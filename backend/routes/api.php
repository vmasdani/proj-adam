<?php

use App\Models\Borrow;
use App\Models\Item;
use App\Models\PurchaseRequest;
use App\Models\Transaction;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

// Users
Route::get('/users', function () {
    return User::all();
});
Route::get('/users/{id}', function (?int $id) {
    $foundUser = User::query()->find($id);

    if ($foundUser == null) {
        return response('Not found', 404);
    }

    return $foundUser;
});

Route::post('/users', function (Request $r) {
    $b = json_decode($r->getContent());
    return User::query()->updateOrCreate(['id' => isset($b->id) ? $b->id : null], (array)$b);
});

Route::post('/login', function (Request $r) {
    $b = json_decode($r->getContent());

    $foundUser = User::query()->where('username', '=', $b?->username)->first();

    if ($foundUser == null) {
        return response('Not found', 404);
    }

    return $foundUser;
});


// Item
Route::get('/items', function () {
    return Item::all();
});
Route::get('/items/{id}', function (?int $id) {
    $foundItem = Item::query()->find($id);

    $foundItem->transactions->each(function (Transaction $t) {
        $t->purchaseRequest;
        $t->borrow;
    });

    return $foundItem;
});

Route::post('/items', function (Request $r) {
    $b = json_decode($r->getContent());
    return Item::query()->updateOrCreate(['id' => isset($b->id) ? $b->id : null], (array)$b);
});

// Inventory
Route::get('/inventory', function () {
    $items = Item::all();

    return $items
        ->map(function (Item $i) {
            $stock = $i->transactions->reduce(function ($acc, $t) {
                if ($t->in_out_type == 'in') {
                    return $acc + $t->qty;
                } else if ($t->in_out_type == 'out') {
                    return $acc - $t->qty;
                } else {
                    return $acc;
                }
            }, 0.0);

            $i->unsetRelation('transactions');

            return [
                'item' => $i,
                'stock' => $stock
            ];
        });
});

// Transaction
Route::get('/transactions', function () {
    return Transaction::all();
});
Route::post('/transactions', function (Request $r) {
    $b = json_decode($r->getContent());
    return Transaction::query()->updateOrCreate(['id' => isset($b->id) ? $b->id : null], (array)$b);
});

// Borrow
Route::get('/borrows', function () {
    $b = Borrow::all();

    $b->each(function (Borrow $b) {
        $b->item;
    });

    return $b;
});
Route::get('/borrows/{id}', function (int $id) {
    $b = Borrow::query()->find($id);
    $b->item;

    return $b;
});

Route::post('/borrows/{id}/approve/{status}', function (int $id, int $status) {
    $b = Borrow::query()->find($id);
    $b->approval_status = $status;
    $b->save();

    // Borrow start
    if ($status == 1) {
        $t = new Transaction;
        $t->qty = $b->qty;
        $t->item_id = $b->item_id;
        $t->in_out_type = 'out';
        $t->borrow_id = $b->id;

        Transaction::query()->updateOrCreate(['id' => null], $t->toArray());
    }

    // Borrow end
    if ($status == 3) {
        $t = new Transaction;
        $t->qty = $b->qty;
        $t->item_id = $b->item_id;
        $t->in_out_type = 'in';
        $t->borrow_id = $b->id;

        Transaction::query()->updateOrCreate(['id' => null], $t->toArray());
    }



    return $b;
});

Route::post('/borrows', function (Request $r) {
    $b = json_decode($r->getContent());
    return Borrow::query()->updateOrCreate(['id' => isset($b->id) ? $b->id : null], (array)$b);
});

// PR
Route::get('/purchaserequests', function () {
    $p = PurchaseRequest::all();

    $p->each(function (PurchaseRequest $p) {
        $p->item;
    });

    return $p;
});
Route::get('/purchaserequests/{id}', function (int $id) {
    $p = PurchaseRequest::query()->find($id);
    $p->item;

    return $p;
});
Route::post('/purchaserequests', function (Request $r) {
    $b = json_decode($r->getContent());
    return PurchaseRequest::query()->updateOrCreate(['id' => isset($b->id) ? $b->id : null], (array)$b);
});

Route::post('/purchaserequests/{id}/approve/{status}', function (int $id, int $status) {
    $p = PurchaseRequest::query()->find($id);
    $p->approval_status = $status;
    $p->save();

    // PR start
    if ($status == 1) {
        $t = new Transaction;
        $t->qty = $p->qty;
        $t->item_id = $p->item_id;
        $t->in_out_type = 'in';
        $t->purchase_request_id = $p->id;

        Transaction::query()->updateOrCreate(['id' => null], $t->toArray());
    }

    return $p;
});

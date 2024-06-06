<?php

use App\Models\Item;
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


// Item
Route::get('/items', function () {
    return Item::all();
});
Route::get('/items/{id}', function (?int $id) {
    $foundItem = Item::query()->find($id);

    $foundItem->transactions->each(function (Transaction $t) {
        $t->purchaseRequest();
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
// PR
<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

/**
 * 
 *
 * @property int $id
 * @property int|null $purchase_request_id
 * @property int|null $borrow_id
 * @property float|null $qty
 * @property int|null $item_id
 * @property string|null $in_out_type
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @method static \Illuminate\Database\Eloquent\Builder|Transaction newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Transaction newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Transaction query()
 * @method static \Illuminate\Database\Eloquent\Builder|Transaction whereBorrowId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Transaction whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Transaction whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Transaction whereInOutType($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Transaction whereItemId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Transaction wherePurchaseRequestId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Transaction whereQty($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Transaction whereUpdatedAt($value)
 * @property-read \App\Models\Borrow|null $borrow
 * @property-read \App\Models\Item|null $item
 * @property-read \App\Models\PurchaseRequest|null $purchaseRequest
 * @mixin \Eloquent
 */
class Transaction extends Model
{

    protected $fillable = [
        'id',
        'item_id',
        'purchase_request_id',
        'borrow_id',
        'qty',
        'item_id',
        'in_out_type'
    ];

    public function item()
    {
        return $this->belongsTo(Item::class);
    }
    public function purchaseRequest()
    {
        return $this->belongsTo(PurchaseRequest::class);
    }
    public function borrow()
    {
        return $this->belongsTo(Borrow::class);
    }
}

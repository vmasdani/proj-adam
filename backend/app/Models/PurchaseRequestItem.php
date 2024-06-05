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
 * @property int|null $item_id
 * @property float|null $qty
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @method static \Illuminate\Database\Eloquent\Builder|PurchaseRequestItem newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|PurchaseRequestItem newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|PurchaseRequestItem query()
 * @method static \Illuminate\Database\Eloquent\Builder|PurchaseRequestItem whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|PurchaseRequestItem whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|PurchaseRequestItem whereItemId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|PurchaseRequestItem wherePurchaseRequestId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|PurchaseRequestItem whereQty($value)
 * @method static \Illuminate\Database\Eloquent\Builder|PurchaseRequestItem whereUpdatedAt($value)
 * @mixin \Eloquent
 */
class PurchaseRequestItem extends Model
{

    protected $fillable = [
        'id',
        'purchase_request_id',
        'item_id',
        'qty'
    ];
}

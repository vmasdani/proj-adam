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
 * @property int|null $borrow_id
 * @property int|null $item_id
 * @property float|null $qty
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @method static \Illuminate\Database\Eloquent\Builder|BorrowItem newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|BorrowItem newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|BorrowItem query()
 * @method static \Illuminate\Database\Eloquent\Builder|BorrowItem whereBorrowId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|BorrowItem whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|BorrowItem whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|BorrowItem whereItemId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|BorrowItem whereQty($value)
 * @method static \Illuminate\Database\Eloquent\Builder|BorrowItem whereUpdatedAt($value)
 * @mixin \Eloquent
 */
class BorrowItem extends Model
{

    protected $fillable = [
        'id',
        'borrow_id',
        'item_id',
        'qty'
    ];
}

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
 * @property int|null $user_id
 * @property int|null $approved
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @method static \Illuminate\Database\Eloquent\Builder|Borrow newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Borrow newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Borrow query()
 * @method static \Illuminate\Database\Eloquent\Builder|Borrow whereApproved($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Borrow whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Borrow whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Borrow whereUpdatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Borrow whereUserId($value)
 * @property int|null $item_id
 * @property float|null $qty
 * @method static \Illuminate\Database\Eloquent\Builder|Borrow whereItemId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Borrow whereQty($value)
 * @property int|null $done
 * @property-read \App\Models\Item|null $item
 * @method static \Illuminate\Database\Eloquent\Builder|Borrow whereDone($value)
 * @property int|null $approval_status
 * @method static \Illuminate\Database\Eloquent\Builder|Borrow whereApprovalStatus($value)
 * @mixin \Eloquent
 */
class Borrow extends Model
{

    protected $fillable = [
        'id',
        'user_id',
        'item_id',
        'qty',
        // 'approved',
        'approval_status',
        'done'
    ];

    public function item()
    {
        return $this->belongsTo(Item::class);
    }
}

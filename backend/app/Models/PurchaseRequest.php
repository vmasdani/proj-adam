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
 * @method static \Illuminate\Database\Eloquent\Builder|PurchaseRequest newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|PurchaseRequest newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|PurchaseRequest query()
 * @method static \Illuminate\Database\Eloquent\Builder|PurchaseRequest whereApproved($value)
 * @method static \Illuminate\Database\Eloquent\Builder|PurchaseRequest whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|PurchaseRequest whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|PurchaseRequest whereUpdatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder|PurchaseRequest whereUserId($value)
 * @property int|null $item_id
 * @property float|null $qty
 * @method static \Illuminate\Database\Eloquent\Builder|PurchaseRequest whereItemId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|PurchaseRequest whereQty($value)
 * @property-read \App\Models\Item|null $item
 * @property int|null $approval_status
 * @property int|null $done
 * @method static \Illuminate\Database\Eloquent\Builder|PurchaseRequest whereApprovalStatus($value)
 * @method static \Illuminate\Database\Eloquent\Builder|PurchaseRequest whereDone($value)
 * @property int|null $approval_user_id
 * @property-read \App\Models\User|null $approvalUser
 * @property-read \App\Models\User|null $user
 * @method static \Illuminate\Database\Eloquent\Builder|PurchaseRequest whereApprovalUserId($value)
 * @mixin \Eloquent
 */
class PurchaseRequest extends Model
{

    protected $fillable = [
        'id',
        'user_id',
        'approval_user_id',
        'item_id',
        'qty',
        // 'approved'
        'approval_status',
        'done'
    ];

    public function item()
    {
        return $this->belongsTo(Item::class);
    }
    public function user()
    {
        return $this->belongsTo(User::class);
    }
    public function approvalUser()
    {
        return $this->belongsTo(User::class);
    }
}

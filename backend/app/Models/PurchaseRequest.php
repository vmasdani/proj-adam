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
 * @mixin \Eloquent
 */
class PurchaseRequest extends Model
{

    protected $fillable = [
        'id',
        'user_id'
    ];
}

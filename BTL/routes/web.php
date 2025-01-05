<?php

use App\Http\Controllers\cthd_controller;
use App\Http\Controllers\hoadon_controller;
use App\Http\Controllers\tienlai_ctrl;
use App\Http\Controllers\top5seller_ctrl;
use App\Models\top5seller;
use Illuminate\Support\Facades\Route;
Route::get('/top5', [top5seller_ctrl::class, 'index']);
Route::get('/lai', [tienlai_ctrl::class, 'index']);
Route::get('/', hoadon_controller::class.'@index')->name('hoadon.index');
Route::get('/hoadon/create', hoadon_controller::class.'@create')->name('hoadon.create');
Route::post('/hoadon', hoadon_controller::class.'@store')->name('hoadon.store');
Route::get('/hoadon/{id}/edit', hoadon_controller::class.'@edit')->name('hoadon.edit');
Route::post('hoadon/{id}', hoadon_controller::class.'@update')->name('hoadon.update');
Route::delete('hoadon/{id}', hoadon_controller::class.'@destroy')->name('hoadon.destroy');
Route::get('hoadon/{id}/chitiet',hoadon_controller::class.'@chitiet')->name('hoadon.chitiet');
Route::get('hoadon/{mahd}/chitiet/create',cthd_controller::class.'@create')->name('cthd.create');
Route::post('/cthd',cthd_controller::class.'@store')->name('cthd.store');
Route::get('/cthd/{mahd}/{mamh}/edit',cthd_controller::class.'@edit')->name('cthd.edit');
Route::post('/cthd/{mahd}/{mamh}',cthd_controller::class.'@update')->name('cthd.update');
Route::delete('/cthd/{mahd}/{mamh}',cthd_controller::class.'@destroy')->name('cthd.destroy');

Route::get('/hoadons/quydoidiem/{mahd}', [hoadon_controller::class, 'quyDoiDiem'])->name('hoadons.quyDoiDiem');

<?php

namespace App\Http\Controllers;

use App\Models\cthd;
use App\Models\hoadon;
use Illuminate\Http\Request;

class cthd_controller extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $cthd=cthd::with(['hoadon','mathang']);
        return view('cthd.index',compact('cthd'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('cthd.create');
    }

    /**-
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {

    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}

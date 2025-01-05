<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
<div class="container h-100 mt-5">
    <div class="row h-100 justify-content-center align-items-center">
        <div class="col-10 col-md-8 col-lg-6">
            <h3>Thêm hóa đơn</h3>
            <form action="{{route('cthd.store')}}" method="post">
                @csrf
                <div class="form-group">
                    <label for="">Mã hóa đơn</label>
                    <input type="text" class="form-control" id="mahd"
                           name="mahd" value="{{$hd->mahd}}" readonly>
                </div>
                <div class="form-group">
                    <label for="mamh">Mã mặt hàng</label>
                    <select class="form-control" name="mamh" id="mamh">
                        @foreach ($mathang as $mh)
                            <option value="{{$mh->mamh}}">{{$mh->mamh}}<option>
                        @endforeach
                    </select>
                </div>

                <div class="form-group">
                    <label for="soluong">Số lượng</label>
                    <input type="number" class="form-control" id="soluong"
                           name="soluong" required>
                </div>

                <br>
                <button type="submit" class="btn btn-primary">Thêm</button>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>


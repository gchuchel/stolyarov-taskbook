program deque;

type
    ItemPtr = ^Item;
    Item = record
        data: longint;
        next, prev: ItemPtr;
    end;
    DequeOfLongint = record
        first, last: ItemPtr;
    end;

procedure DOLInit(var d: DequeOfLongint);
begin
    d.first := nil;
    d.last := nil;
end;

procedure DOLPushFront(var d: DequeOfLongint; data: longint);
var
    tmp: ItemPtr;
begin
    new(tmp);
    tmp^.data := data;
    tmp^.next := d.first;
    tmp^.prev := nil;
    if d.first = nil then
        d.last := tmp
    else
        d.first^.prev := tmp;
    d.first := tmp;
end;

procedure DOLPushBack(var d: DequeOfLongint; data: longint);
var
    tmp: ItemPtr;
begin
    new(tmp);
    tmp^.data := data;
    tmp^.next := nil;
    tmp^.prev := d.last;
    if d.last = nil then
        d.first := tmp
    else
        d.last^.next := tmp;
    d.last := tmp;
end;

function DOLIsEmpty(var d: DequeOfLongint) : boolean;
begin
    DOLIsEmpty := d.first = nil;
end;

procedure DOLPopFront(var d: DequeOfLongint; var data: longint);
var
    tmp: ItemPtr;
begin
    tmp := d.first;
    d.first := d.first^.next;
    data := tmp^.data;
    if d.first = nil then
        d.last := nil;
    dispose(tmp);
end;

var
    d: DequeOfLongint;
    data: longint;
    add: char;
begin
    DOLInit(d);
    while not SeekEof do
    begin
        read(add);
        read(data);
        case add of
            'f': DOLPushFront(d, data);
            'b': DOLPushBack(d, data);
        end;
    end;
    while not DOLIsEmpty(d) do
    begin
        DOLPopFront(d, data);
        writeln(': ', data);
    end;
end.

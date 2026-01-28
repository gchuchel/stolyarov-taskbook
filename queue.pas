program queue;

type
    ItemPtr = ^Item;
    Item = record
        next: ItemPtr;
        data: longint;
    end;
    QueueOfLongint = record
        first, last: ItemPtr;
    end;

procedure QOLInit(var q: QueueOfLongint);
begin
    q.first := nil;
    q.last := nil;
end;

procedure QOLPut(var q: QueueOfLongint; data: longint);
begin
    if q.first = nil then
    begin
        new(q.first);
        q.last := q.first;
    end
    else
    begin
        new(q.last^.next);
        q.last := q.last^.next;
    end;
    q.last^.data := data;
    q.last^.next := nil;
end;

function QOLIsEmpty(var q: QueueOfLongint) : boolean;
begin
    QOLIsEmpty := q.first = nil;
end;

procedure QOLGet(var q: QueueOfLongint; var data: longint);
var
    tmp: ItemPtr;
begin
    tmp := q.first;
    data := tmp^.data;
    q.first := q.first^.next;
    if q.first = nil then
        q.last := nil;
    dispose(tmp);
end;

var
    q: QueueOfLongint;
    data: longint;
begin
    QOLInit(q);
    while not SeekEof do
    begin
        read(data);
        QOLPut(q, data);
    end;
    while not QOLIsEmpty(q) do
    begin
        QOLGet(q, data);
        writeln(': ', data);
    end;
end.

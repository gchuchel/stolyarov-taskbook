program stack;

type
    ItemPtr = ^Item;
    Item = record
        data: longint;
        next: ItemPtr;
    end;
    StackOfLongint = ItemPtr;

procedure SOLInit(var s: StackOfLongint);
begin
    s := nil;
end;

procedure SOLPush(var s: StackOfLongint; data: longint);
var
    tmp: ItemPtr;
begin
    new(tmp);
    tmp^.data := data;
    tmp^.next := s;
    s := tmp;
end;

function SOLIsEmpty(var s: StackOfLongint) : boolean;
begin
    SOLIsEmpty := s = nil;
end;

procedure SOLPop(var s: StackOfLongint; var data: longint);
var
    tmp: ItemPtr;
begin
    tmp := s;
    data := s^.data;
    s := s^.next;
    dispose(tmp);
end;

function SOLSum(var s: StackOfLongint) : longint;
var
    pp: ^ItemPtr;
    sum: longint;
begin
    pp := @s;
    sum := 0;
    while pp^ <> nil do
    begin
        sum := sum + pp^^.data;
        pp := @(pp^^.next);
    end;
    SOLSum := sum;
end;

var
    s: StackOfLongint;
    data: longint;
begin
    SOLInit(s);
    while not SeekEof do
    begin
        read(data);
        SOLPush(s, data);
    end;

    writeln('Sum: ', SOLSum(s));

    while not SOLIsEmpty(s) do
    begin
        SOLPop(s, data);
        writeln(': ', data);
    end;
end.

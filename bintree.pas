program bt;

{ // Тип данных дерева. }
type
    NodePtr = ^Node;
    Node = record
        data: integer;
        left, right: NodePtr;
    end;
    NodePos = ^ NodePtr;

{ // Инициализация дерева. }
procedure InitBinTree(var root: NodePtr);
begin
    root := nil;
end;

{ // Добавление в узел. }
procedure AddToTree(n: integer; var p: NodePtr; var ok: boolean);
begin
    if p = nil then
    begin
        new(p);
        p^.left := nil;
        p^.right := nil;
        p^.data := n;
        ok := true;
    end
    else
    begin
        if n < p^.data then
            AddToTree(n, p^.left, ok)
        else if n > p^.data then
            AddToTree(n, p^.right, ok)
        else
            ok := false;
    end;
end;

{ // Вывод дерева справо на лево. }
procedure PrintTree(p: NodePtr);
begin
    if p <> nil then
    begin
        PrintTree(p^.right);
        writeln(p^.data);
        PrintTree(p^.left);
    end;
end;

{ // Поиск в дереве. }
function IsInTree(p: NodePtr; n: integer) : NodePos;
begin
    if (p = nil) or (p^.data = n) then
        IsInTree := @p
    else if n < p^.data then
        IsInTree := IsInTree(p^.left, n)
    else if n > p^.data then
        IsInTree := IsInTree(p^.right, n)
end;

{ // Сумма в дереве. }
function SumTree(p: NodePtr) : longint;
begin
    if p = nil then
        SumTree := 0
    else
        SumTree := SumTree(p^.left) + p^.data + SumTree(p^.right);
end;

var
    root: NodePtr;
    n: integer;
    ok: boolean;
begin
    { // Инициализация дерева. }
    InitBinTree(root);

    { // Заполнение дерева. }
    while not SeekEof do
    begin
        read(n);
        AddToTree(n, root, ok);
    end;

    { // Вывод дерева справо на лево. }
    writeln('-------');
    PrintTree(root);

    { // Поиск в дереве. }
    writeln('IsInTree: ', nil <> IsInTree(root, 4));

    { // Сумма в дереве. }
    writeln('Sum: ', SumTree(root));
end.

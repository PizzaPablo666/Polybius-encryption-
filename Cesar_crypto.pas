program Cesar_crypto;

type matrix = Array[1..5,1..5] of char;

var char_arr : matrix;
    alphabet, new_alphabet, key, text, encrpt_txt, decrpt_txt : string;
    m,k,a,i,j, key_length, last_i, last_j, text_len: integer;
    in_key_char : Boolean;
    i_arr, j_arr : Array[1..500] of Integer;



// Deleting same chars and i --> j 
Procedure Delete_same_char(var key:string);
var  i, j : integer;
begin

for i:=1 to Length(key) do 
begin
  if key[i] = 'j' then 
        begin
          Delete(key,i,1);
          Insert('i',key,i-1);
        end;
end;

for i:=1 to Length(key) do 
    begin
      for j:=i+1 to Length(key) do
        begin
        if ((key[i] = key[j]) OR (key[j] = ' ')) then delete(key,j,1);
        end;
    end;
end;


Begin {main}
alphabet := 'abcdefghiklmnopqrstuvwxyz';
new_alphabet := '';
encrpt_txt := '';
decrpt_txt := '';

//initializing '0' all the matrix
for i:=1 to 5 do begin
  for j:=1 to 5 do begin
  char_arr[i,j] := '0';
  end;
end;

write('Enter the text you want to encrypt: ');
readln(text);

write('Enter the key string: ');
readln(key);

Delete_same_char(key);
writeln('New key: ', key);

key_length := length(key);
m := 1;

//Put the key in the matrix 
for i:=1 to 5 do 
begin
  for j:=1 to 5 do
  begin
    char_arr[i,j] := key[m];
    last_i := i;
    last_j := j;
    if((m+1) <= key_length) then m:=m+1
    else break;
  end;
  if((m+1) > key_length) then break;
end;

m:=1;
k:=1;
in_key_char := false;

//Creating new alphabet where there is no key characters
//k = new alphabet indexing
for i:=1 to 26 do
  begin
  for j:=1 to key_length do
    begin
        if alphabet[i] = key[j] then in_key_char := true;
    end;
    if in_key_char = false then new_alphabet := new_alphabet + alphabet[i];
    in_key_char := false;
  end;

m:=1;
if last_j = 5 then begin 
  last_j := 1;
  last_i := last_i + 1;
end
else  last_j := last_j + 1;

//writeln('last_i = ', last_i);
//writeln('last_j = ', last_j);


//Put the alphabet in the matrix 
//m = key length indexing
//k = alphabet length indexing
j := last_j;
for i:=last_i to 5 do
  begin
  while(j <= 5) do
    begin
      char_arr[i,j] := new_alphabet[m];
      m:= m + 1;
      j:= j + 1;
    end;
    j:=1;
  end;


//Deleting spaces 
for i:=1 to length(text) do
  begin
    if text[i]=' ' then Delete(text,i,1);
  end;

text_len := length(text);
k:=1; //
a:=1;//i and j array indexing 
i:=1;//char_arr indexing
j:=1;//char_arr indexing 
m:=1; //text indexing

//getting indexes of the text
for m:=1 to text_len do
begin
for i:=1 to 5 do begin
    for j:=1 to 5 do begin
        if text[m] = char_arr[i,j] then 
        begin
            i_arr[a]:= i;
            j_arr[a]:= j;
            a:=a+1;
        end;
       end;
    end;
end;

writeln(a);
a := a - 1;

for i:=1 to a do begin
    write(i_arr[i]);
end;
writeln;

for j:=1 to a do begin
    write(j_arr[j]);
end;

writeln;

for i:=1 to 5 do
  begin
  for j:=1 to 5 do 
  begin
    write(char_arr[i,j]);
  end;
  writeln;
  end;

writeln;
writeln(text);


writeln;

  
 for i:=1 to length(new_alphabet) do begin
    write(new_alphabet[i]);
  end;

//i_arr and j_arr seperating for (x,x+1) pares and getting chars from that index from new_alph
if a mod 2 = 1 then begin
  j:=2;
  i:=1;
  while (i <= (a*2)-1) do begin 
    if i < a then
    encrpt_txt := encrpt_txt + char_arr[i_arr[i],i_arr[i+1]];
    if i = a then 
    encrpt_txt := encrpt_txt + char_arr[i_arr[a],j_arr[1]];
    if i > a then begin
    encrpt_txt := encrpt_txt + char_arr[j_arr[j],j_arr[j+1]];
    j := j + 2;
    end;
    i:= i + 2;
    end;
  end
  else begin
  j:=1;
  i:=1;
  while (i <= (a*2)-1) do begin 
    if i < a then
    encrpt_txt := encrpt_txt + char_arr[i_arr[i],i_arr[i+1]];
    if i >= a then begin
    encrpt_txt := encrpt_txt + char_arr[j_arr[j],j_arr[j+1]];
    j := j + 2;
    end;
    i:= i + 2;
    end;
    
  end;


  WriteLn;
  writeln('Encrypted text: ', encrpt_txt);


//**************************************************************************

//***************************** DECRYPTION *********************************


for i := 1 to a do begin
  decrpt_txt := decrpt_txt + char_arr[i_arr[i],j_arr[i]];
end;

writeln('decrypte text: ', decrpt_txt);


End.
    
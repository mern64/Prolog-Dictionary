% Extended dictionary with common nouns, verbs, adjectives, etc.
translate(pisang, banana).
translate(kereta, car).
translate(rumah, house).
translate(meja, table).
translate(telefon, phone).
translate(kasut, shoes).
translate(pintu, door).
translate(bilik, room).
translate(kerusi, chair).
translate(tingkap, window).
translate(bunga, flower).
translate(buku, book).
translate(sekolah, school).
translate(air, water).
translate(ayam, chicken).
translate(ikan, fish).
translate(buah, fruit).
translate(matahari, sun).
translate(bulan, moon).
translate(bintang, star).
translate(hari, day).
translate(malam, night).
translate(masjid, mosque).
translate(gereja, church).
translate(hospital, hospital).
translate(kedai, shop).
translate(pasar, market).
translate(taman, park).
translate(laut, sea).
translate(gunung, mountain).
translate(sungai, river).
translate(hutan, forest).
translate(kawan, friend).
translate(guru, teacher).
translate(pelajar, student).
translate(kerja, work).
translate(komputer, computer).
translate(telefon_bimbit, mobile_phone).
translate(bilik_air, bathroom).
translate(sayur, vegetable).
translate(cawan, cup).
translate(pinggan, plate).
translate(garpu, fork).
translate(sudu, spoon).
translate(keluarga, family).
translate(anak, child).
translate(ibu, mother).
translate(ayah, father).
translate(adik, sibling).
translate(saudara, relative).
translate(kereta_api, train).
translate(bas, bus).
translate(kapal, ship).
translate(kapal_terbang, airplane).
translate(teksi, taxi).
translate(motosikal, motorcycle).

% Common verbs
translate(makan, eat).
translate(minum, drink).
translate(suka, like).
translate(beri, give).
translate(terima, receive).
translate(baca, read).
translate(tulis, write).
translate(dengar, listen).
translate(cakap, speak).
translate(beli, buy).
translate(jual, sell).
translate(masak, cook).
translate(basuh, wash).
translate(tolong, help).
translate(datang, come).
translate(main, play).
translate(lari, run).
translate(tidur, sleep).
translate(berjalan, walk).
translate(berenang, swim).
translate(menonton, watch).
translate(melihat, see).
translate(mendengar, hear).
translate(bercakap, talk).
translate(belajar, study).
translate(mengajar, teach).
translate(bermain, play).
translate(bekerja, work).
translate(bersih, clean).
translate(memasuki, enter).
translate(keluar, exit).
translate(berhenti, stop).
translate(bermula, start).
translate(meneruskan, continue).
translate(berfikir, think).
translate(memahami, understand).
translate(merancang, plan).
translate(mencipta, create).
translate(mencari, search).

% Adjectives
translate(lapar, hungry).
translate(baik, good).
translate(jahat, bad).
translate(besar, big).
translate(kecil, small).
translate(cantik, beautiful).
translate(cepat, fast).
translate(perlahan, slow).
translate(tinggi, tall).
translate(pendek, short).
translate(kaya, rich).
translate(miskin, poor).
translate(sejuk, cold).
translate(panas, hot).
translate(hijau, green).
translate(cerdas, smart).
translate(pintar, clever).
translate(baik_hati, kind).
translate(tenang, calm).
translate(bising, noisy).
translate(marah, angry).
translate(sedih, sad).
translate(gembira, happy).
translate(murah, cheap).
translate(mahal, expensive).
translate(baru, new).
translate(lama, old).
translate(lembut, soft).
translate(keras, hard).
translate(terang, bright).
translate(gelap, dark).
translate(berat, heavy).
translate(ringan, light).
translate(hangat, warm).
translate(segar, fresh).
translate(kotor, dirty).
translate(bersih, clean).

% Prepositions
translate(dalam, inside).
translate(luar, outside).
translate(atas, above).
translate(bawah, below).
translate(dekat, near).
translate(jauh, far).
translate(depan, in_front).
translate(belakang, behind).
translate(sebelah, beside).
translate(antara, between).
translate(terhadap, towards).
translate(di_sekeliling, around).
translate(di_bawah, underneath).
translate(dari, from).
translate(hingga, until).
translate(sepanjang, along).
translate(bersebelahan, adjacent).
translate(melalui, through).

% Pronouns
translate(saya, i).
translate(awak, you).
translate(kamu, you).
translate(dia, he_she).
translate(kita, we).
translate(mereka, they).
translate(kalian, you_all).
translate(ia, it).
translate(kita_semua, all_of_us).
translate(milik_kita, ours).
translate(milik_mereka, theirs).

% Questions
translate(apa, what).
translate(bila, when).
translate(mana, where).
translate(kenapa, why).
translate(bagaimana, how).

% Conjunctions
translate(dan, and).
translate(atau, or).
translate(sebaliknya, but).
translate(jadi, so).
translate(sebab, because).
translate(sambil, while).
translate(walaupun, although).
translate(jika, if).
translate(tetapi, however).

% Bidirectional translation
terjemah(X, Y) :- translate(X, Y); translate(Y, X).

% Convert to lowercase
to_lower(Word, Lower) :-
    name(Word, Codes),
    to_lower_list(Codes, LowerCodes),
    name(Lower, LowerCodes).

% Convert list of character codes to lowercase
to_lower_list([], []).
to_lower_list([H|T], [H2|T2]) :-
    (H >= 65, H =< 90 ->
        H2 is H + 32
    ;   H2 = H),
    to_lower_list(T, T2).

% Split sentence into words
split_sentence(Sentence, Words) :-
    name(Sentence, Chars),
    split_on_space(Chars, WordChars),
    chars_to_words(WordChars, Words).

% Split on spaces
split_on_space([], []).
split_on_space(Chars, [Word|Rest]) :-
    get_word(Chars, WordChars, RemChars),
    (WordChars = [] ->
        split_on_space(RemChars, Rest)
    ;   Word = WordChars,
        split_on_space(RemChars, Rest)).

% Get a single word
get_word([], [], []).
get_word([32|Rest], [], Rest) :- !.  % Space
get_word([Char|Rest], [Char|WordRest], RemChars) :-
    get_word(Rest, WordRest, RemChars).

% Convert character lists to words
chars_to_words([], []).
chars_to_words([Chars|Rest], [Word|Words]) :-
    name(Word, Chars),
    chars_to_words(Rest, Words).

% Translate a single word
translate_word(Word, Translated) :-
    to_lower(Word, Lower),
    (terjemah(Lower, Trans) ->
        preserve_case(Word, Trans, Translated)
    ;   Translated = Word).

% Preserve case of first letter
preserve_case(Original, Translated, Result) :-
    name(Original, [First|_]),
    name(Translated, [TransFirst|TransRest]),
    (First >= 65, First =< 90 ->
        UpperFirst is TransFirst - 32,
        name(Result, [UpperFirst|TransRest])
    ;   Result = Translated).

% Join words with spaces
join_words([], '').
join_words([Word], Word).
join_words([Word|Rest], Result) :-
    join_words(Rest, RestResult),
    name(Word, WordChars),
    name(RestResult, RestChars),
    append(WordChars, [32|RestChars], ResultChars),
    name(Result, ResultChars).

% Translate sentence
translate_sentence(Sentence, TranslatedSentence) :-
    split_sentence(Sentence, Words),
    translate_words(Words, TranslatedWords),
    join_words(TranslatedWords, TranslatedSentence).

% Translate list of words
translate_words([], []).
translate_words([Word|Rest], [TransWord|TransRest]) :-
    translate_word(Word, TransWord),
    translate_words(Rest, TransRest).

% Main program

createDictGUI :- 
    _S1 = [dlg_ownedbyprolog, ws_sysmenu, ws_caption],
    _S2 = [ws_child, ws_visible, ss_center],
    _S3 = [ws_child, ws_visible, ws_tabstop, ws_border, es_left, es_multiline, es_autohscroll, es_autovscroll, ws_vscroll, ws_hscroll],
    _S4 = [ws_child, ws_visible, ws_tabstop, bs_pushbutton],
    _S5 = [ws_child, ws_visible, ss_left],
    wdcreate(dict, `Dictionary (Malay <-> English)`, 483, 151, 562, 354, _S1),
    wccreate((dict, 10000), static, `Enter a paragraph of sentence:`, 20, 10, 520, 20, _S2),
    wccreate((dict, 8000), edit, ``, 20, 40, 520, 120, _S3),
    wccreate((dict, 1000), button, `TRANSLATE`, 460, 190, 80, 30, _S4),
    wccreate((dict, 1001), button, `CLEAR`, 460, 240, 80, 30, _S4),
    wccreate((dict, 1002), button, `CLOSE`, 460, 290, 80, 30, _S4),
    wccreate((dict, 8001), edit, ``, 20, 190, 430, 130, _S3),
    wccreate((dict, 10001), static, `Translated as:`, 20, 170, 430, 20, _S5).


run :-
    createDictGUI,
    window_handler(dict, dictionary),
    show_dialog(dict).

% Assign actions to specific buttons
dictionary((dict,1000),msg_button,_,_) :-
    wtext((dict, 8000), InputText), 
    split_sentence(InputText, Words),  
    translate_words(Words, TranslatedWords), 
    join_words(TranslatedWords, TranslatedSentence),
    atom_string(TranslatedSentence,T1),
    wtext((dict, 8001), T1).

dictionary((dict, 1001), msg_button, _, _) :-
    	Clear = '',
    	atom_string(Clear, ClearAtom),  
    	wtext((dict, 8000), ClearAtom),
    	wtext((dict, 8001), ClearAtom).


dictionary((dict, 1002), msg_button, _, close) :- % "
    write('The Program will be Exited ... BYE BYE').

% This will be used to split input sentence into words
split_sentence(Sentence, Words) :-
    name(Sentence, Chars),
    split_on_space(Chars, WordChars),
    chars_to_words(WordChars, Words).

% Split sentence on spaces
split_on_space([], []). 
split_on_space(Chars, [Word|Rest]) :-
    get_word(Chars, WordChars, RemChars),
    (WordChars = [] -> 
        split_on_space(RemChars, Rest)
    ;   Word = WordChars, 
        split_on_space(RemChars, Rest)).

% Get a single word from the list of characters
get_word([], [], []). 
get_word([32|Rest], [], Rest). % Space
get_word([Char|Rest], [Char|WordRest], RemChars) :-
    get_word(Rest, WordRest, RemChars).

% Convert character lists into words
chars_to_words([], []).
chars_to_words([Chars|Rest], [Word|Words]) :-
    name(Word, Chars),
    chars_to_words(Rest, Words).

% Translate word based on the dictionary
translate_word(Word, Translated) :-
    to_lower(Word, Lower),
    (terjemah(Lower, Trans) -> 
        preserve_case(Word, Trans, Translated)
    ;   Translated = Word).

% Preserve case of first letter when translating
preserve_case(Original, Translated, Result) :-
    name(Original, [First|_]),
    name(Translated, [TransFirst|TransRest]),
    (First >= 65, First =< 90 -> 
        UpperFirst is TransFirst - 32, 
        name(Result, [UpperFirst|TransRest])
    ;   Result = Translated).

% Join translated words into a sentence
join_words([], ''). 
join_words([Word], Word).
join_words([Word|Rest], Result) :-
    join_words(Rest, RestResult),
    name(Word, WordChars),
    name(RestResult, RestChars),
    append(WordChars, [32|RestChars], ResultChars),
    name(Result, ResultChars).

% Translate the full sentence
translate_sentence(Sentence, TranslatedSentence) :-
    split_sentence(Sentence, Words),
    translate_words(Words, TranslatedWords),
    join_words(TranslatedWords, TranslatedSentence).

% Translate list of words
translate_words([], []).
translate_words([Word|Rest], [TransWord|TransRest]) :-
    translate_word(Word, TransWord),
    translate_words(Rest, TransRest).

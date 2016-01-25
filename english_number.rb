def englishNumber number
  if number < 0  #  Без отрицательных чисел.
    return 'Пожалуйста, введите неотрицательное число.'
  end
  if number == 0
    return 'zero'
  end

  #  Больше нет особых случаев!  Больше нет возвратов по return!

  numString = ''  #  Эту строку мы будем возвращать.

  #  единицы
  onesPlace = ['one',     'two',       'three',    'four',     'five',
               'six',     'seven',     'eight',    'nine']
  #  десятки
  tensPlace = ['ten',     'twenty',    'thirty',   'forty',    'fifty',
               'sixty',   'seventy',   'eighty',   'ninety']
  teenagers = ['eleven',  'twelve',    'thirteen', 'fourteen', 'fifteen',
               'sixteen', 'seventeen', 'eighteen', 'nineteen']

  #  "left" - сколько от числа нам ещё осталось вывести.
  #  "write" - часть числа, которую мы выводим сейчас.
  #  write и left... поняли?  :)
  left  = number
  write = left/1000          #  Сколько тысяч осталось вывести?
  left  = left - write*1000  #  Вычтем эти тысячи.

  if write > 0
    #  Вот здесь действительно хитрый фокус:
    thousands = englishNumber write
    numString = numString + thousands + ' thousand'
    #  Это называется "рекурсия".  Так что же я только что сделал?
    #  Я велел этому методу вызвать себя, но с параметром "write" вместо
    #  "number".  Помните, что "write" это (в настоящий момент) число
    #  сотен, которые нужно вывести.  Прибавив "hundreds" к "numString",
    #  мы добавляем после неё строку ' hundred'.  Так, например, если
    #  мы сначала вызвали englishNumber с 1999 (т.е. "number" = 1999),
    #  затем в этой точке "write" будет равен 19, а "left" равен 99.
    #  Наиболее лениво в этом месте было бы заставить englishNumber
    #  вывести нам 'nineteen', а затем мы выведем ' hundred',
    #  и потом оставшаяся часть englishNumber выведет 'ninety-nine'.

    if left > 0
      #  Так, мы не выводим 'two hundredfifty-one'...
      numString = numString + ' '
    end
  end

  write = left/100          #  Сколько сотен осталось вывести?
  left  = left - write*100  #  Вычтем эти сотни.

  if write > 0
    numString = numString + onesPlace[write-1].to_s + ' hundred'

    if left > 0
      #  Так, мы не выводим 'two hundredfifty-one'...
      numString = numString + ' '
    end

  #elsif write == 1
  #  numString = numString + ' hundred'
#
  #  if left > 0
  #    #  Так, мы не выводим 'two hundredfifty-one'...
#      numString = numString + ' '
  #  end

  end

  write = left/10          #  Сколько десятков осталось вывести?
  left  = left - write*10  #  Вычтем эти десятки.

  if write > 0
    if ((write == 1) and (left > 0))
      #  Поскольку мы не можем вывести "tenty-two" вместо "twelve",
      #  нам нужно сделать для них особую обработку.
      numString = numString + teenagers[left-1]
      #  "-1" здесь потому, что teenagers[3] это 'fourteen', а не 'thirteen'.

      #  Поскольку уже мы позаботились о цифре для единиц,
      #  нам не осталось ничего для вывода.
      left = 0
    else
      numString = numString + tensPlace[write-1]
      #  "-1" потому, что tensPlace[3] это 'forty', а не 'thirty'.
    end

    if left > 0
      #  Так, мы не выводим 'sixtyfour'...
      numString = numString + '-'
    end
  end

  write = left  #  Сколько единиц осталось вывести?
  left  = 0     #  Вычтем эти единицы.

  if write > 0
    numString = numString + onesPlace[write-1]
    #  "-1" потому, что onesPlace[3] это 'four', а не 'three'.
  end

  #  А теперь мы просто возвращаем "numString"...
  numString
end

def puts_english_number
  puts "Please enter a number:"
  ask = gets.chomp.to_i

  puts "It's " + englishNumber(ask) + "."
end

puts_english_number

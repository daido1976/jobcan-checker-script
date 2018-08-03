# slow
def fib(n)
  (0..1).include?(n) ? n : fib(n-2) + fib(n-1)
end

# fast
def fibm(n)
  @cache ||= []
  @cache[n] ||= (0..1).include?(n) ? n : fibm(n-2) + fibm(n-1)
end

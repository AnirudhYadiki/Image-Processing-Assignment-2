function F = FFT2(a,k)
    F = zeros(length(a),1);
    n = length(a);
    k= 1:1:n;
    k=k-1;
    if n == 1
        F = a;
    else
        r_odds = 1:2:length(a);
        r_evens = 2:2:length(a);
        even = FFT2(a(r_evens));
        odd = FFT2(a(r_odds));
        expo = exp((-1* 1i * 2 * pi * k)/length(a));
        F = even + expo.*odd;
    end
    
end

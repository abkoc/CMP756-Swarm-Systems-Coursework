function g = g_dummy(t,i,w)
    g = sign(sin(w*(t+0.0001)/2 + pi*(i - 1)/5)) ;
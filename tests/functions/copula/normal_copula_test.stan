functions {
  #include normal_copula.stan
}
data {
  int<lower=0> N;
  vector[N] x;
  vector[N] y;
  int is_vector;
}
transformed data {
  vector[N] x_std = (x - mean(x)) / sd(x);
  vector[N] y_std = (y - mean(y)) / sd(y);
}
parameters {
  real<lower=-1, upper=1> rho;
}
model {
  if(is_vector == 0){
    for (n in 1:N)
    target += normal_copula(Phi(x_std[n]),
                            Phi(y_std[n]), rho);
  } else {
    target += normal_copula_vector(Phi(x_std),
                                   Phi(y_std), rho);
  }
}
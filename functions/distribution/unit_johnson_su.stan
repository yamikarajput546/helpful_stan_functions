  /* Unit Johnson SU Distribution
   *
   * Copyright Sean Pinkney, June 2, 2021 
   *
   * The Unit Johnson SU distribution is defined as
   * \f$$
         p(y \mid \mu,\sigma) =
              \frac{\sigma}{y (1 - y) \sqrt(1 + \text{logit}(y)^2)}\phi(\mu + \sigma \sinh^{-1}(\text{logit}(y)) )
      \f$$
   * where \f$\mu\f$ is the location parameter defined on the \f$\mathcal{R}\f$ and \f$\sigma\f$ is a scale parameter,
   * restricted to the positive reals, \f$\mathcal{R}^+\f$. The distribution is described in detail at 
   * Gündüz, S., & Korkmaz, M. Ç. (2020). A New Unit Distribution Based On The Unbounded Johnson Distribution 
   * Rule: The Unit Johnson SU Distribution. Pakistan Journal of Statistics and Operation Research, 16(3),
   * 471-490. https://doi.org/10.18187/pjsor.v16i3.3421.
   *
   * @param x Vector 
   * @param mu Real 
   * @param sigma Real (0,Inf) scale parameter
   */
  real unit_johnson_lpdf (vector x, real mu, real sigma){
    int N = num_elements(x);
    return N * log(sigma) - 
             sum( log(x) + log1m(x) + 0.5 * log1p(square(logit(x))) ) +
               std_normal_lpdf(mu + sigma * asinh(logit(x)));
    
  }
  
  /* Unit Johnson SU cumulative density function
   *
   * Copyright Sean Pinkney, June 2, 2021 
   *
   * The Unit Johnson SU distribution is defined as
   * \f$$
         F(y \mid \mu,\sigma) =
              \Phi(\mu + \sigma \sigma \sinh^{-1}(\text{logit}(y)) )
      \f$$
   * where \f$\mu\f$ is the location parameter defined on the \f$\mathcal{R}\f$ and \f$\sigma\f$ is a scale parameter,
   * restricted to the positive reals, \f$\mathcal{R}^+\f$. The distribution is described in detail at 
   * Gündüz, S., & Korkmaz, M. Ç. (2020). A New Unit Distribution Based On The Unbounded Johnson Distribution 
   * Rule: The Unit Johnson SU Distribution. Pakistan Journal of Statistics and Operation Research, 16(3),
   * 471-490. https://doi.org/10.18187/pjsor.v16i3.3421.
   *
   * @param x Vector 
   * @param mu Real 
   * @param sigma Real (0,Inf) scale parameter
   */
  real unit_johnson_cdf (real x, real mu, real sigma){
    return std_normal_cdf(mu + sigma * asinh(logit(x)));
  }
  
  /* Unit Johnson SU log cumulative density function
   *
   * Copyright Sean Pinkney, June 2, 2021 
   *
   * The Unit Johnson SU cumulative is defined as
   * \f$$
         F(y \mid \mu,\sigma) =
              \Phi(\mu + \sigma \sigma \sinh^{-1}(\text{logit}(y)) )
      \f$$
   * where \f$\mu\f$ is the location parameter defined on the \f$\mathcal{R}\f$ and \f$\sigma\f$ is a scale parameter,
   * restricted to the positive reals, \f$\mathcal{R}^+\f$. The distribution is described in detail at 
   * Gündüz, S., & Korkmaz, M. Ç. (2020). A New Unit Distribution Based On The Unbounded Johnson Distribution 
   * Rule: The Unit Johnson SU Distribution. Pakistan Journal of Statistics and Operation Research, 16(3),
   * 471-490. https://doi.org/10.18187/pjsor.v16i3.3421.
   *
   * @param x Vector 
   * @param mu Real 
   * @param sigma Real (0,Inf) scale parameter
   */
  real unit_johnson_lcdf (real x, real mu, real sigma){
    return std_normal_lcdf(mu + sigma * asinh(logit(x)));
  }
  
  /* Unit Johnson SU log complementary cumulative density function
   *
   * Copyright Sean Pinkney, June 2, 2021 
   *
   * The Unit Johnson SU complementary cumulative distribution is defined as
   * \f$$
         S(y \mid \mu,\sigma) =
              1 - \Phi(\mu + \sigma \sigma \sinh^{-1}(\text{logit}(y)) )
      \f$$
   * where \f$\mu\f$ is the location parameter defined on the \f$\mathcal{R}\f$ and \f$\sigma\f$ is a scale parameter,
   * restricted to the positive reals, \f$\mathcal{R}^+\f$. The distribution is described in detail at 
   * Gündüz, S., & Korkmaz, M. Ç. (2020). A New Unit Distribution Based On The Unbounded Johnson Distribution 
   * Rule: The Unit Johnson SU Distribution. Pakistan Journal of Statistics and Operation Research, 16(3),
   * 471-490. https://doi.org/10.18187/pjsor.v16i3.3421.
   *
   * @param x Vector 
   * @param mu Real 
   * @param sigma Real (0,Inf) scale parameter
   */
   real unit_johnson_lccdf (real x, real mu, real sigma){
    return std_normal_lccdf(mu + sigma * asinh(logit(x)));
  }
  
  /* Unit Johnson SU random number generator function
   *
   * Copyright Sean Pinkney, June 2, 2021 
   *
   * A unit Johnson SU can be generated by
   * \f{aligned}{
         u &\sim \mathcal{U}(0,\,1) \\
         x &= \sinh^{-1}\bigg(\frac{\Phi^{-1}(u) - \mu}{\sigma}\bigg)
         y &= \text{inv_logit}(x)
      \f}
   * where \f$x \sim \text{Johnson } S_U(\mu, \sigma\f$ \f$ y \sim \text{UJ}S_U{\mu, \sigma}\f$.
   * Gündüz, S., & Korkmaz, M. Ç. (2020). A New Unit Distribution Based On The Unbounded Johnson Distribution 
   * Rule: The Unit Johnson SU Distribution. Pakistan Journal of Statistics and Operation Research, 16(3),
   * 471-490. https://doi.org/10.18187/pjsor.v16i3.3421.
   *
   * @param mu Real 
   * @param sigma Real (0,Inf) scale parameter
   */
  real unit_johnson_rng (real mu, real sigma) {
    real<lower=0, upper=1> u = uniform_rng(0, 1);
    real x = sinh( (inv_Phi(u) - mu) / sigma);
    return inv_logit(x);
  }
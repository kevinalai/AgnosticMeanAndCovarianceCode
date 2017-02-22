Agnostic method for computing mean and covariance of Gaussians and distributions with bounded fourth moments
Original code downloaded from 
Copyright (C) 2016 Kevin A. Lai, Anup B. Rao, Santosh Vempala

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

We also use some code for generating Cauchy random variables by Peder Axensten. The license for using that code is in the Cauchy code folder.

RobustPCA method for agnostic estimation of mean for Gaussians and distributions with bounded fourth moments. The code accompanies the paper "Agnostic Estimation of Mean and Covariance" in FOCS 2016.

This repository contains code for computing the mean of a distribution in the presence of adversarial noise. The code is written in Matlab.

The main routine is agnosticMeanG(X), which takes as input m samples from an n-dimensional noisy general Gaussian. Each point in X is from some Gaussian G with probability 1-eta and chosen by an adversary with probability eta. The algorithm outputs an estimate for the mean of G.

noisyG(mu, Sigma, z, eta, m) generates m points such that with probability 1-eta they are selected from a Gaussian with mean mu and covariance Sigma, and with probability eta they are at z.

A way to test the code would be to run:
```
>> d = 10; eta = .1; m = 10*n^2;
>> X = noisyG(zeros(d,1), eye(d), ones(d,1)*100, eta, m);
>> est = agnosticMeanG(X, eta);
>> norm(est)
```

where norm(est) will give the error in this case (since the true mean is 0).

Alternately, one could use
```
>> est = agnosticMeanGeneral(X, eta)
```

The meanTesterGeneral and covTesterGeneral run agnosticMeanGeneral and agnosticCovarianceGeneral respectively for different true distributions with Cauchy noise, where the true distribution can be set within the covTesterGeneral code itself. The default is a multivariate Gaussian.




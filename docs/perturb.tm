<TeXmacs|1.99.10>

<style|generic>

<\body>
  <section|Preliminary>

  Herein, we discuss momentum and cumulant, preparing for the following
  calculation.

  Let <math|p> a distribution, then define momentum generating function as

  <\equation>
    M<rsub|p><around*|(|t,\<mu\>|)>\<assign\><big|int>\<mathd\>x
    p<around*|(|x|)> \<mathe\><rsup|t<rsub|\<alpha\>><around*|(|x<rsup|\<alpha\>>-\<mu\><rsup|\<alpha\>>|)>>.
  </equation>

  And cumulant generating function as

  <\equation>
    K<rsub|p><around*|(|t,\<mu\>|)>\<assign\>ln
    M<rsub|p><around*|(|t,\<mu\>|)>.
  </equation>

  Then define momentum by

  <\equation>
    m<rsup|\<alpha\><rsub|1>\<cdots\>\<alpha\><rsub|n>><rsub|p><around*|(|\<mu\>|)>\<assign\><frac|\<partial\><rsup|n>M<rsub|p>|\<partial\>t<rsub|\<alpha\><rsub|1>>\<cdots\>\<partial\>t<rsub|\<alpha\><rsub|n>>><around*|(|0,\<mu\>|)>.
  </equation>

  And cumulant by

  <\equation>
    \<kappa\><rsup|\<alpha\><rsub|1>\<cdots\>\<alpha\><rsub|n>><rsub|p><around*|(|\<mu\>|)>\<assign\><frac|\<partial\><rsup|n>K<rsub|p>|\<partial\>t<rsub|\<alpha\><rsub|1>>\<cdots\>\<partial\>t<rsub|\<alpha\><rsub|n>>><around*|(|0,\<mu\>|)>.
  </equation>

  <\theorem>
    If <math|p<around*|(|x|)>> is decomposible, i.e.
    <math|p<around*|(|x|)>=<big|prod><rsub|\<alpha\>>p<rsub|\<alpha\>><around*|(|x<rsup|\<alpha\>>|)>>,
    then <math|\<kappa\><rsup|\<alpha\><rsub|1>\<cdots\>\<alpha\><rsub|n>><rsub|p><around*|(|\<mu\>|)>>
    is diagonal, i.e. <math|\<kappa\><rsup|\<alpha\><rsub|1>\<cdots\>\<alpha\><rsub|n>><rsub|p><around*|(|\<mu\>|)>\<propto\>\<delta\><rsup|\<alpha\><rsub|1>\<cdots\>\<alpha\><rsub|n>>>,
    the Kroneker-delta.
  </theorem>

  <\theorem>
    [Relation between Momentum and Cumulant]

    <\equation>
      m<rsup|\<alpha\><rsub|1>\<cdots\>\<alpha\><rsub|n>><rsub|p><around*|(|\<mu\>|)>=<text|Feynman
      diagram by <math|\<kappa\><rsup|\<alpha\><rsub|1>\<cdots\>\<alpha\><rsub|m>><rsub|p><around*|(|\<mu\>|)>>
      for <math|\<forall\>m\<leqslant\>n>>.
    </equation>
  </theorem>

  For instance,

  <\equation*>
    m<rsup|\<alpha\>\<beta\>><rsub|p><around*|(|\<mu\>|)>=\<kappa\><rsub|p><rsup|\<alpha\>\<beta\>><around*|(|\<mu\>|)>+\<kappa\><rsup|\<alpha\>><rsub|p><around*|(|\<mu\>|)>\<kappa\><rsup|\<beta\>><rsub|p><around*|(|\<mu\>|)>,
  </equation*>

  <\equation*>
    m<rsup|\<alpha\>\<beta\>\<gamma\>><rsub|p><around*|(|\<mu\>|)>=\<kappa\><rsub|p><rsup|\<alpha\>\<beta\>\<gamma\>><around*|(|\<mu\>|)>+\<kappa\><rsup|\<alpha\>><rsub|p><around*|(|\<mu\>|)>\<kappa\><rsup|\<beta\>\<gamma\>><rsub|p><around*|(|\<mu\>|)>+\<kappa\><rsup|\<gamma\>><rsub|p><around*|(|\<mu\>|)>\<kappa\><rsup|\<alpha\>\<beta\>><rsub|p><around*|(|\<mu\>|)>+\<kappa\><rsup|\<gamma\>><rsub|p><around*|(|\<mu\>|)>\<kappa\><rsup|\<gamma\>\<alpha\>><rsub|p><around*|(|\<mu\>|)>+\<kappa\><rsup|\<alpha\>><rsub|p><around*|(|\<mu\>|)>\<kappa\><rsup|\<beta\>><rsub|p><around*|(|\<mu\>|)>\<kappa\><rsup|\<gamma\>><rsub|p><around*|(|\<mu\>|)>.
  </equation*>

  <section|Hebbian Rule>

  Herein, we furnish a mathmatical formulation of the Hebbian rule.

  Hebb claimed that <with|font-shape|italic|neurons that fire together wire
  together>. This is the Hebbian rule. Mathematially, we characterize the
  distribution of random variables <math|X<rsup|a>>s, which can be
  illustrated as the activation of neurons, as <math|p<around*|(|x|)>>, s.t.,
  for any indices <math|\<alpha\>,\<beta\>> with
  <math|\<alpha\>\<neq\>\<beta\>>,

  <\equation*>
    <big|int>\<mathd\>x p<around*|(|x|)> <around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>-<wide|C|^><rsup|\<alpha\>\<beta\>>,
  </equation*>

  where <math|<wide|x|^><rsup|a>> denotes the mean
  <math|E<around*|(|X<rsup|a>|)>> and <math|<wide|C|^><rsup|ab>> the
  co-variance <math|Cov<around*|(|X<rsup|a>,X<rsup|b>|)>>, based on the
  empirical distribution in the real world.

  Given <math|<wide|x|^><rsup|a>> and <math|<wide|C|^><rsup|ab>>, define
  distribution <math|q<around*|(|x|)>\<assign\><big|prod><rsub|\<alpha\>>q<rsub|\<alpha\>><around*|(|x<rsup|\<alpha\>>|)>>
  with <math|<big|int>\<mathd\>x q<rsub|\<alpha\>><around*|(|x<rsup|\<alpha\>>|)>
  x<rsup|\<alpha\>>=<wide|x|^><rsup|\<alpha\>>.> We are considering the
  minimal extension of <math|q> s.t. this new distribution, say <math|p>, can
  satisty the Hebbian rule given above. The words minimal extension means
  that the KL-divergence <math|D<rsub|KL><around*|(|q,p|)>> is minimized. So,
  mathematically, the previous declarations can be summarized as the
  stabilization of Lagrangian

  <\align>
    <tformat|<table|<row|<cell|L<around*|(|p|)>>|<cell|=D<rsub|KL><around*|(|q,p|)>>>|<row|<cell|>|<cell|+<big|sum><rsub|\<alpha\>,\<beta\>,\<alpha\>\<neq\>\<beta\>>\<lambda\><rsub|\<alpha\>\<beta\>>
    <big|int>\<mathd\>x p<around*|(|x|)> <around*|[|<around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>-<wide|C|^><rsup|\<alpha\>\<beta\>>|]>>>|<row|<cell|>|<cell|+\<mu\><around*|(|<big|int>\<mathd\>x
    p<around*|(|x|)>-1|)>,>>>>
  </align>

  where the third line indicates that <math|p<around*|(|x|)>> is normalized
  s.t. it's a distribution.

  <\theorem>
    [Hebbian Rule]

    Define

    <\equation>
      E<around*|(|x|)>\<assign\>-<frac|1|2><big|sum><rsub|\<alpha\>,\<beta\>,\<alpha\>\<neq\>\<beta\>>W<rsub|\<alpha\>\<beta\>>
      <around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>,
    </equation>

    and

    <\equation>
      ln p<around*|(|x|)>\<assign\> ln q<around*|(|x|)>-E<around*|(|x|)>+ln
      Z,
    </equation>

    where <math|Z\<assign\><big|int>\<mathd\>x q<around*|(|x|)>
    exp<around*|(|-E<around*|(|x|)>|)>> is the normalization constant. Then,
    stablizing the Lagrangian <math|L<around*|(|p|)>> is equivalent to solve
    the <math|W> in <math|E<around*|(|x|)>> s.t. for
    <math|\<forall\>\<alpha\>,\<beta\>> with <math|\<alpha\>\<neq\>\<beta\>>,

    <\equation>
      <big|int>\<mathd\>x p<around*|(|x|)>
      <around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>=<wide|C|^><rsup|\<alpha\>\<beta\>>.
    </equation>
  </theorem>

  <section|Perturbation>

  Herein, we solve the equations in the perturbation framework.

  For expansion by <math|\<epsilon\>>, we re-formulate
  <math|E<around*|(|x|)>\<rightarrow\>\<beta\>E<around*|(|x|)>>, where
  constant <math|\<beta\>\<ll\>1>, indicating the <math|\<epsilon\>>. Thus

  <\equation>
    ln p<around*|(|x|)>\<assign\> ln q<around*|(|x|)>-\<beta\>E<around*|(|x|)>+ln
    Z,
  </equation>

  and <math|Z\<assign\><big|int>\<mathd\>x q<around*|(|x|)>
  exp<around*|(|-\<beta\>E<around*|(|x|)>|)>>.

  <\lemma>
    [First Order Perturbation]

    We have, for <math|\<forall\>\<alpha\>,\<beta\>> with
    <math|\<alpha\>\<neq\>\<beta\>>,

    <\equation>
      <wide|C|^><rsup|\<alpha\>\<beta\>>=\<beta\> W<rsub|\<alpha\>\<beta\>>
      \<kappa\><rsup|\<alpha\>\<alpha\>><rsub|q><around*|(|<wide|x|^>|)>
      \<kappa\><rsup|\<beta\>\<beta\>><rsub|q><around*|(|<wide|x|^>|)>+<with|math-font|cal|O><around*|(|\<beta\><rsup|2>|)>,
    </equation>

    and for <math|\<forall\>\<alpha\>>,

    <\equation>
      \<kappa\><rsub|q><rsup|\<alpha\>><around*|(|<wide|x|^>|)>=<with|math-font|cal|O><around*|(|\<beta\><rsup|2>|)>.
    </equation>
  </lemma>

  <\theorem>
    [First Order Perturbation Solution]

    Define standarizing function <math|z<rsup|\<alpha\>><around*|(|x<rsup|\<alpha\>>|)>\<assign\><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)>/<wide|\<sigma\>|^><rsup|\<alpha\>>>,
    where <math|<wide|\<sigma\>|^><rsup|\<alpha\>>\<assign\><sqrt|m<rsup|\<alpha\>\<alpha\>><rsub|q><around*|(|<wide|x|^>|)>>>.
    Let <math|<wide|\<rho\>|^><rsub|ab>> the Pearson correlation
    coefficients, i.e. <math|<wide|C|^><rsup|\<alpha\>\<beta\>>/<around*|(|<wide|\<sigma\>|^><rsup|\<alpha\>><wide|\<sigma\>|^><rsup|\<beta\>>|)>>.
    We have, by omitting <math|<with|math-font|cal|O><around*|(|\<beta\><rsup|2>|)>>,
    the solution of <math|E> is

    <\equation*>
      E<around*|(|x|)>=-<frac|1|2><wide|\<rho\>|^><rsub|\<alpha\>\<beta\>>
      z<rsup|\<alpha\>><around*|(|x<rsup|\<alpha\>>|)>
      z<rsup|\<beta\>><around*|(|x<rsup|\<beta\>>|)>.
    </equation*>
  </theorem>
</body>

<initial|<\collection>
</collection>>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|?|../../../.TeXmacs/texts/scratch/no_name_7.tm>>
    <associate|auto-2|<tuple|2|?|../../../.TeXmacs/texts/scratch/no_name_7.tm>>
    <associate|auto-3|<tuple|3|?|../../../.TeXmacs/texts/scratch/no_name_7.tm>>
    <associate|auto-4|<tuple|3|?|../../../.TeXmacs/texts/scratch/no_name_7.tm>>
  </collection>
</references>
<TeXmacs|1.99.10>

<style|generic>

<\body>
  <section|Preliminary>

  Herein, we discuss momentum and cumulant, preparing for the following
  calculation.

  <\definition>
    [Momentum and Cumulant]

    Let <math|p> a distribution of a high-dimensional random variable
    <math|X<rsup|a>>, then, given constant vector <math|\<mu\>>, define
    momentum generating function as

    <\equation>
      M<rsub|p><around*|(|t;\<mu\>|)>\<assign\><big|int>\<mathd\>x
      p<around*|(|x|)> \<mathe\><rsup|t<rsub|\<alpha\>><around*|(|x<rsup|\<alpha\>>-\<mu\><rsup|\<alpha\>>|)>>.
    </equation>

    And cumulant generating function as

    <\equation>
      K<rsub|p><around*|(|t;\<mu\>|)>\<assign\>ln
      M<rsub|p><around*|(|t;\<mu\>|)>.
    </equation>

    Then define momentum by

    <\equation>
      m<rsup|\<alpha\><rsub|1>\<cdots\>\<alpha\><rsub|n>><rsub|p><around*|(|\<mu\>|)>\<assign\><frac|\<partial\><rsup|n>M<rsub|p>|\<partial\>t<rsub|\<alpha\><rsub|1>>\<cdots\>\<partial\>t<rsub|\<alpha\><rsub|n>>><around*|(|0;\<mu\>|)>.
    </equation>

    And cumulant by

    <\equation>
      \<kappa\><rsup|\<alpha\><rsub|1>\<cdots\>\<alpha\><rsub|n>><rsub|p><around*|(|\<mu\>|)>\<assign\><frac|\<partial\><rsup|n>K<rsub|p>|\<partial\>t<rsub|\<alpha\><rsub|1>>\<cdots\>\<partial\>t<rsub|\<alpha\><rsub|n>>><around*|(|0;\<mu\>|)>.
    </equation>
  </definition>

  <\theorem>
    If components of <math|X<rsup|a>> is independent, i.e.
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

  <\notation>
    In this section, we use Einstein's convention, and set
    <math|W<rsub|\<alpha\>\<alpha\>>\<equiv\>0>,
  </notation>

  <\lemma>
    [First Order Perturbation (Part 1)]

    Let <math|Z\<backassign\>Z<rsub|0>+\<beta\>
    Z<rsub|1>+\<beta\><rsup|2>Z<rsub|2>/2!+\<cdots\>> and
    <math|p<around*|(|x|)>\<backassign\>p<rsub|0><around*|(|x|)>+\<beta\>p<rsub|1><around*|(|x|)>+\<beta\><rsup|2>p<rsub|2><around*|(|x|)>/2!+\<cdots\>>.
    We have

    <\equation>
      Z<rsub|0>=1,
    </equation>

    <\equation>
      Z<rsub|1>=<frac|1|2><big|sum><rsub|\<alpha\>,\<beta\>,\<alpha\>\<neq\>\<beta\>>W<rsub|\<alpha\>\<beta\>>
      m<rsub|q><rsup|\<alpha\>\<beta\>><around*|(|<wide|x|^>|)>,
    </equation>

    and

    <\equation>
      p<rsub|0><around*|(|x|)>=q<around*|(|x|)>,
    </equation>

    <\equation>
      p<rsub|1><around*|(|x|)>=q<around*|(|x|)>\<times\><frac|1|2><big|sum><rsub|\<alpha\>,\<beta\>,\<alpha\>\<neq\>\<beta\>>W<rsub|\<alpha\>\<beta\>><around*|[|<around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>-
      m<rsub|q><rsup|\<alpha\>\<beta\>><around*|(|<wide|x|^>|)>|]>.
    </equation>
  </lemma>

  <\lemma>
    [First Order Perturbation (Part 2)]

    We have, for <math|\<forall\>\<alpha\>>,

    <\equation>
      m<rsub|p><rsup|\<alpha\>><around*|(|<wide|x|^>|)>=<with|math-font|cal|O><around*|(|\<beta\><rsup|2>|)>,
    </equation>

    and for <math|\<forall\>\<alpha\>,\<beta\>> with
    <math|\<alpha\>\<neq\>\<beta\>>,

    <\equation>
      <wide|C|^><rsup|\<alpha\>\<beta\>>=\<beta\> W<rsub|\<alpha\>\<beta\>>
      m<rsup|\<alpha\>\<alpha\>><rsub|q><around*|(|<wide|x|^>|)>
      m<rsup|\<beta\>\<beta\>><rsub|q><around*|(|<wide|x|^>|)>+<with|math-font|cal|O><around*|(|\<beta\><rsup|2>|)>.
    </equation>
  </lemma>

  <\proof>
    Briefly, we abbreviate the notations

    <\align>
      <tformat|<table|<row|<cell|<big|sum><rsub|\<alpha\>,\<beta\>,\<alpha\>\<neq\>\<beta\>>>|<cell|\<rightarrow\>>>|<row|<cell|m<rsub|q><rsup|\<alpha\>\<cdots\>><around*|(|<wide|x|^>|)>>|<cell|\<rightarrow\>m<rsup|\<alpha\>\<cdots\>>>>|<row|<cell|\<kappa\><rsub|q><rsup|\<alpha\>\<cdots\>><around*|(|<wide|x|^>|)>>|<cell|\<rightarrow\>\<kappa\><rsup|\<alpha\>\<cdots\>>>>>>
    </align>

    Directly, for <math|\<forall\>\<alpha\>>,

    <\align>
      <tformat|<table|<row|<cell|m<rsub|p><rsup|\<alpha\>><around*|(|<wide|x|^>|)>\<assign\>>|<cell|<big|int>\<mathd\>x
      p<around*|(|x|)><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)>>>|<row|<cell|<around*|{|p<rsub|0>,p<rsub|1>=\<cdots\>|}>=>|<cell|<big|int>\<mathd\>x
      q<around*|(|x|)><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)>>>|<row|<cell|+>|<cell|\<beta\><big|int>\<mathd\>x
      q<around*|(|x|)><frac|1|2>W<rsub|\<alpha\><rprime|'>\<beta\><rprime|'>>
      <around*|[|<around*|(|x<rsup|\<alpha\><rprime|'>>-<wide|x|^><rsup|\<alpha\><rprime|'>>|)><around*|(|x<rsup|\<beta\><rprime|'>>-<wide|x|^><rsup|\<beta\><rprime|'>>|)>-
      m<rsup|\<alpha\><rprime|'>\<beta\><rprime|'>>|]><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)>>>|<row|<cell|+>|<cell|<with|math-font|cal|O><around*|(|\<beta\><rsup|2>|)>>>|<row|<cell|<around*|{|m<rsup|\<alpha\>\<cdots\>>\<assign\>\<cdots\>|}>=>|<cell|m<rsup|\<alpha\>>>>|<row|<cell|+>|<cell|\<beta\><frac|1|2>W<rsub|\<alpha\><rprime|'>\<beta\><rprime|'>><around*|(|m<rsup|\<alpha\><rprime|'>\<beta\><rprime|'>\<alpha\>>-m<rsup|\<alpha\><rprime|'>\<beta\><rprime|'>>m<rsup|\<alpha\>>|)>>>|<row|<cell|+>|<cell|<with|math-font|cal|O><around*|(|\<beta\><rsup|2>|)>>>|<row|<cell|<around*|{|Feynman
      diagram|}>=>|<cell|\<kappa\><rsup|\<alpha\>>>>|<row|<cell|+>|<cell|\<beta\><frac|1|2>W<rsub|\<alpha\><rprime|'>\<beta\><rprime|'>><around*|(|<text|non-diagonal>+\<kappa\><rsup|a>\<cdots\>|)>>>|<row|<cell|+>|<cell|<with|math-font|cal|O><around*|(|\<beta\><rsup|2>|)>>>|<row|<cell|<around*|{|\<kappa\><rsup|\<alpha\>\<cdots\>>
      is diagonal,\<kappa\><rsup|\<alpha\>>=0|}>=>|<cell|0>>|<row|<cell|+>|<cell|0>>|<row|<cell|+>|<cell|<with|math-font|cal|O><around*|(|\<beta\><rsup|2>|)>.>>>>
    </align>

    Directly, for <math|\<forall\>\<alpha\>,\<beta\>>,

    <\align>
      <tformat|<table|<row|<cell|m<rsup|\<alpha\>\<beta\>><rsub|p><around*|(|<wide|x|^>|)>\<assign\>>|<cell|<big|int>\<mathd\>x
      p<around*|(|x|)><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>>>|<row|<cell|<around*|{|p<rsub|0>,p<rsub|1>=\<cdots\>|}>=>|<cell|<big|int>\<mathd\>x
      q<around*|(|x|)><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>>>|<row|<cell|+>|<cell|\<beta\><big|int>\<mathd\>x
      q<around*|(|x|)><frac|1|2>W<rsub|\<alpha\><rprime|'>\<beta\><rprime|'>>
      <around*|[|<around*|(|x<rsup|\<alpha\><rprime|'>>-<wide|x|^><rsup|\<alpha\><rprime|'>>|)><around*|(|x<rsup|\<beta\><rprime|'>>-<wide|x|^><rsup|\<beta\><rprime|'>>|)>-
      m<rsup|\<alpha\><rprime|'>\<beta\><rprime|'>>|]><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>>>|<row|<cell|+>|<cell|<with|math-font|cal|O><around*|(|\<beta\><rsup|2>|)>>>|<row|<cell|<around*|{|m<rsup|\<alpha\>\<cdots\>>\<assign\>\<cdots\>|}>=>|<cell|m<rsup|\<alpha\>\<beta\>>>>|<row|<cell|+>|<cell|\<beta\><frac|1|2>W<rsub|\<alpha\><rprime|'>\<beta\><rprime|'>><around*|(|m<rsup|\<alpha\><rprime|'>\<beta\><rprime|'>\<alpha\>\<beta\>>-m<rsup|\<alpha\><rprime|'>\<beta\><rprime|'>>m<rsup|\<alpha\>\<beta\>>|)>>>|<row|<cell|+>|<cell|<with|math-font|cal|O><around*|(|\<beta\><rsup|2>|)>>>|<row|<cell|<around*|{|Feynman
      diagram|}>=>|<cell|\<kappa\><rsup|\<alpha\>\<beta\>>+\<kappa\><rsup|\<alpha\>>\<kappa\><rsup|\<beta\>>>>|<row|<cell|+>|<cell|\<beta\>W<rsub|\<alpha\><rprime|'>\<beta\><rprime|'>>\<kappa\><rsup|\<alpha\><rprime|'>\<alpha\>>\<kappa\><rsup|\<beta\><rprime|'>\<beta\>>+\<beta\>W<rsub|\<alpha\><rprime|'>\<beta\><rprime|'>><around*|(|\<kappa\><rsup|\<alpha\><rprime|'>>\<kappa\><rsup|\<alpha\>>\<kappa\><rsup|\<beta\><rprime|'>\<beta\>>+\<kappa\><rsup|\<alpha\><rprime|'>\<alpha\>>\<kappa\><rsup|\<beta\><rprime|'>>\<kappa\><rsup|\<beta\>>|)>>>|<row|<cell|+>|<cell|<with|math-font|cal|O><around*|(|\<beta\><rsup|2>|)>>>|<row|<cell|<around*|{|\<kappa\><rsup|\<alpha\>\<cdots\>>\<propto\>\<delta\><rsup|\<alpha\>\<cdots\>>,\<kappa\><rsup|\<alpha\>>=0|}>=>|<cell|\<kappa\><rsup|\<alpha\>\<alpha\>>\<delta\><rsup|\<alpha\>\<beta\>>>>|<row|<cell|+>|<cell|\<beta\>W<rsub|\<alpha\>\<beta\>>\<kappa\><rsup|\<alpha\>\<alpha\>>\<kappa\><rsup|\<beta\>\<beta\>>>>|<row|<cell|+>|<cell|<with|math-font|cal|O><around*|(|\<beta\><rsup|2>|)>.>>>>
    </align>

    Thus, for <math|\<forall\>\<alpha\>>,

    <\align>
      <tformat|<table|<row|<cell|m<rsub|p><rsup|\<alpha\>\<alpha\>><around*|(|<wide|x|^>|)>:=>|<cell|<big|int>\<mathd\>x
      p<around*|(|x|)><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><rsup|2>>>|<row|<cell|=>|<cell|\<kappa\><rsup|\<alpha\>\<alpha\>>+<with|math-font|cal|O><around*|(|\<beta\><rsup|2>|)>>>|<row|<cell|<around*|{|\<kappa\><rsup|\<alpha\>>=0|}>=>|<cell|m<rsup|\<alpha\>\<alpha\>>+<with|math-font|cal|O><around*|(|\<beta\><rsup|2>|)>,>>>>
    </align>

    and for <math|\<forall\>\<alpha\>,\<beta\>> with
    <math|\<alpha\>\<neq\>\<beta\>>, from the equations

    <\align>
      <tformat|<table|<row|<cell|<wide|C|^><rsup|\<alpha\>\<beta\>>=>|<cell|<big|int>\<mathd\>x
      p<around*|(|x|)><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>>>|<row|<cell|=>|<cell|\<beta\>W<rsub|\<alpha\>\<beta\>>\<kappa\><rsup|\<alpha\>\<alpha\>>\<kappa\><rsup|\<beta\>\<beta\>>+<with|math-font|cal|O><around*|(|\<beta\><rsup|2>|)>>>|<row|<cell|<around*|{|\<kappa\><rsup|\<alpha\>>=0|}>=>|<cell|\<beta\>W<rsub|\<alpha\>\<beta\>>m<rsup|\<alpha\>\<alpha\>>m<rsup|\<beta\>\<beta\>>+<with|math-font|cal|O><around*|(|\<beta\><rsup|2>|)>.>>>>
    </align>
  </proof>

  <\theorem>
    [First Order Perturbation Solution]

    Let <math|<wide|\<sigma\>|^><rsup|\<alpha\>>> the standard derivative of
    <math|q<rsub|\<alpha\>>>, i.e. <math|<wide|\<sigma\>|^><rsup|\<alpha\>>\<assign\><sqrt|m<rsup|\<alpha\>\<alpha\>><rsub|q><around*|(|<wide|x|^>|)>>>.
    Define standarizing function <math|z<rsup|\<alpha\>><around*|(|x<rsup|\<alpha\>>|)>\<assign\><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)>/<wide|\<sigma\>|^><rsup|\<alpha\>>>.
    Let <math|<wide|\<rho\>|^><rsub|ab>\<assign\><wide|C|^><rsup|\<alpha\>\<beta\>>/<around*|(|<wide|\<sigma\>|^><rsup|\<alpha\>><wide|\<sigma\>|^><rsup|\<beta\>>|)>>.
    The solution of <math|E> is

    <\equation*>
      \<beta\>E<around*|(|x|)>=-<frac|1|2><wide|\<rho\>|^><rsub|\<alpha\>\<beta\>>
      z<rsup|\<alpha\>><around*|(|x<rsup|\<alpha\>>|)>
      z<rsup|\<beta\>><around*|(|x<rsup|\<beta\>>|)>+<with|math-font|cal|O><around*|(|\<beta\><rsup|2>|)>.
    </equation*>

    Notice that this formulation is invariant under re-scaling and shift
    transformations, i.e. <math|x<rsup|\<alpha\>>\<rightarrow\>a<rsup|\<alpha\>>
    x<rsup|\<alpha\>>+b<rsup|\<alpha\>>>, where <math|a> and <math|b> are
    constant vectors.
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
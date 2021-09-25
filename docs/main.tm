<TeXmacs|1.99.10>

<style|article>

<\body>
  <section|Energy-based Model>

  <\definition>
    [Energy-based Model]

    Let <math|<with|math-font|cal|M>> a measure space, and
    <math|E:\<bbb-R\><rsup|m>\<rightarrow\><around*|(|<with|math-font|cal|M>\<rightarrow\>\<bbb-R\>|)>>.
    Then define probabilitic model based on <math|E> as

    <\equation*>
      p<rsub|E><around*|(|x;\<theta\>|)>=<frac|exp<around*|(|-E<around*|(|x;\<theta\>|)>|)>|<big|int><rsub|<with|math-font|cal|M>>\<mathd\>x<rprime|'>
      exp<around*|(|-E<around*|(|x<rprime|'>;\<theta\>|)>|)>>,
    </equation*>

    where <math|\<theta\>\<in\>\<bbb-R\><rsup|m>> and
    <math|x\<in\><with|math-font|cal|M>>.

    We call this an energy-based model, where
    <math|E<around*|(|\<cdummy\>;\<theta\>|)>> is called a energy function
    parameterized by <math|\<theta\>>.
  </definition>

  <\theorem>
    [Universality]

    For any probability density <math|q:<with|math-font|cal|M>\<rightarrow\>\<bbb-R\>>
    and for <math|\<forall\>C\<in\>\<bbb-R\>>, define, for
    <math|\<forall\>x\<in\>supp<around*|(|q|)>>,

    <\equation*>
      E<rsub|q><around*|(|x|)>\<assign\>-ln q<around*|(|x|)>+C,
    </equation*>

    then, for <math|\<forall\>x\<in\>supp<around*|(|q|)>>,

    <\equation*>
      q<around*|(|x|)>=<frac|exp<around*|(|-E<rsub|q><around*|(|x|)>|)>|<big|int><rsub|supp<around*|(|q|)>>\<mathd\>x<rprime|'>
      exp<around*|(|-E<rsub|q><around*|(|x<rprime|'>|)>|)>>.
    </equation*>

    That is, for any probability density, there exists an energy function (up
    to constant) that can describe the probability density.
  </theorem>

  <\theorem>
    [Maximum Entropy Principle]

    For any probability density <math|p<rsub|D>:<with|math-font|cal|M>\<rightarrow\>\<bbb-R\>>,
    we have

    <\equation*>
      p<rsub|E><around*|(|x|)>=argmax<rsub|p> H<around*|[|X|]>,
    </equation*>

    s.t. contrains

    <\equation*>
      \<bbb-E\><rsub|x\<sim\>p<rsub|D>><around*|[|<frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|x;\<theta\>|)>|]>=\<bbb-E\><rsub|x\<sim\>p><around*|[|<frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|x;\<theta\>|)>|]>
    </equation*>

    are satisfied.
  </theorem>

  <\theorem>
    [Activity Rule]

    The local maximum of <math|p<rsub|E><around*|(|\<cdummy\>;\<theta\>|)>>
    is the local minimum of <math|E<around*|(|\<cdummy\>;\<theta\>|)>>, and
    vice versa.
  </theorem>

  <\theorem>
    [Learning Rule]

    For any probability density <math|p<rsub|D>:<with|math-font|cal|M>\<rightarrow\>\<bbb-R\>>,
    define Lagrangian <math|L<around*|(|\<theta\>;p<rsub|D>|)>\<assign\>-<big|int><rsub|<with|math-font|cal|M>>\<mathd\>x
    p<rsub|D><around*|(|x|)> ln p<rsub|E><around*|(|x;\<theta\>|)>>. Then,
    the gradient of Lagrangian w.r.t. component
    <math|\<theta\><rsup|\<alpha\>>> is

    <\equation*>
      <frac|\<partial\>L|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|\<theta\>;p<rsub|D>|)>=<big|int><rsub|<with|math-font|cal|M>>\<mathd\>x
      p<rsub|D><around*|(|x|)> <frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|x;\<theta\>|)>-<big|int><rsub|<with|math-font|cal|M>>\<mathd\>x
      p<rsub|E><around*|(|x;\<theta\>|)> <frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|x;\<theta\>|)>,
    </equation*>

    or in more compact format,

    <\equation*>
      <frac|\<partial\>L|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|\<theta\>;p<rsub|D>|)>=\<bbb-E\><rsub|x\<sim\>p<rsub|D>><around*|[|<frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|x;\<theta\>|)>|]>-\<bbb-E\><rsub|x\<sim\>p<around*|(|x;\<theta\>|)>><around*|[|<frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|x;\<theta\>|)>|]>.
    </equation*>
  </theorem>

  <section|Effective Theory>

  <\definition>
    [Effective Energy]

    Suppose exists <math|<around*|(|<with|math-font|cal|V>,<with|math-font|cal|H>|)>>,
    s.t. <math|<with|math-font|cal|M>=<with|math-font|cal|V>\<oplus\><with|math-font|cal|H>>.
    Re-denote <math|E<around*|(|x;\<theta\>|)>\<rightarrow\>E<around*|(|v,h;\<theta\>|)>>
    and <math|p<around*|(|x;\<theta\>|)>\<rightarrow\>p<around*|(|v,h;\<theta\>|)>>.
    Then, define effective energy <math|E<rsub|eff>:<with|math-font|cal|V>\<rightarrow\>\<bbb-R\>>
    as

    <\equation*>
      E<rsub|eff><around*|(|v;\<theta\>|)>\<assign\>-ln
      <big|int><rsub|<with|math-font|cal|H>>\<mathd\>h
      exp<around*|(|-E<around*|(|v,h;\<theta\>|)>|)>.
    </equation*>
  </definition>

  <\theorem>
    [Effective Theory]

    Recall that <math|p<around*|(|v;\<theta\>|)>\<assign\><big|int><rsub|<with|math-font|cal|H>>\<mathd\>h
    p<around*|(|v,h;\<theta\>|)>>. Then,

    <\equation*>
      p<around*|(|v;\<theta\>|)>=<frac|exp<around*|(|-E<rsub|eff><around*|(|v;\<theta\>|)>|)>|<big|int><rsub|<with|math-font|cal|V>>\<mathd\>v<rprime|'>
      exp<around*|(|-E<rsub|eff><around*|(|v<rprime|'>;\<theta\>|)>|)>>.
    </equation*>
  </theorem>

  <\lemma>
    [Gradient of Effective Energy]

    <\equation*>
      <frac|\<partial\>E<rsub|eff>|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|v,\<theta\>|)>=<big|int><rsub|<with|math-font|cal|H>>\<mathd\>h
      p<around*|(|h\|v;\<theta\>|)> <frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|v,h;\<theta\>|)>.
    </equation*>
  </lemma>

  <\theorem>
    [Learning Rule of Effective Theory]

    For any probability density <math|p<rsub|D>:<with|math-font|cal|V>\<rightarrow\>\<bbb-R\>>,
    define Lagrangian <math|L<around*|(|\<theta\>;p<rsub|D>|)>\<assign\>-<big|int><rsub|<with|math-font|cal|V>>\<mathd\>v
    p<rsub|D><around*|(|v|)> ln p<around*|(|v;\<theta\>|)>>. Then, the
    gradient of Lagrangian w.r.t. component <math|\<theta\><rsup|\<alpha\>>>
    is

    <\equation*>
      <frac|\<partial\>L|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|\<theta\>;p<rsub|D>|)>=<big|int><rsub|<with|math-font|cal|V>>\<mathd\>v<big|int><rsub|<with|math-font|cal|H>>\<mathd\>h
      p<rsub|D><around*|(|v|)> p<around*|(|h\|v;\<theta\>|)>
      <frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|v,h;\<theta\>|)>-<big|int><rsub|<with|math-font|cal|V>>\<mathd\>v<big|int><rsub|<with|math-font|cal|H>>\<mathd\>h
      \ p<around*|(|v,h;\<theta\>|)> <frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|v,h;\<theta\>|)>,
    </equation*>

    or in more compact format,

    <\equation*>
      <frac|\<partial\>L|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|\<theta\>;p<rsub|D>|)>=\<bbb-E\><rsub|v\<sim\>p<rsub|D>,h\<sim\>p<around*|(|h\|v;\<theta\>|)>><around*|[|<frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|v,h;\<theta\>|)>|]>-\<bbb-E\><rsub|v,h\<sim\>p<around*|(|v,h;\<theta\>|)>><around*|[|<frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|v,h;\<theta\>|)>|]>.
    </equation*>
  </theorem>

  <section|Examples>

  <\example>
    [Boltzmann Machine]

    <\itemize>
      <item>Let <math|<with|math-font|cal|M>=<around*|{|0,1|}><rsup|n>>,
      <math|W\<in\>\<bbb-R\><rsup|<around*|(|n\<times\>n|)>>> with
      <math|W<rsub|\<alpha\>\<beta\>>=W<rsub|\<beta\>\<alpha\>>> and
      <math|W<rsub|\<alpha\>\<alpha\>>=0> for
      <math|\<forall\>\<alpha\>,\<beta\>>, <math|b\<in\>\<bbb-R\><rsup|n>>,
      <math|\<theta\>\<assign\><around*|(|W,b|)>>. Then a Boltzmann machine
      is defined by energy function

      <\equation*>
        E<around*|(|x;W,b|)>\<assign\>-<around*|(|1/2|)>
        <big|sum><rsub|\<alpha\>,\<beta\>\<neq\>\<alpha\>>W<rsub|\<alpha\>\<beta\>>
        x<rsup|\<alpha\>> x<rsup|\<beta\>>-<big|sum><rsub|\<alpha\>>b<rsub|\<alpha\>>
        x<rsup|\<alpha\>>.
      </equation*>

      <item>Direct calculation gives

      <\equation*>
        p<around*|(|x<rsub|\<alpha\>>=1\|x<rsub|\\\<alpha\>>|)>=\<sigma\><around*|(|<big|sum><rsub|\<beta\>\<neq\>\<alpha\>>W<rsub|\<alpha\>\<beta\>>
        x<rsup|\<beta\>>+b<rsub|\<alpha\>>|)>.
      </equation*>
    </itemize>
  </example>

  <\example>
    [Boltzmann Machine Variation #1]

    <\itemize>
      <item>Let <math|<with|math-font|cal|M>=<around*|{|0,1|}><rsup|n>>,
      <math|W\<in\>\<bbb-R\><rsup|<around*|(|n\<times\>n|)>>>,
      <math|b\<in\>\<bbb-R\><rsup|n>>, <math|\<theta\>\<assign\><around*|(|W,b|)>>.
      Given dataset <math|D\<assign\><around*|{|x<rsub|i>\|x<rsub|i>\<in\><with|math-font|cal|M>,i=1,\<ldots\>,N|}>>,
      denote expectation as <math|<wide|x|^><rsup|\<alpha\>>>. Then a
      Boltzmann machine is defined by energy function

      <\equation*>
        E<around*|(|x;W,b|)>\<assign\>-<around*|(|1/2|)>
        <big|sum><rsub|\<alpha\>,\<beta\>>W<rsub|\<alpha\>\<beta\>>
        <around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)>
        \ <around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>-<big|sum><rsub|\<alpha\>>b<rsub|\<alpha\>>
        x<rsup|\<alpha\>>.
      </equation*>

      <item>Direct calculation gives<\footnote>
        Since

        <\align>
          <tformat|<table|<row|<cell|p<around*|(|x|)>\<propto\>>|<cell|exp<around*|{|<big|sum><rsub|\<alpha\>,\<beta\>><frac|1|2>
          W<rsub|\<alpha\>\<beta\>> <around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)>
          \ <around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>+<big|sum><rsub|\<alpha\>>b<rsub|\<alpha\>>
          x<rsup|\<alpha\>>|}>>>|<row|<cell|>|<cell|=exp<around*|{|<big|sum><rsub|\<alpha\>,\<beta\>><around*|(|<frac|1|2>
          W<rsub|\<alpha\>\<beta\>> x<rsup|\<alpha\>>
          \ x<rsup|\<beta\>>-<frac|1|2>W<rsub|\<alpha\>\<beta\>>
          x<rsup|\<alpha\>> <wide|x|^><rsup|\<beta\>>-<frac|1|2>W<rsub|\<beta\>\<alpha\>>
          x<rsup|\<alpha\>> <wide|x|^><rsup|\<beta\>>+<frac|1|2>
          W<rsub|\<alpha\>\<beta\>> <wide|x|^><rsup|\<alpha\>>
          <wide|x|^><rsup|\<beta\>>|)>+<big|sum><rsub|\<alpha\>>b<rsub|\<alpha\>>
          x<rsup|\<alpha\>>|}>>>|<row|<cell|>|<cell|=exp<around*|{|<big|sum><rsub|\<alpha\>,\<beta\>><around*|(|<frac|1|2>
          W<rsub|\<alpha\>\<beta\>> x<rsup|\<alpha\>>
          \ x<rsup|\<beta\>>-W<rsub|<around*|(|\<alpha\>\<beta\>|)>>
          x<rsup|\<alpha\>> <wide|x|^><rsup|\<beta\>>+<frac|1|2>
          W<rsub|\<alpha\>\<beta\>> <wide|x|^><rsup|\<alpha\>>
          <wide|x|^><rsup|\<beta\>>|)>+<big|sum><rsub|\<alpha\>>b<rsub|\<alpha\>>
          x<rsup|\<alpha\>>|}>>>|<row|<cell|>|<cell|=exp<around*|{|<big|sum><rsub|\<alpha\>,\<beta\>><frac|1|2>
          W<rsub|\<alpha\>\<beta\>> x<rsup|\<alpha\>>
          \ x<rsup|\<beta\>>+<big|sum><rsub|\<alpha\>><around*|(|b<rsub|\<alpha\>>-<big|sum><rsub|\<beta\>>W<rsub|<around*|(|\<alpha\>\<beta\>|)>>
          <wide|x|^><rsup|\<beta\>>|)> x<rsup|\<alpha\>>+Const|}>,>>>>
        </align>

        we have

        <\align>
          <tformat|<table|<row|<cell|<frac|p<around*|(|x<rsub|\<alpha\>>=1\|x<rsub|\\\<alpha\>>|)>|p<around*|(|x<rsub|\<alpha\>>=0\|x<rsub|\\\<alpha\>>|)>>=>|<cell|exp<around*|{|<big|sum><rsub|\<beta\>>W<rsub|<around*|(|\<alpha\>\<beta\>|)>>
          x<rsup|\<beta\>>-<frac|1|2> W<rsub|\<alpha\>\<alpha\>>+<around*|(|b<rsub|\<alpha\>>-<big|sum><rsub|\<beta\>>W<rsub|<around*|(|\<alpha\>\<beta\>|)>>
          <wide|x|^><rsup|\<beta\>>|)>|}>>>|<row|<cell|=>|<cell|exp<around*|{|<big|sum><rsub|\<beta\>>W<rsub|<around*|(|\<alpha\>\<beta\>|)>>
          <around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>+<around*|(|b<rsub|\<alpha\>>-<frac|1|2>
          W<rsub|\<alpha\>\<alpha\>>|)>|}>.>>>>
        </align>

        Thus

        <\equation*>
          p<around*|(|x<rsub|\<alpha\>>=1\|x<rsub|\\\<alpha\>>|)>=\<sigma\><around*|(|<big|sum><rsub|\<beta\>>W<rsub|<around*|(|\<alpha\>\<beta\>|)>>
          <around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>+<around*|(|b<rsub|\<alpha\>>-<frac|1|2>
          W<rsub|\<alpha\>\<alpha\>>|)>|)>.
        </equation*>
      </footnote>

      <\equation*>
        p<around*|(|x<rsub|\<alpha\>>=1\|x<rsub|\\\<alpha\>>|)>=\<sigma\><around*|(|<big|sum><rsub|\<beta\>>W<rsub|<around*|(|\<alpha\>\<beta\>|)>>
        \ x<rsup|\<beta\>>+c<rsub|\<alpha\>>|)>,
      </equation*>

      where <math|W<rsub|<around*|(|\<alpha\>\<beta\>|)>>\<assign\><around*|(|W<rsub|\<alpha\>\<beta\>>+W<rsub|\<beta\>\<alpha\>>|)>/2>
      and <math|c<rsub|\<alpha\>>\<assign\><around*|(|b<rsub|\<alpha\>>-<around*|(|1/2|)>
      W<rsub|\<alpha\>\<alpha\>>-<big|sum><rsub|\<beta\>>W<rsub|<around*|(|\<alpha\>\<beta\>|)>><wide|x|^><rsup|\<beta\>>|)>>.
    </itemize>
  </example>

  <\example>
    [Restricted Boltzmann Machine]

    <\itemize>
      <item>Let <math|<with|math-font|cal|V>=<around*|{|0,1|}><rsup|n>> and
      <math|<with|math-font|cal|H>=<around*|{|0,1|}><rsup|m>>. Let
      <math|W\<in\>\<bbb-R\><rsup|<around*|(|n\<times\>m|)>>>,
      <math|b\<in\>\<bbb-R\><rsup|n>>, <math|c\<in\>\<bbb-R\><rsup|m>>,
      <math|\<theta\>\<assign\><around*|(|W,b,c|)>>. Then a restricted
      Boltzmann machine is defined by energy function

      <\equation*>
        E<around*|(|v,h;W,b,c|)>\<assign\>-<around*|(|1/2|)>
        <big|sum><rsub|\<alpha\>,\<beta\>\<neq\>\<alpha\>>W<rsub|\<alpha\>\<beta\>>
        v<rsup|\<alpha\>> h<rsup|\<beta\>>-<big|sum><rsub|\<alpha\>>b<rsub|\<alpha\>>
        v<rsup|\<alpha\>>-<big|sum><rsub|\<alpha\>>c<rsub|\<alpha\>>
        h<rsup|\<alpha\>>.
      </equation*>

      <item>Direct calculation gives

      <\equation*>
        E<rsub|eff><around*|(|v;W,b,c|)>=-<big|sum><rsub|\<alpha\>>b<rsub|\<alpha\>>
        v<rsup|\<alpha\>>-<big|sum><rsub|\<beta\>>s<rsub|+><around*|(|<big|sum><rsub|\<alpha\>>W<rsub|\<alpha\>\<beta\>>
        v<rsup|\<alpha\>>+c<rsub|\<beta\>>|)>,
      </equation*>

      where <math|s<rsub|+>> represents soft-plus function.
    </itemize>
  </example>

  <section|Perturbation Theory>

  <subsection|Perturbation of Boltzmann Machine>

  Define <math|p<rsub|i><around*|(|x|)>> by Taylor expansion
  <math|p<rsub|E><around*|(|x|)>=p<rsub|0><around*|(|x|)>+p<rsub|1><around*|(|x|)>+\<cdots\>+p<rsub|n><around*|(|x|)>+<with|math-font|cal|O><around*|(|W<rsup|n+1>|)>>.
  Denote <math|\<sigma\><rsub|\<alpha\>>\<assign\>\<sigma\><around*|(|b<rsub|\<alpha\>>|)>>.

  <\lemma>
    [0th-order of Boltzmann Machine]

    We have<\footnote>
      Since <math|E<rsub|0><around*|(|x;W,b|)>\<assign\>-<big|sum><rsub|\<alpha\>>b<rsub|\<alpha\>>
      x<rsup|\<alpha\>>>,

      <\align>
        <tformat|<table|<row|<cell|p<rsub|0><around*|(|x|)>=>|<cell|<frac|exp<around*|(|<big|sum><rsub|\<alpha\>>b<rsub|\<alpha\>>
        x<rsup|\<alpha\>>|)>|<big|sum><rsub|x<rprime|'><rsup|1>\<in\><around*|{|0,1|}>>\<cdots\><big|sum><rsub|x<rprime|'><rsup|n>\<in\><around*|{|0,1|}>>exp<around*|(|<big|sum><rsub|\<alpha\>>b<rsub|\<alpha\>>
        x<rprime|'><rsup|\<alpha\>>|)>>>>|<row|<cell|=>|<cell|<big|prod><rsub|\<alpha\>><frac|exp<around*|(|b<rsub|\<alpha\>>
        x<rsup|\<alpha\>>|)>|<big|sum><rsub|x<rprime|'><rsup|\<alpha\>>\<in\><around*|{|0,1|}>>exp<around*|(|b<rsub|\<alpha\>>
        x<rprime|'><rsup|\<alpha\>>|)>>>>|<row|<cell|=>|<cell|<big|prod><rsub|\<alpha\>>p<rsub|\<alpha\>><around*|(|x|)>.>>>>
      </align>
    </footnote>

    <\equation*>
      p<rsub|0><around*|(|x|)>=<big|prod><rsub|\<alpha\>>p<rsub|\<alpha\>><around*|(|x<rsup|\<alpha\>>|)>,
    </equation*>

    where

    <\equation*>
      p<rsub|\<alpha\>><around*|(|x|)>\<assign\><frac|exp<around*|(|b<rsub|\<alpha\>>
      x|)>|1+exp<around*|(|b<rsub|\<alpha\>>|)>>.
    </equation*>
  </lemma>

  <\lemma>
    We have<\footnote>
      Directly,

      <\align>
        <tformat|<table|<row|<cell|<frac|\<partial\>|\<partial\>b<rsub|\<alpha\>>>p<rsub|\<alpha\>><around*|(|x|)>=>|<cell|<frac|\<partial\>|\<partial\>b<rsub|\<alpha\>>><frac|exp<around*|(|b<rsub|\<alpha\>>
        x|)>|1+exp<around*|(|b<rsub|\<alpha\>>|)>>>>|<row|<cell|=>|<cell|<frac|exp<around*|(|b<rsub|\<alpha\>>
        x|)>x|1+exp<around*|(|b<rsub|\<alpha\>>|)>>-<frac|exp<around*|(|b<rsub|\<alpha\>>
        x|)><around*|[|exp<around*|(|b<rsub|\<alpha\>>|)>|]>|<around*|[|1+exp<around*|(|b<rsub|\<alpha\>>|)>|]><rsup|2>>>>|<row|<cell|=>|<cell|<frac|exp<around*|(|b<rsub|\<alpha\>>
        x|)>|1+exp<around*|(|b<rsub|\<alpha\>>|)>><around*|[|x-<frac|exp<around*|(|b<rsub|\<alpha\>>|)>|1+exp<around*|(|b<rsub|\<alpha\>>|)>>|]>>>|<row|<cell|=>|<cell|p<rsub|\<alpha\>><around*|(|x|)><around*|(|x-\<sigma\><around*|(|b<rsub|\<alpha\>>|)>|)>>>>>
      </align>
    </footnote>

    <\equation*>
      <frac|\<partial\>p<rsub|\<alpha\>>|\<partial\>b<rsub|\<alpha\>>><around*|(|x|)>=p<rsub|\<alpha\>><around*|(|x|)><around*|(|x-\<sigma\><rsub|\<alpha\>>|)>.
    </equation*>
  </lemma>

  <\lemma>
    [Statistics]

    For <math|\<forall\>\<alpha\>>, the mean of <math|p<rsub|\<alpha\>>>
    <math|V<rsup|\<alpha\>>\<assign\><big|sum><rsub|x>p<rsub|0><around*|(|x|)>
    x<rsup|\<alpha\>>> is<\footnote>
      Since <math|<around*|(|\<partial\>p<rsub|\<alpha\>>/\<partial\>b<rsub|\<alpha\>>|)><around*|(|x|)>=p<rsub|\<alpha\>><around*|(|x|)><around*|(|x-\<sigma\><around*|(|b<rsub|\<alpha\>>|)>|)>>,

      <\align>
        <tformat|<table|<row|<cell|<big|sum><rsub|x><frac|\<partial\>|\<partial\>b<rsub|\<alpha\>>>p<rsub|\<alpha\>><around*|(|x|)>=>|<cell|<big|sum><rsub|x>p<rsub|\<alpha\>><around*|(|x|)>x-<big|sum><rsub|x>p<rsub|\<alpha\>><around*|(|x|)>\<sigma\><around*|(|b<rsub|\<alpha\>>|)>>>|<row|<cell|<frac|\<partial\>|\<partial\>b<rsub|\<alpha\>>><big|sum><rsub|x>p<rsub|\<alpha\>><around*|(|x|)>=>|<cell|<big|sum><rsub|x>p<rsub|\<alpha\>><around*|(|x|)>x-<around*|(|<big|sum><rsub|x>p<rsub|\<alpha\>><around*|(|x|)>|)>\<sigma\><around*|(|b<rsub|\<alpha\>>|)>>>|<row|<cell|0=>|<cell|<big|sum><rsub|x>p<rsub|\<alpha\>><around*|(|x|)>x-\<sigma\><around*|(|b<rsub|\<alpha\>>|)>.>>>>
      </align>
    </footnote>

    <\equation>
      V<rsup|\<alpha\>>=\<sigma\><rsup|\<alpha\>>.
    </equation>

    And variance <math|V<rsup|\<alpha\><rsub|1>\<alpha\><rsub|2>>\<assign\><big|sum><rsub|x>p<rsub|0><around*|(|x|)>
    <big|prod><rsub|i=1><rsup|2><around*|(|x-\<sigma\><rsup|\<alpha\><rsub|i>>|)>>
    is<\footnote>
      Since <math|<around*|(|\<partial\>p<rsub|\<alpha\>>/\<partial\>b<rsub|\<alpha\>>|)><around*|(|x|)>=p<rsub|\<alpha\>><around*|(|x|)><around*|(|x-\<sigma\><around*|(|b<rsub|\<alpha\>>|)>|)>>,

      <\align>
        <tformat|<table|<row|<cell|<frac|\<partial\><rsup|2>p<rsub|0>|\<partial\>b<rsub|\<beta\>>\<partial\>b<rsub|\<alpha\>>><around*|(|x|)>=>|<cell|<frac|\<partial\>|\<partial\>b<rsub|\<beta\>>><around*|[|p<rsub|0><around*|(|x|)><around*|(|x-\<sigma\><rsup|\<alpha\>>|)>|]>>>|<row|<cell|=>|<cell|p<rsub|0><around*|(|x|)><around*|(|x-\<sigma\><rsup|\<alpha\>>|)><around*|(|x-\<sigma\><rsup|\<beta\>>|)>-\<delta\><rsup|\<alpha\>\<beta\>>p<rsub|0><around*|(|x|)>\<sigma\><rsup|\<alpha\>><around*|(|1-\<sigma\><rsup|\<alpha\>>|)>.>>>>
      </align>

      Thus,

      <\align>
        <tformat|<table|<row|<cell|<big|sum><rsub|x><frac|\<partial\><rsup|2>p<rsub|0>|\<partial\>b<rsub|\<beta\>>\<partial\>b<rsub|\<alpha\>>><around*|(|x|)>=>|<cell|<big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x-\<sigma\><rsup|\<alpha\>>|)><around*|(|x-\<sigma\><rsup|\<beta\>>|)>-<big|sum>\<delta\><rsup|\<alpha\>\<beta\>><rsub|x>p<rsub|0><around*|(|x|)>\<sigma\><rsup|\<alpha\>><around*|(|1-\<sigma\><rsup|\<alpha\>>|)>.>>|<row|<cell|0=>|<cell|<big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x-\<sigma\><rsup|\<alpha\>>|)><around*|(|x-\<sigma\><rsup|\<beta\>>|)>-\<delta\><rsup|\<alpha\>\<beta\>>\<sigma\><rsup|\<alpha\>><around*|(|1-\<sigma\><rsup|\<alpha\>>|)>.>>>>
      </align>

      <\equation*>
        <big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x-\<sigma\><rsup|\<alpha\>>|)><around*|(|x-\<sigma\><rsup|\<beta\>>|)>=\<delta\><rsup|\<alpha\>\<beta\>>\<sigma\><rsup|\<alpha\>><around*|(|1-\<sigma\><rsup|\<alpha\>>|)>.
      </equation*>
    </footnote>

    <\equation>
      V<rsup|\<alpha\><rsub|1>\<alpha\><rsub|2>>=\<delta\><rsup|\<alpha\><rsub|1>\<alpha\><rsub|2>>\<sigma\><rsup|a<rsub|1>><around*|(|1-\<sigma\><rsup|\<alpha\><rsub|1>>|)>.
    </equation>

    3-momentum <math|V<rsup|\<alpha\><rsub|1>\<alpha\><rsub|2>\<alpha\><rsub|3>>\<assign\><big|sum><rsub|x>p<rsub|0><around*|(|x|)>
    <big|prod><rsub|i=1><rsup|3><around*|(|x-\<sigma\><rsup|\<alpha\><rsub|i>>|)>>
    is<\footnote>
      \;
    </footnote>

    <\equation>
      V<rsup|\<alpha\><rsub|1>\<alpha\><rsub|2>\<alpha\><rsub|3>>=\<delta\><rsup|\<alpha\><rsub|1>\<alpha\><rsub|2>\<alpha\><rsub|3>>\<sigma\><rsup|\<alpha\><rsub|1>><around*|(|1-\<sigma\><rsup|\<alpha\><rsub|1>>|)><around*|(|1-2\<sigma\><rsup|\<alpha\><rsub|1>>|)>.
    </equation>

    4-momentum <math|V<rsup|\<alpha\><rsub|1>\<cdots\>\<alpha\><rsub|4>>\<assign\><big|sum><rsub|x>p<rsub|0><around*|(|x|)>
    <big|prod><rsub|i=1><rsup|4><around*|(|x-\<sigma\><rsup|\<alpha\><rsub|i>>|)>>
    is<\footnote>
      \;
    </footnote>

    <\equation>
      V<rsup|\<alpha\><rsub|1>\<cdots\>\<alpha\><rsub|4>>=V<rsub|c><rsup|\<alpha\><rsub|1>\<cdots\>\<alpha\><rsub|4>>+<big|sum><rsub|<text|all
      pairs>>V<rsup|\<alpha\><rsub|m<rsub|1>>\<alpha\><rsub|m<rsub|2>>>
      V<rsup|\<alpha\><rsub|n<rsub|1>>\<alpha\><rsub|n<rsub|2>>>,
    </equation>

    where \Pconnected\Q part

    <\equation>
      V<rsub|c><rsup|\<alpha\><rsub|1>\<cdots\>\<alpha\><rsub|4>>\<assign\>\<delta\><rsup|\<alpha\><rsub|1>\<cdots\>\<alpha\><rsub|4>>
      \<sigma\><rsup|\<alpha\><rsub|1>><around*|(|1-\<sigma\><rsup|\<alpha\><rsub|1>>|)>
      <around*|[|6 <around*|(|\<sigma\><rsup|\<alpha\><rsub|1>>|)><rsup|2>-6
      \<sigma\><rsup|\<alpha\><rsub|1>>+1|]>,
    </equation>

    and <math|<around*|(|m<rsub|1>,m<rsub|2>|)>,<around*|(|n<rsub|1>,n<rsub|2>|)>>
    runs over all (three) pairs.
  </lemma>

  <\lemma>
    For <math|\<forall\>\<alpha\>>,<\footnote>
      The gradient of loss gives

      <\align>
        <tformat|<table|<row|<cell|<wide|x|^><rsup|\<alpha\>>=>|<cell|<big|sum><rsub|x>p<rsub|E><around*|(|x|)>x<rsup|\<alpha\>>>>|<row|<cell|<around*|{|Tayor
        expansion|}>=>|<cell|<big|sum><rsub|x>p<rsub|0><around*|(|x|)>x<rsup|\<alpha\>>+<with|math-font|cal|O><around*|(|W|)>>>|<row|<cell|<around*|{|<big|sum><rsub|x>p<rsub|0><around*|(|x|)>x<rsup|\<alpha\>>=\<sigma\><rsup|\<alpha\>>|}>=>|<cell|\<sigma\><rsup|\<alpha\>>+<with|math-font|cal|O><around*|(|W|)>.>>>>
      </align>
    </footnote>

    <\equation>
      <wide|x|^><rsup|\<alpha\>>=\<sigma\><rsup|\<alpha\>>+<with|math-font|cal|O><around*|(|W|)>.
    </equation>
  </lemma>

  <\theorem>
    [1st-order]<\footnote>
      Directly,

      <\align>
        <tformat|<table|<row|<cell|p<rsub|E><around*|(|x|)>=>|<cell|<frac|exp<around*|{|b<rsub|\<alpha\>>x<rsup|\<alpha\>>+<frac|1|2>W<rsub|\<alpha\>\<beta\>><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>|}>|Z>>>|<row|<cell|<around*|{|Expand
        to 1st order|}>=>|<cell|<frac|exp<around*|(|b<rsub|\<alpha\>>x<rsup|\<alpha\>>|)><around*|{|1+<frac|1|2>W<rsub|\<alpha\>\<beta\>><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>+\<cdots\>|}>|Z<rsub|0><around*|(|1+Z<rsub|1>+\<cdots\>|)>>>>|<row|<cell|=>|<cell|p<rsub|0><around*|(|x|)><frac|<around*|{|1+<frac|1|2>W<rsub|\<alpha\>\<beta\>><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>+\<cdots\>|}>|1+Z<rsub|1>+\<cdots\>>>>|<row|<cell|p<rsub|0><around*|(|x|)>+p<rsub|1><around*|(|x|)>+\<cdots\>\<assign\>>|<cell|p<rsub|0><around*|(|x|)><around*|{|1+<frac|1|2>W<rsub|\<alpha\>\<beta\>><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>-Z<rsub|1>+\<cdots\>|}>.>>>>
      </align>

      Thus

      <\align>
        <tformat|<table|<row|<cell|<big|sum><rsub|x>p<rsub|E><around*|(|x|)>=>|<cell|<big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|{|1+<frac|1|2>W<rsub|\<alpha\>\<beta\>><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>-Z<rsub|1>|}>>>|<row|<cell|1=>|<cell|1+<frac|1|2>W<rsub|\<alpha\>\<beta\>><around*|[|<big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>|]>-Z<rsub|1>.>>>>
      </align>

      Since

      <\align>
        <tformat|<table|<row|<cell|>|<cell|<big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>>>|<row|<cell|=>|<cell|\<delta\><rsub|\<alpha\>\<beta\>><big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><rsup|2>+<around*|(|\<sigma\><rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|\<sigma\><rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>-\<delta\><rsub|\<alpha\>\<beta\>><around*|(|\<sigma\><rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><rsup|2>>>|<row|<cell|=>|<cell|\<delta\><rsub|\<alpha\>\<beta\>><big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<alpha\>>-\<sigma\><rsup|\<alpha\>>|)><rsup|2>+<around*|(|\<sigma\><rsup|\<alpha\>>-\<sigma\><rsup|\<alpha\>>|)><around*|(|\<sigma\><rsup|\<beta\>>-\<sigma\><rsup|\<beta\>>|)>-\<delta\><rsub|\<alpha\>\<beta\>><around*|(|\<sigma\><rsup|\<alpha\>>-\<sigma\><rsup|\<alpha\>>|)><rsup|2>+<with|math-font|cal|O><around*|(|W|)>>>|<row|<cell|=>|<cell|\<delta\><rsub|\<alpha\>\<beta\>>
        \<sigma\><rsup|\<alpha\>><around*|(|1-\<sigma\><rsup|\<alpha\>>|)>+<with|math-font|cal|O><around*|(|W|)>,>>>>
      </align>

      we have

      <\align>
        <tformat|<table|<row|<cell|Z<rsub|1>=>|<cell|<frac|1|2>W<rsub|\<alpha\>\<beta\>><around*|[|<big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>|]>>>|<row|<cell|<around*|{|Omit
        <with|math-font|cal|O><around*|(|W<rsup|2>|)>|}>=>|<cell|<frac|1|2>W<rsub|\<alpha\>\<alpha\>>
        \<sigma\><rsup|\<alpha\>><around*|(|1-\<sigma\><rsup|\<alpha\>>|)>>>>>
      </align>

      Thus, at the 1st-order of <math|W>, we have

      <\align>
        <tformat|<table|<row|<cell|<frac|p<rsub|1><around*|(|x|)>|p<rsub|0><around*|(|x|)>>=>|<cell|<frac|1|2>W<rsub|\<alpha\>\<beta\>><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>-Z<rsub|1>>>|<row|<cell|=>|<cell|<frac|1|2>W<rsub|\<alpha\>\<beta\>><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>-<frac|1|2>W<rsub|\<alpha\>\<alpha\>>
        \<sigma\><rsup|\<alpha\>><around*|(|1-\<sigma\><rsup|\<alpha\>>|)>>>|<row|<cell|<around*|{|<wide|x|^><rsup|\<alpha\>>=\<sigma\><rsup|\<alpha\>>+<with|math-font|cal|O><around*|(|W|)>|}>=>|<cell|<frac|1|2>W<rsub|\<alpha\>\<beta\>><around*|(|x<rsup|\<alpha\>>-\<sigma\><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-\<sigma\><rsup|\<beta\>>|)>-<frac|1|2>W<rsub|\<alpha\>\<alpha\>>\<sigma\><rsup|\<alpha\>><around*|(|1-\<sigma\><rsup|\<alpha\>>|)>.>>>>
      </align>
    </footnote>

    <\equation>
      <frac|p<rsub|1><around*|(|x|)>|p<rsub|0><around*|(|x|)>>=<frac|1|2>W<rsub|\<alpha\>\<beta\>><around*|(|x<rsup|\<alpha\>>-\<sigma\><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-\<sigma\><rsup|\<beta\>>|)>-<frac|1|2>W<rsub|\<alpha\>\<alpha\>>\<sigma\><rsup|\<alpha\>><around*|(|1-\<sigma\><rsup|\<alpha\>>|)>.
    </equation>
  </theorem>

  <\lemma>
    Up to the 1st-order of <math|W>, for <math|\<forall\>\<gamma\>>,<\footnote>
      Directly,

      <\align>
        <tformat|<table|<row|<cell|<big|sum><rsub|x>p<rsub|E><around*|(|x|)>x<rsup|\<gamma\>>=>|<cell|<big|sum><rsub|x>p<rsub|0><around*|(|x|)>x<rsup|\<gamma\>>+<big|sum><rsub|x>p<rsub|1><around*|(|x|)>x<rsup|\<gamma\>>>>|<row|<cell|<around*|{|p<rsub|1><around*|(|x|)>=\<cdots\>|}>=>|<cell|\<sigma\><rsup|\<gamma\>>-<frac|1|2>W<rsub|\<alpha\>\<alpha\>>\<sigma\><rsup|\<alpha\>><around*|(|1-\<sigma\><rsup|\<alpha\>>|)><big|sum><rsub|x>p<rsub|0><around*|(|x|)>x<rsup|\<gamma\>>+<frac|1|2>W<rsub|\<alpha\>\<beta\>><big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<alpha\>>-\<sigma\><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-\<sigma\><rsup|\<beta\>>|)>x<rsup|\<gamma\>>>>|<row|<cell|=>|<cell|\<sigma\><rsup|\<gamma\>>-<frac|1|2>W<rsub|\<alpha\>\<alpha\>>\<sigma\><rsup|\<alpha\>><around*|(|1-\<sigma\><rsup|\<alpha\>>|)>\<sigma\><rsup|\<gamma\>>>>|<row|<cell|>|<cell|+<frac|1|2>W<rsub|\<alpha\>\<beta\>><big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<alpha\>>-\<sigma\><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-\<sigma\><rsup|\<beta\>>|)><around*|(|x<rsup|\<gamma\>>-\<sigma\><rsup|\<gamma\>>|)>+<frac|1|2>W<rsub|\<alpha\>\<beta\>><big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<alpha\>>-\<sigma\><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-\<sigma\><rsup|\<beta\>>|)>\<sigma\><rsup|\<gamma\>>>>|<row|<cell|=>|<cell|\<sigma\><rsup|\<gamma\>>-<frac|1|2>W<rsub|\<alpha\>\<alpha\>>\<sigma\><rsup|\<alpha\>><around*|(|1-\<sigma\><rsup|\<alpha\>>|)>\<sigma\><rsup|\<gamma\>>>>|<row|<cell|>|<cell|+<frac|1|2>W<rsub|\<alpha\>\<beta\>><big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<alpha\>>-\<sigma\><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-\<sigma\><rsup|\<beta\>>|)><around*|(|x<rsup|\<gamma\>>-\<sigma\><rsup|\<gamma\>>|)>+<frac|1|2>W<rsub|\<alpha\>\<beta\>><big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<alpha\>>-\<sigma\><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-\<sigma\><rsup|\<beta\>>|)>\<sigma\><rsup|\<gamma\>>>>|<row|<cell|=>|<cell|\<sigma\><rsup|\<gamma\>>-<frac|1|2>W<rsub|\<alpha\>\<alpha\>>\<sigma\><rsup|\<alpha\>><around*|(|1-\<sigma\><rsup|\<alpha\>>|)>\<sigma\><rsup|\<gamma\>>>>|<row|<cell|>|<cell|+<frac|1|2>W<rsub|\<alpha\>\<beta\>>\<delta\><rsup|\<alpha\>\<beta\>\<gamma\>><around*|[|\<sigma\><rsup|\<alpha\>><around*|(|1-\<sigma\><rsup|\<alpha\>>|)><rsup|2>-\<sigma\><rsup|\<alpha\>2><around*|(|1-\<sigma\><rsup|\<alpha\>>|)>|]>+<frac|1|2>W<rsub|\<alpha\>\<beta\>>\<delta\><rsup|\<alpha\>\<beta\>>\<sigma\><rsup|\<alpha\>><around*|(|1-\<sigma\><rsup|\<alpha\>>|)>\<sigma\><rsup|\<gamma\>>>>|<row|<cell|=>|<cell|\<sigma\><rsup|\<gamma\>>+<frac|1|2>W<rsub|\<gamma\>\<gamma\>><around*|[|\<sigma\><rsup|\<gamma\>><around*|(|1-\<sigma\><rsup|\<gamma\>>|)><rsup|2>-\<sigma\><rsup|\<gamma\>2><around*|(|1-\<sigma\><rsup|\<gamma\>>|)>|]>>>|<row|<cell|=>|<cell|\<sigma\><rsup|\<gamma\>>+<frac|1|2><around*|(|1-2\<sigma\><rsup|\<gamma\>>|)>W<rsub|\<alpha\>\<gamma\>>V<rsup|\<alpha\>\<gamma\>>.>>>>
      </align>
    </footnote>

    <\equation>
      <big|sum><rsub|x>p<rsub|E><around*|(|x|)>x<rsup|\<gamma\>>=V<rsup|\<gamma\>>+<frac|1|2><around*|(|1-2V<rsup|\<gamma\>>|)>W<rsub|\<alpha\>\<gamma\>>V<rsup|\<alpha\>\<gamma\>>.
    </equation>

    And, for <math|\<forall\><around*|(|\<mu\>,\<nu\>|)>>,<\footnote>
      Directly,

      <\align>
        <tformat|<table|<row|<cell|>|<cell|<big|sum><rsub|x>p<rsub|E><around*|(|x|)><around*|(|x<rsup|\<mu\>>-<wide|x|^><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-<wide|x|^><rsup|\<nu\>>|)>>>|<row|<cell|=>|<cell|<big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<mu\>>-<wide|x|^><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-<wide|x|^><rsup|\<nu\>>|)>+<big|sum><rsub|x>p<rsub|1><around*|(|x|)><around*|(|x<rsup|\<mu\>>-<wide|x|^><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-<wide|x|^><rsup|\<nu\>>|)>>>|<row|<cell|=>|<cell|<big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|<around*|(|x<rsup|\<mu\>>-\<sigma\><rsup|\<mu\>>|)>+<around*|(|\<sigma\><rsup|\<mu\>>-<wide|x|^><rsup|\<mu\>>|)>|)><around*|(|<around*|(|x<rsup|\<nu\>>-\<sigma\><rsup|\<nu\>>|)>+<around*|(|\<sigma\><rsup|\<nu\>>-<wide|x|^><rsup|\<nu\>>|)>|)>>>|<row|<cell|+>|<cell|<big|sum><rsub|x>p<rsub|1><around*|(|x|)><around*|(|x<rsup|\<mu\>>-\<sigma\><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-\<sigma\><rsup|\<nu\>>|)>>>|<row|<cell|=>|<cell|<big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<mu\>>-\<sigma\><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-\<sigma\><rsup|\<nu\>>|)>+<big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<mu\>>-\<sigma\><rsup|\<mu\>>|)><around*|(|\<sigma\><rsup|\<nu\>>-<wide|x|^><rsup|\<nu\>>|)>>>|<row|<cell|>|<cell|+<big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|\<sigma\><rsup|\<mu\>>-<wide|x|^><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-\<sigma\><rsup|\<nu\>>|)>+<big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|\<sigma\><rsup|\<mu\>>-<wide|x|^><rsup|\<mu\>>|)><around*|(|\<sigma\><rsup|\<nu\>>-<wide|x|^><rsup|\<nu\>>|)>>>|<row|<cell|+>|<cell|<frac|1|2>W<rsub|\<alpha\>\<beta\>><big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<mu\>>-\<sigma\><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-\<sigma\><rsup|\<nu\>>|)><around*|(|x<rsup|\<alpha\>>-\<sigma\><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-\<sigma\><rsup|\<beta\>>|)>>>|<row|<cell|>|<cell|-<frac|1|2>W<rsub|\<alpha\>\<beta\>>\<delta\><rsup|\<alpha\>\<beta\>>\<sigma\><rsup|\<alpha\>><around*|(|1-\<sigma\><rsup|\<alpha\>>|)><big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<mu\>>-\<sigma\><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-\<sigma\><rsup|\<nu\>>|)>>>|<row|<cell|=>|<cell|\<delta\><rsub|\<mu\>\<nu\>>\<sigma\><rsup|\<mu\>><around*|(|1-\<sigma\><rsup|\<mu\>>|)>-<big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<mu\>>-\<sigma\><rsup|\<mu\>>|)><around*|[|<frac|1|2>W<rsub|\<nu\>\<nu\>><around*|[|\<sigma\><rsup|\<nu\>><around*|(|1-\<sigma\><rsup|\<nu\>>|)><rsup|2>-\<sigma\><rsup|\<nu\>><rsup|2><around*|(|1-\<sigma\><rsup|\<nu\>>|)>|]>|]>>>|<row|<cell|>|<cell|-<big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<nu\>>-\<sigma\><rsup|\<nu\>>|)><around*|[|<frac|1|2>W<rsub|\<mu\>\<mu\>><around*|[|\<sigma\><rsup|\<mu\>><around*|(|1-\<sigma\><rsup|\<mu\>>|)><rsup|2>-\<sigma\><rsup|\<mu\>><rsup|2><around*|(|1-\<sigma\><rsup|\<mu\>>|)>|]>|]>+<with|math-font|cal|O><around*|(|W<rsup|2>|)>>>|<row|<cell|+>|<cell|<frac|1|2>W<rsub|\<alpha\>\<beta\>><big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<mu\>>-\<sigma\><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-\<sigma\><rsup|\<nu\>>|)><around*|(|x<rsup|\<alpha\>>-\<sigma\><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-\<sigma\><rsup|\<beta\>>|)>>>|<row|<cell|->|<cell|<frac|1|2>W<rsub|\<alpha\>\<beta\>>\<delta\><rsup|\<alpha\>\<beta\>>\<sigma\><rsup|\<alpha\>><around*|(|1-\<sigma\><rsup|\<alpha\>>|)>\<delta\><rsub|\<mu\>\<nu\>>\<sigma\><rsup|\<mu\>><around*|(|1-\<sigma\><rsup|\<mu\>>|)>>>|<row|<cell|=>|<cell|\<delta\><rsub|\<mu\>\<nu\>>\<sigma\><rsup|\<mu\>><around*|(|1-\<sigma\><rsup|\<mu\>>|)>>>|<row|<cell|+>|<cell|<frac|1|2>W<rsub|\<alpha\>\<beta\>>
        V<rsup|\<alpha\>\<mu\>> V<rsup|\<beta\>\<nu\>>+<frac|1|2>W<rsub|\<alpha\>\<beta\>>
        V<rsup|\<alpha\>\<nu\>> V<rsup|\<beta\>\<mu\>>+<frac|1|2>W<rsub|\<alpha\>\<beta\>>
        V<rsup|\<alpha\>\<beta\>> V<rsup|\<mu\>\<nu\>>>>|<row|<cell|>|<cell|+<frac|1|2>W<rsub|\<alpha\>\<beta\>>\<delta\><rsup|\<alpha\>\<beta\>\<mu\>\<nu\>>\<sigma\><rsup|\<mu\>><around*|(|1-\<sigma\><rsup|\<mu\>>|)><around*|[|6
        <around*|(|\<sigma\><rsup|\<mu\>>|)><rsup|2>-6
        \<sigma\><rsup|\<mu\>>+1|]>>>|<row|<cell|->|<cell|<frac|1|2>W<rsub|\<alpha\>\<beta\>>
        V<rsup|\<alpha\>\<beta\>> V<rsup|\<mu\>\<nu\>>>>|<row|<cell|=>|<cell|V<rsup|\<mu\>\<nu\>>>>|<row|<cell|+>|<cell|W<rsub|<around*|(|\<alpha\>\<beta\>|)>>
        V<rsup|\<alpha\>\<mu\>> V<rsup|\<beta\>\<nu\>>+<frac|1|2>W<rsub|\<mu\>\<nu\>>V<rsup|\<mu\>\<nu\>><around*|[|6
        <around*|(|\<sigma\><rsup|\<mu\>>|)><rsup|2>-6
        \<sigma\><rsup|\<mu\>>+1|]>.>>>>
      </align>
    </footnote>

    <\equation>
      <big|sum><rsub|x>p<rsub|E><around*|(|x|)><around*|(|x<rsup|\<mu\>>-<wide|x|^><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-<wide|x|^><rsup|\<nu\>>|)>=V<rsup|\<mu\>\<nu\>>+W<rsub|<around*|(|\<alpha\>\<beta\>|)>>
      V<rsup|\<alpha\>\<mu\>> V<rsup|\<beta\>\<nu\>>+<frac|1|2><around*|[|6
      <around*|(|V<rsup|\<mu\>>|)><rsup|2>-6
      V<rsup|\<mu\>>+1|]>W<rsub|\<mu\>\<nu\>>V<rsup|\<mu\>\<nu\>>.
    </equation>
  </lemma>

  <\theorem>
    Define <math|<wide|\<sigma\>|^><rsup|\<alpha\>>\<assign\><big|sum><rsub|x>p<rsub|D><around*|(|x|)>x<rsup|\<alpha\>>>
    and <math|<wide|W|^><rsup|\<mu\>\<nu\>>\<assign\><big|sum><rsub|x>p<rsub|D><around*|(|x|)><around*|(|x<rsup|\<mu\>>-<wide|x|^><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-<wide|x|^><rsup|\<nu\>>|)>>.
    Let <math|W<rsub|\<mu\>\<nu\>>> symmetric. By

    <\equation>
      <wide|\<sigma\>|^><rsup|\<alpha\>>=<big|sum><rsub|x>p<rsub|E><around*|(|x|)>x<rsup|\<alpha\>>,
    </equation>

    <\equation>
      <wide|W|^><rsup|\<mu\>\<nu\>>=<big|sum><rsub|x>p<rsub|E><around*|(|x|)><around*|(|x<rsup|\<mu\>>-<wide|x|^><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-<wide|x|^><rsup|\<nu\>>|)>,
    </equation>

    we get<\footnote>
      When <math|\<mu\>\<neq\>\<nu\>>, we have

      <\align>
        <tformat|<table|<row|<cell|<wide|W|^><rsup|\<mu\>\<nu\>>=>|<cell|<big|sum><rsub|x>p<rsub|E><around*|(|x|)><around*|(|x<rsup|\<mu\>>-<wide|x|^><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-<wide|x|^><rsup|\<nu\>>|)>>>|<row|<cell|<around*|{|V<rsup|\<mu\>\<nu\>>\<propto\>\<delta\><rsup|\<mu\>\<nu\>>|}>=>|<cell|W<rsub|<around*|(|\<alpha\>\<beta\>|)>>
        V<rsup|\<alpha\>\<mu\>> V<rsup|\<beta\>\<nu\>>>>|<row|<cell|<around*|{|<text|<math|W<rsub|\<mu\>\<nu\>>>
        symmetric>|}>=>|<cell|W<rsub|\<alpha\>\<beta\>>
        V<rsup|\<alpha\>\<mu\>> V<rsup|\<beta\>\<nu\>>>>|<row|<cell|<around*|{|V<rsup|\<alpha\><rsub|1>\<alpha\><rsub|2>>=\<delta\><rsup|\<alpha\><rsub|1>\<alpha\><rsub|2>>\<sigma\><rsup|a<rsub|1>><around*|(|1-\<sigma\><rsup|\<alpha\><rsub|1>>|)>|}>=>|<cell|W<rsub|\<mu\>\<nu\>>
        \<sigma\><rsup|\<mu\>><around*|(|1-\<sigma\><rsup|\<mu\>>|)>
        \<sigma\><rsup|\<nu\>><around*|(|1-\<sigma\><rsup|\<nu\>>|)>>>|<row|<cell|<around*|{|up
        to <with|math-font|cal|O><around*|(|W|)>|}>=>|<cell|W<rsub|\<mu\>\<nu\>>
        <wide|\<sigma\>|^><rsup|\<mu\>><around*|(|1-<wide|\<sigma\>|^><rsup|\<mu\>>|)>
        <wide|\<sigma\>|^><rsup|\<nu\>><around*|(|1-<wide|\<sigma\>|^><rsup|\<nu\>>|)>>>>>
      </align>

      thus, for <math|\<forall\>\<mu\>\<neq\>\<nu\>>,

      <\equation*>
        W<rsub|\<mu\>\<nu\>>=<frac|<wide|W|^><rsup|\<mu\>\<nu\>>|<wide|\<sigma\>|^><rsup|\<mu\>><around*|(|1-<wide|\<sigma\>|^><rsup|\<mu\>>|)>
        <wide|\<sigma\>|^><rsup|\<nu\>><around*|(|1-<wide|\<sigma\>|^><rsup|\<nu\>>|)>>.
      </equation*>

      And for <math|\<mu\>=\<nu\>>,

      \;

      <\align>
        <tformat|<table|<row|<cell|<wide|W|^><rsup|\<mu\>\<mu\>>=>|<cell|<big|sum><rsub|x>p<rsub|E><around*|(|x|)><around*|(|x<rsup|\<mu\>>-<wide|x|^><rsup|\<mu\>>|)><around*|(|x<rsup|\<mu\>>-<wide|x|^><rsup|\<mu\>>|)>>>|<row|<cell|<around*|{|<text|<math|W<rsub|\<mu\>\<nu\>>>
        symmetric>|}>=>|<cell|V<rsup|\<mu\>\<mu\>>+W<rsub|\<alpha\>\<beta\>>
        V<rsup|\<alpha\>\<mu\>> V<rsup|\<beta\>\<mu\>>+<frac|1|2><around*|[|6
        <around*|(|V<rsup|\<mu\>>|)><rsup|2>-6
        V<rsup|\<mu\>>+1|]>W<rsub|\<mu\>\<mu\>>V<rsup|\<mu\>\<mu\>>>>|<row|<cell|=>|<cell|\<sigma\><rsup|\<mu\>><around*|(|1-\<sigma\><rsup|\<mu\>>|)>+W<rsub|\<alpha\>\<beta\>>\<delta\><rsup|\<alpha\>\<beta\>\<mu\>><around*|[|\<sigma\><rsup|\<mu\>><around*|(|1-\<sigma\><rsup|\<mu\>>|)>|]><rsup|2>+<frac|1|2><around*|[|6
        <around*|(|V<rsup|\<mu\>>|)><rsup|2>-6
        V<rsup|\<mu\>>+1|]>W<rsub|\<mu\>\<mu\>>\<sigma\><rsup|\<mu\>><around*|(|1-\<sigma\><rsup|\<mu\>>|)>>>|<row|<cell|=>|<cell|\<sigma\><rsup|\<mu\>><around*|(|1-\<sigma\><rsup|\<mu\>>|)>+W<rsub|\<mu\>\<mu\>><around*|[|\<sigma\><rsup|\<mu\>><around*|(|1-\<sigma\><rsup|\<mu\>>|)>|]><rsup|2>+<frac|1|2><around*|[|6
        <around*|(|V<rsup|\<mu\>>|)><rsup|2>-6
        V<rsup|\<mu\>>+1|]>W<rsub|\<mu\>\<mu\>>\<sigma\><rsup|\<mu\>><around*|(|1-\<sigma\><rsup|\<mu\>>|)>>>|<row|<cell|=>|<cell|\<sigma\><rsup|\<mu\>><around*|(|1-\<sigma\><rsup|\<mu\>>|)><around*|{|1+<around*|[|\<sigma\><rsup|\<mu\>>-<around*|(|\<sigma\><rsup|\<mu\>>|)><rsup|2>+<frac|1|2><around*|[|6
        <around*|(|\<sigma\><rsup|\<mu\>>|)><rsup|2>-6
        \<sigma\><rsup|\<mu\>>+1|]>|]>W<rsub|\<mu\>\<mu\>>|}>>>|<row|<cell|=>|<cell|\<sigma\><rsup|\<mu\>><around*|(|1-\<sigma\><rsup|\<mu\>>|)><around*|{|1+<around*|[|2<around*|(|\<sigma\><rsup|\<mu\>>|)><rsup|2>-2\<sigma\><rsup|\<mu\>>+<frac|1|2>|]>W<rsub|\<mu\>\<mu\>>|}>>>|<row|<cell|<around*|{|\<sigma\><rsup|\<mu\>>=<wide|\<sigma\>|^><rsup|\<mu\>>+\<cdots\>|}>=>|<cell|<around*|{|<wide|\<sigma\>|^><rsup|\<mu\>>-<frac|1|2><wide|\<sigma\>|^><rsup|\<mu\>><around*|(|1-<wide|\<sigma\>|^><rsup|\<mu\>>|)><around*|(|1-2<wide|\<sigma\>|^><rsup|\<mu\>>|)>W<rsub|\<mu\>\<mu\>>|}>>>|<row|<cell|>|<cell|\<times\><around*|{|1-<wide|\<sigma\>|^><rsup|\<mu\>>+<frac|1|2><wide|\<sigma\>|^><rsup|\<mu\>><around*|(|1-<wide|\<sigma\>|^><rsup|\<mu\>>|)><around*|(|1-2<wide|\<sigma\>|^><rsup|\<mu\>>|)>W<rsub|\<mu\>\<mu\>>|}>>>|<row|<cell|>|<cell|\<times\><around*|{|1+<around*|[|2<around*|(|\<sigma\><rsup|\<mu\>>|)><rsup|2>-2\<sigma\><rsup|\<mu\>>+<frac|1|2>|]>W<rsub|\<mu\>\<mu\>>|}>>>|<row|<cell|=>|<cell|\<sigma\><rsup|\<mu\>>
        <around*|(|1-\<sigma\><rsup|\<mu\>>|)>+<with|math-font|cal|O><around*|(|W<rsup|2>|)>,>>>>
      </align>

      where we have employed

      <\align>
        <tformat|<table|<row|<cell|<wide|\<sigma\>|^><rsup|\<gamma\>>=>|<cell|\<sigma\><rsup|\<gamma\>>+<frac|1|2><around*|(|1-2\<sigma\><rsup|\<gamma\>>|)>W<rsub|\<alpha\>\<gamma\>>\<delta\><rsup|\<alpha\>\<gamma\>>\<sigma\><rsup|\<gamma\>><around*|(|1-\<sigma\><rsup|\<gamma\>>|)>>>|<row|<cell|=>|<cell|\<sigma\><rsup|\<gamma\>>+<frac|1|2>\<sigma\><rsup|\<gamma\>><around*|(|1-\<sigma\><rsup|\<gamma\>>|)><around*|(|1-2\<sigma\><rsup|\<gamma\>>|)>W<rsub|\<gamma\>\<gamma\>>.>>>>
      </align>

      Thus

      <\equation*>
        \<sigma\><rsup|\<mu\>> <around*|(|1-\<sigma\><rsup|\<mu\>>|)>=<wide|W|^><rsup|\<mu\>\<mu\>>.
      </equation*>

      After solving this equation, we have

      <\align>
        <tformat|<table|<row|<cell|<wide|\<sigma\>|^><rsup|\<gamma\>>=>|<cell|\<sigma\><rsup|\<gamma\>>+<frac|1|2>W<rsub|\<gamma\>\<gamma\>><around*|[|\<sigma\><rsup|\<gamma\>><around*|(|1-\<sigma\><rsup|\<gamma\>>|)><rsup|2>-\<sigma\><rsup|\<gamma\>2><around*|(|1-\<sigma\><rsup|\<gamma\>>|)>|]>>>|<row|<cell|=>|<cell|\<sigma\><rsup|\<gamma\>>+<frac|1|2>W<rsub|\<gamma\>\<gamma\>><around*|[|\<sigma\><rsup|\<gamma\>><around*|(|1-\<sigma\><rsup|\<gamma\>>|)><rsup|2>-\<sigma\><rsup|\<gamma\>2><around*|(|1-\<sigma\><rsup|\<gamma\>>|)>|]>>>|<row|<cell|=>|<cell|\<sigma\><rsup|\<gamma\>>+<frac|1|2>W<rsub|\<gamma\>\<gamma\>><around*|[|<wide|W|^><rsup|\<gamma\>\<gamma\>><around*|(|1-\<sigma\><rsup|\<gamma\>>|)>-\<sigma\><rsup|\<gamma\>><wide|W|^><rsup|\<gamma\>\<gamma\>>|]>>>|<row|<cell|=>|<cell|\<sigma\><rsup|\<gamma\>>+W<rsub|\<gamma\>\<gamma\>><around*|[|<wide|W|^><rsup|\<gamma\>\<gamma\>><around*|(|<frac|1|2>-\<sigma\><rsup|\<gamma\>>|)>|]>.>>>>
      </align>

      <\equation*>
        W<rsub|\<mu\>\<mu\>>=<frac|<wide|\<sigma\>|^><rsup|\<mu\>>-\<sigma\><rsup|\<mu\>>|0.5-\<sigma\><rsup|\<mu\>>><frac|1|<wide|W|^><rsup|\<mu\>\<mu\>>>.
      </equation*>
    </footnote>

    <\equation>
      \<forall\>\<mu\>,\<sigma\><rsup|\<mu\>>
      <around*|(|1-\<sigma\><rsup|\<mu\>>|)>=<wide|W|^><rsup|\<mu\>\<mu\>>;
    </equation>

    <\equation*>
      \<forall\>\<mu\>\<neq\>\<nu\>,W<rsub|\<mu\>\<nu\>>=<frac|<wide|W|^><rsup|\<mu\>\<nu\>>|<wide|\<sigma\>|^><rsup|\<mu\>><around*|(|1-<wide|\<sigma\>|^><rsup|\<mu\>>|)>
      <wide|\<sigma\>|^><rsup|\<nu\>><around*|(|1-<wide|\<sigma\>|^><rsup|\<nu\>>|)>>;
    </equation*>

    <\equation*>
      \<forall\>\<mu\>,W<rsub|\<mu\>\<mu\>>=<frac|<wide|\<sigma\>|^><rsup|\<mu\>>-\<sigma\><rsup|\<mu\>>|0.5-\<sigma\><rsup|\<mu\>>><frac|1|<wide|W|^><rsup|\<mu\>\<mu\>>>.
    </equation*>

    (Notice that, generally, <math|<wide|W|^><rsup|\<mu\>\<mu\>>=<with|math-font|cal|O><around*|(|1|)>>.)
  </theorem>
</body>

<initial|<\collection>
</collection>>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|?>>
    <associate|auto-2|<tuple|2|?>>
    <associate|auto-3|<tuple|3|?>>
    <associate|auto-4|<tuple|4|?>>
    <associate|auto-5|<tuple|4.1|?>>
    <associate|footnote-1|<tuple|1|?>>
    <associate|footnote-10|<tuple|10|?>>
    <associate|footnote-11|<tuple|11|?>>
    <associate|footnote-12|<tuple|12|?>>
    <associate|footnote-2|<tuple|2|?>>
    <associate|footnote-3|<tuple|3|?>>
    <associate|footnote-4|<tuple|4|?>>
    <associate|footnote-5|<tuple|5|?>>
    <associate|footnote-6|<tuple|6|?>>
    <associate|footnote-7|<tuple|7|?>>
    <associate|footnote-8|<tuple|8|?>>
    <associate|footnote-9|<tuple|9|?>>
    <associate|footnr-1|<tuple|1|?>>
    <associate|footnr-10|<tuple|10|?>>
    <associate|footnr-11|<tuple|11|?>>
    <associate|footnr-12|<tuple|12|?>>
    <associate|footnr-2|<tuple|2|?>>
    <associate|footnr-3|<tuple|3|?>>
    <associate|footnr-4|<tuple|4|?>>
    <associate|footnr-5|<tuple|5|?>>
    <associate|footnr-6|<tuple|6|?>>
    <associate|footnr-7|<tuple|7|?>>
    <associate|footnr-8|<tuple|8|?>>
    <associate|footnr-9|<tuple|9|?>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Energy-based
      Model> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|2<space|2spc>Effective
      Theory> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|3<space|2spc>Examples>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-3><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|4<space|2spc>Perturbation
      Theory> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-4><vspace|0.5fn>

      <with|par-left|<quote|1tab>|4.1<space|2spc>Perturbation of Boltzmann
      Machine <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-5>>
    </associate>
  </collection>
</auxiliary>
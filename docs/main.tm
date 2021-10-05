<TeXmacs|1.99.10>

<style|article>

<\body>
  <section|Energy-based Model>

  <\definition>
    [Energy-based Model]

    Let <math|<with|math-font|cal|M>> a measure space, and
    <math|E:\<bbb-R\><rsup|m>\<rightarrow\><around*|(|<with|math-font|cal|M>\<rightarrow\>\<bbb-R\>|)>>.
    Then define probabilitic model based on <math|E> as

    <\equation>
      p<rsub|E><around*|(|x;\<theta\>|)>=<frac|exp<around*|(|-E<around*|(|x;\<theta\>|)>|)>|<big|int><rsub|<with|math-font|cal|M>>\<mathd\>x<rprime|'>
      exp<around*|(|-E<around*|(|x<rprime|'>;\<theta\>|)>|)>>,
    </equation>

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

    <\equation>
      E<rsub|q><around*|(|x|)>\<assign\>-ln q<around*|(|x|)>+C,
    </equation>

    then, for <math|\<forall\>x\<in\>supp<around*|(|q|)>>,

    <\equation>
      q<around*|(|x|)>=<frac|exp<around*|(|-E<rsub|q><around*|(|x|)>|)>|<big|int><rsub|supp<around*|(|q|)>>\<mathd\>x<rprime|'>
      exp<around*|(|-E<rsub|q><around*|(|x<rprime|'>|)>|)>>.
    </equation>

    That is, for any probability density, there exists an energy function (up
    to constant) that can describe the probability density.
  </theorem>

  <\theorem>
    [Maximum Entropy Principle]

    For any probability density <math|p<rsub|D>:<with|math-font|cal|M>\<rightarrow\>\<bbb-R\>>,
    we have

    <\equation>
      p<rsub|E><around*|(|x|)>=argmax<rsub|p> H<around*|[|X|]>,
    </equation>

    s.t. contrains

    <\equation>
      \<bbb-E\><rsub|x\<sim\>p<rsub|D>><around*|[|<frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|x;\<theta\>|)>|]>=\<bbb-E\><rsub|x\<sim\>p><around*|[|<frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|x;\<theta\>|)>|]>
    </equation>

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

    <\equation>
      <frac|\<partial\>L|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|\<theta\>;p<rsub|D>|)>=<big|int><rsub|<with|math-font|cal|M>>\<mathd\>x
      p<rsub|D><around*|(|x|)> <frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|x;\<theta\>|)>-<big|int><rsub|<with|math-font|cal|M>>\<mathd\>x
      p<rsub|E><around*|(|x;\<theta\>|)> <frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|x;\<theta\>|)>,
    </equation>

    or in more compact format,

    <\equation>
      <frac|\<partial\>L|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|\<theta\>;p<rsub|D>|)>=\<bbb-E\><rsub|x\<sim\>p<rsub|D>><around*|[|<frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|x;\<theta\>|)>|]>-\<bbb-E\><rsub|x\<sim\>p<around*|(|x;\<theta\>|)>><around*|[|<frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|x;\<theta\>|)>|]>.
    </equation>
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

    <\equation>
      E<rsub|eff><around*|(|v;\<theta\>|)>\<assign\>-ln
      <big|int><rsub|<with|math-font|cal|H>>\<mathd\>h
      exp<around*|(|-E<around*|(|v,h;\<theta\>|)>|)>.
    </equation>
  </definition>

  <\theorem>
    [Effective Theory]

    Recall that <math|p<around*|(|v;\<theta\>|)>\<assign\><big|int><rsub|<with|math-font|cal|H>>\<mathd\>h
    p<around*|(|v,h;\<theta\>|)>>. Then,

    <\equation>
      p<around*|(|v;\<theta\>|)>=<frac|exp<around*|(|-E<rsub|eff><around*|(|v;\<theta\>|)>|)>|<big|int><rsub|<with|math-font|cal|V>>\<mathd\>v<rprime|'>
      exp<around*|(|-E<rsub|eff><around*|(|v<rprime|'>;\<theta\>|)>|)>>.
    </equation>
  </theorem>

  <\lemma>
    [Gradient of Effective Energy]

    <\equation>
      <frac|\<partial\>E<rsub|eff>|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|v,\<theta\>|)>=<big|int><rsub|<with|math-font|cal|H>>\<mathd\>h
      p<around*|(|h\|v;\<theta\>|)> <frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|v,h;\<theta\>|)>.
    </equation>
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

    <\equation>
      <frac|\<partial\>L|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|\<theta\>;p<rsub|D>|)>=\<bbb-E\><rsub|v\<sim\>p<rsub|D>,h\<sim\>p<around*|(|h\|v;\<theta\>|)>><around*|[|<frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|v,h;\<theta\>|)>|]>-\<bbb-E\><rsub|v,h\<sim\>p<around*|(|v,h;\<theta\>|)>><around*|[|<frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|v,h;\<theta\>|)>|]>.
    </equation>
  </theorem>

  <section|Examples>

  <\example>
    [Boltzmann Machine]

    <\itemize>
      <item>Let <math|<with|math-font|cal|M>=<around*|{|0,1|}><rsup|n>>,
      <math|W\<in\>\<bbb-R\><rsup|<around*|(|n\<times\>n|)>>>,
      <math|b\<in\>\<bbb-R\><rsup|n>>, <math|\<theta\>\<assign\><around*|(|W,b|)>>.
      Given dataset <math|D\<assign\><around*|{|x<rsub|i>\|x<rsub|i>\<in\><with|math-font|cal|M>,i=1,\<ldots\>,N|}>>,
      denote expectation as <math|<wide|x|^><rsup|\<alpha\>>>. Then a
      Boltzmann machine is defined by energy function

      <\equation>
        E<around*|(|x;W,b|)>\<assign\>-<frac|1|2>
        <big|sum><rsub|\<alpha\>,\<beta\>>W<rsub|\<alpha\>\<beta\>>
        <around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)>
        <around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>-<big|sum><rsub|\<alpha\>>b<rsub|\<alpha\>>
        x<rsup|\<alpha\>>.
      </equation>

      <item>Direct calculation gives, for <math|\<forall\>\<alpha\>>,

      <\equation>
        p<around*|(|x<rsub|\<alpha\>>=1\|x<rsub|\\\<alpha\>>|)>=\<sigma\><around*|(|<big|sum><rsub|\<alpha\>\<neq\>\<beta\>>W<rsub|<around*|(|\<alpha\>\<beta\>|)>><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>+c<rsub|\<alpha\>>|)>,
      </equation>

      where <math|W<rsub|<around*|(|\<alpha\>\<beta\>|)>>\<assign\><around*|(|W<rsub|\<alpha\>\<beta\>>+W<rsub|\<beta\>\<alpha\>>|)>/2>
      and <math|c<rsub|\<alpha\>>\<assign\>b<rsub|\<alpha\>>+<around*|(|1/2
      -<wide|x|^><rsup|\<alpha\>>|)>W<rsub|\<alpha\>\<alpha\>>>. This
      relation is held even for arbitrary vector <math|<wide|x|^>>.

      <item>Relating to MaxEnt principle, the observable that the model
      simulates is

      <\equation>
        \<forall\><around*|(|\<alpha\>,\<beta\>|)>,\<bbb-E\><rsub|x\<sim\>P<rsub|D>><around*|[|<around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>|]>,
      </equation>

      for which it shall also simulate

      <\equation>
        \<forall\>\<alpha\>,\<bbb-E\><rsub|x\<sim\>P<rsub|D>><around*|[|<wide|x|^><rsup|\<alpha\>>|]>.
      </equation>
    </itemize>
  </example>

  <\proof>
    Here we proof the activity rule.

    Directly, for <math|\<forall\>\<gamma\>>,

    <\align>
      <tformat|<table|<row|<cell|>|<cell|ln
      p<around*|(|x<rsub|\<gamma\>>=1\|x<rsub|\\\<gamma\>>|)>-ln
      p<around*|(|x<rsub|\<gamma\>>=0\|x<rsub|\\\<gamma\>>|)>>>|<row|<cell|<around*|{|\<alpha\>=\<beta\>=\<gamma\>|}>=>|<cell|<frac|1|2>
      W<rsub|\<gamma\>\<gamma\>> <around*|(|1-<wide|x|^><rsup|\<gamma\>>|)><rsup|2>-<frac|1|2>
      W<rsub|\<gamma\>\<gamma\>> <around*|(|-<wide|x|^><rsup|\<gamma\>>|)><rsup|2>>>|<row|<cell|<around*|{|\<alpha\>\<neq\>\<gamma\>,\<beta\>=\<gamma\>|}>>|<cell|+<frac|1|2><big|sum><rsub|\<alpha\>\<neq\>\<gamma\>>W<rsub|\<alpha\>\<gamma\>><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|1-<wide|x|^><rsup|\<gamma\>>|)>-<frac|1|2><big|sum><rsub|\<alpha\>\<neq\>\<gamma\>>W<rsub|\<alpha\>\<gamma\>><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|-<wide|x|^><rsup|\<gamma\>>|)>>>|<row|<cell|<around*|{|\<alpha\>=\<gamma\>,b\<neq\>\<gamma\>|}>>|<cell|+<frac|1|2><big|sum><rsub|\<beta\>\<neq\>\<gamma\>>W<rsub|\<gamma\>\<beta\>><around*|(|1-<wide|x|^><rsup|\<gamma\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>-<frac|1|2><big|sum><rsub|\<beta\>\<neq\>\<gamma\>>W<rsub|\<gamma\>\<beta\>><around*|(|-<wide|x|^><rsup|\<gamma\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>>>|<row|<cell|<around*|{|\<alpha\>,\<beta\>\<neq\>\<gamma\>|}>>|<cell|+<frac|1|2><big|sum><rsub|\<alpha\>,\<beta\>\<neq\>\<gamma\>>W<rsub|\<alpha\>\<beta\>><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>-<frac|1|2><big|sum><rsub|\<alpha\>,\<beta\>\<neq\>\<gamma\>>W<rsub|\<alpha\>\<beta\>><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>>>|<row|<cell|<around*|{|\<alpha\>=\<gamma\>|}>>|<cell|+b<rsup|\<gamma\>>-0>>|<row|<cell|<around*|{|\<alpha\>\<neq\>\<gamma\>|}>>|<cell|+<big|sum><rsub|\<alpha\>\<neq\>\<gamma\>>b<rsub|\<gamma\>>x<rsup|\<gamma\>>-<big|sum><rsub|\<alpha\>\<neq\>\<gamma\>>b<rsub|\<gamma\>>x<rsup|\<gamma\>>>>|<row|<cell|=>|<cell|<frac|1|2>
      W<rsub|\<gamma\>\<gamma\>>-W<rsub|\<gamma\>\<gamma\>><wide|x|^><rsup|\<gamma\>>>>|<row|<cell|>|<cell|+<frac|1|2><big|sum><rsub|\<alpha\>\<neq\>\<gamma\>>W<rsub|\<alpha\>\<gamma\>><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)>>>|<row|<cell|>|<cell|+<frac|1|2><big|sum><rsub|\<beta\>\<neq\>\<gamma\>>W<rsub|\<gamma\>\<beta\>><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>>>|<row|<cell|>|<cell|+0>>|<row|<cell|>|<cell|+b<rsub|\<gamma\>>>>|<row|<cell|>|<cell|+0>>|<row|<cell|=>|<cell|<around*|(|<frac|1|2>
      -<wide|x|^><rsup|\<gamma\>>|)>W<rsub|\<gamma\>\<gamma\>>+<big|sum><rsub|\<alpha\>\<neq\>\<gamma\>>W<rsub|<around*|(|\<gamma\>\<alpha\>|)>><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)>+b<rsub|\<gamma\>>>>>>
    </align>

    Thus

    <\equation*>
      p<around*|(|x<rsub|\<gamma\>>=1\|x<rsub|\\\<gamma\>>|)>=\<sigma\><around*|[|<big|sum><rsub|\<alpha\>\<neq\>\<gamma\>><frac|1|2><around*|(|W<rsub|\<alpha\>\<gamma\>>+W<rsub|\<gamma\>\<alpha\>>|)><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)>+<around*|(|b<rsub|\<gamma\>>+<around*|(|<frac|1|2>
      -<wide|x|^><rsup|\<gamma\>>|)>W<rsub|\<gamma\>\<gamma\>>|)>|]>.
    </equation*>
  </proof>

  <\example>
    [Restricted Boltzmann Machine]

    <\itemize>
      <item>Let <math|<with|math-font|cal|V>=<around*|{|0,1|}><rsup|n>> and
      <math|<with|math-font|cal|H>=<around*|{|0,1|}><rsup|m>>,
      <math|<with|math-font|cal|M>=<with|math-font|cal|V>\<times\><with|math-font|cal|H>>.
      Let <math|U\<in\>\<bbb-R\><rsup|<around*|(|n\<times\>m|)>>>,
      <math|b\<in\>\<bbb-R\><rsup|n>>, <math|c\<in\>\<bbb-R\><rsup|m>>. Then
      a restricted Boltzmann machine is defined by energy function<\footnote>
        We use latin letters for latent variables.
      </footnote>

      <\equation>
        E<around*|(|v,h;U,b,c|)>\<assign\>-<big|sum><rsub|\<alpha\>,i>U<rsub|\<alpha\>i>
        <around*|(|v<rsup|\<alpha\>>-<wide|v|^><rsup|\<alpha\>>|)><around*|(|h<rsup|i>-<wide|h|^><rsup|i>|)>-<big|sum><rsub|\<alpha\>>b<rsub|\<alpha\>>
        v<rsup|\<alpha\>>-<big|sum><rsub|i>c<rsub|i> h<rsup|i>.
      </equation>

      <item>Direct calculation gives

      <\equation>
        E<rsub|eff><around*|(|v;U,b,c|)>=<big|sum><rsub|\<alpha\>><around*|(|<big|sum><rsub|i>U<rsub|\<alpha\>i>
        v<rsup|\<alpha\>><wide|h|^><rsup|i>-b<rsub|\<alpha\>>v<rsup|\<alpha\>>|)>-<big|sum><rsub|i>s<rsub|+><around*|(|<big|sum><rsub|\<alpha\>>U<rsub|\<alpha\>i>
        <around*|(|v<rsup|\<alpha\>>-<wide|v|^><rsup|\<alpha\>>|)>+c<rsub|i>|)>,
      </equation>

      where soft-plus <math|s> is defined as

      <\equation>
        s<around*|(|x|)>\<assign\>ln<around*|(|1+\<mathe\><rsup|x>|)>.
      </equation>

      <item>Relating to Boltzmann machine,
      <math|x\<rightarrow\><around*|(|v,h|)>>,
      <math|b\<rightarrow\><around*|(|b,c|)>>, and

      <\equation>
        W\<rightarrow\><matrix|<tformat|<table|<row|<cell|0>|<cell|U>>|<row|<cell|U<rsup|T>>|<cell|0>>>>>.
      </equation>
    </itemize>
  </example>

  <\proof>
    Here we proof the expression of <math|E<rsub|eff><around*|(|v;U,b,c|)>>.

    Directly,

    <\align>
      <tformat|<table|<row|<cell|>|<cell|E<rsub|eff><around*|(|v|)>>>|<row|<cell|<text|{Definition}>=>|<cell|-ln
      <big|sum><rsub|h>exp<around*|(|-E<around*|(|v,h|)>|)>>>|<row|<cell|<text|{Definition}>=>|<cell|-ln<big|sum><rsub|h>exp<around*|(|<big|sum><rsub|\<alpha\>,i>U<rsub|\<alpha\>\<beta\>>
      <around*|(|v<rsup|\<alpha\>>-<wide|v|^><rsup|\<alpha\>>|)><around*|(|h<rsup|i>-<wide|h|^><rsup|i>|)>+<big|sum><rsub|\<alpha\>>b<rsub|\<alpha\>>
      v<rsup|\<alpha\>>+<big|sum><rsub|i>c<rsub|i>
      h<rsup|i>|)>>>|<row|<cell|<text|{Extract <math|b
      v>}>=>|<cell|-<big|sum><rsub|\<alpha\>>b<rsub|\<alpha\>>
      v<rsup|\<alpha\>>-ln<big|sum><rsub|h>exp<around*|[|<big|sum><rsub|\<alpha\>,i>U<rsub|\<alpha\>\<beta\>>
      <around*|(|v<rsup|\<alpha\>>-<wide|v|^><rsup|\<alpha\>>|)><around*|(|h<rsup|i>-<wide|h|^><rsup|i>|)>+<big|sum><rsub|i>c<rsub|i>
      h<rsup|i>|]>>>|<row|<cell|<text|{Combine}>=>|<cell|-<big|sum><rsub|\<alpha\>>b<rsub|\<alpha\>>
      v<rsup|\<alpha\>>-ln<big|sum><rsub|h>exp<around*|[|<big|sum><rsub|i><around*|(|<big|sum><rsub|\<alpha\>>U<rsub|\<alpha\>i>
      <around*|(|v<rsup|\<alpha\>>-<wide|v|^><rsup|\<alpha\>>|)>|)><around*|(|h<rsup|i>-<wide|h|^><rsup|i>|)>+<big|sum><rsub|i>c<rsub|i>
      h<rsup|i>|]>>>|<row|<cell|<around*|{|exp<big|sum>=<big|prod>exp|}>=>|<cell|-<big|sum><rsub|\<alpha\>>b<rsub|\<alpha\>>
      v<rsup|\<alpha\>>-ln <big|prod><rsub|i>
      <big|sum><rsub|h<rsup|i>=0,1>exp<around*|(|<big|sum><rsub|\<alpha\>>U<rsub|\<alpha\>i>
      <around*|(|v<rsup|\<alpha\>>-<wide|v|^><rsup|\<alpha\>>|)><around*|(|h<rsup|i>-<wide|h|^><rsup|i>|)>+c<rsub|i>
      h<rsup|i>|)>>>|<row|<cell|<around*|{|ln<big|prod>=<big|sum>ln|}>=>|<cell|-<big|sum><rsub|\<alpha\>>b<rsub|\<alpha\>>
      v<rsup|\<alpha\>>-<big|sum><rsub|i>ln
      <big|sum><rsub|h<rsup|i>=0,1>exp<around*|(|<big|sum><rsub|\<alpha\>>U<rsub|\<alpha\>i>
      <around*|(|v<rsup|\<alpha\>>-<wide|v|^><rsup|\<alpha\>>|)><around*|(|h<rsup|i>-<wide|h|^><rsup|i>|)>+c<rsub|i>
      h<rsup|i>|)>.>>>>
    </align>

    Since

    <\align>
      <tformat|<table|<row|<cell|>|<cell|
      <big|sum><rsub|h<rsup|i>=0,1>exp<around*|(|<big|sum><rsub|\<alpha\>>U<rsub|\<alpha\>i>
      <around*|(|v<rsup|\<alpha\>>-<wide|v|^><rsup|\<alpha\>>|)><around*|(|h<rsup|i>-<wide|h|^><rsup|i>|)>+c<rsub|i>
      h<rsup|i>|)>>>|<row|<cell|=>|<cell|exp<around*|(|<big|sum><rsub|\<alpha\>>U<rsub|\<alpha\>i>
      <around*|(|v<rsup|\<alpha\>>-<wide|v|^><rsup|\<alpha\>>|)><around*|(|1-<wide|h|^><rsup|i>|)>+c<rsub|i>|)>+exp<around*|(|<big|sum><rsub|\<alpha\>>U<rsub|\<alpha\>i>
      <around*|(|v<rsup|\<alpha\>>-<wide|v|^><rsup|\<alpha\>>|)><around*|(|-<wide|h|^><rsup|i>|)>|)>>>|<row|<cell|<text|{Extract}>=>|<cell|exp<around*|(|<big|sum><rsub|\<alpha\>>U<rsub|\<alpha\>i>
      <around*|(|v<rsup|\<alpha\>>-<wide|v|^><rsup|\<alpha\>>|)><around*|(|-<wide|h|^><rsup|i>|)>|)><around*|[|exp<around*|(|<big|sum><rsub|\<alpha\>>U<rsub|\<alpha\>i>
      <around*|(|v<rsup|\<alpha\>>-<wide|v|^><rsup|\<alpha\>>|)>+c<rsub|i>|)>+1|]>,>>>>
    </align>

    we have

    <\align>
      <tformat|<table|<row|<cell|>|<cell|E<rsub|eff><around*|(|v|)>>>|<row|<cell|<text|{Previous}>=>|<cell|-<big|sum><rsub|\<alpha\>>b<rsub|\<alpha\>>
      v<rsup|\<alpha\>>-<big|sum><rsub|i>ln
      <big|sum><rsub|h<rsup|i>=0,1>exp<around*|(|<big|sum><rsub|\<alpha\>>U<rsub|\<alpha\>i>
      <around*|(|v<rsup|\<alpha\>>-<wide|v|^><rsup|\<alpha\>>|)><around*|(|h<rsup|i>-<wide|h|^><rsup|i>|)>+c<rsub|i>
      h<rsup|i>|)>>>|<row|<cell|<text|{Plugin}>=>|<cell|-<big|sum><rsub|\<alpha\>>b<rsub|\<alpha\>>
      v<rsup|\<alpha\>>+<big|sum><rsub|i><big|sum><rsub|\<alpha\>>U<rsub|\<alpha\>i>
      <around*|(|v<rsup|\<alpha\>>-<wide|v|^><rsup|\<alpha\>>|)><wide|h|^><rsup|i>>>|<row|<cell|>|<cell|-<big|sum><rsub|i>ln<around*|[|exp<around*|(|<big|sum><rsub|\<alpha\>>U<rsub|\<alpha\>i>
      <around*|(|v<rsup|\<alpha\>>-<wide|v|^><rsup|\<alpha\>>|)>+c<rsub|i>|)>+1|]>>>|<row|<cell|<around*|{|s<around*|(|x|)>\<assign\>\<cdots\>|}>=>|<cell|-<big|sum><rsub|\<alpha\>>b<rsub|\<alpha\>>
      v<rsup|\<alpha\>>+<big|sum><rsub|\<alpha\>,i>U<rsub|\<alpha\>i>
      <around*|(|v<rsup|\<alpha\>>-<wide|v|^><rsup|\<alpha\>>|)><wide|h|^><rsup|i>-<big|sum><rsub|i>s<around*|(|<big|sum><rsub|\<alpha\>>U<rsub|\<alpha\>i>
      <around*|(|v<rsup|\<alpha\>>-<wide|v|^><rsup|\<alpha\>>|)>+c<rsub|i>|)>>>|<row|<cell|<text|{Extract
      <math|Const>}>=>|<cell|-<big|sum><rsub|\<alpha\>>b<rsub|\<alpha\>>
      v<rsup|\<alpha\>>+<big|sum><rsub|\<alpha\>,i>U<rsub|\<alpha\>i>
      v<rsup|\<alpha\>><wide|h|^><rsup|i>-<big|sum><rsub|i>s<around*|(|<big|sum><rsub|\<alpha\>>U<rsub|\<alpha\>i>
      <around*|(|v<rsup|\<alpha\>>-<wide|v|^><rsup|\<alpha\>>|)>+c<rsub|i>|)>+Const>>|<row|<cell|<text|{Combine}>=>|<cell|<big|sum><rsub|\<alpha\>><around*|(|<big|sum><rsub|i>U<rsub|\<alpha\>i>
      v<rsup|\<alpha\>><wide|h|^><rsup|i>-b<rsub|\<alpha\>>v<rsup|\<alpha\>>|)>-<big|sum><rsub|i>s<around*|(|<big|sum><rsub|\<alpha\>>U<rsub|\<alpha\>i>
      <around*|(|v<rsup|\<alpha\>>-<wide|v|^><rsup|\<alpha\>>|)>+c<rsub|i>|)>+Const.>>>>
    </align>

    \ The constant, which will be eliminated by <math|Z>, can be omitted.
  </proof>

  <section|Perturbation Theory>

  <subsection|Perturbation of Boltzmann Machine>

  Define <math|p<rsub|i><around*|(|x|)>> by Taylor expansion
  <math|p<rsub|E><around*|(|x|)>=p<rsub|0><around*|(|x|)>+p<rsub|1><around*|(|x|)>+\<cdots\>+p<rsub|n><around*|(|x|)>+<with|math-font|cal|O><around*|(|W<rsup|n+1>|)>>.
  Denote <math|\<sigma\><rsub|\<alpha\>>\<assign\>\<sigma\><around*|(|b<rsub|\<alpha\>>|)>>.

  <subsubsection|0th-order>

  <\lemma>
    [0th-order of Boltzmann Machine]

    We have

    <\equation>
      p<rsub|0><around*|(|x|)>=<big|prod><rsub|\<alpha\>>p<rsub|\<alpha\>><around*|(|x<rsup|\<alpha\>>|)>,
    </equation>

    where

    <\equation>
      p<rsub|\<alpha\>><around*|(|x|)>\<assign\><frac|exp<around*|(|b<rsub|\<alpha\>>
      x|)>|1+exp<around*|(|b<rsub|\<alpha\>>|)>>.
    </equation>
  </lemma>

  <\proof>
    Since <math|E<rsub|0><around*|(|x;W,b|)>\<assign\>-<big|sum><rsub|\<alpha\>>b<rsub|\<alpha\>>
    x<rsup|\<alpha\>>>,

    <\align>
      <tformat|<table|<row|<cell|p<rsub|0><around*|(|x|)>=>|<cell|<frac|exp<around*|(|<big|sum><rsub|\<alpha\>>b<rsub|\<alpha\>>
      x<rsup|\<alpha\>>|)>|<big|sum><rsub|x<rprime|'><rsup|1>\<in\><around*|{|0,1|}>>\<cdots\><big|sum><rsub|x<rprime|'><rsup|n>\<in\><around*|{|0,1|}>>exp<around*|(|<big|sum><rsub|\<alpha\>>b<rsub|\<alpha\>>
      x<rprime|'><rsup|\<alpha\>>|)>>>>|<row|<cell|=>|<cell|<big|prod><rsub|\<alpha\>><frac|exp<around*|(|b<rsub|\<alpha\>>
      x<rsup|\<alpha\>>|)>|<big|sum><rsub|x<rprime|'><rsup|\<alpha\>>\<in\><around*|{|0,1|}>>exp<around*|(|b<rsub|\<alpha\>>
      x<rprime|'><rsup|\<alpha\>>|)>>>>|<row|<cell|=>|<cell|<big|prod><rsub|\<alpha\>><frac|exp<around*|(|b<rsub|\<alpha\>>
      x<rsup|\<alpha\>>|)>|1+exp<around*|(|b<rsub|\<alpha\>>|)>>>>|<row|<cell|=>|<cell|<big|prod><rsub|\<alpha\>>p<rsub|\<alpha\>><around*|(|x|)>.>>>>
    </align>
  </proof>

  <\lemma>
    We have

    <\equation>
      <frac|\<partial\>p<rsub|\<alpha\>>|\<partial\>b<rsub|\<alpha\>>><around*|(|x|)>=p<rsub|\<alpha\>><around*|(|x|)><around*|(|x-\<sigma\><rsub|\<alpha\>>|)>.
    </equation>
  </lemma>

  <\proof>
    Directly,

    <\align>
      <tformat|<table|<row|<cell|<frac|\<partial\>|\<partial\>b<rsub|\<alpha\>>>p<rsub|\<alpha\>><around*|(|x|)>=>|<cell|<frac|\<partial\>|\<partial\>b<rsub|\<alpha\>>><frac|exp<around*|(|b<rsub|\<alpha\>>
      x|)>|1+exp<around*|(|b<rsub|\<alpha\>>|)>>>>|<row|<cell|=>|<cell|<frac|exp<around*|(|b<rsub|\<alpha\>>
      x|)>x|1+exp<around*|(|b<rsub|\<alpha\>>|)>>-<frac|exp<around*|(|b<rsub|\<alpha\>>
      x|)><around*|[|exp<around*|(|b<rsub|\<alpha\>>|)>|]>|<around*|[|1+exp<around*|(|b<rsub|\<alpha\>>|)>|]><rsup|2>>>>|<row|<cell|=>|<cell|<frac|exp<around*|(|b<rsub|\<alpha\>>
      x|)>|1+exp<around*|(|b<rsub|\<alpha\>>|)>><around*|[|x-<frac|exp<around*|(|b<rsub|\<alpha\>>|)>|1+exp<around*|(|b<rsub|\<alpha\>>|)>>|]>>>|<row|<cell|=>|<cell|p<rsub|\<alpha\>><around*|(|x|)><around*|(|x-\<sigma\><around*|(|b<rsub|\<alpha\>>|)>|)>.>>>>
    </align>
  </proof>

  <\lemma>
    For <math|\<forall\>\<alpha\>>, the mean of <math|p<rsub|\<alpha\>>>
    <math|V<rsup|\<alpha\>>\<assign\><big|sum><rsub|x>p<rsub|0><around*|(|x|)>
    x<rsup|\<alpha\>>> is

    <\equation>
      V<rsup|\<alpha\>>=\<sigma\><rsup|\<alpha\>>.
    </equation>
  </lemma>

  <\proof>
    Since <math|<around*|(|\<partial\>p<rsub|\<alpha\>>/\<partial\>b<rsub|\<alpha\>>|)><around*|(|x|)>=p<rsub|\<alpha\>><around*|(|x|)><around*|(|x-\<sigma\><around*|(|b<rsub|\<alpha\>>|)>|)>>,

    <\align>
      <tformat|<table|<row|<cell|<big|sum><rsub|x><frac|\<partial\>|\<partial\>b<rsub|\<alpha\>>>p<rsub|\<alpha\>><around*|(|x|)>=>|<cell|<big|sum><rsub|x>p<rsub|\<alpha\>><around*|(|x|)>x-<big|sum><rsub|x>p<rsub|\<alpha\>><around*|(|x|)>\<sigma\><around*|(|b<rsub|\<alpha\>>|)>>>|<row|<cell|<frac|\<partial\>|\<partial\>b<rsub|\<alpha\>>><big|sum><rsub|x>p<rsub|\<alpha\>><around*|(|x|)>=>|<cell|<big|sum><rsub|x>p<rsub|\<alpha\>><around*|(|x|)>x-<around*|(|<big|sum><rsub|x>p<rsub|\<alpha\>><around*|(|x|)>|)>\<sigma\><around*|(|b<rsub|\<alpha\>>|)>>>|<row|<cell|0=>|<cell|<big|sum><rsub|x>p<rsub|\<alpha\>><around*|(|x|)>x-\<sigma\><around*|(|b<rsub|\<alpha\>>|)>.>>>>
    </align>
  </proof>

  <\lemma>
    Variance <math|V<rsup|\<alpha\><rsub|1>\<alpha\><rsub|2>>\<assign\><big|sum><rsub|x>p<rsub|0><around*|(|x|)>
    <big|prod><rsub|i=1><rsup|2><around*|(|x-\<sigma\><rsup|\<alpha\><rsub|i>>|)>>
    is

    <\equation>
      V<rsup|\<alpha\><rsub|1>\<alpha\><rsub|2>>=V<rsub|c><rsup|\<alpha\><rsub|1>\<alpha\><rsub|2>>.
    </equation>

    where

    <\equation>
      V<rsub|c><rsup|\<alpha\><rsub|1>\<alpha\><rsub|2>>\<assign\>\<delta\><rsup|\<alpha\><rsub|1>\<alpha\><rsub|2>>\<sigma\><rsup|a<rsub|1>><around*|(|1-\<sigma\><rsup|\<alpha\><rsub|1>>|)>.
    </equation>
  </lemma>

  <\proof>
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
  </proof>

  <\lemma>
    3-momentum <math|V<rsup|\<alpha\><rsub|1>\<alpha\><rsub|2>\<alpha\><rsub|3>>\<assign\><big|sum><rsub|x>p<rsub|0><around*|(|x|)>
    <big|prod><rsub|i=1><rsup|3><around*|(|x-\<sigma\><rsup|\<alpha\><rsub|i>>|)>>
    is

    <\equation>
      V<rsup|\<alpha\><rsub|1>\<alpha\><rsub|2>\<alpha\><rsub|3>>=V<rsub|c><rsup|\<alpha\><rsub|1>\<alpha\><rsub|2>\<alpha\><rsub|3>>,
    </equation>

    where

    <\equation>
      V<rsub|c><rsup|\<alpha\><rsub|1>\<alpha\><rsub|2>\<alpha\><rsub|3>>\<assign\>\<delta\><rsup|\<alpha\><rsub|1>\<alpha\><rsub|2>\<alpha\><rsub|3>>\<sigma\><rsup|\<alpha\><rsub|1>><around*|(|1-\<sigma\><rsup|\<alpha\><rsub|1>>|)><around*|(|1-2\<sigma\><rsup|\<alpha\><rsub|1>>|)>.
    </equation>
  </lemma>

  <\lemma>
    4-momentum <math|V<rsup|\<alpha\><rsub|1>\<cdots\>\<alpha\><rsub|4>>\<assign\><big|sum><rsub|x>p<rsub|0><around*|(|x|)>
    <big|prod><rsub|i=1><rsup|4><around*|(|x-\<sigma\><rsup|\<alpha\><rsub|i>>|)>>
    is

    <\equation>
      V<rsup|\<alpha\><rsub|1>\<cdots\>\<alpha\><rsub|4>>=V<rsub|c><rsup|\<alpha\><rsub|1>\<cdots\>\<alpha\><rsub|4>>+<big|sum><rsub|<text|all
      pairs>>V<rsup|\<alpha\><rsub|m<rsub|1>>\<alpha\><rsub|m<rsub|2>>>
      V<rsup|\<alpha\><rsub|n<rsub|1>>\<alpha\><rsub|n<rsub|2>>>,
    </equation>

    where \Pconnected\Q part

    <\equation>
      V<rsub|c><rsup|\<alpha\><rsub|1>\<cdots\>\<alpha\><rsub|4>>\<assign\>\<delta\><rsup|\<alpha\><rsub|1>\<cdots\>\<alpha\><rsub|4>>
      \<sigma\><rsup|\<alpha\><rsub|1>><around*|(|1-\<sigma\><rsup|\<alpha\><rsub|1>>|)>
      <around*|[|1-6 \<sigma\><rsup|\<alpha\><rsub|1>>+6
      <around*|(|\<sigma\><rsup|\<alpha\><rsub|1>>|)><rsup|2>|]>,
    </equation>

    and <math|<around*|(|m<rsub|1>,m<rsub|2>|)>,<around*|(|n<rsub|1>,n<rsub|2>|)>>
    runs over all (three) pairs.
  </lemma>

  <subsubsection|1st-order>

  <\lemma>
    For <math|\<forall\>\<alpha\>>,

    <\equation>
      <wide|x|^><rsup|\<alpha\>>=\<sigma\><rsup|\<alpha\>>+<with|math-font|cal|O><around*|(|W|)>.
    </equation>
  </lemma>

  <\proof>
    The gradient of loss gives

    <\align>
      <tformat|<table|<row|<cell|<wide|x|^><rsup|\<alpha\>>=>|<cell|<big|sum><rsub|x>p<rsub|E><around*|(|x|)>x<rsup|\<alpha\>>>>|<row|<cell|<around*|{|Tayor
      expand|}>=>|<cell|<big|sum><rsub|x>p<rsub|0><around*|(|x|)>x<rsup|\<alpha\>>+<with|math-font|cal|O><around*|(|W|)>>>|<row|<cell|<around*|{|<big|sum><rsub|x>p<rsub|0><around*|(|x|)>x<rsup|\<alpha\>>=\<sigma\><rsup|\<alpha\>>|}>=>|<cell|\<sigma\><rsup|\<alpha\>>+<with|math-font|cal|O><around*|(|W|)>.>>>>
    </align>
  </proof>

  <\theorem>
    \;

    <\equation>
      <frac|p<rsub|1><around*|(|x|)>|p<rsub|0><around*|(|x|)>>=<frac|1|2>W<rsub|\<alpha\>\<beta\>><around*|(|x<rsup|\<alpha\>>-\<sigma\><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-\<sigma\><rsup|\<beta\>>|)>-<frac|1|2>W<rsub|\<alpha\>\<beta\>>V<rsup|\<alpha\>\<beta\>>.
    </equation>
  </theorem>

  <\proof>
    Directly,

    <\align>
      <tformat|<table|<row|<cell|p<rsub|E><around*|(|x|)>=>|<cell|<frac|exp<around*|(|b<rsub|\<alpha\>>x<rsup|\<alpha\>>+<frac|1|2>W<rsub|\<alpha\>\<beta\>><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>|)>|Z>>>|<row|<cell|<text|{Extract
      <math|b<rsub|\<alpha\>>x<rsup|\<alpha\>>>}>=>|<cell|<frac|exp<around*|(|b<rsub|\<alpha\>>x<rsup|\<alpha\>>|)>
      exp<around*|(|<frac|1|2>W<rsub|\<alpha\>\<beta\>><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>|)>|Z>>>|<row|<cell|<text|{Expand
      to <math|<with|math-font|cal|O><around*|(|W|)>>}>=>|<cell|<frac|exp<around*|(|b<rsub|\<alpha\>>x<rsup|\<alpha\>>|)><around*|{|1+<frac|1|2>W<rsub|\<alpha\>\<beta\>><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>+\<cdots\>|}>|Z<rsub|0><around*|(|1+Z<rsub|1>+\<cdots\>|)>>>>|<row|<cell|<around*|{|p<rsub|0><around*|(|x|)>=\<cdots\>|}>=>|<cell|p<rsub|0><around*|(|x|)><frac|<around*|{|1+<frac|1|2>W<rsub|\<alpha\>\<beta\>><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>+\<cdots\>|}>|1+Z<rsub|1>+\<cdots\>>>>|<row|<cell|<around*|{|<frac|1|1+\<epsilon\>>\<sim\>1-\<epsilon\>|}>=>|<cell|p<rsub|0><around*|(|x|)><around*|{|1+<frac|1|2>W<rsub|\<alpha\>\<beta\>><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>+\<cdots\>|}><around*|{|1-Z<rsub|1>+\<cdots\>|}>>>|<row|<cell|<text|{Expand}>=>|<cell|p<rsub|0><around*|(|x|)><around*|{|1+<frac|1|2>W<rsub|\<alpha\>\<beta\>><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>-Z<rsub|1>+\<cdots\>|}>>>|<row|<cell|\<backassign\>>|<cell|p<rsub|0><around*|(|x|)>+p<rsub|1><around*|(|x|)>+\<cdots\>>>>>
    </align>

    Thus

    <\align>
      <tformat|<table|<row|<cell|<frac|p<rsub|1><around*|(|x|)>|p<rsub|0><around*|(|x|)>>=>|<cell|<frac|1|2>W<rsub|\<alpha\>\<beta\>><around*|(|x<rsup|\<alpha\>>-<wide|x|^><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-<wide|x|^><rsup|\<beta\>>|)>-Z<rsub|1>>>|<row|<cell|<around*|{|<wide|x|^><rsup|\<alpha\>>=\<sigma\><rsup|\<alpha\>>+<with|math-font|cal|O><around*|(|W|)>|}>=>|<cell|<frac|1|2>W<rsub|\<alpha\>\<beta\>><around*|(|x<rsup|\<alpha\>>-\<sigma\><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-\<sigma\><rsup|\<beta\>>|)>-Z<rsub|1>.>>>>
    </align>

    Now we compute <math|Z<rsub|1>>. Since

    <\align>
      <tformat|<table|<row|<cell|1=<big|sum><rsub|x>p<rsub|E><around*|(|x|)>=>|<cell|<big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|{|1+<frac|1|2>W<rsub|\<alpha\>\<beta\>><around*|(|x<rsup|\<alpha\>>-\<sigma\><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-\<sigma\><rsup|\<beta\>>|)>-Z<rsub|1>|}>>>|<row|<cell|<around*|{|<big|sum><rsub|x>p<rsub|0><around*|(|x|)>=1|}>=>|<cell|1+<frac|1|2>W<rsub|\<alpha\>\<beta\>><around*|[|<big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<alpha\>>-\<sigma\><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-\<sigma\><rsup|\<beta\>>|)>|]>-Z<rsub|1>>>|<row|<cell|<around*|{|V<rsup|\<alpha\>\<beta\>>\<assign\>\<cdots\>|}>=>|<cell|1+<frac|1|2>W<rsub|\<alpha\>\<beta\>>V<rsup|\<alpha\>\<beta\>>-Z<rsub|1>>>>>
    </align>

    we have

    <\align>
      <tformat|<table|<row|<cell|Z<rsub|1>=>|<cell|<frac|1|2>W<rsub|\<alpha\>\<beta\>>V<rsup|\<alpha\>\<beta\>>.>>>>
    </align>

    Then,

    <\align>
      <tformat|<table|<row|<cell|<frac|p<rsub|1><around*|(|x|)>|p<rsub|0><around*|(|x|)>>=>|<cell|<frac|1|2>W<rsub|\<alpha\>\<beta\>><around*|(|x<rsup|\<alpha\>>-\<sigma\><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-\<sigma\><rsup|\<beta\>>|)>-Z<rsub|1>>>|<row|<cell|<around*|{|Z<rsub|1>=\<cdots\>|}>=>|<cell|<frac|1|2>W<rsub|\<alpha\>\<beta\>><around*|(|x<rsup|\<alpha\>>-\<sigma\><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-\<sigma\><rsup|\<beta\>>|)>-<frac|1|2>W<rsub|\<alpha\>\<beta\>>V<rsup|\<alpha\>\<beta\>>.>>>>
    </align>
  </proof>

  <\theorem>
    Up to <math|<with|math-font|cal|O><around*|(|W|)>>, for
    <math|\<forall\>\<gamma\>>,

    <\equation>
      <big|sum><rsub|x>p<rsub|E><around*|(|x|)>x<rsup|\<gamma\>>=V<rsup|\<gamma\>>+<frac|1|2>W<rsub|\<alpha\>\<beta\>>V<rsup|\<alpha\>\<beta\>\<gamma\>>..
    </equation>
  </theorem>

  <\proof>
    Directly,

    <\align>
      <tformat|<table|<row|<cell|<big|sum><rsub|x>p<rsub|E><around*|(|x|)>x<rsup|\<gamma\>>=>|<cell|<big|sum><rsub|x>p<rsub|0><around*|(|x|)>x<rsup|\<gamma\>>+<big|sum><rsub|x>p<rsub|1><around*|(|x|)>x<rsup|\<gamma\>>>>|<row|<cell|<around*|{|p<rsub|1><around*|(|x|)>=\<cdots\>|}>=>|<cell|<big|sum><rsub|x>p<rsub|0><around*|(|x|)>x<rsup|\<gamma\>>+<big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|[|<frac|1|2>W<rsub|\<alpha\>\<beta\>><around*|(|x<rsup|\<alpha\>>-\<sigma\><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-\<sigma\><rsup|\<beta\>>|)>-<frac|1|2>W<rsub|\<alpha\>\<alpha\>>\<sigma\><rsup|\<alpha\>><around*|(|1-\<sigma\><rsup|\<alpha\>>|)>|]>x<rsup|\<gamma\>>>>|<row|<cell|<text|{Expand}>=>|<cell|<big|sum><rsub|x>p<rsub|0><around*|(|x|)>x<rsup|\<gamma\>>>>|<row|<cell|>|<cell|+<frac|1|2>W<rsub|\<alpha\>\<beta\>><big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<alpha\>>-\<sigma\><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-\<sigma\><rsup|\<beta\>>|)>x<rsup|\<gamma\>>>>|<row|<cell|>|<cell|-<frac|1|2>W<rsub|\<alpha\>\<beta\>>V<rsup|\<alpha\>\<beta\>><big|sum><rsub|x>p<rsub|0><around*|(|x|)>x<rsup|\<gamma\>>>>|<row|<cell|=>|<cell|<big|sum><rsub|x>p<rsub|0><around*|(|x|)>x<rsup|\<gamma\>>>>|<row|<cell|<text|{Combine}>>|<cell|+<frac|1|2>W<rsub|\<alpha\>\<beta\>><big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<alpha\>>-\<sigma\><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-\<sigma\><rsup|\<beta\>>|)><around*|(|x<rsup|\<gamma\>>-\<sigma\><rsup|\<gamma\>>|)>+<frac|1|2>W<rsub|\<alpha\>\<beta\>><big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<alpha\>>-\<sigma\><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-\<sigma\><rsup|\<beta\>>|)>\<sigma\><rsup|\<gamma\>>>>|<row|<cell|>|<cell|-<frac|1|2>W<rsub|\<alpha\>\<beta\>>V<rsup|\<alpha\>\<beta\>><big|sum><rsub|x>p<rsub|0><around*|(|x|)>x<rsup|\<gamma\>>>>|<row|<cell|=>|<cell|V<rsup|\<gamma\>>>>|<row|<cell|<around*|{|V<rsup|\<alpha\>\<beta\>>=\<cdots\>|}>>|<cell|+<frac|1|2>W<rsub|\<alpha\>\<beta\>>V<rsup|\<alpha\>\<beta\>\<gamma\>>+<frac|1|2>W<rsub|\<alpha\>\<beta\>>V<rsup|\<alpha\>\<beta\>>\<sigma\><rsup|\<gamma\>>>>|<row|<cell|>|<cell|-<frac|1|2>W<rsub|\<alpha\>\<beta\>>V<rsup|\<alpha\>\<beta\>>\<sigma\><rsup|\<gamma\>>>>|<row|<cell|=>|<cell|V<rsup|\<gamma\>>+<frac|1|2>W<rsub|\<alpha\>\<beta\>>V<rsup|\<alpha\>\<beta\>\<gamma\>>.>>>>
    </align>
  </proof>

  <\theorem>
    Up to <math|<with|math-font|cal|O><around*|(|W|)>>, for
    <math|\<forall\><around*|(|\<mu\>,\<nu\>|)>>,

    <\equation>
      <big|sum><rsub|x>p<rsub|E><around*|(|x|)><around*|(|x<rsup|\<mu\>>-<wide|x|^><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-<wide|x|^><rsup|\<nu\>>|)>=V<rsup|\<mu\>\<nu\>>+W<rsub|<around*|(|\<alpha\>\<beta\>|)>>V<rsup|\<alpha\>\<mu\>>V<rsup|\<beta\>\<nu\>>+<frac|1|2>W<rsub|\<alpha\>\<beta\>>V<rsub|c><rsup|\<alpha\>\<beta\>\<mu\>\<nu\>>.
    </equation>
  </theorem>

  <\proof>
    Directly,

    <\align>
      <tformat|<table|<row|<cell|>|<cell|<big|sum><rsub|x>p<rsub|E><around*|(|x|)><around*|(|x<rsup|\<mu\>>-<wide|x|^><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-<wide|x|^><rsup|\<nu\>>|)>>>|<row|<cell|<around*|{|p<rsub|E>=p<rsub|0>+p<rsub|1>|}>=>|<cell|<big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<mu\>>-<wide|x|^><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-<wide|x|^><rsup|\<nu\>>|)>+<big|sum><rsub|x>p<rsub|1><around*|(|x|)><around*|(|x<rsup|\<mu\>>-<wide|x|^><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-<wide|x|^><rsup|\<nu\>>|)>>>|<row|<cell|=>|<cell|<big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<mu\>>-<wide|x|^><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-<wide|x|^><rsup|\<nu\>>|)>>>|<row|<cell|<around*|{|p<rsub|1><around*|(|x|)>=\<cdots\>|}>>|<cell|+<big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|[|<frac|1|2>W<rsub|\<alpha\>\<beta\>><around*|(|x<rsup|\<alpha\>>-\<sigma\><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-\<sigma\><rsup|\<beta\>>|)>-<frac|1|2>W<rsub|\<alpha\>\<beta\>>V<rsup|\<alpha\>\<beta\>>|]><around*|(|x<rsup|\<mu\>>-<wide|x|^><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-<wide|x|^><rsup|\<nu\>>|)>>>|<row|<cell|=>|<cell|<big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<mu\>>-<wide|x|^><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-<wide|x|^><rsup|\<nu\>>|)>>>|<row|<cell|<text|{Expand}>>|<cell|+<frac|1|2>W<rsub|\<alpha\>\<beta\>><big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<alpha\>>-\<sigma\><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-\<sigma\><rsup|\<beta\>>|)><around*|(|x<rsup|\<mu\>>-<wide|x|^><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-<wide|x|^><rsup|\<nu\>>|)>>>|<row|<cell|>|<cell|-<frac|1|2>W<rsub|\<alpha\>\<beta\>>V<rsup|\<alpha\>\<beta\>><big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<mu\>>-<wide|x|^><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-<wide|x|^><rsup|\<nu\>>|)>>>|<row|<cell|<around*|{|<wide|x|^>=\<cdots\>|}>=>|<cell|<big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<mu\>>-\<sigma\><rsup|\<mu\>>-<frac|1|2>W<rsub|\<alpha\>\<beta\>>V<rsup|\<alpha\>\<beta\>\<mu\>>|)><around*|(|x<rsup|\<nu\>>-\<sigma\><rsup|\<nu\>>-<frac|1|2>W<rsub|\<alpha\>\<beta\>>V<rsup|\<alpha\>\<beta\>\<nu\>>|)>>>|<row|<cell|<around*|{|<wide|x|^><rsup|\<alpha\>>=\<sigma\><rsup|\<alpha\>>+<with|math-font|cal|O><around*|(|W|)>|}>>|<cell|+<frac|1|2>W<rsub|\<alpha\>\<beta\>><big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<alpha\>>-\<sigma\><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-\<sigma\><rsup|\<beta\>>|)><around*|(|x<rsup|\<mu\>>-\<sigma\><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-\<sigma\><rsup|\<nu\>>|)>>>|<row|<cell|<around*|{|<wide|x|^><rsup|\<alpha\>>=\<sigma\><rsup|\<alpha\>>+<with|math-font|cal|O><around*|(|W|)>|}>>|<cell|-<frac|1|2>W<rsub|\<alpha\>\<beta\>>V<rsup|\<alpha\>\<beta\>><big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<mu\>>-\<sigma\><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-\<sigma\><rsup|\<nu\>>|)>>>|<row|<cell|<text|{Expand}>=>|<cell|<big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<mu\>>-\<sigma\><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-\<sigma\><rsup|\<nu\>>|)>>>|<row|<cell|>|<cell|-<frac|1|2>W<rsub|\<alpha\>\<beta\>>V<rsup|\<alpha\>\<beta\>\<nu\>><big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<mu\>>-\<sigma\><rsup|\<mu\>>|)>>>|<row|<cell|>|<cell|-<frac|1|2>W<rsub|\<alpha\>\<beta\>>V<rsup|\<alpha\>\<beta\>\<mu\>><big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<nu\>>-\<sigma\><rsup|\<nu\>>|)>>>|<row|<cell|+>|<cell|<frac|1|2>W<rsub|\<alpha\>\<beta\>><big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<alpha\>>-\<sigma\><rsup|\<alpha\>>|)><around*|(|x<rsup|\<beta\>>-\<sigma\><rsup|\<beta\>>|)><around*|(|x<rsup|\<mu\>>-\<sigma\><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-\<sigma\><rsup|\<nu\>>|)>>>|<row|<cell|->|<cell|<frac|1|2>W<rsub|\<alpha\>\<beta\>>V<rsup|\<alpha\>\<beta\>><big|sum><rsub|x>p<rsub|0><around*|(|x|)><around*|(|x<rsup|\<mu\>>-\<sigma\><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-\<sigma\><rsup|\<nu\>>|)>>>|<row|<cell|<around*|{|V<rsup|\<mu\>\<nu\>>=\<cdots\>|}>=>|<cell|V<rsup|\<mu\>\<nu\>>>>|<row|<cell|<around*|{|\<sigma\><rsup|\<mu\>>=V<rsup|\<mu\>>=\<cdots\>|}>>|<cell|-0>>|<row|<cell|<around*|{|\<sigma\><rsup|\<nu\>>=V<rsup|\<nu\>>=\<cdots\>|}>>|<cell|-0>>|<row|<cell|<around*|{|V<rsup|\<alpha\>\<beta\>\<mu\>\<nu\>>=\<cdots\>|}>>|<cell|+<frac|1|2>W<rsub|\<alpha\>\<beta\>>V<rsup|\<alpha\>\<beta\>\<mu\>\<nu\>>>>|<row|<cell|<around*|{|V<rsup|\<mu\>\<nu\>>=\<cdots\>|}>>|<cell|-<frac|1|2>W<rsub|\<alpha\>\<beta\>>V<rsup|\<alpha\>\<beta\>>V<rsup|\<mu\>\<nu\>>>>|<row|<cell|=>|<cell|V<rsup|\<mu\>\<nu\>>>>|<row|<cell|<around*|{|V<rsup|\<alpha\>\<beta\>\<mu\>\<nu\>>=V<rsub|c><rsup|\<alpha\>\<beta\>\<mu\>\<nu\>>+\<cdots\>|}>>|<cell|+<frac|1|2>W<rsub|\<alpha\>\<beta\>><around*|(|V<rsub|c><rsup|\<alpha\>\<beta\>\<mu\>\<nu\>>+V<rsup|\<alpha\>\<beta\>>V<rsup|\<mu\>\<nu\>>+V<rsup|\<alpha\>\<mu\>>V<rsup|\<beta\>\<nu\>>+V<rsup|\<alpha\>\<nu\>>V<rsup|\<beta\>\<mu\>>|)>>>|<row|<cell|>|<cell|-<frac|1|2>W<rsub|\<alpha\>\<beta\>>V<rsup|\<alpha\>\<beta\>>V<rsup|\<mu\>\<nu\>>>>|<row|<cell|=>|<cell|V<rsup|\<mu\>\<nu\>>+<frac|1|2>W<rsub|\<alpha\>\<beta\>><around*|(|V<rsub|c><rsup|\<alpha\>\<beta\>\<mu\>\<nu\>>+V<rsup|\<alpha\>\<mu\>>V<rsup|\<beta\>\<nu\>>+V<rsup|\<alpha\>\<nu\>>V<rsup|\<beta\>\<mu\>>|)>>>|<row|<cell|<text|{Combine}>=>|<cell|V<rsup|\<mu\>\<nu\>>+W<rsub|<around*|(|\<alpha\>\<beta\>|)>>V<rsup|\<alpha\>\<mu\>>V<rsup|\<beta\>\<nu\>>+<frac|1|2>W<rsub|\<alpha\>\<beta\>>V<rsub|c><rsup|\<alpha\>\<beta\>\<mu\>\<nu\>>.>>>>
    </align>
  </proof>

  <\corollary>
    Define <math|<wide|C|^><rsup|\<mu\>\<nu\>>\<assign\><big|sum><rsub|x>p<rsub|D><around*|(|x|)><around*|(|x<rsup|\<mu\>>-<wide|x|^><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-<wide|x|^><rsup|\<nu\>>|)>>.
    Let <math|W> symmetric. By loss gradient, we have

    <\equation>
      <wide|x|^><rsup|\<alpha\>>=<big|sum><rsub|x>p<rsub|E><around*|(|x|)>x<rsup|\<alpha\>>;
    </equation>

    <\equation>
      <wide|C|^><rsup|\<mu\>\<nu\>>=<big|sum><rsub|x>p<rsub|E><around*|(|x|)><around*|(|x<rsup|\<mu\>>-<wide|x|^><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-<wide|x|^><rsup|\<nu\>>|)>.
    </equation>

    From these, we get, up to <math|<with|math-font|cal|O><around*|(|W|)>>,
    for <math|\<forall\>\<mu\>>,

    \;

    <\equation>
      <wide|C|^><rsup|\<mu\>\<mu\>>=<wide|x|^><rsup|\<mu\>><around*|(|1-<wide|x|^><rsup|\<mu\>>|)>+<with|math-font|cal|O><around*|(|W<rsup|2>|)>,
    </equation>

    <\equation>
      \<sigma\><rsup|\<mu\>>=<wide|x|^><rsup|\<mu\>>-W<rsub|\<mu\>\<mu\>><wide|x|^><rsup|\<mu\>><around*|(|1-<wide|x|^><rsup|\<mu\>>|)><around*|(|<frac|1|2>-<wide|x|^><rsup|\<mu\>>|)>;
    </equation>

    and for <math|\<forall\>\<mu\>,\<nu\>> with <math|\<mu\>\<neq\>\<nu\>>,

    <\equation>
      W<rsub|\<mu\>\<nu\>>=<frac|<wide|C|^><rsup|\<mu\>\<nu\>>|<wide|x|^><rsup|\<mu\>><around*|(|1-<wide|x|^><rsup|\<mu\>>|)>
      <wide|x|^><rsup|\<nu\>><around*|(|1-<wide|x|^><rsup|\<nu\>>|)>>.
    </equation>
  </corollary>

  <\proof>
    When <math|\<mu\>\<neq\>\<nu\>>, we have

    <\align>
      <tformat|<table|<row|<cell|<wide|C|^><rsup|\<mu\>\<nu\>>=>|<cell|<big|sum><rsub|x>p<rsub|E><around*|(|x|)><around*|(|x<rsup|\<mu\>>-<wide|x|^><rsup|\<mu\>>|)><around*|(|x<rsup|\<nu\>>-<wide|x|^><rsup|\<nu\>>|)>>>|<row|<cell|<around*|{|V<rsup|\<mu\>\<nu\>>\<propto\>\<delta\><rsup|\<mu\>\<nu\>>|}>=>|<cell|W<rsub|<around*|(|\<alpha\>\<beta\>|)>>
      V<rsup|\<alpha\>\<mu\>> V<rsup|\<beta\>\<nu\>>>>|<row|<cell|<around*|{|<text|<math|W>
      symmetric>|}>=>|<cell|W<rsub|\<alpha\>\<beta\>> V<rsup|\<alpha\>\<mu\>>
      V<rsup|\<beta\>\<nu\>>>>|<row|<cell|<around*|{|V<rsup|\<alpha\><rsub|1>\<alpha\><rsub|2>>=\<delta\><rsup|\<alpha\><rsub|1>\<alpha\><rsub|2>>\<sigma\><rsup|a<rsub|1>><around*|(|1-\<sigma\><rsup|\<alpha\><rsub|1>>|)>|}>=>|<cell|W<rsub|\<mu\>\<nu\>>
      \<sigma\><rsup|\<mu\>><around*|(|1-\<sigma\><rsup|\<mu\>>|)>
      \<sigma\><rsup|\<nu\>><around*|(|1-\<sigma\><rsup|\<nu\>>|)>>>|<row|<cell|<around*|{|<wide|x|^><rsup|\<alpha\>>=\<sigma\><rsup|\<alpha\>>+<with|math-font|cal|O><around*|(|W|)>|}>=>|<cell|W<rsub|\<mu\>\<nu\>>
      <wide|x|^><rsup|\<mu\>><around*|(|1-<wide|\<sigma\>|^><rsup|\<mu\>>|)>
      <wide|x|^><rsup|\<nu\>><around*|(|1-<wide|x|^><rsup|\<nu\>>|)>>>>>
    </align>

    thus, for <math|\<forall\>\<mu\>\<neq\>\<nu\>>,

    <\equation*>
      W<rsub|\<mu\>\<nu\>>=<frac|<wide|C|^><rsup|\<mu\>\<nu\>>|<wide|x|^><rsup|\<mu\>><around*|(|1-<wide|x|^><rsup|\<mu\>>|)>
      <wide|x|^><rsup|\<nu\>><around*|(|1-<wide|x|^><rsup|\<nu\>>|)>>.
    </equation*>

    And for <math|\<mu\>=\<nu\>>,

    \;

    <\align>
      <tformat|<table|<row|<cell|<wide|C|^><rsup|\<mu\>\<mu\>>=>|<cell|<big|sum><rsub|x>p<rsub|E><around*|(|x|)><around*|(|x<rsup|\<mu\>>-<wide|x|^><rsup|\<mu\>>|)><around*|(|x<rsup|\<mu\>>-<wide|x|^><rsup|\<mu\>>|)>>>|<row|<cell|<around*|{|<text|<math|W<rsub|\<mu\>\<nu\>>>
      symmetric>|}>=>|<cell|V<rsup|\<mu\>\<mu\>>+W<rsub|\<alpha\>\<beta\>>
      V<rsup|\<alpha\>\<mu\>> V<rsup|\<beta\>\<mu\>>+<frac|1|2>W<rsub|\<alpha\>\<beta\>>V<rsub|c><rsup|\<alpha\>\<beta\>\<mu\>\<mu\>>>>|<row|<cell|=>|<cell|\<sigma\><rsup|\<mu\>><around*|(|1-\<sigma\><rsup|\<mu\>>|)>>>|<row|<cell|>|<cell|+W<rsub|\<alpha\>\<beta\>>\<delta\><rsup|\<alpha\>\<mu\>>\<delta\><rsup|\<beta\>\<mu\>><around*|[|\<sigma\><rsup|\<mu\>><around*|(|1-\<sigma\><rsup|\<mu\>>|)>|]><rsup|2>>>|<row|<cell|>|<cell|+<frac|1|2>W<rsub|\<alpha\>\<beta\>>\<delta\><rsup|\<alpha\>\<beta\>\<mu\>\<mu\>>
      \<sigma\><rsup|\<mu\>><around*|(|1-\<sigma\><rsup|\<mu\>>|)><around*|[|1-6
      \<sigma\><rsup|\<mu\>>+6 <around*|(|\<sigma\><rsup|\<mu\>>|)><rsup|2>|]>>>|<row|<cell|=>|<cell|\<sigma\><rsup|\<mu\>><around*|(|1-\<sigma\><rsup|\<mu\>>|)>>>|<row|<cell|>|<cell|+W<rsub|\<mu\>\<mu\>><around*|[|\<sigma\><rsup|\<mu\>><around*|(|1-\<sigma\><rsup|\<mu\>>|)>|]><rsup|2>>>|<row|<cell|>|<cell|+<frac|1|2>W<rsub|\<mu\>\<mu\>>\<sigma\><rsup|\<mu\>><around*|(|1-\<sigma\><rsup|\<mu\>>|)><around*|[|1-6
      \<sigma\><rsup|\<mu\>>+6 <around*|(|\<sigma\><rsup|\<mu\>>|)><rsup|2>|]>>>|<row|<cell|<around*|{|<wide|x|^>=\<sigma\>+\<cdots\>|}>=>|<cell|<around*|(|<wide|x|^><rsup|\<mu\>>-<frac|1|2>W<rsub|\<alpha\>\<beta\>>V<rsup|\<alpha\>\<beta\>\<mu\>>|)><around*|(|1-<wide|x|^><rsup|\<mu\>>+<frac|1|2>W<rsub|\<alpha\>\<beta\>>V<rsup|\<alpha\>\<beta\>\<mu\>>|)>>>|<row|<cell|>|<cell|+W<rsub|\<mu\>\<mu\>><around*|[|\<sigma\><rsup|\<mu\>><around*|(|1-\<sigma\><rsup|\<mu\>>|)>|]><rsup|2>>>|<row|<cell|>|<cell|+<frac|1|2>W<rsub|\<mu\>\<mu\>>\<sigma\><rsup|\<mu\>><around*|(|1-\<sigma\><rsup|\<mu\>>|)><around*|[|1-6
      \<sigma\><rsup|\<mu\>>+6 <around*|(|\<sigma\><rsup|\<mu\>>|)><rsup|2>|]>>>|<row|<cell|<text|{Expand}>=>|<cell|<wide|x|^><rsup|\<mu\>><around*|(|1-<wide|x|^><rsup|\<mu\>>|)>+W<rsub|\<alpha\>\<beta\>>V<rsup|\<alpha\>\<beta\>\<mu\>><around*|(|<wide|x|^><rsup|\<mu\>>-<frac|1|2>|)>>>|<row|<cell|>|<cell|+W<rsub|\<mu\>\<mu\>><around*|[|\<sigma\><rsup|\<mu\>><around*|(|1-\<sigma\><rsup|\<mu\>>|)>|]><rsup|2>>>|<row|<cell|>|<cell|+<frac|1|2>W<rsub|\<mu\>\<mu\>>\<sigma\><rsup|\<mu\>><around*|(|1-\<sigma\><rsup|\<mu\>>|)><around*|[|1-6
      \<sigma\><rsup|\<mu\>>+6 <around*|(|\<sigma\><rsup|\<mu\>>|)><rsup|2>|]>>>|<row|<cell|<around*|{|V<rsup|\<alpha\>\<beta\>\<mu\>>=\<cdots\>|}>=>|<cell|<wide|x|^><rsup|\<mu\>><around*|(|1-<wide|x|^><rsup|\<mu\>>|)>+W<rsub|\<mu\>\<mu\>>\<sigma\><rsup|\<mu\>><around*|(|1-\<sigma\><rsup|\<mu\>>|)><around*|(|1-2\<sigma\><rsup|\<mu\>>|)><around*|(|<wide|x|^><rsup|\<mu\>>-<frac|1|2>|)>>>|<row|<cell|>|<cell|+W<rsub|\<mu\>\<mu\>><around*|[|\<sigma\><rsup|\<mu\>><around*|(|1-\<sigma\><rsup|\<mu\>>|)>|]><rsup|2>>>|<row|<cell|>|<cell|+<frac|1|2>W<rsub|\<mu\>\<mu\>>\<sigma\><rsup|\<mu\>><around*|(|1-\<sigma\><rsup|\<mu\>>|)><around*|[|1-6
      \<sigma\><rsup|\<mu\>>+6 <around*|(|\<sigma\><rsup|\<mu\>>|)><rsup|2>|]>>>|<row|<cell|<around*|{|<wide|x|^><rsup|\<alpha\>>=\<sigma\><rsup|\<alpha\>>+<with|math-font|cal|O><around*|(|W|)>|}>=>|<cell|<wide|x|^><rsup|\<mu\>><around*|(|1-<wide|x|^><rsup|\<mu\>>|)>+W<rsub|\<mu\>\<mu\>><wide|x|^><rsup|\<mu\>><around*|(|1-<wide|x|^><rsup|\<mu\>>|)><around*|(|1-2<wide|x|^><rsup|\<mu\>>|)><around*|(|<wide|x|^><rsup|\<mu\>>-<frac|1|2>|)>>>|<row|<cell|>|<cell|+W<rsub|\<mu\>\<mu\>><around*|[|<wide|x|^><rsup|\<mu\>><around*|(|1-<wide|x|^><rsup|\<mu\>>|)>|]><rsup|2>>>|<row|<cell|>|<cell|+<frac|1|2>W<rsub|\<mu\>\<mu\>><wide|x|^><rsup|\<mu\>><around*|(|1-<wide|x|^><rsup|\<mu\>>|)><around*|[|1-6
      <wide|x|^><rsup|\<mu\>>+6 <around*|(|<wide|x|^><rsup|\<mu\>>|)><rsup|2>|]>>>|<row|<cell|<text|{Combine}>=>|<cell|<wide|x|^><rsup|\<mu\>><around*|(|1-<wide|x|^><rsup|\<mu\>>|)>>>|<row|<cell|>|<cell|+W<rsub|\<mu\>\<mu\>><wide|x|^><rsup|\<mu\>><around*|(|1-<wide|x|^><rsup|\<mu\>>|)>\<times\>>>|<row|<cell|>|<cell|\<times\><around*|{|<around*|(|1-2<wide|x|^><rsup|\<mu\>>|)><around*|(|<wide|x|^><rsup|\<mu\>>-<frac|1|2>|)>+<wide|x|^><rsup|\<mu\>><around*|(|1-<wide|x|^><rsup|\<mu\>>|)>+<frac|1|2><around*|[|1-6
      <wide|x|^><rsup|\<mu\>>+6 <around*|(|<wide|x|^><rsup|\<mu\>>|)><rsup|2>|]>|}>>>|<row|<cell|<text|{Simplify}>=>|<cell|<wide|x|^><rsup|\<mu\>><around*|(|1-<wide|x|^><rsup|\<mu\>>|)>,>>>>
    </align>

    Thus,

    <\equation*>
      <wide|C|^><rsup|\<mu\>\<nu\>>=<wide|x|^><rsup|\<mu\>><around*|(|1-<wide|x|^><rsup|\<mu\>>|)>+<with|math-font|cal|O><around*|(|W<rsup|2>|)>.
    </equation*>

    Finally, we have

    <\align>
      <tformat|<table|<row|<cell|<wide|x|^><rsup|\<mu\>>=>|<cell|V<rsup|\<mu\>>+<frac|1|2>W<rsub|\<alpha\>\<beta\>>V<rsup|\<alpha\>\<beta\>\<mu\>>>>|<row|<cell|=>|<cell|\<sigma\><rsup|\<mu\>>+<frac|1|2>W<rsub|\<alpha\>\<beta\>>\<delta\><rsup|\<alpha\>\<beta\>\<mu\>>\<sigma\><rsup|\<alpha\>><around*|(|1-\<sigma\><rsup|\<alpha\>>|)><around*|(|1-2\<sigma\><rsup|\<alpha\>>|)>>>|<row|<cell|=>|<cell|\<sigma\><rsup|\<mu\>>+W<rsub|\<mu\>\<mu\>>\<sigma\><rsup|\<mu\>><around*|(|1-\<sigma\><rsup|\<mu\>>|)><around*|(|<frac|1|2>-\<sigma\><rsup|\<mu\>>|)>.>>|<row|<cell|<around*|{|<wide|x|^><rsup|\<alpha\>>=\<sigma\><rsup|\<alpha\>>+<with|math-font|cal|O><around*|(|W|)>|}>=>|<cell|\<sigma\><rsup|\<mu\>>+W<rsub|\<mu\>\<mu\>><wide|x|^><rsup|\<mu\>><around*|(|1-<wide|x|^><rsup|\<mu\>>|)><around*|(|<frac|1|2>-<wide|x|^><rsup|\<mu\>>|)>>>>>
    </align>

    Thus

    <\equation*>
      \<sigma\><rsup|\<mu\>>=<wide|x|^><rsup|\<mu\>>-W<rsub|\<mu\>\<mu\>><wide|x|^><rsup|\<mu\>><around*|(|1-<wide|x|^><rsup|\<mu\>>|)><around*|(|<frac|1|2>-<wide|x|^><rsup|\<mu\>>|)>.
    </equation*>
  </proof>

  <subsection|Perturbation of Restricted Boltzmann Machine>

  <\theorem>
    For <math|\<forall\>i>, let <math|<wide|h|^><rsup|i>\<equiv\>1/2> and
    <math|c<rsub|i>\<equiv\>0>, then we have

    <\equation>
      E<rsub|eff><around*|(|v;U,b,c|)>=-<frac|1|2>W<rsup|eff><rsub|\<alpha\>\<beta\>><around*|(|v<rsup|\<alpha\>>-<wide|v|^><rsup|\<alpha\>>|)><around*|(|v<rsup|\<beta\>>-<wide|v|^><rsup|\<beta\>>|)>-b<rsup|eff><rsub|\<alpha\>>v<rsup|\<alpha\>>+<with|math-font|cal|O><around*|(|U<rsup|3>|)>,
    </equation>

    where

    <\equation>
      b<rsup|eff><rsub|\<alpha\>>\<assign\>b<rsub|\<alpha\>>,
    </equation>

    and

    <\equation>
      W<rsup|eff><rsub|\<alpha\>\<beta\>>\<assign\><frac|1|4><big|sum><rsub|i>U<rsub|\<alpha\>i>
      U<rsub|\<beta\>i>.
    </equation>

    That is, restricted Boltzmann machine reduces to a Boltzmann machine.
  </theorem>

  <\proof>
    Recall that

    <\equation>
      E<rsub|eff><around*|(|v;U,b,c|)>=<big|sum><rsub|\<alpha\>><around*|(|<big|sum><rsub|i>U<rsub|\<alpha\>i>
      v<rsup|\<alpha\>><wide|h|^><rsup|i>-b<rsub|\<alpha\>>v<rsup|\<alpha\>>|)>-<big|sum><rsub|i>s<rsub|+><around*|(|<big|sum><rsub|\<alpha\>>U<rsub|\<alpha\>i>
      <around*|(|v<rsup|\<alpha\>>-<wide|v|^><rsup|\<alpha\>>|)>+c<rsub|i>|)>,
    </equation>

    where soft-plus <math|s> is defined as

    <\equation>
      s<around*|(|x|)>\<assign\>ln<around*|(|1+\<mathe\><rsup|x>|)>.
    </equation>

    Taylor expansion of soft-plus is

    <\equation*>
      s<around*|(|x|)>=0+<frac|x|2>+<frac|x<rsup|2>|8>+<with|math-font|cal|O><around*|(|x<rsup|3>|)>.
    </equation*>

    Thus

    <\align>
      <tformat|<table|<row|<cell|E<rsub|eff><around*|(|v|)>=>|<cell|<big|sum><rsub|\<alpha\>><around*|(|<big|sum><rsub|i>U<rsub|\<alpha\>i>
      v<rsup|\<alpha\>><wide|h|^><rsup|i>-b<rsub|\<alpha\>>v<rsup|\<alpha\>>|)>>>|<row|<cell|<text|{Taylor
      expand}>->|<cell|<frac|1|2><big|sum><rsub|i><around*|[|<big|sum><rsub|\<alpha\>>U<rsub|\<alpha\>i>
      <around*|(|v<rsup|\<alpha\>>-<wide|v|^><rsup|\<alpha\>>|)>+c<rsub|i>|]>-<frac|1|8><big|sum><rsub|i><around*|[|<big|sum><rsub|\<alpha\>>U<rsub|\<alpha\>i>
      <around*|(|v<rsup|\<alpha\>>-<wide|v|^><rsup|\<alpha\>>|)>+c<rsub|i>|]><rsup|2>>>|<row|<cell|>|<cell|+<with|math-font|cal|O><around*|(|U<rsup|3>+c<rsup|3>|)>>>|<row|<cell|<text|{Expand}>=>|<cell|<big|sum><rsub|\<alpha\>,i>U<rsub|\<alpha\>i>
      v<rsup|\<alpha\>><wide|h|^><rsup|i>-<big|sum><rsub|\<alpha\>>b<rsub|\<alpha\>>v<rsup|\<alpha\>>>>|<row|<cell|>|<cell|-<frac|1|2><big|sum><rsub|\<alpha\>,i>U<rsub|\<alpha\>i>
      <around*|(|v<rsup|\<alpha\>>-<wide|v|^><rsup|\<alpha\>>|)>-<frac|1|2><big|sum><rsub|i>c<rsub|i>>>|<row|<cell|>|<cell|-<frac|1|8><big|sum><rsub|\<alpha\>,\<beta\>><around*|(|<big|sum><rsub|i>U<rsub|\<alpha\>i>
      U<rsub|\<beta\>i>|)><around*|(|v<rsup|\<alpha\>>-<wide|v|^><rsup|\<alpha\>>|)><around*|(|v<rsup|\<beta\>>-<wide|v|^><rsup|\<beta\>>|)>-<frac|1|4><big|sum><rsub|\<alpha\>,i>U<rsub|\<alpha\>i>
      <around*|(|v<rsup|\<alpha\>>-<wide|v|^><rsup|\<alpha\>>|)>c<rsub|i>-<frac|1|8><big|sum><rsub|i>c<rsub|i><rsup|2>>>|<row|<cell|>|<cell|+<with|math-font|cal|O><around*|(|U<rsup|3>+c<rsup|3>|)>>>|<row|<cell|<around*|[|\<propto\><big|sum><rsub|\<alpha\>,i>U<rsub|\<alpha\>i>
      v<rsup|\<alpha\>>|]>=>|<cell|<big|sum><rsub|\<alpha\>,i>U<rsub|\<alpha\>i>v<rsup|\<alpha\>><around*|(|<wide|h|^><rsup|i>-<frac|1|2>-<frac|c<rsub|i>|4>|)>>>|<row|<cell|>|<cell|-<big|sum><rsub|\<alpha\>>b<rsub|\<alpha\>>v<rsup|\<alpha\>>>>|<row|<cell|>|<cell|-<frac|1|8><big|sum><rsub|\<alpha\>,\<beta\>><around*|(|<big|sum><rsub|i>U<rsub|\<alpha\>i>
      U<rsub|\<beta\>i>|)><around*|(|v<rsup|\<alpha\>>-<wide|v|^><rsup|\<alpha\>>|)><around*|(|v<rsup|\<beta\>>-<wide|v|^><rsup|\<beta\>>|)>>>|<row|<cell|<text|[Without
      <math|v>]>>|<cell|+Const>>|<row|<cell|>|<cell|+<with|math-font|cal|O><around*|(|U<rsup|3>+c<rsup|3>|)>>>>>
    </align>

    Let <math|<wide|h|^><rsup|i>\<equiv\>1/2> and <math|c<rsub|i>\<equiv\>0>,
    we have

    <\align>
      <tformat|<table|<row|<cell|E<rsub|eff><around*|(|v|)>=>|<cell|-<big|sum><rsub|\<alpha\>>b<rsub|\<alpha\>>v<rsup|\<alpha\>>>>|<row|<cell|>|<cell|-<frac|1|8><big|sum><rsub|\<alpha\>,\<beta\>><around*|(|<big|sum><rsub|i>U<rsub|\<alpha\>i>
      U<rsub|\<beta\>i>|)><around*|(|v<rsup|\<alpha\>>-<wide|v|^><rsup|\<alpha\>>|)><around*|(|v<rsup|\<beta\>>-<wide|v|^><rsup|\<beta\>>|)>>>|<row|<cell|>|<cell|+Const>>|<row|<cell|>|<cell|+<with|math-font|cal|O><around*|(|U<rsup|3>|)>.>>>>
    </align>

    That is, omitting the constant, which will be eliminated by <math|Z>,

    <\equation>
      E<rsub|eff><around*|(|v|)>=-<frac|1|2>W<rsup|eff><rsub|\<alpha\>\<beta\>><around*|(|v<rsup|\<alpha\>>-<wide|v|^><rsup|\<alpha\>>|)><around*|(|v<rsup|\<beta\>>-<wide|v|^><rsup|\<beta\>>|)>-b<rsup|eff><rsub|\<alpha\>>v<rsup|\<alpha\>>+<with|math-font|cal|O><around*|(|U<rsup|3>|)>,
    </equation>

    where

    <\equation*>
      b<rsup|eff><rsub|\<alpha\>>\<assign\>b<rsub|\<alpha\>>,
    </equation*>

    and

    <\equation>
      W<rsup|eff><rsub|\<alpha\>\<beta\>>\<assign\><frac|1|4><big|sum><rsub|i>U<rsub|\<alpha\>i>
      U<rsub|\<beta\>i>.
    </equation>
  </proof>
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
    <associate|auto-6|<tuple|4.1.1|?>>
    <associate|auto-7|<tuple|4.1.2|?>>
    <associate|auto-8|<tuple|4.2|?>>
    <associate|footnote-1|<tuple|1|?>>
    <associate|footnr-1|<tuple|1|?>>
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

      <with|par-left|<quote|2tab>|4.1.1<space|2spc>0th-order
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-6>>

      <with|par-left|<quote|2tab>|4.1.2<space|2spc>1st-order
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-7>>
    </associate>
  </collection>
</auxiliary>
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
      p<around*|(|x;\<theta\>|)>=<frac|exp<around*|(|-E<around*|(|x;\<theta\>|)>|)>|<big|int><rsub|<with|math-font|cal|M>>\<mathd\>x<rprime|'>
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
    [Activity Rule]

    The local maximum of <math|p<around*|(|\<cdummy\>;\<theta\>|)>> is the
    local minimum of <math|E<around*|(|\<cdummy\>;\<theta\>|)>>, and vice
    versa.
  </theorem>

  <\theorem>
    [Learning Rule]

    For any probability density <math|p<rsub|D>:<with|math-font|cal|M>\<rightarrow\>\<bbb-R\>>,
    define Lagrangian <math|L<around*|(|\<theta\>;p<rsub|D>|)>\<assign\>-<big|int><rsub|<with|math-font|cal|M>>\<mathd\>x
    p<rsub|D><around*|(|x|)> ln p<around*|(|x;\<theta\>|)>>. Then, the
    gradient of Lagrangian w.r.t. component <math|\<theta\><rsup|\<alpha\>>>
    is

    <\equation*>
      <frac|\<partial\>L|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|\<theta\>;p<rsub|D>|)>=<big|int><rsub|<with|math-font|cal|M>>\<mathd\>x
      p<rsub|D><around*|(|x|)> <frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|x;\<theta\>|)>-<big|int><rsub|<with|math-font|cal|M>>\<mathd\>x
      p<around*|(|x;\<theta\>|)> <frac|\<partial\>E|\<partial\>\<theta\><rsup|\<alpha\>>><around*|(|x;\<theta\>|)>,
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
      <math|W\<in\>\<bbb-R\><rsup|<around*|(|n\<times\>n|)>>>,
      <math|b\<in\>\<bbb-R\><rsup|n>>, <math|\<theta\>\<assign\><around*|(|W,b|)>>.
      Then a Boltzmann machine is defined by energy function

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
</body>

<initial|<\collection>
</collection>>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|?|../../../.TeXmacs/texts/scratch/no_name_7.tm>>
    <associate|auto-2|<tuple|2|?|../../../.TeXmacs/texts/scratch/no_name_7.tm>>
    <associate|auto-3|<tuple|3|?|../../../.TeXmacs/texts/scratch/no_name_7.tm>>
    <associate|auto-4|<tuple|3.1|?|../../../.TeXmacs/texts/scratch/no_name_7.tm>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Energy-based
      Model> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>
    </associate>
  </collection>
</auxiliary>
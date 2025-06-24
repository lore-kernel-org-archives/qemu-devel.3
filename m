Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B48C77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 17:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU7aj-0007Fy-KQ; Tue, 24 Jun 2025 13:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uU7ah-0007Fb-0g
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 13:37:51 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uU7ae-0000l9-Nl
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 13:37:50 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ad93ff9f714so137399866b.2
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 10:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750786666; x=1751391466; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6EhEk/+aDhmCVPjvcuwiHTJZVdod2QjKJEE8ZGEQoXg=;
 b=DIq/T63hb7SAWVKCu7tv2NuGAQV+s0KGEYMl++JZ0akR4Szp1odHtlBjARd+8HAJt3
 X9TPjpQWOtK7N7fYd1rZrpxrzIcExMscwE6Z+0YL2WwE+e5jkoR9rDNaMmCTJLclf+Lr
 7K3Qsweaq2/7ildDU/U3ofW7oUBz0EATY73kz8x/wvzBKbGNSjmB2TWupbDuzpKbMmsi
 oHbE3voG8LvHfO3HQ7eywmI2fupA9WiPjdfM3g9yM1VXtHUXIjTlNy4XEIW1xfebvQYb
 EOhcQEKuhlB/yypf2pD+h7AUZD/yCZIujHQQDDtqedq5jkTDSsuFa52UWC0A9TAKR0bG
 MCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750786666; x=1751391466;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6EhEk/+aDhmCVPjvcuwiHTJZVdod2QjKJEE8ZGEQoXg=;
 b=XfjQulKf6Z+vnj4zMK207/XhdX8ukVc5nIyLfwcyIhztJz5J70fUF/11n45rv90C+j
 ts84cBNB1BF4neBw1O1St/7wot0Hw0q8UMcAGPFaWCWMghdBjt1QpO4FZp9rzbKWoYvH
 RPJlMrwn+aDlt9I8b3nVqAGrthjuCl9Zpjgefy6IHeICRaHwLlKzIriqpIL6PL5RDYHV
 1YEMieGGui0owDMFH4ClfICnLkvhsWyi9T1o3VVzjUbqNw1JB4UN+Rj5xplEh2d0VaGw
 35pdfTalPEZJVpXiG76H4AAT7i9GCALqVJvhzc/PUl8IHs/x6/qRyd55OAd42xTXee1a
 cIYQ==
X-Gm-Message-State: AOJu0Yz1169cP1oCpGXd4FShlPAt/4qO9kIpTDgZ/mW+Na3xJDwg/2KE
 439fHTopI1EkD0vkb5VMixqyf31k6sOYwp6Sk28mQbo8t7A8xyZwNCPMSJNKA2d+XwdrruskJ+3
 jFBDySGH5Qp6HJfGrRGqV1HI0Ms3TvlM=
X-Gm-Gg: ASbGncv6bggN0xfWXkjoZ4+YUcimFYpE0KibqrjnrF/xxMxHpML0sWHCZ6h51TlR3qn
 2gb21OCII+6D6DhZuevi7tdNJWHEnSGHDPMDDUVnXHwTCZXb1pNraJU5aaiCYY1BCJoju7Tahee
 hE7RCxUL3UgHBLAQ+AYoGVGo1HjYFYaqvtzfptHNT0O2i9fFemitUQ
X-Google-Smtp-Source: AGHT+IEJQx8YPhhYADxA8Hr8EYKJu846dzi/vpAkZgIKtxnpr/k+81cA6kWMXBnTn7hpj0s/SMmhnZteHcXpRLxaPq8=
X-Received: by 2002:a17:906:b218:b0:ad4:d00f:b4ca with SMTP id
 a640c23a62f3a-ae0bea5247dmr12973566b.50.1750786665758; Tue, 24 Jun 2025
 10:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250620143720.3143-1-tanishdesai37@gmail.com>
 <20250620143720.3143-3-tanishdesai37@gmail.com> <20250624143701.GA5519@fedora>
In-Reply-To: <20250624143701.GA5519@fedora>
From: Tanish Desai <tanishdesai37@gmail.com>
Date: Tue, 24 Jun 2025 23:07:34 +0530
X-Gm-Features: Ac12FXwjot6O2WRsCBpRieUbOyFokMsG2mlkpr-m32MLhfQgBKWVtQ82gM5kPfM
Message-ID: <CAH_Y1jd9CSUZB502Vj4tYFXEsqymAGVJQ93TZ5oEZF726KGHKw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] tracetool: introduce generate_unconditional
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004a4427063854c99b"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=tanishdesai37@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000004a4427063854c99b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> 1. nocheck isn't necessary anymore. The body of nocheck could be inlined
>   here instead to simplify the generated code.
Yes I agree.I will remove nocheck and inline the body of nocheck in
trace-foo
> 2. "if (%(cond)s) {" is only useful for backends that implement
>   .generate(). For example, if only the dtrace backend is enabled then
>   "if (trace_event_get_state(...)) {}" will be emitted unnecessarily.
Yes, we should remove unnecessary if (trace_event_get_state(...)){}
blocks.

But It is difficult because backend.generate() calls
_run_function("generate_%s", event, group) which in turn loops on all
backends.Format can't call generate for individual backends.I will need
to make this map in scripts/tracetool/backend/__init__.py:_run_function().(=
I
think this
will not be a good thing to do).

possible fix would be to create in scripts/tracetool/backend/__init__.py
def is_conditional(self, cond_check):
    self._run_function("generate_%s_conditional", cond_check)
now cond_check will be passed to all backends and backend's will have
def is_h_conditional(cond_check):
    cond_check =3D cond_check or True

Finally if cond_check=3D=3DTrue in h.py I will generate "if
(trace_event_get_state(...)) {"
else not. As the same condition is re-used this solution would work well.
Since h.py only handles reused/shared logic, it's safe to assume consistent
conditions.
If a new backend requires a different condition, it's better handled
directly in backend/*.py.


On Tue, Jun 24, 2025 at 8:07=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:

> On Fri, Jun 20, 2025 at 02:37:19PM +0000, Tanish Desai wrote:
> > diff --git a/scripts/tracetool/format/h.py
> b/scripts/tracetool/format/h.py
> > index ea126b07ea..89d54b9aff 100644
> > --- a/scripts/tracetool/format/h.py
> > +++ b/scripts/tracetool/format/h.py
> > @@ -76,13 +76,17 @@ def generate(events, backend, group):
> >          out('',
> >              'static inline void %(api)s(%(args)s)',
> >              '{',
> > -            '    if (%(cond)s) {',
> > +            api=3De.api(),
> > +            args=3De.args)
> > +
> > +        if "disable" not in e.properties:
> > +            backend.generate_unconditional(e, group)
> > +
> > +        out('    if (%(cond)s) {',
> >              '        %(api_nocheck)s(%(names)s);',
> >              '    }',
> >              '}',
> > -            api=3De.api(),
> >              api_nocheck=3De.api(e.QEMU_TRACE_NOCHECK),
> > -            args=3De.args,
> >              names=3D", ".join(e.args.names()),
> >              cond=3Dcond)
>
> Two thoughts:
>
> 1. nocheck isn't necessary anymore. The body of nocheck could be inlined
>    here instead to simplify the generated code.
>
> 2. "if (%(cond)s) {" is only useful for backends that implement
>    .generate(). For example, if only the dtrace backend is enabled then
>    "if (trace_event_get_state(...)) {}" will be emitted unnecessarily.
>
> Maybe backends should have a .condition() interface so that
> scripts/tracetool/format/h.py:generate() can first collect a dict[cond]
> -> backend. Then it iterates over the map, calling backend.generate()
> within "if (%(cond)s) { ... }". That way only the conditions that are
> actually needed are generated and multiple backends that have the same
> condition will share the same if statement.
>
> Stefan
>

--0000000000004a4427063854c99b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt; 1. nocheck isn&#39;t necessary anymore. The body of n=
ocheck could be inlined<br>&gt;=C2=A0 =C2=A0here instead to simplify the ge=
nerated code.<br>Yes I agree.I will remove nocheck and inline the body of n=
ocheck in trace-foo<div>&gt; 2. &quot;if (%(cond)s) {&quot; is only useful =
for backends that implement<br>&gt;=C2=A0 =C2=A0.generate(). For example, i=
f only the dtrace backend is enabled then<br>&gt;=C2=A0 =C2=A0&quot;if (tra=
ce_event_get_state(...)) {}&quot; will be emitted unnecessarily.</div><div>=
<span style=3D"white-space:unset">Yes, we should remove unnecessary </span>=
<code style=3D"white-space:unset">if (trace_event_get_state(...)){}</code><=
/div><div><span style=3D"white-space:unset"> blocks.</span></div><div><span=
 style=3D"white-space:unset"><br></span><span style=3D"white-space:unset">B=
ut It is difficult because backend.generate() calls=C2=A0</span></div><div>=
<span style=3D"white-space:unset">_run_function(&quot;generate_%s&quot;, ev=
ent, group)=C2=A0</span><span style=3D"white-space:unset">which in turn loo=
ps on all=C2=A0</span></div><div><span style=3D"white-space:unset">backends=
.Format can&#39;t call generate for individual backends.I will need=C2=A0<b=
r>to make this map in scripts/tracetool/backend/__init__.py:</span><span st=
yle=3D"white-space:unset">_run_function()</span><span style=3D"white-space:=
unset">.(I think this</span></div><div><span style=3D"white-space:unset">wi=
ll not be a good thing to do).</span></div><div><span style=3D"white-space:=
unset"><br>possible fix would be to create in scripts/tracetool/backend/__i=
nit__.py</span></div><font face=3D"monospace">def is_conditional(self, cond=
_check):<br></font><div><span style=3D"white-space:unset"><font face=3D"mon=
ospace">=C2=A0 =C2=A0 self._run_function(&quot;generate_%s_conditional&quot=
;, cond_check)</font></span></div><div>now <font face=3D"monospace">cond_ch=
eck</font>=C2=A0will be passed to all backends and backend&#39;s will have=
=C2=A0</div><font face=3D"monospace">def is_h_conditional(cond_check):<br><=
/font><div><span style=3D"white-space:unset"><font face=3D"monospace">=C2=
=A0 =C2=A0 cond_check =3D cond_check or True</font></span></div><div><span =
style=3D"white-space:unset"><br></span></div><div>Finally if=C2=A0<span sty=
le=3D"white-space:unset">cond_check=3D=3DTrue in h.py I will generate=C2=A0=
</span><span style=3D"white-space:unset">&quot;if (trace_event_get_state(..=
.)) {&quot;</span></div><div><span style=3D"white-space:unset">else not. As=
 the same condition is re-used this solution would work well.</span></div><=
div>Since h.py only handles reused/shared logic, it&#39;s safe to assume co=
nsistent conditions.=C2=A0</div><div>If a new backend requires a different =
condition, it&#39;s better handled directly in backend/*.py.<span style=3D"=
white-space:unset"></span></div><div><br></div></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 24, 2025 at 8:07=
=E2=80=AFPM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" targ=
et=3D"_blank">stefanha@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Fri, Jun 20, 2025 at 02:37:19PM +0000, =
Tanish Desai wrote:<br>
&gt; diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/=
h.py<br>
&gt; index ea126b07ea..89d54b9aff 100644<br>
&gt; --- a/scripts/tracetool/format/h.py<br>
&gt; +++ b/scripts/tracetool/format/h.py<br>
&gt; @@ -76,13 +76,17 @@ def generate(events, backend, group):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out(&#39;&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;static inline voi=
d %(api)s(%(args)s)&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;{&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;=C2=A0 =C2=A0 if (%(co=
nd)s) {&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 api=3De.api(),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 args=3De.args)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;disable&quot; not in e.propertie=
s:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 backend.generate_unconditio=
nal(e, group)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 out(&#39;=C2=A0 =C2=A0 if (%(cond)s) {&#3=
9;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 %(api_nocheck)s(%(names)s);&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;=C2=A0 =C2=A0 }&#=
39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;}&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 api=3De.api(),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 api_nocheck=3De.api(e.=
QEMU_TRACE_NOCHECK),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 args=3De.args,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 names=3D&quot;, &quot;=
.join(e.args.names()),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cond=3Dcond)<br>
<br>
Two thoughts:<br>
<br>
1. nocheck isn&#39;t necessary anymore. The body of nocheck could be inline=
d<br>
=C2=A0 =C2=A0here instead to simplify the generated code.<br>
<br>
2. &quot;if (%(cond)s) {&quot; is only useful for backends that implement<b=
r>
=C2=A0 =C2=A0.generate(). For example, if only the dtrace backend is enable=
d then<br>
=C2=A0 =C2=A0&quot;if (trace_event_get_state(...)) {}&quot; will be emitted=
 unnecessarily.<br>
<br>
Maybe backends should have a .condition() interface so that<br>
scripts/tracetool/format/h.py:generate() can first collect a dict[cond]<br>
-&gt; backend. Then it iterates over the map, calling backend.generate()<br=
>
within &quot;if (%(cond)s) { ... }&quot;. That way only the conditions that=
 are<br>
actually needed are generated and multiple backends that have the same<br>
condition will share the same if statement.<br>
<br>
Stefan<br>
</blockquote></div>

--0000000000004a4427063854c99b--


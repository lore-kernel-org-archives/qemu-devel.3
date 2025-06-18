Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D5AC71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 16:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRvZc-00069M-5O; Wed, 18 Jun 2025 12:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uRvZa-000694-SX
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 12:23:38 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uRvZY-0008HN-8Q
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 12:23:38 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-60497d07279so14549675a12.3
 for <qemu-devel@nongnu.org>; Wed, 18 Jun 2025 09:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750263814; x=1750868614; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rRZibTAfe9sgahJ1ASbgQaHlIW5ZT3QqC/Re1YhTdqU=;
 b=UmwdR7IEbEWGuvrK1Y42g7tLZOud79TkMVJt4RsZdyMlDEt7lnvjJjULvoJT14nfx1
 lZJJqGtRPKtqG6gkUcUbiiqY7WoGnOorZrQHu66yFKHvWgLXII8pvlVk07av9q8y7LO2
 nnlRa/Wq++NdLKanxYhRl9B91JB7EyRWIv5qEPmQKS/fmfoeuD6Ge1ceQZp9ZiH+bOPi
 z8KvOD+liWsHG1A/RfxnNrxFl1myFf+RslOkhL/oltdRTLWbwnaBtEwIG+n0UFrWWceP
 cpYjXqAXWzUOhkqvMPU2r7pqfw0WNIhFsSQo19KJOSYIQrUFHn3ZwgV+xM21S1GLCywh
 SOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750263814; x=1750868614;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rRZibTAfe9sgahJ1ASbgQaHlIW5ZT3QqC/Re1YhTdqU=;
 b=qk3T+oRpJJw0YFLVwOtUw7u9NQZxfWqLbus/cgNxp1yeQ1JSw5Y6Z6nH5FKwX9JJK7
 pBHQ7fhXtAEN7UhjjYVv0JzcN/QmrRM45ro19nqxln4bveOrsQePxy7PsqKb9c8mLT9B
 BK19ctUGVsI9IYZjDFtjqoHpeDni3jB1PnYv9lHW2MwWuSHGU5kMjiTuPmIIY8jDmBsM
 bV05XyzB57XSa8lAhyJYKrb+8p2b7T/Br0r9lIOQqeTe0Tgo1IO58Nq4A6SnCzj2fwln
 EJ91zWZtvUOXbW4aj0JuhazSvECleeD81wCnm3S1QPwsJydutcUh3hw0OYJBgzzDfGtm
 iaPA==
X-Gm-Message-State: AOJu0YykrI47K2jSjpDzBr7NNOxZc89PtMzK6CPSWv2D20kjNrZw2CU6
 09uNDsLZQH/T7wygywqd2MxWq8K4ZHZ/UH3sLTSlRjL7SQ6KtGBKRLsKrPaGp/UFZJqsg/Ta2nP
 3G7eXOnfTjPrsXKkIYQwYcR8mmcCL7ZM=
X-Gm-Gg: ASbGncvR7JxIGw/+el/jsNuSO4waYTaQZ9JWlv0R/pPppSdmtHX04FZNYxYUoGpyb00
 4Gd5WSXT3xcMAbublKVe0d6fvqkovqYukRoH433Ns62Ujys7GxBj5Y89zriz3oz6hZUxEvGA2eG
 jhaAv8VfgNVDNhRklHYzWRGsm1gQEkSwM10Hgr5goK6CE=
X-Google-Smtp-Source: AGHT+IEfXbR9PjLIyPOr9wjYsrFUX+Ym4SeQ37AuIvG5KW7cTcD0Sm3tCJ9+iRAdkRhXaX4I9b5XmZV6cWEj7RSfcUM=
X-Received: by 2002:a17:907:7e8d:b0:ad8:9428:6a3b with SMTP id
 a640c23a62f3a-adfad3eac8bmr1819188266b.5.1750263813665; Wed, 18 Jun 2025
 09:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250616201222.6416-1-tanishdesai37@gmail.com>
 <20250616201222.6416-3-tanishdesai37@gmail.com>
 <87zfe6t2gs.fsf@draig.linaro.org>
In-Reply-To: <87zfe6t2gs.fsf@draig.linaro.org>
From: Tanish Desai <tanishdesai37@gmail.com>
Date: Wed, 18 Jun 2025 21:53:21 +0530
X-Gm-Features: AX0GCFvcBOmWvxetN7VnWzbc6ivvrVBSK96V7LZ7kOvSwo5ECRZOxqCnEy81J2k
Message-ID: <CAH_Y1jeCe1P7AV8z5rRp=0guG06Gdhxb5HxHP_uEXHA0Hjc=bg@mail.gmail.com>
Subject: Re: [PATCH 2/3] tracetool: introduce generate_unconditional
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>, 
 Paolo Bonzini <pbonzini@redhat.com>, Mads Ynddal <mads@ynddal.dk>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e0788e0637db0cba"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=tanishdesai37@gmail.com; helo=mail-ed1-x52c.google.com
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

--000000000000e0788e0637db0cba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Please fix the word wrap on the commit at 78 chars.
I will send v2 with this fix
> stray newline
In tracetool/backend, every function is followed by two newline characters.

On Wed, Jun 18, 2025 at 4:12=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:

> Tanish Desai <tanishdesai37@gmail.com> writes:
>
> > This patch separates the generation logic of trace_foo() for the UST an=
d
> DTrace backends from other backends.
> > The motivation is to remove the unnecessary if (true) in the _no_check
> function, as UST and DTrace do not require a trace_event_get_state check
> without introducing a seperate function it is very difficult to generate
> code which keeps them out of unified if condition.
> > With this separation, we can safely move the trace_event_get_state chec=
k
> into trace_foo for the other backends only, keeping UST/DTrace generation
> paths clean.
> > A new generate_h_unconditional function has been introduced for UST
> > and DTrace. It behaves similarly to generate_h, but is defined only in
> > UST and DTrace backends. This ensures that generate_h is used by the
> > other backends, while UST/DTrace selectively use
> > generate_h_unconditional.
>
> Please fix the word wrap on the commit at 78 chars.
>
> >
> > Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> > ---
> >  scripts/tracetool/backend/__init__.py |  3 +++
> >  scripts/tracetool/backend/dtrace.py   |  3 ++-
> >  scripts/tracetool/backend/ust.py      |  2 +-
> >  scripts/tracetool/format/h.py         | 10 +++++++---
> >  4 files changed, 13 insertions(+), 5 deletions(-)
> >
> > diff --git a/scripts/tracetool/backend/__init__.py
> b/scripts/tracetool/backend/__init__.py
> > index 7bfcc86cc5..c4456a5efd 100644
> > --- a/scripts/tracetool/backend/__init__.py
> > +++ b/scripts/tracetool/backend/__init__.py
> > @@ -118,6 +118,9 @@ def generate_begin(self, events, group):
> >      def generate(self, event, group):
> >          self._run_function("generate_%s", event, group)
> >
> > +    def generate_unconditional(self, event, group):
> > +        self._run_function("generate_%s_unconditional", event, group)
> > +
> >      def generate_backend_dstate(self, event, group):
> >          self._run_function("generate_%s_backend_dstate", event, group)
> >
> > diff --git a/scripts/tracetool/backend/dtrace.py
> b/scripts/tracetool/backend/dtrace.py
> > index e17edc9b9d..171b7e09ed 100644
> > --- a/scripts/tracetool/backend/dtrace.py
> > +++ b/scripts/tracetool/backend/dtrace.py
> > @@ -61,7 +61,8 @@ def generate_h_begin(events, group):
> >              '#endif',
> >              uppername=3De.name.upper())
> >
> > -def generate_h(event, group):
> > +
>
> stray newline
>
> > +def generate_h_unconditional(event, group):
> >      out('    QEMU_%(uppername)s(%(argnames)s);',
> >          uppername=3Devent.name.upper(),
> >          argnames=3D", ".join(event.args.names()))
> > diff --git a/scripts/tracetool/backend/ust.py
> b/scripts/tracetool/backend/ust.py
> > index c857516f21..1564b490ec 100644
> > --- a/scripts/tracetool/backend/ust.py
> > +++ b/scripts/tracetool/backend/ust.py
> > @@ -30,7 +30,7 @@ def generate_h_begin(events, group):
> >          '')
> >
> >
> > -def generate_h(event, group):
> > +def generate_h_unconditional(event, group):
> >      argnames =3D ", ".join(event.args.names())
> >      if len(event.args) > 0:
> >          argnames =3D ", " + argnames
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
> Otherwise:
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

--000000000000e0788e0637db0cba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt; Please fix the word wrap on the commit at 78 chars.<d=
iv>I will send v2 with this fix</div><div>&gt;=C2=A0<span style=3D"white-sp=
ace:unset">stray newline</span></div><div>In=C2=A0<code>tracetool/backend</=
code>, every function is followed by two newline characters.</div></div><br=
><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D=
"gmail_attr">On Wed, Jun 18, 2025 at 4:12=E2=80=AFAM Alex Benn=C3=A9e &lt;<=
a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Tanish Desai=
 &lt;<a href=3D"mailto:tanishdesai37@gmail.com" target=3D"_blank">tanishdes=
ai37@gmail.com</a>&gt; writes:<br>
<br>
&gt; This patch separates the generation logic of trace_foo() for the UST a=
nd DTrace backends from other backends.<br>
&gt; The motivation is to remove the unnecessary if (true) in the _no_check=
 function, as UST and DTrace do not require a trace_event_get_state check w=
ithout introducing a seperate function it is very difficult to generate cod=
e which keeps them out of unified if condition.<br>
&gt; With this separation, we can safely move the trace_event_get_state che=
ck into trace_foo for the other backends only, keeping UST/DTrace generatio=
n paths clean.<br>
&gt; A new generate_h_unconditional function has been introduced for UST<br=
>
&gt; and DTrace. It behaves similarly to generate_h, but is defined only in=
<br>
&gt; UST and DTrace backends. This ensures that generate_h is used by the<b=
r>
&gt; other backends, while UST/DTrace selectively use<br>
&gt; generate_h_unconditional.<br>
<br>
Please fix the word wrap on the commit at 78 chars.<br>
<br>
&gt;<br>
&gt; Signed-off-by: Tanish Desai &lt;<a href=3D"mailto:tanishdesai37@gmail.=
com" target=3D"_blank">tanishdesai37@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/tracetool/backend/__init__.py |=C2=A0 3 +++<br>
&gt;=C2=A0 scripts/tracetool/backend/dtrace.py=C2=A0 =C2=A0|=C2=A0 3 ++-<br=
>
&gt;=C2=A0 scripts/tracetool/backend/ust.py=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +=
-<br>
&gt;=C2=A0 scripts/tracetool/format/h.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 10 +++++++---<br>
&gt;=C2=A0 4 files changed, 13 insertions(+), 5 deletions(-)<br>
&gt;<br>
&gt; diff --git a/scripts/tracetool/backend/__init__.py b/scripts/tracetool=
/backend/__init__.py<br>
&gt; index 7bfcc86cc5..c4456a5efd 100644<br>
&gt; --- a/scripts/tracetool/backend/__init__.py<br>
&gt; +++ b/scripts/tracetool/backend/__init__.py<br>
&gt; @@ -118,6 +118,9 @@ def generate_begin(self, events, group):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def generate(self, event, group):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._run_function(&quot;generate_%s=
&quot;, event, group)<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 def generate_unconditional(self, event, group):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._run_function(&quot;generate_%s_unco=
nditional&quot;, event, group)<br>
&gt; +=C2=A0 =C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def generate_backend_dstate(self, event, group):<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._run_function(&quot;generate_%s=
_backend_dstate&quot;, event, group)<br>
&gt;=C2=A0 <br>
&gt; diff --git a/scripts/tracetool/backend/dtrace.py b/scripts/tracetool/b=
ackend/dtrace.py<br>
&gt; index e17edc9b9d..171b7e09ed 100644<br>
&gt; --- a/scripts/tracetool/backend/dtrace.py<br>
&gt; +++ b/scripts/tracetool/backend/dtrace.py<br>
&gt; @@ -61,7 +61,8 @@ def generate_h_begin(events, group):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;#endif&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uppername=3De.name.upp=
er())<br>
&gt;=C2=A0 <br>
&gt; -def generate_h(event, group):<br>
&gt; +<br>
<br>
stray newline<br>
<br>
&gt; +def generate_h_unconditional(event, group):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 out(&#39;=C2=A0 =C2=A0 QEMU_%(uppername)s(%(argnam=
es)s);&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uppername=3Devent.name.upper(),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argnames=3D&quot;, &quot;.join(event=
.args.names()))<br>
&gt; diff --git a/scripts/tracetool/backend/ust.py b/scripts/tracetool/back=
end/ust.py<br>
&gt; index c857516f21..1564b490ec 100644<br>
&gt; --- a/scripts/tracetool/backend/ust.py<br>
&gt; +++ b/scripts/tracetool/backend/ust.py<br>
&gt; @@ -30,7 +30,7 @@ def generate_h_begin(events, group):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;&#39;)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt; -def generate_h(event, group):<br>
&gt; +def generate_h_unconditional(event, group):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 argnames =3D &quot;, &quot;.join(event.args.names(=
))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if len(event.args) &gt; 0:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argnames =3D &quot;, &quot; + argnam=
es<br>
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
Otherwise:<br>
<br>
Reviewed-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org"=
 target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div>

--000000000000e0788e0637db0cba--


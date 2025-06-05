Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E6AFC5B549
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 03:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN0se-0005yk-VC; Wed, 04 Jun 2025 23:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uN0sd-0005yL-9f
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 23:02:59 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uN0sb-0003B0-60
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 23:02:59 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-adb5cb6d8f1so83700966b.3
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 20:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749092574; x=1749697374; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T9/CI6xBOq1PIQDP2Ptci3U1SuMG+mMXOb5yZKoV11c=;
 b=K7corblBjTnxzInqxSiByPi0lz/UtzuLuNw0rafhvcO1lna8vXQIK1ZgXbSIL3465/
 SIJSCYClJX3G+EIjCNRO9Y+p7uZckUoFGVmvU7geikNsSNrcafvuQBBdF9Z5tblIkHUF
 azTcoIfzNgJ/uHs41YtvuKTbOgN7i1oRWvEFNsv4YYrOwwwHYjTK8Osd40aRqO3BInXC
 kCxmWgpmD+Hair2i412naw7incXBtAMllHh7m3mrss8bYgyhL5sgQYTuLI1KH23SkW/e
 J6wy5qOXblSaAuhH2v0Leua/itqvk426gQT0OsqocuSNftE3LjJ06maOuGW52GQYnC+D
 kHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749092574; x=1749697374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T9/CI6xBOq1PIQDP2Ptci3U1SuMG+mMXOb5yZKoV11c=;
 b=pLyQfCO1eKhwvx49CoytET/dmMthgEA56v9aDMTckY54XrJJlOJzz4RbG6M116Kvlr
 7w2CWy9I7fNhdhGPgZbB8lZ4/lppwEqOZRd5e5cPw2x2kG9YOPbLIftmHDN3LZDZZXcT
 ts7PyU978pkYdy6ldH+LvkBoP830WOJ4RT37H/6jcVy7MGfbWyHJRnL00DeW+hJItjYT
 djiBmESDF4UPFm/i8hH+cBwZFWJ7w+VsNhv6oONWyhN14R0s3M2Wy+x/15ThmmbtRROa
 SFOw/EfGaS6JWV73JOJFD45PB9CjlkefRRjYSkcmGxfzlfU199mWy0pOki3AqLYfDn2H
 8x/g==
X-Gm-Message-State: AOJu0Ywiar1vtZwak5fLWrdRlQLA7FFZKvlB2ydfh+VejNt4eWV61TUb
 NrCtcIzMD5FzTqBcs6YGJ7gvp2RSkfO+9N2EboiPS/eiEfznUh1NeH4mUS9qzSc8/F8tbvavN8t
 zmjV5fmxBpq7G+9YzvKQZPvqqynvhFow=
X-Gm-Gg: ASbGncsVuuGVP/pJ/VI6O07SNVJJoQHgg5iIWDPLYgDbXcR+w92e9svR6cHdrrtLFbE
 EWx0PgesuNeeH+J392tXVFY+X2PNNpDnsLjvs3Rz5GXQF12EKeJ0KlmzRzhvjefsTr8q1nfz31f
 AEuYR+/sap9nU8ZsW1cgfuxN1o7IG0J49o
X-Google-Smtp-Source: AGHT+IG8Hug1kpUd7uuAB5vi4mFJYgTAgzxC0lNhM/kuS1kOIXbvLabAuj2NEyWvA4BcZcBNaxzb5vB66AicCvadsDI=
X-Received: by 2002:a17:907:9410:b0:ad5:eff:db32 with SMTP id
 a640c23a62f3a-addf8fbbcbamr528728666b.48.1749092574115; Wed, 04 Jun 2025
 20:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250601181231.3461-1-tanishdesai37@gmail.com>
 <20250601181231.3461-2-tanishdesai37@gmail.com>
 <20250602220119.GA320269@fedora>
In-Reply-To: <20250602220119.GA320269@fedora>
From: Tanish Desai <tanishdesai37@gmail.com>
Date: Thu, 5 Jun 2025 08:32:43 +0530
X-Gm-Features: AX0GCFsHCcN45dFNjb_OIWpkacmBFkRj2JSIJcNvXGRPR4Hip3XGMX9__TtiNvc
Message-ID: <CAH_Y1jd8C-WJYs2SimqgtGhmPuxm615J_3ePUWg+TZY=YaWLKw@mail.gmail.com>
Subject: Re: [PATCH 1/3] trace/syslog: seperate cold paths of tracing functions
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, Mads Ynddal <mads@ynddal.dk>
Content-Type: multipart/alternative; boundary="0000000000008f3cd00636ca596f"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=tanishdesai37@gmail.com; helo=mail-ej1-x62a.google.com
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

--0000000000008f3cd00636ca596f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, you're right=E2=80=94there was a mistake in the original commit descri=
ption.
In this change, we're moving cold paths out of the header (.h) files and
into corresponding source (.c) files. The primary motivation is to avoid
replicating the cold path logic across every translation unit that includes
trace.h (which includes trace-*.h headers).
For the syslog backend, which involves only a single function call, this
change won't have a noticeable impact. However, for the ftrace and log
backends, where functions like _ftrace_trace_foo() and _log_trace_foo() con=
tain
more complex logic, this avoids significant duplication. By centralizing
the implementation in .c files, we expect to save memory and reduce binary
size.
Paolo and I are still experimenting to quantify these memory savings. So
far, we haven=E2=80=99t observed substantial gains, but we're refining our
measurements and isolating symbols more carefully to get accurate binary
size comparisons.

On Tue, Jun 3, 2025 at 3:56=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:

> On Sun, Jun 01, 2025 at 06:12:29PM +0000, Tanish Desai wrote:
> > inline: move hot paths from .c to .h for better performance
> > Moved frequently used hot paths from the .c file to the .h file to
> enable inlining
> > and improve performance. This approach is inspired by past QEMU
> optimizations,
> > where performance-critical code was inlined based on profiling results.
> >
> > Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> > ---
> >  scripts/tracetool/backend/syslog.py | 36 +++++++++++++++++++++++------
> >  1 file changed, 29 insertions(+), 7 deletions(-)
>
> This commit description doesn't match what the patch does.
>
> What is the purpose of creating a _syslog_trace_foo() function in the .c
> file instead of calling syslog() directly from the .h file?
>
> >
> > diff --git a/scripts/tracetool/backend/syslog.py
> b/scripts/tracetool/backend/syslog.py
> > index 012970f6cc..52b8ff65ea 100644
> > --- a/scripts/tracetool/backend/syslog.py
> > +++ b/scripts/tracetool/backend/syslog.py
> > @@ -21,8 +21,12 @@
> >
> >
> >  def generate_h_begin(events, group):
> > -    out('#include <syslog.h>',
> > -        '')
> > +    out('#include <syslog.h>')
> > +    for event in events:
> > +        out('void _syslog_%(api)s(%(args)s);',
> > +            api=3Devent.api(),
> > +            args=3Devent.args)
> > +    out('')
> >
> >
> >  def generate_h(event, group):
> > @@ -37,17 +41,35 @@ def generate_h(event, group):
> >          cond =3D "trace_event_get_state(%s)" % ("TRACE_" +
> event.name.upper())
> >
> >      out('    if (%(cond)s) {',
> > -        '#line %(event_lineno)d "%(event_filename)s"',
> > -        '        syslog(LOG_INFO, "%(name)s " %(fmt)s %(argnames)s);',
> > -        '#line %(out_next_lineno)d "%(out_filename)s"',
> > +            '       _syslog_%(api)s(%(args)s);',
> >          '    }',
> >          cond=3Dcond,
> >          event_lineno=3Devent.lineno,
> >          event_filename=3Dos.path.relpath(event.filename),
> >          name=3Devent.name,
> >          fmt=3Devent.fmt.rstrip("\n"),
> > -        argnames=3Dargnames)
> > -
> > +        argnames=3Dargnames,
> > +        api=3Devent.api(),
> > +        args=3D", ".join(event.args.names()))
> > +
> > +
> > +def generate_c(event, group):
> > +        argnames =3D ", ".join(event.args.names())
> > +        if len(event.args) > 0:
> > +            argnames =3D ", " + argnames
> > +        out('void _syslog_%(api)s(%(args)s){',
> > +        '   #line %(event_lineno)d "%(event_filename)s"',
> > +        '            syslog(LOG_INFO, "%(name)s " %(fmt)s
> %(argnames)s);',
> > +        '   #line %(out_next_lineno)d "%(out_filename)s"',
> > +        '}',
> > +        '',
> > +        event_lineno=3Devent.lineno,
> > +        event_filename=3Dos.path.relpath(event.filename),
> > +        name=3Devent.name,
> > +        fmt=3Devent.fmt.rstrip("\n"),
> > +        argnames=3Dargnames,
> > +        api=3Devent.api(),
> > +        args=3Devent.args)
> >
> >  def generate_h_backend_dstate(event, group):
> >      out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
> > --
> > 2.34.1
> >
>

--0000000000008f3cd00636ca596f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Yes, you&#39;re right=E2=80=94there was a mistake in the o=
riginal commit description.<br><span style=3D"white-space:unset">In this ch=
ange, we&#39;re moving cold paths out of the header (</span><code style=3D"=
white-space:unset">.h</code><span style=3D"white-space:unset">) files and i=
nto corresponding source (</span><code style=3D"white-space:unset">.c</code=
><span style=3D"white-space:unset">) files. The primary motivation is to av=
oid replicating the cold path logic across every translation unit that incl=
udes=C2=A0</span><code style=3D"white-space:unset">trace.h</code><span styl=
e=3D"white-space:unset">=C2=A0(which includes=C2=A0</span><code style=3D"wh=
ite-space:unset">trace-*.h</code><span style=3D"white-space:unset">=C2=A0he=
aders).<br></span><span style=3D"white-space:unset">For the syslog backend,=
 which involves only a single function call, this change won&#39;t have a n=
oticeable impact. However, for the ftrace and log backends, where functions=
 like=C2=A0</span><code style=3D"white-space:unset">_ftrace_trace_foo()</co=
de><span style=3D"white-space:unset">=C2=A0and=C2=A0</span><code style=3D"w=
hite-space:unset">_log_trace_foo()</code><span style=3D"white-space:unset">=
=C2=A0contain more complex logic, this avoids significant duplication. By c=
entralizing the implementation in=C2=A0</span><code style=3D"white-space:un=
set">.c</code><span style=3D"white-space:unset">=C2=A0files, we expect to s=
ave memory and reduce binary size.<br></span><span style=3D"white-space:uns=
et">Paolo and I are still experimenting to quantify these memory savings. S=
o far, we haven=E2=80=99t observed substantial gains, but we&#39;re refinin=
g our measurements and isolating symbols more carefully to get accurate bin=
ary size comparisons.</span></div><br><div class=3D"gmail_quote gmail_quote=
_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 3, 2025 at 3:=
56=E2=80=AFAM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">st=
efanha@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On Sun, Jun 01, 2025 at 06:12:29PM +0000, Tanish Desai wro=
te:<br>
&gt; inline: move hot paths from .c to .h for better performance<br>
&gt; Moved frequently used hot paths from the .c file to the .h file to ena=
ble inlining<br>
&gt; and improve performance. This approach is inspired by past QEMU optimi=
zations,<br>
&gt; where performance-critical code was inlined based on profiling results=
.<br>
&gt; <br>
&gt; Signed-off-by: Tanish Desai &lt;<a href=3D"mailto:tanishdesai37@gmail.=
com" target=3D"_blank">tanishdesai37@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/tracetool/backend/syslog.py | 36 +++++++++++++++++++++++=
------<br>
&gt;=C2=A0 1 file changed, 29 insertions(+), 7 deletions(-)<br>
<br>
This commit description doesn&#39;t match what the patch does.<br>
<br>
What is the purpose of creating a _syslog_trace_foo() function in the .c<br=
>
file instead of calling syslog() directly from the .h file?<br>
<br>
&gt; <br>
&gt; diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/b=
ackend/syslog.py<br>
&gt; index 012970f6cc..52b8ff65ea 100644<br>
&gt; --- a/scripts/tracetool/backend/syslog.py<br>
&gt; +++ b/scripts/tracetool/backend/syslog.py<br>
&gt; @@ -21,8 +21,12 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 def generate_h_begin(events, group):<br>
&gt; -=C2=A0 =C2=A0 out(&#39;#include &lt;syslog.h&gt;&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;&#39;)<br>
&gt; +=C2=A0 =C2=A0 out(&#39;#include &lt;syslog.h&gt;&#39;)<br>
&gt; +=C2=A0 =C2=A0 for event in events:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 out(&#39;void _syslog_%(api)s(%(args)s);&=
#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 api=3Devent.api(),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 args=3Devent.args)<br>
&gt; +=C2=A0 =C2=A0 out(&#39;&#39;)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 def generate_h(event, group):<br>
&gt; @@ -37,17 +41,35 @@ def generate_h(event, group):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cond =3D &quot;trace_event_get_state=
(%s)&quot; % (&quot;TRACE_&quot; + event.name.upper())<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 out(&#39;=C2=A0 =C2=A0 if (%(cond)s) {&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;#line %(event_lineno)d &quot;%(event=
_filename)s&quot;&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 syslog(L=
OG_INFO, &quot;%(name)s &quot; %(fmt)s %(argnames)s);&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;#line %(out_next_lineno)d &quot;%(ou=
t_filename)s&quot;&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0_syslog_%(api)s(%(args)s);&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;=C2=A0 =C2=A0 }&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cond=3Dcond,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 event_lineno=3Devent.lineno,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 event_filename=3Dos.path.relpath(eve=
nt.filename),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D<a href=3D"http://event.name"=
 rel=3D"noreferrer" target=3D"_blank">event.name</a>,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fmt=3Devent.fmt.rstrip(&quot;\n&quot=
;),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 argnames=3Dargnames)<br>
&gt; -<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 argnames=3Dargnames,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 api=3Devent.api(),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 args=3D&quot;, &quot;.join(event.args.nam=
es()))<br>
&gt; +<br>
&gt; +<br>
&gt; +def generate_c(event, group):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 argnames =3D &quot;, &quot;.join(event.ar=
gs.names())<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(event.args) &gt; 0:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argnames =3D &quot;, &quot;=
 + argnames<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 out(&#39;void _syslog_%(api)s(%(args)s){&=
#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;=C2=A0 =C2=A0#line %(event_lineno)d =
&quot;%(event_filename)s&quot;&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 syslog(LOG_INFO, &quot;%(name)s &quot; %(fmt)s %(argnames)s);&#39;,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;=C2=A0 =C2=A0#line %(out_next_lineno=
)d &quot;%(out_filename)s&quot;&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;}&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 event_lineno=3Devent.lineno,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 event_filename=3Dos.path.relpath(event.fi=
lename),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 name=3D<a href=3D"http://event.name" rel=
=3D"noreferrer" target=3D"_blank">event.name</a>,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fmt=3Devent.fmt.rstrip(&quot;\n&quot;),<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 argnames=3Dargnames,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 api=3Devent.api(),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 args=3Devent.args)=C2=A0 =C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 def generate_h_backend_dstate(event, group):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 out(&#39;=C2=A0 =C2=A0 trace_event_get_state_dynam=
ic_by_id(%(event_id)s) || \\&#39;,<br>
&gt; -- <br>
&gt; 2.34.1<br>
&gt; <br>
</blockquote></div>

--0000000000008f3cd00636ca596f--


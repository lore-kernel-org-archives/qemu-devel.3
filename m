Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40736C02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 20:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXQqW-00032s-Pl; Mon, 13 Jan 2025 15:15:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tXQqG-00031u-HE
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 15:15:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tXQqE-0001Wq-JC
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 15:15:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736799314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UF9LJ4jFyC9UC7/kDaX2KKGEGLe2P4mcVoujeqOofqs=;
 b=fxX5Fg3zP9mpZXi8hGtAuKGFJuS765TTt2IuvKCCo2UVlGPqj8MSNEHq65T1sISYLjB9hT
 YtjHY3NiaTkq6wz+uqc/AZpqK0O7C63i/1aHF8Md9AuVy7HLsH5/6odfOs6VxJV2cIKklY
 1rQzYL85W4nMSZF9sL4fs9UIzEqKlFA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-3r8CtjZfPdONWO0M6PWm2w-1; Mon, 13 Jan 2025 15:15:12 -0500
X-MC-Unique: 3r8CtjZfPdONWO0M6PWm2w-1
X-Mimecast-MFC-AGG-ID: 3r8CtjZfPdONWO0M6PWm2w
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ef9da03117so12256264a91.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 12:15:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736799311; x=1737404111;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UF9LJ4jFyC9UC7/kDaX2KKGEGLe2P4mcVoujeqOofqs=;
 b=sQfPXcMyYIvEw/cl9Z6smFFbAGvqU1tqduk2OEi82f4EJ2octaeQ+aeQcDyL8INHgo
 BH6MpUUAslhgRkcgPPgm+YG/yOqF6bwCzdpzGbAOdkwG3WYOYviUsIOu12fOM3S6Z+qA
 MUmdazHEj1s5y2HQWqgsIsUzRvF854zzc+p+4JZZXP2eumOd7nRYQZZcV40JCk7UdBzo
 vIEUU+0s3oFadf0GML6o/9Ebh6+SYhBmBQYNY6G3QJ8FwXMeZePagk6DtPG2xswD8uZ/
 QqT56l0kigviPswLzy2NR/h27X/8ibJSPQWLksPI0ASfbT4cp8dAuvOHhksu6e2S8pjg
 M1UQ==
X-Gm-Message-State: AOJu0Yx6VRdJU9KAvdCL8k9SsN4Y9lpn6asm2zbxVOMNaOayT8F+Zg4y
 t+n4ArO7dxREnNnGonLdczJuC9oj2pmYhtykjoiOaut/bInEmlBm+tse5YE5no3jZQxXhySRqa+
 UAom4Exn/Q6vrg6dYXVb+LOt6+74lgeyq/OoDGwZCcksQP6eWekhizfLY8LAMtzOHd+16GSngf5
 F7ttp81JWRARmdekAdgHAuc5pev4c=
X-Gm-Gg: ASbGncs/UIQSQFibc2AxmV4HTsN43m3IlCZqoxH/YXAdtRu2jabLzCzbSHW1/2LsoDt
 PO/E1KDy1fsOSOIBndzmDBzaRP/kBBWQdeVSUPzmbY+b13Ia5BiHkTROLs4EORHAJSr/mLQ==
X-Received: by 2002:a17:90b:540f:b0:2ee:dcf6:1c8f with SMTP id
 98e67ed59e1d1-2f548eb3c95mr35373654a91.16.1736799311452; 
 Mon, 13 Jan 2025 12:15:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwvlSOV+PpdbbrettoMYc/h9T4Z1MLL/qi1GMoQXvmXUda2REdhcOwSHpMR9AWcBFUThNoNXbLIJGAO7mdqzE=
X-Received: by 2002:a17:90b:540f:b0:2ee:dcf6:1c8f with SMTP id
 98e67ed59e1d1-2f548eb3c95mr35373614a91.16.1736799311030; Mon, 13 Jan 2025
 12:15:11 -0800 (PST)
MIME-Version: 1.0
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-11-jsnow@redhat.com>
 <87cyhm4hcc.fsf@pond.sub.org>
In-Reply-To: <87cyhm4hcc.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 13 Jan 2025 15:14:59 -0500
X-Gm-Features: AbW1kvYJb9mK9agbhrrPAxQNrar56zO1gAF6tgobxT7hWf_b829LUxZkZsSIIXg
Message-ID: <CAFn=p-ZgT51ZCMHSt3Ot=5iOTPX8v8wM+89B-9JCkVDrT-4EDg@mail.gmail.com>
Subject: Re: [PATCH 10/23] docs/qapidoc: add visit_freeform() method
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000fb0421062b9c1960"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.019,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.787,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000fb0421062b9c1960
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 8:25=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py | 47 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index 7d2f7bfb415..6f8f69077b1 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -133,6 +133,53 @@ def visit_module(self, path: str) -> None:
> >          self.add_line_raw(f".. qapi:module:: {name}", path, 1)
> >          self.ensure_blank_line()
> >
> > +    def visit_freeform(self, doc) -> None:
> > +        # Once the old qapidoc transformer is deprecated,
> > +        # freeform sections can be transformed into pure rST.
> > +        #
> > +        # For now, translate our micro-format into rST.
> > +        # Code adapted from Peter Maydell's freeform().
> > +
> > +        assert len(doc.all_sections) =3D=3D 1, doc.all_sections
> > +        body =3D doc.all_sections[0]
> > +        text =3D body.text
> > +        info =3D doc.info
> > +
> > +        if re.match(r"=3D+ ", text):
> > +            # Section/subsection heading (if present, will always be t=
he
> > +            # first line of the block)
> > +            (heading, _, text) =3D text.partition("\n")
> > +            (leader, _, heading) =3D heading.partition(" ")
> > +            level =3D len(leader) + 1  # Implicit +1 for heading in .r=
ST
> stub
> > +
> > +            #
> https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#s=
ections
> > +            markers =3D {
> > +                1: "#",
> > +                2: "*",
> > +                3: "=3D",
> > +                4: "-",
> > +                5: "^",
> > +                6: '"',
> > +            }
> > +            overline =3D level <=3D 2
> > +            marker =3D markers[level]
> > +
> > +            self.ensure_blank_line()
> > +            # This credits all 2 or 3 lines to the single source line.
> > +            if overline:
> > +                self.add_line(marker * len(heading), info)
> > +            self.add_line(heading, info)
> > +            self.add_line(marker * len(heading), info)
> > +            self.ensure_blank_line()
> > +
> > +            # Eat blank line(s) and advance info
> > +            trimmed =3D text.lstrip("\n")
> > +            text =3D trimmed
> > +            info =3D info.next_line(len(text) - len(trimmed) + 1)
>
> We could instead eat newlines one at a time, calling .next_line()
> without an argument for each newline eaten.  Less efficient, but won't
> matter here.  Possibly easier to understand.
>

Eh, I'm gonna delete this later anyway. Will send v2 without touching this,
but I can touch it for next time if it still bothers you.

--js

--000000000000fb0421062b9c1960
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Dec 20,=
 2024 at 8:25=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapidoc.py | 47 ++++++++++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 1 file changed, 47 insertions(+)<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
&gt; index 7d2f7bfb415..6f8f69077b1 100644<br>
&gt; --- a/docs/sphinx/qapidoc.py<br>
&gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt; @@ -133,6 +133,53 @@ def visit_module(self, path: str) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_line_raw(f&quot;.. qapi:mod=
ule:: {name}&quot;, path, 1)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ensure_blank_line()<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 def visit_freeform(self, doc) -&gt; None:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Once the old qapidoc transformer is dep=
recated,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # freeform sections can be transformed in=
to pure rST.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # For now, translate our micro-format int=
o rST.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Code adapted from Peter Maydell&#39;s f=
reeform().<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert len(doc.all_sections) =3D=3D 1, do=
c.all_sections<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 body =3D doc.all_sections[0]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 text =3D body.text<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 info =3D <a href=3D"http://doc.info" rel=
=3D"noreferrer" target=3D"_blank">doc.info</a><br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if re.match(r&quot;=3D+ &quot;, text):<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Section/subsection headin=
g (if present, will always be the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # first line of the block)<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (heading, _, text) =3D text=
.partition(&quot;\n&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (leader, _, heading) =3D he=
ading.partition(&quot; &quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 level =3D len(leader) + 1=
=C2=A0 # Implicit +1 for heading in .rST stub<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # <a href=3D"https://www.sp=
hinx-doc.org/en/master/usage/restructuredtext/basics.html#sections" rel=3D"=
noreferrer" target=3D"_blank">https://www.sphinx-doc.org/en/master/usage/re=
structuredtext/basics.html#sections</a><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 markers =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1: &quot;#&qu=
ot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2: &quot;*&qu=
ot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3: &quot;=3D&=
quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4: &quot;-&qu=
ot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 5: &quot;^&qu=
ot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6: &#39;&quot=
;&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 overline =3D level &lt;=3D =
2<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 marker =3D markers[level]<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ensure_blank_line()<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # This credits all 2 or 3 l=
ines to the single source line.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if overline:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_line=
(marker * len(heading), info)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_line(heading, info=
)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_line(marker * len(=
heading), info)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ensure_blank_line()<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Eat blank line(s) and adv=
ance info<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trimmed =3D text.lstrip(&qu=
ot;\n&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 text =3D trimmed<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info =3D info.next_line(len=
(text) - len(trimmed) + 1)<br>
<br>
We could instead eat newlines one at a time, calling .next_line()<br>
without an argument for each newline eaten.=C2=A0 Less efficient, but won&#=
39;t<br>
matter here.=C2=A0 Possibly easier to understand.<br></blockquote><div><br>=
</div><div>Eh, I&#39;m gonna delete this later anyway. Will send v2 without=
 touching this, but I can touch it for next time if it still bothers you.</=
div><div><br></div><div>--js<br></div></div></div>

--000000000000fb0421062b9c1960--



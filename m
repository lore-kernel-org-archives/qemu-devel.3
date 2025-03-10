Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78029C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 21:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trkPh-0006g8-Qf; Mon, 10 Mar 2025 17:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trkPf-0006ft-RC
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 17:11:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trkPd-0006W3-IE
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 17:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741641107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n271/XLA3YJp0HpqjEDCo92Y9lVbl8uZZIZLocA/c4E=;
 b=KQOBnJjJmQK6DvppJxj1hQ4utQZJzwEAp/q5IaFTusRsh0KR7PEYr3L2qd4jqbThxyMem1
 mIkyw32JH+9nmllMVlNhucQZeF2J/jqDkFTagE9hS2KmM4e37vEn3mWcThyY/Wjh5Q6HZ0
 wmSIuhp4QeQ+p2PQYIwJL1LMMQDdGCs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-r8ToePeqPQCe0lESumpsMA-1; Mon, 10 Mar 2025 17:11:45 -0400
X-MC-Unique: r8ToePeqPQCe0lESumpsMA-1
X-Mimecast-MFC-AGG-ID: r8ToePeqPQCe0lESumpsMA_1741641105
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ff581215f7so7801274a91.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 14:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741641105; x=1742245905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n271/XLA3YJp0HpqjEDCo92Y9lVbl8uZZIZLocA/c4E=;
 b=iqNICZn8KlCoPrZ+3U0e7Kq0gsjY1vHZooQ+MCFunyiXotWZXOJ+x4vmf5CNcq8Avj
 PZtvIwu7NslkHsZrb7w3zfQvw64Jd8lgpWVKGvNbuB7R61I8OhlJqRZ+dBiCoSOINRda
 Q6zh2+WvPg/LLYxEQMqTPArCRUU/WBwtGcBDjv82996WHHvbHV4Lk4OIFLImFEjbLKrZ
 QojXreqohJ+VxD0D6lpARb0mslJPPrtlzZ+PSFrYcDkQLA/CUciJJok1uC+OkeooltJQ
 4CwOqN0K7Yj/zk0QuDsRu1Md6+PMq3F0K8xGeBFglAaRIn6AYy7oSXfy9B9NSdxzKTkC
 fN6g==
X-Gm-Message-State: AOJu0Yy6vp3ktjM7DQI21BHmTJWYZmUtQ/knNwf07FlrSR4BUWtQRbrv
 P4I5OzGSBIMsYRwLZooZkbI6gvFdEwibA7bQajtNSVD8Yqxx77/RdXkJWKc+pIEHxueHZ+zJUYb
 0HviMmLQ4f6pF05SPNgvO1VI1iEBZzPk5Vk+ULuMPoHoF0tHAoo1RsK6HHPQOH5nmnV8+zxMiSS
 PuwowdvFCi23eoLnB9J7QwtWuoOcs=
X-Gm-Gg: ASbGncuHab0Ev7mlLPV/zAoYe6KHWgraYqwAbL0YJWtS1Q2B1OyOwgcQm+JWKBNc7d4
 gTwwnJgEAYfPQByqOcftIwLCu95+uCbefUoYtEn3FjGGZDdtwKM6SlYnZoLfX64+tdhKZG+GMub
 uzaKiGAoefSyK4VgaRRHc+IH+e1RGm
X-Received: by 2002:a17:90a:d605:b0:2ee:db8a:2a01 with SMTP id
 98e67ed59e1d1-2ff7cf128cdmr21599525a91.30.1741641104689; 
 Mon, 10 Mar 2025 14:11:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIkyEUWBkz2K4PLD9AD4qpIBT5sD1pThPzetg3NWWivTb+Dw95Cw/48rvN2eTRi5Y9Rj7zkPaJqonYd8HH9HQ=
X-Received: by 2002:a17:90a:d605:b0:2ee:db8a:2a01 with SMTP id
 98e67ed59e1d1-2ff7cf128cdmr21599494a91.30.1741641104286; Mon, 10 Mar 2025
 14:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250309083550.5155-1-jsnow@redhat.com>
 <20250309083550.5155-43-jsnow@redhat.com>
 <87frjlzzoi.fsf@pond.sub.org>
In-Reply-To: <87frjlzzoi.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 10 Mar 2025 17:11:32 -0400
X-Gm-Features: AQ5f1JqzUwRQA2sWZJMbNSpCN8YPwgxfoieOWrMKrDXqj9OhJbkgXzV_T2lW0Y4
Message-ID: <CAFn=p-aPGZ89OT4zVV5dqnehZ9Fp5-9MkV=_4k7mbXqZ4mqudA@mail.gmail.com>
Subject: Re: [PATCH v2 42/62] docs/qapidoc: add visit_freeform() method
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000058fc960630036b1f"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--00000000000058fc960630036b1f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 5:01=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py | 50 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index 6de8c900543..cf5dbb0133d 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -29,6 +29,7 @@
> >  from contextlib import contextmanager
> >  import os
> >  from pathlib import Path
> > +import re
> >  import sys
> >  from typing import TYPE_CHECKING
> >
> > @@ -55,6 +56,8 @@
> >          Sequence,
> >      )
> >
> > +    from qapi.parser import QAPIDoc
> > +
> >      from sphinx.application import Sphinx
> >      from sphinx.util.typing import ExtensionMetadata
> >
> > @@ -130,6 +133,53 @@ def visit_module(self, path: str) -> None:
> >          self.add_line_raw(f".. qapi:module:: {name}", path, 1)
> >          self.ensure_blank_line()
> >
> > +    def visit_freeform(self, doc: QAPIDoc) -> None:
> > +        # TODO: Once the old qapidoc transformer is deprecated, freefo=
rm
> > +        # sections can be updated to pure rST, and this transformed
> removed.
> > +        #
> > +        # For now, translate our micro-format into rST. Code adapted
> > +        # from Peter Maydell's freeform().
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
>
> I find "in .rST stub" less than clear.  Could we use the filename?
>

No, because the filename is "wherever the qapi-doc directive is written". I
adjusted the comment and will re-spin.


>
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
>
> Suggest
>
>                markers =3D '#*=3D-^".
>

Done.


>
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
> > +
> > +        self.add_lines(text, info)
> > +        self.ensure_blank_line()
> > +
> >
> >  class QAPISchemaGenDepVisitor(QAPISchemaVisitor):
> >      """A QAPI schema visitor which adds Sphinx dependencies each modul=
e
>
>

--00000000000058fc960630036b1f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Mar 9, =
2025 at 5:01=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapidoc.py | 50 ++++++++++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 1 file changed, 50 insertions(+)<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
&gt; index 6de8c900543..cf5dbb0133d 100644<br>
&gt; --- a/docs/sphinx/qapidoc.py<br>
&gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt; @@ -29,6 +29,7 @@<br>
&gt;=C2=A0 from contextlib import contextmanager<br>
&gt;=C2=A0 import os<br>
&gt;=C2=A0 from pathlib import Path<br>
&gt; +import re<br>
&gt;=C2=A0 import sys<br>
&gt;=C2=A0 from typing import TYPE_CHECKING<br>
&gt;=C2=A0 <br>
&gt; @@ -55,6 +56,8 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Sequence,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 )<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 from qapi.parser import QAPIDoc<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 from sphinx.application import Sphinx<br>
&gt;=C2=A0 =C2=A0 =C2=A0 from sphinx.util.typing import ExtensionMetadata<b=
r>
&gt;=C2=A0 <br>
&gt; @@ -130,6 +133,53 @@ def visit_module(self, path: str) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_line_raw(f&quot;.. qapi:mod=
ule:: {name}&quot;, path, 1)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ensure_blank_line()<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 def visit_freeform(self, doc: QAPIDoc) -&gt; None:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # TODO: Once the old qapidoc transformer =
is deprecated, freeform<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # sections can be updated to pure rST, an=
d this transformed removed.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # For now, translate our micro-format int=
o rST. Code adapted<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # from Peter Maydell&#39;s freeform().<br=
>
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
<br>
I find &quot;in .rST stub&quot; less than clear.=C2=A0 Could we use the fil=
ename?<br></blockquote><div><br></div><div>No, because the filename is &quo=
t;wherever the qapi-doc directive is written&quot;. I adjusted the comment =
and will re-spin.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
<br>
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
<br>
Suggest<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0markers =3D &#39;#*=
=3D-^&quot;.<br></blockquote><div><br></div><div>Done.</div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
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
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_lines(text, info)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ensure_blank_line()<br>
&gt; +<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 class QAPISchemaGenDepVisitor(QAPISchemaVisitor):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;A QAPI schema visitor which adds=
 Sphinx dependencies each module<br>
<br>
</blockquote></div></div>

--00000000000058fc960630036b1f--



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F7FC282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 06:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trARU-0006QI-4u; Sun, 09 Mar 2025 01:47:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trARL-0006Pi-CP
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 01:47:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trARI-0004Mg-13
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 01:47:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741502824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L2FU/pvjs1DZxasK1ePwUu4NaGpNTy30ZAuLbmRvR6w=;
 b=YPMasSj8aWv9n7U7aFirLCcuAJgywfkYz0IScukqbB/bXQ/5xv1fjUWacOEeH7BxBCPGPx
 1mn+txFEoc3qX31de5nqGbN9plJqsw56wil/kvzs5NmNgQxsxXYYkkJkbE+EWMV4Zf+vwF
 FVhXzAs9x3FwIaihkzidGD/Huf8cU88=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-JhiB9VPjMXm07aGhS7bYvw-1; Sun, 09 Mar 2025 01:47:02 -0500
X-MC-Unique: JhiB9VPjMXm07aGhS7bYvw-1
X-Mimecast-MFC-AGG-ID: JhiB9VPjMXm07aGhS7bYvw_1741502822
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ff5f3be6e6so5456715a91.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 22:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741502822; x=1742107622;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L2FU/pvjs1DZxasK1ePwUu4NaGpNTy30ZAuLbmRvR6w=;
 b=k5hjRjDevKBqyDB1mObd1lYSKwcXaXSpEN4a8dv925BEWxMkXuHXEXL5r1kgkajRWp
 Vir0iRVsC612n05IVCnSzbx5OOlwAuKekYYmsORzceSOMk0oZaUwtMQ+qF3jl7HEqbOI
 bliCsjJgMfJOkridgQjRk/spcz1QpUI9fbP2uNKdKssgnctLVFxfXf8m4E66Ng9hAju8
 KtmwiKVebVOrULAt+N2A8KTScTGNDdoqUiu4rLX1zaz79Lm6kJfBcCq83goOw2GPkFyL
 3ipfqB5qCbVgfNR7rcKs4FpOQ8gCbw5lty0IyolnO3DnX+6knks3fhv//0jng6HDS6gI
 PBaA==
X-Gm-Message-State: AOJu0YzRU8Qr8j3ozE8Vgqwo9F2uKyy4dH6+sQ7CoDu04p3qxgrZQFkQ
 dLiqHguaKMcZ9aYORX9UT0wahtlR+FE6bLKg+NR2bfRcVnpns5t8ghr+4XvyhhdWVgHwjIvJAEX
 QeP2mC0qDmrRBFQC0P3dGiPf/SFHtpytmDCgjT4jRTi1vPhRS2RQmZ+djD2qjVRN3P18iGH4CrE
 7V2DahWvEb6jyxjThAD/Vn9Megias=
X-Gm-Gg: ASbGncvx2VN3CDzkx9NaGcjYd9d7kLiQvT4hxX1r+L7E5WOVcGEjKmf0CFHxa/ahvGq
 jbA9zoK5Zh9AVqrkHMS0bW4YykxyhEb0D+ILL3R9gAnGJX6/YkB7YEqZwM5Joi05yIyfWKA==
X-Received: by 2002:a17:90b:1d0a:b0:2ea:aa56:499 with SMTP id
 98e67ed59e1d1-2ff7ce4f019mr14013088a91.1.1741502821719; 
 Sat, 08 Mar 2025 22:47:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzuUdIuSbDfKNk5zbV6OcLihWm6W6bB2M/WJG/DH83u20kL+s8xPfWx6JkYvLqrdG/keTNnpXO6HKBicHFFxg=
X-Received: by 2002:a17:90b:1d0a:b0:2ea:aa56:499 with SMTP id
 98e67ed59e1d1-2ff7ce4f019mr14013071a91.1.1741502821420; Sat, 08 Mar 2025
 22:47:01 -0800 (PST)
MIME-Version: 1.0
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-36-jsnow@redhat.com>
 <878qphkq4i.fsf@pond.sub.org>
 <CAFn=p-bjiZcLGtaOh01745Qb4zpSWdj8G5LeXBOb8=5Uex-ytQ@mail.gmail.com>
 <878qpe7oi8.fsf@pond.sub.org>
In-Reply-To: <878qpe7oi8.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Sun, 9 Mar 2025 01:46:47 -0500
X-Gm-Features: AQ5f1Jq0EuphOAR4-vDgQ8tZ_jKl8ZbS_6J9dPBxx6EuMEAqxgYzcfO_WWKQHJ8
Message-ID: <CAFn=p-bSPJ+P_VxrHyVVBhp2dF4KNfTTSYniOQDi8RQ8DHbg_Q@mail.gmail.com>
Subject: Re: [PATCH 35/57] docs/qapidoc: Fix static typing on qapidoc.py
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000bf846062fe3390b"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--0000000000000bf846062fe3390b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 12:38=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Fri, Mar 7, 2025 at 7:00=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com>
> wrote:
> >
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > Now that the legacy code is factored out, fix up the typing on the
> >> > remaining code in qapidoc.py. Add a type ignore to qapi_legacy.py to
> >> > prevent the errors there from bleeding out into qapidoc.py.
> >> >
> >> > Signed-off-by: John Snow <jsnow@redhat.com>
> >> > ---
> >> >  docs/sphinx/qapidoc.py        | 40
> ++++++++++++++++++++++-------------
> >> >  docs/sphinx/qapidoc_legacy.py |  1 +
> >> >  2 files changed, 26 insertions(+), 15 deletions(-)
> >> >
> >> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> >> > index f4abf42e7bf..5246832b68c 100644
> >> > --- a/docs/sphinx/qapidoc.py
> >> > +++ b/docs/sphinx/qapidoc.py
> >> > @@ -24,17 +24,18 @@
> >> >  https://www.sphinx-doc.org/en/master/development/index.html
> >> >  """
> >> >
> >> > +from __future__ import annotations
> >> > +
> >> >  import os
> >> >  import sys
> >> > -from typing import List
> >> > +from typing import TYPE_CHECKING
> >> >
> >> >  from docutils import nodes
> >> >  from docutils.parsers.rst import Directive, directives
> >> >  from qapi.error import QAPIError
> >> > -from qapi.gen import QAPISchemaVisitor
> >> > -from qapi.schema import QAPISchema
> >> > +from qapi.schema import QAPISchema, QAPISchemaVisitor
> >> >
> >> > -from qapidoc_legacy import QAPISchemaGenRSTVisitor
> >> > +from qapidoc_legacy import QAPISchemaGenRSTVisitor  # type: ignore
> >> >  from sphinx import addnodes
> >> >  from sphinx.directives.code import CodeBlock
> >> >  from sphinx.errors import ExtensionError
> >> > @@ -42,6 +43,15 @@
> >> >  from sphinx.util.nodes import nested_parse_with_titles
> >> >
> >> >
> >> > +if TYPE_CHECKING:
> >> > +    from typing import Any, List, Sequence
> >> > +
> >> > +    from docutils.statemachine import StringList
> >> > +
> >> > +    from sphinx.application import Sphinx
> >> > +    from sphinx.util.typing import ExtensionMetadata
> >>
> >> Can you briefly explain why this needs to be conditional?
> >>
> >
> > No requisite, but if they aren't used outside of type hints, they don't
> > actually need to be imported at runtime (when we use from __future__
> import
> > annotations). Improves startup speed slightly and potentially makes the
> > plugin less porcelain at runtime.
>
> Should we do that for all typing-only imports everywhere?
>

Maybe! It's probably not too important, I just noticed Sphinx internals
doing it a lot and started following along because it seemed like a good
idea.

--0000000000000bf846062fe3390b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Mar 9, =
2025 at 12:38=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Fri, Mar 7, 2025 at 7:00=E2=80=AFAM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; w=
rote:<br>
&gt;<br>
&gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank=
">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; Now that the legacy code is factored out, fix up the typing o=
n the<br>
&gt;&gt; &gt; remaining code in qapidoc.py. Add a type ignore to qapi_legac=
y.py to<br>
&gt;&gt; &gt; prevent the errors there from bleeding out into qapidoc.py.<b=
r>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.c=
om" target=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 docs/sphinx/qapidoc.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 40 =
++++++++++++++++++++++-------------<br>
&gt;&gt; &gt;=C2=A0 docs/sphinx/qapidoc_legacy.py |=C2=A0 1 +<br>
&gt;&gt; &gt;=C2=A0 2 files changed, 26 insertions(+), 15 deletions(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<=
br>
&gt;&gt; &gt; index f4abf42e7bf..5246832b68c 100644<br>
&gt;&gt; &gt; --- a/docs/sphinx/qapidoc.py<br>
&gt;&gt; &gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt;&gt; &gt; @@ -24,17 +24,18 @@<br>
&gt;&gt; &gt;=C2=A0 <a href=3D"https://www.sphinx-doc.org/en/master/develop=
ment/index.html" rel=3D"noreferrer" target=3D"_blank">https://www.sphinx-do=
c.org/en/master/development/index.html</a><br>
&gt;&gt; &gt;=C2=A0 &quot;&quot;&quot;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; +from __future__ import annotations<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt;=C2=A0 import os<br>
&gt;&gt; &gt;=C2=A0 import sys<br>
&gt;&gt; &gt; -from typing import List<br>
&gt;&gt; &gt; +from typing import TYPE_CHECKING<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 from docutils import nodes<br>
&gt;&gt; &gt;=C2=A0 from docutils.parsers.rst import Directive, directives<=
br>
&gt;&gt; &gt;=C2=A0 from qapi.error import QAPIError<br>
&gt;&gt; &gt; -from qapi.gen import QAPISchemaVisitor<br>
&gt;&gt; &gt; -from qapi.schema import QAPISchema<br>
&gt;&gt; &gt; +from qapi.schema import QAPISchema, QAPISchemaVisitor<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; -from qapidoc_legacy import QAPISchemaGenRSTVisitor<br>
&gt;&gt; &gt; +from qapidoc_legacy import QAPISchemaGenRSTVisitor=C2=A0 # t=
ype: ignore<br>
&gt;&gt; &gt;=C2=A0 from sphinx import addnodes<br>
&gt;&gt; &gt;=C2=A0 from sphinx.directives.code import CodeBlock<br>
&gt;&gt; &gt;=C2=A0 from sphinx.errors import ExtensionError<br>
&gt;&gt; &gt; @@ -42,6 +43,15 @@<br>
&gt;&gt; &gt;=C2=A0 from sphinx.util.nodes import nested_parse_with_titles<=
br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; +if TYPE_CHECKING:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 from typing import Any, List, Sequence<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 from docutils.statemachine import StringList<b=
r>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 from sphinx.application import Sphinx<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 from sphinx.util.typing import ExtensionMetada=
ta<br>
&gt;&gt;<br>
&gt;&gt; Can you briefly explain why this needs to be conditional?<br>
&gt;&gt;<br>
&gt;<br>
&gt; No requisite, but if they aren&#39;t used outside of type hints, they =
don&#39;t<br>
&gt; actually need to be imported at runtime (when we use from __future__ i=
mport<br>
&gt; annotations). Improves startup speed slightly and potentially makes th=
e<br>
&gt; plugin less porcelain at runtime.<br>
<br>
Should we do that for all typing-only imports everywhere?<br></blockquote><=
div><br></div><div>Maybe! It&#39;s probably not too important, I just notic=
ed Sphinx internals doing it a lot and started following along because it s=
eemed like a good idea.</div></div></div>

--0000000000000bf846062fe3390b--



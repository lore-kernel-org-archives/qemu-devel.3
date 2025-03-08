Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEDEC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 08:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqpAT-0002Jd-7h; Sat, 08 Mar 2025 03:04:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqpAR-0002J8-FB
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 03:04:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqpAP-0004k7-FD
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 03:04:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741421056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9QyntBkjyCP64ElF+7mOonIrW/I9g5vqOT0V824hElI=;
 b=YCvYdU4Ge6M4cxkhSXXRi3KpMUveN8NA+rIdxZZ7GYtLG6nKth0uklDhVli+tJMtbtxRRE
 ZeAqPhQc1sx6oCGiH7fE+r+FzyYj+6lXREJ6G7M+2Calk1Tn54t0Pn+FnIlak45P1JhqgI
 jn6TQjnQ+TGj+YFOyt7kKmN0NHDtkyE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-MKrDeRXOPcCONv0qdDgkUQ-1; Sat, 08 Mar 2025 03:04:12 -0500
X-MC-Unique: MKrDeRXOPcCONv0qdDgkUQ-1
X-Mimecast-MFC-AGG-ID: MKrDeRXOPcCONv0qdDgkUQ_1741421052
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2240a960f9cso44210275ad.0
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 00:04:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741421052; x=1742025852;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9QyntBkjyCP64ElF+7mOonIrW/I9g5vqOT0V824hElI=;
 b=pzffpq+KMsfDLOKDUt3GFsHUghjAc0D1LHT/PaP8gISli2tlkXMRmaKV40SgpMID9u
 Z8MUJ9ZuixYgH6C+2HNX3GZWOxkbnDTI5LZW539pNawUVNMIyZYU5eIWPEJt81CdTeHg
 q3C745LBhORjoiFjJ2ehrzfnRfcqZer0PfDvVrj+KggOcxxFKAREzx1lEHnwobRF3C4R
 8gLf1mZXn0LFATkKiwrL+lqVSGuGecdWXaAGgWz7FtUM9oRSl5fkk6vMo/OM7soLmODp
 KW3R8wM6vLVJ5SkMfLd1oOzGjLAP4D+k9PDkUnPhOHYt69uuTcYl/V7AqwjlYCnLhIjh
 zfuw==
X-Gm-Message-State: AOJu0YylIRrLnF9XN+umTiccZNgJ+HK0yxZL7KmYQLEvbL1nl7vew2g3
 zJnqZdytU0nh8YwX55x6SavLudURmhl0zOOjhmTVHO/gYv+FIeeaX4eJ+DQYJY2bcJ7+GbmxgdM
 MQhAjwWUuUAMs2lKG4BAjwLmzeaOFj9MVf37+MQkj0JehqzPSOwLSeQ+PtWSLdW5VOIC6gKfxvT
 bB6aRw2G9h7/U7qV066ZtEiIWCHOs=
X-Gm-Gg: ASbGncuInwqfv/OmdEiJfE2JfBw0ZJiNslQkNB86A1EBg/BR2bTr7C+1k/GEOR62ntp
 8oJiDOU6pVTo+e/9HLdrC/SF+S6Ba2TMLCmC7aIgjGP1M7BY0lERF2IYYBTWpjpeG7NXobg==
X-Received: by 2002:a17:902:e5d2:b0:224:e33:889b with SMTP id
 d9443c01a7336-22428899db6mr113093035ad.12.1741421051771; 
 Sat, 08 Mar 2025 00:04:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmc1UhIrN+vbcxi+BLB4KOSgDaCXvI4F1KHB0dNPX7Xd2NhmvTySuwjGgI+IpzbffX6OJruUAYVxbbHgAn68c=
X-Received: by 2002:a17:902:e5d2:b0:224:e33:889b with SMTP id
 d9443c01a7336-22428899db6mr113092655ad.12.1741421051394; Sat, 08 Mar 2025
 00:04:11 -0800 (PST)
MIME-Version: 1.0
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-42-jsnow@redhat.com>
 <87r039jay7.fsf@pond.sub.org>
In-Reply-To: <87r039jay7.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Sat, 8 Mar 2025 03:03:59 -0500
X-Gm-Features: AQ5f1JrS6Fb5IFXP7PhjW4HWPiGCnQaCXuWn3ivfchWDvRTJvL8MxYPW5Q6L03o
Message-ID: <CAFn=p-ZTvZvoG5ufC+oPiGObwLqQCALJZLLmbFbAe0RnapkzhA@mail.gmail.com>
Subject: Re: [PATCH 41/57] docs/qapidoc: add preamble() method
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002c5837062fd02f71"
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

--0000000000002c5837062fd02f71
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 7:13=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This method adds the options/preamble to each definition block. Notably=
,
> > :since: and :ifcond: are added, as are any "special features" such as
> > :deprecated: and :unstable:.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py | 41 ++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 38 insertions(+), 3 deletions(-)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index cf5dbb0133d..d8bf0073dfa 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -37,7 +37,12 @@
> >  from docutils.parsers.rst import Directive, directives
> >  from docutils.statemachine import StringList
> >  from qapi.error import QAPIError
> > -from qapi.schema import QAPISchema, QAPISchemaVisitor
> > +from qapi.parser import QAPIDoc
> > +from qapi.schema import (
> > +    QAPISchema,
> > +    QAPISchemaDefinition,
> > +    QAPISchemaVisitor,
> > +)
> >  from qapi.source import QAPISourceInfo
> >
> >  from qapidoc_legacy import QAPISchemaGenRSTVisitor  # type: ignore
> > @@ -56,8 +61,6 @@
> >          Sequence,
> >      )
> >
> > -    from qapi.parser import QAPIDoc
> > -
>
> Some kind of accident?
>
> >      from sphinx.application import Sphinx
> >      from sphinx.util.typing import ExtensionMetadata
> >
> > @@ -125,6 +128,38 @@ def ensure_blank_line(self) -> None:
> >              # +2: correct for zero/one index, then increment by one.
> >              self.add_line_raw("", fname, line + 2)
> >
> > +    # Transmogrification helpers
> > +
> > +    def preamble(self, ent: QAPISchemaDefinition) -> None:
> > +        """
> > +        Generate option lines for qapi entity directives.
> > +        """
> > +        if ent.doc and ent.doc.since:
> > +            assert ent.doc.since.kind =3D=3D QAPIDoc.Kind.SINCE
> > +            # Generated from the entity's docblock; info location is
> exact.
> > +            self.add_line(f":since: {ent.doc.since.text}",
> ent.doc.since.info)
>
> Break the line afte the comma?
>

Is this an 80col vs 79col thing? I'll tighten it up.


>
> > +
> > +        if ent.ifcond.is_present():
> > +            doc =3D ent.ifcond.docgen()
> > +            assert ent.info
> > +            # Generated from entity definition; info location is
> approximate.
> > +            self.add_line(f":ifcond: {doc}", ent.info)
> > +
> > +        # Hoist special features such as :deprecated: and :unstable:
> > +        # into the options block for the entity. If, in the future, ne=
w
> > +        # special features are added, qapi-domain will chirp about
> > +        # unrecognized options and fail until they are handled in
> > +        # qapi-domain.
> > +        for feat in ent.features:
> > +            if feat.is_special():
> > +                # FIXME: handle ifcond if present. How to display that
> > +                # information is TBD.
>
> Is the FIXME worth mentioning in the commit message?
>

Yes, and yes to all subsequent asks.


>
> > +                # Generated from entity def; info location is
> approximate.
> > +                assert feat.info
> > +                self.add_line(f":{feat.name}:", feat.info)
> > +
> > +        self.ensure_blank_line()
> > +
> >      # Transmogrification core methods
> >
> >      def visit_module(self, path: str) -> None:
>
>

--0000000000002c5837062fd02f71
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 7, =
2025 at 7:13=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This method adds the options/preamble to each definition block. Notabl=
y,<br>
&gt; :since: and :ifcond: are added, as are any &quot;special features&quot=
; such as<br>
&gt; :deprecated: and :unstable:.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapidoc.py | 41 ++++++++++++++++++++++++++++++++++++=
++---<br>
&gt;=C2=A0 1 file changed, 38 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
&gt; index cf5dbb0133d..d8bf0073dfa 100644<br>
&gt; --- a/docs/sphinx/qapidoc.py<br>
&gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt; @@ -37,7 +37,12 @@<br>
&gt;=C2=A0 from docutils.parsers.rst import Directive, directives<br>
&gt;=C2=A0 from docutils.statemachine import StringList<br>
&gt;=C2=A0 from qapi.error import QAPIError<br>
&gt; -from qapi.schema import QAPISchema, QAPISchemaVisitor<br>
&gt; +from qapi.parser import QAPIDoc<br>
&gt; +from qapi.schema import (<br>
&gt; +=C2=A0 =C2=A0 QAPISchema,<br>
&gt; +=C2=A0 =C2=A0 QAPISchemaDefinition,<br>
&gt; +=C2=A0 =C2=A0 QAPISchemaVisitor,<br>
&gt; +)<br>
&gt;=C2=A0 from qapi.source import QAPISourceInfo<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 from qapidoc_legacy import QAPISchemaGenRSTVisitor=C2=A0 # type:=
 ignore<br>
&gt; @@ -56,8 +61,6 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Sequence,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 )<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 from qapi.parser import QAPIDoc<br>
&gt; -<br>
<br>
Some kind of accident?<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 from sphinx.application import Sphinx<br>
&gt;=C2=A0 =C2=A0 =C2=A0 from sphinx.util.typing import ExtensionMetadata<b=
r>
&gt;=C2=A0 <br>
&gt; @@ -125,6 +128,38 @@ def ensure_blank_line(self) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # +2: correct for zero=
/one index, then increment by one.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_line_raw(&quo=
t;&quot;, fname, line + 2)<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 # Transmogrification helpers<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def preamble(self, ent: QAPISchemaDefinition) -&gt; Non=
e:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Generate option lines for qapi entity dir=
ectives.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ent.doc and ent.doc.since:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert ent.doc.since.kind =
=3D=3D QAPIDoc.Kind.SINCE<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Generated from the entity=
&#39;s docblock; info location is exact.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_line(f&quot;:since=
: {ent.doc.since.text}&quot;, <a href=3D"http://ent.doc.since.info" rel=3D"=
noreferrer" target=3D"_blank">ent.doc.since.info</a>)<br>
<br>
Break the line afte the comma?<br></blockquote><div><br></div><div>Is this =
an 80col vs 79col thing? I&#39;ll tighten it up.</div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ent.ifcond.is_present():<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 doc =3D ent.ifcond.docgen()=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert <a href=3D"http://en=
t.info" rel=3D"noreferrer" target=3D"_blank">ent.info</a><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Generated from entity def=
inition; info location is approximate.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_line(f&quot;:ifcon=
d: {doc}&quot;, <a href=3D"http://ent.info" rel=3D"noreferrer" target=3D"_b=
lank">ent.info</a>)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Hoist special features such as :depreca=
ted: and :unstable:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # into the options block for the entity. =
If, in the future, new<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # special features are added, qapi-domain=
 will chirp about<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # unrecognized options and fail until the=
y are handled in<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # qapi-domain.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for feat in ent.features:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if feat.is_special():<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # FIXME: hand=
le ifcond if present. How to display that<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # information=
 is TBD.<br>
<br>
Is the FIXME worth mentioning in the commit message?<br></blockquote><div><=
br></div><div>Yes, and yes to all subsequent asks.</div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Generated f=
rom entity def; info location is approximate.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert <a hre=
f=3D"http://feat.info" rel=3D"noreferrer" target=3D"_blank">feat.info</a><b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_line=
(f&quot;:{<a href=3D"http://feat.name" rel=3D"noreferrer" target=3D"_blank"=
>feat.name</a>}:&quot;, <a href=3D"http://feat.info" rel=3D"noreferrer" tar=
get=3D"_blank">feat.info</a>)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ensure_blank_line()<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 # Transmogrification core methods<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def visit_module(self, path: str) -&gt; None:<br>
<br>
</blockquote></div></div>

--0000000000002c5837062fd02f71--



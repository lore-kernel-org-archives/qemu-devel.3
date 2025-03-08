Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17B6C28B28
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 08:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqpCU-00036p-3t; Sat, 08 Mar 2025 03:06:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqpCR-00036M-Nj
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 03:06:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqpCP-0005OF-Ms
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 03:06:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741421180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=enH8eaVrJi/xBbfCLjcxd/k3re3NUppHe/dyGcsSlok=;
 b=HLCitB1pqY6NlNij+blVVlhTuk+aUw3mhrgIILZAF4VRGGIJGTQPNK9T9y0BAnFo20FnjM
 VDKryJpBlm117329WTleWc30MphxUR7jnL6LViHmeMVdMPYql7X2oAfxRdktKBB3oLOZIE
 /GyLHMZAhNv/zfcEe2XcArWdKG6Pfng=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-XLlcmakGOxyD7eNDH4aVuw-1; Sat, 08 Mar 2025 03:06:16 -0500
X-MC-Unique: XLlcmakGOxyD7eNDH4aVuw-1
X-Mimecast-MFC-AGG-ID: XLlcmakGOxyD7eNDH4aVuw_1741421175
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2241aad40f3so40005435ad.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 00:06:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741421175; x=1742025975;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=enH8eaVrJi/xBbfCLjcxd/k3re3NUppHe/dyGcsSlok=;
 b=wjsvd74eGQklDyhsLeoftoe4F2cYzJUkXi2ko3gUgokgwH8UFjEP1LCgrUbYIfkI/q
 ckpKIyBk3OR6HwUisj4dVqLxomXUsj/njH3wFFKnct0ofjOoIBRCJTh8rCLhRQJ46UjG
 yCC82rOZG8wLhIlYBMs8nU0EmATebH1OtcqGlYHBYETWJgyNpvvPCFo5DkFE/t2WGPyE
 o6C908A0SgeSwKCoh0q5loMTgoz5+07+Izjnu5n/CRfzyfmTk4qVDFxJUZ5oLVwTYlxu
 by+hEQDNYDHudzg+x7t0DbmmD7i7o9H08Zl0xcr/MhSdPhPyeXO0z8TPmE8EQQxqegCC
 FyoA==
X-Gm-Message-State: AOJu0YxKsrhrtEBmsu+VmB9rdr7AcpGFmexX5Xcz5WcID2CXMAv+33o1
 8OY7rV4CW7oZY5bB2OnJexeA7Y9fYjRcx1COlSO4neKTcyO3IvzwafQPX311vlq63XyCHbfYn4p
 YxfZLDsqNK9JGQEyTEfXherLtJqXZV3U9wxdWRddXFXVBcxTSEsyPkUZVtfRT8/5sSgpU5+J/Z7
 mR4HFIgutECd/fqwxDFSasA6Stvc0=
X-Gm-Gg: ASbGncvyU4wB5h0zQdwVvUosy/wrEmqjylFY3DWuNsbdrlmbVBv2r+uTTzxzKha041s
 pcZCIvtp5euV8gHdSlqoOYel9jKTcqAseKt5/8JS9FfncCyNi4qF5I+/faiKzdZ0XlFyQQA==
X-Received: by 2002:a17:902:ecc3:b0:223:47e4:d288 with SMTP id
 d9443c01a7336-22428c02d2fmr84488405ad.47.1741421175157; 
 Sat, 08 Mar 2025 00:06:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlL8cBHnXjjW9Qcd9wVKLgfUA8FcDWbdLGgJW5Olsf9ArFKT2KYXpuJYoBdpwtxpSWZYz8BgW0wiiaTu1d6og=
X-Received: by 2002:a17:902:ecc3:b0:223:47e4:d288 with SMTP id
 d9443c01a7336-22428c02d2fmr84488215ad.47.1741421174862; Sat, 08 Mar 2025
 00:06:14 -0800 (PST)
MIME-Version: 1.0
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-49-jsnow@redhat.com>
 <877c51japx.fsf@pond.sub.org>
In-Reply-To: <877c51japx.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Sat, 8 Mar 2025 03:06:03 -0500
X-Gm-Features: AQ5f1JrUu4gzCEiAF3xtVb40lxVBHiZoh8gbEeBl4STkjmtM8rMgMNvxsZolFbw
Message-ID: <CAFn=p-bc+HaTXwCj5sg4m4=aoXkNRe_z11zNL03KD3h3UNz7kw@mail.gmail.com>
Subject: Re: [PATCH 48/57] docs/qapidoc: add visit_returns() method
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000885f5a062fd03613"
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

--000000000000885f5a062fd03613
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 7:18=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Generates :returns: fields for explicit returns statements. Note that
> > this does not presently handle undocumented returns, which is handled i=
n
> > a later commit.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index 834f12ba6e9..6458790fe55 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -41,6 +41,7 @@
> >  from qapi.schema import (
> >      QAPISchema,
> >      QAPISchemaArrayType,
> > +    QAPISchemaCommand,
> >      QAPISchemaDefinition,
> >      QAPISchemaEnumMember,
> >      QAPISchemaFeature,
> > @@ -210,6 +211,20 @@ def visit_feature(self, section:
> QAPIDoc.ArgSection) -> None:
> >
> >          self.generate_field("feat", section.member, section.text,
> section.info)
> >
> > +    def visit_returns(self, section: QAPIDoc.Section) -> None:
> > +        assert isinstance(self.entity, QAPISchemaCommand)
> > +        rtype =3D self.entity.ret_type
> > +        # q_empty can produce None, but we won't be documenting anythi=
ng
> > +        # without an explicit return statement in the doc block, and w=
e
> > +        # should not have any such explicit statements when there is n=
o
> > +        # return value.
> > +        assert rtype
> > +
> > +        typ =3D self.format_type(rtype)
> > +        assert typ
>

I wonder if I can write "assert typ :=3D self.format_type(rtype)" here.


> > +        assert section.text  # We don't expect empty returns sections.
>
> Not sure the comment is worth its keep.  Up to you.
>

Will remove. Not the first time I've talked to myself with assert messages.
Something from the very, very early days of this project and I had to
remind myself of some truths here and there (:


>
> > +        self.add_field("returns", typ, section.text, section.info)
> > +
> >      def visit_errors(self, section: QAPIDoc.Section) -> None:
> >          # FIXME: the formatting for errors may be inconsistent and may
> >          # or may not require different newline placement to ensure
>
>

--000000000000885f5a062fd03613
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 7, =
2025 at 7:18=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Generates :returns: fields for explicit returns statements. Note that<=
br>
&gt; this does not presently handle undocumented returns, which is handled =
in<br>
&gt; a later commit.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapidoc.py | 15 +++++++++++++++<br>
&gt;=C2=A0 1 file changed, 15 insertions(+)<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
&gt; index 834f12ba6e9..6458790fe55 100644<br>
&gt; --- a/docs/sphinx/qapidoc.py<br>
&gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt; @@ -41,6 +41,7 @@<br>
&gt;=C2=A0 from qapi.schema import (<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QAPISchema,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QAPISchemaArrayType,<br>
&gt; +=C2=A0 =C2=A0 QAPISchemaCommand,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QAPISchemaDefinition,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QAPISchemaEnumMember,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QAPISchemaFeature,<br>
&gt; @@ -210,6 +211,20 @@ def visit_feature(self, section: QAPIDoc.ArgSecti=
on) -&gt; None:<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.generate_field(&quot;feat&quot;=
, section.member, section.text, <a href=3D"http://section.info" rel=3D"nore=
ferrer" target=3D"_blank">section.info</a>)<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 def visit_returns(self, section: QAPIDoc.Section) -&gt;=
 None:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert isinstance(self.entity, QAPISchema=
Command)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rtype =3D self.entity.ret_type<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # q_empty can produce None, but we won&#3=
9;t be documenting anything<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # without an explicit return statement in=
 the doc block, and we<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # should not have any such explicit state=
ments when there is no<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # return value.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert rtype<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 typ =3D self.format_type(rtype)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert typ<br></blockquote><div><br></div=
><div>I wonder if I can write &quot;assert typ :=3D self.format_type(rtype)=
&quot; here.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert section.text=C2=A0 # We don&#39;t =
expect empty returns sections.<br>
<br>
Not sure the comment is worth its keep.=C2=A0 Up to you.<br></blockquote><d=
iv><br></div><div>Will remove. Not the first time I&#39;ve talked to myself=
 with assert messages. Something from the very, very early days of this pro=
ject and I had to remind myself of some truths here and there (:</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_field(&quot;returns&quot;, typ, =
section.text, <a href=3D"http://section.info" rel=3D"noreferrer" target=3D"=
_blank">section.info</a>)<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def visit_errors(self, section: QAPIDoc.Section) -=
&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # FIXME: the formatting for errors m=
ay be inconsistent and may<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # or may not require different newli=
ne placement to ensure<br>
<br>
</blockquote></div></div>

--000000000000885f5a062fd03613--



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B801E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdIX-00061q-DY; Wed, 08 Jan 2025 16:09:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tVdIW-00061f-5o
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:09:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tVdIT-0000xE-Ky
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736370536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n+bPjfaPXu9ayGjgaAeaTEGJ0PEgEuGnX30lWOE9zYU=;
 b=NdlgXZanAWvrxfA7Iy2nKJ/jeQkylnfRgtEcYI+ZEu7jwJf38AfijrwwzilPxf7+LoTDyv
 LhrdG+3FpVvk1mkW0Gh4dXMkHGSmvqXB8B3Eriw4pIUGS/TUeuqOkZQJRYUjQhEj28KBE0
 eG0sEOjLcqGrbxtggsKtgl5rOar6sLE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-p3KlRSYbMlmGI9C7bJ5Zgg-1; Wed, 08 Jan 2025 16:08:54 -0500
X-MC-Unique: p3KlRSYbMlmGI9C7bJ5Zgg-1
X-Mimecast-MFC-AGG-ID: p3KlRSYbMlmGI9C7bJ5Zgg
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ee5668e09bso373809a91.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:08:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736370533; x=1736975333;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n+bPjfaPXu9ayGjgaAeaTEGJ0PEgEuGnX30lWOE9zYU=;
 b=ttyZD43ZR0tfpl3vBfQ9xmyCII2084odbuIPHlnomJDTQ+ZKKD30FEUH8mUkVNkR8V
 eyZzadTDlTlUJwC3UJHZ2ULSCzYvJU1ZJBKxQ8guvfSMVZqKdmS9kOUh1e8tXZ+C0COz
 8fWJLRjHefeYI/QXw7adY472YYnWe0RjwiRzkr9MBezLgqmM+zoRhUv74tQT5EkcJ6JQ
 oj7hqVysD+w5gGWAuBViYk2aTQpzvuA9qasTl4BRVJkAqbbvWLFl5LI1dKbfnF9U1XEr
 fydaUeuEGkVWujISI9t5YuavAKzEz3sb1jTfu8JvRfUdNzRPre5aQHvMm+vRVVaNn/2t
 tZ1g==
X-Gm-Message-State: AOJu0YzaaMIPIR/EwAzd+hVyop5a35T7QV3YlDMaQV0N2TS46/utHNc3
 CoUoE179sSP7iFgA4zQiPwbp1Z7MnG+mW9IYUVZTmJH4CICwRsGFCdv05/lw/CI4jI6JzD8UGQx
 mkIH/rUIcBS9Wa5AZsy/kQyrrqgeBciAAjvT3qQxin3S32shcJp9/4r+E4/YSiZz9Xzwu89KZQ8
 KOMBbF+REXg6QY8KkVhgUCZ3rLNl5fG3raEBk=
X-Gm-Gg: ASbGncswIe6bvIxwz0Ujeppzfx+ejQ7740CwAAFWBVHEnLJgK/UJvuuEBMFmeyMuexJ
 T2wvMp2psDm35E/b50ihCgIkV210ufhcLZDHH3K1u9Tio2kvRmSPe8yikAJYUay3HsEMJxQ==
X-Received: by 2002:a17:90a:d64b:b0:2ee:94d1:7a9d with SMTP id
 98e67ed59e1d1-2f548f416b4mr5498891a91.32.1736370532976; 
 Wed, 08 Jan 2025 13:08:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0hnikHxr7XJwvUQCT9LbHnjLwkihcpifO3ax1yHb37TxkL7EWDA1bR25d/rYuHIBzI7qtqZbSo6r8bHrXKjI=
X-Received: by 2002:a17:90a:d64b:b0:2ee:94d1:7a9d with SMTP id
 98e67ed59e1d1-2f548f416b4mr5498805a91.32.1736370531722; Wed, 08 Jan 2025
 13:08:51 -0800 (PST)
MIME-Version: 1.0
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <87ikrfkg6y.fsf@pond.sub.org>
In-Reply-To: <87ikrfkg6y.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 8 Jan 2025 16:08:40 -0500
X-Gm-Features: AbW1kvb3glST3_i0jwyuffP7nBs-H2bdGT8QZbtuuuL9eNu_u0h5Z2fZK9JGBWw
Message-ID: <CAFn=p-YynNgOTb7-rzJeF69hG_3c1ojosHAOsnc-CW-a_SYrUA@mail.gmail.com>
Subject: Re: [PATCH 00/23] docs: add basic sphinx-domain rST generator to
 qapidoc
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000be081d062b38449f"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

--000000000000be081d062b38449f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 7:31=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > based-on:
> https://patchew.org/QEMU/20241213011307.2942030-1-jsnow@redhat.com/
> >
> > Hi!
> >
> > This series is a very, very barebones implementation for the new QAPI
> > doc generator. It does not have many features that I presented on at KV=
M
> > Forum; the point of this patch set is instead to present a stripped dow=
n
> > basis for ongoing work so we can discuss on-list with full context of
> > the code available to do so.
> >
> > The documentation this series generates is *not suitable* for replacing
> > the current document generator, it has a few glaring omissions - on
> > purpose - those features have been factored out intentionally so they
> > can be reviewed with fuller context and more careful review.
> >
> > What this series does:
> >
> > - Adds the new "Transmogrifier" rST generator to qapidoc.py, which
> >   generates an in-memory rST document using qapi-domain directives.
> > - Adds a test document that showcases this new transmogrifier.
>
> Note to other reviewers: transmogrifier output is
> docs/manual/qapi/index.html.
>
> > What this series very notably does not do (yet):
> >
> > - "ifcond" data for anything other than top-level entities is not
> >   considered or rendered. This means "if" statements for features and
> >   members are entirely absent.
> >
> > - The inliner is not present at all. This series renders only
> >   documentation exactly as it is exists in the source files.
>
> This item is not even a regression.
>

No; but the version of this series as sent also does not add "The members
of ..." stubs, which would be a regression. I didn't necessarily intend for
this to be merged as-is; more of a "part one, with additional tricky
elements that require more careful thought isolated into separate patches
for later".

where "later" means "in v2" or "as a follow-up series as we stage things in
a development branch before final submission for inclusion to
origin/master" or whatever the actual mechanism is. I don't have a strong
vision there, really; I just wanted to nail down the basics out in the open
even if that was just between you (Markus) and I and we have a gentleman's
agreement that it looks tentatively OK.


>
> > - *branches* are themselves not considered at all; they're skipped
> >    entirely for now. They will be included alongside the inliner in
> >    either a subsequent series or a followup to this series.
> >
> > - Undocumented members and return statements are not autogenerated.
>
> The current doc generator auto-generates missing member documentation
> ("Not documented").  It doesn't auto-generate missing returns
> documentation.  I explored auto-generating them, but shelved my work to
> not interfere with yours.
>
> > - Pseudofeatures (Things like allow-oob) are not generated as documente=
d
> >   features.
>
> What exactly are "pseudofeatures"?
>

What I've named things like allow-oob that aren't features, but ought to be
documented. We may well decide to promote them to real-deal special
features, or maybe not. My work-in-progress branch currently just adds
"dummy" features to document them. We can discuss this later alongside the
patch that implements this.


>
> > - Documentation culling: all entities are documented whether or not
> >   they're relevant to the wire format.
>
> Also not a regression.
>
> > My goal in doing it this way is to save the "fancy" features for later
> > so we can focus on reviewing and tightening up the core functionality o=
f
> > the transmogrifier. Once we're on steadier ground, I will re-add the
> > fanciful features while adjusting the qapi-domain mechanisms. Once
> > everything looks "roughly right, give or take some minor nits", I will
> > switch back to the qapi-domain series itself for review before we merge
> > everything together.
>
> Makes sense to me.
>
> [...]
>
> >  docs/index.rst         |   1 +
> >  docs/qapi/index.rst    |  53 ++++++
> >  docs/sphinx/qapidoc.py | 419 ++++++++++++++++++++++++++++++++++++++---
> >  scripts/qapi/parser.py |  97 +++++++---
> >  scripts/qapi/source.py |   4 +-
> >  5 files changed, 524 insertions(+), 50 deletions(-)
> >  create mode 100644 docs/qapi/index.rst
>
> The changes to the QAPI generator core (scripts/qapi/) are small, and
> spread over just four patches:
>
>     qapi/source: allow multi-line QAPISourceInfo advancing
>     qapi/schema: add __repr__ to QAPIDoc.Section
>     qapi: expand tags to all doc sections
>     qapi/parser: adjust info location for doc body section
>
>

--000000000000be081d062b38449f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 19,=
 2024 at 7:31=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; based-on: <a href=3D"https://patchew.org/QEMU/20241213011307.2942030-1=
-jsnow@redhat.com/" rel=3D"noreferrer" target=3D"_blank">https://patchew.or=
g/QEMU/20241213011307.2942030-1-jsnow@redhat.com/</a><br>
&gt;<br>
&gt; Hi!<br>
&gt;<br>
&gt; This series is a very, very barebones implementation for the new QAPI<=
br>
&gt; doc generator. It does not have many features that I presented on at K=
VM<br>
&gt; Forum; the point of this patch set is instead to present a stripped do=
wn<br>
&gt; basis for ongoing work so we can discuss on-list with full context of<=
br>
&gt; the code available to do so.<br>
&gt;<br>
&gt; The documentation this series generates is *not suitable* for replacin=
g<br>
&gt; the current document generator, it has a few glaring omissions - on<br=
>
&gt; purpose - those features have been factored out intentionally so they<=
br>
&gt; can be reviewed with fuller context and more careful review.<br>
&gt;<br>
&gt; What this series does:<br>
&gt;<br>
&gt; - Adds the new &quot;Transmogrifier&quot; rST generator to qapidoc.py,=
 which<br>
&gt;=C2=A0 =C2=A0generates an in-memory rST document using qapi-domain dire=
ctives.<br>
&gt; - Adds a test document that showcases this new transmogrifier.<br>
<br>
Note to other reviewers: transmogrifier output is<br>
docs/manual/qapi/index.html.<br>
<br>
&gt; What this series very notably does not do (yet):<br>
&gt;<br>
&gt; - &quot;ifcond&quot; data for anything other than top-level entities i=
s not<br>
&gt;=C2=A0 =C2=A0considered or rendered. This means &quot;if&quot; statemen=
ts for features and<br>
&gt;=C2=A0 =C2=A0members are entirely absent.<br>
&gt;<br>
&gt; - The inliner is not present at all. This series renders only<br>
&gt;=C2=A0 =C2=A0documentation exactly as it is exists in the source files.=
<br>
<br>
This item is not even a regression.<br></blockquote><div><br></div><div>No;=
 but the version of this series as sent also does not add &quot;The members=
 of ...&quot; stubs, which would be a regression. I didn&#39;t necessarily =
intend for this to be merged as-is; more of a &quot;part one, with addition=
al tricky elements that require more careful thought isolated into separate=
 patches for later&quot;.<br><br></div><div>where &quot;later&quot; means &=
quot;in v2&quot; or &quot;as a follow-up series as we stage things in a dev=
elopment branch before final submission for inclusion to origin/master&quot=
; or whatever the actual mechanism is. I don&#39;t have a strong vision the=
re, really; I just wanted to nail down the basics out in the open even if t=
hat was just between you (Markus) and I and we have a gentleman&#39;s agree=
ment that it looks tentatively OK.<br></div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<br>
&gt; - *branches* are themselves not considered at all; they&#39;re skipped=
<br>
&gt;=C2=A0 =C2=A0 entirely for now. They will be included alongside the inl=
iner in<br>
&gt;=C2=A0 =C2=A0 either a subsequent series or a followup to this series.<=
br>
&gt;<br>
&gt; - Undocumented members and return statements are not autogenerated.<br=
>
<br>
The current doc generator auto-generates missing member documentation<br>
(&quot;Not documented&quot;).=C2=A0 It doesn&#39;t auto-generate missing re=
turns<br>
documentation.=C2=A0 I explored auto-generating them, but shelved my work t=
o<br>
not interfere with yours.<br>
<br>
&gt; - Pseudofeatures (Things like allow-oob) are not generated as document=
ed<br>
&gt;=C2=A0 =C2=A0features.<br>
<br>
What exactly are &quot;pseudofeatures&quot;?<br></blockquote><div><br></div=
><div>What I&#39;ve named things like allow-oob that aren&#39;t features, b=
ut ought to be documented. We may well decide to promote them to real-deal =
special features, or maybe not. My work-in-progress branch currently just a=
dds &quot;dummy&quot; features to document them. We can discuss this later =
alongside the patch that implements this.<br></div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; - Documentation culling: all entities are documented whether or not<br=
>
&gt;=C2=A0 =C2=A0they&#39;re relevant to the wire format.<br>
<br>
Also not a regression.<br>
<br>
&gt; My goal in doing it this way is to save the &quot;fancy&quot; features=
 for later<br>
&gt; so we can focus on reviewing and tightening up the core functionality =
of<br>
&gt; the transmogrifier. Once we&#39;re on steadier ground, I will re-add t=
he<br>
&gt; fanciful features while adjusting the qapi-domain mechanisms. Once<br>
&gt; everything looks &quot;roughly right, give or take some minor nits&quo=
t;, I will<br>
&gt; switch back to the qapi-domain series itself for review before we merg=
e<br>
&gt; everything together.<br>
<br>
Makes sense to me.<br>
<br>
[...]<br>
<br>
&gt;=C2=A0 docs/index.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 =
+<br>
&gt;=C2=A0 docs/qapi/index.rst=C2=A0 =C2=A0 |=C2=A0 53 ++++++<br>
&gt;=C2=A0 docs/sphinx/qapidoc.py | 419 +++++++++++++++++++++++++++++++++++=
+++---<br>
&gt;=C2=A0 scripts/qapi/parser.py |=C2=A0 97 +++++++---<br>
&gt;=C2=A0 scripts/qapi/source.py |=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 5 files changed, 524 insertions(+), 50 deletions(-)<br>
&gt;=C2=A0 create mode 100644 docs/qapi/index.rst<br>
<br>
The changes to the QAPI generator core (scripts/qapi/) are small, and<br>
spread over just four patches:<br>
<br>
=C2=A0 =C2=A0 qapi/source: allow multi-line QAPISourceInfo advancing<br>
=C2=A0 =C2=A0 qapi/schema: add __repr__ to QAPIDoc.Section<br>
=C2=A0 =C2=A0 qapi: expand tags to all doc sections<br>
=C2=A0 =C2=A0 qapi/parser: adjust info location for doc body section<br>
<br>
</blockquote></div></div>

--000000000000be081d062b38449f--



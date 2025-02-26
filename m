Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D68C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 15:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnIzP-0007Tz-FU; Wed, 26 Feb 2025 10:06:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tnIzN-0007Tk-Qm
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:06:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tnIzK-0006b5-4s
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740582375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/oVXr78BPQikZvplkFIiKsDaDpfYeflLoDifu/f0B2Q=;
 b=CWeCUjPXMcSA7OF5VHL+8f6UnH0y9DbRHogW1UeJncROiSoEt+xREDOZBEQKGgxHyvMTpD
 tYMPon6zHlhpX0B91QIxCJeaTyGr/jgwVAmk8MERDZu/Vqzrhd1RZ3BLXdshlWPkjlwQph
 x3bSu0UL+JQWfEAO98922PDOVmABYYI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-VZHze6JVM0un6cV8FuMfmQ-1; Wed, 26 Feb 2025 10:06:12 -0500
X-MC-Unique: VZHze6JVM0un6cV8FuMfmQ-1
X-Mimecast-MFC-AGG-ID: VZHze6JVM0un6cV8FuMfmQ_1740582370
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2fc0bc05c00so22260079a91.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 07:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740582370; x=1741187170;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/oVXr78BPQikZvplkFIiKsDaDpfYeflLoDifu/f0B2Q=;
 b=J2nmWSOL5xv137ASqhBkV8YlSWOVkMujx1f/VcPVCqGyGMbVNHi7EGT+TxEMXUPgTg
 vtzNjQqQMmMFaMnlNT7e2bWjopGnpSUZWbRhJpraIpegDirwV4YCePinyVnfQrgcYz4W
 ++Fqy5Uv9Tne3i09hBvIhhqpEAbSs9qRDP1BODhn1VAG5mTwG4jRv2Md9dsChB9WfA0t
 ESWbbSkOyhSSRgMxSNsoK8jucphu7n1K8lUJfetPu9r/xBjYGBYGu6HMItH7NjSteOv5
 1Knmvb22QWHq1N8vnDjamrHfZ6PsGq6fo3Q4W0zTEv1DbsvSUfn15AEo+4+ZcCmWRrN6
 Tqfg==
X-Gm-Message-State: AOJu0Yz2HEcoJrxUQN+afOUZgzZOkg3LdBBLotnOKd7wOez7Z/EXar1S
 EjA8BtpXULsz4RKP4rkSsWCqnZcv7P2jbtz9bkIdQFOXxuV717VWbZtFngn3cyTZsV62XZGLlCr
 vUpkYl8EwvX6/Jk4dUPGeLJ3Wb2KHt+4emvFXiJzRl6CBJObHmKkVzrzYV3XgGtEinDENXwNsG8
 yaoQ1fWfLnkGIwysFYPFzZaMjm1Fk=
X-Gm-Gg: ASbGncuqm979aTagGAQsg57reZIdIXj+gECJ8+7n5X0zuNAaP/b4xRXzF6QrAE05aJq
 +UW0/cHjEILSrHkESHj8S4CUSprAKJ/MGYVDeq7wAsUuVIYPd9PZQrttT2exhomu6YcarnvPYoo
 sd3gTJaYsuHY/XBqCWqgffKe0AuhXN
X-Received: by 2002:a17:90b:5688:b0:2ee:d63f:d77 with SMTP id
 98e67ed59e1d1-2fe68adec61mr13167073a91.9.1740582369016; 
 Wed, 26 Feb 2025 07:06:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFP6kUYGhTUNvRKQY+9cH/Ow1i7GNRxA704erO4xvfRxhfmnPZx3+i9ZkKjCncUJU/yoWqQ3V44WuAh7GLMpuI=
X-Received: by 2002:a17:90b:5688:b0:2ee:d63f:d77 with SMTP id
 98e67ed59e1d1-2fe68adec61mr13166886a91.9.1740582367253; Wed, 26 Feb 2025
 07:06:07 -0800 (PST)
MIME-Version: 1.0
References: <20250224033741.222749-1-jsnow@redhat.com>
 <20250224033741.222749-4-jsnow@redhat.com>
 <87bjup5fnl.fsf@pond.sub.org>
In-Reply-To: <87bjup5fnl.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 26 Feb 2025 10:05:54 -0500
X-Gm-Features: AWEUYZl1Daj4mf-mPxaeH1-9HFkERF7wZLRO_KCfKRn0uVV4kyVzY3ZA6v4GPMc
Message-ID: <CAFn=p-aPSKn1iL3evY4YKyqUnntQZ+y9Tmh_Bq8-YxwMtWQx-w@mail.gmail.com>
Subject: Re: [PATCH 03/10] qapi: delete un-needed python static analysis
 configs
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b3ecc2062f0ce9cc"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000b3ecc2062f0ce9cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 2:28=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > The pylint config is being left in place because the settings differ
> > enough from the python/ directory settings that we need a chit-chat on
> > how to merge them O:-)
> >
> > Everything else can go.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/.flake8    | 3 ---
> >  scripts/qapi/.isort.cfg | 7 -------
> >  scripts/qapi/mypy.ini   | 4 ----
> >  3 files changed, 14 deletions(-)
> >  delete mode 100644 scripts/qapi/.flake8
> >  delete mode 100644 scripts/qapi/.isort.cfg
> >  delete mode 100644 scripts/qapi/mypy.ini
> >
> > diff --git a/scripts/qapi/.flake8 b/scripts/qapi/.flake8
> > deleted file mode 100644
> > index a873ff67309..00000000000
> > --- a/scripts/qapi/.flake8
> > +++ /dev/null
> > @@ -1,3 +0,0 @@
> > -[flake8]
> > -# Prefer pylint's bare-except checks to flake8's
> > -extend-ignore =3D E722
>
> python/setup.cfg has:
>
>    [flake8]
>    # Prefer pylint's bare-except checks to flake8's
>    extend-ignore =3D E722
>    exclude =3D __pycache__,
>
> Good.
>
> > diff --git a/scripts/qapi/.isort.cfg b/scripts/qapi/.isort.cfg
> > deleted file mode 100644
> > index 643caa1fbd6..00000000000
> > --- a/scripts/qapi/.isort.cfg
> > +++ /dev/null
> > @@ -1,7 +0,0 @@
> > -[settings]
> > -force_grid_wrap=3D4
> > -force_sort_within_sections=3DTrue
> > -include_trailing_comma=3DTrue
> > -line_length=3D72
> > -lines_after_imports=3D2
> > -multi_line_output=3D3
>
> python/setup.cfg has:
>
>    [isort]
>    force_grid_wrap=3D4
>    force_sort_within_sections=3DTrue
>    include_trailing_comma=3DTrue
>    line_length=3D72
>    lines_after_imports=3D2
>    multi_line_output=3D3
>
> Good.
>
> > diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
> > deleted file mode 100644
> > index 8109470a031..00000000000
> > --- a/scripts/qapi/mypy.ini
> > +++ /dev/null
> > @@ -1,4 +0,0 @@
> > -[mypy]
> > -strict =3D True
> > -disallow_untyped_calls =3D False
> > -python_version =3D 3.8
>
> python/setup.cfg has:
>
>    [mypy]
>    strict =3D True
>    python_version =3D 3.8
>    warn_unused_configs =3D True
>    namespace_packages =3D True
>    warn_unused_ignores =3D False
>
> Can you briefly explain the differences?
>

warn_unused_configs: Catches config values that aren't actually recognized
or used. Was helpful once upon a time when re-arranging the Python
directory to behave like a package to ensure that the conf files were
working correctly.

namespace_packages: Needed for the python/ directory structure (nested
packages under a namespace, "qemu"). Doesn't impact scripts/qapi at all.
Read up on PEP420 if you are curious. Details in commit message, see below
if you're still curious.

warn_unused_ignores: Needed once upon a time for cross-version mypy support
where some versions would warn in some cases and others would not. Adding
an ignore would effectively just invert which versions complained. Probably
still needed, but it's hard to measure.

python_version: Changes mypy behavior regardless of the invoking python
interpreter to check the file as if it were to be executed by Python 3.8. I
actually want to remove this value from setup.cfg but haven't yet. I
removed it from the python-qemu-qmp repo and never added it for qapi.
Removing it is actually probably correct as it will catch errors specific
to various python versions we support, but there are some nits to iron out
in my neck of the woods. This is a case where scripts/qapi/ is stricter
than python/ :)
(Not reasonable to solve for this series.)

lack of disallow_untyped_calls =3D False: I think this might be a remnant
from when we gradually typed qapi; it's evidently no longer needed since
qapi still checks fine without this affordance. The default under strict is
True.

e941c844e444 (John Snow                   2021-05-27 17:17:05 -0400  79)
[mypy]
e941c844e444 (John Snow                   2021-05-27 17:17:05 -0400  80)
strict =3D True
ca056f4499c2 (Paolo Bonzini               2023-05-03 12:48:02 +0200  81)
python_version =3D 3.8
e941c844e444 (John Snow                   2021-05-27 17:17:05 -0400  82)
warn_unused_configs =3D True
0542a4c95767 (John Snow                   2021-05-27 17:17:06 -0400  83)
namespace_packages =3D True
e7874a50ff3f (John Snow                   2022-05-25 20:09:13 -0400  84)
warn_unused_ignores =3D False


>
> python/setup.cfg additionally has a bunch of ignore_missing_imports that
> don't apply here, as far as I can tell.
>

Right, that's all stuff for fuse and the interactive qmp shell that use
untyped dependencies.

--000000000000b3ecc2062f0ce9cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 26,=
 2025 at 2:28=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; The pylint config is being left in place because the settings differ<b=
r>
&gt; enough from the python/ directory settings that we need a chit-chat on=
<br>
&gt; how to merge them O:-)<br>
&gt;<br>
&gt; Everything else can go.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/qapi/.flake8=C2=A0 =C2=A0 | 3 ---<br>
&gt;=C2=A0 scripts/qapi/.isort.cfg | 7 -------<br>
&gt;=C2=A0 scripts/qapi/mypy.ini=C2=A0 =C2=A0| 4 ----<br>
&gt;=C2=A0 3 files changed, 14 deletions(-)<br>
&gt;=C2=A0 delete mode 100644 scripts/qapi/.flake8<br>
&gt;=C2=A0 delete mode 100644 scripts/qapi/.isort.cfg<br>
&gt;=C2=A0 delete mode 100644 scripts/qapi/mypy.ini<br>
&gt;<br>
&gt; diff --git a/scripts/qapi/.flake8 b/scripts/qapi/.flake8<br>
&gt; deleted file mode 100644<br>
&gt; index a873ff67309..00000000000<br>
&gt; --- a/scripts/qapi/.flake8<br>
&gt; +++ /dev/null<br>
&gt; @@ -1,3 +0,0 @@<br>
&gt; -[flake8]<br>
&gt; -# Prefer pylint&#39;s bare-except checks to flake8&#39;s<br>
&gt; -extend-ignore =3D E722<br>
<br>
python/setup.cfg has:<br>
<br>
=C2=A0 =C2=A0[flake8]<br>
=C2=A0 =C2=A0# Prefer pylint&#39;s bare-except checks to flake8&#39;s<br>
=C2=A0 =C2=A0extend-ignore =3D E722<br>
=C2=A0 =C2=A0exclude =3D __pycache__,<br>
<br>
Good.<br>
<br>
&gt; diff --git a/scripts/qapi/.isort.cfg b/scripts/qapi/.isort.cfg<br>
&gt; deleted file mode 100644<br>
&gt; index 643caa1fbd6..00000000000<br>
&gt; --- a/scripts/qapi/.isort.cfg<br>
&gt; +++ /dev/null<br>
&gt; @@ -1,7 +0,0 @@<br>
&gt; -[settings]<br>
&gt; -force_grid_wrap=3D4<br>
&gt; -force_sort_within_sections=3DTrue<br>
&gt; -include_trailing_comma=3DTrue<br>
&gt; -line_length=3D72<br>
&gt; -lines_after_imports=3D2<br>
&gt; -multi_line_output=3D3<br>
<br>
python/setup.cfg has:<br>
<br>
=C2=A0 =C2=A0[isort]<br>
=C2=A0 =C2=A0force_grid_wrap=3D4<br>
=C2=A0 =C2=A0force_sort_within_sections=3DTrue<br>
=C2=A0 =C2=A0include_trailing_comma=3DTrue<br>
=C2=A0 =C2=A0line_length=3D72<br>
=C2=A0 =C2=A0lines_after_imports=3D2<br>
=C2=A0 =C2=A0multi_line_output=3D3<br>
<br>
Good.<br>
<br>
&gt; diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini<br>
&gt; deleted file mode 100644<br>
&gt; index 8109470a031..00000000000<br>
&gt; --- a/scripts/qapi/mypy.ini<br>
&gt; +++ /dev/null<br>
&gt; @@ -1,4 +0,0 @@<br>
&gt; -[mypy]<br>
&gt; -strict =3D True<br>
&gt; -disallow_untyped_calls =3D False<br>
&gt; -python_version =3D 3.8<br>
<br>
python/setup.cfg has:<br>
<br>
=C2=A0 =C2=A0[mypy]<br>
=C2=A0 =C2=A0strict =3D True<br>
=C2=A0 =C2=A0python_version =3D 3.8<br>
=C2=A0 =C2=A0warn_unused_configs =3D True<br>
=C2=A0 =C2=A0namespace_packages =3D True<br>
=C2=A0 =C2=A0warn_unused_ignores =3D False<br>
<br>
Can you briefly explain the differences?<br></blockquote><div><br></div><di=
v>warn_unused_configs: Catches config values that aren&#39;t actually recog=
nized or used. Was helpful once upon a time when re-arranging the Python di=
rectory to behave like a package to ensure that the conf files were working=
 correctly.</div><div><br></div><div>namespace_packages: Needed for the pyt=
hon/ directory structure (nested packages under a namespace, &quot;qemu&quo=
t;). Doesn&#39;t impact scripts/qapi at all. Read up on PEP420 if you are c=
urious. Details in commit message, see below if you&#39;re still curious.</=
div><div><br></div><div>warn_unused_ignores: Needed once upon a time for cr=
oss-version mypy support where some versions would warn in some cases and o=
thers would not. Adding an ignore would effectively just invert which versi=
ons complained. Probably still needed, but it&#39;s hard to measure.</div><=
div>=C2=A0<br></div><div>python_version: Changes mypy behavior regardless o=
f the invoking python interpreter to check the file as if it were to be exe=
cuted by Python 3.8. I actually want to remove this value from setup.cfg bu=
t haven&#39;t yet. I removed it from the python-qemu-qmp repo and never add=
ed it for qapi. Removing it is actually probably correct as it will catch e=
rrors specific to various python versions we support, but there are some ni=
ts to iron out in my neck of the woods. This is a case where scripts/qapi/ =
is stricter than python/ :)</div><div>(Not reasonable to solve for this ser=
ies.)</div><div><br></div><div>lack of disallow_untyped_calls =3D False: I =
think this might be a remnant from when we gradually typed qapi; it&#39;s e=
vidently no longer needed since qapi still checks fine without this afforda=
nce. The default under strict is True.</div><div><br></div><div></div><div>=
e941c844e444 (John Snow =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 2021-05-27 17:17:05 -0400 =C2=A079) [mypy]<br>e941c844e444 (J=
ohn Snow =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 202=
1-05-27 17:17:05 -0400 =C2=A080) strict =3D True<br>ca056f4499c2 (Paolo Bon=
zini =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2023-05-03 12:48:02 +=
0200 =C2=A081) python_version =3D 3.8<br>e941c844e444 (John Snow =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2021-05-27 17:17:05 -0=
400 =C2=A082) warn_unused_configs =3D True<br>0542a4c95767 (John Snow =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2021-05-27 17:1=
7:06 -0400 =C2=A083) namespace_packages =3D True<br>e7874a50ff3f (John Snow=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2022-05-25 =
20:09:13 -0400 =C2=A084) warn_unused_ignores =3D False</div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
python/setup.cfg additionally has a bunch of ignore_missing_imports that<br=
>
don&#39;t apply here, as far as I can tell.<br></blockquote><div><br></div>=
<div>Right, that&#39;s all stuff for fuse and the interactive qmp shell tha=
t use untyped dependencies.</div><div>=C2=A0</div></div></div>

--000000000000b3ecc2062f0ce9cc--



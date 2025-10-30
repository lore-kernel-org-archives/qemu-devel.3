Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EBCCCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 15:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEUM7-0000d0-QR; Thu, 30 Oct 2025 11:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vEUM5-0000cI-Oj
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:14:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vEUM1-0005Dg-RS
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761837256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=agOED+/yo51W0n8T3pBqMS1+uQy3sv2h8G7u7MF9ZPU=;
 b=J+u7rTwlGrCSz4hRedO+84s85I/WKBzySH8PR8woUMYhZNEtl7wJ5ve808jNFAhRz3SZrF
 zkgggpkfYutAVjYSFsQNYOoBTrmA8ndjxoHfe8K1/sHYq/U4xFIkq7oQS3Bq9Sld1Unr+2
 dcJEUN2f+r6KmmqAtykdOue/w+Bp/YI=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-1CRxTK3qMvCtk6uvKaGyTQ-1; Thu, 30 Oct 2025 11:14:14 -0400
X-MC-Unique: 1CRxTK3qMvCtk6uvKaGyTQ-1
X-Mimecast-MFC-AGG-ID: 1CRxTK3qMvCtk6uvKaGyTQ_1761837254
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-7848168dffaso14806397b3.2
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 08:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761837254; x=1762442054;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=agOED+/yo51W0n8T3pBqMS1+uQy3sv2h8G7u7MF9ZPU=;
 b=qS5cFIGcPq4Eu3BHIquQjdGSJxU4vP4/JP3z6k8Hq+X4gkEQZqsriALkvsRQ1acBt7
 I/ICmZYGGizvuKtJ2FP9hflwZQ1qCUkrtIZQj+pwNEmvOnMLDpGRrJMsmw1kuBPETXfi
 gkgAZEmuIFoCCq+OgTbALEDXqHPqVH/ZSBOKeTC824VwnI9mDZs03VjB1gw/sJRjaVuZ
 NBD+Lf0eJJw7PZD9/7SkqwLdkQN8nS4W7KATmIWJO+Q3XNAGRlfu2QfeDlPR+BHqUUoK
 OZdrM37N91kJUQxqmOBf6VhV1dAeDHEg6veM5bZCvTy13asJ0G38vL+TQNaVFa2rK1Vw
 M9pg==
X-Gm-Message-State: AOJu0YygEdK4tHK+cApg01iqnm09B+PCdRoLfmoGSdNfiynLwI7YOsYO
 g1z5uea4Tf7+idC7CcvfG5Ze3ADisvf38l5IR8FAyQcMsS3WxffI3+BTWOu4TA+6j8Z+IX9BDn8
 FNSTFXzy5bmMDfSNglNY7QMIgUAe7QxnKYiItTJbufKmIefWisCht739HtbvTglACTpDEU3uxsL
 I7+QcWyS8iRhhYNKP6rf8cmfoXHk/sNAo=
X-Gm-Gg: ASbGncsgHNcT1KmaquBNey+Io7vH3GLgj7XlojamPXLF1hJbxjikb8bQXW7vyarUeK1
 KuLJqoGgY0wCsCFZiuE/O8IEsRjRPa6E5VXh8+0trlBoQ938dDM8CgwIoVkWbbY3WUoKY7DA5PD
 kN5oGulcSr2tb6SPfKVpNDSgyKYIrHAnCWYqy9UA8FyR7YuQlBL1hwEIohvgDW5ov1UuQS+3tdE
 42aiaYcY0gcVbw=
X-Received: by 2002:a05:690c:4990:b0:784:8d21:394f with SMTP id
 00721157ae682-7863901a97fmr36572747b3.6.1761837253825; 
 Thu, 30 Oct 2025 08:14:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3HUCeuEzVr/+kJqE1CU5ZesugVO7u1awryMHDBD2q90CQxEEHJRB08FJryCV/Mv8KnGZgmdI+oKYZE7M0CTM=
X-Received: by 2002:a05:690c:4990:b0:784:8d21:394f with SMTP id
 00721157ae682-7863901a97fmr36572227b3.6.1761837252977; Thu, 30 Oct 2025
 08:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <20251028220342.1407883-1-jsnow@redhat.com>
 <20251028220342.1407883-10-jsnow@redhat.com>
 <f58ea42a-8fd9-46ed-aeb3-dd7a15709721@redhat.com>
In-Reply-To: <f58ea42a-8fd9-46ed-aeb3-dd7a15709721@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 30 Oct 2025 11:14:01 -0400
X-Gm-Features: AWmQ_bnEec-A8YD2Md5D3lEA-JwJgggIdTqxlQPpl9Ju3_9ULsYSQJqe6rT22uM
Message-ID: <CAFn=p-YDmsNSZO7geB+reX7=mytPy2keaoPEqmNmukc+g-g0cA@mail.gmail.com>
Subject: Re: [PATCH RFC 09/10] python: quote dotted dependency keys
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Qemu-block <qemu-block@nongnu.org>, Hanna Reitz <hreitz@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009db5f5064261b3a3"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--0000000000009db5f5064261b3a3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025, 4:41=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrote:

> On 28/10/2025 23.03, John Snow wrote:
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >   pythondeps.toml | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/pythondeps.toml b/pythondeps.toml
> > index 70e83320855..a5cdf94a791 100644
> > --- a/pythondeps.toml
> > +++ b/pythondeps.toml
> > @@ -32,8 +32,8 @@ sphinx =3D { accepted =3D ">=3D3.4.3", installed =3D =
"6.2.1",
> canary =3D "sphinx-build" }
> >   sphinx_rtd_theme =3D { accepted =3D ">=3D0.5", installed =3D "1.2.2" =
}
> >
> >   [tests]
> > -qemu_qmp =3D { accepted =3D ">=3D0.0.5", installed =3D "0.0.5" }
> > +"qemu.qmp" =3D { accepted =3D ">=3D0.0.5", installed =3D "0.0.5" }
> >
> >   [functests]
> > -qemu_qmp =3D { accepted =3D ">=3D0.0.5", installed =3D "0.0.5" }
> > +"qemu.qmp" =3D { accepted =3D ">=3D0.0.5", installed =3D "0.0.5" }
> >   pygdbmi =3D { accepted =3D ">=3D0.11.0.0", installed =3D "0.11.0.0" }
>
> Uh, why not immediately using this in patch 4 ?
>

Mea culpa, I fixed this after send. I really meant "RFC" this time, sorry!


>   Thomas
>
>

--0000000000009db5f5064261b3a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 30, 2025, 4:41=E2=80=
=AFAM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 28/10/2025 23.03,=
 John Snow wrote:<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0pythondeps.toml | 4 ++--<br>
&gt;=C2=A0 =C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/pythondeps.toml b/pythondeps.toml<br>
&gt; index 70e83320855..a5cdf94a791 100644<br>
&gt; --- a/pythondeps.toml<br>
&gt; +++ b/pythondeps.toml<br>
&gt; @@ -32,8 +32,8 @@ sphinx =3D { accepted =3D &quot;&gt;=3D3.4.3&quot;, =
installed =3D &quot;6.2.1&quot;, canary =3D &quot;sphinx-build&quot; }<br>
&gt;=C2=A0 =C2=A0sphinx_rtd_theme =3D { accepted =3D &quot;&gt;=3D0.5&quot;=
, installed =3D &quot;1.2.2&quot; }<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0[tests]<br>
&gt; -qemu_qmp =3D { accepted =3D &quot;&gt;=3D0.0.5&quot;, installed =3D &=
quot;0.0.5&quot; }<br>
&gt; +&quot;qemu.qmp&quot; =3D { accepted =3D &quot;&gt;=3D0.0.5&quot;, ins=
talled =3D &quot;0.0.5&quot; }<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0[functests]<br>
&gt; -qemu_qmp =3D { accepted =3D &quot;&gt;=3D0.0.5&quot;, installed =3D &=
quot;0.0.5&quot; }<br>
&gt; +&quot;qemu.qmp&quot; =3D { accepted =3D &quot;&gt;=3D0.0.5&quot;, ins=
talled =3D &quot;0.0.5&quot; }<br>
&gt;=C2=A0 =C2=A0pygdbmi =3D { accepted =3D &quot;&gt;=3D0.11.0.0&quot;, in=
stalled =3D &quot;0.11.0.0&quot; }<br>
<br>
Uh, why not immediately using this in patch 4 ?<br></blockquote></div></div=
><div dir=3D"auto"><br></div><div dir=3D"auto">Mea culpa, I fixed this afte=
r send. I really meant &quot;RFC&quot; this time, sorry!</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_cont=
ainer"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">
<br>
=C2=A0 Thomas<br>
<br>
</blockquote></div></div></div>

--0000000000009db5f5064261b3a3--



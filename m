Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4EBCAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 08:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0c4H-0001sL-Vf; Mon, 22 Sep 2025 04:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1v0c49-0001pD-MI
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 04:38:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1v0c46-0005eh-Kc
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 04:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758530306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=48UJP3LGu3cB9uhq7+OQFYukpMMN3wNNmYqGHF+Z+3M=;
 b=ZPLbIj4oBnQ++pRisvJAar85Onq2GhaFasGrDnuYug0QtNEB2DgyuHSq0c6hR+NFd1M96S
 sBaeawWZ0NwnGn+amQR9RBdJCCMaKO6FAuJKyYP0Fq5nKbCOuu85PPV+HLTSdKrqI5zRXx
 50yEgYgJo1QOE3WCwzyAzmqKsBKZx1Q=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-4G62dVq4OEyFniS93_9Y_g-1; Mon, 22 Sep 2025 04:38:22 -0400
X-MC-Unique: 4G62dVq4OEyFniS93_9Y_g-1
X-Mimecast-MFC-AGG-ID: 4G62dVq4OEyFniS93_9Y_g_1758530302
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-32ee4998c50so3949087a91.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 01:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758530302; x=1759135102;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=48UJP3LGu3cB9uhq7+OQFYukpMMN3wNNmYqGHF+Z+3M=;
 b=u4NGDvMM0c4X50n30YiXL6L9RsPAcKpxFm9nRrMkaAQnUefXbRZDfyVusLoujmGM41
 5WdWOFjlddZ8Oic1S5ufkbvfWEgiCzDBRR96vPQV540ZULVceys6eVbioEnc3E6hg6lM
 iPx0NyyYKBymzaqfQIyOJxgZbDTUtrKKQSrM5WwPTnQM35wAe0mOAXSIw2nLPPp4/OQ2
 PD6pH07H8cKrRDN8ta7B4zcvpaQmYccJo7gVzBtYMbnLZakH+NEwnA9wFPzaoNWffxg2
 bbKQklJ5ya/GgMpnzFGa4OSTYr4bkRDqyK7WjyGXHzQhsbPktDBhvQ7tqq/H4gjDGh29
 mTIg==
X-Gm-Message-State: AOJu0YwA4u4imGQ8k5syQbi+n2M1NzGCOwoz/7GHDMGV56kfMLpsHD/3
 Gt8IjOg/O9BnaUXq4/4wnfaxdPuM8fsF2x1K16iyLYS7mahZrTNZDJTgbs+tAxz1+0d9Ee7r7vI
 6BDmZTAdmweJgqUkXN0cFvi3hW0dH52FTP447rXCtZjSVmQ3wQN3Cm/Ry9hJ1Bu6EojfGkn16es
 lhClTs9Gv+xq9E6IUipHH1dHX9Qf0aMiM=
X-Gm-Gg: ASbGncvJNmDCR34Prj4n8ic0bHa4YihFtmF9BwYW7meQCSpsLrXx5vVQ/RKOd6r9AVu
 UpxCOcCluUfg30J11bCRd3DD5sS9bZSxecwmj53VzDRMMiO5TIQ7d8LDIECuKOGqv4oVV6Gz7eA
 Uqc3YdYSfuo9uFlleDISzuBl+4BM8i4TYQDOKzF+5pXUX3xvB+p4/w6w==
X-Received: by 2002:a17:90b:3f87:b0:32e:5d87:8abc with SMTP id
 98e67ed59e1d1-3309838e02amr12473532a91.36.1758530301577; 
 Mon, 22 Sep 2025 01:38:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaSll1YfFXMnHRwFevQmvajDAAG9IN1IyREzipGX1m4HMaBCjiCl6Keb523JT9Mk7vj3Tmfb3ET41JSwE0FXU=
X-Received: by 2002:a17:90b:3f87:b0:32e:5d87:8abc with SMTP id
 98e67ed59e1d1-3309838e02amr12473509a91.36.1758530301111; Mon, 22 Sep 2025
 01:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250919133320.240145-1-marcandre.lureau@redhat.com>
 <20250919133320.240145-15-marcandre.lureau@redhat.com>
 <aM1m13xBnM9WU_E3@redhat.com>
In-Reply-To: <aM1m13xBnM9WU_E3@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 22 Sep 2025 12:38:09 +0400
X-Gm-Features: AS18NWDl7dcT8INhQy5OLAhJfrRCpBwefBR-Nu0yKl_HL67KL8hVcDXDJFGp2D4
Message-ID: <CAMxuvayXSdVaz=i56T686oKpKf5gE4y6YaPgedPBKGQEPx0v8w@mail.gmail.com>
Subject: Re: [PATCH 14/24] tests: move mips to debian-legacy-test-cross
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, 
 Yonggang Luo <luoyonggang@gmail.com>, Warner Losh <imp@bsdimp.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000eccba7063f5fbdf4"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--000000000000eccba7063f5fbdf4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Sep 19, 2025 at 6:21=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Fri, Sep 19, 2025 at 05:33:08PM +0400, marcandre.lureau@redhat.com
> wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > We are updating debian which dropped support for it:
> >
> https://www.debian.org/releases/trixie/release-notes/issues.html#mips-arc=
hitectures-removed
>
> If Debian 13 has dropped it, why aren't we just keeping the mips
> dockerfiles on 12 ?
>
> The debian-legacy-test-cross a manually written dockerfile that
> has almost none of our deps installed, and is still on 11 which
> is outside our support matrix now. So I don't think we should
> be expanding use of debian-legacy-test-cross, ideally it would
> be removed entirely.
>
>
debian-legacy-test-cross is for tests/tcg. Debian 11 supports more
architecture than 12 or 13..


> > diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
> > index 7a92fe388f..9da20ff7c3 160000
> > --- a/tests/lcitool/libvirt-ci
> > +++ b/tests/lcitool/libvirt-ci
> > @@ -1 +1 @@
> > -Subproject commit 7a92fe388f55d1bbc33e639e3484533f88c542ec
> > +Subproject commit 9da20ff7c3bc9067804a7561c2ff87583b434853
>
> This shouldn't be here.
>
>
right


> > diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> > index 6f98a91277..917ff4abfb 100755
> > --- a/tests/lcitool/refresh
> > +++ b/tests/lcitool/refresh
> > @@ -215,16 +215,6 @@ try:
> >                                              "x86_64-linux-user,"
> >
> "i386-softmmu,i386-linux-user"))
> >
> > -    generate_dockerfile("debian-mips64el-cross", "debian-12",
> > -                        cross=3D"mips64el",
> > -                        trailer=3Dcross_build("mips64el-linux-gnuabi64=
-",
> > -
> "mips64el-softmmu,mips64el-linux-user"))
> > -
> > -    generate_dockerfile("debian-mipsel-cross", "debian-12",
> > -                        cross=3D"mipsel",
> > -                        trailer=3Dcross_build("mipsel-linux-gnu-",
> > -
> "mipsel-softmmu,mipsel-linux-user"))
> > -
>
> I'm not seeing the need to remove these, when they could just
> stay on -12, when the next commit updates the other arches
> to -13.
>

Indeed.. it depends how much we want to keep covering. We already don't
cover all qemu cross compilations. The question is do we want to keep
cross-compiling for soon unsupported arches?

@Benn=C3=A9e, Alex <alex.bennee@linaro.org> might know, thanks

--000000000000eccba7063f5fbdf4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 19, 2=
025 at 6:21=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berran=
ge@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">On Fri, Sep 19, 2025 at 05:33:08PM +0400,=
 <a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_blank">marcandre=
.lureau@redhat.com</a> wrote:<br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt; <br>
&gt; We are updating debian which dropped support for it:<br>
&gt; <a href=3D"https://www.debian.org/releases/trixie/release-notes/issues=
.html#mips-architectures-removed" rel=3D"noreferrer" target=3D"_blank">http=
s://www.debian.org/releases/trixie/release-notes/issues.html#mips-architect=
ures-removed</a><br>
<br>
If Debian 13 has dropped it, why aren&#39;t we just keeping the mips<br>
dockerfiles on 12 ?<br>
<br>
The debian-legacy-test-cross a manually written dockerfile that<br>
has almost none of our deps installed, and is still on 11 which<br>
is outside our support matrix now. So I don&#39;t think we should<br>
be expanding use of debian-legacy-test-cross, ideally it would<br>
be removed entirely.<br>
<br></blockquote><div><br></div><div>debian-legacy-test-cross is for tests/=
tcg. Debian 11 supports more architecture than 12 or 13..</div><div><br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci<br>
&gt; index 7a92fe388f..9da20ff7c3 160000<br>
&gt; --- a/tests/lcitool/libvirt-ci<br>
&gt; +++ b/tests/lcitool/libvirt-ci<br>
&gt; @@ -1 +1 @@<br>
&gt; -Subproject commit 7a92fe388f55d1bbc33e639e3484533f88c542ec<br>
&gt; +Subproject commit 9da20ff7c3bc9067804a7561c2ff87583b434853<br>
<br>
This shouldn&#39;t be here.<br>
<br></blockquote><div><br></div><div>right</div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
&gt; diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh<br>
&gt; index 6f98a91277..917ff4abfb 100755<br>
&gt; --- a/tests/lcitool/refresh<br>
&gt; +++ b/tests/lcitool/refresh<br>
&gt; @@ -215,16 +215,6 @@ try:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;x86_64-linux-user,&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;i386-softmmu,i386-linux-user&quot;))<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 generate_dockerfile(&quot;debian-mips64el-cross&quot;, =
&quot;debian-12&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 cross=3D&quot;mips64el&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 trailer=3Dcross_build(&quot;mips64el-linux-gnuabi64-&quot;,<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;mips64el-softmmu,mips64el-linux-user&quot;))<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 generate_dockerfile(&quot;debian-mipsel-cross&quot;, &q=
uot;debian-12&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 cross=3D&quot;mipsel&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 trailer=3Dcross_build(&quot;mipsel-linux-gnu-&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;mipsel-softmmu,mipsel-linux-user&quot;))<br>
&gt; -<br>
<br>
I&#39;m not seeing the need to remove these, when they could just<br>
stay on -12, when the next commit updates the other arches<br>
to -13.<br></blockquote><div><br></div><div>Indeed.. it depends how much we=
 want to keep covering. We already don&#39;t cover all qemu cross compilati=
ons. The question is do we want to keep cross-compiling for soon unsupporte=
d arches?</div><br></div><div class=3D"gmail_quote gmail_quote_container"><=
a class=3D"gmail_plusreply" id=3D"plusReplyChip-0" href=3D"mailto:alex.benn=
ee@linaro.org" tabindex=3D"-1">@Benn=C3=A9e, Alex</a>=C2=A0might know, than=
ks</div></div>

--000000000000eccba7063f5fbdf4--



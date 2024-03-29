Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD14C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 20:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqIwM-0005IH-Og; Fri, 29 Mar 2024 16:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rqIwK-0005Ht-HQ
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 16:35:04 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rqIwI-0005Xu-Cm
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 16:35:04 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a46f0da1b4fso294300066b.2
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 13:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711744500; x=1712349300; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4Fb6LY4JLqrh9VM0IcjxF2V7xw7ZePKpShbW8PNsR9U=;
 b=Q/87EWbOYczLxmNeQL3wPRGdvgGMaZC+AZBG/gJI9Kl+XCbk2LxaxB6hSySe3dk8ok
 cC+O+1N2m83iuGNwMmRCuh4chvumqOQMN1i3bAQfBGgiMgzhHjHcxwck/u689Emlf3Bd
 ZuuoXelq2aNJiSP/EBJXGMwUPz39sowwARU+WAtTz+GMuO0taVK4+JhIk+f6U0Hx4GAE
 G2JHw4v+/UQvO4Q2Lt6rdX0oMAyoI93hl1OMphqQFvOTkwggfuupnM2dYLjh6D2wf4hm
 W0MMjp+G38lx9wuRbMmrtwvCifbSB7bxMJ4FTcOckaCmBEv3Len3F95z380sFdeng41d
 QHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711744500; x=1712349300;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4Fb6LY4JLqrh9VM0IcjxF2V7xw7ZePKpShbW8PNsR9U=;
 b=p7VWnlswJc1dJMjAFK6f1gKqUXg3fLp8MZRL+ebsCl/MzXj2uM/T1GItLzlb3C5n8H
 QRWGxuOzybY6ALExw8hU4H//sFTD/eb78HMKwNfhVRailH0OCeK+IdpkBcQFiUdjj1U7
 z5a3NrXT2gEFTeF1djkUr6kM+aLp1aQn00J1mbRdLHX4ZggzijcQEQj/ATOJu1a9gm7L
 W/9Syf8WwKvi5DhTKN9QKw892PfxOJKn846mVycQAXM05wWXWT6X2OTXcBf5GtfO1PF+
 D6oB/jo6mmFLA1RMWg3yg2FImj0CZBT7WXr50aX/AMiw6CLyC+BFZeMVvgwmxgOfsvg9
 JjPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/IwEOmh8KCMf0Tuo8HhNCVVrAROjtTXRTiV6aEvyoC7oUGO9zqLulemt6QgtkN7N3PSt8h7+DEpBkzmJ5hZdFudIXloE=
X-Gm-Message-State: AOJu0YwyjnaF2SOLHCIe8tJ3Khly6voQgzquGPoIaSVyU/McqDc0o1Vq
 7Mfscuts4M2DllcKK7rh4IzC4wea0ts/wJxXhd5faPC1+S4YVroqFzbCSInYmQOPuif0a8aeC+t
 dNb96Spnnta1yk/Vow1mZeS7+VR1gjBeHaUF3ZQlVYLqH3lpmwEo=
X-Google-Smtp-Source: AGHT+IHZZ242cFResEM4c/CEfmvlGxgcc5/xgqDFxlALV+o3mOwJpGRdPgPWzneK0MOMdvS2qRSBuFZX6k7OgnO/oLc=
X-Received: by 2002:a17:906:2793:b0:a46:a8ba:60b3 with SMTP id
 j19-20020a170906279300b00a46a8ba60b3mr2161933ejc.37.1711744500442; Fri, 29
 Mar 2024 13:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <CABgObfbBSer0p3OnS7LKt53oWbWw-i=UponFGq5hQnb2rBE71w@mail.gmail.com>
 <Zgcd48BX078i0A-n@redhat.com>
In-Reply-To: <Zgcd48BX078i0A-n@redhat.com>
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Date: Sat, 30 Mar 2024 07:34:50 +1100
Message-ID: <CAHDbmO3ZsZE_Sf8mr6duBtKKGqBfh+F_zynokvFQHoRbAVKA1Q@mail.gmail.com>
Subject: Re: Backdoor in xz, should we switch compression format for tarballs?
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Michael Roth <michael.roth@amd.com>, "Maydell,
 Peter" <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000e543700614d29205"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--000000000000e543700614d29205
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Also does qemu link to libarchive? The original analysis wasn't a full
reverse engineer of the payload so we don't know if it only affects sshd.

On Sat, 30 Mar 2024, 07:01 Daniel P. Berrang=C3=A9, <berrange@redhat.com> w=
rote:

> On Fri, Mar 29, 2024 at 06:59:30PM +0100, Paolo Bonzini wrote:
> > For more info, see
> >
> https://lwn.net/ml/oss-security/20240329155126.kjjfduxw2yrlxgzm@awork3.an=
arazel.de/
> > but, essentially, xz was backdoored and it seems like upstream was
> directly
> > responsible for this.
> >
> > Based on this, should we switch our distribution from bz2+xz to bz2+zst=
d
> or
> > bz2+lzip?
>
> Based on the attack vector of pre-loading git with an exploit, but then
> modifying the tarball to activate it, there's a bigger question of whethe=
r
> users should really trust manually created tarballs at all ? You don't
> anything about either the tarball creator, or the state of creators'
> machine,
> even if it is signed. How can you trust that its contents is a faithful
> representation of the tagged release from git it claims to be?
>
> This issue could prompt a push towards distros only handling tarballs
> directly auto-generated from a git tag, in a reliably reproducible manner=
.
>
> Obviously you couldn't actually trust the upstream maintainer in this
> case, but at least if you're using a reproducible git tarball you can
> verify every link in the chain right through each git commit, and don't
> have this manual tarball whose contents need to be to picked apart.
>
> TL;DR; I think we should consider our tarball distribution options, but
> lets wait for the dust to settle and not rush into decisions.
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>
>

--000000000000e543700614d29205
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Also does qemu link to libarchive? The original analysis =
wasn&#39;t a full reverse engineer of the payload so we don&#39;t know if i=
t only affects sshd.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Sat, 30 Mar 2024, 07:01 Daniel P. Berrang=C3=A9, &lt=
;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">On Fri, Mar 29, 2024 at 06:59:30PM =
+0100, Paolo Bonzini wrote:<br>
&gt; For more info, see<br>
&gt; <a href=3D"https://lwn.net/ml/oss-security/20240329155126.kjjfduxw2yrl=
xgzm@awork3.anarazel.de/" rel=3D"noreferrer noreferrer" target=3D"_blank">h=
ttps://lwn.net/ml/oss-security/20240329155126.kjjfduxw2yrlxgzm@awork3.anara=
zel.de/</a><br>
&gt; but, essentially, xz was backdoored and it seems like upstream was dir=
ectly<br>
&gt; responsible for this.<br>
&gt; <br>
&gt; Based on this, should we switch our distribution from bz2+xz to bz2+zs=
td or<br>
&gt; bz2+lzip?<br>
<br>
Based on the attack vector of pre-loading git with an exploit, but then<br>
modifying the tarball to activate it, there&#39;s a bigger question of whet=
her<br>
users should really trust manually created tarballs at all ? You don&#39;t<=
br>
anything about either the tarball creator, or the state of creators&#39; ma=
chine,<br>
even if it is signed. How can you trust that its contents is a faithful<br>
representation of the tagged release from git it claims to be?<br>
<br>
This issue could prompt a push towards distros only handling tarballs<br>
directly auto-generated from a git tag, in a reliably reproducible manner.<=
br>
<br>
Obviously you couldn&#39;t actually trust the upstream maintainer in this<b=
r>
case, but at least if you&#39;re using a reproducible git tarball you can<b=
r>
verify every link in the chain right through each git commit, and don&#39;t=
<br>
have this manual tarball whose contents need to be to picked apart.<br>
<br>
TL;DR; I think we should consider our tarball distribution options, but<br>
lets wait for the dust to settle and not rush into decisions.<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a h=
ref=3D"https://www.flickr.com/photos/dberrange" rel=3D"noreferrer noreferre=
r" target=3D"_blank">https://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://fstop138.berrange=
.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0=
 <a href=3D"https://www.instagram.com/dberrange" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://www.instagram.com/dberrange</a> :|<br>
<br>
<br>
</blockquote></div>

--000000000000e543700614d29205--


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E65D65553
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 20:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG1te-0003nG-Uo; Tue, 26 Nov 2024 15:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1tG1td-0003mk-IX; Tue, 26 Nov 2024 15:10:53 -0500
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1tG1tW-00016b-Mg; Tue, 26 Nov 2024 15:10:52 -0500
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3a76df43746so24714325ab.1; 
 Tue, 26 Nov 2024 12:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732651840; x=1733256640; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OZcPBE+v7KMTwCQ8k9OZyOuvM0Ux/flzgVHYBPLK/rU=;
 b=jQU0wFguW3nNLs+CUz+WQL1KDTN9UY8HebmNNhnSUECwSSZcEcik8r4hQYfTJybaRr
 q39SyQXcvzsAjt3mHKbeYqm3qGyFkAhgBBGJUGux86ByLXRYkgX3Wg9QhjdCwNN/ktkM
 y0E0e7th6PvyDlf66bc3zhTaeLja2ah6xuNKQrXdfVj6tFEBQN+KUELI+VQL2NnNHI/K
 tDMrxOgJ4XIhAfIxUt54PWwg/o0Vo6FuNVzSIkcBqWnEuOrAFdX0r4qp4OPKo649ZX0s
 FekHaxDhcXZL/suX25lUDOZ9jHYEDD9lCpKHQ5Kd4/8Iuxmy/RobpJBgKwwlPiCdmt5l
 GJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732651840; x=1733256640;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OZcPBE+v7KMTwCQ8k9OZyOuvM0Ux/flzgVHYBPLK/rU=;
 b=irjuPhrPAeLJNHbWWtYkHeAMA5Pc6QWV5yiJB6BsPx3tzFEIPVHJ76SPRG+HKcZIVl
 iD9/x1KMD5sn/nxtAh3jAVGyR/5jMkA5AIaJbdKEy2mGPjkynMMnuAFBXLtZjPQwPXOP
 J11t4pO8XxueYlFwar0XD+riPb5gKyk2iUABSCskWo3x0dxkFBh+wKEWI7MiluHRQ8JO
 kVdQBJAR3tEqD+opRkkUjd2H/DIkReqSMxJbeOX2FHJ+dVeUubvJktK0s64549KJK+/8
 p2Sxw25zDltMvVzneg2nflTWy3lBxOb6Egk1VhCATWhTkMXdyp6JL3Q9VpNc4Q3yaSuw
 Duug==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0ywJzmMShLGm45YyvBER+/gDOHHktPklqDMi4oxV9Vx+VwkoyiBB9iYfK6jcO2RKhZSt4pyfj8w==@nongnu.org
X-Gm-Message-State: AOJu0YwZu2EHTe4t8oghdECISfLLXKePRkEA/nI6tA0cuEZKhv4gXUbw
 tr/GSDPRNMk/wDULiJ3Lw/321fhyuOgGal2LWDtqf9LeuLBs1qx25SHEzGBj4CRJKPNOsd+uN2/
 /OlZ8ZZoTZD3NP10JZPBfGR9IuU8=
X-Gm-Gg: ASbGncvGtMZoqT2XXkxqL5h/1wdlEVKpL3RGLNuD1Ye1LwDH7FZ0DyBCaJ2DbiOKOLy
 KJFmkUFK0OOYBygUKp2u/D6t8/qCl6rrv48UwRpNWqRqChd5VPaYTp+CDrfqtcg==
X-Google-Smtp-Source: AGHT+IHGkVovRLTc9S8HzRFYl+KODBFIBIgOxgtVslpQuXwW+3p9gnBcneyFvj8OWSGZoxtiAdX4ghkN09xcvjBep50=
X-Received: by 2002:a92:c243:0:b0:3a7:65fb:b3da with SMTP id
 e9e14a558f8ab-3a7c55cff9fmr3995005ab.15.1732651840028; Tue, 26 Nov 2024
 12:10:40 -0800 (PST)
MIME-Version: 1.0
References: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
 <20241122225049.1617774-9-pierrick.bouvier@linaro.org>
 <c18bc538-2036-49ad-b629-ae40486934cc@linaro.org>
In-Reply-To: <c18bc538-2036-49ad-b629-ae40486934cc@linaro.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Tue, 26 Nov 2024 21:10:29 +0100
Message-ID: <CAPan3Wqw+LG1hNx3RFR6SbN4FGzO+fCZvgDNfcPG=dU3heU5yQ@mail.gmail.com>
Subject: Re: [PATCH 08/12] docs/system/arm/orangepi: update links
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 alex.bennee@linaro.org, Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>, 
 Alistair Francis <alistair@alistair23.me>
Content-Type: multipart/alternative; boundary="00000000000071cf1d0627d67107"
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-il1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000071cf1d0627d67107
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Pierrick,

Thanks for including orangepi documentation in your updates.

On Tue, Nov 26, 2024 at 8:00=E2=80=AFPM Pierrick Bouvier <
pierrick.bouvier@linaro.org> wrote:

> On 11/22/24 14:50, Pierrick Bouvier wrote:
> > Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > ---
> >   docs/system/arm/orangepi.rst | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/docs/system/arm/orangepi.rst b/docs/system/arm/orangepi.rs=
t
> > index 9afa54213b0..db87e81fec4 100644
> > --- a/docs/system/arm/orangepi.rst
> > +++ b/docs/system/arm/orangepi.rst
> > @@ -119,7 +119,7 @@ Orange Pi PC images
> >   Note that the mainline kernel does not have a root filesystem. You ma=
y
> provide it
> >   with an official Orange Pi PC image from the official website:
> >
> > -  http://www.orangepi.org/downloadresources/
> > +  http://www.orangepi.org/html/serviceAndSupport/index.html
> >
> >   Another possibility is to run an Armbian image for Orange Pi PC which
> >   can be downloaded from:
> > @@ -213,7 +213,7 @@ including the Orange Pi PC. NetBSD 9.0 is known to
> work best for the Orange Pi P
> >   board and provides a fully working system with serial console,
> networking and storage.
> >   For the Orange Pi PC machine, get the 'evbarm-earmv7hf' based image
> from:
> >
> > -
> https://cdn.netbsd.org/pub/NetBSD/NetBSD-9.0/evbarm-earmv7hf/binary/gzimg=
/armv7.img.gz
> > +
> https://archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/=
binary/gzimg/armv7.img.gz
> >
> >   The image requires manually installing U-Boot in the image. Build
> U-Boot with
> >   the orangepi_pc_defconfig configuration as described in the previous
> section.
>
> Regarding our conversation on IRC with Peter, is seems that google
> reference www.orangepi.org only through http, and not https.
> As the host is currently down, I'm not sure if https really works or
> not. So maybe it's better to stick with http for now.
>

Yes, I also just noted that the orangepi.org website is not responding.
However earlier this week, I was able to load the new URL above to the
official website.
Perhaps it is only temporary down, but we can only be sure once it comes
back up.
The NetBSD image URL is OK, ive also verified that the hash is the same.

So for me:

Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>

Regards,
Niek

--=20
Niek Linnenbank

--00000000000071cf1d0627d67107
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hello Pierrick,</div><div><br></div>=
<div>Thanks for including orangepi documentation in your updates.<br></div>=
</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
On Tue, Nov 26, 2024 at 8:00=E2=80=AFPM Pierrick Bouvier &lt;<a href=3D"mai=
lto:pierrick.bouvier@linaro.org">pierrick.bouvier@linaro.org</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 11/22/24 14:=
50, Pierrick Bouvier wrote:<br>
&gt; Signed-off-by: Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier=
@linaro.org" target=3D"_blank">pierrick.bouvier@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0docs/system/arm/orangepi.rst | 4 ++--<br>
&gt;=C2=A0 =C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/docs/system/arm/orangepi.rst b/docs/system/arm/orangepi.r=
st<br>
&gt; index 9afa54213b0..db87e81fec4 100644<br>
&gt; --- a/docs/system/arm/orangepi.rst<br>
&gt; +++ b/docs/system/arm/orangepi.rst<br>
&gt; @@ -119,7 +119,7 @@ Orange Pi PC images<br>
&gt;=C2=A0 =C2=A0Note that the mainline kernel does not have a root filesys=
tem. You may provide it<br>
&gt;=C2=A0 =C2=A0with an official Orange Pi PC image from the official webs=
ite:<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 <a href=3D"http://www.orangepi.org/downloadresources/" rel=3D"=
noreferrer" target=3D"_blank">http://www.orangepi.org/downloadresources/</a=
><br>
&gt; +=C2=A0 <a href=3D"http://www.orangepi.org/html/serviceAndSupport/inde=
x.html" rel=3D"noreferrer" target=3D"_blank">http://www.orangepi.org/html/s=
erviceAndSupport/index.html</a><br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0Another possibility is to run an Armbian image for Orange =
Pi PC which<br>
&gt;=C2=A0 =C2=A0can be downloaded from:<br>
&gt; @@ -213,7 +213,7 @@ including the Orange Pi PC. NetBSD 9.0 is known to=
 work best for the Orange Pi P<br>
&gt;=C2=A0 =C2=A0board and provides a fully working system with serial cons=
ole, networking and storage.<br>
&gt;=C2=A0 =C2=A0For the Orange Pi PC machine, get the &#39;evbarm-earmv7hf=
&#39; based image from:<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 <a href=3D"https://cdn.netbsd.org/pub/NetBSD/NetBSD-9.0/evbarm=
-earmv7hf/binary/gzimg/armv7.img.gz" rel=3D"noreferrer" target=3D"_blank">h=
ttps://cdn.netbsd.org/pub/NetBSD/NetBSD-9.0/evbarm-earmv7hf/binary/gzimg/ar=
mv7.img.gz</a><br>
&gt; +=C2=A0 <a href=3D"https://archive.netbsd.org/pub/NetBSD-archive/NetBS=
D-9.0/evbarm-earmv7hf/binary/gzimg/armv7.img.gz" rel=3D"noreferrer" target=
=3D"_blank">https://archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm=
-earmv7hf/binary/gzimg/armv7.img.gz</a><br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0The image requires manually installing U-Boot in the image=
. Build U-Boot with<br>
&gt;=C2=A0 =C2=A0the orangepi_pc_defconfig configuration as described in th=
e previous section.<br>
<br>
Regarding our conversation on IRC with Peter, is seems that google <br>
reference <a href=3D"http://www.orangepi.org" rel=3D"noreferrer" target=3D"=
_blank">www.orangepi.org</a> only through http, and not https.<br>
As the host is currently down, I&#39;m not sure if https really works or <b=
r>
not. So maybe it&#39;s better to stick with http for now.<br></blockquote><=
div>=C2=A0</div><div>Yes, I also just noted that the <a href=3D"http://oran=
gepi.org">orangepi.org</a> website is not responding. However earlier this =
week, I was able to load the new URL above to the official website.</div><d=
iv>Perhaps it is only temporary down, but we can only be sure once it comes=
 back up.</div><div>The NetBSD image URL is OK, ive also verified that the =
hash is the same.</div><div><br></div><div>So for me:<br></div><div><br></d=
iv><div>Reviewed-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@g=
mail.com">nieklinnenbank@gmail.com</a>&gt;<br></div></div><div><br></div><d=
iv>Regards,</div><div>Niek<br clear=3D"all"></div><br><span class=3D"gmail_=
signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">=
<div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></div></div>

--00000000000071cf1d0627d67107--


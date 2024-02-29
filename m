Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96ECCC54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 10:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfdS4-0002Ov-PM; Thu, 29 Feb 2024 05:15:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rfdS2-0002Ng-En
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 05:15:42 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rfdRy-0001XT-8z
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 05:15:42 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5dca1efad59so534656a12.2
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 02:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1709201614; x=1709806414;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b4GYInZJDerjLh6UOqr8cUrr2tEmGpSkmlQoaOJogW0=;
 b=Po1IzU5rE/g8qpVA2Qov/stnw3ZyIOQ9nZxbrho7l8RR0XIM76z8XHjxorYrUAOpFx
 0f+k19BEQ77JGBo5j0W4t2ZTDU+Ko6RdjAj1KmNCydQqUxYs4AoLrbtX5VE04cugv3lu
 7bKE6eZEL3ODc+3FDfIYbp4VXgmMY0TsR6FrUnWzCN5/sU2ceN6aoVh5rZ+M+X/5cMNk
 FCE81x0vob5Sz7KPPy6ZSRrAaD/NBoiYt2S6DIJ+yHENQNyz+UHIdIoY/+x7M9Ghsm18
 VyoWZFpvcARD6rmsBzyMF+Hs5yhEem29S/e3Vi4vgbhdCX4GiriuWlGADohDAngtA8vm
 q2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709201614; x=1709806414;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b4GYInZJDerjLh6UOqr8cUrr2tEmGpSkmlQoaOJogW0=;
 b=BZazbfjB5XcZ86T/gjbfQM+8FdI0ZkSIVulaDOUMdgI5j19oeTavm8yLt5U2163FnI
 tZKNDum6a84Vx/zdI3d5oLjp+gDpkpxZot+fUY607Mv7YZLrUPw5S7KSs59C1E/vACJs
 wRpbMIB4U0anoSfoOysUKuR3FahpBETwTpXjyKDJErB7m+TSbGpI+NWlvVDbvsa9azX0
 r3CNbcBbq5xnX7mfvnhINuFeao2EtavFY+HeLP4dFiQJWmhZ6J3km8LXrVD6YwAc3bf6
 fiia2fAiDPq/78FBgCdGY1U6yrjgneUSkBVlS4vRhXyfBqr/UytC29aKNtRDjtXWTBQG
 cxSw==
X-Gm-Message-State: AOJu0YyEOD7Q4P7Z4pQLf3jF9zTM59aU1RDXBoRga+J+iWaujIWXvchu
 4F66RTS050j4xv27lMd8QR3VIPee75n5z39NXrnmFbvqsGaB6NlUiliNdVeVQWzYCDWikgWecD5
 MRdmarXPvCuNmgzimVp9sfprFb5XGsen2S3YCXg==
X-Google-Smtp-Source: AGHT+IFZngvKuRVYzYPt5tVGBs+OTq/a+D5FDuIGlfocTepdLL2hcgY+rTlsLTuWZrXSKLiEmqSZHxuCyt+GRwieykI=
X-Received: by 2002:a17:90a:9a93:b0:29a:ec42:91fd with SMTP id
 e19-20020a17090a9a9300b0029aec4291fdmr1692808pjp.46.1709201612412; Thu, 29
 Feb 2024 02:13:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1708527979.git.yong.huang@smartx.com>
 <ZeBIdNQYkq4tnF7h@redhat.com>
In-Reply-To: <ZeBIdNQYkq4tnF7h@redhat.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Thu, 29 Feb 2024 18:13:16 +0800
Message-ID: <CAK9dgmZdPZSHVCrJP9G6At0FzEsXjwHegQixLL=J4QQoMxbCjQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] Support GM/T 0018-2012 cryptographic standard
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000f53102061282822d"
Received-SPF: none client-ip=2607:f8b0:4864:20::535;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000f53102061282822d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 5:04=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Sat, Feb 24, 2024 at 10:34:55PM +0800, Hyman Huang wrote:
> > This patchset introduce GM/T 0018-2012 as a crypto backend driver,
> > which is applied for block encryption. Currently, we support SM4
> > cipher algorithm only.
> >
> > GM/T 0018-2012 is a cryptographic standard issued by the State
> > Cryptography Administration of China. Visit https://hbba.sacinfo.org.cn
> > search GM/T 0018-2012 for brief introduction.
> >
> > The objective of the standard is to develop a uniform application
> > interface standard for the service-based cryptography device under
> > the public key cryptographic infrastructure application framework,
> > and to call the cryptography device through this interface to
> > provide basic cryptographic services for the uppler layer. For
> > more information about contents of the standard, download the
> > specificaiton from:
> > "https://github.com/guanzhi/GM-Standards/blob/master/GMT=E5=AF=86=E7=A0=
=81=E8=A1=8C=E6=A0=87/
> > GMT 00018-2012 =E5=AF=86=E7=A0=81=E8=AE=BE=E5=A4=87=E5=BA=94=E7=94=A8=
=E6=8E=A5=E5=8F=A3=E8=A7=84=E8=8C=83.pdf"
> >
> > There are two benefits to doing this, at least.
> >  * Performance - using a cryptography device for block encryption
> >                  offers an opportunity to enhance the input/output
> >                  performance once the hardware is certified
> >  * Secrecy - hardware manufacturers may fortify cryptography
> >              equipment with security features, so increasing the
> >              secrecy of block encryption.
> >
> > The precise way that vendors implement the standard APIs for data
> > encryption using the cryptographic device is uncoupled from the
> > GM/T 0018-2012 specification. Thus, if developers enable this
> > functionality with the following conditions met, we could accomplish
> > the general implementation:
> >
> > 1. rename the header file provided by vendor to gmt-0018-2012.h
> >    and copy it to the /usr/include directory.
> > 2. rename the dynamic library provided by vendor to
> >    gmt_0018_2012.so and copy it to the /usr/lib64 or any directory
> >    that linker could find before compiling QEMU.
> > 3. enable crypto_gmt option when compiling QEMU and make the feature
> >    availiable.
> >
> > By offering a development package for GM/T 0018-2012, the above
> > provisions could be standardized; unfortunately, the hardware
> > manufacturer has not completed this task. So developers who don't
> > work with the vendor to obtain the cryptography device and related
> > library may not be able to test this functionality because the
> > standard implementation depends on the cryptography device supplied
> > by the hardware vendor. We are hesitant to contribute to this series
> > as a result.
>
> Hmm, yes, that is a pretty unpleasant approach.
>
> IMHO there really needs to be a reference implementation that is
> pure software. eg a gmt_0018_2012.so + header files that simply
>

Ok, this is a preferred choice but more work should be done for
the pure software implementation, we may try it in space time.

Thanks for the comments,

Yong


> uses an existing crypto library. That way applications can build
> and test their support for this, without having to have access
> to a specific piece of hardware. Hardware vendors should only
> have to provide their library impl, not the headers.


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

--=20
Best regards

--000000000000f53102061282822d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 29, 20=
24 at 5:04=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrang=
e@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">=
On Sat, Feb 24, 2024 at 10:34:55PM +0800, Hyman Huang wrote:<br>
&gt; This patchset introduce GM/T 0018-2012 as a crypto backend driver,<br>
&gt; which is applied for block encryption. Currently, we support SM4<br>
&gt; cipher algorithm only.<br>
&gt; <br>
&gt; GM/T 0018-2012 is a cryptographic standard issued by the State<br>
&gt; Cryptography Administration of China. Visit <a href=3D"https://hbba.sa=
cinfo.org.cn" rel=3D"noreferrer" target=3D"_blank">https://hbba.sacinfo.org=
.cn</a><br>
&gt; search GM/T 0018-2012 for brief introduction.<br>
&gt; <br>
&gt; The objective of the standard is to develop a uniform application<br>
&gt; interface standard for the service-based cryptography device under<br>
&gt; the public key cryptographic infrastructure application framework,<br>
&gt; and to call the cryptography device through this interface to<br>
&gt; provide basic cryptographic services for the uppler layer. For<br>
&gt; more information about contents of the standard, download the<br>
&gt; specificaiton from:<br>
&gt; &quot;<a href=3D"https://github.com/guanzhi/GM-Standards/blob/master/G=
MT" rel=3D"noreferrer" target=3D"_blank">https://github.com/guanzhi/GM-Stan=
dards/blob/master/GMT</a>=E5=AF=86=E7=A0=81=E8=A1=8C=E6=A0=87/<br>
&gt; GMT 00018-2012 =E5=AF=86=E7=A0=81=E8=AE=BE=E5=A4=87=E5=BA=94=E7=94=A8=
=E6=8E=A5=E5=8F=A3=E8=A7=84=E8=8C=83.pdf&quot;<br>
&gt; <br>
&gt; There are two benefits to doing this, at least.<br>
&gt;=C2=A0 * Performance - using a cryptography device for block encryption=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 offers a=
n opportunity to enhance the input/output<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 performa=
nce once the hardware is certified<br>
&gt;=C2=A0 * Secrecy - hardware manufacturers may fortify cryptography<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 equipment with securit=
y features, so increasing the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 secrecy of block encry=
ption.<br>
&gt; <br>
&gt; The precise way that vendors implement the standard APIs for data<br>
&gt; encryption using the cryptographic device is uncoupled from the<br>
&gt; GM/T 0018-2012 specification. Thus, if developers enable this<br>
&gt; functionality with the following conditions met, we could accomplish<b=
r>
&gt; the general implementation:<br>
&gt; <br>
&gt; 1. rename the header file provided by vendor to gmt-0018-2012.h<br>
&gt;=C2=A0 =C2=A0 and copy it to the /usr/include directory.<br>
&gt; 2. rename the dynamic library provided by vendor to<br>
&gt;=C2=A0 =C2=A0 gmt_0018_2012.so and copy it to the /usr/lib64 or any dir=
ectory<br>
&gt;=C2=A0 =C2=A0 that linker could find before compiling QEMU.<br>
&gt; 3. enable crypto_gmt option when compiling QEMU and make the feature<b=
r>
&gt;=C2=A0 =C2=A0 availiable.<br>
&gt; <br>
&gt; By offering a development package for GM/T 0018-2012, the above<br>
&gt; provisions could be standardized; unfortunately, the hardware<br>
&gt; manufacturer has not completed this task. So developers who don&#39;t<=
br>
&gt; work with the vendor to obtain the cryptography device and related<br>
&gt; library may not be able to test this functionality because the<br>
&gt; standard implementation depends on the cryptography device supplied<br=
>
&gt; by the hardware vendor. We are hesitant to contribute to this series<b=
r>
&gt; as a result.<br>
<br>
Hmm, yes, that is a pretty unpleasant approach.<br>
<br>
IMHO there really needs to be a reference implementation that is<br>
pure software. eg a gmt_0018_2012.so + header files that simply<br></blockq=
uote><div><br></div><div><div class=3D"gmail_default" style=3D"font-family:=
&quot;comic sans ms&quot;,sans-serif">Ok, this is a preferred choice but mo=
re work should be done for</div><div class=3D"gmail_default" style=3D"font-=
family:&quot;comic sans ms&quot;,sans-serif">the pure software implementati=
on, we may try it in space time.</div><br></div><div><div class=3D"gmail_de=
fault" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Thanks fo=
r the comments,=C2=A0</div><div class=3D"gmail_default" style=3D"font-famil=
y:&quot;comic sans ms&quot;,sans-serif"><br></div><div class=3D"gmail_defau=
lt" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Yong</div></=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-col=
or:rgb(204,204,204);padding-left:1ex">
uses an existing crypto library. That way applications can build<br>
and test their support for this, without having to have access<br>
to a specific piece of hardware. Hardware vendors should only<br>
have to provide their library impl, not the headers.</blockquote><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width=
:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-lef=
t:1ex">
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--000000000000f53102061282822d--


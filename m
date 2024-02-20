Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2761DC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYVG-0001aC-Qc; Tue, 20 Feb 2024 17:22:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faiqueali.109@gmail.com>)
 id 1rcYVF-0001a1-Mm
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:22:17 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faiqueali.109@gmail.com>)
 id 1rcYVE-0002xL-0x
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:22:17 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-563d32ee33aso6597969a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 14:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708467732; x=1709072532; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EoXgfZWN8hEQdPIbTxIIUtmVyGshj4bWDRnk2KYh35U=;
 b=CE3izgB+UpDNS1Fv7uh5KaQ7PLTYYyq5ZwAqjy1xDIa/FQ2lffY4OrbKNmop0OTVNl
 xuCcAiK9LSzreMywWD+DEzbxasx3Yy63KKd8YGkbk3J9om0rFrB6/y0z5J3yMoc+vgFm
 5VRqADAb/rCuN5LWpnUFo854U4g9OMKq7EF1Auw+Txt93LlhuIYP993CWygf6JSH0XnU
 kgCRaSlqynnWYYM60Uc5MDomDL3NIHbmwq8ZNwoUuxLmTIDY6dQj6aH6SkzOLaG/tHxy
 X8oF6pPcHclpIIu19Qe4FO6KJ9a202SXo9tnTybGqp2plH+xQfTRHKnRSLAS9uQXD4WJ
 jHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708467732; x=1709072532;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EoXgfZWN8hEQdPIbTxIIUtmVyGshj4bWDRnk2KYh35U=;
 b=dTiFEiMCGNzRBvxMFxdz/m3OtLsLL7CQZrQImc/UU1rta2COi/SVw48empsp7mC3Rm
 k/jBw8d4RYHhFarCOIDzYIaE36xwo5fEq8mTa7isPqpSI9QyC8PeDrngEIZAfOiZd7gb
 /vXzx534c5Yj/W1/5y5FcJ79opbLXTtW2TYgpLD6n2Yl0zrNo9WMKudNDEE30jIZwf5u
 FDmng/Vwmm1KqjoxKVG1m2jWr5Bx/5/Yf8YZuOUrFQbWrZwHueNlMHa2bOT27dq/UQny
 HGoJTjuqEzUScuoQsGGd3p6U0/575xjlXfAOgO3m16tEVR2LOfChRVUroQHcVIZ/gpaU
 kTPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXocJELszCZxcMF20sP2pdvWn9tW8DaxlTRwLW1xAMF6vL5Y1nPG3lBRCg2i6kMURk7H5xBpwG3Id17/TS5q4a8tvrV3U=
X-Gm-Message-State: AOJu0Yz+vufQ/fVscJHYs/RrOpDX5CiD6I8lZfYSg0EhPo2QzqfRxk5j
 /NbKlfoqPg43QkTcKX4L75UsW3+TwE0vwCvnhqDi+kbpHcNR1XoYZo1Ikoa/bxpCJHuUMwVRfD7
 GSZM62W2d8octKDT6kaFbehh6twg+z9YDzfA=
X-Google-Smtp-Source: AGHT+IF+l+b7ncTy27X+mUyIVu1gn7WTsNGhIYEc2R9vG7m3qm6reL486AfBASSplUlOXKZCfYri5OtAdZclDWSvGj8=
X-Received: by 2002:a05:6402:31f6:b0:564:dd13:56e9 with SMTP id
 dy22-20020a05640231f600b00564dd1356e9mr1277953edb.29.1708467732155; Tue, 20
 Feb 2024 14:22:12 -0800 (PST)
MIME-Version: 1.0
References: <CAOpGCn+KdhjnXRHup6GXVbkoZkUBc7f-2urNzmvLjK1To_pp0A@mail.gmail.com>
 <87a5nvci5n.fsf@draig.linaro.org>
 <CAOpGCnLxVGhbJuAq+K+DNZBESEGGkSr8Sa0_cHsfMR7S-_ahkQ@mail.gmail.com>
 <87y1bfawik.fsf@draig.linaro.org>
 <CAOpGCn+_=5Uxi9mt-C1V3pguNT0OUJura-H3SwBOsJnW5tyJ4g@mail.gmail.com>
 <CAFEAcA-03JYx9szd3FrQ_786gaRLWCJVHeMgjBxxvgH85f-78A@mail.gmail.com>
In-Reply-To: <CAFEAcA-03JYx9szd3FrQ_786gaRLWCJVHeMgjBxxvgH85f-78A@mail.gmail.com>
From: Faiq Ali Sayed <faiqueali.109@gmail.com>
Date: Tue, 20 Feb 2024 23:22:01 +0100
Message-ID: <CAOpGCn+vQ7wupMqeH8ZLarT0c4gD85R6cgRqBMhVeAXtZ1F_Mg@mail.gmail.com>
Subject: Re: QNX VM hang on Qemu
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000004911c80611d7a49c"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=faiqueali.109@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--0000000000004911c80611d7a49c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The real hardware ( xlnx-zcu102 ) is being used for our software. The
software is in the development phase, and for that, I need to create a VM
for simulation purposes.
Qemu has a machine type (-M xlnx-zcu102) which is supported with the
board/hardware.

I have two more images for the same hardware and I can create a VM using
these two images, but in the VM some basic binaries are missing like mkdir
and virtual disk etc.

Now, the image for which I want to create a VM is currently working on
board and everything is working fine on real hardware.
I am not sure whether I can use this image for Qemu because this is created
particularly for hardware.
and giving a try to create a VM.

Your valuable suggestions in this regard will be appreciated and mean a lot
to me :)


br!
Faiq



On Tue, Feb 20, 2024 at 10:24=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org>
wrote:

> On Tue, 20 Feb 2024 at 20:56, Faiq Ali Sayed <faiqueali.109@gmail.com>
> wrote:
> >
> > The image I am using is currently in use for real hardware, and
> > I received it from a third party/vendor.
>
> OK, so what exactly is the real hardware it's for?
>
> > Could you please suggest to me what I can do now?
>
> If QEMU has a model of the hardware the image is for:
>  - use that QEMU machine type (and issues with getting it running
>    will be related to making sure you're loading it at the right
>    address and starting it the way it wants to be started)
> If QEMU does not have a model of the hardware the image is for:
>  - ask your vendor for a build that targets some machine QEMU
>    does have a model of
>
> Unfortunately in general in the Arm world guest OSes are
> not "runs on anything", but only "runs on the hardware
> they were built to run on". This remains true under emulation.
>
> thanks
> -- PMM
>


--=20
Kind Regard-
Faiq Ali Sayed

--0000000000004911c80611d7a49c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The real hardware (

xlnx-zcu102 ) is being used for our software. The software is in the develo=
pment phase, and for that, I need to create a VM for simulation purposes.<d=
iv>Qemu has a machine type (-M xlnx-zcu102) which is supported with the boa=
rd/hardware.</div><div><br></div><div>I have two more images for the same h=
ardware and I can create a VM using these two images,=C2=A0but in the VM so=
me basic binaries are missing like mkdir and virtual disk etc.</div><div><b=
r></div><div>Now, the image for which I want to create a VM is currently wo=
rking on board and everything is working fine on real hardware.</div><div>I=
 am not sure whether I can use this image for Qemu because this is created =
particularly for hardware.</div><div>and giving a try to create a VM.</div>=
<div><br></div><div>Your valuable=C2=A0suggestions in this regard will be=
=C2=A0appreciated and mean a lot to=C2=A0me :)</div><div><br></div><div><br=
></div><div>br!</div><div>Faiq</div><div><br></div><div><br></div></div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, F=
eb 20, 2024 at 10:24=E2=80=AFPM Peter Maydell &lt;<a href=3D"mailto:peter.m=
aydell@linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">On Tue, 20 Feb 2024 at 20:56, Fa=
iq Ali Sayed &lt;<a href=3D"mailto:faiqueali.109@gmail.com" target=3D"_blan=
k">faiqueali.109@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; The image I am using is currently in use for real hardware, and<br>
&gt; I received it from a third party/vendor.<br>
<br>
OK, so what exactly is the real hardware it&#39;s for?<br>
<br>
&gt; Could you please suggest to me what I can do now?<br>
<br>
If QEMU has a model of the hardware the image is for:<br>
=C2=A0- use that QEMU machine type (and issues with getting it running<br>
=C2=A0 =C2=A0will be related to making sure you&#39;re loading it at the ri=
ght<br>
=C2=A0 =C2=A0address and starting it the way it wants to be started)<br>
If QEMU does not have a model of the hardware the image is for:<br>
=C2=A0- ask your vendor for a build that targets some machine QEMU<br>
=C2=A0 =C2=A0does have a model of<br>
<br>
Unfortunately in general in the Arm world guest OSes are<br>
not &quot;runs on anything&quot;, but only &quot;runs on the hardware<br>
they were built to run on&quot;. This remains true under emulation.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div dir=3D"ltr">
<div><span style=3D"color:rgb(34,34,34)">Kind Regard-</span><br style=3D"co=
lor:rgb(34,34,34)"><div dir=3D"ltr" style=3D"color:rgb(34,34,34)"><div dir=
=3D"ltr"><div dir=3D"ltr"><font color=3D"#073763">Faiq Ali Sayed</font></di=
v></div></div></div>
<div><font style=3D"background-color:rgb(255,255,255)" size=3D"1"><br></fon=
t></div><br></div></div></div>

--0000000000004911c80611d7a49c--


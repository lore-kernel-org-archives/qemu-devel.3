Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909C8C5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 18:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcrDA-0007Tj-GE; Wed, 21 Feb 2024 13:20:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faiqueali.109@gmail.com>)
 id 1rcrD9-0007TW-Df
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:20:51 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faiqueali.109@gmail.com>)
 id 1rcrD6-0003GR-Os
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 13:20:51 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-55a035669d5so1792898a12.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 10:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708539647; x=1709144447; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i+trvber0osnARKFr/wpEsjPF456J7xWZmCut5yxym0=;
 b=WJY/Eoht/haNXsjeG+DkWzuJAmPmMTbCinwEEoLL6m+iTJxWcqdZ9VfIflf3ZbJBCf
 nsxmNwCehD51zLXErsFC1mTqxNI1I36plTjLYLTMmW72aIdJF7fElpiJguysgfZj1ojo
 l9zh1lmwbysVn2+Gsru9JNNbr9IQ93RDdG7Jmn93Up/86YD9DHwSu3vR50TS2C+UQLf7
 aUDV5jSBtBf3NBcPmtNd2aGO3SkpODBjdsexfRxIUFdb9g56985Gfj78CW6wNWy/3dNC
 ShtvWtNWktBSx7EjqXfK2I74QfytnK9rSI3dm7+cZ4fqq+/2PG7I4s1PbMYLz3sOrkiX
 SFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708539647; x=1709144447;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i+trvber0osnARKFr/wpEsjPF456J7xWZmCut5yxym0=;
 b=eOQ+BdQYFN/RbdIuUkct1prpnbM5m8SeMQstCoQvrjF348QO2Sk8aS8P5hyjA7xgJ4
 QXSLdwuxK15vE3tcuC/zoBaj9LGG9M7Dld7evkPlwh8JRezpXHwQXV2ax5y17aJF2qh6
 U27ktPR3pK2KmXgmivfsRb/IeSBcdxHoICBj4yQA8EcdCJLpMWbtg/1GnuTCzPcQZKXf
 9IaWO8ymYJgXR54OpffOzTc32sUwBTFLoExRRFhGnolyeKxZoirCIMvFmK668wfZ/SMw
 LXF2byJrOfvMydZqdrvLkchfL4HCyGx21jh9Gp3fovFPAY2dxc3X1ChX6vQk8kFrt/xc
 wEQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6JPcZ4IcgM71KhiAkWUBp+ynP8Vuv93CGc4vSClANy/Rdg8UbNA74nzPsGNswchIn58gx5xf48BLPg3I0bYRwGIS8aoY=
X-Gm-Message-State: AOJu0YyjDjOnsTXZs5GQys0xhgQ1fiEJaatoh/lCU6VjA6vnjoDmLM7e
 Ai2ZzJcC2o29bLuUIwO20fBv+oIFNOKUiQtKluB+GswcXA9awTcxdiuQBvuVVG0PCe+ODK4V8XL
 7NZ4ZPYm3furMAcfsGRFZhOR1DjqoO7JwDLM=
X-Google-Smtp-Source: AGHT+IEU+FTmr+eR3UocLhv/MnkCT2BiVjR5jYaiUFGa7v0YZJBozwZaffvKvXYQONXlTqq0ETOws883f0ACITEPiRk=
X-Received: by 2002:aa7:d052:0:b0:564:71:ccf0 with SMTP id
 n18-20020aa7d052000000b005640071ccf0mr10986787edo.2.1708539646605; 
 Wed, 21 Feb 2024 10:20:46 -0800 (PST)
MIME-Version: 1.0
References: <CAOpGCn+KdhjnXRHup6GXVbkoZkUBc7f-2urNzmvLjK1To_pp0A@mail.gmail.com>
 <87a5nvci5n.fsf@draig.linaro.org>
 <CAOpGCnLxVGhbJuAq+K+DNZBESEGGkSr8Sa0_cHsfMR7S-_ahkQ@mail.gmail.com>
 <87y1bfawik.fsf@draig.linaro.org>
 <CAOpGCn+_=5Uxi9mt-C1V3pguNT0OUJura-H3SwBOsJnW5tyJ4g@mail.gmail.com>
 <CAFEAcA-03JYx9szd3FrQ_786gaRLWCJVHeMgjBxxvgH85f-78A@mail.gmail.com>
 <CAOpGCn+vQ7wupMqeH8ZLarT0c4gD85R6cgRqBMhVeAXtZ1F_Mg@mail.gmail.com>
 <CAFEAcA9Yp=ObPhgagAbf2Ev=6=D+9sCfHC_HCxPUr2JgvWa4oQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9Yp=ObPhgagAbf2Ev=6=D+9sCfHC_HCxPUr2JgvWa4oQ@mail.gmail.com>
From: Faiq Ali Sayed <faiqueali.109@gmail.com>
Date: Wed, 21 Feb 2024 19:20:35 +0100
Message-ID: <CAOpGCn+BHsVPG1_2-avx6Ex10dc-nKYuVv=3VTct=MYRb4TmYw@mail.gmail.com>
Subject: Re: QNX VM hang on Qemu
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000b87f5c0611e86223"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=faiqueali.109@gmail.com; helo=mail-ed1-x529.google.com
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

--000000000000b87f5c0611e86223
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> This is also useful information. I would suggest you look
> at what the difference is between the image that boots and
> the one that doesn't: is it the same format (and what format
> is that)? is the way it is loaded on the real hardware the
> same, or different?


I am not able to distinguish between the images as they are in binary form,
I noticed that the smaller size image can boot in Qemu.
I normally put the image into an SD card of the real hardware to boot.
so it is quite difficult for me now to distinguish.


From the debug info from gdb you provided, the file clearly
> is not a raw binary file -- the initial bytes seem to be
> largely ASCII text. So it might be that this image is in
> a file format that whatever the real-hardware loader
> recognizes, but QEMU doesn't, whereas the images you have
> that work are really raw binaries. In that case you'd want
> to convert the image somehow to a format QEMU can understand
> (eg ELF, or raw-binary).


ahh, that also makes sense, ok now let me try to convert the images, and
let's see.
Does Qemu provide such a tool or do you know any?



br!
Faiq


On Wed, Feb 21, 2024 at 5:02=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Tue, 20 Feb 2024 at 22:22, Faiq Ali Sayed <faiqueali.109@gmail.com>
> wrote:
> >
> > The real hardware ( xlnx-zcu102 ) is being used for our software. The
> software is in the development phase, and for that, I need to create a VM
> for simulation purposes.
> > Qemu has a machine type (-M xlnx-zcu102) which is supported with the
> board/hardware.
>
> Cool. So in principle this should work and there's likely some
> fixable issue with how you're loading the image.
>
> > I have two more images for the same hardware and I can create a VM usin=
g
> these two images, but in the VM some basic binaries are missing like mkdi=
r
> and virtual disk etc.
>
> This is also useful information. I would suggest you look
> at what the difference is between the image that boots and
> the one that doesn't: is it the same format (and what format
> is that)? is the way it is loaded on the real hardware the
> same, or different?
>
> From the debug info from gdb you provided, the file clearly
> is not a raw binary file -- the initial bytes seem to be
> largely ASCII text. So it might be that this image is in
> a file format that whatever the real-hardware loader
> recognizes, but QEMU doesn't, whereas the images you have
> that work are really raw binaries. In that case you'd want
> to convert the image somehow to a format QEMU can understand
> (eg ELF, or raw-binary).
>
> thanks
> -- PMM
>


--=20
Kind Regard-
Faiq Ali Sayed

--000000000000b87f5c0611e86223
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><blockquote style=3D"margin:0 0 0 40px;border:none;padding=
:0px"></blockquote><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><font color=3D"#741b47">This is also useful information. I would=
 suggest you look<br>at what the difference is between the image that boots=
 and<br>the one that doesn&#39;t: is it the same format (and what format<br=
>is that)? is the way it is loaded on the real hardware the<br>same, or dif=
ferent?</font></blockquote><div><br></div><div>I am not able to distinguish=
=C2=A0between the images as they are in binary=C2=A0form,=C2=A0</div><div>I=
 noticed that the smaller size=C2=A0image can boot in Qemu.</div><div>I nor=
mally put the image into an SD card of the=C2=A0real hardware to boot.</div=
><div>so it is quite difficult for me now to distinguish.</div><div><br></d=
iv><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><font c=
olor=3D"#741b47">From the debug info from gdb you provided, the file clearl=
y<br>is not a raw binary file -- the initial bytes seem to be<br>largely AS=
CII text. So it might be that this image is in<br>a file format that whatev=
er the real-hardware loader<br>recognizes, but QEMU doesn&#39;t, whereas th=
e images you have<br>that work are really raw binaries. In that case you&#3=
9;d want<br>to convert the image somehow to a format QEMU can understand<br=
>(eg ELF, or raw-binary).</font></blockquote><div><br></div><div>ahh, that =
also makes sense, ok now let me try to convert the images, and let&#39;s se=
e.</div><div>Does Qemu provide such a tool or do you know any?</div><div>=
=C2=A0</div><div><br></div><div><br></div><div>br!</div><div>Faiq</div><blo=
ckquote style=3D"margin:0 0 0 40px;border:none;padding:0px"></blockquote><b=
lockquote style=3D"margin:0 0 0 40px;border:none;padding:0px"></blockquote>=
<blockquote style=3D"margin:0 0 0 40px;border:none;padding:0px"></blockquot=
e></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Wed, Feb 21, 2024 at 5:02=E2=80=AFPM Peter Maydell &lt;<a href=3D"mail=
to:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, 20 Feb 2024 at=
 22:22, Faiq Ali Sayed &lt;<a href=3D"mailto:faiqueali.109@gmail.com" targe=
t=3D"_blank">faiqueali.109@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; The real hardware ( xlnx-zcu102 ) is being used for our software. The =
software is in the development phase, and for that, I need to create a VM f=
or simulation purposes.<br>
&gt; Qemu has a machine type (-M xlnx-zcu102) which is supported with the b=
oard/hardware.<br>
<br>
Cool. So in principle this should work and there&#39;s likely some<br>
fixable issue with how you&#39;re loading the image.<br>
<br>
&gt; I have two more images for the same hardware and I can create a VM usi=
ng these two images, but in the VM some basic binaries are missing like mkd=
ir and virtual disk etc.<br>
<br>
This is also useful information. I would suggest you look<br>
at what the difference is between the image that boots and<br>
the one that doesn&#39;t: is it the same format (and what format<br>
is that)? is the way it is loaded on the real hardware the<br>
same, or different?<br>
<br>
From the debug info from gdb you provided, the file clearly<br>
is not a raw binary file -- the initial bytes seem to be<br>
largely ASCII text. So it might be that this image is in<br>
a file format that whatever the real-hardware loader<br>
recognizes, but QEMU doesn&#39;t, whereas the images you have<br>
that work are really raw binaries. In that case you&#39;d want<br>
to convert the image somehow to a format QEMU can understand<br>
(eg ELF, or raw-binary).<br>
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

--000000000000b87f5c0611e86223--


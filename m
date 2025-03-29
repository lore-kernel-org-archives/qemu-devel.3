Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B430BC36008
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 11:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyUPH-0000Y1-F5; Sat, 29 Mar 2025 07:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1tyUP9-0000XX-PH
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 07:31:12 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1tyUP7-0005TW-AI
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 07:31:11 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ac2aeada833so566699366b.0
 for <qemu-devel@nongnu.org>; Sat, 29 Mar 2025 04:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743247867; x=1743852667; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/KsMrU1DaNZR9KhG80kLVncl4yvKBbXNvwPiG2QZyYM=;
 b=B7ilWKOsZWeIOPkh3QtSZnnUurcfrI7twz6I0nRE1/QjDr4NnbVsIKLZTSIXDuE+MP
 3j6rMAl10luz38cKY8M+coFZUyODhTvTjaPZyFsVWH90FDizIKxeAJYIgzolTDiH7OEh
 EqqrCe3eScA7Sjuo8ftTfLDBCTXEr7FtG2j/OvwU0wYDOCeupq4L/bgtGCg0PdxdCJfw
 e2SHDKWQ3uhB1T/z7s3is0u9Uj9LuCYdXaJnrnA69oqxn6LNjo5oBlH46Ej0Zy6gD197
 TmwK+W0zLMLpDsFCXky7Y/kjEXRsHNZ0/KkUxw5sBglkQvJB/SyVIAIM2jmxbu/sjo9Q
 kcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743247867; x=1743852667;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/KsMrU1DaNZR9KhG80kLVncl4yvKBbXNvwPiG2QZyYM=;
 b=buvEFFuoO25Q2dCuXstLYb5Wgc9vxUbJdJsWJCQZYbhDZBGwFfuQryaysFCdJItl/Z
 QJwFZfHhxKNZEN6aqDdKLayUH1F4hEJmrClbaIU4dG+WDxr5huaCIcSIxdkTwFMqIMPa
 nEUgm8bkXvg9z486Ky+js7S1pr6Z7LKdTYUTNWPquMZIuNakNkPgQbiKc8AQ2137f9Lt
 /Pl7AZ6ETzuQyTGKhim344nuO55BcQPcNh9lbirL8vFNLTzwfAWXY/Psr6yx/JEFeOYd
 yMuXz4couGg/aG7dKviwJIcUknt/MVBMxm+c4aJ0hQP5DJ9Kd5gxwqmwIi3DfGETFrt+
 CPVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTCc34He4insaajqb62dGazPykZinSEChlQaiET+v8q6mW2PKBGqnZlEpKLmks1UaZZuZZfHUa+9Yp@nongnu.org
X-Gm-Message-State: AOJu0Yws9aF2IzDs+oTrnZd1sVZz3uKHlKaR+lKVde+VGkzzZpwP7L6o
 p7l8+FA843TYRSXyYJ9MIv0VwYWsN2e+PxhD8iT7dVMGPfFIbFHsLyag4j5aMp2SyUY0KDinpZL
 u3YjCwizLA3dOKMSuI/g8aJQkGxo=
X-Gm-Gg: ASbGncuu9XklIROMwEC1gxd2TuxbNnuQWQOV1gHGl0rASj/l5lNL6v2XxMMsQvUD3x2
 5d0gWDwCxz5L8RntAQTCgcXzQO0IDnWiC3wzkl0dCQryTSIUi579Y0vxBoIE8pQrYKdoo96dU0j
 iBA9OiphD4/+ei/g3uT6tiYLPSfRwd1MiYXusHjDmObR6LWSFw0DdyWDsPNsA=
X-Google-Smtp-Source: AGHT+IEHW+7Yo0sjIw4oQvDZWdxPOsGvS/Qu24N4KlV3i1AbQcuDBsTrHECldIKSDOD4FpO2HEDRbw2Q+c7z4qNhDq8=
X-Received: by 2002:a17:907:6d07:b0:ac7:4565:1c37 with SMTP id
 a640c23a62f3a-ac74565264amr45185566b.14.1743247867202; Sat, 29 Mar 2025
 04:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250327153627.307040-1-rakeshjb010@gmail.com>
 <364c91ef-b086-9aea-4073-e0be49b77d76@eik.bme.hu>
 <ca76bcb1-7cea-4153-ae74-02718a6a1cfb@redhat.com>
 <971ac7f1-618d-c94a-93db-9ba887bdc997@eik.bme.hu>
 <CABgObfbL0b7G-Okq=0xnbDMJ4viu0Uk8gduuTUeCS0C4Xtn6aw@mail.gmail.com>
 <3956f3b4-2317-4e7f-a2b4-e53546473d62@linaro.org>
In-Reply-To: <3956f3b4-2317-4e7f-a2b4-e53546473d62@linaro.org>
From: Rakesh J <rakeshjb010@gmail.com>
Date: Sat, 29 Mar 2025 17:00:52 +0530
X-Gm-Features: AQ5f1JqUoJUjupHHw9dgU6VGcMZb8KRa860SB50DOTiT4WSMiwlnndTyDp3qdcE
Message-ID: <CAD8nu1gB2sBPCNaWpycXRp1sC+kasN_T1E=0x-=3vLmTwThY_w@mail.gmail.com>
Subject: Re: [PATCH] hw/pci-host/gt64120.c: Fix PCI host bridge endianness
 handling
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, thuth@redhat.com
Content-Type: multipart/alternative; boundary="000000000000e155580631798572"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=rakeshjb010@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 HTML_FONT_LOW_CONTRAST=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

--000000000000e155580631798572
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for feedback on [PATCH v1]!

I've posted v2 incorporating the suggestions:ve posted v2 incorporating
your suggestions

 Paolo: You pointed out the size issue with .min_access_size =3D 1 and
.max_access_size =3D 4, where bswap32 was wrong for 2-byte accesses. I=E2=
=80=99ve
fixed this with size-appropriate swaps (bswap16 for 2-byte, bswap32 for
4-byte). On the extra swap idea, I stuck with a single swap since it aligns
PCI LE with guest BE expectations without overcomplicating it=E2=80=94let m=
e know
if I misunderstood.

 I=E2=80=99ve sent [PATCH v2] incorporating changes:
1.Removed gt64120_update_pci_cfgdata_mapping() and moved initialization cod=
e
  to gt64120_realize() for a simpler MByteSwap check.
2.Removed unused pci_host_data_be_ops and a misleading comment in dino.h

3.Size-specific swaps (bswap16 and bswap32)
 I included bswap16 for 2-byte accesses in v2=E2=80=94should this be restri=
cted to
4-byte only (bswap32) per the spec, or does GT-64120 expect 2-byte config
swaps too? It=E2=80=99s a minor tweak, so I left it in v2 for now=E2=80=94h=
appy to adjust
in a v3 if needed.

The new patch is available at:
https://mail.gnu.org/archive/html/qemu-devel/2025-03/msg06884.html
 Could you take a look at [PATCH v2] and let me know your thoughts,
especially on the 2-byte swap question? Thanks!

On Sat, Mar 29, 2025 at 4:05=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> On 28/3/25 18:34, Paolo Bonzini wrote:
> > On Fri, Mar 28, 2025 at 3:16=E2=80=AFPM BALATON Zoltan <balaton@eik.bme=
.hu>
> wrote:
> >>> It should be fine.  You should take into account:
> >>>
> >>> - the endianness produced by pci_data_read/pci_data_write (always
> little
> >>> endian)
> >>>
> >>> - the endianness expected by the guest (big endian under the
> conditions in
> >>> the patch)
> >>>
> >>> - the endianness expected by memory.c (always little endian, as
> specified in
> >>> gt64120_pci_data_ops)
> >>>
> >>> Because there is either zero or one mismatch, bswap32 is fine.
> >>
> >> This may worth a comment but I'm still not convinced this works on big
> >> endian host because I think pci_data_read returns val in host endianne=
ss
> >> and if you want big endian then you only need to bswap on LE host not =
on
> >> BE host. Was this tested on BE host and confirmed it works?
> >
> > Looking again at the code, there is definitely one problem: since you
> have
> >
> > +        .min_access_size =3D 1,
> > +        .max_access_size =3D 4,
> >
> > the bswap can also be bswap16 if size =3D=3D 2 (and bswap32 only if siz=
e =3D=3D
> 4).
>
> Per 'PCI LOCAL BUS SPECIFICATION, REV. 3.0':
>
> '''
> 3.2.2.3.2. Software Generation of Configuration Transactions
>
> Anytime a host bridge sees a full DWORD I/O write from the host
> to CONFIG_ADDRESS, the bridge must latch the data into its
> CONFIG_ADDRESS register. On full DWORD I/O reads to CONFIG_ADDRESS,
> the bridge must return the data in CONFIG_ADDRESS. Any other types
> of accesses to this address (non-DWORD) have no effect on CONFIG_ADDRESS
> and are executed as normal I/O transactions on the PCI bus. Therefore,
> the only I/O Space consumed by this register is a DWORD at the given
> address. I/O devices that share the same address but use BYTE or WORD
> registers are not affected because their transactions will pass through
> the host bridge unchanged.
> '''
>
> IIUC we don't need the bswap16.
>
>

--000000000000e155580631798572
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks for feedback on [PATCH v1]!<span style=3D"colo=
r:rgb(255,255,255);font-size:12.573px">=C2=A0</span></div><div><br></div><d=
iv>I&#39;ve posted v2 incorporating the suggestions:<span style=3D"color:rg=
b(255,255,255);font-size:12.573px">ve posted v2 incorporating your suggesti=
ons</span></div><div><br></div><div>=C2=A0Paolo: You pointed out the size i=
ssue with .min_access_size =3D 1 and .max_access_size =3D 4, where bswap32 =
was wrong for 2-byte accesses. I=E2=80=99ve fixed this with size-appropriat=
e swaps (bswap16 for 2-byte, bswap32 for 4-byte). On the extra swap idea, I=
 stuck with a single swap since it aligns PCI LE with guest BE expectations=
 without overcomplicating it=E2=80=94let me know if I misunderstood.</div><=
div><br></div><div>=C2=A0I=E2=80=99ve sent [PATCH v2] incorporating changes=
:=C2=A0</div><div>1.Removed gt64120_update_pci_cfgdata_mapping() and=C2=A0<=
span style=3D"color:rgb(0,0,0)">moved initialization code</span></div><div>=
<span style=3D"color:rgb(0,0,0)">=C2=A0 to gt64120_realize()=C2=A0</span>fo=
r a simpler MByteSwap check.</div><div>2.<span style=3D"color:rgb(0,0,0)">R=
emoved unused pci_host_data_be_ops and a misleading comment in dino.h</span=
></div><div><br class=3D"gmail-Apple-interchange-newline">3.Size-specific s=
waps (bswap16 and bswap32)=C2=A0</div><div>=C2=A0I included bswap16 for 2-b=
yte accesses in v2=E2=80=94should this be restricted to 4-byte only (bswap3=
2) per the spec, or does GT-64120 expect 2-byte config swaps too? It=E2=80=
=99s a minor tweak, so I left it in v2 for now=E2=80=94happy to adjust in a=
 v3 if needed.=C2=A0</div><div><br>The new patch is available at:<br><a hre=
f=3D"https://mail.gnu.org/archive/html/qemu-devel/2025-03/msg06884.html">ht=
tps://mail.gnu.org/archive/html/qemu-devel/2025-03/msg06884.html</a></div><=
div>=C2=A0Could you take a look at [PATCH v2] and let me know your thoughts=
, especially on the 2-byte swap question? Thanks!=C2=A0</div></div><br><div=
 class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Sat, Mar 29, 2025 at 4:05=E2=80=AFPM Philippe Mathieu-Daud=C3=A9=
 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 28/3/25 18:34=
, Paolo Bonzini wrote:<br>
&gt; On Fri, Mar 28, 2025 at 3:16=E2=80=AFPM BALATON Zoltan &lt;<a href=3D"=
mailto:balaton@eik.bme.hu" target=3D"_blank">balaton@eik.bme.hu</a>&gt; wro=
te:<br>
&gt;&gt;&gt; It should be fine.=C2=A0 You should take into account:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; - the endianness produced by pci_data_read/pci_data_write (alw=
ays little<br>
&gt;&gt;&gt; endian)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; - the endianness expected by the guest (big endian under the c=
onditions in<br>
&gt;&gt;&gt; the patch)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; - the endianness expected by memory.c (always little endian, a=
s specified in<br>
&gt;&gt;&gt; gt64120_pci_data_ops)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Because there is either zero or one mismatch, bswap32 is fine.=
<br>
&gt;&gt;<br>
&gt;&gt; This may worth a comment but I&#39;m still not convinced this work=
s on big<br>
&gt;&gt; endian host because I think pci_data_read returns val in host endi=
anness<br>
&gt;&gt; and if you want big endian then you only need to bswap on LE host =
not on<br>
&gt;&gt; BE host. Was this tested on BE host and confirmed it works?<br>
&gt; <br>
&gt; Looking again at the code, there is definitely one problem: since you =
have<br>
&gt; <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 4,<br>
&gt; <br>
&gt; the bswap can also be bswap16 if size =3D=3D 2 (and bswap32 only if si=
ze =3D=3D 4).<br>
<br>
Per &#39;PCI LOCAL BUS SPECIFICATION, REV. 3.0&#39;:<br>
<br>
&#39;&#39;&#39;<br>
3.2.2.3.2. Software Generation of Configuration Transactions<br>
<br>
Anytime a host bridge sees a full DWORD I/O write from the host<br>
to CONFIG_ADDRESS, the bridge must latch the data into its<br>
CONFIG_ADDRESS register. On full DWORD I/O reads to CONFIG_ADDRESS,<br>
the bridge must return the data in CONFIG_ADDRESS. Any other types<br>
of accesses to this address (non-DWORD) have no effect on CONFIG_ADDRESS <b=
r>
and are executed as normal I/O transactions on the PCI bus. Therefore,<br>
the only I/O Space consumed by this register is a DWORD at the given<br>
address. I/O devices that share the same address but use BYTE or WORD<br>
registers are not affected because their transactions will pass through<br>
the host bridge unchanged.<br>
&#39;&#39;&#39;<br>
<br>
IIUC we don&#39;t need the bswap16.<br>
<br>
</blockquote></div>

--000000000000e155580631798572--


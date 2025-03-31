Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE04C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 17:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzJIn-0005Qm-A8; Mon, 31 Mar 2025 13:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1tzJIk-0005QQ-D6
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 13:51:58 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1tzJIh-0002rF-Th
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 13:51:58 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-abbb12bea54so963799566b.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 10:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743443513; x=1744048313; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4OJOFCorfWM24TNpTprcIhHNXK8EW5jkt3X4WIT8LFE=;
 b=gzsAsMS/daiXMoz8v7AUDUgxvNRatjBD+ibcMS85OzN9RJR90KFg/q0d0reSDtidSD
 g8ihaLwXyCXrxHSmTqD3lVmcHajq+b1nRU6RYDNrxEPUCTnd2LZ2INnk2b7uTAqYcqCD
 hHFoN0rtA5M/QfjOr9Bc0rGXJoaa5pJJuy327YXQZCdjSSzdf+Ii9/CIKOCn1csvsJ0g
 84z+YsgwKcAQtPlhJHTSpH3YKJ59p70pNEpzcVXpIK2jUtDlkzv6+KRe/UGtwbwXFjfi
 yeWILomBDHv1XyAF33GMkTgNz0OMvmAE2Shm4hSlUNZx4Sdj5G8JpahpW5TFreFQSfKB
 XmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743443513; x=1744048313;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4OJOFCorfWM24TNpTprcIhHNXK8EW5jkt3X4WIT8LFE=;
 b=VOXK5XLla+RFu3XXZlTk139kUI9KT8rclbRc2shLZrSL06+7Kk17y2Xrn3BumzN0f1
 6Ip468jUsZkkDDiEkfhGJhrUuHT6GmO7B5iRtMOyPxPZ6kOHTiIEpl21bCOJMON4/t6D
 eXeEbpDKbkObCWZNqxiDFgo9VGcOHMH4U4LAXSeapUvJvfUA2gCYmdGafZmLHJNtDmuk
 wPUZubVtecfZjzNR2DOYAFRMRdieTQThTPJMLynXki5mZKRxCbzBWb3W6UBnTdn4vk5c
 z9bY1VjXu+HDV2Kt5+3PmqU5WKdSQ2oJXn8DuKkcomRlXeHaiEFZBfjTl4wAuIPqwZ1d
 Sk2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaT/guStD//vHpX54VBMH5B9jlPf3FzkUgFFVc8I62hrCilLECOBxexYIuXC3dB5oRCpRwZg35Inw/@nongnu.org
X-Gm-Message-State: AOJu0YwRhYo41A/AeYxYql8bemxF7Z4ycHq/t1N4954QTxDrN6NDa+tF
 TavFSH2cGnokNvqf18ggJ8yNXys3gvr/DAKQIbGp+piDwgH/FZowNjgMGe5AzACxwO9PYic4zHO
 Ofk73nFHSGfJPtPqFm6WE9PwCIKs=
X-Gm-Gg: ASbGnct4NvhxHSEBvEGb/CRuIlMo0QxknQ4ixjChDB4CisoxQeIocNuHGdZTaSIvz4P
 Dn1kEBi9vwjJ3fjIoxhk1nt83UL2h7l/EUD+avC/UYp/VjDycTrY2VAoVOQ7WA0SrReBYPr9GKc
 CFctcGqfpLQOSdNgLV1SRBiofkBWzyGfb2BXI3457/iwEnQ7xTjxmE7frEu3hy
X-Google-Smtp-Source: AGHT+IEbV6qbYus7dW16BvSmm5jgsmr7nyktzqa7NfamXoLc5m3MvO+62UBdqxBAmJq3FIwHCTgv4+4CGD3EV7l706g=
X-Received: by 2002:a17:907:7d8d:b0:ac6:fe8c:e7bb with SMTP id
 a640c23a62f3a-ac738c6f525mr835671366b.55.1743443512742; Mon, 31 Mar 2025
 10:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250327153627.307040-1-rakeshjb010@gmail.com>
 <364c91ef-b086-9aea-4073-e0be49b77d76@eik.bme.hu>
 <ca76bcb1-7cea-4153-ae74-02718a6a1cfb@redhat.com>
 <971ac7f1-618d-c94a-93db-9ba887bdc997@eik.bme.hu>
 <CABgObfbL0b7G-Okq=0xnbDMJ4viu0Uk8gduuTUeCS0C4Xtn6aw@mail.gmail.com>
 <3956f3b4-2317-4e7f-a2b4-e53546473d62@linaro.org>
 <CAD8nu1gB2sBPCNaWpycXRp1sC+kasN_T1E=0x-=3vLmTwThY_w@mail.gmail.com>
 <054c2f1d-9fc5-4219-81ad-c9cefdec4753@linaro.org>
In-Reply-To: <054c2f1d-9fc5-4219-81ad-c9cefdec4753@linaro.org>
From: Rakesh J <rakeshjb010@gmail.com>
Date: Mon, 31 Mar 2025 23:21:40 +0530
X-Gm-Features: AQ5f1Jr_xxaOOEtbTQ4-OAd5L5lL_IpEx2HZY5Kb02ITDSIsE9SpEsFQBh-ElJA
Message-ID: <CAD8nu1gGw20K1Yw0-CW2pHK8wVNHXRq45YJ7MWKuGWdLZd5H8g@mail.gmail.com>
Subject: Re: [PATCH] hw/pci-host/gt64120.c: Fix PCI host bridge endianness
 handling
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-devel@nongnu.org, marcandre.lureau@redhat.com, thuth@redhat.com
Content-Type: multipart/alternative; boundary="00000000000043615a0631a71365"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=rakeshjb010@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--00000000000043615a0631a71365
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 re-examining the PCI spec (3.2.2.3.2) and QEMU's PCI host bridge
implementations, I agree .min_access_size =3D 4 is actually more correct
I'll update the patch(v4) to:
-Set .min_access_size =3D 4 in MemoryRegionOps
-Remove the now-unnecessary bswap16 handling

On Mon, Mar 31, 2025 at 5:04=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> On 29/3/25 12:30, Rakesh J wrote:
> > Thanks for feedback on [PATCH v1]!
> >
> > I've posted v2 incorporating the suggestions:ve posted v2 incorporating
> > your suggestions
> >
> >   Paolo: You pointed out the size issue with .min_access_size =3D 1
> > and .max_access_size =3D 4, where bswap32 was wrong for 2-byte accesses=
.
> > I=E2=80=99ve fixed this with size-appropriate swaps (bswap16 for 2-byte=
, bswap32
> > for 4-byte). On the extra swap idea, I stuck with a single swap since i=
t
> > aligns PCI LE with guest BE expectations without overcomplicating it=E2=
=80=94let
> > me know if I misunderstood.
> >
> >   I=E2=80=99ve sent [PATCH v2] incorporating changes:
> > 1.Removed gt64120_update_pci_cfgdata_mapping() and moved initialization
> code
> >    to gt64120_realize() for a simpler MByteSwap check.
> > 2.Removed unused pci_host_data_be_ops and a misleading comment in dino.=
h
> >
> > 3.Size-specific swaps (bswap16 and bswap32)
> >   I included bswap16 for 2-byte accesses in v2=E2=80=94should this be r=
estricted
> > to 4-byte only (bswap32) per the spec, or does GT-64120 expect 2-byte
> > config swaps too? It=E2=80=99s a minor tweak, so I left it in v2 for no=
w=E2=80=94happy
> > to adjust in a v3 if needed.
> >
> > The new patch is available at:
> > https://mail.gnu.org/archive/html/qemu-devel/2025-03/msg06884.html
> > <https://mail.gnu.org/archive/html/qemu-devel/2025-03/msg06884.html>
> >   Could you take a look at [PATCH v2] and let me know your thoughts,
> > especially on the 2-byte swap question? Thanks!
> >
> > On Sat, Mar 29, 2025 at 4:05=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> > <philmd@linaro.org <mailto:philmd@linaro.org>> wrote:
> >
> >     On 28/3/25 18:34, Paolo Bonzini wrote:
> >      > On Fri, Mar 28, 2025 at 3:16=E2=80=AFPM BALATON Zoltan
> >     <balaton@eik.bme.hu <mailto:balaton@eik.bme.hu>> wrote:
> >      >>> It should be fine.  You should take into account:
> >      >>>
> >      >>> - the endianness produced by pci_data_read/pci_data_write
> >     (always little
> >      >>> endian)
> >      >>>
> >      >>> - the endianness expected by the guest (big endian under the
> >     conditions in
> >      >>> the patch)
> >      >>>
> >      >>> - the endianness expected by memory.c (always little endian, a=
s
> >     specified in
> >      >>> gt64120_pci_data_ops)
> >      >>>
> >      >>> Because there is either zero or one mismatch, bswap32 is fine.
> >      >>
> >      >> This may worth a comment but I'm still not convinced this works
> >     on big
> >      >> endian host because I think pci_data_read returns val in host
> >     endianness
> >      >> and if you want big endian then you only need to bswap on LE
> >     host not on
> >      >> BE host. Was this tested on BE host and confirmed it works?
> >      >
> >      > Looking again at the code, there is definitely one problem: sinc=
e
> >     you have
> >      >
> >      > +        .min_access_size =3D 1,
> >      > +        .max_access_size =3D 4,
> >      >
> >      > the bswap can also be bswap16 if size =3D=3D 2 (and bswap32 only=
 if
> >     size =3D=3D 4).
> >
> >     Per 'PCI LOCAL BUS SPECIFICATION, REV. 3.0':
> >
> >     '''
> >     3.2.2.3.2. Software Generation of Configuration Transactions
> >
> >     Anytime a host bridge sees a full DWORD I/O write from the host
> >     to CONFIG_ADDRESS, the bridge must latch the data into its
> >     CONFIG_ADDRESS register. On full DWORD I/O reads to CONFIG_ADDRESS,
> >     the bridge must return the data in CONFIG_ADDRESS. Any other types
> >     of accesses to this address (non-DWORD) have no effect on
> >     CONFIG_ADDRESS
> >     and are executed as normal I/O transactions on the PCI bus.
> Therefore,
> >     the only I/O Space consumed by this register is a DWORD at the give=
n
> >     address. I/O devices that share the same address but use BYTE or WO=
RD
> >     registers are not affected because their transactions will pass
> through
> >     the host bridge unchanged.
> >     '''
> >
> >     IIUC we don't need the bswap16.
>
> What I'm questioning is why we need .min_access_size =3D 1
> and not .min_access_size =3D 4.
>

--00000000000043615a0631a71365
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">=C2=A0re-examining the PCI spec (3.2.2.3.2) and QEMU&#39;s=
 PCI host bridge implementations, I agree .min_access_size =3D 4 is actuall=
y more correct<br>I&#39;ll update the patch(v4) to:<br>-Set .min_access_siz=
e =3D 4 in MemoryRegionOps<br>-Remove the now-unnecessary bswap16 handling<=
/div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" =
class=3D"gmail_attr">On Mon, Mar 31, 2025 at 5:04=E2=80=AFPM Philippe Mathi=
eu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
29/3/25 12:30, Rakesh J wrote:<br>
&gt; Thanks for feedback on [PATCH v1]!<br>
&gt; <br>
&gt; I&#39;ve posted v2 incorporating the suggestions:ve posted v2 incorpor=
ating <br>
&gt; your suggestions<br>
&gt; <br>
&gt;=C2=A0 =C2=A0Paolo: You pointed out the size issue with .min_access_siz=
e =3D 1 <br>
&gt; and .max_access_size =3D 4, where bswap32 was wrong for 2-byte accesse=
s. <br>
&gt; I=E2=80=99ve fixed this with size-appropriate swaps (bswap16 for 2-byt=
e, bswap32 <br>
&gt; for 4-byte). On the extra swap idea, I stuck with a single swap since =
it <br>
&gt; aligns PCI LE with guest BE expectations without overcomplicating it=
=E2=80=94let <br>
&gt; me know if I misunderstood.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0I=E2=80=99ve sent [PATCH v2] incorporating changes:<br>
&gt; 1.Removed gt64120_update_pci_cfgdata_mapping() and moved initializatio=
n code<br>
&gt;=C2=A0 =C2=A0 to gt64120_realize() for a simpler MByteSwap check.<br>
&gt; 2.Removed unused pci_host_data_be_ops and a misleading comment in dino=
.h<br>
&gt; <br>
&gt; 3.Size-specific swaps (bswap16 and bswap32)<br>
&gt;=C2=A0 =C2=A0I included bswap16 for 2-byte accesses in v2=E2=80=94shoul=
d this be restricted <br>
&gt; to 4-byte only (bswap32) per the spec, or does GT-64120 expect 2-byte =
<br>
&gt; config swaps too? It=E2=80=99s a minor tweak, so I left it in v2 for n=
ow=E2=80=94happy <br>
&gt; to adjust in a v3 if needed.<br>
&gt; <br>
&gt; The new patch is available at:<br>
&gt; <a href=3D"https://mail.gnu.org/archive/html/qemu-devel/2025-03/msg068=
84.html" rel=3D"noreferrer" target=3D"_blank">https://mail.gnu.org/archive/=
html/qemu-devel/2025-03/msg06884.html</a> <br>
&gt; &lt;<a href=3D"https://mail.gnu.org/archive/html/qemu-devel/2025-03/ms=
g06884.html" rel=3D"noreferrer" target=3D"_blank">https://mail.gnu.org/arch=
ive/html/qemu-devel/2025-03/msg06884.html</a>&gt;<br>
&gt;=C2=A0 =C2=A0Could you take a look at [PATCH v2] and let me know your t=
houghts, <br>
&gt; especially on the 2-byte swap question? Thanks!<br>
&gt; <br>
&gt; On Sat, Mar 29, 2025 at 4:05=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <b=
r>
&gt; &lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank">philmd@lina=
ro.org</a> &lt;mailto:<a href=3D"mailto:philmd@linaro.org" target=3D"_blank=
">philmd@linaro.org</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 28/3/25 18:34, Paolo Bonzini wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Fri, Mar 28, 2025 at 3:16=E2=80=AFPM BALAT=
ON Zoltan<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:balaton@eik.bme.hu" target=3D=
"_blank">balaton@eik.bme.hu</a> &lt;mailto:<a href=3D"mailto:balaton@eik.bm=
e.hu" target=3D"_blank">balaton@eik.bme.hu</a>&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; It should be fine.=C2=A0 You should t=
ake into account:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; - the endianness produced by pci_data=
_read/pci_data_write<br>
&gt;=C2=A0 =C2=A0 =C2=A0(always little<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; endian)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; - the endianness expected by the gues=
t (big endian under the<br>
&gt;=C2=A0 =C2=A0 =C2=A0conditions in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; the patch)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; - the endianness expected by memory.c=
 (always little endian, as<br>
&gt;=C2=A0 =C2=A0 =C2=A0specified in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; gt64120_pci_data_ops)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; Because there is either zero or one m=
ismatch, bswap32 is fine.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; This may worth a comment but I&#39;m stil=
l not convinced this works<br>
&gt;=C2=A0 =C2=A0 =C2=A0on big<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; endian host because I think pci_data_read=
 returns val in host<br>
&gt;=C2=A0 =C2=A0 =C2=A0endianness<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; and if you want big endian then you only =
need to bswap on LE<br>
&gt;=C2=A0 =C2=A0 =C2=A0host not on<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; BE host. Was this tested on BE host and c=
onfirmed it works?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Looking again at the code, there is definitel=
y one problem: since<br>
&gt;=C2=A0 =C2=A0 =C2=A0you have<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size=
 =3D 1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size=
 =3D 4,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; the bswap can also be bswap16 if size =3D=3D =
2 (and bswap32 only if<br>
&gt;=C2=A0 =C2=A0 =C2=A0size =3D=3D 4).<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Per &#39;PCI LOCAL BUS SPECIFICATION, REV. 3.0&#39;=
:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&#39;&#39;&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A03.2.2.3.2. Software Generation of Configuration Tra=
nsactions<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Anytime a host bridge sees a full DWORD I/O write f=
rom the host<br>
&gt;=C2=A0 =C2=A0 =C2=A0to CONFIG_ADDRESS, the bridge must latch the data i=
nto its<br>
&gt;=C2=A0 =C2=A0 =C2=A0CONFIG_ADDRESS register. On full DWORD I/O reads to=
 CONFIG_ADDRESS,<br>
&gt;=C2=A0 =C2=A0 =C2=A0the bridge must return the data in CONFIG_ADDRESS. =
Any other types<br>
&gt;=C2=A0 =C2=A0 =C2=A0of accesses to this address (non-DWORD) have no eff=
ect on<br>
&gt;=C2=A0 =C2=A0 =C2=A0CONFIG_ADDRESS<br>
&gt;=C2=A0 =C2=A0 =C2=A0and are executed as normal I/O transactions on the =
PCI bus. Therefore,<br>
&gt;=C2=A0 =C2=A0 =C2=A0the only I/O Space consumed by this register is a D=
WORD at the given<br>
&gt;=C2=A0 =C2=A0 =C2=A0address. I/O devices that share the same address bu=
t use BYTE or WORD<br>
&gt;=C2=A0 =C2=A0 =C2=A0registers are not affected because their transactio=
ns will pass through<br>
&gt;=C2=A0 =C2=A0 =C2=A0the host bridge unchanged.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&#39;&#39;&#39;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0IIUC we don&#39;t need the bswap16.<br>
<br>
What I&#39;m questioning is why we need .min_access_size =3D 1<br>
and not .min_access_size =3D 4.<br>
</blockquote></div>

--00000000000043615a0631a71365--


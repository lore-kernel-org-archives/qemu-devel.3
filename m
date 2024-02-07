Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9BCC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 13:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXiPM-00060N-9M; Wed, 07 Feb 2024 08:56:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rXiPK-0005z3-6u
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:56:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rXiPI-0005KQ-IR
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:56:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707314168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0I9XBCykp/6iUwnMHUQ/X/t05uyetIemrX2doERnoW8=;
 b=T3GRrMZbcgLDbOPv8u7GSp04fii6/z7fdETSS6kWNmhDH8SlX8E91Id3C8fNDY0wB8yVG7
 H2GwwPmNlOXr72gduKsgB12CoZ7CgDpJOPHfu/uyHwoGnKcayAWgby39NMYP1Gl+ATsklq
 64fUM0Nmflnk1qXBrYTd6cPOFuBpm+0=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-6vKbVeVVOymkz85qGVqeQg-1; Wed, 07 Feb 2024 08:56:06 -0500
X-MC-Unique: 6vKbVeVVOymkz85qGVqeQg-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-4677690896cso337961137.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 05:56:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707314165; x=1707918965;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0I9XBCykp/6iUwnMHUQ/X/t05uyetIemrX2doERnoW8=;
 b=pWUrrIVrmzV0buyDhGajPWg+L4TtK8+NgtaHZYPJzH1rY3REboGj7p2lZRd452oCwf
 xcVVpgaToCqkf8+lymkWVmR8UvsfKfmy1SyY3tQlJwcF50RL/igcMhdpFznFlPXWzhF1
 K13C3zV7jZB8D7yoh4t8Ln4Ddnpnb6YfjE5uh1TGD/BeBvhavxSPn6+3lTLA+4Hmhzdp
 ymLb75KNMZ0hnnv8r4VOkBwxc43i5taxxaTw5pOWuKpktNGNVTwJpmVWGGv7WK9tpOOb
 B5CNT+BulOiUn+4rpRyMmrBiDpfIgDJAhU88h+gR/P17F5j45KyO3F/ao03f90DfnBNW
 E4Tg==
X-Gm-Message-State: AOJu0YxTOzRbpoV1ohEA97+3XiWBKi8yN37WX5r95XPJa3wR4t40e9Jl
 9ITpylPpzMAkb3S+WX41HBYS/JrMkR6vBLS7gpDNRVz87PIC4+r8G0lLz8lxsyaQv1AY75MVTll
 mnt8iPZNCIIzTGEl30ethTFShiXnDy14XOpuv0VS2XWqfkxLk81KBoGqp0NqKQGK6ZSe0IbAURq
 b4sEYchl6ERZTCDut4OiPAKEbFQPU=
X-Received: by 2002:a05:6102:4193:b0:46d:2336:fcc0 with SMTP id
 cd19-20020a056102419300b0046d2336fcc0mr3347771vsb.25.1707314165600; 
 Wed, 07 Feb 2024 05:56:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOmY1v4QaGkIm0c9QjpSs6iZQ0r6CvOPRaxXlWgnpFeM/4ALlCWhjyhMhPx2Len0lwTYLKCf+fEd3IXk+nWxE=
X-Received: by 2002:a05:6102:4193:b0:46d:2336:fcc0 with SMTP id
 cd19-20020a056102419300b0046d2336fcc0mr3347754vsb.25.1707314165374; Wed, 07
 Feb 2024 05:56:05 -0800 (PST)
MIME-Version: 1.0
References: <20240207111411.115040-1-pbonzini@redhat.com>
 <20240207111411.115040-9-pbonzini@redhat.com>
 <d218b1b0-3436-6120-55bc-f629ee1d667e@eik.bme.hu>
In-Reply-To: <d218b1b0-3436-6120-55bc-f629ee1d667e@eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 7 Feb 2024 14:55:51 +0100
Message-ID: <CABgObfY=va3f6By4PtAVDeJv7o7-YVVA+d7pA7YzZ1=bPQ3_QQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] mips: do not list individual devices from configs/
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel <qemu-devel@nongnu.org>, Bernhard Beschow <shentey@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000058ff110610cb0e75"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

--00000000000058ff110610cb0e75
Content-Type: text/plain; charset="UTF-8"

Il mer 7 feb 2024, 14:18 BALATON Zoltan <balaton@eik.bme.hu> ha scritto:

> >     if (defaults_enabled() && object_class_by_name("pci-ohci")) {
> >         pci_create_simple(pci_bus, -1, "pci-ohci");
> > -        usb_create_simple(usb_bus_find(-1), "usb-kbd");
> > -        usb_create_simple(usb_bus_find(-1), "usb-tablet");
> > +        Object *usb_bus = object_resolve_path_type("", TYPE_USB_BUS,
> NULL);
> > +        usb_create_simple(USB_BUS(usb_bus), "usb-kbd");
> > +        usb_create_simple(USB_BUS(usb_bus), "usb-tablet");
> >     }
> >
> >     for (i = 0; i < nb_nics; i++) {
>
> Is this hunk supposed to be in this patch?
>

Yes, it fixes compilation --without-default-devices (where usb_bus_find
does not exist). Before this patch CONFIG_USB is always selected, even
without default devices.

Paolo


> Regards,
> BALATON Zoltan
>
> > diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> > index 1aafe1923d2..5b2b3840f7a 100644
> > --- a/hw/display/Kconfig
> > +++ b/hw/display/Kconfig
> > @@ -55,7 +55,7 @@ config VGA_MMIO
> >
> > config VMWARE_VGA
> >     bool
> > -    default y if PCI_DEVICES && PC_PCI
> > +    default y if PCI_DEVICES && (PC_PCI || MIPS)
> >     depends on PCI
> >     select VGA
> >
> > diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
> > index e57db4f6412..5c83ef49cf6 100644
> > --- a/hw/mips/Kconfig
> > +++ b/hw/mips/Kconfig
> > @@ -1,8 +1,15 @@
> > config MALTA
> >     bool
> > +    imply PCNET_PCI
> > +    imply PCI_DEVICES
> > +    imply TEST_DEVICES
> >     select FDC37M81X
> >     select GT64120
> > +    select MIPS_CPS
> >     select PIIX
> > +    select PFLASH_CFI01
> > +    select SERIAL
> > +    select SMBUS_EEPROM
> >
> > config MIPSSIM
> >     bool
> > @@ -31,17 +38,26 @@ config JAZZ
> >
> > config FULOONG
> >     bool
> > +    imply PCI_DEVICES
> > +    imply TEST_DEVICES
> > +    imply ATI_VGA
> > +    imply RTL8139_PCI
> >     select PCI_BONITO
> > +    select SMBUS_EEPROM
> >     select VT82C686
> >
> > config LOONGSON3V
> >     bool
> > +    imply PCI_DEVICES
> > +    imply TEST_DEVICES
> > +    imply VIRTIO_PCI
> > +    imply VIRTIO_NET
> >     imply VIRTIO_VGA
> >     imply QXL if SPICE
> > +    imply USB_OHCI_PCI
> >     select SERIAL
> >     select GOLDFISH_RTC
> >     select LOONGSON_LIOINTC
> > -    select PCI_DEVICES
> >     select PCI_EXPRESS_GENERIC_BRIDGE
> >     select MSI_NONBROKEN
> >     select FW_CFG_MIPS
> > @@ -53,6 +69,8 @@ config MIPS_CPS
> >
> > config MIPS_BOSTON
> >     bool
> > +    imply PCI_DEVICES
> > +    imply TEST_DEVICES
> >     select FITLOADER
> >     select MIPS_CPS
> >     select PCI_EXPRESS_XILINX
> >
>
>

--00000000000058ff110610cb0e75
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 7 feb 2024, 14:18 BALATON Zoltan &lt;<a href=3D=
"mailto:balaton@eik.bme.hu">balaton@eik.bme.hu</a>&gt; ha scritto:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">&gt;=C2=A0 =C2=A0 =C2=A0if (defaults_enable=
d() &amp;&amp; object_class_by_name(&quot;pci-ohci&quot;)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_create_simple(pci_bus, -1, &quot;=
pci-ohci&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 usb_create_simple(usb_bus_find(-1), &quot=
;usb-kbd&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 usb_create_simple(usb_bus_find(-1), &quot=
;usb-tablet&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Object *usb_bus =3D object_resolve_path_t=
ype(&quot;&quot;, TYPE_USB_BUS, NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 usb_create_simple(USB_BUS(usb_bus), &quot=
;usb-kbd&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 usb_create_simple(USB_BUS(usb_bus), &quot=
;usb-tablet&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; nb_nics; i++) {<br>
<br>
Is this hunk supposed to be in this patch?<br></blockquote></div></div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">Yes, it fixes compilation --witho=
ut-default-devices (where usb_bus_find does not exist). Before this patch C=
ONFIG_USB is always selected, even without default devices.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
<br>
Regards,<br>
BALATON Zoltan<br>
<br>
&gt; diff --git a/hw/display/Kconfig b/hw/display/Kconfig<br>
&gt; index 1aafe1923d2..5b2b3840f7a 100644<br>
&gt; --- a/hw/display/Kconfig<br>
&gt; +++ b/hw/display/Kconfig<br>
&gt; @@ -55,7 +55,7 @@ config VGA_MMIO<br>
&gt;<br>
&gt; config VMWARE_VGA<br>
&gt;=C2=A0 =C2=A0 =C2=A0bool<br>
&gt; -=C2=A0 =C2=A0 default y if PCI_DEVICES &amp;&amp; PC_PCI<br>
&gt; +=C2=A0 =C2=A0 default y if PCI_DEVICES &amp;&amp; (PC_PCI || MIPS)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0depends on PCI<br>
&gt;=C2=A0 =C2=A0 =C2=A0select VGA<br>
&gt;<br>
&gt; diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig<br>
&gt; index e57db4f6412..5c83ef49cf6 100644<br>
&gt; --- a/hw/mips/Kconfig<br>
&gt; +++ b/hw/mips/Kconfig<br>
&gt; @@ -1,8 +1,15 @@<br>
&gt; config MALTA<br>
&gt;=C2=A0 =C2=A0 =C2=A0bool<br>
&gt; +=C2=A0 =C2=A0 imply PCNET_PCI<br>
&gt; +=C2=A0 =C2=A0 imply PCI_DEVICES<br>
&gt; +=C2=A0 =C2=A0 imply TEST_DEVICES<br>
&gt;=C2=A0 =C2=A0 =C2=A0select FDC37M81X<br>
&gt;=C2=A0 =C2=A0 =C2=A0select GT64120<br>
&gt; +=C2=A0 =C2=A0 select MIPS_CPS<br>
&gt;=C2=A0 =C2=A0 =C2=A0select PIIX<br>
&gt; +=C2=A0 =C2=A0 select PFLASH_CFI01<br>
&gt; +=C2=A0 =C2=A0 select SERIAL<br>
&gt; +=C2=A0 =C2=A0 select SMBUS_EEPROM<br>
&gt;<br>
&gt; config MIPSSIM<br>
&gt;=C2=A0 =C2=A0 =C2=A0bool<br>
&gt; @@ -31,17 +38,26 @@ config JAZZ<br>
&gt;<br>
&gt; config FULOONG<br>
&gt;=C2=A0 =C2=A0 =C2=A0bool<br>
&gt; +=C2=A0 =C2=A0 imply PCI_DEVICES<br>
&gt; +=C2=A0 =C2=A0 imply TEST_DEVICES<br>
&gt; +=C2=A0 =C2=A0 imply ATI_VGA<br>
&gt; +=C2=A0 =C2=A0 imply RTL8139_PCI<br>
&gt;=C2=A0 =C2=A0 =C2=A0select PCI_BONITO<br>
&gt; +=C2=A0 =C2=A0 select SMBUS_EEPROM<br>
&gt;=C2=A0 =C2=A0 =C2=A0select VT82C686<br>
&gt;<br>
&gt; config LOONGSON3V<br>
&gt;=C2=A0 =C2=A0 =C2=A0bool<br>
&gt; +=C2=A0 =C2=A0 imply PCI_DEVICES<br>
&gt; +=C2=A0 =C2=A0 imply TEST_DEVICES<br>
&gt; +=C2=A0 =C2=A0 imply VIRTIO_PCI<br>
&gt; +=C2=A0 =C2=A0 imply VIRTIO_NET<br>
&gt;=C2=A0 =C2=A0 =C2=A0imply VIRTIO_VGA<br>
&gt;=C2=A0 =C2=A0 =C2=A0imply QXL if SPICE<br>
&gt; +=C2=A0 =C2=A0 imply USB_OHCI_PCI<br>
&gt;=C2=A0 =C2=A0 =C2=A0select SERIAL<br>
&gt;=C2=A0 =C2=A0 =C2=A0select GOLDFISH_RTC<br>
&gt;=C2=A0 =C2=A0 =C2=A0select LOONGSON_LIOINTC<br>
&gt; -=C2=A0 =C2=A0 select PCI_DEVICES<br>
&gt;=C2=A0 =C2=A0 =C2=A0select PCI_EXPRESS_GENERIC_BRIDGE<br>
&gt;=C2=A0 =C2=A0 =C2=A0select MSI_NONBROKEN<br>
&gt;=C2=A0 =C2=A0 =C2=A0select FW_CFG_MIPS<br>
&gt; @@ -53,6 +69,8 @@ config MIPS_CPS<br>
&gt;<br>
&gt; config MIPS_BOSTON<br>
&gt;=C2=A0 =C2=A0 =C2=A0bool<br>
&gt; +=C2=A0 =C2=A0 imply PCI_DEVICES<br>
&gt; +=C2=A0 =C2=A0 imply TEST_DEVICES<br>
&gt;=C2=A0 =C2=A0 =C2=A0select FITLOADER<br>
&gt;=C2=A0 =C2=A0 =C2=A0select MIPS_CPS<br>
&gt;=C2=A0 =C2=A0 =C2=A0select PCI_EXPRESS_XILINX<br>
&gt;<br>
<br>
</blockquote></div></div></div>

--00000000000058ff110610cb0e75--



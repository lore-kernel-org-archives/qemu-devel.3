Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901CEC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 16:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY75A-00020A-EQ; Thu, 08 Feb 2024 11:17:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rY759-0001yq-33
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 11:16:59 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rY757-0002hi-DI
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 11:16:58 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-51147d0abd1so2390637e87.1
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 08:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707409015; x=1708013815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LzHUM3HkKrr5qUlTZx47MQ+nhW8W/D14nHvbJQDJQoY=;
 b=QvXVpWXCeK9W/3142o9regs1EHJNT0ttqk2fny0vzmEcrjI2POd7mTWkzu/5qZAoL5
 Mxe9L42tFe2s+V4OE6uiP594yEk1/wk7UNTqS7wkhG4PjUBiCx1SaCiaRxQ6DcvCqFD6
 P7GSUp8/EZF9M7YwK1oBmR5TsakdJhwJs9UHflHdy1gJ/RI0Lzj1Sh233ajFoBDbMxH4
 Veuqetk0e/VK0CUw20tiE8uUmQBtkT2kX/KNM52WBn0nD4YXcxuGx41C3gDqSa7qz3q5
 5zMvxfZ6xyqskA4EHIrQ3exPWEGJ8rYcA+Q7NHpOx6pMnkTp5njtBpHWSU1Mc68hwb6K
 p97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707409015; x=1708013815;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LzHUM3HkKrr5qUlTZx47MQ+nhW8W/D14nHvbJQDJQoY=;
 b=JMpvJZn86NtClNRkMQueF8bAbfGN+CXYEtGcbom/1PHKWbhPnqiA/pNmbp2yZWVdqU
 2C4mutqHg+1xEgVSQjEZN0PTL8km2oz+03BS78ROLBDaiV4obQHLlMta9p11Ex9m2bTi
 K5dm/3esQ778DC8uEQ2pp2ro6MWle2gmDfXlMLsykDF2G6kUmyTXH/cC17/QTPSX51SY
 sXvBdaCn6IbO6y+GXyt8Z9Oly95nGYagJiLpyth4OkPM0PhseXNLPQLfg1NTT713wWg3
 CO2xAiM89bXtgdNXv8OIRnsLuXBVZi302Qb51GpWM+kbaUXFbkYANOAPNZYKyOsef2Mk
 1bRw==
X-Gm-Message-State: AOJu0YwHJMV/agCe/M65udmUdQPRDUsqmKYRi1GizMF/hDUuBPAgN3fl
 sjjt3YZCfTagx1Z9UvQJGlPPh8+jRP8tx8v4hRQd0RKbIESex5YH
X-Google-Smtp-Source: AGHT+IF5PqvE6Q5J6wAYFWaJDv4wtY7vsoiqiFJUHZCasyxaH8JiaOThbaXAyxvu7s6Z/iHqS987Lw==
X-Received: by 2002:ac2:559a:0:b0:511:54f2:df07 with SMTP id
 v26-20020ac2559a000000b0051154f2df07mr5963643lfg.11.1707409015255; 
 Thu, 08 Feb 2024 08:16:55 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWKJn8x82BbtgmisScZakLmtmdfgVkUgbhx1mS4UPSmHs0DNvhfZIamNoWNHl7ju4jbY8cuC7sNrnSYQsCMZF+yLDf86poTHhUAdWvD6URfF65a4l9M
Received: from ?IPv6:::1?
 (p200300faaf1724007ccdd0ba9e70da1e.dip0.t-ipconnect.de.
 [2003:fa:af17:2400:7ccd:d0ba:9e70:da1e])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c4ecb00b0040d5ae2906esm2055232wmq.30.2024.02.08.08.16.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 08:16:54 -0800 (PST)
Date: Thu, 08 Feb 2024 16:16:47 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel <qemu-devel@nongnu.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 8/8] mips: do not list individual devices from configs/
In-Reply-To: <CABgObfY=va3f6By4PtAVDeJv7o7-YVVA+d7pA7YzZ1=bPQ3_QQ@mail.gmail.com>
References: <20240207111411.115040-1-pbonzini@redhat.com>
 <20240207111411.115040-9-pbonzini@redhat.com>
 <d218b1b0-3436-6120-55bc-f629ee1d667e@eik.bme.hu>
 <CABgObfY=va3f6By4PtAVDeJv7o7-YVVA+d7pA7YzZ1=bPQ3_QQ@mail.gmail.com>
Message-ID: <D6B1F7B5-DE42-4189-9FA7-BCE26BB47DF7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 7=2E Februar 2024 13:55:51 UTC schrieb Paolo Bonzini <pbonzini@redhat=
=2Ecom>:
>Il mer 7 feb 2024, 14:18 BALATON Zoltan <balaton@eik=2Ebme=2Ehu> ha scrit=
to:
>
>> >     if (defaults_enabled() && object_class_by_name("pci-ohci")) {
>> >         pci_create_simple(pci_bus, -1, "pci-ohci");
>> > -        usb_create_simple(usb_bus_find(-1), "usb-kbd");
>> > -        usb_create_simple(usb_bus_find(-1), "usb-tablet");
>> > +        Object *usb_bus =3D object_resolve_path_type("", TYPE_USB_BU=
S,
>> NULL);
>> > +        usb_create_simple(USB_BUS(usb_bus), "usb-kbd");
>> > +        usb_create_simple(USB_BUS(usb_bus), "usb-tablet");
>> >     }
>> >
>> >     for (i =3D 0; i < nb_nics; i++) {
>>
>> Is this hunk supposed to be in this patch?
>>
>
>Yes, it fixes compilation --without-default-devices (where usb_bus_find
>does not exist)=2E Before this patch CONFIG_USB is always selected, even
>without default devices=2E

Might be worth pointing out in the commit message=2E I wondered about this=
, too=2E

Bernhard

>
>Paolo
>
>
>> Regards,
>> BALATON Zoltan
>>
>> > diff --git a/hw/display/Kconfig b/hw/display/Kconfig
>> > index 1aafe1923d2=2E=2E5b2b3840f7a 100644
>> > --- a/hw/display/Kconfig
>> > +++ b/hw/display/Kconfig
>> > @@ -55,7 +55,7 @@ config VGA_MMIO
>> >
>> > config VMWARE_VGA
>> >     bool
>> > -    default y if PCI_DEVICES && PC_PCI
>> > +    default y if PCI_DEVICES && (PC_PCI || MIPS)
>> >     depends on PCI
>> >     select VGA
>> >
>> > diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
>> > index e57db4f6412=2E=2E5c83ef49cf6 100644
>> > --- a/hw/mips/Kconfig
>> > +++ b/hw/mips/Kconfig
>> > @@ -1,8 +1,15 @@
>> > config MALTA
>> >     bool
>> > +    imply PCNET_PCI
>> > +    imply PCI_DEVICES
>> > +    imply TEST_DEVICES
>> >     select FDC37M81X
>> >     select GT64120
>> > +    select MIPS_CPS
>> >     select PIIX
>> > +    select PFLASH_CFI01
>> > +    select SERIAL
>> > +    select SMBUS_EEPROM
>> >
>> > config MIPSSIM
>> >     bool
>> > @@ -31,17 +38,26 @@ config JAZZ
>> >
>> > config FULOONG
>> >     bool
>> > +    imply PCI_DEVICES
>> > +    imply TEST_DEVICES
>> > +    imply ATI_VGA
>> > +    imply RTL8139_PCI
>> >     select PCI_BONITO
>> > +    select SMBUS_EEPROM
>> >     select VT82C686
>> >
>> > config LOONGSON3V
>> >     bool
>> > +    imply PCI_DEVICES
>> > +    imply TEST_DEVICES
>> > +    imply VIRTIO_PCI
>> > +    imply VIRTIO_NET
>> >     imply VIRTIO_VGA
>> >     imply QXL if SPICE
>> > +    imply USB_OHCI_PCI
>> >     select SERIAL
>> >     select GOLDFISH_RTC
>> >     select LOONGSON_LIOINTC
>> > -    select PCI_DEVICES
>> >     select PCI_EXPRESS_GENERIC_BRIDGE
>> >     select MSI_NONBROKEN
>> >     select FW_CFG_MIPS
>> > @@ -53,6 +69,8 @@ config MIPS_CPS
>> >
>> > config MIPS_BOSTON
>> >     bool
>> > +    imply PCI_DEVICES
>> > +    imply TEST_DEVICES
>> >     select FITLOADER
>> >     select MIPS_CPS
>> >     select PCI_EXPRESS_XILINX
>> >
>>
>>


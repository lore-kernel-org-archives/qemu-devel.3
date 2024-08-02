Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102FBC3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 19:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZxq3-0003BZ-Jf; Fri, 02 Aug 2024 15:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sZxpz-0003An-2h
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 15:21:15 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sZxpw-0005mf-QV
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 15:21:14 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8AF4E4E6004;
 Fri, 02 Aug 2024 21:21:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id RLe42StmQCbM; Fri,  2 Aug 2024 21:21:00 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 928304E6001; Fri, 02 Aug 2024 21:21:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 90C8374577C;
 Fri, 02 Aug 2024 21:21:00 +0200 (CEST)
Date: Fri, 2 Aug 2024 21:21:00 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH-for-9.1 v4 1/2] hw/pci-host/gt64120: Set PCI base address
 register write mask
In-Reply-To: <20240802171023.85719-2-philmd@linaro.org>
Message-ID: <0319cc95-fb5b-d904-4043-00384ac9df4e@eik.bme.hu>
References: <20240802171023.85719-1-philmd@linaro.org>
 <20240802171023.85719-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-1803442020-1722625654=:46709"
Content-ID: <5d4ff228-0391-e18f-4409-e569fcf807c8@eik.bme.hu>
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1803442020-1722625654=:46709
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <a704aec2-d86d-051f-d235-8068947911f1@eik.bme.hu>

On Fri, 2 Aug 2024, Philippe Mathieu-Daudé wrote:
> When booting Linux we see:
>
>  PCI host bridge to bus 0000:00
>  pci_bus 0000:00: root bus resource [mem 0x10000000-0x17ffffff]
>  pci_bus 0000:00: root bus resource [io  0x1000-0x1fffff]
>  pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
>  pci 0000:00:00.0: [11ab:4620] type 00 class 0x060000
>  pci 0000:00:00.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
>  pci 0000:00:00.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
>  pci 0000:00:00.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
>  pci 0000:00:00.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
>  pci 0000:00:00.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
>
> This is due to missing base address register write mask.
> Add it to get:
>
>  PCI host bridge to bus 0000:00
>  pci_bus 0000:00: root bus resource [mem 0x10000000-0x17ffffff]
>  pci_bus 0000:00: root bus resource [io  0x1000-0x1fffff]
>  pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
>  pci 0000:00:00.0: [11ab:4620] type 00 class 0x060000
>  pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00000fff pref]
>  pci 0000:00:00.0: reg 0x14: [mem 0x01000000-0x01000fff pref]
>  pci 0000:00:00.0: reg 0x18: [mem 0x1c000000-0x1c000fff]
>  pci 0000:00:00.0: reg 0x1c: [mem 0x1f000000-0x1f000fff]
>  pci 0000:00:00.0: reg 0x20: [mem 0x1be00000-0x1be00fff]
>  pci 0000:00:00.0: reg 0x24: [io  0x14000000-0x14000fff]
>
> Since this device is only used by MIPS machines which aren't
> versioned, we don't need to update migration compat machinery.
>
> Mention the datasheet referenced. Remove the "Malta assumptions
> ahead" comment since the reset values from the datasheet are used.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> hw/pci-host/gt64120.c | 14 +++++++++++++-
> 1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
> index e02efc9e2e..7df2855f32 100644
> --- a/hw/pci-host/gt64120.c
> +++ b/hw/pci-host/gt64120.c
> @@ -1,6 +1,8 @@
> /*
>  * QEMU GT64120 PCI host
>  *
> + * (Datasheet GT-64120 Rev 1.4 from Sep 14, 1999)
> + *
>  * Copyright (c) 2006,2007 Aurelien Jarno
>  *
>  * Permission is hereby granted, free of charge, to any person obtaining a copy
> @@ -1213,17 +1215,27 @@ static void gt64120_realize(DeviceState *dev, Error **errp)
>
> static void gt64120_pci_realize(PCIDevice *d, Error **errp)
> {
> -    /* FIXME: Malta specific hw assumptions ahead */
> +    /* Values from chapter 17.16 "PCI Configuration" */
> +
>     pci_set_word(d->config + PCI_COMMAND, 0);
>     pci_set_word(d->config + PCI_STATUS,
>                  PCI_STATUS_FAST_BACK | PCI_STATUS_DEVSEL_MEDIUM);
>     pci_config_set_prog_interface(d->config, 0);
> +
> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_0, 0xfffff009);
> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_1, 0xfffff009);
> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_2, 0xfffff009);
> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_3, 0xfffff009);
> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_4, 0xfffff009);

Documentation says bit 0 is read only 0 for these? Why mask ending with 9 
not 8? Also prefetch bit 3 is read only 0 for the last one BAR4. 
Otherwise:

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

Regards,
BALATON Zoltan

> +    pci_set_long(d->wmask + PCI_BASE_ADDRESS_5, 0xfffff001);
> +
>     pci_set_long(d->config + PCI_BASE_ADDRESS_0, 0x00000008);
>     pci_set_long(d->config + PCI_BASE_ADDRESS_1, 0x01000008);
>     pci_set_long(d->config + PCI_BASE_ADDRESS_2, 0x1c000000);
>     pci_set_long(d->config + PCI_BASE_ADDRESS_3, 0x1f000000);
>     pci_set_long(d->config + PCI_BASE_ADDRESS_4, 0x14000000);
>     pci_set_long(d->config + PCI_BASE_ADDRESS_5, 0x14000001);
> +
>     pci_set_byte(d->config + 0x3d, 0x01);
> }
>
>
--3866299591-1803442020-1722625654=:46709--


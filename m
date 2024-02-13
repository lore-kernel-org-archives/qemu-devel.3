Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FE8C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 17:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZwoW-0006Fo-MT; Tue, 13 Feb 2024 12:43:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rZwoV-0006Ec-1s; Tue, 13 Feb 2024 12:43:23 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rZwoT-0001XS-Nl; Tue, 13 Feb 2024 12:43:22 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0C2FA4E604A;
 Tue, 13 Feb 2024 18:43:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 3U7p4bGtSRTb; Tue, 13 Feb 2024 18:43:17 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1E1A84E6013; Tue, 13 Feb 2024 18:43:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1C6667456B4;
 Tue, 13 Feb 2024 18:43:17 +0100 (CET)
Date: Tue, 13 Feb 2024 18:43:17 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@linux.intel.com>, 
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, 
 qemu-ppc@nongnu.org
Subject: Re: [PATCH v4 06/12] hw/misc/macio: Realize IDE controller before
 accessing it
In-Reply-To: <20240213130341.1793-7-philmd@linaro.org>
Message-ID: <6466b872-d0c8-d4af-07a2-9ac77a966ba4@eik.bme.hu>
References: <20240213130341.1793-1-philmd@linaro.org>
 <20240213130341.1793-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1088475822-1707846197=:79075"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--3866299591-1088475822-1707846197=:79075
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 13 Feb 2024, Philippe Mathieu-Daudé wrote:
> We should not wire IRQs on unrealized device.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> ---
> hw/misc/macio/macio.c | 9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> index c9f22f8515..3f449f91c0 100644
> --- a/hw/misc/macio/macio.c
> +++ b/hw/misc/macio/macio.c
> @@ -123,14 +123,17 @@ static bool macio_realize_ide(MacIOState *s, MACIOIDEState *ide,
> {
>     SysBusDevice *sbd = SYS_BUS_DEVICE(ide);
>
> -    sysbus_connect_irq(sbd, 0, irq0);
> -    sysbus_connect_irq(sbd, 1, irq1);
>     qdev_prop_set_uint32(DEVICE(ide), "channel", dmaid);
>     object_property_set_link(OBJECT(ide), "dbdma", OBJECT(&s->dbdma),
>                              &error_abort);
>     macio_ide_register_dma(ide);
> +    if (!qdev_realize(DEVICE(ide), BUS(&s->macio_bus), errp)) {
> +        return false;
> +    }
> +    sysbus_connect_irq(sbd, 0, irq0);
> +    sysbus_connect_irq(sbd, 1, irq1);
>
> -    return qdev_realize(DEVICE(ide), BUS(&s->macio_bus), errp);
> +    return true;
> }
>
> static void macio_oldworld_realize(PCIDevice *d, Error **errp)
>
--3866299591-1088475822-1707846197=:79075--


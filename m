Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DC9CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1M63-0006dy-LK; Wed, 24 Sep 2025 05:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v1M61-0006dF-O0
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:47:33 -0400
Received: from 3.mo548.mail-out.ovh.net ([188.165.32.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v1M5v-0007NW-1R
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:47:33 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.0.143])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4cWsSz2lqlz6V1K;
 Wed, 24 Sep 2025 09:47:14 +0000 (UTC)
Received: from kaod.org (37.59.142.104) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Wed, 24 Sep
 2025 11:47:14 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R005a9990dd1-1814-41ad-b12b-c0905ace3ad7,
 FFBB6E977D22EB3F6A0A3CEA11E4CFA931BEF3A6) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <d2edb8ff-2f99-423b-b28a-b8e3e2543bc2@kaod.org>
Date: Wed, 24 Sep 2025 11:47:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] hw/arm/aspeed: Move aspeed_board_init_flashes() to
 common SoC code
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>
References: <20250924055602.294857-1-jamin_lin@aspeedtech.com>
 <20250924055602.294857-2-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250924055602.294857-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.104]
X-ClientProxiedBy: DAG9EX1.mxp5.local (172.16.2.81) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 16b118c4-dfc0-40c2-b397-738ff9735896
X-Ovh-Tracer-Id: 13700513019773094703
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGaheJr/VrkrQnoYFIYoS/at6BnQ1vc4H6Ax1Bv0UjYKQP9OKrbPUiHtlDdJ6UB9UI7VNelypNwXxVcVcug4FjtGUSV+XMEFXPJKBCHXRzk8jbHFAWb0IKOfa4TCdPHlmqmNAVc9EMQ++HJLjAgz2wKXYvKYq4YfkRXsDDkSG+w4Gx8plSXUpflfXRITJfA9Hf62rSgmodYnLLbbmZlLe23gFzzyiX9DcEF8L71S/aeJ0S9lCzafwsMGYHlNTVeiVw0o8u0NN+12s4qLM4D1dQeTw5eutPIvwi/n3vfMEkCWzv0m3szlB59Lo3KnMdMkjHpZDAOmTpRV0w1JqfXrDxWs9qdi/JHsYolsX3F/aVFzLnoyVMzEYV77t2i+M7Jhq6oSedVSrPbXFqi7FtvhjWK6E2GFC2w/YkrdTIzS7XKowKdebejnb7Jiuss3/i8KtH9JYeDDl34jXFzCtXO0RztJ6+s0QegR8b4aJBrhwgLCSoZgsDRZ0tPMufQwPV24LT2cLl8UUYPfxnGSM4CJKseXWUYvJYL/vfQnnMXI754yElip1EGfX1ZEqKAx9KMnztltLM2NwyI62e588fccaefL39HGlhPI1/x/uy1KJZRQ2KEiRkye1rQWhFlNqN2YU8Z/zVWzuKZc2f3sGM0fMzKxtla+cN/ugK9TVvYaKxIcQ
DKIM-Signature: a=rsa-sha256; bh=m03pBTtqhWVnIPWttMXmsPQTndb5Y8GH6K20SGB5OAk=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1758707236; v=1;
 b=AEs3W1FMqEPQAccTL9012EnR4BQCGzSz7iNPKrvL/SLa6E2RoVUn++0KOWzv8Bk3NPFOee32
 d088ZXlydpEN7kZPZbT5qsgKXxxwgN9IEtGx/3ZC2qDqdUbzKEUmKPD228qIKX4SqDMXlr6GQfr
 ZRXgKd97DtlYgRQlph4XwCUxt0v3a2it+v7XYSBKYEYbkuFcu4CGsSeAYVHgUL5KLAbiPhPLXZo
 HPNjg/px5PVDcxj7/kmzO5Gfz2oGMVBqrWWGNtTeBUwdWQZgHjQfsof8nZGkoNICWsEPTZJ9wG+
 1U964JPrd3SDRSbH+ABbEK+LTlKNHDYh6GQQ6W/Cvrxbg==
Received-SPF: pass client-ip=188.165.32.156; envelope-from=clg@kaod.org;
 helo=3.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/24/25 07:55, Jamin Lin wrote:
> Relocate aspeed_board_init_flashes() from hw/arm/aspeed.c into
> hw/arm/aspeed_soc_common.c so the helper can be reused by all
> ASPEED machines. The API was already declared in
> include/hw/arm/aspeed_soc.h; this change moves its
> implementation out of the machine file to keep aspeed.c cleaner.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/arm/aspeed.c            | 22 ----------------------
>   hw/arm/aspeed_soc_common.c | 23 +++++++++++++++++++++++
>   2 files changed, 23 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index d21b21965a..55f0afe0a4 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -337,28 +337,6 @@ static void aspeed_load_vbootrom(AspeedMachineState *bmc, const char *bios_name,
>       }
>   }
>   
> -void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
> -                                      unsigned int count, int unit0)
> -{
> -    int i;
> -
> -    if (!flashtype) {
> -        return;
> -    }
> -
> -    for (i = 0; i < count; ++i) {
> -        DriveInfo *dinfo = drive_get(IF_MTD, 0, unit0 + i);
> -        DeviceState *dev;
> -
> -        dev = qdev_new(flashtype);
> -        if (dinfo) {
> -            qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo));
> -        }
> -        qdev_prop_set_uint8(dev, "cs", i);
> -        qdev_realize_and_unref(dev, BUS(s->spi), &error_fatal);
> -    }
> -}
> -
>   static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc,
>                                  bool boot_emmc)
>   {
> diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
> index 1c4ac93a0f..31b1e683c3 100644
> --- a/hw/arm/aspeed_soc_common.c
> +++ b/hw/arm/aspeed_soc_common.c
> @@ -16,6 +16,7 @@
>   #include "hw/misc/unimp.h"
>   #include "hw/arm/aspeed_soc.h"
>   #include "hw/char/serial-mm.h"
> +#include "system/blockdev.h"
>   
>   
>   const char *aspeed_soc_cpu_type(AspeedSoCClass *sc)
> @@ -124,6 +125,28 @@ void aspeed_mmio_map_unimplemented(AspeedSoCState *s, SysBusDevice *dev,
>                                           sysbus_mmio_get_region(dev, 0), -1000);
>   }
>   
> +void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
> +                               unsigned int count, int unit0)
> +{
> +    int i;
> +
> +    if (!flashtype) {
> +        return;
> +    }
> +
> +    for (i = 0; i < count; ++i) {
> +        DriveInfo *dinfo = drive_get(IF_MTD, 0, unit0 + i);
> +        DeviceState *dev;
> +
> +        dev = qdev_new(flashtype);
> +        if (dinfo) {
> +            qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo));
> +        }
> +        qdev_prop_set_uint8(dev, "cs", i);
> +        qdev_realize_and_unref(dev, BUS(s->spi), &error_fatal);
> +    }
> +}
> +
>   static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>   {
>       AspeedSoCState *s = ASPEED_SOC(dev);



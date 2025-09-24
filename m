Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A529DCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1M6A-0006eb-OV; Wed, 24 Sep 2025 05:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v1M66-0006eN-Mv
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:47:41 -0400
Received: from 8.mo548.mail-out.ovh.net ([46.105.45.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v1M60-0007Qh-0m
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:47:38 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.43.72])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4cWsT93gYZz6TCD;
 Wed, 24 Sep 2025 09:47:25 +0000 (UTC)
Received: from kaod.org (37.59.142.97) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Wed, 24 Sep
 2025 11:47:24 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G00218836895-7978-4e2d-8b31-904573f41fd6,
 FFBB6E977D22EB3F6A0A3CEA11E4CFA931BEF3A6) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <376f5276-4140-4a09-bd48-80b238fadac2@kaod.org>
Date: Wed, 24 Sep 2025 11:47:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] hw/arm/aspeed: Move write_boot_rom to common SoC
 code
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>
References: <20250924055602.294857-1-jamin_lin@aspeedtech.com>
 <20250924055602.294857-3-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250924055602.294857-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG5EX2.mxp5.local (172.16.2.42) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 619ffc42-c00a-40cf-bff6-afc1e7ad5789
X-Ovh-Tracer-Id: 13703609241605999407
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEVtDoSl0SyU/3ZU/z6FreJhDcjOuMfXbxUQiGDko4R5+IVwzd5/AkOm3SLjk4kMlai5LyerbaQ8qrXmxT9XOaQF7DndJLf5jDm/oiib+rBC69JqNje1i4f7Wy2XQTm1OtfJDNAuFYwLpyPVzcclEoe5kkWm7QCA48vgF9RbVU+4004dl65StStzbTjPm5JZEvT5zINeADOYVsMkRZ06ah5y3xFQ8WLYIDWcyLyeOuLOavBI0CLyS2Sb7882h/ZWlv+IZVs2ZOaCbKrvzrWZVDUZIyMRJ/0r5dY7hOd2R7OoxF6+atMi92S+DyqdLQxDrnL2ZdxaR9T+JaV7o8SITN0BImdyepdFi5f7a6rrqfhiVlkC5gWIp+CpB7GLDaOOhA8C5UIG6BVykmnHudVrSQeWPf+6bz+aYnCMo720rGgODe8y15MAMdf8a8C0Q3CFEu4M0uYNJkW/fvMtePXBNr7imzgsl8qALBSXytQ6yjlFwiHF2BleO7a6q/2ZceeANYEHMagO/hDQF7u16hsmIZGYGZm2JcggJdfqINq6YkLjWF8Pxj37p6d18Y+eBGbEAGUkT+mbE3uq0kjSoI4gAMtrbTTERxmmqqdUSvA1p+dA2Tqf/nCxqhfa9Js1Id4O0pNPjBMvNZElyt7xUMx67d/WrOeiLogTqhFDs3J44P9PA
DKIM-Signature: a=rsa-sha256; bh=MlpWjTrIVbPri9PnJUIpAQ/89+ymXriq2Vf8isEbuUk=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1758707245; v=1;
 b=vtxC/Sb211OfyOOT4+7yqcAsu0MhJBrGZvg2Yo4MWHTIX7iZ3zN9Evm6Xcjl276WREFUGsHQ
 wBjiD/0ZARURDL2XkRpXwGzmo7zGlHKzGrl46L05fvCbXh6qGePWI2Cu4Q3Pmgz+fBZr0qLO1cV
 YWGbgous1pqX6rMcPWXYiWfgbCThwNoUYFowGkAcPf4XRFmNGTHTVJ47idD7fJdoYaFKBjcv22N
 ufENyUiAhCQKZ0DU+iMT5+E8naTvZnhAFcqfZrosR0m2TJqF/kORbEdmlt9l46WykhmTflqHS3G
 zDydEip9852RM5CHD/cbeHlOmY7Y0Un7WxPnwcd122K1g==
Received-SPF: pass client-ip=46.105.45.231; envelope-from=clg@kaod.org;
 helo=8.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Move the write_boot_rom helper from hw/arm/aspeed.c into
> hw/arm/aspeed_soc_common.c so it can be reused by all ASPEED
> machines. Export the API as aspeed_write_boot_rom() in
> include/hw/arm/aspeed_soc.h and update the existing call site
> to use the new helper.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/arm/aspeed_soc.h |  2 ++
>   hw/arm/aspeed.c             | 33 ++-------------------------------
>   hw/arm/aspeed_soc_common.c  | 31 +++++++++++++++++++++++++++++++
>   3 files changed, 35 insertions(+), 31 deletions(-)
> 
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index aaf518d179..5567bdcb69 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -312,6 +312,8 @@ void aspeed_mmio_map_unimplemented(AspeedSoCState *s, SysBusDevice *dev,
>                                      uint64_t size);
>   void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
>                                  unsigned int count, int unit0);
> +void aspeed_write_boot_rom(BlockBackend *blk, hwaddr addr, size_t rom_size,
> +                           Error **errp);
>   
>   static inline int aspeed_uart_index(int uart_dev)
>   {
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 55f0afe0a4..4d0d935836 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -263,35 +263,6 @@ static void aspeed_reset_secondary(ARMCPU *cpu,
>       cpu_set_pc(cs, info->smp_loader_start);
>   }
>   
> -static void write_boot_rom(BlockBackend *blk, hwaddr addr, size_t rom_size,
> -                           Error **errp)
> -{
> -    g_autofree void *storage = NULL;
> -    int64_t size;
> -
> -    /*
> -     * The block backend size should have already been 'validated' by
> -     * the creation of the m25p80 object.
> -     */
> -    size = blk_getlength(blk);
> -    if (size <= 0) {
> -        error_setg(errp, "failed to get flash size");
> -        return;
> -    }
> -
> -    if (rom_size > size) {
> -        rom_size = size;
> -    }
> -
> -    storage = g_malloc0(rom_size);
> -    if (blk_pread(blk, 0, rom_size, storage, 0) < 0) {
> -        error_setg(errp, "failed to read the initial flash content");
> -        return;
> -    }
> -
> -    rom_add_blob_fixed("aspeed.boot_rom", storage, rom_size, addr);
> -}
> -
>   /*
>    * Create a ROM and copy the flash contents at the expected address
>    * (0x0). Boots faster than execute-in-place.
> @@ -306,8 +277,8 @@ static void aspeed_install_boot_rom(AspeedMachineState *bmc, BlockBackend *blk,
>                              &error_abort);
>       memory_region_add_subregion_overlap(&soc->spi_boot_container, 0,
>                                           &bmc->boot_rom, 1);
> -    write_boot_rom(blk, sc->memmap[ASPEED_DEV_SPI_BOOT],
> -                   rom_size, &error_abort);
> +    aspeed_write_boot_rom(blk, sc->memmap[ASPEED_DEV_SPI_BOOT], rom_size,
> +                          &error_abort);
>   }
>   
>   #define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
> diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
> index 31b1e683c3..d0a400725f 100644
> --- a/hw/arm/aspeed_soc_common.c
> +++ b/hw/arm/aspeed_soc_common.c
> @@ -17,6 +17,8 @@
>   #include "hw/arm/aspeed_soc.h"
>   #include "hw/char/serial-mm.h"
>   #include "system/blockdev.h"
> +#include "system/block-backend.h"
> +#include "hw/loader.h"
>   
>   
>   const char *aspeed_soc_cpu_type(AspeedSoCClass *sc)
> @@ -147,6 +149,35 @@ void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
>       }
>   }
>   
> +void aspeed_write_boot_rom(BlockBackend *blk, hwaddr addr, size_t rom_size,
> +                           Error **errp)
> +{
> +    g_autofree void *storage = NULL;
> +    int64_t size;
> +
> +    /*
> +     * The block backend size should have already been 'validated' by
> +     * the creation of the m25p80 object.
> +     */
> +    size = blk_getlength(blk);
> +    if (size <= 0) {
> +        error_setg(errp, "failed to get flash size");
> +        return;
> +    }
> +
> +    if (rom_size > size) {
> +        rom_size = size;
> +    }
> +
> +    storage = g_malloc0(rom_size);
> +    if (blk_pread(blk, 0, rom_size, storage, 0) < 0) {
> +        error_setg(errp, "failed to read the initial flash content");
> +        return;
> +    }
> +
> +    rom_add_blob_fixed("aspeed.boot_rom", storage, rom_size, addr);
> +}
> +
>   static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>   {
>       AspeedSoCState *s = ASPEED_SOC(dev);



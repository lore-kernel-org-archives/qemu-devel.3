Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88714CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1M6b-0006iU-Dg; Wed, 24 Sep 2025 05:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v1M6Z-0006hv-I1
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:48:07 -0400
Received: from smtpout4.mo529.mail-out.ovh.net ([217.182.185.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v1M6P-0007WI-SA
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:48:07 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.37.179])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4cWsTh6GxBz5w6K;
 Wed, 24 Sep 2025 09:47:52 +0000 (UTC)
Received: from kaod.org (37.59.142.108) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Wed, 24 Sep
 2025 11:47:51 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-108S002e4864947-a02d-4e66-9429-9c4fc422bf1f,
 FFBB6E977D22EB3F6A0A3CEA11E4CFA931BEF3A6) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <b134e567-3640-490a-add4-bb36ba0c9272@kaod.org>
Date: Wed, 24 Sep 2025 11:47:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] hw/arm/aspeed: Move aspeed_load_vbootrom to common
 SoC code
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>
References: <20250924055602.294857-1-jamin_lin@aspeedtech.com>
 <20250924055602.294857-5-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250924055602.294857-5-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.108]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: bbf3c8ce-2e5a-495c-a764-268be76ca793
X-Ovh-Tracer-Id: 13711209066548333359
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGH5VBLOuSKlD5f33Xct79dsDOs8kr/nVfOh53MRWnj9rBlccBZJxqpnu2wq9eD19mcQaqBlB01Rjk34EY7uk2kjJWXc5wMBn6N45fpnGM/XAP213fzAIr++PTg9ipLpQsNVeaecueHuQa+r6y7xXub1n63qTe7/2bASjXrg6R3vAtpTM/csn3bSw8nsTNG3dAOS3yWn61uc2MljZG89cBs/UaXeQa1cdm9GksB2R0D2lNgy06d0jAscQYiO6CqJwnYaovU0djwaaW7jbxn5bLdlrqQJ6IYFVk0NExjMGVwIoEhu330gt/cP2+17cw19O0ieizzITCWfd5eK24DgElGCEGVNoHBbbeCBc6aPcnbOmTmpb9mCXan7/YMI2eCKOlkbfp7oa1wU7T6S7QeXjRNh1iaApFPMSHViu26LolsxUQHxZsf1UcKrMjdr1I0QlFMr8IQLD6wevo4g53oFu+meMYxzZwnbFUOgSQjGqu9lg73Fd0XyTjOSGjniGlrswG5tuPbuLRxjO8bNY5yE362Tx5kU0/u5Frkxbyu/QpqczNjRbXOPdMqeFMfdhlvQduxC+0r2uQqdABSjp0y64Et6GZw7oUi8l8UBToMN/dsAtu4U+9w5SX4SseG+WL0ohfA3RFjFWcziuRX+0kSLMlk6IaNuMiFtGh6/gU7SkyFvw
DKIM-Signature: a=rsa-sha256; bh=o1/CcvNvGikq50UbbY/4egc04q9xFGQ97KBxh8mPnIM=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1758707273; v=1;
 b=MpnHIegVUBjLUq66mdVWMzq2b4T/p66GKSpe/Cg0IHkb8g4PIbabpTSl3Y1A0WNFZtHsua60
 8zAoSZU31tR2JJBd0Brd6NK3LMojg1P4eOBX/87hRHjborkrK5Jok4eSKcXBs4Oi+rY/KIONX81
 XXO6lM8TdjBPwFh0y4VWa41HlQRyIG/W+56qAPf8ZKocXLwcPfRpJjNIoKfSEFhApOccNKb7MD2
 pFwDRXX+nH/PsheoTPiQbSpmXAZKQQQZDkdhpH0ipu/e1tDM/lJlqc4iA6HttugcPdt4/r3dRC+
 7ls1NPZaFcusKjwYItooKBT8wRTOBxybfASGWarI9lZzg==
Received-SPF: pass client-ip=217.182.185.173; envelope-from=clg@kaod.org;
 helo=smtpout4.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
> Move the vbootrom loader helper into common SoC code so it can be reused
> by all ASPEED boards, and decouple the API from AspeedMachineState.
> 
> Specifically:
> - Move aspeed_load_vbootrom() to hw/arm/aspeed_soc_common.c and
> declare it in include/hw/arm/aspeed_soc.h.
> - Change the helper’s signature to take AspeedSoCState * instead of
> AspeedMachineState *.
> - Update aspeed_machine_init() call sites accordingly.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/arm/aspeed_soc.h |  4 ++++
>   hw/arm/aspeed.c             | 31 +------------------------------
>   hw/arm/aspeed_soc_common.c  | 25 +++++++++++++++++++++++++
>   3 files changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index aea210a8e2..ed32efb543 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -43,6 +43,8 @@
>   #include "hw/char/serial-mm.h"
>   #include "hw/intc/arm_gicv3.h"
>   
> +#define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
> +
>   #define ASPEED_SPIS_NUM  3
>   #define ASPEED_EHCIS_NUM 4
>   #define ASPEED_WDTS_NUM  8
> @@ -316,6 +318,8 @@ void aspeed_write_boot_rom(BlockBackend *blk, hwaddr addr, size_t rom_size,
>                              Error **errp);
>   void aspeed_install_boot_rom(AspeedSoCState *soc, BlockBackend *blk,
>                                MemoryRegion *boot_rom, uint64_t rom_size);
> +void aspeed_load_vbootrom(AspeedSoCState *soc, const char *bios_name,
> +                          Error **errp);
>   
>   static inline int aspeed_uart_index(int uart_dev)
>   {
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 429f4c6d77..6046ec0bb2 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -26,9 +26,7 @@
>   #include "hw/qdev-properties.h"
>   #include "system/block-backend.h"
>   #include "system/reset.h"
> -#include "hw/loader.h"
>   #include "qemu/error-report.h"
> -#include "qemu/datadir.h"
>   #include "qemu/units.h"
>   #include "hw/qdev-clock.h"
>   #include "system/system.h"
> @@ -263,33 +261,6 @@ static void aspeed_reset_secondary(ARMCPU *cpu,
>       cpu_set_pc(cs, info->smp_loader_start);
>   }
>   
> -#define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
> -
> -/*
> - * This function locates the vbootrom image file specified via the command line
> - * using the -bios option. It loads the specified image into the vbootrom
> - * memory region and handles errors if the file cannot be found or loaded.
> - */
> -static void aspeed_load_vbootrom(AspeedMachineState *bmc, const char *bios_name,
> -                                 Error **errp)
> -{
> -    g_autofree char *filename = NULL;
> -    AspeedSoCState *soc = bmc->soc;
> -    int ret;
> -
> -    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> -    if (!filename) {
> -        error_setg(errp, "Could not find vbootrom image '%s'", bios_name);
> -        return;
> -    }
> -
> -    ret = load_image_mr(filename, &soc->vbootrom);
> -    if (ret < 0) {
> -        error_setg(errp, "Failed to load vbootrom image '%s'", bios_name);
> -        return;
> -    }
> -}
> -
>   static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc,
>                                  bool boot_emmc)
>   {
> @@ -451,7 +422,7 @@ static void aspeed_machine_init(MachineState *machine)
>   
>       if (amc->vbootrom) {
>           bios_name = machine->firmware ?: VBOOTROM_FILE_NAME;
> -        aspeed_load_vbootrom(bmc, bios_name, &error_abort);
> +        aspeed_load_vbootrom(bmc->soc, bios_name, &error_abort);
>       }
>   
>       arm_load_kernel(ARM_CPU(first_cpu), machine, &aspeed_board_binfo);
> diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
> index 7f104f8de5..bc70e864fb 100644
> --- a/hw/arm/aspeed_soc_common.c
> +++ b/hw/arm/aspeed_soc_common.c
> @@ -19,6 +19,7 @@
>   #include "system/blockdev.h"
>   #include "system/block-backend.h"
>   #include "hw/loader.h"
> +#include "qemu/datadir.h"
>   
>   
>   const char *aspeed_soc_cpu_type(AspeedSoCClass *sc)
> @@ -195,6 +196,30 @@ void aspeed_install_boot_rom(AspeedSoCState *soc, BlockBackend *blk,
>                             &error_abort);
>   }
>   
> +/*
> + * This function locates the vbootrom image file specified via the command line
> + * using the -bios option. It loads the specified image into the vbootrom
> + * memory region and handles errors if the file cannot be found or loaded.
> + */
> +void aspeed_load_vbootrom(AspeedSoCState *soc, const char *bios_name,
> +                          Error **errp)
> +{
> +    g_autofree char *filename = NULL;
> +    int ret;
> +
> +    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> +    if (!filename) {
> +        error_setg(errp, "Could not find vbootrom image '%s'", bios_name);
> +        return;
> +    }
> +
> +    ret = load_image_mr(filename, &soc->vbootrom);
> +    if (ret < 0) {
> +        error_setg(errp, "Failed to load vbootrom image '%s'", bios_name);
> +        return;
> +    }
> +}
> +
>   static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>   {
>       AspeedSoCState *s = ASPEED_SOC(dev);



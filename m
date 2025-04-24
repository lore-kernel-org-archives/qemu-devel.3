Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22DEC369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7sRJ-0007YT-IJ; Thu, 24 Apr 2025 05:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=52tn=XK=kaod.org=clg@ozlabs.org>)
 id 1u7sRH-0007XC-D6; Thu, 24 Apr 2025 05:00:11 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=52tn=XK=kaod.org=clg@ozlabs.org>)
 id 1u7sRE-0005gh-SR; Thu, 24 Apr 2025 05:00:11 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Zjqg65Qdwz4xD3;
 Thu, 24 Apr 2025 19:00:02 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Zjqg30pdKz4x8Y;
 Thu, 24 Apr 2025 18:59:56 +1000 (AEST)
Message-ID: <4d90794d-3add-49a3-b4b6-10a1b4cf3441@kaod.org>
Date: Thu, 24 Apr 2025 10:59:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] hw/arm/aspeed: Add support for loading vbootrom
 image via "-bios"
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Cc: troy_lee@aspeedtech.com, nabihestefan@google.com
References: <20250424075135.3715128-1-jamin_lin@aspeedtech.com>
 <20250424075135.3715128-4-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250424075135.3715128-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=52tn=XK=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/24/25 09:51, Jamin Lin wrote:
> Introduce "aspeed_load_vbootrom()" to support loading a virtual boot ROM image
> into the vbootrom memory region, using the "-bios" command-line option.
> 
> Introduce a new "vbootrom" field in the AspeedMachineClass to indicate whether
> a machine supports the virtual boot ROM region.
> 
> Set this field to true by default for the AST2700-A0 and AST2700-A1 EVB
> machines.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Nabih Estefan <nabihestefan@google.com>
> Tested-by: Nabih Estefan <nabihestefan@google.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/arm/aspeed.h |  1 +
>   hw/arm/aspeed.c         | 36 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 37 insertions(+)
> 
> diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
> index 9cae45a1c9..973277bea6 100644
> --- a/include/hw/arm/aspeed.h
> +++ b/include/hw/arm/aspeed.h
> @@ -40,6 +40,7 @@ struct AspeedMachineClass {
>       void (*i2c_init)(AspeedMachineState *bmc);
>       uint32_t uart_default;
>       bool sdhci_wp_inverted;
> +    bool vbootrom;
>   };
>   
>   
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 82f42582fa..32846bd088 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -27,6 +27,7 @@
>   #include "system/reset.h"
>   #include "hw/loader.h"
>   #include "qemu/error-report.h"
> +#include "qemu/datadir.h"
>   #include "qemu/units.h"
>   #include "hw/qdev-clock.h"
>   #include "system/system.h"
> @@ -305,6 +306,33 @@ static void aspeed_install_boot_rom(AspeedMachineState *bmc, BlockBackend *blk,
>                      rom_size, &error_abort);
>   }
>   
> +#define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
> +
> +/*
> + * This function locates the vbootrom image file specified via the command line
> + * using the -bios option. It loads the specified image into the vbootrom
> + * memory region and handles errors if the file cannot be found or loaded.
> + */
> +static void aspeed_load_vbootrom(AspeedMachineState *bmc, const char *bios_name,
> +                                 Error **errp)
> +{
> +    g_autofree char *filename = NULL;
> +    AspeedSoCState *soc = bmc->soc;
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
>   void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
>                                         unsigned int count, int unit0)
>   {
> @@ -380,6 +408,7 @@ static void aspeed_machine_init(MachineState *machine)
>       AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(machine);
>       AspeedSoCClass *sc;
>       int i;
> +    const char *bios_name = NULL;
>       DriveInfo *emmc0 = NULL;
>       bool boot_emmc;
>   
> @@ -482,6 +511,11 @@ static void aspeed_machine_init(MachineState *machine)
>           }
>       }
>   
> +    if (amc->vbootrom) {
> +        bios_name = machine->firmware ?: VBOOTROM_FILE_NAME;
> +        aspeed_load_vbootrom(bmc, bios_name, &error_abort);
> +    }
> +
>       arm_load_kernel(ARM_CPU(first_cpu), machine, &aspeed_board_binfo);
>   }
>   
> @@ -1689,6 +1723,7 @@ static void aspeed_machine_ast2700a0_evb_class_init(ObjectClass *oc, void *data)
>       amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON | ASPEED_MAC2_ON;
>       amc->uart_default = ASPEED_DEV_UART12;
>       amc->i2c_init  = ast2700_evb_i2c_init;
> +    amc->vbootrom = true;
>       mc->auto_create_sdcard = true;
>       mc->default_ram_size = 1 * GiB;
>       aspeed_machine_class_init_cpus_defaults(mc);
> @@ -1709,6 +1744,7 @@ static void aspeed_machine_ast2700a1_evb_class_init(ObjectClass *oc, void *data)
>       amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON | ASPEED_MAC2_ON;
>       amc->uart_default = ASPEED_DEV_UART12;
>       amc->i2c_init  = ast2700_evb_i2c_init;
> +    amc->vbootrom = true;
>       mc->auto_create_sdcard = true;
>       mc->default_ram_size = 1 * GiB;
>       aspeed_machine_class_init_cpus_defaults(mc);



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B289FCD98C5
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 17:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYRu2-0003kh-G1; Sat, 13 Jun 2026 13:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wYRtv-0003k7-Td
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 13:12:08 -0400
Received: from smtpout3.mo539.mail-out.ovh.net ([51.210.91.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wYRtt-0004vG-Q7
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 13:12:07 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [57.128.106.70])
 by mo539.mail-out.ovh.net (Postfix) with ESMTPS id 4gd2xC3BTcz3wgc;
 Sat, 13 Jun 2026 17:11:59 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.hansen@9elements.com>; Sat, 13 Jun 2026 17:11:59 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.118.15])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gd2xC09wYz7xq5; Sat, 13 Jun 2026 17:11:59 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.2])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id ABF521B43C5B;
 Sat, 13 Jun 2026 17:11:56 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G0061c81e408-9072-480b-b3dc-788c0c79fd1b,
 E2CD3F290BDA47254B2896B828795FC85CEB7E2E) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <edd061c5-0477-4c18-8b96-f647081648ab@kaod.org>
Date: Sat, 13 Jun 2026 19:11:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/arm: anacapa: add ADC128D818 devices
To: Emmanuel Blot <eblot@meta.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alexander Hansen <alexander.hansen@9elements.com>,
 William de Abreu Pinho <williampinho@meta.com>, qemu-arm@nongnu.org
References: <20260612-i2c-adc128d818-anacapa-v1-0-9e4640cd164b@meta.com>
 <20260612-i2c-adc128d818-anacapa-v1-3-9e4640cd164b@meta.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260612-i2c-adc128d818-anacapa-v1-3-9e4640cd164b@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 10330976071811705901
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGSmKmxdwSRWuZ5s6iujUbnhOdyDtj4OTqh8pyfspxqou0l89+0GjMdlgBfQbiuU24cQaBXs38OVfiudxFXIuoXdXOpR1rFxnywXxYzZ6ImLNfnbBj+w5rAp7+hwikQkiZrRjXWMr/javrm4wmYHS3XDdlIu3wt7XEqrtjCePYYgsskAzfpeLFhIVgLckUK0CwKwyOtXuHMAFOM6TK2Mqz8OCJstpt/7VnePjADUXr+7VWdxVNSuXouokfB0Ezj6nEeSXvg1avZIOIkLfWVc51EDyMRKpGs/EbVZy4Qk5CT1khcAM+4lf0Qfzs6HE77KJCR1iaq96uZkjldtEplCpXybo9cNGIcdMjYyz2Vbv1OSY08iv/wH+WnxGLROqNHw6y7JrMlwHDDZas+d34uDhsqY4ukr8/stgASzMO2ko5xCK5KlVINWiV81NZ6RC5KuRYUTcQ0toc+5C0K5lm13CHYomk3eUFz+qFDRdYqpDI/w8PehHQboiF33BHwOs0xGHbvwPJO/qNYe56yucVXk0LDF6yjPvQZOa6+LOWek8OwK5IVa84ig5/BazE7Sawn1cVdotxxNc5I6AsSvhfGJLix0ziRCgpIHWYI4U+dLRlythwb5UkJkj34UmnWanngfoPzko/KrKgm5L7FlTy13rFhVkZjnRCo4aB5wjKxhLHGqA
DKIM-Signature: a=rsa-sha256; bh=gKYFEx3b1ewlXvJ+geDFIgU4rkAAWp4hC0oSetjt4BQ=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1781370721; v=1;
 b=M4r6JeOcun9n+O5Ek/6Fnh9u7IXevdzDKEnYNGE2YKE1Inq79iUMDv6Opb1hu5ZTdAIVTfy/
 B1Oeif8HtSgFc6RqC9kgGDFsNJFc5L0onfNX9bQ6mh+MjiSvpmfp7yTWSun3SJdIUQb+r0pTx1q
 ILcx7zESrf4ITIrTy+fZ1VhkRIIM4ufDLxudOiWKqp7ub4fSyhZa8qhrBKGnv4bppy9wTEVwMZB
 RsIf5vw9amd3LRgBv1YB+yZ2d5N6p2/FOSbnoO7WNL/SLvZQpCP9ulLjeBeTIhPTypcZoFNsryK
 uMMjvuvoknROB0TjCMQTm/8YO9hvenJ4KhuX9Js+LAr1A==
Received-SPF: pass client-ip=51.210.91.42; envelope-from=clg@kaod.org;
 helo=smtpout3.mo539.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/12/26 18:47, Emmanuel Blot wrote:
> Wire up the two ADC128D818 instances that appear in the Anacapa DTS:
> one on i2c8 mux channel 0 and one on i2c13 mux channel 3.
> 
> Signed-off-by: Emmanuel Blot <eblot@meta.com>
> ---
>   hw/arm/Kconfig                  |  1 +
>   hw/arm/aspeed_ast2600_anacapa.c | 19 +++++++++++++++++--
>   2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index fb798ccbee..04ecf5d473 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -553,6 +553,7 @@ config ASPEED_SOC
>       select LED
>       select PMBUS
>       select MAX31785
> +    select ADC128D818
>       select FSI_APB2OPB_ASPEED
>       select AT24C
>       select PCI_EXPRESS
> diff --git a/hw/arm/aspeed_ast2600_anacapa.c b/hw/arm/aspeed_ast2600_anacapa.c
> index a1c8111a93..7dc566d7fe 100644
> --- a/hw/arm/aspeed_ast2600_anacapa.c
> +++ b/hw/arm/aspeed_ast2600_anacapa.c
> @@ -8,6 +8,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
> +#include "hw/sensor/adc128d818.h"
>   #include "hw/arm/machines-qom.h"
>   #include "hw/arm/aspeed.h"
>   #include "hw/arm/aspeed_soc.h"
> @@ -16,9 +17,11 @@
>   #include "hw/nvram/eeprom_at24c.h"
>   
>   /* Anacapa hardware value */
> +/* clang-format off */

Doesn't seem useful.

>   #define ANACAPA_BMC_HW_STRAP1 0x00002002
>   #define ANACAPA_BMC_HW_STRAP2 0x00000000
>   #define ANACAPA_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
> +/* clang-format on */
>   
>   /*
>    * "Anacapa HPM (MB)" FRU data. Generated with frugen.
> @@ -221,6 +224,14 @@ static const uint8_t hpm_brd_id_eeprom[] = {
>   };
>   static const size_t hpm_brd_id_eeprom_len = sizeof(hpm_brd_id_eeprom);
>   
> +static void anacapa_add_adc128d818(I2CBus *bus, uint8_t addr,
> +                                   const char *description)
> +{
> +    DeviceState *dev = DEVICE(i2c_slave_new(TYPE_ADC128D818, addr));
> +    qdev_prop_set_string(dev, "description", description);
> +    i2c_slave_realize_and_unref(I2C_SLAVE(dev), bus, &error_fatal);
> +}
> +
>   static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
>   {
>       /* Reference: aspeed-bmc-facebook-anacapa.dts */
> @@ -259,7 +270,8 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
>       i2c_mux = i2c_slave_create_simple(i2c[8], TYPE_PCA9546, 0x72);
>   
>       /* i2c8mux ch0 */
> -    /* adc128d818@1f — no model */
> +    /* adc128d818@1f — R-PDB ADC (mode 1: 8 voltage channels) */
> +    anacapa_add_adc128d818(pca954x_i2c_get_bus(i2c_mux, 0), 0x1f, "i2c8:0:1f");
>       /* pca9555@22 */
>       i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
>                               TYPE_PCA9552, 0x22);
> @@ -320,7 +332,8 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
>       i2c_mux = i2c_slave_create_simple(i2c[13], TYPE_PCA9548, 0x70);
>   
>       /* i2c13mux ch3 */
> -    /* adc128d818@1f - no model */
> +    /* adc128d818@1f — MB ADC (mode 1: 8 voltage channels) */
> +    anacapa_add_adc128d818(pca954x_i2c_get_bus(i2c_mux, 3), 0x1f, "i2c13:3:1f");
>   
>       /* i2c13mux ch4 */
>       /* eeprom@51 */
> @@ -350,6 +363,7 @@ static void aspeed_machine_anacapa_class_init(ObjectClass *oc,
>       aspeed_machine_class_init_cpus_defaults(mc);
>   }
>   
> +/* clang-format off */
>   static const TypeInfo aspeed_ast2600_anacapa_types[] = {
>       {
>           .name          = MACHINE_TYPE_NAME("anacapa-bmc"),
> @@ -358,5 +372,6 @@ static const TypeInfo aspeed_ast2600_anacapa_types[] = {
>           .interfaces    = arm_machine_interfaces,
>       }
>   };
> +/* clang-format on */
>   
>   DEFINE_TYPES(aspeed_ast2600_anacapa_types)
> 


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



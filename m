Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CC6CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 13:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU2Ho-0005pd-7q; Mon, 01 Jun 2026 09:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wU2Hg-0005ol-ME; Mon, 01 Jun 2026 09:02:24 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wU2Hf-0003hb-1A; Mon, 01 Jun 2026 09:02:24 -0400
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net [51.68.80.175])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4gTYyh24yrz6L35;
 Mon,  1 Jun 2026 13:02:20 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net. [127.0.0.1])
 by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon,  1 Jun 2026 13:02:20 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.43.16])
 by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4gTYyg6WgYz5vcK;
 Mon,  1 Jun 2026 13:02:19 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.7])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 6C624203041; 
 Mon,  1 Jun 2026 13:02:18 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G005b064b122-a802-4ca4-a5bd-10ad09aad068,
 E35A50153BDE4127F94F88E3CE699B0651996EDF) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <deca1d33-2a68-4033-a26e-091d1dd7d260@kaod.org>
Date: Mon, 1 Jun 2026 15:02:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/10] hw/arm/aspeed_ast1040_evb: Introduce onboard I2C
 device
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260529064243.2064188-1-jamin_lin@aspeedtech.com>
 <20260529064243.2064188-10-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260529064243.2064188-10-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 9429411721596218379
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFp8ny1hmNd97OM8uT7w+Ima7RRb/O6fA9kb5EMDlw1a1krev9U3wEbresaOKqCH+k2txpMfVIsDaRMAikjoxqbc6UpoFUn+/7t9Le36U8Ow85znq7s7AxGsUv/bYSwjH1vWQIjFfQ35Mvj9LXEWEq2epDnecZBzUg85n48FQX2BTiAOJSwBOMLuvLtZdGmUs09FqbLbK+zN/NNNhSrnXPkOklIJ1Q4dqYOMyAGRFdtIdCsvjo/dY65ipFPgvfEclpO+t3OacDnIbrYh9RlXHeVDVLGV0jH+p2UWl5dZKqRJvkL2eAivfwpIjYpxMx4cuG5dEfBSJCLmkl4Svms00rmPh82ic8BV1sq5cqUGJM/3ZY1dF/wJluy8Hd6015LYB6FWsu2l7VVOR1h6xaCXmW1QhNnGP+J3Blbu0bnoTJVc1RlZ4ExVpW+niosOZMOTg8OVCjAWnaLhYYAV15VXkS2hhGUZ9VSFqsH/TXKzyQYIVovKoBdFsYXhciio20ds4QMN2Mp9HERSCnLrzfn2TqFy5kKiJ8V/A8a2d2d024lYMPKAcrNoEIz9/qQwKvSVJy+6/T+XgejVzbwYaAzbT2DLRzC98wLZ0mJ3XsRFZrnLlueI5PA8RMf/6w+XLutTQ45U8NXzoaUA30JxzUFmEIO/aHa+qrVqF24HYGrnMgELA
DKIM-Signature: a=rsa-sha256; bh=OWf3I8IQAN2L5ZVK0vZ88LcZh3i9chkw/62Y/YJaRe4=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1780318940; v=1;
 b=n/9MtM6pbX8DYH/2s6CXoc34pAT/Ei2mDQ/nXBP3mWgiM641Xwz0CdVbee1jUMHkuM+1STlH
 eO3OJ/PAd4NWyi0cQv7iXMwkvRx0akjxfNAqLSdPawatAgh4D9oPe+ifGSze1zfEo5NOLDwpvEK
 Aq+BsD3WXamMs8s+xTQET23US+BC/2Fr+BtCXJwACXHfyYyZBmftO91Qx50OOQ8uEyr357pb1j3
 rtykySexnWctd8gaQuFts3D2e8g6QqQTmzDppT2/v6gACzSdEvaCETp0VwUMthiS9LVctWIcmOa
 Zybp3uPEapCJa/soVNkil+JTPoCIpee+ziHQZvVU9iMMA==
Received-SPF: pass client-ip=46.105.34.251; envelope-from=clg@kaod.org;
 helo=smtpout1.mo528.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/29/26 08:42, Jamin Lin wrote:
> Introduce onboard I2C device initialization for the AST1040
> EVB model.
> 
> This change adds the initial onboard I2C device setup flow
> and instantiates a 24C08 SMBus EEPROM device connected to
> I2C bus 0, matching the current AST1040 EVB hardware design.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast1040_evb.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/hw/arm/aspeed_ast1040_evb.c b/hw/arm/aspeed_ast1040_evb.c
> index 1d9b55247f..392b0d5159 100644
> --- a/hw/arm/aspeed_ast1040_evb.c
> +++ b/hw/arm/aspeed_ast1040_evb.c
> @@ -14,6 +14,7 @@
>   #include "hw/arm/aspeed_soc.h"
>   #include "hw/core/qdev-clock.h"
>   #include "system/system.h"
> +#include "hw/i2c/smbus_eeprom.h"
>   
>   #define AST1040_INTERNAL_FLASH_SIZE (4 * MiB)
>   /* Main SYSCLK frequency in Hz (400MHz) */
> @@ -38,12 +39,28 @@ static void aspeed_bic_machine_init(MachineState *machine)
>       aspeed_connect_serial_hds_to_uarts(bmc);
>       qdev_realize(DEVICE(bmc->soc), NULL, &error_abort);
>   
> +    if (amc->i2c_init) {
> +        amc->i2c_init(bmc);
> +    }
> +
>       armv7m_load_kernel(ARM_CPU(first_cpu),
>                          machine->kernel_filename,
>                          0,
>                          AST1040_INTERNAL_FLASH_SIZE);
>   }
>   
> +static void ast1040_evb_i2c_init(AspeedMachineState *bmc)
> +{
> +    AspeedSoCState *soc = bmc->soc;
> +
> +    /* U10 24C08 connects to SDA/SCL Group 1 by default */
> +    uint8_t *eeprom_buf = g_malloc0(32 * 1024);

32 * KiB

Thanks,

C.


> +    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50, eeprom_buf);
> +
> +    /* U11 LM75 connects to SDA/SCL Group 2 by default */
> +    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4d);
> +}
> +
>   static void aspeed_machine_ast1040_evb_class_init(ObjectClass *oc,
>                                                     const void *data)
>   {
> @@ -55,6 +72,7 @@ static void aspeed_machine_ast1040_evb_class_init(ObjectClass *oc,
>       amc->hw_strap1 = 0;
>       amc->hw_strap2 = 0;
>       mc->init = aspeed_bic_machine_init;
> +    amc->i2c_init = ast1040_evb_i2c_init;
>       mc->default_ram_size = 0;
>       amc->macs_mask = 0;
>       amc->uart_default = ASPEED_DEV_UART12;



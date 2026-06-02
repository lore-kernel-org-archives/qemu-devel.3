Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC27C5DF71
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 06:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUIiW-0006hW-Ad; Tue, 02 Jun 2026 02:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wUIi2-00061j-V0
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 02:34:43 -0400
Received: from smtpout10.mo536.mail-out.ovh.net ([51.210.91.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wUIi1-0004l6-E6
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 02:34:42 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [51.255.22.22])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4gV1Jt4H0Dz827h;
 Tue,  2 Jun 2026 06:34:38 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue,  2 Jun 2026 06:34:38 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.37.33])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4gV1Jt30Znz7vfP;
 Tue,  2 Jun 2026 06:34:38 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.2])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 26DAD12E305E;
 Tue,  2 Jun 2026 06:34:37 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-114S0085e620c05-f064-4c90-8d86-2c6b3f2816bb,
 E738715FB773EF828F8B902CE3F45C10C1B236B1) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <904f30ab-14ed-41e8-8875-42179c444b56@kaod.org>
Date: Tue, 2 Jun 2026 08:34:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] hw/arm/aspeed_ast1040_evb: Introduce onboard I2C
 device
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260602052827.1535299-1-jamin_lin@aspeedtech.com>
 <20260602052827.1535299-10-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260602052827.1535299-10-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 8754434728548740107
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGbUxDtm0LlJfuMZW4FGwKf0YvPeZl+LMuyhANbUieSobq/xs7MxFyCCXkDbOwejshX8xPriEryFQ6mSViJeM4jmXbMAA9LryL137eatNq4/rzz0WIDbvZAhixdo7fH6IKcGpTuU+Vy119cYEUU/n/OziL18aXVPEW2bUOqeuvYqFauyPBYqeBH4fa5+/yNUwvGLJ5/+u7Tkx4okQ4oVk5n9TxLIvuLsb3JtN2EcgEaOuw++ttlrUTz9i+yU5Dx5LtMxPEzoJ6+RUWqEmhu4gCRFwEqdu3b/f3GFcqbAUppH8Gtdrh+0b0Eb1zMMehB8RidlQdgVwSUg2vtnDiwEQXGgAjPOR8VXUX/fhytRQn1yG4jD48ms9LiCEU8PwEvfCqe46VbSgf1ANyVdx1RhhJhanhO5+FBSHqtNg6g9ysK1tXBJbq85FdwwnL4a1HNtXEIafaBD5/6LjuzeVRXH8s6GHGtGF3KGDaSqJY+0mWhD7egTb6P0+DptrGh5bwmvUxmVTQxTjEw/LOJ87FHs7OSME3ytrY92XsZMjZpVyA5frHqPKAFTJq1iGUsSMcBd/dKhYXZddpw1/LW76Cv6QYngHt80fRAoRACM8kAn1C1i6mVwdiT5nVCsS2jzMIzCG6bcwhjfQGpj0GhsnrpaMAq6qzlE3AGPJQFOXTNFLXvAg
DKIM-Signature: a=rsa-sha256; bh=GVCInvhL3HQgbnY/IlNhszuV16Sx6VFt0bpT/zMYKxw=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1780382079; v=1;
 b=LwD0Tl/elwYYv+r7TG5TsSeIfmm7xd5TtcIbTZ3uA8tDWSbFqXhKmii9++02sQrm+YVWwWNo
 mKd8EESk7Yw2JOUB+V2o4Y4F+CIa5lmaXHT4mA53pDHJe8nlSukQXFB5PQ56jTwFfF8O3Ahkbge
 VyuCIgD1yZ9BiKf6Za2WgRJAGFZF+qCL2x5GXUxghTvTfqAl+JvnmGG0LvEd/1Dk6IbqxHZSGIt
 Y2hZlqUPF6sX7GEH1Yt2wgRC25G0drizTmsZCCKYGqyCIxAeULvHzOKQKtIPPheg/SSAY7jX4bx
 4wfLQJrJ4Pyy5FsGQ01Oa2lX90mMrqrWIVg3Sse2NCmnA==
Received-SPF: pass client-ip=51.210.91.19; envelope-from=clg@kaod.org;
 helo=smtpout10.mo536.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/2/26 07:28, Jamin Lin wrote:
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
> index 1d9b55247f..66f08ccbe6 100644
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
> +    uint8_t *eeprom_buf = g_malloc0(32 * KiB);


The smbus-eeprom device's internal buffer is 256 bytes.

We have been copy/pasting this 32 * KiB size for a while it seems but
SMBUS_EEPROM_SIZE would be enough.

Anyhow,


Reviewed-by: Cédric Le Goater <clg@redhat.com>

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



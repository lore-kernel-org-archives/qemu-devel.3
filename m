Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD9FC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 14:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh9NL-0001RD-MB; Mon, 04 Mar 2024 09:33:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=daq9=KK=kaod.org=clg@ozlabs.org>)
 id 1rh9NF-0001PS-1a; Mon, 04 Mar 2024 09:33:02 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=daq9=KK=kaod.org=clg@ozlabs.org>)
 id 1rh9N1-00045P-1g; Mon, 04 Mar 2024 09:32:56 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TpLks4CTPz4wnq;
 Tue,  5 Mar 2024 01:32:37 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TpLkp2mYcz4wcg;
 Tue,  5 Mar 2024 01:32:31 +1100 (AEDT)
Message-ID: <10fc74b2-7bab-4c97-9e55-8e73a38b7440@kaod.org>
Date: Mon, 4 Mar 2024 15:32:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] aspeed/wdt: Add AST2700 support
Content-Language: en-US, fr
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240304092934.1953198-1-jamin_lin@aspeedtech.com>
 <20240304092934.1953198-2-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240304092934.1953198-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=daq9=KK=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hello Jamin,

On 3/4/24 10:29, Jamin Lin wrote:
> AST2700 wdt controller is similiar to AST2600's wdt, but
> the AST2700 has 8 watchdogs, and they each have a 0x80 of registers.

... they each have 0x80 registers.

> Introduce ast2700 object class and increse the number of regs(offset) of

.. increase ...

> ast2700 model.
> 
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   hw/watchdog/wdt_aspeed.c         | 24 ++++++++++++++++++++++++
>   include/hw/watchdog/wdt_aspeed.h |  3 ++-
>   2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
> index d70b656f8e..75685c5647 100644
> --- a/hw/watchdog/wdt_aspeed.c
> +++ b/hw/watchdog/wdt_aspeed.c
> @@ -422,12 +422,36 @@ static const TypeInfo aspeed_1030_wdt_info = {
>       .class_init = aspeed_1030_wdt_class_init,
>   };
>   
> +static void aspeed_2700_wdt_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    AspeedWDTClass *awc = ASPEED_WDT_CLASS(klass);
> +
> +    dc->desc = "ASPEED 2700 Watchdog Controller";
> +    awc->iosize = 0x80;
> +    awc->ext_pulse_width_mask = 0xfffff; /* TODO */
> +    awc->reset_ctrl_reg = AST2600_SCU_RESET_CONTROL1;
> +    awc->reset_pulse = aspeed_2500_wdt_reset_pulse;
> +    awc->wdt_reload = aspeed_wdt_reload_1mhz;
> +    awc->sanitize_ctrl = aspeed_2600_sanitize_ctrl;
> +    awc->default_status = 0x014FB180;
> +    awc->default_reload_value = 0x014FB180;
> +}
> +
> +static const TypeInfo aspeed_2700_wdt_info = {
> +    .name = TYPE_ASPEED_2700_WDT,
> +    .parent = TYPE_ASPEED_WDT,
> +    .instance_size = sizeof(AspeedWDTState),
> +    .class_init = aspeed_2700_wdt_class_init,
> +};
> +
>   static void wdt_aspeed_register_types(void)
>   {
>       type_register_static(&aspeed_wdt_info);
>       type_register_static(&aspeed_2400_wdt_info);
>       type_register_static(&aspeed_2500_wdt_info);
>       type_register_static(&aspeed_2600_wdt_info);
> +    type_register_static(&aspeed_2700_wdt_info);
>       type_register_static(&aspeed_1030_wdt_info);
>   }
>   
> diff --git a/include/hw/watchdog/wdt_aspeed.h b/include/hw/watchdog/wdt_aspeed.h
> index e90ef86651..830b0a7936 100644
> --- a/include/hw/watchdog/wdt_aspeed.h
> +++ b/include/hw/watchdog/wdt_aspeed.h
> @@ -19,9 +19,10 @@ OBJECT_DECLARE_TYPE(AspeedWDTState, AspeedWDTClass, ASPEED_WDT)
>   #define TYPE_ASPEED_2400_WDT TYPE_ASPEED_WDT "-ast2400"
>   #define TYPE_ASPEED_2500_WDT TYPE_ASPEED_WDT "-ast2500"
>   #define TYPE_ASPEED_2600_WDT TYPE_ASPEED_WDT "-ast2600"
> +#define TYPE_ASPEED_2700_WDT TYPE_ASPEED_WDT "-ast2700"
>   #define TYPE_ASPEED_1030_WDT TYPE_ASPEED_WDT "-ast1030"
>   
> -#define ASPEED_WDT_REGS_MAX        (0x30 / 4)
> +#define ASPEED_WDT_REGS_MAX        (0x80 / 4)
>   
>   struct AspeedWDTState {
>       /*< private >*/



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103C7CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 16:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIUZc-00061y-HJ; Mon, 10 Nov 2025 11:16:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vIUZY-0005xD-4r
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 11:16:52 -0500
Received: from 4.mo548.mail-out.ovh.net ([188.165.42.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vIUZV-00064c-NP
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 11:16:51 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.37.24])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4d4vtl2YC9z5ybb;
 Mon, 10 Nov 2025 16:16:47 +0000 (UTC)
Received: from kaod.org (37.59.142.106) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Mon, 10 Nov
 2025 17:16:46 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006c58d239b-39ac-4ae2-915d-711c331bbd32,
 2CC8F654BF9A736B588295E2BFA8A60E013487DB) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <3eff381c-a36b-48bd-89d3-4dcc4be5c39c@kaod.org>
Date: Mon, 10 Nov 2025 17:16:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/17] hw/arm/aspeed: Model AST1700 PWM block as
 unimplemented device
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>
References: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
 <20251105035859.3709907-18-kane_chen@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251105035859.3709907-18-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG7EX2.mxp5.local (172.16.2.62) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: f2f81102-ab7a-455e-823a-f72e21b9fc6a
X-Ovh-Tracer-Id: 1148136433288448946
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEETKDIRgefPLc/4UFXqjG33wuDJY6jdZWvdSTxCZgy6mCkZ+u/M8pSKt0oWr06dapBtxNp6o+pDqWuIKBLOzCJutyBpIGsLk/P9Y9AC4DIRQ0s3xm81uO26WY0oddK8bIbPgBEw2oIs1PIhyxKiL4OJHZC5Kj5VU95ryiSTs6RlNbvq3pMzJXPrBBZE6bx28HEVbW+918F97G/YZKUMUviO186SX+o9G9F4zm/MUzHTXvHDvzSktTH8z2iw/teJpreoUbkiepOAu7gENIZWpKTgc/fvOU2cImUFQ9XWU/KB/WporhxKYo+8jVNiogsImLOj1HYy45j9P+J4VIOD9teCAe6NNF/kEwM/U16O+i6hrlARFgE5hgTgA4zuM6+LgYAjJOzLbQqJDEs9mqMh0WgYHXjvKIdLpMK4L8QhllOMpTDxY8d6cx5iMyrYtQw5PlAYUXS+/9mpoLygoEttew8SCoOKBArVJxbJ38XAEM0WLrCCT7wFqBN3tDJ9Ckh3jyLKnCqi/lpOyVr1KlWckrSBkrHM+Nvon1B1gmmYyFsXicvIEiaLeriwUpfj02whitU5QRhAbM+mBqTTpNbP98GD9dY9tuktA6sHxVNGDL+awHOK8Xw3jRLdJ3Q8sjZksRLIwajHyXNt/1cVBgf6cfPTiRQnn3uZBmDCF1gauEgLQ
DKIM-Signature: a=rsa-sha256; bh=sWROq5p1CFqvuNGYNDXzfttPs3417kfwAXK2WNAiikI=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1762791407; v=1;
 b=KhxU7wDqLdMh+OTfiLUZ9niFQEqk7XokoyWaqM8bJX2rud5eYq8GYRD1p/pcAThKBdJn8x5c
 CDoQJW0l3Vy/sx6i2rZrks9jtz8hFmrHrEiMxMuJCoCMTOKXNrmJP7EvhfkQL0gSLYhrZ2h6bP8
 PUqvyO87tgNe2FCBE59duEndDU8kAy460XDO1v6wwyRwvJ1U8kE5vJhd6Th84SZdLf4Kjebf/d2
 MHt1OtzNBLPdHLgGgIJwok/w3esUcADOI1BPp4E6Ejm8+3W7RUzaa73ZczGJcITxwxEDea7Jl7c
 GjStCOcXgq8A1inWonFDWQioEsPo+vivY0WhW9KNgyEQQ==
Received-SPF: pass client-ip=188.165.42.229; envelope-from=clg@kaod.org;
 helo=4.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 11/5/25 04:58, Kane Chen wrote:
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> 
> AST1700 includes an PWM block, but QEMU has no functional model for
> aspeed product yet. 

We could start with a dummy PWM model :

   https://github.com/legoater/qemu/commit/9d77c84b04c2d9ae5685b3ccb5c434873666ca78

Feel free to add to your series.

Thanks,

C.



Expose it as an unimplemented device so the
> address space is reserved and the missing functionality is explicit
> to users/guests.
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>   include/hw/misc/aspeed_ast1700.h |  1 +
>   hw/misc/aspeed_ast1700.c         | 16 ++++++++++++++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/include/hw/misc/aspeed_ast1700.h b/include/hw/misc/aspeed_ast1700.h
> index 8ada3a7775..9d432a7db0 100644
> --- a/include/hw/misc/aspeed_ast1700.h
> +++ b/include/hw/misc/aspeed_ast1700.h
> @@ -45,6 +45,7 @@ struct AspeedAST1700SoCState {
>   
>       UnimplementedDeviceState i3c;
>       UnimplementedDeviceState sgpiom;
> +    UnimplementedDeviceState pwm;
>   };
>   
>   #endif /* ASPEED_AST1700_H */
> diff --git a/hw/misc/aspeed_ast1700.c b/hw/misc/aspeed_ast1700.c
> index 66a5f21d27..3d9a920a7a 100644
> --- a/hw/misc/aspeed_ast1700.c
> +++ b/hw/misc/aspeed_ast1700.c
> @@ -20,9 +20,11 @@
>   #define AST1700_SOC_SRAM_SIZE        0x00040000
>   #define AST1700_SOC_I3C_SIZE         0x00010000
>   #define AST1700_SOC_SGPIOM_SIZE      0x00002000
> +#define AST1700_SOC_PWM_SIZE         0x00000200
>   
>   enum {
>       ASPEED_AST1700_DEV_SPI0,
> +    ASPEED_AST1700_DEV_PWM,
>       ASPEED_AST1700_DEV_SRAM,
>       ASPEED_AST1700_DEV_ADC,
>       ASPEED_AST1700_DEV_SCU,
> @@ -38,6 +40,7 @@ enum {
>   
>   static const hwaddr aspeed_ast1700_io_memmap[] = {
>       [ASPEED_AST1700_DEV_SPI0]      =  0x00030000,
> +    [ASPEED_AST1700_DEV_PWM]       =  0x000C0000,
>       [ASPEED_AST1700_DEV_SRAM]      =  0x00BC0000,
>       [ASPEED_AST1700_DEV_ADC]       =  0x00C00000,
>       [ASPEED_AST1700_DEV_SCU]       =  0x00C02000,
> @@ -174,6 +177,15 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
>                           sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->sgpiom), 0),
>                           -1000);
>   
> +    /* PWM */
> +    qdev_prop_set_string(DEVICE(&s->pwm), "name", "ioexp-pwm");
> +    qdev_prop_set_uint64(DEVICE(&s->pwm), "size", AST1700_SOC_PWM_SIZE);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->pwm), errp);
> +    memory_region_add_subregion_overlap(&s->iomem,
> +                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_PWM],
> +                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pwm), 0),
> +                        -1000);
> +
>       /* WDT */
>       for (i = 0; i < AST1700_WDT_NUM; i++) {
>           AspeedWDTClass *awc = ASPEED_WDT_GET_CLASS(&s->wdt[i]);
> @@ -241,6 +253,10 @@ static void aspeed_ast1700_instance_init(Object *obj)
>       object_initialize_child(obj, "ioexp-sgpiom[*]", &s->sgpiom,
>                               TYPE_UNIMPLEMENTED_DEVICE);
>   
> +    /* PWM */
> +    object_initialize_child(obj, "ioexp-pwm", &s->pwm,
> +                            TYPE_UNIMPLEMENTED_DEVICE);
> +
>       /* WDT */
>       for (i = 0; i < AST1700_WDT_NUM; i++) {
>           snprintf(typename, sizeof(typename), "aspeed.wdt-%s", socname);



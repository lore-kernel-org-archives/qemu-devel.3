Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131CCCD6E64
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 12:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU2Cy-0004I1-1z; Mon, 01 Jun 2026 08:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wU2Cw-0004Hc-6R; Mon, 01 Jun 2026 08:57:30 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wU2Ct-00013v-Qq; Mon, 01 Jun 2026 08:57:29 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [51.68.94.138])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4gTYs0356fz6KrL;
 Mon,  1 Jun 2026 12:57:24 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon,  1 Jun 2026 12:57:24 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.101.155])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gTYs00tyYz7tjH; Mon,  1 Jun 2026 12:57:24 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.0])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id B0454940D5B; 
 Mon,  1 Jun 2026 12:57:22 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002cdf8dd89-28d0-4df6-ad58-84965e23a49c,
 E35A50153BDE4127F94F88E3CE699B0651996EDF) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <1e706d5e-3124-47ee-9f00-d06ea1d4dbaa@kaod.org>
Date: Mon, 1 Jun 2026 14:57:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/10] hw/i2c/aspeed_i2c: Introduce AST1040 I2C model
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260529064243.2064188-1-jamin_lin@aspeedtech.com>
 <20260529064243.2064188-8-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260529064243.2064188-8-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 9346095127912819723
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFHPcj6rhDse6TIehFj4YkDl1Iu6lpfrN8zjDl3wxGkYhcCzcj8JDML7dfyctwzQ0yWqyIOojaYM5QLda2FCwZO6sq3rszhucZCSaIkvCHXdu2yHPxeYGJuNUFD5gTTFFCJUQAVGZbf8IqWelPPDODTg3DMFfRKg9acvFOLfNvZVi1mBMZ646I2csb2/JsESpo5BxQTPDITMLVyuYaPwbN6q4ec792eeT8xF2GBOWnqABBTp4G2dF2Q53wid/pMzmpt3WVNhkkdQpkX6rCCa0kVUBLN1Nu09w1sBzmFo88wHW8gPH8H+nZf6y5+yb1E2vCk1CwJAy7nIfrWP1BYnVHXUnDwq7j1AWYptUvDVQmTMi+H502ei0O91Exb7jb8Kc+HMrKUissqZDONXSZZx8RoV3GHZ8tAwZUvNDN96VhAagEhVwE4eGYiZvMJfvj/wjs4QzsPHJlE5fVaHE1J3QB0MmRJxU9CzRVxH8WVcj1JTCcJ7CjnnRaInY2PWdz/7BRf8sKcVTFhXRRa2yvzlJ5HVXrx3ABGiiZwUBkJ0CEtf260M8S7b1PF7DMsZTbK8QTsDbzBj0KJl4KVazhUbcbPfl8vzmGt+ljZNrbbASQjAkHIc6ug9n/p2i6t2gpygrDG2iRZUHxWdT+5RUX3rhc4/Q9qUtihsCRgD4cEUE5vZw
DKIM-Signature: a=rsa-sha256; bh=CBbS/3DWgIgAErpMA3VVp+Qy/PWTWmIaWynY7XYykb4=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1780318644; v=1;
 b=Xdc4gvgam9lbpwU/xShWaEr38Mq0Z0pReJFcUcE3oode1lCSUOGxcP1tnwGSKudUfI+nxTou
 zLgou8kY7feCFDkhaBtw2u25uYWcX4GTFQs/w6JgPV9cE7K3ad/3j0x//BZmArgQO7mObKkKv9Z
 07nmFJXwPGQHRiVbihtB1Xfd4axCgIURWdZ3GAxSvLjWEXtynPrSxMfd3SevNcOyOXH+M6Dob7U
 Dr9zDhV7lqDoAdXj1MFkHP9KP0xOCEAs6oHVNfHdLUe63uUc6vWyNodMLyYGEcc0eqT4wpROg6d
 S0JFHVOWmxefOTFhRNW5krGwYKWzZQeEQr9uKRCx2GQow==
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
> Introduce the AST1040 I2C controller model.
> 
> The AST1040 I2C controller is compatible with the AST2700 I2C controller,
> including DMA support and the 64-bit DMA address registers. Set has_dma64 so
> firmware can access the high address register and program it to zero, as the
> CM4 CPU only supports 32-bit addressing.
> 
> Since AST1040 has 16MB HyperRAM, limit the DMA low address mask to
> 0x00ffffff.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/i2c/aspeed_i2c.h |  1 +
>   hw/i2c/aspeed_i2c.c         | 29 +++++++++++++++++++++++++++++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
> index b2e4d2fb9d..156998e7c1 100644
> --- a/include/hw/i2c/aspeed_i2c.h
> +++ b/include/hw/i2c/aspeed_i2c.h
> @@ -30,6 +30,7 @@
>   #define TYPE_ASPEED_2500_I2C TYPE_ASPEED_I2C "-ast2500"
>   #define TYPE_ASPEED_2600_I2C TYPE_ASPEED_I2C "-ast2600"
>   #define TYPE_ASPEED_1030_I2C TYPE_ASPEED_I2C "-ast1030"
> +#define TYPE_ASPEED_1040_I2C TYPE_ASPEED_I2C "-ast1040"
>   #define TYPE_ASPEED_2700_I2C TYPE_ASPEED_I2C "-ast2700"
>   OBJECT_DECLARE_TYPE(AspeedI2CState, AspeedI2CClass, ASPEED_I2C)
>   
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index 5be6fefc4d..8418a0a686 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -1702,6 +1702,34 @@ static const TypeInfo aspeed_1030_i2c_info = {
>       .class_init = aspeed_1030_i2c_class_init,
>   };
>   
> +static void aspeed_1040_i2c_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    AspeedI2CClass *aic = ASPEED_I2C_CLASS(klass);
> +
> +    dc->desc = "ASPEED 1040 I2C Controller";
> +
> +    aic->num_busses = 16;
> +    aic->reg_size = 0xa0;
> +    aic->reg_gap_size = 0x60;
> +    aic->gap = -1; /* no gap */
> +    aic->bus_get_irq = aspeed_2600_i2c_bus_get_irq;
> +    aic->pool_size = 0x40;
> +    aic->pool_gap_size = 0xc0;
> +    aic->pool_base = 0x1c0;
> +    aic->bus_pool_base = aspeed_2500_i2c_bus_pool_base;
> +    aic->has_dma = true;
> +    aic->mem_size = 0x2000;
> +    aic->has_dma64 = true;
> +    aic->dma_addr_lo_mask = 0x00ffffff;
> +}

Above constants are similar to TYPE_ASPEED_2700_I2C. It's worth a comment.

> +
> +static const TypeInfo aspeed_1040_i2c_info = {
> +    .name = TYPE_ASPEED_1040_I2C,
> +    .parent = TYPE_ASPEED_I2C,
> +    .class_init = aspeed_1040_i2c_class_init,
> +};
> +
>   static void aspeed_2700_i2c_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -1739,6 +1767,7 @@ static void aspeed_i2c_register_types(void)
>       type_register_static(&aspeed_2500_i2c_info);
>       type_register_static(&aspeed_2600_i2c_info);
>       type_register_static(&aspeed_1030_i2c_info);
> +    type_register_static(&aspeed_1040_i2c_info);
>       type_register_static(&aspeed_2700_i2c_info);
>   }
>   

the type info will need an update bc of

   https://lore.kernel.org/qemu-devel/20260601024959.2347639-1-jamin_lin@aspeedtech.com/

Anyhow,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



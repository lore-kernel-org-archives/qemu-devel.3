Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496ADE7544E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 10:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYMJZ-0005vQ-9p; Wed, 24 Dec 2025 05:41:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vYMJU-0005um-Vs
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 05:41:54 -0500
Received: from 8.mo548.mail-out.ovh.net ([46.105.45.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vYMJS-0006KV-OY
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 05:41:52 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.37.215])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4dbpMt5gd7z6N0d;
 Wed, 24 Dec 2025 10:41:46 +0000 (UTC)
Received: from DAG3EX1.mxp5.local (172.16.2.21) by DAG7EX1.mxp5.local
 (172.16.2.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Wed, 24 Dec
 2025 11:41:46 +0100
Received: from kaod.org (37.59.142.96) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Wed, 24 Dec
 2025 11:41:45 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R00191539da5-a61b-4979-946b-6b1909226968,
 9377EA31308664D21D54FC0151EBFE1D7AAB8817) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <98d22733-ef05-430c-8b4a-4a227f9b3f98@kaod.org>
Date: Wed, 24 Dec 2025 11:41:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/19] hw/arm/aspeed: Attach LTPI controller to AST1700
 model
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <nabihestefan@google.com>
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-8-kane_chen@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251224014203.756264-8-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: 044ab3fe-5ea7-41ba-8142-286b6e4c116f
X-Ovh-Tracer-Id: 14081067185795271669
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFzfJipwO86VMdoYmj5Tsvs/pIWSm/DPyoFt8G9stLqhaSeYq6H5wxlLoyjZrIXahde62TFUiMDazrfTtDlsgD4oakbcMiFYIASlc4Et4DNgCoGmhplwW+wu7VbkwebJIHtcrPadNpsSmvTT1agg//rIhZ5JUEeL174mDSzjr5rNHdlkoQucYu3L4LhRhF6kLrj5WVKYAHiGa8eu6UQlirzALR4EEhX9/knRPF2QKSwcm4C6W1iIDR30QcOufDeWTEPQtyvQVNdwtLg70Wm0nyzX6QlwuUYpVfNXTWl1PrU/vHVRLPdjidTIZ5G6FMY6V3KU1RYNRaaKRLQ8i+PRppVIqC5Khzop2AdlxBXmi8eLn/FU4TCvWMEZG/03M2w9epEYcC/A27IOkAYw++K1YngKq2Gjdz6LuXChPxpg+g85hGs9GwS06Rba5bJvEi8T09Dsk5XyarUNuZKhiS7fqoAcOgvUASwpZlhYzPwV77Y0z/137eZkDtAaRAyz75eVXNC8ZeoYtI7UgAtZ5zsdDRxhD5RW0r8Wy2cx46lFqhNnO7PGci+VUJOHvWEqmbcp51Y07nlsoRbqxfXKAvsXca+qA5fceyNzMFH8DzD45c5UcJfFO3B4uzxHGP8OyubHodf7n1Iv6gE8VU/adBiDJ9Ba/ldNUxKFb0vbpXffphDzw
DKIM-Signature: a=rsa-sha256; bh=KewGfz9dfGxTBO4BMwOqRI+D0VSlecW1nTq26dM+u4s=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1766572907; v=1;
 b=qpQNN68fMfPCHioBxBzN2O7hUPAbVAnGLD1lvIA/Zx9C9UefXTj5D8JQ8n7neood4eqynWAj
 sqi2hDsJu/6Uoi8qpWRjqHh351E30iXO4TB+cwmijXqkB24wVgtqKLj0/qq/Wpj9DoFSNsTbjjm
 7RqCNoc+Smj3f1sEQ24lGO8X0UkCubYD1Jmbj9YalJrRj/7HVXtbGDxcHja/GAF/eZ57NYhCOPP
 n0iLFxUv6dv6Xd5pqvx1HjlKElnUD8KWcXw2R31aXqdL/tk/VlpVW6bQ42g7l8AVRVvd4vhOT/Q
 8hMuWnwpIX4cag7XLYRrIeUY/oWpvomSrvB1XS/MIbSfA==
Received-SPF: pass client-ip=46.105.45.231; envelope-from=clg@kaod.org;
 helo=8.mo548.mail-out.ovh.net
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

On 12/24/25 02:41, Kane Chen via wrote:
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> 
> Connect the LTPI controller to the AST1700 model by mapping its MMIO
> region.
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>


> ---
>   include/hw/arm/aspeed_ast1700.h |  3 +++
>   hw/arm/aspeed_ast1700.c         | 27 +++++++++++++++++++++++++++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1700.h
> index 2a95ebfe89..b9ee4952d0 100644
> --- a/include/hw/arm/aspeed_ast1700.h
> +++ b/include/hw/arm/aspeed_ast1700.h
> @@ -9,6 +9,7 @@
>   #define ASPEED_AST1700_H
>   
>   #include "hw/sysbus.h"
> +#include "hw/misc/aspeed_ltpi.h"
>   
>   #define TYPE_ASPEED_AST1700 "aspeed.ast1700"
>   
> @@ -18,6 +19,8 @@ struct AspeedAST1700SoCState {
>       SysBusDevice parent_obj;
>   
>       MemoryRegion iomem;
> +
> +    AspeedLTPIState ltpi;
>   };
>   
>   #endif /* ASPEED_AST1700_H */
> diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
> index bb6ca2ce9e..eeb586102f 100644
> --- a/hw/arm/aspeed_ast1700.c
> +++ b/hw/arm/aspeed_ast1700.c
> @@ -14,6 +14,14 @@
>   
>   #define AST2700_SOC_LTPI_SIZE        0x01000000
>   
> +enum {
> +    ASPEED_AST1700_DEV_LTPI_CTRL,
> +};
> +
> +static const hwaddr aspeed_ast1700_io_memmap[] = {
> +    [ASPEED_AST1700_DEV_LTPI_CTRL] =  0x00C34000,
> +};
> +
>   static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
>   {
>       AspeedAST1700SoCState *s = ASPEED_AST1700(dev);
> @@ -23,8 +31,26 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
>       memory_region_init(&s->iomem, OBJECT(s), TYPE_ASPEED_AST1700,
>                          AST2700_SOC_LTPI_SIZE);
>       sysbus_init_mmio(sbd, &s->iomem);
> +
> +    /* LTPI controller */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {
> +        return;
> +    }
> +    memory_region_add_subregion(&s->iomem,
> +                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_LTPI_CTRL],
> +                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->ltpi), 0));
>   }
>   
> +static void aspeed_ast1700_instance_init(Object *obj)
> +{
> +    AspeedAST1700SoCState *s = ASPEED_AST1700(obj);
> +
> +    /* LTPI controller */
> +    object_initialize_child(obj, "ltpi-ctrl",
> +                            &s->ltpi, TYPE_ASPEED_LTPI);
> +
> +    return;
> +}
>   static void aspeed_ast1700_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -37,6 +63,7 @@ static const TypeInfo aspeed_ast1700_info = {
>       .parent        = TYPE_SYS_BUS_DEVICE,
>       .instance_size = sizeof(AspeedAST1700SoCState),
>       .class_init    = aspeed_ast1700_class_init,
> +    .instance_init = aspeed_ast1700_instance_init,
>   };
>   
>   static void aspeed_ast1700_register_types(void)



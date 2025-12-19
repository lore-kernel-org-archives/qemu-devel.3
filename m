Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC6BD7879F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 17:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWduz-0002R3-6t; Fri, 19 Dec 2025 12:05:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vWduf-0002Kk-Av; Fri, 19 Dec 2025 12:05:11 -0500
Received: from 7.mo552.mail-out.ovh.net ([188.165.59.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vWduc-0007uT-Gn; Fri, 19 Dec 2025 12:05:09 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.254.179])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4dXv6Q0RrGz5yNx;
 Fri, 19 Dec 2025 17:05:02 +0000 (UTC)
Received: from kaod.org (37.59.142.98) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 19 Dec
 2025 18:05:01 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002c3642f3f-6234-4304-8c5a-df1dc7368d99,
 13AF5B8175AA3308F51DC8C03696883D036152F7) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <8f02ab07-d936-4528-a1d2-aebada40b639@kaod.org>
Date: Fri, 19 Dec 2025 18:05:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v3 09/18] hw/arm/aspeed: Attach SRAM device to
 AST1700 model
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>
References: <20251208074436.1871180-1-kane_chen@aspeedtech.com>
 <20251208074436.1871180-10-kane_chen@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251208074436.1871180-10-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: 5c3a6513-b694-4e72-ba03-f28603dd42a8
X-Ovh-Tracer-Id: 9636858779595279282
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGHo5DNLkvEtf89+Zf74t4xUyNZKrQjyIxcA9vLxs6rihyxKBSREpm9CHPUpRtXXqteoHnZqTw07uqp0SdIzI92txXhfQMfVpbNRkD+ntAEq+ivbgsd7FMNNbZElWQu7QTV8HF3Y14vzls3fdLkV9wnH1YkOIKhA3Fx3I8TGs78EcGU4nnjMwKTiizz4oh6uRLFH1fWI7Gw21peGR84KcGhF76cMk2McYPsBo/jTPkvBWmyWaXH3fiZ7qGENdGy/iKM02qXuvoq9GryChHboc4j6wHr7W8FJkyTh04Mk3h5gOR5s+XnZhFevZxFq0J6QUzr/eQpW83a2A88ziR/mJ9/SeCYEn5kcDoPJYSeVSuXr0Xnzbh6dK+Okm2XdMH8MCE/g4Rd8oBd8yx8vLsPUly3Meaic6Xw4Xfn1md/oiTFDz27Zcsx56xBGCM3tXZ71kSpWJ2n7351rwUEOjZaSkVgEUyipb2JKK28h5HB6oXTJyG9zUmpNTiP8JnS5/JxeBOt7BuFcCB/5kNjmE/j1ht3hhUN5JaVr0oRwAoQxw0+Z0x0aEn2xSiL+JO2CEBA6HzJ3PjAAdX4O6FBoU1vZAN2QBIk9v2fO3jHjKpY9kNEygkbMX04pc4ep96Kc7fye1vqfEitVmj2qlFX/IP9F1BGktAZ51dxdialZiieuB6utQ
DKIM-Signature: a=rsa-sha256; bh=sDzol6wg/E467ZKR3d222WUDBXhbG4tp5VkjAbMTpHk=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1766163902; v=1;
 b=aVWiP7TjsezaGluv/PZ24BDAonJP9iEfgQY6cLCqjNjoNLdkVWCPmZHKfjp7tjT8yGLYfviE
 TqXnvpqaXmXOZ3VQgCliQQk8mCq5a+EyMAXS3OSn60owHCej/gA80EdrzZ/ppTkwoBQhyTRUeMB
 fpC7bk6FdN9l1ASIWgrsJRf90DtN6wTMN2JSaoKfbijmJT/OE9+ca/cmY4d5xLN1nEi/PBYNRT1
 9K5MIbe7UOps0Q8UioCOfWBwHiRamY/TjEwxqEZEt5tAbuebTe3k0Qr37mt+bo1joNhgrAKyp0l
 bkk3sjC37qzdCkToaP/66gFdXpcCV9V20mnxHRi+GpL6g==
Received-SPF: pass client-ip=188.165.59.253; envelope-from=clg@kaod.org;
 helo=7.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/8/25 08:44, Kane Chen wrote:
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> 
> Map the SRAM device to AST1700 model
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_ast1700.h |  2 ++
>   hw/arm/aspeed_ast1700.c         | 17 +++++++++++++++++
>   hw/arm/aspeed_ast27x0.c         |  1 +
>   3 files changed, 20 insertions(+)




Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> 
> diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1700.h
> index a0d6b3ae44..23588f7a81 100644
> --- a/include/hw/arm/aspeed_ast1700.h
> +++ b/include/hw/arm/aspeed_ast1700.h
> @@ -20,9 +20,11 @@ struct AspeedAST1700SoCState {
>       SysBusDevice parent_obj;
>   
>       MemoryRegion iomem;
> +    uint8_t board_idx;
>   
>       AspeedLTPIState ltpi;
>       SerialMM uart;
> +    MemoryRegion sram;
>   };
>   
>   #endif /* ASPEED_AST1700_H */
> diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
> index f88052ec8a..8e93a8857a 100644
> --- a/hw/arm/aspeed_ast1700.c
> +++ b/hw/arm/aspeed_ast1700.c
> @@ -14,13 +14,16 @@
>   #include "hw/arm/aspeed_ast1700.h"
>   
>   #define AST2700_SOC_LTPI_SIZE        0x01000000
> +#define AST1700_SOC_SRAM_SIZE        0x00040000
>   
>   enum {
> +    ASPEED_AST1700_DEV_SRAM,
>       ASPEED_AST1700_DEV_UART12,
>       ASPEED_AST1700_DEV_LTPI_CTRL,
>   };
>   
>   static const hwaddr aspeed_ast1700_io_memmap[] = {
> +    [ASPEED_AST1700_DEV_SRAM]      =  0x00BC0000,
>       [ASPEED_AST1700_DEV_UART12]    =  0x00C33B00,
>       [ASPEED_AST1700_DEV_LTPI_CTRL] =  0x00C34000,
>   };
> @@ -29,12 +32,21 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
>   {
>       AspeedAST1700SoCState *s = ASPEED_AST1700(dev);
>       SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    char dev_name[32];
>   
>       /* Occupy memory space for all controllers in AST1700 */
>       memory_region_init(&s->iomem, OBJECT(s), TYPE_ASPEED_AST1700,
>                          AST2700_SOC_LTPI_SIZE);
>       sysbus_init_mmio(sbd, &s->iomem);
>   
> +    /* SRAM */
> +    snprintf(dev_name, sizeof(dev_name), "aspeed.ioexp-sram.%d", s->board_idx);
> +    memory_region_init_ram(&s->sram, OBJECT(s), dev_name,
> +                           AST1700_SOC_SRAM_SIZE, errp);
> +    memory_region_add_subregion(&s->iomem,
> +                            aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SRAM],
> +                            &s->sram);
> +
>       /* UART */
>       qdev_prop_set_uint8(DEVICE(&s->uart), "regshift", 2);
>       qdev_prop_set_uint32(DEVICE(&s->uart), "baudbase", 38400);
> @@ -69,11 +81,16 @@ static void aspeed_ast1700_instance_init(Object *obj)
>       return;
>   }
>   
> +static const Property aspeed_ast1700_props[] = {
> +    DEFINE_PROP_UINT8("board-idx", AspeedAST1700SoCState, board_idx, 0),
> +};
> +
>   static void aspeed_ast1700_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>   
>       dc->realize = aspeed_ast1700_realize;
> +    device_class_set_props(dc, aspeed_ast1700_props);
>   }
>   
>   static const TypeInfo aspeed_ast1700_info = {
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 33800dffc5..66c877a6a4 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -1096,6 +1096,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>   
>       /* IO Expander */
>       for (i = 0; i < sc->ioexp_num; i++) {
> +        qdev_prop_set_uint8(DEVICE(&s->ioexp[i]), "board-idx", i);
>           if (!sysbus_realize(SYS_BUS_DEVICE(&s->ioexp[i]), errp)) {
>               return;
>           }



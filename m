Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B847CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 07:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHHMB-0004bH-17; Fri, 07 Nov 2025 02:58:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vHHM8-0004aY-L0; Fri, 07 Nov 2025 02:58:00 -0500
Received: from smtpout3.mo529.mail-out.ovh.net ([46.105.54.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vHHM6-0005BV-NR; Fri, 07 Nov 2025 02:58:00 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.231.214])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4d2ryV55Fyz5w28;
 Fri,  7 Nov 2025 07:57:54 +0000 (UTC)
Received: from kaod.org (37.59.142.106) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 7 Nov
 2025 08:57:54 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006da54bc78-fc33-4dbe-a9cd-de32c550d232,
 22B515FCB2325FA901564F8AB94FB8FB00D14EB6) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <f8a8d21a-00bb-48b1-984d-ef7e4aa393f2@kaod.org>
Date: Fri, 7 Nov 2025 08:57:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/12] hw/arm/aspeed: Fix missing SPI IRQ connection
 causing DMA interrupt failure
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <kane_chen@aspeedtech.com>
References: <20251106084925.1253704-1-jamin_lin@aspeedtech.com>
 <20251106084925.1253704-2-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251106084925.1253704-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG4EX1.mxp5.local (172.16.2.31) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: b2720378-6b78-42a9-a741-d031348b0873
X-Ovh-Tracer-Id: 11998152361465252670
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE7Rrxv6nbZ7vov45cvww1t4fXvEmZMiTlQNyMEjres6q6JOMD+2Z1x/YmF+lgO9SEouI57P5s81WxUdU/l1TOl2L5xPjT9S00n2dOaWtibz6BogyagmWqQM52P4P39r1ZktqsLbSt3VQZ3q1yaxbYskgePKvWZz28B6EvPjhuMlRNlivJ5L+UG7eyXdaunr+AGuJYc5waaIHaoTd8e0vtWasWVQIHLa4TVKy51PL72cqpRvFN684ti4zzLH8LSvUdB4moORK3xBSu3F8K/fxEeMS9hAqoNJwxp6IOCzeonoR4hY5lF0cGlFUSNN/S05FKMslAZ2+ipY2BOMPARbyLrQN31ZEjl202yo6mPZgxLfzBSHXiJkIHP0nQ7lDODWWA1kfGCfkMEvnssR9/71M4Dua2xJ9b/WB4MFQVe0ZffojrTJy6sAUa+07kb/pt0bq1p7S753NiLJHI66sLPJlI8x4W0H4FYxt70YfLjql/Z8VnREXYGknSGZYEygRD0k96MOf9j5iYjtfphFPA7SEguets/2ixQPJPPdOaq+VtjQ3l9OvR69BwlqMtXz2AeWFLAlpgHhtX+Ue5Ch4WTZzSAWtcgfdzB8iYf/xJbszPVoOYJiTMxJZA9IUe3WUnfnlnsPCRPzmfjvupW8c3tJZnoNH5GqdeFZ4qwJETLTY41UQ
DKIM-Signature: a=rsa-sha256; bh=wWxptKkNL1+KGdj7Jqe2EnPrg+7CDqodeGBujcvElc4=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1762502275; v=1;
 b=CEjuIqrKjCpUaw6O0atwUCvap5kvI9RgPgXBP0XgFG1wA2svwXlUBkqdttvZK4TpbXRJ4+SD
 NhmBMzh6gYf7LmvBNIJtbAuMreREIXl5GyND+BdoqjEsH/kvA7ul1Pxvmck1r381IpsDmGRaM8v
 IOeCBI8XwGsYknFnYAoOkw5D7IBiML7bU7/yDzTDjE2zQRZeAHJhVWl1+WlHs3Be6I+jRZak+Gk
 /WNE7arI3zeZ4PuZxfGyPotv2wKAYJiQiXr9VPRe3OiIHqrJmXP/iCSF2GCv+fDp2Lu2bWXQ2XW
 YKSNqbvx9xLuGL7rQW7Vh1FEWi2xUIOTkYIHjbkzCThfQ==
Received-SPF: pass client-ip=46.105.54.81; envelope-from=clg@kaod.org;
 helo=smtpout3.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/6/25 09:49, Jamin Lin wrote:
> It did not connect SPI IRQ to the Interrupt Controller, so even the SPI
> model raised the IRQ, the interrupt was not received. The CPU therefore
> did not trigger an interrupt via the controller, and the firmware never
> received the interrupt.
> 
> Fixes: 356b230ed13889e09d087a96498887de695df17e ("aspeed/soc: Add AST1030 support")
> Fixes: f25c0ae1079dc0b9de02676eb3e3949a09df9f41 ("aspeed/soc: Add AST2600 support")
> Fixes: 5dd883ab0635c9f715c77cc32622e458a0724581 ("aspeed/soc: Add AST2700 support")


AFAIR, the IRQ is for DMA which the drivers don't support yet.
Am I wrong ? When was it added ?

The code is fine and I am asking because of the fixes tags above.
It would mean propagating the fixes to the stable branches too.


Thanks,

C.

  

> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast10x0.c | 2 ++
>   hw/arm/aspeed_ast2600.c | 2 ++
>   hw/arm/aspeed_ast27x0.c | 2 ++
>   3 files changed, 6 insertions(+)
> 
> diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
> index 7f49c13391..ca487774ae 100644
> --- a/hw/arm/aspeed_ast10x0.c
> +++ b/hw/arm/aspeed_ast10x0.c
> @@ -372,6 +372,8 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
>                           sc->memmap[ASPEED_DEV_SPI1 + i]);
>           aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 1,
>                           ASPEED_SMC_GET_CLASS(&s->spi[i])->flash_window_base);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
> +                           aspeed_soc_ast1030_get_irq(s, ASPEED_DEV_SPI1 + i));
>       }
>   
>       /* Secure Boot Controller */
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index 498d1ecc07..4c5a42ea17 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -557,6 +557,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>                           sc->memmap[ASPEED_DEV_SPI1 + i]);
>           aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 1,
>                           ASPEED_SMC_GET_CLASS(&s->spi[i])->flash_window_base);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
> +                           aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_SPI1 + i));
>       }
>   
>       /* EHCI */
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index c484bcd4e2..e02a674b13 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -831,6 +831,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>                           sc->memmap[ASPEED_DEV_SPI0 + i]);
>           aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->spi[i]), 1,
>                           ASPEED_SMC_GET_CLASS(&s->spi[i])->flash_window_base);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
> +                           aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_SPI0 + i));
>       }
>   
>       /* EHCI */



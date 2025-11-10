Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA10CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 16:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIURb-0006VB-D1; Mon, 10 Nov 2025 11:08:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vIURY-0006RV-HT
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 11:08:36 -0500
Received: from 10.mo552.mail-out.ovh.net ([87.98.187.244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vIURU-0004LD-Rn
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 11:08:36 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.58.79])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4d4vj86nDvz5yRg;
 Mon, 10 Nov 2025 16:08:28 +0000 (UTC)
Received: from kaod.org (37.59.142.102) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Mon, 10 Nov
 2025 17:08:28 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R0041a6b5ec0-8fee-4de9-b111-825fd02739e0,
 2CC8F654BF9A736B588295E2BFA8A60E013487DB) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <bc22c287-b240-4cba-a8c1-515856186469@kaod.org>
Date: Mon, 10 Nov 2025 17:08:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/17] hw/arm/aspeed: Attach SRAM device to AST1700
 model
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>
References: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
 <20251105035859.3709907-9-kane_chen@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251105035859.3709907-9-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.102]
X-ClientProxiedBy: DAG1EX2.mxp5.local (172.16.2.2) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: ce3446b8-2776-4b2f-b0d9-648cf8dd94dd
X-Ovh-Tracer-Id: 1007680418398571442
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGQr86MUpRhBdD9IMv04TB0CdeKUvAK31Hi4rbkIbXfH69tq0M+8bif6xcrhD5KbaQvwo+tYHqffSUdgG98jXuh9sCPMSPr0HwtHrBuuOnOF5QkQTiL/6SwX3er6mNcsm9ihLJe20kstesk8ywZCJtagOBrGahsPwAFfRjw4/18bKq8uKRLi9Oe//qcYMimrZayU4asElLnV0+WZaKhR0ezrC/iYUtIipa4OhaqjMiLx+TlMUAoasC0OaFFR0nMFhCbLlUQAqSoUQbdKb3/LGVz0Apow7raCJMft+PSpxVDFDzUgVjmPlW3Q15cQMs3MvL2IK6nWAHODrd3Jo+zli2OVW+3TRtti8DmP2Do4dO+n/UOUijVxwxyZzgnTPUx8N08kPCXHWIzKIDxXJEeGHL5fXiY4G6o/ePXVrMWonCq6dA1WDpOG9O9qbvZY6dZ45WEcTeLZo3zzrMmGE37UQjStqaEiOC1hYQ6WKjLHsMcK+DZiNH9iQCelXYxvtgwZUjRbDUpuzIoh7sed4OM0N5U+ltdfQW957AJKHUkYfcvD1DvRyjIvy+IzYTYzu1vMeZeVQ1NpkMj2qY2THxWKtIkAgPkqT2lgEuU2sxyDI/zLcZ83CGVo8QfvTzbYnCRxPUiFnXYbMHip03F4d74MaIxIXvyBpVqgGBoz38LLZ6tKw
DKIM-Signature: a=rsa-sha256; bh=e927kS/sOLiRJkI/470A98XQjOntSwXh39iwoBjYI4o=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1762790910; v=1;
 b=a2bFZal5XnCv3ybSwfXLeolRojqY0Tu4ye4MeLQAOZqIWMQPZ0/vrFSdjU8ClJ78rBvWTTt6
 yw7Jk8Z3Lh79JE8znHbOQ1OLQ/SzGUruqe6jJa9+LoAeTzAmilTzm0aMvh8gdumRk3KTWUcMpr1
 dwE+KTYVl7nOH9XiB9N+pwPpCF0JLwkMZejWeNAfee7BCQ/yBcjrdKt7HRmTzk4m0qWh6iEvM72
 2qG5oEPlEkTlxJoioxYXsOtqKrVYd0cBsyyjsvv7UD122lM+1lGTAnefF1XuDTt3G2YDhmO5RR8
 HmL6df8eAwpZLqs48jSobkXOQ5gwglOL/yW7rGZ5hTZNw==
Received-SPF: pass client-ip=87.98.187.244; envelope-from=clg@kaod.org;
 helo=10.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 11/5/25 04:58, Kane Chen wrote:
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> 
> Map the SRAM device to AST1700 model
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>   include/hw/misc/aspeed_ast1700.h |  1 +
>   hw/misc/aspeed_ast1700.c         | 25 +++++++++++++++++++++++++
>   2 files changed, 26 insertions(+)
> 
> diff --git a/include/hw/misc/aspeed_ast1700.h b/include/hw/misc/aspeed_ast1700.h
> index e105ceb027..391c8687f5 100644
> --- a/include/hw/misc/aspeed_ast1700.h
> +++ b/include/hw/misc/aspeed_ast1700.h
> @@ -32,6 +32,7 @@ struct AspeedAST1700SoCState {
>   
>       AspeedLTPIState ltpi;
>       SerialMM uart;
> +    MemoryRegion sram;
>   };
>   
>   #endif /* ASPEED_AST1700_H */
> diff --git a/hw/misc/aspeed_ast1700.c b/hw/misc/aspeed_ast1700.c
> index 1c2d367cdb..6f7ff625b5 100644
> --- a/hw/misc/aspeed_ast1700.c
> +++ b/hw/misc/aspeed_ast1700.c
> @@ -15,14 +15,18 @@
>   #include "migration/vmstate.h"
>   #include "hw/misc/aspeed_ast1700.h"
>   
> +#define AST1700_BOARD1_MEM_ADDR      0x30000000
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
> @@ -31,12 +35,33 @@ static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
>       AspeedAST1700SoCState *s = ASPEED_AST1700(dev);
>       SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>       hwaddr uart_base;
> +    Error *err = NULL;

This variable could be avoided.

> +    int board_idx;
> +    char sram_name[32];
> +
> +    if (s->mapped_base == AST1700_BOARD1_MEM_ADDR) {
> +        board_idx = 0;
> +    } else {
> +        board_idx = 1;
> +    }

That's a bit hacky.

An "index" property set at the SoC level would avoid this weak heuristic.


>   
>       /* Occupy memory space for all controllers in AST1700 */
>       memory_region_init(&s->iomem, OBJECT(s), TYPE_ASPEED_AST1700,
>                          AST2700_SOC_LTPI_SIZE);
>       sysbus_init_mmio(sbd, &s->iomem);
>   
> +    /* SRAM */
> +    snprintf(sram_name, sizeof(sram_name), "aspeed.ioexp-sram.%d", board_idx);
> +    memory_region_init_ram(&s->sram, OBJECT(s), sram_name,
> +                           AST1700_SOC_SRAM_SIZE, &err);

Just pass 'errp' and test the return value of memory_region_init_ram()


Thanks,

C.



> +    if (err != NULL) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    memory_region_add_subregion(&s->iomem,
> +                                aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SRAM],
> +                                &s->sram);
> +
>       /* UART */
>       uart_base = s->mapped_base +
>                  aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_UART12];



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F235FA3744
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 13:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbfCx-0007DW-3O; Fri, 02 Jan 2026 08:28:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vbfCn-0007Aw-F5; Fri, 02 Jan 2026 08:28:38 -0500
Received: from 10.mo552.mail-out.ovh.net ([87.98.187.244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vbfCg-0007xa-Aj; Fri, 02 Jan 2026 08:28:36 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.0.143])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4djPf038YMz5vtL;
 Fri,  2 Jan 2026 13:28:23 +0000 (UTC)
Received: from kaod.org (37.59.142.107) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 2 Jan
 2026 14:28:23 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-107S00165809949-757b-485d-98f6-fe9de4857ee6,
 B7FD5E44328430CDF13337E5E30BE77826E2EBC7) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 90.14.253.154
Message-ID: <e73caa29-7bfc-4a2f-a8ea-a305e6d7f0e5@kaod.org>
Date: Fri, 2 Jan 2026 14:28:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] hw/intc/aspeed: Remove SSP 128 - 138
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <kane_chen@aspeedtech.com>
References: <20260102090746.1130033-1-jamin_lin@aspeedtech.com>
 <20260102090746.1130033-2-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260102090746.1130033-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.107]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: 48665a2e-1599-4b30-9f4d-0c2c65435b2f
X-Ovh-Tracer-Id: 14408985534673554354
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEfPCNna7+YE1uAmOktcyyNYT+5GmGBcczz/xCKw7vnBr2apRt0wmHVyNi1+ZiCHV7wUD52i1EGbJJjx4ZRNYNeyMylTVVR2vHM7bKqWmKFRDAvW/vQK1+gAJw6qC+SS5QY5/+qj77ngoq8soZb85kMiclrWDwUZ2tIaqef+CEyJVdheLaqHbZvGYYb+W4ZjvArh+stoPYClHTfwBkDeBAsJMQVcyuKGlaaFSyLqNFqw5qrrfXomAH1g7b1e9mX1eDUlk2zKLirOiTf+OJV2NC0iyjxTi0VDH3SzZN+pxQyXEf3jvGotBgygdWxC1JZ65zt+6vX9xI17iLNy19TYt2tpBssHiLlrmw5ieFFAWQ8mdnKsiYv3KTcXTImhXA6lzMBj25cDAgAmhTtoy/T/+4MBEwxL3z4AERnQOdqPhJTLPWdOd2UVZXC3OdE0Wm1nL0qSJU4Nv5rcadmx0jZ6s/lrIi1qjCxeEO4BULTPnXf3Xw6UbISTYLj7e8VYWy+LKCzSiDjRWipJyihGkefDXzZMd0cSF+ZVEjP1C+TLkgV5ED7c3HApC/1n00gWtWV9xphk9jdw/nORG+4wHd/swIZO4VL0FazcD5UuqRgGXtvydPpIBxrQ0aEgiL14fXNgt3LmWyQErdrjGE1egioIhY20ogR16kfpA/KPqcfb6zD3A
DKIM-Signature: a=rsa-sha256; bh=UcpmyTpogJt8kf29pa8w3XCtEHLmnhPMp0BwL5eFZh0=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1767360505; v=1;
 b=JZNVyIQR7vJb3I0sH/CLpk3HgU5zw6SBxFn15IqbSwLhddoTZBLsfZA1yOwcSTeOUYTQuwbb
 XKmn/WhWq7iRjMGN8U7GZxB1I/ZxH2T8S/GnlFmoldvDvD0dvn6fyCj7+uoIoZSCDikJDCTj64+
 HJqfN9xNUXanm2/ySqcUw6WCrur++m+VZHvaEtAZbyCi2XaQCyJiKo+4MNsmT4Dkx8pUxTThto4
 Rra5zFhTTXxCxVqyjD71LcMDfjA7GcWBQmTfqjpCPfu1uf/VyD1KtiolmCPYHKJnIUZ861kKfyy
 hcHcaCflbp+O6UL7qspPVIjQEm7nq1l+ELpbgQva+72cw==
Received-SPF: pass client-ip=87.98.187.244; envelope-from=clg@kaod.org;
 helo=10.mo552.mail-out.ovh.net
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

On 1/2/26 10:07, Jamin Lin wrote:
> The SSP interrupts 128 - 138 were only used by the AST2700 A0 SoC.
> Since the AST2700 A0 has been deprecated, these interrupt
> definitions are no longer needed. This commit removes them to
> clean up the codebase.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

> ---
>   hw/arm/aspeed_ast27x0-ssp.c | 13 ++-------
>   hw/intc/aspeed_intc.c       | 55 ++-----------------------------------
>   2 files changed, 4 insertions(+), 64 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
> index 04d3705659..cee937b37e 100644
> --- a/hw/arm/aspeed_ast27x0-ssp.c
> +++ b/hw/arm/aspeed_ast27x0-ssp.c
> @@ -62,7 +62,7 @@ static const int aspeed_soc_ast27x0ssp_irqmap[] = {
>   };
>   
>   /* SSPINT 164 */
> -static const int ast2700_ssp132_ssp164_intcmap[] = {
> +static const int ast2700_ssp164_intcmap[] = {
>       [ASPEED_DEV_UART0]     = 7,
>       [ASPEED_DEV_UART1]     = 8,
>       [ASPEED_DEV_UART2]     = 9,
> @@ -89,21 +89,12 @@ static struct nvic_intc_irq_info ast2700_ssp_intcmap[] = {
>       {161, 1, 1, NULL},
>       {162, 1, 2, NULL},
>       {163, 1, 3, NULL},
> -    {164, 1, 4, ast2700_ssp132_ssp164_intcmap},
> +    {164, 1, 4, ast2700_ssp164_intcmap},
>       {165, 1, 5, NULL},
>       {166, 1, 6, NULL},
>       {167, 1, 7, NULL},
>       {168, 1, 8, NULL},
>       {169, 1, 9, NULL},
> -    {128, 0, 1, NULL},
> -    {129, 0, 2, NULL},
> -    {130, 0, 3, NULL},
> -    {131, 0, 4, NULL},
> -    {132, 0, 5, ast2700_ssp132_ssp164_intcmap},
> -    {133, 0, 6, NULL},
> -    {134, 0, 7, NULL},
> -    {135, 0, 8, NULL},
> -    {136, 0, 9, NULL},
>   };
>   
>   static qemu_irq aspeed_soc_ast27x0ssp_get_irq(AspeedCoprocessorState *s,
> diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
> index 606bde65bb..305458d6d4 100644
> --- a/hw/intc/aspeed_intc.c
> +++ b/hw/intc/aspeed_intc.c
> @@ -47,28 +47,6 @@ REG32(GICINT197_STATUS,     0x54)
>   /*
>    * SSP INTC Registers
>    */
> -REG32(SSPINT128_EN,             0x2000)
> -REG32(SSPINT128_STATUS,         0x2004)
> -REG32(SSPINT129_EN,             0x2100)
> -REG32(SSPINT129_STATUS,         0x2104)
> -REG32(SSPINT130_EN,             0x2200)
> -REG32(SSPINT130_STATUS,         0x2204)
> -REG32(SSPINT131_EN,             0x2300)
> -REG32(SSPINT131_STATUS,         0x2304)
> -REG32(SSPINT132_EN,             0x2400)
> -REG32(SSPINT132_STATUS,         0x2404)
> -REG32(SSPINT133_EN,             0x2500)
> -REG32(SSPINT133_STATUS,         0x2504)
> -REG32(SSPINT134_EN,             0x2600)
> -REG32(SSPINT134_STATUS,         0x2604)
> -REG32(SSPINT135_EN,             0x2700)
> -REG32(SSPINT135_STATUS,         0x2704)
> -REG32(SSPINT136_EN,             0x2800)
> -REG32(SSPINT136_STATUS,         0x2804)
> -REG32(SSPINT137_EN,             0x2900)
> -REG32(SSPINT137_STATUS,         0x2904)
> -REG32(SSPINT138_EN,             0x2A00)
> -REG32(SSPINT138_STATUS,         0x2A04)
>   REG32(SSPINT160_169_EN,         0x2B00)
>   REG32(SSPINT160_169_STATUS,     0x2B04)
>   
> @@ -511,29 +489,9 @@ static void aspeed_ssp_intc_write(void *opaque, hwaddr offset, uint64_t data,
>       trace_aspeed_intc_write(name, offset, size, data);
>   
>       switch (reg) {
> -    case R_SSPINT128_EN:
> -    case R_SSPINT129_EN:
> -    case R_SSPINT130_EN:
> -    case R_SSPINT131_EN:
> -    case R_SSPINT132_EN:
> -    case R_SSPINT133_EN:
> -    case R_SSPINT134_EN:
> -    case R_SSPINT135_EN:
> -    case R_SSPINT136_EN:
>       case R_SSPINT160_169_EN:
>           aspeed_intc_enable_handler(s, offset, data);
>           break;
> -    case R_SSPINT128_STATUS:
> -    case R_SSPINT129_STATUS:
> -    case R_SSPINT130_STATUS:
> -    case R_SSPINT131_STATUS:
> -    case R_SSPINT132_STATUS:
> -    case R_SSPINT133_STATUS:
> -    case R_SSPINT134_STATUS:
> -    case R_SSPINT135_STATUS:
> -    case R_SSPINT136_STATUS:
> -        aspeed_intc_status_handler(s, offset, data);
> -        break;
>       case R_SSPINT160_169_STATUS:
>           aspeed_intc_status_handler_multi_outpins(s, offset, data);
>           break;
> @@ -911,15 +869,6 @@ static const TypeInfo aspeed_2700_intcio_info = {
>   
>   static AspeedINTCIRQ aspeed_2700ssp_intc_irqs[ASPEED_INTC_MAX_INPINS] = {
>       {0, 0, 10, R_SSPINT160_169_EN, R_SSPINT160_169_STATUS},
> -    {1, 10, 1, R_SSPINT128_EN, R_SSPINT128_STATUS},
> -    {2, 11, 1, R_SSPINT129_EN, R_SSPINT129_STATUS},
> -    {3, 12, 1, R_SSPINT130_EN, R_SSPINT130_STATUS},
> -    {4, 13, 1, R_SSPINT131_EN, R_SSPINT131_STATUS},
> -    {5, 14, 1, R_SSPINT132_EN, R_SSPINT132_STATUS},
> -    {6, 15, 1, R_SSPINT133_EN, R_SSPINT133_STATUS},
> -    {7, 16, 1, R_SSPINT134_EN, R_SSPINT134_STATUS},
> -    {8, 17, 1, R_SSPINT135_EN, R_SSPINT135_STATUS},
> -    {9, 18, 1, R_SSPINT136_EN, R_SSPINT136_STATUS},
>   };
>   
>   static void aspeed_2700ssp_intc_class_init(ObjectClass *klass, const void *data)
> @@ -929,8 +878,8 @@ static void aspeed_2700ssp_intc_class_init(ObjectClass *klass, const void *data)
>   
>       dc->desc = "ASPEED 2700 SSP INTC Controller";
>       aic->num_lines = 32;
> -    aic->num_inpins = 10;
> -    aic->num_outpins = 19;
> +    aic->num_inpins = 1;
> +    aic->num_outpins = 10;
>       aic->mem_size = 0x4000;
>       aic->nr_regs = 0x2B08 >> 2;
>       aic->reg_offset = 0x0;



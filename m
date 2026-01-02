Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F3BFA3744
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 13:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbfCz-0007Ex-44; Fri, 02 Jan 2026 08:28:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vbfCw-0007Cz-Lc
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 08:28:46 -0500
Received: from 2.mo552.mail-out.ovh.net ([178.33.105.233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vbfCr-0007zP-2a
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 08:28:44 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.58.222])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4djPfF5C1pz5w25;
 Fri,  2 Jan 2026 13:28:37 +0000 (UTC)
Received: from kaod.org (37.59.142.100) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 2 Jan
 2026 14:28:36 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R00366f6700c-9825-417e-94d9-3ccebe1ea7fe,
 B7FD5E44328430CDF13337E5E30BE77826E2EBC7) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 90.14.253.154
Message-ID: <91694864-29ce-4603-934d-ccf725bc40cf@kaod.org>
Date: Fri, 2 Jan 2026 14:28:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] hw/intc/aspeed: Remove TSP 128 - 138
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <kane_chen@aspeedtech.com>
References: <20260102090746.1130033-1-jamin_lin@aspeedtech.com>
 <20260102090746.1130033-3-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260102090746.1130033-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: 0cad113c-e66b-4d04-8d55-7cc72dffab51
X-Ovh-Tracer-Id: 14412926183869877170
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGyKqhfzqYiLfy0XHcrtO7ud0e8JjnqSUrlkJkCtFUzxGOEy72d4Jv2qKPWnUNOF0HU12jYLRo/wNYrnHPTirp2lIWK1zOal56zmPP8P6LRedhCb+8OsBpPx7+cb2tFJVWD5t2JnRVkF386i8YvZlMDYjouBhIAEBVBUysOSGUceremXebXwbaAPzubccIQyExk52793UMOX1Md+t0BvH9d6iHU9P964pRJIFDgTAnUdDqe0HU4n0fOgGjSyi8FJX4iASfnDqGOxRTFK9MJokewSHzzIcsM8eCQpxS7598xUKNsIbbfIY1QXexBSZBWmbqliSHvPIJnJ1RYtyruDBX2otsr/23QXYg95gwBYGeA4Z5uzlMWg16fInx1K0LZPniQLEVT/9oRuJrrehM7xvcXZ8DcLChf4/rp6NR9jv4PBdZ+F87dMGTxOHeI9IV0k+nID3f9jtkSvboAF6KI+JFSgrqaJBm9gPQ7uM3MzGWXcXkiYSAUYZbXJ2AkjPmd+pDkIDIU8ORl8Gklta6fwOlr9K2W9tQi/h0cuuqQN21ysTYWumwp2CxbNBolntdE+8rVuMTAR673gjpJxmErbWuKh+xarl/B31Xy7L4xHX1lp7yLWNuyIS+dcMsECn6iaQEKSsU+hWrXibmSzJ3ci8acQpskVRrLyn/1Cd5TJ1dZdA
DKIM-Signature: a=rsa-sha256; bh=e8skIPXTKPkD5kZkjr8JiU4XqExm5ISASNtzLcJdBzs=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1767360517; v=1;
 b=r9lynUsXJ5krTJqTvyRnIMIhb5uMjoAezRF3lguCsTGIFoBVSQpGBZ0NckO4Fr4JIcQLBRsi
 0BkEevS7dHv1fhkjne5Ccm+poxsDor3t46BCLCMfJ2ESEGLE+9/3HM0Cvw9jDI/pdQ1x8x5Hlyu
 RBlYmIWRndo5pHnNXQr6m8qxm82614lFNGlFX5lyprnCFpcfA++hdJrRY4F+RICe/PVttUtcDXZ
 Sk68Lukmk3w1Xd3V3cunzE71cAsnOAxK09vP16SbDaFmiZb5z7hXrj1+qI4wJBxS83J+m9q1jfO
 IadtjWivWnxmG7WrbLfI+iHvnWYQaWzAxgxDOnX/M2NOA==
Received-SPF: pass client-ip=178.33.105.233; envelope-from=clg@kaod.org;
 helo=2.mo552.mail-out.ovh.net
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
>   hw/arm/aspeed_ast27x0-tsp.c | 13 ++-------
>   hw/intc/aspeed_intc.c       | 55 ++-----------------------------------
>   2 files changed, 4 insertions(+), 64 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
> index f40c70fea5..9c11c016ca 100644
> --- a/hw/arm/aspeed_ast27x0-tsp.c
> +++ b/hw/arm/aspeed_ast27x0-tsp.c
> @@ -62,7 +62,7 @@ static const int aspeed_soc_ast27x0tsp_irqmap[] = {
>   };
>   
>   /* TSPINT 164 */
> -static const int ast2700_tsp132_tsp164_intcmap[] = {
> +static const int ast2700_tsp164_intcmap[] = {
>       [ASPEED_DEV_UART0]     = 7,
>       [ASPEED_DEV_UART1]     = 8,
>       [ASPEED_DEV_UART2]     = 9,
> @@ -89,21 +89,12 @@ static struct nvic_intc_irq_info ast2700_tsp_intcmap[] = {
>       {161, 1, 1, NULL},
>       {162, 1, 2, NULL},
>       {163, 1, 3, NULL},
> -    {164, 1, 4, ast2700_tsp132_tsp164_intcmap},
> +    {164, 1, 4, ast2700_tsp164_intcmap},
>       {165, 1, 5, NULL},
>       {166, 1, 6, NULL},
>       {167, 1, 7, NULL},
>       {168, 1, 8, NULL},
>       {169, 1, 9, NULL},
> -    {128, 0, 1, NULL},
> -    {129, 0, 2, NULL},
> -    {130, 0, 3, NULL},
> -    {131, 0, 4, NULL},
> -    {132, 0, 5, ast2700_tsp132_tsp164_intcmap},
> -    {133, 0, 6, NULL},
> -    {134, 0, 7, NULL},
> -    {135, 0, 8, NULL},
> -    {136, 0, 9, NULL},
>   };
>   
>   static qemu_irq aspeed_soc_ast27x0tsp_get_irq(AspeedCoprocessorState *s,
> diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
> index 305458d6d4..1702cb87dc 100644
> --- a/hw/intc/aspeed_intc.c
> +++ b/hw/intc/aspeed_intc.c
> @@ -69,28 +69,6 @@ REG32(SSPINT165_STATUS,     0x1D4)
>   /*
>    * TSP INTC Registers
>    */
> -REG32(TSPINT128_EN,             0x3000)
> -REG32(TSPINT128_STATUS,         0x3004)
> -REG32(TSPINT129_EN,             0x3100)
> -REG32(TSPINT129_STATUS,         0x3104)
> -REG32(TSPINT130_EN,             0x3200)
> -REG32(TSPINT130_STATUS,         0x3204)
> -REG32(TSPINT131_EN,             0x3300)
> -REG32(TSPINT131_STATUS,         0x3304)
> -REG32(TSPINT132_EN,             0x3400)
> -REG32(TSPINT132_STATUS,         0x3404)
> -REG32(TSPINT133_EN,             0x3500)
> -REG32(TSPINT133_STATUS,         0x3504)
> -REG32(TSPINT134_EN,             0x3600)
> -REG32(TSPINT134_STATUS,         0x3604)
> -REG32(TSPINT135_EN,             0x3700)
> -REG32(TSPINT135_STATUS,         0x3704)
> -REG32(TSPINT136_EN,             0x3800)
> -REG32(TSPINT136_STATUS,         0x3804)
> -REG32(TSPINT137_EN,             0x3900)
> -REG32(TSPINT137_STATUS,         0x3904)
> -REG32(TSPINT138_EN,             0x3A00)
> -REG32(TSPINT138_STATUS,         0x3A04)
>   REG32(TSPINT160_169_EN,         0x3B00)
>   REG32(TSPINT160_169_STATUS,     0x3B04)
>   
> @@ -511,29 +489,9 @@ static void aspeed_tsp_intc_write(void *opaque, hwaddr offset, uint64_t data,
>       trace_aspeed_intc_write(name, offset, size, data);
>   
>       switch (reg) {
> -    case R_TSPINT128_EN:
> -    case R_TSPINT129_EN:
> -    case R_TSPINT130_EN:
> -    case R_TSPINT131_EN:
> -    case R_TSPINT132_EN:
> -    case R_TSPINT133_EN:
> -    case R_TSPINT134_EN:
> -    case R_TSPINT135_EN:
> -    case R_TSPINT136_EN:
>       case R_TSPINT160_169_EN:
>           aspeed_intc_enable_handler(s, offset, data);
>           break;
> -    case R_TSPINT128_STATUS:
> -    case R_TSPINT129_STATUS:
> -    case R_TSPINT130_STATUS:
> -    case R_TSPINT131_STATUS:
> -    case R_TSPINT132_STATUS:
> -    case R_TSPINT133_STATUS:
> -    case R_TSPINT134_STATUS:
> -    case R_TSPINT135_STATUS:
> -    case R_TSPINT136_STATUS:
> -        aspeed_intc_status_handler(s, offset, data);
> -        break;
>       case R_TSPINT160_169_STATUS:
>           aspeed_intc_status_handler_multi_outpins(s, offset, data);
>           break;
> @@ -929,15 +887,6 @@ static const TypeInfo aspeed_2700ssp_intcio_info = {
>   
>   static AspeedINTCIRQ aspeed_2700tsp_intc_irqs[ASPEED_INTC_MAX_INPINS] = {
>       {0, 0, 10, R_TSPINT160_169_EN, R_TSPINT160_169_STATUS},
> -    {1, 10, 1, R_TSPINT128_EN, R_TSPINT128_STATUS},
> -    {2, 11, 1, R_TSPINT129_EN, R_TSPINT129_STATUS},
> -    {3, 12, 1, R_TSPINT130_EN, R_TSPINT130_STATUS},
> -    {4, 13, 1, R_TSPINT131_EN, R_TSPINT131_STATUS},
> -    {5, 14, 1, R_TSPINT132_EN, R_TSPINT132_STATUS},
> -    {6, 15, 1, R_TSPINT133_EN, R_TSPINT133_STATUS},
> -    {7, 16, 1, R_TSPINT134_EN, R_TSPINT134_STATUS},
> -    {8, 17, 1, R_TSPINT135_EN, R_TSPINT135_STATUS},
> -    {9, 18, 1, R_TSPINT136_EN, R_TSPINT136_STATUS},
>   };
>   
>   static void aspeed_2700tsp_intc_class_init(ObjectClass *klass, const void *data)
> @@ -947,8 +896,8 @@ static void aspeed_2700tsp_intc_class_init(ObjectClass *klass, const void *data)
>   
>       dc->desc = "ASPEED 2700 TSP INTC Controller";
>       aic->num_lines = 32;
> -    aic->num_inpins = 10;
> -    aic->num_outpins = 19;
> +    aic->num_inpins = 1;
> +    aic->num_outpins = 10;
>       aic->mem_size = 0x4000;
>       aic->nr_regs = 0x3B08 >> 2;
>       aic->reg_offset = 0;



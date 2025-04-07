Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F6CC3601E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 15:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1oBs-0003AZ-Ik; Mon, 07 Apr 2025 11:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=CcIW=WZ=kaod.org=clg@ozlabs.org>)
 id 1u1oBI-0002QL-3y; Mon, 07 Apr 2025 11:14:36 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=CcIW=WZ=kaod.org=clg@ozlabs.org>)
 id 1u1oBE-0005fz-Jb; Mon, 07 Apr 2025 11:14:35 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZWXmz03fgz4wyk;
 Tue,  8 Apr 2025 01:14:27 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZWXmv2CV6z4wcn;
 Tue,  8 Apr 2025 01:14:22 +1000 (AEST)
Message-ID: <c953bf4b-fbca-40df-859b-54e19f81790c@kaod.org>
Date: Mon, 7 Apr 2025 17:14:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] hw/intc/aspeed: Add support for AST2700 TSP INTC
To: Steven Lee <steven_lee@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20250313054020.2583556-1-steven_lee@aspeedtech.com>
 <20250313054020.2583556-5-steven_lee@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250313054020.2583556-5-steven_lee@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=CcIW=WZ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/13/25 06:40, Steven Lee wrote:
> - Define new types for ast2700tsp INTC and INTCIO
> - Add register definitions for TSP INTC and INTCIO
> - Implement write handlers for TSP INTC and INTCIO
> - Register new types in aspeed_intc_register_types
> 
> The design of the TSP INTC and INTCIO controllers is similar to
> AST2700, with the following differences:
> 
> - AST2700
>    Support GICINT128 to GICINT136 in INTC
>    The INTCIO GIC_192_201 has 10 output pins, mapped as follows:
>      Bit 0 -> GIC 192
>      Bit 1 -> GIC 193
>      Bit 2 -> GIC 194
>      Bit 3 -> GIC 195
>      Bit 4 -> GIC 196
> 
> - AST2700-tsp
>    Support TSPINT128 to TSPINT136 in INTC
>    The INTCIO TSPINT_160_169 has 10 output pins, mapped as follows:
>      Bit 0 -> TSPINT 160
>      Bit 1 -> TSPINT 161
>      Bit 2 -> TSPINT 162
>      Bit 3 -> TSPINT 163
>      Bit 4 -> TSPINT 164
> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> Change-Id: I9e71a8aac400c0cdbd5b78073d0ada79d12a1350


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/intc/aspeed_intc.h |   2 +
>   hw/intc/aspeed_intc.c         | 213 ++++++++++++++++++++++++++++++++++
>   2 files changed, 215 insertions(+)
> 
> diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
> index 746f159bf3..51288384a5 100644
> --- a/include/hw/intc/aspeed_intc.h
> +++ b/include/hw/intc/aspeed_intc.h
> @@ -17,6 +17,8 @@
>   #define TYPE_ASPEED_2700_INTCIO TYPE_ASPEED_INTC "io-ast2700"
>   #define TYPE_ASPEED_2700SSP_INTC TYPE_ASPEED_INTC "-ast2700ssp"
>   #define TYPE_ASPEED_2700SSP_INTCIO TYPE_ASPEED_INTC "io-ast2700ssp"
> +#define TYPE_ASPEED_2700TSP_INTC TYPE_ASPEED_INTC "-ast2700tsp"
> +#define TYPE_ASPEED_2700TSP_INTCIO TYPE_ASPEED_INTC "io-ast2700tsp"
>   
>   OBJECT_DECLARE_TYPE(AspeedINTCState, AspeedINTCClass, ASPEED_INTC)
>   
> diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
> index 1f8b4d4d36..9e3bee993f 100644
> --- a/hw/intc/aspeed_intc.c
> +++ b/hw/intc/aspeed_intc.c
> @@ -106,6 +106,51 @@ REG32(SSPINT164_STATUS,     0x1C4)
>   REG32(SSPINT165_EN,         0x1D0)
>   REG32(SSPINT165_STATUS,     0x1D4)
>   
> +/*
> + * TSP INTC Registers
> + */
> +REG32(TSPINT128_EN,             0x3000)
> +REG32(TSPINT128_STATUS,         0x3004)
> +REG32(TSPINT129_EN,             0x3100)
> +REG32(TSPINT129_STATUS,         0x3104)
> +REG32(TSPINT130_EN,             0x3200)
> +REG32(TSPINT130_STATUS,         0x3204)
> +REG32(TSPINT131_EN,             0x3300)
> +REG32(TSPINT131_STATUS,         0x3304)
> +REG32(TSPINT132_EN,             0x3400)
> +REG32(TSPINT132_STATUS,         0x3404)
> +REG32(TSPINT133_EN,             0x3500)
> +REG32(TSPINT133_STATUS,         0x3504)
> +REG32(TSPINT134_EN,             0x3600)
> +REG32(TSPINT134_STATUS,         0x3604)
> +REG32(TSPINT135_EN,             0x3700)
> +REG32(TSPINT135_STATUS,         0x3704)
> +REG32(TSPINT136_EN,             0x3800)
> +REG32(TSPINT136_STATUS,         0x3804)
> +REG32(TSPINT137_EN,             0x3900)
> +REG32(TSPINT137_STATUS,         0x3904)
> +REG32(TSPINT138_EN,             0x3A00)
> +REG32(TSPINT138_STATUS,         0x3A04)
> +REG32(TSPINT160_169_EN,         0x3B00)
> +REG32(TSPINT160_169_STATUS,     0x3B04)
> +
> +/*
> + * TSP INTCIO Registers
> + */
> +
> +REG32(TSPINT160_EN,         0x200)
> +REG32(TSPINT160_STATUS,     0x204)
> +REG32(TSPINT161_EN,         0x210)
> +REG32(TSPINT161_STATUS,     0x214)
> +REG32(TSPINT162_EN,         0x220)
> +REG32(TSPINT162_STATUS,     0x224)
> +REG32(TSPINT163_EN,         0x230)
> +REG32(TSPINT163_STATUS,     0x234)
> +REG32(TSPINT164_EN,         0x240)
> +REG32(TSPINT164_STATUS,     0x244)
> +REG32(TSPINT165_EN,         0x250)
> +REG32(TSPINT165_STATUS,     0x254)
> +
>   static const AspeedINTCIRQ *aspeed_intc_get_irq(AspeedINTCClass *aic,
>                                                   uint32_t reg)
>   {
> @@ -540,6 +585,50 @@ static void aspeed_ssp_intc_write(void *opaque, hwaddr offset, uint64_t data,
>       return;
>   }
>   
> +static void aspeed_tsp_intc_write(void *opaque, hwaddr offset, uint64_t data,
> +                                        unsigned size)
> +{
> +    AspeedINTCState *s = ASPEED_INTC(opaque);
> +    const char *name = object_get_typename(OBJECT(s));
> +    uint32_t reg = offset >> 2;
> +
> +    trace_aspeed_intc_write(name, offset, size, data);
> +
> +    switch (reg) {
> +    case R_TSPINT128_EN:
> +    case R_TSPINT129_EN:
> +    case R_TSPINT130_EN:
> +    case R_TSPINT131_EN:
> +    case R_TSPINT132_EN:
> +    case R_TSPINT133_EN:
> +    case R_TSPINT134_EN:
> +    case R_TSPINT135_EN:
> +    case R_TSPINT136_EN:
> +    case R_TSPINT160_169_EN:
> +        aspeed_intc_enable_handler(s, offset, data);
> +        break;
> +    case R_TSPINT128_STATUS:
> +    case R_TSPINT129_STATUS:
> +    case R_TSPINT130_STATUS:
> +    case R_TSPINT131_STATUS:
> +    case R_TSPINT132_STATUS:
> +    case R_TSPINT133_STATUS:
> +    case R_TSPINT134_STATUS:
> +    case R_TSPINT135_STATUS:
> +    case R_TSPINT136_STATUS:
> +        aspeed_intc_status_handler(s, offset, data);
> +        break;
> +    case R_TSPINT160_169_STATUS:
> +        aspeed_intc_status_handler_multi_outpins(s, offset, data);
> +        break;
> +    default:
> +        s->regs[reg] = data;
> +        break;
> +    }
> +
> +    return;
> +}
> +
>   static uint64_t aspeed_intcio_read(void *opaque, hwaddr offset,
>                                      unsigned int size)
>   {
> @@ -622,6 +711,40 @@ static void aspeed_ssp_intcio_write(void *opaque, hwaddr offset, uint64_t data,
>       return;
>   }
>   
> +static void aspeed_tsp_intcio_write(void *opaque, hwaddr offset, uint64_t data,
> +                                unsigned size)
> +{
> +    AspeedINTCState *s = ASPEED_INTC(opaque);
> +    const char *name = object_get_typename(OBJECT(s));
> +    uint32_t reg = offset >> 2;
> +
> +    trace_aspeed_intc_write(name, offset, size, data);
> +
> +    switch (reg) {
> +    case R_TSPINT160_EN:
> +    case R_TSPINT161_EN:
> +    case R_TSPINT162_EN:
> +    case R_TSPINT163_EN:
> +    case R_TSPINT164_EN:
> +    case R_TSPINT165_EN:
> +        aspeed_intc_enable_handler(s, offset, data);
> +        break;
> +    case R_TSPINT160_STATUS:
> +    case R_TSPINT161_STATUS:
> +    case R_TSPINT162_STATUS:
> +    case R_TSPINT163_STATUS:
> +    case R_TSPINT164_STATUS:
> +    case R_TSPINT165_STATUS:
> +        aspeed_intc_status_handler(s, offset, data);
> +        break;
> +    default:
> +        s->regs[reg] = data;
> +        break;
> +    }
> +
> +    return;
> +}
> +
>   static const MemoryRegionOps aspeed_intc_ops = {
>       .read = aspeed_intc_read,
>       .write = aspeed_intc_write,
> @@ -662,6 +785,26 @@ static const MemoryRegionOps aspeed_ssp_intcio_ops = {
>       }
>   };
>   
> +static const MemoryRegionOps aspeed_tsp_intc_ops = {
> +    .read = aspeed_intc_read,
> +    .write = aspeed_tsp_intc_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    }
> +};
> +
> +static const MemoryRegionOps aspeed_tsp_intcio_ops = {
> +    .read = aspeed_intcio_read,
> +    .write = aspeed_tsp_intcio_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    }
> +};
> +
>   static void aspeed_intc_instance_init(Object *obj)
>   {
>       AspeedINTCState *s = ASPEED_INTC(obj);
> @@ -887,6 +1030,74 @@ static const TypeInfo aspeed_2700ssp_intcio_info = {
>       .class_init = aspeed_2700ssp_intcio_class_init,
>   };
>   
> +static AspeedINTCIRQ aspeed_2700tsp_intc_irqs[ASPEED_INTC_MAX_INPINS] = {
> +    {0, 0, 10, R_TSPINT160_169_EN, R_TSPINT160_169_STATUS},
> +    {1, 10, 1, R_TSPINT128_EN, R_TSPINT128_STATUS},
> +    {2, 11, 1, R_TSPINT129_EN, R_TSPINT129_STATUS},
> +    {3, 12, 1, R_TSPINT130_EN, R_TSPINT130_STATUS},
> +    {4, 13, 1, R_TSPINT131_EN, R_TSPINT131_STATUS},
> +    {5, 14, 1, R_TSPINT132_EN, R_TSPINT132_STATUS},
> +    {6, 15, 1, R_TSPINT133_EN, R_TSPINT133_STATUS},
> +    {7, 16, 1, R_TSPINT134_EN, R_TSPINT134_STATUS},
> +    {8, 17, 1, R_TSPINT135_EN, R_TSPINT135_STATUS},
> +    {9, 18, 1, R_TSPINT136_EN, R_TSPINT136_STATUS},
> +};
> +
> +static void aspeed_2700tsp_intc_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    AspeedINTCClass *aic = ASPEED_INTC_CLASS(klass);
> +
> +    dc->desc = "ASPEED 2700 TSP INTC Controller";
> +    aic->num_lines = 32;
> +    aic->num_inpins = 10;
> +    aic->num_outpins = 19;
> +    aic->mem_size = 0x4000;
> +    aic->nr_regs = 0x3B08 >> 2;
> +    aic->reg_offset = 0;
> +    aic->reg_ops = &aspeed_tsp_intc_ops;
> +    aic->irq_table = aspeed_2700tsp_intc_irqs;
> +    aic->irq_table_count = ARRAY_SIZE(aspeed_2700tsp_intc_irqs);
> +}
> +
> +static const TypeInfo aspeed_2700tsp_intc_info = {
> +    .name = TYPE_ASPEED_2700TSP_INTC,
> +    .parent = TYPE_ASPEED_INTC,
> +    .class_init = aspeed_2700tsp_intc_class_init,
> +};
> +
> +static AspeedINTCIRQ aspeed_2700tsp_intcio_irqs[ASPEED_INTC_MAX_INPINS] = {
> +    {0, 0, 1, R_TSPINT160_EN, R_TSPINT160_STATUS},
> +    {1, 1, 1, R_TSPINT161_EN, R_TSPINT161_STATUS},
> +    {2, 2, 1, R_TSPINT162_EN, R_TSPINT162_STATUS},
> +    {3, 3, 1, R_TSPINT163_EN, R_TSPINT163_STATUS},
> +    {4, 4, 1, R_TSPINT164_EN, R_TSPINT164_STATUS},
> +    {5, 5, 1, R_TSPINT165_EN, R_TSPINT165_STATUS},
> +};
> +
> +static void aspeed_2700tsp_intcio_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    AspeedINTCClass *aic = ASPEED_INTC_CLASS(klass);
> +
> +    dc->desc = "ASPEED 2700 TSP INTC IO Controller";
> +    aic->num_lines = 32;
> +    aic->num_inpins = 6;
> +    aic->num_outpins = 6;
> +    aic->mem_size = 0x400;
> +    aic->nr_regs = 0x258 >> 2;
> +    aic->reg_offset = 0x0;
> +    aic->reg_ops = &aspeed_tsp_intcio_ops;
> +    aic->irq_table = aspeed_2700tsp_intcio_irqs;
> +    aic->irq_table_count = ARRAY_SIZE(aspeed_2700tsp_intcio_irqs);
> +}
> +
> +static const TypeInfo aspeed_2700tsp_intcio_info = {
> +    .name = TYPE_ASPEED_2700TSP_INTCIO,
> +    .parent = TYPE_ASPEED_INTC,
> +    .class_init = aspeed_2700tsp_intcio_class_init,
> +};
> +
>   static void aspeed_intc_register_types(void)
>   {
>       type_register_static(&aspeed_intc_info);
> @@ -894,6 +1105,8 @@ static void aspeed_intc_register_types(void)
>       type_register_static(&aspeed_2700_intcio_info);
>       type_register_static(&aspeed_2700ssp_intc_info);
>       type_register_static(&aspeed_2700ssp_intcio_info);
> +    type_register_static(&aspeed_2700tsp_intc_info);
> +    type_register_static(&aspeed_2700tsp_intcio_info);
>   }
>   
>   type_init(aspeed_intc_register_types);



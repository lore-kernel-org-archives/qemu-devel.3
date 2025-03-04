Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579A7C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 07:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpMPa-0005oH-O7; Tue, 04 Mar 2025 02:09:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=B2sr=VX=kaod.org=clg@ozlabs.org>)
 id 1tpMOS-0005ic-IX; Tue, 04 Mar 2025 02:08:49 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=B2sr=VX=kaod.org=clg@ozlabs.org>)
 id 1tpMOP-000266-KB; Tue, 04 Mar 2025 02:08:44 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Z6Rc359YMz4x89;
 Tue,  4 Mar 2025 18:08:35 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Z6Rc02JTzz4x3q;
 Tue,  4 Mar 2025 18:08:31 +1100 (AEDT)
Message-ID: <8b57a5a3-9b85-4f0c-ad37-fc21d0189d4c@kaod.org>
Date: Tue, 4 Mar 2025 08:08:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/23] hw/intc/aspeed: Add Support for AST2700 INTCIO
 Controller
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20250303095457.2337631-1-jamin_lin@aspeedtech.com>
 <20250303095457.2337631-16-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250303095457.2337631-16-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=B2sr=VX=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 3/3/25 10:54, Jamin Lin wrote:
> Introduce a new ast2700 INTCIO class to support AST2700 INTCIO.
> Added new register definitions for INTCIO, including enable and status
> registers for IRQs GICINT192 through GICINT197.
> Created a dedicated IRQ array for INTCIO, supporting six input pins and six
> output pins, aligning with the newly defined registers.
> Implemented "aspeed_intcio_read" and "aspeed_intcio_write" to handle
> INTCIO-specific register access.
> 
>   To GICINT196                                                                                |
> 
>         ETH1    |-----------|                    |--------------------------|
>        -------->|0          |                    |         INTCIO           |
>         ETH2    |          4|   orgates[0]------>|inpin[0]-------->outpin[0]|
>        -------->|1         5|   orgates[1]------>|inpin[1]-------->outpin[1]|
>         ETH3    |          6|   orgates[2]------>|inpin[2]-------->outpin[2]|
>        -------->|2        19|   orgates[3]------>|inpin[3]-------->outpin[3]|
>         UART0   |         20|-->orgates[4]------>|inpin[4]-------->outpin[4]|
>        -------->|7        21|   orgates[5]------>|inpin[5]-------->outpin[5]|
>         UART1   |         22|                    |--------------------------|
>        -------->|8        23|
>         UART2   |         24|
>        -------->|9        25|
>         UART3   |         26|
>        ---------|10       27|
>         UART5   |         28|
>        -------->|11       29|
>         UART6   |           |
>        -------->|12       30|
>         UART7   |         31|
>        -------->|13         |
>         UART8   |  OR[0:31] |
>        -------->|14         |
>         UART9   |           |
>        -------->|15         |
>         UART10  |           |
>        -------->|16         |
>         UART11  |           |
>        -------->|17         |
>         UART12  |           |
>        -------->|18         |
>                 |-----------|
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/intc/aspeed_intc.h |   1 +
>   hw/intc/aspeed_intc.c         | 112 ++++++++++++++++++++++++++++++++++
>   2 files changed, 113 insertions(+)
> 
> diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
> index 21d9398933..fd7529137b 100644
> --- a/include/hw/intc/aspeed_intc.h
> +++ b/include/hw/intc/aspeed_intc.h
> @@ -14,6 +14,7 @@
>   
>   #define TYPE_ASPEED_INTC "aspeed.intc"
>   #define TYPE_ASPEED_2700_INTC TYPE_ASPEED_INTC "-ast2700"
> +#define TYPE_ASPEED_2700_INTCIO TYPE_ASPEED_INTC "io-ast2700"
>   OBJECT_DECLARE_TYPE(AspeedINTCState, AspeedINTCClass, ASPEED_INTC)
>   
>   #define ASPEED_INTC_NR_REGS (0xB08 >> 2)
> diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
> index 18521d3eb0..da721a6066 100644
> --- a/hw/intc/aspeed_intc.c
> +++ b/hw/intc/aspeed_intc.c
> @@ -42,6 +42,26 @@ REG32(GICINT136_STATUS,     0x804)
>   REG32(GICINT192_201_EN,         0xB00)
>   REG32(GICINT192_201_STATUS,     0xB04)
>   
> +/*
> + * INTCIO Registers
> + *
> + * values below are offset by - 0x100 from datasheet
> + * because its memory region is start at 0x100
> + *
> + */
> +REG32(GICINT192_EN,         0x00)
> +REG32(GICINT192_STATUS,     0x04)
> +REG32(GICINT193_EN,         0x10)
> +REG32(GICINT193_STATUS,     0x14)
> +REG32(GICINT194_EN,         0x20)
> +REG32(GICINT194_STATUS,     0x24)
> +REG32(GICINT195_EN,         0x30)
> +REG32(GICINT195_STATUS,     0x34)
> +REG32(GICINT196_EN,         0x40)
> +REG32(GICINT196_STATUS,     0x44)
> +REG32(GICINT197_EN,         0x50)
> +REG32(GICINT197_STATUS,     0x54)
> +
>   static const AspeedINTCIRQ *aspeed_intc_get_irq(AspeedINTCClass *aic,
>                                                   uint32_t addr)
>   {
> @@ -456,6 +476,55 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
>       return;
>   }
>   
> +static uint64_t aspeed_intcio_read(void *opaque, hwaddr offset,
> +                                   unsigned int size)
> +{
> +    AspeedINTCState *s = ASPEED_INTC(opaque);
> +    const char *name = object_get_typename(OBJECT(s));
> +    uint32_t reg = offset >> 2;
> +    uint32_t value = 0;> +
> +    value = s->regs[reg];
> +    trace_aspeed_intc_read(name, offset, size, value);
> +
> +    return value;
> +}
> +
> +static void aspeed_intcio_write(void *opaque, hwaddr offset, uint64_t data,
> +                                unsigned size)
> +{
> +    AspeedINTCState *s = ASPEED_INTC(opaque);
> +    const char *name = object_get_typename(OBJECT(s));
> +    uint32_t reg = offset >> 2;
> +
> +    trace_aspeed_intc_write(name, offset, size, data);
> +
> +    switch (reg) {
> +    case R_GICINT192_EN:
> +    case R_GICINT193_EN:
> +    case R_GICINT194_EN:
> +    case R_GICINT195_EN:
> +    case R_GICINT196_EN:
> +    case R_GICINT197_EN:
> +        aspeed_intc_enable_handler(s, offset, data);
> +        break;
> +    case R_GICINT192_STATUS:
> +    case R_GICINT193_STATUS:
> +    case R_GICINT194_STATUS:
> +    case R_GICINT195_STATUS:
> +    case R_GICINT196_STATUS:
> +    case R_GICINT197_STATUS:
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
> +
>   static const MemoryRegionOps aspeed_intc_ops = {
>       .read = aspeed_intc_read,
>       .write = aspeed_intc_write,
> @@ -466,6 +535,16 @@ static const MemoryRegionOps aspeed_intc_ops = {
>       }
>   };
>   
> +static const MemoryRegionOps aspeed_intcio_ops = {
> +    .read = aspeed_intcio_read,
> +    .write = aspeed_intcio_write,
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
> @@ -580,10 +659,43 @@ static const TypeInfo aspeed_2700_intc_info = {
>       .class_init = aspeed_2700_intc_class_init,
>   };
>   
> +static AspeedINTCIRQ aspeed_2700_intcio_irqs[ASPEED_INTC_MAX_INPINS] = {
> +    {0, 0, 1, R_GICINT192_EN, R_GICINT192_STATUS},
> +    {1, 1, 1, R_GICINT193_EN, R_GICINT193_STATUS},
> +    {2, 2, 1, R_GICINT194_EN, R_GICINT194_STATUS},
> +    {3, 3, 1, R_GICINT195_EN, R_GICINT195_STATUS},
> +    {4, 4, 1, R_GICINT196_EN, R_GICINT196_STATUS},
> +    {5, 5, 1, R_GICINT197_EN, R_GICINT197_STATUS},
> +};
> +
> +static void aspeed_2700_intcio_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    AspeedINTCClass *aic = ASPEED_INTC_CLASS(klass);
> +
> +    dc->desc = "ASPEED 2700 INTC IO Controller";
> +    aic->num_lines = 32;
> +    aic->num_inpins = 6;
> +    aic->num_outpins = 6;
> +    aic->mem_size = 0x400;
> +    aic->reg_size = 0x58;
> +    aic->reg_offset = 0x100;
> +    aic->reg_ops = &aspeed_intcio_ops;
> +    aic->irq_table = aspeed_2700_intcio_irqs;
> +    aic->irq_table_count = ARRAY_SIZE(aspeed_2700_intcio_irqs);
> +}
> +
> +static const TypeInfo aspeed_2700_intcio_info = {
> +    .name = TYPE_ASPEED_2700_INTCIO,
> +    .parent = TYPE_ASPEED_INTC,
> +    .class_init = aspeed_2700_intcio_class_init,
> +};
> +
>   static void aspeed_intc_register_types(void)
>   {
>       type_register_static(&aspeed_intc_info);
>       type_register_static(&aspeed_2700_intc_info);
> +    type_register_static(&aspeed_2700_intcio_info);
>   }
>   
>   type_init(aspeed_intc_register_types);



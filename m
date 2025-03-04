Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32455C282D2
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 06:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpMAh-0002Kc-BP; Tue, 04 Mar 2025 01:54:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=B2sr=VX=kaod.org=clg@ozlabs.org>)
 id 1tpM8x-0001vB-Dy; Tue, 04 Mar 2025 01:52:49 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=B2sr=VX=kaod.org=clg@ozlabs.org>)
 id 1tpM8r-0004wa-WB; Tue, 04 Mar 2025 01:52:41 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Z6RFY5kCXz4x89;
 Tue,  4 Mar 2025 17:52:33 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Z6RFV1bN6z4x3q;
 Tue,  4 Mar 2025 17:52:29 +1100 (AEDT)
Message-ID: <e4e07368-9628-4346-abc0-d8a5d0563bc4@kaod.org>
Date: Tue, 4 Mar 2025 07:52:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/23] hw/intc/aspeed: Introduce AspeedINTCIRQ
 structure to save the irq index and register address
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20250303095457.2337631-1-jamin_lin@aspeedtech.com>
 <20250303095457.2337631-13-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250303095457.2337631-13-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
> The INTC controller supports GICINT128 to GICINT136, mapping 1:1 to input and
> output IRQs 0 to 8. Previously, the formula "address & 0x0f00" was used to
> derive the IRQ index numbers.
> 
> However, the INTC controller also supports GICINT192_201, mapping 1 input IRQ
> pin to 10 output IRQ pins. The pin numbers for input and output are different.
> It is difficult to use a formula to determine the index number of INTC model
> supported input and output IRQs.
> 
> To simplify and improve readability, introduces the AspeedINTCIRQ structure to
> save the input/output IRQ index and its enable/status register address.
> 
> Introduce the "aspeed_2700_intc_irqs" table to store IRQ information for INTC.
> Introduce the "aspeed_intc_get_irq" function to retrieve the input/output IRQ
> pin index from the provided status/enable register address.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/intc/aspeed_intc.h |  10 +++
>   hw/intc/aspeed_intc.c         | 120 ++++++++++++++++++++--------------
>   2 files changed, 82 insertions(+), 48 deletions(-)
> 
> diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
> index f9a0273f78..112a01f402 100644
> --- a/include/hw/intc/aspeed_intc.h
> +++ b/include/hw/intc/aspeed_intc.h
> @@ -20,6 +20,14 @@ OBJECT_DECLARE_TYPE(AspeedINTCState, AspeedINTCClass, ASPEED_INTC)
>   #define ASPEED_INTC_MAX_INPINS 9
>   #define ASPEED_INTC_MAX_OUTPINS 9
>   
> +typedef struct AspeedINTCIRQ {
> +    int inpin_idx;
> +    int outpin_idx;
> +    int num_outpins;
> +    uint32_t enable_addr;
> +    uint32_t status_addr;

The _addr suffix is confusing. Doesn't it refer to a register index ?

> +} AspeedINTCIRQ;
> +
>   struct AspeedINTCState {
>       /*< private >*/
>       SysBusDevice parent_obj;
> @@ -47,6 +55,8 @@ struct AspeedINTCClass {
>       uint64_t reg_size;
>       uint64_t reg_offset;
>       const MemoryRegionOps *reg_ops;
> +    const AspeedINTCIRQ *irq_table;
> +    int irq_table_count;
>   };
>   
>   #endif /* ASPEED_INTC_H */
> diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
> index 9bc3e089d8..5730a7604d 100644
> --- a/hw/intc/aspeed_intc.c
> +++ b/hw/intc/aspeed_intc.c
> @@ -40,7 +40,23 @@ REG32(GICINT135_STATUS,     0x704)
>   REG32(GICINT136_EN,         0x800)
>   REG32(GICINT136_STATUS,     0x804)
>   
> -#define GICINT_STATUS_BASE     R_GICINT128_STATUS
> +static const AspeedINTCIRQ *aspeed_intc_get_irq(AspeedINTCClass *aic,
> +                                                uint32_t addr)
> +{
> +    int i;
> +
> +    for (i = 0; i < aic->irq_table_count; i++) {
> +        if (aic->irq_table[i].enable_addr == addr ||
> +            aic->irq_table[i].status_addr == addr) {
> +            return &aic->irq_table[i];
> +        }
> +    }
> +
> +    /*
> +     * Invalid addr.
> +     */
> +    g_assert_not_reached();
> +}
>   
>   /*
>    * Update the state of an interrupt controller pin by setting
> @@ -81,15 +97,10 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
>       AspeedINTCState *s = (AspeedINTCState *)opaque;
>       AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
>       const char *name = object_get_typename(OBJECT(s));
> -    uint32_t status_addr = GICINT_STATUS_BASE + ((0x100 * irq) >> 2);
> +    const AspeedINTCIRQ *intc_irq;
>       uint32_t select = 0;
>       uint32_t enable;
>       int i;
> -    int inpin_idx;
> -    int outpin_idx;
> -
> -    inpin_idx = irq;
> -    outpin_idx = irq;
>   
>       if (irq >= aic->num_inpins) {
>           qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid input pin index: %d\n",
> @@ -97,15 +108,16 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
>           return;
>       }
>   
> -    trace_aspeed_intc_set_irq(name, inpin_idx, level);
> -    enable = s->enable[inpin_idx];
> +    intc_irq = &aic->irq_table[irq];
> +    trace_aspeed_intc_set_irq(name, intc_irq->inpin_idx, level);
> +    enable = s->enable[intc_irq->inpin_idx];
>   
>       if (!level) {
>           return;
>       }
>   
>       for (i = 0; i < aic->num_lines; i++) {
> -        if (s->orgates[inpin_idx].levels[i]) {
> +        if (s->orgates[intc_irq->inpin_idx].levels[i]) {
>               if (enable & BIT(i)) {
>                   select |= BIT(i);
>               }
> @@ -118,7 +130,7 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
>   
>       trace_aspeed_intc_select(name, select);
>   
> -    if (s->mask[inpin_idx] || s->regs[status_addr]) {
> +    if (s->mask[intc_irq->inpin_idx] || s->regs[intc_irq->status_addr]) {
>           /*
>            * a. mask is not 0 means in ISR mode
>            * sources interrupt routine are executing.
> @@ -127,17 +139,19 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
>            *
>            * save source interrupt to pending variable.
>            */
> -        s->pending[inpin_idx] |= select;
> -        trace_aspeed_intc_pending_irq(name, inpin_idx, s->pending[inpin_idx]);
> +        s->pending[intc_irq->inpin_idx] |= select;
> +        trace_aspeed_intc_pending_irq(name, intc_irq->inpin_idx,
> +                                      s->pending[intc_irq->inpin_idx]);
>       } else {
>           /*
>            * notify firmware which source interrupt are coming
>            * by setting status register
>            */
> -        s->regs[status_addr] = select;
> -        trace_aspeed_intc_trigger_irq(name, inpin_idx, outpin_idx,
> -                                      s->regs[status_addr]);
> -        aspeed_intc_update(s, inpin_idx, outpin_idx, 1);
> +        s->regs[intc_irq->status_addr] = select;
> +        trace_aspeed_intc_trigger_irq(name, intc_irq->inpin_idx,
> +                                      intc_irq->outpin_idx,
> +                                      s->regs[intc_irq->status_addr]);
> +        aspeed_intc_update(s, intc_irq->inpin_idx, intc_irq->outpin_idx, 1);
>       }
>   }
>   
> @@ -146,19 +160,17 @@ static void aspeed_intc_enable_handler(AspeedINTCState *s, hwaddr offset,
>   {
>       AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
>       const char *name = object_get_typename(OBJECT(s));
> +    const AspeedINTCIRQ *intc_irq;
>       uint32_t addr = offset >> 2;
>       uint32_t old_enable;
>       uint32_t change;
> -    uint32_t irq;
> -    int inpin_idx;
>   
> -    irq = (offset & 0x0f00) >> 8;
> -    inpin_idx = irq;
> +    intc_irq = aspeed_intc_get_irq(aic, addr);

I would keep the 'inpin_idx' variable and assign it to 'intc_irq->inpin_idx'.
This would reduce the number of change.


> -    if (inpin_idx >= aic->num_inpins) {
> +    if (intc_irq->inpin_idx >= aic->num_inpins) {

Since both values are defined at compile time, shouldn't that be an assert ?

>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "%s: Invalid input pin index: %d\n",
> -                      __func__, inpin_idx);
> +                      __func__, intc_irq->inpin_idx);
>           return;
>       }
>   
> @@ -169,17 +181,17 @@ static void aspeed_intc_enable_handler(AspeedINTCState *s, hwaddr offset,
>        */
>   
>       /* disable all source interrupt */
> -    if (!data && !s->enable[inpin_idx]) {
> +    if (!data && !s->enable[intc_irq->inpin_idx]) {
>           s->regs[addr] = data;
>           return;
>       }
>   
> -    old_enable = s->enable[inpin_idx];
> -    s->enable[inpin_idx] |= data;
> +    old_enable = s->enable[intc_irq->inpin_idx];
> +    s->enable[intc_irq->inpin_idx] |= data;
>   
>       /* enable new source interrupt */
> -    if (old_enable != s->enable[inpin_idx]) {
> -        trace_aspeed_intc_enable(name, s->enable[inpin_idx]);
> +    if (old_enable != s->enable[intc_irq->inpin_idx]) {
> +        trace_aspeed_intc_enable(name, s->enable[intc_irq->inpin_idx]);
>           s->regs[addr] = data;
>           return;
>       }
> @@ -187,11 +199,11 @@ static void aspeed_intc_enable_handler(AspeedINTCState *s, hwaddr offset,
>       /* mask and unmask source interrupt */
>       change = s->regs[addr] ^ data;
>       if (change & data) {
> -        s->mask[inpin_idx] &= ~change;
> -        trace_aspeed_intc_unmask(name, change, s->mask[inpin_idx]);
> +        s->mask[intc_irq->inpin_idx] &= ~change;
> +        trace_aspeed_intc_unmask(name, change, s->mask[intc_irq->inpin_idx]);
>       } else {
> -        s->mask[inpin_idx] |= change;
> -        trace_aspeed_intc_mask(name, change, s->mask[inpin_idx]);
> +        s->mask[intc_irq->inpin_idx] |= change;
> +        trace_aspeed_intc_mask(name, change, s->mask[intc_irq->inpin_idx]);
>       }
>   
>       s->regs[addr] = data;
> @@ -202,24 +214,20 @@ static void aspeed_intc_status_handler(AspeedINTCState *s, hwaddr offset,
>   {
>       AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
>       const char *name = object_get_typename(OBJECT(s));
> +    const AspeedINTCIRQ *intc_irq;
>       uint32_t addr = offset >> 2;
> -    uint32_t irq;
> -    int inpin_idx;
> -    int outpin_idx;


I would keep both these variables to reduce the number of changes.


Thanks,

C.


>       if (!data) {
>           qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid data 0\n", __func__);
>           return;
>       }
>   
> -    irq = (offset & 0x0f00) >> 8;
> -    inpin_idx = irq;
> -    outpin_idx = irq;
> +    intc_irq = aspeed_intc_get_irq(aic, addr);
>   
> -    if (inpin_idx >= aic->num_inpins) {
> +    if (intc_irq->inpin_idx >= aic->num_inpins) {
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "%s: Invalid input pin index: %d\n",
> -                      __func__, inpin_idx);
> +                      __func__, intc_irq->inpin_idx);
>           return;
>       }
>   
> @@ -238,22 +246,24 @@ static void aspeed_intc_status_handler(AspeedINTCState *s, hwaddr offset,
>   
>       /* All source ISR execution are done */
>       if (!s->regs[addr]) {
> -        trace_aspeed_intc_all_isr_done(name, inpin_idx);
> -        if (s->pending[inpin_idx]) {
> +        trace_aspeed_intc_all_isr_done(name, intc_irq->inpin_idx);
> +        if (s->pending[intc_irq->inpin_idx]) {
>               /*
>                * handle pending source interrupt
>                * notify firmware which source interrupt are pending
>                * by setting status register
>                */
> -            s->regs[addr] = s->pending[inpin_idx];
> -            s->pending[inpin_idx] = 0;
> -            trace_aspeed_intc_trigger_irq(name, inpin_idx, outpin_idx,
> +            s->regs[addr] = s->pending[intc_irq->inpin_idx];
> +            s->pending[intc_irq->inpin_idx] = 0;
> +            trace_aspeed_intc_trigger_irq(name, intc_irq->inpin_idx,
> +                                          intc_irq->outpin_idx,
>                                             s->regs[addr]);
> -            aspeed_intc_update(s, inpin_idx, outpin_idx, 1);
> +            aspeed_intc_update(s, intc_irq->inpin_idx, intc_irq->outpin_idx, 1);
>           } else {
>               /* clear irq */
> -            trace_aspeed_intc_clear_irq(name, inpin_idx, outpin_idx, 0);
> -            aspeed_intc_update(s, inpin_idx, outpin_idx, 0);
> +            trace_aspeed_intc_clear_irq(name, intc_irq->inpin_idx,
> +                                        intc_irq->outpin_idx, 0);
> +            aspeed_intc_update(s, intc_irq->inpin_idx, intc_irq->outpin_idx, 0);
>           }
>       }
>   }
> @@ -416,6 +426,18 @@ static const TypeInfo aspeed_intc_info = {
>       .abstract = true,
>   };
>   
> +static AspeedINTCIRQ aspeed_2700_intc_irqs[ASPEED_INTC_MAX_INPINS] = {
> +    {0, 0, 1, R_GICINT128_EN, R_GICINT128_STATUS},
> +    {1, 1, 1, R_GICINT129_EN, R_GICINT129_STATUS},
> +    {2, 2, 1, R_GICINT130_EN, R_GICINT130_STATUS},
> +    {3, 3, 1, R_GICINT131_EN, R_GICINT131_STATUS},
> +    {4, 4, 1, R_GICINT132_EN, R_GICINT132_STATUS},
> +    {5, 5, 1, R_GICINT133_EN, R_GICINT133_STATUS},
> +    {6, 6, 1, R_GICINT134_EN, R_GICINT134_STATUS},
> +    {7, 7, 1, R_GICINT135_EN, R_GICINT135_STATUS},
> +    {8, 8, 1, R_GICINT136_EN, R_GICINT136_STATUS},
> +};
> +
>   static void aspeed_2700_intc_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -428,6 +450,8 @@ static void aspeed_2700_intc_class_init(ObjectClass *klass, void *data)
>       aic->mem_size = 0x4000;
>       aic->reg_size = 0x808;
>       aic->reg_offset = 0x1000;
> +    aic->irq_table = aspeed_2700_intc_irqs;
> +    aic->irq_table_count = ARRAY_SIZE(aspeed_2700_intc_irqs);
>   }
>   
>   static const TypeInfo aspeed_2700_intc_info = {



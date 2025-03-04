Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD08DC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 07:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpMbx-0004qA-Gz; Tue, 04 Mar 2025 02:22:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=B2sr=VX=kaod.org=clg@ozlabs.org>)
 id 1tpMbP-0004e2-O4; Tue, 04 Mar 2025 02:22:08 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=B2sr=VX=kaod.org=clg@ozlabs.org>)
 id 1tpMbL-00066a-JS; Tue, 04 Mar 2025 02:22:07 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Z6RvT6Ttlz4x7G;
 Tue,  4 Mar 2025 18:21:57 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Z6RvQ1X1Yz4wgp;
 Tue,  4 Mar 2025 18:21:53 +1100 (AEDT)
Message-ID: <cd85ca38-522f-4401-b441-0206f0fee311@kaod.org>
Date: Tue, 4 Mar 2025 08:21:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/23] hw/intc/aspeed: Add Support for Multi-Output IRQ
 Handling
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20250303095457.2337631-1-jamin_lin@aspeedtech.com>
 <20250303095457.2337631-15-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250303095457.2337631-15-jamin_lin@aspeedtech.com>
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
> This update introduces support for handling multi-output IRQs in the AST2700
> interrupt controller (INTC), specifically for GICINT192_201. GICINT192_201 maps
> 1:10 to input IRQ 0 and output IRQs 0 to 9. Each status bit corresponds to a
> specific IRQ.
> 
> Implemented "aspeed_intc_set_irq_handler_multi_outpins" to handle IRQs with
> multiple output pins. Introduced "aspeed_intc_status_handler_multi_outpins"
> for managing status registers associated with multi-output IRQs.
> 
> Added new IRQ definitions for GICINT192_201 in INTC.
> Adjusted the IRQ array to accommodate 10 input pins and 19 output pins,
> aligning with the new GICINT192_201 mappings.
> 
>                     |------------------------------|
>                     |            INTC              |
>                     |inpin[0:0]--------->outpin[0] |
>                     |inpin[0:1]--------->outpin[1] |
>                     |inpin[0:2]--------->outpin[2] |
>                     |inpin[0:3]--------->outpin[3] |
> orgates[0]-------> |inpin[0:4]--------->outpin[4] |
>                     |inpin[0:5]--------->outpin[5] |
>                     |inpin[0:6]--------->outpin[6] |
>                     |inpin[0:7]--------->outpin[7] |
>                     |inpin[0:8]--------->outpin[8] |
>                     |inpin[0:9]--------->outpin[9] |
>                     |                              |
>   orgates[1]------> |inpin[1]----------->outpin[10]|
>   orgates[2]------> |inpin[2]----------->outpin[11]|
>   orgates[3]------> |inpin[3]----------->outpin[12]|
>   orgates[4]------> |inpin[4]----------->outpin[13]|
>   orgates[5]------> |inpin[5]----------->outpin[14]|
>   orgates[6]------> |inpin[6]----------->outpin[15]|
>   orgates[7]------> |inpin[7]----------->outpin[16]|
>   orgates[8]------> |inpin[8]----------->outpin[17]|
>   orgates[9]------> |inpin[9]----------->outpin[18]|
>                     |------------------------------|
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/intc/aspeed_intc.h |   6 +-
>   hw/intc/aspeed_intc.c         | 144 ++++++++++++++++++++++++++++++----
>   hw/intc/trace-events          |   1 +
>   3 files changed, 133 insertions(+), 18 deletions(-)
> 
> diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
> index 112a01f402..21d9398933 100644
> --- a/include/hw/intc/aspeed_intc.h
> +++ b/include/hw/intc/aspeed_intc.h
> @@ -16,9 +16,9 @@
>   #define TYPE_ASPEED_2700_INTC TYPE_ASPEED_INTC "-ast2700"
>   OBJECT_DECLARE_TYPE(AspeedINTCState, AspeedINTCClass, ASPEED_INTC)
>   
> -#define ASPEED_INTC_NR_REGS (0x808 >> 2)
> -#define ASPEED_INTC_MAX_INPINS 9
> -#define ASPEED_INTC_MAX_OUTPINS 9
> +#define ASPEED_INTC_NR_REGS (0xB08 >> 2)
> +#define ASPEED_INTC_MAX_INPINS 10
> +#define ASPEED_INTC_MAX_OUTPINS 19
>   
>   typedef struct AspeedINTCIRQ {
>       int inpin_idx;
> diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
> index 99077ec72d..18521d3eb0 100644
> --- a/hw/intc/aspeed_intc.c
> +++ b/hw/intc/aspeed_intc.c
> @@ -39,6 +39,8 @@ REG32(GICINT135_EN,         0x700)
>   REG32(GICINT135_STATUS,     0x704)
>   REG32(GICINT136_EN,         0x800)
>   REG32(GICINT136_STATUS,     0x804)
> +REG32(GICINT192_201_EN,         0xB00)
> +REG32(GICINT192_201_STATUS,     0xB04)
>   
>   static const AspeedINTCIRQ *aspeed_intc_get_irq(AspeedINTCClass *aic,
>                                                   uint32_t addr)
> @@ -117,9 +119,48 @@ static void aspeed_intc_set_irq_handler(AspeedINTCState *s,
>       }
>   }
>   
> +static void aspeed_intc_set_irq_handler_multi_outpins(AspeedINTCState *s,
> +                                 const AspeedINTCIRQ *intc_irq, uint32_t select)
> +{
> +    const char *name = object_get_typename(OBJECT(s));
> +    int i;
> +
> +    for (i = 0; i < intc_irq->num_outpins; i++) {
> +        if (select & BIT(i)) {
> +            if (s->mask[intc_irq->inpin_idx] & BIT(i) ||
> +                s->regs[intc_irq->status_addr] & BIT(i)) {
> +                /*
> +                 * a. mask bit is not 0 means in ISR mode sources interrupt
> +                 * routine are executing.
> +                 * b. status bit is not 0 means previous source interrupt
> +                 * does not be executed, yet.
> +                 *
> +                 * save source interrupt to pending bit.
> +                 */
> +                 s->pending[intc_irq->inpin_idx] |= BIT(i);
> +                 trace_aspeed_intc_pending_irq(name, intc_irq->inpin_idx,
> +                                               s->pending[intc_irq->inpin_idx]);
> +            } else {
> +                /*
> +                 * notify firmware which source interrupt are coming
> +                 * by setting status bit
> +                 */
> +                s->regs[intc_irq->status_addr] |= BIT(i);
> +                trace_aspeed_intc_trigger_irq(name, intc_irq->inpin_idx,
> +                                              intc_irq->outpin_idx + i,
> +                                              s->regs[intc_irq->status_addr]);
> +                aspeed_intc_update(s, intc_irq->inpin_idx,
> +                                   intc_irq->outpin_idx + i, 1);> +            }
> +        }
> +    }
> +}
> +
>   /*
> - * GICINT128 to GICINT136 map 1:1 to input and output IRQs 0 to 8.
> - * The value of input IRQ should be between 0 and the number of inputs.
> + * GICINT192_201 maps 1:10 to input IRQ 0 and output IRQs 0 to 9.
> + * GICINT128 to GICINT136 map 1:1 to input IRQs 1 to 9 and output
> + * IRQs 10 to 18. The value of input IRQ should be between 0 and
> + * the number of input pins.
>    */
>   static void aspeed_intc_set_irq(void *opaque, int irq, int level)
>   {
> @@ -158,7 +199,11 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
>       }
>   
>       trace_aspeed_intc_select(name, select);
> -    aspeed_intc_set_irq_handler(s, intc_irq, select);
> +    if (intc_irq->num_outpins > 1) {
> +        aspeed_intc_set_irq_handler_multi_outpins(s, intc_irq, select);
> +    } else {
> +        aspeed_intc_set_irq_handler(s, intc_irq, select);
> +    }
>   }
>   
>   static void aspeed_intc_enable_handler(AspeedINTCState *s, hwaddr offset,
> @@ -274,6 +319,70 @@ static void aspeed_intc_status_handler(AspeedINTCState *s, hwaddr offset,
>       }
>   }
>   
> +static void aspeed_intc_status_handler_multi_outpins(AspeedINTCState *s,
> +                                                hwaddr offset, uint64_t data)
> +{
> +    AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
> +    const char *name = object_get_typename(OBJECT(s));
> +    const AspeedINTCIRQ *intc_irq;
> +    uint32_t addr = offset >> 2;

variable 'addr' here is a register index. I think 'reg' would be a better
name.

> +    int i;
> +
> +    if (!data) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid data 0\n", __func__);
> +        return;
> +    }
> +
> +    intc_irq = aspeed_intc_get_irq(aic, addr);
> +
> +    if (intc_irq->inpin_idx >= aic->num_inpins) {

Since both values are defined at compile time, shouldn't that be an assert ?


Thanks,

C.



> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Invalid input pin index: %d\n",
> +                      __func__,  intc_irq->inpin_idx);
> +        return;
> +    }
> +
> +    /* clear status */
> +    s->regs[addr] &= ~data;> +> +    /*
> +     * The status registers are used for notify sources ISR are executed.
> +     * If one source ISR is executed, it will clear one bit.
> +     * If it clear all bits, it means to initialize this register status
> +     * rather than sources ISR are executed.
> +     */
> +    if (data == 0xffffffff) {
> +        return;
> +    }
> +
> +    for (i = 0; i < intc_irq->num_outpins; i++) {
> +        /* All source ISR executions are done from a specific bit */
> +        if (data & BIT(i)) {
> +            trace_aspeed_intc_all_isr_done_bit(name, intc_irq->inpin_idx, i);
> +            if (s->pending[intc_irq->inpin_idx] & BIT(i)) {
> +                /*
> +                 * Handle pending source interrupt.
> +                 * Notify firmware which source interrupt is pending
> +                 * by setting the status bit.
> +                 */
> +                s->regs[addr] |= BIT(i);
> +                s->pending[intc_irq->inpin_idx] &= ~BIT(i);
> +                trace_aspeed_intc_trigger_irq(name, intc_irq->inpin_idx,
> +                                              intc_irq->outpin_idx + i,
> +                                              s->regs[addr]);
> +                aspeed_intc_update(s, intc_irq->inpin_idx,
> +                                   intc_irq->outpin_idx + i, 1);
> +            } else {
> +                /* clear irq for the specific bit */
> +                trace_aspeed_intc_clear_irq(name, intc_irq->inpin_idx,
> +                                            intc_irq->outpin_idx + i, 0);
> +                aspeed_intc_update(s, intc_irq->inpin_idx,
> +                                   intc_irq->outpin_idx + i, 0);
> +            }
> +        }
> +    }
> +}
> +
>   static uint64_t aspeed_intc_read(void *opaque, hwaddr offset, unsigned int size)
>   {
>       AspeedINTCState *s = ASPEED_INTC(opaque);
> @@ -322,6 +431,7 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
>       case R_GICINT134_EN:
>       case R_GICINT135_EN:
>       case R_GICINT136_EN:
> +    case R_GICINT192_201_EN:
>           aspeed_intc_enable_handler(s, offset, data);
>           break;
>       case R_GICINT128_STATUS:
> @@ -335,6 +445,9 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
>       case R_GICINT136_STATUS:
>           aspeed_intc_status_handler(s, offset, data);
>           break;
> +    case R_GICINT192_201_STATUS:
> +        aspeed_intc_status_handler_multi_outpins(s, offset, data);
> +        break;
>       default:
>           s->regs[addr] = data;
>           break;
> @@ -433,15 +546,16 @@ static const TypeInfo aspeed_intc_info = {
>   };
>   
>   static AspeedINTCIRQ aspeed_2700_intc_irqs[ASPEED_INTC_MAX_INPINS] = {
> -    {0, 0, 1, R_GICINT128_EN, R_GICINT128_STATUS},
> -    {1, 1, 1, R_GICINT129_EN, R_GICINT129_STATUS},
> -    {2, 2, 1, R_GICINT130_EN, R_GICINT130_STATUS},
> -    {3, 3, 1, R_GICINT131_EN, R_GICINT131_STATUS},
> -    {4, 4, 1, R_GICINT132_EN, R_GICINT132_STATUS},
> -    {5, 5, 1, R_GICINT133_EN, R_GICINT133_STATUS},
> -    {6, 6, 1, R_GICINT134_EN, R_GICINT134_STATUS},
> -    {7, 7, 1, R_GICINT135_EN, R_GICINT135_STATUS},
> -    {8, 8, 1, R_GICINT136_EN, R_GICINT136_STATUS},
> +    {0, 0, 10, R_GICINT192_201_EN, R_GICINT192_201_STATUS},
> +    {1, 10, 1, R_GICINT128_EN, R_GICINT128_STATUS},
> +    {2, 11, 1, R_GICINT129_EN, R_GICINT129_STATUS},
> +    {3, 12, 1, R_GICINT130_EN, R_GICINT130_STATUS},
> +    {4, 13, 1, R_GICINT131_EN, R_GICINT131_STATUS},
> +    {5, 14, 1, R_GICINT132_EN, R_GICINT132_STATUS},
> +    {6, 15, 1, R_GICINT133_EN, R_GICINT133_STATUS},
> +    {7, 16, 1, R_GICINT134_EN, R_GICINT134_STATUS},
> +    {8, 17, 1, R_GICINT135_EN, R_GICINT135_STATUS},
> +    {9, 18, 1, R_GICINT136_EN, R_GICINT136_STATUS},
>   };
>   
>   static void aspeed_2700_intc_class_init(ObjectClass *klass, void *data)
> @@ -451,10 +565,10 @@ static void aspeed_2700_intc_class_init(ObjectClass *klass, void *data)
>   
>       dc->desc = "ASPEED 2700 INTC Controller";
>       aic->num_lines = 32;
> -    aic->num_inpins = 9;
> -    aic->num_outpins = 9;
> +    aic->num_inpins = 10;
> +    aic->num_outpins = 19;
>       aic->mem_size = 0x4000;
> -    aic->reg_size = 0x808;
> +    aic->reg_size = 0xB08;
>       aic->reg_offset = 0x1000;
>       aic->irq_table = aspeed_2700_intc_irqs;
>       aic->irq_table_count = ARRAY_SIZE(aspeed_2700_intc_irqs);
> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
> index e97eea820b..913197a181 100644
> --- a/hw/intc/trace-events
> +++ b/hw/intc/trace-events
> @@ -92,6 +92,7 @@ aspeed_intc_enable(const char *s, uint32_t value) "%s: Enable: 0x%x"
>   aspeed_intc_select(const char *s, uint32_t value) "%s: Select: 0x%x"
>   aspeed_intc_mask(const char *s, uint32_t change, uint32_t value) "%s: Mask: 0x%x: 0x%x"
>   aspeed_intc_unmask(const char *s, uint32_t change, uint32_t value) "%s: UnMask: 0x%x: 0x%x"
> +aspeed_intc_all_isr_done_bit(const char *s, int inpin_idx, int bit) "%s: All source ISR execution are done from specific bit: %d-%d"
>   
>   # arm_gic.c
>   gic_enable_irq(int irq) "irq %d enabled"



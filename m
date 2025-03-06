Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A851FC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqCmC-0004qN-0g; Thu, 06 Mar 2025 10:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=VCYv=VZ=kaod.org=clg@ozlabs.org>)
 id 1tqClp-0004kA-Tt; Thu, 06 Mar 2025 10:04:23 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=VCYv=VZ=kaod.org=clg@ozlabs.org>)
 id 1tqCln-00086m-Df; Thu, 06 Mar 2025 10:04:21 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Z7t4073gjz4x6n;
 Fri,  7 Mar 2025 02:04:16 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Z7t3x3jDpz4wcd;
 Fri,  7 Mar 2025 02:04:13 +1100 (AEDT)
Message-ID: <84dfe23f-d66d-4fa5-a87d-704ef2bb4d3e@kaod.org>
Date: Thu, 6 Mar 2025 16:04:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/29] hw/intc/aspeed: Rename status_addr and addr to
 status_reg and reg for clarity
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20250306103846.429221-1-jamin_lin@aspeedtech.com>
 <20250306103846.429221-3-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250306103846.429221-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=VCYv=VZ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 3/6/25 11:38, Jamin Lin wrote:
> Rename the variables "status_addr" to "status_reg" and "addr" to "reg" because
> they are used as register index. This change makes the code more appropriate
> and improves readability.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/intc/aspeed_intc.c | 38 +++++++++++++++++++-------------------
>   1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
> index 033b574c1e..465f41e4fd 100644
> --- a/hw/intc/aspeed_intc.c
> +++ b/hw/intc/aspeed_intc.c
> @@ -60,7 +60,7 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
>   {
>       AspeedINTCState *s = (AspeedINTCState *)opaque;
>       AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
> -    uint32_t status_addr = GICINT_STATUS_BASE + ((0x100 * irq) >> 2);
> +    uint32_t status_reg = GICINT_STATUS_BASE + ((0x100 * irq) >> 2);
>       uint32_t select = 0;
>       uint32_t enable;
>       int i;
> @@ -92,7 +92,7 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
>   
>       trace_aspeed_intc_select(select);
>   
> -    if (s->mask[irq] || s->regs[status_addr]) {
> +    if (s->mask[irq] || s->regs[status_reg]) {
>           /*
>            * a. mask is not 0 means in ISR mode
>            * sources interrupt routine are executing.
> @@ -108,8 +108,8 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
>            * notify firmware which source interrupt are coming
>            * by setting status register
>            */
> -        s->regs[status_addr] = select;
> -        trace_aspeed_intc_trigger_irq(irq, s->regs[status_addr]);
> +        s->regs[status_reg] = select;
> +        trace_aspeed_intc_trigger_irq(irq, s->regs[status_reg]);
>           aspeed_intc_update(s, irq, 1);
>       }
>   }
> @@ -117,17 +117,17 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
>   static uint64_t aspeed_intc_read(void *opaque, hwaddr offset, unsigned int size)
>   {
>       AspeedINTCState *s = ASPEED_INTC(opaque);
> -    uint32_t addr = offset >> 2;
> +    uint32_t reg = offset >> 2;
>       uint32_t value = 0;
>   
> -    if (addr >= ASPEED_INTC_NR_REGS) {
> +    if (reg >= ASPEED_INTC_NR_REGS) {
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx "\n",
>                         __func__, offset);
>           return 0;
>       }
>   
> -    value = s->regs[addr];
> +    value = s->regs[reg];
>       trace_aspeed_intc_read(offset, size, value);
>   
>       return value;
> @@ -138,12 +138,12 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
>   {
>       AspeedINTCState *s = ASPEED_INTC(opaque);
>       AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
> -    uint32_t addr = offset >> 2;
> +    uint32_t reg = offset >> 2;
>       uint32_t old_enable;
>       uint32_t change;
>       uint32_t irq;
>   
> -    if (addr >= ASPEED_INTC_NR_REGS) {
> +    if (reg >= ASPEED_INTC_NR_REGS) {
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx "\n",
>                         __func__, offset);
> @@ -152,7 +152,7 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
>   
>       trace_aspeed_intc_write(offset, size, data);
>   
> -    switch (addr) {
> +    switch (reg) {
>       case R_GICINT128_EN:
>       case R_GICINT129_EN:
>       case R_GICINT130_EN:
> @@ -177,7 +177,7 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
>   
>           /* disable all source interrupt */
>           if (!data && !s->enable[irq]) {
> -            s->regs[addr] = data;
> +            s->regs[reg] = data;
>               return;
>           }
>   
> @@ -187,12 +187,12 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
>           /* enable new source interrupt */
>           if (old_enable != s->enable[irq]) {
>               trace_aspeed_intc_enable(s->enable[irq]);
> -            s->regs[addr] = data;
> +            s->regs[reg] = data;
>               return;
>           }
>   
>           /* mask and unmask source interrupt */
> -        change = s->regs[addr] ^ data;
> +        change = s->regs[reg] ^ data;
>           if (change & data) {
>               s->mask[irq] &= ~change;
>               trace_aspeed_intc_unmask(change, s->mask[irq]);
> @@ -200,7 +200,7 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
>               s->mask[irq] |= change;
>               trace_aspeed_intc_mask(change, s->mask[irq]);
>           }
> -        s->regs[addr] = data;
> +        s->regs[reg] = data;
>           break;
>       case R_GICINT128_STATUS:
>       case R_GICINT129_STATUS:
> @@ -220,7 +220,7 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
>           }
>   
>           /* clear status */
> -        s->regs[addr] &= ~data;
> +        s->regs[reg] &= ~data;
>   
>           /*
>            * These status registers are used for notify sources ISR are executed.
> @@ -233,7 +233,7 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
>           }
>   
>           /* All source ISR execution are done */
> -        if (!s->regs[addr]) {
> +        if (!s->regs[reg]) {
>               trace_aspeed_intc_all_isr_done(irq);
>               if (s->pending[irq]) {
>                   /*
> @@ -241,9 +241,9 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
>                    * notify firmware which source interrupt are pending
>                    * by setting status register
>                    */
> -                s->regs[addr] = s->pending[irq];
> +                s->regs[reg] = s->pending[irq];
>                   s->pending[irq] = 0;
> -                trace_aspeed_intc_trigger_irq(irq, s->regs[addr]);
> +                trace_aspeed_intc_trigger_irq(irq, s->regs[reg]);
>                   aspeed_intc_update(s, irq, 1);
>               } else {
>                   /* clear irq */
> @@ -253,7 +253,7 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
>           }
>           break;
>       default:
> -        s->regs[addr] = data;
> +        s->regs[reg] = data;
>           break;
>       }
>   



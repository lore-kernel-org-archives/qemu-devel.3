Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6D1C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 03:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wePUd-0000XP-6m; Mon, 29 Jun 2026 23:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wePUa-0000Wm-3K
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 23:50:36 -0400
Received: from smtpout2.mo539.mail-out.ovh.net ([51.210.91.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wePUW-0008VL-D0
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 23:50:34 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo539.mail-out.ovh.net (Postfix) with ESMTPS id 4gq8LS4YFhz46tm;
 Tue, 30 Jun 2026 03:50:24 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue, 30 Jun 2026 03:50:23 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.168.213])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gq8LR6SvJz1xpK; Tue, 30 Jun 2026 03:50:23 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.6])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 8E999941911; 
 Tue, 30 Jun 2026 03:50:22 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004d12d8363-88de-49e2-998a-89ea31c4feb1,
 C9F07EB534A46111D337A1875201B4A1724CF27E) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <2cce4512-a223-4821-96c3-77d13942c58f@kaod.org>
Date: Tue, 30 Jun 2026 05:50:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/aspeed: Drop stale pending interrupts
To: Jian Zhang <zhangjian.3032@bytedance.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20260612060857.1842819-1-zhangjian.3032@bytedance.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260612060857.1842819-1-zhangjian.3032@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 4395231762908883979
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF4MqoRfwo5ZBUlMv64NkhJEVqkU03kdRcOceAzit+hbGigv22RHLEzTisTNkR7OZTmxsziJSfmo0PCKH+qRv0sGx4ht7UTQCAqUzhn5Te7qKLq6TjcS+ZaKwXxVGMqmErT8INdNPb/JlwuncX0ra6qoMbEHMucQuNWwIKKx/speLe5hgpMC9rDYLxXAWWn8/XoN8d2WWitwsoEBk/sm4ivrycBH4Bocl+42uhTM9AS/871T0idcZwoZeptFwoHQlKiUW16QlK15OGP11Q/WKRZf7Qoy8cAwd34yKLd3Z2USTRfTtYQ7wZFDaG6lC1pxTGVm2ZzA5eMKL2I8/CzVDEEO4vIGyRfRg/4QFwBCihET5ZuJ05eiQ9IS5lgL4cpaBWhBcLEI3KGb8bKfXKO5Lyd+8vGXAC50iiX3V19asTcQ6MAdSXXaE7/AjivElP35Z2TFCVKy9YbJf+JQ5XQqLxYJOVrLHe1Sv9aO6nTMlVu72EJFb5qzYMKGLi45Aja1Yil2pHEYggMh65aDNM8w3Mskqz+/zRpBOJrnE87H4oStsXUf1NtkLKiKofhXU2lOK9+VX+2GZlJe4aPQ1fil+SR9WJHR3rDbZaBVMbh+zGJnM+q4tgPoYzTl0eYPeP2qbA+lCqwn1m9HQPqtnmAoGuCcVKR9/IwGxXHL9Kh8EoznQ
DKIM-Signature: a=rsa-sha256; bh=bJS1X0Z9NZuLmMWvBbxplkX8AKkcx/lOcKcPARktfOw=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1782791425; v=1;
 b=UxUB2TRD6B/tyAbplNz3H0Q0dPJkVXdJzmBXtCuSbQeJqKt4jQ2Ngf+wkYtpSgiLjz4KcNDr
 hDNRLP0kh5c9abWj0iZfcwh2OV6KfxprJ+0qTZNdnH+PBEGtsgOO2y4cmI6kIwi6G3u/Ll3vR2e
 YCSQzjJWB9J2s5JGtPT7l4Z1Asnn6u5CXKnP+vaERRVcaVhXf45k2FlFaF9S71J4Qx9PZXzhspk
 subFdslje6ElUBCZ0uCva+13mB+wglTWqZlY+uEz+zulVTPT1xqCF8fGk4Nn7t0Ak3WFFxdiiE3
 6zAoQdOXP9SZlBe1A9TNb7eyBw9MvaJtXyaz+zbnxvNGg==
Received-SPF: pass client-ip=51.210.91.41; envelope-from=clg@kaod.org;
 helo=smtpout2.mo539.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 6/12/26 08:08, Jian Zhang wrote:
> The Aspeed INTC records an interrupt source in the pending bitmap when
> the source is masked or another status bit is still being handled.  When
> the guest later clears the status register, the model promotes all saved
> pending bits back to status unconditionally.
> 
> This is not correct for level-triggered sources.  A source can deassert
> while another source connected to the same OR gate keeps the aggregated
> INTC line asserted.  Promoting the stale bit later makes the guest demux
> a child interrupt whose device status has already been cleared.
> 
> This is visible on AST2700 I2C, where the I2C buses are aggregated
> through INTCIO GICINT194 before reaching the GIC.  A stale I2C source bit
> can be promoted back to the INTCIO status register, causing Linux to run
> the corresponding I2C ISR with an empty I2C interrupt status register.
> For example, the Linux aspeed-i2c debug ring shows a transfer that first
> receives a valid status interrupt, then receives a spurious ISR with both
> isr and raw status equal to zero.  The zero-status ISR clears the saved
> command error and the transfer completes with ret=0:
> 
>    event=start isr=0x00000000 raw=0x00000000 cmd_err=0 msgs_idx=0
>    event=isr   isr=0x00010011 raw=0x00010011 cmd_err=0 msgs_idx=0
>    event=isr   isr=0x00000000 raw=0x00000000 cmd_err=1 msgs_idx=1
>    event=complete ret=0 cmd_err=0 msgs_idx=1
> 
> A normal command can then be reported as zero transferred messages, which
> is converted to -EIO by Linux i2c_smbus_xfer_emulated().  The race is
> more likely when multiple I2C buses are accessed concurrently.
> 
> Drop pending bits that no longer correspond to an asserted and enabled
> source before they can be promoted back to status.
> 
> Signed-off-by: Jian Zhang <zhangjian.3032@bytedance.com>


This looks correct to me.

Jamin, could you take a look please ?

Thanks,

C.



> ---
>   hw/intc/aspeed_intc.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
> index 5a36fff5204..ab80c239bc1 100644
> --- a/hw/intc/aspeed_intc.c
> +++ b/hw/intc/aspeed_intc.c
> @@ -107,6 +107,27 @@ static const AspeedINTCIRQ *aspeed_intc_get_irq(AspeedINTCClass *aic,
>       g_assert_not_reached();
>   }
>   
> +static uint32_t aspeed_intc_orgate_levels(AspeedINTCState *s, int inpin_idx)
> +{
> +    AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
> +    uint32_t levels = 0;
> +    int i;
> +
> +    for (i = 0; i < aic->num_lines && i < 32; i++) {
> +        if (s->orgates[inpin_idx].levels[i]) {
> +            levels |= BIT(i);
> +        }
> +    }
> +
> +    return levels;
> +}
> +
> +static void aspeed_intc_drop_stale_pending(AspeedINTCState *s, int inpin_idx)
> +{
> +    s->pending[inpin_idx] &= aspeed_intc_orgate_levels(s, inpin_idx) &
> +                             s->enable[inpin_idx];
> +}
> +
>   /*
>    * Update the state of an interrupt controller pin by setting
>    * the specified output pin to the given level.
> @@ -231,6 +252,8 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
>       trace_aspeed_intc_set_irq(name, inpin_idx, level);
>       enable = s->enable[inpin_idx];
>   
> +    aspeed_intc_drop_stale_pending(s, inpin_idx);
> +
>       if (!level) {
>           return;
>       }
> @@ -343,6 +366,7 @@ static void aspeed_intc_status_handler(AspeedINTCState *s, hwaddr offset,
>       /* All source ISR execution are done */
>       if (!s->regs[reg]) {
>           trace_aspeed_intc_all_isr_done(name, inpin_idx);
> +        aspeed_intc_drop_stale_pending(s, inpin_idx);
>           if (s->pending[inpin_idx]) {
>               /*
>                * handle pending source interrupt
> @@ -402,6 +426,7 @@ static void aspeed_intc_status_handler_multi_outpins(AspeedINTCState *s,
>           /* All source ISR executions are done from a specific bit */
>           if (data & BIT(i)) {
>               trace_aspeed_intc_all_isr_done_bit(name, inpin_idx, i);
> +            aspeed_intc_drop_stale_pending(s, inpin_idx);
>               if (s->pending[inpin_idx] & BIT(i)) {
>                   /*
>                    * Handle pending source interrupt.



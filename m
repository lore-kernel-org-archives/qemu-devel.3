Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B776D1125858
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 17:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Nay-0002n0-8p; Wed, 11 Mar 2026 13:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w0Nan-0002lM-N0; Wed, 11 Mar 2026 13:43:35 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w0Nal-0004CT-MT; Wed, 11 Mar 2026 13:43:33 -0400
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fWJ4m0504zHnGjb;
 Thu, 12 Mar 2026 01:43:20 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 1E19F40584;
 Thu, 12 Mar 2026 01:43:28 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 11 Mar
 2026 17:43:27 +0000
Date: Wed, 11 Mar 2026 17:43:26 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 51/65] target/arm: GICv5 cpuif: Signal IRQ or FIQ
Message-ID: <20260311174326.00002f95@huawei.com>
In-Reply-To: <20260223170212.441276-52-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
 <20260223170212.441276-52-peter.maydell@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 23 Feb 2026 17:01:58 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> The CPU interface must signal IRQ or FIQ (possibly with
> superpriority) when there is a pending interrupt of sufficient
> priority available.  Implement this logic.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Another bit of triviality.  I can't find anything else ;)

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  target/arm/tcg/gicv5-cpuif.c | 91 ++++++++++++++++++++++++++++++++++--
>  target/arm/tcg/trace-events  |  1 +
>  2 files changed, 89 insertions(+), 3 deletions(-)
> 
> diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
> index 02129d5936..79203a3478 100644
> --- a/target/arm/tcg/gicv5-cpuif.c
> +++ b/target/arm/tcg/gicv5-cpuif.c

> +static void gicv5_update_irq_fiq(CPUARMState *env)
> +{
> +    /*
> +     * Update whether we are signalling IRQ or FIQ based
> +     * on the current state of the CPU interface (and in
> +     * particular on the HPPI information from the IRS and
> +     * for the PPIs for each interrupt domain);

The comment wrapping is a bit too random in here.  Perhaps give
it a once over for consistency.

> +     *
> +     * The logic here for IRQ and FIQ is defined by rules R_QLGBG
> +     * and R_ZGHMN; whether to signal with superpriority is
> +     * defined by rule R_CSBDX.
> +     *
> +     * For the moment, we do not consider preemptive interrupts,
> +     * because these only occur when there is a HPPI of
> +     * sufficient priority for another interrupt domain, and
> +     * we only support EL1 and the NonSecure interrupt domain
> +     * currently.
> +     *
> +     * NB: when we handle more than just EL1 we will need to
> +     * arrange to call this function to re-evaluate the IRQ
> +     * and FIQ state when we change EL.
> +     */
> +    GICv5PendingIrq current_hppi;
> +    bool irq, fiq, superpriority;
> +
> +    /*
> +     * We will never signal FIQ because FIQ is for
> +     * preemptive interrupts or for EL3 HPPIs.
> +     */
> +    fiq = false;
> +
> +    /*
> +     * We signal IRQ when we are not signalling FIQ and there is a
> +     * HPPI of sufficient priority for the current domain. It
> +     * has Superpriority if its priority is 0 (in which case it
> +     * is CPU_INTERRUPT_NMI rather than CPU_INTERRUPT_HARD).
> +     */
> +    current_hppi = gic_hppi(env, gicv5_current_phys_domain(env));
> +    superpriority = current_hppi.prio == 0;
> +    irq = current_hppi.prio != PRIO_IDLE && !superpriority;
> +
> +    /*
> +     * Unlike a GICv3 or GICv2, there is no external IRQ or FIQ
> +     * line to the CPU. Instead we directly signal the interrupt
> +     * via cpu_interrupt()/cpu_reset_interrupt().
> +     */
> +    trace_gicv5_update_irq_fiq(irq, fiq, superpriority);
> +    cpu_interrupt_update(env, CPU_INTERRUPT_HARD, irq);
> +    cpu_interrupt_update(env, CPU_INTERRUPT_FIQ, fiq);
> +    cpu_interrupt_update(env, CPU_INTERRUPT_NMI, superpriority);
> +}




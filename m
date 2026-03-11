Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11AD1125858
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 17:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0N8v-0005sG-2S; Wed, 11 Mar 2026 13:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w0N8s-0005rl-3r; Wed, 11 Mar 2026 13:14:42 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w0N8o-0004S7-L1; Wed, 11 Mar 2026 13:14:41 -0400
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fWHRQ3x1TzHnGjs;
 Thu, 12 Mar 2026 01:14:26 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 96BAF40572;
 Thu, 12 Mar 2026 01:14:34 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 11 Mar
 2026 17:14:34 +0000
Date: Wed, 11 Mar 2026 17:14:32 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 45/65] target/arm: GICv5 cpuif: Implement ICC_HPPIR_EL1
Message-ID: <20260311171432.00005bda@huawei.com>
In-Reply-To: <20260223170212.441276-46-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
 <20260223170212.441276-46-peter.maydell@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
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

On Mon, 23 Feb 2026 17:01:52 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> Implement ICC_HPPIR_EL1, which the guest can use to read the current
> highest priority pending interrupt.  Like APR, PCR and CR0, this is
> banked, with the _EL1 register reading the answer for the current
> logical interrupt domain, and the _EL3 register reading the answer
> for the EL3 interrupt domain.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Few formatting things...

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  hw/intc/arm_gicv5.c                | 11 ++++++
>  include/hw/intc/arm_gicv5_stream.h | 14 +++++++
>  target/arm/tcg/gicv5-cpuif.c       | 62 ++++++++++++++++++++++++++++++
>  3 files changed, 87 insertions(+)
> 
> diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
> index 070d414d67..6cb81123e5 100644
> --- a/hw/intc/arm_gicv5.c
> +++ b/hw/intc/arm_gicv5.c
> @@ -527,6 +527,17 @@ static void irs_recall_hppis(GICv5 *s, GICv5Domain domain)
>      }
>  }
>  
> +GICv5PendingIrq gicv5_get_hppi(GICv5Common *cs, GICv5Domain domain,
> +                               uint32_t iaffid)
> +{
> +    GICv5 *s = ARM_GICV5(cs);
> +

Why the blank line?

> +    int cpuidx = irs_cpuidx_from_iaffid(cs, iaffid);
> +
> +    assert(cpuidx >= 0);
> +    return s->hppi[domain][cpuidx];
> +}
> +
>  static hwaddr l1_iste_addr(GICv5Common *cs, const GICv5ISTConfig *cfg,
>                             uint32_t id)
>  {

> diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
> index 45ef80ca87..adb4d2018f 100644
> --- a/target/arm/tcg/gicv5-cpuif.c
> +++ b/target/arm/tcg/gicv5-cpuif.c

>  /*
>   * We implement 24 bits of interrupt ID, the mandated 5 bits of priority,
>   * and no legacy GICv3.3 vcpu interface (yet)
> @@ -114,6 +118,52 @@ static uint64_t gic_running_prio(CPUARMState *env, GICv5Domain domain)
>      return hap < 32 ? hap : PRIO_IDLE;
>  }
>  
> +static GICv5PendingIrq gic_hppi(CPUARMState *env, GICv5Domain domain)
> +{
> +    /*
> +     * Return the current highest priority pending

rewrap

> +     * interrupt for the specified domain, if it has sufficient
> +     * priority to preempt. The intid field of the return value
> +     * will be in the format of the ICC_HPPIR register (and will
> +     * be zero if and only if there is no interrupt that can preempt).
> +     */
> +
> +    GICv5Common *gic = gicv5_get_gic(env);
> +    GICv5PendingIrq best;
> +    GICv5PendingIrq irs_hppi;

Maybe just one line?

> +
> +    if (!(env->gicv5_cpuif.icc_cr0[domain] & R_ICC_CR0_EN_MASK)) {
> +        /* If cpuif is disabled there is no HPPI */
> +        return (GICv5PendingIrq) { .intid = 0, .prio = PRIO_IDLE };
> +    }
> +
> +    irs_hppi = gicv5_get_hppi(gic, domain, env->gicv5_iaffid);
> +
> +    /*
> +     * If the best PPI and the best interrupt from the IRS have the
> +     * same priority, it's IMPDEF which we pick (R_VVBPS). We choose
> +     * the PPI.
> +     */
> +    if (env->gicv5_cpuif.ppi_hppi[domain].prio <= irs_hppi.prio) {
> +        best = env->gicv5_cpuif.ppi_hppi[domain];
> +    } else {
> +        best = irs_hppi;
> +    }
> +
> +    /*
> +     * D_MSQKF: an interrupt has sufficient priority if its priority
> +     * is higher than the current running priority and equal to or
> +     * higher than the priority mask.
> +     */
> +    if (best.prio == PRIO_IDLE ||
> +        best.prio > env->gicv5_cpuif.icc_pcr[domain] ||
> +        best.prio >= gic_running_prio(env, domain)) {
> +        return (GICv5PendingIrq) { .intid = 0, .prio = PRIO_IDLE };
> +    }
> +    best.intid |= R_ICC_HPPIR_EL1_HPPIV_MASK;
> +    return best;
> +}



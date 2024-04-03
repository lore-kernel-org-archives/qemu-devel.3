Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE95CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 03:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrr7O-00089s-A7; Tue, 02 Apr 2024 23:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rrr7J-00086b-Oh; Tue, 02 Apr 2024 23:16:49 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rrr7F-0006iN-Sb; Tue, 02 Apr 2024 23:16:49 -0400
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4V8VFm2FxCzwR46;
 Wed,  3 Apr 2024 11:13:48 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id CFC0B14010C;
 Wed,  3 Apr 2024 11:16:35 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 11:16:35 +0800
Message-ID: <6ff19301-8791-384e-bd40-5f58058f4234@huawei.com>
Date: Wed, 3 Apr 2024 11:16:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v11 18/23] hw/intc/arm_gicv3: Handle icv_nmiar1_read() for
 icc_nmiar1_read()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
CC: <eduardo@habkost.net>, <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, 
 <wangyanan55@huawei.com>, <richard.henderson@linaro.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20240330103128.3185962-1-ruanjinjie@huawei.com>
 <20240330103128.3185962-19-ruanjinjie@huawei.com>
 <CAFEAcA_WY04voee07n6Ph606xqy=QvTkYdMyqYf5LMHUS5GcDw@mail.gmail.com>
In-Reply-To: <CAFEAcA_WY04voee07n6Ph606xqy=QvTkYdMyqYf5LMHUS5GcDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=ruanjinjie@huawei.com; helo=szxga01-in.huawei.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.376,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Reply-to:  Jinjie Ruan <ruanjinjie@huawei.com>
From:  Jinjie Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2024/4/3 0:12, Peter Maydell wrote:
> On Sat, 30 Mar 2024 at 10:33, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>> Implement icv_nmiar1_read() for icc_nmiar1_read(), so add definition for
>> ICH_LR_EL2.NMI and ICH_AP1R_EL2.NMI bit.
>>
>> If FEAT_GICv3_NMI is supported, ich_ap_write() should consider ICV_AP1R_EL1.NMI
>> bit. In icv_activate_irq() and icv_eoir_write(), the ICV_AP1R_EL1.NMI bit
>> should be set or clear according to the Non-maskable property. And the RPR
>> priority should also update the NMI bit according to the APR priority NMI bit.
>>
>> By the way, add gicv3_icv_nmiar1_read trace event.
>>
>> If the hpp irq is a NMI, the icv iar read should return 1022 and trap for
>> NMI again
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> v11:
>> - Deal with NMI in the callers instead of ich_highest_active_virt_prio().
>> - Set either NMI or a group-priority bit, not both.
>> - Only set AP NMI bits in the 0 reg.
>> - Handle NMI in hppvi_index(), icv_hppi_can_preempt() and icv_eoir_write().
>> v10:
>> - Rename ICH_AP1R_EL2_NMI to ICV_AP1R_EL1_NMI.
>> - Add ICV_RPR_EL1_NMI definition.
>> - Set ICV_RPR_EL1.NMI according to the ICV_AP1R<n>_EL1.NMI in
>>   ich_highest_active_virt_prio().
>> v9:
>> - Correct the INTID_NMI logic.
>> v8:
>> - Fix an unexpected interrupt bug when sending VNMI by running qemu VM.
>> v7:
>> - Add Reviewed-by.
>> v6:
>> - Implement icv_nmiar1_read().
>> ---
>>  hw/intc/arm_gicv3_cpuif.c | 97 ++++++++++++++++++++++++++++++++++-----
>>  hw/intc/gicv3_internal.h  |  4 ++
>>  hw/intc/trace-events      |  1 +
>>  3 files changed, 91 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
>> index f99f2570a6..a7bc44b30c 100644
>> --- a/hw/intc/arm_gicv3_cpuif.c
>> +++ b/hw/intc/arm_gicv3_cpuif.c
>> @@ -157,6 +157,10 @@ static int ich_highest_active_virt_prio(GICv3CPUState *cs)
>>      int i;
>>      int aprmax = ich_num_aprs(cs);
>>
>> +    if (cs->gic->nmi_support && cs->ich_apr[GICV3_G1NS][0] & ICV_AP1R_EL1_NMI) {
>> +        return 0x80;
> 
> This should be 0, not 0x80 -- see the register description for
> ICH_LR<n>_EL2 Priority field: when NMI is 1, the virtual interrupt's
> priority is treated as 0x0.
> 
>> +    }
>> +
>>      for (i = 0; i < aprmax; i++) {
>>          uint32_t apr = cs->ich_apr[GICV3_G0][i] |
>>              cs->ich_apr[GICV3_G1NS][i];
>> @@ -191,6 +195,7 @@ static int hppvi_index(GICv3CPUState *cs)
>>       * correct behaviour.
>>       */
>>      int prio = 0xff;
>> +    bool nmi = false;
>>
>>      if (!(cs->ich_vmcr_el2 & (ICH_VMCR_EL2_VENG0 | ICH_VMCR_EL2_VENG1))) {
>>          /* Both groups disabled, definitely nothing to do */
>> @@ -200,6 +205,11 @@ static int hppvi_index(GICv3CPUState *cs)
>>      for (i = 0; i < cs->num_list_regs; i++) {
>>          uint64_t lr = cs->ich_lr_el2[i];
>>          int thisprio;
>> +        bool thisnmi = false;
>> +
>> +        if (cs->gic->nmi_support) {
>> +            thisnmi = lr & ICH_LR_EL2_NMI;
>> +        }
> 
> You could write this a little more concisely as
>       bool thisnmi = cs->gic_nmi_support && (lr & ICH_LR_EL2_NMI);
> 
>>          if (ich_lr_state(lr) != ICH_LR_EL2_STATE_PENDING) {
>>              /* Not Pending */
>> @@ -219,9 +229,13 @@ static int hppvi_index(GICv3CPUState *cs)
>>
>>          thisprio = ich_lr_prio(lr);
>>
>> -        if (thisprio < prio) {
>> +        if ((thisprio < prio) || ((thisprio == prio) && (thisnmi & (!nmi)))) {
>>              prio = thisprio;
>>              idx = i;
>> +
>> +            if (cs->gic->nmi_support) {
>> +                nmi = thisnmi;
>> +            }
> 
> You don't need to check nmi_support here because if nmi_support
> is false then thisnmi will also be false, and so we will never
> set nmi to anything other than false.
> 
>>          }
>>      }
>>
>> @@ -326,6 +340,12 @@ static bool icv_hppi_can_preempt(GICv3CPUState *cs, uint64_t lr)
>>          return true;
>>      }
>>
>> +    if ((prio & mask) == (rprio & mask) &&
>> +        cs->gic->nmi_support && (lr & ICH_LR_EL2_NMI) &&
>> +        (!(cs->ich_apr[GICV3_G1NS][0] & ICV_AP1R_EL1_NMI))) {
>> +        return true;
>> +    }
>> +
>>      return false;
>>  }
> 
> This isn't the only change needed to icv_hppi_can_preempt():
> virtual NMIs are never masked by the MPR, so that check also
> must be changed. If we pull out a variable:
> 
>     bool is_nmi = cs->gic->nmi_support && (lr & ICH_LR_EL2_NMI);
> 
> we can use that both to gate the vpmr check:
> 
>     if (!is_nmi && prio >= vpmr) {
> 
> and also in the priority check you have here.
> 
>> @@ -736,13 +765,19 @@ static void icv_activate_irq(GICv3CPUState *cs, int idx, int grp)
>>       */
>>      uint32_t mask = icv_gprio_mask(cs, grp);
>>      int prio = ich_lr_prio(cs->ich_lr_el2[idx]) & mask;
>> +    bool nmi = cs->ich_lr_el2[idx] & ICH_LR_EL2_NMI;
>>      int aprbit = prio >> (8 - cs->vprebits);
>>      int regno = aprbit / 32;
>>      int regbit = aprbit % 32;
>>
>>      cs->ich_lr_el2[idx] &= ~ICH_LR_EL2_STATE_PENDING_BIT;
>>      cs->ich_lr_el2[idx] |= ICH_LR_EL2_STATE_ACTIVE_BIT;
>> -    cs->ich_apr[grp][regno] |= (1 << regbit);
>> +
>> +    if (cs->gic->nmi_support && nmi) {
>> +        cs->ich_apr[grp][regno] |= ICV_AP1R_EL1_NMI;
>> +    } else {
>> +        cs->ich_apr[grp][regno] |= (1 << regbit);
>> +    }
>>  }
>>
>>  static void icv_activate_vlpi(GICv3CPUState *cs)
>> @@ -776,7 +811,11 @@ static uint64_t icv_iar_read(CPUARMState *env, const ARMCPRegInfo *ri)
>>          if (thisgrp == grp && icv_hppi_can_preempt(cs, lr)) {
>>              intid = ich_lr_vintid(lr);
>>              if (!gicv3_intid_is_special(intid)) {
>> -                icv_activate_irq(cs, idx, grp);
>> +                if (!(lr & ICH_LR_EL2_NMI)) {
> 
> This is missing checks on both whether the GIC has NMI support and
> on whether the SCTLR NMI bit is set (compare pseudocode
> VirtualReadIAR1()). I suggest defining a
> 
>         bool nmi = cs->gic->nmi_support &&
>             (env->cp15.sctlr_el[arm_current_el(env)] & SCTLR_NMI) &&
>             (lr & ICH_LR_EL2_NMI);

The nmi_support check is redundant, as if FEAT_GICv3_NMI is unsupported,
the ICH_LR_EL2.NMI is RES0, so if ICH_LR_EL2.NMI is 1, FEAT_GICv3_NMI
has been surely realized.

> 
> and then you can check "if (!nmi)" here.
> 
>> +                    icv_activate_irq(cs, idx, grp);
>> +                } else {
>> +                    intid = INTID_NMI;
>> +                }
>>              } else {
>>                  /* Interrupt goes from Pending to Invalid */
>>                  cs->ich_lr_el2[idx] &= ~ICH_LR_EL2_STATE_PENDING_BIT;
>> @@ -797,8 +836,32 @@ static uint64_t icv_iar_read(CPUARMState *env, const ARMCPRegInfo *ri)
>>
>>  static uint64_t icv_nmiar1_read(CPUARMState *env, const ARMCPRegInfo *ri)
>>  {
>> -    /* todo */
>> +    GICv3CPUState *cs = icc_cs_from_env(env);
>> +    int idx = hppvi_index(cs);
>>      uint64_t intid = INTID_SPURIOUS;
>> +
>> +    if (idx >= 0 && idx != HPPVI_INDEX_VLPI) {
>> +        uint64_t lr = cs->ich_lr_el2[idx];
>> +        int thisgrp = (lr & ICH_LR_EL2_GROUP) ? GICV3_G1NS : GICV3_G0;
>> +
>> +        if ((thisgrp == GICV3_G1NS) && (lr & ICH_LR_EL2_NMI)) {
>> +            intid = ich_lr_vintid(lr);
>> +            if (!gicv3_intid_is_special(intid)) {
>> +                icv_activate_irq(cs, idx, GICV3_G1NS);
>> +            } else {
>> +                /* Interrupt goes from Pending to Invalid */
>> +                cs->ich_lr_el2[idx] &= ~ICH_LR_EL2_STATE_PENDING_BIT;
>> +                /* We will now return the (bogus) ID from the list register,
>> +                 * as per the pseudocode.
>> +                 */
> 
> QEMU's coding style wants the /* on a line of its own for a
> multiline comment.
> 
>> +            }
>> +        }
>> +    }
>> +
>> +    trace_gicv3_icv_nmiar1_read(gicv3_redist_affid(cs), intid);
>> +
>> +    gicv3_cpuif_virt_update(cs);
>> +
>>      return intid;
>>  }
> 
>> @@ -1504,6 +1573,7 @@ static void icv_eoir_write(CPUARMState *env, const ARMCPRegInfo *ri,
>>      int irq = value & 0xffffff;
>>      int grp = ri->crm == 8 ? GICV3_G0 : GICV3_G1NS;
>>      int idx, dropprio;
>> +    bool nmi = false;
>>
>>      trace_gicv3_icv_eoir_write(ri->crm == 8 ? 0 : 1,
>>                                 gicv3_redist_affid(cs), value);
>> @@ -1516,8 +1586,8 @@ static void icv_eoir_write(CPUARMState *env, const ARMCPRegInfo *ri,
>>       * error checks" (because that lets us avoid scanning the AP
>>       * registers twice).
>>       */
>> -    dropprio = icv_drop_prio(cs);
>> -    if (dropprio == 0xff) {
>> +    dropprio = icv_drop_prio(cs, &nmi);
>> +    if (dropprio == 0xff && !nmi) {
>>          /* No active interrupt. It is CONSTRAINED UNPREDICTABLE
>>           * whether the list registers are checked in this
>>           * situation; we choose not to.
>> @@ -1539,8 +1609,9 @@ static void icv_eoir_write(CPUARMState *env, const ARMCPRegInfo *ri,
>>          uint64_t lr = cs->ich_lr_el2[idx];
>>          int thisgrp = (lr & ICH_LR_EL2_GROUP) ? GICV3_G1NS : GICV3_G0;
>>          int lr_gprio = ich_lr_prio(lr) & icv_gprio_mask(cs, grp);
>> +        int thisnmi = lr & ICH_LR_EL2_NMI;
> 
> This variable should be "bool". An "int" is 32 bits, so because
> ICH_LR_EL2_NMI is bit 59, the value of "lr & ICH_LR_EL2_NMI" when
> cast to int is always zero. Using bool avoids this bug and also
> is consistent with the type we used for the 'nmi' variable we're
> about to compare it with.
> 
>> -        if (thisgrp == grp && lr_gprio == dropprio) {
>> +        if (thisgrp == grp && (lr_gprio == dropprio || thisnmi == nmi)) {
>>              if (!icv_eoi_split(env, cs) || irq >= GICV3_LPI_INTID_START) {
>>                  /*
>>                   * Priority drop and deactivate not split: deactivate irq now.
>> @@ -2626,7 +2697,11 @@ static void ich_ap_write(CPUARMState *env, const ARMCPRegInfo *ri,
>>
>>      trace_gicv3_ich_ap_write(ri->crm & 1, regno, gicv3_redist_affid(cs), value);
>>
>> -    cs->ich_apr[grp][regno] = value & 0xFFFFFFFFU;
>> +    if (cs->gic->nmi_support) {
>> +        cs->ich_apr[grp][regno] = value & (0xFFFFFFFFU | ICV_AP1R_EL1_NMI);
>> +    } else {
>> +        cs->ich_apr[grp][regno] = value & 0xFFFFFFFFU;
>> +    }
>>      gicv3_cpuif_virt_irq_fiq_update(cs);
>>  }
> 
> thanks
> -- PMM


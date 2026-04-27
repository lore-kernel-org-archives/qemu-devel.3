Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42A0FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 18:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHQue-0002jI-Se; Mon, 27 Apr 2026 14:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1wHQub-0002iR-Sa
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 14:42:29 -0400
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1wHQuZ-00018X-D5
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 14:42:29 -0400
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-2c156c4a9efso14466467eec.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 11:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777315345; x=1777920145; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9D9752LVMe2fTIJea87T8EvGRre91VlA7lnj2zzLGng=;
 b=BDLLZ0FmCuS1omgFRPCad7kIcEfZ2JZn+QRCwQ0OA2yMuHoywJe09dcxbuQplrGTj8
 ciQvsHnAkL29cx/xsXOE4/LaKVAjS7CgKPdTERt+Fu0nAgPsLDcEnz43URFz7iYEx8Kl
 Y3mEOE6HBvzf+ufPLBOLxvc9aLAriyrEpbO4iSz5qvFD1A/f5+d3nuK7cGF9+GIoJSkk
 sNPYHPDBkPmVbbqbkCrWnq3Dzr22Kw0yJ7lJMskjyD9vOfl6pUsfdtAxIk4IaZ+SZsFa
 YbvAG0xCnECc1FOmoeM3xFFARX/AxVnhRg3JAjcTg8sQGmfEukhmXClpG14kLI8JguHe
 goqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777315345; x=1777920145;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9D9752LVMe2fTIJea87T8EvGRre91VlA7lnj2zzLGng=;
 b=hBpt1hmyQn3+P9UmXa+UlGuDgLDMRS5I9rs3AY91AfXaiurFMQ1Ytfeu4EOeLrU5+9
 3OoXmy8k/JBxmX9sXQXbFhmrUNlZV5DUysEZb4L1qyNEh+djkVzmrX0NZjArRova9u1I
 dTudLNYpmEaDDnseNNpTYpehVaTV2whTfU5TFqqYlqEXdGvyo8OT5WLuqfa3pzUP6n42
 NLitwx7+G/jMo3w4DLF2dd9f9k/nM0F/mbvufh3SOiWMOsnKusIe47O7FeFcRts5RwUS
 I1CmgjmaSyPEmYTt2+ql7SuW3qEAZTiqroJTzWdcd3ixulfvzjwO96HXUHBqJUXBV9uF
 +ysw==
X-Gm-Message-State: AOJu0YxGa+w5K3KHq3zppWgSQkvHezzqc7/g8Mbw6Qa0YehQOiCWyalf
 lvQh9SsPugRO85+wZPl4nIfq2BGDM4YpzfgvE2dqTaPA6cjFqeoNNrsI
X-Gm-Gg: AeBDiet6ltwFKN2MFfOLzRs+kb1cNWnP3LbDisGWNB7kr5LUzKeTcPSa0UmgWdyZF3O
 DN1ocGooYcuvGpUZPoNq9SuULmGUOQ/C8UTQDnwVi5YiuTzi7sxaPd5oEA7yicC3nuP3NvTG5ID
 JqMtvuxfTIRbJryaiIa7kDDiQl6ljszj18HGpAO0TCUQ0iQpYIYuUW4zQo0kjFVDyU9J2gv+lLz
 HcziLKlmcYe2CbI6ZWll458AdO5NBBY++UUHT+kH4ZJWutUL8U7gC1dCCeXoXWsMiDK52AipTIR
 X/KWCkhceZZhpgaZiupGl4KQWlvhrFEhImowuVhQya+tddkTzGKpEaXzhyP8s1dcqt1OxxSfSUM
 1AbJ1kuE5knMpKcIyYUEAWXI5J4UC63u8sU9Fh9qs5BgriwH2Lv8zbbdo+DDcjzh1AejFrZuW8A
 nQWW40nm6jC5XeDjdU1+HcGrwMvD1bAgaVvJCNONhtZYzoSOguQsQma3GpzAt7gUO4F2H7tPVwM
 TbIrP5CdLZEARFobNd+8fN+uJEqceHl
X-Received: by 2002:a05:7301:1691:b0:2df:71f0:e5b3 with SMTP id
 5a478bee46e88-2ed0a1403bfmr16838eec.20.1777315345223; 
 Mon, 27 Apr 2026 11:42:25 -0700 (PDT)
Received: from localhost ([2601:645:8200:47:f4a5:bd04:3ca7:5727])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed09f8f2b2sm88182eec.1.2026.04.27.11.42.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 11:42:24 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Apr 2026 11:42:23 -0700
Message-Id: <DI45PH4NASOO.3MQVHIFL83QFX@gmail.com>
Cc: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <rbolshakov@ddn.com>,
 <phil@philjordan.eu>, <agraf@csgraf.de>
Subject: Re: [PATCH v2] target/arm/hvf: Fix WFI halting to stop idle vCPU
 spinning
From: "Scott J. Goldman" <scottjgo@gmail.com>
To: "Peter Maydell" <peter.maydell@linaro.org>, "Scott J. Goldman"
 <scottjgo@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260410044726.61853-1-scottjgo@gmail.com>
 <20260410055045.63001-1-scottjgo@gmail.com>
 <CAFEAcA9RHQ+7++=kLn2goJwcgzDnaqdkQtQBtxQ2Rw1-uiKY=g@mail.gmail.com>
In-Reply-To: <CAFEAcA9RHQ+7++=kLn2goJwcgzDnaqdkQtQBtxQ2Rw1-uiKY=g@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::132b;
 envelope-from=scottjgo@gmail.com; helo=mail-dy1-x132b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon Apr 27, 2026 at 4:15 AM PDT, Peter Maydell wrote:
> On Fri, 10 Apr 2026 at 06:50, Scott J. Goldman <scottjgo@gmail.com> wrote=
:
>>
>> Commit b5f8f77271 ("accel/hvf: Implement WFI without using pselect()")
>> changed hvf_wfi() from blocking the vCPU thread with pselect() to
>> returning EXCP_HLT, intending QEMU's main event loop to handle the
>> idle wait. However, cpu->halted was never set, so cpu_thread_is_idle()
>> always returns false and the vCPU thread spins at 100% CPU per core
>> while the guest is idle.
>>
>> Fix this by:
>>
>> 1. Setting cpu->halted =3D 1 in hvf_wfi() so the vCPU thread sleeps on
>>    halt_cond in qemu_process_cpu_events().
>>
>> 2. Arming a host-side QEMU_CLOCK_HOST timer to fire when the guest's
>>    virtual timer (CNTV_CVAL_EL0) would expire. This is necessary
>>    because HVF only delivers HV_EXIT_REASON_VTIMER_ACTIVATED during
>>    hv_vcpu_run(), which is not called while the CPU is halted. The
>>    timer callback mirrors the VTIMER_ACTIVATED handler: it raises the
>>    vtimer IRQ through the GIC and marks vtimer_masked, causing the
>>    interrupt delivery chain to wake the vCPU via qemu_cpu_kick().
>
> A host side timer here seems a bit odd -- it will still
> expire even if the user halts the whole VM. We only use
> QEMU_CLOCK_HOST timers for things that are part of QEMU proper,
> like handling timeouts in the migration networking code.
>
>> diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
>> index 2621164cb2..58fb865eba 100644
>> --- a/include/system/hvf_int.h
>> +++ b/include/system/hvf_int.h
>> @@ -48,6 +48,7 @@ struct AccelCPUState {
>>      hv_vcpu_exit_t *exit;
>>      bool vtimer_masked;
>>      bool guest_debug_enabled;
>> +    struct QEMUTimer *wfi_timer;
>>  #endif
>>  };
>
> QEMUTimer objects need to be migrated. I think as it is now,
> if you do a migration while one vCPU is in WFI we won't
> migrate the timer state, and so on the destination it won't
> be woken up when it should.

Hi Peter--

Thanks for the review here. I am going to post a follow-up patch based
on your comments, but I did want to just flag that migration is broken
in hvf/arm right now (segfaults in the dirty page tracking code). Of
course, I can post fixes for that as well.


>
>> +static void hvf_wfi_timer_cb(void *opaque)
>> +{
>> +    CPUState *cpu =3D opaque;
>> +    ARMCPU *arm_cpu =3D ARM_CPU(cpu);
>> +
>> +    /*
>> +     * vtimer expired while the CPU was halted for WFI.
>> +     * Mirror HV_EXIT_REASON_VTIMER_ACTIVATED: raise the vtimer
>> +     * interrupt and mark as masked so hvf_sync_vtimer() will
>> +     * check and unmask when the guest handles it.
>> +     *
>> +     * The interrupt delivery chain (GIC -> cpu_interrupt ->
>> +     * qemu_cpu_kick) wakes the vCPU thread from halt_cond.
>> +     */
>> +    qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
>> +    cpu->accel->vtimer_masked =3D true;
>
> If the VM happens to be stopped by the user when the timer
> fires, this will change the VM state, which I suspect is
> not correct. Avoiding use of a QEMU_CLOCK_HOST timer would
> fix this.
>
>> +}
>> +
>>  static int hvf_wfi(CPUState *cpu)
>>  {
>> +    ARMCPU *arm_cpu =3D ARM_CPU(cpu);
>> +    uint64_t ctl, cval;
>> +    hv_return_t r;
>> +
>>      if (cpu_has_work(cpu)) {
>>          /*
>>           * Don't bother to go into our "low power state" if
>> @@ -2037,6 +2068,34 @@ static int hvf_wfi(CPUState *cpu)
>>          return 0;
>>      }
>>
>> +    /*
>> +     * Set up a host-side timer to wake us when the vtimer expires.
>> +     * HVF only delivers HV_EXIT_REASON_VTIMER_ACTIVATED during
>> +     * hv_vcpu_run(), which we won't call while halted.
>> +     */
>> +    r =3D hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0, =
&ctl);
>> +    assert_hvf_ok(r);
>> +
>> +    if ((ctl & TMR_CTL_ENABLE) && !(ctl & TMR_CTL_IMASK)) {
>> +        r =3D hv_vcpu_get_sys_reg(cpu->accel->fd,
>> +                                HV_SYS_REG_CNTV_CVAL_EL0, &cval);
>> +        assert_hvf_ok(r);
>> +
>> +        uint64_t now =3D hvf_vtimer_val_raw();
>> +        if (cval <=3D now) {
>> +            /* Timer already expired, don't halt */
>> +            return 0;
>> +        }
>> +
>> +        uint64_t delta_ticks =3D cval - now;
>> +        int64_t delta_ns =3D delta_ticks * NANOSECONDS_PER_SECOND
>> +                           / arm_cpu->gt_cntfrq_hz;
>
> As a general rule, tick-to-ns and vice-versa conversions should
> use muldiv64() to avoid potential overflow in the intermediate value.
>
>> +        int64_t deadline =3D qemu_clock_get_ns(QEMU_CLOCK_HOST) + delta=
_ns;
>> +
>> +        timer_mod(cpu->accel->wfi_timer, deadline);
>> +    }
>> +
>> +    cpu->halted =3D 1;
>>      return EXCP_HLT;
>>  }
>
> thanks
> -- PMM



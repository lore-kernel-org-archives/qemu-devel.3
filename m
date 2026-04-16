Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830D9F8DFC7
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 21:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDU8P-0001yH-TV; Thu, 16 Apr 2026 17:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1wDU8O-0001x0-2d
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:20:24 -0400
Received: from mail-dy1-x132d.google.com ([2607:f8b0:4864:20::132d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1wDU8L-0005jj-Nu
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:20:23 -0400
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-2d8ffdc31d0so11104076eec.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 14:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776374420; x=1776979220; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VC7nQVv1RhnMd3rwzntvYtDT8+OyaBleLRT2qXreYFU=;
 b=NIfX+S92PKEUsp+IMiWRJ/ZARGWZp7rnjz4GU2eF4ai93ke6i83GjvZtJ7dpe5L1Xt
 OvHCfjfW6TiOcl/qcF13kYiproi+PiC42mMALVtVv8yhtd+CJjbJ4QIQeLPKpT5kGcDP
 Mh+0dtHX7S5AkLx6fDbrUabmQH8P1IAeejS/ojqSF+XImEuA+lsZMVwAKeipLUZWFhad
 DO3XyuZbp3qLXwmXR0YagbIBo3fvDvO16gngsMZYMY3Q7pgIOIxrIOTyKDAQ1J8SMjSj
 rk6OFFsy9uvbXLJ3cagXRunln/us4m1ZhTGW8WX5vSR3lDab/AChuXJ+JtYC2gmBIfm9
 OANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776374420; x=1776979220;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VC7nQVv1RhnMd3rwzntvYtDT8+OyaBleLRT2qXreYFU=;
 b=i+VcT1fc3eVKRi5iwWPsRDQuI20uN8t6JjjtPFDmSPIWoYpLRQ5ppdg9NewUgky+lL
 BF3cSx/8CT5VT+elQe5pH/y/49sRo9VrZpEmsfti5/xopOVNy+rqNpzDwa1FolzpW/zH
 S7cAJSVN1iJu/0Fa64Ccb1hO66tqefJ9Fdrgik/pY+KVYElSVMWGEA18hKyy5N8ZhJMy
 ui78SWXTkDf0P9Wq0mDdCsFy6ZU9jUW+87syaE01L89h9mjKLAs8Qv9tjzH58i2hYlk7
 T7UuWO6T50boW0x++T4o1GhMXlUnwS+YZ+wo5+S6FBhk109Qqxf9ePFaz7ByRauns6qY
 kf2Q==
X-Gm-Message-State: AOJu0YxcDBofZe2Y83L8RTyT2zJeXfx8tbyUwsjx13sVhXXhERNopZtz
 oTGqYdr8uIQeOBLlbNRopZGrRDDn9ZMbHE3Ml/gruEH0AdA3LB6qIAAj
X-Gm-Gg: AeBDietwIEgjbURnImmVG7ptkqOGSEZqVh0ktSQNepQ2ZNF5UQdkbj2Tmazej8Sj37A
 LOz18m8ws3V78REdOQ7drlM23ZgvCPUN7w+uYhcbqy+G8ozPN51SkO9jyGurcgV3SjQJeKigtVL
 kyd6VfjDks+ntJKtilJJFS7ElvagK5EK8mCBL9SLODSf3c+xkiS3TWkpZv8Q7XPyvqH+YrNpCMd
 UN3x71WvZ+IgGXvhWl26Z0qq0axt/VTeTbpB0QGWhKefWHQN5FdroMkwtM4MVoI7t226j5hC2rZ
 PeDIrpy4X45pNUcO96PaoG+kiZzT07SoFFjo07tGrZCzXfpj7Q/npC/uS8BA099vV/bad7uFyx5
 iv2W1/ypoUyYzvpHmyXS9IeECACy/NlYNV/R3/CCL7N57RlnIylPnKAZeOWcaCq42acJ7sc10i3
 zhTUDX4xlK0itgORGKNXOGzjeK9NZhzUt0Vd1/wphqdBwRFfWcGpldcR6Q648p4Nr91CMhN7kAw
 an6ZomJiuvPm2SWhXOOjw==
X-Received: by 2002:a05:7301:6786:b0:2e1:f72:3f2a with SMTP id
 5a478bee46e88-2e2e348a7d6mr541421eec.4.1776374419400; 
 Thu, 16 Apr 2026 14:20:19 -0700 (PDT)
Received: from localhost ([2601:645:8200:47:54d1:f936:e5b2:27e5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c606db2sm8864909eec.11.2026.04.16.14.20.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 14:20:18 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Apr 2026 14:20:17 -0700
Message-Id: <DHUW6DNJWPDC.1MEF4S1911AJ1@gmail.com>
From: "Scott J. Goldman" <scottjgo@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <rbolshakov@ddn.com>,
 <phil@philjordan.eu>, <agraf@csgraf.de>, <peter.maydell@linaro.org>,
 "Mohamed Mediouni" <mohamed@unpredictable.fr>
Subject: Re: [PATCH v2] target/arm/hvf: Fix WFI halting to stop idle vCPU
 spinning
X-Mailer: aerc 0.21.0
References: <20260410044726.61853-1-scottjgo@gmail.com>
 <20260410055045.63001-1-scottjgo@gmail.com>
 <86D19C52-2A31-4802-ADF2-703D9AE83E75@unpredictable.fr>
In-Reply-To: <86D19C52-2A31-4802-ADF2-703D9AE83E75@unpredictable.fr>
Received-SPF: pass client-ip=2607:f8b0:4864:20::132d;
 envelope-from=scottjgo@gmail.com; helo=mail-dy1-x132d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Philippe-- apologies for the nag here but this is a fix for a unfortunate
regression. Any chance you could take a look? Thanks!

On Thu Apr 9, 2026 at 11:18 PM PDT, Mohamed Mediouni wrote:
>
>
>> On 10. Apr 2026, at 07:50, Scott J. Goldman <scottjgo@gmail.com> wrote:
>>=20
>> Commit b5f8f77271 ("accel/hvf: Implement WFI without using pselect()")
>> changed hvf_wfi() from blocking the vCPU thread with pselect() to
>> returning EXCP_HLT, intending QEMU's main event loop to handle the
>> idle wait. However, cpu->halted was never set, so cpu_thread_is_idle()
>> always returns false and the vCPU thread spins at 100% CPU per core
>> while the guest is idle.
>>=20
>> Fix this by:
>>=20
>> 1. Setting cpu->halted =3D 1 in hvf_wfi() so the vCPU thread sleeps on
>>   halt_cond in qemu_process_cpu_events().
>>=20
>> 2. Arming a host-side QEMU_CLOCK_HOST timer to fire when the guest's
>>   virtual timer (CNTV_CVAL_EL0) would expire. This is necessary
>>   because HVF only delivers HV_EXIT_REASON_VTIMER_ACTIVATED during
>>   hv_vcpu_run(), which is not called while the CPU is halted. The
>>   timer callback mirrors the VTIMER_ACTIVATED handler: it raises the
>>   vtimer IRQ through the GIC and marks vtimer_masked, causing the
>>   interrupt delivery chain to wake the vCPU via qemu_cpu_kick().
>>=20
>> 3. Clearing cpu->halted in hvf_arch_vcpu_exec() when cpu_has_work()
>>   indicates a pending interrupt, and cancelling the WFI timer.
>>=20
>> Fixes: b5f8f77271 ("accel/hvf: Implement WFI without using pselect()")
>> Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
>
> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>> include/system/hvf_int.h |  1 +
>> target/arm/hvf/hvf.c     | 65 +++++++++++++++++++++++++++++++++++++++-
>> 2 files changed, 65 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
>> index 2621164cb2..58fb865eba 100644
>> --- a/include/system/hvf_int.h
>> +++ b/include/system/hvf_int.h
>> @@ -48,6 +48,7 @@ struct AccelCPUState {
>>     hv_vcpu_exit_t *exit;
>>     bool vtimer_masked;
>>     bool guest_debug_enabled;
>> +    struct QEMUTimer *wfi_timer;
>> #endif
>> };
>>=20
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index 5fc8f6bbbd..f5d7221845 100644
>> --- a/target/arm/hvf/hvf.c
>> +++ b/target/arm/hvf/hvf.c
>> @@ -28,6 +28,7 @@
>> #include "hw/core/boards.h"
>> #include "hw/core/irq.h"
>> #include "qemu/main-loop.h"
>> +#include "qemu/timer.h"
>> #include "system/cpus.h"
>> #include "arm-powerctl.h"
>> #include "target/arm/cpu.h"
>> @@ -301,6 +302,8 @@ void hvf_arm_init_debug(void)
>> #define TMR_CTL_IMASK   (1 << 1)
>> #define TMR_CTL_ISTATUS (1 << 2)
>>=20
>> +static void hvf_wfi_timer_cb(void *opaque);
>> +
>> static uint32_t chosen_ipa_bit_size;
>>=20
>> typedef struct HVFVTimer {
>> @@ -1214,6 +1217,9 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
>> {
>>     hv_return_t ret;
>>=20
>> +    timer_free(cpu->accel->wfi_timer);
>> +    cpu->accel->wfi_timer =3D NULL;
>> +
>>     ret =3D hv_vcpu_destroy(cpu->accel->fd);
>>     assert_hvf_ok(ret);
>> }
>> @@ -1352,6 +1358,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>>                               arm_cpu->isar.idregs[ID_AA64MMFR0_EL1_IDX]=
);
>>     assert_hvf_ok(ret);
>>=20
>> +    cpu->accel->wfi_timer =3D timer_new_ns(QEMU_CLOCK_HOST,
>> +                                          hvf_wfi_timer_cb, cpu);
>> +
>>     aarch64_add_sme_properties(OBJECT(cpu));
>>     return 0;
>> }
>> @@ -2027,8 +2036,30 @@ static uint64_t hvf_vtimer_val_raw(void)
>>     return mach_absolute_time() - hvf_state->vtimer_offset;
>> }
>>=20
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
>> +}
>> +
>> static int hvf_wfi(CPUState *cpu)
>> {
>> +    ARMCPU *arm_cpu =3D ARM_CPU(cpu);
>> +    uint64_t ctl, cval;
>> +    hv_return_t r;
>> +
>>     if (cpu_has_work(cpu)) {
>>         /*
>>          * Don't bother to go into our "low power state" if
>> @@ -2037,6 +2068,34 @@ static int hvf_wfi(CPUState *cpu)
>>         return 0;
>>     }
>>=20
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
>> +        int64_t deadline =3D qemu_clock_get_ns(QEMU_CLOCK_HOST) + delta=
_ns;
>> +
>> +        timer_mod(cpu->accel->wfi_timer, deadline);
>> +    }
>> +
>> +    cpu->halted =3D 1;
>>     return EXCP_HLT;
>> }
>>=20
>> @@ -2332,7 +2391,11 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
>>     hv_return_t r;
>>=20
>>     if (cpu->halted) {
>> -        return EXCP_HLT;
>> +        if (!cpu_has_work(cpu)) {
>> +            return EXCP_HLT;
>> +        }
>> +        cpu->halted =3D 0;
>> +        timer_del(cpu->accel->wfi_timer);
>>     }
>>=20
>>     flush_cpu_state(cpu);
>> --=20
>> 2.50.1 (Apple Git-155)
>>=20
>>=20



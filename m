Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52AECD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 16:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMqGB-00027J-5R; Tue, 12 May 2026 12:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1wMqG7-000263-BS
 for qemu-devel@nongnu.org; Tue, 12 May 2026 12:47:03 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1wMqG4-0004HC-SI
 for qemu-devel@nongnu.org; Tue, 12 May 2026 12:47:03 -0400
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-8d65f4073bfso788563385a.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 09:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778604417; x=1779209217; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7IezjjKN4X9JWmBtNjXCJ3bHoXex+8rlWRjK21uO+BE=;
 b=M4eq7N7IfOyt91L1S89t/jMzdgGeYIRPInWe0+7Foa0RSJFj/2j9kNb4BGwN9zvD2h
 gEI2eAovYakmlTdJScEGuJSsWK+3pNmyk88SEVxsBFF2EH8E8aXVCoy0q39eTDePubV9
 8EsSQHFFwLZEMBJteMIgbjn7XP9zIiz8NLVP/rFzcwM5pD7MKZZbVeyLNLp/ay0x9nhw
 GoOgVQXZlUS0A0QqOxrjfAkBIniPKAkEyjLhhz2iMZbtt0sE+L39++AfGThSiftChHqd
 uXuq6I93LdBP7kVZ3dr77pV/8CQ9mx3EGTvL/UfGdQww1YwPva9GNzfFhsibyn6s1HdY
 q3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778604417; x=1779209217;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7IezjjKN4X9JWmBtNjXCJ3bHoXex+8rlWRjK21uO+BE=;
 b=Naj/ehct55vbCdU9AAuffHz3SUtVBy8+mf05RTOuJ7a+tizZ/WfXFEE8oJRtRYIazL
 n2LDWlhsjlWTUtb+vxMDYe/MF7mmFimXwoE4LL/VFmbIPYSDC4vR8mG97RNdVubgpzlG
 Ucn0HzSHHk6co/KXFzA6LWh9ZbJryCa0eE2bNGPxsfjIOUc6Qs7ySo9w2Pw85Y05OjP0
 afqBmoZglmUXs+vqp3ATtM2V3LBL/UJntVGdCGB5RwY1FFowLjy8/bdCJD44M/tH8SnE
 b93ZDjcFyHvkAfRecPMrkjzgGu5P4UUskdW8x0Yo4bXehBIxMiY/grbsofXWTKgO4Wrk
 PvGw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+L0EGjlQnlyD2nTKnhB07SbiMGdDNB0CQzvPh221bPSc7XXwiDxr2ajc1ZTFiWJkblGJ0B7Fee14Mz@nongnu.org
X-Gm-Message-State: AOJu0Yy3vgkoLGh9OGL4Z0o+S6bdalC+5PS8CM4OqpOOF7lhWzhszYN3
 k4HC1+rwPSLmI8i1V5BBW6x/jArAtMs0rf7XzzpTRbm+6Wa70LcHByWD
X-Gm-Gg: Acq92OFSsS+rCi91CRguJN/A52vsozpNDJA+k+fI+DX6rlFv2HF/c2X0r0BpqD/GShr
 hffUp8bj2I/8cfX/lVXL6K/XX9aVlX8kTPb2cTjr+3DK5WjgQoMFkfHX0x7U4sbSRmHd+E3WNMq
 Z3U1cjU5MN0572PqN2wsksClEje1KfDpnHgFYOO7NNZqN7HLUcrCxfX/OyG3bLZqLtgE6TvD2WL
 vZxYaFDkCVCxxFPyMh59CRXlW9sNZIjFiUw8U6Ut19zXDfFvsOe96Kos7bTM5tfb9SK21h/e1++
 KlNVRTY/BU0tPf+4xtMsJqtwyZhxARCjgrwLn3zwna1Cqz/lLZ3hO1Zm6q27AAYvi7cFt2GtqAs
 lFFBDQMpVhlB0aY+rKjEErSW2Wle/Ax5dojee1+pV9dCtwM+MLX1Cx7s33JJTy/1pe7h+3djDHV
 9k7G9WbE3uEPutLcRvVu/6xCF9QdlwWdAREo8IEqs0eqt3IBESjLGrTm+1/vmC94QvXDVKOYqbs
 71oVtqrn0IC99w=
X-Received: by 2002:a05:620a:3952:b0:8ed:e1d4:1644 with SMTP id
 af79cd13be357-90cfb4c0cd6mr551761985a.3.1778604417182; 
 Tue, 12 May 2026 09:46:57 -0700 (PDT)
Received: from localhost ([2603:7000:4df0:8300:fdb5:4a2a:97d0:addf])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-90d77f64627sm145576385a.15.2026.05.12.09.46.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 09:46:56 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 May 2026 12:46:55 -0400
Message-Id: <DIGUN8EOAZ7C.3VYBVHXL4F06O@gmail.com>
Cc: <qemu-arm@nongnu.org>, "Alexander Graf" <agraf@csgraf.de>, "Phil
 Dennis-Jordan" <phil@philjordan.eu>, "Roman Bolshakov"
 <rbolshakov@ddn.com>, =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3] target/arm/hvf: Fix WFI halting to stop idle vCPU
 spinning
From: "Scott J. Goldman" <scottjgo@gmail.com>
To: "Peter Maydell" <peter.maydell@linaro.org>
X-Mailer: aerc 0.21.0
References: <20260410055045.63001-1-scottjgo@gmail.com>
 <20260427195516.46256-1-scottjgo@gmail.com>
In-Reply-To: <20260427195516.46256-1-scottjgo@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=scottjgo@gmail.com; helo=mail-qk1-x72e.google.com
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

On Mon Apr 27, 2026 at 3:55 PM EDT, Scott J. Goldman wrote:
> Commit b5f8f77271 ("accel/hvf: Implement WFI without using pselect()")
> changed hvf_wfi() from blocking the vCPU thread with pselect() to
> returning EXCP_HLT, intending QEMU's main event loop to handle the
> idle wait. However, cpu->halted was never set, so cpu_thread_is_idle()
> always returns false and the vCPU thread spins at 100% CPU per core
> while the guest is idle.
>
> Fix this by:
>
> 1. Setting cpu->halted =3D 1 in hvf_wfi() so the vCPU thread sleeps on
>    halt_cond in qemu_process_cpu_events().
>
> 2. Arming a per-vCPU QEMU_CLOCK_VIRTUAL timer to fire when the guest's
>    virtual timer (CNTV_CVAL_EL0) would expire. This is necessary
>    because HVF only delivers HV_EXIT_REASON_VTIMER_ACTIVATED during
>    hv_vcpu_run(), which is not called while the CPU is halted. The
>    timer callback mirrors the VTIMER_ACTIVATED handler: it raises the
>    vtimer IRQ through the GIC and marks vtimer_masked, causing the
>    interrupt delivery chain to wake the vCPU via qemu_cpu_kick().
>
> 3. Clearing cpu->halted in hvf_arch_vcpu_exec() when cpu_has_work()
>    indicates a pending interrupt, and cancelling the WFI timer.
>
> 4. Re-arming the WFI timer from hvf_vm_state_change() on the resume
>    transition for any halted vCPU, since the QEMUTimer is per-instance
>    state and is not migrated. After cpu_synchronize_all_states() the
>    migrated vtimer state is mirrored in env, so we can read CNTV_CTL
>    and CNTV_CVAL from there. If the vtimer has already expired by the
>    time the destination resumes, hvf_wfi_timer_cb() is invoked
>    directly so the halted vCPU is woken up.
>
> Fixes: b5f8f77271 ("accel/hvf: Implement WFI without using pselect()")
> Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
> ---
> Changes since v2:
>  - Use QEMU_CLOCK_VIRTUAL instead of QEMU_CLOCK_HOST so the timer
>    pauses with the VM and a halted vCPU isn't woken (or its IRQ
>    raised) while the user has stopped the guest. (Peter)
>  - Convert vtimer ticks to nanoseconds with muldiv64() to avoid
>    intermediate overflow. (Peter)
>  - Re-arm the WFI timer from hvf_vm_state_change() on the resume
>    transition so a halted vCPU on the migration destination is
>    woken when its vtimer expires (the QEMUTimer is per-instance
>    state and isn't migrated). (Peter)
> v2: https://lore.kernel.org/qemu-devel/20260410055045.63001-1-scottjgo@gm=
ail.com/
> v1: https://lore.kernel.org/qemu-devel/20260410044726.61853-1-scottjgo@gm=
ail.com/
>
>  include/system/hvf_int.h |   1 +
>  target/arm/hvf/hvf.c     | 124 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 124 insertions(+), 1 deletion(-)
>
> diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
> index 2621164cb2..58fb865eba 100644
> --- a/include/system/hvf_int.h
> +++ b/include/system/hvf_int.h
> @@ -48,6 +48,7 @@ struct AccelCPUState {
>      hv_vcpu_exit_t *exit;
>      bool vtimer_masked;
>      bool guest_debug_enabled;
> +    struct QEMUTimer *wfi_timer;
>  #endif
>  };
> =20
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 678afe5c8e..a19d7a5e1f 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -28,6 +28,7 @@
>  #include "hw/core/boards.h"
>  #include "hw/core/irq.h"
>  #include "qemu/main-loop.h"
> +#include "qemu/timer.h"
>  #include "system/cpus.h"
>  #include "arm-powerctl.h"
>  #include "target/arm/cpu.h"
> @@ -301,6 +302,8 @@ void hvf_arm_init_debug(void)
>  #define TMR_CTL_IMASK   (1 << 1)
>  #define TMR_CTL_ISTATUS (1 << 2)
> =20
> +static void hvf_wfi_timer_cb(void *opaque);
> +
>  static uint32_t chosen_ipa_bit_size;
> =20
>  typedef struct HVFVTimer {
> @@ -1214,6 +1217,9 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
>  {
>      hv_return_t ret;
> =20
> +    timer_free(cpu->accel->wfi_timer);
> +    cpu->accel->wfi_timer =3D NULL;
> +
>      ret =3D hv_vcpu_destroy(cpu->accel->fd);
>      assert_hvf_ok(ret);
>  }
> @@ -1352,6 +1358,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>                                arm_cpu->isar.idregs[ID_AA64MMFR0_EL1_IDX]=
);
>      assert_hvf_ok(ret);
> =20
> +    cpu->accel->wfi_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                          hvf_wfi_timer_cb, cpu);
> +
>      aarch64_add_sme_properties(OBJECT(cpu));
>      return 0;
>  }
> @@ -2027,8 +2036,67 @@ static uint64_t hvf_vtimer_val_raw(void)
>      return mach_absolute_time() - hvf_state->vtimer_offset;
>  }
> =20
> +static void hvf_wfi_timer_cb(void *opaque)
> +{
> +    CPUState *cpu =3D opaque;
> +    ARMCPU *arm_cpu =3D ARM_CPU(cpu);
> +
> +    /*
> +     * vtimer expired while the CPU was halted for WFI.
> +     * Mirror HV_EXIT_REASON_VTIMER_ACTIVATED: raise the vtimer
> +     * interrupt and mark as masked so hvf_sync_vtimer() will
> +     * check and unmask when the guest handles it.
> +     *
> +     * The interrupt delivery chain (GIC -> cpu_interrupt ->
> +     * qemu_cpu_kick) wakes the vCPU thread from halt_cond.
> +     */
> +    qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
> +    cpu->accel->vtimer_masked =3D true;
> +}
> +
> +/*
> + * Arm a host-side QEMU_CLOCK_VIRTUAL timer to fire when the guest's
> + * vtimer (CNTV_CVAL_EL0) is scheduled to expire. HVF only delivers
> + * HV_EXIT_REASON_VTIMER_ACTIVATED during hv_vcpu_run(), which we won't
> + * call while the vCPU is halted, so we need this to wake the vCPU.
> + *
> + * QEMU_CLOCK_VIRTUAL pauses while the VM is stopped, which keeps the
> + * timer in lockstep with the guest's view of vtime across pause/resume.
> + *
> + * Caller must supply the current CNTV_CTL_EL0 and CNTV_CVAL_EL0 values,
> + * since the appropriate source (HVF vs. env) depends on context.
> + *
> + * Returns 0 if the timer was armed (or if the vtimer is disabled/masked
> + * and the vCPU should still halt waiting on another event), or -1 if
> + * the vtimer has already expired.
> + */
> +static int hvf_arm_wfi_timer(CPUState *cpu, uint64_t ctl, uint64_t cval)
> +{
> +    ARMCPU *arm_cpu =3D ARM_CPU(cpu);
> +    uint64_t now;
> +    int64_t delta_ns;
> +
> +    if (!(ctl & TMR_CTL_ENABLE) || (ctl & TMR_CTL_IMASK)) {
> +        return 0;
> +    }
> +
> +    now =3D hvf_vtimer_val_raw();
> +    if (cval <=3D now) {
> +        return -1;
> +    }
> +
> +    delta_ns =3D muldiv64(cval - now, NANOSECONDS_PER_SECOND,
> +                        arm_cpu->gt_cntfrq_hz);
> +    timer_mod(cpu->accel->wfi_timer,
> +              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delta_ns);
> +    return 0;
> +}
> +
>  static int hvf_wfi(CPUState *cpu)
>  {
> +    uint64_t ctl, cval;
> +    hv_return_t r;
> +
>      if (cpu_has_work(cpu)) {
>          /*
>           * Don't bother to go into our "low power state" if
> @@ -2037,6 +2105,22 @@ static int hvf_wfi(CPUState *cpu)
>          return 0;
>      }
> =20
> +    /*
> +     * Read the vtimer state directly from HVF. We're on the vCPU thread=
,
> +     * just exited from hv_vcpu_run(), so HVF holds the authoritative
> +     * values and env may be stale.
> +     */
> +    r =3D hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0, &=
ctl);
> +    assert_hvf_ok(r);
> +    r =3D hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CVAL_EL0, =
&cval);
> +    assert_hvf_ok(r);
> +
> +    if (hvf_arm_wfi_timer(cpu, ctl, cval) < 0) {
> +        /* vtimer already expired, don't halt */
> +        return 0;
> +    }
> +
> +    cpu->halted =3D 1;
>      return EXCP_HLT;
>  }
> =20
> @@ -2332,7 +2416,11 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
>      hv_return_t r;
> =20
>      if (cpu->halted) {
> -        return EXCP_HLT;
> +        if (!cpu_has_work(cpu)) {
> +            return EXCP_HLT;
> +        }
> +        cpu->halted =3D 0;
> +        timer_del(cpu->accel->wfi_timer);
>      }
> =20
>      flush_cpu_state(cpu);
> @@ -2376,11 +2464,45 @@ static const VMStateDescription vmstate_hvf_vtime=
r =3D {
>  static void hvf_vm_state_change(void *opaque, bool running, RunState sta=
te)
>  {
>      HVFVTimer *s =3D opaque;
> +    CPUState *cpu;
> =20
>      if (running) {
>          /* Update vtimer offset on all CPUs */
>          hvf_state->vtimer_offset =3D mach_absolute_time() - s->vtimer_va=
l;
>          cpu_synchronize_all_states();
> +
> +        /*
> +         * After migration restore (or any resume), the wfi_timer is not
> +         * scheduled on this QEMU instance, so re-arm it for any halted
> +         * vCPU with a pending vtimer. For a non-migration resume the
> +         * QEMU_CLOCK_VIRTUAL timer was already scheduled; recomputing t=
he
> +         * deadline produces the same value and is a harmless no-op.
> +         *
> +         * cpu_synchronize_all_states() above ensures env mirrors the
> +         * authoritative vtimer state (whether that came from HVF or fro=
m
> +         * the migration stream), so we can safely read it here from the
> +         * iothread.
> +         */
> +        CPU_FOREACH(cpu) {
> +            ARMCPU *arm_cpu;
> +            uint64_t ctl, cval;
> +
> +            if (!cpu->accel || !cpu->halted) {
> +                continue;
> +            }
> +
> +            arm_cpu =3D ARM_CPU(cpu);
> +            ctl =3D arm_cpu->env.cp15.c14_timer[GTIMER_VIRT].ctl;
> +            cval =3D arm_cpu->env.cp15.c14_timer[GTIMER_VIRT].cval;
> +
> +            if (hvf_arm_wfi_timer(cpu, ctl, cval) < 0) {
> +                /*
> +                 * vtimer already expired while we were paused; raise th=
e
> +                 * IRQ now so the halted vCPU wakes up.
> +                 */
> +                hvf_wfi_timer_cb(cpu);
> +            }
> +        }
>      } else {
>          /* Remember vtimer value on every pause */
>          s->vtimer_val =3D hvf_vtimer_val_raw();

Hi Peter--

Sorry to nag, just was wondering if you could take a look at this follow-up
to your earlier review comments in:
https://lore.kernel.org/qemu-devel/CAFEAcA9RHQ+7++=3DkLn2goJwcgzDnaqdkQtQBt=
xQ2Rw1-uiKY=3Dg@mail.gmail.com/#t

It's a bit of an unfortunate regression, so I was hoping to get some form o=
f
the fix in.

Additionally, re: migration under hvf being broken, it  looks like one of m=
y
fixes got merged, but there is one patch remaining here as well:
https://lore.kernel.org/qemu-devel/5e123304-628a-4da9-81ca-585498c809b6@lin=
aro.org/

Thanks, and hope the ping is ok (just following the docs that say to retry
every 2 weeks)
-sjg


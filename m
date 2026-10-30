Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AFC606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cwM0cdSc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMphR-0001Lc-5q; Fri, 30 Oct 2026 12:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMphJ-0001KB-KD
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 12:43:23 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMphD-0001Xh-FL
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 12:43:21 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso9327505e9.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 09:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793378594; x=1793983394; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XsAr2+WVSEhog8k5E0fRJm+o1Xwf4Pru9NbYC3h/E0g=;
 b=cwM0cdScT1eEYhEZFBAbtEsjXJqvu8DHwSnU+RUUjAURB3dkJQxURY1gOSY+xsyV+G
 KZWK9dKlndW7uJB5tKKKEqWYPUWia5ScggRqVTKoYn8NYzAsnHoTOHD5OfSyZLp/vopa
 9unt5Q7LmU8RqTk7n00ETOJE9C/N6GibgUjztt3gh9Y521OWxXTYd0C2X1JpANWkss4p
 ld79tEjuMwXE7vcizs0ZKn2GsvvUCUffogSrXLZ9nqj9icoKOYJ5n9ZbGvE6DC0WyI55
 IYx1t05lGl7TK0UOXcvIk1bS2DWT86tnCUy9Q3hdnPQRDZrPuvx6xVLZEYVNZMoiwEJU
 5wMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793378594; x=1793983394;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XsAr2+WVSEhog8k5E0fRJm+o1Xwf4Pru9NbYC3h/E0g=;
 b=Rgx1ZqMzao3yggQHVX5Xuli2CtgDpzxWB3hmp3HDmkQlnevmwuYClfe8HjXyjKnt13
 WIux7ajm2AVoUOkKQp6+FKltEK9vfkt9oc3yL7uSzp5aVcMEghJ8RrhGTahYnQH6MNvz
 BpfHPGCOmHssV5/WDsjIzdGjdOP+DA/+fZMUFnoIlNxKy4i9isRsxCSj7OJ/NotD211m
 WLrTfmkpExCidAl4vPinTbaJIxgR08Cpk2ROtv2d15BaLyEVdxHJtcIrWxDQbJOCqmAX
 UAaBMqsmN7OHPS9o0n7amfw6ua7V1gGOBQc8Dl4hcGwz6BzSEFLKK5LCLDZjoIML55/t
 lKxg==
X-Gm-Message-State: AFq9FYJkIPRlHEcF3vXqYIdHjOAgK+sZnHo5jjnAWQIxobllBE1UqVTy
 6MIJux49KMbAVhuaMGiEU+T2ecE475Q8aIVwoKEnYdhB2zsj8FMWLtsWPNbKUWEaROM=
X-Gm-Gg: AYBFou2JmZg+p1FhrR0MPljG9C+BFPKgTKb6kS23FMTQLGLJipe7D8UkEin4+KoVT87
 c01SiVsRwvJKQ9v6Ukg3ivEcR8qhsO7CSNaVlpRSDueDquAFfN9FPqvN0TmSs/TBTZft6O7DNn7
 C3e3V5OlJDw4xDiND/NYTagPrmtTI649xBOwk8iK1WwHCdIAAGX32vPuHBzuZhVF12PWBj+neN7
 S1QWfrAYLJZU7IIfiJB+yjHXjorlRUCN1mphig0BZD092VqXgObUgQ91OEIbBVcGyjoQrpdGfK2
 IWRbXsUjexmPS4xMSrw1ON6zQjCJp+1tFCq0qwUZ7ZjZsevThyUrXcEVIgM8ytfL/1yMKWaLGab
 Cj+eFhl7lWMGTKOCUQt814Smv5rzpsizTfNHPHAZ1q8k3ebPg/Z/e/LMXpaMmQwJCZsg1MJHNHi
 4ElZDfC1TiCeWCAJFtLUQnfJ+66AWEs2FhLk/dBXlZuGYV6Ty170kXa+YhF35pMHtYwU3G5eQI1
 G5B06iubWPAgUea8F0Q7FESENncODb0ChIxZQsqTYjAuXlpkTE9owb2UvnciGC6HbS37tdTgX4a
 8crlNxCVB+F+xRscno6CcLWkiRxTlxMuC8RfN9+SNc0iUR6++A==
X-Received: by 2002:a05:600c:4e50:b0:4a1:7d9b:d4ae with SMTP id
 5b1f17b1804b1-4ac16fa3523mr63593395e9.5.1793378593564; 
 Fri, 30 Oct 2026 09:43:13 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa8213ead6sm145917035e9.14.2026.10.30.09.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 09:43:12 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2920E5F7FD;
 Fri, 30 Oct 2026 16:43:12 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  qemu-arm@nongnu.org
Subject: Re: [PATCH 3/4] target/arm: simplify wfxt_timer_cb to only trigger
 cpu_interrupt
In-Reply-To: <CAFEAcA_vh2WhO8wAX8=6cmZx0Fe2UQYJBoRjaJb1YVAG-Lm8Jw@mail.gmail.com>
 (Peter Maydell's message of "Fri, 30 Oct 2026 14:41:47 +0000")
References: <20261030141046.2710206-1-alex.bennee@linaro.org>
 <20261030141046.2710206-4-alex.bennee@linaro.org>
 <CAFEAcA_vh2WhO8wAX8=6cmZx0Fe2UQYJBoRjaJb1YVAG-Lm8Jw@mail.gmail.com>
User-Agent: mu4e 1.14.4; emacs 30.1
Date: Fri, 30 Oct 2026 16:43:12 +0000
Message-ID: <877biz87hb.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 30 Oct 2026 at 14:10, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> HALT_WFE will always be cleared when leaving halt via
>> arm_cpu_leaving_halt so we don't need to worry about atomic games in
>> the asynchronous timer callback. Furthermore, a WFET timeout or
>> event-stream expiration is not an event that sets the event register;
>
> No, this is still not true. WFET timeouts don't set the
> event register, but event-stream expiration does.

Oops I missed that comment, how about something like this:

--8<---------------cut here---------------start------------->8---
modified   target/arm/cpu.h
@@ -984,8 +984,12 @@ struct ArchCPU {
      * pmu_op_finish() - it does not need other handling during migration
      */
     QEMUTimer *pmu_timer;
-    /* Timer used for WFxT timeouts OR event stream events */
+    /*
+     * Timer used for WFxT timeouts OR event stream events,
+     * wfxt_triggers_event set depending on what will come first.
+     */
     QEMUTimer *wfxt_timer;
+    bool wfxt_triggers_event;
=20
     /* GPIO outputs for generic timer */
     qemu_irq gt_timer_outputs[NUM_GTIMERS];
modified   target/arm/cpu.c
@@ -885,26 +885,17 @@ static void arm_cpu_leaving_halt(CPUState *cs)
 }
 #endif
=20
-/*
- * Unlike almost everything else that messes with the halt_reason and
- * event_register details the timer callbacks are not in the vCPU
- * context.
- *
- * To prevent races we atomically consume a HALT_WFE and set the event
- * register. Either way we trigger the an exit event.
- */
 static void arm_wfxt_timer_cb(void *opaque)
 {
     ARMCPU *cpu =3D opaque;
     CPUState *cs =3D CPU(cpu);
     CPUARMState *env =3D &cpu->env;
=20
-    if (qatomic_cmpxchg(&env->halt_reason, HALT_WFE, NOT_HALTED)) {
+    if (cpu->wfxt_triggers_event) {
         qatomic_set(&env->event_register, true);
     }
-
     /*
-     * We expect the CPU to be halted; this will cause arm_cpu_is_work()
+     * We expect the CPU to be halted; this will cause arm_cpu_has_work()
      * to return true (so we will come out of halt even with no other
      * pending interrupt), and the TCG accelerator's cpu_exec_interrupt()
      * function auto-clears the CPU_INTERRUPT_EXITTB flag for us.
modified   target/arm/tcg/op_helper.c
@@ -377,6 +377,7 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
     return;
 #else
     CPUState *cs =3D env_cpu(env);
+    ARMCPU *cpu =3D env_archcpu(env);
     uint32_t excp;
     int target_el =3D check_wfx_trap(env, false, &excp);
=20
@@ -398,6 +399,7 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
                         target_el);
     }
=20
+    cpu->wfxt_triggers_event =3D false;
     qatomic_set(&env->halt_reason, HALT_WFI);
     cs->exception_index =3D EXCP_HLT;
     cs->halted =3D 1;
@@ -461,6 +463,7 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
     } else {
         timer_mod(cpu->wfxt_timer, nexttick);
     }
+    cpu->wfxt_triggers_event =3D false;
     qatomic_set(&env->halt_reason, HALT_WFI);
     cs->exception_index =3D EXCP_HLT;
     cs->halted =3D 1;
@@ -720,12 +723,14 @@ void HELPER(wfet)(CPUARMState *env, uint32_t rd)
     next_event =3D gt_calc_next_event_stream(env);
     if (next_event > 0 && next_event < nexttick) {
         timer_mod(cpu->wfxt_timer, next_event);
+        cpu->wfxt_triggers_event =3D true;
     } else {
         if (nexttick =3D=3D INT64_MAX) {
             timer_mod_ns(cpu->wfxt_timer, INT64_MAX);
         } else {
             timer_mod(cpu->wfxt_timer, nexttick);
         }
+        cpu->wfxt_triggers_event =3D false;
     }
=20
     qatomic_set(&env->halt_reason, HALT_WFE);
--8<---------------cut here---------------end--------------->8---


>
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


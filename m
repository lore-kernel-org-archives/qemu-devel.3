Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6F9C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 17:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1r5P-0002CL-1W; Tue, 30 Apr 2024 13:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s1r5I-0002Af-Ku
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 13:16:09 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s1r5F-00038U-31
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 13:16:03 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a58eb9a42d9so444136066b.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 10:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714497359; x=1715102159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yJNrL/6SvwXBHGcA1ZFaRqo9PBInYVWOnUcTki0yH9s=;
 b=o8nRs6DOftjRONHPEcQxjg/e5gnUBS4hHpiXGjzUlNzzl8jKhQn9g4xf28Sfn69bDl
 vg07VlLXVmkJ/X+hUqm2RLDpLgH8NrNT87q4lYu9uQkk9rdXbdOCSpo0foXXWK8LLGUt
 NQOQUtLZDvdnjcw3Sb6JqVVu5sTA7xvOgcCwtlxFE9CZ7xJR+wfkCh+nEVIlLj2ONrsF
 k335LoGUywx0y1VgU2OgA2XqGLLXiSFqdybChk8BjSZGb3xUENzieu1NsY4iDxBmkLRi
 7cbZnszJ6Ej26j6pefbvgMWXkKDJrc24ColI247qbax3gstND5zMHQexteQjVrcTvje7
 TpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714497359; x=1715102159;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yJNrL/6SvwXBHGcA1ZFaRqo9PBInYVWOnUcTki0yH9s=;
 b=LYCWpfoFOhr9e1Kru+KHF48ee3go+2gK0tcXmrnyiUUodxuQ6kMxcdveKhZR/qKf/m
 M8UpECn0outK8dmlzEuuoPS5Kq2wlDzSfdHSPS71gD+ht+wE7rEr3IUQ10HxSBtdMy6y
 cegjP8eD14QVreyuyfSx1wDnx6ZqctHkCxS8HyGLy7FfmJX8ZvkcJ40IqtqcBPFO6hA8
 EjrcydlIZQm9Ozdu3oyjhQyGcjSkJ2iOhwZMElmYeFZ6csbDqL7WntyUVL32O1AbP0nK
 UvUIeectMO8omaW+Lf6gAWHHZmiAYYpJ4RjxGW2ZDF42UaPXL2pSxOsI1AYn5PFz8tTP
 NVCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPgWbhhcss8ZPafaguI436kZuuz27KznpvqcMLwenTGWddci1qoCLgNrPkNAWM7Od0wd7xxKag2Wc6Jld6rDD+5KedUEg=
X-Gm-Message-State: AOJu0YwkbsHI/DL+C6XEvOfYwm1wNuESctbDdS7bGvmvRWP3dxNWiL+d
 auKSFwAS7dvmrnKsjO2ysKOkuvh25JRzXAj80O6gewfhZiQnQzVRfgE2GJsrEHI=
X-Google-Smtp-Source: AGHT+IFc5ODU7GTggPM/FZ/Cjdzip7pEteG3zCtN227ukbSI44ZcmoNmc2p/INAF9ANrjwLqHOmpGg==
X-Received: by 2002:a17:906:787:b0:a52:4edb:6db7 with SMTP id
 l7-20020a170906078700b00a524edb6db7mr250533ejc.54.1714497359251; 
 Tue, 30 Apr 2024 10:15:59 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j21-20020a170906431500b00a521e5856f6sm15395091ejm.51.2024.04.30.10.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 10:15:59 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 51F685F7A7;
 Tue, 30 Apr 2024 18:15:58 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] accel/tcg: Make TCGCPUOps::cpu_exec_halt return
 bool for whether to halt
In-Reply-To: <20240430140035.3889879-2-peter.maydell@linaro.org> (Peter
 Maydell's message of "Tue, 30 Apr 2024 15:00:34 +0100")
References: <20240430140035.3889879-1-peter.maydell@linaro.org>
 <20240430140035.3889879-2-peter.maydell@linaro.org>
Date: Tue, 30 Apr 2024 18:15:58 +0100
Message-ID: <87ttji3h69.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Peter Maydell <peter.maydell@linaro.org> writes:

> The TCGCPUOps::cpu_exec_halt method is called from cpu_handle_halt()
> when the CPU is halted, so that a target CPU emulation can do
> anything target-specific it needs to do.  (At the moment we only use
> this on i386.)
>
> The current specification of the method doesn't allow the target
> specific code to do something different if the CPU is about to come
> out of the halt state, because cpu_handle_halt() only determines this
> after the method has returned.  (If the method called cpu_has_work()
> itself this would introduce a potential race if an interrupt arrived
> between the target's method implementation checking and
> cpu_handle_halt() repeating the check.)
>
> Change the definition of the method so that it returns a bool to
> tell cpu_handle_halt() whether to stay in halt or not.
>
> We will want this for the Arm target, where FEAT_WFxT wants to do
> some work only for the case where the CPU is in halt but about to
> leave it.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/core/tcg-cpu-ops.h       | 11 +++++++++--
>  target/i386/tcg/helper-tcg.h        |  2 +-
>  accel/tcg/cpu-exec.c                |  7 +++++--
>  target/i386/tcg/sysemu/seg_helper.c |  3 ++-
>  4 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
> index dc1f16a9777..f3ac76e6f6d 100644
> --- a/include/hw/core/tcg-cpu-ops.h
> +++ b/include/hw/core/tcg-cpu-ops.h
> @@ -111,8 +111,15 @@ struct TCGCPUOps {
>      void (*do_interrupt)(CPUState *cpu);
>      /** @cpu_exec_interrupt: Callback for processing interrupts in cpu_e=
xec */
>      bool (*cpu_exec_interrupt)(CPUState *cpu, int interrupt_request);
> -    /** @cpu_exec_halt: Callback for handling halt in cpu_exec */
> -    void (*cpu_exec_halt)(CPUState *cpu);
> +    /**
> +     * @cpu_exec_halt: Callback for handling halt in cpu_exec.
> +     *
> +     * Return true to indicate that the CPU should now leave halt, false
> +     * if it should remain in the halted state.
> +     * If this method is not provided, the default is to leave halt
> +     * if cpu_has_work() returns true.
> +     */
> +    bool (*cpu_exec_halt)(CPUState *cpu);

Would it be too much to rename the method to cpu_exec_leave_halt() to
make it clearer on use the sense of the return value?

>      /**
>       * @tlb_fill: Handle a softmmu tlb miss
>       *
> diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
> index effc2c1c984..85957943bf3 100644
> --- a/target/i386/tcg/helper-tcg.h
> +++ b/target/i386/tcg/helper-tcg.h
> @@ -39,7 +39,7 @@ QEMU_BUILD_BUG_ON(TCG_PHYS_ADDR_BITS > TARGET_PHYS_ADDR=
_SPACE_BITS);
>   */
>  void x86_cpu_do_interrupt(CPUState *cpu);
>  #ifndef CONFIG_USER_ONLY
> -void x86_cpu_exec_halt(CPUState *cpu);
> +bool x86_cpu_exec_halt(CPUState *cpu);
>  bool x86_need_replay_interrupt(int interrupt_request);
>  bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
>  #endif
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 5c70748060a..550f93b19ce 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -669,11 +669,14 @@ static inline bool cpu_handle_halt(CPUState *cpu)
>  #ifndef CONFIG_USER_ONLY
>      if (cpu->halted) {
>          const TCGCPUOps *tcg_ops =3D cpu->cc->tcg_ops;
> +        bool leave_halt;
>=20=20
>          if (tcg_ops->cpu_exec_halt) {
> -            tcg_ops->cpu_exec_halt(cpu);
> +            leave_halt =3D tcg_ops->cpu_exec_halt(cpu);
> +        } else {
> +            leave_halt =3D cpu_has_work(cpu);
>          }
> -        if (!cpu_has_work(cpu)) {
> +        if (!leave_halt) {
>              return true;
>          }
>=20=20
> diff --git a/target/i386/tcg/sysemu/seg_helper.c b/target/i386/tcg/sysemu=
/seg_helper.c
> index 2db8083748e..9ba94deb3aa 100644
> --- a/target/i386/tcg/sysemu/seg_helper.c
> +++ b/target/i386/tcg/sysemu/seg_helper.c
> @@ -128,7 +128,7 @@ void x86_cpu_do_interrupt(CPUState *cs)
>      }
>  }
>=20=20
> -void x86_cpu_exec_halt(CPUState *cpu)
> +bool x86_cpu_exec_halt(CPUState *cpu)
>  {
>      if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
>          X86CPU *x86_cpu =3D X86_CPU(cpu);
> @@ -138,6 +138,7 @@ void x86_cpu_exec_halt(CPUState *cpu)
>          cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
>          bql_unlock();
>      }
> +    return cpu_has_work(cpu);

The x86 version is essentially being called for side effects. Do we want
to document this usage in the method?

>  }
>=20=20
>  bool x86_need_replay_interrupt(int interrupt_request)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


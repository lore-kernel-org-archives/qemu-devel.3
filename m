Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60B7CA1005
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4MF-0008Kz-Fh; Mon, 01 Sep 2025 09:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut4MC-0008Kj-Ci
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:14:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut4M5-0007Yu-Tk
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756732430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wzovtqV4yVdtqHUdl7Qy1Sg5S4Yb6KN0Oy3VffajCx8=;
 b=QfsJ1aLQhpOiixWxh36lTNdrUDbbmrOM0MAymMLLt5yIU4q68eWGeEbZzfb+YcxsdcFClV
 qn5OYdIzQcD6+zzLxzkRX0wDigNolymaWj+RDTSqPHC/7Kp6tcY/JtAgoJxVA/B04NRjYH
 bu6z1PYsPlOyvC4uwzfeD7sGpZo6Kcc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-eW_z3DY0PJapqOW9_68edA-1; Mon, 01 Sep 2025 09:13:48 -0400
X-MC-Unique: eW_z3DY0PJapqOW9_68edA-1
X-Mimecast-MFC-AGG-ID: eW_z3DY0PJapqOW9_68edA_1756732428
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4b30fadc974so57267791cf.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 06:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756732428; x=1757337228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wzovtqV4yVdtqHUdl7Qy1Sg5S4Yb6KN0Oy3VffajCx8=;
 b=gkGcNUqxCJYfPVxChfxQfdwW4nVf0LdKDV4HWNfYBYZqhepEbcuWNcItCyxZJV+VW2
 dWaSX2V36lCzIvsOAyVGBn8J1e9NXlamELWVRX5I0RVxUxktR2AAH9zIuWHJZPR+2agm
 3zRSvvovL8KUjVit43nuCTxhJ5N39DoNqqJdjvQoGjZoIWqSvFK7ZTFyEhKQSWsV7j1x
 kOxdf/8bqvaDt+pQUq1xCwhoay+LhEAN2HTRUgx54QteO1AvLQ3utCDIVZAQXVCPh+LT
 KRb4c54u0xiyo9RqttFS+BSh3W8pMIw2Y4/p68x+gAf4NbhZdH6FoygZU1ZGgkHenolx
 uVkw==
X-Gm-Message-State: AOJu0YwMlSxvN28ATxxJPDPoK1HBHYVtKnbvQF62n+k0booyM2plTaVQ
 sA4uGSOZ5hbxC5L/xO204TpTDN4/yLCBhQcykacyWmHDOVJEzkzz7joRFNkDHRforOIP4fMCJJY
 grASGz0Am9ucIHY6iHogimWcQ0uWyXJdCvc42eZazCQU6qQJZeBorfIPm
X-Gm-Gg: ASbGncuifOh6qG75/+M3O/DOdgTljkEt8eC167fZBSy7D+GK8aVEZnPErRzmaURV/Py
 MwEALe4NwFg6T1ApjZ2OoL6mWiPC8qfTb2F0FwaqwrybnEi+pxfWtSRM1s16IqMdKZ8JuujnfZ6
 p28eQNX4X6p8CCkrC/Rt4pHp0YJ8tDuBpaG1zGEPMEmaXZe4JdWzoeJBMoZ5ky2LY2imXsdv3Yj
 MAy0Gup0WqKSbRaiQAVTkAX3XRWnrVdG4Rz3paVgO6+J4J8VXeyT5rf7ArfCdk1RmA+XW8rMeY0
 WKDZkqLk9EJB0XQarjGkOT57Umls4Q==
X-Received: by 2002:a05:622a:17cf:b0:4b3:1613:6025 with SMTP id
 d75a77b69052e-4b31d80c9cbmr101312391cf.7.1756732427846; 
 Mon, 01 Sep 2025 06:13:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr3RHcr3pZqi+L+9jOayST1HE60V/Dxxx2QF4MeYsih5D9s+7Bj5nqQNMsCDXrK1/hFwGXww==
X-Received: by 2002:a05:622a:17cf:b0:4b3:1613:6025 with SMTP id
 d75a77b69052e-4b31d80c9cbmr101311631cf.7.1756732427151; 
 Mon, 01 Sep 2025 06:13:47 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7fc0ecb89f9sm663710385a.24.2025.09.01.06.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 06:13:46 -0700 (PDT)
Date: Mon, 1 Sep 2025 15:13:43 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, richard.henderson@linaro.org
Subject: Re: [PATCH 09/18] accel: use store_release/load_acquire for
 cross-thread exit_request
Message-ID: <20250901151343.76fa22f6@fedora>
In-Reply-To: <20250829153115.1590048-5-pbonzini@redhat.com>
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-5-pbonzini@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, 29 Aug 2025 17:31:06 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> Reads and writes cpu->exit_request do not use a load-acquire/store-release
> pair right now, but this means that cpu_exit() may not write cpu->exit_request
> after any flags that are read by the vCPU thread.
> 
> Probably everything is protected one way or the other by the BQL, because
> cpu->exit_request leads to the slow path, where the CPU thread often takes
> the BQL (for example, to go to sleep by waiting on the BQL-protected
> cpu->halt_cond); but it's not clear, so use load-acquire/store-release
> consistently.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

nit below:
> ---
>  accel/kvm/kvm-all.c          | 19 +++++++++----------
>  accel/tcg/cpu-exec.c         |  7 +++++--
>  accel/tcg/tcg-accel-ops-rr.c |  2 +-
>  hw/core/cpu-common.c         |  3 ++-
>  target/i386/nvmm/nvmm-all.c  |  5 ++---
>  target/i386/whpx/whpx-all.c  |  3 ++-
>  6 files changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index f36dfe33492..bd9e5e3886d 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3029,10 +3029,6 @@ static void kvm_eat_signals(CPUState *cpu)
>  
>      if (kvm_immediate_exit) {
>          qatomic_set(&cpu->kvm_run->immediate_exit, 0);
> -        /* Write kvm_run->immediate_exit before the cpu->exit_request
> -         * write in kvm_cpu_exec.
> -         */
> -        smp_wmb();
>          return;
>      }
>  
> @@ -3187,7 +3183,8 @@ int kvm_cpu_exec(CPUState *cpu)
>          }
>  
>          kvm_arch_pre_run(cpu, run);
> -        if (qatomic_read(&cpu->exit_request)) {
> +        /* Corresponding store-release is in cpu_exit. */
> +        if (qatomic_load_acquire(&cpu->exit_request)) {
>              trace_kvm_interrupt_exit_request();
>              /*
>               * KVM requires us to reenter the kernel after IO exits to complete
> @@ -3197,13 +3194,15 @@ int kvm_cpu_exec(CPUState *cpu)
>              kvm_cpu_kick_self();
>          }
>  
> -        /* Read cpu->exit_request before KVM_RUN reads run->immediate_exit.
> -         * Matching barrier in kvm_eat_signals.
> -         */
> -        smp_rmb();
> -
>          run_ret = kvm_vcpu_ioctl(cpu, KVM_RUN, 0);
>  
> +        /*
> +         * After writing cpu->exit_request, cpu_exit() sends a signal that writes
> +         * kvm->run->immediate_exit.  The signal is already happening after the
> +         * write to cpu->exit_request so, if KVM read kvm->run->immediate_exit
> +         * as true, cpu->exit_request will always read as true.
> +         */
> +
>          attrs = kvm_arch_post_run(cpu, run);
>  
>  #ifdef KVM_HAVE_MCE_INJECTION
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 508d2d2d9e2..f838535d111 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -851,8 +851,11 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>      }
>  #endif /* !CONFIG_USER_ONLY */
>  
> -    /* Finally, check if we need to exit to the main loop.  */
> -    if (unlikely(qatomic_read(&cpu->exit_request)) || icount_exit_request(cpu)) {
> +    /*
> +     * Finally, check if we need to exit to the main loop.
> +     * The corresponding store-release is in cpu_exit.
> +     */
> +    if (unlikely(qatomic_load_acquire(&cpu->exit_request)) || icount_exit_request(cpu)) {
>          qatomic_set(&cpu->exit_request, 0);
>          if (cpu->exception_index == -1) {
>              cpu->exception_index = EXCP_INTERRUPT;
> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
> index 6eec5c9eee9..1e551e92d6d 100644
> --- a/accel/tcg/tcg-accel-ops-rr.c
> +++ b/accel/tcg/tcg-accel-ops-rr.c
> @@ -242,7 +242,7 @@ static void *rr_cpu_thread_fn(void *arg)
>              cpu = first_cpu;
>          }
>  

should we have here a similar comment as in the previous hunk?

> -        while (cpu && cpu_work_list_empty(cpu) && !cpu->exit_request) {
> +        while (cpu && cpu_work_list_empty(cpu) && !qatomic_load_acquire(&cpu->exit_request)) {
>              /* Store rr_current_cpu before evaluating cpu_can_run().  */
>              qatomic_set_mb(&rr_current_cpu, cpu);
>  
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index 9ea1f3764a8..ca00accd162 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -74,7 +74,8 @@ void cpu_reset_interrupt(CPUState *cpu, int mask)
>  
>  void cpu_exit(CPUState *cpu)
>  {
> -    qatomic_set(&cpu->exit_request, 1);
> +    /* Ensure cpu_exec will see the reason why the exit request was set.  */
> +    qatomic_store_release(&cpu->exit_request, true);
>      /* Ensure cpu_exec will see the exit request after TCG has exited.  */
>      smp_wmb();
>      qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
> diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
> index e1151b04c6e..10bd51d9b59 100644
> --- a/target/i386/nvmm/nvmm-all.c
> +++ b/target/i386/nvmm/nvmm-all.c
> @@ -743,7 +743,8 @@ nvmm_vcpu_loop(CPUState *cpu)
>  
>          nvmm_vcpu_pre_run(cpu);
>  
> -        if (qatomic_read(&cpu->exit_request)) {
> +        /* Corresponding store-release is in cpu_exit. */
> +        if (qatomic_load_acquire(&cpu->exit_request)) {
>  #if NVMM_USER_VERSION >= 2
>              nvmm_vcpu_stop(vcpu);
>  #else
> @@ -751,8 +752,6 @@ nvmm_vcpu_loop(CPUState *cpu)
>  #endif
>          }
>  
> -        /* Read exit_request before the kernel reads the immediate exit flag */
> -        smp_rmb();
>          ret = nvmm_vcpu_run(mach, vcpu);
>          if (ret == -1) {
>              error_report("NVMM: Failed to exec a virtual processor,"
> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
> index c09a0a64f22..2106c29c3a0 100644
> --- a/target/i386/whpx/whpx-all.c
> +++ b/target/i386/whpx/whpx-all.c
> @@ -1714,7 +1714,8 @@ static int whpx_vcpu_run(CPUState *cpu)
>          if (exclusive_step_mode == WHPX_STEP_NONE) {
>              whpx_vcpu_pre_run(cpu);
>  
> -            if (qatomic_read(&cpu->exit_request)) {
> +            /* Corresponding store-release is in cpu_exit. */
> +            if (qatomic_load_acquire(&cpu->exit_request)) {
>                  whpx_vcpu_kick(cpu);
>              }
>          }



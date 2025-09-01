Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA92CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut48f-0007OM-NQ; Mon, 01 Sep 2025 09:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut48d-0007NV-6A
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:59:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut48Y-0005R4-Jv
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756731590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kJN4CgvNPux64sdzikWX7SL8X4G3ubjXMYMZPvPd8dQ=;
 b=cvEFXpHwgjVEuvTMn+xj7d8b5RrnK3Jd/7QrIfpecjCeoYqpiZSgFPo695CS+CW9til77r
 116j87xLYk6YjaXxGuz9dDxH9JDcdXvfQRlHn54JgOTA3rivZI/r3htXTk2Mg46MWZUe3/
 Az7LJM6wOQsBi9KNZxcjCY5JjZqW5lw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-2fJhdC8bNXWk-M8LFnyWpg-1; Mon, 01 Sep 2025 08:59:49 -0400
X-MC-Unique: 2fJhdC8bNXWk-M8LFnyWpg-1
X-Mimecast-MFC-AGG-ID: 2fJhdC8bNXWk-M8LFnyWpg_1756731588
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-70dd6d25992so85278626d6.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 05:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756731588; x=1757336388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kJN4CgvNPux64sdzikWX7SL8X4G3ubjXMYMZPvPd8dQ=;
 b=WJAudXpdxiiAw44dEYOKu30v2fZUp+yvj8roM7v1WTO9fSUdy+/RDfDEhGcoCtF/FV
 QRKisVa3F+y2VJ1w2pFWMTn8tlByj5Fxljl64s7tctvHND4qO0UiBwxrG7+cP87Yl8oB
 5M/SUPtVvmVZpH6r9ppZFL0oOn0rpztybnxDgX7IOfkDbcuUtP5BaoFXkcxATRikpGGf
 BhUw6UAzOb1WY/BV1Uuly6DMHgM4t0YRXejT+yKMaPEsjPvplMNIcnrdkhZizIfAWEjw
 +el2fabZ9LmOMSwKPhmTeZRgQjH/pfyLJywXDet/bczkohEtwsGwNxxL09pVyjzLSKll
 xsiQ==
X-Gm-Message-State: AOJu0YxXfq4sfelif27xocx+qcAU+Q2kBPfdguA+WrKayICCDT/deKBj
 rgMIigKrI7wfBKWds5g2SEISywc6TGQe51DpqYOzAzwDGDOmdpYPGVDzQvPo7+eYgB/na8gUyN/
 Yk45FTcAq0n1I60+SnkYt/tEcQA6pEGkgEYMRGp11S8K2JomItMQusV2/
X-Gm-Gg: ASbGncv3lPDS56JI74SPVBJQRC6FGCNyme0HcgKFWX0kR0r0fsGbazUsaSCq4st6xCg
 CSZK61GQja9624aMYp6rAjzr23njnLGClOiSQu1AK6UvPuDM73zq7bGgo8ttYONsgLGJKB/D/dR
 nJs8ppSrDzrzO4WeruiNloPbBHMuDwHfkQCAZs5FwHpjl4g6hAe55lBEPim9enoyd9mz44gQVyd
 lKbsq6pPIliyh6AlT6NlUa/dP06g1pLbmuvVCiyrk/0rFUPgnKcHMMuX/IeqQFw7o9F8YB+52r2
 LxRdYNhkAmXIEsgzv8j9Ktj5y9hjVA==
X-Received: by 2002:a05:6214:ccc:b0:714:36b2:a271 with SMTP id
 6a1803df08f44-71436b2aaeamr54425336d6.66.1756731588355; 
 Mon, 01 Sep 2025 05:59:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExOIJlOX6TLQmaQclRv9BVSiAsub5oHWkrxlv2YxMnFFoA3l4BIwiqpWfora1i02fGB/SQGQ==
X-Received: by 2002:a05:6214:ccc:b0:714:36b2:a271 with SMTP id
 6a1803df08f44-71436b2aaeamr54424876d6.66.1756731587617; 
 Mon, 01 Sep 2025 05:59:47 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70fb25c86d9sm40336596d6.3.2025.09.01.05.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 05:59:47 -0700 (PDT)
Date: Mon, 1 Sep 2025 14:59:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, richard.henderson@linaro.org
Subject: Re: [PATCH 06/18] treewide: clear bits of cs->interrupt_request
 with cpu_reset_interrupt()
Message-ID: <20250901145944.4e83030f@fedora>
In-Reply-To: <20250829153115.1590048-2-pbonzini@redhat.com>
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-2-pbonzini@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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

On Fri, 29 Aug 2025 17:31:03 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

beside nit below

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  accel/tcg/cpu-exec.c                |  6 +++---
>  hw/core/cpu-system.c                |  2 +-
>  target/avr/helper.c                 |  4 ++--
>  target/i386/hvf/x86hvf.c            |  8 ++++----
>  target/i386/kvm/kvm.c               | 14 +++++++-------
>  target/i386/nvmm/nvmm-all.c         | 10 +++++-----
>  target/i386/tcg/system/seg_helper.c | 13 ++++++-------
>  target/i386/tcg/system/svm_helper.c |  2 +-
>  target/i386/whpx/whpx-all.c         | 12 ++++++------
>  target/openrisc/sys_helper.c        |  2 +-
>  target/rx/helper.c                  |  4 ++--
>  target/s390x/tcg/excp_helper.c      |  2 +-
>  12 files changed, 39 insertions(+), 40 deletions(-)
> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 8491e5badd1..508d2d2d9e2 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -784,7 +784,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>      if (unlikely(cpu_test_interrupt(cpu, ~0))) {
>          bql_lock();
>          if (cpu_test_interrupt(cpu, CPU_INTERRUPT_DEBUG)) {
> -            cpu->interrupt_request &= ~CPU_INTERRUPT_DEBUG;
> +            cpu_reset_interrupt(cpu, CPU_INTERRUPT_DEBUG);
>              cpu->exception_index = EXCP_DEBUG;
>              bql_unlock();
>              return true;
> @@ -793,7 +793,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>              /* Do nothing */
>          } else if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HALT)) {
>              replay_interrupt();
> -            cpu->interrupt_request &= ~CPU_INTERRUPT_HALT;
> +            cpu_reset_interrupt(cpu, CPU_INTERRUPT_HALT);
>              cpu->halted = 1;
>              cpu->exception_index = EXCP_HLT;
>              bql_unlock();
> @@ -840,7 +840,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>              }
>          }
>          if (cpu_test_interrupt(cpu, CPU_INTERRUPT_EXITTB)) {
> -            cpu->interrupt_request &= ~CPU_INTERRUPT_EXITTB;
> +            cpu_reset_interrupt(cpu, CPU_INTERRUPT_EXITTB);
>              /* ensure that no TB jump will be modified as
>                 the program flow was changed */
>              *last_tb = NULL;
> diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
> index a975405d3a0..09c928c1f92 100644
> --- a/hw/core/cpu-system.c
> +++ b/hw/core/cpu-system.c
> @@ -204,7 +204,7 @@ static int cpu_common_post_load(void *opaque, int version_id)
>           * 0x01 was CPU_INTERRUPT_EXIT. This line can be removed when the
>           * version_id is increased.
>           */
> -        cpu->interrupt_request &= ~0x01;
> +        cpu_reset_interrupt(cpu, 0x01);
>  
>          tlb_flush(cpu);
>  
> diff --git a/target/avr/helper.c b/target/avr/helper.c
> index b9cd6d5ef27..4b29ab35263 100644
> --- a/target/avr/helper.c
> +++ b/target/avr/helper.c
> @@ -47,7 +47,7 @@ bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>              cs->exception_index = EXCP_RESET;
>              avr_cpu_do_interrupt(cs);
>  
> -            cs->interrupt_request &= ~CPU_INTERRUPT_RESET;
> +            cpu_reset_interrupt(cs, CPU_INTERRUPT_RESET);
>              return true;
>          }
>      }
> @@ -59,7 +59,7 @@ bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>  
>              env->intsrc &= env->intsrc - 1; /* clear the interrupt */
>              if (!env->intsrc) {
> -                cs->interrupt_request &= ~CPU_INTERRUPT_HARD;
> +                cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
>              }
>              return true;
>          }
> diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
> index 9e05e0e5765..a502437c303 100644
> --- a/target/i386/hvf/x86hvf.c
> +++ b/target/i386/hvf/x86hvf.c
> @@ -397,7 +397,7 @@ bool hvf_inject_interrupts(CPUState *cs)
>  
>      if (cpu_test_interrupt(cs, CPU_INTERRUPT_NMI)) {
>          if (!(env->hflags2 & HF2_NMI_MASK) && !(info & VMCS_INTR_VALID)) {
> -            cs->interrupt_request &= ~CPU_INTERRUPT_NMI;
> +            cpu_reset_interrupt(cs, CPU_INTERRUPT_NMI);
>              info = VMCS_INTR_VALID | VMCS_INTR_T_NMI | EXCP02_NMI;
>              wvmcs(cs->accel->fd, VMCS_ENTRY_INTR_INFO, info);
>          } else {
> @@ -409,7 +409,7 @@ bool hvf_inject_interrupts(CPUState *cs)
>          cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
>          (env->eflags & IF_MASK) && !(info & VMCS_INTR_VALID)) {
>          int line = cpu_get_pic_interrupt(env);
> -        cs->interrupt_request &= ~CPU_INTERRUPT_HARD;
> +        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
>          if (line >= 0) {
>              wvmcs(cs->accel->fd, VMCS_ENTRY_INTR_INFO, line |
>                    VMCS_INTR_VALID | VMCS_INTR_T_HWINTR);
> @@ -437,7 +437,7 @@ int hvf_process_events(CPUState *cs)
>      }
>  
>      if (cpu_test_interrupt(cs, CPU_INTERRUPT_POLL)) {
> -        cs->interrupt_request &= ~CPU_INTERRUPT_POLL;
> +        cpu_reset_interrupt(cs, CPU_INTERRUPT_POLL);
>          apic_poll_irq(cpu->apic_state);
>      }
>      if ((cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
> @@ -450,7 +450,7 @@ int hvf_process_events(CPUState *cs)
>          do_cpu_sipi(cpu);
>      }
>      if (cpu_test_interrupt(cs, CPU_INTERRUPT_TPR)) {
> -        cs->interrupt_request &= ~CPU_INTERRUPT_TPR;
> +        cpu_reset_interrupt(cs, CPU_INTERRUPT_TPR);
>          cpu_synchronize_state(cs);
>          apic_handle_tpr_access_report(cpu->apic_state, env->eip,
>                                        env->tpr_access_type);
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 306430a0521..8420c4090ef 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -5066,7 +5066,7 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
>               */
>              events.smi.pending = cs->interrupt_request & CPU_INTERRUPT_SMI;
>              events.smi.latched_init = cs->interrupt_request & CPU_INTERRUPT_INIT;
> -            cs->interrupt_request &= ~(CPU_INTERRUPT_INIT | CPU_INTERRUPT_SMI);
> +            cpu_reset_interrupt(cs, CPU_INTERRUPT_INIT | CPU_INTERRUPT_SMI);

this was called without BQL in kvm_cpu_exec(),
perhaps mention in commit message that beside replacing
open coded interrupt reset commit also fixes potential bug since
cpu_reset_interrupt() would take BQL now. (or make this hunk a separate patch)

not sure but perhaps the same applies to hunk in target/i386/tcg/system/svm_helper.c


>          } else {
>              /* Keep these in cs->interrupt_request.  */
>              events.smi.pending = 0;
> @@ -5456,7 +5456,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
>      if (cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
>          if (cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
>              bql_lock();
> -            cpu->interrupt_request &= ~CPU_INTERRUPT_NMI;
> +            cpu_reset_interrupt(cpu, CPU_INTERRUPT_NMI);
>              bql_unlock();
>              DPRINTF("injected NMI\n");
>              ret = kvm_vcpu_ioctl(cpu, KVM_NMI);
> @@ -5467,7 +5467,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
>          }
>          if (cpu_test_interrupt(cpu, CPU_INTERRUPT_SMI)) {
>              bql_lock();
> -            cpu->interrupt_request &= ~CPU_INTERRUPT_SMI;
> +            cpu_reset_interrupt(cpu, CPU_INTERRUPT_SMI);
>              bql_unlock();
>              DPRINTF("injected SMI\n");
>              ret = kvm_vcpu_ioctl(cpu, KVM_SMI);
> @@ -5502,7 +5502,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
>  
>              bql_lock();
>  
> -            cpu->interrupt_request &= ~CPU_INTERRUPT_HARD;
> +            cpu_reset_interrupt(cpu, CPU_INTERRUPT_HARD);
>              irq = cpu_get_pic_interrupt(env);
>              if (irq >= 0) {
>                  struct kvm_interrupt intr;
> @@ -5597,7 +5597,7 @@ int kvm_arch_process_async_events(CPUState *cs)
>          /* We must not raise CPU_INTERRUPT_MCE if it's not supported. */
>          assert(env->mcg_cap);
>  
> -        cs->interrupt_request &= ~CPU_INTERRUPT_MCE;
> +        cpu_reset_interrupt(cs, CPU_INTERRUPT_MCE);
>  
>          kvm_cpu_synchronize_state(cs);
>  
> @@ -5627,7 +5627,7 @@ int kvm_arch_process_async_events(CPUState *cs)
>      }
>  
>      if (cpu_test_interrupt(cs, CPU_INTERRUPT_POLL)) {
> -        cs->interrupt_request &= ~CPU_INTERRUPT_POLL;
> +        cpu_reset_interrupt(cs, CPU_INTERRUPT_POLL);
>          apic_poll_irq(cpu->apic_state);
>      }
>      if ((cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
> @@ -5640,7 +5640,7 @@ int kvm_arch_process_async_events(CPUState *cs)
>          do_cpu_sipi(cpu);
>      }
>      if (cpu_test_interrupt(cs, CPU_INTERRUPT_TPR)) {
> -        cs->interrupt_request &= ~CPU_INTERRUPT_TPR;
> +        cpu_reset_interrupt(cs, CPU_INTERRUPT_TPR);
>          kvm_cpu_synchronize_state(cs);
>          apic_handle_tpr_access_report(cpu->apic_state, env->eip,
>                                        env->tpr_access_type);
> diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
> index c1ac74c4f04..e1151b04c6e 100644
> --- a/target/i386/nvmm/nvmm-all.c
> +++ b/target/i386/nvmm/nvmm-all.c
> @@ -419,7 +419,7 @@ nvmm_vcpu_pre_run(CPUState *cpu)
>  
>      if (!has_event && cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
>          if (nvmm_can_take_nmi(cpu)) {
> -            cpu->interrupt_request &= ~CPU_INTERRUPT_NMI;
> +            cpu_reset_interrupt(cpu, CPU_INTERRUPT_NMI);
>              event->type = NVMM_VCPU_EVENT_INTR;
>              event->vector = 2;
>              has_event = true;
> @@ -428,7 +428,7 @@ nvmm_vcpu_pre_run(CPUState *cpu)
>  
>      if (!has_event && cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
>          if (nvmm_can_take_int(cpu)) {
> -            cpu->interrupt_request &= ~CPU_INTERRUPT_HARD;
> +            cpu_reset_interrupt(cpu, CPU_INTERRUPT_HARD);
>              event->type = NVMM_VCPU_EVENT_INTR;
>              event->vector = cpu_get_pic_interrupt(env);
>              has_event = true;
> @@ -437,7 +437,7 @@ nvmm_vcpu_pre_run(CPUState *cpu)
>  
>      /* Don't want SMIs. */
>      if (cpu_test_interrupt(cpu, CPU_INTERRUPT_SMI)) {
> -        cpu->interrupt_request &= ~CPU_INTERRUPT_SMI;
> +        cpu_reset_interrupt(cpu, CPU_INTERRUPT_SMI);
>      }
>  
>      if (sync_tpr) {
> @@ -697,7 +697,7 @@ nvmm_vcpu_loop(CPUState *cpu)
>          /* set int/nmi windows back to the reset state */
>      }
>      if (cpu_test_interrupt(cpu, CPU_INTERRUPT_POLL)) {
> -        cpu->interrupt_request &= ~CPU_INTERRUPT_POLL;
> +        cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
>          apic_poll_irq(x86_cpu->apic_state);
>      }
>      if ((cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD) &&
> @@ -710,7 +710,7 @@ nvmm_vcpu_loop(CPUState *cpu)
>          do_cpu_sipi(x86_cpu);
>      }
>      if (cpu_test_interrupt(cpu, CPU_INTERRUPT_TPR)) {
> -        cpu->interrupt_request &= ~CPU_INTERRUPT_TPR;
> +        cpu_reset_interrupt(cpu, CPU_INTERRUPT_TPR);
>          nvmm_cpu_synchronize_state(cpu);
>          apic_handle_tpr_access_report(x86_cpu->apic_state, env->eip,
>              env->tpr_access_type);
> diff --git a/target/i386/tcg/system/seg_helper.c b/target/i386/tcg/system/seg_helper.c
> index 794a23ddfc4..38072e51d72 100644
> --- a/target/i386/tcg/system/seg_helper.c
> +++ b/target/i386/tcg/system/seg_helper.c
> @@ -178,7 +178,7 @@ bool x86_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>       */
>      switch (interrupt_request) {
>      case CPU_INTERRUPT_POLL:
> -        cs->interrupt_request &= ~CPU_INTERRUPT_POLL;
> +        cpu_reset_interrupt(cs, CPU_INTERRUPT_POLL);
>          apic_poll_irq(cpu->apic_state);
>          break;
>      case CPU_INTERRUPT_SIPI:
> @@ -186,23 +186,22 @@ bool x86_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>          break;
>      case CPU_INTERRUPT_SMI:
>          cpu_svm_check_intercept_param(env, SVM_EXIT_SMI, 0, 0);
> -        cs->interrupt_request &= ~CPU_INTERRUPT_SMI;
> +        cpu_reset_interrupt(cs, CPU_INTERRUPT_SMI);
>          do_smm_enter(cpu);
>          break;
>      case CPU_INTERRUPT_NMI:
>          cpu_svm_check_intercept_param(env, SVM_EXIT_NMI, 0, 0);
> -        cs->interrupt_request &= ~CPU_INTERRUPT_NMI;
> +        cpu_reset_interrupt(cs, CPU_INTERRUPT_NMI);
>          env->hflags2 |= HF2_NMI_MASK;
>          do_interrupt_x86_hardirq(env, EXCP02_NMI, 1);
>          break;
>      case CPU_INTERRUPT_MCE:
> -        cs->interrupt_request &= ~CPU_INTERRUPT_MCE;
> +        cpu_reset_interrupt(cs, CPU_INTERRUPT_MCE);
>          do_interrupt_x86_hardirq(env, EXCP12_MCHK, 0);
>          break;
>      case CPU_INTERRUPT_HARD:
>          cpu_svm_check_intercept_param(env, SVM_EXIT_INTR, 0, 0);
> -        cs->interrupt_request &= ~(CPU_INTERRUPT_HARD |
> -                                   CPU_INTERRUPT_VIRQ);
> +        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_VIRQ);
>          intno = cpu_get_pic_interrupt(env);
>          qemu_log_mask(CPU_LOG_INT,
>                        "Servicing hardware INT=0x%02x\n", intno);
> @@ -215,7 +214,7 @@ bool x86_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>          qemu_log_mask(CPU_LOG_INT,
>                        "Servicing virtual hardware INT=0x%02x\n", intno);
>          do_interrupt_x86_hardirq(env, intno, 1);
> -        cs->interrupt_request &= ~CPU_INTERRUPT_VIRQ;
> +        cpu_reset_interrupt(cs, CPU_INTERRUPT_VIRQ);
>          env->int_ctl &= ~V_IRQ_MASK;
>          break;
>      }
> diff --git a/target/i386/tcg/system/svm_helper.c b/target/i386/tcg/system/svm_helper.c
> index 3569196bdda..505788b0e26 100644
> --- a/target/i386/tcg/system/svm_helper.c
> +++ b/target/i386/tcg/system/svm_helper.c
> @@ -824,7 +824,7 @@ void do_vmexit(CPUX86State *env)
>      env->intercept_exceptions = 0;
>  
>      /* Clears the V_IRQ and V_INTR_MASKING bits inside the processor. */
> -    cs->interrupt_request &= ~CPU_INTERRUPT_VIRQ;
> +    cpu_reset_interrupt(cs, CPU_INTERRUPT_VIRQ);
>      env->int_ctl = 0;
>  
>      /* Clears the TSC_OFFSET inside the processor. */
> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
> index 878cdd1668c..c09a0a64f22 100644
> --- a/target/i386/whpx/whpx-all.c
> +++ b/target/i386/whpx/whpx-all.c
> @@ -1471,14 +1471,14 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
>      if (!vcpu->interruption_pending &&
>          cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
>          if (cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
> -            cpu->interrupt_request &= ~CPU_INTERRUPT_NMI;
> +            cpu_reset_interrupt(cpu, CPU_INTERRUPT_NMI);
>              vcpu->interruptable = false;
>              new_int.InterruptionType = WHvX64PendingNmi;
>              new_int.InterruptionPending = 1;
>              new_int.InterruptionVector = 2;
>          }
>          if (cpu_test_interrupt(cpu, CPU_INTERRUPT_SMI)) {
> -            cpu->interrupt_request &= ~CPU_INTERRUPT_SMI;
> +            cpu_reset_interrupt(cpu, CPU_INTERRUPT_SMI);
>          }
>      }
>  
> @@ -1502,7 +1502,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
>              vcpu->interruptable && (env->eflags & IF_MASK)) {
>              assert(!new_int.InterruptionPending);
>              if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
> -                cpu->interrupt_request &= ~CPU_INTERRUPT_HARD;
> +                cpu_reset_interrupt(cpu, CPU_INTERRUPT_HARD);
>                  irq = cpu_get_pic_interrupt(env);
>                  if (irq >= 0) {
>                      new_int.InterruptionType = WHvX64PendingInterrupt;
> @@ -1520,7 +1520,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
>          }
>      } else if (vcpu->ready_for_pic_interrupt &&
>                 cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
> -        cpu->interrupt_request &= ~CPU_INTERRUPT_HARD;
> +        cpu_reset_interrupt(cpu, CPU_INTERRUPT_HARD);
>          irq = cpu_get_pic_interrupt(env);
>          if (irq >= 0) {
>              reg_names[reg_count] = WHvRegisterPendingEvent;
> @@ -1607,7 +1607,7 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
>      }
>  
>      if (cpu_test_interrupt(cpu, CPU_INTERRUPT_POLL)) {
> -        cpu->interrupt_request &= ~CPU_INTERRUPT_POLL;
> +        cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
>          apic_poll_irq(x86_cpu->apic_state);
>      }
>  
> @@ -1623,7 +1623,7 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
>      }
>  
>      if (cpu_test_interrupt(cpu, CPU_INTERRUPT_TPR)) {
> -        cpu->interrupt_request &= ~CPU_INTERRUPT_TPR;
> +        cpu_reset_interrupt(cpu, CPU_INTERRUPT_TPR);
>          whpx_cpu_synchronize_state(cpu);
>          apic_handle_tpr_access_report(x86_cpu->apic_state, env->eip,
>                                        env->tpr_access_type);
> diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
> index d96b41a01c2..b091a9c6685 100644
> --- a/target/openrisc/sys_helper.c
> +++ b/target/openrisc/sys_helper.c
> @@ -196,7 +196,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
>                  env->ttmr = (rb & ~TTMR_IP) | ip;
>              } else {    /* Clear IP bit.  */
>                  env->ttmr = rb & ~TTMR_IP;
> -                cs->interrupt_request &= ~CPU_INTERRUPT_TIMER;
> +                cpu_reset_interrupt(cs, CPU_INTERRUPT_TIMER);
>              }
>              cpu_openrisc_timer_update(cpu);
>              bql_unlock();
> diff --git a/target/rx/helper.c b/target/rx/helper.c
> index ce003af4219..41c9606fd1d 100644
> --- a/target/rx/helper.c
> +++ b/target/rx/helper.c
> @@ -63,7 +63,7 @@ void rx_cpu_do_interrupt(CPUState *cs)
>              env->bpsw = save_psw;
>              env->pc = env->fintv;
>              env->psw_ipl = 15;
> -            cs->interrupt_request &= ~CPU_INTERRUPT_FIR;
> +            cpu_reset_interrupt(cs, CPU_INTERRUPT_FIR);
>              qemu_set_irq(env->ack, env->ack_irq);
>              qemu_log_mask(CPU_LOG_INT, "fast interrupt raised\n");
>          } else if (do_irq & CPU_INTERRUPT_HARD) {
> @@ -73,7 +73,7 @@ void rx_cpu_do_interrupt(CPUState *cs)
>              cpu_stl_data(env, env->isp, env->pc);
>              env->pc = cpu_ldl_data(env, env->intb + env->ack_irq * 4);
>              env->psw_ipl = env->ack_ipl;
> -            cs->interrupt_request &= ~CPU_INTERRUPT_HARD;
> +            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
>              qemu_set_irq(env->ack, env->ack_irq);
>              qemu_log_mask(CPU_LOG_INT,
>                            "interrupt 0x%02x raised\n", env->ack_irq);
> diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
> index e4c75d0ce01..4c7faeee82b 100644
> --- a/target/s390x/tcg/excp_helper.c
> +++ b/target/s390x/tcg/excp_helper.c
> @@ -559,7 +559,7 @@ try_deliver:
>  
>      /* we might still have pending interrupts, but not deliverable */
>      if (!env->pending_int && !qemu_s390_flic_has_any(flic)) {
> -        cs->interrupt_request &= ~CPU_INTERRUPT_HARD;
> +        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
>      }
>  
>      /* WAIT PSW during interrupt injection or STOP interrupt */



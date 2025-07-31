Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34BEC87FCC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 20:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uha0L-0003jh-GC; Thu, 31 Jul 2025 16:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uhYty-0001aA-DP
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 15:25:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uhYtw-0004AG-2C
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 15:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753989914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QXSIdstZfjGNG7c9NTmPEpyllqt0bQnq/AKMbOHjSTc=;
 b=LUn2C0GGcXnQ7exwOPXBcuCnv8KkdpHasuCAm2/gxFb89KnZdj8LGt2W/U+La21bHFn/qn
 5aHIe4ZX4QzgcqkSO0cdQt0hTVlpbNNavq1EJYbQFHWnBpp817V0QxWAku2g5AtdbjyLj1
 utueZJ6f1xfunLFkXhHBXoo+2CJNetA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-hGZ89WR6Oa65q5BJyNm5rg-1; Thu, 31 Jul 2025 15:25:12 -0400
X-MC-Unique: hGZ89WR6Oa65q5BJyNm5rg-1
X-Mimecast-MFC-AGG-ID: hGZ89WR6Oa65q5BJyNm5rg_1753989912
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-7073cd24febso1317036d6.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 12:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753989912; x=1754594712;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QXSIdstZfjGNG7c9NTmPEpyllqt0bQnq/AKMbOHjSTc=;
 b=rsCO0Q0uW8RqCLwEmZ1MPSYQ+zBVbtJL9Z51qrRnsWXpjeae/LoDTAYKb88f/ZN/Sn
 lusmDkdHuwTEVV+d/GbT7+VWErrfGfW8YX2UIj9gp+0ZKNaMzv3pelsakOeKN7mTuKfg
 Yx8hqdOXEKChlc6bCyuGqWY+R1tTn1beYtshbGWzShyWEOYxzhJGhmi6ufofy6n74Qvh
 4cQ2/NeaVXV3SE7/hD1BEKYwnYthvu7Rj8n55txYVmfgO7xiSMF9quyVaUmZSjal52y4
 T8FAgMeR+MTViwbzF5auRtldxkeluQQAySn2QVaIUHToLoj5XklwXSsbmLDBIpx6/l72
 Y8gQ==
X-Gm-Message-State: AOJu0YxCOmThQCKSiOF/scCfLaGRIHhcyBZpX+iv82FOrbcapExADWuU
 3YUKQpwvgEbTibDMxTVCHkpn/1EAqngnY/G7oVw7C97Zt8FBtqXmIT3QZ+js4qzcNfru3KvTTB3
 wMiH8yW2xhbUZCFe3ILFPhTetNr0BuUWHOTcJCiC9ohxPFH6oQWgg10mm
X-Gm-Gg: ASbGncuJghRMhGyuEMd9qE+pN/nC7t6vZZruICeHm3DHvsntI1O8cV5Vxh5ycr787CT
 Axm45RqMagvX4gWWXmiX/tpWm7mFQed6XUk9agoL5NCdKEkpIVDB3turZ9mM1O4oWtgc3v/yQfa
 3Eh0M3haRN2GHYSn8t4qAZfi6En3gysjtp9eG4ZnFoLM+ZpWeejMmO0mPeceDVj6mX9DThz3iF7
 qq30bv9zOtXuDw18r5+wiDTFulxYojos2ZJ56VwnCwcmgwOIAS6YmW044Quy5TrLXzt53Eu2ybH
 XVE0HDe9/YJZsGlZBC6Vv7hJ8UXGzlva
X-Received: by 2002:a05:6214:cc7:b0:706:aae8:ad48 with SMTP id
 6a1803df08f44-7076721a032mr113497466d6.35.1753989911781; 
 Thu, 31 Jul 2025 12:25:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdUbB4By1fXwkIdpqgpTSfJB4SgSqadgNvrFjWdpE4ZoQMN5akQKyZOKW/76Fr2Rl7IhUg+g==
X-Received: by 2002:a05:6214:cc7:b0:706:aae8:ad48 with SMTP id
 6a1803df08f44-7076721a032mr113496796d6.35.1753989911053; 
 Thu, 31 Jul 2025 12:25:11 -0700 (PDT)
Received: from x1.local ([174.89.135.171]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077ca1d5ecsm11414126d6.26.2025.07.31.12.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 12:25:10 -0700 (PDT)
Date: Thu, 31 Jul 2025 15:24:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 mtosatti@redhat.com, kraxel@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCH v2 6/6] kvm: i386: irqchip: take BQL only if there is an
 interrupt
Message-ID: <aIvDC4nv1mUNLeMI@x1.local>
References: <20250730123934.1787379-1-imammedo@redhat.com>
 <20250730123934.1787379-7-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250730123934.1787379-7-imammedo@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Wed, Jul 30, 2025 at 02:39:34PM +0200, Igor Mammedov wrote:
> when kernel-irqchip=split is used, QEMU still hits BQL
> contention issue when reading ACPI PM/HPET timers
> (despite of timer[s] access being lock-less).
> 
> So Windows with more than 255 cpus is still not able to
> boot (since it requires iommu -> split irqchip).
> 
> Problematic path is in kvm_arch_pre_run() where BQL is taken
> unconditionally when split irqchip is in use.
> 
> There are a few parts tha BQL protects there:
>   1. interrupt check and injecting
> 
>     however we do not take BQL when checking for pending
>     interrupt (even within the same function), so the patch
>     takes the same approach for cpu->interrupt_request checks
>     and takes BQL only if there is a job to do.
> 
>   2. request_interrupt_window access
>       CPUState::kvm_run::request_interrupt_window doesn't need BQL
>       as it's accessed on side QEMU only by its own vCPU thread.
>       The only thing that BQL provides there is implict barrier.
>       Which can be done by using cheaper explicit barrier there.
> 
>   3. cr8/cpu_get_apic_tpr access
>       the same (as #2) applies to CPUState::kvm_run::cr8 write,
>       and APIC registers are also cached/synced (get/put) within
>       the vCPU thread it belongs to.
> 
> Taking BQL only when is necessary, eleminates BQL bottleneck on
> IO/MMIO only exit path, improoving latency by 80% on HPET micro
> benchmark.
> 
> This lets Windows to boot succesfully (in case hv-time isn't used)
> when more than 255 vCPUs are in use.

Not familiar with this path, but the change looks reasonable, a few pure
questions inline.

> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  target/i386/kvm/kvm.c | 58 +++++++++++++++++++++++++++----------------
>  1 file changed, 37 insertions(+), 21 deletions(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 369626f8c8..32024d50f5 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -5450,6 +5450,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
>  {
>      X86CPU *x86_cpu = X86_CPU(cpu);
>      CPUX86State *env = &x86_cpu->env;
> +    bool release_bql = 0;
>      int ret;
>  
>      /* Inject NMI */
> @@ -5478,15 +5479,16 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
>          }
>      }
>  
> -    if (!kvm_pic_in_kernel()) {
> -        bql_lock();
> -    }
>  
>      /* Force the VCPU out of its inner loop to process any INIT requests
>       * or (for userspace APIC, but it is cheap to combine the checks here)
>       * pending TPR access reports.
>       */
>      if (cpu->interrupt_request & (CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
> +        if (!kvm_pic_in_kernel()) {
> +            bql_lock();
> +            release_bql = true;
> +        }

Does updating exit_request need bql at all?  I saw the pattern is this:

        kvm_arch_pre_run(cpu, run);
        if (qatomic_read(&cpu->exit_request)) {
            trace_kvm_interrupt_exit_request();
            /*
             * KVM requires us to reenter the kernel after IO exits to complete
             * instruction emulation. This self-signal will ensure that we
             * leave ASAP again.
             */
            kvm_cpu_kick_self();
        }

So setting exit_request=1 here will likely be read very soon later, in this
case it seems the lock isn't needed.

>          if ((cpu->interrupt_request & CPU_INTERRUPT_INIT) &&
>              !(env->hflags & HF_SMM_MASK)) {
>              cpu->exit_request = 1;
> @@ -5497,24 +5499,31 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
>      }
>  
>      if (!kvm_pic_in_kernel()) {
> -        /* Try to inject an interrupt if the guest can accept it */
> -        if (run->ready_for_interrupt_injection &&
> -            (cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
> -            (env->eflags & IF_MASK)) {
> -            int irq;
> -
> -            cpu->interrupt_request &= ~CPU_INTERRUPT_HARD;
> -            irq = cpu_get_pic_interrupt(env);
> -            if (irq >= 0) {
> -                struct kvm_interrupt intr;
> -
> -                intr.irq = irq;
> -                DPRINTF("injected interrupt %d\n", irq);
> -                ret = kvm_vcpu_ioctl(cpu, KVM_INTERRUPT, &intr);
> -                if (ret < 0) {
> -                    fprintf(stderr,
> -                            "KVM: injection failed, interrupt lost (%s)\n",
> -                            strerror(-ret));
> +        if (cpu->interrupt_request & CPU_INTERRUPT_HARD) {
> +            if (!release_bql) {
> +                bql_lock();
> +                release_bql = true;
> +            }
> +
> +            /* Try to inject an interrupt if the guest can accept it */
> +            if (run->ready_for_interrupt_injection &&
> +                (cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
> +                (env->eflags & IF_MASK)) {
> +                int irq;
> +
> +                cpu->interrupt_request &= ~CPU_INTERRUPT_HARD;
> +                irq = cpu_get_pic_interrupt(env);
> +                if (irq >= 0) {
> +                    struct kvm_interrupt intr;
> +
> +                    intr.irq = irq;
> +                    DPRINTF("injected interrupt %d\n", irq);
> +                    ret = kvm_vcpu_ioctl(cpu, KVM_INTERRUPT, &intr);
> +                    if (ret < 0) {
> +                        fprintf(stderr,
> +                                "KVM: injection failed, interrupt lost (%s)\n",
> +                                strerror(-ret));
> +                    }
>                  }
>              }
>          }
> @@ -5531,7 +5540,14 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
>  
>          DPRINTF("setting tpr\n");
>          run->cr8 = cpu_get_apic_tpr(x86_cpu->apic_state);
> +        /*
> +         * make sure that request_interrupt_window/cr8 are set
> +         * before KVM_RUN might read them
> +         */
> +        smp_mb();

Is this mb() needed if KVM_RUN will always happen in the same thread anyway?

Thanks,

> +    }
>  
> +    if (release_bql) {
>          bql_unlock();
>      }
>  }
> -- 
> 2.47.1
> 

-- 
Peter Xu



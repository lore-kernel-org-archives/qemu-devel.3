Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD29E606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 09:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NKhYhVPV;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Qlxk62r5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMMcg-0006Ld-W4; Thu, 29 Oct 2026 05:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xMMce-0006Kl-P5
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 05:40:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xMMcd-0007UB-6D
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 05:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793266834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LwaPOvuylH4iynsuqQIDIgAPiysf4YjtFnJtH91GqsY=;
 b=NKhYhVPVAcuh+EGIG5OahVIkWzmKj+bNY0noOnEsPBhiOcBEs5R3ouNs8IsNZi3nGyMfzw
 km4urCj4kRciJiFz1WUUfGjENQOCQneiE9/ZA00HlW7wNYG7NYfSRgH1wT7kJKnBujkbvX
 lTmtwfIE+IIlEvvwcWXa3mrmN5Vzk+w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-EWRPBsbJMxGKs_j4CR0C-Q-1; Thu, 29 Oct 2026 05:40:32 -0400
X-MC-Unique: EWRPBsbJMxGKs_j4CR0C-Q-1
X-Mimecast-MFC-AGG-ID: EWRPBsbJMxGKs_j4CR0C-Q_1793266832
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a359b714f8so17771395e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 02:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793266832; x=1793871632; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LwaPOvuylH4iynsuqQIDIgAPiysf4YjtFnJtH91GqsY=;
 b=Qlxk62r5JXhL8dXwgD5oxi2dtfXAIeOWmE/I74GgmRuRHylUgfv4KxxXFDb/xMcVtL
 s7tM4T3o2Kg2H+jrnZBk1RAIuYL1wELhPtFUhGU4dQcuIfbFrVMqRlNexFgckXWqUSIq
 MkKzf89Lh52yQtL8fGBOLlFMwLfA9ysjU87tBfGOA/ZckbLnUd1xvpd6tI8Hn02lW3+m
 hiASJ4pcMRsoM70pyhbrH5qGBL6rqEI6hkmdEkbjvLWfiqP8dWkosV8LDcoMH0AbM0y4
 VCsGTi6uBs157CjGhGgCWF81hN63zCRCYhEMFy/heoojy/T0txYQ310EZXecKTmeJ44d
 8xnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793266832; x=1793871632;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LwaPOvuylH4iynsuqQIDIgAPiysf4YjtFnJtH91GqsY=;
 b=X6Tpql5HqJT/UzZgX468A5FkipYfC2Y2uzU49nw9gQKGJhfuvdhqy8UVtPo2ttVIWt
 Z2u3+gDmjVy2XEyI8z4eDbGf57BUjbdQdQ1enne1CtS9JKOLcDb70td5wh9n4aV3SUdX
 rvJPeJm2vkEAPnxRb2t+4xtMDVCeKyZEsFJhyGpImq9vsL7Tai91tKnSXgFglXl+0KUT
 apNOZsL4S0Pia4edw2U3wo4pFQ1DfN/8ySD+bFSWfhFOwx+F5iocfccnZx5oQKq4cKr2
 ENmVqevWzWjdO3xYFqaIO+i17BZxsdOrXpf8cdwDIkn6DixtVJBqAZi8rGhB/LVnr+UX
 k9bQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPSXGzdv97xlzhn+eKb9f8aS+GC4+vsmOEyD/aP0AEDGcvk+pGm42eRDL6fhF9CQJCzt1taINTK21O@nongnu.org
X-Gm-Message-State: AFq9FYKJ1Msx3sgjONyKykiUyxS2PAXQRHJ6OwVhTiiTkzh+zwspJ6WM
 wCwbV2/CXL5NG0sg4L8EOFzi4iq78mXUGE25VyRGI/qUsRfBZFUiqjWhCim2REUBQYtBcJvqACg
 Fx6p8bGmzMbAvwxhBI+sebOuHIoU1sZ8V8OvtA23Pf0mK8degMgMKOzuV
X-Gm-Gg: AYBFou1hdNe4usmcANJ9ofKRddIovP6YUADnoPKUeCJFEWSH7Tk+Jl2QO82+bxGeqAK
 GO3orBwoHjTFdbzqhR+AzXENOIAJENStzKdjWqxGJc0LoXlk3SDnixxw6JM6cHQn8E2jkv2fO+f
 Li/cFEwlrbp5fik5VmSakteqczl5CXLwEV+XQs21jT1Gg+B7634EnIfFbQMStZQee1tBUkuzeEp
 Buu52Km521MJn1is6rnL4O7A0+DrsnTU/L0I0lx7oYdAKQAOYA8KHig2e3WIyRWpDeFcv6K6WGo
 qgEGuqJ2Rcp0/kUm05Ve3Lgt2bv4Hpy3Mr/teiAp6NScSefeFKYVGFfjKgL9R1GNTUdRdiF8gM6
 6nfUvZR++D5E1Kk4680wkuFXJXFnO4m9scQ==
X-Received: by 2002:a05:600c:8718:b0:4a4:de70:2ad4 with SMTP id
 5b1f17b1804b1-4a9670165d0mr112486005e9.22.1793266831802; 
 Thu, 29 Oct 2026 02:40:31 -0700 (PDT)
X-Received: by 2002:a05:600c:8718:b0:4a4:de70:2ad4 with SMTP id
 5b1f17b1804b1-4a9670165d0mr112485535e9.22.1793266831442; 
 Thu, 29 Oct 2026 02:40:31 -0700 (PDT)
Received: from x1 ([151.41.153.165]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f387sm33225612f8f.4.2026.10.29.02.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 02:40:30 -0700 (PDT)
Date: Thu, 29 Oct 2026 10:40:27 +0100
From: Gustavo Romero <gromero@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, shaju.abraham@nutanix.com, khushit.shah@nutanix.com, 
 richard.henderson@linaro.org, pbonzini@redhat.com, skolothumtho@nvidia.com, 
 philmd@oss.qualcomm.com, 7746591750@163.com, maobibo@loongson.cn,
 harshpb@linux.ibm.com, 
 amachhiw@linux.ibm.com, daniel.barboza@oss.qualcomm.com, milesg@linux.ibm.com, 
 farman@linux.ibm.com, cohuck@redhat.com, armbru@redhat.com, mbawa@redhat.com
Subject: Re: [PATCH for-11.2 8/9] target/arm/kvm: Introduce
 kvm_arm_vcpu_prepare_init_features helper
Message-ID: <ks6g4723u4i4t2qgc6a3pzg5gbxws32bpzmztk5z2uw2derhzj@ojxkez4mqqqb>
References: <20261029092307.281287-1-eric.auger@redhat.com>
 <20261029092307.281287-9-eric.auger@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029092307.281287-9-eric.auger@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gromero@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Eric,

On Thu, Oct 29, 2026 at 10:20:20AM +0100, Eric Auger wrote:
> Factorize the code that initializes the kvm init features from the
> cpu settings in a helper. Use it kvm_arch_init_vcpu(). Soon it will
> be used by another function.
> 
> The only change in the code relates to the check of kvm_state. The
> future caller won't have the VM created when calling the helper and
> for this caller it is OK ignoring PSCI version setting.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  target/arm/kvm.c | 50 ++++++++++++++++++++++++++++--------------------
>  1 file changed, 29 insertions(+), 21 deletions(-)
> 
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 2d37c2bfb4..1c5be9ecf4 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -2015,34 +2015,18 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
>      return 0;
>  }
>  
> -int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
> +/* Determine init features for this CPU */
> +static void kvm_arm_vcpu_prepare_init_features(ARMCPU *cpu)
>  {
> -    int ret;
> -    uint64_t mpidr;
> -    ARMCPU *cpu = ARM_CPU(cs);
> +    CPUState *cs = CPU(cpu);
>      CPUARMState *env = &cpu->env;
> -    uint64_t psciver;
>  
> -    if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_NONE) {
> -        error_setg(errp, "KVM is not supported for this guest CPU type");
> -        return -EINVAL;
> -    }
> -
> -    if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_CORTEX_A53 ||
> -        cpu->kvm_target == QEMU_KVM_ARM_TARGET_CORTEX_A57) {
> -        warn_report_once("Using the cortex-a53 and cortex-a57 CPU types "
> -                         "with KVM is deprecated. Use the max or host CPU "
> -                         "types instead.");
> -    }
> -
> -    qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cpu);
> -
> -    /* Determine init features for this CPU */
>      memset(cpu->kvm_init_features, 0, sizeof(cpu->kvm_init_features));
> +
>      if (cs->start_powered_off) {
>          cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_POWER_OFF;
>      }
> -    if (cpu->psci_version != QEMU_PSCI_VERSION_0_1 &&
> +    if (cpu->psci_version != QEMU_PSCI_VERSION_0_1 && cs->kvm_state &&
>          kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PSCI_0_2)) {
>          /*
>           * Versions >= v0.2 are backward compatible with v0.2
> @@ -2066,6 +2050,30 @@ int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
>      if (cpu->has_el2 && kvm_arm_el2_supported()) {
>          cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
>      }
> +}
> +
> +int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
> +{
> +    int ret;
> +    uint64_t mpidr;
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    uint64_t psciver;
> +
> +    if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_NONE) {
> +        error_setg(errp, "KVM is not supported for this guest CPU type");
> +        return -EINVAL;
> +    }
> +
> +    if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_CORTEX_A53 ||
> +        cpu->kvm_target == QEMU_KVM_ARM_TARGET_CORTEX_A57) {
> +        warn_report_once("Using the cortex-a53 and cortex-a57 CPU types "
> +                         "with KVM is deprecated. Use the max or host CPU "
> +                         "types instead.");
> +    }
> +
> +    qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cpu);
> +
> +    kvm_arm_vcpu_prepare_init_features(cpu);
>  
>      /* Do KVM_ARM_VCPU_INIT ioctl */
>      ret = kvm_arm_vcpu_init(cpu);
> -- 
> 2.53.0
> 
> 

Reviewed-by: Gustavo Romero <gromero@redhat.com>


Cheers,
Gustavo



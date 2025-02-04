Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BA8C0218F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 05:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfB6a-0005Z7-Ua; Tue, 04 Feb 2025 00:04:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tfB6Z-0005YV-Jc
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 00:04:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tfB6V-0008Ka-2v
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 00:04:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738645446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zLwPzCW+9mhMz39XR3eYl9jQT8q9/Q27z70z+ybmEIQ=;
 b=gNPIhyXYqmpZxJ9kKeU2VuHCZoppdRH/CjpGRI5ZQ++7W92l9d1wGhpchcUGEl5SOGuoK3
 7YKmuCDg8iScp6d9uWFROd6NoHi3xsreNK5QnjQJEba0szsK5eY7p3qatJ66iR5XBT17Ue
 aDQgH6jML8hHbGexSMcXgmXawLYRplI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-7LGZXr1lNUWqwLuJS_wDYQ-1; Tue, 04 Feb 2025 00:02:48 -0500
X-MC-Unique: 7LGZXr1lNUWqwLuJS_wDYQ-1
X-Mimecast-MFC-AGG-ID: 7LGZXr1lNUWqwLuJS_wDYQ
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ef9e4c5343so14716119a91.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 21:02:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738645368; x=1739250168;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zLwPzCW+9mhMz39XR3eYl9jQT8q9/Q27z70z+ybmEIQ=;
 b=bLtbo9nFHIOTUIyHeCdrQE4D7xHPYWp9Nl0JJeHS6L1slWLM4gjkfHtEI3VIUIVOFP
 e92oXGABge+FLCQr1Nm+8wXVpXCK+ZglrwQ/9SFrsK3zTfqg1jtVPP7jffer9XDOrw0T
 /drWars3GELVFQ2nZnUBetu0iCzVQ0lm1NbzxKQeCc5wK/uElHjQIY3aIVsvUM/KZK22
 4Qr0Dgj+8SPyzTBWuSNWMHYlSMCiY+KR7EGVghByE9rEaAx+WzbhFxZtBrKfcj91FEfF
 WhOxspGOrImkqT2BeO0hTRURXokpx2t1QLJ9Cv64JkCD1bAk+ZinTdqhK1Bjzb9+SVTJ
 QObQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT5jsW3gVlpyHumFFr+o9TZ0pFRsCJvHb0zjKly3Eq1GWwQLJROWhR/0qSrloJxLb/pnoh82FcMq8m@nongnu.org
X-Gm-Message-State: AOJu0Yye7Qu9EZJNrp7MuosLgOaFmR67lDwpjQ2eXG3uKGfxI4PqW6a1
 k1biFHBkF09Pu665N+wlgq5VtgLtfPxsNY3KKQaVfpd6aRYQan8vU720lzGwstwGeCbgqOTBXL7
 touRvd9/PAj8FVMq9EBOv1eqA4JDeIQ1qnCjAU8qOchlhspVGkgV7
X-Gm-Gg: ASbGnctS2drkV2XdlguHn0uEsH51/yCmTnWtLbMpLQq2N7MHfI/OKkBOKUMwDIECV6J
 YDQ8AOzg6P/wmsP3hRbqZJFn4F8JaEedkKX//KdgC0fuL2clJsA2ta8KLyE7ks5q4+FZNRIgL2f
 0TbOJBKRxedQwMJnnKm4goig1x9ALIi2sGbYxOEKQOV6/0YkMvsk9YRaW31RaLQlCuNBnmf+8S+
 68eS0wuFLA9S0ikCI6et6ELrWLQY7QoIQYPSpSWZxeLf0rAZR2Nq0q3ApHGMfiPtU0Ej4QD+mdV
 NofGtw==
X-Received: by 2002:a05:6a00:3a1d:b0:725:e015:908d with SMTP id
 d2e1a72fcca58-72fd0bce492mr33593465b3a.1.1738645367616; 
 Mon, 03 Feb 2025 21:02:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8xUd6eo0FwwzZGVQjwRYJZbSZ4GCqFyDUfwtJZ+ou6UCYwIDRIi7CR/KE8ldzOgy2UfIprA==
X-Received: by 2002:a05:6a00:3a1d:b0:725:e015:908d with SMTP id
 d2e1a72fcca58-72fd0bce492mr33593423b3a.1.1738645367126; 
 Mon, 03 Feb 2025 21:02:47 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.64])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe631bf13sm9433909b3a.32.2025.02.03.21.02.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 21:02:46 -0800 (PST)
Message-ID: <abb2bf76-2548-4c2b-a971-502ca623aee2@redhat.com>
Date: Tue, 4 Feb 2025 15:02:41 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/26] target/arm/kvm-rme: Initialize vCPU
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-8-jean-philippe@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20241125195626.856992-8-jean-philippe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/26/24 5:56 AM, Jean-Philippe Brucker wrote:
> The target code calls kvm_arm_vcpu_init() to mark the vCPU as part of a
> Realm. For a Realm vCPU, only x0-x7 can be set at runtime. Before boot,
> the PC can also be set, and is ignored at runtime. KVM also accepts a
> few system register changes during initial configuration, as returned by
> KVM_GET_REG_LIST.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>   target/arm/cpu.h     |  3 +++
>   target/arm/kvm_arm.h | 15 +++++++++++
>   target/arm/kvm-rme.c | 10 ++++++++
>   target/arm/kvm.c     | 61 ++++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 89 insertions(+)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index d86e641280..f617591921 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -961,6 +961,9 @@ struct ArchCPU {
>       OnOffAuto kvm_steal_time;
>   #endif /* CONFIG_KVM */
>   
> +    /* Realm Management Extension */
> +    bool kvm_rme;
> +
>       /* Uniprocessor system with MP extensions */
>       bool mp_is_up;
>   
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 9d6a89f9b1..8b52a881b0 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -245,6 +245,16 @@ int kvm_arm_rme_init(MachineState *ms);
>    */
>   int kvm_arm_rme_vm_type(MachineState *ms);
>   
> +/**
> + * kvm_arm_rme_vcpu_init
> + * @cs: the CPU
> + *
> + * If the user requested a Realm, setup the given vCPU accordingly. Realm vCPUs
> + * behave a little differently, for example most of their register state is
> + * hidden from the host.
> + */
> +int kvm_arm_rme_vcpu_init(CPUState *cs);
> +
>   #else
>   
>   /*
> @@ -339,6 +349,11 @@ static inline int kvm_arm_rme_vm_type(MachineState *ms)
>       g_assert_not_reached();
>   }
>   
> +static inline int kvm_arm_rme_vcpu_init(CPUState *cs)
> +{
> +    g_assert_not_reached();
> +}
> +
>   #endif
>   
>   #endif
> diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> index 60d967a842..e3cc37538a 100644
> --- a/target/arm/kvm-rme.c
> +++ b/target/arm/kvm-rme.c
> @@ -137,6 +137,16 @@ int kvm_arm_rme_init(MachineState *ms)
>       return 0;
>   }
>   
> +int kvm_arm_rme_vcpu_init(CPUState *cs)
> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +
> +    if (rme_guest) {
> +        cpu->kvm_rme = true;
> +    }
> +    return 0;
> +}
> +
>   int kvm_arm_rme_vm_type(MachineState *ms)
>   {
>       if (rme_guest) {
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 0c80992f7c..a0de2efc41 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -1926,6 +1926,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
>           return ret;
>       }
>   
> +    ret = kvm_arm_rme_vcpu_init(cs);
> +    if (ret) {
> +        return ret;
> +    }
> +
>       if (cpu_isar_feature(aa64_sve, cpu)) {
>           ret = kvm_arm_sve_set_vls(cpu);
>           if (ret) {
> @@ -2062,6 +2067,35 @@ static int kvm_arch_put_sve(CPUState *cs)
>       return 0;
>   }
>   
> +static int kvm_arm_rme_put_core_regs(CPUState *cs, Error **errp)
> +{
> +    int i, ret;
> +    struct kvm_one_reg reg;
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    CPUARMState *env = &cpu->env;
> +
> +    /*
> +     * The RME ABI only allows us to set 8 GPRs and the PC
> +     */

Needn't to span for multiple lines.

> +    for (i = 0; i < 8; i++) {
> +        reg.id = AARCH64_CORE_REG(regs.regs[i]);
> +        reg.addr = (uintptr_t) &env->xregs[i];
> +        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +
> +    reg.id = AARCH64_CORE_REG(regs.pc);
> +    reg.addr = (uintptr_t) &env->pc;
> +    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +

Nice place to use kvm_set_one_reg(). With it, @reg can be dropped.

>   static int kvm_arm_put_core_regs(CPUState *cs, int level, Error **errp)
>   {
>       uint64_t val;
> @@ -2072,6 +2106,10 @@ static int kvm_arm_put_core_regs(CPUState *cs, int level, Error **errp)
>       ARMCPU *cpu = ARM_CPU(cs);
>       CPUARMState *env = &cpu->env;
>   
> +    if (cpu->kvm_rme) {
> +        return kvm_arm_rme_put_core_regs(cs, errp);
> +    }
> +
>       /* If we are in AArch32 mode then we need to copy the AArch32 regs to the
>        * AArch64 registers before pushing them out to 64-bit KVM.
>        */
> @@ -2259,6 +2297,25 @@ static int kvm_arch_get_sve(CPUState *cs)
>       return 0;
>   }
>   
> +static int kvm_arm_rme_get_core_regs(CPUState *cs, Error **errp)
> +{
> +    int i, ret;
> +    struct kvm_one_reg reg;
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    CPUARMState *env = &cpu->env;
> +
> +    for (i = 0; i < 8; i++) {
> +        reg.id = AARCH64_CORE_REG(regs.regs[i]);
> +        reg.addr = (uintptr_t) &env->xregs[i];
> +        ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +
> +    return 0;
> +}
> +

Similiarly, kvm_get_one_reg() can be used.

>   static int kvm_arm_get_core_regs(CPUState *cs, Error **errp)
>   {
>       uint64_t val;
> @@ -2269,6 +2326,10 @@ static int kvm_arm_get_core_regs(CPUState *cs, Error **errp)
>       ARMCPU *cpu = ARM_CPU(cs);
>       CPUARMState *env = &cpu->env;
>   
> +    if (cpu->kvm_rme) {
> +        return kvm_arm_rme_get_core_regs(cs, errp);
> +    }
> +
>       for (i = 0; i < 31; i++) {
>           ret = kvm_get_one_reg(cs, AARCH64_CORE_REG(regs.regs[i]),
>                                 &env->xregs[i]);

Thanks,
Gavin



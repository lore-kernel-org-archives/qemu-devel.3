Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C10ECCF9E6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 15:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stUEo-0002uk-9k; Wed, 25 Sep 2024 11:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1stUEh-0002ln-N8
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:47:28 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1stUEf-0005Wa-8z
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 11:47:27 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42cacabd2e0so60271585e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 08:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727279243; x=1727884043; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bdto+4CUkb8ydbJkf0ODC+XwBNhhfN6qWFH3Iq53Mvg=;
 b=esSzJrql24yb26JrekasKuLtgRHlvwfhgLWybIyoEqOn09KMphpvOnbflYnoSez5Dy
 cPZ0aLBT8PJRs+vQObpdrnMjpe83ri62gd9zx1mwTbs+4DFbKFqznRpSMQYuKWxYIQN1
 lVax7z1xAH0UCkucUT41wCeOjblmo2H52W7Vk6VfIImjD0KMJMhzauLAy4LrktPC8GKG
 EiYNVvdsXAzkEG6jNckvsBH2k47OPbw6pcio9o07Gc4tSARb+l0pF/fY5gNuv047DAYK
 1AiRtEYE1/y88GpQPLi9j9JJV8i2RxF9dPH9oy4jYm5WZBJ/nIyIKNUnriPjUHE14IUR
 h+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727279243; x=1727884043;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bdto+4CUkb8ydbJkf0ODC+XwBNhhfN6qWFH3Iq53Mvg=;
 b=sgMeNvTNsXu4OOlYxvQmQifkC0bsYdgAH8n4i5vBlkd/LQTDtMVntiMZxUhL9XbyKx
 oxrtbjCBr9Yw+9RKighzTHvmY3DyD6njhgxlhaFK4NA0K/Rt4HNo3ulO/vNGP4WiGIDF
 koX2yuBEaAr80Wdbe1HQkJCaCgsoRfOqxi0sFcu5lqHAIn5eawCzA70+yqnGhAz4mxYq
 Xl+dTRajMUtKAlq5xWaJHtwZLJH1MRqaN5xSZ6wBcn7jNJP39W88eV/UxZIT1t38JA5D
 faD0EvpBPPs/e9MxNd4RTqWEFI2LVrbExTOwh4Ct2uBzkQieHfDCXtw/AYAqKNI2bky3
 hJzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/2s9itukMo81mLe8Lq/yjc5EyTDqnuiirqiUxO5+4nZKoMLS8eGltWB3SiylVW8jXcPpIy/eO2R7+@nongnu.org
X-Gm-Message-State: AOJu0Ywb2HdAQRb7w/FErQpJjOzwmQuRjIDEpdMNQyDvYhuji2w6WKxU
 ep0vM02wm2BZwBQpVlxthw4bnT7GOOST0Oh+aK2+dcggUUFw82gdtvNqYZGR+I0=
X-Google-Smtp-Source: AGHT+IHyTmqCYkSGgVDs3YzxTTD5sv7T4nQRF6uuOVGJbjRiE4D3HsgHHG+m6qqhh19zr6RN6dEK1Q==
X-Received: by 2002:a05:600c:1c81:b0:42c:b3e5:f68c with SMTP id
 5b1f17b1804b1-42e9610235fmr21124915e9.4.1727279242529; 
 Wed, 25 Sep 2024 08:47:22 -0700 (PDT)
Received: from [192.168.119.120] ([195.85.229.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a56fddsm22485035e9.46.2024.09.25.08.47.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2024 08:47:21 -0700 (PDT)
Message-ID: <4b1a7f9b-4a69-4c0a-93be-4ecd27b08196@linaro.org>
Date: Wed, 25 Sep 2024 17:47:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] arm/kvm: add support for MTE
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, cohuck@redhat.com, darren@os.amperecomputing.com
References: <20240920073725.410373-1-gankulkarni@os.amperecomputing.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20240920073725.410373-1-gankulkarni@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=gustavo.romero@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Ganapatrao,

Sorry for the delay on replying it. I was attending KVM Forum and commuting.

On 9/20/24 09:37, Ganapatrao Kulkarni wrote:
> Extend the 'mte' property for the virt machine to cover KVM as
> well. For KVM, we don't allocate tag memory, but instead enable
> the capability.
>
> If MTE has been enabled, we need to disable migration, as we do not
> yet have a way to migrate the tags as well. Therefore, MTE will stay
> off with KVM unless requested explicitly.
>
> This patch is rework of commit b320e21c48ce64853904bea6631c0158cc2ef227
> which broke TCG since it made the TCG -cpu max
> report the presence of MTE to the guest even if the board hadn't
> enabled MTE by wiring up the tag RAM. This meant that if the guest
> then tried to use MTE QEMU would segfault accessing the
> non-existent tag RAM.
>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
> ---
>
> Changes since V2:
> 	Updated with review comments.
>
> Changes since V1:
> 	Added code to enable MTE before reading register
> id_aa64pfr1 (unmasked MTE bits).
>
> This patch is boot tested on ARM64 with KVM and on X86 with TCG for mte=on
> and default case(i.e, no mte).
>
>   hw/arm/virt.c        | 72 ++++++++++++++++++++++++++------------------
>   target/arm/cpu.c     | 11 +++++--
>   target/arm/cpu.h     |  2 ++
>   target/arm/kvm.c     | 57 +++++++++++++++++++++++++++++++++++
>   target/arm/kvm_arm.h | 19 ++++++++++++
>   5 files changed, 129 insertions(+), 32 deletions(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 7934b23651..a33af7d996 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2211,7 +2211,7 @@ static void machvirt_init(MachineState *machine)
>           exit(1);
>       }
>   
> -    if (vms->mte && (kvm_enabled() || hvf_enabled())) {
> +    if (vms->mte && hvf_enabled()) {
>           error_report("mach-virt: %s does not support providing "
>                        "MTE to the guest CPU",
>                        current_accel_name());
> @@ -2281,39 +2281,51 @@ static void machvirt_init(MachineState *machine)
>           }
>   
>           if (vms->mte) {
> -            /* Create the memory region only once, but link to all cpus. */
> -            if (!tag_sysmem) {
> -                /*
> -                 * The property exists only if MemTag is supported.
> -                 * If it is, we must allocate the ram to back that up.
> -                 */
> -                if (!object_property_find(cpuobj, "tag-memory")) {
> -                    error_report("MTE requested, but not supported "
> -                                 "by the guest CPU");
> -                    exit(1);
> +            if (tcg_enabled()) {
> +                /* Create the memory region only once, but link to all cpus. */
> +                if (!tag_sysmem) {
> +                    /*
> +                     * The property exists only if MemTag is supported.
> +                     * If it is, we must allocate the ram to back that up.
> +                     */
> +                    if (!object_property_find(cpuobj, "tag-memory")) {
> +                        error_report("MTE requested, but not supported "
> +                                     "by the guest CPU");
> +                        exit(1);
> +                    }
> +
> +                    tag_sysmem = g_new(MemoryRegion, 1);
> +                    memory_region_init(tag_sysmem, OBJECT(machine),
> +                                       "tag-memory", UINT64_MAX / 32);
> +
> +                    if (vms->secure) {
> +                        secure_tag_sysmem = g_new(MemoryRegion, 1);
> +                        memory_region_init(secure_tag_sysmem, OBJECT(machine),
> +                                           "secure-tag-memory",
> +                                           UINT64_MAX / 32);
> +
> +                        /* As with ram, secure-tag takes precedence over tag. */
> +                        memory_region_add_subregion_overlap(secure_tag_sysmem,
> +                                                            0, tag_sysmem, -1);
> +                    }
>                   }
>   
> -                tag_sysmem = g_new(MemoryRegion, 1);
> -                memory_region_init(tag_sysmem, OBJECT(machine),
> -                                   "tag-memory", UINT64_MAX / 32);
> -
> +                object_property_set_link(cpuobj, "tag-memory",
> +                                         OBJECT(tag_sysmem), &error_abort);
>                   if (vms->secure) {
> -                    secure_tag_sysmem = g_new(MemoryRegion, 1);
> -                    memory_region_init(secure_tag_sysmem, OBJECT(machine),
> -                                       "secure-tag-memory", UINT64_MAX / 32);
> -
> -                    /* As with ram, secure-tag takes precedence over tag.  */
> -                    memory_region_add_subregion_overlap(secure_tag_sysmem, 0,
> -                                                        tag_sysmem, -1);
> +                    object_property_set_link(cpuobj, "secure-tag-memory",
> +                                             OBJECT(secure_tag_sysmem),
> +                                             &error_abort);
>                   }
> -            }
> -
> -            object_property_set_link(cpuobj, "tag-memory", OBJECT(tag_sysmem),
> -                                     &error_abort);
> -            if (vms->secure) {
> -                object_property_set_link(cpuobj, "secure-tag-memory",
> -                                         OBJECT(secure_tag_sysmem),
> -                                         &error_abort);
> +            } else if (kvm_enabled()) {
> +                if (!kvm_arm_mte_supported()) {
> +                    error_report("MTE requested, but not supported by KVM");
> +                    exit(1);
> +                }
> +                kvm_arm_enable_mte(cpuobj, &error_abort);
> +            } else {
> +                    error_report("MTE requested, but not supported ");
> +                    exit(1);
>               }
>           }
>   
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 19191c2391..8a2fc471ce 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2390,14 +2390,21 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>   
>   #ifndef CONFIG_USER_ONLY
>           /*
> -         * If we do not have tag-memory provided by the machine,
> +         * If we do not have tag-memory provided by the TCG,
>            * reduce MTE support to instructions enabled at EL0.
>            * This matches Cortex-A710 BROADCASTMTE input being LOW.
>            */
> -        if (cpu->tag_memory == NULL) {
> +        if (tcg_enabled() && cpu->tag_memory == NULL) {
>               cpu->isar.id_aa64pfr1 =
>                   FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 1);
>           }
> +
> +        /*
> +         * Clear MTE bits, if not enabled in KVM mode.
> +         */
> +        if (kvm_enabled() && !cpu->kvm_mte) {
> +                FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 0);
> +        }

I 've discussed a bit with Richard about the need of setting the MTE 
field here

to 0. This is already a reduction since it's inside the condition block:

if (cpu_isar_feature(aa64_mte, cpu)) { ... }, which is only taken if we 
already

have MTE field >= 1. At this point the MTE bits in cpu->isar.id_aa64pfr1 
should

already be set correctly accordingly to the host bits since 
kvm_arm_get_host_cpu_features()

was called.


The check for TCG (cpu->tag_memory == NULL) exists because even if MTE 
instructions

are supported by the CPU it's possible that the machine's memory does 
not support tags,

but we don't check for that in KVM afaics.


For KVM, isn't the cpu->isar.id_aa64pfr1 MTE bits already correct here 
so we don't need to touch them?

cpu->kvm_mte is false here only if kvm_check_extension(kvm_state, 
KVM_CAP_ARM_MTE) is true but

kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_MTE, 0) is false -- can that 
happen ever happen? _or_ when

we can't block migration? So basically we are telling to the guest that 
MTE is not supported if we have

MTE supported in the host _but_ we can't block migration?



Cheers,

Gustavo

>   #endif
>       }
>   
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index f065756c5c..8fc8b6398f 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -922,6 +922,8 @@ struct ArchCPU {
>   
>       /* CPU has memory protection unit */
>       bool has_mpu;
> +    /* CPU has MTE enabled in KVM mode */
> +    bool kvm_mte;
>       /* PMSAv7 MPU number of supported regions */
>       uint32_t pmsav7_dregion;
>       /* PMSAv8 MPU number of supported hyp regions */
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 849e2e21b3..af7a98517d 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -39,6 +39,7 @@
>   #include "hw/acpi/acpi.h"
>   #include "hw/acpi/ghes.h"
>   #include "target/arm/gtimer.h"
> +#include "migration/blocker.h"
>   
>   const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
>       KVM_CAP_LAST_INFO
> @@ -119,6 +120,20 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
>       if (vmfd < 0) {
>           goto err;
>       }
> +
> +    /*
> +     * MTE capability must be enabled by the VMM before creating
> +     * any VCPUs. The MTE bits of the ID_AA64PFR1 register are masked
> +     * if MTE is not enabled, allowing them to be probed correctly.
> +     */
> +    if (kvm_arm_mte_supported()) {
> +        KVMState kvm_state;
> +
> +        kvm_state.fd = kvmfd;
> +        kvm_state.vmfd = vmfd;
> +        kvm_vm_enable_cap(&kvm_state, KVM_CAP_ARM_MTE, 0);
> +    }
> +
>       cpufd = ioctl(vmfd, KVM_CREATE_VCPU, 0);
>       if (cpufd < 0) {
>           goto err;
> @@ -1793,6 +1808,11 @@ bool kvm_arm_sve_supported(void)
>       return kvm_check_extension(kvm_state, KVM_CAP_ARM_SVE);
>   }
>   
> +bool kvm_arm_mte_supported(void)
> +{
> +    return kvm_check_extension(kvm_state, KVM_CAP_ARM_MTE);
> +}
> +
>   QEMU_BUILD_BUG_ON(KVM_ARM64_SVE_VQ_MIN != 1);
>   
>   uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
> @@ -2417,3 +2437,40 @@ int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
>       }
>       return 0;
>   }
> +
> +void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
> +{
> +    static bool tried_to_enable;
> +    static bool succeeded_to_enable;
> +    Error *mte_migration_blocker = NULL;
> +    ARMCPU *cpu = ARM_CPU(cpuobj);
> +    int ret;
> +
> +    if (!tried_to_enable) {
> +        /*
> +         * MTE on KVM is enabled on a per-VM basis (and retrying doesn't make
> +         * sense), and we only want a single migration blocker as well.
> +         */
> +        tried_to_enable = true;
> +
> +        ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_MTE, 0);
> +        if (ret) {
> +            error_setg_errno(errp, -ret, "Failed to enable KVM_CAP_ARM_MTE");
> +            return;
> +        }
> +
> +        /* TODO: Add migration support with MTE enabled */
> +        error_setg(&mte_migration_blocker,
> +                   "Live migration disabled due to MTE enabled");
> +        if (migrate_add_blocker(&mte_migration_blocker, errp)) {
> +            error_free(mte_migration_blocker);
> +            return;
> +        }
> +
> +        succeeded_to_enable = true;
> +    }
> +
> +    if (succeeded_to_enable) {
> +        cpu->kvm_mte = true;
> +    }
> +}
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index cfaa0d9bc7..4d293618a7 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -188,6 +188,13 @@ bool kvm_arm_pmu_supported(void);
>    */
>   bool kvm_arm_sve_supported(void);
>   
> +/**
> + * kvm_arm_mte_supported:
> + *
> + * Returns: true if KVM can enable MTE, and false otherwise.
> + */
> +bool kvm_arm_mte_supported(void);
> +
>   /**
>    * kvm_arm_get_max_vm_ipa_size:
>    * @ms: Machine state handle
> @@ -214,6 +221,8 @@ void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa);
>   
>   int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
>   
> +void kvm_arm_enable_mte(Object *cpuobj, Error **errp);
> +
>   #else
>   
>   /*
> @@ -235,6 +244,11 @@ static inline bool kvm_arm_sve_supported(void)
>       return false;
>   }
>   
> +static inline bool kvm_arm_mte_supported(void)
> +{
> +    return false;
> +}
> +
>   /*
>    * These functions should never actually be called without KVM support.
>    */
> @@ -283,6 +297,11 @@ static inline uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
>       g_assert_not_reached();
>   }
>   
> +static inline void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
> +{
> +    g_assert_not_reached();
> +}
> +
>   #endif
>   
>   #endif


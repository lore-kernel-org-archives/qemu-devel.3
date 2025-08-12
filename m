Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42AAC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 13:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulohk-0006kI-Pe; Tue, 12 Aug 2025 09:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulohe-0006gS-4J
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 09:06:10 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulohT-0005Js-Kn
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 09:06:09 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-459e1338565so51160245e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 06:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755003952; x=1755608752; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iA59R1YcqNH4uQQGiviRNHutERyag7XjulXFJ6ocDYw=;
 b=PaPqRhEiigCHt1BX/4agO4n/sdhQgK8lwpYrqOjwdSTUWfeFWVu2aBAEKernRFQ21R
 IAoQhbOOZqkw8R8TePmzbigP2oShsZB6o1/VphCNiELG08gDgqWvydhxHimOjPSVtlMb
 4sPVxjGg4kzrd4v5aKNqQcEaW/AmsEq0JcaadtXBsjrhJWFdcf7W95TDcW4VcMVNfsMR
 GrL5xYjPM+56F2usMpflEw5ea/8rVamkanpEvvakI5aRIH2FYrAMAvi4A+S6mWkS3QXg
 Vqvf5NN1QiMnoJ6C3VCiEdJaSYciSis3QfEFFhId55XuemRD7PbU/SX6amhCHGTPi7C+
 YTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755003952; x=1755608752;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iA59R1YcqNH4uQQGiviRNHutERyag7XjulXFJ6ocDYw=;
 b=jqOYuHqQDfRtc3MRanzSG5FbuJV0IJeNevCPYsTtsvsaHkMXD2K32atG8196rOxfPN
 A4pzRu8JqMvw2MVgESDqkmWpkGV+/6FnnI3oXzNNDScZTMFk0cj2g+NwMHmUDkp0AUxv
 KKoFzN2MBcAWifZSH6/AS52QW76Teg3U++WxeCgSBeorBZaVSznd7b8AYEVD0FMwYloy
 CICFV85uZRlDemNJFhmuIHVYmR63sOtP/ZMUJUE/jUdw7sNvBzh/DHeZteRnESDDrQ6+
 MFDYvA63h5/h3UWenxXPGck243g0tkcVh6tf/H/CJyFrVVJ2CJN+CDJcN9BY8lfqHTW0
 GnhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqMJifO0EBQNpbkZK11oA/luVtTM/ojXF5GqvZ6DDRrZ1B2WrAah7imN2feV906yHS27ILeNKF+X4N@nongnu.org
X-Gm-Message-State: AOJu0YxDkgFaSC4JBRnRI2jRVAnL/HGMd68CqjM5U+XEhpeyAcahfntS
 rZFuKbaMBgyTpqWt39dtPsJWYC3Vb/CoczaALFbaLv7eCCTiGnKZq7lf7qZJiE25u8k=
X-Gm-Gg: ASbGncufSCqRkfJw0Fo4UAXjkK7SJnaY8XoUxXV8y7X9EI13YqTjIR3ixwCph7HRbE8
 UpyMXC+8spZBg5sBY5+hHi40zHYsuTe3cn135P/BYiBQxknWZU/qPmOk+YJkbJwJwMqWdX6y/kg
 OH0hH5wxdGK3d54lexoLU3x6a1hcC/O9aMq6YsePknMngmq2JTBrt3El9/1af7zK1XOFoaQOWzk
 lEQBof/SbkuxTqHvrXu04/NGeM10/q7cRhcE4vNq6MxdnonupAe/lpuGjO82POhrFW15D8hEkl/
 V2uXLlqn19hh51vqZvOjtwTKo6v4/MYZfMLiiihXOC8yoxmmyQ95+SedtR56REoBqreCwGviboW
 AW3ImfPaPdENGQBP1z4x3z5duUUUkpvp6ygqUTfi+xeURvDkp9VxulFRVI93f1VJRTQ==
X-Google-Smtp-Source: AGHT+IHmofbv5JUmeAre+GnGZAWglXtMlE4/RgdQg1F2nIGrRCw0DwOHwN17kSbr+Ytj+wNZVhb8Ag==
X-Received: by 2002:a05:600c:3b97:b0:458:bfb1:1fb6 with SMTP id
 5b1f17b1804b1-45a11e79ac3mr22644005e9.2.1755003952427; 
 Tue, 12 Aug 2025 06:05:52 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459ebede65asm248852045e9.8.2025.08.12.06.05.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 06:05:51 -0700 (PDT)
Message-ID: <77535ca0-43b1-445c-a89d-2167300fe791@linaro.org>
Date: Tue, 12 Aug 2025 15:05:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/13] accel, hw/arm, include/system/hvf:
 infrastructure changes for HVF vGIC
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Igor Mammedov <imammedo@redhat.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>
References: <20250808070137.48716-1-mohamed@unpredictable.fr>
 <20250808070137.48716-4-mohamed@unpredictable.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250808070137.48716-4-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 8/8/25 09:01, Mohamed Mediouni wrote:
> Misc changes needed for HVF vGIC enablement.
> 
> Note: x86_64 macOS exposes interrupt controller virtualisation since macOS 12.
> Keeping an #ifdef here in case we end up supporting that...
> 
> However, given that x86_64 macOS is on its way out, it'll probably (?) not be supported in Qemu.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   accel/hvf/hvf-all.c        | 50 ++++++++++++++++++++++++++++++++++++++
>   accel/stubs/hvf-stub.c     |  1 +
>   hw/arm/virt.c              | 16 ++++++++----
>   hw/intc/arm_gicv3_common.c |  3 +++
>   include/system/hvf.h       |  3 +++
>   system/vl.c                |  2 ++
>   6 files changed, 70 insertions(+), 5 deletions(-)


> @@ -290,6 +293,43 @@ static int hvf_gdbstub_sstep_flags(AccelState *as)
>       return SSTEP_ENABLE | SSTEP_NOIRQ;
>   }
>   
> +static void hvf_set_kernel_irqchip(Object *obj, Visitor *v,
> +                                   const char *name, void *opaque,
> +                                   Error **errp)
> +{
> +    OnOffSplit mode;
> +    if (!visit_type_OnOffSplit(v, name, &mode, errp)) {
> +        return;
> +    }
> +
> +    switch (mode) {
> +    case ON_OFF_SPLIT_ON:
> +#ifdef __x86_64__
> +        /* macOS 12 onwards exposes an HVF virtual APIC. */
> +        error_setg(errp, "HVF: kernel irqchip is not currently implemented for x86.");
> +        break;
> +#else
> +        hvf_kernel_irqchip = true;
> +        break;
> +#endif
> +
> +    case ON_OFF_SPLIT_OFF:
> +        hvf_kernel_irqchip = false;
> +        break;
> +
> +    case ON_OFF_SPLIT_SPLIT:
> +        error_setg(errp, "HVF: split irqchip is not supported on HVF.");
> +        break;
> +
> +    default:
> +        /*
> +         * The value was checked in visit_type_OnOffSplit() above. If
> +         * we get here, then something is wrong in QEMU.
> +         */
> +        abort();
> +    }
> +}
> +
>   static void hvf_accel_class_init(ObjectClass *oc, const void *data)
>   {
>       AccelClass *ac = ACCEL_CLASS(oc);
> @@ -297,6 +337,16 @@ static void hvf_accel_class_init(ObjectClass *oc, const void *data)
>       ac->init_machine = hvf_accel_init;
>       ac->allowed = &hvf_allowed;
>       ac->gdbstub_supported_sstep_flags = hvf_gdbstub_sstep_flags;
> +#ifdef __x86_64__
> +    hvf_kernel_irqchip = false;
> +#else
> +    hvf_kernel_irqchip = true;

I'm getting on Silicon m1:
qemu-system-aarch64: unknown type 'hvf-arm-gicv3'

> +#endif
> +    object_class_property_add(oc, "kernel-irqchip", "on|off|split",
> +        NULL, hvf_set_kernel_irqchip,
> +        NULL, NULL);
> +    object_class_property_set_description(oc, "kernel-irqchip",
> +        "Configure HVF irqchip");
>   }
>   
>   static const TypeInfo hvf_accel_type = {
> diff --git a/accel/stubs/hvf-stub.c b/accel/stubs/hvf-stub.c
> index 42eadc5ca9..6bd08759ba 100644
> --- a/accel/stubs/hvf-stub.c
> +++ b/accel/stubs/hvf-stub.c
> @@ -10,3 +10,4 @@
>   #include "system/hvf.h"
>   
>   bool hvf_allowed;
> +bool hvf_kernel_irqchip;
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 5951b331f3..59e6c2b9df 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -830,7 +830,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
>        * interrupts; there are always 32 of the former (mandated by GIC spec).
>        */
>       qdev_prop_set_uint32(vms->gic, "num-irq", NUM_IRQS + 32);
> -    if (!kvm_irqchip_in_kernel()) {
> +    if (!kvm_irqchip_in_kernel() && !hvf_irqchip_in_kernel()) {
>           qdev_prop_set_bit(vms->gic, "has-security-extensions", vms->secure);
>       }
>   
> @@ -853,8 +853,9 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
>           qdev_prop_set_array(vms->gic, "redist-region-count",
>                               redist_region_count);
>   
> -        if (!kvm_irqchip_in_kernel()) {
> -            if (vms->tcg_its) {
> +        if (!kvm_irqchip_in_kernel() &&
> +         !(hvf_enabled() && hvf_irqchip_in_kernel())) {
> +            if (vms->its && vms->tcg_its) {
>                   object_property_set_link(OBJECT(vms->gic), "sysmem",
>                                            OBJECT(mem), &error_fatal);
>                   qdev_prop_set_bit(vms->gic, "has-lpi", true);
> @@ -864,7 +865,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
>                                    ARCH_GIC_MAINT_IRQ);
>           }
>       } else {
> -        if (!kvm_irqchip_in_kernel()) {
> +        if (!kvm_irqchip_in_kernel() && !hvf_irqchip_in_kernel()) {
>               qdev_prop_set_bit(vms->gic, "has-virtualization-extensions",
>                                 vms->virt);
>           }
> @@ -2060,7 +2061,12 @@ static void finalize_gic_version(VirtMachineState *vms)
>           /* KVM w/o kernel irqchip can only deal with GICv2 */
>           gics_supported |= VIRT_GIC_VERSION_2_MASK;
>           accel_name = "KVM with kernel-irqchip=off";
> -    } else if (tcg_enabled() || hvf_enabled() || qtest_enabled())  {
> +    } else if (hvf_enabled()) {
> +        if (!hvf_irqchip_in_kernel()) {
> +            gics_supported |= VIRT_GIC_VERSION_2_MASK;
> +        }
> +        gics_supported |= VIRT_GIC_VERSION_3_MASK;
> +    } else if (tcg_enabled() || qtest_enabled()) {
>           gics_supported |= VIRT_GIC_VERSION_2_MASK;
>           if (module_object_class_by_name("arm-gicv3")) {
>               gics_supported |= VIRT_GIC_VERSION_3_MASK;
> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
> index e438d8c042..b8eee27260 100644
> --- a/hw/intc/arm_gicv3_common.c
> +++ b/hw/intc/arm_gicv3_common.c
> @@ -32,6 +32,7 @@
>   #include "gicv3_internal.h"
>   #include "hw/arm/linux-boot-if.h"
>   #include "system/kvm.h"
> +#include "system/hvf.h"
>   
>   
>   static void gicv3_gicd_no_migration_shift_bug_post_load(GICv3State *cs)
> @@ -662,6 +663,8 @@ const char *gicv3_class_name(void)
>   {
>       if (kvm_irqchip_in_kernel()) {
>           return "kvm-arm-gicv3";
> +    } else if (hvf_enabled() && hvf_irqchip_in_kernel()) {
> +        return "hvf-arm-gicv3";
>       } else {
>           if (kvm_enabled()) {
>               error_report("Userspace GICv3 is not supported with KVM");
> diff --git a/include/system/hvf.h b/include/system/hvf.h
> index d3dcf088b3..dc8da85979 100644
> --- a/include/system/hvf.h
> +++ b/include/system/hvf.h
> @@ -26,8 +26,11 @@
>   #ifdef CONFIG_HVF_IS_POSSIBLE
>   extern bool hvf_allowed;
>   #define hvf_enabled() (hvf_allowed)
> +extern bool hvf_kernel_irqchip;
> +#define hvf_irqchip_in_kernel()  (hvf_kernel_irqchip)
>   #else /* !CONFIG_HVF_IS_POSSIBLE */
>   #define hvf_enabled() 0
> +#define hvf_irqchip_in_kernel() 0
>   #endif /* !CONFIG_HVF_IS_POSSIBLE */
>   
>   #define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
> diff --git a/system/vl.c b/system/vl.c
> index 3b7057e6c6..1c072d15a4 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -1773,6 +1773,8 @@ static void qemu_apply_legacy_machine_options(QDict *qdict)
>                                      false);
>           object_register_sugar_prop(ACCEL_CLASS_NAME("whpx"), "kernel-irqchip", value,
>                                      false);
> +        object_register_sugar_prop(ACCEL_CLASS_NAME("hvf"), "kernel-irqchip", value,
> +                                   false);
>           qdict_del(qdict, "kernel-irqchip");
>       }
>   



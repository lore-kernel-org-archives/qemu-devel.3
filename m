Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97600C0218F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 05:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfBVs-0001LD-Fh; Tue, 04 Feb 2025 00:30:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tfBVo-0001Kp-PT
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 00:30:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1tfBVm-0007zQ-UH
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 00:30:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738647011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fsh1mX2fTPgCm5zaVVBg/eCP2E3sojwW1XaxhbF3L2g=;
 b=a0lV6LwJpLFDCsW1cf3zvQOWT6L57llyd5v4QRfvxBYZC+a284WAhut8G+5nB0gOOLcfyA
 S4sq+AvtH8H5QW0P2YpykqHs8dHf1xJG7A9DrFn5Ip2MiJjxN2xxWUU8qTTTvbpY/BgXFz
 rsutnT6po5e6ybiR6gOoOb5swhkLeq0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-odm9t31kPxKG4Q9bMtvHog-1; Tue, 04 Feb 2025 00:30:07 -0500
X-MC-Unique: odm9t31kPxKG4Q9bMtvHog-1
X-Mimecast-MFC-AGG-ID: odm9t31kPxKG4Q9bMtvHog
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ef9e38b0cfso9603088a91.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 21:30:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738647007; x=1739251807;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fsh1mX2fTPgCm5zaVVBg/eCP2E3sojwW1XaxhbF3L2g=;
 b=axTcaEIMEkjx2X2R5IRccoxMhTrz/HNsafk3ZkX1mbfNHDJ8fySD8kAwYLj5xp9vaF
 ItloQC/VOLPWSYlXNrd8wuziZpJlobovFcPc0HIToEovo2UCTTrBmpQ/bibuzZ3mfNNG
 VEMBzM9O09ND2vaR3GGWfgCgyFIms9/qCtg2HmFj2V5Rsa2B8HEjB3RLxEtP9mJaAET8
 R5lVGFkbWLZFlneV4RqEJ1b4XXAsudH5Imrb16sXfryaJkGDgVLdFLWLTTSgB5hnsX6K
 425/XZY9XEXYJraLkKVKybxt7X1tw9FyVoEXdxGAMPmxBWdZHYO5bTNxLC1C11WZ7bhw
 yzcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZihBnzHnU14qJaki1EPI0Q7wCiCNWqXtdU6v9L5MAZXJkE8I6WtFBg8C392JUbOD8eEQR6s6cxrWW@nongnu.org
X-Gm-Message-State: AOJu0Yw+lJN1+JNE9UqtyF2tkmMDK0tqiV9VixUy+zYMxeABWy/ZXJpm
 2YEjO1su2SwjlKIFeRQhtNU0FKdJyO62+Xcoa8pxn5pr9S1ecHTudErjV+uRENMEcyL5qqo0mHz
 MQ3uGgLk85ivBDiDjD/ztAjht5+5HHZJXAMMNPpD7/fFVeE9GzW4S
X-Gm-Gg: ASbGncuhbO5y3SYSRCtkIAUlvdL1t/8UBZixq5hokvl3v8e9EgpD2UAZ1qhBzjf3X2S
 fuG76qnry/WzFY19HLoDnxTAEi6Bglw2GD4LsnWpbcdKFJulOqhET1mMfv7RXCfy70uJqRlsBYy
 CyUFtZ9+G3lQORQJtOw+ZJi8TT9kmfCY5+5eOJhUFuMd/JMMdkcDX2FIojZFoBzSOnuQevwq5tc
 r6YTdT/xFXB/x+Z3shIZR6QIGLBhWTOOzm8qXBLA/XBPutlNciT3iWc5lWN97arTLzmB0Xfup43
 QrV9Yw==
X-Received: by 2002:aa7:9306:0:b0:725:d956:aa6f with SMTP id
 d2e1a72fcca58-72fd0bc2572mr35091220b3a.5.1738647006643; 
 Mon, 03 Feb 2025 21:30:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFX8TG2NZ8uSDcMCSgMub9IoZWHA/P90vj6Tk2tiMmjQmudlUGhjo1dKupSiVmSkpMbWLgAjA==
X-Received: by 2002:aa7:9306:0:b0:725:d956:aa6f with SMTP id
 d2e1a72fcca58-72fd0bc2572mr35091174b3a.5.1738647006219; 
 Mon, 03 Feb 2025 21:30:06 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.64])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe69ba44fsm9914108b3a.100.2025.02.03.21.30.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 21:30:05 -0800 (PST)
Message-ID: <91b825c4-462f-4663-8412-effa84c0863d@redhat.com>
Date: Tue, 4 Feb 2025 15:30:00 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/26] target/arm/kvm-rme: Initialize Realm memory
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-11-jean-philippe@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20241125195626.856992-11-jean-philippe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> Initialize the IPA state of RAM. Collect the images copied into guest
> RAM into a sorted list, and issue POPULATE_REALM KVM ioctls once we've
> created the Realm Descriptor. The images are part of the Realm Initial
> Measurement.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v2->v3: RIPAS is now initialized separately
> ---
>   target/arm/kvm_arm.h |  14 +++++
>   target/arm/kvm-rme.c | 128 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 142 insertions(+)
> 
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 8b52a881b0..67db09a424 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -255,6 +255,16 @@ int kvm_arm_rme_vm_type(MachineState *ms);
>    */
>   int kvm_arm_rme_vcpu_init(CPUState *cs);
>   
> +/*
> + * kvm_arm_rme_init_guest_ram
> + * @base: base address of RAM
> + * @size: size of RAM
> + *
> + * If the user requested a Realm, set the base and size of guest RAM, in order
> + * to initialize the Realm IPA space.
> + */
> +void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size);
> +
>   #else
>   
>   /*
> @@ -281,6 +291,10 @@ static inline bool kvm_arm_mte_supported(void)
>       return false;
>   }
>   
> +static inline void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size)
> +{
> +}
> +
>   /*
>    * These functions should never actually be called without KVM support.
>    */
> diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> index e3cc37538a..83a29421df 100644
> --- a/target/arm/kvm-rme.c
> +++ b/target/arm/kvm-rme.c
> @@ -9,6 +9,7 @@
>   #include "exec/confidential-guest-support.h"
>   #include "hw/boards.h"
>   #include "hw/core/cpu.h"
> +#include "hw/loader.h"
>   #include "kvm_arm.h"
>   #include "migration/blocker.h"
>   #include "qapi/error.h"
> @@ -20,16 +21,85 @@
>   #define TYPE_RME_GUEST "rme-guest"
>   OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
>   
> +#define RME_PAGE_SIZE qemu_real_host_page_size()
> +
>   struct RmeGuest {
>       ConfidentialGuestSupport parent_obj;
> +    Notifier rom_load_notifier;
> +    GSList *ram_regions;
> +
> +    hwaddr ram_base;
> +    size_t ram_size;
>   };
>   

s/size_t/hwaddr. To be consistent with RmeRamRegion, we may reuse
it like below.

struct RmeGuest {
     :
     GSlist *populate_ram_regions;
     RmeRamRegion init_ram_region;
};

>   OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
>                                             CONFIDENTIAL_GUEST_SUPPORT,
>                                             { TYPE_USER_CREATABLE }, { })
>   
> +typedef struct {
> +    hwaddr base;
> +    hwaddr size;
> +} RmeRamRegion;
> +
>   static RmeGuest *rme_guest;
>   
> +static int rme_init_ram(hwaddr base, size_t size, Error **errp)
> +{
> +    int ret;
> +    uint64_t start = QEMU_ALIGN_DOWN(base, RME_PAGE_SIZE);
> +    uint64_t end = QEMU_ALIGN_UP(base + size, RME_PAGE_SIZE);
> +    struct kvm_cap_arm_rme_init_ipa_args init_args = {
> +        .init_ipa_base = start,
> +        .init_ipa_size = end - start,
> +    };
> +
> +    ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_RME, 0,
> +                            KVM_CAP_ARM_RME_INIT_IPA_REALM,
> +                            (intptr_t)&init_args);
> +    if (ret) {
> +        error_setg_errno(errp, -ret,
> +                         "failed to init RAM [0x%"HWADDR_PRIx", 0x%"HWADDR_PRIx")",
                                                      ^^^^^^^^^^        ^^^^^^^^^^^
The type for 'start' and 'end' would be 'hwaddr'.

> +                         start, end);
> +    }
> +
> +    return ret;
> +}
> +
> +static int rme_populate_range(hwaddr base, size_t size, bool measure,
> +                              Error **errp)
> +{
> +    int ret;
> +    uint64_t start = QEMU_ALIGN_DOWN(base, RME_PAGE_SIZE);
> +    uint64_t end = QEMU_ALIGN_UP(base + size, RME_PAGE_SIZE);
> +    struct kvm_cap_arm_rme_populate_realm_args populate_args = {
> +        .populate_ipa_base = start,
> +        .populate_ipa_size = end - start,
> +        .flags = measure ? KVM_ARM_RME_POPULATE_FLAGS_MEASURE : 0,
> +    };
> +
> +    ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_RME, 0,
> +                            KVM_CAP_ARM_RME_POPULATE_REALM,
> +                            (intptr_t)&populate_args);
> +    if (ret) {
> +        error_setg_errno(errp, -ret,
> +                   "failed to populate realm [0x%"HWADDR_PRIx", 0x%"HWADDR_PRIx")",
> +                   start, end);
> +    }
> +    return ret;
> +}
> +
> +static void rme_populate_ram_region(gpointer data, gpointer err)
> +{
> +    Error **errp = err;
> +    const RmeRamRegion *region = data;
> +
> +    if (*errp) {
> +        return;
> +    }
> +
> +    rme_populate_range(region->base, region->size, /* measure */ true, errp);
> +}
> +
>   static int rme_init_cpus(Error **errp)
>   {
>       int ret;
> @@ -60,6 +130,16 @@ static int rme_create_realm(Error **errp)
>           return -1;
>       }
>   
> +    if (rme_init_ram(rme_guest->ram_base, rme_guest->ram_size, errp)) {
> +        return -1;
> +    }
> +
> +    g_slist_foreach(rme_guest->ram_regions, rme_populate_ram_region, errp);
> +    g_slist_free_full(g_steal_pointer(&rme_guest->ram_regions), g_free);
> +    if (*errp) {
> +        return -1;
> +    }
> +
>       if (rme_init_cpus(errp)) {
>           return -1;
>       }
> @@ -105,6 +185,43 @@ static void rme_guest_finalize(Object *obj)
>   {
>   }
>   
> +static gint rme_compare_ram_regions(gconstpointer a, gconstpointer b)
> +{
> +        const RmeRamRegion *ra = a;
> +        const RmeRamRegion *rb = b;
> +
> +        g_assert(ra->base != rb->base);
> +        return ra->base < rb->base ? -1 : 1;
> +}
> +
> +static void rme_rom_load_notify(Notifier *notifier, void *data)
> +{
> +    RmeRamRegion *region;
> +    RomLoaderNotify *rom = data;
> +
> +    if (rom->addr == -1) {
> +        /*
> +         * These blobs (ACPI tables) are not loaded into guest RAM at reset.
> +         * Instead the firmware will load them via fw_cfg and measure them
> +         * itself.
> +         */
> +        return;
> +    }
> +
> +    region = g_new0(RmeRamRegion, 1);
> +    region->base = rom->addr;
> +    region->size = rom->len;
> +
> +    /*
> +     * The Realm Initial Measurement (RIM) depends on the order in which we
> +     * initialize and populate the RAM regions. To help a verifier
> +     * independently calculate the RIM, sort regions by GPA.
> +     */
> +    rme_guest->ram_regions = g_slist_insert_sorted(rme_guest->ram_regions,
> +                                                   region,
> +                                                   rme_compare_ram_regions);
> +}
> +
>   int kvm_arm_rme_init(MachineState *ms)
>   {
>       static Error *rme_mig_blocker;
> @@ -132,11 +249,22 @@ int kvm_arm_rme_init(MachineState *ms)
>        */
>       qemu_add_vm_change_state_handler(rme_vm_state_change, NULL);
>   
> +    rme_guest->rom_load_notifier.notify = rme_rom_load_notify;
> +    rom_add_load_notifier(&rme_guest->rom_load_notifier);
> +
>       cgs->require_guest_memfd = true;
>       cgs->ready = true;
>       return 0;
>   }
>   
> +void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size)
> +{
> +    if (rme_guest) {
> +        rme_guest->ram_base = base;
> +        rme_guest->ram_size = size;
> +    }
> +}
> +
>   int kvm_arm_rme_vcpu_init(CPUState *cs)
>   {
>       ARMCPU *cpu = ARM_CPU(cs);

Thanks,
Gavin



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F53C02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYRaq-0007jY-Gt; Thu, 16 Jan 2025 10:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRan-0007jE-BB
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:15:34 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRak-0004Me-QU
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:15:32 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso602804f8f.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 07:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737040529; x=1737645329; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P2YFbZSRRq68dZ8YTMXTs2PyjB/YB4zWrlZnSpaNhjA=;
 b=pj1ZUuIlfMWpUSmFmyaqKJk5cVanDEv3P1RAYZs8tdXMVss/HhEqNsypzrhvAJSvJ9
 0a+TWTqqpBEbJ0mcZkFyQYtg2xiZu15IosECUFrIqxzbng1Dssr4RLfWxuaUem2RKSy8
 jpMayse3AoByyRm69YwwL2Dse8x75nUgkIANXFTNn9Rf4RLjEIMxfqhHwXbFUm89mtZU
 mSCkMGdZiYFVN0t1Fj+4MWe37K2IKLIUt/pcwwBCGG7tof2jl21sxorPlMcUFNFrpfHl
 /HivH4922ChVVWkfwNLuYY8hkJOSwWuJvNSTXJ73clDE2XYKiUnJo/mDRrZRIKgAHPq7
 tR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737040529; x=1737645329;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P2YFbZSRRq68dZ8YTMXTs2PyjB/YB4zWrlZnSpaNhjA=;
 b=IHA5Sh3yDM2oMaCzDe8BmQDeiA9s9mZQOyaI3Xwgwe6l1anzRdpiqYSYimvz35YFML
 mzy4CjRHTHvCadL9nDm4vE2Fbf0ha5VX3xMbEmR7G+ZteTidDfOKlo0JNKzQCgrcRxkL
 jPMN+mklryHjk1rCXtWiWzQIU5Jw7BI3oSBQb29cUpJs+ujuSGSkE8enPnpRJ00eO+rj
 YR6o1xd3P+w6u7pGqnxXSVZwhMExDzGDut1wX/OnZumjj0ETBNDidJR85q1xIs2xZaga
 EKeDVa6FcVujnN6VhxC/zbLe9YHUunaIz0RlpBkzz83+C8bmmEN6kTBnU1HTp7m81w/j
 wXRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfZfaNAP/cAXigR6a/AOkdVnODO9tGPL8muKUsXnHMn8tUyFqypkeBGXpz4xXdY4V5klazRpCUN7fU@nongnu.org
X-Gm-Message-State: AOJu0YzCp9Cw93SOTLBhaWXL/Uw5DO/qw/7eOaEb0haFl+sSzZu1SvHI
 V6zYXqFYxTNOm4FkVaki0tUw8KxMW1am3B56wA08h9VROLxzk53cSs4mOv5dj+s=
X-Gm-Gg: ASbGncvnnXMeoECJezBmZQ/ZfZICD9hcEaQgWTbpk29qedIER4ReGaCE5CtRagYEY7c
 z08xiBW7GHvfKKqPrtKcQc7I+SyGfaUwN2QYfhG8faQSWIM3olCaQmB52if1ac7b+jv654HerqG
 Hi7CHl5XBhE3RNW/+xlKf3OnqEWYNSqBayn7fAUXbcCwigYufKaMqTzHPh1QC4W8nkiPZb/TOIC
 N1NJwrBnSRUTyM3f4l454mNTTEwcV5PTfukdMSRS/TE+jM35mG1cSMwrCIhqSEqpnruj1WJOfUk
 GqtzvcfusYSkqOb8evXQfKVc
X-Google-Smtp-Source: AGHT+IF3Ab03hlPeEtyGVcmClbbw6R2nPcKnVnJRTlN/EjNbW+iquEZJisSTPjzNaI5nZnLULiP/fw==
X-Received: by 2002:a05:6000:18a7:b0:385:f220:f798 with SMTP id
 ffacd0b85a97d-38a872c93eemr26153783f8f.6.1737040529019; 
 Thu, 16 Jan 2025 07:15:29 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322a414sm118553f8f.47.2025.01.16.07.15.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 07:15:28 -0800 (PST)
Message-ID: <56e3ad5c-758b-4799-86a4-bb503aa34cea@linaro.org>
Date: Thu, 16 Jan 2025 16:15:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] hw/acpi: Add vmclock device
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Cornelia Huck <cohuck@redhat.com>,
 Peter Hilber <quic_philber@quicinc.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>, paul <paul@xen.org>,
 David Woodhouse <dwmw@amazon.co.uk>
References: <20250116140315.2455143-1-dwmw2@infradead.org>
 <20250116140315.2455143-4-dwmw2@infradead.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250116140315.2455143-4-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Hi David,

On 16/1/25 14:59, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The vmclock device addresses the problem of live migration with
> precision clocks. The tolerances of a hardware counter (e.g. TSC) are
> typically around ±50PPM. A guest will use NTP/PTP/PPS to discipline that
> counter against an external source of 'real' time, and track the precise
> frequency of the counter as it changes with environmental conditions.
> 
> When a guest is live migrated, anything it knows about the frequency of
> the underlying counter becomes invalid. It may move from a host where
> the counter running at -50PPM of its nominal frequency, to a host where
> it runs at +50PPM. There will also be a step change in the value of the
> counter, as the correctness of its absolute value at migration is
> limited by the accuracy of the source and destination host's time
> synchronization.
> 
> The device exposes a shared memory region to guests, which can be mapped
> all the way to userspace. In the first phase, this merely advertises a
> 'disruption_marker', which indicates that the guest should throw away any
> NTP synchronization it thinks it has, and start again.
> 
> Because the region can be exposed all the way to userspace, applications
> can still use time from a fast vDSO 'system call', and check the
> disruption marker to be sure that their timestamp is indeed truthful.
> 
> The structure also allows for the precise time, as known by the host, to
> be exposed directly to guests so that they don't have to wait for NTP to
> resync from scratch.
> 
> The values and fields are based on the nascent virtio-rtc specification,
> and the intent is that a version (hopefully precisely this version) of
> this structure will be included as an optional part of that spec. In the
> meantime, a simple ACPI device along the lines of VMGENID is perfectly
> sufficient and is compatible with what's being shipped in certain
> commercial hypervisors.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Reviewed-by: Paul Durrant <paul@xen.org>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   MAINTAINERS               |   5 ++
>   hw/acpi/Kconfig           |   5 ++
>   hw/acpi/meson.build       |   1 +
>   hw/acpi/vmclock.c         | 179 ++++++++++++++++++++++++++++++++++++++
>   hw/i386/Kconfig           |   1 +
>   hw/i386/acpi-build.c      |  10 ++-
>   include/hw/acpi/vmclock.h |  34 ++++++++
>   7 files changed, 234 insertions(+), 1 deletion(-)
>   create mode 100644 hw/acpi/vmclock.c
>   create mode 100644 include/hw/acpi/vmclock.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8b9d9a7cac..b51860aaed 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2414,6 +2414,11 @@ F: hw/audio/virtio-snd-pci.c
>   F: include/hw/audio/virtio-snd.h
>   F: docs/system/devices/virtio-snd.rst
>   
> +vmclock
> +M: David Woodhouse <dwmw2@infradead.org>
> +S: Supported
> +F: hw/acpi/vmclock.c
> +
>   nvme
>   M: Keith Busch <kbusch@kernel.org>
>   M: Klaus Jensen <its@irrelevant.dk>
> diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
> index e07d3204eb..1d4e9f0845 100644
> --- a/hw/acpi/Kconfig
> +++ b/hw/acpi/Kconfig
> @@ -60,6 +60,11 @@ config ACPI_VMGENID
>       default y
>       depends on PC
>   
> +config ACPI_VMCLOCK
> +    bool
> +    default y
> +    depends on PC

This doesn't look right (apparently the kernel side also build on ARM).

I'm only seeing e820_add_entry (I386) and ACPI API called. So:

     depends on I386 && ACPI

If later we want ARM support we'll have to rework the e820_add_entry()
call.

> diff --git a/hw/acpi/vmclock.c b/hw/acpi/vmclock.c
> new file mode 100644
> index 0000000000..7387e5c9ca
> --- /dev/null
> +++ b/hw/acpi/vmclock.c
> @@ -0,0 +1,179 @@
> +/*
> + * Virtual Machine Clock Device
> + *
> + * Copyright © 2024 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * Authors: David Woodhouse <dwmw2@infradead.org>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +#include "hw/i386/e820_memory_layout.h"
> +#include "hw/acpi/acpi.h"
> +#include "hw/acpi/aml-build.h"
> +#include "hw/acpi/vmclock.h"
> +#include "hw/nvram/fw_cfg.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
> +#include "migration/vmstate.h"
> +#include "system/reset.h"
> +
> +#include "standard-headers/linux/vmclock-abi.h"
> +
> +void vmclock_build_acpi(VmclockState *vms, GArray *table_data,
> +                        BIOSLinker *linker, const char *oem_id)
> +{
> +    Aml *ssdt, *dev, *scope, *crs;
> +    AcpiTable table = { .sig = "SSDT", .rev = 1,
> +                        .oem_id = oem_id, .oem_table_id = "VMCLOCK" };
> +
> +    /* Put VMCLOCK into a separate SSDT table */
> +    acpi_table_begin(&table, table_data);
> +    ssdt = init_aml_allocator();
> +
> +    scope = aml_scope("\\_SB");
> +    dev = aml_device("VCLK");
> +    aml_append(dev, aml_name_decl("_HID", aml_string("AMZNC10C")));
> +    aml_append(dev, aml_name_decl("_CID", aml_string("VMCLOCK")));
> +    aml_append(dev, aml_name_decl("_DDN", aml_string("VMCLOCK")));
> +
> +    /* Simple status method */
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
> +
> +    crs = aml_resource_template();
> +    aml_append(crs, aml_qword_memory(AML_POS_DECODE,
> +                                     AML_MIN_FIXED, AML_MAX_FIXED,
> +                                     AML_CACHEABLE, AML_READ_ONLY,
> +                                     0xffffffffffffffffULL,
> +                                     vms->physaddr,
> +                                     vms->physaddr + VMCLOCK_SIZE - 1,
> +                                     0, VMCLOCK_SIZE));
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +    aml_append(scope, dev);
> +    aml_append(ssdt, scope);
> +
> +    g_array_append_vals(table_data, ssdt->buf->data, ssdt->buf->len);
> +    acpi_table_end(linker, &table);
> +    free_aml_allocator();
> +}


> +static void vmclock_realize(DeviceState *dev, Error **errp)
> +{
> +    VmclockState *vms = VMCLOCK(dev);
> +
> +    /*
> +     * Given that this function is executing, there is at least one VMCLOCK
> +     * device. Check if there are several.
> +     */
> +    if (!find_vmclock_dev()) {
> +        error_setg(errp, "at most one %s device is permitted", TYPE_VMCLOCK);

Hmm.

> +        return;
> +    }
> +
> +    vms->physaddr = VMCLOCK_ADDR;
> +
> +    e820_add_entry(vms->physaddr, VMCLOCK_SIZE, E820_RESERVED);

I386 specific code, OK.

> +
> +    memory_region_init_ram(&vms->clk_page, OBJECT(dev), "vmclock_page",
> +                           VMCLOCK_SIZE, &error_abort);
> +    memory_region_set_enabled(&vms->clk_page, true);
> +    vms->clk = memory_region_get_ram_ptr(&vms->clk_page);
> +    memset(vms->clk, 0, VMCLOCK_SIZE);
> +
> +    vms->clk->magic = cpu_to_le32(VMCLOCK_MAGIC);
> +    vms->clk->size = cpu_to_le16(VMCLOCK_SIZE);
> +    vms->clk->version = cpu_to_le16(1);
> +
> +    /* These are all zero and thus default, but be explicit */
> +    vms->clk->clock_status = VMCLOCK_STATUS_UNKNOWN;
> +    vms->clk->counter_id = VMCLOCK_COUNTER_INVALID;
> +
> +    qemu_register_reset(vmclock_handle_reset, vms);

Isn't qemu_register_reset() legacy API?

> +
> +    vmclock_update_guest(vms);
> +}

> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index 32818480d2..d34ce07b21 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -43,6 +43,7 @@ config PC
>       select SERIAL_ISA
>       select ACPI_PCI
>       select ACPI_VMGENID
> +    select ACPI_VMCLOCK

IIUC this is optional (see [*] below) so:

         imply ACPI_VMCLOCK

>       select VIRTIO_PMEM_SUPPORTED
>       select VIRTIO_MEM_SUPPORTED
>       select HV_BALLOON_SUPPORTED
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 733b8f0851..d482f974df 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -43,6 +43,7 @@
>   #include "system/tpm.h"
>   #include "hw/acpi/tpm.h"
>   #include "hw/acpi/vmgenid.h"
> +#include "hw/acpi/vmclock.h"
>   #include "hw/acpi/erst.h"
>   #include "hw/acpi/piix4.h"
>   #include "system/tpm_backend.h"
> @@ -2432,7 +2433,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>       uint8_t *u;
>       GArray *tables_blob = tables->table_data;
>       AcpiSlicOem slic_oem = { .id = NULL, .table_id = NULL };
> -    Object *vmgenid_dev;
> +    Object *vmgenid_dev, *vmclock_dev;
>       char *oem_id;
>       char *oem_table_id;
>   
> @@ -2505,6 +2506,13 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>                              tables->vmgenid, tables->linker, x86ms->oem_id);
>       }
>   
> +    vmclock_dev = find_vmclock_dev();
> +    if (vmclock_dev) {

[*]

> +        acpi_add_table(table_offsets, tables_blob);
> +        vmclock_build_acpi(VMCLOCK(vmclock_dev), tables_blob, tables->linker,
> +                           x86ms->oem_id);
> +    }

Regards,

Phil.


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5005C71135
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 12:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ3yw-0006an-A8; Fri, 13 Jun 2025 08:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uQ3yk-0006XH-Nu
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 08:57:56 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uQ3yi-0008LQ-9H
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 08:57:54 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-70a57a8ffc3so19615487b3.0
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 05:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749819471; x=1750424271; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5e5DLwd9hQN7WIN5NYjTG58rp8CGAwEIUDrxIuaZN+E=;
 b=v/XtFc3YOgBHtmtsJYjygs7TFGllq7VyxnHsTkIGSrumbuuC+xfL7FXwoCPJftS9Tb
 2yDSQMXjm9Sv+zl8DSPm/9borXcYnzlhAemcdbhRo87fM6ufabu1Jp4w53TB6ld5mX+X
 AV1ucjiAnjVHuTgrhntiCoZGMPtVD6d/wBoyt1RURfnE/XXdC0RqqGX/nuH6y/JNQRsB
 apCqbktfOaFHmpdnhPBCoLaBjZ3cmp9KeYCi/QnV8inFoNYotwq9R6XDWiHD73+hM9bW
 1LfDZTUa5AgIllrczGvlCn4XkUR9xSOhpAOUUrbgArJR3j6RcEFjCc/HEmqTXoTJGR92
 IokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749819471; x=1750424271;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5e5DLwd9hQN7WIN5NYjTG58rp8CGAwEIUDrxIuaZN+E=;
 b=WRTrk/CaI3ecBjjLDmSFiO/lMWcWsYlsOrCj42xPUVE0ZzphWd3MLBNkfT1yesTjey
 gv/BPufxtP1zBhx+nzhZSLRYcplXPHIvDtwqNsAspQiCogfrKZnLO8VetLZcnKGVVHJn
 qW2yXULNsLHTMdhtHQ7MoWAWra0pcucIK2t16UwQY+00LWySQSEJS+oCCsgZQjhZKNQ/
 wM/rFuVy9kLZi54ApbKIGBPrBGl27etE9Va4PiLcFY7TwpOSnKFbgDj/Wp7nHIFa1NDs
 gHMoPBotoJhMQbYsDjvU18zAb4mg1cg8hTIm+Dkeo/QSXRXAKb6K+ajjtJBExo4o6T2u
 uWDg==
X-Gm-Message-State: AOJu0YyS2zDSM+3O+GG2wNcqcX2xdOdYgz3STno2sXTP+zk/XcWrp5FT
 OPKx3ObVTrhds8/EBczUkKEh/lhFU+8nP1kAiIfxFbpkLLyQ7cS/Gz1NKguseJ+0Xa7sYMRWtDu
 6ykMGpGtvJl4SRy++Lk2g582S5XJwfXnazvX0ZtWvTQ==
X-Gm-Gg: ASbGncv9EcTl05HuYdJIS0lfb2lz93wI5c7NPdy1tXxX8Y5ll5O0lul4CFjJMA2L2zH
 XkdrLGfLrfMTbOOgj+DlWp8EQs3rRCpwVarfLndAYC4gaU8P5dZoNjjlLID/StO+A+/GAK+RUwO
 kuToQehBR5EiJ+U/c0e2Vsg7hnGMch26EtPG5ab+Fk01xd
X-Google-Smtp-Source: AGHT+IGOqdMgK2uR5dYMh+4m6yWvXA5HHWIhp0IPRI9GXw8RTzt2MNwCVJQ74vJuTdZKitYKMfh0RBIxhRkxEj0eMow=
X-Received: by 2002:a05:690c:d1c:b0:70c:a854:8384 with SMTP id
 00721157ae682-71163645c81mr50388717b3.11.1749819470736; Fri, 13 Jun 2025
 05:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250612134338.1871023-1-Jonathan.Cameron@huawei.com>
 <20250612134338.1871023-4-Jonathan.Cameron@huawei.com>
In-Reply-To: <20250612134338.1871023-4-Jonathan.Cameron@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jun 2025 13:57:39 +0100
X-Gm-Features: AX0GCFv5MSwU1aQDZ69b1dKRTca84UO3VVXOn0u2BXHQNHBteShBJRs4HFTae4I
Message-ID: <CAFEAcA-J+vAGfEV67PezA72rUiqpuqTBT=8hJLc1sw+xo3XHWQ@mail.gmail.com>
Subject: Re: [PATCH v15 3/4] hw/arm/virt: Basic CXL enablement on
 pci_expander_bridge instances pxb-cxl
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>, mst@redhat.com, 
 Zhijian Li <lizhijian@fujitsu.com>, Itaru Kitayama <itaru.kitayama@linux.dev>,
 linuxarm@huawei.com, linux-cxl@vger.kernel.org, qemu-arm@nongnu.org, 
 Yuquan Wang <wangyuquan1236@phytium.com.cn>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Thu, 12 Jun 2025 at 14:45, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> Code based on i386/pc enablement. The memory layout places space for 16
> host bridge register regions after the GIC_REDIST2 in the extended memmap.
> The CFMWs are placed above the extended memmap.
>
> Only create the CEDT table if cxl=on set for the machine.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> ---
> v15: No changes.
> ---
>  include/hw/arm/virt.h    |  4 ++++
>  hw/arm/virt-acpi-build.c | 34 ++++++++++++++++++++++++++++++++++
>  hw/arm/virt.c            | 29 +++++++++++++++++++++++++++++
>  3 files changed, 67 insertions(+)

Can we have some user-facing documentation, please?
(docs/system/arm/virt.rst -- can just be a brief mention
and link to docs/system/devices/cxl.rst if you want to put the
examples of aarch64 use in there.)

> @@ -220,6 +223,7 @@ static const MemMapEntry base_memmap[] = {
>  static MemMapEntry extended_memmap[] = {
>      /* Additional 64 MB redist region (can contain up to 512 redistributors) */
>      [VIRT_HIGH_GIC_REDIST2] =   { 0x0, 64 * MiB },
> +    [VIRT_CXL_HOST] =           { 0x0, 64 * KiB * 16 }, /* 16 UID */

This is going to shuffle the memory map around, even if CXL
isn't enabled, which will break migration compatibility.
You need to do something to ensure that the CXL region isn't
included in the calculations of the base addresses for these
regions if CXL isn't enabled.

>      [VIRT_HIGH_PCIE_ECAM] =     { 0x0, 256 * MiB },
>      /* Second PCIe window */
>      [VIRT_HIGH_PCIE_MMIO] =     { 0x0, DEFAULT_HIGH_PCIE_MMIO_SIZE },

If you're OK with having the CXL host region at the end of the
list then that's a simpler way to avoid its presence disturbing
the layout of the existing regions, but you might not like it
being at such a high physaddr.

> @@ -1621,6 +1625,17 @@ static void create_pcie(VirtMachineState *vms)
>      }
>  }
>
> +static void create_cxl_host_reg_region(VirtMachineState *vms)
> +{
> +    MemoryRegion *sysmem = get_system_memory();
> +    MemoryRegion *mr = &vms->cxl_devices_state.host_mr;

This looks odd -- why are we reaching directly into the cxl_devices_state
to fish out a MemoryRegion and init it?

> +    memory_region_init(mr, OBJECT(vms), "cxl_host_reg",
> +                       vms->memmap[VIRT_CXL_HOST].size);
> +    memory_region_add_subregion(sysmem, vms->memmap[VIRT_CXL_HOST].base, mr);
> +    vms->highmem_cxl = true;
> +}
> +
>  static void create_platform_bus(VirtMachineState *vms)
>  {
>      DeviceState *dev;
> @@ -1737,6 +1752,12 @@ void virt_machine_done(Notifier *notifier, void *data)
>      struct arm_boot_info *info = &vms->bootinfo;
>      AddressSpace *as = arm_boot_address_space(cpu, info);
>
> +    cxl_hook_up_pxb_registers(vms->bus, &vms->cxl_devices_state,
> +                              &error_fatal);
> +
> +    if (vms->cxl_devices_state.is_enabled) {
> +        cxl_fmws_link_targets(&error_fatal);
> +    }
>      /*
>       * If the user provided a dtb, we assume the dynamic sysbus nodes
>       * already are integrated there. This corresponds to a use case where
> @@ -1783,6 +1804,7 @@ static inline bool *virt_get_high_memmap_enabled(VirtMachineState *vms,
>  {
>      bool *enabled_array[] = {
>          &vms->highmem_redists,
> +        &vms->highmem_cxl,
>          &vms->highmem_ecam,
>          &vms->highmem_mmio,
>      };
> @@ -1890,6 +1912,9 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
>      if (device_memory_size > 0) {
>          machine_memory_devices_init(ms, device_memory_base, device_memory_size);
>      }
> +
> +    cxl_fmws_set_memmap(ROUND_UP(vms->highest_gpa + 1, 256 * MiB),
> +                        BIT_ULL(pa_bits));

Isn't this stomping over the HIGH_PCIE memory window (or
whatever else happens to be at the top end of memory) ?

Also taking highest_gpa and then rounding it up looks suspicious:
if it's the highest GPA then anything larger than that is off
the end of the physical address space.

Plus cxl_fmws_set_memmap() names its arguments base, max_addr:
"highest gpa, rounded up" doesn't sound like a base address.

(Looking at our current code that sets and adjusts highest_gpa,
it looks a bit weird: maybe we're setting it to values that aren't
what the variable name claims it's doing, and that's why this
code happens to work ?)

>  }
>
>  static VirtGICType finalize_gic_version_do(const char *accel_name,
> @@ -2340,6 +2365,8 @@ static void machvirt_init(MachineState *machine)
>      memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base,
>                                  machine->ram);
>
> +    cxl_fmws_update_mmio();
> +
>      virt_flash_fdt(vms, sysmem, secure_sysmem ?: sysmem);
>
>      create_gic(vms, sysmem);
> @@ -2395,6 +2422,7 @@ static void machvirt_init(MachineState *machine)
>      create_rtc(vms);
>
>      create_pcie(vms);
> +    create_cxl_host_reg_region(vms);
>
>      if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
>          vms->acpi_dev = create_acpi_ged(vms);
> @@ -3365,6 +3393,7 @@ static void virt_instance_init(Object *obj)
>
>      vms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
>      vms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
> +    cxl_machine_init(obj, &vms->cxl_devices_state);
>  }

cxl defaults to disabled, right? (i.e. we don't need the
machine-version specific stuff to keep it from being enabled
on old versioned machine types).

thanks
-- PMM


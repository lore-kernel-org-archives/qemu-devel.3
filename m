Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E0DC54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWZy-0006EH-Rq; Mon, 26 Feb 2024 03:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reWZy-0006E2-2m
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:43:18 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reWZw-0007xZ-7u
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:43:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708936996; x=1740472996;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=5du1ZNf9adi2dAeM9Sm6epTKF73eeoRKt0chtDMR+s0=;
 b=cK5WchQ/wjzrL4pqcKyAWOnwo53jd/+QcJEgZkXwxA+RLggUe0JqOArz
 7+Z22fpfyQ7klNKPZu3LbbFgfS8u1NhkRVOmVW8ZhJ+bMOwTeBpwMkTOc
 i6dCfEXLafxuzKBUVmZ+RZWgFaO0HQBEviG6iW4ykiyph+I7wfbIG6lmF
 8F75CEJ+NN16SdLE/YKKbXS/KlWSyDiPz0gSw/K6ETh6qPxq+ErxI4ToR
 G7qNVpQ63xPdk0zQ+ouUKlQHLM9hU7vGHDgqmMJcxt/QVopf8WjXWPOeL
 bg6Gw6SZkgpMoq1m5j4zEap28kPUNBfn5b2mJmMj8Mr4LfxGvmsslNeYg g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="6994824"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6994824"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 00:43:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="7116540"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 26 Feb 2024 00:43:10 -0800
Date: Mon, 26 Feb 2024 16:56:52 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Durrant <paul@xen.org>,
 Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH v2 2/6] hw/i386/pc: Rename "bus" attribute to "pcibus"
Message-ID: <ZdxSVGAMmK+D/l+t@intel.com>
References: <20240224135851.100361-1-shentey@gmail.com>
 <20240224135851.100361-3-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240224135851.100361-3-shentey@gmail.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, Feb 24, 2024 at 02:58:47PM +0100, Bernhard Beschow wrote:
> Date: Sat, 24 Feb 2024 14:58:47 +0100
> From: Bernhard Beschow <shentey@gmail.com>
> Subject: [PATCH v2 2/6] hw/i386/pc: Rename "bus" attribute to "pcibus"
> X-Mailer: git-send-email 2.44.0
> 
> The attribute is of type PCIBus; reflect that in the name. It will also make the
> next change more intuitive.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  include/hw/i386/pc.h     | 2 +-
>  hw/i386/acpi-build.c     | 2 +-
>  hw/i386/amd_iommu.c      | 2 +-
>  hw/i386/intel_iommu.c    | 2 +-
>  hw/i386/kvm/xen_evtchn.c | 2 +-
>  hw/i386/pc.c             | 8 ++++----
>  hw/i386/pc_piix.c        | 6 +++---
>  hw/i386/pc_q35.c         | 2 +-
>  hw/i386/x86-iommu.c      | 2 +-
>  9 files changed, 14 insertions(+), 14 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index e88468131a..27834043c3 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -31,7 +31,7 @@ typedef struct PCMachineState {
>      Notifier machine_done;
>  
>      /* Pointers to devices and objects: */
> -    PCIBus *bus;
> +    PCIBus *pcibus;
>      I2CBus *smbus;
>      PFlashCFI01 *flash[2];
>      ISADevice *pcspk;
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index d3ce96dd9f..cd3f2d0148 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1556,7 +1556,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>      }
>  
>      crs_range_set_init(&crs_range_set);
> -    bus = PC_MACHINE(machine)->bus;
> +    bus = PC_MACHINE(machine)->pcibus;
>      if (bus) {
>          QLIST_FOREACH(bus, &bus->child, sibling) {
>              uint8_t bus_num = pci_bus_num(bus);
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 7329553ad3..6d4fde72f9 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1584,7 +1584,7 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>      MachineState *ms = MACHINE(qdev_get_machine());
>      PCMachineState *pcms = PC_MACHINE(ms);
>      X86MachineState *x86ms = X86_MACHINE(ms);
> -    PCIBus *bus = pcms->bus;
> +    PCIBus *bus = pcms->pcibus;
>  
>      s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
>                                       amdvi_uint64_equal, g_free, g_free);
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index cf933189d3..cc8e59674e 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4183,7 +4183,7 @@ static void vtd_realize(DeviceState *dev, Error **errp)
>      MachineState *ms = MACHINE(qdev_get_machine());
>      PCMachineState *pcms = PC_MACHINE(ms);
>      X86MachineState *x86ms = X86_MACHINE(ms);
> -    PCIBus *bus = pcms->bus;
> +    PCIBus *bus = pcms->pcibus;
>      IntelIOMMUState *s = INTEL_IOMMU_DEVICE(dev);
>      X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
>  
> diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
> index 0171ef6d59..a5052c0ea3 100644
> --- a/hw/i386/kvm/xen_evtchn.c
> +++ b/hw/i386/kvm/xen_evtchn.c
> @@ -371,7 +371,7 @@ static int set_callback_pci_intx(XenEvtchnState *s, uint64_t param)
>          return 0;
>      }
>  
> -    pdev = pci_find_device(pcms->bus, bus, devfn);
> +    pdev = pci_find_device(pcms->pcibus, bus, devfn);
>      if (!pdev) {
>          return 0;
>      }
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f8eb684a49..353edeb2ea 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -675,7 +675,7 @@ void pc_machine_done(Notifier *notifier, void *data)
>                                          PCMachineState, machine_done);
>      X86MachineState *x86ms = X86_MACHINE(pcms);
>  
> -    cxl_hook_up_pxb_registers(pcms->bus, &pcms->cxl_devices_state,
> +    cxl_hook_up_pxb_registers(pcms->pcibus, &pcms->cxl_devices_state,
>                                &error_fatal);
>  
>      if (pcms->cxl_devices_state.is_enabled) {
> @@ -685,7 +685,7 @@ void pc_machine_done(Notifier *notifier, void *data)
>      /* set the number of CPUs */
>      x86_rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
>  
> -    fw_cfg_add_extra_pci_roots(pcms->bus, x86ms->fw_cfg);
> +    fw_cfg_add_extra_pci_roots(pcms->pcibus, x86ms->fw_cfg);
>  
>      acpi_setup();
>      if (x86ms->fw_cfg) {
> @@ -1250,8 +1250,8 @@ void pc_basic_device_init(struct PCMachineState *pcms,
>          xen_evtchn_create(IOAPIC_NUM_PINS, gsi);
>          xen_gnttab_create();
>          xen_xenstore_create();
> -        if (pcms->bus) {
> -            pci_create_simple(pcms->bus, -1, "xen-platform");
> +        if (pcms->pcibus) {
> +            pci_create_simple(pcms->pcibus, -1, "xen-platform");
>          }
>          xen_bus_init();
>          xen_be_init();
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 7724396ead..3393b93007 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -216,7 +216,7 @@ static void pc_init1(MachineState *machine,
>          pci_bus_map_irqs(pci_bus,
>                           xen_enabled() ? xen_pci_slot_get_pirq
>                                         : pc_pci_slot_get_pirq);
> -        pcms->bus = pci_bus;
> +        pcms->pcibus = pci_bus;
>  
>          hole64_size = object_property_get_uint(phb,
>                                                 PCI_HOST_PROP_PCI_HOLE64_SIZE,
> @@ -480,8 +480,8 @@ static void pc_xen_hvm_init(MachineState *machine)
>      }
>  
>      pc_xen_hvm_init_pci(machine);
> -    xen_igd_reserve_slot(pcms->bus);
> -    pci_create_simple(pcms->bus, -1, "xen-platform");
> +    xen_igd_reserve_slot(pcms->pcibus);
> +    pci_create_simple(pcms->pcibus, -1, "xen-platform");
>  }
>  #endif
>  
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index c89ff63579..734d9bedb2 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -217,7 +217,7 @@ static void pc_q35_init(MachineState *machine)
>  
>      /* pci */
>      host_bus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pcie.0"));
> -    pcms->bus = host_bus;
> +    pcms->pcibus = host_bus;
>  
>      /* irq lines */
>      gsi_state = pc_gsi_create(&x86ms->gsi, true);
> diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
> index 726e9e1d16..60af896225 100644
> --- a/hw/i386/x86-iommu.c
> +++ b/hw/i386/x86-iommu.c
> @@ -101,7 +101,7 @@ static void x86_iommu_realize(DeviceState *dev, Error **errp)
>      QLIST_INIT(&x86_iommu->iec_notifiers);
>      bool irq_all_kernel = kvm_irqchip_in_kernel() && !kvm_irqchip_is_split();
>  
> -    if (!pcms || !pcms->bus) {
> +    if (!pcms || !pcms->pcibus) {
>          error_setg(errp, "Machine-type '%s' not supported by IOMMU",
>                     mc->name);
>          return;
> -- 
> 2.44.0
> 
> 


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31F8CA0FE9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 09:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqqM2-0003ZA-9E; Tue, 26 Aug 2025 05:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqqM0-0003Yx-GB
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 05:52:36 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uqqLo-0002hj-4J
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 05:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756201944; x=1787737944;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=t/Patup7nWUfF/GinangY2uI4/c07GMjjpmIPXpW8zE=;
 b=V5mm/k0GJrjL6cTqE3g2jS7uBz+ceF8gDCDhV1qmRJZk9vtScamqP0AA
 iXkwhTsbxjNfaG7tT+N08B/U0HmKuPsI/BlLLQhD7sKOebVYzm5ej0mOm
 /6K0eBU5BYX8oAL7FXE1PmvJOdy7QNO2DWMy676dL73SU0KViHfxsh2lG
 KlTKeJzv1rh3EkbJ/cxUj+3B1wlbUcN0D8lwAoJA73HxQTbc5mQAHKGJf
 lb2VMbbwCkZwzVf+6ALloI59uhlma8zrriPLRuaaY6A3DBX8oc+xwxzFN
 YaziBhUnfRYC2O9YnVfRNmnB4okhSJjlcDuEY364dBBVf0BlaFV/poln9 w==;
X-CSE-ConnectionGUID: yu3Dv3QgQJm+EIPdfNbzqA==
X-CSE-MsgGUID: DvaIsMbZSgqN91nTPdu1RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="69866609"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="69866609"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 02:52:19 -0700
X-CSE-ConnectionGUID: a1Yrz/x+RRmXdjpIDRFa/w==
X-CSE-MsgGUID: vcywT9qfQZGf+ZLYqPqo7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="169464368"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 02:52:17 -0700
Message-ID: <658ef6d0-6bbc-403b-91e8-974311ef4815@intel.com>
Date: Tue, 26 Aug 2025 17:52:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/19] hw/i386/pc_piix.c: remove SMI and piix4_pm
 initialisation from pc_init_isa()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-7-mark.caveayland@nutanix.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250822121342.894223-7-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.703, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 8/22/2025 8:11 PM, Mark Cave-Ayland wrote:
> These are based upon the PIIX4 PCI chipset and so can never be used on an isapc machine.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   hw/i386/pc_piix.c | 19 -------------------
>   1 file changed, 19 deletions(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index da2de88383..e58a7b3977 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -441,8 +441,6 @@ static void pc_init_isa(MachineState *machine)
>       MemoryRegion *system_memory = get_system_memory();
>       MemoryRegion *system_io = get_system_io();
>       ISABus *isa_bus;
> -    Object *piix4_pm = NULL;
> -    qemu_irq smi_irq;
>       GSIState *gsi_state;
>       MemoryRegion *ram_memory;
>       MemoryRegion *rom_memory = system_memory;
> @@ -597,23 +595,6 @@ static void pc_init_isa(MachineState *machine)
>       }
>   #endif
>   
> -    if (piix4_pm) {
> -        smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
> -
> -        qdev_connect_gpio_out_named(DEVICE(piix4_pm), "smi-irq", 0, smi_irq);
> -        pcms->smbus = I2C_BUS(qdev_get_child_bus(DEVICE(piix4_pm), "i2c"));
> -        /* TODO: Populate SPD eeprom data.  */
> -        smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
> -
> -        object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
> -                                 TYPE_HOTPLUG_HANDLER,
> -                                 (Object **)&x86ms->acpi_dev,
> -                                 object_property_allow_set_link,
> -                                 OBJ_PROP_LINK_STRONG);
> -        object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
> -                                 piix4_pm, &error_abort);
> -    }
> -
>       if (machine->nvdimms_state->is_enabled) {
>           nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
>                                  x86_nvdimm_acpi_dsmio,



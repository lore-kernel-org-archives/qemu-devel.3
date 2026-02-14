Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15E9EF48C9
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 11:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrE6h-0005qp-Pd; Sat, 14 Feb 2026 06:46:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vrE6e-0005qN-OT; Sat, 14 Feb 2026 06:46:37 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vrE6c-0003r7-3j; Sat, 14 Feb 2026 06:46:36 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CFDC7596ADA;
 Sat, 14 Feb 2026 12:46:30 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id iu8HW44TlmLw; Sat, 14 Feb 2026 12:46:28 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B9C74596AC7; Sat, 14 Feb 2026 12:46:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B80B35969F6;
 Sat, 14 Feb 2026 12:46:28 +0100 (CET)
Date: Sat, 14 Feb 2026 12:46:28 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 7/8] hw/ppc: Set graphic display dimensions generically
In-Reply-To: <20260214021240.58657-8-philmd@linaro.org>
Message-ID: <252b2fa2-9251-3949-625b-7071c525c8e2@eik.bme.hu>
References: <20260214021240.58657-1-philmd@linaro.org>
 <20260214021240.58657-8-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-748815940-1771068859=:43665"
Content-ID: <83d4573b-b87d-6721-97b7-1122260f6ab5@eik.bme.hu>
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-748815940-1771068859=:43665
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <561c4897-6084-daef-ffc3-81306ca2cef0@eik.bme.hu>

On Sat, 14 Feb 2026, Philippe Mathieu-Daudé wrote:
> If a dimension is not set, have the machine init code set
> the default value by calling the ppc_graphic_dimensions()
> helper, common to all PowerPC machines. Declare local
> variables to avoid using the global ones.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> include/hw/ppc/ppc.h    |  2 ++
> hw/ppc/mac_newworld.c   | 10 ++++++----
> hw/ppc/mac_oldworld.c   | 10 ++++++----
> hw/ppc/ppc.c            |  8 ++++++++
> hw/ppc/prep.c           |  4 ++++
> hw/ppc/spapr.c          |  4 ++++
> system/globals-target.c |  6 ------
> 7 files changed, 30 insertions(+), 14 deletions(-)
>
> diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
> index cb51d704c6d..14cc09ab22b 100644
> --- a/include/hw/ppc/ppc.h
> +++ b/include/hw/ppc/ppc.h
> @@ -102,6 +102,8 @@ enum {
>     ARCH_MAC99_U3,
> };
>
> +void ppc_graphic_dimensions(int *width, int *height, int *depth);
> +
> #define FW_CFG_PPC_WIDTH        (FW_CFG_ARCH_LOCAL + 0x00)
> #define FW_CFG_PPC_HEIGHT       (FW_CFG_ARCH_LOCAL + 0x01)
> #define FW_CFG_PPC_DEPTH        (FW_CFG_ARCH_LOCAL + 0x02)
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 7275563a155..daf0029c01a 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -156,6 +156,7 @@ static void ppc_core99_init(MachineState *machine)
>     DeviceState *uninorth_internal_dev = NULL, *uninorth_agp_dev = NULL;
>     hwaddr nvram_addr = 0xFFF04000;
>     uint64_t tbfreq = kvm_enabled() ? kvmppc_get_tbfreq() : TBFREQ;
> +    int graphic_width, graphic_height, graphic_depth;
>
>     /* init CPUs */
>     for (i = 0; i < machine->smp.cpus; i++) {
> @@ -432,10 +433,6 @@ static void ppc_core99_init(MachineState *machine)
>
>     pci_vga_init(pci_bus);
>
> -    if (graphic_depth != 15 && graphic_depth != 32 && graphic_depth != 8) {
> -        graphic_depth = 15;
> -    }
> -
>     pci_init_nic_devices(pci_bus, mc->default_nic);
>
>     /* The NewWorld NVRAM is not located in the MacIO device */
> @@ -480,6 +477,11 @@ static void ppc_core99_init(MachineState *machine)
>     fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
>     fw_cfg_add_i16(fw_cfg, FW_CFG_BOOT_DEVICE, ppc_boot_device);
>
> +    ppc_graphic_dimensions(&graphic_width, &graphic_height, &graphic_depth);
> +    if (graphic_depth != 15 && graphic_depth != 32 && graphic_depth != 8) {
> +        graphic_depth = 15;
> +    }
> +
>     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_WIDTH, graphic_width);
>     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_HEIGHT, graphic_height);
>     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_DEPTH, graphic_depth);
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index e679d338985..ea1f778877c 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -108,6 +108,7 @@ static void ppc_heathrow_init(MachineState *machine)
>     DriveInfo *dinfo, *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>     void *fw_cfg;
>     uint64_t tbfreq = kvm_enabled() ? kvmppc_get_tbfreq() : TBFREQ;
> +    int graphic_width, graphic_height, graphic_depth;
>
>     /* init CPUs */
>     for (i = 0; i < machine->smp.cpus; i++) {
> @@ -288,10 +289,6 @@ static void ppc_heathrow_init(MachineState *machine)
>         pci_create_simple(pci_bus, -1, "pci-ohci");
>     }
>
> -    if (graphic_depth != 15 && graphic_depth != 32 && graphic_depth != 8) {
> -        graphic_depth = 15;
> -    }
> -
>     /* No PCI init: the BIOS will do it */
>
>     dev = qdev_new(TYPE_FW_CFG_MEM);
> @@ -321,6 +318,11 @@ static void ppc_heathrow_init(MachineState *machine)
>     fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
>     fw_cfg_add_i16(fw_cfg, FW_CFG_BOOT_DEVICE, ppc_boot_device);
>
> +    ppc_graphic_dimensions(&graphic_width, &graphic_height, &graphic_depth);
> +    if (graphic_depth != 15 && graphic_depth != 32 && graphic_depth != 8) {
> +        graphic_depth = 15;
> +    }
> +
>     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_WIDTH, graphic_width);
>     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_HEIGHT, graphic_height);
>     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_DEPTH, graphic_depth);
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index a512d4fa647..d7b4466d701 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -29,6 +29,7 @@
> #include "qemu/timer.h"
> #include "exec/cpu-interrupt.h"
> #include "system/cpus.h"
> +#include "system/system.h"
> #include "qemu/log.h"
> #include "qemu/main-loop.h"
> #include "qemu/error-report.h"
> @@ -1557,3 +1558,10 @@ void ppc_irq_reset(PowerPCCPU *cpu)
>         kvmppc_set_interrupt(cpu, PPC_INTERRUPT_EXT, 0);
>     }
> }
> +
> +void ppc_graphic_dimensions(int *width, int *height, int *depth)
> +{
> +    *width = graphic_width ?: 800;
> +    *height = graphic_height ?: 600;
> +    *depth = graphic_depth ?: 32;
> +}

I think there's no reason to have this common to all ppc machines. If we 
change this we could also make it per machine like for other targets. 
There's nothing common in these machines that dictate these defaults. It 
seems it used to be an arbitrary default in QEMU that some machines later 
deviated from. So might as well just keep it as global for now after you 
removed the SPARC and M68K special cases. If the ppc machines are the last 
users of these global defaults you can just move them to hw/ppc/ppc.{h,c} 
for now and let ppc people clean this up eventually.

Regards,
BALATON Zoltan

> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index c4efd1d3908..7077b047b25 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -43,6 +43,7 @@
> #include "exec/target_page.h"
> #include "system/kvm.h"
> #include "system/reset.h"
> +#include "system/system.h"
> #include "trace.h"
> #include "elf.h"
> #include "qemu/units.h"
> @@ -250,6 +251,7 @@ static void ibm_40p_init(MachineState *machine)
>     uint32_t kernel_base = 0, initrd_base = 0;
>     long kernel_size = 0, initrd_size = 0;
>     char boot_device;
> +    int graphic_width, graphic_height, graphic_depth;
>
>     if (kvm_enabled()) {
>         error_report("machine %s does not support the KVM accelerator",
> @@ -412,6 +414,8 @@ static void ibm_40p_init(MachineState *machine)
>     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)machine->ram_size);
>     fw_cfg_add_i16(fw_cfg, FW_CFG_MACHINE_ID, ARCH_PREP);
>
> +    ppc_graphic_dimensions(&graphic_width, &graphic_height, &graphic_depth);
> +
>     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_WIDTH, graphic_width);
>     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_HEIGHT, graphic_height);
>     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_DEPTH, graphic_depth);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 274f38785f2..c50c7da34d5 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1143,6 +1143,7 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt, bool reset)
> {
>     MachineState *machine = MACHINE(spapr);
>     int chosen;
> +    int graphic_width, graphic_height, graphic_depth;
>
>     _FDT(chosen = fdt_add_subnode(fdt, 0, "chosen"));
>
> @@ -1177,6 +1178,9 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt, bool reset)
>         if (machine->boot_config.has_menu && machine->boot_config.menu) {
>             _FDT((fdt_setprop_cell(fdt, chosen, "qemu,boot-menu", true)));
>         }
> +
> +        ppc_graphic_dimensions(&graphic_width, &graphic_height, &graphic_depth);
> +
>         _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-width", graphic_width));
>         _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-height", graphic_height));
>         _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-depth", graphic_depth));
> diff --git a/system/globals-target.c b/system/globals-target.c
> index 17a27a06218..ffa6c308b59 100644
> --- a/system/globals-target.c
> +++ b/system/globals-target.c
> @@ -9,12 +9,6 @@
> #include "qemu/osdep.h"
> #include "system/system.h"
>
> -#if defined(TARGET_SPARC) || defined(TARGET_M68K)
> int graphic_width;
> int graphic_height;
> int graphic_depth;
> -#else
> -int graphic_width = 800;
> -int graphic_height = 600;
> -int graphic_depth = 32;
> -#endif
>
--3866299591-748815940-1771068859=:43665--


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E556CC6369E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 23:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuJCJ-0006NH-Ej; Sun, 22 Feb 2026 18:49:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vuJCI-0006Mv-3u
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:49:10 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vuJCG-00059j-2w
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:49:09 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 20C6959736D;
 Mon, 23 Feb 2026 00:49:02 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id DfXrZ1v6qHJL; Mon, 23 Feb 2026 00:49:00 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0593A59731C; Mon, 23 Feb 2026 00:49:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 01A645969F2;
 Mon, 23 Feb 2026 00:48:59 +0100 (CET)
Date: Mon, 23 Feb 2026 00:48:59 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org
Subject: Re: [PULL 10/20] hw/ppc: Set graphic display dimensions
 generically
In-Reply-To: <20260222230602.5756-11-philmd@linaro.org>
Message-ID: <2671f32a-0881-c2fc-7cd4-5c684a4ac43e@eik.bme.hu>
References: <20260222230602.5756-1-philmd@linaro.org>
 <20260222230602.5756-11-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-891330876-1771804139=:21785"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--3866299591-891330876-1771804139=:21785
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 23 Feb 2026, Philippe Mathieu-Daudé wrote:
> If a dimension is not set, have the machine init code set
> the default value by calling the ppc_graphic_dimensions()
> helper, common to all PowerPC machines. Declare local
> variables to avoid using the global ones.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20260216213121.47122-8-philmd@linaro.org>
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

Sorry but didn't we say that there should be no common 
ppc_graphic_dimensions function but each board should set its own 
defaults?

Regards,
BALATON Zoltan
--3866299591-891330876-1771804139=:21785--


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53F2C54ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 15:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uITzx-0001EY-CA; Fri, 23 May 2025 11:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uITzs-0001Dy-DS; Fri, 23 May 2025 11:07:44 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uITzn-0003nO-Sx; Fri, 23 May 2025 11:07:42 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6371955BC03;
 Fri, 23 May 2025 17:07:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id yuB41LotNhpl; Fri, 23 May 2025 17:07:35 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 726B255BC02; Fri, 23 May 2025 17:07:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 700C0745682;
 Fri, 23 May 2025 17:07:35 +0200 (CEST)
Date: Fri, 23 May 2025 17:07:35 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 3/3] hw/ppc/e500: Use SysBusDevice API to access
 TYPE_CCSR's internal resources
In-Reply-To: <619a58d1f83d2aad5b4feec930d46c64abff0977.1748012109.git.balaton@eik.bme.hu>
Message-ID: <4194477a-9241-b019-0f55-ac3b74765e2a@eik.bme.hu>
References: <cover.1748012109.git.balaton@eik.bme.hu>
 <619a58d1f83d2aad5b4feec930d46c64abff0977.1748012109.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Fri, 23 May 2025, Bernhard Beschow wrote:
> From: Bernhard Beschow <shentey@gmail.com>

This was meant to be only here but somehow it alse overwrote the ream 
From that should have been my address. Sorry for that, but patch is still 
correct.

Regards,
BALATON Zoltan

> Rather than accessing the attributes of TYPE_CCSR directly, use the SysBusDevice
> API which exists exactly for that purpose. Furthermore, registering the memory
> region with the SysBusDevice API makes it show up in QMP's `info qom-tree`
> command.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
> [balaton: rebased]
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> hw/pci-host/ppce500.c | 8 ++++----
> hw/ppc/e500.c         | 8 ++++----
> 2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
> index e97a515d5f..52269b05bb 100644
> --- a/hw/pci-host/ppce500.c
> +++ b/hw/pci-host/ppce500.c
> @@ -16,7 +16,6 @@
>
> #include "qemu/osdep.h"
> #include "hw/irq.h"
> -#include "hw/ppc/e500-ccsr.h"
> #include "hw/qdev-properties.h"
> #include "migration/vmstate.h"
> #include "hw/pci/pci_device.h"
> @@ -418,11 +417,12 @@ static const VMStateDescription vmstate_ppce500_pci = {
> static void e500_pcihost_bridge_realize(PCIDevice *d, Error **errp)
> {
>     PPCE500PCIBridgeState *b = PPC_E500_PCI_BRIDGE(d);
> -    PPCE500CCSRState *ccsr = CCSR(
> +    SysBusDevice *ccsr = SYS_BUS_DEVICE(
>         object_resolve_path_component(qdev_get_machine(), "e500-ccsr"));
> +    MemoryRegion *ccsr_space = sysbus_mmio_get_region(ccsr, 0);
>
> -    memory_region_init_alias(&b->bar0, OBJECT(ccsr), "e500-pci-bar0", &ccsr->ccsr_space,
> -                             0, int128_get64(ccsr->ccsr_space.size));
> +    memory_region_init_alias(&b->bar0, OBJECT(ccsr), "e500-pci-bar0",
> +                             ccsr_space, 0, int128_get64(ccsr_space->size));
>     pci_register_bar(d, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &b->bar0);
> }
>
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index dedd96b057..6899802bed 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -931,7 +931,6 @@ void ppce500_init(MachineState *machine)
>     CPUPPCState *firstenv = NULL;
>     MemoryRegion *ccsr_addr_space;
>     SysBusDevice *s;
> -    PPCE500CCSRState *ccsr;
>     I2CBus *i2c;
>
>     irqs = g_new0(IrqLines, smp_cpus);
> @@ -993,10 +992,10 @@ void ppce500_init(MachineState *machine)
>     memory_region_add_subregion(address_space_mem, 0, machine->ram);
>
>     dev = qdev_new("e500-ccsr");
> +    s = SYS_BUS_DEVICE(dev);
>     object_property_add_child(OBJECT(machine), "e500-ccsr", OBJECT(dev));
> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> -    ccsr = CCSR(dev);
> -    ccsr_addr_space = &ccsr->ccsr_space;
> +    sysbus_realize_and_unref(s, &error_fatal);
> +    ccsr_addr_space = sysbus_mmio_get_region(s, 0);
>     memory_region_add_subregion(address_space_mem, pmc->ccsrbar_base,
>                                 ccsr_addr_space);
>
> @@ -1284,6 +1283,7 @@ static void e500_ccsr_initfn(Object *obj)
>     PPCE500CCSRState *ccsr = CCSR(obj);
>     memory_region_init(&ccsr->ccsr_space, obj, "e500-ccsr",
>                        MPC8544_CCSRBAR_SIZE);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(ccsr), &ccsr->ccsr_space);
> }
>
> static const TypeInfo e500_ccsr_info = {
>


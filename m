Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994A0C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 18:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc8QU-0001Py-LQ; Mon, 19 Feb 2024 13:31:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rc8Q9-0001NY-EK
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 13:31:25 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rc8Q6-0007et-Aq
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 13:31:16 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DDAE84E6006;
 Mon, 19 Feb 2024 19:31:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id iyE62chT7ybT; Mon, 19 Feb 2024 19:31:06 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DE0B04E6003; Mon, 19 Feb 2024 19:31:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DC7817456B4;
 Mon, 19 Feb 2024 19:31:06 +0100 (CET)
Date: Mon, 19 Feb 2024 19:31:06 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Igor Mammedov <imammedo@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 09/14] hw/southbridge/ich9: Add a AHCI function
In-Reply-To: <20240219163855.87326-10-philmd@linaro.org>
Message-ID: <6cf6d2f4-5f24-fcb9-16c4-ab66d7b5e724@eik.bme.hu>
References: <20240219163855.87326-1-philmd@linaro.org>
 <20240219163855.87326-10-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1783725181-1708367466=:53903"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1783725181-1708367466=:53903
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 19 Feb 2024, Philippe Mathieu-Daudé wrote:
> Instantiate TYPE_ICH9_AHCI in TYPE_ICH9_SOUTHBRIDGE.
>
> Since the PC machines can disable SATA (see the
> PC_MACHINE_SATA dynamic property), add the 'sata-enabled'
> property to disable it.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> MAINTAINERS                   |  2 ++
> include/hw/southbridge/ich9.h |  4 ----
> hw/i386/pc_q35.c              | 25 ++++---------------------
> hw/southbridge/ich9.c         | 35 +++++++++++++++++++++++++++++++++++
> hw/i386/Kconfig               |  1 -
> hw/southbridge/Kconfig        |  1 +
> 6 files changed, 42 insertions(+), 26 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d1a2eddd4c..937ebb5c96 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2607,9 +2607,11 @@ M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> S: Supported
> F: hw/acpi/ich9*.c
> F: hw/i2c/smbus_ich9.c
> +F: hw/ide/ich.c
> F: hw/isa/lpc_ich9.c
> F: hw/southbridge/ich9.c
> F: include/hw/acpi/ich9*.h
> +F: include/hw/ide/ahci-pci.h
> F: include/hw/pci-bridge/ich_dmi_pci.h
> F: include/hw/southbridge/ich9.h
>
> diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
> index b9122d299d..ac7f9f4ff5 100644
> --- a/include/hw/southbridge/ich9.h
> +++ b/include/hw/southbridge/ich9.h
> @@ -166,10 +166,6 @@ struct ICH9LPCState {
>
> #define ICH9_GPIO_GSI "gsi"
>
> -/* D31:F2 SATA Controller #1 */
> -#define ICH9_SATA1_DEV                          31
> -#define ICH9_SATA1_FUNC                         2
> -
> /* D31:F0 power management I/O registers
>    offset from the address ICH9_LPC_PMBASE */
>
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 2f15af540f..060358d449 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -61,9 +61,6 @@
> #include "hw/acpi/acpi.h"
> #include "target/i386/cpu.h"
>
> -/* ICH9 AHCI has 6 ports */
> -#define MAX_SATA_PORTS     6
> -
> struct ehci_companions {
>     const char *name;
>     int func;
> @@ -129,7 +126,7 @@ static void pc_q35_init(MachineState *machine)
>     PCIDevice *lpc;
>     Object *lpc_obj;
>     DeviceState *lpc_dev;
> -    BusState *idebus[MAX_SATA_PORTS];
> +    BusState *idebus[2] = { };
>     ISADevice *rtc_state;
>     MemoryRegion *system_memory = get_system_memory();
>     MemoryRegion *system_io = get_system_io();
> @@ -138,7 +135,6 @@ static void pc_q35_init(MachineState *machine)
>     ISABus *isa_bus;
>     int i;
>     ram_addr_t lowmem;
> -    DriveInfo *hd[MAX_SATA_PORTS];
>     MachineClass *mc = MACHINE_GET_CLASS(machine);
>     bool acpi_pcihp;
>     bool keep_pci_slot_hpc;
> @@ -239,6 +235,7 @@ static void pc_q35_init(MachineState *machine)
>     object_property_set_link(OBJECT(ich9), "mch-pcie-bus",
>                              OBJECT(host_bus), &error_abort);
>     qdev_prop_set_bit(ich9, "d2p-enabled", false);
> +    qdev_prop_set_bit(ich9, "sata-enabled", pcms->sata_enabled);
>     qdev_realize_and_unref(ich9, NULL, &error_fatal);
>
>     /* irq lines */
> @@ -302,22 +299,8 @@ static void pc_q35_init(MachineState *machine)
>                          0xff0104);
>
>     if (pcms->sata_enabled) {

Shouldn't this condition be inverted if you only leave the else leg?

Regards,.
BALATON Zoltan

> -        PCIDevice *pdev;
> -        AHCIPCIState *ich9;
> -
> -        /* ahci and SATA device, for q35 1 ahci controller is built-in */
> -        pdev = pci_create_simple_multifunction(host_bus,
> -                                               PCI_DEVFN(ICH9_SATA1_DEV,
> -                                                         ICH9_SATA1_FUNC),
> -                                               "ich9-ahci");
> -        ich9 = ICH9_AHCI(pdev);
> -        idebus[0] = qdev_get_child_bus(DEVICE(pdev), "ide.0");
> -        idebus[1] = qdev_get_child_bus(DEVICE(pdev), "ide.1");
> -        g_assert(MAX_SATA_PORTS == ich9->ahci.ports);
> -        ide_drive_get(hd, ich9->ahci.ports);
> -        ahci_ide_create_devs(&ich9->ahci, hd);
> -    } else {
> -        idebus[0] = idebus[1] = NULL;
> +        idebus[0] = qdev_get_child_bus(ich9, "ide.0");
> +        idebus[1] = qdev_get_child_bus(ich9, "ide.1");
>     }
>
>     if (machine_usb(machine)) {
> diff --git a/hw/southbridge/ich9.c b/hw/southbridge/ich9.c
> index 6df47e81fb..233dc1c5d7 100644
> --- a/hw/southbridge/ich9.c
> +++ b/hw/southbridge/ich9.c
> @@ -13,22 +13,30 @@
> #include "hw/southbridge/ich9.h"
> #include "hw/pci/pci.h"
> #include "hw/pci-bridge/ich_dmi_pci.h"
> +#include "hw/ide/ahci-pci.h"
> +#include "hw/ide.h"
>
> #define ICH9_D2P_DEVFN          PCI_DEVFN(30, 0)
> +#define ICH9_SATA1_DEVFN        PCI_DEVFN(31, 2)
> +
> +#define SATA_PORTS              6
>
> struct ICH9State {
>     DeviceState parent_obj;
>
>     I82801b11Bridge d2p;
> +    AHCIPCIState sata0;
>
>     PCIBus *pci_bus;
>     bool d2p_enabled;
> +    bool sata_enabled;
> };
>
> static Property ich9_props[] = {
>     DEFINE_PROP_LINK("mch-pcie-bus", ICH9State, pci_bus,
>                      TYPE_PCIE_BUS, PCIBus *),
>     DEFINE_PROP_BOOL("d2p-enabled", ICH9State, d2p_enabled, true),
> +    DEFINE_PROP_BOOL("sata-enabled", ICH9State, sata_enabled, true),
>     DEFINE_PROP_END_OF_LIST(),
> };
>
> @@ -48,6 +56,29 @@ static bool ich9_realize_d2p(ICH9State *s, Error **errp)
>     return true;
> }
>
> +static bool ich9_realize_sata(ICH9State *s, Error **errp)
> +{
> +    DriveInfo *hd[SATA_PORTS];
> +
> +    object_initialize_child(OBJECT(s), "sata[0]", &s->sata0, TYPE_ICH9_AHCI);
> +    qdev_prop_set_int32(DEVICE(&s->sata0), "addr", ICH9_SATA1_DEVFN);
> +    if (!qdev_realize(DEVICE(&s->sata0), BUS(s->pci_bus), errp)) {
> +        return false;
> +    }
> +    for (unsigned i = 0; i < SATA_PORTS; i++) {
> +        g_autofree char *portname = g_strdup_printf("ide.%u", i);
> +
> +        object_property_add_alias(OBJECT(s), portname,
> +                                  OBJECT(&s->sata0), portname);
> +    }
> +
> +    g_assert(SATA_PORTS == s->sata0.ahci.ports);
> +    ide_drive_get(hd, s->sata0.ahci.ports);
> +    ahci_ide_create_devs(&s->sata0.ahci, hd);
> +
> +    return true;
> +}
> +
> static void ich9_init(Object *obj)
> {
> }
> @@ -64,6 +95,10 @@ static void ich9_realize(DeviceState *dev, Error **errp)
>     if (s->d2p_enabled && !ich9_realize_d2p(s, errp)) {
>         return;
>     }
> +
> +    if (s->sata_enabled && !ich9_realize_sata(s, errp)) {
> +        return;
> +    }
> }
>
> static void ich9_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index d21638f4f9..226d7f6916 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -101,7 +101,6 @@ config Q35
>     select PCI_EXPRESS_Q35
>     select ICH9
>     select LPC_ICH9
> -    select AHCI_ICH9
>     select DIMM
>     select SMBIOS
>     select FW_CFG_DMA
> diff --git a/hw/southbridge/Kconfig b/hw/southbridge/Kconfig
> index db7259bf6f..f806033d48 100644
> --- a/hw/southbridge/Kconfig
> +++ b/hw/southbridge/Kconfig
> @@ -4,3 +4,4 @@ config ICH9
>     bool
>     depends on PCI_EXPRESS
>     imply I82801B11
> +    select AHCI_ICH9
>
--3866299591-1783725181-1708367466=:53903--


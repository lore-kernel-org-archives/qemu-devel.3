Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9898C54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 13:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reacX-0007M7-KR; Mon, 26 Feb 2024 08:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1reacW-0007LQ-32; Mon, 26 Feb 2024 08:02:12 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1reacQ-0005Tz-45; Mon, 26 Feb 2024 08:02:11 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 535EF4E601F;
 Mon, 26 Feb 2024 14:02:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 9t60Q0hnXzp1; Mon, 26 Feb 2024 14:01:59 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 41FD04E601E; Mon, 26 Feb 2024 14:01:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3FDBE7456B4;
 Mon, 26 Feb 2024 14:01:59 +0100 (CET)
Date: Mon, 26 Feb 2024 14:01:59 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>, 
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, qemu-block@nongnu.org, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Eduardo Habkost <eduardo@habkost.net>, John Snow <jsnow@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v2 08/15] hw/pci-bridge: Extract QOM ICH definitions to
 'ich9_dmi.h'
In-Reply-To: <20240226111416.39217-9-philmd@linaro.org>
Message-ID: <5bab87f9-aeee-3aa5-d695-4fa2128130a1@eik.bme.hu>
References: <20240226111416.39217-1-philmd@linaro.org>
 <20240226111416.39217-9-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1028664770-1708952519=:37179"
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

--3866299591-1028664770-1708952519=:37179
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 26 Feb 2024, Philippe Mathieu-Daudé wrote:
> Expose TYPE_ICH_DMI_PCI_BRIDGE to the new
> "hw/pci-bridge/ich9_dmi.h" header.

Since this is effectively an empty object (that's not even instantiated by 
default) I still think that instead of adding even more files for it all 
this could just be moved to hw/isa/lpc_ich9.c and define there as an 
internal object and drop the OBJECT_DECLARE_SIMPLE_TYPE(I82801b11Bridge, 
ICH_DMI_PCI_BRIDGE) and just use the size of the superclass as it's 
instance size. That just adds the realize function and a type definition 
and gets rid of boilerplate scattered around the source tree which just 
adds complexity for no reason. But I don't care too much about it, just 
wanted to say again that if something can be kept simple I'd prefer that 
over making it more complex and for this device it looks already too 
complex for what it does or used for.

Regards,
BALATON Zoltan

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> MAINTAINERS                               |  1 +
> include/hw/pci-bridge/ich9_dmi.h          | 20 ++++++++++++++++++++
> include/hw/southbridge/ich9.h             |  2 --
> hw/pci-bridge/{i82801b11.c => ich9_dmi.c} | 11 ++++-------
> hw/pci-bridge/meson.build                 |  2 +-
> 5 files changed, 26 insertions(+), 10 deletions(-)
> create mode 100644 include/hw/pci-bridge/ich9_dmi.h
> rename hw/pci-bridge/{i82801b11.c => ich9_dmi.c} (95%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0849283287..52282c680e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2618,6 +2618,7 @@ F: hw/i2c/smbus_ich9.c
> F: hw/isa/lpc_ich9.c
> F: include/hw/acpi/ich9*.h
> F: include/hw/i2c/ich9_smbus.h
> +F: include/hw/pci-bridge/ich9_dmi.h
> F: include/hw/southbridge/ich9.h
>
> PIIX4 South Bridge (i82371AB)
> diff --git a/include/hw/pci-bridge/ich9_dmi.h b/include/hw/pci-bridge/ich9_dmi.h
> new file mode 100644
> index 0000000000..7cf5d9d9b2
> --- /dev/null
> +++ b/include/hw/pci-bridge/ich9_dmi.h
> @@ -0,0 +1,20 @@
> +/*
> + * QEMU ICH4 i82801b11 dmi-to-pci Bridge Emulation
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_PCI_BRIDGE_ICH9_DMI_H
> +#define HW_PCI_BRIDGE_ICH9_DMI_H
> +
> +#include "qom/object.h"
> +#include "hw/pci/pci_bridge.h"
> +
> +#define TYPE_ICH_DMI_PCI_BRIDGE "i82801b11-bridge"
> +OBJECT_DECLARE_SIMPLE_TYPE(I82801b11Bridge, ICH_DMI_PCI_BRIDGE)
> +
> +struct I82801b11Bridge {
> +    PCIBridge parent_obj;
> +};
> +
> +#endif
> diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
> index bee522a4cf..b2abf483e0 100644
> --- a/include/hw/southbridge/ich9.h
> +++ b/include/hw/southbridge/ich9.h
> @@ -114,8 +114,6 @@ struct ICH9LPCState {
>
> #define ICH9_D2P_SECONDARY_DEFAULT              (256 - 8)
>
> -#define ICH9_D2P_A2_REVISION                    0x92
> -
> /* D31:F0 LPC Processor Interface */
> #define ICH9_RST_CNT_IOPORT                     0xCF9
>
> diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/ich9_dmi.c
> similarity index 95%
> rename from hw/pci-bridge/i82801b11.c
> rename to hw/pci-bridge/ich9_dmi.c
> index c140919cbc..927e48bf2e 100644
> --- a/hw/pci-bridge/i82801b11.c
> +++ b/hw/pci-bridge/ich9_dmi.c
> @@ -45,7 +45,7 @@
> #include "hw/pci/pci_bridge.h"
> #include "migration/vmstate.h"
> #include "qemu/module.h"
> -#include "hw/southbridge/ich9.h"
> +#include "hw/pci-bridge/ich9_dmi.h"
>
> /*****************************************************************************/
> /* ICH9 DMI-to-PCI bridge */
> @@ -53,11 +53,8 @@
> #define I82801ba_SSVID_SVID     0
> #define I82801ba_SSVID_SSID     0
>
> -typedef struct I82801b11Bridge {
> -    /*< private >*/
> -    PCIBridge parent_obj;
> -    /*< public >*/
> -} I82801b11Bridge;
> +
> +#define ICH9_D2P_A2_REVISION                    0x92
>
> static void i82801b11_bridge_realize(PCIDevice *d, Error **errp)
> {
> @@ -103,7 +100,7 @@ static void i82801b11_bridge_class_init(ObjectClass *klass, void *data)
> }
>
> static const TypeInfo i82801b11_bridge_info = {
> -    .name          = "i82801b11-bridge",
> +    .name          = TYPE_ICH_DMI_PCI_BRIDGE,
>     .parent        = TYPE_PCI_BRIDGE,
>     .instance_size = sizeof(I82801b11Bridge),
>     .class_init    = i82801b11_bridge_class_init,
> diff --git a/hw/pci-bridge/meson.build b/hw/pci-bridge/meson.build
> index f2a60434dd..d746487193 100644
> --- a/hw/pci-bridge/meson.build
> +++ b/hw/pci-bridge/meson.build
> @@ -1,6 +1,6 @@
> pci_ss = ss.source_set()
> pci_ss.add(files('pci_bridge_dev.c'))
> -pci_ss.add(when: 'CONFIG_I82801B11', if_true: files('i82801b11.c'))
> +pci_ss.add(when: 'CONFIG_I82801B11', if_true: files('ich9_dmi.c'))
> pci_ss.add(when: 'CONFIG_IOH3420', if_true: files('ioh3420.c'))
> pci_ss.add(when: 'CONFIG_PCIE_PORT', if_true: files('pcie_root_port.c', 'gen_pcie_root_port.c'))
> pci_ss.add(when: 'CONFIG_PCIE_PCI_BRIDGE', if_true: files('pcie_pci_bridge.c'))
>
--3866299591-1028664770-1708952519=:37179--


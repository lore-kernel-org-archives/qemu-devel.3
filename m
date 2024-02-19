Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AA0C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 18:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc8Ju-0006Ol-7Q; Mon, 19 Feb 2024 13:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rc8Jr-0006OZ-TE
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 13:24:48 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rc8Jp-0006JX-4F
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 13:24:47 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 578254E6006;
 Mon, 19 Feb 2024 19:24:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 0eioVlDl-jRh; Mon, 19 Feb 2024 19:24:40 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 584A74E6003; Mon, 19 Feb 2024 19:24:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5635D7456B4;
 Mon, 19 Feb 2024 19:24:40 +0100 (CET)
Date: Mon, 19 Feb 2024 19:24:40 +0100 (CET)
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
Subject: Re: [PATCH 06/14] hw/pci-bridge: Extract QOM ICH definitions to
 'ich_dmi_pci.h'
In-Reply-To: <0841e333-3d7d-0440-a8bf-8a7fd2f0011f@eik.bme.hu>
Message-ID: <19500c79-8e4a-2160-3622-dbf145655046@eik.bme.hu>
References: <20240219163855.87326-1-philmd@linaro.org>
 <20240219163855.87326-7-philmd@linaro.org>
 <0841e333-3d7d-0440-a8bf-8a7fd2f0011f@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1030663560-1708367080=:53903"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

--3866299591-1030663560-1708367080=:53903
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 19 Feb 2024, BALATON Zoltan wrote:
> On Mon, 19 Feb 2024, Philippe Mathieu-Daudé wrote:
>> Expose TYPE_ICH_DMI_PCI_BRIDGE to the new
>> "hw/pci-bridge/ich_dmi_pci.h" header.
>> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> MAINTAINERS                         |  1 +
>> include/hw/pci-bridge/ich_dmi_pci.h | 20 ++++++++++++++++++++
>> include/hw/southbridge/ich9.h       |  2 --
>> hw/pci-bridge/i82801b11.c           | 11 ++++-------
>> 4 files changed, 25 insertions(+), 9 deletions(-)
>> create mode 100644 include/hw/pci-bridge/ich_dmi_pci.h
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 1b210c5cc1..50507c3dd6 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2609,6 +2609,7 @@ F: hw/acpi/ich9*.c
>> F: hw/i2c/smbus_ich9.c
>> F: hw/isa/lpc_ich9.c
>> F: include/hw/acpi/ich9*.h
>> +F: include/hw/pci-bridge/ich_dmi_pci.h
>> F: include/hw/southbridge/ich9.h
>> 
>> PIIX4 South Bridge (i82371AB)
>> diff --git a/include/hw/pci-bridge/ich_dmi_pci.h 
>> b/include/hw/pci-bridge/ich_dmi_pci.h
>> new file mode 100644
>> index 0000000000..7623b32b8e
>> --- /dev/null
>> +++ b/include/hw/pci-bridge/ich_dmi_pci.h
>> @@ -0,0 +1,20 @@
>> +/*
>> + * QEMU ICH4 i82801b11 dmi-to-pci Bridge Emulation
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef HW_PCI_BRIDGE_ICH_D2P_H
>> +#define HW_PCI_BRIDGE_ICH_D2P_H
>> +
>> +#include "qom/object.h"
>> +#include "hw/pci/pci_bridge.h"
>> +
>> +#define TYPE_ICH_DMI_PCI_BRIDGE "i82801b11-bridge"
>> +OBJECT_DECLARE_SIMPLE_TYPE(I82801b11Bridge, ICH_DMI_PCI_BRIDGE)
>> +
>> +struct I82801b11Bridge {
>> +    PCIBridge parent_obj;
>> +};
>
> If this class has no fields of its own why does it need its own state struct 
> defined? You could just set .instance_size = sizeof(PCIBridge) in the 
> TypeInfo i82801b11_bridge_info below and delete this struct completely as 
> it's not even used anywhere. One less needless QOM complication :-) For an 
> example see the empty via-mc97 device in hw/audio/via-ac97.c.
>
> Then you can put the OBJECT_DECLARE_SIMPLE_TYPE in hw/pci-bridge/i82801b11.c 
> where this object is defined and the #define TYPE_ICH_DMI_PCI_BRIDGE in

You don't even need OBJECT_DECLARE_SIMPLE_TYPE if there's no state struct. 
But on second look what is this object at all? It's never instantiated 
anywhere. Is it used somewhere?

Regards,
BALATON Zoltan

> hw/southbridge/ich9.h and then you don't need this header at all so you don't 
> end up with:
>
> 4 files changed, 25 insertions(+), 9 deletions(-)
>
> but really simplifying it.
>
> Regards,
> BALATON Zoltan
>
>> +
>> +#endif
>> diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
>> index bee522a4cf..b2abf483e0 100644
>> --- a/include/hw/southbridge/ich9.h
>> +++ b/include/hw/southbridge/ich9.h
>> @@ -114,8 +114,6 @@ struct ICH9LPCState {
>> 
>> #define ICH9_D2P_SECONDARY_DEFAULT              (256 - 8)
>> 
>> -#define ICH9_D2P_A2_REVISION                    0x92
>> -
>> /* D31:F0 LPC Processor Interface */
>> #define ICH9_RST_CNT_IOPORT                     0xCF9
>> 
>> diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
>> index c140919cbc..dd17e35b0a 100644
>> --- a/hw/pci-bridge/i82801b11.c
>> +++ b/hw/pci-bridge/i82801b11.c
>> @@ -45,7 +45,7 @@
>> #include "hw/pci/pci_bridge.h"
>> #include "migration/vmstate.h"
>> #include "qemu/module.h"
>> -#include "hw/southbridge/ich9.h"
>> +#include "hw/pci-bridge/ich_dmi_pci.h"
>> 
>> /*****************************************************************************/
>> /* ICH9 DMI-to-PCI bridge */
>> @@ -53,11 +53,8 @@
>> #define I82801ba_SSVID_SVID     0
>> #define I82801ba_SSVID_SSID     0
>> 
>> -typedef struct I82801b11Bridge {
>> -    /*< private >*/
>> -    PCIBridge parent_obj;
>> -    /*< public >*/
>> -} I82801b11Bridge;
>> +
>> +#define ICH9_D2P_A2_REVISION                    0x92
>> 
>> static void i82801b11_bridge_realize(PCIDevice *d, Error **errp)
>> {
>> @@ -103,7 +100,7 @@ static void i82801b11_bridge_class_init(ObjectClass 
>> *klass, void *data)
>> }
>> 
>> static const TypeInfo i82801b11_bridge_info = {
>> -    .name          = "i82801b11-bridge",
>> +    .name          = TYPE_ICH_DMI_PCI_BRIDGE,
>>     .parent        = TYPE_PCI_BRIDGE,
>>     .instance_size = sizeof(I82801b11Bridge),
>>     .class_init    = i82801b11_bridge_class_init,
>
--3866299591-1030663560-1708367080=:53903--


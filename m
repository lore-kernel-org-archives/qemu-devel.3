Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346EACCD195
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 23:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAcne-0005B1-M6; Sun, 19 Oct 2025 19:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vAcnc-0005Ag-Lh; Sun, 19 Oct 2025 19:26:52 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vAcna-0000bz-5W; Sun, 19 Oct 2025 19:26:52 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 608A359703F;
 Mon, 20 Oct 2025 01:26:44 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 36DITYluydic; Mon, 20 Oct 2025 01:26:42 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 043FB5972E1; Mon, 20 Oct 2025 01:26:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 01EFE5972F4;
 Mon, 20 Oct 2025 01:26:41 +0200 (CEST)
Date: Mon, 20 Oct 2025 01:26:41 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 01/14] hw/pci-host/raven: Simplify PCI facing part
In-Reply-To: <b83b904c-6dcc-4b4f-afc0-499ffafca15c@ilande.co.uk>
Message-ID: <818e8c63-9ef1-c2f5-6a85-7ef37a80d44b@eik.bme.hu>
References: <cover.1758219840.git.balaton@eik.bme.hu>
 <ebfd5b64421e8a876c5a6e2ce3dc871de500b69d.1758219840.git.balaton@eik.bme.hu>
 <b5db600a-3278-427d-9f67-b222cb0c1bd1@ilande.co.uk>
 <db65a6dd-cfdf-18b8-1764-8a1d7d3fcc24@eik.bme.hu>
 <a95fed21-de1c-4dc8-a776-a6a2acd4b7d3@linux.ibm.com>
 <b83b904c-6dcc-4b4f-afc0-499ffafca15c@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-837372825-1760916402=:79527"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-837372825-1760916402=:79527
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sun, 19 Oct 2025, Mark Cave-Ayland wrote:
> On 18/10/2025 03:41, Harsh Prateek Bora wrote:
>> Hi Mark,
>> 
>> Thanks much for pitching in to help with reviewing this series.
>
> Hi Harsh,
>
> No worries - I've looked at raven before when working on adding 40p support 
> for OpenBIOS, so I do have some familiarity.
>
>> On 9/19/25 01:51, BALATON Zoltan wrote:
>>> On Thu, 18 Sep 2025, Mark Cave-Ayland wrote:
>>>> On 18/09/2025 19:50, BALATON Zoltan wrote:
>>>>> The raven PCI device does not need a state struct as it has no data to
>>>>> store there any more, so we can remove that to simplify code.
>>>>> 
>>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>>> ---
>>>>>   hw/pci-host/raven.c | 30 +-----------------------------
>>>>>   1 file changed, 1 insertion(+), 29 deletions(-)
>>>>> 
>>>>> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
>>>>> index f8c0be5d21..172f01694c 100644
>>>>> --- a/hw/pci-host/raven.c
>>>>> +++ b/hw/pci-host/raven.c
>>>>> @@ -31,7 +31,6 @@
>>>>>   #include "hw/pci/pci_bus.h"
>>>>>   #include "hw/pci/pci_host.h"
>>>>>   #include "hw/qdev-properties.h"
>>>>> -#include "migration/vmstate.h"
>>>>>   #include "hw/intc/i8259.h"
>>>>>   #include "hw/irq.h"
>>>>>   #include "hw/or-irq.h"
>>>>> @@ -40,12 +39,6 @@
>>>>>   #define TYPE_RAVEN_PCI_DEVICE "raven"
>>>>>   #define TYPE_RAVEN_PCI_HOST_BRIDGE "raven-pcihost"
>>>>>   -OBJECT_DECLARE_SIMPLE_TYPE(RavenPCIState, RAVEN_PCI_DEVICE)
>>>>> -
>>>>> -struct RavenPCIState {
>>>>> -    PCIDevice dev;
>>>>> -};
>>>>> -
>>>>>   typedef struct PRePPCIState PREPPCIState;
>>>>>   DECLARE_INSTANCE_CHECKER(PREPPCIState, RAVEN_PCI_HOST_BRIDGE,
>>>>>                            TYPE_RAVEN_PCI_HOST_BRIDGE)
>>>>> @@ -65,7 +58,6 @@ struct PRePPCIState {
>>>>>       MemoryRegion bm_ram_alias;
>>>>>       MemoryRegion bm_pci_memory_alias;
>>>>>       AddressSpace bm_as;
>>>>> -    RavenPCIState pci_dev;
>>>>>         int contiguous_map;
>>>>>   };
>>>>> @@ -268,8 +260,7 @@ static void raven_pcihost_realizefn(DeviceState *d, 
>>>>> Error **errp)
>>>>>                             "pci-intack", 1);
>>>>>       memory_region_add_subregion(address_space_mem, 0xbffffff0, 
>>>>> &s->pci_intack);
>>>>>   -    /* TODO Remove once realize propagates to child devices. */
>>>>> -    qdev_realize(DEVICE(&s->pci_dev), BUS(&s->pci_bus), errp);
>>>>> +    pci_create_simple(&s->pci_bus, PCI_DEVFN(0, 0), 
>>>>> TYPE_RAVEN_PCI_DEVICE);
>>>>>   }
>> 
>> <snip>
>> 
>>>>> @@ -361,7 +334,6 @@ static void raven_class_init(ObjectClass *klass, 
>>>>> const void *data)
>>>>>   static const TypeInfo raven_info = {
>>>>>       .name = TYPE_RAVEN_PCI_DEVICE,
>>>>>       .parent = TYPE_PCI_DEVICE,
>>>>> -    .instance_size = sizeof(RavenPCIState),
>>>>>       .class_init = raven_class_init,
>>>>>       .interfaces = (const InterfaceInfo[]) {
>>>>>           { INTERFACE_CONVENTIONAL_PCI_DEVICE },
>>>> 
>>>> I agree with removing RavenPCIState, but pci_create_simple() isn't the 
>>>> right solution here because it both init()s and realize()s the inner 
>>>> object. The right way to do this is for the parent to init() its inner 
>>>> object(s) within its init() function, and similarly for it to realize() 
>>>> its inner object(s) within its realize() function.
>>>> 
>>>> FWIW it looks as if the same mistake is present in several other 
>>>> hw/pci-host devices.
>>> 
>>> So maybe that's not a mistake then. There's no need to init and realize it 
>>> separately as this is an internal object which is enough to be created in 
>>> realize method and init and realize there at one go for which 
>>> pci_create_simple is appropriate. I think this inner object would only 
>>> need to be init separately if it exposed something (like a property) that 
>>> could be inspected or set before realize but that's not the case here so 
>>> it does not have to be created in init only in realize. (A lot of simple 
>>> devices don't even have init method only realize so init is only needed 
>>> for things that have to be set before realize.)
>> 
>> Do we have a consensus here ?
>> 
>> regards,
>> Harsh
> Given there is still some ongoing discussion regarding object modelling, I 
> think this will require a separate tidy-up so let's go with the 
> pci_create_simple() approach for now.
>
> The changes to the interrupt routing and readability of some of the changes 
> from a developer's perspective are still of concern to me.

I think simpler is more readable so not having an or-irq object where not 
needed as the PCI code can handle this makes it more readable (also the 
same as ppc440_pcix which was previously approved by Peter[1] and a patch 
to add or-irq there was dropped as unneeded[2] so doing the same thing the 
same way here is also more readable and more consistent). Thus I think the 
interrupt routing changes should be OK and having an or-irq is an 
unneeded complication.

What other readablility concerns do you have? Is it about not passing the 
whole device state struct to callbacks but only what they need from it? 
I've answered that already and I think that unnecessary casts would not 
add any readablility. I'd like to hear others' opinion too but it seems 
not many care so it's only us and we both seem to have strong view on 
these things so it's hard to come to an agreement.

Regards,
BALATON Zoltan

[1] commit 2a9cf49598c65 and 
https://lists.nongnu.org/archive/html/qemu-ppc/2021-01/msg00031.html

[2] https://lists.nongnu.org/archive/html/qemu-ppc/2020-12/msg00422.html 
https://lists.nongnu.org/archive/html/qemu-ppc/2020-12/msg00423.html
--3866299591-837372825-1760916402=:79527--


Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D10606A885
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=YLWKB0sE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRS32-0000LS-25; Thu, 12 Nov 2026 05:28:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xRS2z-0000K2-9v
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 05:28:49 -0500
Received: from smtpout7.mo538.mail-out.ovh.net ([51.210.91.36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xRS2w-0003DB-Cr
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 05:28:49 -0500
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [79.137.60.226])
 by mo538.mail-out.ovh.net (Postfix) with ESMTPS id 4jQGnb4g5Sz6FGd;
 Thu, 12 Nov 2026 10:28:35 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 10:28:35 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.54.122])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jQGnb2Qcpz46dN; Thu, 12 Nov 2026 10:28:35 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.2])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id BC8CF204316; 
 Thu, 12 Nov 2026 10:28:34 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R00193d0ce99-d898-42c1-bf85-aaadad20b57e,
 9FCD2E849CC7F977B1057F3A509A178403275A03) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <4037a4af-1b56-4cdf-a3c2-09baf51b4641@kaod.org>
Date: Thu, 12 Nov 2026 11:28:34 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-12.0 v2] pcie: Model DLLLA transitions on Secondary
 Bus Reset
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>
References: <20261110060205.1147027-1-clg@redhat.com>
 <20261111074653-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20261111074653-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 10723915140929924259
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEIispU1nOUO/+nloWPfcAMkFYDgHb8nWbYfgrXTasb2MUtUa26mLc/rURkSvhg5Nj7V7U6MHnuFbjIMqZ+3ISOLevCBChVNfgFwzVsB/xPJeZw60EHlJtr9qAWhdIGdVLctPZp6pM/zdxGfaR/vJfFR2EIOC10/HqCgWApYXrk6eIvo8zpYzdqauQu2voLsoT4aaHx9VSmeFX16pACsYjlqOgS2ZCGXpt2SW5lYGOhDgxv1pyxViPiUAxBjy3xpOVFYK7Cq7ODniKo6suAzWVe8RborUU5APZ1uts6gJbsC94iIaFmfAwFzinjOQvWRVV2zE2wsVnytnK1uixAPxBbHbfg3TDrUN/4eAeav1d78AhDNj60PJjznD4odhxxZDrTv59qjsNZEvtOaHeztzb5zoirzURVy5nZvbZANxwpVAR4QgLY6Q3P+YfMNjXLo3wT3X1twBBpMWQHSQIidhP+eOdhw2BeCTGujtRvxSGB8cVOXBsWcXvsFjdJCJwf4Pq9OJbWG4UvLFPsz+CjCwEmfmv2DGDeldAc4TrYthrfReKH2DW7r/+fQ+drYkbXZmQ5osV/6OSuiOc84jWszW1EdRpCGAYBWDDdVzdwY27w2r4glPf9x8CxOubnQV3E8Y7BRvG6Llp5F0hu8ePRUdbVInr0c8Oi5xKx16780Kf6oQ
DKIM-Signature: a=rsa-sha256; bh=fILy8CzKXSyBRDFVicOwKA775aQBCOJjxJuH3Dc0mi4=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1794479316; v=1;
 b=YLWKB0sEPL1n8cdv2OQhfGWOFmAXhpUPOv4LI+LzsAn3XD8Ua8EaWyy6Cs+eRzAlqE1Y6f+u
 LQTr4eFiDlsVgmhAgnReRqN5zt6DRAlrYkt5QwrgFEdvq1WjxjhAJ2cYuq4+ey9M52vNWtix16k
 cYwVtMjeNdABAyZ++AacPuGfsTdi8zdzRK4eOhe1PHMojurBgPni9OyEd1fL9002qlDb06RD9rO
 49oBm7hMLCMtmT1zejs71bMfJ+ALRedftTnYXGQ2/EoO6CLK6Q49+Y4kru4kXrLjekm8LQSXbac
 UJo/18uxQ1VOKWA4viLw43aw+ClZQhx0Pe0gJ7KEk050A==
Received-SPF: pass client-ip=51.210.91.36; envelope-from=clg@kaod.org;
 helo=smtpout7.mo538.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/26 13:48, Michael S. Tsirkin wrote:
> On Tue, Nov 10, 2026 at 07:02:04AM +0100, Cédric Le Goater wrote:
>> Per PCIe r6.5 sec 6.6.1 and 7.5.3.8, setting the Secondary Bus Reset
>> bit on a downstream port drives the Data Link Layer to DL_Down,
>> clearing the Data Link Layer Link Active bit (DLLLA). On de-assertion
>> the link retrains and DLLLA is re-asserted.
>>
>> Currently DLLLA is only managed during plug/unplug events, so a
>> guest sees stale DLLLA=1 while SBR is in progress.
>>
>> Handle both SBR transitions in pci_bridge_write_config(), the common
>> config write path for all bridge types, guarded by
>> pci_is_express_downstream_port(). Also restore DLLLA in
>> pcie_cap_slot_reset() so that a system reset while SBR is asserted
>> does not leave DLLLA stuck at 0.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   include/hw/pci/pcie.h |  1 +
>>   hw/pci/pci_bridge.c   | 13 ++++++++++++-
>>   hw/pci/pcie.c         | 20 ++++++++++++++++++++
>>   3 files changed, 33 insertions(+), 1 deletion(-)
>>
>>   Changes in v2 :
>>
>>   - Introduced pcie_cap_update_slot_link() as suggested by Michael.
>>
>> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
>> index ec25e7a7de99..50fbbacb2200 100644
>> --- a/include/hw/pci/pcie.h
>> +++ b/include/hw/pci/pcie.h
>> @@ -112,6 +112,7 @@ void pcie_cap_slot_get(PCIDevice *dev, uint16_t *slt_ctl, uint16_t *slt_sta);
>>   void pcie_cap_slot_write_config(PCIDevice *dev,
>>                                   uint16_t old_slt_ctl, uint16_t old_slt_sta,
>>                                   uint32_t addr, uint32_t val, int len);
>> +void pcie_cap_update_slot_link(PCIDevice *dev, uint16_t bctl);
>>   int pcie_cap_slot_post_load(void *opaque, int version_id);
>>   void pcie_cap_slot_push_attention_button(PCIDevice *dev);
>>   void pcie_cap_slot_enable_power(PCIDevice *dev);
>> diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
>> index e85932e41a92..a11cf2f20afa 100644
>> --- a/hw/pci/pci_bridge.c
>> +++ b/hw/pci/pci_bridge.c
>> @@ -33,6 +33,7 @@
>>   #include "qemu/units.h"
>>   #include "hw/pci/pci_bridge.h"
>>   #include "hw/pci/pci_bus.h"
>> +#include "hw/pci/pcie.h"
>>   #include "qemu/module.h"
>>   #include "qemu/range.h"
>>   #include "qapi/error.h"
>> @@ -274,9 +275,19 @@ void pci_bridge_write_config(PCIDevice *d,
>>   
>>       newctl = pci_get_word(d->config + PCI_BRIDGE_CONTROL);
>>       if (~oldctl & newctl & PCI_BRIDGE_CTL_BUS_RESET) {
>> -        /* Trigger hot reset on 0->1 transition. */
>> +        /* SBR assertion (0->1): bring link down, then reset devices. */
>> +        if (pci_is_express_downstream_port(d)) {
>> +            pcie_cap_update_slot_link(d, newctl);
>> +        }
>>           bus_cold_reset(BUS(&s->sec_bus));
>>       }
>> +
>> +    if (oldctl & ~newctl & PCI_BRIDGE_CTL_BUS_RESET) {
>> +        /* SBR de-assertion (1->0): bring link back up. */
>> +        if (pci_is_express_downstream_port(d)) {
>> +            pcie_cap_update_slot_link(d, newctl);
>> +        }
>> +    }
>>   }
>>   
>>   void pci_bridge_disable_base_limit(PCIDevice *dev)
> 
> 
> I'd rather call it once, unconditionally: it's idempotent.
> 
> Or if you really want:
> 	if ((oldctl ^ newctl) & PCI_BRIDGE_CTL_BUS_RESET)

yes. Looks better. How's that ?

@@ -273,6 +274,12 @@ void pci_bridge_write_config(PCIDevice *
      }
  
      newctl = pci_get_word(d->config + PCI_BRIDGE_CONTROL);
+    if ((oldctl ^ newctl) & PCI_BRIDGE_CTL_BUS_RESET) {
+        if (pci_is_express_downstream_port(d)) {
+            pcie_cap_update_slot_link(d, newctl);
+        }
+    }
+
      if (~oldctl & newctl & PCI_BRIDGE_CTL_BUS_RESET) {
          /* Trigger hot reset on 0->1 transition. */
          bus_cold_reset(BUS(&s->sec_bus));


C.

> 
> 
>> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
>> index bd00305ecca6..3b6dcd15aa44 100644
>> --- a/hw/pci/pcie.c
>> +++ b/hw/pci/pcie.c
>> @@ -803,6 +803,8 @@ void pcie_cap_slot_reset(PCIDevice *dev)
>>                                    PCI_EXP_SLTSTA_PDC |
>>                                    PCI_EXP_SLTSTA_ABP);
>>   
>> +    pcie_cap_update_slot_link(dev,
>> +                              pci_get_word(dev->config + PCI_BRIDGE_CONTROL));
>>       pcie_cap_update_power(dev);
>>       hotplug_event_update_event_status(dev);
>>   }
>> @@ -946,6 +948,24 @@ void pcie_cap_slot_push_attention_button(PCIDevice *dev)
>>       pcie_cap_slot_event(dev, PCI_EXP_HP_EV_ABP);
>>   }
>>   
>> +/*
>> + * Set DLLLA to reflect the actual link state: up iff a device is
>> + * present on the secondary bus and SBR is not asserted.
>> + */
>> +void pcie_cap_update_slot_link(PCIDevice *dev, uint16_t bctl)
>> +{
>> +    PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(dev));
>> +    uint8_t *exp_cap = dev->config + dev->exp.exp_cap;
>> +    uint32_t lnkcap = pci_get_long(exp_cap + PCI_EXP_LNKCAP);
>> +    bool link_up = sec_bus->devices[0] && !(bctl & PCI_BRIDGE_CTL_BUS_RESET);
>> +
>> +    if (dev->cap_present & QEMU_PCIE_LNKSTA_DLLLA ||
>> +        (lnkcap & PCI_EXP_LNKCAP_DLLLARC)) {
>> +        pci_set_word_by_mask(exp_cap + PCI_EXP_LNKSTA,
>> +                             PCI_EXP_LNKSTA_DLLLA, link_up);
>> +    }
>> +}
>> +
>>   /* root control/capabilities/status. PME isn't emulated for now */
>>   void pcie_cap_root_init(PCIDevice *dev)
>>   {
>> -- 
>> 2.56.0
> 



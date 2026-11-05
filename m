Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C426082BD2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOyui-0005od-62; Thu, 05 Nov 2026 09:58:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xOyuf-0005np-BN; Thu, 05 Nov 2026 09:58:01 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xOyuc-00054I-EW; Thu, 05 Nov 2026 09:58:01 -0500
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6A5EvOeq088172
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 5 Nov 2026 23:57:24 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=E1T2/BmMyuqmf5Ob4qtzeh9FgzWETosKMkE2Zur4e6Y=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1793890644; v=1;
 b=OBGYLOSNENPb9Ws/MMFYyhK2XludxTJjFoOS+mZyLmiqx/+19Psk13Fovq8/pGYi
 ukIKLT3/iDQjzsYO8/J7t7RQnBnHblgbjcrREHKaN+ESeP2s+cnL0DpoTd/krvQT
 M91C/L7xrcDL9uOPwVM9ygKNrSMcPLxxRnnaychjRljL3ythYaPNSb35oRIm0iEA
 j/dVj6OACK2s4eOZvdpz2di6t+UCzUKJJHQBYd6hFy6BgFuUgfTN3vUVU5yg2HnV
 lRpjKxxYOoI/M58ZmjeqIhMbG5nudIF3jmUrw1USud/s9zf6xxD5a6YRZuMaWe8h
 na1H07QbNbljr3quICUYYA==
Message-ID: <91b3e3a2-6006-412e-80e8-11044024e507@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 5 Nov 2026 23:57:23 +0900
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/10] qtest/libqos/pci: Enforce balanced iomap/unmap
To: Utkarsh Verma <uverma@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, jishnuvw@linux.ibm.com, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, jsnow@redhat.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com,
 aleksandr.mikhalitsyn@futurfusion.io,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20261102035306.2291147-1-uverma@linux.ibm.com>
 <20261102035306.2291147-9-uverma@linux.ibm.com>
 <09566fd1-7eb6-4dc1-a721-f15e4948e143@rsg.ci.i.u-tokyo.ac.jp>
 <2f5493aa-f70b-4561-8990-919234b6f257@linux.ibm.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <2f5493aa-f70b-4561-8990-919234b6f257@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/11/05 21:15, Utkarsh Verma wrote:
> On 11/3/26 7:36 PM, Akihiko Odaki wrote:
>> On 2026/11/02 12:53, uverma@linux.ibm.com wrote:
>>> From: Nicholas Piggin <npiggin@gmail.com>
>>>
>>> Add assertions to ensure a BAR is not mapped twice, and that only
>>> previously mapped BARs are unmapped. This can help catch bugs and
>>> fragile coding.
>>>
>>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>>> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> Signed-off-by: Jishnu Warrier <jishnuvw@linux.ibm.com>
>>> Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
>>> ---
>>>   tests/qtest/libqos/ahci.c |  3 ++-
>>>   tests/qtest/libqos/pci.c  | 57 +++++++++++++++++++++++++++++++++++----
>>>   tests/qtest/libqos/pci.h  | 10 +++++++
>>>   3 files changed, 64 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
>>> index a709558aac..53a98bd6cb 100644
>>> --- a/tests/qtest/libqos/ahci.c
>>> +++ b/tests/qtest/libqos/ahci.c
>>> @@ -225,7 +225,7 @@ void start_ahci_device(AHCIQState *ahci)
>>>   void stop_ahci_device(AHCIQState *ahci)
>>>   {
>>> -    /* Unmap AHCI's ABAR */
>>> +    /* Unmap AHCI's ABAR (no-op if not mapped) */
>>>       qpci_iounmap(ahci->dev, ahci->hba_bar);
>>>   }
>>> @@ -250,6 +250,7 @@ void ahci_hba_enable(AHCIQState *ahci)
>>>       uint8_t num_cmd_slots;
>>>       g_assert(ahci != NULL);
>>> +    g_assert(ahci->hba_bar.mapped);
>>>       /* Set GHC.AE to 1 */
>>>       ahci_set(ahci, AHCI_GHC, AHCI_GHC_AE);
>>> diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
>>> index e78dd4d4c7..365fde1fb9 100644
>>> --- a/tests/qtest/libqos/pci.c
>>> +++ b/tests/qtest/libqos/pci.c
>>> @@ -79,12 +79,17 @@ QPCIDevice *qpci_device_find(QPCIBus *bus, int 
>>> devfn)
>>>   void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, QPCIAddress 
>>> *addr)
>>>   {
>>>       uint16_t vendor_id, device_id;
>>> +    int i;
>>>       qpci_device_set(dev, bus, addr->devfn);
>>>       vendor_id = qpci_config_readw(dev, PCI_VENDOR_ID);
>>>       device_id = qpci_config_readw(dev, PCI_DEVICE_ID);
>>>       g_assert(!addr->vendor_id || vendor_id == addr->vendor_id);
>>>       g_assert(!addr->device_id || device_id == addr->device_id);
>>> +
>>> +    for (i = 0; i < QPCI_NUM_REGIONS; i++) {
>>> +        g_assert(!dev->bars_mapped[i]);
>>> +    }
>>>   }
>>>   static uint8_t qpci_find_resource_reserve_capability(QPCIDevice *dev)
>>> @@ -554,21 +559,31 @@ void qpci_memwrite(QPCIDevice *dev, QPCIBar 
>>> token, uint64_t off,
>>>       dev->bus->memwrite(dev->bus, token.addr + off, buf, len);
>>>   }
>>> -QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
>>> +static uint8_t qpci_bar_reg(int barno)
>>>   {
>>> -    QPCIBus *bus = dev->bus;
>>>       static const int bar_reg_map[] = {
>>>           PCI_BASE_ADDRESS_0, PCI_BASE_ADDRESS_1, PCI_BASE_ADDRESS_2,
>>>           PCI_BASE_ADDRESS_3, PCI_BASE_ADDRESS_4, PCI_BASE_ADDRESS_5,
>>>       };
>>> +
>>> +    g_assert(barno >= 0 && barno < QPCI_NUM_REGIONS);
>>> +
>>> +    return bar_reg_map[barno];
>>> +}
>>> +
>>> +QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
>>> +{
>>> +    QPCIBus *bus = dev->bus;
>>>       QPCIBar bar;
>>>       int bar_reg;
>>>       uint32_t addr, size;
>>>       uint32_t io_type;
>>>       uint64_t loc;
>>> -    g_assert(barno >= 0 && barno <= 5);
>>> -    bar_reg = bar_reg_map[barno];
>>> +    g_assert(barno >= 0 && barno < QPCI_NUM_REGIONS);
>>> +    g_assert(!dev->bars_mapped[barno]);
>>> +
>>> +    bar_reg = qpci_bar_reg(barno);
>>>       qpci_config_writel(dev, bar_reg, 0xFFFFFFFF);
>>>       addr = qpci_config_readl(dev, bar_reg);
>>> @@ -611,12 +626,40 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, 
>>> uint64_t *sizeptr)
>>>       }
>>>       bar.addr = loc;
>>> +    bar.mapped = true;
>>> +
>>> +    dev->bars_mapped[barno] = true;
>>> +    dev->bars[barno] = bar;
>>> +
>>>       return bar;
>>>   }
>>>   void qpci_iounmap(QPCIDevice *dev, QPCIBar bar)
>>>   {
>>> -    /* FIXME */
>>> +    int bar_reg;
>>> +    int i;
>>> +
>>> +    if (!bar.mapped) {
>>> +        return; /* bar was never mapped; no-op */
>>> +    }
>>> +
>>> +    for (i = 0; i < QPCI_NUM_REGIONS; i++) {
>>> +        if (!dev->bars_mapped[i]) {
>>> +            continue;
>>> +        }
>>> +        if (dev->bars[i].addr == bar.addr) {
>>> +            dev->bars_mapped[i] = false;
>>> +            dev->bars[i].mapped = false;
>>> +            bar_reg = qpci_bar_reg(i);
>>> +            qpci_config_writel(dev, bar_reg, 0xFFFFFFFF);
>>
>> I found that this is actually dangerous: the BAR may be 64-bit, and in 
>> that case, this won't unmap it. On x86, the BIOS is mapped around that 
>> area, and the mapped BAR will shadow it.
>>
>> Regards,
>> Akihiko Odaki
>>
> Agree, writing all 0xFF's to a single BAR will map the PCIe device to 
> 4GB-size address, which can overlap with the BIOS area on x86 system.
> The problem is that since qtest work directly with guest physical 
> addresses, writing any address to the BAR for unmapping purpose will map 
> that address to the PCIe device.
> The false mapping is not the 32 bit limitation, even with full 64 bit 
> BAR support, writing any address to both the BARs in qpci_iounmap() 
> would result in the mapping of the address to the PCIe device. Also, 
> full 64 bit BAR supoort would require implementation in the qpci_iomap() 
> and other functions as well.

pci_bar_address() rejects a region whose last address is
PCI_BAR_UNMAPPED, so writing all ones to both halves of a 64-bit BAR
would unmap it. The problem here is writing only the low half. Writing 
only the low half leaves a valid address below 4 GiB when the upper half 
is zero.

Regards,
Akihiko Odaki

> 
> For now we can completely remove this BAR write, so the BAR would be 
> mapped to it's original address for the rest of the qemu process (memory 
> leak) but should be safe as other allocations won't use that same 
> address again. Also, since these qtests launch new qemu instances so the 
> memory leak only exists in that current qemu process and new tests 
> create new instances, so it shouldn't be a big problem.
> Do you have any other approach for this, or does the above look good?
> 
> Regards,
> Utkarsh
> 
>>> +            /* FIXME: the address space is leaked */> + return;
>>> +        }
>>> +    }
>>> +    /*
>>> +     * bar was not iomap()ed; treat as no-op for callers that may
>>> +     * call iounmap unconditionally during cleanup paths.
>>> +     */
>>>   }
>>>   QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr)
>>> @@ -627,6 +670,10 @@ QPCIBar qpci_legacy_iomap(QPCIDevice *dev, 
>>> uint16_t addr)
>>>   void qpci_migrate_fixup(QPCIDevice *to, QPCIDevice *from)
>>>   {
>>> +    memcpy(to->bars_mapped, from->bars_mapped, sizeof(from- 
>>> >bars_mapped));
>>> +    memset(from->bars_mapped, 0, sizeof(from->bars_mapped));
>>> +    memcpy(to->bars, from->bars, sizeof(from->bars));
>>> +    memset(from->bars, 0, sizeof(from->bars));
>>>   }
>>>   void add_qpci_address(QOSGraphEdgeOptions *opts, QPCIAddress *addr)
>>> diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
>>> index cfb7c17dd3..2f9555ae4e 100644
>>> --- a/tests/qtest/libqos/pci.h
>>> +++ b/tests/qtest/libqos/pci.h
>>> @@ -58,12 +58,22 @@ struct QPCIBus {
>>>   struct QPCIBar {
>>>       uint64_t addr;
>>>       bool is_io;
>>> +    bool mapped;
>>>   };
>>> +/*
>>> + * hw/pci permits 7 (PCI_NUM_REGIONS) regions, the last for 
>>> PCI_ROM_SLOT.
>>> + * libqos does not implement PCI_ROM_SLOT at the moment, and as such it
>>> + * permits 6.
>>> + */
>>> +#define QPCI_NUM_REGIONS 6
>>> +
>>>   struct QPCIDevice
>>>   {
>>>       QPCIBus *bus;
>>>       int devfn;
>>> +    bool bars_mapped[QPCI_NUM_REGIONS];
>>> +    QPCIBar bars[QPCI_NUM_REGIONS];
>>>       bool msix_enabled;
>>>       QPCIBar msix_table_bar, msix_pba_bar;
>>>       uint64_t msix_table_off, msix_pba_off;
>>
>>
> 



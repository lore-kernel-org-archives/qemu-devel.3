Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2917C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 09:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmrVF-0006oW-Ey; Tue, 25 Feb 2025 04:45:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tmrVE-0006oN-ES
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 04:45:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tmrVA-0005wu-M1
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 04:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740476719;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o+2EwlrpqQxflyAK7lsRdE9l7fLP3tZB8Ko9GRO6/BI=;
 b=QYkuO8toLZcImL6MmjuG45+737/NoHh2PNjcCCbJAvc6ZnuI52T1UkKwBKnamklez7zYEY
 6KW/LpfyRcszF3gQT7YHA3YAPXQUmoaz8TKbL/Pk4y9DajJvOuFkSRA+z98w8R39Ej9Nce
 vqA4AHwFeEcTpnmT/Junmd8ivy8djh0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-5NCQf6CBPcCrRKJHoUcClw-1; Tue, 25 Feb 2025 04:45:13 -0500
X-MC-Unique: 5NCQf6CBPcCrRKJHoUcClw-1
X-Mimecast-MFC-AGG-ID: 5NCQf6CBPcCrRKJHoUcClw_1740476712
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38f2c0aa6d6so2815924f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 01:45:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740476712; x=1741081512;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o+2EwlrpqQxflyAK7lsRdE9l7fLP3tZB8Ko9GRO6/BI=;
 b=VRTHpyfEzRIO1QksWpMjoDOxh7dICmMisGKzWPk6SiGgxTwUaRVBht1nMRuPfskft2
 aMqbtYQ1B2Gb6uV/tcBctss/Q2XkZW9SBXFJ1SRzVsyUJ7qoL3CnDHqieWDSe2rBZdrp
 Ern1MsVLn+hujhvlVNxyM0/m4gokjdGkhBRz5hM8frWhwSO8IReE4Okq87bObdOT0yJ+
 zIe9m2TlVr2pWeG+hlIKfWz+WJvx5f7SMqQ5++7YUzDrX9HWMQfTv/8URA4v/2PmGr6n
 3FyKQgxoWaavBYZKxYf6Y1Qg/enNc9/H1u9uHJgESMK3W9DoYkrRmdnAsmByJh88mebR
 /pEw==
X-Gm-Message-State: AOJu0Yy5VDzF9TBf+WayGlVF8Zi+0+Z/OvIEGkFwV9rx2vZEx7zcN8an
 EPYoXe8Gzjc45zMfB5n6kOpCjbE4ESZfcITCsWp+GlqEpnnU5RPRi2O8Lz3JhZzJDaF0RxwbOtr
 rvyi+KJlVlmYCht4SNdknwfzBiRzMjyEG1AHSHBkFzhptl1stOSsG
X-Gm-Gg: ASbGncvICdXRd38Mdc97uz8aBwsvAPOzLIFIM7svUM6GWhlwdV8NhjPxyK7hIGHcf0a
 zYkjmFHpXLiQ67KU2xb2sebMK5/2KpOLYlV4NYVqkVCVCsbsxXsTfRiN+XWnh+7KA5dAX+Far7n
 ugpBaKr0xfKawRK4GWRb9laPVL50PiAp818Ee3fnTRPjOcSkmQcVVCcqouTUKHU2EPunhNsUTna
 8uf/6PsFYXLI736E8qKA5b17N5Ha3eUwFON3XIk4q/ju561LsZvCcmNCn1afTXtSWDU0YU96OZp
 c2anOuv6rbPZmmB04pdkIFqLzZyrAAQWAxv1zXTu2NJNHnWnnI2xjIQjpvvzd0k=
X-Received: by 2002:a05:6000:1a87:b0:38f:3ec3:4801 with SMTP id
 ffacd0b85a97d-38f616323bamr18607228f8f.25.1740476712411; 
 Tue, 25 Feb 2025 01:45:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkfuHioVx9u0vRtUg9bgqEFuz0sokdrsc3Bt8z5k8x5/Wk7PAoqYQ8YATO2rLnzaBL+2f6/Q==
X-Received: by 2002:a05:6000:1a87:b0:38f:3ec3:4801 with SMTP id
 ffacd0b85a97d-38f616323bamr18607195f8f.25.1740476712036; 
 Tue, 25 Feb 2025 01:45:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd8fc864sm1684533f8f.91.2025.02.25.01.45.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 01:45:11 -0800 (PST)
Message-ID: <e929b9b1-9f74-49e6-9ae7-cc50d79bde93@redhat.com>
Date: Tue, 25 Feb 2025 10:45:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hw/pci: Basic support for PCI power management
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, eric.auger.pro@gmail.com, clg@redhat.com,
 zhenzhong.duan@intel.com, mst@redhat.com, marcel.apfelbaum@gmail.com
References: <20250220224918.2520417-1-alex.williamson@redhat.com>
 <20250220224918.2520417-2-alex.williamson@redhat.com>
 <ac58cbe2-6161-46ed-a65d-c3fba90c1344@redhat.com>
 <20250224222458.183a061c.alex.williamson@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250224222458.183a061c.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Alex,


On 2/25/25 6:24 AM, Alex Williamson wrote:
> On Mon, 24 Feb 2025 20:03:56 +0100
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> Hi Alex,
>>
>> On 2/20/25 11:48 PM, Alex Williamson wrote:
>>> The memory and IO BARs for devices are only accessible in the D0
>>> power state.  In other power states the PCI spec defines that the
>>> device should respond to TLPs and messages with an Unsupported
>>> Request response.  The closest we can come to emulating this
>>> behavior is to consider the BARs as unmapped, removing them from
>>> the address space.
>>>
>>> Introduce an interface to register the PM capability such that
>>> the device power state is considered relative to the BAR mapping
>>> state.  
>> "the device power state is considered relative to the BAR mapping
>> state."
>> I rather understood that you want the BAR mapping state to depend on the power state but maybe I misunderstand the langage here.
> Yes, for the BAR to be mapped, both the memory enable state of the
> command register and the device power state are relevant, they are both
> considered.
thanks. That sounds clearer to me.
>
>>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>>> ---
>>>  hw/pci/pci.c                | 83 ++++++++++++++++++++++++++++++++++++-
>>>  hw/pci/trace-events         |  2 +
>>>  include/hw/pci/pci.h        |  3 ++
>>>  include/hw/pci/pci_device.h |  3 ++
>>>  4 files changed, 89 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>> index 2afa423925c5..4f2554dd63ac 100644
>>> --- a/hw/pci/pci.c
>>> +++ b/hw/pci/pci.c
>>> @@ -435,6 +435,74 @@ static void pci_msi_trigger(PCIDevice *dev, MSIMessage msg)
>>>                           attrs, NULL);
>>>  }
>>>  
>>> +int pci_pm_init(PCIDevice *d, uint8_t offset, Error **errp)
>>> +{
>>> +    int cap = pci_add_capability(d, PCI_CAP_ID_PM, offset, PCI_PM_SIZEOF, errp);
>>> +
>>> +    if (cap < 0) {
>>> +        return cap;
>>> +    }
>>> +
>>> +    d->pm_cap = cap;
>>> +    d->cap_present |= QEMU_PCI_CAP_PM;
>>> +    pci_set_word(d->wmask + cap + PCI_PM_CTRL, PCI_PM_CTRL_STATE_MASK);
>>> +
>>> +    return cap;
>>> +}
>>> +
>>> +static uint8_t pci_pm_state(PCIDevice *d)
>>> +{
>>> +    uint16_t pmcsr;
>>> +
>>> +    if (!(d->cap_present & QEMU_PCI_CAP_PM)) {
>>> +        return 0;
>>> +    }
>>> +
>>> +    pmcsr = pci_get_word(d->config + d->pm_cap + PCI_PM_CTRL);
>>> +
>>> +    return pmcsr & PCI_PM_CTRL_STATE_MASK;
>>> +}
>>> +
>>> +static uint8_t pci_pm_update(PCIDevice *d, uint32_t addr, int l, uint8_t old)  
>> the old/new terminology sounds weird to me. generally when one updates
>> we pass the new value.
> The new state lives in config space, the old state is recorded before
> config space is updated.  Otherwise we interfere with or duplicate the
> update of config space, which seems error prone and unnecessarily
> complicated.  pci_update_irq_disable() uses the same strategy.
ok
>
>>> +{
>>> +    uint16_t pmc;
>>> +    uint8_t new;
>>> +
>>> +    if (!(d->cap_present & QEMU_PCI_CAP_PM) ||
>>> +        !range_covers_byte(addr, l, d->pm_cap + PCI_PM_CTRL)) {
>>> +        return old;
>>> +    }
>>> +
>>> +    new = pci_pm_state(d);  
>> and new sounds to be the current state.
> The state after the guest config write is first applied, yes.
>
>> pci_pm_update() does a kind of validation of the current value? 
> Yes.  The PCI spec indicates that invalid transitions are ignored by
> the device.  That's currently all this does, but if a device wanted a
> callback to effect some behavior at state change, this would be a
> logical place to do that.
ok
>
>>> +    if (new == old) {
>>> +        return old;
>>> +    }
>>> +
>>> +    pmc = pci_get_word(d->config + d->pm_cap + PCI_PM_PMC);
>>> +
>>> +    /*
>>> +     * Transitions to D1 & D2 are only allowed if supported.  Devices may
>>> +     * only transition to higher D-states or to D0.  The write is dropped
>>> +     * for rejected transitions by restoring the old state.
>>> +     */
>>> +    if ((!(pmc & PCI_PM_CAP_D1) && new == 1) ||
>>> +        (!(pmc & PCI_PM_CAP_D2) && new == 2) ||
>>> +        (old && new && new < old)) {
>>> +        pci_word_test_and_clear_mask(d->config + d->pm_cap + PCI_PM_CTRL,
>>> +                                     PCI_PM_CTRL_STATE_MASK);
>>> +        pci_word_test_and_set_mask(d->config + d->pm_cap + PCI_PM_CTRL,
>>> +                                   old);
>>> +        trace_pci_pm_bad_transition(d->name, pci_dev_bus_num(d),
>>> +                                    PCI_SLOT(d->devfn), PCI_FUNC(d->devfn),
>>> +                                    old, new);  
>> the trace does not output that the old state is kept. This may be helpful.
> I was trying to keep the trace log brief.  The trace indicates it's a
> "bad" transition versus the trace below indicates a successful
> transition.  AIUI, most trace logs require some degree of familiarity
> with the call path to fully comprehend and it seemed unnecessary to
> print the old value twice to explicitly show it was restored.
> Suggestions welcome.
ok
>
>>> +        return old;
>>> +    }
>>> +
>>> +    trace_pci_pm_transition(d->name, pci_dev_bus_num(d), PCI_SLOT(d->devfn),
>>> +                            PCI_FUNC(d->devfn), old, new);
>>> +    return new;
>>> +}
>>> +
>>>  static void pci_reset_regions(PCIDevice *dev)
>>>  {
>>>      int r;
>>> @@ -474,6 +542,11 @@ static void pci_do_device_reset(PCIDevice *dev)
>>>                                pci_get_word(dev->wmask + PCI_INTERRUPT_LINE) |
>>>                                pci_get_word(dev->w1cmask + PCI_INTERRUPT_LINE));
>>>      dev->config[PCI_CACHE_LINE_SIZE] = 0x0;
>>> +    /* Default PM state is D0 */
>>> +    if (dev->cap_present & QEMU_PCI_CAP_PM) {
>>> +        pci_word_test_and_clear_mask(dev->config + dev->pm_cap + PCI_PM_CTRL,
>>> +                                     PCI_PM_CTRL_STATE_MASK);
>>> +    }
>>>      pci_reset_regions(dev);
>>>      pci_update_mappings(dev);
>>>  
>>> @@ -1598,7 +1671,7 @@ static void pci_update_mappings(PCIDevice *d)
>>>              continue;
>>>  
>>>          new_addr = pci_bar_address(d, i, r->type, r->size);
>>> -        if (!d->enabled) {
>>> +        if (!d->enabled || pci_pm_state(d)) {
>>>              new_addr = PCI_BAR_UNMAPPED;
>>>          }
>>>  
>>> @@ -1664,6 +1737,7 @@ uint32_t pci_default_read_config(PCIDevice *d,
>>>  
>>>  void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int l)
>>>  {
>>> +    uint8_t new_pm_state, old_pm_state = pci_pm_state(d);
>>>      int i, was_irq_disabled = pci_irq_disabled(d);
>>>      uint32_t val = val_in;
>>>  
>>> @@ -1676,11 +1750,16 @@ void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int
>>>          d->config[addr + i] = (d->config[addr + i] & ~wmask) | (val & wmask);
>>>          d->config[addr + i] &= ~(val & w1cmask); /* W1C: Write 1 to Clear */
>>>      }
>>> +  
>> IIUC the config is first updated and then we check the validity and
>> potentially restore the older value.
>> Couldn't we check the validity before updating d->config?
> We could, but why?  It's easier to deal with the before and after
> values rather than mangle the incoming write value, imo.  I also don't
> think the intermediate value is visible to the guest anyway.  Fixing
> the value "in flight" would need to take into account the wmask,
> duplicating or preempting the code just above.  Thanks,
OK, up to you. That pattern looked a bit unusual to me + update with
'old' param. But I have not seen any functional issue

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


>
> Alex
>
>>> +    new_pm_state = pci_pm_update(d, addr, l, old_pm_state);
>>> +
>>>      if (ranges_overlap(addr, l, PCI_BASE_ADDRESS_0, 24) ||
>>>          ranges_overlap(addr, l, PCI_ROM_ADDRESS, 4) ||
>>>          ranges_overlap(addr, l, PCI_ROM_ADDRESS1, 4) ||
>>> -        range_covers_byte(addr, l, PCI_COMMAND))
>>> +        range_covers_byte(addr, l, PCI_COMMAND) ||
>>> +        !!new_pm_state != !!old_pm_state) {
>>>          pci_update_mappings(d);  
>> Eric
>>> +    }
>>>  
>>>      if (ranges_overlap(addr, l, PCI_COMMAND, 2)) {
>>>          pci_update_irq_disabled(d, was_irq_disabled);
>>> diff --git a/hw/pci/trace-events b/hw/pci/trace-events
>>> index 19643aa8c6b0..811354f29031 100644
>>> --- a/hw/pci/trace-events
>>> +++ b/hw/pci/trace-events
>>> @@ -1,6 +1,8 @@
>>>  # See docs/devel/tracing.rst for syntax documentation.
>>>  
>>>  # pci.c
>>> +pci_pm_bad_transition(const char *dev, uint32_t bus, uint32_t slot, uint32_t func, uint8_t old, uint8_t new) "%s %02x:%02x.%x bad PM transition D%d->D%d"
>>> +pci_pm_transition(const char *dev, uint32_t bus, uint32_t slot, uint32_t func, uint8_t old, uint8_t new) "%s %02x:%02x.%x PM transition D%d->D%d"
>>>  pci_update_mappings_del(const char *dev, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "%s %02x:%02x.%x %d,0x%"PRIx64"+0x%"PRIx64
>>>  pci_update_mappings_add(const char *dev, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "%s %02x:%02x.%x %d,0x%"PRIx64"+0x%"PRIx64
>>>  pci_route_irq(int dev_irq, const char *dev_path, int parent_irq, const char *parent_path) "IRQ %d @%s -> IRQ %d @%s"
>>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>>> index 4002bbeebde0..c220cc844962 100644
>>> --- a/include/hw/pci/pci.h
>>> +++ b/include/hw/pci/pci.h
>>> @@ -216,6 +216,8 @@ enum {
>>>      QEMU_PCIE_ARI_NEXTFN_1 = (1 << QEMU_PCIE_ARI_NEXTFN_1_BITNR),
>>>  #define QEMU_PCIE_EXT_TAG_BITNR 13
>>>      QEMU_PCIE_EXT_TAG = (1 << QEMU_PCIE_EXT_TAG_BITNR),
>>> +#define QEMU_PCI_CAP_PM_BITNR 14
>>> +    QEMU_PCI_CAP_PM = (1 << QEMU_PCI_CAP_PM_BITNR),
>>>  };
>>>  
>>>  typedef struct PCIINTxRoute {
>>> @@ -676,5 +678,6 @@ static inline void pci_irq_deassert(PCIDevice *pci_dev)
>>>  MSIMessage pci_get_msi_message(PCIDevice *dev, int vector);
>>>  void pci_set_enabled(PCIDevice *pci_dev, bool state);
>>>  void pci_set_power(PCIDevice *pci_dev, bool state);
>>> +int pci_pm_init(PCIDevice *pci_dev, uint8_t offset, Error **errp);
>>>  
>>>  #endif
>>> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
>>> index add208edfabd..345b12eaac1a 100644
>>> --- a/include/hw/pci/pci_device.h
>>> +++ b/include/hw/pci/pci_device.h
>>> @@ -105,6 +105,9 @@ struct PCIDevice {
>>>      /* Capability bits */
>>>      uint32_t cap_present;
>>>  
>>> +    /* Offset of PM capability in config space */
>>> +    uint8_t pm_cap;
>>> +
>>>      /* Offset of MSI-X capability in config space */
>>>      uint8_t msix_cap;
>>>    



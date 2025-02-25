Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85BFC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 05:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmnRc-0004t3-AE; Tue, 25 Feb 2025 00:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tmnRV-0004sC-I7
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 00:25:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tmnRT-00030D-CK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 00:25:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740461113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mXWwnOFN3urtIKDn17HP5pGp9bm0Ra3+H2Gl6Bf0fwQ=;
 b=DU5v4Nad/ejYi2imBErzmnHeUGDO/pyVD5MWZ4G1CYOO12qv2wOTmzdQtoePlZ3KhydIGF
 toghl7Ric3RnbccDnHOcK+h9htYWgycKR/8oJaB06CRS/X0hz587SG+uQXyRTQr7RYbpSh
 EDWXJVv/3Y1BGM0sdUv9CXX7WvH7cOE=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-_SRKblfaN02OsKkoDRpvSg-1; Tue, 25 Feb 2025 00:25:06 -0500
X-MC-Unique: _SRKblfaN02OsKkoDRpvSg-1
X-Mimecast-MFC-AGG-ID: _SRKblfaN02OsKkoDRpvSg_1740461106
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-85534e45380so35622239f.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 21:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740461105; x=1741065905;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mXWwnOFN3urtIKDn17HP5pGp9bm0Ra3+H2Gl6Bf0fwQ=;
 b=df9QsPe2GBafuexzTE2NB7bbCPsfpB4P4npse5DGav6oChmwJP9T/TS5wdCqFZLM4d
 logZWfbObVpIsXJEyZvml+qVa5/wZy2iAK/NQfz4WyNZ6D6FnBTca2RK6EfNr3z30O8N
 nNibGkK4XnfmExGaWnYNGfxEHMELsogSIQa2En1Ci1sHCRaE/V/ta5wnIDSPblf7RwDb
 gZO8ZE1utvdIHxkbPcpo5ErKDqb0hHqpxmiS6J8dPfb03sFurber3Do8uG+Hope+RVXS
 khmkJ6/YYHDDoQ1T8635CHVCYZcbKrOhmq8lPmPrfgbsBYcsEISq54yK4QWzlt8YWBu/
 OzzQ==
X-Gm-Message-State: AOJu0Yz2ES218U0HnaWPK0sc9vrZDrn2kAs7c48Bmd0ZbAGn74e9QZgG
 zETcEvQ3n6lkVwsXU4hdoogcBMr0FI2P/qI8CYVNI0EsO9/9ce8OayYwSNNWztIg0pPjvC8YriG
 q6ItGLteC6OuQm2FppBB1i04ncnufaOKOd3+6OBvu08a50fi2EAV8
X-Gm-Gg: ASbGncsMP1CIcnLy162lvsHt1l8fAqRwWeovhmQuQpFYFq4zn/yNxrCHvBKdkZSYt3S
 UNbbJXawXR5brKI61BP8hdYu328/U88ZILOpkdc9iC7F7iynybtpg8125UO6wCMQxmG406Vd240
 /RxIHtqoN2gt+XqaQg5nqw/BDDL7y8jNz/nX6D0xvPaVT3/f33cXk//rNybFTJum3E035ZAQay+
 i7kLgqxz5ZAQsiWc9xdS8ESDFrvFT40ktswrdXkPHWU5SSws1CTR+i16oL2tbWGPviRUZk6wMMn
 xoahx7qjAaj0TbDd8is=
X-Received: by 2002:a05:6602:2c8c:b0:855:9e01:9ac9 with SMTP id
 ca18e2360f4ac-855da9bb272mr427273139f.1.1740461105605; 
 Mon, 24 Feb 2025 21:25:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7H8PsM7CcZTU9kOjhAaHvL/rvFnrC/dU7gakZxjEZg5+wiGVzVEV9OfEqmk5EArrwBaTBWw==
X-Received: by 2002:a05:6602:2c8c:b0:855:9e01:9ac9 with SMTP id
 ca18e2360f4ac-855da9bb272mr427272339f.1.1740461105205; 
 Mon, 24 Feb 2025 21:25:05 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85620a18c09sm19609439f.15.2025.02.24.21.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 21:25:03 -0800 (PST)
Date: Mon, 24 Feb 2025 22:24:58 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, eric.auger.pro@gmail.com, clg@redhat.com,
 zhenzhong.duan@intel.com, mst@redhat.com, marcel.apfelbaum@gmail.com
Subject: Re: [PATCH 1/5] hw/pci: Basic support for PCI power management
Message-ID: <20250224222458.183a061c.alex.williamson@redhat.com>
In-Reply-To: <ac58cbe2-6161-46ed-a65d-c3fba90c1344@redhat.com>
References: <20250220224918.2520417-1-alex.williamson@redhat.com>
 <20250220224918.2520417-2-alex.williamson@redhat.com>
 <ac58cbe2-6161-46ed-a65d-c3fba90c1344@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 24 Feb 2025 20:03:56 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> Hi Alex,
> 
> On 2/20/25 11:48 PM, Alex Williamson wrote:
> > The memory and IO BARs for devices are only accessible in the D0
> > power state.  In other power states the PCI spec defines that the
> > device should respond to TLPs and messages with an Unsupported
> > Request response.  The closest we can come to emulating this
> > behavior is to consider the BARs as unmapped, removing them from
> > the address space.
> >
> > Introduce an interface to register the PM capability such that
> > the device power state is considered relative to the BAR mapping
> > state.  
> 
> "the device power state is considered relative to the BAR mapping
> state."
> I rather understood that you want the BAR mapping state to depend on the power state but maybe I misunderstand the langage here.

Yes, for the BAR to be mapped, both the memory enable state of the
command register and the device power state are relevant, they are both
considered.

> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  hw/pci/pci.c                | 83 ++++++++++++++++++++++++++++++++++++-
> >  hw/pci/trace-events         |  2 +
> >  include/hw/pci/pci.h        |  3 ++
> >  include/hw/pci/pci_device.h |  3 ++
> >  4 files changed, 89 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index 2afa423925c5..4f2554dd63ac 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -435,6 +435,74 @@ static void pci_msi_trigger(PCIDevice *dev, MSIMessage msg)
> >                           attrs, NULL);
> >  }
> >  
> > +int pci_pm_init(PCIDevice *d, uint8_t offset, Error **errp)
> > +{
> > +    int cap = pci_add_capability(d, PCI_CAP_ID_PM, offset, PCI_PM_SIZEOF, errp);
> > +
> > +    if (cap < 0) {
> > +        return cap;
> > +    }
> > +
> > +    d->pm_cap = cap;
> > +    d->cap_present |= QEMU_PCI_CAP_PM;
> > +    pci_set_word(d->wmask + cap + PCI_PM_CTRL, PCI_PM_CTRL_STATE_MASK);
> > +
> > +    return cap;
> > +}
> > +
> > +static uint8_t pci_pm_state(PCIDevice *d)
> > +{
> > +    uint16_t pmcsr;
> > +
> > +    if (!(d->cap_present & QEMU_PCI_CAP_PM)) {
> > +        return 0;
> > +    }
> > +
> > +    pmcsr = pci_get_word(d->config + d->pm_cap + PCI_PM_CTRL);
> > +
> > +    return pmcsr & PCI_PM_CTRL_STATE_MASK;
> > +}
> > +
> > +static uint8_t pci_pm_update(PCIDevice *d, uint32_t addr, int l, uint8_t old)  
> the old/new terminology sounds weird to me. generally when one updates
> we pass the new value.

The new state lives in config space, the old state is recorded before
config space is updated.  Otherwise we interfere with or duplicate the
update of config space, which seems error prone and unnecessarily
complicated.  pci_update_irq_disable() uses the same strategy.

> > +{
> > +    uint16_t pmc;
> > +    uint8_t new;
> > +
> > +    if (!(d->cap_present & QEMU_PCI_CAP_PM) ||
> > +        !range_covers_byte(addr, l, d->pm_cap + PCI_PM_CTRL)) {
> > +        return old;
> > +    }
> > +
> > +    new = pci_pm_state(d);  
> and new sounds to be the current state.

The state after the guest config write is first applied, yes.

> pci_pm_update() does a kind of validation of the current value? 

Yes.  The PCI spec indicates that invalid transitions are ignored by
the device.  That's currently all this does, but if a device wanted a
callback to effect some behavior at state change, this would be a
logical place to do that.

> > +    if (new == old) {
> > +        return old;
> > +    }
> > +
> > +    pmc = pci_get_word(d->config + d->pm_cap + PCI_PM_PMC);
> > +
> > +    /*
> > +     * Transitions to D1 & D2 are only allowed if supported.  Devices may
> > +     * only transition to higher D-states or to D0.  The write is dropped
> > +     * for rejected transitions by restoring the old state.
> > +     */
> > +    if ((!(pmc & PCI_PM_CAP_D1) && new == 1) ||
> > +        (!(pmc & PCI_PM_CAP_D2) && new == 2) ||
> > +        (old && new && new < old)) {
> > +        pci_word_test_and_clear_mask(d->config + d->pm_cap + PCI_PM_CTRL,
> > +                                     PCI_PM_CTRL_STATE_MASK);
> > +        pci_word_test_and_set_mask(d->config + d->pm_cap + PCI_PM_CTRL,
> > +                                   old);
> > +        trace_pci_pm_bad_transition(d->name, pci_dev_bus_num(d),
> > +                                    PCI_SLOT(d->devfn), PCI_FUNC(d->devfn),
> > +                                    old, new);  
> the trace does not output that the old state is kept. This may be helpful.

I was trying to keep the trace log brief.  The trace indicates it's a
"bad" transition versus the trace below indicates a successful
transition.  AIUI, most trace logs require some degree of familiarity
with the call path to fully comprehend and it seemed unnecessary to
print the old value twice to explicitly show it was restored.
Suggestions welcome.

> > +        return old;
> > +    }
> > +
> > +    trace_pci_pm_transition(d->name, pci_dev_bus_num(d), PCI_SLOT(d->devfn),
> > +                            PCI_FUNC(d->devfn), old, new);
> > +    return new;
> > +}
> > +
> >  static void pci_reset_regions(PCIDevice *dev)
> >  {
> >      int r;
> > @@ -474,6 +542,11 @@ static void pci_do_device_reset(PCIDevice *dev)
> >                                pci_get_word(dev->wmask + PCI_INTERRUPT_LINE) |
> >                                pci_get_word(dev->w1cmask + PCI_INTERRUPT_LINE));
> >      dev->config[PCI_CACHE_LINE_SIZE] = 0x0;
> > +    /* Default PM state is D0 */
> > +    if (dev->cap_present & QEMU_PCI_CAP_PM) {
> > +        pci_word_test_and_clear_mask(dev->config + dev->pm_cap + PCI_PM_CTRL,
> > +                                     PCI_PM_CTRL_STATE_MASK);
> > +    }
> >      pci_reset_regions(dev);
> >      pci_update_mappings(dev);
> >  
> > @@ -1598,7 +1671,7 @@ static void pci_update_mappings(PCIDevice *d)
> >              continue;
> >  
> >          new_addr = pci_bar_address(d, i, r->type, r->size);
> > -        if (!d->enabled) {
> > +        if (!d->enabled || pci_pm_state(d)) {
> >              new_addr = PCI_BAR_UNMAPPED;
> >          }
> >  
> > @@ -1664,6 +1737,7 @@ uint32_t pci_default_read_config(PCIDevice *d,
> >  
> >  void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int l)
> >  {
> > +    uint8_t new_pm_state, old_pm_state = pci_pm_state(d);
> >      int i, was_irq_disabled = pci_irq_disabled(d);
> >      uint32_t val = val_in;
> >  
> > @@ -1676,11 +1750,16 @@ void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int
> >          d->config[addr + i] = (d->config[addr + i] & ~wmask) | (val & wmask);
> >          d->config[addr + i] &= ~(val & w1cmask); /* W1C: Write 1 to Clear */
> >      }
> > +  
> IIUC the config is first updated and then we check the validity and
> potentially restore the older value.
> Couldn't we check the validity before updating d->config?

We could, but why?  It's easier to deal with the before and after
values rather than mangle the incoming write value, imo.  I also don't
think the intermediate value is visible to the guest anyway.  Fixing
the value "in flight" would need to take into account the wmask,
duplicating or preempting the code just above.  Thanks,

Alex

> > +    new_pm_state = pci_pm_update(d, addr, l, old_pm_state);
> > +
> >      if (ranges_overlap(addr, l, PCI_BASE_ADDRESS_0, 24) ||
> >          ranges_overlap(addr, l, PCI_ROM_ADDRESS, 4) ||
> >          ranges_overlap(addr, l, PCI_ROM_ADDRESS1, 4) ||
> > -        range_covers_byte(addr, l, PCI_COMMAND))
> > +        range_covers_byte(addr, l, PCI_COMMAND) ||
> > +        !!new_pm_state != !!old_pm_state) {
> >          pci_update_mappings(d);  
> Eric
> > +    }
> >  
> >      if (ranges_overlap(addr, l, PCI_COMMAND, 2)) {
> >          pci_update_irq_disabled(d, was_irq_disabled);
> > diff --git a/hw/pci/trace-events b/hw/pci/trace-events
> > index 19643aa8c6b0..811354f29031 100644
> > --- a/hw/pci/trace-events
> > +++ b/hw/pci/trace-events
> > @@ -1,6 +1,8 @@
> >  # See docs/devel/tracing.rst for syntax documentation.
> >  
> >  # pci.c
> > +pci_pm_bad_transition(const char *dev, uint32_t bus, uint32_t slot, uint32_t func, uint8_t old, uint8_t new) "%s %02x:%02x.%x bad PM transition D%d->D%d"
> > +pci_pm_transition(const char *dev, uint32_t bus, uint32_t slot, uint32_t func, uint8_t old, uint8_t new) "%s %02x:%02x.%x PM transition D%d->D%d"
> >  pci_update_mappings_del(const char *dev, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "%s %02x:%02x.%x %d,0x%"PRIx64"+0x%"PRIx64
> >  pci_update_mappings_add(const char *dev, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "%s %02x:%02x.%x %d,0x%"PRIx64"+0x%"PRIx64
> >  pci_route_irq(int dev_irq, const char *dev_path, int parent_irq, const char *parent_path) "IRQ %d @%s -> IRQ %d @%s"
> > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > index 4002bbeebde0..c220cc844962 100644
> > --- a/include/hw/pci/pci.h
> > +++ b/include/hw/pci/pci.h
> > @@ -216,6 +216,8 @@ enum {
> >      QEMU_PCIE_ARI_NEXTFN_1 = (1 << QEMU_PCIE_ARI_NEXTFN_1_BITNR),
> >  #define QEMU_PCIE_EXT_TAG_BITNR 13
> >      QEMU_PCIE_EXT_TAG = (1 << QEMU_PCIE_EXT_TAG_BITNR),
> > +#define QEMU_PCI_CAP_PM_BITNR 14
> > +    QEMU_PCI_CAP_PM = (1 << QEMU_PCI_CAP_PM_BITNR),
> >  };
> >  
> >  typedef struct PCIINTxRoute {
> > @@ -676,5 +678,6 @@ static inline void pci_irq_deassert(PCIDevice *pci_dev)
> >  MSIMessage pci_get_msi_message(PCIDevice *dev, int vector);
> >  void pci_set_enabled(PCIDevice *pci_dev, bool state);
> >  void pci_set_power(PCIDevice *pci_dev, bool state);
> > +int pci_pm_init(PCIDevice *pci_dev, uint8_t offset, Error **errp);
> >  
> >  #endif
> > diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> > index add208edfabd..345b12eaac1a 100644
> > --- a/include/hw/pci/pci_device.h
> > +++ b/include/hw/pci/pci_device.h
> > @@ -105,6 +105,9 @@ struct PCIDevice {
> >      /* Capability bits */
> >      uint32_t cap_present;
> >  
> > +    /* Offset of PM capability in config space */
> > +    uint8_t pm_cap;
> > +
> >      /* Offset of MSI-X capability in config space */
> >      uint8_t msix_cap;
> >    
> 



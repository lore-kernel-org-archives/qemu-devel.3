Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E04C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 08:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnZ4Y-0007ik-3o; Thu, 27 Feb 2025 03:16:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tnZ4V-0007c8-SR
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 03:16:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tnZ4R-0003Cr-Cc
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 03:16:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740644196;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0SDnSnIXBA24M3WfobUAkeQB1U5JVsQiXjCEnohXrSc=;
 b=SHvxi3fWwMX6zTNweIy4EZk+TisDYqw3ZtO4ZfSD0ICTJbpvbNryz44rJSxNH/Mg2Y0Uow
 uuJevTPe4+QKkCcOHPyfDoCprbTWc/rDEjkL60p3hrhvrsx0l975sDjfwQLDL3ifGh8BSG
 EG81XMSGA5DFNMkFv23GwRftwgKrqbE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-ikJq82udOqy_hmP9A1t2cw-1; Thu, 27 Feb 2025 03:16:35 -0500
X-MC-Unique: ikJq82udOqy_hmP9A1t2cw-1
X-Mimecast-MFC-AGG-ID: ikJq82udOqy_hmP9A1t2cw_1740644194
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43943bd1409so5211765e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 00:16:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740644194; x=1741248994;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0SDnSnIXBA24M3WfobUAkeQB1U5JVsQiXjCEnohXrSc=;
 b=wkSSYsQ/io5OlTekVqAenNw68QGgGFzxN7/4hnwb/tS8VVlBS8NicCbW6yQEwXYxWN
 uM3ghyTUOnhPyFUgWAqBTuTNd9GtdkChLkIWH/v7NNdlXrlgYxhE804MzsIYepTIkZfI
 Gxf3CVP/pl8KdK277Cm0W1eCw6JGGYpoIsT4oMqRWVPZ6gsF9oOsUWrHFtYKmKkzaJ+d
 oQl2muaxSfhLU3N354jzNtcNSugXhvCRksNvmme1Y8CCv3sSDsI3irATKdKyQ4s3dkia
 senuhg0/rwdTl+VMy1BjjpFyronrR+G9cNdcJG8pmQIyq48c0S0GOm7DV+ZiYxSo/J4E
 Q4UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqd4H9wbYrvB1xE4/eIMQWsZ5QLFb/bg8rrzTLeiJpmrY8T2SzL9LIU8/VHFZmGyI3ciTgsoyahMm4@nongnu.org
X-Gm-Message-State: AOJu0YzeZ+Xq0/7g83AmUgy9UCbYJo3yhRgTjwPvlSsf/xpjWPELKwLl
 js89Qn8ygyF7hgh3afh0bBN8P1MW3Qka/yYWkxSd0dNLrkeUGbtR7KEB35rR+4G9QiFmr5pWqGm
 D3+MXt93jhvHDkT88JJTwNWnVAQOSpP9G/vxK/qWy1ZV4SM1mLmQ8
X-Gm-Gg: ASbGncubJ9ORzmMktCGutvqH8PFb8oMU3Xt7tpP5Ub00DXVQfvtE62Rc8Omzz4oWxYM
 E3SuwDAGrwt+pSjMRN1tULCbVWIZpJhV5TwHAT7hfmTMnLUlITtnZtM71F2PIzp0Qx3lDwVAR/D
 ddI/52QJJ8d1+imlegZDl2ZLpvhilE/er1pZHUnBmkCAeu8kJBiU6OfINJgHA6H3idMOGEg4NBF
 IIDNlE2xOfKN/QmQ1DbC7dTOkpFLW7Ctt2BbkWlmwKadFZbYDRk+IHs0OONZT1z7oF/lZuQAT9s
 Vmu38syxNy04ko65WzhRuY06X9s591MwqKyX1nzgq+hLRu5qsAlvxbX8n9mUN4E=
X-Received: by 2002:a05:600c:45c6:b0:439:5afa:ecd1 with SMTP id
 5b1f17b1804b1-43ab8fd1e33mr51310775e9.6.1740644193616; 
 Thu, 27 Feb 2025 00:16:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxqXdS3NXpT3UFq8gGab7ifZrIIBLy5F++iBvNOMt156OKofU+wodcyHCWW1wjYXGDuLbl5g==
X-Received: by 2002:a05:600c:45c6:b0:439:5afa:ecd1 with SMTP id
 5b1f17b1804b1-43ab8fd1e33mr51310515e9.6.1740644193189; 
 Thu, 27 Feb 2025 00:16:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba52b7ecsm46175525e9.3.2025.02.27.00.16.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 00:16:32 -0800 (PST)
Message-ID: <d09287df-de4e-4717-8769-24ce08c81ec3@redhat.com>
Date: Thu, 27 Feb 2025 09:16:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] hw/pci: Basic support for PCI power management
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: eric.auger.pro@gmail.com, clg@redhat.com, zhenzhong.duan@intel.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com
References: <20250225215237.3314011-1-alex.williamson@redhat.com>
 <20250225215237.3314011-2-alex.williamson@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250225215237.3314011-2-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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




On 2/25/25 10:52 PM, Alex Williamson wrote:
> The memory and IO BARs for devices are only accessible in the D0 power
> state.  In other power states the PCI spec defines that the device
> responds to TLPs and messages with an Unsupported Request response.
>
> To approximate this behavior, consider the BARs as unmapped when the
> device is not in the D0 power state.  This makes the BARs inaccessible
> and has the additional bonus for vfio-pci that we don't attempt to DMA
> map BARs for devices in a non-D0 power state.
>
> To support this, an interface is added for devices to register the PM
> capability, which allows central tracking to enforce valid transitions
> and unmap BARs in non-D0 states.
>
> NB. We currently have device models (eepro100 and pcie_pci_bridge)
> that register a PM capability but do not set wmask to enable writes to
> the power state field.  In order to maintain migration compatibility,
> this new helper does not manage the wmask to enable guest writes to
> initiate a power state change.  The contents and write access of the
> PM capability are still managed by the caller.
>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/pci/pci.c                | 93 ++++++++++++++++++++++++++++++++++++-
>  hw/pci/trace-events         |  2 +
>  include/hw/pci/pci.h        |  3 ++
>  include/hw/pci/pci_device.h |  3 ++
>  4 files changed, 99 insertions(+), 2 deletions(-)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 2afa423925c5..24629807de82 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -435,6 +435,84 @@ static void pci_msi_trigger(PCIDevice *dev, MSIMessage msg)
>                           attrs, NULL);
>  }
>  
> +/*
> + * Register and track a PM capability.  If wmask is also enabled for the power
> + * state field of the pmcsr register, guest writes may change the device PM
> + * state.  BAR access is only enabled while the device is in the D0 state.
> + * Return the capability offset or negative error code.
> + */
> +int pci_pm_init(PCIDevice *d, uint8_t offset, Error **errp)
> +{
> +    int cap = pci_add_capability(d, PCI_CAP_ID_PM, offset, PCI_PM_SIZEOF, errp);
> +
> +    if (cap < 0) {
> +        return cap;
> +    }
> +
> +    d->pm_cap = cap;
> +    d->cap_present |= QEMU_PCI_CAP_PM;
> +
> +    return cap;
> +}
> +
> +static uint8_t pci_pm_state(PCIDevice *d)
> +{
> +    uint16_t pmcsr;
> +
> +    if (!(d->cap_present & QEMU_PCI_CAP_PM)) {
> +        return 0;
> +    }
> +
> +    pmcsr = pci_get_word(d->config + d->pm_cap + PCI_PM_CTRL);
> +
> +    return pmcsr & PCI_PM_CTRL_STATE_MASK;
> +}
> +
> +/*
> + * Update the PM capability state based on the new value stored in config
> + * space respective to the old, pre-write state provided.  If the new value
> + * is rejected (unsupported or invalid transition) restore the old value.
> + * Return the resulting PM state.
> + */
> +static uint8_t pci_pm_update(PCIDevice *d, uint32_t addr, int l, uint8_t old)
> +{
> +    uint16_t pmc;
> +    uint8_t new;
> +
> +    if (!(d->cap_present & QEMU_PCI_CAP_PM) ||
> +        !range_covers_byte(addr, l, d->pm_cap + PCI_PM_CTRL)) {
> +        return old;
> +    }
> +
> +    new = pci_pm_state(d);
> +    if (new == old) {
> +        return old;
> +    }
> +
> +    pmc = pci_get_word(d->config + d->pm_cap + PCI_PM_PMC);
> +
> +    /*
> +     * Transitions to D1 & D2 are only allowed if supported.  Devices may
> +     * only transition to higher D-states or to D0.
> +     */
> +    if ((!(pmc & PCI_PM_CAP_D1) && new == 1) ||
> +        (!(pmc & PCI_PM_CAP_D2) && new == 2) ||
> +        (old && new && new < old)) {
> +        pci_word_test_and_clear_mask(d->config + d->pm_cap + PCI_PM_CTRL,
> +                                     PCI_PM_CTRL_STATE_MASK);
> +        pci_word_test_and_set_mask(d->config + d->pm_cap + PCI_PM_CTRL,
> +                                   old);
> +        trace_pci_pm_bad_transition(d->name, pci_dev_bus_num(d),
> +                                    PCI_SLOT(d->devfn), PCI_FUNC(d->devfn),
> +                                    old, new);
> +        return old;
> +    }
> +
> +    trace_pci_pm_transition(d->name, pci_dev_bus_num(d), PCI_SLOT(d->devfn),
> +                            PCI_FUNC(d->devfn), old, new);
> +    return new;
> +}
> +
>  static void pci_reset_regions(PCIDevice *dev)
>  {
>      int r;
> @@ -474,6 +552,11 @@ static void pci_do_device_reset(PCIDevice *dev)
>                                pci_get_word(dev->wmask + PCI_INTERRUPT_LINE) |
>                                pci_get_word(dev->w1cmask + PCI_INTERRUPT_LINE));
>      dev->config[PCI_CACHE_LINE_SIZE] = 0x0;
> +    /* Default PM state is D0 */
> +    if (dev->cap_present & QEMU_PCI_CAP_PM) {
> +        pci_word_test_and_clear_mask(dev->config + dev->pm_cap + PCI_PM_CTRL,
> +                                     PCI_PM_CTRL_STATE_MASK);
> +    }
>      pci_reset_regions(dev);
>      pci_update_mappings(dev);
>  
> @@ -1598,7 +1681,7 @@ static void pci_update_mappings(PCIDevice *d)
>              continue;
>  
>          new_addr = pci_bar_address(d, i, r->type, r->size);
> -        if (!d->enabled) {
> +        if (!d->enabled || pci_pm_state(d)) {
>              new_addr = PCI_BAR_UNMAPPED;
>          }
>  
> @@ -1664,6 +1747,7 @@ uint32_t pci_default_read_config(PCIDevice *d,
>  
>  void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int l)
>  {
> +    uint8_t new_pm_state, old_pm_state = pci_pm_state(d);
>      int i, was_irq_disabled = pci_irq_disabled(d);
>      uint32_t val = val_in;
>  
> @@ -1676,11 +1760,16 @@ void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int
>          d->config[addr + i] = (d->config[addr + i] & ~wmask) | (val & wmask);
>          d->config[addr + i] &= ~(val & w1cmask); /* W1C: Write 1 to Clear */
>      }
> +
> +    new_pm_state = pci_pm_update(d, addr, l, old_pm_state);
> +
>      if (ranges_overlap(addr, l, PCI_BASE_ADDRESS_0, 24) ||
>          ranges_overlap(addr, l, PCI_ROM_ADDRESS, 4) ||
>          ranges_overlap(addr, l, PCI_ROM_ADDRESS1, 4) ||
> -        range_covers_byte(addr, l, PCI_COMMAND))
> +        range_covers_byte(addr, l, PCI_COMMAND) ||
> +        !!new_pm_state != !!old_pm_state) {
>          pci_update_mappings(d);
> +    }
>  
>      if (ranges_overlap(addr, l, PCI_COMMAND, 2)) {
>          pci_update_irq_disabled(d, was_irq_disabled);
> diff --git a/hw/pci/trace-events b/hw/pci/trace-events
> index 19643aa8c6b0..c82a87ffdd2b 100644
> --- a/hw/pci/trace-events
> +++ b/hw/pci/trace-events
> @@ -1,6 +1,8 @@
>  # See docs/devel/tracing.rst for syntax documentation.
>  
>  # pci.c
> +pci_pm_bad_transition(const char *dev, uint32_t bus, uint32_t slot, uint32_t func, uint8_t old, uint8_t new) "%s %02x:%02x.%x REJECTED PM transition D%d->D%d"
> +pci_pm_transition(const char *dev, uint32_t bus, uint32_t slot, uint32_t func, uint8_t old, uint8_t new) "%s %02x:%02x.%x PM transition D%d->D%d"
>  pci_update_mappings_del(const char *dev, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "%s %02x:%02x.%x %d,0x%"PRIx64"+0x%"PRIx64
>  pci_update_mappings_add(const char *dev, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "%s %02x:%02x.%x %d,0x%"PRIx64"+0x%"PRIx64
>  pci_route_irq(int dev_irq, const char *dev_path, int parent_irq, const char *parent_path) "IRQ %d @%s -> IRQ %d @%s"
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 4002bbeebde0..c220cc844962 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -216,6 +216,8 @@ enum {
>      QEMU_PCIE_ARI_NEXTFN_1 = (1 << QEMU_PCIE_ARI_NEXTFN_1_BITNR),
>  #define QEMU_PCIE_EXT_TAG_BITNR 13
>      QEMU_PCIE_EXT_TAG = (1 << QEMU_PCIE_EXT_TAG_BITNR),
> +#define QEMU_PCI_CAP_PM_BITNR 14
> +    QEMU_PCI_CAP_PM = (1 << QEMU_PCI_CAP_PM_BITNR),
>  };
>  
>  typedef struct PCIINTxRoute {
> @@ -676,5 +678,6 @@ static inline void pci_irq_deassert(PCIDevice *pci_dev)
>  MSIMessage pci_get_msi_message(PCIDevice *dev, int vector);
>  void pci_set_enabled(PCIDevice *pci_dev, bool state);
>  void pci_set_power(PCIDevice *pci_dev, bool state);
> +int pci_pm_init(PCIDevice *pci_dev, uint8_t offset, Error **errp);
>  
>  #endif
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index add208edfabd..345b12eaac1a 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -105,6 +105,9 @@ struct PCIDevice {
>      /* Capability bits */
>      uint32_t cap_present;
>  
> +    /* Offset of PM capability in config space */
> +    uint8_t pm_cap;
> +
>      /* Offset of MSI-X capability in config space */
>      uint8_t msix_cap;
>  



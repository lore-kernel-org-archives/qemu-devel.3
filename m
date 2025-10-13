Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD337CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 08:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Dii-0002d3-VF; Mon, 13 Oct 2025 04:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v8Dif-0002br-1r
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 04:15:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v8Dib-0004o5-R2
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 04:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760343341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gYkogHth0JTgwp9RwAi4OgML/GAIyxEiR3GSkwhS9Ws=;
 b=bFy1I8uC+zLoOCzywKT7AA0NbGvFigtw61luDBScdUwxQVGKqdojhBRLlpHaYpGQOexvTw
 rJrqfKJbhH/ljq+m1/fzyQ7qsR5N556OZpoyq1FME5Nx5lRoiSsaAhRMqP3cJ62qXeA9NS
 T3OTp3B825D0LdCLgKSR7gHHV8mAOfU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-1n2uGY1KMoGkf7BQzFC3Fg-1; Mon, 13 Oct 2025 04:15:39 -0400
X-MC-Unique: 1n2uGY1KMoGkf7BQzFC3Fg-1
X-Mimecast-MFC-AGG-ID: 1n2uGY1KMoGkf7BQzFC3Fg_1760343336
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e45899798so27357335e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 01:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760343336; x=1760948136;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gYkogHth0JTgwp9RwAi4OgML/GAIyxEiR3GSkwhS9Ws=;
 b=ciz8ASmkUp4tCHbUe9sSbRxqmrheZtisflXqQO6Uc18UUCadhS86bf94o6ho79cSrR
 G4MG7C6i2IiMZ1B0Ru3sn2AgSrhDPOK2+Uo55zURSnGjyVi+7CA+YItrGRqWKVAsXc0M
 QoAUajHA9r7lovd8sC6Nd6v4/yGeiW3DAE/RpyQc52ovm+UY9r7M7HgSYuHp/T+EMQym
 9Usq8izAkHfHkKe9OfwPxjTtU5vkZWP+ShYHOKObDQHVyMX1H1D4s8uwiGkmeQfWAGMW
 PLI9cf6nX8RMVZavULZT84g3Q53g2vOQzdJhyRAkhYFHIQEAAPPYLLuwEy4ysn9GyAsr
 SbbQ==
X-Gm-Message-State: AOJu0YzHiLkHma8gTfzD7/KQnVajpcqQ9vOyykGrzPLwHqXlQjBBeUn2
 mx1ETyonq8EE6LUXfdNjzN11qcjV5LsVN73Lu/1elfXazS85aQIYrijJrRo9sqPrL9VBE1AJD41
 WXbR0t894E1acq01JVu9CnZpr1l0jjzyqb1MCJRGXwYTR9PuVq+XlQxUo
X-Gm-Gg: ASbGncsCCy35T8TWFp5wr+flrhAeXRpRCpCpK0wn9kqlHwtUqNrzTlkSth5yZya0ChE
 79cHq6q8nodx+PH2bMd9+ha9BvDGJMgxeOFh2hb614OSvHp4TcGH28E3DmAwTxTFWrVdss70IPm
 1D6K9p2lYlQ6fkXxbGbIM7cAIrDEWkHHSm5mfOkL19U6ZI1+5OEz8RkCJEJXHWVy1OjqtJOf6v7
 RnRSr4dBzBWyqIUAg1iZOwskJwgPNUl+vKzDJZ/QJX8Aa//c1NFV0UJMLvicw2A5Ym7oELn1Puu
 O97n04vyPpmbsyXd5qzPUv2cSnwzdQ==
X-Received: by 2002:a05:600c:4e41:b0:45f:2cf9:c229 with SMTP id
 5b1f17b1804b1-46fa9a220b1mr141741085e9.0.1760343335855; 
 Mon, 13 Oct 2025 01:15:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBjj9a+iNUuAnUHexK/Ol9BXSs0HdOY59PS3AaLTWHAct3LJCSJgJ0O/aajQFZZc7stxQ+jw==
X-Received: by 2002:a05:600c:4e41:b0:45f:2cf9:c229 with SMTP id
 5b1f17b1804b1-46fa9a220b1mr141740835e9.0.1760343335294; 
 Mon, 13 Oct 2025 01:15:35 -0700 (PDT)
Received: from redhat.com ([31.187.78.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e8b31sm17061409f8f.54.2025.10.13.01.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 01:15:34 -0700 (PDT)
Date: Mon, 13 Oct 2025 04:15:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: qemu-devel@nongnu.org, alejandro.j.jimenez@oracle.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, suravee.suthikulpanit@amd.com,
 vasant.hegde@amd.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, aik@amd.com
Subject: Re: [PATCH v2 1/2] amd_iommu: Fix handling device on buses != 0
Message-ID: <20251013041059-mutt-send-email-mst@kernel.org>
References: <20251013050046.393-1-sarunkod@amd.com>
 <20251013050046.393-2-sarunkod@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013050046.393-2-sarunkod@amd.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Oct 13, 2025 at 10:30:45AM +0530, Sairaj Kodilkar wrote:
> The AMD IOMMU is set up at boot time and uses PCI bus numbers + devfn
> for indexing into DTE. The problem is that before the guest started,
> all PCI bus numbers are 0 as no PCI discovery happened yet (BIOS or/and
> kernel will do that later) so relying on the bus number is wrong.
> The immediate effect is emulated devices cannot do DMA when places on
> a bus other that 0.
> 
> Replace static array of address_space with hash table which uses devfn and
> PCIBus* for key as it is not going to change after the guest is booted.

I am curious whether this has any measureable impact on
performance.


> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>


love the patch! yet something to improve:

> ---
>  hw/i386/amd_iommu.c | 134 ++++++++++++++++++++++++++------------------
>  hw/i386/amd_iommu.h |   2 +-
>  2 files changed, 79 insertions(+), 57 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 378e0cb55eab..b194e3294dd7 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -59,7 +59,7 @@ const char *amdvi_mmio_high[] = {
>  };
>  
>  struct AMDVIAddressSpace {
> -    uint8_t bus_num;            /* bus number                           */
> +    PCIBus *bus;                /* PCIBus (for bus number)              */
>      uint8_t devfn;              /* device function                      */
>      AMDVIState *iommu_state;    /* AMDVI - one per machine              */
>      MemoryRegion root;          /* AMDVI Root memory map region         */
> @@ -101,6 +101,11 @@ typedef enum AMDVIFaultReason {
>      AMDVI_FR_PT_ENTRY_INV,      /* Failure to read PTE from guest memory */
>  } AMDVIFaultReason;
>  
> +typedef struct amdvi_as_key {
> +    PCIBus *bus;
> +    uint8_t devfn;
> +} amdvi_as_key;
> +
>  uint64_t amdvi_extended_feature_register(AMDVIState *s)
>  {
>      uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;


Pls fix structure and typedef names according to the QEMU
coding style. Thanks!


> @@ -382,6 +387,44 @@ static guint amdvi_uint64_hash(gconstpointer v)
>      return (guint)*(const uint64_t *)v;
>  }
>  
> +static gboolean amdvi_as_equal(gconstpointer v1, gconstpointer v2)
> +{
> +    const struct amdvi_as_key *key1 = v1;
> +    const struct amdvi_as_key *key2 = v2;
> +
> +    return key1->bus == key2->bus && key1->devfn == key2->devfn;
> +}
> +
> +static guint amdvi_as_hash(gconstpointer v)
> +{
> +    const struct amdvi_as_key *key = v;
> +    guint bus = (guint)(uintptr_t)key->bus;
> +
> +    return (guint)(bus << 8 | (uint)key->devfn);
> +}
> +
> +static AMDVIAddressSpace *amdvi_as_lookup(AMDVIState *s, PCIBus *bus,
> +                                          uint8_t devfn)
> +{
> +    amdvi_as_key key = { .bus = bus, .devfn = devfn };
> +    return g_hash_table_lookup(s->address_spaces, &key);
> +}
> +
> +gboolean amdvi_find_as_by_devid(gpointer key, gpointer value,
> +                                  gpointer user_data)
> +{
> +    amdvi_as_key *as = (struct amdvi_as_key *)key;

this assignment does not need a cast I think.

> +    uint16_t devid = *((uint16_t *)user_data);

would be better like this:
	    uint16_t * devidp = user_data;
then just use *devidp instead of devid.


> +
> +    return devid == PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
> +}
> +
> +static AMDVIAddressSpace *amdvi_get_as_by_devid(AMDVIState *s, uint16_t devid)
> +{
> +    return g_hash_table_find(s->address_spaces,
> +                             amdvi_find_as_by_devid, &devid);
> +}
> +
>  static AMDVIIOTLBEntry *amdvi_iotlb_lookup(AMDVIState *s, hwaddr addr,
>                                             uint64_t devid)
>  {
> @@ -551,7 +594,7 @@ static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
>  
>  static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte)
>  {
> -    uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
> +    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
>      AMDVIState *s = as->iommu_state;
>  
>      if (!amdvi_get_dte(s, devid, dte)) {
> @@ -1011,25 +1054,15 @@ static void amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
>   */
>  static void amdvi_reset_address_translation_all(AMDVIState *s)
>  {
> -    AMDVIAddressSpace **iommu_as;
> -
> -    for (int bus_num = 0; bus_num < PCI_BUS_MAX; bus_num++) {
> +    AMDVIAddressSpace *iommu_as;
> +    GHashTableIter as_it;
>  
> -        /* Nothing to do if there are no devices on the current bus */
> -        if (!s->address_spaces[bus_num]) {
> -            continue;
> -        }
> -        iommu_as = s->address_spaces[bus_num];
> +    g_hash_table_iter_init(&as_it, s->address_spaces);
>  
> -        for (int devfn = 0; devfn < PCI_DEVFN_MAX; devfn++) {
> -
> -            if (!iommu_as[devfn]) {
> -                continue;
> -            }
> -            /* Use passthrough as default mode after reset */
> -            iommu_as[devfn]->addr_translation = false;
> -            amdvi_switch_address_space(iommu_as[devfn]);
> -        }
> +    while (g_hash_table_iter_next(&as_it, NULL, (void **)&iommu_as)) {
> +        /* Use passhthrough as default mode after reset */
> +        iommu_as->addr_translation = false;
> +        amdvi_switch_address_space(iommu_as);
>      }
>  }
>  
> @@ -1089,27 +1122,15 @@ static void enable_nodma_mode(AMDVIAddressSpace *as)
>   */
>  static void amdvi_update_addr_translation_mode(AMDVIState *s, uint16_t devid)
>  {
> -    uint8_t bus_num, devfn, dte_mode;
> +    uint8_t dte_mode;
>      AMDVIAddressSpace *as;
>      uint64_t dte[4] = { 0 };
>      int ret;
>  
> -    /*
> -     * Convert the devid encoded in the command to a bus and devfn in
> -     * order to retrieve the corresponding address space.
> -     */
> -    bus_num = PCI_BUS_NUM(devid);
> -    devfn = devid & 0xff;
> -
> -    /*
> -     * The main buffer of size (AMDVIAddressSpace *) * (PCI_BUS_MAX) has already
> -     * been allocated within AMDVIState, but must be careful to not access
> -     * unallocated devfn.
> -     */
> -    if (!s->address_spaces[bus_num] || !s->address_spaces[bus_num][devfn]) {
> +    as = amdvi_get_as_by_devid(s, devid);
> +    if (!as) {
>          return;
>      }
> -    as = s->address_spaces[bus_num][devfn];
>  
>      ret = amdvi_as_to_dte(as, dte);
>  
> @@ -1783,7 +1804,7 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
>                                 bool is_write, IOMMUTLBEntry *ret)
>  {
>      AMDVIState *s = as->iommu_state;
> -    uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
> +    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
>      AMDVIIOTLBEntry *iotlb_entry = amdvi_iotlb_lookup(s, addr, devid);
>      uint64_t entry[4];
>      int dte_ret;
> @@ -1858,7 +1879,7 @@ static IOMMUTLBEntry amdvi_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
>      }
>  
>      amdvi_do_translate(as, addr, flag & IOMMU_WO, &ret);
> -    trace_amdvi_translation_result(as->bus_num, PCI_SLOT(as->devfn),
> +    trace_amdvi_translation_result(pci_bus_num(as->bus), PCI_SLOT(as->devfn),
>              PCI_FUNC(as->devfn), addr, ret.translated_addr);
>      return ret;
>  }
> @@ -2222,30 +2243,28 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>  {
>      char name[128];
>      AMDVIState *s = opaque;
> -    AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
> -    int bus_num = pci_bus_num(bus);
> +    AMDVIAddressSpace *amdvi_dev_as;
> +    amdvi_as_key *key;
>  
> -    iommu_as = s->address_spaces[bus_num];
> +    amdvi_dev_as = amdvi_as_lookup(s, bus, devfn);
>  
>      /* allocate memory during the first run */
> -    if (!iommu_as) {
> -        iommu_as = g_new0(AMDVIAddressSpace *, PCI_DEVFN_MAX);
> -        s->address_spaces[bus_num] = iommu_as;
> -    }
> -
> -    /* set up AMD-Vi region */
> -    if (!iommu_as[devfn]) {
> +    if (!amdvi_dev_as) {
>          snprintf(name, sizeof(name), "amd_iommu_devfn_%d", devfn);
>  
> -        iommu_as[devfn] = g_new0(AMDVIAddressSpace, 1);
> -        iommu_as[devfn]->bus_num = (uint8_t)bus_num;
> -        iommu_as[devfn]->devfn = (uint8_t)devfn;
> -        iommu_as[devfn]->iommu_state = s;
> -        iommu_as[devfn]->notifier_flags = IOMMU_NOTIFIER_NONE;
> -        iommu_as[devfn]->iova_tree = iova_tree_new();
> -        iommu_as[devfn]->addr_translation = false;
> +        amdvi_dev_as = g_new0(AMDVIAddressSpace, 1);
> +        key = g_new0(amdvi_as_key, 1);
>  
> -        amdvi_dev_as = iommu_as[devfn];
> +        amdvi_dev_as->bus = bus;
> +        amdvi_dev_as->devfn = (uint8_t)devfn;
> +        amdvi_dev_as->iommu_state = s;
> +        amdvi_dev_as->notifier_flags = IOMMU_NOTIFIER_NONE;
> +        amdvi_dev_as->iova_tree = iova_tree_new();
> +        amdvi_dev_as->addr_translation = false;
> +        key->bus = bus;
> +        key->devfn = devfn;
> +
> +        g_hash_table_insert(s->address_spaces, key, amdvi_dev_as);
>  
>          /*
>           * Memory region relationships looks like (Address range shows
> @@ -2288,7 +2307,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>  
>          amdvi_switch_address_space(amdvi_dev_as);
>      }
> -    return &iommu_as[devfn]->as;
> +    return &amdvi_dev_as->as;
>  }
>  
>  static const PCIIOMMUOps amdvi_iommu_ops = {
> @@ -2329,7 +2348,7 @@ static int amdvi_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
>      if (!s->dma_remap && (new & IOMMU_NOTIFIER_MAP)) {
>          error_setg_errno(errp, ENOTSUP,
>              "device %02x.%02x.%x requires dma-remap=1",
> -            as->bus_num, PCI_SLOT(as->devfn), PCI_FUNC(as->devfn));
> +            pci_bus_num(as->bus), PCI_SLOT(as->devfn), PCI_FUNC(as->devfn));
>          return -ENOTSUP;
>      }
>  
> @@ -2510,6 +2529,9 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>      s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
>                                       amdvi_uint64_equal, g_free, g_free);
>  
> +    s->address_spaces = g_hash_table_new_full(amdvi_as_hash,
> +                                     amdvi_as_equal, g_free, g_free);
> +
>      /* set up MMIO */
>      memory_region_init_io(&s->mr_mmio, OBJECT(s), &mmio_mem_ops, s,
>                            "amdvi-mmio", AMDVI_MMIO_SIZE);
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index daf82fc85f96..38471b95d153 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -408,7 +408,7 @@ struct AMDVIState {
>      bool mmio_enabled;
>  
>      /* for each served device */
> -    AMDVIAddressSpace **address_spaces[PCI_BUS_MAX];
> +    GHashTable *address_spaces;
>  
>      /* list of address spaces with registered notifiers */
>      QLIST_HEAD(, AMDVIAddressSpace) amdvi_as_with_notifiers;
> -- 
> 2.34.1



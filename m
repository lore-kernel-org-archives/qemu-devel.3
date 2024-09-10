Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55CAEB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so2F1-0001fr-32; Tue, 10 Sep 2024 10:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so2Ez-0001Z1-BP
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:53:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so2Ex-0003kF-7y
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725979989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jqcY5zTpyBajee0NjYvZqsjXACtG4fGsKZkHyxgnBNo=;
 b=LDgO0YyWG1tlqh0DD8AuaCKnpfaspW7Ef0cfz4D4JTCJ1XvozfV/JzL8MTzedkon6CvwDB
 QWnlgCUqYyJ3Q7nadayGbQk0cPL8nbwcc48hlfwe3NCkXBIEs0YRzucLi9Zh5qRnMofXAu
 vtreSck33Lk+g91NjudGX4RPMBSkV+M=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-i9Wx8VvyNvGmYyHfly-pFQ-1; Tue, 10 Sep 2024 10:53:08 -0400
X-MC-Unique: i9Wx8VvyNvGmYyHfly-pFQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5365b801741so4213627e87.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725979987; x=1726584787;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jqcY5zTpyBajee0NjYvZqsjXACtG4fGsKZkHyxgnBNo=;
 b=A3d3byEvhTY1f3O88YViaZH8nEnl42/DCizvyHsGpJ+wBZJ2gQqswXUbj3lW/lQG4m
 8ZYVlAFXpZlldDkI9Ex/qRVn/+qAoStivD3z3Wprj2FFTRgg5eSPr2zGQC2qS4uyYoBF
 5eMnJcHZDl4GlhRwaXmMqjR7gxOdjL91Oe1pC9L/FTgYQzWQjPeOPmiJaXhAt3e9+M1Q
 QSML6lbWm+P5b6XqN0MZVnwvnZeJ87y0A68xTXGLIVn32ukkb04RJDCBMsCoE2e7kGM/
 Y/NDWKugH7bqwCK4wQilP9ei3LYvAE2++BFAN9lO4bu8uraXyVnZGdjq7lJ3yHyB7Sab
 Pteg==
X-Gm-Message-State: AOJu0YxFSBXklfAECsGGk08sd4SxA80PTCfUjStoV4IuW2b2v5om36xT
 7T9S+WlF4d11fNSoaC8uxN/tlZXDg4L46dTx6aDHhqrujELMROGOQ1KBFSw8QeZNw9YMK6x/l4W
 x4JCNosWTvx0+BY0YtadikT33IUdiwh1VUV85xlzONeuob3lSm/2j
X-Received: by 2002:a05:6512:b88:b0:536:53d1:850d with SMTP id
 2adb3069b0e04-536587f848emr13088364e87.39.1725979986721; 
 Tue, 10 Sep 2024 07:53:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLzaPfrTZCub1pgymWhfXu5knEnh+te7rbHLXqoo6D0px7E3sOrx/pkkgGy90rAK774GdxpA==
X-Received: by 2002:a05:6512:b88:b0:536:53d1:850d with SMTP id
 2adb3069b0e04-536587f848emr13088280e87.39.1725979985522; 
 Tue, 10 Sep 2024 07:53:05 -0700 (PDT)
Received: from redhat.com ([31.187.78.63]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c7286esm485445866b.138.2024.09.10.07.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 07:53:04 -0700 (PDT)
Date: Tue, 10 Sep 2024 10:53:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 stefanha@redhat.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] softmmu: Support concurrent bounce buffers
Message-ID: <20240910105002-mutt-send-email-mst@kernel.org>
References: <20240819135455.2957406-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240819135455.2957406-1-mnissler@rivosinc.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Aug 19, 2024 at 06:54:54AM -0700, Mattias Nissler wrote:
> When DMA memory can't be directly accessed, as is the case when
> running the device model in a separate process without shareable DMA
> file descriptors, bounce buffering is used.
> 
> It is not uncommon for device models to request mapping of several DMA
> regions at the same time. Examples include:
>  * net devices, e.g. when transmitting a packet that is split across
>    several TX descriptors (observed with igb)
>  * USB host controllers, when handling a packet with multiple data TRBs
>    (observed with xhci)
> 
> Previously, qemu only provided a single bounce buffer per AddressSpace
> and would fail DMA map requests while the buffer was already in use. In
> turn, this would cause DMA failures that ultimately manifest as hardware
> errors from the guest perspective.
> 
> This change allocates DMA bounce buffers dynamically instead of
> supporting only a single buffer. Thus, multiple DMA mappings work
> correctly also when RAM can't be mmap()-ed.
> 
> The total bounce buffer allocation size is limited individually for each
> AddressSpace. The default limit is 4096 bytes, matching the previous
> maximum buffer size. A new x-max-bounce-buffer-size parameter is
> provided to configure the limit for PCI devices.
> 
> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Acked-by: Peter Xu <peterx@redhat.com>
> ---
> This patch is split out from my "Support message-based DMA in vfio-user server"
> series. With the series having been partially applied, I'm splitting this one
> out as the only remaining patch to system emulation code in the hope to
> simplify getting it landed. The code has previously been reviewed by Stefan
> Hajnoczi and Peter Xu. This latest version includes changes to switch the
> bounce buffer size bookkeeping to `size_t` as requested and LGTM'd by Phil in
> v9.
> ---
>  hw/pci/pci.c                |  8 ++++
>  include/exec/memory.h       | 14 +++----
>  include/hw/pci/pci_device.h |  3 ++
>  system/memory.c             |  5 ++-
>  system/physmem.c            | 82 ++++++++++++++++++++++++++-----------
>  5 files changed, 76 insertions(+), 36 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index fab86d0567..d2caf3ee8b 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -85,6 +85,8 @@ static Property pci_props[] = {
>                      QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
>      DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
>                      QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> +    DEFINE_PROP_SIZE32("x-max-bounce-buffer-size", PCIDevice,
> +                     max_bounce_buffer_size, DEFAULT_MAX_BOUNCE_BUFFER_SIZE),
>      DEFINE_PROP_END_OF_LIST()
>  };
>  

I'm a bit puzzled by now there being two fields named
max_bounce_buffer_size, one directly controllable by
a property.

Pls add code comments explaining how they are related.


Also, what is the point of adding a property without
making it part of an API? No one will be able to rely on
it working.




> @@ -1204,6 +1206,8 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>                         "bus master container", UINT64_MAX);
>      address_space_init(&pci_dev->bus_master_as,
>                         &pci_dev->bus_master_container_region, pci_dev->name);
> +    pci_dev->bus_master_as.max_bounce_buffer_size =
> +        pci_dev->max_bounce_buffer_size;
>  
>      if (phase_check(PHASE_MACHINE_READY)) {
>          pci_init_bus_master(pci_dev);
> @@ -2633,6 +2637,10 @@ static void pci_device_class_init(ObjectClass *klass, void *data)
>      k->unrealize = pci_qdev_unrealize;
>      k->bus_type = TYPE_PCI_BUS;
>      device_class_set_props(k, pci_props);
> +    object_class_property_set_description(
> +        klass, "x-max-bounce-buffer-size",
> +        "Maximum buffer size allocated for bounce buffers used for mapped "
> +        "access to indirect DMA memory");
>  }
>  
>  static void pci_device_class_base_init(ObjectClass *klass, void *data)
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 296fd068c0..e5e865d1a9 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1084,13 +1084,7 @@ typedef struct AddressSpaceMapClient {
>      QLIST_ENTRY(AddressSpaceMapClient) link;
>  } AddressSpaceMapClient;
>  
> -typedef struct {
> -    MemoryRegion *mr;
> -    void *buffer;
> -    hwaddr addr;
> -    hwaddr len;
> -    bool in_use;
> -} BounceBuffer;
> +#define DEFAULT_MAX_BOUNCE_BUFFER_SIZE (4096)
>  
>  /**
>   * struct AddressSpace: describes a mapping of addresses to #MemoryRegion objects
> @@ -1110,8 +1104,10 @@ struct AddressSpace {
>      QTAILQ_HEAD(, MemoryListener) listeners;
>      QTAILQ_ENTRY(AddressSpace) address_spaces_link;
>  
> -    /* Bounce buffer to use for this address space. */
> -    BounceBuffer bounce;
> +    /* Maximum DMA bounce buffer size used for indirect memory map requests */
> +    size_t max_bounce_buffer_size;
> +    /* Total size of bounce buffers currently allocated, atomically accessed */
> +    size_t bounce_buffer_size;
>      /* List of callbacks to invoke when buffers free up */
>      QemuMutex map_client_list_lock;
>      QLIST_HEAD(, AddressSpaceMapClient) map_client_list;
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index 15694f2489..91df40f989 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -167,6 +167,9 @@ struct PCIDevice {
>      /* ID of standby device in net_failover pair */
>      char *failover_pair_id;
>      uint32_t acpi_index;
> +
> +    /* Maximum DMA bounce buffer size used for indirect memory map requests */
> +    uint32_t max_bounce_buffer_size;
>  };
>  
>  static inline int pci_intx(PCIDevice *pci_dev)
> diff --git a/system/memory.c b/system/memory.c
> index 5e6eb459d5..f6f6fee6d8 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -3148,7 +3148,8 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
>      as->ioeventfds = NULL;
>      QTAILQ_INIT(&as->listeners);
>      QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
> -    as->bounce.in_use = false;
> +    as->max_bounce_buffer_size = DEFAULT_MAX_BOUNCE_BUFFER_SIZE;
> +    as->bounce_buffer_size = 0;
>      qemu_mutex_init(&as->map_client_list_lock);
>      QLIST_INIT(&as->map_client_list);
>      as->name = g_strdup(name ? name : "anonymous");
> @@ -3158,7 +3159,7 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
>  
>  static void do_address_space_destroy(AddressSpace *as)
>  {
> -    assert(!qatomic_read(&as->bounce.in_use));
> +    assert(qatomic_read(&as->bounce_buffer_size) == 0);
>      assert(QLIST_EMPTY(&as->map_client_list));
>      qemu_mutex_destroy(&as->map_client_list_lock);
>  
> diff --git a/system/physmem.c b/system/physmem.c
> index 94600a33ec..971bfa0855 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3095,6 +3095,20 @@ void cpu_flush_icache_range(hwaddr start, hwaddr len)
>                                       NULL, len, FLUSH_CACHE);
>  }
>  
> +/*
> + * A magic value stored in the first 8 bytes of the bounce buffer struct. Used
> + * to detect illegal pointers passed to address_space_unmap.
> + */
> +#define BOUNCE_BUFFER_MAGIC 0xb4017ceb4ffe12ed
> +
> +typedef struct {
> +    uint64_t magic;
> +    MemoryRegion *mr;
> +    hwaddr addr;
> +    size_t len;
> +    uint8_t buffer[];
> +} BounceBuffer;
> +
>  static void
>  address_space_unregister_map_client_do(AddressSpaceMapClient *client)
>  {
> @@ -3120,9 +3134,9 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh)
>      QEMU_LOCK_GUARD(&as->map_client_list_lock);
>      client->bh = bh;
>      QLIST_INSERT_HEAD(&as->map_client_list, client, link);
> -    /* Write map_client_list before reading in_use.  */
> +    /* Write map_client_list before reading bounce_buffer_size. */
>      smp_mb();
> -    if (!qatomic_read(&as->bounce.in_use)) {
> +    if (qatomic_read(&as->bounce_buffer_size) < as->max_bounce_buffer_size) {
>          address_space_notify_map_clients_locked(as);
>      }
>  }
> @@ -3251,28 +3265,40 @@ void *address_space_map(AddressSpace *as,
>      mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
>  
>      if (!memory_access_is_direct(mr, is_write)) {
> -        if (qatomic_xchg(&as->bounce.in_use, true)) {
> +        size_t used = qatomic_read(&as->bounce_buffer_size);
> +        for (;;) {
> +            hwaddr alloc = MIN(as->max_bounce_buffer_size - used, l);
> +            size_t new_size = used + alloc;
> +            size_t actual =
> +                qatomic_cmpxchg(&as->bounce_buffer_size, used, new_size);
> +            if (actual == used) {
> +                l = alloc;
> +                break;
> +            }
> +            used = actual;
> +        }
> +
> +        if (l == 0) {
>              *plen = 0;
>              return NULL;
>          }
> -        /* Avoid unbounded allocations */
> -        l = MIN(l, TARGET_PAGE_SIZE);
> -        as->bounce.buffer = qemu_memalign(TARGET_PAGE_SIZE, l);
> -        as->bounce.addr = addr;
> -        as->bounce.len = l;
>  
> +        BounceBuffer *bounce = g_malloc0(l + sizeof(BounceBuffer));
> +        bounce->magic = BOUNCE_BUFFER_MAGIC;
>          memory_region_ref(mr);
> -        as->bounce.mr = mr;
> +        bounce->mr = mr;
> +        bounce->addr = addr;
> +        bounce->len = l;
> +
>          if (!is_write) {
>              flatview_read(fv, addr, MEMTXATTRS_UNSPECIFIED,
> -                          as->bounce.buffer, l);
> +                          bounce->buffer, l);
>          }
>  
>          *plen = l;
> -        return as->bounce.buffer;
> +        return bounce->buffer;
>      }
>  
> -
>      memory_region_ref(mr);
>      *plen = flatview_extend_translation(fv, addr, len, mr, xlat,
>                                          l, is_write, attrs);
> @@ -3287,12 +3313,11 @@ void *address_space_map(AddressSpace *as,
>  void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
>                           bool is_write, hwaddr access_len)
>  {
> -    if (buffer != as->bounce.buffer) {
> -        MemoryRegion *mr;
> -        ram_addr_t addr1;
> +    MemoryRegion *mr;
> +    ram_addr_t addr1;
>  
> -        mr = memory_region_from_host(buffer, &addr1);
> -        assert(mr != NULL);
> +    mr = memory_region_from_host(buffer, &addr1);
> +    if (mr != NULL) {
>          if (is_write) {
>              invalidate_and_set_dirty(mr, addr1, access_len);
>          }
> @@ -3302,15 +3327,22 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
>          memory_region_unref(mr);
>          return;
>      }
> +
> +
> +    BounceBuffer *bounce = container_of(buffer, BounceBuffer, buffer);
> +    assert(bounce->magic == BOUNCE_BUFFER_MAGIC);
> +
>      if (is_write) {
> -        address_space_write(as, as->bounce.addr, MEMTXATTRS_UNSPECIFIED,
> -                            as->bounce.buffer, access_len);
> -    }
> -    qemu_vfree(as->bounce.buffer);
> -    as->bounce.buffer = NULL;
> -    memory_region_unref(as->bounce.mr);
> -    /* Clear in_use before reading map_client_list.  */
> -    qatomic_set_mb(&as->bounce.in_use, false);
> +        address_space_write(as, bounce->addr, MEMTXATTRS_UNSPECIFIED,
> +                            bounce->buffer, access_len);
> +    }
> +
> +    qatomic_sub(&as->bounce_buffer_size, bounce->len);
> +    bounce->magic = ~BOUNCE_BUFFER_MAGIC;
> +    memory_region_unref(bounce->mr);
> +    g_free(bounce);
> +    /* Write bounce_buffer_size before reading map_client_list. */
> +    smp_mb();
>      address_space_notify_map_clients(as);
>  }
>  
> -- 
> 2.34.1



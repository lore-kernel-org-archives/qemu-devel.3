Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7544EC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Asy-0003lo-DM; Wed, 15 May 2024 05:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1s7Asx-0003jl-7U
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:25:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1s7Asv-0000Ga-AJ
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715765116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O2J5Y6ZEP+TpfFuzBsfImrHvYbZQpARMLzeFKHkXYAI=;
 b=fltHWslIUGVFkODqghzpXA1HSzEALzaTCvxSKdc+c1C3QbR0NFrKkWGldDYK2lW7vggDRH
 iAC+G348o1Dx5pwX96f/a8s/wuvs9ljpMn4P9pgQ3qwWJ4zH8iOaD531jCe2Nc91LgEYjw
 3mzq0SO6Qf1WBgVS/aPeUvLbzm/OfGo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-3nsoNcXCNFaYZdlGWcAAMQ-1; Wed, 15 May 2024 05:25:15 -0400
X-MC-Unique: 3nsoNcXCNFaYZdlGWcAAMQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-43e0e0dab52so70397051cf.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715765114; x=1716369914;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O2J5Y6ZEP+TpfFuzBsfImrHvYbZQpARMLzeFKHkXYAI=;
 b=CZ8tsot0cAQYcziN0ZAZnsc4/t9GTeuuD10jJBjCLVhhdKNpYbTbQQNcleKeYuSxUD
 thxDkZICK/kY1exbxkjRZY/CWCCqZSvHpacrUyAlQfsZ8RC4wsWkPTWP/xTIJZUJ86XI
 s0Q8bqojjOzLI+dy9S76hua0nOb+qHLIIUEsrpwVaJ17gpuRQqDl+Zyy/Tk5ZO8KB/kS
 kHOfmsVhDFIaqluMrzjYhcyBeJ3GOZmextmHN9Vk/Z/i4rcCNa3F6kr5YzZhaSJSi6UQ
 czZEXFpj9j1YSmuLv7iB+z+8RDok8bfjlt9LeNMDfOoE3zr3QsWcBFehmqlSBh3ZucM3
 BZwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5jSrJZ1y8XmIhosaPJC5Cdo7ey1cJU+Yfike5Jib3lyJD9IjBMV7bF+TegfUr+23MKo2+lAZSo5gK5UmS0N2ov7HlATQ=
X-Gm-Message-State: AOJu0Yx4aHWGGQwUw/Du3nbZ+caMKfkqL0G4j1jsJnqw3P9j1zU874Og
 0LpZaNUTv41E0Im7cUfI2oP3L8LAuTCQtOLTYwm4oCBW09DTxZIcjiI8cZB4GOYaGHRR/XD7rkZ
 5eOLQCS7FtiQ/hTwMEl40XSNzpM0Rc/HzAbDD14o7c9jeFNBkYDTy
X-Received: by 2002:a05:622a:178c:b0:439:b523:46e4 with SMTP id
 d75a77b69052e-43dfce573c3mr247746661cf.32.1715765114486; 
 Wed, 15 May 2024 02:25:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTGWqpEBTl1PVthefT0kkFyvq9cpLaazi+SeD7vz2xnlnq70nPEzzfHHSO/k9Pvw733cm5hQ==
X-Received: by 2002:a05:622a:178c:b0:439:b523:46e4 with SMTP id
 d75a77b69052e-43dfce573c3mr247746471cf.32.1715765114093; 
 Wed, 15 May 2024 02:25:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43df54f216esm81324251cf.31.2024.05.15.02.25.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 02:25:13 -0700 (PDT)
Message-ID: <17e133f9-36ff-4a17-8a38-dbe5a6278b9d@redhat.com>
Date: Wed, 15 May 2024 11:25:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/9] memory: Add Error** argument to
 memory_get_xlat_addr()
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20240514153130.394307-1-clg@redhat.com>
 <20240514153130.394307-8-clg@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240514153130.394307-8-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 5/14/24 17:31, Cédric Le Goater wrote:
> Let the callers do the reporting. This will be useful in
> vfio_iommu_map_dirty_notify().
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
> 
>  Changes in v6:
> 
>  - Fixed memory_get_xlat_addr documentation (Avihai)
>  
>  include/exec/memory.h  | 15 ++++++++++++++-
>  hw/vfio/common.c       | 13 +++++++++----
>  hw/virtio/vhost-vdpa.c |  5 ++++-
>  system/memory.c        | 10 +++++-----
>  4 files changed, 32 insertions(+), 11 deletions(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index d417d7f363dbbca6553c449582a93d5da73cca40..9cdd64e9c69b63f9d27cebc2e8cb366e22ed7577 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -774,9 +774,22 @@ void ram_discard_manager_register_listener(RamDiscardManager *rdm,
>  void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>                                               RamDiscardListener *rdl);
>  
> +/**
> + * memory_get_xlat_addr: Extract addresses from a TLB entry
> + *
> + * @iotlb: pointer to an #IOMMUTLBEntry
> + * @vaddr: virtual address
> + * @ram_addr: RAM address
> + * @read_only: indicates if writes are allowed
> + * @mr_has_discard_manager: indicates memory is controlled by a
> + *                          RamDiscardManager
> + * @errp: pointer to Error*, to store an error if it happens.
> + *
> + * Return: true on success, else false setting @errp with error.
> + */
>  bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>                            ram_addr_t *ram_addr, bool *read_only,
> -                          bool *mr_has_discard_manager);
> +                          bool *mr_has_discard_manager, Error **errp);
>  
>  typedef struct CoalescedMemoryRange CoalescedMemoryRange;
>  typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 4e2ef3d3034e72aa6a546bcb9ea1f31a0bbd5b1b..919c4c52bc1590fd6c0bda37ba5881f58ff2ffff 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -253,12 +253,13 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>  
>  /* Called with rcu_read_lock held.  */
>  static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
> -                               ram_addr_t *ram_addr, bool *read_only)
> +                               ram_addr_t *ram_addr, bool *read_only,
> +                               Error **errp)
>  {
>      bool ret, mr_has_discard_manager;
>  
>      ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
> -                               &mr_has_discard_manager);
> +                               &mr_has_discard_manager, errp);
>      if (ret && mr_has_discard_manager) {
>          /*
>           * Malicious VMs might trigger discarding of IOMMU-mapped memory. The
> @@ -288,6 +289,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>      hwaddr iova = iotlb->iova + giommu->iommu_offset;
>      void *vaddr;
>      int ret;
> +    Error *local_err = NULL;
>  
>      trace_vfio_iommu_map_notify(iotlb->perm == IOMMU_NONE ? "UNMAP" : "MAP",
>                                  iova, iova + iotlb->addr_mask);
> @@ -304,7 +306,8 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>      if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>          bool read_only;
>  
> -        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only)) {
> +        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &local_err)) {
> +            error_report_err(local_err);
>              goto out;
>          }
>          /*
> @@ -1213,6 +1216,7 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>      VFIOContainerBase *bcontainer = giommu->bcontainer;
>      hwaddr iova = iotlb->iova + giommu->iommu_offset;
>      ram_addr_t translated_addr;
> +    Error *local_err = NULL;
>      int ret = -EINVAL;
>  
>      trace_vfio_iommu_map_dirty_notify(iova, iova + iotlb->addr_mask);
> @@ -1224,7 +1228,8 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>      }
>  
>      rcu_read_lock();
> -    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL)) {
> +    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
> +        error_report_err(local_err);
>          goto out_unlock;
>      }
>  
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index e827b9175fc61f1ef419e48d90a440b00449312a..ed99ab87457d8f31b98ace960713f48d47b27102 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -208,6 +208,7 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>      void *vaddr;
>      int ret;
>      Int128 llend;
> +    Error *local_err = NULL;
>  
>      if (iotlb->target_as != &address_space_memory) {
>          error_report("Wrong target AS \"%s\", only system memory is allowed",
> @@ -227,7 +228,9 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>      if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>          bool read_only;
>  
> -        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL)) {
> +        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL,
> +                                  &local_err)) {
> +            error_report_err(local_err);
>              return;
>          }
>          ret = vhost_vdpa_dma_map(s, VHOST_VDPA_GUEST_PA_ASID, iova,
> diff --git a/system/memory.c b/system/memory.c
> index 642a449f8c867d38c62a748a4dfd5c055637c205..9540caa8a1f4da8501bf5ae9d7eedde8b775e1dc 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2179,7 +2179,7 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>  /* Called with rcu_read_lock held.  */
>  bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>                            ram_addr_t *ram_addr, bool *read_only,
> -                          bool *mr_has_discard_manager)
> +                          bool *mr_has_discard_manager, Error **errp)
>  {
>      MemoryRegion *mr;
>      hwaddr xlat;
> @@ -2197,7 +2197,7 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>      mr = address_space_translate(&address_space_memory, iotlb->translated_addr,
>                                   &xlat, &len, writable, MEMTXATTRS_UNSPECIFIED);
>      if (!memory_region_is_ram(mr)) {
> -        error_report("iommu map to non memory area %" HWADDR_PRIx "", xlat);
> +        error_setg(errp, "iommu map to non memory area %" HWADDR_PRIx "", xlat);
>          return false;
>      } else if (memory_region_has_ram_discard_manager(mr)) {
>          RamDiscardManager *rdm = memory_region_get_ram_discard_manager(mr);
> @@ -2216,8 +2216,8 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>           * were already restored before IOMMUs are restored.
>           */
>          if (!ram_discard_manager_is_populated(rdm, &tmp)) {
> -            error_report("iommu map to discarded memory (e.g., unplugged via"
> -                         " virtio-mem): %" HWADDR_PRIx "",
> +            error_setg(errp, "iommu map to discarded memory (e.g., unplugged"
> +                         " via virtio-mem): %" HWADDR_PRIx "",
>                           iotlb->translated_addr);
>              return false;
>          }
> @@ -2228,7 +2228,7 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>       * check that it did not truncate too much.
>       */
>      if (len & iotlb->addr_mask) {
> -        error_report("iommu has granularity incompatible with target AS");
> +        error_setg(errp, "iommu has granularity incompatible with target AS");
>          return false;
>      }
>  
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric



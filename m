Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE75D2505B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 09:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfE1y-0004aT-6N; Mon, 12 Jan 2026 04:16:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vfE1q-0004XZ-MI
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 04:16:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vfE1m-0006WX-Sh
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 04:16:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768209356;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MWWWqeK64ec0+Sc+BsA42lXcR5YfvvX2aTtBOanWLHs=;
 b=hs/xf94Cr/YRqkX98yAy7BqSgFFw2fZetETf+/u9Epevsd+zW6uSHlfsLB4nVOr8io6RK+
 SBgSE9xE6IeS3vXkF213J4qpPgR9iwm0K7kKgEFBRpiCC7RoFEHLFTmfzppq2a7QPNA7gZ
 AFQVKdD+3lWI9yqqw7fPM1NOs0G077Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-YRVvMEw-MP6MPnmVY9F3Dg-1; Mon, 12 Jan 2026 04:15:55 -0500
X-MC-Unique: YRVvMEw-MP6MPnmVY9F3Dg-1
X-Mimecast-MFC-AGG-ID: YRVvMEw-MP6MPnmVY9F3Dg_1768209354
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-432a9ef3d86so3204477f8f.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 01:15:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768209354; x=1768814154;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MWWWqeK64ec0+Sc+BsA42lXcR5YfvvX2aTtBOanWLHs=;
 b=JLnij/lAUfkMg2UkgLQvi/TSf0SatOoF97Alh6J8atqnFRXPyHFLqNBbxnXMYsCPUX
 Q0WBudAxITQDzuftmBmD8p6TnBMvbDam0b7UwtdtN5XG0+kiIQqjLr/CFgfs7cQITIbt
 LMiraL7utBylyHGNoybKhuF6zK7oa01BQ+YSVf96JBnmDOrfQskmOI2kqfXr1eHrkI4v
 +MrbLoVwQgL+RXXfvOYc8DIXlq2eP4DIJD9ylyB39vzCNX58HeU4pLfab5/KqPJMJ7xO
 KeUeTWzAo5pAsJ/J7wHy8N1uXW+ucbsOLLePpgQAt3NUCRSxk/p2tQxAVvY78Ia8Ic8X
 cVLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXBV7rZhODL/0xFlbhFsMbEKTbZYc7ntCUKVuAzUfyKhsuJDk2vDkHrjGZ3V2rARxVUAhKUzVSdUqQ@nongnu.org
X-Gm-Message-State: AOJu0YwuOPPE0tDdx3LS12b3GCYWEjffDDWegktkZk/qkQoqnVwFwRg2
 sENhlFD6qSbb4jXMZHV0MQp2R7UMZLiQMjt6YnYvEIVUtY3leEN1TVpzhGwmjf/HW91vwnoRY2e
 j7gh2Kt3B6lxaSUDHdS359QZezJm7BO/cSZzYnz43m48BiSTUxesNg1cl
X-Gm-Gg: AY/fxX4mDJQpXeicci09LzEeoW3MViz/fackYtm0zAv8Go1enxTIi/N00ufK0UB1HN+
 z1Ihgs7TucwZbGtQQfdKdGAK/D3xxr9KkP5Za4QkmQ1nzY5Nx6w3zb7pK0E7eubF2Ju/mEk1my2
 jZPY/oKOnKZLlPexT1J3cMSmB3bApKoipiL2/q71sZkbkdn/720DuJ3SdfO7MNmLqF5XBWAmQve
 6gtRdq0CC7jasitFgpWHNi5z1I/yZeaMpWxEDTef+8ryXyGJxUq3gZQ6kbGs5oPyTYWEOuR6vGx
 7jMsuuxCKmBeZbqVhVPuhtKqhQueuDlI222/p9GDXQ+8HG78Zcux7AYERxU1g7BI2fb4vPjkPQp
 Q0B9zVYcVfYFzK0sSDYDp60CMtGE49uGsTlVhIeob9aEd/maYJDY3f2x5/Q==
X-Received: by 2002:a05:6000:1842:b0:42f:f627:3aa7 with SMTP id
 ffacd0b85a97d-432c3632b03mr18708415f8f.16.1768209353716; 
 Mon, 12 Jan 2026 01:15:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHB0HbCPjl3t9l4wLv7Dbaq3ryXmDzOT9tYzmC/ThaRXt0AgV61JTMXChMYrifEPtyjlUp5iw==
X-Received: by 2002:a05:6000:1842:b0:42f:f627:3aa7 with SMTP id
 ffacd0b85a97d-432c3632b03mr18708375f8f.16.1768209353254; 
 Mon, 12 Jan 2026 01:15:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ff0b2sm37510157f8f.42.2026.01.12.01.15.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 01:15:52 -0800 (PST)
Message-ID: <af8904cf-cce9-476f-be8a-34a85668cdb3@redhat.com>
Date: Mon, 12 Jan 2026 10:15:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, cohuck@redhat.com, mst@redhat.com,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jgg@nvidia.com,
 kjaju@nvidia.com
References: <20251222135357.143339-1-skolothumtho@nvidia.com>
 <20251222135357.143339-4-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251222135357.143339-4-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

Hi Shameer,

On 12/22/25 2:53 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Linux now provides a VFIO dmabuf exporter to expose PCI BAR memory for P2P
> use cases. Create a dmabuf for each mapped BAR region after the mmap is set
> up, and store the returned fd in the region’s RAMBlock. This allows QEMU to
> pass the fd to dma_map_file(), enabling iommufd to import the dmabuf and map
> the BAR correctly in the host IOMMU page table.

I tested the series with upstream kernel and your
master-smmuv3-accel-v6-veventq-v2-vcmdq-rfcv1-dmabuf-v1 branch

It works fine with Grace Hopper GPU passthrough, without cmdqv. However
with cmdqv, I get

qemu-system-aarch64: warning: IOMMU_IOAS_MAP failed: Bad address, PCI BAR?
qemu-system-aarch64: warning: vfio_container_dma_map(0xaaaea68471b0,
0xc090000, 0x10000, 0xffffb5c90000) = -14 (Bad address)
qemu-system-aarch64: warning: IOMMU_IOAS_MAP failed: Bad address, PCI BAR?

Maybe this is unrelated to this series and rather relates to the cmdqv one.

Wonder if you get the same warning, and in the positive, if the root
cause is understood and maybe fixed elsewhere.

Thank you in advance

Eric



>
> If the kernel lacks support or dmabuf setup fails, QEMU skips the setup
> and continues with normal mmap handling.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/vfio/region.c     | 57 +++++++++++++++++++++++++++++++++++++++++++-
>  hw/vfio/trace-events |  1 +
>  2 files changed, 57 insertions(+), 1 deletion(-)
>
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index b165ab0b93..6949f6779c 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -29,6 +29,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/units.h"
>  #include "monitor/monitor.h"
> +#include "system/ramblock.h"
>  #include "vfio-helpers.h"
>  
>  /*
> @@ -238,13 +239,52 @@ static void vfio_subregion_unmap(VFIORegion *region, int index)
>      region->mmaps[index].mmap = NULL;
>  }
>  
> +static int vfio_region_create_dma_buf(VFIORegion *region)
> +{
> +    g_autofree struct vfio_device_feature *feature = NULL;
> +    VFIODevice *vbasedev = region->vbasedev;
> +    struct vfio_device_feature_dma_buf *dma_buf;
> +    size_t total_size;
> +    int i, ret;
> +
> +    g_assert(region->nr_mmaps);
> +
> +    total_size = sizeof(*feature) + sizeof(*dma_buf) +
> +                 sizeof(struct vfio_region_dma_range) * region->nr_mmaps;
> +    feature = g_malloc0(total_size);
> +    *feature = (struct vfio_device_feature) {
> +        .argsz = total_size,
> +        .flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_DMA_BUF,
> +    };
> +
> +    dma_buf = (void *)feature->data;
> +    *dma_buf = (struct vfio_device_feature_dma_buf) {
> +        .region_index = region->nr,
> +        .open_flags = O_RDWR,
> +        .nr_ranges = region->nr_mmaps,
> +    };
> +
> +    for (i = 0; i < region->nr_mmaps; i++) {
> +        dma_buf->dma_ranges[i].offset = region->mmaps[i].offset;
> +        dma_buf->dma_ranges[i].length = region->mmaps[i].size;
> +    }
> +
> +    ret = vbasedev->io_ops->device_feature(vbasedev, feature);
> +    for (i = 0; i < region->nr_mmaps; i++) {
> +        trace_vfio_region_dmabuf(region->vbasedev->name, ret, region->nr,
> +                                 region->mem->name, region->mmaps[i].offset,
> +                                 region->mmaps[i].size);
> +    }
> +    return ret;
> +}
> +
>  int vfio_region_mmap(VFIORegion *region)
>  {
>      int i, ret, prot = 0;
>      char *name;
>      int fd;
>  
> -    if (!region->mem) {
> +    if (!region->mem || !region->nr_mmaps) {
>          return 0;
>      }
>  
> @@ -305,6 +345,21 @@ int vfio_region_mmap(VFIORegion *region)
>                                 region->mmaps[i].size - 1);
>      }
>  
> +    ret = vfio_region_create_dma_buf(region);
> +    if (ret < 0) {
> +        if (ret == -ENOTTY) {
> +            warn_report_once("VFIO dmabuf not supported in kernel");
> +        } else {
> +            error_report("%s: failed to create dmabuf: %s",
> +                         memory_region_name(region->mem), strerror(errno));
> +        }
> +    } else {
> +        MemoryRegion *mr = &region->mmaps[0].mem;
> +        RAMBlock *ram_block = mr->ram_block;
> +
> +        ram_block->fd = ret;
> +    }
> +
>      return 0;
>  
>  no_mmap:
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 1e895448cd..592a0349d4 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -117,6 +117,7 @@ vfio_device_put(int fd) "close vdev->fd=%d"
>  vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
>  vfio_region_read(char *name, int index, uint64_t addr, unsigned size, uint64_t data) " (%s:region%d+0x%"PRIx64", %d) = 0x%"PRIx64
>  vfio_region_setup(const char *dev, int index, const char *name, unsigned long flags, unsigned long offset, unsigned long size) "Device %s, region %d \"%s\", flags: 0x%lx, offset: 0x%lx, size: 0x%lx"
> +vfio_region_dmabuf(const char *dev, int fd, int index,  const char *name, unsigned long offset, unsigned long size) "Device %s, dmabuf fd %d region %d \"%s\", offset: 0x%lx, size: 0x%lx"
>  vfio_region_mmap_fault(const char *name, int index, unsigned long offset, unsigned long size, int fault) "Region %s mmaps[%d], [0x%lx - 0x%lx], fault: %d"
>  vfio_region_mmap(const char *name, unsigned long offset, unsigned long end) "Region %s [0x%lx - 0x%lx]"
>  vfio_region_exit(const char *name, int index) "Device %s, region %d"



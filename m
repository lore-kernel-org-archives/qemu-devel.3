Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0AACD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 12:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ2F3-000502-9t; Thu, 21 May 2026 08:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wQ2F0-0004ze-Gg
 for qemu-devel@nongnu.org; Thu, 21 May 2026 08:11:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wQ2Ey-0001H1-5X
 for qemu-devel@nongnu.org; Thu, 21 May 2026 08:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779365462;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ls/h+mBaYPKEcug4ENQoj5FSj8qrgO/Q/7qjGXBsW0=;
 b=ZzElLjCct18+64sulClNWQnC7GHK6QSrD4rvaKowr/52PxJ/tjtRCKIn/e4C50uBVuuc0D
 swe6MTceDQxTU2ToFjLIJdgYbvwk4Dc9209LRUSUFy16AsGy4WexsNKwYUa7DQeI+HFJmC
 /oUqpp07RVfhCbuMkBQvxnQuIDDx79U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-EeGxpHz7NA6yx39ZbREV-w-1; Thu, 21 May 2026 08:10:59 -0400
X-MC-Unique: EeGxpHz7NA6yx39ZbREV-w-1
X-Mimecast-MFC-AGG-ID: EeGxpHz7NA6yx39ZbREV-w_1779365459
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48fd233d1e2so55950815e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 05:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779365459; x=1779970259;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ls/h+mBaYPKEcug4ENQoj5FSj8qrgO/Q/7qjGXBsW0=;
 b=lop/MAsp98+GdLZqHjCiJjUvNs/5gFxv5y1TmstgvOYoT5QhDIKI36ZvsE+7j6EN7b
 +EbP5dT8VilqF159+z7206SiHGcqWIXkoDvdrWlvYZTE0x9RLkHSU3XNBbfmedq7yw6l
 y9mfTIFtLrEirp5yANG24sMWOapCEUgiF4L+fwK5yOiY14VRY8SC1Fm6t+Ta1kf9Cew7
 d39OGpqtfdg5itGpxQhabV3ODLdVUgcAVA1uKRLcW9EZkgKF47FHXg3wOP1lR/8le0Sf
 fEJlTL6p2P3pXw7IISTlkfPpTz7Sdf8NpdmwEaZIgpc1wLgz/THqIprkFpffOCSol8vb
 0x6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9iGgnEBvIqZeBUTcQQhbUJlb+72Lk/QUHx4szb0dWRnsu60KzXyJqJ8UfjOKhzgu0hCNSeB2B9JRAJ@nongnu.org
X-Gm-Message-State: AOJu0Yy35A9kgW5CQG2TYlEELGnpLmzMWVfUnabmLE+gW6r1PJtLxQQz
 Qcut72QOFGbfWR7lw9L/gB9BaQXJfejfi3JDjeIEMPHIXbh5ds4f6XKCoGJo0WJFUudR6+PTHJE
 842U5ys7pOAWofpOLkIB8+28xP5BadN+qsEOlQNYDkpZNVnSlWxHDv4iu
X-Gm-Gg: Acq92OGo7xZji0buVbKEuS45r97b57/e7hI2JgKfGqb6Kyr3B3WEDOvrTW75emKpkJF
 /37nVSc97o6ej3oQL51bY/3umHLuDW5PFy3joPrJ8SDffg424cxvr74G/nbj+N3+PIaepEE2YI+
 ZtFf+Dvm+ZfvHLbCYUOLsBeyxNp+dUqnQveNFC1aClbHOUWZxF6+0YYKrWq+7mJdiHFPD6oZVYO
 UlwFFIDWvdH9tVZkzmN+pZFR0as+M0upn4VTcNSUxRqWUNxaNducbW9oTORxPs9a1vezysr/Hc2
 SsEduP1GU0sLvHUzYbzL6ua0OAsuAj2yWpyFZOhsA/fzVJ9jTD77V3tyi8Nu0bN2DsCTofI5MiR
 VHGjRmQUCPeOwktsvL45/mgeHjZVibcuTW8qA9J8PpYCS1Mg1qCidVJlX/Tbc6teOsYwRziCqkM
 uVMlL0
X-Received: by 2002:a05:600c:a04:b0:48a:97b6:7420 with SMTP id
 5b1f17b1804b1-490360e46d3mr35720305e9.24.1779365458565; 
 Thu, 21 May 2026 05:10:58 -0700 (PDT)
X-Received: by 2002:a05:600c:a04:b0:48a:97b6:7420 with SMTP id
 5b1f17b1804b1-490360e46d3mr35719795e9.24.1779365458086; 
 Thu, 21 May 2026 05:10:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903cae778asm20189015e9.13.2026.05.21.05.10.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 05:10:57 -0700 (PDT)
Message-ID: <4c820b96-0426-4839-82ab-70fc2d146406@redhat.com>
Date: Thu, 21 May 2026 14:10:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 21/32] memory: Allow RAM device regions to skip IOMMU
 mapping
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, zhenzhong.duan@intel.com, kjaju@nvidia.com,
 phrdina@redhat.com
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-22-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260519103727.899332-22-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/19/26 12:36 PM, Shameer Kolothum wrote:
> Some RAM device regions created with memory_region_init_ram_device_ptr()
> are not intended to be P2P DMA targets.
>
> The VFIO listener currently treats all RAM device regions as DMA
> capable and attempts to map them into the IOMMU. For regions without
> dma-buf backing this fails and prints warnings such as:
>
>   IOMMU_IOAS_MAP failed: Bad address, PCI BAR?
>
> Introduce a MemoryRegion flag (ram_device_skip_iommu_map) to mark RAM
> device regions that should not be IOMMU mapped, paired with
> memory_region_skip_iommu_map() / memory_region_set_skip_iommu_map()
> accessors. When the flag is set, the VFIO listener skips DMA mapping
> for that region.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  include/system/memory.h | 21 +++++++++++++++++++++
>  hw/vfio/listener.c      |  4 ++++
>  system/memory.c         | 10 ++++++++++
>  3 files changed, 35 insertions(+)
>
> diff --git a/include/system/memory.h b/include/system/memory.h
> index af5f96f6ff..b11d6bf07f 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -864,6 +864,8 @@ struct MemoryRegion {
>  
>      /* For devices designed to perform re-entrant IO into their own IO MRs */
>      bool disable_reentrancy_guard;
> +    /* RAM device region that does not require IOMMU mapping for P2P */
> +    bool ram_device_skip_iommu_map;
>  };
>  
>  struct IOMMUMemoryRegion {
> @@ -1743,6 +1745,25 @@ static inline bool memory_region_is_romd(const MemoryRegion *mr)
>   */
>  bool memory_region_is_protected(const MemoryRegion *mr);
>  
> +/**
> + * memory_region_skip_iommu_map: check whether a memory region is excluded
> + *                               from IOMMU mapping
> + *
> + * Returns %true if @mr is a RAM device region marked to skip IOMMU mapping.
> + *
> + * @mr: the memory region being queried
> + */
> +bool memory_region_skip_iommu_map(const MemoryRegion *mr);
> +
> +/**
> + * memory_region_set_skip_iommu_map: mark a RAM device region to skip IOMMU
> + *                                   mapping
> + *
> + * @mr: the memory region being modified
> + * @skip: %true to skip IOMMU mapping, %false to allow it
> + */
> +void memory_region_set_skip_iommu_map(MemoryRegion *mr, bool skip);
> +
>  /**
>   * memory_region_has_guest_memfd: check whether a memory region has guest_memfd
>   *     associated
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index 0b72a2cf5e..18100e9897 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -610,6 +610,10 @@ void vfio_container_region_add(VFIOContainer *bcontainer,
>          }
>      }
>  
> +    if (memory_region_skip_iommu_map(section->mr)) {
Maybe add a trace-point just as above
trace_vfio_listener_region_add_no_dma_map()

Otherwise looks good to me.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> +        return;
> +    }
> +
>      ret = vfio_container_dma_map(bcontainer, iova, int128_get64(llsize),
>                                   vaddr, section->readonly, section->mr);
>      if (ret) {
> diff --git a/system/memory.c b/system/memory.c
> index 739ba11da6..48245fd01b 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -1814,6 +1814,16 @@ bool memory_region_is_protected(const MemoryRegion *mr)
>      return mr->ram && (mr->ram_block->flags & RAM_PROTECTED);
>  }
>  
> +bool memory_region_skip_iommu_map(const MemoryRegion *mr)
> +{
> +    return memory_region_is_ram_device(mr) && mr->ram_device_skip_iommu_map;
> +}
> +
> +void memory_region_set_skip_iommu_map(MemoryRegion *mr, bool skip)
> +{
> +    mr->ram_device_skip_iommu_map = skip;
> +}
> +
>  bool memory_region_has_guest_memfd(const MemoryRegion *mr)
>  {
>      return mr->ram_block && mr->ram_block->guest_memfd >= 0;



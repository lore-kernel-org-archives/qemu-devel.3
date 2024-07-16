Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95D7C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 13:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTiMD-0008UD-5R; Tue, 16 Jul 2024 09:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTiM5-0007w6-TU
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:36:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTiM3-0005dA-8k
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721136990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8LxoCTSacOcmZzMl59QCloTIhad2CEE15AxchhRxxBc=;
 b=N+78Q1BMClEIdFlWvJDhGdAZX+WnrPBuM4YX9VbRJAuURNeQoiPTUpCVooSxRQOdQkov9z
 lrUvApS8jVI8P6oJISRdrt2NqB0JYXzDA1XLhTlXVuZyueXPKVTj5MhyfmJ8/ljCdCNjkz
 t2Lxv0/Ouj0bzK1/h5wYCPsN6hzK7H4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-SSAAJDvfNRq9YXKP9FU52w-1; Tue, 16 Jul 2024 09:36:28 -0400
X-MC-Unique: SSAAJDvfNRq9YXKP9FU52w-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3679ab94cdbso3486752f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 06:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721136987; x=1721741787;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8LxoCTSacOcmZzMl59QCloTIhad2CEE15AxchhRxxBc=;
 b=sTeojoeZCw0ZMoPyOyjgcU5oI0EAZiHHH8+0JNvixI8eszhEeY4yDqNvRHLWmWZwMX
 g7t6wko1b2v5174CF2zpqEiagaHZKuOLtERhEkMMnJvQIu737y2PbKAZmzylmuOi8ymh
 xp5h7R9pDrW03FwKZxariLFk5hJy8OAfqHAUfsLkJXAMXhr5kUYUl1qi6yTZjAjXfDky
 Sep4+cMAUnwNgWTS5TBUODiuDctcEQZLQf3k6CqMJy9V6pmt5w2x3oRinw77KolZyCvu
 dmPONbI3DVovgDN2oTGqMIq+Mr/YUy7qUV+SpQ+iy3X3Ft68WOWGTa3jHeqo3d5eKGN+
 JxgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp6gJgR/kaJnhItEIcMoiZl9RrsMfzosKcTa674ZrX8cIIDhu85RRBhXKcN6foNgwz3gCM40SCf0OgPNO1CjbBMMUIzJM=
X-Gm-Message-State: AOJu0Yxqe9NTku7+ZKQfZYeLslRIVwWNza+arbrN/J6fDCH5eUyyDX87
 k9x2SgMXDVrMngPTV1eDMrLy4w2rNhNLabuLcThBHX2CSsiJ9NvniZ5emhpUPM7tpYq0h8OwCS0
 UvmKzbF82NWKctIsL+45tePIA40wgdXlNCBcMbI+JyLRXMsXHCsr4
X-Received: by 2002:a5d:574b:0:b0:367:9237:611d with SMTP id
 ffacd0b85a97d-3682635cc47mr1522344f8f.60.1721136987730; 
 Tue, 16 Jul 2024 06:36:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMq2Y2R1rQqETSxq6AXso1RFyZ1Az4WRt5znXYdoTQzigy5if8KLOUAoRruy+9ZMu04T1tCg==
X-Received: by 2002:a5d:574b:0:b0:367:9237:611d with SMTP id
 ffacd0b85a97d-3682635cc47mr1522330f8f.60.1721136987365; 
 Tue, 16 Jul 2024 06:36:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:26c5:842:8baa:576b?
 ([2a01:e0a:9e2:9000:26c5:842:8baa:576b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680daccad8sm9108296f8f.60.2024.07.16.06.36.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 06:36:26 -0700 (PDT)
Message-ID: <186f5ab0-3933-4897-be1e-edee8cb91ae9@redhat.com>
Date: Tue, 16 Jul 2024 15:36:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] hw/vfio/common: Add vfio_listener_region_del_iommu
 trace event
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 jean-philippe@linaro.org, peter.maydell@linaro.org,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com, jasowang@redhat.com
Cc: yanghliu@redhat.com
References: <20240716094619.1713905-1-eric.auger@redhat.com>
 <20240716094619.1713905-6-eric.auger@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240716094619.1713905-6-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 7/16/24 11:45, Eric Auger wrote:
> Trace when VFIO gets notified about the deletion of an IOMMU MR.
> Also trace the name of the region in the add_iommu trace message.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/common.c     | 3 ++-
>   hw/vfio/trace-events | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 6d15b36e0b..cfc44a4569 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -599,7 +599,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
>           IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
>           int iommu_idx;
>   
> -        trace_vfio_listener_region_add_iommu(iova, end);
> +        trace_vfio_listener_region_add_iommu(section->mr->name, iova, end);
>           /*
>            * FIXME: For VFIO iommu types which have KVM acceleration to
>            * avoid bouncing all map/unmaps through qemu this way, this
> @@ -725,6 +725,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
>       if (memory_region_is_iommu(section->mr)) {
>           VFIOGuestIOMMU *giommu;
>   
> +        trace_vfio_listener_region_del_iommu(section->mr->name);
>           QLIST_FOREACH(giommu, &bcontainer->giommu_list, giommu_next) {
>               if (MEMORY_REGION(giommu->iommu_mr) == section->mr &&
>                   giommu->n.start == section->offset_within_region) {
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index e16179b507..98bd4dccea 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -95,7 +95,8 @@ vfio_region_read(char *name, int index, uint64_t addr, unsigned size, uint64_t d
>   vfio_iommu_map_notify(const char *op, uint64_t iova_start, uint64_t iova_end) "iommu %s @ 0x%"PRIx64" - 0x%"PRIx64
>   vfio_listener_region_skip(const char *name, uint64_t start, uint64_t end) "SKIPPING %s 0x%"PRIx64" - 0x%"PRIx64
>   vfio_spapr_group_attach(int groupfd, int tablefd) "Attached groupfd %d to liobn fd %d"
> -vfio_listener_region_add_iommu(uint64_t start, uint64_t end) "region_add [iommu] 0x%"PRIx64" - 0x%"PRIx64
> +vfio_listener_region_add_iommu(const char* name, uint64_t start, uint64_t end) "region_add [iommu] %s 0x%"PRIx64" - 0x%"PRIx64
> +vfio_listener_region_del_iommu(const char *name) "region_del [iommu] %s"
>   vfio_listener_region_add_ram(uint64_t iova_start, uint64_t iova_end, void *vaddr) "region_add [ram] 0x%"PRIx64" - 0x%"PRIx64" [%p]"
>   vfio_known_safe_misalignment(const char *name, uint64_t iova, uint64_t offset_within_region, uintptr_t page_size) "Region \"%s\" iova=0x%"PRIx64" offset_within_region=0x%"PRIx64" qemu_real_host_page_size=0x%"PRIxPTR
>   vfio_listener_region_add_no_dma_map(const char *name, uint64_t iova, uint64_t size, uint64_t page_size) "Region \"%s\" 0x%"PRIx64" size=0x%"PRIx64" is not aligned to 0x%"PRIx64" and cannot be mapped for DMA"



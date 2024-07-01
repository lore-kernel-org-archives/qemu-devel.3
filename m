Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934B8C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 20:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sONJz-0000vY-D5; Mon, 01 Jul 2024 16:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sONJs-0000uf-Oi
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 16:08:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sONJr-0006ih-3y
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 16:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719864489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9lWbyZwchYtAOT8Zdf/tSo6hD879WtfwPr9e9f4EYjc=;
 b=SWU+KmOYfmeIurhRYU/RvkHHSbx9rtLUakjiWipEPj5M88+9d/FNqXhRhia0B6Ce5axQ30
 EYYCF0ZgX1yaw4DqbS0fabr3ZGVKyLcgpbpmN4Nha3X0LCASWCm4pCPwWumDiVe8KAGojP
 ViHNfFKYRmnWJt1V3H7EfhwzawFqlLg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-7hMYQ11DOvKd3IfhyVQuyQ-1; Mon, 01 Jul 2024 16:08:07 -0400
X-MC-Unique: 7hMYQ11DOvKd3IfhyVQuyQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3673ce35cc7so1963796f8f.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 13:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719864485; x=1720469285;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9lWbyZwchYtAOT8Zdf/tSo6hD879WtfwPr9e9f4EYjc=;
 b=vgXIGooYn5qeqL40GvuwJP+3D6TXmmVpry+KH3m4oV91IKURxsDlvoUF1f4dFlMTQe
 H1DJpuAqxN3ByTvWFClI4KNprF3UONCC3L9vEWP2BcCCI4Yx3EXKYgYBaKuQwNv90SX3
 LZ3CjX1Tb7xLVJ3QUPi8ChnGTHGKPNMrwg03oCD7t9iBsbbXWXC4BqAP02ZCquv4mkH1
 3/1vWsUPYXbwDRntQdkkv4IytT2170mGe7u5rCH4NKIQ+ZJ+TpyGG/FYqPtBXWL/PPsh
 qXp+O4KHPVHkOLjS6HFSyEYXT7p1ZrO7XbOqV0hAryjRPZYySPQevISmrkq1SPuW3V6H
 dl7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs02GBh37+Gd9B/NjbiYFuSAJnOqmANVaP2YMN092FzXnvG+YwfGktRJCByumUTrr+t3JJ0pAatgruyYwaPJXFKBw70vc=
X-Gm-Message-State: AOJu0Yx6bCGR6wjJUQMLqjlpLcK/XGweFzgDcgMqDgnOgUAM9Fq9sT9U
 wL+ZzQVYDCitXPFZpPN0vKHN7t9fEZiXVbXrLB8wuvBqdkGhl74mgW4WH8zLWQetEE+yIyoMX6J
 GU8/Hje42goAW8UwJMJnWGqKCu3AXqu5+V1hEhK1xf/VOBNvamkWn
X-Received: by 2002:a5d:6890:0:b0:360:9436:b928 with SMTP id
 ffacd0b85a97d-367756aae29mr4569361f8f.27.1719864485590; 
 Mon, 01 Jul 2024 13:08:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGbcrDVWbwzxPbpNiA/kXtrnsJ7gEkehUrSrWDHRFC8sfe6Ef+NUaBb8Ism4SN5Sc3Myb5Uw==
X-Received: by 2002:a5d:6890:0:b0:360:9436:b928 with SMTP id
 ffacd0b85a97d-367756aae29mr4569340f8f.27.1719864484972; 
 Mon, 01 Jul 2024 13:08:04 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a1129ccsm10964601f8f.117.2024.07.01.13.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 13:08:04 -0700 (PDT)
Date: Mon, 1 Jul 2024 16:07:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, peter.maydell@linaro.org, clg@redhat.com,
 yanghliu@redhat.com, zhenzhong.duan@intel.com, alex.williamson@redhat.com
Subject: Re: [PATCH 0/7] VIRTIO-IOMMU/HostIOMMUDevice: Fixes and page size
 mask rework
Message-ID: <20240701160734-mutt-send-email-mst@kernel.org>
References: <20240626082727.1278530-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626082727.1278530-1-eric.auger@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Jun 26, 2024 at 10:26:45AM +0200, Eric Auger wrote:
> The 2 first patches are fixes of
> cf2647a76e ("virtio-iommu: Compute host reserved regions")
> They can be taken separately of the rest.
> 
> Then the series uses the HostIOMMUDevice interface to fetch
> information about the page size mask supported along the assigned
> device and propagate it to the virtio-iommu. This is a similar
> work as what was done in
> 
> VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling series
> 
> but this time for the page size mask. Using this new
> infrastructure allows to handle page size mask conflicts
> earlier on device hotplug as opposed to current QEMU
> abort:
> 
> qemu-system-aarch64: virtio-iommu virtio-iommu-memory-region-8-0
> does not support frozen granule 0x10000
> qemu: hardware error: vfio: DMA mapping failed, unable to continue
> 
> With this series the hotplug nicely fails.
> 
> Also this allows to remove hacks consisting in transiently enabling
> IOMMU MRs to collect coldplugged device page size mask before machine
> init. Those hacks were introduced by
> 
> 94df5b2180d6 ("virtio-iommu: Fix 64kB host page size VFIO device
> assignment")
> 
> The series can be found at:
> https://github.com/eauger/qemu/tree/virtio-iommu-psmask-rework-v1


virtio things:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Feel free to merge.

> 
> Eric Auger (7):
>   virtio-iommu: Fix error handling in
>     virtio_iommu_set_host_iova_ranges()
>   vfio-container-base: Introduce vfio_container_get_iova_ranges() helper
>   HostIOMMUDevice : remove Error handle from get_iova_ranges callback
>   HostIOMMUDevice: Introduce get_page_size_mask() callback
>   virtio-iommu : Retrieve page size mask on
>     virtio_iommu_set_iommu_device()
>   memory: remove IOMMU MR iommu_set_page_size_mask() callback
>   virtio-iommu: Revert transient enablement of IOMMU MR in bypass mode
> 
>  include/exec/memory.h                 |  38 --------
>  include/hw/vfio/vfio-container-base.h |   9 ++
>  include/sysemu/host_iommu_device.h    |  11 ++-
>  hw/vfio/common.c                      |   8 --
>  hw/vfio/container-base.c              |  15 ++++
>  hw/vfio/container.c                   |  16 ++--
>  hw/vfio/iommufd.c                     |  21 +++--
>  hw/virtio/virtio-iommu.c              | 121 +++++++++++++-------------
>  system/memory.c                       |  13 ---
>  hw/virtio/trace-events                |   2 +-
>  10 files changed, 117 insertions(+), 137 deletions(-)
> 
> -- 
> 2.41.0



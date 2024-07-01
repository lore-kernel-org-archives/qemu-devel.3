Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5975CC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 21:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOOMP-0007FC-0r; Mon, 01 Jul 2024 17:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOOMM-0007EO-Pb
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 17:14:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOOML-0007cb-77
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 17:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719868488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3fY9NGJXUfh+G8Fe4Rnm80jIH0RR/F/rmrmGUiwg7dk=;
 b=aaUDD1ekX8jQSmfvqjpgIL+K9xGiKuiUu5GaFAjbnsJK3xuUqQaRtBjzhLwfHiaUYHvcX5
 pLkH0DvKHZBt6CIcWbojyqz3hpg20VKG/XI9Gcogo+PQRyT4lJrotiW2WWOXIkkmhUWZzA
 vCVVLdrFt3bMBMkloS/ZdtIDEBufcuU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-NYoYfs5bM4SOFL6puAtEvw-1; Mon, 01 Jul 2024 17:14:46 -0400
X-MC-Unique: NYoYfs5bM4SOFL6puAtEvw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4257dd7d40dso9553535e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 14:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719868483; x=1720473283;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3fY9NGJXUfh+G8Fe4Rnm80jIH0RR/F/rmrmGUiwg7dk=;
 b=VXg2lv6ntSEeA9+egvcAm1FAKpjKiS9GJkJXcNCQ0vKT/SoLrNWXs3LB08Z9V4Rv6D
 u+K8QKvJf8WdId6Bzh94sQAE5xXgt0VO/IjDVGDk8WgXGpGWXbkdC01DvuEYWZzxr7cD
 1/5tibrc6NC//WuakuTemHz47cZiYNR88yhhtfeaaXWCqtG0TrhQ3b31Fuv1sn7V9hS7
 elkti2CyGHnGunk6Dq0DLysMba6TGnoKnotefxUiXXW0bO/12srEq8Op9bENoJnFWr2c
 9P+PSndaFkZq9bTyZ9MiWiyRHqm2AAfHE5uJHdhrG++twCyxFgfvJLPFImE2ANkvIXrz
 bN4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUuL9UfY4en6NILRzzilCn9wcn9TSyeGo6uSt0OweOhnCJ0MYPPrAwVJ/QimsWH9Kq9oxyPmZ7B2SQ22LmWjEsEq74zK0=
X-Gm-Message-State: AOJu0Yx1SIlUeyK7iIt9lK9SxuuZ9fV9SFVlt8Wa+cO9AwLcLzKnQgt4
 mPFkQF9AkjdeCaTBj/3dmgq2/DsVd1Kmd7zFg1GrNsNtVUjuD1DG54eiFsokLYRxnGv29zgk9WP
 T7aD01FrO3/BG7SVS90GlnY/UYtpiJBNyn5ONVdRCheRSSiy8FlRa
X-Received: by 2002:a05:600c:1c21:b0:424:8be4:f2c with SMTP id
 5b1f17b1804b1-4257984de8fmr59809475e9.2.1719868483724; 
 Mon, 01 Jul 2024 14:14:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTPQ+fw3ONtxgOJ/bJuHDBXmkSZQpGZLzyd2pHO5LdL5BArfHueyhpDgMQigs4ieYiCQC/cg==
X-Received: by 2002:a05:600c:1c21:b0:424:8be4:f2c with SMTP id
 5b1f17b1804b1-4257984de8fmr59809275e9.2.1719868483153; 
 Mon, 01 Jul 2024 14:14:43 -0700 (PDT)
Received: from redhat.com ([176.12.141.208]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b068e93sm169796125e9.24.2024.07.01.14.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 14:14:42 -0700 (PDT)
Date: Mon, 1 Jul 2024 17:14:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, peter.maydell@linaro.org, clg@redhat.com,
 yanghliu@redhat.com, zhenzhong.duan@intel.com, alex.williamson@redhat.com
Subject: Re: [PATCH v2 0/7] VIRTIO-IOMMU/HostIOMMUDevice: Fixes and page size
 mask rework
Message-ID: <20240701171314-mutt-send-email-mst@kernel.org>
References: <20240701084957.1567641-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240701084957.1567641-1-eric.auger@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jul 01, 2024 at 10:48:52AM +0200, Eric Auger wrote:
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
> https://github.com/eauger/qemu/tree/virtio-iommu-psmask-rework-v2


So presumably will be merged with rest of host iommu stuff.
For virtio bits:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>



> ---
> v1 -> v2:
> - Don't update mask if the granule is frozen (Zhenzhong)
> - Collected Zhenzhong's and Cédric's R-bs
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
>  hw/virtio/virtio-iommu.c              | 123 +++++++++++++-------------
>  system/memory.c                       |  13 ---
>  hw/virtio/trace-events                |   2 +-
>  10 files changed, 119 insertions(+), 137 deletions(-)
> 
> -- 
> 2.41.0



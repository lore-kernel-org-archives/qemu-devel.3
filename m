Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684B0C27C65
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 09:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF9Nx-00057w-8B; Thu, 06 Jun 2024 05:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sF9Nu-000574-V8
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:26:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sF9Ns-0005bC-VG
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717665971;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ac/fZ78v49GhfEeAwQ7tuikMxslFv4opWtJvubpPu0o=;
 b=iMEAPaFGMaOqlo6HkoYIdjGhZyQYyrwxpzWtQkC2DIAmBBGFf+DHl8RPZCKcBaAUjmIsqs
 wSA2SOWTBAxnUMvhlUY1vi/BLXISwdXtB8P2Y6JIOn3X73NEEnI04RO18wn7dhtjAXleiN
 Y80nfhBAkl8BAFicKO1lyZI7bkelMwU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-bSyGFneTMliiYjYI1uQS1w-1; Thu, 06 Jun 2024 05:26:10 -0400
X-MC-Unique: bSyGFneTMliiYjYI1uQS1w-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4401cbc8964so6103111cf.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 02:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717665970; x=1718270770;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ac/fZ78v49GhfEeAwQ7tuikMxslFv4opWtJvubpPu0o=;
 b=FAFcLC4yRoB3Ft6LYix/nauYBBEfNrO6nmGVvMucTp72fzzgcjqlS6IWTqTI+mSAXa
 jFQm8/CwqTp7QMuxpnxWNcEWjeKet3Nv+NxD1h3VL0Ss32hR6ETiJL7kNeXF+r5VTksK
 iqoDHe1268Yc4se119oXJC7HYc/YLieYEgbaJ5gAVrPJoJFc3wSrY4x3KkR6R5/QFyRf
 Sa1E+M2xjJQbcaHFZS1C7TUY4stZxuDAqQgsMHn2mM6EOu71JvT0m1IkLF31vDCa+daY
 QE3Y7us+9Cq5yEwjxHq2/RjmCF8yO8sW/xVaJs5ugi7khSX6tMEoge0mdm3RowT61FdN
 4Lzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsgGSME28PeMYczMtZG/NjluywL25SczBIWMstm5vLItQSxQxW9KcDq4kZ40oX0E8tEKPYNigK4lpVMhl0yywtNBD50LQ=
X-Gm-Message-State: AOJu0YwfcJ3tsA++T11MrexcTybz4Wv4PjeRnGKVjrrsetPUKiYKqGJM
 UQouX6bzDivB6D87VfGGg+DU9Kito+ntmQOrqaPgMFx7u9lGbDpspPJXBIgnu2w4t20rEcsZmbT
 3jonLXh4/kCHu4kwQYECqy77fitOa1B7sakuKfMv5RhTTvG1bpxqY
X-Received: by 2002:ac8:58d0:0:b0:43b:14a:fa65 with SMTP id
 d75a77b69052e-4402b5bbc8amr53727451cf.28.1717665969666; 
 Thu, 06 Jun 2024 02:26:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8t0JqCBo9uhHuVvONvzD9vDrGZtKzEnXF5GYe5EFkbna/OQ6kEjMBwz8UdBk4WbNRddltLQ==
X-Received: by 2002:ac8:58d0:0:b0:43b:14a:fa65 with SMTP id
 d75a77b69052e-4402b5bbc8amr53727321cf.28.1717665969259; 
 Thu, 06 Jun 2024 02:26:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44038a72a35sm3430091cf.29.2024.06.06.02.26.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 02:26:08 -0700 (PDT)
Message-ID: <09ba18e0-9d91-4e04-b291-0412d00a108d@redhat.com>
Date: Thu, 6 Jun 2024 11:26:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/19] vfio/iommufd: Implement
 HostIOMMUDeviceClass::realize() handler
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-10-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240603061023.269738-10-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Zhenzhong,
On 6/3/24 08:10, Zhenzhong Duan wrote:
> It calls iommufd_backend_get_device_info() to get host IOMMU
> related information and translate it into HostIOMMUDeviceCaps
> for query with .get_cap().
>
> Introduce macro VTD_MGAW_FROM_CAP to get MGAW which equals to
> (aw_bits - 1).
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/hw/i386/intel_iommu.h |  1 +
>  hw/vfio/iommufd.c             | 37 +++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
>
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 7fa0a695c8..7d694b0813 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -47,6 +47,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IntelIOMMUState, INTEL_IOMMU_DEVICE)
>  #define VTD_HOST_AW_48BIT           48
>  #define VTD_HOST_ADDRESS_WIDTH      VTD_HOST_AW_39BIT
>  #define VTD_HAW_MASK(aw)            ((1ULL << (aw)) - 1)
> +#define VTD_MGAW_FROM_CAP(cap)      ((cap >> 16) & 0x3fULL)
>  
>  #define DMAR_REPORT_F_INTR          (1)
>  
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index e4a507d55c..9d2e95e20e 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -25,6 +25,7 @@
>  #include "qemu/cutils.h"
>  #include "qemu/chardev_open.h"
>  #include "pci.h"
> +#include "hw/i386/intel_iommu_internal.h"
>  
>  static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>                              ram_addr_t size, void *vaddr, bool readonly)
> @@ -619,6 +620,41 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
>      vioc->pci_hot_reset = iommufd_cdev_pci_hot_reset;
>  };
>  
> +static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
> +                                      Error **errp)
> +{
> +    VFIODevice *vdev = opaque;
I think it would make sense to store vdev in hiod. This would allow to
postpone some computations in the HostIOMMUDevice ops instead of doing
everything in the realize.
For instance to retrieve the usable iova_ranges I will need to access
the base container in the associated ops.

Thanks

Eric
> +    HostIOMMUDeviceCaps *caps = &hiod->caps;
> +    enum iommu_hw_info_type type;
> +    union {
> +        struct iommu_hw_info_vtd vtd;
> +    } data;
> +
> +    if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
> +                                         &type, &data, sizeof(data), errp)) {
> +        return false;
> +    }
> +
> +    caps->type = type;
> +
> +    switch (type) {
> +    case IOMMU_HW_INFO_TYPE_INTEL_VTD:
> +        caps->aw_bits = VTD_MGAW_FROM_CAP(data.vtd.cap_reg) + 1;
> +        break;
> +    case IOMMU_HW_INFO_TYPE_NONE:
> +        break;
> +    }
> +
> +    return true;
> +}
> +
> +static void hiod_iommufd_vfio_class_init(ObjectClass *oc, void *data)
> +{
> +    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
> +
> +    hiodc->realize = hiod_iommufd_vfio_realize;
> +};
> +
>  static const TypeInfo types[] = {
>      {
>          .name = TYPE_VFIO_IOMMU_IOMMUFD,
> @@ -627,6 +663,7 @@ static const TypeInfo types[] = {
>      }, {
>          .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO,
>          .parent = TYPE_HOST_IOMMU_DEVICE_IOMMUFD,
> +        .class_init = hiod_iommufd_vfio_class_init,
>      }
>  };
>  



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4A7C41513
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 15:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJEFV-0008BX-NH; Mon, 17 Jun 2024 11:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJEFS-0008Az-RU
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 11:26:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJEFR-0006uJ-1m
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 11:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718637979;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VnSCWeVxn7zg3hYu9Q/BnNZi4CJ43g6VuZ8rEsweTSA=;
 b=hWbj2Nh2o2vr+M6UYDFw+eO55BfRFB8dyUVzhqfM+wrXEP0rzwhOeR5zWHrz9PDpqJV5En
 9vw6cGQcTSVF1OQdbn4CFs/8hwnEP5oO7ZO/xb/hLV6/88XeIT9YqYIcP+7AiqrUmWfSfC
 BWTK7QfzxfOcw845kvt92L3GmJpcFCc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-sEgzlhBEM8y7hSl02ejV2w-1; Mon, 17 Jun 2024 11:26:17 -0400
X-MC-Unique: sEgzlhBEM8y7hSl02ejV2w-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-440cfb095c1so50006081cf.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 08:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718637977; x=1719242777;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VnSCWeVxn7zg3hYu9Q/BnNZi4CJ43g6VuZ8rEsweTSA=;
 b=gQA/xSsE6AzFSO6IT859XyvcLzPbZJ0foMpMYkxd7aOA2vVDCCNmr7c+8TEbpv18YS
 2tKBn+UWN0SC5P4S/Mb+kSV0+Sv/+T2boAkycvNWhiNEaC/Xgr9V2mNUPZv6ntV4Tr5V
 rSftbMFQiEhlD/GX4hr8K6N1cf2s14A2Hhaqin+Gk4ngetIcg++Y07DOS7HrN5t7CpUG
 slpEWT/OF4wXZyhBeE8igGBsdaHkrf7U5J7cO8frpakce3U0jpPMqgjGCPn7vIVB7ghy
 gT2vGZjFvuReI1EdMKf/+lDzaffMSTQ8MnoEGz3AOaCazA1pxMApBlcXUvQK7qqInwCk
 7rUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6VuH7eckBk+X/r+PcmimYZrKdTheW6uaKLLIkWq8BZYpizPfkw8WHLt4Til8WJ41OVhZ7hJSp55uRyeNtpA5gNFscwSE=
X-Gm-Message-State: AOJu0Yxh8JYRcoz1JRtgb/6D6VXLvhOhZsyfy6U6RzdQInZnIdS1UbFe
 R5I5cc1KLAN9XuyGAxgsgKg6gvgcQdTzvhzdOtv5GJhb2GMV2hTqyGKiaq8C11pKj1iSozCZwii
 0qSw54ffTvtcLA0XiFpS1laPYiGolqTLnvn9w1WVeNcCS3s22he5d
X-Received: by 2002:a05:622a:130a:b0:43a:b542:d1dd with SMTP id
 d75a77b69052e-44216af8850mr101902931cf.36.1718637976752; 
 Mon, 17 Jun 2024 08:26:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDveHBqha6E2NivvGGBu3xjdk79caGUKl2eSkiLegZ37rTpNAed5JUyZlMiWDh23F+eNg2ww==
X-Received: by 2002:a05:622a:130a:b0:43a:b542:d1dd with SMTP id
 d75a77b69052e-44216af8850mr101902181cf.36.1718637975574; 
 Mon, 17 Jun 2024 08:26:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-441ef3d89c7sm47256291cf.20.2024.06.17.08.26.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 08:26:14 -0700 (PDT)
Message-ID: <72ecc243-3841-44a0-a5b9-e98249889158@redhat.com>
Date: Mon, 17 Jun 2024 17:26:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/17] vfio/container: Change VFIOContainerBase to use
 QOM
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240617063409.34393-1-clg@redhat.com>
 <20240617063409.34393-12-clg@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240617063409.34393-12-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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



On 6/17/24 08:34, Cédric Le Goater wrote:
> VFIOContainerBase was made a QOM interface because we believed that a
> QOM object would expose all the IOMMU backends to the QEMU machine and
> human interface. This only applies to user creatable devices or objects.
>
> Change the VFIOContainerBase nature from interface to object and make
> the necessary adjustments in the VFIO_IOMMU hierarchy.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  include/hw/vfio/vfio-common.h         |  4 ++++
>  include/hw/vfio/vfio-container-base.h | 12 +++---------
>  hw/vfio/container-base.c              |  4 +++-
>  hw/vfio/container.c                   |  1 +
>  hw/vfio/iommufd.c                     |  1 +
>  hw/vfio/spapr.c                       |  3 +++
>  6 files changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 825d80130bd435fe50830c8ae5b7905d18104dd6..e8ddf92bb18547f0d3b811b3d757cbae7fec8b8d 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -84,6 +84,8 @@ typedef struct VFIOContainer {
>      QLIST_HEAD(, VFIOGroup) group_list;
>  } VFIOContainer;
>  
> +OBJECT_DECLARE_SIMPLE_TYPE(VFIOContainer, VFIO_IOMMU_LEGACY);
> +
>  typedef struct VFIOHostDMAWindow {
>      hwaddr min_iova;
>      hwaddr max_iova;
> @@ -99,6 +101,8 @@ typedef struct VFIOIOMMUFDContainer {
>      uint32_t ioas_id;
>  } VFIOIOMMUFDContainer;
>  
> +OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
> +
>  typedef struct VFIODeviceOps VFIODeviceOps;
>  
>  typedef struct VFIODevice {
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index d505f63607ec40e6aa44aeb3e20848ac780562a1..b079b76f68975c5701a289ce9012e912a8e44fc6 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -34,6 +34,7 @@ typedef struct VFIOAddressSpace {
>   * This is the base object for vfio container backends
>   */
>  typedef struct VFIOContainerBase {
> +    Object parent;
>      const VFIOIOMMUClass *ops;
>      VFIOAddressSpace *space;
>      MemoryListener listener;
> @@ -96,17 +97,10 @@ void vfio_container_destroy(VFIOContainerBase *bcontainer);
>  #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
>  #define TYPE_VFIO_IOMMU_IOMMUFD TYPE_VFIO_IOMMU "-iommufd"
>  
> -/*
> - * VFIOContainerBase is not an abstract QOM object because it felt
> - * unnecessary to expose all the IOMMU backends to the QEMU machine
> - * and human interface. However, we can still abstract the IOMMU
> - * backend handlers using a QOM interface class. This provides more
> - * flexibility when referencing the various implementations.
> - */
> -DECLARE_CLASS_CHECKERS(VFIOIOMMUClass, VFIO_IOMMU, TYPE_VFIO_IOMMU)
> +OBJECT_DECLARE_TYPE(VFIOContainerBase, VFIOIOMMUClass, VFIO_IOMMU)
>  
>  struct VFIOIOMMUClass {
> -    InterfaceClass parent_class;
> +    ObjectClass parent_class;
>  
>      /* Properties */
>      const char *hiod_typename;
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 280f0dd2db1fc3939fe9925ce00a2c50d0e14196..98c15e174dd78df5146ee83c05c98f3ea9c1e52c 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -102,8 +102,10 @@ void vfio_container_destroy(VFIOContainerBase *bcontainer)
>  static const TypeInfo types[] = {
>      {
>          .name = TYPE_VFIO_IOMMU,
> -        .parent = TYPE_INTERFACE,
> +        .parent = TYPE_OBJECT,
> +        .instance_size = sizeof(VFIOContainerBase),
>          .class_size = sizeof(VFIOIOMMUClass),
> +        .abstract = true,
>      },
>  };
>  
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 31bdc46a96d1626b237227a25007957e1d472757..3ae52530a9b500bd53ec9f9e66c73253d97c9aba 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -1196,6 +1196,7 @@ static const TypeInfo types[] = {
>      {
>          .name = TYPE_VFIO_IOMMU_LEGACY,
>          .parent = TYPE_VFIO_IOMMU,
> +        .instance_size = sizeof(VFIOContainer),
>          .class_init = vfio_iommu_legacy_class_init,
>      }, {
>          .name = TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO,
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index e5d9334142418514215528b9523f12c031792c7f..3e9d642034c2d2234ea701952c94a78ab32e9147 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -672,6 +672,7 @@ static const TypeInfo types[] = {
>      {
>          .name = TYPE_VFIO_IOMMU_IOMMUFD,
>          .parent = TYPE_VFIO_IOMMU,
> +        .instance_size = sizeof(VFIOIOMMUFDContainer),
>          .class_init = vfio_iommu_iommufd_class_init,
>      }, {
>          .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO,
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 47b040f1bcca7dd0b5cf052d941b43541e98a3c5..018bd2048194a6a2db83ed740025a7060181698f 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -30,6 +30,8 @@ typedef struct VFIOSpaprContainer {
>      QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
>  } VFIOSpaprContainer;
>  
> +OBJECT_DECLARE_SIMPLE_TYPE(VFIOSpaprContainer, VFIO_IOMMU_SPAPR);
> +
>  static bool vfio_prereg_listener_skipped_section(MemoryRegionSection *section)
>  {
>      if (memory_region_is_iommu(section->mr)) {
> @@ -548,6 +550,7 @@ static const TypeInfo types[] = {
>      {
>          .name = TYPE_VFIO_IOMMU_SPAPR,
>          .parent = TYPE_VFIO_IOMMU_LEGACY,
> +        .instance_size = sizeof(VFIOSpaprContainer),
>          .class_init = vfio_iommu_spapr_class_init,
>      },
>  };



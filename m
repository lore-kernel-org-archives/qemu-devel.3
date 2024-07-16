Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23A5C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 10:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTfIq-00087G-Eh; Tue, 16 Jul 2024 06:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTfIk-0007vb-HZ
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:20:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTfIi-0006rM-Ae
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721125249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IRlPA3hGcL0l41Y26Jo1wjexwu96pE/V8Rh+gKlaJA4=;
 b=LCZG+6jA7VkeFRP670rKrwfzErpDusV8Pl0faduo6PdfyW1pmV2Ix/Dw5ki0+bspZmwo3q
 LBCrS3avDOVFb1yQuo3WmpEFm4vmz1c/vR/n31VVwcxh/gO7T1e9R2pabZamCViCktVXmu
 TfCf0OdlNHZVsQw57oo87eECNZdgatM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-y2MHnHuXNHav_oY1ItcnOQ-1; Tue, 16 Jul 2024 06:20:48 -0400
X-MC-Unique: y2MHnHuXNHav_oY1ItcnOQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-79f06a617a4so925444985a.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 03:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721125247; x=1721730047;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IRlPA3hGcL0l41Y26Jo1wjexwu96pE/V8Rh+gKlaJA4=;
 b=CZYSlZZAuwmqRzXVLbuG6DI5G4nrhiCgv9E2XW+LVdzNovZezIOJxSA2WNItjCUH7O
 /uImLf5PcNaCYcDLPrQTAvcB8efELAsHRrYzxP2WJ25mVsvCazIy+ngQqM37fYiwZZ8a
 K/0isssZrmUNTdMk4RbyyH0icI3LWz7rzd4SBmaXgufkC4nN8EIp48Nfcw1AtrryFqAP
 uCuM635y4fcmpnQg+81ygJEB0aUD0P/9v/ol9uNXUXp3bf4BZi64BoMYnBXz7KLrSOqB
 f56SVPBxLUlqLtcqfeCCfp37bN44EvOOqK38u2YzjBtwxTtpWcegNoWGG6CAuc037UAV
 wJ/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAqTcsQb9K7x9JKHlerloMekQDyjD9VGsCSK0e1GaAl5gzqv82p322CvkPyoxqJL0ieQrczXfdl7bA/IUS34/QsGmyRk4=
X-Gm-Message-State: AOJu0YxHT8QBEuGN5ym+qBaPr66m/Ongyw+sTymCZvHwzt5lI5Q9BCYQ
 so8cFUByphe1SDK858UqDndN7UepDiTF03u36Itwmca0sTmTGoQ+0gsHn1lMlSD5FvR/OiuqJB4
 NqgJ6a3gDm6kMc8OwxJuMUkDmXj4jKcZeyzMVHAGfeDYYxQrd3n2h
X-Received: by 2002:a05:620a:2a06:b0:79f:4c8:d873 with SMTP id
 af79cd13be357-7a17cc850e1mr182532385a.28.1721125247540; 
 Tue, 16 Jul 2024 03:20:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7CUxRuqD86fZL42ZNFOvbPyRUuy3R81MPI/5aojnYsOgrMUVqXLJUrsv1he4k1ca74KYbYQ==
X-Received: by 2002:a05:620a:2a06:b0:79f:4c8:d873 with SMTP id
 af79cd13be357-7a17cc850e1mr182530485a.28.1721125247153; 
 Tue, 16 Jul 2024 03:20:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:26c5:842:8baa:576b?
 ([2a01:e0a:9e2:9000:26c5:842:8baa:576b])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44f5b83d990sm33602581cf.80.2024.07.16.03.20.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 03:20:46 -0700 (PDT)
Message-ID: <877a409a-4256-4899-96bb-563961a51449@redhat.com>
Date: Tue, 16 Jul 2024 12:20:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/12] vfio/{iommufd,container}: Initialize
 HostIOMMUDeviceCaps during attach_device()
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-8-joao.m.martins@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240712114704.8708-8-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 7/12/24 13:46, Joao Martins wrote:
> Fetch IOMMU hw raw caps behind the device and thus move the
> HostIOMMUDevice::realize() to be done during the attach of the device. It
> allows it to cache the information obtained from IOMMU_GET_HW_INFO from
> iommufd early on. However, while legacy HostIOMMUDevice caps
> always return true and doesn't have dependency on other things, the IOMMUFD
> backend requires the iommufd FD to be connected and having a devid to be
> able to query capabilities. Hence when exactly is HostIOMMUDevice
> initialized inside backend ::attach_device() implementation is backend
> specific.
> 
> This is in preparation to fetch parse hw capabilities and understand if
> dirty tracking is supported by device backing IOMMU without necessarily
> duplicating the amount of calls we do to IOMMU_GET_HW_INFO.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   include/sysemu/host_iommu_device.h |  1 +
>   hw/vfio/common.c                   | 16 ++++++----------
>   hw/vfio/container.c                |  6 ++++++
>   hw/vfio/iommufd.c                  |  7 +++++++
>   4 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
> index 20e77cf54568..b1e5f4b8ac3e 100644
> --- a/include/sysemu/host_iommu_device.h
> +++ b/include/sysemu/host_iommu_device.h
> @@ -24,6 +24,7 @@
>    */
>   typedef struct HostIOMMUDeviceCaps {
>       uint32_t type;
> +    uint64_t hw_caps;
>   } HostIOMMUDeviceCaps;
>   
>   #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index b0beed44116e..cc14f0e3fe24 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1544,7 +1544,7 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>   {
>       const VFIOIOMMUClass *ops =
>           VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
> -    HostIOMMUDevice *hiod;
> +    HostIOMMUDevice *hiod = NULL;
>   
>       if (vbasedev->iommufd) {
>           ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
> @@ -1552,21 +1552,17 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>   
>       assert(ops);
>   
> -    if (!ops->attach_device(name, vbasedev, as, errp)) {
> -        return false;
> -    }
>   
> -    if (vbasedev->mdev) {
> -        return true;
> +    if (!vbasedev->mdev) {
> +        hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
> +        vbasedev->hiod = hiod;
>       }
>   
> -    hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
> -    if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
> +    if (!ops->attach_device(name, vbasedev, as, errp)) {
>           object_unref(hiod);
> -        ops->detach_device(vbasedev);
> +        vbasedev->hiod = NULL;
>           return false;
>       }
> -    vbasedev->hiod = hiod;
>   
>       return true;
>   }
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index c27f448ba26e..29da261bbf3e 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -907,6 +907,7 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>                                         AddressSpace *as, Error **errp)
>   {
>       int groupid = vfio_device_groupid(vbasedev, errp);
> +    HostIOMMUDevice *hiod = vbasedev->hiod;
>       VFIODevice *vbasedev_iter;
>       VFIOGroup *group;
>       VFIOContainerBase *bcontainer;
> @@ -917,6 +918,11 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>   
>       trace_vfio_attach_device(vbasedev->name, groupid);
>   
> +    if (hiod &&
> +        !HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
> +        return false;
> +    }
> +


Could you please introduce an helper :

   bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);


Thanks,

C.



>       group = vfio_get_group(groupid, as, errp);
>       if (!group) {
>           return false;
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 873c919e319c..d34dc88231ec 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -384,6 +384,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>       Error *err = NULL;
>       const VFIOIOMMUClass *iommufd_vioc =
>           VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
> +    HostIOMMUDevice *hiod = vbasedev->hiod;
>   
>       if (vbasedev->fd < 0) {
>           devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
> @@ -401,6 +402,11 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>   
>       space = vfio_get_address_space(as);
>   
> +    if (hiod &&
> +        !HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
> +        return false;
> +    }
> +
>       /* try to attach to an existing container in this space */
>       QLIST_FOREACH(bcontainer, &space->containers, next) {
>           container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
> @@ -722,6 +728,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>   
>       hiod->name = g_strdup(vdev->name);
>       caps->type = type;
> +    caps->hw_caps = hw_caps;
>   
>       return true;
>   }



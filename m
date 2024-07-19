Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201D0C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 14:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUoJg-0004VQ-5o; Fri, 19 Jul 2024 10:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sUoJe-0004H3-56
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 10:10:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sUoJc-00036M-Bj
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 10:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721398231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3dJRLuUKQMvWYfGrEmj7BDaUhPYwA1pTISr1KCVr/W8=;
 b=L6HK7bWAgdoGmjNUbUr0K/OR6rjqQdmvuKRGCtqxRB2PhLo6M9jjvfDKotMNXwFaCsnroV
 j70ZH1Z35BZzFK23DtD8NS13uFx64CYJdiwLQ4qPWS+WOu/4lL5scu0SHRwi/EPoDjTNFP
 3N3nRoq29emZ4oQ+GBwVzmWZ2bHbFrU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-AuilgoxQNeG7fWksLgi7TA-1; Fri, 19 Jul 2024 10:10:26 -0400
X-MC-Unique: AuilgoxQNeG7fWksLgi7TA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42725ec6e0aso11061215e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 07:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721398225; x=1722003025;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3dJRLuUKQMvWYfGrEmj7BDaUhPYwA1pTISr1KCVr/W8=;
 b=qitgd1psOGbW1VB7cpwX8AGQLtek3lj27IfXh3NvM9cvxXCfwuf1JqwwYzKhdVdOTT
 D+0ctUpp08B2HhlrOUlTZSTp4aBe0R3uc/qQh0x28KblIHHYnvDBl1UOH3SMkvaKmKVn
 mp/RycmVHj6rG+Kht1s4iUhd5ym73aMrr5iz4uW07Z8mOg+HOzWjnHP72trXHPE6LkON
 q9VZcIkXLjiNy2VJaj9UEFnPPWNYFr1Nab6mN+78PZuIvt2OvWsYUDeRQ+bx3PchO+I8
 CzDJLsHobg82XFWCfF2TLCZYvULvXcyw86D5S7SHaZjts1LDrprHngAH6ixhiDXX11UT
 ZQOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSXhm+UHjtOleBsgnK20iGYXeBtvn0HbujB8JaqeZ1lmJ9+TF5l+Q3s6/85IICc+0QwruVqv8yU3bHCzbXl6aARwncUbc=
X-Gm-Message-State: AOJu0Yw258p5lqoD5YRIyPmp80bL0/3peQRiBD1IVPZucxcOHMsJEL4d
 maw16raG2jiArp24C/icFa+SY9oXT6mPYgI872TB/8gfLIvfQhjb9vHy60DpqxiHQ9cM8NB9sho
 oog+1v5qsg4zWo3RnhXXhmBwu2EyIcSMchJyY5QJWvXKpnag2B4px
X-Received: by 2002:a5d:5231:0:b0:367:9522:5e6b with SMTP id
 ffacd0b85a97d-368316faebemr5145267f8f.45.1721398225696; 
 Fri, 19 Jul 2024 07:10:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAD/LX9xZVOlhQpCdIWAfHok/0HA5nq77WA0W6KcdqzutvbjDMcrC0gfhszemE59szGZZhdA==
X-Received: by 2002:a5d:5231:0:b0:367:9522:5e6b with SMTP id
 ffacd0b85a97d-368316faebemr5145250f8f.45.1721398225251; 
 Fri, 19 Jul 2024 07:10:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:26c5:842:8baa:576b?
 ([2a01:e0a:9e2:9000:26c5:842:8baa:576b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a6efc5sm53895135e9.21.2024.07.19.07.10.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jul 2024 07:10:24 -0700 (PDT)
Message-ID: <31418d2a-7c81-4a9c-9aec-72cfac938091@redhat.com>
Date: Fri, 19 Jul 2024 16:10:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/13] vfio/{iommufd,container}: Invoke
 HostIOMMUDevice::realize() during attach_device()
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
 <20240719120501.81279-9-joao.m.martins@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240719120501.81279-9-joao.m.martins@oracle.com>
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

On 7/19/24 14:04, Joao Martins wrote:
> Move the HostIOMMUDevice::realize() to be invoked during the attach of the device
> before we allocate IOMMUFD hardware pagetable objects (HWPT). This allows the use
> of the hw_caps obtained by IOMMU_GET_HW_INFO that essentially tell if the IOMMU
> behind the device supports dirty tracking.
> 
> Note: The HostIOMMUDevice data from legacy backend is static and doesn't
> need any information from the (type1-iommu) backend to be initialized.
> In contrast however, the IOMMUFD HostIOMMUDevice data requires the
> iommufd FD to be connected and having a devid to be able to successfully
> GET_HW_INFO. This means vfio_device_hiod_realize() is called in
> different places within the backend .attach_device() implementation.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.cm>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-common.h |  1 +
>   hw/vfio/common.c              | 16 ++++++----------
>   hw/vfio/container.c           |  4 ++++
>   hw/vfio/helpers.c             | 11 +++++++++++
>   hw/vfio/iommufd.c             |  4 ++++
>   5 files changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 1a96678f8c38..4e44b26d3c45 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -242,6 +242,7 @@ void vfio_region_finalize(VFIORegion *region);
>   void vfio_reset_handler(void *opaque);
>   struct vfio_device_info *vfio_get_device_info(int fd);
>   bool vfio_device_is_mdev(VFIODevice *vbasedev);
> +bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
>   bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>                           AddressSpace *as, Error **errp);
>   void vfio_detach_device(VFIODevice *vbasedev);
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
> index c27f448ba26e..adb302216e23 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -917,6 +917,10 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>   
>       trace_vfio_attach_device(vbasedev->name, groupid);
>   
> +    if (!vfio_device_hiod_realize(vbasedev, errp)) {
> +        return false;
> +    }
> +
>       group = vfio_get_group(groupid, as, errp);
>       if (!group) {
>           return false;
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index 7e23e9080c9d..ea15c79db0a3 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -689,3 +689,14 @@ bool vfio_device_is_mdev(VFIODevice *vbasedev)
>       subsys = realpath(tmp, NULL);
>       return subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
>   }
> +
> +bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp)
> +{
> +    HostIOMMUDevice *hiod = vbasedev->hiod;
> +
> +    if (!hiod) {
> +        return true;
> +    }
> +
> +    return HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp);
> +}
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 7a10b1e90a6f..bb44d948c735 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -403,6 +403,10 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>   
>       space = vfio_get_address_space(as);
>   
> +    if (!vfio_device_hiod_realize(vbasedev, errp)) {
> +        return false;
> +    }
> +
>       /* try to attach to an existing container in this space */
>       QLIST_FOREACH(bcontainer, &space->containers, next) {
>           container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);



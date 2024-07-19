Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D34BC3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 06:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUglT-0000Ar-4Q; Fri, 19 Jul 2024 02:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sUglR-0008RJ-GW
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 02:06:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sUgkv-0008SC-Ei
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 02:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721369171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L8Rh4/lFBIuDUXUIUbiaaJDIlu7AnPmBoXB8vDERe4Q=;
 b=h+6O39jrt9HmZMwZrPCkhfQuKAGwPnmBzM6VpFExNmvS3lKPN3TQf8YSAJl6TmFpCiLwmz
 f19F6EsHDog/m9yxPh4awXIhc9bVcTI9OJdhBrDzU+6GYRPzDeAJPUxvGczluirnKArc3O
 I5SF3wYGCiT1Kl11wxAV1y+aa2WMRO0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-olqtOl6vPb-l_OzC9myygw-1; Fri, 19 Jul 2024 02:06:06 -0400
X-MC-Unique: olqtOl6vPb-l_OzC9myygw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-36835f6ebdcso495924f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 23:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721369165; x=1721973965;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L8Rh4/lFBIuDUXUIUbiaaJDIlu7AnPmBoXB8vDERe4Q=;
 b=LEmrcBB1WnydHoDjFSzpg42B+5pxpD3tS5Z1Fyx+cTyCZopQKMH5hk7PGbcvo78h1Z
 V3rTI1oTo731/RwU2L+68bVbrlnX2ZYntylwguT8UXHTH/6LejHWdCmVK6dJETkUYCbD
 pX7VrN1mkCdIZGFiFcEjj4KgA6CRjQnirJzctmN/8Vatw0gI2CCN+ozyUUrCkGPv69jX
 SIluhTCs/5ykXgAkjDw4uDK1McMIqMj+0e3egJqRGIm3ebrYYEnYmOXp5FMCBsrBn+3o
 /9JBO5PqCiphb245zccWFzvU80+1/1vUii+h4lF83Li+z3LweVcBtxZsWYBmw385cLXd
 d7Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH1+mvAJMhW5HwKJ9ZCYaOB0p7l7SUW6y7xG/BRbhMSXqzSXj3X68+D3KGM3wonbx1MoEWYzVi4qXu9pVGFC9vIxFXAbg=
X-Gm-Message-State: AOJu0Yx5KQ81zdWqZ9LcGBMB9VlRyNOdJAZfVwUIFvGLWFWfWNbnnM+o
 t0feRb96xAViTCIP6CVmLSlUy2AICrhrIJOtYK73MrkePpOTItV9EAbXBTgfKt1l6G2vKolkqqm
 J4HKldDEwLGo87qpwGbBe/tLfYHZ2Lg6I6iM3p7dXShdtTPTJScic
X-Received: by 2002:a5d:4443:0:b0:367:9d82:8370 with SMTP id
 ffacd0b85a97d-368317114d7mr4353221f8f.45.1721369165618; 
 Thu, 18 Jul 2024 23:06:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxa9QYyHKDbNWq4aWoc3X8n1NPE4cP63oSlZWSvehOSbyxHS949jl6sGKfr8bj/b10j6Zm2A==
X-Received: by 2002:a5d:4443:0:b0:367:9d82:8370 with SMTP id
 ffacd0b85a97d-368317114d7mr4353203f8f.45.1721369165190; 
 Thu, 18 Jul 2024 23:06:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:26c5:842:8baa:576b?
 ([2a01:e0a:9e2:9000:26c5:842:8baa:576b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787cedcdsm652289f8f.83.2024.07.18.23.06.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 23:06:04 -0700 (PDT)
Message-ID: <7bdc97e9-0afa-4c7b-bccf-cfb3b63569fb@redhat.com>
Date: Fri, 19 Jul 2024 08:06:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/12] vfio/iommufd: Introduce auto domain creation
To: Joao Martins <joao.m.martins@oracle.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-6-joao.m.martins@oracle.com>
 <f98463ba-32d1-4d9c-876c-715d0ca6ae3c@redhat.com>
 <befcbcfb-2ec4-4ec7-bd14-504c9363b3ca@oracle.com>
 <a67edbc5-68ce-4967-b8b9-a440904ed1b1@oracle.com>
 <SJ0PR11MB674475CA28136228FE93072A92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <6ce29c92-d9f8-413d-92f3-8a30e937f746@oracle.com>
 <2bffe255-f5ae-4004-aa64-e62ccf201464@redhat.com>
 <5f97ffc3-a7d2-4c4d-8420-112d1cf157c6@oracle.com>
 <016301e4-2971-4186-9bc2-e69d2560cb11@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <016301e4-2971-4186-9bc2-e69d2560cb11@oracle.com>
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

On 7/18/24 15:47, Joao Martins wrote:
> On 17/07/2024 10:31, Joao Martins wrote:
>> On 17/07/2024 10:28, Cédric Le Goater wrote:
>>>>>>>>> @@ -224,6 +300,11 @@ static void
>>>>>> iommufd_cdev_detach_container(VFIODevice *vbasedev,
>>>>>>>>>    {
>>>>>>>>>        Error *err = NULL;
>>>>>>>>>
>>>>>>>>> +    if (vbasedev->hwpt) {
>>>>>>>>> +        iommufd_cdev_autodomains_put(vbasedev, container);
>>>>>>>>> +        return;
>>>>>>>> Where do we detach the device from the hwpt?
>>>>>>>>
>>>>>>> In iommufd_backend_free_id() for auto domains
>>>>>>>
>>>>>>
>>>>>> to clarify here I meant *userspace* auto domains
>>>>>>
>>>>>> *kernel* auto domains (mdev) goes via DETACH_IOMMUFD_PT
>>>>>
>>>>> If the device is still attached to the hwpt, will iommufd_backend_free_id()
>>>>> succeed?
>>>>> Have you tried the hot unplug?
>>>>>
>>>>
>>>> I have but I didn't see any errors. But I will check again for v5 as it could
>>>> also be my oversight.
>>>>
>>>> I was thinking about Eric's remark overnight and I think what I am doing is not
>>>> correct regardless of the above.
>>>>
>>>> I should be calling DETACH_IOMMUFD_PT pairing with ATTACH_IOMMUFD_PT, and the
>>>> iommufd_backend_free_id() is to drop the final reference pairing with
>>>> alloc_hwpt() when the device list is empty i.e. when there's no more devices in
>>>> that vdev::hwpt.
>>>>
>>>> DETACH_IOMMUFD_PT decrement the hwpt refcount and it doesn't differentiate
>>>> between auto domains vs manual domains.
>>>>
>>>> The code is already there anyhow it just has the order of
>>>> iommufd_cdev_autodomains_put vs detach invocation reversed; I'll fix that for
>>>> next version.
>>>
>>> While at it, could you please move these routines :
>>>
>>>    iommufd_cdev_detach_ioas_hwpt
>>>    iommufd_cdev_attach_ioas_hwpt
>>>   
>>> under backends/iommufd.c ? I think that's where they belong.
>>
>> OK
> 
> At the first glance I thought this was a good idea. But these functions while
> they attach an IOMMUFD they do not really talk to an IOMMUFD backend, but to a
> VFIO device file descriptor. Now I think they are in the right place here and we
> would leave IOMMUFD uAPI things to backends/iommufd and VFIO APIs in hw/vfio/.

yep. I was misled by vbasedev->iommufd->fd which is only used in the trace event.
Let's keep things how they are. Thanks for looking,

C.



> It also uses a lot of VFIODevice* which requires some funny includes in
> sysemu/iommufd.h.
> 
> Do you still want me to go ahead with it? Here's a snip below of the change
> involved:
> 
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 2b3d51af26d2..19d1e430ef48 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -20,6 +20,7 @@
>   #include "trace.h"
>   #include <sys/ioctl.h>
>   #include <linux/iommufd.h>
> +#include <linux/vfio.h>
> 
>   static void iommufd_backend_init(Object *obj)
>   {
> @@ -232,6 +233,46 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be,
> uint32_t devid,
>       return true;
>   }
> 
> +int iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, uint32_t id,
> +                                  Error **errp)
> +{
> +    int iommufd = vbasedev->iommufd->fd;
> +    struct vfio_device_attach_iommufd_pt attach_data = {
> +        .argsz = sizeof(attach_data),
> +        .flags = 0,
> +        .pt_id = id,
> +    };
> +
> +    /* Attach device to an IOAS or hwpt within iommufd */
> +    if (ioctl(vbasedev->fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data)) {
> +        error_setg_errno(errp, errno,
> +                         "[iommufd=%d] error attach %s (%d) to id=%d",
> +                         iommufd, vbasedev->name, vbasedev->fd, id);
> +        return -errno;
> +    }
> +
> +    trace_iommufd_cdev_attach_ioas_hwpt(iommufd, vbasedev->name,
> +                                        vbasedev->fd, id);
> +    return 0;
> +}
> +
> +bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
> +{
> +    int iommufd = vbasedev->iommufd->fd;
> +    struct vfio_device_detach_iommufd_pt detach_data = {
> +        .argsz = sizeof(detach_data),
> +        .flags = 0,
> +    };
> +
> +    if (ioctl(vbasedev->fd, VFIO_DEVICE_DETACH_IOMMUFD_PT, &detach_data)) {
> +        error_setg_errno(errp, errno, "detach %s failed", vbasedev->name);
> +        return false;
> +    }
> +
> +    trace_iommufd_cdev_detach_ioas_hwpt(iommufd, vbasedev->name);
> +    return true;
> +}
> +
>   static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
>   {
>       HostIOMMUDeviceCaps *caps = &hiod->caps;
> diff --git a/backends/trace-events b/backends/trace-events
> index 211e6f374adc..2fee8e0af20e 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -15,3 +15,5 @@ iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t
> ioas, uint64_t iova, u
>   iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t
> size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" s
> ize=0x%"PRIx64" (%d)"
>   iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
>   iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
> +iommufd_cdev_attach_ioas_hwpt(int iommufd, const char *name, int devfd, int id)
> " [iommufd=%d] Successfully attached device %s (%d)
> to id=%d"
> +iommufd_cdev_detach_ioas_hwpt(int iommufd, const char *name) " [iommufd=%d]
> Successfully detached %s"
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 077dea8f1b64..5a6d56c915e2 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -172,46 +172,6 @@ out:
>       return ret;
>   }
> 
> -static int iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, uint32_t id,
> -                                         Error **errp)
> -{
> -    int iommufd = vbasedev->iommufd->fd;
> -    struct vfio_device_attach_iommufd_pt attach_data = {
> -        .argsz = sizeof(attach_data),
> -        .flags = 0,
> -        .pt_id = id,
> -    };
> -
> -    /* Attach device to an IOAS or hwpt within iommufd */
> -    if (ioctl(vbasedev->fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data)) {
> -        error_setg_errno(errp, errno,
> -                         "[iommufd=%d] error attach %s (%d) to id=%d",
> -                         iommufd, vbasedev->name, vbasedev->fd, id);
> -        return -errno;
> -    }
> -
> -    trace_iommufd_cdev_attach_ioas_hwpt(iommufd, vbasedev->name,
> -                                        vbasedev->fd, id);
> -    return 0;
> -}
> -
> -static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
> -{
> -    int iommufd = vbasedev->iommufd->fd;
> -    struct vfio_device_detach_iommufd_pt detach_data = {
> -        .argsz = sizeof(detach_data),
> -        .flags = 0,
> -    };
> -
> -    if (ioctl(vbasedev->fd, VFIO_DEVICE_DETACH_IOMMUFD_PT, &detach_data)) {
> -        error_setg_errno(errp, errno, "detach %s failed", vbasedev->name);
> -        return false;
> -    }
> -
> -    trace_iommufd_cdev_detach_ioas_hwpt(iommufd, vbasedev->name);
> -    return true;
> -}
> -
>   static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
>                                             VFIOIOMMUFDContainer *container,
>                                             Error **errp)
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index e16179b507ed..24fde6270112 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -170,8 +170,6 @@ vfio_vmstate_change_prepare(const char *name, int running,
> const char *reason, c
> 
>   iommufd_cdev_connect_and_bind(int iommufd, const char *name, int devfd, int
> devid) " [iommufd=%d] Successfully bound device %s (fd=%
> d): output devid=%d"
>   iommufd_cdev_getfd(const char *dev, int devfd) " %s (fd=%d)"
> -iommufd_cdev_attach_ioas_hwpt(int iommufd, const char *name, int devfd, int id)
> " [iommufd=%d] Successfully attached device %s (%d)
> to id=%d"
> -iommufd_cdev_detach_ioas_hwpt(int iommufd, const char *name) " [iommufd=%d]
> Successfully detached %s"
>   iommufd_cdev_fail_attach_existing_container(const char *msg) " %s"
>   iommufd_cdev_alloc_ioas(int iommufd, int ioas_id) " [iommufd=%d] new IOMMUFD
> container with ioasid=%d"
>   iommufd_cdev_device_info(char *name, int devfd, int num_irqs, int num_regions,
> int flags) " %s (%d) num_irqs=%d num_regions=%d flags
> =%d"
> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
> index 57d502a1c79a..89780669118f 100644
> --- a/include/sysemu/iommufd.h
> +++ b/include/sysemu/iommufd.h
> @@ -18,6 +18,8 @@
>   #include "exec/hwaddr.h"
>   #include "exec/cpu-common.h"
>   #include "sysemu/host_iommu_device.h"
> +#include "hw/vfio/vfio-common.h"
> +#include "hw/vfio/vfio-container-base.h"
> 
>   #define TYPE_IOMMUFD_BACKEND "iommufd"
>   OBJECT_DECLARE_TYPE(IOMMUFDBackend, IOMMUFDBackendClass, IOMMUFD_BACKEND)
> @@ -51,5 +53,9 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be,
> uint32_t devid,
>                                        uint32_t *type, void *data, uint32_t len,
>                                        uint64_t *caps, Error **errp);
> 
> +bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp);
> +int iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, uint32_t id,
> +                                  Error **errp);
> +
>   #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>   #endif
> 
> 



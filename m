Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA511C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 09:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU0yA-0003Ie-3L; Wed, 17 Jul 2024 05:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sU0y8-0003Hw-M5
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:29:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sU0y2-0001zG-EF
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721208535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RFown1/Mhj8x+hroRHrzA9g1y4anS9tMJ6Wcq8BFqds=;
 b=GqwbQ8+apncjKA8U8Nho7aPaYBsy4UwKZXPNUiITKV2rDmNTF6P15XksnDbhCSQ4+IPjpQ
 ZTrKyGY13E02c55EFNydzQfbs+ZWTyx51k6CVKcRPC0mRDzWuE//uEWVGg7mELQxnbiHBW
 Sb3hckSj4qJEb5in7im1YPVnWtzJLpw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-GL2xxy83PGKIlLKP5hJ_eg-1; Wed, 17 Jul 2024 05:28:53 -0400
X-MC-Unique: GL2xxy83PGKIlLKP5hJ_eg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-426679bc120so49386655e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 02:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721208532; x=1721813332;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RFown1/Mhj8x+hroRHrzA9g1y4anS9tMJ6Wcq8BFqds=;
 b=BgRRH1JD78gJUe3/jeTlRzoRtLWjd0GDZxRxCjuqH6H1QOGWA8oQ80R2M9BUtt2f0k
 oRbqoY7nuXltRmja/hQMCv2XFf/n0f7wJMKXeYdvXJDhPDacD2h5oEbND9xszYqbydRe
 7Q5JFDgEsmrv+65BPWsN7eOv4ZNqhdOk3Xk5nwYhV7X/d49JJMnYWGDRfqy67jc1r+11
 SkcF0rzqMtG/DRZH0KhYHTnsnOinRrXsHiQEnkge2VcW7yguW8cn5JK4xG6tn5MLsO5m
 DB4DiHAMo1aJPlFgIHRBkGjNkSV0SIxkohkWJZlaEBgWOCWVlgxOzz2Hs5dq+53XgY5r
 dQLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEFYPQdZhKfN9/d/KtGZPHtxzkfk5d8lDVfrkB7juEx4di15iHYbV+/yLhZ8PfkFAh8Dr0CVSt/w9YEwZjMuMuwykqtqQ=
X-Gm-Message-State: AOJu0YxMy2iX2PXP2f9s4ciLsi4LZEVS8YiK0G0WWj8uuRmiU57vOCpk
 GRTDDHbj/CQ3+6HL8z9Fsb2k41EO6dR2FkYzpOJPCYbmEeiwZ/Chu+vKH3OjTwafb421ttD/+xh
 Wfb8lm6m3TCVp5VGhhdi2Wa7zwVPkUesi90och2Lqcd55T42beWaR
X-Received: by 2002:a05:600c:4f4f:b0:426:5d43:e41d with SMTP id
 5b1f17b1804b1-427c2cc2f66mr7312925e9.18.1721208531905; 
 Wed, 17 Jul 2024 02:28:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyjTA9OnPCCkTDfx2GBHgIgOOutFiqBHezTWzYXLv09MpaWZP8qmZF1to2XHHzbjvDoiO2eA==
X-Received: by 2002:a05:600c:4f4f:b0:426:5d43:e41d with SMTP id
 5b1f17b1804b1-427c2cc2f66mr7312745e9.18.1721208531395; 
 Wed, 17 Jul 2024 02:28:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:26c5:842:8baa:576b?
 ([2a01:e0a:9e2:9000:26c5:842:8baa:576b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2d7c9csm198324215e9.48.2024.07.17.02.28.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 02:28:50 -0700 (PDT)
Message-ID: <2bffe255-f5ae-4004-aa64-e62ccf201464@redhat.com>
Date: Wed, 17 Jul 2024 11:28:49 +0200
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
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <6ce29c92-d9f8-413d-92f3-8a30e937f746@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/17/24 11:09, Joao Martins wrote:
> On 17/07/2024 03:52, Duan, Zhenzhong wrote:
>>
>>
>>> -----Original Message-----
>>> From: Joao Martins <joao.m.martins@oracle.com>
>>> Subject: Re: [PATCH v4 05/12] vfio/iommufd: Introduce auto domain
>>> creation
>>>
>>> On 16/07/2024 17:44, Joao Martins wrote:
>>>> On 16/07/2024 17:04, Eric Auger wrote:
>>>>> Hi Joao,
>>>>>
>>>>> On 7/12/24 13:46, Joao Martins wrote:
>>>>>> There's generally two modes of operation for IOMMUFD:
>>>>>>
>>>>>> * The simple user API which intends to perform relatively simple things
>>>>>> with IOMMUs e.g. DPDK. It generally creates an IOAS and attach to VFIO
>>>>>
>>>>> It generally creates? can you explicit what is "it"
>>>>>
>>>> 'It' here refers to the process/API-user
>>>>
>>>>> I am confused by this automatic terminology again (not your fault). the
>>> doc says:
>>>>> "
>>>>>
>>>>>    *
>>>>>
>>>>>      Automatic domain - refers to an iommu domain created automatically
>>>>>      when attaching a device to an IOAS object. This is compatible to the
>>>>>      semantics of VFIO type1.
>>>>>
>>>>>    *
>>>>>
>>>>>      Manual domain - refers to an iommu domain designated by the user as
>>>>>      the target pagetable to be attached to by a device. Though currently
>>>>>      there are no uAPIs to directly create such domain, the datastructure
>>>>>      and algorithms are ready for handling that use case.
>>>>>
>>>>> "
>>>>>
>>>>>
>>>>> in 1) the device is attached to the ioas id (using the auto domain if I am
>>> not wrong)
>>>>> Here you attach to an hwpt id. Isn't it a manual domain?
>>>>>
>>>>
>>>> Correct.
>>>>
>>>> The 'auto domains' generally refers to the kernel-equivalent own
>>> automatic
>>>> attaching to a new pagetable.
>>>>
>>>> Here I call 'auto domains' in the userspace version too because we are
>>> doing the
>>>> exact same but from userspace, using the manual API in IOMMUFD.
>>>>
>>>>>> and mainly performs IOAS_MAP and UNMAP.
>>>>>>
>>>>>> * The native IOMMUFD API where you have fine grained control of the
>>>>>> IOMMU domain and model it accordingly. This is where most new
>>> feature
>>>>>> are being steered to.
>>>>>>
>>>>>> For dirty tracking 2) is required, as it needs to ensure that
>>>>>> the stage-2/parent IOMMU domain will only attach devices
>>>>>> that support dirty tracking (so far it is all homogeneous in x86, likely
>>>>>> not the case for smmuv3). Such invariant on dirty tracking provides a
>>>>>> useful guarantee to VMMs that will refuse incompatible device
>>>>>> attachments for IOMMU domains.
>>>>>>
>>>>>> Dirty tracking insurance is enforced via HWPT_ALLOC, which is
>>>>>> responsible for creating an IOMMU domain. This is contrast to the
>>>>>> 'simple API' where the IOMMU domain is created by IOMMUFD
>>> automatically
>>>>>> when it attaches to VFIO (usually referred as autodomains) but it has
>>>>>> the needed handling for mdevs.
>>>>>>
>>>>>> To support dirty tracking with the advanced IOMMUFD API, it needs
>>>>>> similar logic, where IOMMU domains are created and devices attached
>>> to
>>>>>> compatible domains. Essentially mimmicing kernel
>>>>>> iommufd_device_auto_get_domain(). With mdevs given there's no
>>> IOMMU domain
>>>>>> it falls back to IOAS attach.
>>>>>>
>>>>>> The auto domain logic allows different IOMMU domains to be created
>>> when
>>>>>> DMA dirty tracking is not desired (and VF can provide it), and others
>>> where
>>>>>> it is. Here is not used in this way here given how VFIODevice migration
>>>>>
>>>>> Here is not used in this way here ?
>>>>>
>>>>
>>>> I meant, 'Here it is not used in this way given (...)'
>>>>
>>>>>> state is initialized after the device attachment. But such mixed mode of
>>>>>> IOMMU dirty tracking + device dirty tracking is an improvement that
>>> can
>>>>>> be added on. Keep the 'all of nothing' of type1 approach that we have
>>>>>> been using so far between container vs device dirty tracking.
>>>>>>
>>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>>>> ---
>>>>>>   include/hw/vfio/vfio-common.h |  9 ++++
>>>>>>   include/sysemu/iommufd.h      |  5 +++
>>>>>>   backends/iommufd.c            | 30 +++++++++++++
>>>>>>   hw/vfio/iommufd.c             | 82
>>> +++++++++++++++++++++++++++++++++++
>>>>>>   backends/trace-events         |  1 +
>>>>>>   5 files changed, 127 insertions(+)
>>>>>>
>>>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>>> common.h
>>>>>> index 7419466bca92..2dd468ce3c02 100644
>>>>>> --- a/include/hw/vfio/vfio-common.h
>>>>>> +++ b/include/hw/vfio/vfio-common.h
>>>>>> @@ -95,10 +95,17 @@ typedef struct VFIOHostDMAWindow {
>>>>>>
>>>>>>   typedef struct IOMMUFDBackend IOMMUFDBackend;
>>>>>>
>>>>>> +typedef struct VFIOIOASHwpt {
>>>>>> +    uint32_t hwpt_id;
>>>>>> +    QLIST_HEAD(, VFIODevice) device_list;
>>>>>> +    QLIST_ENTRY(VFIOIOASHwpt) next;
>>>>>> +} VFIOIOASHwpt;
>>>>>> +
>>>>>>   typedef struct VFIOIOMMUFDContainer {
>>>>>>       VFIOContainerBase bcontainer;
>>>>>>       IOMMUFDBackend *be;
>>>>>>       uint32_t ioas_id;
>>>>>> +    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
>>>>>>   } VFIOIOMMUFDContainer;
>>>>>>
>>>>>>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer,
>>> VFIO_IOMMU_IOMMUFD);
>>>>>> @@ -135,6 +142,8 @@ typedef struct VFIODevice {
>>>>>>       HostIOMMUDevice *hiod;
>>>>>>       int devid;
>>>>>>       IOMMUFDBackend *iommufd;
>>>>>> +    VFIOIOASHwpt *hwpt;
>>>>>> +    QLIST_ENTRY(VFIODevice) hwpt_next;
>>>>>>   } VFIODevice;
>>>>>>
>>>>>>   struct VFIODeviceOps {
>>>>>> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>>>>>> index 57d502a1c79a..e917e7591d05 100644
>>>>>> --- a/include/sysemu/iommufd.h
>>>>>> +++ b/include/sysemu/iommufd.h
>>>>>> @@ -50,6 +50,11 @@ int
>>> iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>>>>>>   bool iommufd_backend_get_device_info(IOMMUFDBackend *be,
>>> uint32_t devid,
>>>>>>                                        uint32_t *type, void *data, uint32_t len,
>>>>>>                                        uint64_t *caps, Error **errp);
>>>>>> +bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t
>>> dev_id,
>>>>>> +                                uint32_t pt_id, uint32_t flags,
>>>>>> +                                uint32_t data_type, uint32_t data_len,
>>>>>> +                                void *data_ptr, uint32_t *out_hwpt,
>>>>>> +                                Error **errp);
>>>>>>
>>>>>>   #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>>> TYPE_HOST_IOMMU_DEVICE "-iommufd"
>>>>>>   #endif
>>>>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>>>>> index 2b3d51af26d2..5d3dfa917415 100644
>>>>>> --- a/backends/iommufd.c
>>>>>> +++ b/backends/iommufd.c
>>>>>> @@ -208,6 +208,36 @@ int
>>> iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>>>>>>       return ret;
>>>>>>   }
>>>>>>
>>>>>> +bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t
>>> dev_id,
>>>>>> +                                uint32_t pt_id, uint32_t flags,
>>>>>> +                                uint32_t data_type, uint32_t data_len,
>>>>>> +                                void *data_ptr, uint32_t *out_hwpt,
>>>>>> +                                Error **errp)
>>>>>> +{
>>>>>> +    int ret, fd = be->fd;
>>>>>> +    struct iommu_hwpt_alloc alloc_hwpt = {
>>>>>> +        .size = sizeof(struct iommu_hwpt_alloc),
>>>>>> +        .flags = flags,
>>>>>> +        .dev_id = dev_id,
>>>>>> +        .pt_id = pt_id,
>>>>>> +        .data_type = data_type,
>>>>>> +        .data_len = data_len,
>>>>>> +        .data_uptr = (uint64_t)data_ptr,
>>>>>> +    };
>>>>>> +
>>>>>> +    ret = ioctl(fd, IOMMU_HWPT_ALLOC, &alloc_hwpt);
>>>>>> +    trace_iommufd_backend_alloc_hwpt(fd, dev_id, pt_id, flags,
>>> data_type,
>>>>>> +                                     data_len, (uint64_t)data_ptr,
>>>>>> +                                     alloc_hwpt.out_hwpt_id, ret);
>>>>>> +    if (ret) {
>>>>>> +        error_setg_errno(errp, errno, "Failed to allocate hwpt");
>>>>>> +        return false;
>>>>>> +    }
>>>>>> +
>>>>>> +    *out_hwpt = alloc_hwpt.out_hwpt_id;
>>>>>> +    return true;
>>>>>> +}
>>>>>> +
>>>>>>   bool iommufd_backend_get_device_info(IOMMUFDBackend *be,
>>> uint32_t devid,
>>>>>>                                        uint32_t *type, void *data, uint32_t len,
>>>>>>                                        uint64_t *caps, Error **errp)
>>>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>>>> index 077dea8f1b64..325c7598d5a1 100644
>>>>>> --- a/hw/vfio/iommufd.c
>>>>>> +++ b/hw/vfio/iommufd.c
>>>>>> @@ -212,10 +212,86 @@ static bool
>>> iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>>>>>>       return true;
>>>>>>   }
>>>>>>
>>>>>> +static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>>>> +                                         VFIOIOMMUFDContainer *container,
>>>>>> +                                         Error **errp)
>>>>>> +{
>>>>>> +    IOMMUFDBackend *iommufd = vbasedev->iommufd;
>>>>>> +    uint32_t flags = 0;
>>>>>> +    VFIOIOASHwpt *hwpt;
>>>>>> +    uint32_t hwpt_id;
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    /* Try to find a domain */
>>>>>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>>>>>> +        ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id,
>>> errp);
>>>>>> +        if (ret) {
>>>>>> +            /* -EINVAL means the domain is incompatible with the device.
>>> */
>>>>>> +            if (ret == -EINVAL) {
>>>>>> +                /*
>>>>>> +                 * It is an expected failure and it just means we will try
>>>>>> +                 * another domain, or create one if no existing compatible
>>>>>> +                 * domain is found. Hence why the error is discarded below.
>>>>>> +                 */
>>>>>> +                error_free(*errp);
>>>>>> +                *errp = NULL;
>>>>>> +                continue;
>>>>>> +            }
>>>>>> +
>>>>>> +            return false;
>>>>>> +        } else {
>>>>>> +            vbasedev->hwpt = hwpt;
>>>>>> +            QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>>>>>> +            return true;
>>>>>> +        }
>>>>>> +    }
>>>>>> +
>>>>>> +    if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>>>>>> +                                    container->ioas_id, flags,
>>>>>> +                                    IOMMU_HWPT_DATA_NONE, 0, NULL,
>>>>>> +                                    &hwpt_id, errp)) {
>>>>>> +        return false;
>>>>>> +    }
>>>>>> +
>>>>>> +    hwpt = g_malloc0(sizeof(*hwpt));
>>>>>> +    hwpt->hwpt_id = hwpt_id;
>>>>>> +    QLIST_INIT(&hwpt->device_list);
>>>>>> +
>>>>>> +    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id,
>>> errp);
>>>>>> +    if (ret) {
>>>>>> +        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>>>>>> +        g_free(hwpt);
>>>>>> +        return false;
>>>>>> +    }
>>>>>> +
>>>>>> +    vbasedev->hwpt = hwpt;
>>>>>> +    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>>>>>> +    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>>>>>> +    return true;
>>>>>> +}
>>>>>> +
>>>>>> +static void iommufd_cdev_autodomains_put(VFIODevice *vbasedev,
>>>>>> +                                         VFIOIOMMUFDContainer *container)
>>>>>> +{
>>>>>> +    VFIOIOASHwpt *hwpt = vbasedev->hwpt;
>>>>>> +
>>>>>> +    QLIST_REMOVE(vbasedev, hwpt_next);
>>>>> don't you want to reset vbasedev->hwpt = NULL too?
>>>>>
>>>> Yeap, Thanks for catching that
>>>>
>>>>>
>>>>>> +    if (QLIST_EMPTY(&hwpt->device_list)) {
>>>>>> +        QLIST_REMOVE(hwpt, next);
>>>>>> +        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>>>>>> +        g_free(hwpt);
>>>>>> +    }
>>>>>> +}
>>>>>> +
>>>>>>   static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
>>>>>>                                             VFIOIOMMUFDContainer *container,
>>>>>>                                             Error **errp)
>>>>>>   {
>>>>>> +    /* mdevs aren't physical devices and will fail with auto domains */
>>>>>> +    if (!vbasedev->mdev) {
>>>>>> +        return iommufd_cdev_autodomains_get(vbasedev, container,
>>> errp);
>>>>>> +    }
>>>>>> +
>>>>>>       return !iommufd_cdev_attach_ioas_hwpt(vbasedev, container-
>>>> ioas_id, errp);
>>>>>>   }
>>>>>>
>>>>>> @@ -224,6 +300,11 @@ static void
>>> iommufd_cdev_detach_container(VFIODevice *vbasedev,
>>>>>>   {
>>>>>>       Error *err = NULL;
>>>>>>
>>>>>> +    if (vbasedev->hwpt) {
>>>>>> +        iommufd_cdev_autodomains_put(vbasedev, container);
>>>>>> +        return;
>>>>> Where do we detach the device from the hwpt?
>>>>>
>>>> In iommufd_backend_free_id() for auto domains
>>>>
>>>
>>> to clarify here I meant *userspace* auto domains
>>>
>>> *kernel* auto domains (mdev) goes via DETACH_IOMMUFD_PT
>>
>> If the device is still attached to the hwpt, will iommufd_backend_free_id() succeed?
>> Have you tried the hot unplug?
>>
> 
> I have but I didn't see any errors. But I will check again for v5 as it could
> also be my oversight.
> 
> I was thinking about Eric's remark overnight and I think what I am doing is not
> correct regardless of the above.
> 
> I should be calling DETACH_IOMMUFD_PT pairing with ATTACH_IOMMUFD_PT, and the
> iommufd_backend_free_id() is to drop the final reference pairing with
> alloc_hwpt() when the device list is empty i.e. when there's no more devices in
> that vdev::hwpt.
> 
> DETACH_IOMMUFD_PT decrement the hwpt refcount and it doesn't differentiate
> between auto domains vs manual domains.
> 
> The code is already there anyhow it just has the order of
> iommufd_cdev_autodomains_put vs detach invocation reversed; I'll fix that for
> next version.

While at it, could you please move these routines :

   iommufd_cdev_detach_ioas_hwpt
   iommufd_cdev_attach_ioas_hwpt
  
under backends/iommufd.c ? I think that's where they belong.



Thanks,

C.




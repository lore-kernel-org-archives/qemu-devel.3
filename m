Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C76C3DA70
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 14:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVtuc-0005Oc-To; Mon, 22 Jul 2024 10:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sVtub-0005No-Le
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 10:21:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sVtuY-0003ag-RU
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 10:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721658069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bWj9hA69XxB6WpoYkkC91FsclTxtqeLlrql3w52WIOc=;
 b=Mz4pF7BhHzeYAW5UTrPwzMg0pEoK2KN7FhLeHYWodyyr6AefGxh950mfiJyrhHNx805h4P
 JV+bGB4Pdx9eRgNsY+Qn8HEfnmcdiP1HEHOHAp4D8Ce7a9qDf2bOPVAdpoRty83uJj9dRG
 yjvcuiDb8IW8TbUcQVR37cRqr9lCsZY=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-l3KBGC0uNO6SnLsZqsJvhA-1; Mon, 22 Jul 2024 10:21:07 -0400
X-MC-Unique: l3KBGC0uNO6SnLsZqsJvhA-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-e03b3f48c65so9924865276.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 07:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721658067; x=1722262867;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bWj9hA69XxB6WpoYkkC91FsclTxtqeLlrql3w52WIOc=;
 b=WW3kUrrbFMFPYOxBpuiQlLDj20Mwfo9+yQVyIxPy6S9wgH6k9egi+nb85s7IvY9k8k
 x795jFvd5WGc8z8h68ZTwv4s+TDiYR4A/FQ56cFVKLo9YIDc1l9tqxBUdJ+zI3g16BXj
 6Ub/EaOiWinsSeGEU2Oa2NCQ7kQORPJgpSks33dRaZdYGRl5kXbQMSjfMofsVRqyfay+
 1u6Y7IaGVm8E3WVn6c5pgqbbOoZgcNCFqiSGmiM9TW8udP9w9oJsQN/bXPtwPltSw1b2
 LxSn8FyLYt+kHPc7rhYpEc1fzyT3qzf+9ItZQtS5xSiqFaG2kZ9H/iYSg43Fg1vltSAT
 5ELA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxIyXM0mzNyOqrXtQW/FrCYRkY2V6NECv85hmRVr/vfo4lPQNdXiBr16ZmpBgq1VTpx5XHLLoPYUVbnZUbiUc8ndV7yaE=
X-Gm-Message-State: AOJu0YzeATaAwDFksLo+dxciiS3WjBKtlWK5XtvrLbooa1r4nbdbLct/
 jIhNntETgwML7fs+kFc1S+hbJjDd58X62L65nZm1LSw8frWU47xp1t/rGEV+hIRdBRlJD2L6g0U
 cEXrgoXsQU2eYT1Ll+UmRs75wr3jhgcrCA6sdLh4N+R7TGggDsaHd
X-Received: by 2002:a05:6902:1207:b0:e08:7251:d44b with SMTP id
 3f1490d57ef6-e087251d60emr7583926276.31.1721658066821; 
 Mon, 22 Jul 2024 07:21:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFMRnBvZMiYQaH8kUm8g+0j+JohHwpEdlAE+OyKXRwlVBXIj/jgHVLmVbYLIrHt66kC7Yusw==
X-Received: by 2002:a05:6902:1207:b0:e08:7251:d44b with SMTP id
 3f1490d57ef6-e087251d60emr7583899276.31.1721658066378; 
 Mon, 22 Jul 2024 07:21:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e?
 ([2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b96dc5b051sm14487136d6.55.2024.07.22.07.21.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 07:21:06 -0700 (PDT)
Message-ID: <343058b1-ee11-4bc0-8318-f357214b0901@redhat.com>
Date: Mon, 22 Jul 2024 16:21:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/13] vfio/iommufd: Introduce auto domain creation
To: Joao Martins <joao.m.martins@oracle.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
 <20240719120501.81279-6-joao.m.martins@oracle.com>
 <SJ0PR11MB67447F437F8FCDC4F995737C92A82@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <1f220462-6540-4a9a-8a29-5edfe836b9c3@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <1f220462-6540-4a9a-8a29-5edfe836b9c3@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

On 7/22/24 10:50, Joao Martins wrote:
> On 22/07/2024 06:16, Duan, Zhenzhong wrote:
>>> -----Original Message-----
>>> From: Joao Martins <joao.m.martins@oracle.com>
>>> Subject: [PATCH v5 05/13] vfio/iommufd: Introduce auto domain creation
>>>
>>> There's generally two modes of operation for IOMMUFD:
>>>
>>> 1) The simple user API which intends to perform relatively simple things
>>> with IOMMUs e.g. DPDK. The process generally creates an IOAS and attaches
>>> to VFIO and mainly performs IOAS_MAP and UNMAP.
>>>
>>> 2) The native IOMMUFD API where you have fine grained control of the
>>> IOMMU domain and model it accordingly. This is where most new feature
>>> are being steered to.
>>>
>>> For dirty tracking 2) is required, as it needs to ensure that
>>> the stage-2/parent IOMMU domain will only attach devices
>>> that support dirty tracking (so far it is all homogeneous in x86, likely
>>> not the case for smmuv3). Such invariant on dirty tracking provides a
>>> useful guarantee to VMMs that will refuse incompatible device
>>> attachments for IOMMU domains.
>>>
>>> Dirty tracking insurance is enforced via HWPT_ALLOC, which is
>>> responsible for creating an IOMMU domain. This is contrast to the
>>> 'simple API' where the IOMMU domain is created by IOMMUFD
>>> automatically
>>> when it attaches to VFIO (usually referred as autodomains) but it has
>>> the needed handling for mdevs.
>>>
>>> To support dirty tracking with the advanced IOMMUFD API, it needs
>>> similar logic, where IOMMU domains are created and devices attached to
>>> compatible domains. Essentially mimicking kernel
>>> iommufd_device_auto_get_domain(). With mdevs given there's no IOMMU
>>> domain
>>> it falls back to IOAS attach.
>>>
>>> The auto domain logic allows different IOMMU domains to be created when
>>> DMA dirty tracking is not desired (and VF can provide it), and others where
>>> it is. Here it is not used in this way given how VFIODevice migration
>>> state is initialized after the device attachment. But such mixed mode of
>>> IOMMU dirty tracking + device dirty tracking is an improvement that can
>>> be added on. Keep the 'all of nothing' of type1 approach that we have
>>> been using so far between container vs device dirty tracking.
>>>
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> ---
>>> include/hw/vfio/vfio-common.h |  9 ++++
>>> include/sysemu/iommufd.h      |  5 +++
>>> backends/iommufd.c            | 30 +++++++++++++
>>> hw/vfio/iommufd.c             | 84
>>> +++++++++++++++++++++++++++++++++++
>>> backends/trace-events         |  1 +
>>> 5 files changed, 129 insertions(+)
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>>> common.h
>>> index 98acae8c1c97..1a96678f8c38 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -95,10 +95,17 @@ typedef struct VFIOHostDMAWindow {
>>>
>>> typedef struct IOMMUFDBackend IOMMUFDBackend;
>>>
>>> +typedef struct VFIOIOASHwpt {
>>> +    uint32_t hwpt_id;
>>> +    QLIST_HEAD(, VFIODevice) device_list;
>>> +    QLIST_ENTRY(VFIOIOASHwpt) next;
>>> +} VFIOIOASHwpt;
>>> +
>>> typedef struct VFIOIOMMUFDContainer {
>>>      VFIOContainerBase bcontainer;
>>>      IOMMUFDBackend *be;
>>>      uint32_t ioas_id;
>>> +    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
>>> } VFIOIOMMUFDContainer;
>>>
>>> OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer,
>>> VFIO_IOMMU_IOMMUFD);
>>> @@ -135,6 +142,8 @@ typedef struct VFIODevice {
>>>      HostIOMMUDevice *hiod;
>>>      int devid;
>>>      IOMMUFDBackend *iommufd;
>>> +    VFIOIOASHwpt *hwpt;
>>> +    QLIST_ENTRY(VFIODevice) hwpt_next;
>>> } VFIODevice;
>>>
>>> struct VFIODeviceOps {
>>> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>>> index 57d502a1c79a..e917e7591d05 100644
>>> --- a/include/sysemu/iommufd.h
>>> +++ b/include/sysemu/iommufd.h
>>> @@ -50,6 +50,11 @@ int
>>> iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>>> bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t
>>> devid,
>>>                                       uint32_t *type, void *data, uint32_t len,
>>>                                       uint64_t *caps, Error **errp);
>>> +bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t
>>> dev_id,
>>> +                                uint32_t pt_id, uint32_t flags,
>>> +                                uint32_t data_type, uint32_t data_len,
>>> +                                void *data_ptr, uint32_t *out_hwpt,
>>> +                                Error **errp);
>>>
>>> #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>>> TYPE_HOST_IOMMU_DEVICE "-iommufd"
>>> #endif
>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>> index 2b3d51af26d2..a94d3b90c05c 100644
>>> --- a/backends/iommufd.c
>>> +++ b/backends/iommufd.c
>>> @@ -208,6 +208,36 @@ int
>>> iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>>>      return ret;
>>> }
>>>
>>> +bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t
>>> dev_id,
>>> +                                uint32_t pt_id, uint32_t flags,
>>> +                                uint32_t data_type, uint32_t data_len,
>>> +                                void *data_ptr, uint32_t *out_hwpt,
>>> +                                Error **errp)
>>> +{
>>> +    int ret, fd = be->fd;
>>> +    struct iommu_hwpt_alloc alloc_hwpt = {
>>> +        .size = sizeof(struct iommu_hwpt_alloc),
>>> +        .flags = flags,
>>> +        .dev_id = dev_id,
>>> +        .pt_id = pt_id,
>>> +        .data_type = data_type,
>>> +        .data_len = data_len,
>>> +        .data_uptr = (uintptr_t)data_ptr,
>>> +    };
>>> +
>>> +    ret = ioctl(fd, IOMMU_HWPT_ALLOC, &alloc_hwpt);
>>> +    trace_iommufd_backend_alloc_hwpt(fd, dev_id, pt_id, flags, data_type,
>>> +                                     data_len, (uintptr_t)data_ptr,
>>> +                                     alloc_hwpt.out_hwpt_id, ret);
>>> +    if (ret) {
>>> +        error_setg_errno(errp, errno, "Failed to allocate hwpt");
>>> +        return false;
>>> +    }
>>> +
>>> +    *out_hwpt = alloc_hwpt.out_hwpt_id;
>>> +    return true;
>>> +}
>>> +
>>> bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t
>>> devid,
>>>                                       uint32_t *type, void *data, uint32_t len,
>>>                                       uint64_t *caps, Error **errp)
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index 077dea8f1b64..545f4a404125 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -212,10 +212,88 @@ static bool
>>> iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>>>      return true;
>>> }
>>>
>>> +static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>> +                                         VFIOIOMMUFDContainer *container,
>>> +                                         Error **errp)
>>> +{
>>> +    IOMMUFDBackend *iommufd = vbasedev->iommufd;
>>> +    uint32_t flags = 0;
>>> +    VFIOIOASHwpt *hwpt;
>>> +    uint32_t hwpt_id;
>>> +    int ret;
>>> +
>>> +    /* Try to find a domain */
>>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>>> +        ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id,
>>> errp);
>>> +        if (ret) {
>>> +            /* -EINVAL means the domain is incompatible with the device. */
>>> +            if (ret == -EINVAL) {
>>> +                /*
>>> +                 * It is an expected failure and it just means we will try
>>> +                 * another domain, or create one if no existing compatible
>>> +                 * domain is found. Hence why the error is discarded below.
>>> +                 */
>>> +                error_free(*errp);
>>> +                *errp = NULL;
>>> +                continue;
>>> +            }
>>> +
>>> +            return false;
>>> +        } else {
>>> +            vbasedev->hwpt = hwpt;
>>> +            QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>>> +            return true;
>>> +        }
>>> +    }
>>> +
>>> +    if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>>> +                                    container->ioas_id, flags,
>>> +                                    IOMMU_HWPT_DATA_NONE, 0, NULL,
>>> +                                    &hwpt_id, errp)) {
>>> +        return false;
>>> +    }
>>> +
>>> +    hwpt = g_malloc0(sizeof(*hwpt));
>>> +    hwpt->hwpt_id = hwpt_id;
>>> +    QLIST_INIT(&hwpt->device_list);
>>> +
>>> +    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
>>> +    if (ret) {
>>> +        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>>> +        g_free(hwpt);
>>> +        return false;
>>> +    }
>>> +
>>> +    vbasedev->hwpt = hwpt;
>>> +    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>>> +    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>>> +    return true;
>>> +}
>>> +
>>> +static void iommufd_cdev_autodomains_put(VFIODevice *vbasedev,
>>> +                                         VFIOIOMMUFDContainer *container)
>>> +{
>>> +    VFIOIOASHwpt *hwpt = vbasedev->hwpt;
>>> +
>>> +    QLIST_REMOVE(vbasedev, hwpt_next);
>>> +    vbasedev->hwpt = NULL;
>>> +
>>> +    if (QLIST_EMPTY(&hwpt->device_list)) {
>>> +        QLIST_REMOVE(hwpt, next);
>>> +        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>>> +        g_free(hwpt);
>>> +    }
>>> +}
>>
>> Looks the detach flow is still missed?
>>
> 
> 
> I don't think so. The iommufd_backend_free_id() pairs with alloc_hwpt call and
> is there for when there's no device attached to the hwpt to actually free the
> hwpt. Besides setting to NULL the device hwpt, the detach flow was fixed below (...)
> 
>>> +
>>> static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
>>>                                            VFIOIOMMUFDContainer *container,
>>>                                            Error **errp)
>>> {
>>> +    /* mdevs aren't physical devices and will fail with auto domains */
>>> +    if (!vbasedev->mdev) {
>>> +        return iommufd_cdev_autodomains_get(vbasedev, container, errp);
>>> +    }
>>> +
>>>      return !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id,
>>> errp);
>>> }
>>>
>>> @@ -227,6 +305,11 @@ static void
>>> iommufd_cdev_detach_container(VFIODevice *vbasedev,
>>>      if (!iommufd_cdev_detach_ioas_hwpt(vbasedev, &err)) {
>>
>> Shouldn't we check mdev before calling this?
>>
> (...) here. Detach needs to be called for both, and keep in mind that this
> doesn't a pt_id, as the ioctl detaches from whatever domain or emulated idea of
> it (for mdev) that it has previously been called IOMMUFD_ATTACH with.
> 
> We also call this with mdev we just don't call it with a hwpt_id but rather use
> autodomains (and it doesn't actually allocate a hw domain)
>
>>>          error_report_err(err);
>>>      }
>>> +
>>> +    if (vbasedev->hwpt) {
>>> +        iommufd_cdev_autodomains_put(vbasedev, container);
>>> +    }
>>> +
>>> }
>>>
>>> static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer
>>> *container)
>>> @@ -354,6 +437,7 @@ static bool iommufd_cdev_attach(const char *name,
>>> VFIODevice *vbasedev,
>>>      container =
>>> VFIO_IOMMU_IOMMUFD(object_new(TYPE_VFIO_IOMMU_IOMMUFD));
>>>      container->be = vbasedev->iommufd;
>>>      container->ioas_id = ioas_id;
>>> +    QLIST_INIT(&container->hwpt_list);
>>
>> This can be in ::instance_init().
>>
> But there's no instance_init() for TYPE_VFIO_IOMMU_IOMMUFD. This is where all
> IOMMUFD container stuff is taking place aiui.

We can add an .instance_init() handler later on. It would be cleaner I agree
but it shouldn't be a reason to block the series.

Zhenzhong,

Did Joao address your concerns ?

Thanks,

C.




>> Thanks
>> Zhenzhong
>>
>>>
>>>      bcontainer = &container->bcontainer;
>>>      vfio_address_space_insert(space, bcontainer);
>>> diff --git a/backends/trace-events b/backends/trace-events
>>> index 211e6f374adc..4d8ac02fe7d6 100644
>>> --- a/backends/trace-events
>>> +++ b/backends/trace-events
>>> @@ -14,4 +14,5 @@ iommufd_backend_map_dma(int iommufd, uint32_t
>>> ioas, uint64_t iova, uint64_t size
>>> iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas,
>>> uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping:
>>> iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>>> iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova,
>>> uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64"
>>> size=0x%"PRIx64" (%d)"
>>> iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d
>>> ioas=%d"
>>> +iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t
>>> pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr,
>>> uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u
>>> flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u
>>> (%d)"
>>> iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d
>>> id=%d (%d)"
>>> --
>>> 2.17.2
>>
> 



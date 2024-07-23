Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1AF8C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 08:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWApa-0000vu-3M; Tue, 23 Jul 2024 04:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sWApY-0000oT-7O
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:25:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sWApV-0001Ak-Je
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721723103;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B+kFNx0Uk3WlkobVCqShZPskkhzY6dKWTuC1o8ej8bM=;
 b=fVxZnzUSENHSGgHyO3lxd+7rSNJPwK28Dw65LjuNw6BaZzCyVwdVqRXIRWiwlME5K4ef0q
 Xv2u2mqFUh1pC7YvezM70LGJCHvY88YyeljvUTvncZPlU+K2lzQxe3KLLXg1gV4waTMdMI
 SCVxoB/EbVSTt6bnEHSbZPs8s/sHw3k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-uSCZlLSkNmKbz_QfGcr9wA-1; Tue, 23 Jul 2024 04:25:02 -0400
X-MC-Unique: uSCZlLSkNmKbz_QfGcr9wA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-427a7a65e7dso20772965e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 01:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721723100; x=1722327900;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B+kFNx0Uk3WlkobVCqShZPskkhzY6dKWTuC1o8ej8bM=;
 b=FCtX+jJyeTVbtz2sg51LQgX0bemlIdjs0dgkIATXt/WpKyfQyPKdvbgaU1bhyVW3ji
 16LdVry3Zvsuftc72X80ccMjd5LnXNlhHZ087bpFsFQfhTO+oLBtI02/NC83uurN7DZ2
 6zjHxS//OZ8pbWW0Es8N+Fg9hayq1dmsCfL7KW5f9j2R09Gcsp4A7nkdLJUERO3TVtKf
 HI9CoUNIK/vt9qAesxZRNEVUDbCz//M0FnTzPlDkqwLQ3hyjXepNs/JjrrS41PGIqnVZ
 S4KAohUCrsVAMAdnWvThAM2rYN5xG2YhQmoGNpf4OALHRqnjTvOdeFZVGV0p1YLZfBjC
 Gxdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaNSTdvauJr8JjFzqfcM6M8SeJrb1zuz5Druoe5bPxEzxtUg+/1II5Jrr90pF4s44B2f18LGANbEKZVXsjwBpNRP7ScX4=
X-Gm-Message-State: AOJu0YxmHPxaebAUsW0c+Wv2pEF2zSy6be7ZoR4apeyLlXMMTnv0C1/p
 /UmhSLIfnOnWzKPZBl2PB62Yz/eVza75qjg5iipJNDiS/0aOkqPNYkJhTM6dobWXBB3Z38QzDwC
 Vg5PuVXLTG6XSuRj+nSvNcV7a+5AsUZLpkc+OMwtOmXLbW2hQ61Fhkd/Ddmle
X-Received: by 2002:a05:600c:4f42:b0:426:5b52:84fb with SMTP id
 5b1f17b1804b1-427ef32e9e8mr8729975e9.7.1721723099964; 
 Tue, 23 Jul 2024 01:24:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtz0D1SfgrtJGFb/j22IuQq6RdU4fv0DvhNtQbOVFbQkBuf0rub0JhiF5qwDtQzC5FOrQRyQ==
X-Received: by 2002:a05:600c:4f42:b0:426:5b52:84fb with SMTP id
 5b1f17b1804b1-427ef32e9e8mr8729795e9.7.1721723099540; 
 Tue, 23 Jul 2024 01:24:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a5c356sm188302955e9.18.2024.07.23.01.24.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 01:24:59 -0700 (PDT)
Message-ID: <79fde766-182c-41ab-b979-ceac088f4f54@redhat.com>
Date: Tue, 23 Jul 2024 10:24:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/9] vfio/{iommufd,container}: Invoke
 HostIOMMUDevice::realize() during attach_device()
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Joao Martins <joao.m.martins@oracle.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-5-joao.m.martins@oracle.com>
 <a1cc917a-7fa7-43da-b7b7-1b69308400b0@redhat.com>
 <eae669f6-f24f-4573-9934-2c6fb5b364ad@redhat.com>
 <8405600f-ffa2-43c2-8e51-7b6674de11ae@redhat.com>
 <e0ad88d2-c78d-4d28-9655-08fd5a92fe2b@oracle.com>
 <SJ0PR11MB674475ED43B94625DC359AA992A92@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB674475ED43B94625DC359AA992A92@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/23/24 10:20, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Subject: Re: [PATCH v6 4/9] vfio/{iommufd,container}: Invoke
>> HostIOMMUDevice::realize() during attach_device()
>>
>> On 23/07/2024 08:55, Eric Auger wrote:
>>>
>>> On 7/23/24 09:44, Cédric Le Goater wrote:
>>>> On 7/23/24 09:38, Eric Auger wrote:
>>>>> Hi Joao,
>>>>>
>>>>> On 7/22/24 23:13, Joao Martins wrote:
>>>>>> Move the HostIOMMUDevice::realize() to be invoked during the attach
>>>>>> of the device
>>>>>> before we allocate IOMMUFD hardware pagetable objects (HWPT). This
>>>>>> allows the use
>>>>>> of the hw_caps obtained by IOMMU_GET_HW_INFO that essentially
>> tell
>>>>>> if the IOMMU
>>>>>> behind the device supports dirty tracking.
>>>>>>
>>>>>> Note: The HostIOMMUDevice data from legacy backend is static and
>>>>>> doesn't
>>>>>> need any information from the (type1-iommu) backend to be
>> initialized.
>>>>>> In contrast however, the IOMMUFD HostIOMMUDevice data requires
>> the
>>>>>> iommufd FD to be connected and having a devid to be able to
>>>>>> successfully
>>>>> Nit: maybe this comment shall be also added in iommufd.c before the
>> call
>>>>> to vfio_device_hiod_realize() to avoid someone else to move that call
>>>>> earlier at some point
>>>>>> GET_HW_INFO. This means vfio_device_hiod_realize() is called in
>>>>>> different places within the backend .attach_device() implementation.
>>>>>>
>>>>>> Suggested-by: Cédric Le Goater <clg@redhat.cm>
>>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>>>> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>>> ---
>>>>>>   include/hw/vfio/vfio-common.h |  1 +
>>>>>>   hw/vfio/common.c              | 16 ++++++----------
>>>>>>   hw/vfio/container.c           |  4 ++++
>>>>>>   hw/vfio/helpers.c             | 11 +++++++++++
>>>>>>   hw/vfio/iommufd.c             |  4 ++++
>>>>>>   5 files changed, 26 insertions(+), 10 deletions(-)
>>>>>>
>>>>>> diff --git a/include/hw/vfio/vfio-common.h
>>>>>> b/include/hw/vfio/vfio-common.h
>>>>>> index 1a96678f8c38..4e44b26d3c45 100644
>>>>>> --- a/include/hw/vfio/vfio-common.h
>>>>>> +++ b/include/hw/vfio/vfio-common.h
>>>>>> @@ -242,6 +242,7 @@ void vfio_region_finalize(VFIORegion *region);
>>>>>>   void vfio_reset_handler(void *opaque);
>>>>>>   struct vfio_device_info *vfio_get_device_info(int fd);
>>>>>>   bool vfio_device_is_mdev(VFIODevice *vbasedev);
>>>>>> +bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
>>>>>>   bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>>>>>>                           AddressSpace *as, Error **errp);
>>>>>>   void vfio_detach_device(VFIODevice *vbasedev);
>>>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>>>>> index 784e266e6aab..da12cbd56408 100644
>>>>>> --- a/hw/vfio/common.c
>>>>>> +++ b/hw/vfio/common.c
>>>>>> @@ -1537,7 +1537,7 @@ bool vfio_attach_device(char *name,
>> VFIODevice
>>>>>> *vbasedev,
>>>>>>   {
>>>>>>       const VFIOIOMMUClass *ops =
>>>>>>
>>>>>>
>> VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
>>>>>> -    HostIOMMUDevice *hiod;
>>>>>> +    HostIOMMUDevice *hiod = NULL;
>>>>>>         if (vbasedev->iommufd) {
>>>>>>           ops =
>>>>>>
>> VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUF
>> D));
>>>>>> @@ -1545,21 +1545,17 @@ bool vfio_attach_device(char *name,
>>>>>> VFIODevice *vbasedev,
>>>>>>         assert(ops);
>>>>>>   -    if (!ops->attach_device(name, vbasedev, as, errp)) {
>>>>>> -        return false;
>>>>>> -    }
>>>>>>   -    if (vbasedev->mdev) {
>>>>>> -        return true;
>>>>>> +    if (!vbasedev->mdev) {
>>>>>> +        hiod = HOST_IOMMU_DEVICE(object_new(ops-
>>> hiod_typename));
>>>>>> +        vbasedev->hiod = hiod;
>>>>>>       }
>>>>>>   -    hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
>>>>>> -    if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod,
>> vbasedev,
>>>>>> errp)) {
>>>>>> +    if (!ops->attach_device(name, vbasedev, as, errp)) {
>>>>>>           object_unref(hiod);
>>>>>> -        ops->detach_device(vbasedev);
>>>>>> +        vbasedev->hiod = NULL;
>>>>>>           return false;
>>>>>>       }
>>>>>> -    vbasedev->hiod = hiod;
>>>>>>         return true;
>>>>>>   }
>>>>>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>>>>>> index 10cb4b4320ac..9ccdb639ac84 100644
>>>>>> --- a/hw/vfio/container.c
>>>>>> +++ b/hw/vfio/container.c
>>>>>> @@ -914,6 +914,10 @@ static bool vfio_legacy_attach_device(const
>>>>>> char *name, VFIODevice *vbasedev,
>>>>>>         trace_vfio_attach_device(vbasedev->name, groupid);
>>>>>>   +    if (!vfio_device_hiod_realize(vbasedev, errp)) {
>>>>>> +        return false;
>>>>> don't you want to go to err_alloc_ioas instead?
>>>> hmm, the err_alloc_ioas label is in a different function
>>>> iommufd_cdev_attach().
>>>>
>>>> may be you meant the comment for routine iommufd_cdev_attach() and
>>>> label err_connect_bind ?
>>>>
>>>>
>>>> Thanks,
>>>>
>>>> C.
>>>>
>>>>
>>>>>> +    }
>>>>>> +
>>>>>>       group = vfio_get_group(groupid, as, errp);
>>>>>>       if (!group) {
>>>>>>           return false;
>>>>>> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
>>>>>> index 7e23e9080c9d..ea15c79db0a3 100644
>>>>>> --- a/hw/vfio/helpers.c
>>>>>> +++ b/hw/vfio/helpers.c
>>>>>> @@ -689,3 +689,14 @@ bool vfio_device_is_mdev(VFIODevice
>> *vbasedev)
>>>>>>       subsys = realpath(tmp, NULL);
>>>>>>       return subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
>>>>>>   }
>>>>>> +
>>>>>> +bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp)
>>>>>> +{
>>>>>> +    HostIOMMUDevice *hiod = vbasedev->hiod;
>>>>>> +
>>>>>> +    if (!hiod) {
>>>>>> +        return true;
>>>>>> +    }
>>>>>> +
>>>>>> +    return HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod,
>>>>>> vbasedev, errp);
>>>>>> +}
>>>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>>>> index 5e2fc1ce089d..2324bf892c56 100644
>>>>>> --- a/hw/vfio/iommufd.c
>>>>>> +++ b/hw/vfio/iommufd.c
>>>>>> @@ -403,6 +403,10 @@ static bool iommufd_cdev_attach(const char
>>>>>> *name, VFIODevice *vbasedev,
>>>>>>         space = vfio_get_address_space(as);
>>>>>>   +    if (!vfio_device_hiod_realize(vbasedev, errp)) {
>>>>>> +        return false;
>>> Hum sorry my previous comment was targetting that place. I think
>>> unrolling is needed up to put_address_space
>>>
>>> so effectively this does not match err_alloc_ioas but I guess we would
>>> need another label
>>>
>> You're right. We haven't yet attached rthe device and that's what
>> err_alloc_ioas
>> would do. Adding another label not sure would make things cleaner given
>> the
>> ordering requirement. So maybe this instead?
>>
>> @@ -482,7 +483,8 @@ static bool iommufd_cdev_attach(const char *name,
>> VFIODevice
>> *vbasedev,
>>     space = vfio_get_address_space(as);
>>
>>     if (!vfio_device_hiod_realize(vbasedev, errp)) {
>> -        return false;
>> +        vfio_put_address_space(space);
>> +        goto err_connect_bind;
>>     }
>>
>>     /* try to attach to an existing container in this space */
> I was confused though Cedric and Eric both ACK this change. Don't we miss the iommufd_cdev_unbind_and_disconnect() call?
Hum yes you're right. connect and bind was done. I thought this was done
later. so err_alloc_ioas label looks good

Eric
>



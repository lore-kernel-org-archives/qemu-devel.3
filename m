Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC6AC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 08:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWAS4-0003DS-0e; Tue, 23 Jul 2024 04:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sWARy-0003Bl-DW
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:00:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sWARw-0004AK-H4
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721721643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HWY5shYtWizZJUz6wvz2A8tQRH40NYZbHbietKUzBP4=;
 b=d3C74cJJx3FzRXXaMBqph03PGRE0ZOyvHWqWerWlomCMYy3xnKPQGfkq4T8JjZ7u3IKXC8
 CeWlrMQ+/jsqKLhNnbl8A46eiU47b3LkYm3tLgqyoZTZzwgd8bGEkPcr+Eb+lmR6gOfpI7
 jI+S3ZM0ZiYaSdhrSfPokFJIzMbNBIY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-wf6lP9dwNW-P7ITyNkFnyw-1; Tue, 23 Jul 2024 04:00:41 -0400
X-MC-Unique: wf6lP9dwNW-P7ITyNkFnyw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-36871eb0a8eso2845698f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 01:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721721640; x=1722326440;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HWY5shYtWizZJUz6wvz2A8tQRH40NYZbHbietKUzBP4=;
 b=Ga9Uox5Yvzr+yaijcdonoKEEtJJyw+jjPCY78f3nlSk1hwdxiAEYLmJ4kod+BVh/Aq
 gwnJOUCSk3VEawnOmniKWy2904PXp93ed3TWWG8N3To99q7W6AuFUasOBmHSkfwP8Jb7
 /h9vowLJHmg5CAJx6USABP5I2TpiDeNnuudCPhprxIKVHl1Sy6x6Vnwgei1JSw11kVBT
 UkcEhlm+y4qkxPLO19fsI845Kq0DiL1Np6ZkPKR1EzasNwKZWMb9S/RzjFwdGEnoFO9I
 JdZ3sNyDTGUF6sz+h7Bx5QiamSnZG/5wDevmq9fAQ9V9n4TFRcCuAOOD68/7NeTsXOVA
 8mHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1p8p5qP0mlnulxXsAR9+ite5JE29lN0wqbGeZ5ZlF8lsEt0BcTra+M6R5rrtYpUO3xLMifZpciXiFtfevZmu/B2Oksaw=
X-Gm-Message-State: AOJu0YzCnM7+4YTeScwh/zO3BTa9i5MK58MRG9mQ/nOFyV+jKhMLXrKu
 8h7+0dxuM3fN+SCvckQqLPcKZCWpci8C+EJu6Z2vBn9wbnC3p/JcA1BgwlAVTfBdTULWUxRBIky
 RruFFvFeTBonVHvqHLzcdAjrl6ScsECEODSyk0W0xCT/DPfLXiZY/
X-Received: by 2002:a5d:47cb:0:b0:366:ee9b:847 with SMTP id
 ffacd0b85a97d-369dec1e43dmr1737458f8f.14.1721721640177; 
 Tue, 23 Jul 2024 01:00:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBbsnv4S4xAxHZJJbZUx483Dfw9Q5MHBb8fLVBdZLxXPJd8nYWyUB3oaFqyg4SZH2BCT+JdA==
X-Received: by 2002:a5d:47cb:0:b0:366:ee9b:847 with SMTP id
 ffacd0b85a97d-369dec1e43dmr1737434f8f.14.1721721639699; 
 Tue, 23 Jul 2024 01:00:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e?
 ([2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a9466bsm187796765e9.41.2024.07.23.01.00.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 01:00:39 -0700 (PDT)
Message-ID: <ab77b806-5c17-4a96-9c15-eb2317a54f6a@redhat.com>
Date: Tue, 23 Jul 2024 10:00:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/9] vfio/{iommufd,container}: Invoke
 HostIOMMUDevice::realize() during attach_device()
To: Joao Martins <joao.m.martins@oracle.com>, eric.auger@redhat.com,
 qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-5-joao.m.martins@oracle.com>
 <a1cc917a-7fa7-43da-b7b7-1b69308400b0@redhat.com>
 <5baed252-aea8-4ce4-b05d-1d9505a7bb41@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <5baed252-aea8-4ce4-b05d-1d9505a7bb41@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 7/23/24 09:53, Joao Martins wrote:
> On 23/07/2024 08:38, Eric Auger wrote:
>> Hi Joao,
>>
>> On 7/22/24 23:13, Joao Martins wrote:
>>> Move the HostIOMMUDevice::realize() to be invoked during the attach of the device
>>> before we allocate IOMMUFD hardware pagetable objects (HWPT). This allows the use
>>> of the hw_caps obtained by IOMMU_GET_HW_INFO that essentially tell if the IOMMU
>>> behind the device supports dirty tracking.
>>>
>>> Note: The HostIOMMUDevice data from legacy backend is static and doesn't
>>> need any information from the (type1-iommu) backend to be initialized.
>>> In contrast however, the IOMMUFD HostIOMMUDevice data requires the
>>> iommufd FD to be connected and having a devid to be able to successfully
>> Nit: maybe this comment shall be also added in iommufd.c before the call
>> to vfio_device_hiod_realize() to avoid someone else to move that call
>> earlier at some point
>>> GET_HW_INFO. This means vfio_device_hiod_realize() is called in
>>> different places within the backend .attach_device() implementation.
>>>
>>> Suggested-by: Cédric Le Goater <clg@redhat.cm>
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>   include/hw/vfio/vfio-common.h |  1 +
>>>   hw/vfio/common.c              | 16 ++++++----------
>>>   hw/vfio/container.c           |  4 ++++
>>>   hw/vfio/helpers.c             | 11 +++++++++++
>>>   hw/vfio/iommufd.c             |  4 ++++
>>>   5 files changed, 26 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>> index 1a96678f8c38..4e44b26d3c45 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -242,6 +242,7 @@ void vfio_region_finalize(VFIORegion *region);
>>>   void vfio_reset_handler(void *opaque);
>>>   struct vfio_device_info *vfio_get_device_info(int fd);
>>>   bool vfio_device_is_mdev(VFIODevice *vbasedev);
>>> +bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
>>>   bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>>>                           AddressSpace *as, Error **errp);
>>>   void vfio_detach_device(VFIODevice *vbasedev);
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index 784e266e6aab..da12cbd56408 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -1537,7 +1537,7 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>>>   {
>>>       const VFIOIOMMUClass *ops =
>>>           VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
>>> -    HostIOMMUDevice *hiod;
>>> +    HostIOMMUDevice *hiod = NULL;
>>>   
>>>       if (vbasedev->iommufd) {
>>>           ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
>>> @@ -1545,21 +1545,17 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>>>   
>>>       assert(ops);
>>>   
>>> -    if (!ops->attach_device(name, vbasedev, as, errp)) {
>>> -        return false;
>>> -    }
>>>   
>>> -    if (vbasedev->mdev) {
>>> -        return true;
>>> +    if (!vbasedev->mdev) {
>>> +        hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
>>> +        vbasedev->hiod = hiod;
>>>       }
>>>   
>>> -    hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
>>> -    if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
>>> +    if (!ops->attach_device(name, vbasedev, as, errp)) {
>>>           object_unref(hiod);
>>> -        ops->detach_device(vbasedev);
>>> +        vbasedev->hiod = NULL;
>>>           return false;
>>>       }
>>> -    vbasedev->hiod = hiod;
>>>   
>>>       return true;
>>>   }
>>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>>> index 10cb4b4320ac..9ccdb639ac84 100644
>>> --- a/hw/vfio/container.c
>>> +++ b/hw/vfio/container.c
>>> @@ -914,6 +914,10 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>>>   
>>>       trace_vfio_attach_device(vbasedev->name, groupid);
>>>   
>>> +    if (!vfio_device_hiod_realize(vbasedev, errp)) {
>>> +        return false;
>> don't you want to go to err_alloc_ioas instead?
> 
> Oh, yes, I thought I was doing that, but I am not :( Thanks for catching that
> 
> Your comment is spot on but in the wrong place.
> 
> vfio_legacy_attach_device() can just return false as it's at the top of the
> function but here (...)
> 
>>> +    }
>>> +
>>>       group = vfio_get_group(groupid, as, errp);
>>>       if (!group) {
>>>           return false;
>>> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
>>> index 7e23e9080c9d..ea15c79db0a3 100644
>>> --- a/hw/vfio/helpers.c
>>> +++ b/hw/vfio/helpers.c
>>> @@ -689,3 +689,14 @@ bool vfio_device_is_mdev(VFIODevice *vbasedev)
>>>       subsys = realpath(tmp, NULL);
>>>       return subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
>>>   }
>>> +
>>> +bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp)
>>> +{
>>> +    HostIOMMUDevice *hiod = vbasedev->hiod;
>>> +
>>> +    if (!hiod) {
>>> +        return true;
>>> +    }
>>> +
>>> +    return HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp);
>>> +}
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index 5e2fc1ce089d..2324bf892c56 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -403,6 +403,10 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>>>   
>>>       space = vfio_get_address_space(as);
>>>   
>>> +    if (!vfio_device_hiod_realize(vbasedev, errp)) {
>>> +        return false;
>>> +    }
>>> +
> 
> (...) we definitely need a goto err_alloc_ioas here.
> 
> Snip below:
> 
> @@ -482,7 +483,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice
> *vbasedev,
>       space = vfio_get_address_space(as);
> 
>       if (!vfio_device_hiod_realize(vbasedev, errp)) {
> -        return false;
> +        goto err_alloc_ioas;
>       }
> 
>       /* try to attach to an existing container in this space */
> 

ok. Applied the changes.


Thanks,

C.





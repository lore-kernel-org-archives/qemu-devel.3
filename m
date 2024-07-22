Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C677BC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 15:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVujT-0005r8-3c; Mon, 22 Jul 2024 11:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sVujN-0005p9-Cg
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 11:13:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sVujL-0005dg-1G
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 11:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721661217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OktzIyp+O8Bk73QmL0XsgshYqeJl7DE38QlOHnqONt0=;
 b=cPCdZUDxKi6y/2+tK7nXiMA7y8y/1v5HyL7iAtAP17RfzNXa4K3QnyQFqu6lNqy9fc8DGc
 ZzFNslUwI/CaUv9lXrwKAZVodqQC5aSTErd5mhX8rLNEc5zJvrrgllO9Mw1BxThOzHvlnC
 WOk0grZ1UhtRqX67i765QnDxi8iUrnM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-2UneoxcNOdSVqWUQ-UkjUQ-1; Mon, 22 Jul 2024 11:13:34 -0400
X-MC-Unique: 2UneoxcNOdSVqWUQ-UkjUQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-79efd11a9faso520028985a.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 08:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721661214; x=1722266014;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OktzIyp+O8Bk73QmL0XsgshYqeJl7DE38QlOHnqONt0=;
 b=eGfy2SNnWOavPCEvm5cMlhrRtLVmY0I/w2dzVZk4+myPGFg+PLFpdAVjlclFndy95V
 h6ZrhnJUBY+awBNvS4z+fFhdmE6smBZI8Ky64+Y5NZSMp0f0ux/kjbEaCjFl9iZqKY0Y
 Y6Gl24U1O2lzLjBr+zKRNL5nJMS0fGY3mR2PKaMwsiwyX9okToLPh43cgCyoXymrTBBq
 0YyDZrStQw+QIteyHqanIbpLJdrDyij3m7mPSvihHqotKYZcrz82960a9OvdCZCHa1nN
 XrOIjFoxPSsYTLv4lAoTqfRPCphXGQ13n+5aRakbAg2U7u4leb04KRk+zZtwJwhQEw22
 c/Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfXhPJHjqk6YFxxn0npwZNIfCP77eSlVdr9UQXr/wFxgHPQqhQAKRMft8CMmI/Qbl6c/rfLB6QBBpYRV5Nmk7EW2cFIwE=
X-Gm-Message-State: AOJu0YxkeXANmPjtG7AILHq6KcFLchWYHoj91fERknaDvt4eFB6iz4Pf
 mK6j6GlESTym371IvZ0RUKnx5hDqfs83A6d3UOuO8tdv+QqfD8W1x1fIP8lzYaqyjo4+/D/ZFfa
 S5dF2hOJq/tUPwpUN7LQnvAo/tv7rhdaOeMFCGb4s+r4lA0am2Al4
X-Received: by 2002:ad4:5f8d:0:b0:6b5:ebd3:b8f8 with SMTP id
 6a1803df08f44-6b9610274b0mr107531256d6.4.1721661213824; 
 Mon, 22 Jul 2024 08:13:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6lFNYxm3ZfwYg/+M9DlMwjY7rzgbhMx0FwTfK65/we+WrBaO6tTbX5pQY90zN/ASea4Pliw==
X-Received: by 2002:ad4:5f8d:0:b0:6b5:ebd3:b8f8 with SMTP id
 6a1803df08f44-6b9610274b0mr107530926d6.4.1721661213407; 
 Mon, 22 Jul 2024 08:13:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e?
 ([2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b7ac7bd2a7sm36253976d6.20.2024.07.22.08.13.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 08:13:33 -0700 (PDT)
Message-ID: <51012898-c535-4fb1-b101-3d613d46fc30@redhat.com>
Date: Mon, 22 Jul 2024 17:13:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/13] vfio/migration: Don't block migration device
 dirty tracking is unsupported
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
 <20240719120501.81279-13-joao.m.martins@oracle.com>
 <a8239962-c987-4ca1-b342-95fd8f03179e@redhat.com>
 <f5d64358-70e3-4217-8376-356c8aaac8ea@oracle.com>
 <1304a8c4-be47-4b47-88dd-328a8f167e54@oracle.com>
 <967952f0-e3bd-4c86-b4a8-4906e6b3e248@redhat.com>
 <103a2101-3f9e-46da-b45b-b8a4eaa7d6e7@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <103a2101-3f9e-46da-b45b-b8a4eaa7d6e7@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/22/24 17:01, Joao Martins wrote:
> On 22/07/2024 15:53, Cédric Le Goater wrote:
>> On 7/19/24 19:26, Joao Martins wrote:
>>> On 19/07/2024 15:24, Joao Martins wrote:
>>>> On 19/07/2024 15:17, Cédric Le Goater wrote:
>>>>> On 7/19/24 14:05, Joao Martins wrote:
>>>>>> By default VFIO migration is set to auto, which will support live
>>>>>> migration if the migration capability is set *and* also dirty page
>>>>>> tracking is supported.
>>>>>>
>>>>>> For testing purposes one can force enable without dirty page tracking
>>>>>> via enable-migration=on, but that option is generally left for testing
>>>>>> purposes.
>>>>>>
>>>>>> So starting with IOMMU dirty tracking it can use to accomodate the lack of
>>>>>> VF dirty page tracking allowing us to minimize the VF requirements for
>>>>>> migration and thus enabling migration by default for those too.
>>>>>>
>>>>>> While at it change the error messages to mention IOMMU dirty tracking as
>>>>>> well.
>>>>>>
>>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>>>> ---
>>>>>>     include/hw/vfio/vfio-common.h |  1 +
>>>>>>     hw/vfio/iommufd.c             |  2 +-
>>>>>>     hw/vfio/migration.c           | 11 ++++++-----
>>>>>>     3 files changed, 8 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>>>>> index 7e530c7869dc..00b9e933449e 100644
>>>>>> --- a/include/hw/vfio/vfio-common.h
>>>>>> +++ b/include/hw/vfio/vfio-common.h
>>>>>> @@ -299,6 +299,7 @@ int vfio_devices_query_dirty_bitmap(const
>>>>>> VFIOContainerBase *bcontainer,
>>>>>>                     VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
>>>>>>     int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t
>>>>>> iova,
>>>>>>                               uint64_t size, ram_addr_t ram_addr, Error
>>>>>> **errp);
>>>>>> +bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt);
>>>>>>       /* Returns 0 on success, or a negative errno. */
>>>>>>     bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>>>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>>>> index 7dd5d43ce06a..a998e8578552 100644
>>>>>> --- a/hw/vfio/iommufd.c
>>>>>> +++ b/hw/vfio/iommufd.c
>>>>>> @@ -111,7 +111,7 @@ static void iommufd_cdev_unbind_and_disconnect(VFIODevice
>>>>>> *vbasedev)
>>>>>>         iommufd_backend_disconnect(vbasedev->iommufd);
>>>>>>     }
>>>>>>     -static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>>>>> +bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>>>>>     {
>>>>>>         return hwpt && hwpt->hwpt_flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>>>>>     }
>>>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>>>> index 34d4be2ce1b1..63ffa46c9652 100644
>>>>>> --- a/hw/vfio/migration.c
>>>>>> +++ b/hw/vfio/migration.c
>>>>>> @@ -1036,16 +1036,17 @@ bool vfio_migration_realize(VFIODevice *vbasedev,
>>>>>> Error **errp)
>>>>>>             return !vfio_block_migration(vbasedev, err, errp);
>>>>>>         }
>>>>>>     -    if (!vbasedev->dirty_pages_supported) {
>>>>>> +    if (!vbasedev->dirty_pages_supported &&
>>>>>> +        !iommufd_hwpt_dirty_tracking(vbasedev->hwpt)) {
>>>>>
>>>>>
>>>>> Some platforms do not have IOMMUFD support and this call will need
>>>>> some kind of abstract wrapper to reflect dirty tracking support in
>>>>> the IOMMU backend.
>>>>>
>>>>
>>>> This was actually on purpose because only IOMMUFD presents a view of hardware
>>>> whereas type1 supporting dirty page tracking is not used as means to 'migration
>>>> is supported'.
>>>>
>>>> The hwpt is nil in type1 and the helper checks that, so it should return false.
>>>>
>>>
>>> Oh wait, maybe you're talking about CONFIG_IOMMUFD=n which I totally didn't
>>> consider. Maybe this would be a elegant way to address it? Looks to pass my
>>> build with CONFIG_IOMMUFD=n
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>> index 61dd48e79b71..422ad4a5bdd1 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -300,7 +300,14 @@ int vfio_devices_query_dirty_bitmap(const VFIOContainerBase
>>> *bcontainer,
>>>                    VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
>>>    int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>>>                              uint64_t size, ram_addr_t ram_addr, Error **errp);
>>> +#ifdef CONFIG_IOMMUFD
>>>    bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt);
>>> +#else
>>> +static inline bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>> +{
>>> +    return false;
>>> +}
>>> +#endif
>>>
>>>    /* Returns 0 on success, or a negative errno. */
>>>    bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>>>
>>
>> hmm, no. You will need to introduce a new Host IOMMU device capability,
>> something like :
>>
>>     HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING,
>>
>> Then, introduce an helper routine to check the capability  :
>>
>>     return hiodc->get_cap( ... HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING...)
>>   
>> and replace the iommufd_hwpt_dirty_tracking call with it.
>>
>> Yeah I know, it's cumbersome but it's cleaner !
>>
> 
> Funny you mention it, because that's what I did in v3:
> 
> https://lore.kernel.org/qemu-devel/20240708143420.16953-9-joao.m.martins@oracle.com/
> 
> But it was suggested to drop (I am assuming to avoid complexity)

my bad if I did :/

we will need an helper such as :

   bool vfio_device_dirty_tracking(VFIODevice *vbasedev)
   {
       HostIOMMUDevice *hiod = vbasedev->hiod ;
       HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);

       return hiodc->get_cap &&
           hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING, NULL) == 1;
   }

and something like,

   static int hiod_iommufd_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
                                        Error **errp)
   {
       switch (cap) {
       case HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING:
           return !!(hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING);
       default:
           error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
           return -EINVAL;
       }
   }

Feel free to propose your own implementation,

Thanks,

C.



> 
>> That's not a major problem in the series. I can address it at the end
>> to avoid a resend. First, let's get a R-b on all other patches.
>>
>> Thanks,
>>
>> C.
>>
>>
> 



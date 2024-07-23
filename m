Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319DCC3DA64
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 06:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW9Ac-0000as-Qy; Tue, 23 Jul 2024 02:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sW9Aa-0000Si-Ic
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 02:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sW9AX-0004yw-KI
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 02:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721716719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Wpa6PoKOb18eQjQNfFRTpUPqIh3UPcbUwSXIrTDtk8=;
 b=LaXGYFcZv6jTYxYphQlNj6VrNGLQ5kSr3kaDgQTihVo3wm0se1ZurqKqBNma786rTy9o6g
 4O7XLuqvxT18+81mRp3vNia96rjgfskE8cWg3xlfd8jOmiRr0IoEWdMem86mFl5C/ANJcl
 6Tb8l+OrA96/NKZmOz1ZHYQE0wlGPZI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-raH073ipOYWzam3h9qsO3A-1; Tue, 23 Jul 2024 02:38:38 -0400
X-MC-Unique: raH073ipOYWzam3h9qsO3A-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4266edc9c85so34826925e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 23:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721716717; x=1722321517;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Wpa6PoKOb18eQjQNfFRTpUPqIh3UPcbUwSXIrTDtk8=;
 b=bLXqSXCQIhJsTJMLljwGurpp/aKXcC0Bc5b3CCnwZWxec/BBxXdlZ4BaVpHuOcMkRc
 2oLPgOR2p6EqRDddVQ/XJn7aLO3gsL93Xxb29n92OPdSrtEdPtu7pTCk7/NdYPDPF3CN
 3zuHR3iqJ5mJ0zJqFd4t8/C7NYwhsH/dJyikLX3dfAisJD39ivA1XASGuoUvSE3az23e
 e0dAPFcBFdzPMdmJKCJpUw2FTWF0xfu5kmRMO+i19crEar+GVCYhgPwikm6BpAEOBwtO
 gdTjPSQwO2geLs9CJ9mNut3aMZJc0dskPY9P2zJ1C9pSBiuShZLblxp+k4Lwf9aF7otv
 ibeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD8MtaA0Ogemb6JzEtx8Pp/qdCeBeq5XOdPEYnQHnWRfeBynH243n7HDYpYhNk8ph+mxquu7JXdSOf+TsPFK/lCDoPPs4=
X-Gm-Message-State: AOJu0Yz0tDZNYQS61gl5g/HWE2wCwLQ8ecFUpO8GUM2xCV9d0Chvsg+i
 lV8nLeIq5zmCNXZ5l3w/gw8jWHdlL44utqMUKxTZCxCgNjzdKlU6rPwZYhuc+ye2RP4AKjZLNOK
 9qISJt6+P6HrqTpLWgAQAxw5yOL1/Akxl3C4ZjG9lW2PavAp/QJS/
X-Received: by 2002:a05:600c:a47:b0:426:4f47:6037 with SMTP id
 5b1f17b1804b1-427ed016d9fmr12674335e9.19.1721716716964; 
 Mon, 22 Jul 2024 23:38:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUWh4DDdfVqCWJUqn8psm35JLh9d9l1Mo4KXg2PD9+t9Mm2ZerqCBaOp1Iasx5rZgSNNiBJg==
X-Received: by 2002:a05:600c:a47:b0:426:4f47:6037 with SMTP id
 5b1f17b1804b1-427ed016d9fmr12674155e9.19.1721716716448; 
 Mon, 22 Jul 2024 23:38:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e?
 ([2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a721b7sm179761445e9.27.2024.07.22.23.38.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 23:38:35 -0700 (PDT)
Message-ID: <892227e1-c24e-444a-b934-18ba8e48c177@redhat.com>
Date: Tue, 23 Jul 2024 08:38:34 +0200
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
 <51012898-c535-4fb1-b101-3d613d46fc30@redhat.com>
 <27e2792c-6eba-4fab-a22d-40e46dae9cda@oracle.com>
 <f9e3bc1c-71f2-442a-8697-19b64a225d57@redhat.com>
 <1d7aaeb6-67ab-4897-96e0-e6128680dd4c@oracle.com>
 <544c0bfe-7dcc-48e7-80a3-ca7f4b255d1b@redhat.com>
 <a4129e04-5923-467a-a359-88697a5a464b@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <a4129e04-5923-467a-a359-88697a5a464b@oracle.com>
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

On 7/22/24 20:01, Joao Martins wrote:
> On 22/07/2024 18:04, Cédric Le Goater wrote:
>> On 7/22/24 18:29, Joao Martins wrote:
>>> On 22/07/2024 16:58, Cédric Le Goater wrote:
>>>> On 7/22/24 17:42, Joao Martins wrote:
>>>>> On 22/07/2024 16:13, Cédric Le Goater wrote:
>>>>>> On 7/22/24 17:01, Joao Martins wrote:
>>>>>>> On 22/07/2024 15:53, Cédric Le Goater wrote:
>>>>>>>> On 7/19/24 19:26, Joao Martins wrote:
>>>>>>>>> On 19/07/2024 15:24, Joao Martins wrote:
>>>>>>>>>> On 19/07/2024 15:17, Cédric Le Goater wrote:
>>>>>>>>>>> On 7/19/24 14:05, Joao Martins wrote:
>>>>>>>>>>>> By default VFIO migration is set to auto, which will support live
>>>>>>>>>>>> migration if the migration capability is set *and* also dirty page
>>>>>>>>>>>> tracking is supported.
>>>>>>>>>>>>
>>>>>>>>>>>> For testing purposes one can force enable without dirty page tracking
>>>>>>>>>>>> via enable-migration=on, but that option is generally left for testing
>>>>>>>>>>>> purposes.
>>>>>>>>>>>>
>>>>>>>>>>>> So starting with IOMMU dirty tracking it can use to accomodate the
>>>>>>>>>>>> lack of
>>>>>>>>>>>> VF dirty page tracking allowing us to minimize the VF requirements for
>>>>>>>>>>>> migration and thus enabling migration by default for those too.
>>>>>>>>>>>>
>>>>>>>>>>>> While at it change the error messages to mention IOMMU dirty tracking as
>>>>>>>>>>>> well.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>>>>>>>>>> ---
>>>>>>>>>>>>        include/hw/vfio/vfio-common.h |  1 +
>>>>>>>>>>>>        hw/vfio/iommufd.c             |  2 +-
>>>>>>>>>>>>        hw/vfio/migration.c           | 11 ++++++-----
>>>>>>>>>>>>        3 files changed, 8 insertions(+), 6 deletions(-)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/include/hw/vfio/vfio-common.h
>>>>>>>>>>>> b/include/hw/vfio/vfio-common.h
>>>>>>>>>>>> index 7e530c7869dc..00b9e933449e 100644
>>>>>>>>>>>> --- a/include/hw/vfio/vfio-common.h
>>>>>>>>>>>> +++ b/include/hw/vfio/vfio-common.h
>>>>>>>>>>>> @@ -299,6 +299,7 @@ int vfio_devices_query_dirty_bitmap(const
>>>>>>>>>>>> VFIOContainerBase *bcontainer,
>>>>>>>>>>>>                        VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error
>>>>>>>>>>>> **errp);
>>>>>>>>>>>>        int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer,
>>>>>>>>>>>> uint64_t
>>>>>>>>>>>> iova,
>>>>>>>>>>>>                                  uint64_t size, ram_addr_t ram_addr,
>>>>>>>>>>>> Error
>>>>>>>>>>>> **errp);
>>>>>>>>>>>> +bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt);
>>>>>>>>>>>>          /* Returns 0 on success, or a negative errno. */
>>>>>>>>>>>>        bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>>>>>>>>>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>>>>>>>>>> index 7dd5d43ce06a..a998e8578552 100644
>>>>>>>>>>>> --- a/hw/vfio/iommufd.c
>>>>>>>>>>>> +++ b/hw/vfio/iommufd.c
>>>>>>>>>>>> @@ -111,7 +111,7 @@ static void
>>>>>>>>>>>> iommufd_cdev_unbind_and_disconnect(VFIODevice
>>>>>>>>>>>> *vbasedev)
>>>>>>>>>>>>            iommufd_backend_disconnect(vbasedev->iommufd);
>>>>>>>>>>>>        }
>>>>>>>>>>>>        -static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>>>>>>>>>>> +bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>>>>>>>>>>>        {
>>>>>>>>>>>>            return hwpt && hwpt->hwpt_flags &
>>>>>>>>>>>> IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>>>>>>>>>>>        }
>>>>>>>>>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>>>>>>>>>> index 34d4be2ce1b1..63ffa46c9652 100644
>>>>>>>>>>>> --- a/hw/vfio/migration.c
>>>>>>>>>>>> +++ b/hw/vfio/migration.c
>>>>>>>>>>>> @@ -1036,16 +1036,17 @@ bool vfio_migration_realize(VFIODevice
>>>>>>>>>>>> *vbasedev,
>>>>>>>>>>>> Error **errp)
>>>>>>>>>>>>                return !vfio_block_migration(vbasedev, err, errp);
>>>>>>>>>>>>            }
>>>>>>>>>>>>        -    if (!vbasedev->dirty_pages_supported) {
>>>>>>>>>>>> +    if (!vbasedev->dirty_pages_supported &&
>>>>>>>>>>>> +        !iommufd_hwpt_dirty_tracking(vbasedev->hwpt)) {
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Some platforms do not have IOMMUFD support and this call will need
>>>>>>>>>>> some kind of abstract wrapper to reflect dirty tracking support in
>>>>>>>>>>> the IOMMU backend.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> This was actually on purpose because only IOMMUFD presents a view of
>>>>>>>>>> hardware
>>>>>>>>>> whereas type1 supporting dirty page tracking is not used as means to
>>>>>>>>>> 'migration
>>>>>>>>>> is supported'.
>>>>>>>>>>
>>>>>>>>>> The hwpt is nil in type1 and the helper checks that, so it should return
>>>>>>>>>> false.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Oh wait, maybe you're talking about CONFIG_IOMMUFD=n which I totally didn't
>>>>>>>>> consider. Maybe this would be a elegant way to address it? Looks to pass my
>>>>>>>>> build with CONFIG_IOMMUFD=n
>>>>>>>>>
>>>>>>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>>>>>>>> index 61dd48e79b71..422ad4a5bdd1 100644
>>>>>>>>> --- a/include/hw/vfio/vfio-common.h
>>>>>>>>> +++ b/include/hw/vfio/vfio-common.h
>>>>>>>>> @@ -300,7 +300,14 @@ int vfio_devices_query_dirty_bitmap(const
>>>>>>>>> VFIOContainerBase
>>>>>>>>> *bcontainer,
>>>>>>>>>                       VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error
>>>>>>>>> **errp);
>>>>>>>>>       int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer,
>>>>>>>>> uint64_t
>>>>>>>>> iova,
>>>>>>>>>                                 uint64_t size, ram_addr_t ram_addr, Error
>>>>>>>>> **errp);
>>>>>>>>> +#ifdef CONFIG_IOMMUFD
>>>>>>>>>       bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt);
>>>>>>>>> +#else
>>>>>>>>> +static inline bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>>>>>>>> +{
>>>>>>>>> +    return false;
>>>>>>>>> +}
>>>>>>>>> +#endif
>>>>>>>>>
>>>>>>>>>       /* Returns 0 on success, or a negative errno. */
>>>>>>>>>       bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>>>>>>>>>
>>>>>>>>
>>>>>>>> hmm, no. You will need to introduce a new Host IOMMU device capability,
>>>>>>>> something like :
>>>>>>>>
>>>>>>>>        HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING,
>>>>>>>>
>>>>>>>> Then, introduce an helper routine to check the capability  :
>>>>>>>>
>>>>>>>>        return hiodc->get_cap( ... HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING...)
>>>>>>>>      and replace the iommufd_hwpt_dirty_tracking call with it.
>>>>>>>>
>>>>>>>> Yeah I know, it's cumbersome but it's cleaner !
>>>>>>>>
>>>>>>>
>>>>>>> Funny you mention it, because that's what I did in v3:
>>>>>>>
>>>>>>> https://lore.kernel.org/qemu-devel/20240708143420.16953-9-joao.m.martins@oracle.com/
>>>>>>>
>>>>>>> But it was suggested to drop (I am assuming to avoid complexity)
>>>>>>
>>>>>> my bad if I did :/
>>>>>>
>>>>>
>>>>> No worries it is all part of review -- I think Zhenzhong proposed with good
>>>>> intentions, and I probably didn't think too hard about the consequences on
>>>>> layering with the HIOD.
>>>>>
>>>>>> we will need an helper such as :
>>>>>>
>>>>>>      bool vfio_device_dirty_tracking(VFIODevice *vbasedev)
>>>>>>      {
>>>>>>          HostIOMMUDevice *hiod = vbasedev->hiod ;
>>>>>>          HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>>>>>>
>>>>>>          return hiodc->get_cap &&
>>>>>>              hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING, NULL)
>>>>>> == 1;
>>>>>>      }
>>>>>>
>>>>>> and something like,
>>>>>>
>>>>>>      static int hiod_iommufd_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
>>>>>>                                           Error **errp)
>>>>>>      {
>>>>>>          switch (cap) {
>>>>>>          case HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING:
>>>>>>              return !!(hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING);
>>>>>>          default:
>>>>>>              error_setg(errp, "%s: unsupported capability %x", hiod->name,
>>>>>> cap);
>>>>>>              return -EINVAL;
>>>>>>          }
>>>>>>      }
>>>>>>
>>>>>> Feel free to propose your own implementation,
>>>>>>
>>>>>
>>>>> Actually it's close to what I had in v3 link, except the new helper (the name
>>>>> vfio_device_dirty_tracking is a bit misleading I would call it
>>>>> vfio_device_iommu_dirty_tracking)
>>>>
>>>> Let's call it vfio_device_iommu_dirty_tracking.
>>>>
>>>
>>> I thinking about this and I am not that sure it makes sense. That is the
>>> .get_cap() stuff.
>>>
>>> Using the hw_caps is only useful when choosing hwpt_flags, then the only thing
>>> that matters for patch 12 is after the device is attached ... hence we gotta
>>> look at hwpt_flags. That ultimately is what tells if dirty tracking can be done
>>> in the device pagetable.
>>>
>>> I can expand hiod_iommufd_vfio_get_cap() to return the hwpt flags, but it feels
>>> just as hacky given that I am testing its enablement of the hardware pagetable
>>> (HWPT), and not asking a HIOD capability.
>>
>> arf. yes.
>>
>>> e.g. hiod_iommufd_vfio_get_cap would make more sense in patch 9 for the
>>> attach_device() flow[*], but not for vfio_migration_realize() flow.
>>>
>>> [*] though feels unneeded as we only have a local callsite, not external user so
>>> far.
>>>
>>> Which would technically make v5.1 patch a more correct right check, perhaps with
>>> better layering/naming.
>>
>> The quick fix (plan B if needed) would be :
>>
>> @@ -1038,8 +1038,11 @@ bool vfio_migration_realize(VFIODevice *
>>       }
>>   
>>       if ((!vbasedev->dirty_pages_supported ||
>> -         vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF) &&
>> -        !iommufd_hwpt_dirty_tracking(vbasedev->hwpt)) {
>> +         vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF)
>> +#ifdef CONFIG_IOMMUFD
>> +        && !iommufd_hwpt_dirty_tracking(vbasedev->hwpt)
>> +#endif
>> +        ) {
>>           if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
>>               error_setg(&err,
>>                          "%s: VFIO device doesn't support device and "
>>
>> I would prefer to avoid the common component to reference IOMMUFD
>> directly. The only exception today is the use of the vbasedev->iommufd
>> pointer which is treated as opaque.
>>
>> I guess a simple approach would be to store the result of
>> iommufd_hwpt_dirty_tracking(hwpt) under a 'dirty_tracking' attribute
>> of vbasedev and return the value in vfio_device_iommu_dirty_tracking() ?
>>
>> if not, let's merge v5 (with more acks) and the fix of plan B.
>>
>>
>>>>> I can follow-up with this improvement in case this gets merged as is,
>>>>
>>>> I can't merge as is since it break compiles (I am excluding the v5.1 patch).
>>>> Which means I would prefer a v6 please.
>>>>
>>>
>>> Ah OK -- I thought this discussion assumed v5.1 to be in which does fix the
>>> compilation issue and all that remained were acks.
>>
>> v5.1 proposes a CONFIG_IOMMUFD in a header file which is error prone.
>>   
> 
> hmmm, ok, that's strage. It does look quite common in Qemu? e.g. We even have
> CONFIG_LINUX in the vfio-common.h header file.

Yes. there are some high level CONFIG options like LINUX, TCG, KVM,
etc in header files. It's different for device CONFIG options, you
first need to include CONFIG_DEVICES.

Thanks,

C.



> 
>>>>> or include
>>>>> it in the next version if you prefer to adjourn this series into 9.2 (given the
>>>>> lack of time to get everything right).
>>>>
>>>> There aren't many open questions left.
>>>>
>>>> * PATCH 5 lacks a R-b. I would feel more confortable if ZhenZhong or
>>>>     Eric acked the changes.
>>>> * PATCH 9 is slightly hacky with the use of vfio_device_get_aw_bits().
>>>>     I think it's minor. I would also feel more confortable if ZhenZhong
>>>>     acked the changes.
>>>
>>> I guess you meant patch 6 and not 9.
>>
>> yes.
>>
>> Thanks,
>>
>> C.
>>
>>
>>
>>>
>>>> * PATCH 12 needs the fix we have been talking about.
>>>> * PATCH 13 is for dev/debug.
>>>>
>>>>
>>>> What's important is to avoid introducing regressions in the current behavior,
>>>> that is when not using IOMMUFD. It looks fine on that aspect AFAICT.
>>>
>>> OK
>>>
>>
> 



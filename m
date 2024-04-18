Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB87C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 06:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxLTs-0000eu-24; Thu, 18 Apr 2024 02:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rxLTp-0000dK-MT
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 02:42:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rxLTn-0007lW-Fh
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 02:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713422562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CVRdTQJVhZMYYe1te75iCcYl0zKB+QuuJyD5+g1+Z4Q=;
 b=Nt9UiISCBla7xNYBX0yc6n2OAgXG6rQ8EMpXY1boUuJTo+f4ZNelm+Oy1UQw6Q8beROWIg
 2JaCgG62DnoH7Wq3WGTYDjb+YFO59jZXCcMAQZMs9I3p/p8KACXLXWj4VM7l7JLB3V5Djm
 0XGpO3t2nSdeEZmw5TujD1jWbs33QCQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-a_ZX9JnCMfmyNLuMtvP5rw-1; Thu, 18 Apr 2024 02:42:40 -0400
X-MC-Unique: a_ZX9JnCMfmyNLuMtvP5rw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-78ed2a710efso77009785a.1
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 23:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713422560; x=1714027360;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CVRdTQJVhZMYYe1te75iCcYl0zKB+QuuJyD5+g1+Z4Q=;
 b=lS/KWFGNvkjwhnSYtKV24mhosoXQm8Wt6piTlilSI3Sdu+ktuNOU7fmzCw00FfpTT2
 VFfZQmWXY4+TcvQIh851IWVavi5owGp669AGjOS0rursxawU75WGSSyRAFEKeGL564nt
 /I9P1bdlBPOmHgGjucvoEm+Dm3O0Is92mJBFloNExp+pnuCB/B2z+kXpPTaKw/3KfMMA
 swCeHg9A4z8nIsPQyt/JNrLbHA01k+tSLioQLZx7O26wZCGcn4eZgPacnOmeLArteFss
 B0mIMMsu1BBxnHtdgkKJXloTB/D/txQXf89aoA3J4rxLNgDWX5ypk6wy0VvOd1deOApQ
 8xTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjgAy7f4oqE4Md8Gc+PsnKFEmlbytW5YHKjgv5lVYP5oGFAIdz9igwnrCHH6t5IF1P0clT5rPG8yHSaQ1SGxyHv/bY8kA=
X-Gm-Message-State: AOJu0YzALltLKv0PvOcfTgCnx6INH+IsBhuodF7pi2vPG1Uh0ADHL87x
 HtJ6csFazTeqtksh6udLjGTQ0bWuuVCYv6KpVeXzhn5RCqGyMxWx+QDK9CPtgaF4a1N7i3z+IwY
 ud1ccFEsZDOkOV4eTc1MmZODxhFJJo5OTp91L+9Pbw5gpebBPp3cY
X-Received: by 2002:a05:620a:5758:b0:78e:c527:4d95 with SMTP id
 wj24-20020a05620a575800b0078ec5274d95mr1818581qkn.6.1713422560184; 
 Wed, 17 Apr 2024 23:42:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpyFbN1tDwP4MLVKaniGNCOAfY4Z60FgVwqi9LaLhxRoF5Zy3Uw9Dwh7SeF18HPjPZTHGizw==
X-Received: by 2002:a05:620a:5758:b0:78e:c527:4d95 with SMTP id
 wj24-20020a05620a575800b0078ec5274d95mr1818552qkn.6.1713422559835; 
 Wed, 17 Apr 2024 23:42:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae?
 ([2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae])
 by smtp.gmail.com with ESMTPSA id
 s3-20020ac85283000000b004364ee6909esm387850qtn.83.2024.04.17.23.42.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 23:42:39 -0700 (PDT)
Message-ID: <afac1b03-11ea-4bb9-ab79-92cff2c0ea20@redhat.com>
Date: Thu, 18 Apr 2024 08:42:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] intel_iommu: Add a framework to do compatibility
 check with host IOMMU cap/ecap
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240408084404.1111628-1-zhenzhong.duan@intel.com>
 <20240408084404.1111628-4-zhenzhong.duan@intel.com>
 <251715ae-5378-4dfb-bc14-47ba2e62f83a@redhat.com>
 <SJ0PR11MB67443BF6BC7CABCE28F482A392082@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <5eb6c665-df8f-4c5e-8426-4678d8433a0c@redhat.com>
 <SJ0PR11MB6744F7A99B9303C8A3699EE9920F2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <b67b6ba8-b506-4865-9ab0-e9107cd5b12a@redhat.com>
 <SJ0PR11MB67442AA733CF06B144D33934920F2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB67442AA733CF06B144D33934920F2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
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

Hello Zhenzhong

On 4/17/24 11:24, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH v2 3/5] intel_iommu: Add a framework to do
>> compatibility check with host IOMMU cap/ecap
>>
>> On 4/17/24 06:21, Duan, Zhenzhong wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Cédric Le Goater <clg@redhat.com>
>>>> Subject: Re: [PATCH v2 3/5] intel_iommu: Add a framework to do
>>>> compatibility check with host IOMMU cap/ecap
>>>>
>>>> Hello,
>>>>
>>>> On 4/16/24 09:09, Duan, Zhenzhong wrote:
>>>>> Hi Cédric,
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Cédric Le Goater <clg@redhat.com>
>>>>>> Subject: Re: [PATCH v2 3/5] intel_iommu: Add a framework to do
>>>>>> compatibility check with host IOMMU cap/ecap
>>>>>>
>>>>>> On 4/8/24 10:44, Zhenzhong Duan wrote:
>>>>>>> From: Yi Liu <yi.l.liu@intel.com>
>>>>>>>
>>>>>>> If check fails, the host side device(either vfio or vdpa device) should
>> not
>>>>>>> be passed to guest.
>>>>>>>
>>>>>>> Implementation details for different backends will be in following
>>>> patches.
>>>>>>>
>>>>>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>>>>>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>>>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>>>> ---
>>>>>>>      hw/i386/intel_iommu.c | 35
>>>>>> +++++++++++++++++++++++++++++++++++
>>>>>>>      1 file changed, 35 insertions(+)
>>>>>>>
>>>>>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>>>>>> index 4f84e2e801..a49b587c73 100644
>>>>>>> --- a/hw/i386/intel_iommu.c
>>>>>>> +++ b/hw/i386/intel_iommu.c
>>>>>>> @@ -35,6 +35,7 @@
>>>>>>>      #include "sysemu/kvm.h"
>>>>>>>      #include "sysemu/dma.h"
>>>>>>>      #include "sysemu/sysemu.h"
>>>>>>> +#include "sysemu/iommufd.h"
>>>>>>>      #include "hw/i386/apic_internal.h"
>>>>>>>      #include "kvm/kvm_i386.h"
>>>>>>>      #include "migration/vmstate.h"
>>>>>>> @@ -3819,6 +3820,32 @@ VTDAddressSpace
>>>>>> *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>>>>>>>          return vtd_dev_as;
>>>>>>>      }
>>>>>>>
>>>>>>> +static int vtd_check_legacy_hdev(IntelIOMMUState *s,
>>>>>>> +                                 HostIOMMUDevice *hiod,
>>>>>>> +                                 Error **errp)
>>>>>>> +{
>>>>>>> +    return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int vtd_check_iommufd_hdev(IntelIOMMUState *s,
>>>>>>> +                                  HostIOMMUDevice *hiod,
>>>>>>> +                                  Error **errp)
>>>>>>> +{
>>>>>>> +    return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int vtd_check_hdev(IntelIOMMUState *s,
>>>> VTDHostIOMMUDevice
>>>>>> *vtd_hdev,
>>>>>>> +                          Error **errp)
>>>>>>> +{
>>>>>>> +    HostIOMMUDevice *hiod = vtd_hdev->dev;
>>>>>>> +
>>>>>>> +    if (object_dynamic_cast(OBJECT(hiod), TYPE_HIOD_IOMMUFD)) {
>>>>>>> +        return vtd_check_iommufd_hdev(s, hiod, errp);
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    return vtd_check_legacy_hdev(s, hiod, errp);
>>>>>>> +}
>>>>>>
>>>>>>
>>>>>> I think we should be using the .get_host_iommu_info() class handler
>>>>>> instead. Can we refactor the code slightly to avoid this check on
>>>>>> the type ?
>>>>>
>>>>> There is some difficulty ini avoiding this check, the behavior of
>>>> vtd_check_legacy_hdev
>>>>> and vtd_check_iommufd_hdev are different especially after nesting
>>>> support introduced.
>>>>> vtd_check_iommufd_hdev() has much wider check over cap/ecap bits
>>>> besides aw_bits.
>>>>
>>>> I think it is important to fully separate the vIOMMU model from the
>>>> host IOMMU backing device. 

This comment is true for the structures also.

>>>> Could we introduce a new HostIOMMUDeviceClass
>>>> handler .check_hdev() handler, which would call .get_host_iommu_info() ?

This means that HIOD_LEGACY_INFO and HIOD_IOMMUFD_INFO should be
a common structure 'HostIOMMUDeviceInfo' holding all attributes
for the different backends. Each .get_host_iommu_info() implementation
would translate the specific host iommu device data presentation
into the common 'HostIOMMUDeviceInfo', this is true for host_aw_bits.

'type' could be handled the same way, with a 'HostIOMMUDeviceInfo'
type attribute and host iommu device type definitions, or as you
suggested with a QOM interface. This is more complex however. In
this case, I would suggest to implement a .compatible() handler to
compare the host iommu device type with the vIOMMU type.

The resulting check_hdev routine would look something like :

static int vtd_check_hdev(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hdev,
                           Error **errp)
{
     HostIOMMUDevice *hiod = vtd_hdev->dev;
     HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
     HostIOMMUDevice info;
     int host_aw_bits, ret;

     ret = hiodc->get_host_iommu_info(hiod, &info, sizeof(info), errp);
     if (ret) {
         return ret;
     }

     ret = hiodc->is_compatible(hiod, VIOMMU_INTERFACE(s));
     if (ret) {
         return ret;
     }
     
     if (s->aw_bits > info.aw_bits) {
         error_setg(errp, "aw-bits %d > host aw-bits %d",
                    s->aw_bits, info.aw_bits);
         return -EINVAL;
     }
}

and the HostIOMMUDeviceClass::is_compatible() handler would call a
vIOMMUInterface::compatible() handler simply returning
IOMMU_HW_INFO_TYPE_INTEL_VTD. How does that sound ?

Including the type in HostIOMMUDeviceInfo is much simpler to start with.

Thanks,

C.





>>>
>>> Understood, besides the new .check_hdev() handler, I think we also need a
>> new interface
>>> class TYPE_IOMMU_CHECK_HDEV which has two handlers
>> check_[legacy|iommufd]_hdev(),
>>> and different vIOMMUs have different implementation.
>>
>> I am not sure to understand. Which class hierarchy would implement this
>> new "TYPE_IOMMU_CHECK_HDEV" interface ? vIOMMU or host iommu  ?
>>
>> Could you please explain with an update of your diagram :
>>
>>                          HostIOMMUDevice
>>                                 | .get_host_iommu_info()
>>                                 |
>>                                 |
>>              .------------------------------------.
>>              |                  |                 |
>>        HIODLegacyVFIO    [HIODLegacyVDPA]    HIODIOMMUFD
>>              | .vdev            | [.vdev]         | .iommufd
>>                                                   | .devid
>>                                                   | [.ioas_id]
>>                                                   | [.attach_hwpt()]
>>                                                   | [.detach_hwpt()]
>>                                                   |
>>                                      .----------------------.
>>                                      |                      |
>>                             HIODIOMMUFDVFIO         [HIODIOMMUFDVDPA]
>>                                      | .vdev                | [.vdev]
>>
> 
> Sure.
> 
>                           HostIOMMUDevice
>                                  | .get_host_iommu_info()
>                                  | .check_hdev()
>                                  |
>                     .------------------------------.
>                     |                              |
>                 HIODLegacy                    HIODIOMMUFD
>                     |                              | .iommufd
>               .--------------.                     | .devid
>               |              |                     | [.ioas_id]
>         HIODLegacyVFIO    [HIODLegacyVDPA]         | [.attach_hwpt()]
>               | .vdev            | [.vdev]         | [.detach_hwpt()]
>                                                    |
>                                       .----------------------.
>                                       |                      |
>                              HIODIOMMUFDVFIO         [HIODIOMMUFDVDPA]
>                                       | .vdev                | [.vdev]
> 
> 
> HostIOMMUDevice only declare .check_hdev(), but
> HIODLegacy and HIODIOMMUFD will implement .check_hdev().
> E.g., hiod_legacy_check_hdev() and hiod_iommufd_check_hdev().
> 
> int hiod_legacy_check_hdev(HostIOMMUDevice *hiod, IOMMUCheckHDev *viommu, Error **errp)
> {
>      IOMMUCheckHDevClass *chdc = IOMMU_CHECK_HDEV_GET_CLASS(viommu);
> 
>      return chdc->check_legacy_hdev(viommu, hiod, errp);
> }
> 
> int hiod_iommufd_check_hdev(HostIOMMUDevice *hiod, IOMMUCheckHDev *viommu, Error **errp)
> {
>      IOMMUCheckHDevClass *chdc = IOMMU_CHECK_HDEV_GET_CLASS(viommu);
> 
>      return chdc->check_iommufd_hdev(viommu, hiod, errp);
> }
> 
> And we implement interface TYPE_IOMMU_CHECK_HDEV in intel-iommu module.
> Certainly, we can also implement the same in other vIOMMUs we want.
> See below pseudo change:
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 68380d50ca..173c702b9f 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -5521,12 +5521,9 @@ static int vtd_check_hdev(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hdev,
>                             Error **errp)
>   {
>       HostIOMMUDevice *hiod = vtd_hdev->dev;
> +    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
> 
> -    if (object_dynamic_cast(OBJECT(hiod), TYPE_HIOD_IOMMUFD)) {
> -        return vtd_check_iommufd_hdev(s, vtd_hdev, errp);
> -    }
> -
> -    return vtd_check_legacy_hdev(s, hiod, errp);
> +    return hiodc->check_hdev(IOMMU_CHECK_HDEV(s), hiod, errp);
>   }
> 
>   static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
> @@ -6076,6 +6073,7 @@ static void vtd_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       X86IOMMUClass *x86_class = X86_IOMMU_DEVICE_CLASS(klass);
> +    IOMMUCheckHDevClass *chdc = IOMMU_CHECK_HDEV_CLASS(klass);
> 
>       dc->reset = vtd_reset;
>       dc->vmsd = &vtd_vmstate;
> @@ -6087,6 +6085,8 @@ static void vtd_class_init(ObjectClass *klass, void *data)
>       dc->user_creatable = true;
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>       dc->desc = "Intel IOMMU (VT-d) DMA Remapping device";
> +    chdc->check_legacy_hdev = vtd_check_legacy_hdev;
> +    chdc->check_iommufd_hdev = vtd_check_iommufd_hdev;
>   }
> 
>   static const TypeInfo vtd_info = {
> @@ -6094,6 +6094,10 @@ static const TypeInfo vtd_info = {
>       .parent        = TYPE_X86_IOMMU_DEVICE,
>       .instance_size = sizeof(IntelIOMMUState),
>       .class_init    = vtd_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_IOMMU_CHECK_HDEV },
> +        { }
> +    }
>   };
> 
> Thanks
> Zhenzhong



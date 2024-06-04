Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C252CC27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 08:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEPE5-0003XI-CP; Tue, 04 Jun 2024 04:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sEPE2-0003Ws-MF
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:08:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sEPE0-0000BG-V7
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717488536;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xbXjCdnktLNleGB+4NWSPe5ERS7iFdQoDcxZtY+BxSs=;
 b=DnDcNX6Zd+fmNPG0FREwfLBBUs95NjdAw8JWAVfYkDxHZ65mADCuLkr29F9Xjqqv7NxcMb
 WHqx9RGi0RnUcqR7VzlzGWiobU5nLDKRLjyz2gRA6wlUE/OcrMVxO+E3huJ04AQ0wo6Efk
 7tnMUTvKQ9BwCdwQdyQ2fqQwPospjy8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-4I6rDDRhNz2iwUp1zrnSKA-1; Tue, 04 Jun 2024 04:08:51 -0400
X-MC-Unique: 4I6rDDRhNz2iwUp1zrnSKA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4213441aa8cso24785395e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 01:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717488530; x=1718093330;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xbXjCdnktLNleGB+4NWSPe5ERS7iFdQoDcxZtY+BxSs=;
 b=xFFxQapy75cZCsXEH0pdaLtWqhvVOQozN9D9XUL0Ei5++npFv7iWSSlTyciVfgAkOm
 ++34Jf2GHb0ey+OdePIn4oe+ALaPNgQY/kChZBCpqGD/fWSGrnAVqXWhTm/rEdwetsNP
 AKY5OV1oH9cFQHC6/KKP09NNp8zCijrFW8O8TZAbQ+iJ4FRZk5lRCTnsWLXnNoSfL1yj
 09G+FXWy/W1ZXwnjeB2QMkknTYAHPULelOh2TUONCzHvigQeM5F2Rpw6HuV0Dn93a/Wy
 2alkfV1zveBnSD2+aQ/rc9DVo/ViC2l+0WiQ34Zhwe8H5QfZNxdHSICsSrxR08NXE4DK
 0HFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLYAi/4EU39zlwtdszZlMIgT+W9cG40jmzmM2seJsnqKr8Rje8EE+OD1xtHnXSt86WQtDCp31hcSNX0eCwrKKaUBIMSAk=
X-Gm-Message-State: AOJu0Yx4eZDP3A/o3cawqOH1W4JDuuZtGpESeLHryLj7yNHtPEQVgiAt
 EURWSeRx3snkY35/Q0h5TsJeX6raF7iHAc6oAoOXjQFh6ADjIA1c85NTvoAO48ypunh2LVgvMOK
 tE16E3gZfDSH4gpfPph1FP4NKES27hThHyHiD7s7CwGqyjwicB5Xn
X-Received: by 2002:a05:600c:3b0d:b0:41b:aa11:29b3 with SMTP id
 5b1f17b1804b1-4212e0b54c4mr84199505e9.35.1717488529925; 
 Tue, 04 Jun 2024 01:08:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT7kN6rCaR8vwNW15EGLsBo0Tf9g4HAcgRfmuTEY0OTS91YMSdCWfXkdHmsmCs69a15cLVyg==
X-Received: by 2002:a05:600c:3b0d:b0:41b:aa11:29b3 with SMTP id
 5b1f17b1804b1-4212e0b54c4mr84199285e9.35.1717488529566; 
 Tue, 04 Jun 2024 01:08:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4213c47f330sm68456335e9.47.2024.06.04.01.08.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 01:08:49 -0700 (PDT)
Message-ID: <270f9f43-fa47-4b42-92b0-0f717861dbc1@redhat.com>
Date: Tue, 4 Jun 2024 10:08:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/19] vfio/iommufd: Implement
 HostIOMMUDeviceClass::realize() handler
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-10-zhenzhong.duan@intel.com>
 <e20c3fce-5a5a-4efb-9383-9ed7c9c6ef32@redhat.com>
 <SJ0PR11MB67441F9E6629728ABBF7655092F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <999a8b13-61e9-4c5d-a02b-a608487f7114@redhat.com>
 <SJ0PR11MB67449D7B5FFAB6104F050D9092F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB67449D7B5FFAB6104F050D9092F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


Hi,
On 6/4/24 09:51, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: Re: [PATCH v6 09/19] vfio/iommufd: Implement
>> HostIOMMUDeviceClass::realize() handler
>>
>>
>>
>> On 6/4/24 04:58, Duan, Zhenzhong wrote:
>>>> -----Original Message-----
>>>> From: Eric Auger <eric.auger@redhat.com>
>>>> Subject: Re: [PATCH v6 09/19] vfio/iommufd: Implement
>>>> HostIOMMUDeviceClass::realize() handler
>>>>
>>>> Hi Zhenzhong,
>>>>
>>>> On 6/3/24 08:10, Zhenzhong Duan wrote:
>>>>> It calls iommufd_backend_get_device_info() to get host IOMMU
>>>>> related information and translate it into HostIOMMUDeviceCaps
>>>>> for query with .get_cap().
>>>>>
>>>>> Introduce macro VTD_MGAW_FROM_CAP to get MGAW which equals
>> to
>>>>> (aw_bits - 1).
>>>>>
>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>> ---
>>>>>  include/hw/i386/intel_iommu.h |  1 +
>>>>>  hw/vfio/iommufd.c             | 37
>>>> +++++++++++++++++++++++++++++++++++
>>>>>  2 files changed, 38 insertions(+)
>>>>>
>>>>> diff --git a/include/hw/i386/intel_iommu.h
>>>> b/include/hw/i386/intel_iommu.h
>>>>> index 7fa0a695c8..7d694b0813 100644
>>>>> --- a/include/hw/i386/intel_iommu.h
>>>>> +++ b/include/hw/i386/intel_iommu.h
>>>>> @@ -47,6 +47,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IntelIOMMUState,
>>>> INTEL_IOMMU_DEVICE)
>>>>>  #define VTD_HOST_AW_48BIT           48
>>>>>  #define VTD_HOST_ADDRESS_WIDTH      VTD_HOST_AW_39BIT
>>>>>  #define VTD_HAW_MASK(aw)            ((1ULL << (aw)) - 1)
>>>>> +#define VTD_MGAW_FROM_CAP(cap)      ((cap >> 16) & 0x3fULL)
>>>>>
>>>>>  #define DMAR_REPORT_F_INTR          (1)
>>>>>
>>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>>> index e4a507d55c..9d2e95e20e 100644
>>>>> --- a/hw/vfio/iommufd.c
>>>>> +++ b/hw/vfio/iommufd.c
>>>>> @@ -25,6 +25,7 @@
>>>>>  #include "qemu/cutils.h"
>>>>>  #include "qemu/chardev_open.h"
>>>>>  #include "pci.h"
>>>>> +#include "hw/i386/intel_iommu_internal.h"
>>>>>
>>>>>  static int iommufd_cdev_map(const VFIOContainerBase *bcontainer,
>>>> hwaddr iova,
>>>>>                              ram_addr_t size, void *vaddr, bool readonly)
>>>>> @@ -619,6 +620,41 @@ static void
>>>> vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
>>>>>      vioc->pci_hot_reset = iommufd_cdev_pci_hot_reset;
>>>>>  };
>>>>>
>>>>> +static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void
>>>> *opaque,
>>>>> +                                      Error **errp)
>>>>> +{
>>>>> +    VFIODevice *vdev = opaque;
>>>>> +    HostIOMMUDeviceCaps *caps = &hiod->caps;
>>>>> +    enum iommu_hw_info_type type;
>>>>> +    union {
>>>>> +        struct iommu_hw_info_vtd vtd;
>>>>> +    } data;
>>>>> +
>>>>> +    if (!iommufd_backend_get_device_info(vdev->iommufd, vdev-
>>> devid,
>>>>> +                                         &type, &data, sizeof(data), errp)) {
>>>>> +        return false;
>>>>> +    }
>>>>> +
>>>>> +    caps->type = type;
>>>>> +
>>>>> +    switch (type) {
>>>>> +    case IOMMU_HW_INFO_TYPE_INTEL_VTD:
>>>>> +        caps->aw_bits = VTD_MGAW_FROM_CAP(data.vtd.cap_reg) + 1;
>>>> Please can you remind me of why you can't reuse the iova_ranges
>> method.
>>>> isn't it generic enough?
>>> Yes, iova_ranges method is only for iova_ranges, we want to make
>>> HostIOMMUDevice.get_cap() a common interface.
>>>
>>> When we want to pass iova_ranges, we can add
>> HOST_IOMMU_DEVICE_CAP_IOVA_RANGES
>>> and HostIOMMUDevice.iova_ranges.
>> I rather meant that iova_ranges is part of VFIOContainerBase and you
>> could reuse the technics used in hiod_legacy_vfio_realize, relying on a
>> common helper instead of using
>>
>> VTD_MGAW_FROM_CAP(data.vtd.cap_reg). Doesn't it work?
> Get your point.
> Yes, It does work and should have same result.
> That means iommufd backend support two ways to get aw_bits.
>
> Only reason is I feel VTD_MGAW_FROM_CAP(data.vtd.cap_reg) is a bit simpler
> and there are other bits picked in nesting series, see:
>
>     case IOMMU_HW_INFO_TYPE_INTEL_VTD:
>         caps->aw_bits = VTD_MGAW_FROM_CAP(data.vtd.cap_reg) + 1;
>         caps->nesting = !!(data.vtd.ecap_reg & VTD_ECAP_NEST);
>         caps->fs1gp = !!(data.vtd.cap_reg & VTD_CAP_FS1GP);
>         caps->errata = data.vtd.flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17;
>
> I'm fine to use iova_ranges to calculate aw_bits for iommufd backend if you prefer that.
Yes I think I would prefer because this technics also work for other
iommus and not only VTD. It also can rely on common code between legacy
and iommufd. The nesting series can bring the rest later

Eric
>
> Thanks
> Zhenzhong



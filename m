Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EEECA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgBN-0002TT-UD; Thu, 28 Aug 2025 13:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urcFf-0004v9-4X
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 09:01:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urcFc-0000rU-Pg
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 09:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756386068;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2FSHSriAEkJkOMz1ICxZHuNRqzraCwOGW/4wAlLiDXk=;
 b=V35aXZzczLMgMceEzPuO/y8kMTZNxv14O+iUkrDRV8oDTnmJslBZFDg7VJn+sA611Wa/d8
 vsNGr7w2oendMphBTVQU9Ktpbf6XuWR7t9GNuZe6M3jTeOwW8f4XuKiMCeie9jnCR3euIG
 J5BoOyN0gtxECtfO5ZK8FY+PPp/HsGk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-k8mvxsW9MuqI0td4hkf2vw-1; Thu, 28 Aug 2025 09:01:07 -0400
X-MC-Unique: k8mvxsW9MuqI0td4hkf2vw-1
X-Mimecast-MFC-AGG-ID: k8mvxsW9MuqI0td4hkf2vw_1756386067
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-70d7c7e972eso22364016d6.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 06:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756386066; x=1756990866;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2FSHSriAEkJkOMz1ICxZHuNRqzraCwOGW/4wAlLiDXk=;
 b=T131kD8MgN9deJ1rgFPj+t5iHYPDcx9lFqmrsgGbUtnbMYkh5xAYDZj8BBBY+NwqkG
 7f7igl0QY3QoVqhGJpofqku30P4vz9J7BZo5BZyWcluKfjmBEBOhtxJvUPKk1ySILCpK
 hiZUN2NBOtPZ3pjcfyNj+eWuDoREARufikEKrc9pXoeGn+gbLOe+Gbt8odL9jZxhkBDj
 7sGidIWmXA3KRYwWloJIhlQ0NyVP4x23kM6lYHRJygJ7lKr6JZ8JvlodJaaAt+YyEQtL
 4UX1AAySL1Retz5x09D3c/yfueUZCKthRg7UVziAqBy+xPhoB3EfFaENzq89DZtdNEMB
 /6hQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpTHwV/Q+2yFGDlPUV40RM2JjubV+ST9mW10D6z34JjzXwGHxBWQNMC6S4Ale6P65whphy6HOtdEcu@nongnu.org
X-Gm-Message-State: AOJu0YwieGAMWi9TVsIdeZdf5vPWA/8A9mE5PRpWXRVBc49qFO1RNeMH
 kkenq/ApJXWw+EgRa0tpgCBcddNqGP4StFKWjQ0Le4CLY716FtMCOn84VfiC6X+swLbdNEV/EAo
 xJPF1KNpwCFTdmB02botlId77KW6PyMc87vQY5siGcrF7xjWd9bl0leZ5
X-Gm-Gg: ASbGncu6hUdtEi57iz1fI1Vus0b8wrCCN3xKwv9kNqcXB6oRXj/3Xf2KuGDZVGeOEjO
 Zwym8fqDlW6ltYyZUjmE6tBXHC5E1MNC6XIdx3XF06OtWg4JGJErxmFbUKnD+C1Wjr7yxL7dmJk
 Hgi5mglH1E1MOr+isnE207KhXYjlqi+GJPzT07bZjfFnk5U06sVVuGJLiUXutTaOAjmi+aLBZyr
 g9qvmFovWW9LMQmK+o7E36Y52lBYY4u/0VBzSG9Ibz4PK7jMMlGOzF/7d6Y9lJXY2pzR+iQ0A/8
 haHp4yYzUFqtQNRZXVgJX0Kk5lau9IlWffOv7ORI2xdBzd3huDjC04gcaDcxYZ48QArQabPS27M
 Yhjus8o/h15s=
X-Received: by 2002:a05:6214:5191:b0:70d:6de2:50d5 with SMTP id
 6a1803df08f44-70d972153bamr264903596d6.66.1756386066506; 
 Thu, 28 Aug 2025 06:01:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTX7iu2SSYp7lyAL22K2f7XpgBmpyccaeINyh6fOmPk9PG3qCxwefbyL/0PlXXSH0YsbxarA==
X-Received: by 2002:a05:6214:5191:b0:70d:6de2:50d5 with SMTP id
 6a1803df08f44-70d972153bamr264896416d6.66.1756386061198; 
 Thu, 28 Aug 2025 06:01:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70da728a11asm105183076d6.46.2025.08.28.06.00.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 06:00:59 -0700 (PDT)
Message-ID: <ff8022d1-6363-43c7-b095-cf8f0a692a16@redhat.com>
Date: Thu, 28 Aug 2025 15:00:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/21] vfio/iommufd: Force creating nested parent domain
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-6-zhenzhong.duan@intel.com>
 <93a7a387-ae57-488e-b341-2beea67bf78e@redhat.com>
 <IA3PR11MB9136E928181D1B95F5AD39AB923BA@IA3PR11MB9136.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <IA3PR11MB9136E928181D1B95F5AD39AB923BA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 8/28/25 11:53 AM, Duan, Zhenzhong wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: Re: [PATCH v5 05/21] vfio/iommufd: Force creating nested parent
>> domain
>>
>> Hi Zhenzhong,
>>
>> On 8/22/25 8:40 AM, Zhenzhong Duan wrote:
>>> Call pci_device_get_viommu_cap() to get if vIOMMU supports
>> VIOMMU_CAP_HW_NESTED,
>>> if yes, create nested parent domain which could be reused by vIOMMU to
>> create
>>> nested domain.
>>>
>>> Introduce helper vfio_device_viommu_get_nested to facilitate this
>>> implementation.
>>>
>>> It is safe because even if VIOMMU_CAP_HW_NESTED is returned, s->flts is
>>> forbidden and VFIO device fails in set_iommu_device() call, until we support
>>> passthrough device with x-flts=on.
>>>
>>> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
>>> Suggested-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>  include/hw/vfio/vfio-device.h |  2 ++
>>>  hw/vfio/device.c              | 12 ++++++++++++
>>>  hw/vfio/iommufd.c             |  8 ++++++++
>>>  3 files changed, 22 insertions(+)
>>>
>>> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
>>> index 6e4d5ccdac..ecd82c16c7 100644
>>> --- a/include/hw/vfio/vfio-device.h
>>> +++ b/include/hw/vfio/vfio-device.h
>>> @@ -257,6 +257,8 @@ void vfio_device_prepare(VFIODevice *vbasedev,
>> VFIOContainerBase *bcontainer,
>>>  void vfio_device_unprepare(VFIODevice *vbasedev);
>>>
>>> +bool vfio_device_viommu_get_nested(VFIODevice *vbasedev);
>> I would suggest vfio_device_viommu_has_feature_hw_nested or something
>> alike
>> get usually means tou take a ref count associated with a put
> Sure.
>
>>> +
>>>  int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
>>>                                  struct vfio_region_info **info);
>>>  int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t
>> type,
>>> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
>>> index 08f12ac31f..3eeb71bd51 100644
>>> --- a/hw/vfio/device.c
>>> +++ b/hw/vfio/device.c
>>> @@ -23,6 +23,7 @@
>>>
>>>  #include "hw/vfio/vfio-device.h"
>>>  #include "hw/vfio/pci.h"
>>> +#include "hw/iommu.h"
>>>  #include "hw/hw.h"
>>>  #include "trace.h"
>>>  #include "qapi/error.h"
>>> @@ -504,6 +505,17 @@ void vfio_device_unprepare(VFIODevice
>> *vbasedev)
>>>      vbasedev->bcontainer = NULL;
>>>  }
>>>
>>> +bool vfio_device_viommu_get_nested(VFIODevice *vbasedev)
>>> +{
>>> +    VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
>>> +
>>> +    if (vdev) {
>>> +        return !!(pci_device_get_viommu_cap(&vdev->pdev) &
>>> +                  VIOMMU_CAP_HW_NESTED);
>>> +    }
>>> +    return false;
>>> +}
>>> +
>>>  /*
>>>   * Traditional ioctl() based io
>>>   */
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index 8c27222f75..e503c232e1 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -379,6 +379,14 @@ static bool
>> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>          flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>>      }
>>>
>>> +    /*
>>> +     * If vIOMMU supports stage-1 translation, force to create nested
>> parent
>> I would rather not use another terminology here. You previously used
>> hw_nested, I think that's better. Also bear in mind that smmu supports
>> S1, S2 and S1+S2 in emulated code.
> What about 'nesting parent' to match kernel side terminology, per Nicolin's suggestion:
>
> In kernel kdoc/uAPI, we use:
>  - "nesting parent" for stage-2 object
>  - "nested hwpt", "nested domain" for stage-1 object
I still think that since you queried the HW_NESTED cap it makes sense to
continue using it. This can come along with the kernel terminology though.

Eric
>
> Thanks
> Zhenzhong
>> Thanks
>>
>> Eric
>>> +     * domain which could be reused by vIOMMU to create nested
>> domain.
>>> +     */
>>> +    if (vfio_device_viommu_get_nested(vbasedev)) {
>>> +        flags |= IOMMU_HWPT_ALLOC_NEST_PARENT;
>>> +    }
>>> +
>>>      if (cpr_is_incoming()) {
>>>          hwpt_id = vbasedev->cpr.hwpt_id;
>>>          goto skip_alloc;



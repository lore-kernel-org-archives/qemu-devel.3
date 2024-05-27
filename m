Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1293DC25B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 13:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBaCQ-0007qP-O7; Mon, 27 May 2024 09:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sBaC7-0007jw-NB
 for qemu-devel@nongnu.org; Mon, 27 May 2024 09:15:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sBaC5-00040Q-2T
 for qemu-devel@nongnu.org; Mon, 27 May 2024 09:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716815714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8wHzN3iFlyLxHgryxnWH2xnDGyQijh2ajFAN2cd0d9Y=;
 b=T/810hPalu8wABD3ftQ7b/G92hi5TEzM+XRt8eXGy0ZgxyXTMF2ndfQsv6ULb3Yi380coE
 vtgL4+j5f1+i9JThbraLEx8NLntNUGiWkLDEt9zsH8ZNLYfknpozZCGawGBi+3geSXZu7g
 7dMyi4+TiSpDmKXvvphaoWzM/PLP2jw=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-WRj26cLTMUG4Ml0VIqFiJg-1; Mon, 27 May 2024 09:15:12 -0400
X-MC-Unique: WRj26cLTMUG4Ml0VIqFiJg-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-7eaccb5a928so119893639f.3
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 06:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716815711; x=1717420511;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8wHzN3iFlyLxHgryxnWH2xnDGyQijh2ajFAN2cd0d9Y=;
 b=IaFTOJgzoXRcWS0HTGPutCfBfb7HpogzJ0ZWrAXyOx9PhnbvFAEuICMZitwY+lP+w/
 Pr3aya2nQxoyRHGGCTtfZgf9HMDIV7LnKE2nYeAJgxCFaSx7QzpYdt6I51Xd2Ra1UxGQ
 MCV1+EnF4zBsYD1lfkR75ZUUv9dPNNwWqWjbk7UFGLIkIPrTe8LFsbh2N940i1WIJI55
 44YarDl4L+aeNvTF7a1dK/e/G8ZWVP/WEfqYkDrmzWvKgVg4xyaeoX8kzQGv7cr7kacl
 LP+97vQ+YK5lQIVrisur6F70oktXOpb/2AhIQjcR5U+fS1iRUNgIaxOeB9oPLno3QwC8
 JfEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNYS60gNCm1y/xVK4iLaWqC2r7ISU9o0wClCr0bbCBS+G3tgG6AWefDO1wHPrtmGGF6kVYxY+At9cgHucG+Pklzn3/lw0=
X-Gm-Message-State: AOJu0YykWgj9JZXJVKhQZL/tLkRHcDBC9Q8HyPT/epkLm87cJXgi31oB
 GZXJkSpRtW5MbjQbpKSBTOrstJEiQ1xkIj7DX048BDjO+pss4RMGypbyOK5H3VJ7BaTzRvpwTTO
 w40QxcHJRG1apNE7A0w2Xubtn1V0MwBj885Qtm3tY/xiBUiHjzIgO
X-Received: by 2002:a05:6e02:1d83:b0:36c:4d7d:26bf with SMTP id
 e9e14a558f8ab-3737b26aea8mr123154805ab.1.1716815711124; 
 Mon, 27 May 2024 06:15:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb5jeJogF5QarXuY/iKcP2DFVU3cdoOu+GW7H9gIR+oEmcSfaZiO1CN4oqTELITnB8VkjuFg==
X-Received: by 2002:a05:6e02:1d83:b0:36c:4d7d:26bf with SMTP id
 e9e14a558f8ab-3737b26aea8mr123154205ab.1.1716815710615; 
 Mon, 27 May 2024 06:15:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:151b:2482:8f7e:1f56?
 ([2a01:e0a:280:24f0:151b:2482:8f7e:1f56])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abca6386sm297687085a.22.2024.05.27.06.15.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 06:15:10 -0700 (PDT)
Message-ID: <e4ce6f45-6232-4f62-a2d4-72a9e1e8c15c@redhat.com>
Date: Mon, 27 May 2024 15:15:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/19] backends: Introduce HostIOMMUDevice abstract
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240508090354.1815561-1-zhenzhong.duan@intel.com>
 <20240508090354.1815561-2-zhenzhong.duan@intel.com>
 <0134a4f2-5a88-42d3-bcb7-f309a0dd62e5@redhat.com>
 <SJ0PR11MB6744EEBF525D7057D396A09292E22@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB6744EEBF525D7057D396A09292E22@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/13/24 12:28, Duan, Zhenzhong wrote:
> Hi Cédric,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH v5 01/19] backends: Introduce HostIOMMUDevice
>> abstract
>>
>> Hello Zhenzhong,
>>
>> On 5/8/24 11:03, Zhenzhong Duan wrote:
>>> Introduce HostIOMMUDevice as an abstraction of host IOMMU device.
>>>
>>> Introduce .realize() to initialize HostIOMMUDevice further after
>>> instance init.
>>>
>>> Introduce a macro CONFIG_HOST_IOMMU_DEVICE to define the usage
>>> for VFIO, and VDPA in the future.
>>
>> This looks like a way to work around some other problem, like
>> avoiding exposing Linux definitions on windows build.
> 
> Yes, I have used this MACRO in patch19 to fix build failure on windows.
> Also need change HostIOMMUDeviceCaps::type to be uint32_t type.

Routine host_iommu_device_get_cap() could be open coded in vtd_check_hdev()
to avoid CONFIG_HOST_IOMMU_DEVICE.

Thanks,

C.



> 
>>
>> Thanks,
>>
>> C.
>>
>>
>>
>>
>>>
>>> Suggested-by: Cédric Le Goater <clg@redhat.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    MAINTAINERS                        |  2 ++
>>>    include/sysemu/host_iommu_device.h | 51
>> ++++++++++++++++++++++++++++++
>>>    backends/host_iommu_device.c       | 30 ++++++++++++++++++
>>>    backends/Kconfig                   |  5 +++
>>>    backends/meson.build               |  1 +
>>>    5 files changed, 89 insertions(+)
>>>    create mode 100644 include/sysemu/host_iommu_device.h
>>>    create mode 100644 backends/host_iommu_device.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 84391777db..5dab60bd04 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2191,6 +2191,8 @@ M: Zhenzhong Duan
>> <zhenzhong.duan@intel.com>
>>>    S: Supported
>>>    F: backends/iommufd.c
>>>    F: include/sysemu/iommufd.h
>>> +F: backends/host_iommu_device.c
>>> +F: include/sysemu/host_iommu_device.h
>>>    F: include/qemu/chardev_open.h
>>>    F: util/chardev_open.c
>>>    F: docs/devel/vfio-iommufd.rst
>>> diff --git a/include/sysemu/host_iommu_device.h
>> b/include/sysemu/host_iommu_device.h
>>> new file mode 100644
>>> index 0000000000..2b58a94d62
>>> --- /dev/null
>>> +++ b/include/sysemu/host_iommu_device.h
>>> @@ -0,0 +1,51 @@
>>> +/*
>>> + * Host IOMMU device abstract declaration
>>> + *
>>> + * Copyright (C) 2024 Intel Corporation.
>>> + *
>>> + * Authors: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> + *
>>> + * This work is licensed under the terms of the GNU GPL, version 2.  See
>>> + * the COPYING file in the top-level directory.
>>> + */
>>> +
>>> +#ifndef HOST_IOMMU_DEVICE_H
>>> +#define HOST_IOMMU_DEVICE_H
>>> +
>>> +#include "qom/object.h"
>>> +#include "qapi/error.h"
>>> +
>>> +#define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
>>> +OBJECT_DECLARE_TYPE(HostIOMMUDevice, HostIOMMUDeviceClass,
>> HOST_IOMMU_DEVICE)
>>> +
>>> +struct HostIOMMUDevice {
>>> +    Object parent_obj;
>>> +};
>>> +
>>> +/**
>>> + * struct HostIOMMUDeviceClass - The base class for all host IOMMU
>> devices.
>>> + *
>>> + * Different type of host devices (e.g., VFIO or VDPA device) or devices
>>> + * with different backend (e.g., VFIO legacy container or IOMMUFD
>> backend)
>>> + * can have different sub-classes.
>>> + */
>>> +struct HostIOMMUDeviceClass {
>>> +    ObjectClass parent_class;
>>> +
>>> +    /**
>>> +     * @realize: initialize host IOMMU device instance further.
>>> +     *
>>> +     * Mandatory callback.
>>> +     *
>>> +     * @hiod: pointer to a host IOMMU device instance.
>>> +     *
>>> +     * @opaque: pointer to agent device of this host IOMMU device,
>>> +     *          i.e., for VFIO, pointer to VFIODevice
>>> +     *
>>> +     * @errp: pass an Error out when realize fails.
>>> +     *
>>> +     * Returns: true on success, false on failure.
>>> +     */
>>> +    bool (*realize)(HostIOMMUDevice *hiod, void *opaque, Error **errp);
>>> +};
>>> +#endif
>>> diff --git a/backends/host_iommu_device.c
>> b/backends/host_iommu_device.c
>>> new file mode 100644
>>> index 0000000000..41f2fdce20
>>> --- /dev/null
>>> +++ b/backends/host_iommu_device.c
>>> @@ -0,0 +1,30 @@
>>> +/*
>>> + * Host IOMMU device abstract
>>> + *
>>> + * Copyright (C) 2024 Intel Corporation.
>>> + *
>>> + * Authors: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> + *
>>> + * This work is licensed under the terms of the GNU GPL, version 2.  See
>>> + * the COPYING file in the top-level directory.
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "sysemu/host_iommu_device.h"
>>> +
>>> +OBJECT_DEFINE_ABSTRACT_TYPE(HostIOMMUDevice,
>>> +                            host_iommu_device,
>>> +                            HOST_IOMMU_DEVICE,
>>> +                            OBJECT)
>>> +
>>> +static void host_iommu_device_class_init(ObjectClass *oc, void *data)
>>> +{
>>> +}
>>> +
>>> +static void host_iommu_device_init(Object *obj)
>>> +{
>>> +}
>>> +
>>> +static void host_iommu_device_finalize(Object *obj)
>>> +{
>>> +}
>>> diff --git a/backends/Kconfig b/backends/Kconfig
>>> index 2cb23f62fa..34ab29e994 100644
>>> --- a/backends/Kconfig
>>> +++ b/backends/Kconfig
>>> @@ -3,3 +3,8 @@ source tpm/Kconfig
>>>    config IOMMUFD
>>>        bool
>>>        depends on VFIO
>>> +
>>> +config HOST_IOMMU_DEVICE
>>> +    bool
>>> +    default y
>>> +    depends on VFIO
>>> diff --git a/backends/meson.build b/backends/meson.build
>>> index 8b2b111497..2e975d641e 100644
>>> --- a/backends/meson.build
>>> +++ b/backends/meson.build
>>> @@ -25,6 +25,7 @@ if have_vhost_user
>>>    endif
>>>    system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-
>> vhost.c'))
>>>    system_ss.add(when: 'CONFIG_IOMMUFD', if_true: files('iommufd.c'))
>>> +system_ss.add(when: 'CONFIG_HOST_IOMMU_DEVICE', if_true:
>> files('host_iommu_device.c'))
>>
>> Euh. Why is that ?
> 
> Tried to reduce qemu binary size a bit.
> When CONFIG_VFIO=n such as on windows,  CONFIG_HOST_IOMMU_DEVICE=n.
> There is no user of host_iommu_device.c, so no need to build it.
> But this way need to add '#ifdef CONFIG_HOST_IOMMU_DEVICE' in vtd_check_hdev() in intel_iommu.c.
> 
> The other way is to drop this build configuration, then there is no need to add '#ifdef CONFIG_HOST_IOMMU_DEVICE' in vtd_check_hdev() in intel_iommu.c, because
> host_iommu_device.c is always built.
> 
> This series works in 1st way, I can change to 2nd way if you prefer.
> 
> Thanks
> Zhenzhong
> 
> 
> 



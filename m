Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAD9D3E79C
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 07:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTanr-0003zi-NB; Thu, 11 Dec 2025 02:09:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vTanp-0003zJ-Pa
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 02:09:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vTann-0004A7-Fh
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 02:09:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765436966;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mD7sFzTKa84RMWUjMHKxfbF2QwIiDvLUQIXs0StRm44=;
 b=Q6lfk43Kq5dZ7y+pjnVrphrg/LJP5fLQmk612jiPrybJLUva8+ZoXz2lyDZa4wR9adLXQZ
 UGM2IddLBnc+aZgdNWF8uDf2QDJ00/Db86QobBS08HvskksDlNhIc2vqdXtxmJclV+uT7V
 sqZkKUvqyWXoZLkaMcJc13kRJoh/yNk=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-6ob7HYAJM7aRbtm612NRTA-1; Thu, 11 Dec 2025 02:09:15 -0500
X-MC-Unique: 6ob7HYAJM7aRbtm612NRTA-1
X-Mimecast-MFC-AGG-ID: 6ob7HYAJM7aRbtm612NRTA_1765436954
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c0c7e0a8ac1so744698a12.0
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 23:09:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765436954; x=1766041754;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mD7sFzTKa84RMWUjMHKxfbF2QwIiDvLUQIXs0StRm44=;
 b=F+I05ET98Zci7NvHi4NiHBfJk7jBu5vQVtDX0z9sKBHGppK6PgTfSxwqF/1cgcQjQo
 +Nc5hrMLoNkvMofpezd8+LCP/2ZdQevEGJMiOVL9m+qf1MJl8Vi4pJ42NN1C4AC6z2sb
 DSS483ViMMCVIPulWlEm7WDv45yq4sqYuGOK3+ExaSQ9SdoO/UPQadwikCq3gWbJciSM
 xqagd27mzfLbVIW/D+wMhkLMv5+neOzOYhcCK/3IJ9ZvkXN3DkWUwzTxWYNyzxnCydZF
 BkHbfhZVPqVK2Kn8R9QGJtyg0UQIgxPOtfyjkl494LMxTmNTseMHK3IvxSkn1XrzUQxT
 AyCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2EfPJrxP0KFx4cE5TroTfcLPXAurstDmX1mySVeeDTBDp+duncdxxb0LDTg4EW/N1toTIHuYs/Ctb@nongnu.org
X-Gm-Message-State: AOJu0YwOe125rrmWWp4psRaJaEzZPpySWFDBStvbROAls9+rp/Dgs0xz
 g6fvrai8DFOU42FoxU6X6xn6iP8vILJ5Z3TromGELmz36NzpQ1utBH0KmZgfhgW6XaHpXxanuOE
 iG7CPgI6wmHPEhMX5dUeLOiB02E4rXH3TJhoeLm5oYPza3zvRSl932MSw
X-Gm-Gg: AY/fxX4d2MU2wZBiVze4PpUKcxufLMW89mdXuIJ8uW0Jqn/8qC841v41vypIP7A9795
 ge2w/lFpwJeeLvBH7AhHogLphvEUVZ0LNDkw3z5dUqBvBelrzczRtkZt/9LTQWOK9lyaoe+h/ap
 rGKfjueCUHtyHHzshYMoeajhHKOIe2Z24i7+ujBDSSx2dzxEDnAnnl4oVmMBUSA4TTUUDIjsnob
 auDQcXkNs4o4YjYdway80wHlPMSigPKb6mduCf/zqjhnxqjSsUVPJzHDCZAw+/WEIDPG4i8ARRW
 Z3QaM1U1Zc6FQCMgHoQW/exLgGFfJHDr0PDg+mU9iX7DdZolOC5GNfvQb/W1TEUKz6EqTaNH/MG
 wkIIb6eGiNFiJdAKrLHJ0+YpQKw+HBVbIIx8ZKE7WlCi4cqqvKahaNzDejg==
X-Received: by 2002:a05:7022:4299:b0:119:e569:f626 with SMTP id
 a92af1059eb24-11f29689922mr4346393c88.31.1765436953783; 
 Wed, 10 Dec 2025 23:09:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGHzLgUWO5a9VKBa+pgGScbW5TQAySf4wqW8i3CSCV1+btCDE+Zlxe8hoqgahimAO3I5hZ2g==
X-Received: by 2002:a05:7022:4299:b0:119:e569:f626 with SMTP id
 a92af1059eb24-11f29689922mr4346367c88.31.1765436953261; 
 Wed, 10 Dec 2025 23:09:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11f2e304766sm5174828c88.13.2025.12.10.23.09.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 23:09:12 -0800 (PST)
Message-ID: <ef46c714-28f6-413c-9270-6119a92a2849@redhat.com>
Date: Thu, 11 Dec 2025 08:09:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/23] intel_iommu_accel: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
 <20251117093729.1121324-10-zhenzhong.duan@intel.com>
 <52074045-fe32-4fbf-b8a3-5037438649f7@redhat.com>
 <IA3PR11MB9136A94E3A6B29A2F35D57EA92A1A@IA3PR11MB9136.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <IA3PR11MB9136A94E3A6B29A2F35D57EA92A1A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 12/11/25 7:49 AM, Duan, Zhenzhong wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: Re: [PATCH v8 09/23] intel_iommu_accel: Check for compatibility
>> with IOMMUFD backed device when x-flts=on
>>
>> Hi Zhenzhong,
>> On 11/17/25 10:37 AM, Zhenzhong Duan wrote:
>>> When vIOMMU is configured x-flts=on in scalable mode, first stage page
>> table
>>> is passed to host to construct nested page table for passthrough devices.
>>>
>>> We need to check compatibility of some critical IOMMU capabilities
>> between
>>> vIOMMU and host IOMMU to ensure guest first stage page table could be
>> used by
>>> host.
>>>
>>> For instance, vIOMMU supports first stage 1GB large page mapping, but
>> host does
>>> not, then this IOMMUFD backed device should fail.
>>>
>>> Even of the checks pass, for now we willingly reject the association because
>>> all the bits are not there yet, it will be relaxed in the end of this series.
>>>
>>> Note vIOMMU has exposed IOMMU_HWPT_ALLOC_NEST_PARENT flag to
>> force VFIO core to
>>> create nesting parent HWPT, if host doesn't support nested translation, the
>>> creation will fail. So no need to check nested capability here.
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>  MAINTAINERS                 |  1 +
>>>  hw/i386/intel_iommu_accel.h | 28 +++++++++++++++++++++++++
>>>  hw/i386/intel_iommu.c       |  5 ++---
>>>  hw/i386/intel_iommu_accel.c | 42
>> +++++++++++++++++++++++++++++++++++++
>>>  hw/i386/Kconfig             |  5 +++++
>>>  hw/i386/meson.build         |  1 +
>>>  6 files changed, 79 insertions(+), 3 deletions(-)
>>>  create mode 100644 hw/i386/intel_iommu_accel.h
>>>  create mode 100644 hw/i386/intel_iommu_accel.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index f4a30c126b..bc1d2b6261 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -3929,6 +3929,7 @@ R: Clément Mathieu--Drif
>> <clement.mathieu--drif@eviden.com>
>>>  S: Supported
>>>  F: hw/i386/intel_iommu.c
>>>  F: hw/i386/intel_iommu_internal.h
>>> +F: hw/i386/intel_iommu_accel.*
>>>  F: include/hw/i386/intel_iommu.h
>>>  F: tests/functional/x86_64/test_intel_iommu.py
>>>  F: tests/qtest/intel-iommu-test.c
>>> diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
>>> new file mode 100644
>>> index 0000000000..c5274e342c
>>> --- /dev/null
>>> +++ b/hw/i386/intel_iommu_accel.h
>>> @@ -0,0 +1,28 @@
>>> +/*
>>> + * Intel IOMMU acceleration with nested translation
>>> + *
>>> + * Copyright (C) 2025 Intel Corporation.
>>> + *
>>> + * Authors: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#ifndef HW_I386_INTEL_IOMMU_ACCEL_H
>>> +#define HW_I386_INTEL_IOMMU_ACCEL_H
>>> +#include CONFIG_DEVICES
> Here to address Cédric's suggestion.
>
>>> +
>>> +#ifdef CONFIG_VTD_ACCEL
>>> +bool vtd_check_hiod_accel(IntelIOMMUState *s, HostIOMMUDevice
>> *hiod,
>>> +                          Error **errp);
>>> +#else
>>> +static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
>>> +                                        HostIOMMUDevice
>> *hiod,
>>> +                                        Error **errp)
>>> +{
>>> +    error_setg(errp,
>>> +               "host IOMMU is incompatible with guest first stage
>> translation");
>> I would rather change the error msg to
>>
>> host IOMMU cannot be checked!
>> + append a hint through error_append_hint,
>> CONFIG_VTD_ACCEL is not enabled or smthg alike
> Will do.
>
>>> +    return false;
>>> +}
>>> +#endif
>>> +#endif
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index 3095d78321..d3c8a75878 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -26,6 +26,7 @@
>>>  #include "hw/sysbus.h"
>>>  #include "hw/iommu.h"
>>>  #include "intel_iommu_internal.h"
>>> +#include "intel_iommu_accel.h"
>>>  #include "hw/pci/pci.h"
>>>  #include "hw/pci/pci_bus.h"
>>>  #include "hw/qdev-properties.h"
>>> @@ -4596,9 +4597,7 @@ static bool vtd_check_hiod(IntelIOMMUState *s,
>> HostIOMMUDevice *hiod,
>>>          return true;
>>>      }
>>>
>>> -    error_setg(errp,
>>> -               "host device is uncompatible with first stage
>> translation");
>>> -    return false;
>>> +    return vtd_check_hiod_accel(s, hiod, errp);
>>>  }
>>>
>>>  static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int
>> devfn,
>>> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
>>> new file mode 100644
>>> index 0000000000..6846c6ec4d
>>> --- /dev/null
>>> +++ b/hw/i386/intel_iommu_accel.c
>>> @@ -0,0 +1,42 @@
>>> +/*
>>> + * Intel IOMMU acceleration with nested translation
>>> + *
>>> + * Copyright (C) 2025 Intel Corporation.
>>> + *
>>> + * Authors: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "system/iommufd.h"
>>> +#include "intel_iommu_internal.h"
>>> +#include "intel_iommu_accel.h"
>>> +
>>> +bool vtd_check_hiod_accel(IntelIOMMUState *s, HostIOMMUDevice
>> *hiod,
>>> +                          Error **errp)
>>> +{
>>> +    struct HostIOMMUDeviceCaps *caps = &hiod->caps;
>>> +    struct iommu_hw_info_vtd *vtd = &caps->vendor_caps.vtd;
>>> +
>>> +    if (!object_dynamic_cast(OBJECT(hiod),
>> TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
>>> +        error_setg(errp, "Need IOMMUFD backend when x-flts=on");
>>> +        return false;
>>> +    }
>>> +
>>> +    if (caps->type != IOMMU_HW_INFO_TYPE_INTEL_VTD) {
>>> +        error_setg(errp, "Incompatible host platform IOMMU type %d",
>>> +                   caps->type);
>>> +        return false;
>>> +    }
>>> +
>>> +    if (s->fs1gp && !(vtd->cap_reg & VTD_CAP_FS1GP)) {
>>> +        error_setg(errp,
>>> +                   "First stage 1GB large page is unsupported by host
>> IOMMU");
>>> +        return false;
>>> +    }
>>> +
>>> +    error_setg(errp,
>>> +               "host IOMMU is incompatible with guest first stage
>> translation");
>>> +    return false;
>>> +}
>>> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
>>> index 6a0ab54bea..12473acaa7 100644
>>> --- a/hw/i386/Kconfig
>>> +++ b/hw/i386/Kconfig
>>> @@ -150,8 +150,13 @@ config X86_IOMMU
>>>
>>>  config VTD
>>>      bool
>>> +    imply VTD_ACCEL
>>>      select X86_IOMMU
>>>
>>> +config VTD_ACCEL
>>> +    bool
>>> +    depends on VTD && IOMMUFD
>>> +
>>>  config AMD_IOMMU
>>>      bool
>>>      select X86_IOMMU
>>> diff --git a/hw/i386/meson.build b/hw/i386/meson.build
>>> index 436b3ce52d..63ae57baa5 100644
>>> --- a/hw/i386/meson.build
>>> +++ b/hw/i386/meson.build
>>> @@ -21,6 +21,7 @@ i386_ss.add(when: 'CONFIG_Q35', if_true:
>> files('pc_q35.c'))
>>>  i386_ss.add(when: 'CONFIG_VMMOUSE', if_true: files('vmmouse.c'))
>>>  i386_ss.add(when: 'CONFIG_VMPORT', if_true: files('vmport.c'))
>>>  i386_ss.add(when: 'CONFIG_VTD', if_true: files('intel_iommu.c'))
>>> +i386_ss.add(when: 'CONFIG_VTD_ACCEL', if_true:
>> files('intel_iommu_accel.c'))
>>>  i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx-epc.c','sgx.c'),
>>>                                  if_false: files('sgx-stub.c'))
>>>
>> wrt comments made by Cédric in
>> https://lore.kernel.org/all/IA3PR11MB9136B13C0C48EF293D3B599D92FAA@
>> IA3PR11MB9136.namprd11.prod.outlook.com/
>> I see you kept the original approach. I have no strong opinion on that.
>> I let Cédric's comment if he strongly disagrees.
> Guess you mean adding '#include CONFIG_DEVICES'?
> I added it in hw/i386/intel_iommu_accel.h, see above. There is reference to
> CONFIG_VTD_ACCEL in intel_iommu_accel.h, I thought it's better to add it
> there instead of intel_iommu_accel.c

No I rather meant Cédric's comment on extending HostIOMMUDeviceClass
instead of using iommufd directly Eric


>
> Thanks
> Zhenzhong
>
>> With my comment taken into account feel free to grab my
>>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>
>> Thanks
>>
>> Eric



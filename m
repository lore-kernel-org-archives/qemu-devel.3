Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0385DC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 16:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsOi8-0005pk-6G; Wed, 12 Mar 2025 12:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tsOi5-0005lK-Ax
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 12:13:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tsOi3-0000VD-DY
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 12:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741796009;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tXdYkiDiF96+isnvOpDD4U8i4rrBdoq5tobkI0Svnb8=;
 b=IB2HbpJwCagOfx7f6TYLcJXH/CGDrQoOT/0OabYr5EgbIIp0XwbJo/7InruDy5dmcHdG55
 xcXai4FPrTO55mqYnWGvaP1hUHB/zlGlx4cam9RAmAo+pWY5k0GdEb+BgD+wz15U0U0zld
 siIOhTyMRReaf2fREjV5K21CXtLB+NQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-bCmCfkEBOpazuBZYR3AX3A-1; Wed, 12 Mar 2025 12:13:28 -0400
X-MC-Unique: bCmCfkEBOpazuBZYR3AX3A-1
X-Mimecast-MFC-AGG-ID: bCmCfkEBOpazuBZYR3AX3A_1741796008
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c0b9242877so594358285a.3
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 09:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741796008; x=1742400808;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tXdYkiDiF96+isnvOpDD4U8i4rrBdoq5tobkI0Svnb8=;
 b=W9EV3RkHX6LtMxUySK2Hzx+EPXy9Ca5Z8qcJ8fWJ88UO26LDHQPyDtml2pQeM1sKv4
 z5mSs6ZxCfDspaqwy9lqTL2alqSqNHjF7CTakWcrHm2Y5YLC71QznMbox2oNVUT0odYP
 +ehv2iyLR1DXQRRUnrJwba8pLXRXP13IZQKa8sO48l2+vLJIgDdaj0A71FgoL5U5hXyL
 SE74O0O8T48BV5f5CsLgG93N0i4tp/+WapBN7+mbZ7pCK4rd4u1K3w9ZkPl1uxfp2Phf
 sZ4LJARlVKUl2J9+t+QwKIKcKZN+1I1MqGEidLdpciUa2CyGgrZDGU1LpMPk9oz3EOxH
 anFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhVNu9wuCO1giDY1tle6xzlrZoRSwWYd3E+GLN10DW/2alW8VaXflmNJO1O6vcdTbrZy0+8Bm/Izn3@nongnu.org
X-Gm-Message-State: AOJu0Ywl41GTJHHTMljy2NzWLhHcNWmi8yYqXXHPApn+LYQbfFbw2dPH
 axO1GBkT3QUgEkM7Ju9UDJcJn0LeazINCY0SfKZRFepq0laoKYyuwzcx9I0kSQ+MAZ9ES3YCIYZ
 3v3Lx/Qh+5wzzNUX2m+bUaIDl2Wovb/u81s8myaA1YwHKYXi1jheL
X-Gm-Gg: ASbGncskMlK7SNwL2bv99/TJgm67BSGV9aWgakDdouNOzZ7sYHfr/vxQAthKFjNRSq+
 bvYKlExWMvQj8qOvqGeroBa+O03gkQgo+4qYktzus1CpqShmYHMkj55qozxtpFpI0DFvTuyBqIM
 LNBD5uggx1GGkUASNvRMQe+dLU5V9ag3o8c94cbejkokFT7FiLpGUpDQXUtL8uRbWW/+0R1GgjC
 0AnJb4fdmh7VcpDoZPUfMLk5r4oclLKS31xLwJtZbwHMVwV889zumxHHSyWCJAjwtb7ZEoGLljs
 MW9C6w//Dop6hEBcTWgvUteV4dIIRhwQVqstHdjyeHB3h73LaXNrQUYgqPccPdo=
X-Received: by 2002:a05:620a:2842:b0:7c5:3ef2:8c40 with SMTP id
 af79cd13be357-7c53ef28f53mr2335462485a.12.1741796008054; 
 Wed, 12 Mar 2025 09:13:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQSkmeq59Jcjqtpky3wBvc18dR1h/ZwjKkqatgKTh00wBXSvbUtQPr4STMUyZl9GqTK6xICw==
X-Received: by 2002:a05:620a:2842:b0:7c5:3ef2:8c40 with SMTP id
 af79cd13be357-7c53ef28f53mr2335459285a.12.1741796007760; 
 Wed, 12 Mar 2025 09:13:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c559e11134sm374158185a.12.2025.03.12.09.13.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 09:13:27 -0700 (PDT)
Message-ID: <5b29ea01-1b86-4b48-a769-14986751a0f1@redhat.com>
Date: Wed, 12 Mar 2025 17:13:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 04/20] hw/arm/virt: Add support for smmuv3-accel
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-5-shameerali.kolothum.thodi@huawei.com>
 <547f961e-380c-4ffe-8b8b-3e9d543aa702@redhat.com>
 <58c9c37876c64584b0c7961ec61696a3@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <58c9c37876c64584b0c7961ec61696a3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Shameer,


On 3/12/25 4:46 PM, Shameerali Kolothum Thodi wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: qemu-devel-
>> bounces+shameerali.kolothum.thodi=huawei.com@nongnu.org <qemu-
>> devel-bounces+shameerali.kolothum.thodi=huawei.com@nongnu.org> On
>> Behalf Of Eric Auger
>> Sent: Wednesday, March 12, 2025 3:36 PM
>> To: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>> qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; jgg@nvidia.com; nicolinc@nvidia.com;
>> ddutile@redhat.com; berrange@redhat.com; nathanc@nvidia.com;
>> mochs@nvidia.com; smostafa@google.com; Linuxarm
>> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
>> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
>> Subject: Re: [RFC PATCH v2 04/20] hw/arm/virt: Add support for smmuv3-
>> accel
>>
>> Hi Shameer,
>>
>>
>> On 3/11/25 3:10 PM, Shameer Kolothum wrote:
>>> Allow cold-plug smmuv3-accel to virt If the machine wide smmuv3
>>> is not specified.
>>>
>>> No FDT support is added for now.
>>>
>>> Signed-off-by: Shameer Kolothum
>> <shameerali.kolothum.thodi@huawei.com>
>>> ---
>>>  hw/arm/virt.c         | 12 ++++++++++++
>>>  hw/core/sysbus-fdt.c  |  1 +
>>>  include/hw/arm/virt.h |  1 +
>>>  3 files changed, 14 insertions(+)
>>>
>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>>> index 4a5a9666e9..84a323da55 100644
>>> --- a/hw/arm/virt.c
>>> +++ b/hw/arm/virt.c
>>> @@ -73,6 +73,7 @@
>>>  #include "qobject/qlist.h"
>>>  #include "standard-headers/linux/input.h"
>>>  #include "hw/arm/smmuv3.h"
>>> +#include "hw/arm/smmuv3-accel.h"
>>>  #include "hw/acpi/acpi.h"
>>>  #include "target/arm/cpu-qom.h"
>>>  #include "target/arm/internals.h"
>>> @@ -2911,6 +2912,16 @@ static void
>> virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>>>              platform_bus_link_device(PLATFORM_BUS_DEVICE(vms-
>>> platform_bus_dev),
>>>                                       SYS_BUS_DEVICE(dev));
>>>          }
>>> +        if (object_dynamic_cast(OBJECT(dev), TYPE_ARM_SMMUV3_ACCEL))
>> {
>>> +            if (vms->iommu == VIRT_IOMMU_SMMUV3) {
>> maybe just check whether it is != VIRT_IOMMU_NONE?
>>> +                error_setg(errp,
>>> +                           "iommu=smmuv3 is already specified. can't create
>> smmuv3-accel dev");
>> I would clearly state "iommu=smmuv3 virt machine option is alreadt set"
>> and use an error hint to say both are not compatible.
>>> +                return;
>>> +            }
>>> +            if (vms->iommu != VIRT_IOMMU_SMMUV3_ACCEL) {
>>> +                vms->iommu = VIRT_IOMMU_SMMUV3_ACCEL;
>> I know there were quite a lot of dicussions on the 1st multi
>> instantiation series related to the way we instanatiate that device and
>> maybe I missed some blockers but why wouldn't we allow the instantiation
>> of the legacy smmu device with -device too. I think this would be
>> simpler for libvirt and we would somehow deprecate the machine option
>> method? would that make a problem if you were to use -device smmu,accel
>> or something alike?
> Thanks for taking a look. I am just jumping on this one for now.  Yes, there
> were discussions around that. But I was not sure we concluded on deprecating
> the machine option. So if I get you correctly the idea is,
>
> if we have, 
> -device smmuv3 it will instantiate the current machine wide smmuv3 and for
> -device smmuv3,accel this device?
yes that would be my preference.

Eric
>
> Thanks,
> Shameer



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C979C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 16:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsOw7-0006Ku-5v; Wed, 12 Mar 2025 12:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tsOw5-0006HU-9G
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 12:28:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tsOw3-0003HV-61
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 12:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741796877;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/yVTJvH0OauXFUivf9YJv5P0lB94yuCxQcCdRvEY22o=;
 b=H7zTDur+aDvWZBZ79Pr/RYPGCl3v61Z+l/hfgAX+Je4wjZqvic+rcSZfMn8vjKgVeIlxi2
 QH/f5/S9IpKlE6pW9fFziYvlfbMcsUaUrqcIYm/7mpwuRXv6rEmRE4SZmeJCLoNdUahNDj
 Cnj9x/ea+67hF1SDuM7pVvkOKNa7+Pw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-kFw7cbDmNZSpa4Rg2jVTaw-1; Wed, 12 Mar 2025 12:27:55 -0400
X-MC-Unique: kFw7cbDmNZSpa4Rg2jVTaw-1
X-Mimecast-MFC-AGG-ID: kFw7cbDmNZSpa4Rg2jVTaw_1741796875
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-476aa099fb3so43537401cf.2
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 09:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741796875; x=1742401675;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/yVTJvH0OauXFUivf9YJv5P0lB94yuCxQcCdRvEY22o=;
 b=JF20MgAsNWqyX9V2Ww5OwaGnaVWfsdIcyMIrw+6AUib9aY5/UlQ5q/odA2YH3PGhvu
 1aZe/8UJTmN6I1w+fyYDFEzSMoQNGD1ENxaTvIn58BBXHUullU0HCJA7jPZ+oY/swjM3
 Xv+GztLYiBZqHmszFiFPA4Agh4KB8e9hrNw28FiJbK9oCF4/5hKMe2D772vTdmzghK2Y
 7RCRejtzoi8jdlj/nXSnN+0ckf/Tv+Ha7lMnv+pyGPIsMkEcx/IETVmW8fKGxGPuME19
 MPNoy0txy1E36tzcI65/K3o/cudonBwjrRzjEy9yYt1bnTEQ1M6NuFWHnAtF8LGfL1d9
 7PVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCWm7y9eADuif9za69+P0Zsqm0oLM1Ow5c1/uo8s3Hhw0gJTPjeFZbUSPVAPsP4zo86/1EbyoiMIFs@nongnu.org
X-Gm-Message-State: AOJu0Yztv4/YruHgIauBIx+y1xgauUsMGwywRMhA0u1rC/yXa9XHRz5V
 TGQSF0ZnPgfFuec2IKl08kzV2jwbT3jzijcM2R9YQLGToaQm3Z4MwhZ4teQwrDQVNylpHparMrg
 8nXc7XYuEm7G3QQ6SbaHQRcsrD7ray7oGhvGnltGR7jK8zAtPLu9C
X-Gm-Gg: ASbGncseuN8v1MZkW0L6fz5ENeZU1KUwsXuFJanlFgA0dyQJg24bkuEsOcGc/wmHxPm
 YWrkeIPgltXe6aOj2kF1VtQC/Ui8cHQlN4FxTMBobpbsGyreYk6Y5UkBAeFAao0k0P7vLNLjTlY
 EDUbFr2aOCGzgAfa6rtVeZmEkr62A8HtQdOR+s60qQz1rpJcUv49dYe4PMcCFgpFmRMZavGPzi9
 ZKc3IOcUM6Hv9M/QraCYXLVznHOT0ldLOx7e6MOtHmd7q+yBE7PzAnRzEFcvMF6y/G5kX2b06hY
 XXLNh2QY38ztmb18ICD9NkyBbzzz6RiibgVFJS1Nc5O2wRGW76MdmcO1NUzWUmk=
X-Received: by 2002:a05:622a:438b:b0:476:afd2:5b4b with SMTP id
 d75a77b69052e-476afd29835mr25417461cf.8.1741796875192; 
 Wed, 12 Mar 2025 09:27:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHOf1bTmb21wkjMEDmUeWzO60iLJsinhHqZqYcXNgbVkIg7B8ONR2bPNZ6na664g2Wt09EDQ==
X-Received: by 2002:a05:622a:438b:b0:476:afd2:5b4b with SMTP id
 d75a77b69052e-476afd29835mr25417261cf.8.1741796874855; 
 Wed, 12 Mar 2025 09:27:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4767e447867sm50703211cf.41.2025.03.12.09.27.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 09:27:54 -0700 (PDT)
Message-ID: <fb28c228-0c78-4412-ba91-a62cb4351793@redhat.com>
Date: Wed, 12 Mar 2025 17:27:49 +0100
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
 <5b29ea01-1b86-4b48-a769-14986751a0f1@redhat.com>
 <5d894a546d3f4081ac2cfe98bd2ea612@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <5d894a546d3f4081ac2cfe98bd2ea612@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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




On 3/12/25 5:22 PM, Shameerali Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: qemu-devel-
>> bounces+shameerali.kolothum.thodi=huawei.com@nongnu.org <qemu-
>> devel-bounces+shameerali.kolothum.thodi=huawei.com@nongnu.org> On
>> Behalf Of Eric Auger
>> Sent: Wednesday, March 12, 2025 4:13 PM
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
>> On 3/12/25 4:46 PM, Shameerali Kolothum Thodi wrote:
>>> Hi Eric,
>>>
>>>> -----Original Message-----
>>>> From: qemu-devel-
>>>> bounces+shameerali.kolothum.thodi=huawei.com@nongnu.org <qemu-
>>>> devel-bounces+shameerali.kolothum.thodi=huawei.com@nongnu.org>
>> On
>>>> Behalf Of Eric Auger
>>>> Sent: Wednesday, March 12, 2025 3:36 PM
>>>> To: Shameerali Kolothum Thodi
>>>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>>>> qemu-devel@nongnu.org
>>>> Cc: peter.maydell@linaro.org; jgg@nvidia.com; nicolinc@nvidia.com;
>>>> ddutile@redhat.com; berrange@redhat.com; nathanc@nvidia.com;
>>>> mochs@nvidia.com; smostafa@google.com; Linuxarm
>>>> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
>>>> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
>>>> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
>>>> Subject: Re: [RFC PATCH v2 04/20] hw/arm/virt: Add support for
>>>> smmuv3- accel
>>>>
>>>> Hi Shameer,
>>>>
>>>>
>>>> On 3/11/25 3:10 PM, Shameer Kolothum wrote:
>>>>> Allow cold-plug smmuv3-accel to virt If the machine wide smmuv3 is
>>>>> not specified.
>>>>>
>>>>> No FDT support is added for now.
>>>>>
>>>>> Signed-off-by: Shameer Kolothum
>>>> <shameerali.kolothum.thodi@huawei.com>
>>>>> ---
>>>>>  hw/arm/virt.c         | 12 ++++++++++++
>>>>>  hw/core/sysbus-fdt.c  |  1 +
>>>>>  include/hw/arm/virt.h |  1 +
>>>>>  3 files changed, 14 insertions(+)
>>>>>
>>>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c index
>>>>> 4a5a9666e9..84a323da55 100644
>>>>> --- a/hw/arm/virt.c
>>>>> +++ b/hw/arm/virt.c
>>>>> @@ -73,6 +73,7 @@
>>>>>  #include "qobject/qlist.h"
>>>>>  #include "standard-headers/linux/input.h"
>>>>>  #include "hw/arm/smmuv3.h"
>>>>> +#include "hw/arm/smmuv3-accel.h"
>>>>>  #include "hw/acpi/acpi.h"
>>>>>  #include "target/arm/cpu-qom.h"
>>>>>  #include "target/arm/internals.h"
>>>>> @@ -2911,6 +2912,16 @@ static void
>>>> virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>>>>>              platform_bus_link_device(PLATFORM_BUS_DEVICE(vms-
>>>>> platform_bus_dev),
>>>>>                                       SYS_BUS_DEVICE(dev));
>>>>>          }
>>>>> +        if (object_dynamic_cast(OBJECT(dev),
>>>>> + TYPE_ARM_SMMUV3_ACCEL))
>>>> {
>>>>> +            if (vms->iommu == VIRT_IOMMU_SMMUV3) {
>>>> maybe just check whether it is != VIRT_IOMMU_NONE?
>>>>> +                error_setg(errp,
>>>>> +                           "iommu=smmuv3 is already specified.
>>>>> + can't create
>>>> smmuv3-accel dev");
>>>> I would clearly state "iommu=smmuv3 virt machine option is alreadt set"
>>>> and use an error hint to say both are not compatible.
>>>>> +                return;
>>>>> +            }
>>>>> +            if (vms->iommu != VIRT_IOMMU_SMMUV3_ACCEL) {
>>>>> +                vms->iommu = VIRT_IOMMU_SMMUV3_ACCEL;
>>>> I know there were quite a lot of dicussions on the 1st multi
>>>> instantiation series related to the way we instanatiate that device
>>>> and maybe I missed some blockers but why wouldn't we allow the
>>>> instantiation of the legacy smmu device with -device too. I think
>>>> this would be simpler for libvirt and we would somehow deprecate the
>>>> machine option method? would that make a problem if you were to use
>>>> -device smmu,accel or something alike?
>>> Thanks for taking a look. I am just jumping on this one for now.  Yes,
>>> there were discussions around that. But I was not sure we concluded on
>>> deprecating the machine option. So if I get you correctly the idea is,
>>>
>>> if we have,
>>> -device smmuv3 it will instantiate the current machine wide smmuv3 and
>>> for -device smmuv3,accel this device?
>> yes that would be my preference.
> Ok. I will look into that in my next respin. A quick question. Does qemu
> DEVICE model support the differentiation like above easily? Or we have
> to manage it with properties?
Not sure if I understand you question. I meant it can be a boolean
device property (DEFINE_PROP_BOOL) smmuv3,accel=on

No?

Eric
>
> Any example device implementation like above already there?
> Please let me know.
>
> Thanks,
> Shameer
>
>
>  
>



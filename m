Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBEEC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 14:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwjcw-0006es-J6; Tue, 16 Apr 2024 10:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rwjco-0006cZ-BB
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:17:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rwjci-0005yt-FP
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713277043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PeKeC8mq230gpeDVmokE9xgNdY9hhaC6dqBwpF9B0Dw=;
 b=c9eao/DXXXi60qkDL1DCRNwbGVdgGO46gt9aNjoWPUfWV51/Ul/TRg73BNiBDY5RkTuEUQ
 avHHNDbSRraHcxg158G0XOwitJm4GuwD3sEsR6irqkFT0V5sNliJOeQ7hjFo0XxZHjDQaf
 CNRusMhFUEb4/U6pG+mnmkjUR9uq8gE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-TDVbtlroMsGwQyURRiB2iw-1; Tue, 16 Apr 2024 10:17:21 -0400
X-MC-Unique: TDVbtlroMsGwQyURRiB2iw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-415591b1500so17928495e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 07:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713277041; x=1713881841;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PeKeC8mq230gpeDVmokE9xgNdY9hhaC6dqBwpF9B0Dw=;
 b=IlzZ4zizfIjid9NHMveV/uYIVPzxdhU+PWNztb4kwWUkxTJ2UOG0wBxvLgXsB47yKQ
 mB+L32aERWNdGctLqaE9Iz5HVH+mblb+Dq3x+Y33+XqxKLyehT5x8plRoEGlISu9Zb5H
 FG2EKupKI0LI83sJz8Nmi4O/+K4gDvyjXSqNYo1QNb3N4wdO38Kdkm39zTnZEOTuQLM7
 Xgr8UOxcGay3qrzcOlLmmbpHtVZBFlXSLSeXQOQ+wZfsVGeiCLIqJCXiGyoqvz1iHaLM
 odCYNPgHm04at0VyJih6lenWKrjRUApNGxWpNjHD+0HXWds0RPecuUhFsXyQvdKlTxVY
 UkDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhgPXFJGmTu2JC7JaLVXdULi6861m0JvIDeuino1Aju3IR9cfAZFU2dKaV4RIolxHbJAmMSM+dh11NGdv7jgvcwoeV6w8=
X-Gm-Message-State: AOJu0Yy2mmD8zol9JlgRQubL4fHkfPS8jia4mPsnT3ehl8fuUEpRZYj5
 6AmsC3T3etvR4Nu1N/s6Cci62chpMLvoHG+TIczyApuZIQVwKBlamMXQWf2JTcgTvjaNmUdKnLq
 xbctrZ0VLckJkONec52FkjdIKeT3VLzYOjCoGDRzHtmCXmMVmsDN8
X-Received: by 2002:a05:600c:3148:b0:418:4303:65e5 with SMTP id
 h8-20020a05600c314800b00418430365e5mr6115853wmo.38.1713277040830; 
 Tue, 16 Apr 2024 07:17:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY9T0cYyaoQmMSU8DjjURtw76ryY1vblvwEBqF/WlD8Bd4sxcz9n9mv9FX//hiectIr7kjcQ==
X-Received: by 2002:a05:600c:3148:b0:418:4303:65e5 with SMTP id
 h8-20020a05600c314800b00418430365e5mr6115829wmo.38.1713277040368; 
 Tue, 16 Apr 2024 07:17:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae?
 ([2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae])
 by smtp.gmail.com with ESMTPSA id
 q1-20020adfb181000000b00346266b612csm15173102wra.81.2024.04.16.07.17.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 07:17:19 -0700 (PDT)
Message-ID: <5eb6c665-df8f-4c5e-8426-4678d8433a0c@redhat.com>
Date: Tue, 16 Apr 2024 16:17:14 +0200
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
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB67443BF6BC7CABCE28F482A392082@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
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

Hello,

On 4/16/24 09:09, Duan, Zhenzhong wrote:
> Hi Cédric,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH v2 3/5] intel_iommu: Add a framework to do
>> compatibility check with host IOMMU cap/ecap
>>
>> On 4/8/24 10:44, Zhenzhong Duan wrote:
>>> From: Yi Liu <yi.l.liu@intel.com>
>>>
>>> If check fails, the host side device(either vfio or vdpa device) should not
>>> be passed to guest.
>>>
>>> Implementation details for different backends will be in following patches.
>>>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    hw/i386/intel_iommu.c | 35
>> +++++++++++++++++++++++++++++++++++
>>>    1 file changed, 35 insertions(+)
>>>
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index 4f84e2e801..a49b587c73 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -35,6 +35,7 @@
>>>    #include "sysemu/kvm.h"
>>>    #include "sysemu/dma.h"
>>>    #include "sysemu/sysemu.h"
>>> +#include "sysemu/iommufd.h"
>>>    #include "hw/i386/apic_internal.h"
>>>    #include "kvm/kvm_i386.h"
>>>    #include "migration/vmstate.h"
>>> @@ -3819,6 +3820,32 @@ VTDAddressSpace
>> *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>>>        return vtd_dev_as;
>>>    }
>>>
>>> +static int vtd_check_legacy_hdev(IntelIOMMUState *s,
>>> +                                 HostIOMMUDevice *hiod,
>>> +                                 Error **errp)
>>> +{
>>> +    return 0;
>>> +}
>>> +
>>> +static int vtd_check_iommufd_hdev(IntelIOMMUState *s,
>>> +                                  HostIOMMUDevice *hiod,
>>> +                                  Error **errp)
>>> +{
>>> +    return 0;
>>> +}
>>> +
>>> +static int vtd_check_hdev(IntelIOMMUState *s, VTDHostIOMMUDevice
>> *vtd_hdev,
>>> +                          Error **errp)
>>> +{
>>> +    HostIOMMUDevice *hiod = vtd_hdev->dev;
>>> +
>>> +    if (object_dynamic_cast(OBJECT(hiod), TYPE_HIOD_IOMMUFD)) {
>>> +        return vtd_check_iommufd_hdev(s, hiod, errp);
>>> +    }
>>> +
>>> +    return vtd_check_legacy_hdev(s, hiod, errp);
>>> +}
>>
>>
>> I think we should be using the .get_host_iommu_info() class handler
>> instead. Can we refactor the code slightly to avoid this check on
>> the type ?
> 
> There is some difficulty ini avoiding this check, the behavior of vtd_check_legacy_hdev
> and vtd_check_iommufd_hdev are different especially after nesting support introduced.
> vtd_check_iommufd_hdev() has much wider check over cap/ecap bits besides aw_bits.

I think it is important to fully separate the vIOMMU model from the
host IOMMU backing device. Could we introduce a new HostIOMMUDeviceClass
handler .check_hdev() handler, which would call .get_host_iommu_info() ?


Thanks,

C.


> That the reason I have two functions to do different thing.
> See:
> https://github.com/yiliu1765/qemu/blob/zhenzhong/iommufd_nesting_rfcv2/hw/i386/intel_iommu.c#L5472
> 
> Meanwhile in vtd_check_legacy_hdev(), when legacy VFIO device attaches to modern vIOMMU,
> this is unsupported and error out early, it will not call .get_host_iommu_info().
> I mean we don't need to unconditionally call .get_host_iommu_info() in some cases.
> 
> Thanks
> Zhenzhong



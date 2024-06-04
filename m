Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C848C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQd0-0007Tz-2N; Tue, 04 Jun 2024 05:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sEQcy-0007Tg-JV
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:38:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sEQcw-0004Fv-WC
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717493926;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CmqKyZRFnTf9fy0t5yVod40Etlc1mFPdjroameY7sco=;
 b=Qw9jPgtAWY65i2X5w5uBjTS4Ko/2QMRDF8EDBULtAaIJovld0R3X93shiXE9exDiStO9md
 q4R6GzAV+EefCobQkW1Dc5g9VpUO98Xv04OAHaRvaPAQltpx5dirImkBHI7WkyXSTAlLOy
 jC5Uukelt1BrICZPvaN/YRCI6CGFFb4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-IkgjoAJDNbSQrDjcnRhAxw-1; Tue, 04 Jun 2024 05:38:44 -0400
X-MC-Unique: IkgjoAJDNbSQrDjcnRhAxw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4212a3ddb6bso34342115e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717493923; x=1718098723;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CmqKyZRFnTf9fy0t5yVod40Etlc1mFPdjroameY7sco=;
 b=uw5UtQv9M16nn3FTBd1DuY9RIIOC6XJdQHmlDebgBeVCJH5HnlHatxpdBFRmYtSjIR
 P5/UAzMCqjrxp3Z7QFi4VqY0MT32XDwTUYbbMWR91UcqdjXgAJna8eBp+mmx9iKP8KWP
 L3fXkzmYMSz17TDPvcfMu9/wAh4NIbrM2+kwXYJCgsBluESlOgogwmzTYUVs3mf+Iz6G
 fLNqBA22e/GySLRetol7AS1MrRKmX2ZaHUukzlHT2XfB5ZkR7HsfojlIwdW0GyS/6yHD
 4qAYqQf99E7Z5KW+JolMXUnIbePGoXn0Tu4BbZiVJTz0rO7nD9zuwTHFvCT0ojn6z7GO
 7+fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURE9doJ77IYs9M5nUn7aVF0M0z+wzM09beqW34fr+Pau6ycjSHnDYJNcZE752rWWgFc0U+gYzrA7bN426HFGDLMmB9GZE=
X-Gm-Message-State: AOJu0Yy30npyu0kiNfyFMTEg2CxO1wE+XNqZG0fpRK4ZUa3/VOe3yoWR
 P6UdafvlwTz1UtXzyxfSDLX5T76rJf1kwUhshPpfznn3KLYwvlUjWJ/MsPwNEkPgYFwj4PMSvRg
 Q/iWwrxraIUsBWvqN3qnDDihLo8LMTDowJezNxBK7cBekvWuDi+u0
X-Received: by 2002:a05:600c:4f82:b0:41a:821b:37f7 with SMTP id
 5b1f17b1804b1-4212e0a52f5mr96488015e9.27.1717493923510; 
 Tue, 04 Jun 2024 02:38:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnoPdgZ93lbLk+m6uHKw+UchIGaiqGjROo9IRwncJZvDVzNenzVi/k6jqJrVF3b893Acy5RQ==
X-Received: by 2002:a05:600c:4f82:b0:41a:821b:37f7 with SMTP id
 5b1f17b1804b1-4212e0a52f5mr96487845e9.27.1717493923090; 
 Tue, 04 Jun 2024 02:38:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4214beb5c9asm13929885e9.7.2024.06.04.02.38.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 02:38:42 -0700 (PDT)
Message-ID: <3e3b49dd-89e1-4586-aa32-6d89022d5e54@redhat.com>
Date: Tue, 4 Jun 2024 11:38:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 18/19] intel_iommu: Implement
 [set|unset]_iommu_device() callbacks
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
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-19-zhenzhong.duan@intel.com>
 <7d5fb5db-8505-469a-a41f-6e18ef8bc77c@redhat.com>
 <SJ0PR11MB67442CF9C141B5C1120CA59092F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <d089e681-5fa3-4f97-8637-76376fd4b4fc@redhat.com>
 <SJ0PR11MB67442ADA8C8CC17F14012A0092F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB67442ADA8C8CC17F14012A0092F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 6/4/24 10:48, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: Re: [PATCH v6 18/19] intel_iommu: Implement
>> [set|unset]_iommu_device() callbacks
>>
>>
>>
>> On 6/4/24 07:40, Duan, Zhenzhong wrote:
>>>> -----Original Message-----
>>>> From: Eric Auger <eric.auger@redhat.com>
>>>> Subject: Re: [PATCH v6 18/19] intel_iommu: Implement
>>>> [set|unset]_iommu_device() callbacks
>>>>
>>>> Hi Zhenzhong,
>>>>
>>>> On 6/3/24 08:10, Zhenzhong Duan wrote:
>>>>> From: Yi Liu <yi.l.liu@intel.com>
>>>>>
>>>>> Implement [set|unset]_iommu_device() callbacks in Intel vIOMMU.
>>>>> In set call, a new structure VTDHostIOMMUDevice which holds
>>>>> a reference to HostIOMMUDevice is stored in hash table
>>>>> indexed by PCI BDF.
>>>> maybe precise that this is not the aliased one?
>>> Sure.
>>>
>>>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>>>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>> ---
>>>>>  hw/i386/intel_iommu_internal.h |  9 ++++
>>>>>  include/hw/i386/intel_iommu.h  |  2 +
>>>>>  hw/i386/intel_iommu.c          | 76
>>>> ++++++++++++++++++++++++++++++++++
>>>>>  3 files changed, 87 insertions(+)
>>>>>
>>>>> diff --git a/hw/i386/intel_iommu_internal.h
>>>> b/hw/i386/intel_iommu_internal.h
>>>>> index f8cf99bddf..b800d62ca0 100644
>>>>> --- a/hw/i386/intel_iommu_internal.h
>>>>> +++ b/hw/i386/intel_iommu_internal.h
>>>>> @@ -28,6 +28,7 @@
>>>>>  #ifndef HW_I386_INTEL_IOMMU_INTERNAL_H
>>>>>  #define HW_I386_INTEL_IOMMU_INTERNAL_H
>>>>>  #include "hw/i386/intel_iommu.h"
>>>>> +#include "sysemu/host_iommu_device.h"
>>>>>
>>>>>  /*
>>>>>   * Intel IOMMU register specification
>>>>> @@ -537,4 +538,12 @@ typedef struct VTDRootEntry VTDRootEntry;
>>>>>  #define VTD_SL_IGN_COM              0xbff0000000000000ULL
>>>>>  #define VTD_SL_TM                   (1ULL << 62)
>>>>>
>>>>> +
>>>>> +typedef struct VTDHostIOMMUDevice {
>>>>> +    IntelIOMMUState *iommu_state;
>>>> Why do you need the iommu_state?
>>> It is used in nesting series.
>>>
>>>>> +    PCIBus *bus;
>>>>> +    uint8_t devfn;
>>>>> +    HostIOMMUDevice *dev;
>>>>> +    QLIST_ENTRY(VTDHostIOMMUDevice) next;
>>>>> +} VTDHostIOMMUDevice;
>>>> How VTD specific is it?
>>> In nesting series, it has element iommu_state and errata
>>> which are VTD specific.
>> so at least I would add a comment in the commit message explaining this.
> I'd like to drop it and reintroduce it in nesting series.

OK then just justify the choice of introducing another struct  because
other VTD specific fields will be introduced later on

Eric
>
> Thanks
> Zhenzhong
>



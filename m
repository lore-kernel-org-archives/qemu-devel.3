Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22278EA8130
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 16:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpqBH-0001Ue-3l; Tue, 10 Feb 2026 11:01:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vpqBF-0001UM-Gz
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:01:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vpqBD-0006Yh-OI
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:01:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770739294;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XX1FfvGUqj0Obv8a5Pl1RjMyLWiLnvD7U1LpzfPXPCw=;
 b=EvUBAZh8yMsliLNtPzh5YQKTA8dngCZmqAjbZSkv1UqKIcJYtclwM2aCsCkXrQY/m005Hk
 bLyBTYboDTPTCAov0tWEUAqLqPnbQsE7P7JoktvIX7CbLH0eBfBT5D99dmYoffuKJtISzC
 rrksu4OneeBz2xaYZuJO0jC16i1vS20=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-TxN0fhGHNY-bv68k4TC_2w-1; Tue, 10 Feb 2026 11:01:32 -0500
X-MC-Unique: TxN0fhGHNY-bv68k4TC_2w-1
X-Mimecast-MFC-AGG-ID: TxN0fhGHNY-bv68k4TC_2w_1770739291
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48057c39931so52576025e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 08:01:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770739291; x=1771344091;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XX1FfvGUqj0Obv8a5Pl1RjMyLWiLnvD7U1LpzfPXPCw=;
 b=s5lWMvjLgEKqp76CPh36j1yvLIFvZQ05g9L4pR2uJg/qwAzOLezL5TYlzsYGVZJDBc
 OsXVI7gVUqeHyPv0tJbd2F7EkA6CuvuPsV7wcPLPECzjgdR2MZBgvk6DEOKz9rffZ6JB
 LuoyjXjSR2JXVMOubJ/PCe1F6fqX2Qzg4qjO4d7WLLjmjDC5HMOfMfjdaAI4KoZsI5YQ
 qhSfuNo5sq9mjhKCHaUM0leu3dIXTThKUhdKdlKGJK3anLdGi9nmpH0jprigQR1M30vs
 mzQtl6z20xCwk07pCeUU8YQGInyQ44A9x68saaKJ+iUKJBxN+dQgYgYG3enPcX/ljOzh
 /jwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoVYsEfrgUGyDpbjvwwCDc4l2BAuOv4/lcJ9jUFiXToPKJWwZNXkU5l0P5da11aNe16K9a6VVb0SnV@nongnu.org
X-Gm-Message-State: AOJu0YwkSm0FWZsE2HmPt67BZfnOfwfu/UV6yR0s/TGT1j5U/YVHP4+b
 D3MI98mALF5GXf/xHtSkpDfmx/6S1Qyvo/KcA2UT7gvN42NGy+WbNSKheE7zf7XSfz7sLDfxSbf
 VglMQSFofOuVATW5IfvS+QsrqxFG8M4j2kOZVp1ziPrEGqd8Ehc5fdWkh
X-Gm-Gg: AZuq6aJ1hjHCJ0W8/Lpy/f9NRjCXX/Od0CSc+GLDikjl5t+TZrMoBCHLKu63bC96++x
 aUH3d2ojrxq3qXHZQ06x+aKAC+brcFxt+OtxW5XdgZi+ral9Vcb1Khfr5VyJh3w+pwGTSOLKSno
 2j1qWESfrMrMllB7vCQIYgzqaIkf20esCOOnrkhAfnIeHc2Fyo/qQR04hH//Key6Z2rzutt9HXR
 8SBY4zKl4oHUaWVZiWXGLccujgHXNC57zIHlmqaqHIYk2+buhATZJ6YA/Ei+/kA3RBQtDEgi1Q0
 E3z5yU0spm84JkAl10Hev/0AVHyujBafkfTzPQVPTcQEHdqpn9FDc1k742m2Er0/WBZ5omGnTBi
 uhGzT5JhURn/wk/haXhpwrMTHW0U4QRl0RrTYSEiCIb7juKI5PNuBVOP2EhlwiYeDwtl27w==
X-Received: by 2002:a05:600c:46d5:b0:480:1a3a:5ce6 with SMTP id
 5b1f17b1804b1-483201e4bcamr212476355e9.14.1770739290697; 
 Tue, 10 Feb 2026 08:01:30 -0800 (PST)
X-Received: by 2002:a05:600c:46d5:b0:480:1a3a:5ce6 with SMTP id
 5b1f17b1804b1-483201e4bcamr212475725e9.14.1770739290145; 
 Tue, 10 Feb 2026 08:01:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d7e64b0sm83195635e9.11.2026.02.10.08.01.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Feb 2026 08:01:29 -0800 (PST)
Message-ID: <03282286-c99e-467b-8192-695d973ea656@redhat.com>
Date: Tue, 10 Feb 2026 17:01:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 31/37] hw/arm/smmuv3-accel: Add property to specify OAS
 bits
Content-Language: en-US
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
 <20260126104342.253965-32-skolothumtho@nvidia.com>
 <d9192ae6-a94f-479a-b19f-734cc52a6be0@redhat.com>
 <CH3PR12MB754867E986856DC7718D4051AB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20260202151917.GO2223369@nvidia.com>
 <CH3PR12MB754835BE4A5C54387122504AAB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20260202160000.GR2223369@nvidia.com>
 <CH3PR12MB7548DFE7F7CE555A3B3BF947AB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <CH3PR12MB7548515EDA96BD03F64DCAA2AB62A@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB7548515EDA96BD03F64DCAA2AB62A@CH3PR12MB7548.namprd12.prod.outlook.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
On 2/10/26 4:12 PM, Shameer Kolothum Thodi wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Shameer Kolothum Thodi
>> Sent: 02 February 2026 16:04
>> To: Jason Gunthorpe <jgg@nvidia.com>
>> Cc: eric.auger@redhat.com; qemu-arm@nongnu.org; qemu-
>> devel@nongnu.org; peter.maydell@linaro.org; Nicolin Chen
>> <nicolinc@nvidia.com>; ddutile@redhat.com; berrange@redhat.com;
>> clg@redhat.com; alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>;
>> Matt Ochs <mochs@nvidia.com>; smostafa@google.com;
>> wangzhou1@hisilicon.com; jiangkunkun@huawei.com;
>> jonathan.cameron@huawei.com; zhangfei.gao@linaro.org;
>> zhenzhong.duan@intel.com; yi.l.liu@intel.com; Krishnakant Jaju
>> <kjaju@nvidia.com>
>> Subject: RE: [PATCH v9 31/37] hw/arm/smmuv3-accel: Add property to
>> specify OAS bits
>>
>>
>>
>>> -----Original Message-----
>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>> Sent: 02 February 2026 16:00
>>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
>>> Cc: eric.auger@redhat.com; qemu-arm@nongnu.org; qemu-
>>> devel@nongnu.org; peter.maydell@linaro.org; Nicolin Chen
>>> <nicolinc@nvidia.com>; ddutile@redhat.com; berrange@redhat.com;
>>> clg@redhat.com; alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>;
>>> Matt Ochs <mochs@nvidia.com>; smostafa@google.com;
>>> wangzhou1@hisilicon.com; jiangkunkun@huawei.com;
>>> jonathan.cameron@huawei.com; zhangfei.gao@linaro.org;
>>> zhenzhong.duan@intel.com; yi.l.liu@intel.com; Krishnakant Jaju
>>> <kjaju@nvidia.com>
>>> Subject: Re: [PATCH v9 31/37] hw/arm/smmuv3-accel: Add property to
>>> specify OAS bits
>>>
>>> On Mon, Feb 02, 2026 at 03:38:50PM +0000, Shameer Kolothum Thodi
>>> wrote:
>>>
>>>>> We can treat ATS as a per-PCIe device property.. I think it would
>>>>> be fine to tell the SMMU that it always has ATS support, it will
>>>>> never do anything with it unless it sees a PCIe device with an ATS
>>>>> cap, and the physical STE generated by the hypervisor should sanitize the
>> EATS.
>>>>> BIOS overriding it should be reflected as the devices being
>>>>> reported as not supporting ATS, qemu should have a per-device flag
>>>>> to disable ATS.
>>>> Do we have way to detect that(IOMMU_FWSPEC_PCI_RC_ATS) from
>>>> userspace now?
>>> I don't think so.. I was describing how I suspect that should work.
>>>
>>> The iommu driver is the only entity that decides if ATS should be
>>> enabled per-device, so it should report back to userspace in iommufd
>>> if the device is allowed to enable ATS or not. That should roll up any
>>> FW overrides and the PCI cap block.
>> Right. May be just like the out_max_pasid_log2. Will take a look.
> Looking at adding the ATS detection support through iommufd, one
> idea is to extend the enum iommufd_hw_capabilities with
> IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED. The question I have
> now is whether we need to differentiate an old kernel which doesn't
> have this support or not.
>
> This is how the usage would look with an added "ats" property on the
> vfio-pci device:
>
> -device vfio-pci,...,ats=on
>     if ATS_NOT_SUPPORTED then reject
How do you distinguish an old kernel which is not capable of returning
the cap info from a new kernel that effectively returns the capability
is not supported.
> -device vfio-pci,...,ats=off
>     keep ATS off
> -device vfio-pci,...,ats=auto (default)
>    if ATS_NOT_SUPPORTED, disable ATS
>     otherwise, enable ATS if the PCIe ATS capability is present

I am not sure how it works with an old kernel. auto or on would keep
ATS=off while it is currently set today, no?

Thanks

Eric
>     (this also covers behaviour on older kernels)
>
> Does the above make sense?
>
> Thanks,
> Shameer
>



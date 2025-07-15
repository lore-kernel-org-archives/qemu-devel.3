Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2AAC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 17:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubj8O-0006bR-8B; Tue, 15 Jul 2025 13:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1ubik9-0005Je-C0
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:43:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1ubik7-0005lB-0h
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752597777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q6gPr8Y1UHTqpDkH5Q2VDFlbHP53Gnyg6814Rt4agYU=;
 b=es34KTxJ6SFOoWozxI/qR6Iam3W1uwT8S05w828jFp9Tef91I3FAkvi8XA9D9E0x9OYd2V
 SQwpjV1f4hI24eq3B/kiyc8nOmXiF0V2CuBTWtzK5nwLv0mNHs5k0v75I0ReHItgpStAGe
 wEiElthInf/u5ZW+2rrPVmO3KxK6ZwA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-TDyyllI9NOuL85pHj2ZUJw-1; Tue, 15 Jul 2025 12:42:56 -0400
X-MC-Unique: TDyyllI9NOuL85pHj2ZUJw-1
X-Mimecast-MFC-AGG-ID: TDyyllI9NOuL85pHj2ZUJw_1752597776
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6fac216872cso122972486d6.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 09:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752597776; x=1753202576;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q6gPr8Y1UHTqpDkH5Q2VDFlbHP53Gnyg6814Rt4agYU=;
 b=iXFjfIq7D/cVT9RswUY1FiYbVJzhgItRDgW1b1CO5RM45bh6/QWehBN+Rcql7q4YMt
 cm+nsRJCky6zg6c/zgaxkYeyHBtcRWZ9AaLtOOJzqyMvlS1Cb7dJM5u85+xrMwjUv0+x
 zk1uoTEbqrhmiRBIEaHvfyi5B5FpNEJTo/ajXRhC6OZDbQ05xQOyHIPxwaRHBur4x3JO
 vmmlIUfKMbfA4k9vzGVNAv0xEdN4Hdzc1jvsJZ48fJZHz5rtyrEJyCcmlaCa5LKQ+Qou
 ZN+T6FaQQ+PwAdZQ4xapTjPd52lCfLu7596kdjVAknBQr6SbY/DZpX+wIn9DK7VOfxn9
 NnDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUhzQbznivWROE+t2k/5ekL0rIkn07dfTp0Q5WHzSvoKucIhNK3uAeYt/eSwCRRyIgoFgzyFFy78Rk@nongnu.org
X-Gm-Message-State: AOJu0YzdxOQCrlas3G3gHhovakcYBqdjN5yMo7PHIPoLEpgXPoeHiuvF
 TLTr/5rbIHChln9t0LDdVZJ/f529mmxCIEWzgiLn+9AclkDQ42HrbngtJjPoCryoHY8bRMGmK4R
 ncGGvqFD9xc36sHKoeR2i8f3DdJfjxjC/fkUbikBBsqv7Y0zE4ffpuk28
X-Gm-Gg: ASbGncu7pg45xDK8efSxsRjRqlkDxg85v+bJSsbtHhslJ5EMYkr6GSKP+DktniSkDlU
 QLw08gjE2wt2tzwgEngRfdKTBUEB6aQSTlk6h6qUCa+D5tu2IF6H3bdQ4TTVXFzI8o92512WrVD
 AVgcAwSvj3OzmICr6PSZe9iISVtbgNKHjL9/zH8xPUiSemuZp9+Bi258p/sg84M/PZojYkKj7nD
 NT43d4lE52pDGn4lFESCdBsdboZMIJ3+rw7s6asdr8PEoTYHdz53iQNFdplR0HaC89mDiSr65Lg
 IEE4XFbtfG803PlM0NHOy32NvaMmUzbKyA8tdgn2
X-Received: by 2002:a05:6214:5d0a:b0:6fd:236f:abb4 with SMTP id
 6a1803df08f44-704f4ae3f62mr2229336d6.34.1752597775647; 
 Tue, 15 Jul 2025 09:42:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiAbwsz81kJwhd8VYw8p/IEeBle6Ya6faowDdutMek45d1HHbHlyT2YxYt+bZAulYymtz1YQ==
X-Received: by 2002:a05:6214:5d0a:b0:6fd:236f:abb4 with SMTP id
 6a1803df08f44-704f4ae3f62mr2228876d6.34.1752597775063; 
 Tue, 15 Jul 2025 09:42:55 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70497db4acbsm59812116d6.109.2025.07.15.09.42.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 09:42:54 -0700 (PDT)
Message-ID: <6036bb2e-b573-4b29-a81c-aab42927c313@redhat.com>
Date: Tue, 15 Jul 2025 12:42:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/20] hw/pci: Introduce pci_device_get_viommu_cap()
Content-Language: en-US
To: eric.auger@redhat.com, Nicolin Chen <nicolinc@nvidia.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-3-zhenzhong.duan@intel.com>
 <aG26VBqzOnLAWC5z@Asurada-Nvidia>
 <01584206-e2c0-4881-aaf5-d6c552a30873@redhat.com>
 <aG7A8hxd1R4iVhGT@Asurada-Nvidia>
 <0c99b6aa-440a-44df-b875-a34e64465a04@redhat.com>
 <b8c3b228-953f-4364-b78f-2702ae2bd183@redhat.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <b8c3b228-953f-4364-b78f-2702ae2bd183@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/15/25 11:28 AM, Eric Auger wrote:
> Hi,
> 
> On 7/10/25 3:22 AM, Donald Dutile wrote:
>>
>>
>> On 7/9/25 3:20 PM, Nicolin Chen wrote:
>>> On Wed, Jul 09, 2025 at 01:55:46PM -0400, Donald Dutile wrote:
>>>>>> +enum {
>>>>>> +    VIOMMU_CAP_STAGE1 = BIT_ULL(0),  /* stage1 page table
>>>>>> supported */
>>>>>> +};
>>>>>
>>>>> Thanks for this work. I am happy to see that we can share the
>>>>> common code that allocates a NESTING_PARENT in the core using
>>>>> this flag.
>>>>>
>>>>> Yet on ARM, a STAGE1 page table isn't always a nested S1, the
>>>>> hardware accelerated one. More often, it can be just a regular
>>>>> 1-stage translation table via emulated translation code and an
>>>>> emulated iotlb.
>>>>>
>>>> Because the user-created smmuv3 started as 'accelerated smmuv3',
>>>> and had been 'de-accelerated' to simply 'user created smmuv3',
>>>> I'm looking for some clarification in the above statement/request.
>>>>
>>>> Is the above suppose to reflect that a nested IOMMU has some
>>>> hw-acceleration
>>>> in its Stage1 implementation?
>>>> If so, then call it that: STAGE1_ACCEL.
>>>> If it's suppose to represent that an IOMMU has nested/2-stage support,
>>>> then the above is a valid cap;  -but-, having a nested/2-stage
>>>> support IOMMU
>>>> doesn't necessarily mean its accelerated.
>>>
>>> Well, there are an emulated "nested" mode and an hw-accelerated
>>> "nested" mode in the smmuv3 code, so we had to choose something
>>> like "accel" over "nested".
>>>
>>> Here, on the other hand, I think the core using this CAP would
>>> unlikely care about an emulated "nested" mode in the individual
>>> vIOMMU..
>>>
>>> So I suggested:
>>>        /* hardware-accelerated nested stage-1 page table support */
>>>       VIOMMU_CAP_NESTED_S1 = BIT_ULL(0),
>>>
>>> which it should be clear IMHO.
>>>
>>> If not, maybe go a bit further like "VIOMMU_CAP_HW_NESTED_S1"?
>>>
>>> Thanks
>>> Nicolin
>>>
>> If the distinction is hw-based s1 vs emulated-based s1, than
>> I'd prefer the use of VIOMMU_CAP_HW_NESTED_S1, and avoid the use
> VIOMMU_CAP_HW_NESTED_S1 or even VIOMMU_CAP_HW_NESTED look good to me too
> 
> Thanks
> 
> Eric
+1 to VIOMMU_CAP_HW_NESTED ; the S1 is unnecessary if nested IOMMU is the info being conveyed.
- Don

>> of 'accel'/'ACCEL' unless it is an explicitly stated 'acceleration'
>> feature/option in the SMMU spec.
>>
>> Thanks,
>> - Don
>>
> 



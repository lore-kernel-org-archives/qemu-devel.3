Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35ACC83F10
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 01:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZfze-0006DZ-ND; Wed, 09 Jul 2025 21:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uZfzc-0006Ci-GD
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 21:22:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uZfzZ-0005sg-Tm
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 21:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752110547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e+uZcwxffvvF74Hi/SwT2INujUOeOFSNJJMhWkay1NQ=;
 b=gawRo2C2MwCuTgtXl7nJK/w1vcaC2hgrbDbWoOBkrCeEOhCWonXU9kxnFLfl4VkQ969E09
 RLKgcfXvPx/rJPlFYkwemtXUsKzRo3zJT9Ly9eZ+KwckXGkSGMtxhxLaS/+YAv4Zg25urz
 jjbgj638dL/lvZjlpY2Ktv06M1HUTI8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-scRdAtVJMFWyx9JIluI3tA-1; Wed, 09 Jul 2025 21:22:26 -0400
X-MC-Unique: scRdAtVJMFWyx9JIluI3tA-1
X-Mimecast-MFC-AGG-ID: scRdAtVJMFWyx9JIluI3tA_1752110545
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3139c0001b5so458940a91.2
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 18:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752110545; x=1752715345;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e+uZcwxffvvF74Hi/SwT2INujUOeOFSNJJMhWkay1NQ=;
 b=isHhTCgDQ5tY1fYxChWHEs89BSIDTxQvujMqAAmfm2gK6ziQLvl4sOf4+i7zmly3a+
 MsbsSU6sGJxZjL47c5TYfBKhEAqtrq+AHND2TMaKe/OENGY0amU9zkoVOC64OeY5CEmN
 6YG0MrDP2ZiGMvZB5R8ALKQodkbNy4Nf4vu9nOo9/PB2s3U5Eljhls9cuyTo6gOY+QGs
 eLkZ4jtk5VSSo7QT3f7sEIVE646rzvvgp6xr6bQg5LnpT8DKGcWxH5zBjzT2s21Lh/tj
 AALKKtWrruUWTdCtuDvA8e9KMpBLtxzHPM5ddHMPXOJxTF6beuskWhRVYAwLYfdvL3RI
 ZakA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPmnEkr7XFFxxMEOia84HVSKYfAWlD1iJeNhTVptB3m3swVsnTIEIYJc+xDK3QheEXucxCCF+HbGQw@nongnu.org
X-Gm-Message-State: AOJu0Yz4VuQX0qZ2uhxpm+hEtsekmEBYCmkHaKLU3+KxUAPobCGWg9J+
 znhs26K6l+yXGCcr1X+0cZxlN3fiMoVOvaVpQdgMFvEWnViNsEk+SEH95s2AO79MN/gsjQPg+QY
 f6U5ZZpb8LyvtHPE8+Tj/v3Vh35krvI4l5Qm+gCOu8WE6pgt4wKexMpE5
X-Gm-Gg: ASbGnctGhNdqObnXGZ1CiFuyC5l7ckPSRfXtUo1nmt6w1qkcf8a6imOKYwKSOa9fajw
 ofBGonUGjgWNmeFoWNVuqOT1Yz/RbdHnlhWNY/P88Un3OgmbdjegElR1AewZupviSZMZKPeNGPB
 x+F5iureyFmfJNLEgmHY5IbOhA5Ux50kg5ThbFbTBi8TV8d2KfeVLBXIZeSBYQmCUW25tmBb6AT
 o0//jAivecqwnC154LymbniB6XYso8VXlan+oeRhxpn3nobff9IGz+TrjdY+u6xjICw/MNt0eYE
 OfmuHI0oktepmv7nbhRQ9PA=
X-Received: by 2002:a17:90b:1c0f:b0:311:d05c:936 with SMTP id
 98e67ed59e1d1-31c3c2d493fmr3895142a91.17.1752110545067; 
 Wed, 09 Jul 2025 18:22:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE52OehjlSnKIzZfT9PjfxxvMWt/i7rkJ06XGKH4rPkGll4hRYBcBReWJZeT/chRAV/wwmNKQ==
X-Received: by 2002:a17:90b:1c0f:b0:311:d05c:936 with SMTP id
 98e67ed59e1d1-31c3c2d493fmr3895089a91.17.1752110544614; 
 Wed, 09 Jul 2025 18:22:24 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de4323daesm4441965ad.139.2025.07.09.18.22.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 18:22:24 -0700 (PDT)
Message-ID: <0c99b6aa-440a-44df-b875-a34e64465a04@redhat.com>
Date: Wed, 9 Jul 2025 21:22:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/20] hw/pci: Introduce pci_device_get_viommu_cap()
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-3-zhenzhong.duan@intel.com>
 <aG26VBqzOnLAWC5z@Asurada-Nvidia>
 <01584206-e2c0-4881-aaf5-d6c552a30873@redhat.com>
 <aG7A8hxd1R4iVhGT@Asurada-Nvidia>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <aG7A8hxd1R4iVhGT@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 7/9/25 3:20 PM, Nicolin Chen wrote:
> On Wed, Jul 09, 2025 at 01:55:46PM -0400, Donald Dutile wrote:
>>>> +enum {
>>>> +    VIOMMU_CAP_STAGE1 = BIT_ULL(0),  /* stage1 page table supported */
>>>> +};
>>>
>>> Thanks for this work. I am happy to see that we can share the
>>> common code that allocates a NESTING_PARENT in the core using
>>> this flag.
>>>
>>> Yet on ARM, a STAGE1 page table isn't always a nested S1, the
>>> hardware accelerated one. More often, it can be just a regular
>>> 1-stage translation table via emulated translation code and an
>>> emulated iotlb.
>>>
>> Because the user-created smmuv3 started as 'accelerated smmuv3',
>> and had been 'de-accelerated' to simply 'user created smmuv3',
>> I'm looking for some clarification in the above statement/request.
>>
>> Is the above suppose to reflect that a nested IOMMU has some hw-acceleration
>> in its Stage1 implementation?
>> If so, then call it that: STAGE1_ACCEL.
>> If it's suppose to represent that an IOMMU has nested/2-stage support,
>> then the above is a valid cap;  -but-, having a nested/2-stage support IOMMU
>> doesn't necessarily mean its accelerated.
> 
> Well, there are an emulated "nested" mode and an hw-accelerated
> "nested" mode in the smmuv3 code, so we had to choose something
> like "accel" over "nested".
> 
> Here, on the other hand, I think the core using this CAP would
> unlikely care about an emulated "nested" mode in the individual
> vIOMMU..
> 
> So I suggested:
>       /* hardware-accelerated nested stage-1 page table support */
>      VIOMMU_CAP_NESTED_S1 = BIT_ULL(0),
> 
> which it should be clear IMHO.
> 
> If not, maybe go a bit further like "VIOMMU_CAP_HW_NESTED_S1"?
> 
> Thanks
> Nicolin
> 
If the distinction is hw-based s1 vs emulated-based s1, than
I'd prefer the use of VIOMMU_CAP_HW_NESTED_S1, and avoid the use
of 'accel'/'ACCEL' unless it is an explicitly stated 'acceleration'
feature/option in the SMMU spec.

Thanks,
- Don



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1D0C3ABA3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 18:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9TQM-0008LU-Ks; Mon, 28 Apr 2025 14:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1u9TQL-0008L1-Di
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 14:41:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1u9TQF-0000m0-Rb
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 14:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745865701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a6If9EO/h7rU4F1PikJSkICcwblsjKckeKQKcOucDD4=;
 b=f4vN98Q9E1wr4kNqRSDXCg+WgA0CzlJ1kDeMwCyAzL1A8RFQN3SKQV64Al7jb7h0rynmxu
 uUgWM0N+7WlJ3B2M6bu5UHnqVyq5qpvp8F0AIUTZSVpZhAhyP+h7UvTXtVu2vany8RwAxP
 WQAiuyvXrOv5b6SdfPnsSLC48lo2SyA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-jLJPXxhhMpKLR8nxHEDHTg-1; Mon, 28 Apr 2025 14:41:36 -0400
X-MC-Unique: jLJPXxhhMpKLR8nxHEDHTg-1
X-Mimecast-MFC-AGG-ID: jLJPXxhhMpKLR8nxHEDHTg_1745865696
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-47682f9e7b9so80933251cf.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 11:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745865696; x=1746470496;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a6If9EO/h7rU4F1PikJSkICcwblsjKckeKQKcOucDD4=;
 b=XreRssuHba1ZbcDkFIboDNfZg4UQDdbrBLSY9/SyGvSGuzelMLXP5/wUWdM3oeIXwi
 xNjq9LJHTgQ0w29URRBMZmR3B0a1s0SsAVXkpdLJ9AUIvGQwyrVL+NBchwfX3aRt9ZDm
 Y29QVGyfBYsob4YBn9zvjrQIL6ioWuNkUyQZa6sOOcp1APreZtT2nYZ2+9WxxXSdfw3u
 1BAOvTqPpZMk0zkAJRjNNeMqDzFZnxp/B5S9vAmi+4zhlGt/F4ckcE2u+427pBMLLlwG
 LZPPAm6hfDwRUF3krrkLJYXRQguS+LjauqeC+Z5mKBdw/RgC/cU5Bpmu7uIhDtt0Jiiu
 YBng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkVv3Vng9TmUQyQT4cTgt+r+p5tLCS0bmSns+70f83zlNMCn5J5diRbVIzcweAj4Cvb/6y13SzpsoI@nongnu.org
X-Gm-Message-State: AOJu0Yw0+h8cr4zJ0UCKcgmmWRzFTKHlR3UifdBrobPgnxSgW5o4I7f6
 j2i5hLuQ2yuf6lCcHce4Fh19/U+Djo97AP75dfnES6oD3aRR2coE/YCd4TU5W5Z1/n2/eGuGluF
 42Kj3/WGcDEC1Cq89ophyWTWboKNEwrk/MdbNoaLWCl/Bsf/Fzoa0
X-Gm-Gg: ASbGncsrMJLh0XGel10ZiL6/kj7U/b2yRsx4An/bicSe89xL1zMBXY5/KC2ZdQKFOHv
 MY0FXadg4gUlkGkfSfhGYLVCneFBxRNdhESGYr3X5Xi3DhXpjKFtcM9GllMRPBPkWpqgVLwSqlG
 +rGq77J22aFn+n49NDxZv1miN4LYGWwBZLGbRuUM+vUhEX05fKwdPz19Xum3TrJ0TZUpJU6Rif6
 Pb69QlxqWd+kLwDRSvJX84HB3PG4mGZvMj3rklFSJWSwG+cOBolXfZ80LDZvWYxoESGIJUjzLrC
 0GCDR1D3IqWU
X-Received: by 2002:ac8:5889:0:b0:476:790c:739a with SMTP id
 d75a77b69052e-48131806878mr181232251cf.20.1745865695710; 
 Mon, 28 Apr 2025 11:41:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJkaINtSkVOIKeN8hk1V3O1vPYoZYGzD8z+JAvkfOzcO2zJuozhrnyThY1o//oOVJZcUGXcg==
X-Received: by 2002:ac8:5889:0:b0:476:790c:739a with SMTP id
 d75a77b69052e-48131806878mr181231821cf.20.1745865695227; 
 Mon, 28 Apr 2025 11:41:35 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4811f9bafdasm44820691cf.50.2025.04.28.11.41.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 11:41:34 -0700 (PDT)
Message-ID: <7446ba2c-0dbb-44dc-9e48-300f431dcf85@redhat.com>
Date: Mon, 28 Apr 2025 14:41:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add support for user creatable SMMUv3 device
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20250415081104.71708-1-shameerali.kolothum.thodi@huawei.com>
 <84870c74-f078-48c5-bead-96db1d582987@redhat.com>
 <8f7cc59e3745407bb7ae3d875cf97ae0@huawei.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <8f7cc59e3745407bb7ae3d875cf97ae0@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 4/22/25 4:57 AM, Shameerali Kolothum Thodi wrote:
> 
>> -----Original Message-----
>> From: Donald Dutile <ddutile@redhat.com>
>> Sent: Friday, April 18, 2025 9:34 PM
>> To: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>> qemu-devel@nongnu.org
>> Cc: eric.auger@redhat.com; peter.maydell@linaro.org; jgg@nvidia.com;
>> nicolinc@nvidia.com; berrange@redhat.com; nathanc@nvidia.com;
>> mochs@nvidia.com; smostafa@google.com; Linuxarm
>> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
>> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
>> Subject: Re: [PATCH 0/5] Add support for user creatable SMMUv3 device
>>
>> Shameer,
>> Hi!
>>
>> First off, like the partitioning of these pieces.
>>
>> On 4/15/25 4:10 AM, Shameer Kolothum wrote:
>>> Hi All,
>>>
>>> This patch series introduces support for a user-creatable SMMUv3 device
>>> (-device arm-smmuv3-dev) in QEMU.
>>>
>> Can we drop the '-dev', as 'arm-smmu' is sufficient, as is '-device'?
>>
>> I know, internal to QEMU, there's already an ARM_SMMU, but as suggested
>> later,
>> if it uses the same struct, the qemu cmdline syntax is a bit less redundant.
> 
> Trust me I tried that😊. The problem is that, the legacy one doesn't have a bus
> associated with it and the moment we change that and have bus specified for the
>   "-device arm-smmuv3, bus=pcie.0" the legacy smmuv3 creation in virt,
> 
> create_smmu() --> qdev_new(TYPE_ARM_SMMUV3)
> 
> will fails as it expects the bus type to be specified for it. I couldn't find a way
> to solve that.
> 
I guessed that's why there was new syntax for what is basically an extension of previous syntax.
I'll dig more into it and see if there's a way to handle it.
qemu does handle varying added params (id=blah, no id=blah),
so I'm researching how that's done, to figure out how the legacy, smmu-for-all,
and the smmu-for-specific pcie<RC> can both be supported.
Given your stated trials and tribulations, this should be fun. ;-)
- Don

>>
>>> The implementation is based on feedback received from the RFCv2[0]:
>>> "hw/arm/virt: Add support for user-creatable accelerated SMMUv3"
>>>
>>> Currently, QEMU's SMMUv3 emulation (iommu=smmuv3) is tied to the
>> machine
>>> and does not support instantiating multiple SMMUv3 devices—each
>> associated
>>> with a separate PCIe root complex. In contrast, real-world ARM systems
>>> often include multiple SMMUv3 instances, each bound to a different PCIe
>>> root complex.
>>>
>>> This also lays the groundwork for supporting accelerated SMMUv3, as
>>> proposed in the aforementioned RFC. Please note, the
>> accelerated SMMUv3
>>> support is not part of this series and will be sent out as a separate
>>> series later on top of this one.
>>>
>>> Summary of changes:
>>>
>>>    -Introduces support for multiple -device arm-smmuv3-dev,bus=pcie.x
>>>     instances.
>>>
>>>     Example usage:
>>>
>>>     -device arm-smmuv3-dev,bus=pcie.0
>>>     -device virtio-net-pci,bus=pcie.0
>>>     -device pxb-pcie,id=pcie.1,bus_nr=2
>>>     -device arm-smmuv3-dev,bus=pcie.1
>>>     -device pcie-root-port,id=pcie.port1,bus=pcie.1
>>>     -device virtio-net-pci,bus=pcie.port1
>>>
>>>     -Supports either the legacy iommu=smmuv3 option or the new
>>>     "-device arm-smmuv3-dev" model.
>>>
>> nice! :)
>> Can it support both? i.e., some devices using a system-wide, legacy
>> smmuv3,
>> and some pcie devices using the -device arm-smmuv3 ?
> 
> Please see my reply to patch #2. In short No, it doesn't support both.
> 
> Also I think we should slowly deprecate the use of legacy SMMUv3 going
> forward unless there is a strong use case/reason to support it.
> 
>> If not, then add a check to min-warn or max-fail, that config.
>> I can see old machines being converted/upgraded to new machines,
>> and they will want to switch from legacy->device smmuv3, and catching
>> an edit/update to a machine change (or enabling automated conversion)
>> would be helpful.
> 
> Please see Patch #4. It already checks and prevents if incompatible SMMUv3
> types are specified. Or is the suggestion here is to add something extra?
> Please let me know.
> 
> Thanks,
> Shameer
> 



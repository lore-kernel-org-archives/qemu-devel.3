Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386BAC83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 17:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZZ1V-0003z5-JZ; Wed, 09 Jul 2025 13:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uZZ1O-0003yb-Ra
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 13:55:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uZZ1N-0002nE-4J
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 13:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752083751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3BznBhB2VCjk9rrZ8Zl6SRBMtxHR7F0M6WbwXzJWD00=;
 b=fd+93Xf57UZBUXIMRQObvFWiO6zZKnDymrDU5UbwgH3QZolo+iYy4/THoDxTCXDnF5tC1n
 8caY+GlUhW03BgY89zmkSjhkKK6CCdswQkGd/glr85HZK3dv/gsXfm29hANBOG40Mr/HIU
 gG9QIChLQ1Dx6i8X4evx9FJs9ZxML3o=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-xGAFwQBIMPS1FJKe4JFx3g-1; Wed, 09 Jul 2025 13:55:49 -0400
X-MC-Unique: xGAFwQBIMPS1FJKe4JFx3g-1
X-Mimecast-MFC-AGG-ID: xGAFwQBIMPS1FJKe4JFx3g_1752083749
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7d460764849so220011385a.1
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 10:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752083749; x=1752688549;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3BznBhB2VCjk9rrZ8Zl6SRBMtxHR7F0M6WbwXzJWD00=;
 b=wrN1JHJ8W4ZfWwKkcDhvIKXgo6KQDJMd8T6fWak1MBL6Z/PGXRwyvEtTejHqF2YtF9
 3eDDic1HT+iYSrJqUxborImtvoDwO0qJlJ3VUgP2wpGRInhheTdbRqoeQmkaLvSB65o2
 e8DjNJad7EScK16u2hAO5Ev5qZmUc9PG7ZsEXhttFpRU6ACpmlwNca6aD+7CPu1kJ1Df
 UZjqZyNMDPF7AUSSOF9tJZrcO7V6qkbEs2yauvd3hmRoTa5jhTt1q2A5OXd6dl5uUH+3
 jJYWqHWImWxfgQIOlpVuS4BLhJK67L2bEwLR8HVyNkr/Kr2B0rtdnqy+a4+iPM6iOHY5
 sDhg==
X-Gm-Message-State: AOJu0Yx0lJqkwPJNpylc35dl5KkJ89WSBhZyacqbQInvJWrT1Z/R8wT5
 0o0wOoveitHW/mMdw5ya43BxGVfiXU3JiAfsGbz1qicyub4WCzO8JRgrhSaU4CWlynNfUUcBsdT
 Wuyh4Q7tQyZH3sSX0FQlD/0WFEd+WlwYK9TC/6UDqL/49jCUle4clCNos
X-Gm-Gg: ASbGncutHnxBmHMokOwdvGSxU7RlpH0Zhct/IJ62TzjD2gMriepdjC6U2mmVTpoYa8k
 3TVF1bACH05b9LMGnr/EF5ixZd3J2tGXkV8eumI8Wx1lZFLlmdD8qEgbA2IWzmkMh36pQRAoywP
 e0Y6mhsH63FTRELQTOaTvqu7msjf1whNA9tIn4f23cgVBumtx1diaB6oNlDgdbwuAuaYsCjIDn4
 rEmHfPDJFLVD4F7HSpAZnr2fV9klBrCampiSREOiqhP5EnIaiiCsm5dPnrRRvFuVz98RQeUdHj1
 Trf0cn1h8Bk5JvbFFn5QUGg=
X-Received: by 2002:a05:622a:230b:b0:4a4:2fd6:90b7 with SMTP id
 d75a77b69052e-4a9e9cd8589mr5732941cf.17.1752083749185; 
 Wed, 09 Jul 2025 10:55:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6EpX3Sw0s8jIsdyBPDf75ZN/LNVdeWPNO6Sp49Va5PEtvpZm4D60pPRoM6/TinkXfgx7S2Q==
X-Received: by 2002:a05:622a:230b:b0:4a4:2fd6:90b7 with SMTP id
 d75a77b69052e-4a9e9cd8589mr5732521cf.17.1752083748545; 
 Wed, 09 Jul 2025 10:55:48 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a995841539sm98077701cf.53.2025.07.09.10.55.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 10:55:48 -0700 (PDT)
Message-ID: <01584206-e2c0-4881-aaf5-d6c552a30873@redhat.com>
Date: Wed, 9 Jul 2025 13:55:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/20] hw/pci: Introduce pci_device_get_viommu_cap()
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 eric.auger@redhat.com, mst@redhat.com, jasowang@redhat.com,
 peterx@redhat.com, jgg@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-3-zhenzhong.duan@intel.com>
 <aG26VBqzOnLAWC5z@Asurada-Nvidia>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <aG26VBqzOnLAWC5z@Asurada-Nvidia>
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



On 7/8/25 8:39 PM, Nicolin Chen wrote:
> On Tue, Jul 08, 2025 at 07:05:43AM -0400, Zhenzhong Duan wrote:
>> diff --git a/include/hw/iommu.h b/include/hw/iommu.h
>> new file mode 100644
>> index 0000000000..e80aaf4431
>> --- /dev/null
>> +++ b/include/hw/iommu.h
>> @@ -0,0 +1,16 @@
>> +/*
>> + * General vIOMMU capabilities, flags, etc
>> + *
>> + * Copyright (C) 2025 Intel Corporation.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef HW_IOMMU_H
>> +#define HW_IOMMU_H
>> +
>> +enum {
>> +    VIOMMU_CAP_STAGE1 = BIT_ULL(0),  /* stage1 page table supported */
>> +};
> 
> Thanks for this work. I am happy to see that we can share the
> common code that allocates a NESTING_PARENT in the core using
> this flag.
> 
> Yet on ARM, a STAGE1 page table isn't always a nested S1, the
> hardware accelerated one. More often, it can be just a regular
> 1-stage translation table via emulated translation code and an
> emulated iotlb.
> 
Because the user-created smmuv3 started as 'accelerated smmuv3',
and had been 'de-accelerated' to simply 'user created smmuv3',
I'm looking for some clarification in the above statement/request.

Is the above suppose to reflect that a nested IOMMU has some hw-acceleration
in its Stage1 implementation?
If so, then call it that: STAGE1_ACCEL.
If it's suppose to represent that an IOMMU has nested/2-stage support,
then the above is a valid cap;  -but-, having a nested/2-stage support IOMMU
doesn't necessarily mean its accelerated.

So, let's ensure terminology, esp. bit-macro names(pace) reflects
the (exact) meaning, and not any indirect meaning.

A recent kvm-arm email thread had such indirect naming cleaned up
when referring to pfn-map/device-map/struct-page-mapped pages, which
I'd like not to start down a similar mis-naming/indirect-naming path here.

Look forward to the clarification.
- Don

> I think this flag should indicate that the vIOMMU supports a
> HW-accelerated nested S1 HWPT allocation/invalidation.
> 
> So, perhaps:
>      /* hardware-accelerated nested stage-1 page table support */
>      VIOMMU_CAP_NESTED_S1 = BIT_ULL(0),
> ?
> 
> Nicolin
> 



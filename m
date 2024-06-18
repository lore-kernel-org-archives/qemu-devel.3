Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB10C2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 11:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJWvL-000872-Ee; Tue, 18 Jun 2024 07:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJWvK-00086o-3f
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:22:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJWvI-0006s8-FD
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718709767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CX9jhsD3yIhJB3sf9Ojmv7T6fPjqFPyjj0blbbEBoao=;
 b=X4zHa5v8QkaivypaeCF7pft0pXjLaUuSOpWvttHg3+UQhlYq6Qm8CZT+UJ+kd+hjk+EdMO
 M1BH+HvEyfm8gS+Y+ns05TuH1Xe8PjTZ06W0SQOfNAdJe3akot81a4UJsXnAVWEDYeByx/
 dDQ0n3sThk+KWucBSQK/rBC3dsjsPO0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-1KlopZGTOKSJjb3Yec1Tvg-1; Tue, 18 Jun 2024 07:22:46 -0400
X-MC-Unique: 1KlopZGTOKSJjb3Yec1Tvg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-362c8b9a09cso18648f8f.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 04:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718709765; x=1719314565;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CX9jhsD3yIhJB3sf9Ojmv7T6fPjqFPyjj0blbbEBoao=;
 b=DzgawWHT/GMWDoutfcHLQZWgbqajywvhBd+r3j8a8KdrqdbcDQeQPtnCS9Je8jf9QH
 zkska+D5SJaEaSIhFM4y7sIRxV/90fQ6NoO6ZHAa4ieMq4/W6EmB1OgZoz0mHDYPKUI2
 bLCxLeCt0fwzDJUXZAZFHhPWFN3OaGNm8wulVfWa7CkOPggkQNfEhrR1V4Kx7w/hrhnZ
 ndQ/SwWWbUHy7LE2kUilSGQ9beNVDoR9XFch6dmxNak+ZLa1J+21qXFbj/nECeoRRmhf
 vqBoE0yVpS+9h2+zMswlBt+3wsgaxK498DjBt8tZfDBdSK3DRq6k28wzc44PEUD/a/Fg
 5QAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWncRKPlEJ0JoUq3HkzCs0B26EoBmurlqG5eLV3rnaWVDswY0394LrDgfHyNjnLVvkpVTm7B41Imof4+Dy2H+uZmQPE+DI=
X-Gm-Message-State: AOJu0Yxpj527dwBi/O6FLbEM/8xpWBJOGVCKPlsW1T3Rvji4XnJ5F+BY
 MG4RnlUgh80uIgkwiLLzg0gLAh0kyknlEjlqj8HnGiINbxXNKmqMGejR5ED4IaYALQFBHbxwBSv
 XdrSGG28trJbXrYR+fjdQaKnhJa07PTj3pc3BmHKP6bTqdPEGkBek
X-Received: by 2002:a05:6000:1815:b0:35f:1857:e363 with SMTP id
 ffacd0b85a97d-3607a77fa5emr8619360f8f.44.1718709764971; 
 Tue, 18 Jun 2024 04:22:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwyAPB89qNDmTuaiMigsrVHg76Tic8Ri0ucbFCo9KoZ138x4ixJuFrE4MgpMEU/eFjNQw+gg==
X-Received: by 2002:a05:6000:1815:b0:35f:1857:e363 with SMTP id
 ffacd0b85a97d-3607a77fa5emr8619349f8f.44.1718709764575; 
 Tue, 18 Jun 2024 04:22:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3609aa60a59sm3267858f8f.84.2024.06.18.04.22.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 04:22:44 -0700 (PDT)
Message-ID: <fecee4bd-edfb-49e4-b901-9511a54300a9@redhat.com>
Date: Tue, 18 Jun 2024 13:22:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/17] vfio/common: Extract vIOMMU code from
 vfio_sync_dirty_bitmap()
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
References: <20240617063409.34393-1-clg@redhat.com>
 <20240617063409.34393-5-clg@redhat.com>
 <b02d50c5-7cb8-4903-9c12-f7ec9c29151e@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <b02d50c5-7cb8-4903-9c12-f7ec9c29151e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/17/24 4:00 PM, Eric Auger wrote:
> Hi Cédric,
> 
> On 6/17/24 08:33, Cédric Le Goater wrote:
>> From: Avihai Horon <avihaih@nvidia.com>
>>
>> Extract vIOMMU code from vfio_sync_dirty_bitmap() to a new function and
>> restructure the code.
>>
>> This is done in preparation for optimizing vIOMMU deviice dirty page
> device

fixed.


>> tracking. No functional changes intended.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> [ clg: - Rebased on upstream ]
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   hw/vfio/common.c | 63 +++++++++++++++++++++++++++++-------------------
>>   1 file changed, 38 insertions(+), 25 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index fe215918bdf66ddbe3c5db803e10ce1aa9756b90..f28641bad5cf4b71fcdc0a6c9d42b24c8d786248 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1302,37 +1302,50 @@ vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainerBase *bcontainer,
>>                                                   &vrdl);
>>   }
>>   
>> +static int vfio_sync_iommu_dirty_bitmap(VFIOContainerBase *bcontainer,
>> +                                        MemoryRegionSection *section)
>> +{
>> +    VFIOGuestIOMMU *giommu;
>> +    bool found = false;
>> +    Int128 llend;
>> +    vfio_giommu_dirty_notifier gdn;
>> +    int idx;
>> +
>> +    QLIST_FOREACH(giommu, &bcontainer->giommu_list, giommu_next) {
>> +        if (MEMORY_REGION(giommu->iommu_mr) == section->mr &&
>> +            giommu->n.start == section->offset_within_region) {
>> +            found = true;
>> +            break;
>> +        }
>> +    }
>> +
>> +    if (!found) {
>> +        return 0;
>> +    }
>> +
>> +    gdn.giommu = giommu;
>> +    idx = memory_region_iommu_attrs_to_index(giommu->iommu_mr,
>> +                                             MEMTXATTRS_UNSPECIFIED);
>> +
>> +    llend = int128_add(int128_make64(section->offset_within_region),
>> +                       section->size);
>> +    llend = int128_sub(llend, int128_one());
>> +
>> +    iommu_notifier_init(&gdn.n, vfio_iommu_map_dirty_notify, IOMMU_NOTIFIER_MAP,
>> +                        section->offset_within_region, int128_get64(llend),
>> +                        idx);
>> +    memory_region_iommu_replay(giommu->iommu_mr, &gdn.n);
>> +
>> +    return 0;
> if this does not return anything else than 0, shouldn't it be void?

Yes it could. The return value is practical for the caller below though. Let's
keep it that way for now, it's harmless.


Thanks,

C.


> 
> Thanks
> 
> Eric
>> +}
>> +
>>   static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
>>                                     MemoryRegionSection *section, Error **errp)
>>   {
>>       ram_addr_t ram_addr;
>>   
>>       if (memory_region_is_iommu(section->mr)) {
>> -        VFIOGuestIOMMU *giommu;
>> -
>> -        QLIST_FOREACH(giommu, &bcontainer->giommu_list, giommu_next) {
>> -            if (MEMORY_REGION(giommu->iommu_mr) == section->mr &&
>> -                giommu->n.start == section->offset_within_region) {
>> -                Int128 llend;
>> -                vfio_giommu_dirty_notifier gdn = { .giommu = giommu };
>> -                int idx = memory_region_iommu_attrs_to_index(giommu->iommu_mr,
>> -                                                       MEMTXATTRS_UNSPECIFIED);
>> -
>> -                llend = int128_add(int128_make64(section->offset_within_region),
>> -                                   section->size);
>> -                llend = int128_sub(llend, int128_one());
>> -
>> -                iommu_notifier_init(&gdn.n,
>> -                                    vfio_iommu_map_dirty_notify,
>> -                                    IOMMU_NOTIFIER_MAP,
>> -                                    section->offset_within_region,
>> -                                    int128_get64(llend),
>> -                                    idx);
>> -                memory_region_iommu_replay(giommu->iommu_mr, &gdn.n);
>> -                break;
>> -            }
>> -        }
>> -        return 0;
>> +        return vfio_sync_iommu_dirty_bitmap(bcontainer, section);
>>       } else if (memory_region_has_ram_discard_manager(section->mr)) {
>>           int ret;
>>   
> 



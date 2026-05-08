Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C923ECD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 14:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMOg-0003iu-2t; Fri, 08 May 2026 10:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wLMOc-0003e2-NC
 for qemu-devel@nongnu.org; Fri, 08 May 2026 10:41:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wLMOa-0008K5-Ud
 for qemu-devel@nongnu.org; Fri, 08 May 2026 10:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778251298;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QMvTddc/VGWLyfpaUwEcPvWkVtZm0XQqNkM5eCiBseQ=;
 b=U9eVXZj6SnpJI+5L2FVriNpmQvwnbAgEqHO1AgCXq9uFx8Bwf+SGHpELL6wmEyr+ezAWJu
 kynJ/MGT9cD6fEVMad2GtA1WTQRBRG5Vtn/cwTaiiCBTwUWONrDgIWSoin0VtRr7Rv97SG
 JYIdWSPAiIRm3+XfRvAM8hwZAOX/weg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-LESKHyKpNr21rbSK6sFSdA-1; Fri, 08 May 2026 10:41:37 -0400
X-MC-Unique: LESKHyKpNr21rbSK6sFSdA-1
X-Mimecast-MFC-AGG-ID: LESKHyKpNr21rbSK6sFSdA_1778251296
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488d1b5bca0so10533275e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 07:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778251296; x=1778856096;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QMvTddc/VGWLyfpaUwEcPvWkVtZm0XQqNkM5eCiBseQ=;
 b=qS1IFronow3LnnROdGaWWU28aYilAsKqkr/TstHs1SU5+pVoi71xjJCFnN/AtPI7Db
 2nX+pom011794vfiZZcGAPjbFJqSn1wWwYgPYKHF6G4zlFMEY/6lTR6nlZVdeScVShFz
 aZMmowK8wCCkaW3RKV7rvzEqF7y2EHYrs3qr2Jrk+035BuFUV2Hn9/u9hsVlcyb2nx4k
 OswZetQT1rcnQP2asJMifRhkMDvY9kw3jXiWB8SFqXsCQfMhoEthwI28OU5aX6mQpfvS
 n7jFEIvjI9m6/bxC3OoXsvL0mtp9Qh9IhFMI47g5goLGk5eLnpCmn53wte527LY534e+
 uwwQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8YtqtyVnx0VojWpTqRp/FsQ6m++I1AJuSSVmkdxUe7MfSUbDse1CZheasX9xTz86DtG0ZYf/4oYFI7@nongnu.org
X-Gm-Message-State: AOJu0Yxw5iGziGdBAAEPpahYmYVZzSBctWUQOKm6T0ygHv0hhnbvC3y/
 7V+drFlNxXvqtYV8ZfAdZNPvu+aGQ2PaULJatyciZiKAqXy9NUT+QObiM5lSuw9bes111AvO9Ck
 PxOpXzFqjF45CWox5k7Y/SsthMxzVDuUtx8Ceje7fKVk+aUTzaOFr02Jg
X-Gm-Gg: AeBDieuBL+0KJ7LwaXpkfwgeMbdezgi3vvqWra73fVf2WD8cYBcyscrWDv+wDf/qmhN
 DKTjoxBEtIp+HnkAxQl/vXiZgwASJHZfOfHbKKsUMPyf0/SQZEQMx25OGPkxihm5gi+OVW/1UEm
 Y+XWByCfvNn7TlkKsu0LDUQgbZIGiKi4Ps6ZFPxRqJdf6USg60A+1/Oj79oYFa1/43Z2xdzLnqm
 XBeNdGyp/lWJzYfuofNqCnSMZ+LzVdb5aOSoTsxQPIAn20pTqGKw5MAgKj4FjfAOesay6WwLzxp
 U3iqeQDsLZGG2q1+tV0QeNDlx13N24qMC8RqK0/TP2BKbDaoXGvKHe8BLAY3usKOGZOvAzqF7Ws
 ro6K+l1oqjTTmbVvUIWLNW8PVcYrxx4iEs1WNp3VfV1wACjLmabns/kAFbGIHYHPtiGqPWg==
X-Received: by 2002:a05:600d:8:b0:48a:58ae:993b with SMTP id
 5b1f17b1804b1-48e676a4e03mr47460625e9.16.1778251296343; 
 Fri, 08 May 2026 07:41:36 -0700 (PDT)
X-Received: by 2002:a05:600d:8:b0:48a:58ae:993b with SMTP id
 5b1f17b1804b1-48e676a4e03mr47460285e9.16.1778251295973; 
 Fri, 08 May 2026 07:41:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e68f5d9b5sm39186385e9.15.2026.05.08.07.41.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 07:41:35 -0700 (PDT)
Message-ID: <2ec140e8-d862-466a-9061-f9175b2a846b@redhat.com>
Date: Fri, 8 May 2026 16:41:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 26/31] hw/arm/tegra241-cmdqv: Limit queue size based on
 backend page size
Content-Language: en-US
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, "phrdina@redhat.com"
 <phrdina@redhat.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-27-skolothumtho@nvidia.com>
 <e7a172be-41b4-40c8-8b1b-2814450d110a@redhat.com>
 <IA0PR12MB75555AF6ED6EF19543546F04AB3D2@IA0PR12MB7555.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <IA0PR12MB75555AF6ED6EF19543546F04AB3D2@IA0PR12MB7555.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 5/8/26 3:38 PM, Shameer Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 07 May 2026 18:24
>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; clg@redhat.com; alex@shazbot.org; Nicolin
>> Chen <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt
>> Ochs <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
>> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
>> zhenzhong.duan@intel.com; Krishnakant Jaju <kjaju@nvidia.com>;
>> phrdina@redhat.com
>> Subject: Re: [PATCH v4 26/31] hw/arm/tegra241-cmdqv: Limit queue size
>> based on backend page size
>>
>> External email: Use caution opening links or attachments
>>
>>
>> Hi Shameer,
>>
>> On 4/15/26 12:55 PM, Shameer Kolothum wrote:
>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>
>>> CMDQV HW reads guest queue memory in its host physical address setup via
>>> IOMMUFD. This requires the guest queue memory is not only contiguous in
>>> guest PA space but also in host PA space. With Tegra241 CMDQV enabled,
>> we
>>> must only advertise a CMDQS that the host can safely back with physically
>> s/a CMDQS/ a command queue size (CMDQS)
>>> contiguous memory. Allowing a queue larger than the host page size could
>> a queue size
>>> cause the hardware to DMA across page boundaries, leading to faults.
>>>
>>> Walk the RAMBlock list to find the smallest memory-backend page size, then
>>> limit IDR1.CMDQS so the guest cannot configure a command queue that
>> exceeds
>> what is the minimal CMDQS required?
> AFAICS, spec doesn't specify a minimum. But in practical terms I think,
> it will be 4K page size(CMDQS=8).

OK
>
>>> that contiguous backing. Fall back to the real host page size if no
>>> memory-backend RAM blocks are found.
>>>
>>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> ---
>>>  hw/arm/tegra241-cmdqv.c | 41
>> +++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 41 insertions(+)
>>>
>>> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
>>> index af68add2f0..2870886783 100644
>>> --- a/hw/arm/tegra241-cmdqv.c
>>> +++ b/hw/arm/tegra241-cmdqv.c
>>> @@ -14,6 +14,9 @@
>>>  #include "hw/arm/smmuv3.h"
>>>  #include "hw/core/irq.h"
>>>  #include "smmuv3-accel.h"
>>> +#include "smmuv3-internal.h"
>>> +#include "system/ramblock.h"
>>> +#include "system/ramlist.h"
>>>  #include "tegra241-cmdqv.h"
>>>  #include "trace.h"
>>>
>>> @@ -646,9 +649,38 @@ free_viommu:
>>>      return false;
>>>  }
>>>
>>> +static size_t tegra241_cmdqv_min_ram_pagesize(void)
>> shouldn't we put that rather in system/physmem.c
>> there we also have qemu_ram_pagesize_largest() for instance
> Could do. But we may have to rename it differently compared to 
> qemu_ram_pagesize_largest() as we are checking the size among
> memory-backend RAM only.
>
> May be qemu_ram_backend_pagesize_min() ?

Yes sounds reasonable to me. Let's add the physmem.c maintainers in cc.

Eric
>
> Thanks,
> Shameer



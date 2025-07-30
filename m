Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D2EC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 15:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh8op-0006NU-7P; Wed, 30 Jul 2025 11:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uh7dm-0008Ir-6c
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 10:18:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uh7dj-0008B3-KX
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 10:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753885121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ClDIZV/QKpZ13qJPZviednqaYcCrNh2jIDyXdj6fGx8=;
 b=YUGm2vmgrMi0RhgIQpfzgBlbO2uetug2xDiulBtEnWI31QNsgv/euJb+GIjqeFKsFF2I6M
 1QLzI9HjxjnSYPni0PAJUct6jIClDHQ2S1RRCf3pyTQNdjld7kEn/2zmB5T6f7ZD+OTtM6
 M6VHiUhuItAgkSm9wt+XNHRqfPkQKFA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-Nb-ry3PXMHe3qfZgrmu21A-1; Wed, 30 Jul 2025 10:18:39 -0400
X-MC-Unique: Nb-ry3PXMHe3qfZgrmu21A-1
X-Mimecast-MFC-AGG-ID: Nb-ry3PXMHe3qfZgrmu21A_1753885118
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45896cf24fbso4305515e9.2
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 07:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753885118; x=1754489918;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ClDIZV/QKpZ13qJPZviednqaYcCrNh2jIDyXdj6fGx8=;
 b=cGmwbXxOoRP6xeMPpseCl7tTaDP6pNexViMNmS6fo2vlE0X6iOzSiqwv7frqg46iCx
 yr4nHkubsm0ED/f1DEzBRWuuHyqx/cFXr131DWUnIOhNIsiUbwcC/xNO2A+wazf3JDGQ
 SWt1OXxaUdtTM16zCKi3xlMfisfph2pTMhPH2UOngEUj9JEbtFAxXEZRqX6DoZFLAgJm
 Bny2PhGOPtdVpzxd1XlGsAu+klEbXoSdeIqjCPpAdlyVeQPAArUSecVIQxLjJJPN9fLv
 LXMYMqdaYZpwKWqk2nfY/+OG4P6mQlcsXVC1KKOzqpHkPoCgsSwEbwGZU2PLflAfVjRL
 Ta2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzN7lpy5YbezEAbhkYCGUan8dHUbyhKJFfEeIOP65Qor9cOn5YYRwVOk+qEDJxD8v/bEsQF2XFZ8Ir@nongnu.org
X-Gm-Message-State: AOJu0YwWNJrhk3d6CN2/i8H1lraxPKhjJMGxpQJBTMoqje1zWye0glL0
 DwBXS4HMn3L7OEiTFLqqhVr7NIfGQC7dJsCtgKDkd+ozeqycMrBu7gMLCsdTGeCHSUXishsIx1S
 dEV7As161lyo1xlCsaQhooIfJ3smuqbBCqQ5aINDwfH4ocBUJ7k12mWuf
X-Gm-Gg: ASbGncvlj7aq8yUBlok36f5dzmuzb2hMPFgi8uExIMaxfJdDmGCTOs0hd7P7Mk+ZutM
 TzJo/8q9uB8t4OIh2M5x0arD6MUxWiqhS5Pljj+H/3is6wO8Uk8Xr3LLTfWhHv5sMc940wK9nwm
 iMttxo/8oraSVkNWfr16dS/F4vIc+/Ds6T0BRHajMb88QQbpxEUNRoGidGLHU8HCIQ7Pn9fRS6V
 id4+JBLtoaCX5RMnPksxAqptwLP6uYobcfAW+zbQKLh1JLn3rXoZzGZh6NHiRHbuJs+3BzfWV+/
 CwaKRneFr/ZxDnlESUgplRtYyCbAZJhzhbDEDoez6b2yBrodct3jLIzTsCmn4XwKAuZ0MG1CQph
 vLM1y49Q=
X-Received: by 2002:a05:600c:3553:b0:455:f380:32e2 with SMTP id
 5b1f17b1804b1-45892bc58bamr37572695e9.18.1753885118245; 
 Wed, 30 Jul 2025 07:18:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ7ES9h1ppSZgNrXkVwUWJ8h0RyLw0YUBLstEATCTJo0q3B49OC+Wk9ifsywCS/izzhqLIyw==
X-Received: by 2002:a05:600c:3553:b0:455:f380:32e2 with SMTP id
 5b1f17b1804b1-45892bc58bamr37572265e9.18.1753885117726; 
 Wed, 30 Jul 2025 07:18:37 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:9004:d500:837f:93fd:c85e:5b97?
 ([2a01:cb19:9004:d500:837f:93fd:c85e:5b97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79718bc8esm1727097f8f.74.2025.07.30.07.18.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 07:18:37 -0700 (PDT)
Message-ID: <fc9c0197-e824-4bcc-b2ce-2855f3f9ee1d@redhat.com>
Date: Wed, 30 Jul 2025 16:18:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/20] vfio: Add a new element bypass_ro in
 VFIOContainerBase
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20250729092043.785836-1-zhenzhong.duan@intel.com>
 <20250729092043.785836-19-zhenzhong.duan@intel.com>
 <1ec1ad68-d6fc-41b1-8f62-5d1f9bdf3655@redhat.com>
 <IA3PR11MB9136F831BDBB3379EB3D86D49224A@IA3PR11MB9136.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <IA3PR11MB9136F831BDBB3379EB3D86D49224A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 7/30/25 12:58, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH v4 18/20] vfio: Add a new element bypass_ro in
>> VFIOContainerBase
>>
>> On 7/29/25 11:20, Zhenzhong Duan wrote:
>>> When bypass_ro is true, read only memory section is bypassed from
>>> mapping in the container.
>>>
>>> This is a preparing patch to workaround Intel ERRATA_772415.
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    include/hw/vfio/vfio-container-base.h |  1 +
>>>    hw/vfio/listener.c                    | 13 +++++++++----
>>>    2 files changed, 10 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/hw/vfio/vfio-container-base.h
>> b/include/hw/vfio/vfio-container-base.h
>>> index bded6e993f..31fd784d76 100644
>>> --- a/include/hw/vfio/vfio-container-base.h
>>> +++ b/include/hw/vfio/vfio-container-base.h
>>> @@ -51,6 +51,7 @@ typedef struct VFIOContainerBase {
>>>        QLIST_HEAD(, VFIODevice) device_list;
>>>        GList *iova_ranges;
>>>        NotifierWithReturn cpr_reboot_notifier;
>>> +    bool bypass_ro;
>>>    } VFIOContainerBase;
>>>
>>>    typedef struct VFIOGuestIOMMU {
>>> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
>>> index f498e23a93..c64aa4539e 100644
>>> --- a/hw/vfio/listener.c
>>> +++ b/hw/vfio/listener.c
>>> @@ -364,7 +364,8 @@ static bool
>> vfio_known_safe_misalignment(MemoryRegionSection *section)
>>>        return true;
>>>    }
>>>
>>> -static bool vfio_listener_valid_section(MemoryRegionSection *section,
>>> +static bool vfio_listener_valid_section(VFIOContainerBase *bcontainer,
>>> +                                        MemoryRegionSection
>> *section,
>>>                                            const char *name)
>>
>> Instead of adding a 'VFIOContainerBase *' argument, I would add an
>> extra 'bool bypass_ro' argument.
> 
> Done, see https://github.com/yiliu1765/qemu/commit/b0be8bfc9a899334819f3f4f0704e47116944a53

I don't think the extra 'bool bypass_ro' are useful. A part from that,
looks good.


Thanks,

C.


> Opportunistically, I also introduced another patch to bypass dirty tracking for readonly region, see https://github.com/yiliu1765/qemu/commit/a21ce0afd8aec5d5a9e6de46cf46757530cb7d9f




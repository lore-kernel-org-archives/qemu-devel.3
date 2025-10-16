Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055EDCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 16:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9QmO-0002E3-63; Thu, 16 Oct 2025 12:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v9QmM-0002Du-5T
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:24:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v9Qm9-0004Vw-F2
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760631860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UeUijJCsMdFTfNPxctORYr7ipajkJP3u46Bv+x4+gDM=;
 b=MTQtlvvvMlWYryxp6834/uP42+HafjBHPKe3nL9OciC6sDvdJYm3Kmr+lcQlZRMV307opc
 25UJ+oEML+Nb6E6aBT9Ec2vbLrOU60HoY/UnjGylW2ikLmab/RhfzMRO0wgmcmQJoZe6ug
 YUySrnThRxa9MLJ9D5kUCgE3HWKtOtI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-4u0rfyF5NLmOlHPT9EEO7w-1; Thu, 16 Oct 2025 12:24:18 -0400
X-MC-Unique: 4u0rfyF5NLmOlHPT9EEO7w-1
X-Mimecast-MFC-AGG-ID: 4u0rfyF5NLmOlHPT9EEO7w_1760631857
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42558f501adso542536f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 09:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760631857; x=1761236657;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UeUijJCsMdFTfNPxctORYr7ipajkJP3u46Bv+x4+gDM=;
 b=Y47SfbKEs7+KnKjQZhCtk+OiHsGWmYkpIWu0k/za4MNAMom72O1WJNax4IBjvuAIty
 bZmWoRhTfgLDMbDrjIu07qyJ9TmCz+LuSM5kd17F4ochrbIfUQg3LtTv1Fa5usH5JQqw
 HFaYnHcK9tt7LZMorBHbruxD/Qp599MYRAH0wb/fDIFKr6mAhU2qu/qKG0dybv8QfbZx
 Y0Tv3jmjwtwlT+gQuJRGHbKWNqDVMIWlEBWwS2qrUmpkD7AtJC6cqwxu8qIUGghiD3SW
 bYvu7/3cG/XndPIZ7yJmLsj/infmrbWdJ2/wJ7GTAv4wQvzdJrtn6PJvMV1M7JsrCThk
 /YqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsPPZcCdfrcaV0ibOYTNrUYpKpSNlSqhuYa2oq/HlKvUxBTuneTZ2z6NwpMtKLRvtEuMMWweL9RTiL@nongnu.org
X-Gm-Message-State: AOJu0YxvUJq7mTS49wdad1YwqfBbAXBrWjJ7HnrdBKIWooeZJfe2Z05D
 TtsyQsbUiLkvkJPhb7nttgZZCJzbhInbp2f7zbHbY2mhvKHvAtK+P6RNkXQiUI4EtoZw9QBZLsq
 zWvDEfdv72HxWePaVjV3DDsaczS64ZTZw2Zgq501EKigPtksuBcIB7YLs
X-Gm-Gg: ASbGncvZlEB8N6fGe6GGoFUMOdzbXuwLAxTDaw28uk/qfhUu0aMUzvjgJbfrmyEaPGn
 tCBDMNWYDiuFZMwnD8AJK7pLlz+YxhbxatHlay7RFITi9mdY+4XkH3SPSE3M+P37y32ZRHmlKvn
 UmEZIZB3arMGJNpA3LEZAQNqjv05iapseBLVYgk5ZJojaFVCtwv7+cy5fMDIXseWSvK1CrnkV8j
 WDvbrq9ADGklaeZhvS3e8Wlj0boJUUyf8n6HbbwwnN0NoIYN3i34ieI0Oxn+DJfz3EsvclyYyt+
 Ln0C9HB5fHas1gYdJIr7HY5FTw+7BPaSvpKd7AQaxzMdi9RViYXobqnwF6Y80LvljRiavCMOz3r
 tmZBwftEY7/vM6GVLIufwDUVdwfuWJdjKFFL+ug==
X-Received: by 2002:a05:6000:1446:b0:426:d55e:6cd6 with SMTP id
 ffacd0b85a97d-42704d94a3emr646753f8f.35.1760631857190; 
 Thu, 16 Oct 2025 09:24:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXCkcT5uZbfqc1hFyWUJbmtzP553lWmF5BtsRxIjQYSswy+BUvNeKVVTqbtHnC7u6HHV/OVA==
X-Received: by 2002:a05:6000:1446:b0:426:d55e:6cd6 with SMTP id
 ffacd0b85a97d-42704d94a3emr646720f8f.35.1760631856730; 
 Thu, 16 Oct 2025 09:24:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710ca4931csm28670185e9.0.2025.10.16.09.24.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 09:24:15 -0700 (PDT)
Message-ID: <808ebae7-27c8-49f1-9626-8ed9b7a1f4e7@redhat.com>
Date: Thu, 16 Oct 2025 18:24:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] intel_iommu: Optimize unmap_bitmap during migration
To: Yi Liu <yi.l.liu@intel.com>, "Duan, Zhenzhong"
 <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao, Xudong"
 <xudong.hao@intel.com>, "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
 "Gross, Mark" <mark.gross@intel.com>,
 "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
References: <20250910023701.244356-1-zhenzhong.duan@intel.com>
 <20250910023701.244356-5-zhenzhong.duan@intel.com>
 <bc51d154-be8e-47d7-abe7-bcb9f93a7348@intel.com>
 <DS4PPF93A1BBECD1A86879EBF071C6D09D792EAA@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
 <74930e82-62f7-4b4e-8bdc-217142586dd3@intel.com>
 <IA3PR11MB913676B74FF4A6B74F4959D992EBA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <f6317dfb-4f04-42e8-8350-b47004c64f70@intel.com>
 <IA3PR11MB9136AEE8F0C3A989C964E35092E8A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <9fabdf4a-a781-491a-bbd2-40e51462b8e7@intel.com>
 <IA3PR11MB9136B2CF78F1473BED36E1B492E9A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <cf67c96b-21f2-47eb-b693-704c5657a2a9@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <cf67c96b-21f2-47eb-b693-704c5657a2a9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/16/25 11:53, Yi Liu wrote:
> On 2025/10/16 16:48, Duan, Zhenzhong wrote:
>>
>>>>>>>>> how about an empty iova_tree? If guest has not mapped anything for
>>>>> the
>>>>>>>>> device, the tree is empty. And it is fine to not unmap anyting. While,
>>>>>>>>> if the device is attached to an identify domain, the iova_tree is empty
>>>>>>>>> as well. Are we sure that we need not to unmap anything here? It
>>> looks
>>>>>>>>> the answer is yes. But I'm suspecting the unmap failure will happen in
>>>>>>>>> the vfio side? If yes, need to consider a complete fix. :)
>>>>>>>>
>>>>>>>> Not get what failure will happen, could you elaborate?
>>>>>>>> In case of identity domain, IOMMU memory region is disabled, no
>>> iommu
>>>>>>>> notifier will ever be triggered. vfio_listener monitors memory address
>>>>>>> space,
>>>>>>>> if any memory region is disabled, vfio_listener will catch it and do dirty
>>>>>>> tracking.
>>>>>>>
>>>>>>> My question comes from the reason why DMA unmap fails. It is due to
>>>>>>> a big range is given to kernel while kernel does not support. So if
>>>>>>> VFIO gives a big range as well, it should fail as well. And this is
>>>>>>> possible when guest (a VM with large size memory) switches from
>>> identify
>>>>>>> domain to a paging domain. In this case, vfio_listener will unmap all
>>>>>>> the system MRs. And it can be a big range if VM size is big enough.
>>>>>>
>>>>>> Got you point. Yes, currently vfio_type1 driver limits unmap_bitmap to
>>> 8TB
>>>>> size.
>>>>>> If guest memory is large enough and lead to a memory region of more
>>> than
>>>>> 8TB size,
>>>>>> unmap_bitmap will fail. It's a rare case to live migrate VM with more than
>>>>> 8TB memory,
>>>>>> instead of fixing it in qemu with complex change, I'd suggest to bump
>>> below
>>>>> MACRO
>>>>>> value to enlarge the limit in kernel, or switch to use iommufd which
>>> doesn't
>>>>> have such limit.
>>>>>
>>>>> This limit shall not affect the usage of device dirty tracking. right?
>>>>> If yes, add something to tell user use iommufd backend is better. e.g
>>>>> if memory size is bigger than the limit of vfio iommu type1's dirty
>>>>> bitmap limit (query cap_mig.max_dirty_bitmap_size), then fail user if
>>>>> user wants migration capability.
>>>>
>>>> Do you mean just dirty tracking instead of migration, like dirtyrate?
>>>> In that case, there is error print as above, I think that's enough as a hint?
>>>
>>> it's not related to diryrate.
>>>
>>>> I guess you mean to add a migration blocker if limit is reached? It's hard
>>>> because the limit is only helpful for identity domain, DMA domain in guest
>>>> doesn't have such limit, and we can't know guest's choice of domain type
>>>> of each VFIO device attached.
>>>
>>> I meant a blocker to boot QEMU if there is limit. something like below:
>>>
>>>     if (VM memory > 8TB && legacy_container_backend &&
>>> migration_enabled)
>>>         fail the VM boot.
>>
>> OK, will add below to vfio_migration_realize() with an extra patch:
> 
> yeah, let's see Alex and Cedric's feedback.
> 
>>      if (!vbasedev->iommufd && current_machine->ram_size > 8 * TiB) {
>>          /*
>>           * The 8TB comes from default kernel and QEMU config, it may be
>>           * conservative here as VM can use large page or run with vIOMMU
>>           * so the limitation may be relaxed. But 8TB is already quite
>>           * large for live migration. One can also switch to use IOMMUFD
>>           * backend if there is a need to migrate large VM.
>>           */
> 
> instead of hard code 8TB. May convert cap_mig.max_dirty_bitmap_size to
> memory size. :)
yes. It would reflect better that it's a VFIO dirty tracking limitation.


Zhenzhong,

Soft freeze is w45. I plan to send a PR next week, w43, and I will be out
w44. I will have some (limited) time to address more changes on w45.

Thanks,

C.




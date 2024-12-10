Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72795E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 22:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL8Iq-0005qt-It; Tue, 10 Dec 2024 17:02:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tL8In-0005qf-Ux
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 17:01:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tL8Il-0001VZ-Ul
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 17:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733868113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=D9+GLwwyBTNYWf4yqWzbV14McIrIsBO4Jp/lNHdKvis=;
 b=HmAEhR/tirPmnxpLQtsIXyXmNXxSseezitEre0uGouG16jqL5hHLEAIWgqH40g8d/16jMx
 erAGdgztS9QkdiT6k+7PquBbcH6ywanSN9PubOU1s4dMsTjJYUswlItP7YOX0js6ielN0/
 c1OTpPhJGDmrtpWqK4QUV/QXcn9DB6M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-3JHuxigiMeOVKWBLMHK7Gg-1; Tue, 10 Dec 2024 17:01:52 -0500
X-MC-Unique: 3JHuxigiMeOVKWBLMHK7Gg-1
X-Mimecast-MFC-AGG-ID: 3JHuxigiMeOVKWBLMHK7Gg
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-434f02ea82dso29377475e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 14:01:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733868111; x=1734472911;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=D9+GLwwyBTNYWf4yqWzbV14McIrIsBO4Jp/lNHdKvis=;
 b=Wlu81CiQm8Pjqy92yvLagyedIjFC8p3schAnTHZQ87+w9MiWhvL5Zy1mZW3bUF8APK
 pa8Kwt8mRImA08Go+m5OZwvvkXsVhBVM1C5akCE2tiMhIHvAH6tqQR2YXWs1lD4IlDmb
 L6CGALAGKvSyafeS/kOKoPzov5n6EApa6tIwAwRM7/Z+CfWTGsgEyYK0d2yZ8tYlugsI
 cJrX+kYWXisLcept5hT6blKb2ao946yLOZGlAZMaWIerXrVXHYmUrPdpvgL/y1iW7Ybc
 A8PMn7rQAGs9XMrVDBFurxt1imj3YFvuex6cFrvZOLjLhEjcWrwymPY0XjKGAtPryIag
 Pg1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIlqK34TDUWDp+E6K4ZPNEOsn0Tny4vbGvabLZMj0gYZCbi/g1oigTftvKfi8YO5Ff/2bH8lQ/BPX/@nongnu.org
X-Gm-Message-State: AOJu0YygAyKQFVlSh3bFHfRnsyZ6IV0bgEoyAIL6d44emHgMQq4ShDuk
 KBGyU0+Uwnsq6fhi/DsNxhpP2bkVYJEH7O9RwpiwtE+0N/ouYU5mXuSjip1TSftRfHzIjs88HHl
 R4s74zWHYZLvK5KlAVlmFeoDJHOclldAzCkH6QG2hgf2bvG9vuBlv
X-Gm-Gg: ASbGnctQ17flEvabXr4a+CG15u+wqGTGoZt1ahg3rQTRnCramW/WYRux04pCSe4egg0
 3oPMTht9RG3hMYVfv4+op4DSAxBnd9AWCEayjl7955x2L1zOlSugTqDHnAqujqGyVjs8Bt0wLqX
 VdIpSyVWY57x8KKk0uPflWi+ZuVKckRNHx/8aJjNKX8/4y187LGojDewHp1WGRb1uT2AA34O7u9
 82tPybHq8JhxG9n0yZnSyrChAEE9kB8JxUgDr4q13JMloQ2BJ6F1o/a6SXFOaA6KUCgTD6c6c1D
 Pqd7KUunokDIJ0/ZlX9DOZXdx+26WKiM7s7EoV0vARwQwPRFAipU8Uz2SxHfqHHezRBhQ/ZsX6C
 rWieAow==
X-Received: by 2002:a05:6000:21c9:b0:386:3356:f3ac with SMTP id
 ffacd0b85a97d-3864ce9f37amr375529f8f.26.1733868111003; 
 Tue, 10 Dec 2024 14:01:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGp8CuUQPNHLeZTjQJhP12o1aeSxczWzCX7yiFcyZz4TsLWWeCMMqgK1dcnP7aF9hXQGtfesQ==
X-Received: by 2002:a05:6000:21c9:b0:386:3356:f3ac with SMTP id
 ffacd0b85a97d-3864ce9f37amr375520f8f.26.1733868110667; 
 Tue, 10 Dec 2024 14:01:50 -0800 (PST)
Received: from ?IPV6:2003:cb:c723:b800:9a60:4b46:49f9:87f3?
 (p200300cbc723b8009a604b4649f987f3.dip0.t-ipconnect.de.
 [2003:cb:c723:b800:9a60:4b46:49f9:87f3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434e8bb0390sm134100175e9.27.2024.12.10.14.01.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 14:01:49 -0800 (PST)
Message-ID: <7e9298da-79e2-43b6-a616-b1e1e1e1a883@redhat.com>
Date: Tue, 10 Dec 2024 23:01:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hostmem-file: add the 'hmem' option
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kraxel@redhat.com" <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20241204171114.20033-1-Zhigang.Luo@amd.com>
 <5d4019cd-a3fb-4bed-8bab-e0388ccffee7@redhat.com>
 <BL1PR12MB531759C282DC7A424CBC56E8F1312@BL1PR12MB5317.namprd12.prod.outlook.com>
 <ab889035-afa2-4a32-8a13-b8bd21b69fc7@redhat.com>
 <BL1PR12MB5317B47F9AF0068760239C8BF13D2@BL1PR12MB5317.namprd12.prod.outlook.com>
 <cbe5a04e-caac-4ddc-a7a4-6c6bf5b0fac8@redhat.com>
 <BL1PR12MB5317EAF52CFCABB96E05D538F13D2@BL1PR12MB5317.namprd12.prod.outlook.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <BL1PR12MB5317EAF52CFCABB96E05D538F13D2@BL1PR12MB5317.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 10.12.24 22:51, Luo, Zhigang wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: David Hildenbrand <david@redhat.com>
>> Sent: Tuesday, December 10, 2024 2:55 PM
>> To: Luo, Zhigang <Zhigang.Luo@amd.com>; qemu-devel@nongnu.org
>> Cc: kraxel@redhat.com; Igor Mammedov <imammedo@redhat.com>
>> Subject: Re: [PATCH] hostmem-file: add the 'hmem' option
>>
>> On 10.12.24 20:32, Luo, Zhigang wrote:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>> Hi David,
>>>
>>
>> Hi,
>>
>>>>>
>>>>> Thanks for your comments.
>>>>> Let me give you some background for this patch.
>>>>> I am currently engaged in a project that requires to pass the
>>>>> EFI_MEMORY_SP
>>>> (Special Purpose Memory) type memory from host to a virtual machine
>>>> within QEMU. This memory needs to be EFI_MEMORY_SP type in the
>>>> virtual machine as well.
>>>>> This particular memory type is essential for the functionality of my project.
>>>>
>>>> Which exact guest memory will be backed by this memory? All guest-memory?
>>> [Luo, Zhigang] not all guest-memory. Only the memory reserved for specific
>> device.
>>
>> Can you show me an example QEMU cmdline, and how you would pass that
>> hostmem-file object to the device?
>>
> [Luo, Zhigang] the following is an example. m1 is the reserved memory for pci device "0000:03:00.0". both the memory and pci device are set to same numa node.
> 
> -object memory-backend-ram,size=8G,id=m0 \
> -object memory-backend-file,size=16G,id=m1,mem-path=/dev/dax0.0,prealloc=on,align=1G,hmem=on \
> -numa node,nodeid=0,memdev=m0 -numa node,nodeid=1,memdev=m1 \

Okay, so you expose this memory as a second numa node, and want the 
guest to identify the second numa node as SP to not use it during boot.

Let me CC Jonathan, I am pretty sure he has an idea what to do here.

> -device pxb-pcie,id=pcie.1,numa_node=1,bus_nr=2,bus=pcie.0 \
> -device ioh3420,id=pcie_port1,bus=pcie.1,chassis=1 \
> -device vfio-pci,host=0000:03:00.0,id=hostdev0,bus=pcie_port1
> 
>>>
>>>>
>>>> And, what is the guest OS going to do with this memory?
>>> [Luo, Zhigang] the device driver in guest will use this reserved memory.
>>
>> Okay, so just like CXL memory.
>>
>>>
>>>>
>>>> Usually, this SP memory (dax, cxl, ...) is not used as boot memory.
>>>> Like on a bare metal system, one would expect that only CXL memory
>>>> will be marked as special and put aside to the cxl driver, such that
>>>> the OS can boot on ordinary DIMMs, such that cxl can online it etc.
>>>>
>>>> So maybe you would want to expose this memory using CXL-mem device to
>>>> the VM? Or a DIMM?
>>>>
>>>> I assume the alternative is to tell the VM on the Linux kernel
>>>> cmdline to set EFI_MEMORY_SP on this memory. I recall that there is a way to
>> achieve that.
>>>>
>>> [Luo, Zhigang] I know this option. but it requires the end user to know where is the
>> memory location in guest side(start address, size).
>>
>> Right.
>>
>>>
>>>
>>>>> In Linux, the SPM memory will be claimed by hmem-dax driver by
>>>>> default. With
>>>> this patch I can use the following config to pass the SPM memory to guest VM.
>>>>> -object
>>>>> memory-backend-file,size=30G,id=m1,mem-path=/dev/dax0.0,prealloc=on,
>>>>> al
>>>>> ign=1G,hmem=on
>>>>>
>>>>> I was thinking to change the option name from "hmem" to "spm" to
>>>>> avoid
>>>> confusion.
>>>>
>>>> Likely it should be specified elsewhere, that you want specific guest
>>>> RAM ranges to be EFI_MEMORY_SP. For a DIMM, it could be a property,
>>>> similarly maybe for CXL- mem devices (no expert on that).
>>>>
>>>> For boot memory / machine memory it could be a machine property. But
>>>> I'll first have to learn which ranges you actually want to expose
>>>> that way, and what the VM will do with that information.
>>> [Luo, Zhigang] we want to expose the SPM memory reserved for specific device.
>> And we will pass the SPM memory and the device to guest. Then the device driver
>> can use the SPM memory in guest side.
>>
>> Then the device driver should likely have a way to configure that, not the memory
>> backend.
>>
>> After all, the device driver will map it somehow into guest physical address space
>> (how?).
>>
> [Luo, Zhigang] from guest view, it's still system memory, but marked as SPM. So, qemu will map the memory to guest physical address space.
> The device driver just claims to use the SPM memory in guest side.
> 
>>>
>>>>
>>>>>
>>>>> Do you have any suggestions to achieve this more reasonable?
>>>>
>>>> The problem with qemu_ram_foreach_block() is that you would indicate
>>>> also DIMMs, virtio-mem, ... and even RAMBlocks that are not even used
>>>> for backing anything to the VM as EFI_MEMORY_SP, which is wrong.
>>> [Luo, Zhigang] qemu_ram_foreach_block() will list all memory block, but in
>> pc_update_hmem_memory(), only the memory block with "hmem" flag will be
>> updated to SPM memory.
>>
>> Yes, but imagine a user passing such a memory backend to a DIMM/virtio-mem/boot
>> memory etc. It will have very undesired side effects.
>>
> [Luo, Zhigang] the user should know what he/she is doing when he/she set the flag for the memory region.

No, we must not allow to create insane configurations that don't make 
any sense.

Sufficient to add:

-object memory-backend-file,size=16G,id=unused,mem-path=whatever,hmem=on

to the cmdline to cause a mess.


Maybe it should be a "numa" node configuration like

-numa node,nodeid=1,memdev=m1,sp=on

But I recall that we discussed something related with Jonathan, so I'm 
hoping we can get his input.

-- 
Cheers,

David / dhildenb



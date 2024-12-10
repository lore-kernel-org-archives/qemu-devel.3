Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529A4E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 19:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL6Jt-0006cb-UW; Tue, 10 Dec 2024 14:54:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tL6Jp-0006cC-Er
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 14:54:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tL6Jn-0005BH-UH
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 14:54:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733860491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=913+i+AdDm0zx6BASJNE2CHnV4GNy+xj58hIm8KyCwU=;
 b=TAmiA1uNSiVdXfLDq71AWqZcgspiczG8OrFjNGd3yvNvLP7YqkrMRgSQQ/PS+Qto+4avxs
 IIQm1oLGHn2uToU0IGU94o/xBgzarnC6ylJL2vIJ1Riybeiz26trtzmwzp8y3nLbxKfqhF
 bg4Z+w3xO0kIOGzzBlW993mAyXqlXHU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-waDxmPQ7NUuGZB9dUZun4w-1; Tue, 10 Dec 2024 14:54:48 -0500
X-MC-Unique: waDxmPQ7NUuGZB9dUZun4w-1
X-Mimecast-MFC-AGG-ID: waDxmPQ7NUuGZB9dUZun4w
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361ac607b6so3942225e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 11:54:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733860487; x=1734465287;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=913+i+AdDm0zx6BASJNE2CHnV4GNy+xj58hIm8KyCwU=;
 b=wQRy+dchY4aMh4kB2R9lvE/107+OWzvXcuWAqE4Ipb2qDnCoZ/w+wCeMLTtAbyZYqH
 K7Y89a6ceeRtwjBaVmgCaOzgOUVLF5f3qZ10PNFchbSdgXqPrCHudY42scJ1ed1O40X3
 bCmSQkHE8Nf7P/mfiR1GtpYT0sJ1sdkHmk+GPryqwjiqr4W3b3XB8N5lIvehK9/GlgCi
 /3KBdx13m7HHmLnF5/E0JlRr6s6HRr7Zu3UqFDs+kM17pu0trz0kM9NlLkJKOz4W3/Lf
 JWAAT6jLuGhLkDK/kbOjClgqY5Z/o5ap85tlsIubnpgy08GH5868RJsC0h8sSDkDjtTz
 nYRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjSDLU5VtWpym/23X4ScSIKFfHNoJQ4IOmyBOeCrZCYAymk0rlzM6eBwlb4h32GWVrl5Jd5EZ9QnZh@nongnu.org
X-Gm-Message-State: AOJu0Yz1atukjFLeZm7GgR/edNJEGsZuUuJfXXK1Do2WQ8rjN4tKMWsw
 f7QOnX13KtqlOomazf2X1qi2jOsPL7ovR6WYU7H6Wgz/EmsHetX6/6MbrsQ5YmIeBdlHKvz3cJw
 1Z2Mfu4MiHWTbwvhCrhiP28cPI2BZYi6TeoTgK84MQBJWELvhAH3U
X-Gm-Gg: ASbGncu/H7cTJoxhqupI1Cjs03Bp2i1NjQ0L1KjWshUVfHb5vSfuhFnKCAlnPqliLBG
 OMabx/Up8Nscwp2XsPaJDEMcukFGad6EPWK5LNP25XT1J+D3yySW3XAWuOpyeIQr24aPagQC0Vv
 h6kO/d52DbXOjAvvfzgTyKGYMttIuHAB+GxyABhDVvZimjFLWdCxF1Vdii0iWJ69FdghOBV3gpn
 bJxByHs6+RiqC+FuM+U2DbHYEZPyU52IzMp4V3+IgYHjA5VfOnaAS5+3UP/G9B3d3UcFDlpmIv/
 dFAxG5E=
X-Received: by 2002:a05:6000:1545:b0:385:ea11:dd92 with SMTP id
 ffacd0b85a97d-3864ce967famr304619f8f.15.1733860487103; 
 Tue, 10 Dec 2024 11:54:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQHZ67Z3GzpGyyWLoLF+zEfP1kSGgrZ3hFYq3/4yPFLxDQWNl8dsbzg02kb5IkNqbGtVRfTw==
X-Received: by 2002:a05:6000:1545:b0:385:ea11:dd92 with SMTP id
 ffacd0b85a97d-3864ce967famr304608f8f.15.1733860486771; 
 Tue, 10 Dec 2024 11:54:46 -0800 (PST)
Received: from [192.168.3.141] (p5b0c61ad.dip0.t-ipconnect.de. [91.12.97.173])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861ecf4119sm16524669f8f.14.2024.12.10.11.54.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 11:54:45 -0800 (PST)
Message-ID: <cbe5a04e-caac-4ddc-a7a4-6c6bf5b0fac8@redhat.com>
Date: Tue, 10 Dec 2024 20:54:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hostmem-file: add the 'hmem' option
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kraxel@redhat.com" <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20241204171114.20033-1-Zhigang.Luo@amd.com>
 <5d4019cd-a3fb-4bed-8bab-e0388ccffee7@redhat.com>
 <BL1PR12MB531759C282DC7A424CBC56E8F1312@BL1PR12MB5317.namprd12.prod.outlook.com>
 <ab889035-afa2-4a32-8a13-b8bd21b69fc7@redhat.com>
 <BL1PR12MB5317B47F9AF0068760239C8BF13D2@BL1PR12MB5317.namprd12.prod.outlook.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <BL1PR12MB5317B47F9AF0068760239C8BF13D2@BL1PR12MB5317.namprd12.prod.outlook.com>
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

On 10.12.24 20:32, Luo, Zhigang wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi David,
> 

Hi,

>>>
>>> Thanks for your comments.
>>> Let me give you some background for this patch.
>>> I am currently engaged in a project that requires to pass the EFI_MEMORY_SP
>> (Special Purpose Memory) type memory from host to a virtual machine within
>> QEMU. This memory needs to be EFI_MEMORY_SP type in the virtual machine as
>> well.
>>> This particular memory type is essential for the functionality of my project.
>>
>> Which exact guest memory will be backed by this memory? All guest-memory?
> [Luo, Zhigang] not all guest-memory. Only the memory reserved for specific device.

Can you show me an example QEMU cmdline, and how you would pass that 
hostmem-file object to the device?

> 
>>
>> And, what is the guest OS going to do with this memory?
> [Luo, Zhigang] the device driver in guest will use this reserved memory.

Okay, so just like CXL memory.

> 
>>
>> Usually, this SP memory (dax, cxl, ...) is not used as boot memory. Like on a bare
>> metal system, one would expect that only CXL memory will be marked as special
>> and put aside to the cxl driver, such that the OS can boot on ordinary DIMMs, such
>> that cxl can online it etc.
>>
>> So maybe you would want to expose this memory using CXL-mem device to the
>> VM? Or a DIMM?
>>
>> I assume the alternative is to tell the VM on the Linux kernel cmdline to set
>> EFI_MEMORY_SP on this memory. I recall that there is a way to achieve that.
>>
> [Luo, Zhigang] I know this option. but it requires the end user to know where is the memory location in guest side(start address, size).

Right.

> 
> 
>>> In Linux, the SPM memory will be claimed by hmem-dax driver by default. With
>> this patch I can use the following config to pass the SPM memory to guest VM.
>>> -object
>>> memory-backend-file,size=30G,id=m1,mem-path=/dev/dax0.0,prealloc=on,al
>>> ign=1G,hmem=on
>>>
>>> I was thinking to change the option name from "hmem" to "spm" to avoid
>> confusion.
>>
>> Likely it should be specified elsewhere, that you want specific guest RAM ranges to
>> be EFI_MEMORY_SP. For a DIMM, it could be a property, similarly maybe for CXL-
>> mem devices (no expert on that).
>>
>> For boot memory / machine memory it could be a machine property. But I'll first have
>> to learn which ranges you actually want to expose that way, and what the VM will do
>> with that information.
> [Luo, Zhigang] we want to expose the SPM memory reserved for specific device. And we will pass the SPM memory and the device to guest. Then the device driver can use the SPM memory in guest side.

Then the device driver should likely have a way to configure that, not 
the memory backend.

After all, the device driver will map it somehow into guest physical 
address space (how?).

> 
>>
>>>
>>> Do you have any suggestions to achieve this more reasonable?
>>
>> The problem with qemu_ram_foreach_block() is that you would indicate also DIMMs,
>> virtio-mem, ... and even RAMBlocks that are not even used for backing anything to
>> the VM as EFI_MEMORY_SP, which is wrong.
> [Luo, Zhigang] qemu_ram_foreach_block() will list all memory block, but in pc_update_hmem_memory(), only the memory block with "hmem" flag will be updated to SPM memory.

Yes, but imagine a user passing such a memory backend to a 
DIMM/virtio-mem/boot memory etc. It will have very undesired side effects.

-- 
Cheers,

David / dhildenb



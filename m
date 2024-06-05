Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52BBC27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 16:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEt5m-0001Lz-1J; Wed, 05 Jun 2024 12:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sEt5k-0001KV-Gc
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 12:02:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sEt5i-0007m3-BB
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 12:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717603330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+TsdZiJwdoLL9Nogml42jX+/s7UsczqDyOXqfSDTr/A=;
 b=JYTNl69nzQr5BDBHuIcTEQM15OCHzPQ98B5a/1079CvhP6euNn1Y1WgLzfymdlP+fgubC4
 zgmC9mYZdUzQWnys3UZPAXulHBxClHhH3lZQ813IA0rRS014SqwU9LOvLYJqHnVLk6BaG8
 ejbGAw3SJR+QdrzHwC9VdGPx+xoLjK8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-knzaeZFHO2mKHh3Q13JcjA-1; Wed, 05 Jun 2024 12:02:09 -0400
X-MC-Unique: knzaeZFHO2mKHh3Q13JcjA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4212a4bb9d7so76375e9.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 09:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717603328; x=1718208128;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+TsdZiJwdoLL9Nogml42jX+/s7UsczqDyOXqfSDTr/A=;
 b=BaW8QCqhck4c4an06qYEIYmZZ0xWy9RozEjwAGX4Iqjg9thyefgEI4JPppv3ipaUuO
 tqHYEK3pO2wWAzli06G+WIeRqH8eBBsABS9fEXqDms3aEJgJPT/XWu5e8RWUZTodE46A
 YDe5JJyMC7EBu6s8aj/43hoCvqrfrXyOGKYpuH9VEBTPX7lvNz2ig4HrbFeDEYIDmpDZ
 OqsHOifQVfc4/fwF34ebximGiyKe3BZkgrtFEa+K1EgkfF8gue0gtAdZaLEc0hWb/0Xg
 aY/euBZ4BO4xLXuiw+HC6BKUwHCJCfM/tlIUE/0WF+BpJjzMh9LMTvgCHRvUgWzEVKWs
 y7Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/Ly405Pi1fDfO8lgndxDc2glVXFmX02bITZrhfhBV5aTmt8ttu2pS7rCD+P2oXdhwn32dCwh6PK7XJfKvI7qMZhmltgs=
X-Gm-Message-State: AOJu0Yx7wLNjK91LmyV/yZmx6DNoHaeVPR+pUsyyMcE0tQ1R/gAgE+rz
 nDdZJr6NZsdlJwNkQS5QF/fPXva5H0xQPbo5Bhum5W02yj7me/L9CIppjZlXIQuWaXC4Qvwz/6y
 e3ZwhFKoRDZ9AXHCvkcg5N7hLH9JULRKAc6jAHU8l9rQG7VLra60c4Wt4T912
X-Received: by 2002:a05:600c:4f49:b0:421:36da:9438 with SMTP id
 5b1f17b1804b1-4215633a175mr31142135e9.28.1717603328307; 
 Wed, 05 Jun 2024 09:02:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVqdsYIUNnBo0e0OGz+HPXoUsB4tbTEXQvIZey3FluaSuKIcd+zcwKdGxPoowSABuEicLRFQ==
X-Received: by 2002:a05:600c:4f49:b0:421:36da:9438 with SMTP id
 5b1f17b1804b1-4215633a175mr31141745e9.28.1717603327763; 
 Wed, 05 Jun 2024 09:02:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:3100:19a8:d898:8e69:6aff?
 (p200300cbc706310019a8d8988e696aff.dip0.t-ipconnect.de.
 [2003:cb:c706:3100:19a8:d898:8e69:6aff])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42158110ab4sm27224425e9.11.2024.06.05.09.02.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 09:02:07 -0700 (PDT)
Message-ID: <c89da51b-fef4-4c95-bf71-29598e6553df@redhat.com>
Date: Wed, 5 Jun 2024 18:02:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] vhost-user: add shmem mmap request
To: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org,
 mst@redhat.com, slp@redhat.com, jasowang@redhat.com
References: <20240530152223.780232-1-aesteve@redhat.com>
 <20240530152223.780232-2-aesteve@redhat.com>
 <20240604185416.GB90471@fedora.redhat.com>
 <CADSE00+yvsOhiJJg0ePgr7AYVCkjm9xWNj7KpAOFMwj2wuEpGg@mail.gmail.com>
 <20240605142849.GC135899@fedora.redhat.com>
 <CAJSP0QUL8VNsYB-D1gaBoE0nrXAQozELU4fwNqoFy5FC9OiEng@mail.gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJSP0QUL8VNsYB-D1gaBoE0nrXAQozELU4fwNqoFy5FC9OiEng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 05.06.24 17:19, Stefan Hajnoczi wrote:
> On Wed, 5 Jun 2024 at 10:29, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>
>> On Wed, Jun 05, 2024 at 10:13:32AM +0200, Albert Esteve wrote:
>>> On Tue, Jun 4, 2024 at 8:54 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>>
>>>> On Thu, May 30, 2024 at 05:22:23PM +0200, Albert Esteve wrote:
>>>>> Add SHMEM_MAP/UNMAP requests to vhost-user.
>>>>>
>>>>> This request allows backends to dynamically map
>>>>> fds into a shared memory region indentified by
>>>>
>>>> Please call this "VIRTIO Shared Memory Region" everywhere (code,
>>>> vhost-user spec, commit description, etc) so it's clear that this is not
>>>> about vhost-user shared memory tables/regions.
>>>>
>>>>> its `shmid`. Then, the fd memory is advertised
>>>>> to the frontend through a BAR+offset, so it can
>>>>> be read by the driver while its valid.
>>>>
>>>> Why is a PCI BAR mentioned here? vhost-user does not know about the
>>>> VIRTIO Transport (e.g. PCI) being used. It's the frontend's job to
>>>> report VIRTIO Shared Memory Regions to the driver.
>>>>
>>>>
>>> I will remove PCI BAR, as it is true that it depends on the
>>> transport. I was trying to explain that the driver
>>> will use the shm_base + shm_offset to access
>>> the mapped memory.
>>>
>>>
>>>>>
>>>>> Then, the backend can munmap the memory range
>>>>> in a given shared memory region (again, identified
>>>>> by its `shmid`), to free it. After this, the
>>>>> region becomes private and shall not be accessed
>>>>> by the frontend anymore.
>>>>
>>>> What does "private" mean?
>>>>
>>>> The frontend must mmap PROT_NONE to reserve the virtual memory space
>>>> when no fd is mapped in the VIRTIO Shared Memory Region. Otherwise an
>>>> unrelated mmap(NULL, ...) might use that address range and the guest
>>>> would have access to the host memory! This is a security issue and needs
>>>> to be mentioned explicitly in the spec.
>>>>
>>>
>>> I mentioned private because it changes the mapping from MAP_SHARED
>>> to MAP_PRIVATE. I will highlight PROT_NONE instead.
>>
>> I see. Then "MAP_PRIVATE" would be clearer. I wasn't sure whether you
>> mean mmap flags or something like the memory range is no longer
>> accessible to the driver.
> 
> One more thing: please check whether kvm.ko memory regions need to be
> modified or split to match the SHMEM_MAP mapping's read/write
> permissions.
> 
> The VIRTIO Shared Memory Area pages can have PROT_READ, PROT_WRITE,
> PROT_READ|PROT_WRITE, or PROT_NONE.
> 
> kvm.ko memory regions are read/write or read-only. I'm not sure what
> happens when the guest accesses a kvm.ko memory region containing
> mappings with permissions more restrictive than its kvm.ko memory
> region.

IIRC, the KVM R/O memory region requests could allow to further reduce 
permissions (assuming your mmap is R/W you could map it R/O into the KVM 
MMU), but I might remember things incorrectly.


> In other words, the kvm.ko memory region would allow the
> access but the Linux virtual memory configuration would cause a page
> fault.
> 
> For example, imagine a QEMU MemoryRegion containing a SHMEM_MAP
> mapping with PROT_READ. The kvm.ko memory region would be read/write
> (unless extra steps were taken to tell kvm.ko about the permissions).
> When the guest stores to the PROT_READ page, kvm.ko will process a
> fault...and I'm not sure what happens next.
> 
> A similar scenario occurs when a PROT_NONE mapping exists within a
> kvm.ko memory region. I don't remember how kvm.ko behaves when the
> guest tries to access the pages.
> 
> It's worth figuring this out before going further because it could
> become tricky if issues are discovered later. I have CCed David
> Hildenbrand in case he knows.


One relevant piece is likely:

"When the KVM_CAP_SYNC_MMU capability is available, changes in the 
backing of the memory region are automatically reflected into the guest. 
  For example, an mmap() that affects the region will be made visible 
immediately. "

We can already effectively get R/O or PROT_NONE PTEs in 
PROT_READ|PROT_WRITE mappings, and the KVM must be able to handle that 
properly -- trigegring a page fault to let core-MM resolve that.

If we have a PROT_NONE VMA and the guest writes to it, we'd likely end 
up (to resolve the KVM MMU page fault) in 
hva_to_pfn_slow()->get_user_pages_unlocked(), which would return -EFAULT.

Not sure if we really inject a page fault into the guest or if the KVM 
run would effectively fail with -EFAULT and make user space unhappy. 
Certainly something to play with!

-- 
Cheers,

David / dhildenb



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A69C0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 20:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taL4i-0006b1-9J; Tue, 21 Jan 2025 15:42:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1taL4e-0006al-UI
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 15:42:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1taL4d-0004yu-4g
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 15:42:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737492129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bV+nRwACZuxKEgybFrFqH2UzM+9UPRa+IzmD8p7kJqY=;
 b=BC5Nnizp13neFTShNxQWMHgZ/QnpUh6O5miQmqTGftO50GmACEoEEBhxL/0lq0r4QrR7b5
 44bnabctDnYJDxODy7K/jtpZXmqzcgJ8oFWDpWcxOFwJJFq2kUvEo6GCWk4pLT4GmyROgT
 uXMDE4859NVtyolbDow92cvCmz1Encw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-li0Ur9uDMRuaf-f-QFR8sg-1; Tue, 21 Jan 2025 15:42:00 -0500
X-MC-Unique: li0Ur9uDMRuaf-f-QFR8sg-1
X-Mimecast-MFC-AGG-ID: li0Ur9uDMRuaf-f-QFR8sg
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385dcae001fso2739089f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 12:42:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737492119; x=1738096919;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bV+nRwACZuxKEgybFrFqH2UzM+9UPRa+IzmD8p7kJqY=;
 b=Aee65m3sPTSwNxXvuWaoCs7zK7xsSIyO+79eMs9tCvwT3tVuOe3gr9aqzyM3ThnuB9
 5kCBswmXG3Q3W8SYdHtginj32RDU6eZ79dRv8k520Dh3W5yI03hEq6Tz33oMvNmxEkE9
 TbKwbNb4CFSwiikIrX3ZJn5FjCqctyl4s+BqwdJ7v8pbetC0mBfQ0p18+hkn04qhcDpv
 bqBRTcHP1vFGJSjsVkoUyMgLym+pdIwA4xGrD7pBdiEbI1unbI69gDYR5BIHvcGQUJxy
 kXlBNKsP/e8QO3SuOmfDpYsESYwaejQ82pnmMF0m33il/aGnLXP4gZCtGyTMj+ZsYZ6u
 cpzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDSQTFCWBz4XivCzoxx71Pe9+JcVVTyRdnidj8Pcr2lzj4NK7TYmr9+erdKbNKYjYFlultKWYFRp60@nongnu.org
X-Gm-Message-State: AOJu0Yz+i5q7uEou0AeP9tLSejeu46PqgmVetkehx1ylv1qiZGD7v3VE
 yinWluCj3NoYa/WrmefHV+pwuB6dDp2UFyQ4ZkRLn9MM4KPzlsV5kY6/P2QFDzQV2B7KZSjh2Gk
 tYgKSzqCQbi8I7mjq391gOUgvLzEdUjC9aazsb5qD2L3GrR7GEwL+
X-Gm-Gg: ASbGncuC2sG1xpkWA/C/md89j38uJ4idzQkSrkQK1Y3VwfK0EO8OiOCYPLa2Q6mjo2C
 OViCFpJQYvE4ocf+1lVthwOel+WwGumVnv74JFW0J1pCNF5R+38KOWcO9W/F7AF05uvjkQeFWT+
 SLy46GjWqT/59MBKNz9atptR+2EZAilVVS8X78KIZBGrDpjJSZ/RnpTFQ5DIsDBzN8BnKcjHNl5
 pTprCvAXC+FltUr1kYRT0wnkEFk6R2Qrg9Q6Brym2OFe5AitFQtwBX1DypMZ1U0FYxUg2Kc7gSg
 AkDH/DD8typAeIH84xtb7UbKqcVP4+Q8lLZDXgSal8AEiijklUZKO7qZTJ8LUoSQ/6MVtTQ+blB
 cIL1R0jqWcXpUUzrdwf1pbQ==
X-Received: by 2002:adf:cc90:0:b0:38a:4b8a:e47d with SMTP id
 ffacd0b85a97d-38bf5674f99mr13452391f8f.26.1737492119328; 
 Tue, 21 Jan 2025 12:41:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0/IGfSRFqD5a1cp4PYttFZEQK6OSIhNeNeDTCMSeqJHpzVP1bbzOd8PElCu3iC/ATqtzc0g==
X-Received: by 2002:adf:cc90:0:b0:38a:4b8a:e47d with SMTP id
 ffacd0b85a97d-38bf5674f99mr13452373f8f.26.1737492118899; 
 Tue, 21 Jan 2025 12:41:58 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:6200:16ba:af70:999d:6a1a?
 (p200300cbc709620016baaf70999d6a1a.dip0.t-ipconnect.de.
 [2003:cb:c709:6200:16ba:af70:999d:6a1a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf327e19fsm14701763f8f.93.2025.01.21.12.41.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 12:41:57 -0800 (PST)
Message-ID: <bc0b4372-d8ca-4d5c-aee8-6e2521ebb2ec@redhat.com>
Date: Tue, 21 Jan 2025 21:41:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/49] HostMem: Add mechanism to opt in kvm guest memfd
 via MachineState
To: Peter Xu <peterx@redhat.com>
Cc: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-8-michael.roth@amd.com> <Z4_b3Lrpbnyzyros@x1n>
 <fa29f4ef-f67d-44d7-93f0-753437cf12cb@redhat.com> <Z5AB3SlwRYo19dOa@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z5AB3SlwRYo19dOa@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

>> This "anon" memory cannot be "shared" with other processes, but
>> virtio-kernel etc. can just use it.
>>
>> To "share" the memory with other processes, we'd need memfd/file.
> 
> Ah OK, thanks David.  Is this the planned long term solution for
> vhost-kernel?

I think the basic idea was that the memory backend defines how the 
"non-private" memory is backed, which is the same just like for any 
other non-CC VM.

The "private" memory always comes from guest_memfd.

So for the time being using anon+guest_memfd coresponds to "just a 
simple VM".

Long-term I expect that we use guest_memfd for shared+private, and use 
in-place conversion. Access to "private" memory using the mmap() will 
result in a SIGBUS.

 > > I wonder what happens if vhost tries to DMA to a region that is private
> with this setup.
 > > AFAIU, it'll try to DMA to the fake address of ramblock->host that is
> pointing to by the memory backend (either anon, shmem, file, etc.).  The
> ideal case IIUC is it should crash QEMU because it's trying to access an
> illegal page which is private. But if with this model, it won't crash but
> silently populate some page in the non-gmemfd backend.
> 
> Is that expected?

Yes, it's all just a big mmap() which will populate memory on access -- 
independent of using anon/file/memfd.

Similar to virtio-mem, long-term we'd want a mechanism to check/enforce 
that some memory in there will not be populated on access from QEMU 
(well, and vhost-user processes ...).

In memory_get_xlat_addr() we perform such checks, but it's only used for 
iommu. vhost-kernel likely has no such checks, just like vhost-user etc 
does not.

> 
>>
>>>
>>> When specified gmemfd=on with those, IIUC it'll allocate both the memory
>>> (ramblock->host) and gmemfd, but without using ->host.  Meanwhile AFAIU the
>>> ramblock->host will start to conflict with gmemfd in the future when it
>>> might be able to be mapp-able (having valid ->host).
>>
>> These will require a new guest_memfd memory backend (I recall that was
>> discussed a couple of times).
> 
> Do you know if anyone is working on this one?

So far my understanding is that Google that does shared+private 
guest_memfd kernel part won't be working on QEMU patches. I raised that 
to our management recently, that this would be a good project for RH to 
focus on.

I am not aware of real implementations of the guest_memfd backend (yet).

> 
>>
>>>
>>> I have a local fix for this (and actually more than below.. but starting
>>> from it), I'm not sure whether I overlooked something, but from reading the
>>> cover letter it's only using memfd backend which makes perfect sense to me
>>> so far.
>>
>> Does the anon+guest_memfd combination not work or are you speculating about
>> the usability (which I hopefully addressed above).
> 
> IIUC, if with above solution and with how QEMU interacts memory convertions
> right now, at least hugetlb pages will suffer from double allocation, as
> kvm_convert_memory() won't free hugetlb pages even if converted to private.

Yes, that's why I'm invested in teaching guest_memfd in-place conversion 
alongside huge page support (which fortunately Google engineers are 
doing great work on).

> 
> It sounds like also doable (and also preferrable..) that for each of the VM
> we always stich with pages in the gmemfd page cache, no matter if it's
> shared or private.  For private, we could zap all pgtables and sigbus any
> faults afterwards.  I thought that was always the plan, but I could lose
> many latest informations..

Yes, with the guest_memfd backend (shared+private) that's the plan: 
SIGBUS on invalid access.


-- 
Cheers,

David / dhildenb



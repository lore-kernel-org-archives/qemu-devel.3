Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC6BC3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFCdE-0005Jc-3h; Wed, 14 May 2025 09:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uFCdC-0005AL-9D
 for qemu-devel@nongnu.org; Wed, 14 May 2025 09:58:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uFCd9-0001Z7-AE
 for qemu-devel@nongnu.org; Wed, 14 May 2025 09:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747231121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jwcZ4GZ8HHVD1ukpomEmS3Iftui0aAFFOJ+emh4s7kI=;
 b=jEEBXPSzmmcSJDYFdaMqdLsNHsFbJQTPioUPvM2+hMrpzTQJPDaMY+aRkT2asJvS7127Kb
 7xlJtmip0ffnIln0bjOA9li4N0IDfqZXqy9EJW0hj2xkHgreVdt90kck/Xm+CNCT7bi1nW
 AzMYg/lqZEkJo4R72vMNk465ywJDGI4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-IODpto9DNlui7Oa45LL6Ag-1; Wed, 14 May 2025 09:57:31 -0400
X-MC-Unique: IODpto9DNlui7Oa45LL6Ag-1
X-Mimecast-MFC-AGG-ID: IODpto9DNlui7Oa45LL6Ag_1747231050
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a0ba24d233so2389619f8f.2
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 06:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747231050; x=1747835850;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jwcZ4GZ8HHVD1ukpomEmS3Iftui0aAFFOJ+emh4s7kI=;
 b=emjsyoQBRpt8mfkj7FACkiuU6yA6hzx6oMjogRb61fIeYuewhYW8ZO8GGDyBmUmPLu
 4ugO4jfrMIkGMkrFsWkh0pWgLqZrNo4mqDtFWK9CzPBFmnHsGyMgCPP0aNyiKotAVyI3
 7eX7VtjwTeAxW/99E5sLIG5UINglXjVrtJIzz2TyqQ/LxaAhtECYRoWAsGy4ddiIKO3A
 taGf7V8k52QuQssLfXw8kCR0Af7VMZl9dJ021XvfA2x3lI3OqTyFQRmCVUH3sPYVj/0W
 xQ73JWvXe56DMFOBThlDudjpqezFfXwx/I5WF2opI2p7tuU2crUsN1VSTKxOw6umVQGJ
 hDFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmUAzowqchhRoLUX2yYcc3igdgyDfFi84G+UYn3C/n1Pn5ofJ51/96XgvClZXIM1RONbVZhFYYI97F@nongnu.org
X-Gm-Message-State: AOJu0YzZcXjaZXsL9UXOFI7KoCP1dFcYeeKKG7p6tliGNHmRw5m2fDPG
 fP3JehJ1LfTJ5OmjL2bnXxE+qX4a+466GilPGcqWohz3N7O+d8efhCpC1mIIGJVjocQ3i5Noafj
 RxssSBRgVl/DbhLFhbLJ4BClfQx0z7CCniC2DINZisXTe8nBvTJBX
X-Gm-Gg: ASbGncstqXb4b7Bm9yjoi06Wq/vzEX8gXVtO2JKSUEQBQ8cYll6mWVNbRFH+cn+opyF
 By6fT+Du8Yhcd5iqToY5mp3sHcY4Y7VI+nGEzVaw/9LauJ6nd4jD311q+iBlEkvxZ1VaOkMdioV
 Bz8nZucKB/1PNXOggtgEBYFeZK6LBf637qRVXKG5pkhRL2vOcwhc5/aiRAjgdlVpDii4/9D+ppW
 fCNOhd7NNfMGPRZ9O8qz2Ec2mT+UsLv7sNAamErBcK9JUalmbIVIIRlBCQbiAzaOTB5qLHrYENE
 Mbe2vz737X17b8r3W2sEkoGGMyMgqK57n09RwUrsS9WaM5dtSiurszufFnLNQksTJ1MiAl7oCYV
 p3qmFvA2neHExG0n58vpnedFtnvtExl1hzlG0GfA=
X-Received: by 2002:a5d:5f91:0:b0:3a0:7017:61f6 with SMTP id
 ffacd0b85a97d-3a3496a40f6mr3385161f8f.14.1747231049975; 
 Wed, 14 May 2025 06:57:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFl7tHcB8gaiVEPddNqHlH/ICCu7ZjgGfosPjmrNj0Jh/aUIsq0SQwft+uNyNO+kzp8ND8EtA==
X-Received: by 2002:a5d:5f91:0:b0:3a0:7017:61f6 with SMTP id
 ffacd0b85a97d-3a3496a40f6mr3385122f8f.14.1747231049526; 
 Wed, 14 May 2025 06:57:29 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f15:6200:d485:1bcd:d708:f5df?
 (p200300d82f156200d4851bcdd708f5df.dip0.t-ipconnect.de.
 [2003:d8:2f15:6200:d485:1bcd:d708:f5df])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2ca31sm19931594f8f.65.2025.05.14.06.57.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 06:57:29 -0700 (PDT)
Message-ID: <cac9c790-c195-4d06-b3ac-894320ccbb97@redhat.com>
Date: Wed, 14 May 2025 15:57:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: live-migration performance regression when using pmem
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Chaney, Ben" <bchaney@akamai.com>,
 "yury-kotov@yandex-team.ru" <yury-kotov@yandex-team.ru>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "beata.michalska@linaro.org" <beata.michalska@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "junyan.he@intel.com" <junyan.he@intel.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>,
 "Tottenham, Max" <mtottenh@akamai.com>, "Hunt, Joshua" <johunt@akamai.com>,
 "Glasgall, Anna" <aglasgal@akamai.com>, Junyan He <junyan.he@intel.com>
References: <1385969E-EC2D-4262-9072-29F520D0DF81@akamai.com>
 <802008e8-5661-4475-a99c-09f0524f1a8a@redhat.com>
 <20250513161036-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250513161036-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 13.05.25 22:11, Michael S. Tsirkin wrote:
> On Tue, May 13, 2025 at 07:21:36PM +0200, David Hildenbrand wrote:
>> On 12.05.25 17:16, Chaney, Ben wrote:
>>> Hello,
>>>
>>>           When live migrating to a destination host with pmem there is a very long downtime where the guest is paused. In some cases, this can be as high as 5 minutes, compared to less than one second in the good case.
>>>
>>>
>>>           Profiling suggests very high activity in this code path:
>>>
>>>
>>> ffffffffa2956de6 clean_cache_range+0x26 ([kernel.kallsyms])
>>> ffffffffa2359b0f dax_writeback_mapping_range+0x1ef ([kernel.kallsyms])
>>> ffffffffc0c6336d ext4_dax_writepages+0x7d ([kernel.kallsyms])
>>> ffffffffa2242dac do_writepages+0xbc ([kernel.kallsyms])
>>> ffffffffa2235ea6 filemap_fdatawrite_wbc+0x66 ([kernel.kallsyms])
>>> ffffffffa223a896 __filemap_fdatawrite_range+0x46 ([kernel.kallsyms])
>>> ffffffffa223af73 file_write_and_wait_range+0x43 ([kernel.kallsyms])
>>> ffffffffc0c57ecb ext4_sync_file+0xfb ([kernel.kallsyms])
>>> ffffffffa228a331 __do_sys_msync+0x1c1 ([kernel.kallsyms])
>>> ffffffffa2997fe6 do_syscall_64+0x56 ([kernel.kallsyms])
>>> ffffffffa2a00126 entry_SYSCALL_64_after_hwframe+0x6e ([kernel.kallsyms])
>>> 11ec5f msync+0x4f (/usr/lib/x86_64-linux-gnu/libc.so.6)
>>> 675ada qemu_ram_msync+0x8a (/usr/local/akamai/qemu/bin/qemu-system-x86_64)
>>> 6873c7 xbzrle_load_cleanup+0x37 (inlined)
>>> 6873c7 ram_load_cleanup+0x37 (/usr/local/akamai/qemu/bin/qemu-system-x86_64)
>>> 4ff375 qemu_loadvm_state_cleanup+0x55 (/usr/local/akamai/qemu/bin/qemu-system-x86_64)
>>> 500f0b qemu_loadvm_state+0x15b (/usr/local/akamai/qemu/bin/qemu-system-x86_64)
>>> 4ecf85 process_incoming_migration_co+0x95 (/usr/local/akamai/qemu/bin/qemu-system-x86_64)
>>> 8b6412 qemu_coroutine_self+0x2 (/usr/local/akamai/qemu/bin/qemu-system-x86_64)
>>> ffffffffffffffff [unknown] ([unknown])
>>>
>>>
>>>           I was able to resolve the performance issue by removing the call to qemu_ram_block_writeback in ram_load_cleanup. This causes the performance to return to normal. It looks like this code path was initially added to ensure the memory was synchronized if the persistent memory region is backed by an NVDIMM device. Does it serve any purpose if pmem is instead backed by standard DRAM?
>>
>> Are you using a read-only NVDIMM?
>>
>> In that case, I assume we would never need msync.
>>
>>
>> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
>> index 94bb3ccbe4..819b8ef829 100644
>> --- a/include/exec/ram_addr.h
>> +++ b/include/exec/ram_addr.h
>> @@ -153,7 +153,8 @@ void qemu_ram_msync(RAMBlock *block, ram_addr_t start, ram_addr_t length);
>>   /* Clear whole block of mem */
>>   static inline void qemu_ram_block_writeback(RAMBlock *block)
>>   {
>> -    qemu_ram_msync(block, 0, block->used_length);
>> +    if (!(block->flags & RAM_READONLY))
>> +        qemu_ram_msync(block, 0, block->used_length);
>>   }
>>
>>
>> -- 
>> Cheers,
>>
>> David / dhildenb
> 
> I acked the original change but now I don't understand why is it
> critical to preserve memory at a random time that has nothing
> to do with guest state.
> David, maybe you understand?

Let me dig ...

As you said, we originally added pmem_persist() in:


commit 56eb90af39abf66c0e80588a9f50c31e7df7320b (mst/mst-next)
Author: Junyan He <junyan.he@intel.com>
Date:   Wed Jul 18 15:48:03 2018 +0800

     migration/ram: ensure write persistence on loading all data to PMEM.

     Because we need to make sure the pmem kind memory data is synced
     after migration, we choose to call pmem_persist() when the migration
     finish. This will make sure the data of pmem is safe and will not
     lose if power is off.

     Signed-off-by: Junyan He <junyan.he@intel.com>
     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
     Reviewed-by: Igor Mammedov <imammedo@redhat.com>
     Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


Then, we generalized to not using pmem_persist() but doing a 
qemu_ram_block_writeback() -- that includes a conditional pmem_persist() in:

commit bd108a44bc29cb648dd930564996b0128e66ac01
Author: Beata Michalska <beata.michalska@linaro.org>
Date:   Thu Nov 21 00:08:42 2019 +0000

     migration: ram: Switch to ram block writeback

     Switch to ram block writeback for pmem migration.

     Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
     Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
     Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
     Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
     Message-id: 20191121000843.24844-4-beata.michalska@linaro.org
     Signed-off-by: Peter Maydell <peter.maydell@linaro.org>


That was part of a patch series "[PATCH 0/4] target/arm: Support for 
Data Cache Clean up to PoP" [1].

At first, it looks like a cleanup, but has the effect of also affecting 
non-pmem memory backends.

A discussion [2] includes some reasoning around libpmem not being 
around, and msync being a suitable replacement in that case [3]: "
According to the PMDG man page, pmem_persist is supposed to be
equivalent for the msync. It's just more performant. So in case of real 
pmem hardware it should be all good."


So, the real question is: why do have to sync *after* migration on the 
migration *destination*?

I think the reason is simple if you assume that the pmem device will 
differ between source and destination, and that we actually migrated 
that data in the migration stream.

On the migration destination, we will fill pmem with data we obtained 
from the src via the migration stream: writing the data to pmem using 
ordinary memory writes.

pmem requires a sync to make sure that the data is *actually* persisted. 
The VM will certainly not issue a sync, because it didn't modify any 
pages. So we have to issue a sync such that pmem is guaranteed to be 
persisted.


In case of ordinary files, this means writing data back to disk 
("persist on disk"). I'll note that NVDIMMs are not suitable for 
ordinary files in general, because we cannot easily implement 
guest-triggered pmem syncs using basic instruction set. For R/O NVDIMMs 
it's fine.

For the R/W use case, virtio-pmem was invented, whereby the VM will do 
the sync -> msync using an explicit guest->host call. So once the guest 
sync'ed, it's actually persisted.


Now, NVDIMMs could be safely used in R/O mode backed by ordinary files. 
Here, we would *still* want to do this msync.

So, we can really only safely ignore the msync if we know that the 
mmap() is R/O (in which case, migration probably would fail either way? 
unless the RAMBlock is ignored).


While we could not perform the msync if we detect that we have an 
ordinary file, there might still be the case where we have a R/W NVDIMM, 
just nobody actually ever writes to it ... so it's tricky. Certainly 
worth exploring. But there would be the chance of data loss for R/O 
NVDIMMs after migration on hypervisor crash ...



[1] 
https://patchew.org/QEMU/20191121000843.24844-1-beata.michalska@linaro.org/

[2] 
https://lists.libreplanet.org/archive/html/qemu-devel/2019-09/msg01750.html

[3] 
https://lists.libreplanet.org/archive/html/qemu-devel/2019-09/msg01772.html

-- 
Cheers,

David / dhildenb



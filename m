Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A50C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 10:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taXh3-0004bX-E1; Wed, 22 Jan 2025 05:10:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1taXh0-0004bA-P2
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 05:10:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1taXgz-0006Do-1A
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 05:10:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737540631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=v3tiZnnv0SFg7soColkuXI5vrzo7wy1u1urREuCEukU=;
 b=iROkmBMYrQodPrFSotV1IJDtzwdqH7jurrJwFhJb1QZNSgwiyfLCu3URLD6hOegHUEOqYL
 N49y8W2pEoZphuhjHLCXGkYqGLUF6crBi7bjj31hpwXjQUU1oa6Awco0pZ0uL31BNw3MnT
 v2+FCPl9xgEkUza9KgLRRDCiLyeAAVI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-U9VJ_6ihNziqL0T7JL-DOw-1; Wed, 22 Jan 2025 05:10:29 -0500
X-MC-Unique: U9VJ_6ihNziqL0T7JL-DOw-1
X-Mimecast-MFC-AGG-ID: U9VJ_6ihNziqL0T7JL-DOw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43673af80a6so50986045e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 02:10:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737540628; x=1738145428;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=v3tiZnnv0SFg7soColkuXI5vrzo7wy1u1urREuCEukU=;
 b=QYjV0t1QlGlKkxc6iv2YUXIacvXEfea6nDnnyZiACmfw2Y05pQUu6WQtMXYkGxVrzi
 O+eZltGO2ciJvz3UQr5SCXC3071RE5bt6LmGo19gKcNxRDw1mGVCct2yGH5jsNJFjaT5
 YBI529Wv5NcCtcT2GwUpKuGtyjQN2c/8l9JYpV/nxw/kZtkzJRQdVXM9MSlQl8l6Rr+q
 74VQM07zKIa4LLTKtMJsK9To04i7Yu41We7mbFNobjuF9PR+YMeoyJsWyIUlaY9hIfj2
 chGczZ4N845JNFz1BQHxuRW7hYnSxdm/cxD3MQ9cHly3gDS6vavYwBIkUZ2/r6ZDd+F/
 dOng==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/BIReBaCNf/DMtCRtP8Dtv3qSrGMhLzwPkuXNBiXmuTszmIUOg5M3dhvXu3U3DZ+LpbF4DvFpq+mY@nongnu.org
X-Gm-Message-State: AOJu0YyRd1sViVhN4hfhTkbb1W6yOVOHjGQn9tuv2XYI3CsdKPBKrTki
 mDOjt8tX1T3Ya1bEW3YWXnnVnxgVsHCqDJT+eduqdR8+DRbSBBlxFFB69H6HqPLMgwsDym/4Pjt
 wbXldMyABTeHEi8EOKUc1RsFLMlaBNfS91QdSZrcUTt0JRCOProq2
X-Gm-Gg: ASbGncvmn0hyCNPIF0U48z6r+C/Xn27AZLeUUpXGZM7SemM221q5xijz/cGNxJ8fJYL
 ARyPgmKUhOBI2JJkzX8Ilu4ODaLV9N6E0T3oAztcOl4pVuDGPqjZgg8XwVuMdCU7TWD4yT6Y9Xg
 bUV16RHE9TLcfz/PeEt1QNFhzR8VmoTAxlHr/iLeRh3D8nJtHFjdCfA8DBLUn2+oe5RS+nqVwDR
 nHI0Oaq5V1GFmwHqpUIWhSymLvoXiIk92TMOGdocZdSQ+IfFLHyRJjTaK4ZO8Sq2FSChjhfpMY/
 9XggmE18b5nCbUdqq0RK2ImoFiykHhf0/a1mEBi36DUHBeiScF1s7pVVPN18e2u92TqnWmMHsK+
 r1AJoVsxmlRVsxLPBcDISug==
X-Received: by 2002:a05:600c:1e18:b0:436:8a6f:b6db with SMTP id
 5b1f17b1804b1-4389141c12emr167967935e9.22.1737540628668; 
 Wed, 22 Jan 2025 02:10:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFRDqSw9z3md06NycKarYqY+LVjOIKMUFA7FT1DVfsckylPpU9efRjL9nKBEjL9rAlkW+/Pw==
X-Received: by 2002:a05:600c:1e18:b0:436:8a6f:b6db with SMTP id
 5b1f17b1804b1-4389141c12emr167967535e9.22.1737540628273; 
 Wed, 22 Jan 2025 02:10:28 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:db00:724d:8b0c:110e:3713?
 (p200300cbc70bdb00724d8b0c110e3713.dip0.t-ipconnect.de.
 [2003:cb:c70b:db00:724d:8b0c:110e:3713])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b1ce51a6sm18603005e9.1.2025.01.22.02.10.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2025 02:10:27 -0800 (PST)
Message-ID: <de04d28c-c729-4c84-b241-1eb312586c52@redhat.com>
Date: Wed, 22 Jan 2025 11:10:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] physmem: disallow direct access to RAM DEVICE in
 address_space_write_rom()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Stefan Zabka <git@zabka.it>
References: <20250120111503.244994-1-david@redhat.com>
 <20250120111503.244994-2-david@redhat.com>
 <5267cc69-18ec-48b1-be60-90c972922806@linaro.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <5267cc69-18ec-48b1-be60-90c972922806@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.086,
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

On 22.01.25 11:07, Philippe Mathieu-Daudé wrote:
> Hi David,
> 
> On 20/1/25 12:14, David Hildenbrand wrote:
>> As documented in commit 4a2e242bbb306 ("memory: Don't use memcpy for
>> ram_device regions"), we disallow direct access to RAM DEVICE regions.
>>
>> Let's factor out the "supports direct access" check from
>> memory_access_is_direct() so we can reuse it, and make it a bit easier to
>> read.
>>
>> This change implies that address_space_write_rom() and
>> cpu_memory_rw_debug() won't be able to write to RAM DEVICE regions. It
>> will also affect cpu_flush_icache_range(), but it's only used by
>> hw/core/loader.c after writing to ROM, so it is expected to not apply
>> here with RAM DEVICE.
>>
>> This fixes direct access to these regions where we don't want direct
>> access. We'll extend cpu_memory_rw_debug() next to also be able to write to
>> these (and IO) regions.
>>
>> This is a preparation for further changes.
>>
>> Cc: Alex Williamson <alex.williamson@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>    include/exec/memory.h | 30 ++++++++++++++++++++++++------
>>    system/physmem.c      |  3 +--
>>    2 files changed, 25 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>> index 3ee1901b52..bd0ddb9cdf 100644
>> --- a/include/exec/memory.h
>> +++ b/include/exec/memory.h
>> @@ -2985,15 +2985,33 @@ MemTxResult address_space_write_cached_slow(MemoryRegionCache *cache,
>>    int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr);
>>    bool prepare_mmio_access(MemoryRegion *mr);
>>    
>> +static inline bool memory_region_supports_direct_access(MemoryRegion *mr)
>> +{
>> +    /* ROM DEVICE regions only allow direct access if in ROMD mode. */
>> +    if (memory_region_is_romd(mr)) {
>> +        return true;
>> +    }
>> +    if (!memory_region_is_ram(mr)) {
>> +        return false;
>> +    }
>> +    /*
>> +     * RAM DEVICE regions can be accessed directly using memcpy, but it might
>> +     * be MMIO and access using mempy can be wrong (e.g., using instructions not
>> +     * intended for MMIO access). So we treat this as IO.
>> +     */
>> +    return !memory_region_is_ram_device(mr);
>> +
>> +}
>> +
>>    static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
>>    {
>> -    if (is_write) {
>> -        return memory_region_is_ram(mr) && !mr->readonly &&
>> -               !mr->rom_device && !memory_region_is_ram_device(mr);
>> -    } else {
>> -        return (memory_region_is_ram(mr) && !memory_region_is_ram_device(mr)) ||
> 
> This patch is doing multiple things at once, and I'm having hard time
> reviewing it.

I appreciate the review, but ... really?! :)

25 insertions(+), 8 deletions(-)

-- 
Cheers,

David / dhildenb



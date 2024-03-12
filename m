Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C12C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk650-0002Eg-Kd; Tue, 12 Mar 2024 13:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk64y-0002E7-61
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 13:38:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk64w-0007mc-Dd
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 13:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710265097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZYshZ2cMTkObAgxJ7KWvttePfpfCKs/O1A0THaH8+88=;
 b=QGskrUNRbaiRnv4dI0gfQx3rwA3KqEoQWb2Bq4QmyeQw80ff3wDVAMUBEXCUaZjnmVcy3h
 e8i9KCB2Kj55jAWlar7Qp4fBq77d/VaIM+fnuEdWHJMTPqEKUBYSkfOaOWACVAWT3Aq2Rc
 Q4YqxYgHTv3kDGNCFg7bO9TK8FPKGkY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-ce5o8GadNC2wlQMZi_V-SQ-1; Tue, 12 Mar 2024 13:38:16 -0400
X-MC-Unique: ce5o8GadNC2wlQMZi_V-SQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a46376dcdcbso5732066b.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 10:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710265095; x=1710869895;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZYshZ2cMTkObAgxJ7KWvttePfpfCKs/O1A0THaH8+88=;
 b=JXauEYeKH72gyNUzHirJN+UMUM5knnCnkP+QixRL3Vec6NaVOjBvOgVy2boosTJojB
 ARt0rMvwT4Yuc+35nIzgd8od0LH613uuDLV0aAKgr0bGAG0uvxS6P91B0kvenYORVrzV
 W3B9TZdqAoA0MEv2iIN06qoWUo3oobXvcFba3omLTpwK7F4isGcEhSXjAHETnuR+dWli
 2N3BsdeLWZfCzXEw0H1ODybcbL5U9FEBrFi7Ee29DZ2jcRCMkfLdeRaMPNolNyv32dm+
 SCwYV7TlyJKX/lRo8tTDP6dW1VyeBzEDZZqEF50uSpqib+2R9D4qe2s/o9Kf9/U2ycTU
 Zo2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJv4a4WSUmxkMqb0ij6InjYBU4B0VXZpbqpm4rQwNKYVPVEuDmNdZ/CB3UpOG88M5/gOW5SDX+eokYBRPmqCyNuce9zqo=
X-Gm-Message-State: AOJu0Yw0it5UTX4Fh/kLYWzEaFV7M1WbUMDvdFugDpLC2oiCvj5B2Nyz
 eqlwDwDNmpq1tVZs0qMoBYDE/R2PKG9iy14BkEmdb30HpI9uT1nNhT7M9VtzWiSA311f6C81JFd
 EmwgiBPC/ocL6pJuQPhrHNu8J2UhyhfCFdYER/M/whI0+s9/tzqUH
X-Received: by 2002:a17:906:e285:b0:a45:f2f3:2de0 with SMTP id
 gg5-20020a170906e28500b00a45f2f32de0mr160793ejb.35.1710265095254; 
 Tue, 12 Mar 2024 10:38:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6CmGfhVJ6R+HXhjUSwE721LLFqH0Jk1Lo/GJGZEi2t6fDcJsso/0Qt8LvMz0CiEa1WI32Cw==
X-Received: by 2002:a17:906:e285:b0:a45:f2f3:2de0 with SMTP id
 gg5-20020a170906e28500b00a45f2f32de0mr160773ejb.35.1710265094899; 
 Tue, 12 Mar 2024 10:38:14 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-86.web.vodafone.de.
 [109.43.177.86]) by smtp.gmail.com with ESMTPSA id
 z6-20020a1709063ac600b00a4636e3f576sm1471343ejd.160.2024.03.12.10.38.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 10:38:14 -0700 (PDT)
Message-ID: <0fef1275-836f-496a-8a96-3e46c09cb232@redhat.com>
Date: Tue, 12 Mar 2024 18:38:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/physmem: Fix migration dirty bitmap coherency with
 TCG memory access
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
References: <20240219061731.232570-1-npiggin@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240219061731.232570-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


  Hi Peter, Paolo, David,

this patch fixes a problem with the kvm-unit-tests ... could we get it 
included in QEMU 9.0 ?

  Thanks,
   Thomas


On 19/02/2024 07.17, Nicholas Piggin wrote:
> The fastpath in cpu_physical_memory_sync_dirty_bitmap() to test large
> aligned ranges forgot to bring the TCG TLB up to date after clearing
> some of the dirty memory bitmap bits. This can result in stores though
> the TCG TLB not setting the dirty memory bitmap and ultimately causes
> memory corruption / lost updates during migration from a TCG host.
> 
> Fix this by exporting an abstracted function to call when dirty bits
> have been cleared.
> 
> Fixes: aa8dc044772 ("migration: synchronize memory bitmap 64bits at a time")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> 
> I reproduced this with a kvm-unit-tests migration stress tester I'm
> working on. Tree here with reproduce instructions in latest commit.
> 
> https://github.com/npiggin/kvm-unit-tests/tree/qemu-tcg-migration-bug
> 
> Thanks,
> Nick
> 
>   include/exec/ram_addr.h | 13 +++++++++++++
>   system/physmem.c        | 14 +++++++++-----
>   2 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 90676093f5..dadb2deb11 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -443,6 +443,16 @@ uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>   }
>   #endif /* not _WIN32 */
>   
> +void tcg_cpu_physical_memory_dirty_bits_cleared(ram_addr_t start,
> +                                                ram_addr_t length);
> +static inline void cpu_physical_memory_dirty_bits_cleared(ram_addr_t start,
> +                                                          ram_addr_t length)
> +{
> +    if (tcg_enabled()) {
> +        tcg_cpu_physical_memory_dirty_bits_cleared(start, length);
> +    }
> +
> +}
>   bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
>                                                 ram_addr_t length,
>                                                 unsigned client);
> @@ -504,6 +514,9 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>                   idx++;
>               }
>           }
> +        if (num_dirty) {
> +            cpu_physical_memory_dirty_bits_cleared(start, length);
> +        }
>   
>           if (rb->clear_bmap) {
>               /*
> diff --git a/system/physmem.c b/system/physmem.c
> index 5e66d9ae36..dc0d8b16aa 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -839,6 +839,12 @@ static void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length)
>       }
>   }
>   
> +void tcg_cpu_physical_memory_dirty_bits_cleared(ram_addr_t start,
> +                                                ram_addr_t length)
> +{
> +    tlb_reset_dirty_range_all(start, length);
> +}
> +
>   /* Note: start and end must be within the same ram block.  */
>   bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
>                                                 ram_addr_t length,
> @@ -881,8 +887,8 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
>           memory_region_clear_dirty_bitmap(ramblock->mr, mr_offset, mr_size);
>       }
>   
> -    if (dirty && tcg_enabled()) {
> -        tlb_reset_dirty_range_all(start, length);
> +    if (dirty) {
> +        cpu_physical_memory_dirty_bits_cleared(start, length);
>       }
>   
>       return dirty;
> @@ -929,9 +935,7 @@ DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty
>           }
>       }
>   
> -    if (tcg_enabled()) {
> -        tlb_reset_dirty_range_all(start, length);
> -    }
> +    cpu_physical_memory_dirty_bits_cleared(start, length);
>   
>       memory_region_clear_dirty_bitmap(mr, offset, length);
>   



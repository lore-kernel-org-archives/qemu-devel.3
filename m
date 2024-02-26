Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214EAC54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWkX-0000ZF-4j; Mon, 26 Feb 2024 03:54:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reWkU-0000YW-KC
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:54:11 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reWkS-0001Zr-9N
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:54:10 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-412a5de8a06so2754835e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708937646; x=1709542446; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mT94LtOI9uDDPqWj7St7l9/fVkwxxxe7GhZ8AGoPtC0=;
 b=TazdJd8adPSU/OZ2Gi49bxhTSUMuBdwzrrVMGdfURd3qZ2L4Mn1TzEoaLRPSJT1wYj
 qC/HpzbMqH4op1sGehMu/MFwhj6xud7V9hHdm1mHhG5LcaqVR678ZusFSbQzSW7rm/Af
 823JGr/Nb2M/LZFXp86rjHJqfVsw7o+t4HE3UjeSo0mLaV4ShT3P6WXsvQ+9eBJMh+O3
 UhqaPKyX7Y2kTd7dTpcTnEl7zFD21AcZLVLFfoM9TUlGj8LXynGP+W9SXtAtWBGLJB6a
 I9F3M58IOqvZdIW2/G9S2QGg5gvwiO34MNTE7tNtlCidl0NEXSuPnm1NqRnAFan8CRE+
 6AyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708937646; x=1709542446;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mT94LtOI9uDDPqWj7St7l9/fVkwxxxe7GhZ8AGoPtC0=;
 b=Tr0aelpHiNDkVuObtM/9C8uqTbQD5NEg3Mx4Gq+EHe2u/csAA/TodyzXa6UN8dvekV
 j68jCXnCmWaJw/Mzr/V+JlMUvlacKpjz7TfNnjHZwGRzxqZMFKIb6YXIASCDWtBZTr4p
 /9FokinZj54pSvJiFeo6hTdGbFpGDOPmVnDS4OZHPUrob0fNo35xX7Th35DKiZaiLJYd
 LIdot6w/hFvnp8FSgsjeF01nkvajLH3KFSlDFaM7TY8tCGxAXYhQbm+2RPVea77MX7SQ
 QMciHqR0CEPscVNg7vfCklRsagYEt9WkOHDNgxjMJym5i2I27LxLiXALd2n6F2L4vKeO
 OM3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkiLQcMvlRE0tYPOnpElCHxVhNzGooMwuhqNQhv26QMJ76xHFc4ZgXXQZym2sBq6bpc5ZE4zSnMCE723AryldN6gDca34=
X-Gm-Message-State: AOJu0Yx4hDwzI0/Aiat8vppg9SdN1DDz3h2D3tdcfekJaKUMCEc6cbmx
 8BIS6sf3/UdwsWJgV/RcNzWBmnbCTSBXuxN/LwihOX9CQpugOVO7LHnCNKKUOVvOGJ8aBOQICch
 q
X-Google-Smtp-Source: AGHT+IFm/qumrh9UKQSd1i6jtSpYI85FnvsuSYZoKCULaWnXc9p9gEbJNSezMsryrVMXAjkdTsHpJw==
X-Received: by 2002:a05:6000:1b8d:b0:33d:2b3d:a02e with SMTP id
 r13-20020a0560001b8d00b0033d2b3da02emr4458954wru.46.1708937645833; 
 Mon, 26 Feb 2024 00:54:05 -0800 (PST)
Received: from [192.168.69.100] ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 by6-20020a056000098600b0033d568f8310sm7647781wrb.89.2024.02.26.00.54.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 00:54:05 -0800 (PST)
Message-ID: <ec595183-df69-4cca-a930-2308488fb0c4@linaro.org>
Date: Mon, 26 Feb 2024 09:54:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/physmem: remove redundant arg reassignment
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20240215091506.1932251-1-manos.pitsidianakis@linaro.org>
 <9cafaeae-78a2-47e6-b2f4-4ea89c2ab1a4@linaro.org>
In-Reply-To: <9cafaeae-78a2-47e6-b2f4-4ea89c2ab1a4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 15/2/24 12:09, Philippe Mathieu-Daudé wrote:
> On 15/2/24 10:15, Manos Pitsidianakis wrote:
>> Arguments `ram_block` are reassigned to local declarations `block`
>> without further use. Remove re-assignment to reduce noise.
>>
>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> ---
>>   system/physmem.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/system/physmem.c b/system/physmem.c
>> index 5e66d9ae36..d4c3bfac65 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -2154,10 +2154,8 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t 
>> length)
>>    *
>>    * Called within RCU critical section.
>>    */
>> -void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)
>> +void *qemu_map_ram_ptr(RAMBlock *block, ram_addr_t addr)
> 
> Better update the declaration in the same commit:
> 
> -- >8 --
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 177be23db7..bf4db3b374 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -2960,7 +2960,7 @@ MemTxResult flatview_read_continue(FlatView *fv, 
> hwaddr addr,
>                                      MemTxAttrs attrs, void *buf,
>                                      hwaddr len, hwaddr addr1, hwaddr l,
>                                      MemoryRegion *mr);
> -void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
> +void *qemu_map_ram_ptr(RAMBlock *block, ram_addr_t addr);

FYI this is now merged as commit aab4631a4a ("system/physmem:
remove redundant arg reassignment").

> 
>   /* Internal functions, part of the implementation of 
> address_space_read_cached
>    * and address_space_write_cached.  */
> ---
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 



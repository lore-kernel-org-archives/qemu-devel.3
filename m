Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC31C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 02:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn8Fw-0004tF-W6; Wed, 20 Mar 2024 22:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rn8Fu-0004sp-K1
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 22:34:10 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rn8Fs-0004qx-Pq
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 22:34:10 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e6ee9e3cffso349925b3a.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 19:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710988447; x=1711593247; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xYG/7pplxozutVH6xlmxbKWprHVGUb0KGnS6bDNzImw=;
 b=zOcDgP1FxGlQBYIemodLeNMdX8cSLhMzhq5OkCeMP8pKzj776HLLHMPGfTv6uoG4vH
 9NostGZu0kVWgg0t0tqKT5LnUuXwYiQ3sh5+j96NNi3Exsd318TDjZ/Plv+wjjlxb4Ve
 omw7JQhQ9rZqvs5PfUplUS7ee8nAjDwDHYRWq3SjcWAnu+VILdgpSxJOE3ax/DOXksZk
 zyNQrYFvnYpavo8kVZbqtOaIvjVBr2Atpjr+nJiezWLt0zsVRqOpMHxaKGNQkkiFRWEu
 Yu6vVgiGKdtlW6g+A67bCLvsrRZTTXKBujy/d2jnMQwJhyR8ynJbTzeiDGhHNSKJE1B8
 y/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710988447; x=1711593247;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xYG/7pplxozutVH6xlmxbKWprHVGUb0KGnS6bDNzImw=;
 b=uaf50wSl7SAtRSMsEOnmUCN5WJZhalYRQFvMj/nXd4SLiYeX7de3Ww5DKtQ7hVTqsX
 1V1u0VJUUUkh8PT7bGlaaF1YLE795L+9EEpZ/hov3zXnoFfRX5yHMYXblps7Y1+n5Sv9
 L2KcC/9apqqA2jYv6BZx1YstTsExCZHaLEXM/nCGGCXq/fx2C0raTYsU/KySDMg/9v8W
 fKkiFNXX0+scaCPBReCodV8TGLsC9OAlJlSiZOIJQlE49cCYTzg318oTl8elb/B+n+5V
 odS/ceCAtJAthG2+o9tePCXjhcQdrXcpIgBtXDCSiwYChRlx5dO4OWA/mlMV1rbzNepB
 MI1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqTlcIXTC/1029iBGOJusvJ+gSFizvLoXGXTuebjmb2hyDzbivwcyoi0hDs+7t7AqZX6ZRiYG2QYzTm3yZfBb4bdldiTA=
X-Gm-Message-State: AOJu0YyWzjWv7v+4AAiTnAbl1mDLip30gongYrEleRmzflbV8P5QoNuh
 +rYijOINRnUy+zYLH24vit7s/uCBAYn1h/CE2zLf2vGd+i8JDUAnXuASFnWRh08=
X-Google-Smtp-Source: AGHT+IHUOmbPbKmPVa0vt2GOPS6Gc6ylFyMKZaHtl9tKgy6OzNG3MHmi3LWEbGgjDhwlxW3/ppze8w==
X-Received: by 2002:a05:6a00:182a:b0:6e7:82e2:87dd with SMTP id
 y42-20020a056a00182a00b006e782e287ddmr2392388pfa.0.1710988447057; 
 Wed, 20 Mar 2024 19:34:07 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 ks11-20020a056a004b8b00b006e647059cccsm12406016pfb.33.2024.03.20.19.34.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 19:34:06 -0700 (PDT)
Message-ID: <70513c91-cc10-4e64-9e9e-c48aad7dd822@linaro.org>
Date: Wed, 20 Mar 2024 16:34:03 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] target/i386: Enable page walking from MMIO memory
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gregory.price@memverge.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, linuxarm@huawei.com
References: <20240307155304.31241-1-Jonathan.Cameron@huawei.com>
 <20240307155304.31241-2-Jonathan.Cameron@huawei.com>
 <731fa1ad-5831-4b94-bea4-c57bce01a260@linaro.org>
In-Reply-To: <731fa1ad-5831-4b94-bea4-c57bce01a260@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

Paolo, ping!

On 3/13/24 09:30, Richard Henderson wrote:
> On 3/7/24 05:53, Jonathan Cameron wrote:
>> From: Gregory Price <gregory.price@memverge.com>
>>
>> CXL emulation of interleave requires read and write hooks due to
>> requirement for subpage granularity. The Linux kernel stack now enables
>> using this memory as conventional memory in a separate NUMA node. If a
>> process is deliberately forced to run from that node
>> $ numactl --membind=1 ls
>> the page table walk on i386 fails.
>>
>> Useful part of backtrace:
>>
>>      (cpu=cpu@entry=0x555556fd9000, fmt=fmt@entry=0x555555fe3378 "cpu_io_recompile: 
>> could not find TB for pc=%p")
>>      at ../../cpu-target.c:359
>>      (retaddr=0, addr=19595792376, attrs=..., xlat=<optimized out>, cpu=0x555556fd9000, 
>> out_offset=<synthetic pointer>)
>>      at ../../accel/tcg/cputlb.c:1339
>>      (cpu=0x555556fd9000, full=0x7fffee0d96e0, ret_be=ret_be@entry=0, addr=19595792376, 
>> size=size@entry=8, mmu_idx=4, type=MMU_DATA_LOAD, ra=0) at ../../accel/tcg/cputlb.c:2030
>>      (cpu=cpu@entry=0x555556fd9000, p=p@entry=0x7ffff56fddc0, mmu_idx=<optimized out>, 
>> type=type@entry=MMU_DATA_LOAD, memop=<optimized out>, ra=ra@entry=0) at 
>> ../../accel/tcg/cputlb.c:2356
>>      (cpu=cpu@entry=0x555556fd9000, addr=addr@entry=19595792376, oi=oi@entry=52, 
>> ra=ra@entry=0, access_type=access_type@entry=MMU_DATA_LOAD) at 
>> ../../accel/tcg/cputlb.c:2439
>>      at ../../accel/tcg/ldst_common.c.inc:301
>>      at ../../target/i386/tcg/sysemu/excp_helper.c:173
>>      (err=0x7ffff56fdf80, out=0x7ffff56fdf70, mmu_idx=0, access_type=MMU_INST_FETCH, 
>> addr=18446744072116178925, env=0x555556fdb7c0)
>>      at ../../target/i386/tcg/sysemu/excp_helper.c:578
>>      (cs=0x555556fd9000, addr=18446744072116178925, size=<optimized out>, 
>> access_type=MMU_INST_FETCH, mmu_idx=0, probe=<optimized out>, retaddr=0) at 
>> ../../target/i386/tcg/sysemu/excp_helper.c:604
>>
>> Avoid this by plumbing the address all the way down from
>> x86_cpu_tlb_fill() where is available as retaddr to the actual accessors
>> which provide it to probe_access_full() which already handles MMIO accesses.
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Gregory Price <gregory.price@memverge.com>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>> v3: No change.
> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2180
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2220
> 
> 
> r~



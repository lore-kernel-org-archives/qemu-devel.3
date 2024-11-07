Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC54D4335B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 12:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t926A-0004Ft-Ki; Thu, 07 Nov 2024 07:58:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t9268-0004FO-2T
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 07:58:52 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t9265-0006RF-Kt
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 07:58:51 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7ee4c57b037so748360a12.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 04:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730984327; x=1731589127; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KGuVbS5asxDoJXbzOIuOfKfflFy5lpVmMa6aCe6HTyc=;
 b=SvPr8YlbKM13xrz17F0gczMr8H85eP364ZC3nRwDYY+9xT59ZAw8fBUXGUVExt7DJZ
 +gZa8YkhauPmsjGqzHXhcy38/moUoULRctNAaZ4+Lza4Y19EAGueBklQ0EaNZTl7huhg
 71+43lHt5BPbe4YELCyRYJ5CuwNpo29sv16M4PZBlpuawlowqzDJo4vnDsbKyaKQAYLw
 9+Zu7okTdcRlX12tKNGK/UX4lSvykzmRMnusoJHn8D37MNBP0xDg8MSn0ftdEzZ0//ov
 t63COOSHf3qikatdAf6to5dipEu25vFJCxwKURB7lPEpWSB4kSJ2+xan6Y+cR73dLL+Q
 295g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730984327; x=1731589127;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KGuVbS5asxDoJXbzOIuOfKfflFy5lpVmMa6aCe6HTyc=;
 b=eUBisjhlZVzhjD/hdIy+17UxSARP2nfp8mtdbDsbZ4qigq74bwh2HrBXopG0r1Bua/
 +7s/MeSxftTeoQ+ek9FwD5AvHRQYYlEm4FyHh1AogoCCDad4/DDq007AUmPM5eOHussT
 IWYV91O61vFGV8BY1uysi5CCPtWAKzQH+lRfs0Iph7gORk2QsNFzsXDYvhaq/rcmFSvi
 lf4aK5nY5vYAng+7r7nMbVF3GjVtbXfq1nsjhYIZPYKkxObnV/yGXygHHuZh5HMTh3mX
 BbMPR/x073XeYA+R9eiU8N4PxhuiedDtGiMt710V2gTQsAE81bbUvcn5hqzt67mUUJ0W
 VKNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlEPluUuyrk0xuWIqXpWbgLSAu8+QVO70p1rofyUQKofKaBb2vK6QHMknEnqIgAfEtdxp7s7p4dges@nongnu.org
X-Gm-Message-State: AOJu0YyCZOfGR/REWpAy7ikkyErOfImkAf3i4jyqZFf4bKxuUrV1fuDT
 7AsggCN+RctQ12/r43IDIpJGDT8lr4DXawKPG7hDNP0/x0ieyIO7WU/9RCNyo+E=
X-Google-Smtp-Source: AGHT+IEp4tTI+YWthjDBPzFUQb7I5UVgQ8+dlr3ic3YbsYW7k6IiRigh/HZ0qqVNih28QaTqsgJcbg==
X-Received: by 2002:a05:6a20:2d13:b0:1d4:fc66:30e8 with SMTP id
 adf61e73a8af0-1dba521914amr31018010637.10.1730984327161; 
 Thu, 07 Nov 2024 04:58:47 -0800 (PST)
Received: from ?IPV6:2804:7f0:bdcd:fb00:6501:2693:db52:c621?
 ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724079aa8efsm1473483b3a.124.2024.11.07.04.58.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 04:58:46 -0800 (PST)
Message-ID: <6b06b532-c53f-4b5b-b65d-d54d7c746ffc@ventanamicro.com>
Date: Thu, 7 Nov 2024 09:58:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 2/2] target/riscv: rvv: improve performance of RISC-V
 vector loads and stores on large amounts of data.
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Savini <paolo.savini@embecosm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>
References: <20241029194348.59574-1-paolo.savini@embecosm.com>
 <20241029194348.59574-3-paolo.savini@embecosm.com>
 <7a046c99-c4e7-4395-8dc9-9139e9bfba06@linaro.org>
 <96e7601d-14aa-4741-8f6a-ae4a1c397a44@embecosm.com>
 <54c99505-21ef-422c-a7fe-a2d7dabc3d6c@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <54c99505-21ef-422c-a7fe-a2d7dabc3d6c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 11/4/24 9:48 AM, Richard Henderson wrote:
> On 10/30/24 15:25, Paolo Savini wrote:
>> Thanks for the review Richard.
>>
>> On 10/30/24 11:40, Richard Henderson wrote:
>>> On 10/29/24 19:43, Paolo Savini wrote:
>>>> This patch optimizes the emulation of unit-stride load/store RVV instructions
>>>> when the data being loaded/stored per iteration amounts to 16 bytes or more.
>>>> The optimization consists of calling __builtin_memcpy on chunks of data of 16
>>>> bytes between the memory address of the simulated vector register and the
>>>> destination memory address and vice versa.
>>>> This is done only if we have direct access to the RAM of the host machine,
>>>> if the host is little endiand and if it supports atomic 128 bit memory
>>>> operations.
>>>>
>>>> Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
>>>> ---
>>>>   target/riscv/vector_helper.c    | 17 ++++++++++++++++-
>>>>   target/riscv/vector_internals.h | 12 ++++++++++++
>>>>   2 files changed, 28 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
>>>> index 75c24653f0..e1c100e907 100644
>>>> --- a/target/riscv/vector_helper.c
>>>> +++ b/target/riscv/vector_helper.c
>>>> @@ -488,7 +488,22 @@ vext_group_ldst_host(CPURISCVState *env, void *vd, uint32_t byte_end,
>>>>       }
>>>>         fn = fns[is_load][group_size];
>>>> -    fn(vd, byte_offset, host + byte_offset);
>>>> +
>>>> +    /* __builtin_memcpy uses host 16 bytes vector loads and stores if supported.
>>>> +     * We need to make sure that these instructions have guarantees of atomicity.
>>>> +     * E.g. x86 processors provide strong guarantees of atomicity for 16-byte
>>>> +     * memory operations if the memory operands are 16-byte aligned */
>>>> +    if (!HOST_BIG_ENDIAN && (byte_offset + 16 < byte_end) &&
>>>> +            ((byte_offset % 16) == 0) && HOST_128_ATOMIC_MEM_OP) {
>>>> +      group_size = MO_128;
>>>> +      if (is_load) {
>>>> +        __builtin_memcpy((uint8_t *)(vd + byte_offset), (uint8_t *)(host + byte_offset), 16);
>>>> +      } else {
>>>> +        __builtin_memcpy((uint8_t *)(host + byte_offset), (uint8_t *)(vd + byte_offset), 16);
>>>> +      }
>>>
>>> I said this last time and I'll say it again:
>>>
>>>     __builtin_memcpy DOES NOT equal VMOVDQA
>> I am aware of this. I took __builtin_memcpy as a generic enough way to emulate loads and stores that should allow several hosts to generate the widest load/store instructions they can and on x86 I see this generates instructions vmovdpu/movdqu that are not always guaranteed to be atomic. x86 though guarantees them to be atomic if the memory address is aligned to 16 bytes.
> 
> No, AMD guarantees MOVDQU is atomic if aligned, Intel does not.
> See the comment in util/cpuinfo-i386.c, and the two CPUINFO_ATOMIC_VMOVDQ[AU] bits.
> 
> See also host/include/*/host/atomic128-ldst.h, HAVE_ATOMIC128_RO, and atomic16_read_ro.
> Not that I think you should use that here; it's complicated, and I think you're better off relying on the code in accel/tcg/ when more than byte atomicity is required.
>

Not sure if that's what you meant but I didn't find any clear example of
multi-byte atomicity using qatomic_read() and friends that would be closer
to what memcpy() is doing here. I found one example in bdrv_graph_co_rdlock()
that seems to use a mem barrier via smp_mb() and qatomic_read() inside a
loop, but I don't understand that code enough to say.

I'm also wondering if a common pthread_lock() wrapping up these memcpy() calls
would suffice in this case. Even if we can't guarantee that __builtin_memcpy()
will use arch specific vector insns in the host it would already be a faster
path than falling back to fn(...).

In a quick detour, I'm not sure if we really considered how ARM SVE implements these
helpers. E.g gen_sve_str():

https://gitlab.com/qemu-project/qemu/-/blob/master/target/arm/tcg/translate-sve.c#L4182

I'm curious to see if this form of front end optimization, use TCG ops
instead of a for() loop with ldst_elem() like we're doing today,  would yield more
performance with less complication with backend specifics, atomicity and whatnot.
In fact I have a feeling this is not the first time we talk about using ideas from
SVE too.


Thanks,

Daniel



  
> 
> r~


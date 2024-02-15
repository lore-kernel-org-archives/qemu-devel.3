Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE28C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafpx-0000KZ-IQ; Thu, 15 Feb 2024 12:47:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rafpw-0000Hb-9t
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:47:52 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rafpu-0007aG-EJ
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:47:52 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e10746c6f4so934792b3a.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708019269; x=1708624069; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k6nK9opyUiKn1IAvmhW8Rr4zK/O57SgCCYGmeXNKs0Q=;
 b=mH64GxxqyOmm2NTZ1ArY6JWyCy7F5xNsR7EzLmi0l5VQOQd0+0E3LSdMlodMMf8aw3
 q/WHYPougzVMOt5EK0442uEW+t1qyQ6Nlzcb7ifI70xfl4/obZkmsBuivrn72fQS55Ex
 dSSfVPli8g4AABoldMP1y5OQBY6RZf1AeF9TDjzuFIgywbg6lCiyd9JIAg7RQ8EC7aCM
 Gnqsw5U6pusGR4udUXnk8FdiylnIcNKhTwJL3grgqV9cRztXA5f8Nu32vHsPK2WUnPGp
 NgR62jFnibDnKDbMucNBW+noTPQ/JVNp4aJlzxKiLCWTOc9sC2PtWSk5zzLiEW2KQpAJ
 4XDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708019269; x=1708624069;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k6nK9opyUiKn1IAvmhW8Rr4zK/O57SgCCYGmeXNKs0Q=;
 b=Rr5T+zEC/lwUZz7wnuIK0+T9yQbmvKyj6E3jiM1Tzx4whyKpmi1VaRUoORr54LsgPU
 h09bXTo4uVJYDBn6CrcanPpjk/7y46S1dsmD1LFMyZbKyTdsFzK7AMGwa3s8Z0dMx6vZ
 ZeT5mhfYi2+p+zjnhuNfepjQaAVWTukIvLQZQO3vyjIK/aDpBai1vXmgWG2Hu20Hz3m5
 VsDEeISexfL1FCjhOKpUc6OxUHGIM88kV3x/z1Xkwpb/jqrEf9kQLS80+By6YUcMX31+
 KzPIjuA8RqLz+ymAtjKg7EI9kH23Lx4e3R4fkbV3D8Zqy8k/GIK/7KCYFaHmcYJf2WfI
 z+3g==
X-Gm-Message-State: AOJu0YzAn32fh+lGUlEiByJ7ImeFByyO9YK9LAnDXJigx/2Zj1ZPDRIC
 jlDHkVVoBGnLcMwa6bdH1TkoB02YbHG+g7LIqAZrT1m+NagDtpDYQ56qaN2T0dDuQfLgYqKSIbC
 g
X-Google-Smtp-Source: AGHT+IGEq1PqmZwugDBB3fYpKZQhdJQX8+lWlDSGtXO0SALoYg0Bx0cqjy8WgDOveX6FWBrYIgvmJQ==
X-Received: by 2002:a05:6a21:1799:b0:1a0:56c9:608e with SMTP id
 nx25-20020a056a21179900b001a056c9608emr3045420pzb.61.1708019268686; 
 Thu, 15 Feb 2024 09:47:48 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 f5-20020a056a000b0500b006dfbecb5027sm1678726pfu.171.2024.02.15.09.47.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 09:47:48 -0800 (PST)
Message-ID: <6499be56-2002-44b3-9c53-1a1ec2fde53f@linaro.org>
Date: Thu, 15 Feb 2024 07:47:45 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/10] util/bufferiszero: Add simd acceleration for
 aarch64
Content-Language: en-US
To: Alexander Monakov <amonakov@ispras.ru>
Cc: qemu-devel@nongnu.org, mmromanov@ispras.ru
References: <20240215081449.848220-1-richard.henderson@linaro.org>
 <20240215081449.848220-10-richard.henderson@linaro.org>
 <1f038576-5121-e84c-8196-ae5f9ca3a75b@ispras.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <1f038576-5121-e84c-8196-ae5f9ca3a75b@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 2/14/24 22:47, Alexander Monakov wrote:
> 
> On Wed, 14 Feb 2024, Richard Henderson wrote:
> 
>> Because non-embedded aarch64 is expected to have AdvSIMD enabled, merely
>> double-check with the compiler flags for __ARM_NEON and don't bother with
>> a runtime check.  Otherwise, model the loop after the x86 SSE2 function,
>> and use VADDV to reduce the four vector comparisons.
> 
> I am not very familiar with Neon but I wonder if this couldn't use SHRN
> for the final 128b->64b reduction similar to 2022 Glibc optimizations:
> https://inbox.sourceware.org/libc-alpha/20220620174628.2820531-1-danilak@google.com/

The reason they use SHRN for memchr is that they have also applied a mask
to the comparison so that they can identify which byte contained the match.
That is not required here, so any reduction will do.


> In git history I see the previous Neon buffer_is_zero was removed because
> it was not faster. Is it because integer LDP was as good as vector loads
> at saturating load bandwidth on older cores, and things are different now?

The old reduction was a bit silly,

-#define DO_NONZERO(X)  (vgetq_lane_u64((X), 0) | vgetq_lane_u64((X), 1))

performing two cross-register-set fetches.  It's also possible that we were saturating the 
load bandwidth on the old mustang.  This time I'm testing on a neoverse-n1, which is quite 
a few years newer.

The loop kernel compiles to this:

  19c:   ad401c20        ldp     q0, q7, [x1]
  1a0:   ad411823        ldp     q3, q6, [x1, #32]
  1a4:   ad421421        ldp     q1, q5, [x1, #64]
  1a8:   ad431022        ldp     q2, q4, [x1, #96]
  1ac:   91020021        add     x1, x1, #0x80
  1b0:   4ea71c00        orr     v0.16b, v0.16b, v7.16b
  1b4:   4ea61c63        orr     v3.16b, v3.16b, v6.16b
  1b8:   4ea51c21        orr     v1.16b, v1.16b, v5.16b
  1bc:   4ea41c42        orr     v2.16b, v2.16b, v4.16b
  1c0:   4ea31c00        orr     v0.16b, v0.16b, v3.16b
  1c4:   4ea21c21        orr     v1.16b, v1.16b, v2.16b
  1c8:   4ea11c00        orr     v0.16b, v0.16b, v1.16b
  1cc:   eb03003f        cmp     x1, x3
  1d0:   54000162        b.cs    1fc <buffer_is_zero_simd+0xb8>  // b.hs, b.nlast
  1d4:   4ea09800        cmeq    v0.4s, v0.4s, #0
  1d8:   4eb1b800        addv    s0, v0.4s
  1dc:   1e260000        fmov    w0, s0
  1e0:   3100101f        cmn     w0, #0x4
  1e4:   54fffdc0        b.eq    19c <buffer_is_zero_simd+0x58>  // b.none


r~

> 
> Alexander
> 
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   util/bufferiszero.c | 74 +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 74 insertions(+)
>>
>> diff --git a/util/bufferiszero.c b/util/bufferiszero.c
>> index 4eef6d47bc..2809b09225 100644
>> --- a/util/bufferiszero.c
>> +++ b/util/bufferiszero.c
>> @@ -214,7 +214,81 @@ bool test_buffer_is_zero_next_accel(void)
>>       }
>>       return false;
>>   }
>> +
>> +#elif defined(__aarch64__) && defined(__ARM_NEON)
>> +#include <arm_neon.h>
>> +
>> +#define REASSOC_BARRIER(vec0, vec1) asm("" : "+w"(vec0), "+w"(vec1))
>> +
>> +static bool buffer_is_zero_simd(const void *buf, size_t len)
>> +{
>> +    uint32x4_t t0, t1, t2, t3;
>> +
>> +    /* Align head/tail to 16-byte boundaries.  */
>> +    const uint32x4_t *p = QEMU_ALIGN_PTR_DOWN(buf + 16, 16);
>> +    const uint32x4_t *e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 16);
>> +
>> +    /* Unaligned loads at head/tail.  */
>> +    t0 = vld1q_u32(buf) | vld1q_u32(buf + len - 16);
>> +
>> +    /* Collect a partial block at tail end.  */
>> +    t1 = e[-7] | e[-6];
>> +    t2 = e[-5] | e[-4];
>> +    t3 = e[-3] | e[-2];
>> +    t0 |= e[-1];
>> +    REASSOC_BARRIER(t0, t1);
>> +    REASSOC_BARRIER(t2, t3);
>> +    t0 |= t1;
>> +    t2 |= t3;
>> +    REASSOC_BARRIER(t0, t2);
>> +    t0 |= t2;
>> +
>> +    /*
>> +     * Loop over complete 128-byte blocks.
>> +     * With the head and tail removed, e - p >= 14, so the loop
>> +     * must iterate at least once.
>> +     */
>> +    do {
>> +        /* Each comparison is [-1,0], so reduction is in [-4..0]. */
>> +        if (unlikely(vaddvq_u32(vceqzq_u32(t0)) != -4)) {
>> +            return false;
>> +        }
>> +
>> +        t0 = p[0] | p[1];
>> +        t1 = p[2] | p[3];
>> +        t2 = p[4] | p[5];
>> +        t3 = p[6] | p[7];
>> +        REASSOC_BARRIER(t0, t1);
>> +        REASSOC_BARRIER(t2, t3);
>> +        t0 |= t1;
>> +        t2 |= t3;
>> +        REASSOC_BARRIER(t0, t2);
>> +        t0 |= t2;
>> +        p += 8;
>> +    } while (p < e - 7);
>> +
>> +    return vaddvq_u32(vceqzq_u32(t0)) == -4;
>> +}
>> +
>> +static biz_accel_fn const accel_table[] = {
>> +    buffer_is_zero_int_ge256,
>> +    buffer_is_zero_simd,
>> +};
>> +
>> +static unsigned accel_index = 1;
>> +#define INIT_ACCEL buffer_is_zero_simd
>> +
>> +bool test_buffer_is_zero_next_accel(void)
>> +{
>> +    if (accel_index != 0) {
>> +        buffer_is_zero_accel = accel_table[--accel_index];
>> +        return true;
>> +    }
>> +    return false;
>> +}
>> +
>>   #else
>> +
>>   bool test_buffer_is_zero_next_accel(void)
>>   {
>>       return false;
>>



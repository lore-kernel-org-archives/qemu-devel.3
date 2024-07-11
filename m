Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F28C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 15:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRvkQ-0005aK-Sw; Thu, 11 Jul 2024 11:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRvkP-0005Yl-B1
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 11:30:17 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRvkN-0002R5-5t
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 11:30:16 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-70af5fbf0d5so734937b3a.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 08:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720711813; x=1721316613; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bETxq6ytYgakkzaYEcWOgx3WVqCfrMTSEGiPhPvQzIw=;
 b=kxqNssu9awBiY2S4ixQ7hKXE8HADLuDjuTxCTSPIohdptd/kDcGpN4MxF0C6bmQGEa
 Mhy+T44wcxKTtNVad4tkRBVubEcR+04rFX1+OTV89PN5iurBSeKzeFM0jJGmY5AD/P1w
 XHxZC7bLLtKzroh90LiMVZJBMin+BT3ZxjmH3PlpWg2mHXExkhkwGIJh3ZDKHHg8aUp2
 yzqF3cFwofwZi4lJWTPIANSmM7KgisCpiNL7Dj5RsQGwoQVM+O3HabeSSGylwFyViVmd
 W9ixTdoKX8bt5G5mKaG9AQpDgit5S7ImcvMTDjHE591b88VIQcHjG7/cVEZwu/so8PKG
 HPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720711813; x=1721316613;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bETxq6ytYgakkzaYEcWOgx3WVqCfrMTSEGiPhPvQzIw=;
 b=QxK0lqJXXT+MmDnkqvIDhRoOrgyU6Zh4FmyuoWVLUg9pyZkjYh0ouCd3/SwRQnhMV0
 GdajKLk6YJR0h3IlQ7xpwUKeLZdJoRYHDFb93OBFuRGlHqUF69ZW+XKpoudmQenolBk8
 45x84YSNt3tBrlDqxoHzn9FS2YjTFryVNI/WIgO5S2NYMRgirkkumyeoDGi9OwIcSg2F
 m84QTUGNzsgNCKfb+bGjf1oi4XHGLJYz/JRX9iF2rrFCmXnLIf3DfIYFDQ7SdAmJrytw
 RqACzC9D0uGKXBfkFFJ6tTUPGuZlwYvYMN1H+l7uvvwj+QjEQZgRHbRQ22DQy+Oa6hVD
 i2IQ==
X-Gm-Message-State: AOJu0Yw5GMwzZ0NHdMre8s4tU8ZGWBeRcLXOWc5/leRQJct5J2aQftX2
 q8Sb+uMvrm+MqEWdkXTTFkdGridc5r6/AxI+A6KolPl2meFdC2qo7u4/wrY8ZcQ=
X-Google-Smtp-Source: AGHT+IH0NuTml2YQRvUsgrYiwZqlKz6FUVisinUXBWMFEJI9h93FCsn2jAiur1McCzWqSDDeBEc6gQ==
X-Received: by 2002:a05:6a00:8118:b0:70a:ee81:2fa2 with SMTP id
 d2e1a72fcca58-70b6c864f74mr34414b3a.2.1720711813043; 
 Thu, 11 Jul 2024 08:30:13 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b439686c1sm5817360b3a.100.2024.07.11.08.30.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 08:30:12 -0700 (PDT)
Message-ID: <7ae80428-0f39-4914-bcfb-0fa0be0e57e4@linaro.org>
Date: Thu, 11 Jul 2024 08:30:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] target/i386/tcg: use X86Access for TSS access
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Robert Henry <rrh.henry@gmail.com>
References: <20240710062920.73063-1-pbonzini@redhat.com>
 <20240710062920.73063-10-pbonzini@redhat.com>
 <293864db-8a3e-4585-abf1-da2b11990b43@linaro.org>
 <CABgObfbBz9Oq=L1XCUaXGwp-7Q5FWQFp4Ld=b8Twyi0ymSrYpQ@mail.gmail.com>
 <e3e7f92c-94ef-4478-99e5-c162fd4b9136@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e3e7f92c-94ef-4478-99e5-c162fd4b9136@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/10/24 23:28, Paolo Bonzini wrote:
> On 7/10/24 20:40, Paolo Bonzini wrote:
>>
>>
>> Il mer 10 lug 2024, 18:47 Richard Henderson <richard.henderson@linaro.org 
>> <mailto:richard.henderson@linaro.org>> ha scritto:
>>
>>     On 7/9/24 23:29, Paolo Bonzini wrote:
>>      > This takes care of probing the vaddr range in advance, and is
>>     also faster
>>      > because it avoids repeated TLB lookups.  It also matches the
>>     Intel manual
>>      > better, as it says "Checks that the current (old) TSS, new TSS,
>>     and all
>>      > segment descriptors used in the task switch are paged into system
>>     memory";
>>      > note however that it's not clear how the processor checks for segment
>>      > descriptors, and this check is not included in the AMD manual.
>>      >
>>      > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com
>>     <mailto:pbonzini@redhat.com>>
>>      > ---
>>      >   target/i386/tcg/seg_helper.c | 101
>>     ++++++++++++++++++-----------------
>>      >   1 file changed, 51 insertions(+), 50 deletions(-)
>>      >
>>      > diff --git a/target/i386/tcg/seg_helper.c
>>     b/target/i386/tcg/seg_helper.c
>>      > index 25af9d4a4ec..77f2c65c3cf 100644
>>      > --- a/target/i386/tcg/seg_helper.c
>>      > +++ b/target/i386/tcg/seg_helper.c
>>      > @@ -311,35 +313,44 @@ static int switch_tss_ra(CPUX86State *env,
>>     int tss_selector,
>>      >           raise_exception_err_ra(env, EXCP0A_TSS, tss_selector &
>>     0xfffc, retaddr);
>>      >       }
>>      >
>>      > +    /* X86Access avoids memory exceptions during the task switch */
>>      > +    access_prepare_mmu(&old, env, env->tr.base, old_tss_limit_max,
>>      > +                    MMU_DATA_STORE, cpu_mmu_index_kernel(env),
>>     retaddr);
>>      > +
>>      > +    if (source == SWITCH_TSS_CALL) {
>>      > +        /* Probe for future write of parent task */
>>      > +        probe_access(env, tss_base, 2, MMU_DATA_STORE,
>>      > +                  cpu_mmu_index_kernel(env), retaddr);
>>      > +    }
>>      > +    access_prepare_mmu(&new, env, tss_base, tss_limit,
>>      > +                    MMU_DATA_LOAD, cpu_mmu_index_kernel(env),
>>     retaddr);
>>
>>     You're computing cpu_mmu_index_kernel 3 times.
> 
> Squashing this in (easier to review than the whole thing):

Excellent, thanks!


r~

> 
> diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
> index 4123ff1245e..4edfd26135f 100644
> --- a/target/i386/tcg/seg_helper.c
> +++ b/target/i386/tcg/seg_helper.c
> @@ -321,7 +321,7 @@ static void switch_tss_ra(CPUX86State *env, int tss_selector,
>       uint32_t new_eflags, new_eip, new_cr3, new_ldt, new_trap;
>       uint32_t old_eflags, eflags_mask;
>       SegmentCache *dt;
> -    int index;
> +    int mmu_index, index;
>       target_ulong ptr;
>       X86Access old, new;
> 
> @@ -378,16 +378,17 @@ static void switch_tss_ra(CPUX86State *env, int tss_selector,
>       }
> 
>       /* X86Access avoids memory exceptions during the task switch */
> +    mmu_index = cpu_mmu_index_kernel(env);
>       access_prepare_mmu(&old, env, env->tr.base, old_tss_limit_max,
> -               MMU_DATA_STORE, cpu_mmu_index_kernel(env), retaddr);
> +               MMU_DATA_STORE, mmu_index, retaddr);
> 
>       if (source == SWITCH_TSS_CALL) {
>           /* Probe for future write of parent task */
>           probe_access(env, tss_base, 2, MMU_DATA_STORE,
> -             cpu_mmu_index_kernel(env), retaddr);
> +             mmu_index, retaddr);
>       }
>       access_prepare_mmu(&new, env, tss_base, tss_limit,
> -               MMU_DATA_LOAD, cpu_mmu_index_kernel(env), retaddr);
> +               MMU_DATA_LOAD, mmu_index, retaddr);
> 
>       /* read all the registers from the new TSS */
>       if (type & 8) {
> @@ -468,7 +469,11 @@ static void switch_tss_ra(CPUX86State *env, int tss_selector,
>          context */
> 
>       if (source == SWITCH_TSS_CALL) {
> -        cpu_stw_kernel_ra(env, tss_base, env->tr.selector, retaddr);
> +        /*
> +         * Thanks to the probe_access above, we know the first two
> +         * bytes addressed by &new are writable too.
> +         */
> +        access_stw(&new, tss_base, env->tr.selector);
>           new_eflags |= NT_MASK;
>       }
> 
> Paolo
> 



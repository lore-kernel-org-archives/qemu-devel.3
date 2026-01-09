Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64813D26D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFEU-000220-PJ; Fri, 09 Jan 2026 11:21:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1veFER-00021l-7B
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:20:59 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1veFEO-0002SJ-DT
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:20:58 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-29f1bc40b35so51149845ad.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767975654; x=1768580454; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aY19eyqxM/HKPNjuy0Paw72HYYx5/3R6KegH8ibdJJk=;
 b=mZtX2/Q0K+E1Ftzmo3OyYGza3bpZ08AWGsW3+RIyVYh648pR9bt5a+gdPzA1+FIiiQ
 WrNuGjuK3Bu0xz4qgNIPWANbvhE4sPBeZSi55IY5q4DQu8PM+ENOedJxXxM649g2t2D2
 1cCxzSVmJgGxUmq3i+7RCoVTnJy2R4zduEll5PEe30UThhuGzxE7huhc9hnD3+rWUyv7
 aVTGTdpQfAwYVFJUksrSzo7pLvBVS4NRluGNXgv/+G6vADgj1h8XKiVII6PO6RtJEt0W
 P92ySPy1UCU8SDKLPdcD6O80X7x+VgMVPL0oCCK9ZMLgmd9M/dDc3eSicx2504es9VS+
 WVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767975654; x=1768580454;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aY19eyqxM/HKPNjuy0Paw72HYYx5/3R6KegH8ibdJJk=;
 b=wqzXQYZzw69CPbZNOihP/2+Qi5AjfZRF6+gSdkGolQYt1iNsuygI/c3bGJ2yQZUJzV
 YlC2xqKeJ+su1/gjb/cRZ6kdz49/1t6QNOKY/uyZxXpvjJgGpsDG+CzsWCcVE9dn1pWl
 4t4qRsBiGnq6KYRhZjx9dsBX+Rp27HBP4VL/3MZ21NIwhuFi5TBPF/wKBL6ySg0Fm5xF
 6fSv9uRxQMfDi8H9gZkzxKHnX/OoFmwLvlJtNDOG2XClhfap5oB8tKPmH4dSI7AeWWEI
 g1Mhwr7wYkjm9WWjaMqQosFCdGp2Mt3zBYRvBcT/0X8/cC/F2TQUaTzSiOSubLoR6EFQ
 uczw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLkLioV0+iPizF1FoOKxV6CGx6JW8mYlVVBLYOdiYgia9SLnYyLhzlvNFotFoAVzyhVz1rLK7qhjHt@nongnu.org
X-Gm-Message-State: AOJu0YzxOgkd8cz6GCu23wKpetDPNvigpO084bElebjBVrlTTwItSsEa
 o04xFrfJYAbiBwYxEBltP7YEZoAADAdTAHZl8bpNw+lzy8Snu6/0jwqVFpDTOTaKBBM=
X-Gm-Gg: AY/fxX4PXpnx+GMrLGWMt21YOVE114CodrLIRzYM/ZUDV4CNYkj/Zvdq0PnumeRzQLQ
 2urJCScc0r1LwXh5VlySFYJ2/MFls+84JOYQWBoS0MJIufgX7skfQ5mU3RriW3nYamzHJypN6+1
 trTUMIRBX6e1WhdSdDYgIY+YZcTRXtfs2Qs89vE9aipuDluC6S8CgoAinB5nTGOrxBJAgPI9+Pj
 BThtv/JDTLfneDzdlHRWMDQGUXzXD5rwKewG/8++O6EY8snPGEjQ9V7KgrcvgGcLMRHORA9t0q6
 3iSCbUSrF7uAxK54RerGwFLAymlHFEJOp9zWKTEymGjkWd4dOeMGe9oQVB3JcqO7dBA2xDZHFFV
 rywJnmYv5ot3MdZYVSuYs/ie3GBvuoagqa0o5/q2Fd/TisIJmTUcjSTbhhQ+3cwT5a7N6mu8IBT
 rLOV/LuIjZZNl2i98aJUOAA9gkxlqnNOx8seCFVXjm7BwYEtYT8IKqLlep
X-Google-Smtp-Source: AGHT+IFU/tSwJd+SZ0Voy8mrRZ1nfK4qNwS7WetdYFwNKSy5vj4LvTpOcDgWsqejbmL6ty7qxCQlMg==
X-Received: by 2002:a17:902:dace:b0:264:70da:7a3b with SMTP id
 d9443c01a7336-2a3ee49b58amr103235275ad.49.1767975654001; 
 Fri, 09 Jan 2026 08:20:54 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c49299sm108205055ad.42.2026.01.09.08.20.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 08:20:53 -0800 (PST)
Message-ID: <13d81894-53c2-4fda-86da-c9ec484c6ef3@linaro.org>
Date: Fri, 9 Jan 2026 08:20:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/29] include/tcg/tcg-op.h: introduce TARGET_ADDRESS_BITS
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-15-pierrick.bouvier@linaro.org>
 <5883ace8-ec8c-4632-9761-615462582254@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <5883ace8-ec8c-4632-9761-615462582254@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 1/9/26 7:36 AM, Paolo Bonzini wrote:
> On 1/9/26 06:31, Pierrick Bouvier wrote:
>> This define will be used to replace TARGET_LONG_BITS in tcg-op-*
>> headers. The goal here is to allow a compilation unit to set explicitely
>> which variant of the arch it's targeting (32 vs 64 bits).
>>
>> By default, we simple let it defined as TARGET_LONG_BITS, so existing
>> code does not need to be changed, and we can progressively convert new
>> files.
>>
>> target/arm/tcg/* files are cleanly splitted between 32 and 64 bits (with
>> some TARGET_AARCH64 defines). For other arch, this is a work that will
>> have to be done before converting them.
> 
> ARM is pretty special in this regard because it has separate registers
> arrays regs[] and xregs[].  The other five multi-size targets (i386,
> mips, ppc, riscv, sparc) probably will *not* use target_common_arch as
> much as ARM is doing, and will keep support two TCG _tl sizes: 32 for
> the 32-bit single-target binaries, 64 for the 64-bit single-target
> binaries and for the single multi-target binary.
>

That's a point we raised when talking about it with Richard. Indeed, 
some other arch will require further changes.

> For them, the death of target_long/target_ulong is not really possible,
> because they will have to reinvent include/exec/target_long.h for their
> CPUStates.
>

At this time, I don't have a simple solution to provide to workaround 
this. As long as compilation units are duplicated, you will have 
duplicated symbols for any extern symbol, thus preventing to link the 
final qemu-system binary. So duplication has to be eliminated, one way 
or another. And multiple type definitions is a barrier for this.

Any good idea is welcome.

> For the sake of this series, I would rename TARGET_ADDRESS_BITS to
> TCG_ADDRESS_BITS, add to include/tcg/tcg-op.h something like:
> 
> #if TCG_ADDRESS_BITS == 32
> typedef TCGv_i32 TCGv_addr;
> #define tcg_temp_new_addr() tcg_temp_new_i32()
> #define tcg_global_mem_new_addr tcg_global_mem_new_i32
> #define tcgv_addr_temp tcgv_i32_temp
> #define tcg_gen_qemu_ld_addr tcg_gen_qemu_ld_i32
> #define tcg_gen_qemu_st_addr tcg_gen_qemu_st_i32
> #elif TCG_ADDRESS_BITS == 64
> typedef TCGv_i64 TCGv_addr;
> #define tcg_temp_new_addr() tcg_temp_new_i64()
> #define tcg_global_mem_new_addr tcg_global_mem_new_i64
> #define tcgv_addr_temp tcgv_i64_temp
> #define tcg_gen_qemu_ld_addr tcg_gen_qemu_ld_i64
> #define tcg_gen_qemu_st_addr tcg_gen_qemu_st_i64
> #else
> #error Unhandled TARGET_LONG_BITS value
> #endif
> 
> and use TCGv_addr in tcg_gen_qemu_ld_i32 and friends.  This first step
> clearly separates (at least in the long run) target_long from TCG addresses.
>

Richard suggested to extract memory operations, of the rest, as you're 
suggesting now. So I'll do this for next version, and rename the define 
as well.

>   From the point of view of this is all I would like to see:
> TARGET_ADDRESS_BITS renamed to TCG_ADDRESS_BITS, and TCGv_addr
> introduced in include/tcg/tcg-op.h and tcg/tcg-op-ldst.c at the same
> time as TCG_ADDRESS_BITS.
> 
> In the rest of the message I'm going to describe why and what more I
> envision.
> 
> In the long run TCGv and _tl can become entirely optional, leaving the
> door open for single-size targets to use TCGv_{i32,i64,addr}
> exclusively.  For this reason, the second step (independent of this
> series) is for single-size targets, who have already mostly moved
> towards removing target_long, to remove TARGET_LONG_BITS from
> configs/targets/ altogether.  To this end I would create two files like
> this:
>

By making all files for an architecture "common", TARGET_LONG_BITS is 
eliminated by design, since it's a poisoned identifier.

> include/exec/target_long32.h
> ----------------------------
> #ifndef TARGET_LONG_BITS
> #define TARGET_LONG_BITS 32
> #endif
> #define TARGET_ADDRESS_BITS 32
> #define TARGET_LONG_SIZE 4
> typedef int32_t target_long;
> typedef uint32_t target_ulong;
> #define TARGET_FMT_lx "%08x"
> #define TARGET_FMT_ld "%d"
> #define TARGET_FMT_lu "%u"
> #define MO_TL MO_32
> 
> include/exec/target_long64.h
> ----------------------------
> #ifndef TARGET_LONG_BITS
> #define TARGET_LONG_BITS 64
> #endif
> #define TARGET_ADDRESS_BITS 64
> #define TARGET_LONG_SIZE 8
> typedef int64_t target_long;
> typedef uint64_t target_ulong;
> #define TARGET_FMT_lx "%016" PRIx64
> #define TARGET_FMT_ld "%" PRId64
> #define TARGET_FMT_lu "%" PRIu64
> #define MO_TL MO_64
> 
> ... and use them in include/exec/target_long.h:
> 
> include/exec/target_long.h:
> #ifndef TARGET_LONG_BITS
> #error TARGET_LONG_BITS not defined
> #elif TARGET_LONG_BITS == 32
> #include "exec/target_long32.h"
> #elif TARGET_LONG_BITS == 64
> #include "exec/target_long64.h"
> #endif
> 
> Then the single-size targets can replace TARGET_LONG_BITS with:
> - a "#define TCG_ADDRESS_BITS" in their translate.c
> - a #include "exec/target_longNN.h" in their cpu.h.
> 
> Dual-size targets, instead, can add to their cpu.h an initial stanza
> like this:
> 
> #ifdef TARGET_I386
> #include "exec/target_long32.h"
> #else
> #include "exec/target_long64.h" // x86_64 or single binary
> #endif
> 
> and keep using target_long.
>

I'm not sure what we gain from this header mechanics, wouldn't that be 
better to eradicate TARGET_LONG_BITS completely instead?

With Philippe, we introduced target-info.h, to precisely find this 
information at runtime, with target_long_bits().
As well, as you can see in codebase, target_long_bits() is not used in 
many places, and especially, it's not needed anywhere in target/arm. So 
it does not seem needed to keep it alive.

Thanks for the feedback,
Pierrick


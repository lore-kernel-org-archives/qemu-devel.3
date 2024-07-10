Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DACC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 16:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRaRx-0004U1-BP; Wed, 10 Jul 2024 12:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRaRr-0004TN-U0
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 12:45:47 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRaRq-0006MX-1B
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 12:45:43 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fb1ff21748so36342645ad.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 09:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720629940; x=1721234740; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/iUAUUeZIqPv04/0NaudV5uJmF8c1Eam0WiOC5XcZJE=;
 b=Z6CJZ2lEc7uxASOyWsoXmqBmY7iB7vshROaV5d59AqeQRxWbsXgaX+FB0xppkGUSt5
 0rRiMs8+lrfZKfRa+2DnwJSaQTHJb1m0ZcK8t4iNaN4l4IKOHA9yLUpNbRSwxaXQ5vS4
 IQrzGyhOEhhaBvOk/Az6UKbjNmqWOt+fqm1c8kOhn2JQ1kPcG4A8S5UKfTrjdJEhlh8X
 29nDkH1qN3voWwGe2h8zunbRbGOKW8UDgoZqU8FMrXXYpweNSfqxOvTINGIvDsPBZ2qi
 n8gaovkVLYws75uC65kb9wase7y/bcFN6PTt4Jvq+RQUcGFOnqnsK8qbvRkICcYpjBk4
 EpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720629940; x=1721234740;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/iUAUUeZIqPv04/0NaudV5uJmF8c1Eam0WiOC5XcZJE=;
 b=MeP3re4MNOJ7Yia3JXggQZecr3wyWcAUe+JSLAxYZRibXxSyubDB0f6gJDAB7dNclQ
 yC+8+Rrf0KMdHHfnro8iT0JhvkPqM+GuXNgXWCwdH/P4Pj2Nod+lKEuHEy2w1ci5HHqA
 vbrxaw2Ew9s842NPZ54Frwlnga9UUniKEyXYY70kotcbi+xtjBhUeTb9xoaMGhzroziv
 j4UKP3Rl16NCvxm1C3Ogs7Cu/9+6Hw2B9tj396W3mHW9zLDZHKNgpqCwu6jZ2DGpK0DG
 whtmQbjT2sr7lvfeoH0itYnxk38SBNkmkeucgKPg5ErfLcUTRjulPJz9eI2doG877Ojy
 B7xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVceolSEjJ0Kjhax5vhYWe/Cnt3i3pJmxJ6b+19pIPzj5UyIvkNcN3lPhZBfcbCHzB+H/ypsXfmmrj73qQBmJdd7kLzIZI=
X-Gm-Message-State: AOJu0YwyonT9FDP3yIbpZWmfNnEt4sYG3OGWXfkTU9OzPX1U2G0gynAl
 uLct6Tsl0O5OGTZJOc64CpFjxclShsal6zqMJXc456ifAoAhpOrWmnIkfcCm/o8=
X-Google-Smtp-Source: AGHT+IFslzpxa6k5BmiOliiQk0tPMIQyA0IJYUfJXxmxCkBB2MFWxcvN7hHZTnt+LqicjPv69+leww==
X-Received: by 2002:a17:902:ea0d:b0:1fb:a077:a846 with SMTP id
 d9443c01a7336-1fbb6d253b9mr40160635ad.3.1720629939727; 
 Wed, 10 Jul 2024 09:45:39 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6a1197asm35945145ad.31.2024.07.10.09.45.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 09:45:39 -0700 (PDT)
Message-ID: <293864db-8a3e-4585-abf1-da2b11990b43@linaro.org>
Date: Wed, 10 Jul 2024 09:45:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] target/i386/tcg: use X86Access for TSS access
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: rrh.henry@gmail.com
References: <20240710062920.73063-1-pbonzini@redhat.com>
 <20240710062920.73063-10-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240710062920.73063-10-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 7/9/24 23:29, Paolo Bonzini wrote:
> This takes care of probing the vaddr range in advance, and is also faster
> because it avoids repeated TLB lookups.  It also matches the Intel manual
> better, as it says "Checks that the current (old) TSS, new TSS, and all
> segment descriptors used in the task switch are paged into system memory";
> note however that it's not clear how the processor checks for segment
> descriptors, and this check is not included in the AMD manual.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/seg_helper.c | 101 ++++++++++++++++++-----------------
>   1 file changed, 51 insertions(+), 50 deletions(-)
> 
> diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
> index 25af9d4a4ec..77f2c65c3cf 100644
> --- a/target/i386/tcg/seg_helper.c
> +++ b/target/i386/tcg/seg_helper.c
> @@ -27,6 +27,7 @@
>   #include "exec/log.h"
>   #include "helper-tcg.h"
>   #include "seg_helper.h"
> +#include "access.h"
>   
>   int get_pg_mode(CPUX86State *env)
>   {
> @@ -250,7 +251,7 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
>                            uint32_t e1, uint32_t e2, int source,
>                            uint32_t next_eip, uintptr_t retaddr)
>   {
> -    int tss_limit, tss_limit_max, type, old_tss_limit_max, old_type, v1, v2, i;
> +    int tss_limit, tss_limit_max, type, old_tss_limit_max, old_type, i;
>       target_ulong tss_base;
>       uint32_t new_regs[8], new_segs[6];
>       uint32_t new_eflags, new_eip, new_cr3, new_ldt, new_trap;
> @@ -258,6 +259,7 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
>       SegmentCache *dt;
>       int index;
>       target_ulong ptr;
> +    X86Access old, new;
>   
>       type = (e2 >> DESC_TYPE_SHIFT) & 0xf;
>       LOG_PCALL("switch_tss: sel=0x%04x type=%d src=%d\n", tss_selector, type,
> @@ -311,35 +313,44 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
>           raise_exception_err_ra(env, EXCP0A_TSS, tss_selector & 0xfffc, retaddr);
>       }
>   
> +    /* X86Access avoids memory exceptions during the task switch */
> +    access_prepare_mmu(&old, env, env->tr.base, old_tss_limit_max,
> +		       MMU_DATA_STORE, cpu_mmu_index_kernel(env), retaddr);
> +
> +    if (source == SWITCH_TSS_CALL) {
> +        /* Probe for future write of parent task */
> +        probe_access(env, tss_base, 2, MMU_DATA_STORE,
> +		     cpu_mmu_index_kernel(env), retaddr);
> +    }
> +    access_prepare_mmu(&new, env, tss_base, tss_limit,
> +		       MMU_DATA_LOAD, cpu_mmu_index_kernel(env), retaddr);

You're computing cpu_mmu_index_kernel 3 times.

This appears to be conservative in that you're requiring only 2 bytes (a minimum) of 0x68 
to be writable.  Is it legal to place the TSS at offset 0xffe of page 0, with the balance 
on page 1, with page 0 writable and page 1 read-only?  Otherwise I would think you could 
just check the entire TSS for writability.

Anyway, after the MMU_DATA_STORE probe, you have proved that 'X86Access new' contains an 
address range that may be stored.  So you can change the SWITCH_TSS_CALL store below to 
access_stw() too.

> @@ -349,16 +360,6 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
>        chapters 12.2.5 and 13.2.4 on how to implement TSS Trap bit */
>       (void)new_trap;
>   
> -    /* NOTE: we must avoid memory exceptions during the task switch,
> -       so we make dummy accesses before */
> -    /* XXX: it can still fail in some cases, so a bigger hack is
> -       necessary to valid the TLB after having done the accesses */
> -
> -    v1 = cpu_ldub_kernel_ra(env, env->tr.base, retaddr);
> -    v2 = cpu_ldub_kernel_ra(env, env->tr.base + old_tss_limit_max, retaddr);
> -    cpu_stb_kernel_ra(env, env->tr.base, v1, retaddr);
> -    cpu_stb_kernel_ra(env, env->tr.base + old_tss_limit_max, v2, retaddr);

OMG.

Looks like a fantastic cleanup overall.


r~


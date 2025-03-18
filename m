Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCAEC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 23:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tugjc-0006Yq-NS; Tue, 18 Mar 2025 19:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tugjW-0006YR-JC
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 19:52:32 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tugjU-0007mT-My
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 19:52:30 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22401f4d35aso118256195ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 16:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742341947; x=1742946747; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SKHVeOYDWa4XTnzwRh4cU5pHtuwj0t2DOht+LoJAbMo=;
 b=AEbj/kKgLPHZP8lS+oQFArYvNq7hN/5DQEhXOb+4Rzl3kNbeqM984Vs26kyXWq0GUX
 gOwi+GPNDs03mfGOmnkMtx4FgjrA+eO3zDec/m0yuKGt7yMMdJvWH7ee8r/C18ts6zqm
 FcncMm8FpefPZR8LjnqepDv+Sq/YUV3hA1+Nb9DeSP6td8///vcML5rFkGYwy1XBqCrF
 PjJP9Gf0t45bJrTDgSDCTGSNjJkZmcy3GdVBjsEIU3swFAsQkVOTFCq2HIeKtWUEk1vZ
 3H9GqYnq0sRuwR4SPb8gq7z5ywS61ux4O8WyPnFaNTxPnejnABqtnW80HQH/1Ya6dkFf
 O+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742341947; x=1742946747;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SKHVeOYDWa4XTnzwRh4cU5pHtuwj0t2DOht+LoJAbMo=;
 b=keTjMzkm9pwl2VqDd7XuI97kduWEoounN6EKpvD3J6KQjQhzLAXNZCPXWdjP4tHjrP
 SkXaQwp09ANWvYS/eMaYP6Nk8/3BVVf+BfCkSwYyaKqwl+NHarLTUr6x0LA30awKjcps
 33+kB+V7RjZ/ImpLNecLYYSS4VysifNUlfG3xdLhXcPgqbUEUf8Q2LGuXLzlfUafVHFP
 e+Dkwyh0RMP8jjHuluvsMaOSafm5OYVbklyTTKVYKBTU6mRguAOT8rkk9xK4xSqD9fwx
 A/E6tvtmC2+5iku+FFMD0vYv05xSCMawraSxNAgES4RqfdFMMLb4aFQ0u462viK5nF8X
 DWTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJgD2S6DAm2YbJ++3DvhQ8y3YFQh9ICAZ6+47n8gHiIR6t2aVPKSip37dVay8AxAXrm2VGlxbbkkU/@nongnu.org
X-Gm-Message-State: AOJu0YwKY8g7Qb/fYrL5EK1Z9GLVSbrDPW1U5vLWUnadri/2RAnFvkxg
 j47iE3HEC23DCG+TYkqY8dE3sZ3T18qQmlNyJtsc9vLVTX+tV/a+bDxpyzXMivU=
X-Gm-Gg: ASbGnctHQPUQQXJgk8KnZqRyCleLkvDW4RK72HTmSJS3QdfnLgclN/pVPopOzejwpSI
 18v0ZhjW8Ijuw8UlYR/6i1wXDESZ0oQGGrG2SlTs2smilqoZ3U8fRtg3dGpT7IyjZUKg3Pm0VEN
 xOAEPF838yusTsCJhxRfzDiiBVl6nttWgM9KNBcoH/xlnT5VUu/7gunsE968gfrjNaKLjo+vCgL
 H4nq+BOSROQdY6VKUSrS99ZeRFXO9oNCOJoESYUF46vm6p9HxJvZwkrq+DsVSt7IOYHJdqRjQUR
 kj3E3/Br47nFecKYfb72YQWWO5vkM+wH7FAMGLcLMydG1oa2mDhKpNAPoQ==
X-Google-Smtp-Source: AGHT+IGigE3l6eEgBJ3CmgnuS2+uRHN829wF5Zoi23WSRGJurTQ8MfULJ2EAjxYd7VFb3nMBCVXLpw==
X-Received: by 2002:a17:903:2f90:b0:223:5645:8e26 with SMTP id
 d9443c01a7336-22649817becmr6016755ad.20.1742341946835; 
 Tue, 18 Mar 2025 16:52:26 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c68a4095sm101279435ad.66.2025.03.18.16.52.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 16:52:26 -0700 (PDT)
Message-ID: <de8fb1b6-0aef-47aa-aa17-37d836b5b983@linaro.org>
Date: Tue, 18 Mar 2025 16:52:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/42] accel/tcg: Fix cpu_ld*_code_mmu for user mode
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-4-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250318213209.2579218-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 3/18/25 14:31, Richard Henderson wrote:
> These routines are buggy in multiple ways:
>    - Use of target-endian loads, then a bswap that
>      depends on the host endiannness.

The code is very similar to do_ld*_mmu functions, so it's subtle to notice.

Was the endianness bug due to the fact we use oi (MemOpIdx) directly 
instead of get_memop(oi) (MemOp)?
It seems to be the main difference with do_ld*_mmu functions.

>    - A non-unwinding code load must set_helper_retaddr 1,
>      which is magic within adjust_signal_pc.
>    - cpu_ldq_code_mmu used MMU_DATA_LOAD
> 
> The bugs are hidden because all current uses of cpu_ld*_code_mmu
> are from system mode.
> 
> Fixes: 2899062614a ("accel/tcg: Add cpu_ld*_code_mmu")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/user-exec.c | 41 ++++-------------------------------------
>   1 file changed, 4 insertions(+), 37 deletions(-)
> 
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index 2322181b15..629a1c9ce6 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -1257,58 +1257,25 @@ uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr ptr)
>   uint8_t cpu_ldb_code_mmu(CPUArchState *env, abi_ptr addr,
>                            MemOpIdx oi, uintptr_t ra)
>   {
> -    void *haddr;
> -    uint8_t ret;
> -
> -    haddr = cpu_mmu_lookup(env_cpu(env), addr, oi, ra, MMU_INST_FETCH);
> -    ret = ldub_p(haddr);
> -    clear_helper_retaddr();
> -    return ret;
> +    return do_ld1_mmu(env_cpu(env), addr, oi, ra ? ra : 1, MMU_INST_FETCH);
>   }
>   
>   uint16_t cpu_ldw_code_mmu(CPUArchState *env, abi_ptr addr,
>                             MemOpIdx oi, uintptr_t ra)
>   {
> -    void *haddr;
> -    uint16_t ret;
> -
> -    haddr = cpu_mmu_lookup(env_cpu(env), addr, oi, ra, MMU_INST_FETCH);
> -    ret = lduw_p(haddr);
> -    clear_helper_retaddr();
> -    if (get_memop(oi) & MO_BSWAP) {
> -        ret = bswap16(ret);
> -    }
> -    return ret;
> +    return do_ld2_mmu(env_cpu(env), addr, oi, ra ? ra : 1, MMU_INST_FETCH);
>   }
>   
>   uint32_t cpu_ldl_code_mmu(CPUArchState *env, abi_ptr addr,
>                             MemOpIdx oi, uintptr_t ra)
>   {
> -    void *haddr;
> -    uint32_t ret;
> -
> -    haddr = cpu_mmu_lookup(env_cpu(env), addr, oi, ra, MMU_INST_FETCH);
> -    ret = ldl_p(haddr);
> -    clear_helper_retaddr();
> -    if (get_memop(oi) & MO_BSWAP) {
> -        ret = bswap32(ret);
> -    }
> -    return ret;
> +    return do_ld4_mmu(env_cpu(env), addr, oi, ra ? ra : 1, MMU_INST_FETCH);
>   }
>   
>   uint64_t cpu_ldq_code_mmu(CPUArchState *env, abi_ptr addr,
>                             MemOpIdx oi, uintptr_t ra)
>   {
> -    void *haddr;
> -    uint64_t ret;
> -
> -    haddr = cpu_mmu_lookup(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
> -    ret = ldq_p(haddr);
> -    clear_helper_retaddr();
> -    if (get_memop(oi) & MO_BSWAP) {
> -        ret = bswap64(ret);
> -    }
> -    return ret;
> +    return do_ld8_mmu(env_cpu(env), addr, oi, ra ? ra : 1, MMU_INST_FETCH);
>   }
>   
>   #include "ldst_common.c.inc"

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



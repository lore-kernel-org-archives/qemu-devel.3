Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB656CEDDA3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 00:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sygyH-00051d-I5; Wed, 09 Oct 2024 20:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sygyF-00051M-Vo
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 20:23:59 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sygyE-00042Q-DL
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 20:23:59 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7ea0ff74b15so195748a12.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 17:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728519837; x=1729124637; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iJLWOt9kK8ZViWbwNa7SGeOWpd/yG0CKREpAbHlXAd0=;
 b=P1q7K9X6ralQ8Xq8eeOmr3pG1JzoyPdVOBOWWZc+rkwS8IgQKrja2QG8n7IozyxrlI
 pwPgGix9UTGXPu8VZkCQToGtPyKwmNelFqwIphdNesKgxAa7QitcXbMnwkqNeArpuWXE
 uQLYjZdAMDSeuis4TKgPEpeIaKyYxC8UQVZ1YOp7CZYZWAj7XDqP4AvPvjbUUd4W/ZeH
 yQpEROO5RrJDgk3M9UwkobLOSL8UlDIC8pDdcffj7yop+1TDj08/GoqwtTwCdR2u2zGV
 1pSCfOlCUuYi/DSo2SZKmnoTTU5I7TbzYhWt9bWIuE6JL4UQbJ+4iINTANTGQehHMCjW
 fH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728519837; x=1729124637;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iJLWOt9kK8ZViWbwNa7SGeOWpd/yG0CKREpAbHlXAd0=;
 b=UMAZ5s4WB0MhVaLLGy7/MfMF4Rdya+T4mS/i9jQm0NYbizE57cpRlrS6SxkNymfUt/
 1JicDmi/mwXQr2sLhCOiN30izJ5/EHsE5ZE8+E09w8CRqTxpcYx9g0AXrCYb5yPEqhVG
 1LWr0kHpm7BQ1BmL+huu6YNuarKBxFuj2njsC7QMsOD+qSv6ex3quO/L/CfAdWdnq8ay
 2UUrAzr/5eM6uBu4eXk8z9qBOvBwx2L0EmB9KgLFU9DLoLCtPGgdJte5gkqcsW548dhr
 3YHCvSFL5gRHPfH2zWsxGIB4Hx4pYfUjGOCbm05nzIWM5JHqlJ9ZTv7OjthxvfRzVzla
 Z24w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2r03s/YIkn28oVNsJGyN847XOYcBqWGbakgUbr3YPcuOscaeDAxwfMujUasio6o67SwVAj7hcJ4cj@nongnu.org
X-Gm-Message-State: AOJu0YwT9PVZN520b/BHgKiLdjXnVhKCjUAAY00+WF5TzfHqrq93HQ5K
 4VzStAoqI4I4BS0VKvB9CcDmehSVpmsDf5zBZVhf9FGnvBVt+iRIEVftx55M/dc=
X-Google-Smtp-Source: AGHT+IEfiGlHtAOAWkgI3zdTovSt1JyXnQikOEMywJ1UorRbXCXlGsNJCFsy1SGwuYl/ZRDk2/6fEA==
X-Received: by 2002:a17:902:e546:b0:20b:532d:bb17 with SMTP id
 d9443c01a7336-20c63915469mr72287875ad.54.1728519836818; 
 Wed, 09 Oct 2024 17:23:56 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c0f2272sm77905ad.136.2024.10.09.17.23.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 17:23:56 -0700 (PDT)
Message-ID: <32195e57-9e94-4060-80cb-911505813788@linaro.org>
Date: Wed, 9 Oct 2024 17:23:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/23] accel/tcg: Call cpu_ld*_code_mmu from cpu_ld*_code
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-19-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241009150855.804605-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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

On 10/9/24 08:08, Richard Henderson wrote:
> Ensure a common entry point for all code lookups.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 59ee766d51..61daa89e06 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -2954,28 +2954,28 @@ uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr)
>   {
>       CPUState *cs = env_cpu(env);
>       MemOpIdx oi = make_memop_idx(MO_UB, cpu_mmu_index(cs, true));
> -    return do_ld1_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
> +    return cpu_ldb_code_mmu(env, addr, oi, 0);
>   }
>   
>   uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr)
>   {
>       CPUState *cs = env_cpu(env);
>       MemOpIdx oi = make_memop_idx(MO_TEUW, cpu_mmu_index(cs, true));
> -    return do_ld2_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
> +    return cpu_ldw_code_mmu(env, addr, oi, 0);
>   }
>   
>   uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr)
>   {
>       CPUState *cs = env_cpu(env);
>       MemOpIdx oi = make_memop_idx(MO_TEUL, cpu_mmu_index(cs, true));
> -    return do_ld4_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
> +    return cpu_ldl_code_mmu(env, addr, oi, 0);
>   }
>   
>   uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
>   {
>       CPUState *cs = env_cpu(env);
>       MemOpIdx oi = make_memop_idx(MO_TEUQ, cpu_mmu_index(cs, true));
> -    return do_ld8_mmu(cs, addr, oi, 0, MMU_INST_FETCH);
> +    return cpu_ldq_code_mmu(env, addr, oi, 0);
>   }
>   
>   uint8_t cpu_ldb_code_mmu(CPUArchState *env, abi_ptr addr,

This will still call the same functions behind _code_mmu variants, but I 
guess it's more coherent overall.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


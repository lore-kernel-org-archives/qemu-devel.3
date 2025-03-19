Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B695AC28B2F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 01:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuhwO-0005am-0b; Tue, 18 Mar 2025 21:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuhwE-0005WR-Aw
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 21:09:42 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuhwB-00078t-RQ
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 21:09:41 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-225477548e1so111140945ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 18:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742346578; x=1742951378; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pYnPy2zTdaIbEK//lejqruKbRa6GxXboBVf1q8oVBHU=;
 b=sHp2sDnwFc4o6Om5HNzIrEEDoZNvAkWkw79D3mjX03sdJPmR3mvt4yYjsXorkBGTLC
 eE9oVcn+j0dueUvo01MBZFFHI1vfF43UNtoc7b3Jov+EHuPu7So2DWd0pqSu5HO1G4hR
 +bF7xHjfpfYQp6roghqQ2oPLM0T1Bq7a+yKrMBiaMMWD5XdskDnoayh71wYSJMfR90bG
 9ELCViw1Tlq5RrltgSCYERUWy0Eh8k5ueySDVdETB9UEFm7G35KxogJGSb8E2Prx1ClA
 zip/GEN2dS2OYIGPAg2law+9rlSVwgQVHLhASRju5Al1iA3IPDpXL8uGdnbtDlZPeBMT
 IsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742346578; x=1742951378;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pYnPy2zTdaIbEK//lejqruKbRa6GxXboBVf1q8oVBHU=;
 b=QnqzQERi65I+SE3iOq5ei/VFaivrC+Bd2oSeSOafRB35cpqdE5nWQeoAY5o6XagEeK
 RIpk922ehBouPGaDdknsjrkNSqKod0lhWiau4GgzhGRRpFRvDk0BQq2CNdlWDLS5rhuw
 jzcoBZ52ri8nVNfzyUtzfnB8CnZuoGW4WtZcVM5bhzXN+WARGGJjslKQj9d5NgWzVTDJ
 yIVfSG8w1Mjlx29EnRodDjUQFKnbxGdBt6uRHtnXEv3fqVIXw9zomyr0RzZ0DbQdCQ1W
 ER/2woQbJkQs5AgUQ4LpLQ6lCWn8A33v8VJ0PbHHoR1XjgP+PAfRDKIiXemUX4CuOeD0
 sGVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuukj/MZlypHdrgixjU6Br5iwD6cRrl9x8D6cBHP1iagyPAeLomU8v6k/1tOVVEmQVxxwHldeHOK35@nongnu.org
X-Gm-Message-State: AOJu0YxJO2a5opMjxHzHnXg1NRbG/IwO+1OCebOYHMprFQ5gQMLtj/cS
 REBdfvuuzTX0Itlc1AIRBiqfatChn4pfLlZjbGJQKLbBfQpQZeJZDiMbBHvT01tTm9PCjZ8PPho
 O
X-Gm-Gg: ASbGncshD49TSKRgym3PX22yQ4wq2VA5eEs7NmHTHGH23gz1vmNRZ2iwP700OTPxpQB
 qzbpAZ9tnJwfXtBCDD/dDv5DPkDNSYXOKaOurmWvEWf7cyIuFl4yAKpH5NXP6+wMOhdDZ6A+oL7
 v6uy0ZAkIe5V57mToBri97U2sEIssoN2aNaqb5KNGsoEUxuPSG2GBR6thIS4lE/b2COpZnderU5
 gOwea3C3cxNhfhUqBERqDYjdEDz+szIpYjRt/vp1oxqMoAsq1pRQXtIk6H1w6reSmSeAjpqG8Ky
 dsgZVcQNfBSFUAwa6tH8RFZXfSKUm0FT+mq80jlDP4xhUzxMocCJPE2Lww==
X-Google-Smtp-Source: AGHT+IHgHfwBnki3vcoaFbaukCI63+DviHk6tNqkRaha0fxVJQBdR+lIA6PnGItziQTaXKTmr9Josg==
X-Received: by 2002:a05:6a21:3286:b0:1f5:8678:182a with SMTP id
 adf61e73a8af0-1fbeb7a1da1mr1176639637.12.1742346578387; 
 Tue, 18 Mar 2025 18:09:38 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-737115592c2sm10653593b3a.66.2025.03.18.18.09.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 18:09:37 -0700 (PDT)
Message-ID: <92981c19-8d0c-4dd7-aa2d-414bebdc9a83@linaro.org>
Date: Tue, 18 Mar 2025 18:09:37 -0700
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

Already given with my first question, but more clear to repeat it here:

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



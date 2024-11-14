Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCD7D6A224
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBeHd-0007f5-IQ; Thu, 14 Nov 2024 13:09:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeHa-0007V2-NP
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:09:30 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeHZ-0003l2-6I
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:09:30 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ea0bd709c0so593979a91.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731607767; x=1732212567; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XGV/9s2W2wGDmMSrGE04DpbZ7phUwwJPAW+gQzkv1xg=;
 b=fBfkYyMsYQOwLbO1K9AajpJ+uXubQSzMURzwxk/EEm1tEPeFAG73rOR9aJTMud1R6S
 vYt9AWbWX1/OWutFATIBf9DaIzySqOgE2v8uywUA4k339HFA2mVzuZKdFZLAG5mipW3T
 a5jzfdQRAb7B3xpBSQA2ATvmh/a/Atlau9dQLBNXk5QqF9RiLswXksz3m+wOpnVInACo
 e0+So4dUeb3o0qlmJu20SvLNWdLo1pedxWsXEYXP26xKiiA77wTP+qg+eAX+6qDMk8Ck
 vBZCA2c7ys20AZoz3AcQlStqrPkAgsIdLn8C/hLlUu1oNtDjFPcGzdAC1REcDUaI/3vf
 Xkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731607767; x=1732212567;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XGV/9s2W2wGDmMSrGE04DpbZ7phUwwJPAW+gQzkv1xg=;
 b=THGA32EhP77EdVXfh66G+IHiFCAyumqFwEE5kOTpPQXjXd+EBug3LM+rt/hhNo1LaQ
 2k3sWBpWHjN3t5SQZMyHugUaSWa8p2bYJo8hAAyo80x9NKXqLBAbaPJthQ48+APDzcHZ
 6u5VillHC8UL/WxDpfeIgwyBVg6vA6fdvK4Ua0AiCnQCbv7EBTSVCiJoTiV7AM2x95Yl
 rrM5uRP/3lumKBMg97Htsw5rj85NwEAYdjPluGiRxJlXGxU7ov+vqcSEgYCcEc/79gjq
 VBbXeRm0iuFMRJd8nhQW4eE+2ASXv37hK2moNghxtIZig7sGOA7hNOuaqm4rCqMxEBuF
 lVGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtP1BHLwlx6aNhvqmhNNVQXbrwFipEA27amma1EWu/7n3eprsQ3K3EE4rUiVN3nLCV85b2UTwU+/99@nongnu.org
X-Gm-Message-State: AOJu0YwuqXYidAfv9oVG1PjKJ+E0OC9wKsCfe5lAPfxOj/WG6OcrZFzg
 Q/CcAf1JDU4jPmJ1wqSB4DkTPTFR3tRjJf7btmKpLoahACCD4zeeaw3Muik7Dfw=
X-Google-Smtp-Source: AGHT+IEvvFDPZBgCwrJBYvLmJjk8P7R3WjknkkerNKLzAeyKNm3wG2ht/OFGTgQ1Cgy8a0hd1857eA==
X-Received: by 2002:a17:90b:270e:b0:2e2:e937:7141 with SMTP id
 98e67ed59e1d1-2ea0638b4f6mr3721667a91.20.1731607767256; 
 Thu, 14 Nov 2024 10:09:27 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211c7d389c2sm13587025ad.268.2024.11.14.10.09.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:09:26 -0800 (PST)
Message-ID: <15940c4f-8975-4c9d-a574-798f25e0a610@linaro.org>
Date: Thu, 14 Nov 2024 10:09:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/54] accel/tcg: Call cpu_ld*_code_mmu from
 cpu_ld*_code
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-23-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
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

On 11/14/24 08:00, Richard Henderson wrote:
> Ensure a common entry point for all code lookups.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index a4c69bcbf1..c975dd2322 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -2924,28 +2924,28 @@ uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr)
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



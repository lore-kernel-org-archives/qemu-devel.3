Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63ED5109E543
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 03:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5bJ1-0000Mm-E1; Wed, 25 Mar 2026 23:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5bJ0-0000ML-9N
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 23:22:46 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5bIy-0007oq-It
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 23:22:46 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2ad9f316d68so2390475ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 20:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774495363; x=1775100163; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TNzBK42/RI4ZFpHTJpnIhrZkGrb4kpEPZQyFB5ml6Lw=;
 b=MqwydMPdCgCWnXPzrWXbNGLoB9Aos1MywBmEfVgZC8sBeD1GdztDfMzVri0UDBN2GA
 0pJb8jD/LyjJwSOwdzkKquC05oREahP3nzDJ4Wk/84xX7fZnHEOIMewQaZydjr2sj07S
 KfKB/3kG9tzu2hrnrX3KllintBsEFMRC8qBCM+WpivJFKdqDW/dyvcJTjhiUE5UJAZnm
 pQYgOTY5Vf/31Oz1yphmhUf1aMjrl1orlOVCVwK0CItdh2K29WDaxK1tjGDQgw4gFBPJ
 9wCGh3N+aOWdsrzu8D/Q/y2yNYepLVqbTVXENumIH0Zx8Ai7Tm5/7AdEbwt3vHwtf3VT
 zMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774495363; x=1775100163;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TNzBK42/RI4ZFpHTJpnIhrZkGrb4kpEPZQyFB5ml6Lw=;
 b=TlugbJ4sjycDl7Lm9B6h9OFHSV+nnsnN8S9/TwdnktJlzk1u7zYDqk3bLCcivU5hc4
 s0E/iXNM12k2AVmUaYC3tfJopERBzljqd3U6y/AIB5WgaI0z8ikzqC+io7b1F15ziq2t
 j+1tChqE870rek3i5K7uHNuBblR/GxwSULcSEhuM5vsL5rqe2dKdUeLHIQgA9Z+vIIfj
 4aYPxl2wcEd2VOVg7m5Aa60rA9UoABaRibrXWqHDooCtJk9mqxkRYcJ6nIrmrOTFRZrg
 igCXUQBG0ZnVPqoqVxO4PRAreAq7FIdRU9gn2aNAEjGbGySugbEFl93hJja+7IOJ9grR
 vw6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhmRU1m0JlF5KDjtaL4ipxSs5HZDoWJb78D0UIYUbSiYpqO3s60bDErq9CU72aNsy6B3OAIdg5n/7y@nongnu.org
X-Gm-Message-State: AOJu0Yz7fV9oJUXxXijh8h5ed0T+9IIul71xYVglxUN5kHGWu0u7kPoV
 0USy3wQeAKxT3dHpYSutELUPGlOQqXKpCdQNF3sJHLA1Eaq6FvB+8tpSrLYRxYOR0wA=
X-Gm-Gg: ATEYQzyjBSvl3MEVL3NtQA4LYDEj/eRfWDEeezPmCH3GRO4Mt9gHTj4++irzN117uy7
 MilYjkMoSZQkTc8HHVEXlhsmGGmwy3PCWH1Dvl7qU1g0sowiLO25Pbinvi1cyZLJ6dXACIUIbyC
 Vk3svPTOyX6n+ooi3029D1AMMAgU61QleFV1MXrtnTjpkH1ubZECA2/usCf0/+hURTx7Ny0wFfV
 P/qgfUQ8VKYyw8vtagHlhnp4o2TSELhCqJYpWOaopeKahJO4d8p2BxxtgqnKCMxJGUIiGhkkQv1
 LCR4Uc2yB/ikM9F+uvnzBgwOiNeIrDee0jw11X8ZAUB6l4xZnFyU9MfMTCHIHESXr/N9/GcSK0I
 6mFz5uCNnknCz0sunObPvPG+xh28n0VqXrq5uV7kbdK/dDgvTcv27rxjvXWmhtgNC5GUPbEO+z8
 IAhY74i1zZ8Mntq45iYlY/a4A+yoMUENw/aBy13rmJzg==
X-Received: by 2002:a17:903:f84:b0:2b0:6d56:8d29 with SMTP id
 d9443c01a7336-2b0b0a75058mr69779995ad.32.1774495362692; 
 Wed, 25 Mar 2026 20:22:42 -0700 (PDT)
Received: from [172.16.11.156] ([103.100.225.140])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc87ebf1sm13336715ad.44.2026.03.25.20.22.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 20:22:42 -0700 (PDT)
Message-ID: <d974df44-b46e-4e51-9eec-b46e391c3462@linaro.org>
Date: Thu, 26 Mar 2026 13:22:33 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] target/riscv: Implement runtime data endianness
 via MSTATUS bits
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20260320150552.169480-1-djordje.todorovic@htecgroup.com>
 <20260320150552.169480-5-djordje.todorovic@htecgroup.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320150552.169480-5-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/21/26 01:06, Djordje Todorovic wrote:
> +/*
> + * Return true if data accesses are big-endian for the current privilege
> + * level, based on the MSTATUS MBE/SBE/UBE bits.
> + */
> +static inline bool riscv_cpu_data_is_big_endian(CPURISCVState *env)
> +{
> +#if defined(CONFIG_USER_ONLY)
> +    return false;
> +#else
> +    switch (env->priv) {
> +    case PRV_M:
> +        return env->mstatus & MSTATUS_MBE;
> +    case PRV_S:
> +        return env->mstatus & MSTATUS_SBE;
> +    case PRV_U:
> +        return env->mstatus & MSTATUS_UBE;
> +    default:
> +        g_assert_not_reached();
> +    }
> +#endif
> +}

This ifdef means ...

> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -189,10 +189,17 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>       flags = FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
>       flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
>   
> +    uint64_t cs_base = env->misa_ext;
> +#ifndef CONFIG_USER_ONLY
> +    if (riscv_cpu_data_is_big_endian(env)) {
> +        cs_base |= TB_CSBASE_BIG_ENDIAN;
> +    }
> +#endif

... you don't need this one.

> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 5df5b73849..d7f1f8e466 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -119,6 +119,8 @@ typedef struct DisasContext {
>       bool fcfi_lp_expected;
>       /* zicfiss extension, if shadow stack was enabled during TB gen */
>       bool bcfi_enabled;
> +    /* Data endianness from MSTATUS UBE/SBE/MBE */
> +    bool big_endian;

Better to store MemOp here.

>   } DisasContext;
>   
>   static inline bool has_ext(DisasContext *ctx, uint32_t ext)
> @@ -128,14 +130,7 @@ static inline bool has_ext(DisasContext *ctx, uint32_t ext)
>   
>   static inline MemOp mo_endian(DisasContext *ctx)
>   {
> -    /*
> -     * A couple of bits in MSTATUS set the endianness:
> -     *  - MSTATUS_UBE (User-mode),
> -     *  - MSTATUS_SBE (Supervisor-mode),
> -     *  - MSTATUS_MBE (Machine-mode)
> -     * but we don't implement that yet.
> -     */
> -    return MO_LE;
> +    return ctx->big_endian ? MO_BE : MO_LE;
>   }

... so that this expression is only computed once ...


>   
>   #ifdef TARGET_RISCV32
> @@ -1346,6 +1341,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>       ctx->zero = tcg_constant_tl(0);
>       ctx->virt_inst_excp = false;
>       ctx->decoders = cpu->decoders;
> +    ctx->big_endian = ctx->base.tb->cs_base & TB_CSBASE_BIG_ENDIAN;


... here.


r~


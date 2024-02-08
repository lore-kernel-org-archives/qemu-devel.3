Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951EBC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 20:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYBFF-0000L0-Dm; Thu, 08 Feb 2024 15:43:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYBFE-0000Kr-KL
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 15:43:40 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYBFB-0008I5-OL
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 15:43:39 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d99c5f6bfeso9874605ad.1
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 12:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707425016; x=1708029816; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ya9xo+3CuU6WmCDooJtFmZl+ngqE+k0cnrRZXYUkrOo=;
 b=zEl/FR5c9uJIoB58otGA29HcexWCToDdMC6RjslLJW+ogEiiImr5TB02MAjGJEIA5u
 smk9PGGt7MATcEE4J/YiLni8lQq6D4NGBLbq8JmEd9ENFkyznBUtJ2SUoZsyHv72VEfg
 exhp1Jka9m08+LT0tjhQppvwmjbRiusc7P9x3Qy70Z1flJUYdxquhmkNj4W3fZ5COZr2
 O3JojQ0GyXsxtQN+SYal185UhvrdZuYHZjDSf9q2Ka0nNvOAYTwG9JhKQjwfArYR6LTF
 AYUBfFwdpyoJcXbG4LTYZ+FVGSniVEZaqCjnaSFdBs/mD129FuiQlXLZqTsABXmCrE8K
 prFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707425016; x=1708029816;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ya9xo+3CuU6WmCDooJtFmZl+ngqE+k0cnrRZXYUkrOo=;
 b=wGZdRWykNYT0866w70qZovnSPBECxIlBaIb0FK6TKiXK/XivlKjVLrqAV9A8TXBHBP
 0ll2lVTPqiHzrmmjL3Z2EK6jiebS1y5WUfgxbg7bjXDBkZSv4H5O6Gt703hkYrR1kw2R
 fMFFEc22PqUiWLQM+taBf7LKtXO+Qv0jsF9QquPwD+4DJzALWxmZajZ0aak1TCHwJ0VX
 tcpKmOuLWql38vZ8QVDptKaMfrklm3pgNCKS08DCEnEqB/cwOE0fDbIum8IJbi3VPzNn
 z1AVqmr6aoZYdpO0dSn1bS1btw5zQo3eQ1rwN7sC/yglfXHLFkMjRfZyFGYFslFghh2W
 +fUw==
X-Gm-Message-State: AOJu0YzF6qgkmbOXerCTUkFOCMv8zxcqKBQowBLy6vSzPBdYz4ywcOEz
 OTzos9nqmVz1nJVmfCRPdgC2vg0jdOTTlv6bM19eJfseTkU9lCK6MFjCwgW0tG0=
X-Google-Smtp-Source: AGHT+IFWEFmyFRY46Dm0N2lNYz2axOXK3KpvJIG6lDl+igWFCZP7SOQa8TXr+r0B745d1kj9EZpMvA==
X-Received: by 2002:a17:902:ec92:b0:1d9:ab92:153c with SMTP id
 x18-20020a170902ec9200b001d9ab92153cmr7053774plg.5.1707425016074; 
 Thu, 08 Feb 2024 12:43:36 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWhNk9BTFiQNP7ZaaUhHvYF2IKxnchOoIMR0Bo8QHWIQ9oKHkglCOzg9mH6C4w7pWaBwRdJKr1Z/wtXPO89rWLuw6f+U4Y=
Received: from [192.168.4.112] (066-027-223-101.inf.spectrum.com.
 [66.27.223.101]) by smtp.gmail.com with ESMTPSA id
 lh15-20020a170903290f00b001d923684323sm174151plb.195.2024.02.08.12.43.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 12:43:35 -0800 (PST)
Message-ID: <2736d6d1-5585-4bbd-82c7-a3b7f5c87fb9@linaro.org>
Date: Thu, 8 Feb 2024 10:43:26 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] target/hppa: Fix PSW_W and PSW_E bits in rsm, ssm
 and mtsm
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20240207182023.36316-1-deller@kernel.org>
 <20240207182023.36316-4-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240207182023.36316-4-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 2/7/24 08:20, deller@kernel.org wrote:
>   #define PSW_E            0x04000000
> +#define PSW_E_BIT                37 /* PA2.0 only */
>   #define PSW_W            0x08000000 /* PA2.0 only */
> +#define PSW_W_BIT                36 /* PA2.0 only */
...
> +target_ulong HELPER(get_system_mask)(CPUHPPAState *env)
> +{
> +    target_ulong psw = env->psw;
> +
> +    /* mask out invalid bits */
> +    target_ulong psw_new = psw & PSW_SM;
> +
> +    /* ssm/rsm instructions number PSW_W and PSW_E differently */
> +    psw_new &= ~PSW_W;
> +    if (psw & PSW_W) {
> +        psw_new |= 1ull << (63 - PSW_W_BIT);
> +    }

Um, this has changed nothing, since 1 << (63 - 36) == 0x8000000 == PSW_W.

The conversion of PSW_SM_W to PSW_W happens in expand_sm_imm().
There's a comment there about keeping unimplemented bits disabled, including PSW_E. 
Perhaps this is the wrong layer in which to do this?

In any case, what is the actual problem that you're seeing?  Because it *isn't* that we 
were not considering the different placement of the bits, as your commit message suggests.

> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 53ec57ee86..10fdc0813d 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -2163,13 +2163,20 @@ static bool trans_rsm(DisasContext *ctx, arg_rsm *a)
>       nullify_over(ctx);
>   
>       tmp = tcg_temp_new_i64();
> -    tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));
> -    tcg_gen_andi_i64(tmp, tmp, ~a->i);
> -    gen_helper_swap_system_mask(tmp, tcg_env, tmp);
> -    save_gpr(ctx, a->t, tmp);
> +    if (a->t != 0) {
> +        gen_helper_get_system_mask(tmp, tcg_env);
> +        save_gpr(ctx, a->t, tmp);
> +    }

If a->t == 0, tmp is uninitialized...

> +
> +    if (a->i) {
> +        tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));

... but read here.

> @@ -2183,11 +2190,17 @@ static bool trans_ssm(DisasContext *ctx, arg_ssm *a)
>       nullify_over(ctx);
>   
>       tmp = tcg_temp_new_i64();
> -    tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));
> -    tcg_gen_ori_i64(tmp, tmp, a->i);
> -    gen_helper_swap_system_mask(tmp, tcg_env, tmp);
> -    save_gpr(ctx, a->t, tmp);
> +    if (a->t != 0) {
> +        gen_helper_get_system_mask(tmp, tcg_env);
> +        save_gpr(ctx, a->t, tmp);
> +    }
> +
> +    if (a->i) {
> +        tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));
> +        tcg_gen_ori_i64(tmp, tmp, a->i);

Likewise.


r~


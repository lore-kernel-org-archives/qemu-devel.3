Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1091C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 10:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmX82-0006Iq-Jy; Tue, 19 Mar 2024 06:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmX81-0006Ic-8d
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 06:55:33 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmX7y-0004sJ-8X
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 06:55:32 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41413f7b2dfso11794135e9.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 03:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710845727; x=1711450527; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hNhD0BwtgqNTJ8yeeV0K5ipAtyhSqFEgJ/V75Wm0Yy0=;
 b=DnSBo5UMZWUxs3AeZNEwo7kR5aKLqgpSljI6ajf19LBN9kshL3W6dad2XhnvODpjas
 wnYcMTyfgX/MWqJ18/2i9ihp3z7toKsazFie2a2QgB54NF1V3arcadvW1Z30KnleFwjK
 elovT6/txHTU5UZ3ipeORAjbYmwcNOFgLIPhX5+6cYeNbYb3/0L5btsTgNxIQnn6kPz0
 0aVKaM/5HqD8LyH0WDUV7SJN1HSjehdEekG2Tz5T0eYo80NoqqsfyjQvzqNJjG1/o4mN
 asnmVH0kmmO1FvpMHwrt2hSFX+15QuCZ8K1qFG5BrY1uLGiggMHd7gidvbazG0W54Pyd
 CZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710845727; x=1711450527;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hNhD0BwtgqNTJ8yeeV0K5ipAtyhSqFEgJ/V75Wm0Yy0=;
 b=LPl0Q/LjRh7r4SPMwc2nznqLUz5CMM+8cRYfWYURPgGkOWiwI0eUgwmKZJD+o8w1Rw
 wATHWQP1TCc1RYcpI1qW6EHHPmhmh4NHGblDD2dyU4R19R0r9HqqHs9P109JBAkr9Ziz
 ltdMnQc9QNZRrtgVdE/41g6pj3zvnuYGjUF8TLaZMYSUlZPh4VNbO811NT2zxAAv5ycz
 bGZuE1q2g47GNUo8FKGX2iJvZcXxXKV/0lzx1M4wegDe71i2bGGBBTP8m050HjE5auXi
 K+pMhC4p40PHqJ9yIUXM1hkYjCSQLerea2cHe/vvVEVMwunz9wI3mMno7lYOhZiuv3Np
 6mhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCjMKzKg2EbBfcieUtSVEJedUrJzwaO3OfBV8AAyaIAXjtE5+0aQ/IAjRshgZzFNRjY+rJShUWppwr+tN+pUhiwzba20o=
X-Gm-Message-State: AOJu0YzZoOO8mQaoXA81lLuj2C98eRo4O8YsrA2fk9NFdnkldq+Bd39i
 Uj0+9EBkkJHdP9Ca9sS1fVAfaU6JSKFNEzpnPUCgsyAX6rKkXRdBhjYardlhUb0=
X-Google-Smtp-Source: AGHT+IE4jR3Wuq1rZhw879K2U4fJ/WUodVrkVJV4Bu9iL/Sjpv4wb5KX6WQdybBKisoE2S8AYoXVGw==
X-Received: by 2002:a05:600c:1553:b0:414:1325:e8a8 with SMTP id
 f19-20020a05600c155300b004141325e8a8mr3233842wmg.39.1710845726471; 
 Tue, 19 Mar 2024 03:55:26 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a05600c45cf00b0041466e03e55sm353472wmo.0.2024.03.19.03.55.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 03:55:26 -0700 (PDT)
Message-ID: <ea857944-c7da-41e1-b260-ea5114e34129@linaro.org>
Date: Tue, 19 Mar 2024 14:55:21 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/22] tcg: Add TCGContext.emit_before_op
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-2-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240316015720.3661236-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x330.google.com
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

On 3/16/24 05:56, Richard Henderson wrote:
> Allow operations to be emitted via normal expanders
> into the middle of the opcode stream.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg.h |  1 +
>   tcg/tcg.c         | 14 ++++++++++++--
>   2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index 451f3fec41..e9d05f40b0 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -552,6 +552,7 @@ struct TCGContext {
>   
>       QTAILQ_HEAD(, TCGOp) ops, free_ops;
>       QSIMPLEQ_HEAD(, TCGLabel) labels;
> +    TCGOp *emit_before_op;
>   
>       /* Tells which temporary holds a given register.
>          It does not take into account fixed registers */
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index d6670237fb..0c0bb9d169 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1521,6 +1521,7 @@ void tcg_func_start(TCGContext *s)
>   
>       QTAILQ_INIT(&s->ops);
>       QTAILQ_INIT(&s->free_ops);
> +    s->emit_before_op = NULL;
>       QSIMPLEQ_INIT(&s->labels);
>   
>       tcg_debug_assert(s->addr_type == TCG_TYPE_I32 ||
> @@ -2332,7 +2333,11 @@ static void tcg_gen_callN(TCGHelperInfo *info, TCGTemp *ret, TCGTemp **args)
>       op->args[pi++] = (uintptr_t)info;
>       tcg_debug_assert(pi == total_args);
>   
> -    QTAILQ_INSERT_TAIL(&tcg_ctx->ops, op, link);
> +    if (tcg_ctx->emit_before_op) {
> +        QTAILQ_INSERT_BEFORE(tcg_ctx->emit_before_op, op, link);
> +    } else {
> +        QTAILQ_INSERT_TAIL(&tcg_ctx->ops, op, link);
> +    }
>   
>       tcg_debug_assert(n_extend < ARRAY_SIZE(extend_free));
>       for (i = 0; i < n_extend; ++i) {
> @@ -3215,7 +3220,12 @@ static TCGOp *tcg_op_alloc(TCGOpcode opc, unsigned nargs)
>   TCGOp *tcg_emit_op(TCGOpcode opc, unsigned nargs)
>   {
>       TCGOp *op = tcg_op_alloc(opc, nargs);
> -    QTAILQ_INSERT_TAIL(&tcg_ctx->ops, op, link);
> +
> +    if (tcg_ctx->emit_before_op) {
> +        QTAILQ_INSERT_BEFORE(tcg_ctx->emit_before_op, op, link);
> +    } else {
> +        QTAILQ_INSERT_TAIL(&tcg_ctx->ops, op, link);
> +    }
>       return op;
>   }
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


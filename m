Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D17E7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 23:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW1qI-00068H-KL; Thu, 09 Jan 2025 18:21:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW1qF-00067y-BV
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 18:21:31 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW1qC-0002kp-Ir
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 18:21:30 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3863703258fso1686854f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 15:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736464886; x=1737069686; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TRwIYbo74v+HcYFCSI7LmOicyJ3CM/3Nd+a1ZWFWubI=;
 b=DCDkGyi+O5cO+/h3KpbDuFEc7dhAKjN8edWHi/kK4JLLjU7xSY+QZa1MLypIaW6Zkt
 EHydMgD4jGRIJbTVGSNKGTaoe23he4MFx0kfA4or2phX+xwZfv1L5lEHR9iy5OG2lJZN
 hyBMF+9EZ2iX1oGrvyUgFHeITTgX5+gqpSqV+TvD2gv8oDX28wRYTGsnEqn0MgUNQdtU
 Ge8CptzUKGs/NBiwdwptMJdPNGL98wvWkSyYhGAein1l/lF9iIxT3LmNQK2hs3nqIY0q
 V0ECfGDSHH9c0Y77J9xuCQLBQhkfeieR1372zWgF4IAuu8KYae9A2a5rYOfOuaL0c0yc
 3qsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736464886; x=1737069686;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TRwIYbo74v+HcYFCSI7LmOicyJ3CM/3Nd+a1ZWFWubI=;
 b=Z7JPmAFEvKzzWgiQqUkwblvOH0hNZxc5dUVIUJs1MCbLMCkmy7qd6iaEhBY68e7oLg
 37YxGQ9LE30qgfXHNQv3IMb2p2BdRhWS08KSiL+mJQWblR44pboICdS4V4BHvDQ02UoE
 op8HpQaA1yIRozET33aeQNU/4gZLx7o/sbmpa9ot8kDA0B+F38teN2lrGCSgGQTTSBjB
 jxZgZApVzxXQQl/3zbSsPlJRoQMMmf2ubtmsQf28WLW7VmKP/bfXNPg3lmkW9roLAjbI
 Es7xiCkIYn83M8SJfEXjM5zF7mD9ztZlwBKYbf/wN0URUIeJJpYcAGEQ/4FJHP/pD9gi
 0OnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcZvv2WohxyAC/vsyU9ovG6OX4jbj2D48wHjLAYZNgPT4Uq26vZ5/ihprS0EKhFB0Qgrl+d7Kd/Dse@nongnu.org
X-Gm-Message-State: AOJu0Yw15sDHgt3P1KnN9/hivEctX6SgJOlfX4RHO5nLG6uKRRYs/wdq
 y8Cp+HtG68+rFYZ5T7JtIf/rgpX+lrW0WzdDUaaoudBSKkhGYi15UA7+fIAZ6MI=
X-Gm-Gg: ASbGncvgzXb2L0do7hUDZN06CIkAcVVCu56jRHdTjI6MoJbVHDBGJqpQi1QSwoyLs2v
 8qy0HUUXs77t+4cOkN0aTOEPnYbL5YzybVj1bR7+oVSfPGg3BUhd8Mi8DMBIC3MWBaKK7ESxC63
 jKha/7VfF3W/GTL+mlMxAO4Nt3/dEMZJefLJCuL4q+ggAQbRaUSfWjydTmBw1Xwq7JKosxBxZaA
 1ccQazCiSH/znivqhkZ07d80OofJFqsF+A7J1MMlX4fFjWW9h6YJbzXn0yeXablsYDTDie3MXDS
 dGSOEf3WvlJvavCCzA5mGRuvf6g=
X-Google-Smtp-Source: AGHT+IEDf1TCX/VJ6NolXIeMwzGLznjpaICE8MHo/LHk2wWHojme71P61AgkErSD8vaF1ZYBBLZFOA==
X-Received: by 2002:a05:6000:1fa5:b0:38a:88ac:ee69 with SMTP id
 ffacd0b85a97d-38a8b0d5bb4mr4091294f8f.13.1736464886055; 
 Thu, 09 Jan 2025 15:21:26 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38bf78sm2916560f8f.48.2025.01.09.15.21.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 15:21:25 -0800 (PST)
Message-ID: <fd696582-0b9f-48b0-8721-2afc0a28c6ea@linaro.org>
Date: Fri, 10 Jan 2025 00:21:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 50/81] tcg: Add all_outop[]
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-51-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-51-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> Add infrastructure for more consolidated output of opcodes.
> The base structure allows for constraints to be either static
> or dynamic, and for the existence of those constraints to
> replace TCG_TARGET_HAS_* and the bulk of tcg_op_supported.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 53 insertions(+), 7 deletions(-)


> +static const TCGOutOp outop_notreached = {
> +    .static_constraint = C_NotReached,
> +};
> +
> +static const TCGOutOp * const all_outop[NB_OPS] = {
> +    [0 ... NB_OPS - 1] = &outop_notreached,
> +};


> @@ -3331,18 +3370,25 @@ static void process_constraint_sets(TCGContext *s)
>   
>   static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
>   {
> -    const TCGOpDef *def = &tcg_op_defs[op->opc];
> +    TCGOpcode opc = op->opc;
> +    TCGType type = TCGOP_TYPE(op);
> +    unsigned flags = TCGOP_FLAGS(op);
> +    const TCGOpDef *def = &tcg_op_defs[opc];
> +    const TCGOutOp *outop = all_outop[opc];
>       TCGConstraintSetIndex con_set;
>   
> -#ifdef CONFIG_DEBUG_TCG
> -    assert(tcg_op_supported(op->opc, TCGOP_TYPE(op), TCGOP_FLAGS(op)));
> -#endif
> -
>       if (def->flags & TCG_OPF_NOT_PRESENT) {
>           return empty_cts;
>       }
>   
> -    con_set = tcg_target_op_def(op->opc, TCGOP_TYPE(op), TCGOP_FLAGS(op));
> +    if (outop) {

Always true,

> +        con_set = outop->static_constraint;
> +        if (con_set == C_Dynamic) {
> +            con_set = outop->dynamic_constraint(type, flags);
> +        }
> +    } else {
> +        con_set = tcg_target_op_def(opc, type, flags);

so unreachable. Gremlins?

> +    }



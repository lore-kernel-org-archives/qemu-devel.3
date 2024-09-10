Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C6DEE01EB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 21:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so8kz-0004kJ-R9; Tue, 10 Sep 2024 17:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so8kx-0004jq-IP
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 17:50:39 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so8kv-0004ZM-Jn
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 17:50:39 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-718e6299191so2036810b3a.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 14:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726005036; x=1726609836; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XgAbYucyx8VC2oK9wXWYiLUAeSc9VbUTGR7SlHgQ6yI=;
 b=EjTOrfo6PjO0a6XB7A3P/zfyeP5/DGAkOoXMh4l6ykkUQXqq8oZbS1WwHeF4pArRrK
 ABAye/6oWsY/3NlX/9M6kwdMdYR7CV3S0Dl7nj+kvP2tIJEMyIBEFQuqLpEhIysWiosE
 bfPb6vL3VERNzX0gFUgJDuTXggCUe86S+mQQ6ANMSeP4SLJT7VRyr6Y0s8SSysEkvpaJ
 tCnYzpvMbKXZ2fv+1NxNdtUkibvDPz90JCXxu8zbbqUux1TpFApffbpjaQ1BMKCt6mVc
 BtbMpPWIXgXCkIznKVJHdzdGw8sA9eiOkXniXSkTDwP4x1enNPEm8uVrBlvV5BdjjTpq
 tm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726005036; x=1726609836;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XgAbYucyx8VC2oK9wXWYiLUAeSc9VbUTGR7SlHgQ6yI=;
 b=cb0bkL/MkaaydED5haPPNQJPo2OB9QncSS5Bbj9Nf2HLvHBtXYRICO4OtVwXrs222Y
 uC/JpxVwWknuINXG94tKSp46ZTIAxPqKo/45gGesiZtSiYcdw5cZazblj5PtVwMN+MQp
 sgwb7yd54cHk4FL8negtrcuuoate4gBEq/y/2Ck834loIQJ8kgSUFmnthDKnKs/8ieiA
 9YSk9KukFLtaBa4AzJqB7Hl9DeCF0QPR8lzdeM54GVWEDh/TMOLnweaax8aqsbD/ke7G
 j6NtWiu+xz/31w++wz4+cA2a6nmLWufv3XhGqBRZocwAUVHqIK7SD4NN7mJ++IYRmRb1
 h/CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7cbS/HjjbbzsIT9WwndTJmCAJTjxsPD6uG1RkvGdHP1qocr36aIcJDnnNbuPrL/l1Lm+s1coTDLKa@nongnu.org
X-Gm-Message-State: AOJu0Yz0nlcdLdJCbZ71JwI/1jERRviqAQ4hiBdJpBbBe7nZODVcWcj/
 LwLuYny66pHYE/x6R2Tt3+39r2wwAwSxXohgVmaFwFPvtbM4HOt8hSSzEQqcuMc=
X-Google-Smtp-Source: AGHT+IHptM7fwv8UtnwgR23Tf399EunGTKcafQDM9sY8QZf2S1hiDtWZ0YysiKLNCgq/rFOC5TXRtA==
X-Received: by 2002:a05:6a20:c79a:b0:1cf:39ee:f249 with SMTP id
 adf61e73a8af0-1cf5e033133mr3413100637.6.1726005035824; 
 Tue, 10 Sep 2024 14:50:35 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::9633? ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71909005869sm1857441b3a.91.2024.09.10.14.50.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 14:50:35 -0700 (PDT)
Message-ID: <047bf152-ac20-49e0-90fb-ff9b56511982@linaro.org>
Date: Tue, 10 Sep 2024 14:50:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tcg: Propagate new TCGOp to add_as_label_use
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Elisha Hollander <just4now666666@gmail.com>
References: <20240910212351.977753-1-richard.henderson@linaro.org>
 <20240910212351.977753-3-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240910212351.977753-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 9/10/24 14:23, Richard Henderson wrote:
> The use of tcg_last_op does not interact well with
> TCGContext.emit_before_op, resulting in the label
> being linked to something other than the branch op.
> 
> In this case it is easier to simply collect the emitted
> branch op and pass it directly to add_as_label_use.
> 
> Reported-by: Elisha Hollander <just4now666666@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op.c | 63 ++++++++++++++++++++++++++--------------------------
>   1 file changed, 32 insertions(+), 31 deletions(-)
> 
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 28c41b37a4..4a7e705367 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -117,9 +117,9 @@ static void DNI tcg_gen_op1_i64(TCGOpcode opc, TCGv_i64 a1)
>       tcg_gen_op1(opc, tcgv_i64_arg(a1));
>   }
>   
> -static void DNI tcg_gen_op1i(TCGOpcode opc, TCGArg a1)
> +static TCGOp * DNI tcg_gen_op1i(TCGOpcode opc, TCGArg a1)
>   {
> -    tcg_gen_op1(opc, a1);
> +    return tcg_gen_op1(opc, a1);
>   }
>   
>   static void DNI tcg_gen_op2_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2)
> @@ -196,16 +196,16 @@ static void DNI tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
>                   tcgv_i64_arg(a3), a4);
>   }
>   
> -static void DNI tcg_gen_op4ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
> -                                  TCGArg a3, TCGArg a4)
> +static TCGOp * DNI tcg_gen_op4ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
> +                                     TCGArg a3, TCGArg a4)
>   {
> -    tcg_gen_op4(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2), a3, a4);
> +    return tcg_gen_op4(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2), a3, a4);
>   }
>   
> -static void DNI tcg_gen_op4ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
> -                                  TCGArg a3, TCGArg a4)
> +static TCGOp * DNI tcg_gen_op4ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
> +                                     TCGArg a3, TCGArg a4)
>   {
> -    tcg_gen_op4(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3, a4);
> +    return tcg_gen_op4(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3, a4);
>   }
>   
>   static void DNI tcg_gen_op5_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
> @@ -270,12 +270,12 @@ static void DNI tcg_gen_op6i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
>                   tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5), a6);
>   }
>   
> -static void DNI tcg_gen_op6ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
> -                                  TCGv_i32 a3, TCGv_i32 a4,
> -                                  TCGArg a5, TCGArg a6)
> +static TCGOp * DNI tcg_gen_op6ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
> +                                     TCGv_i32 a3, TCGv_i32 a4,
> +                                     TCGArg a5, TCGArg a6)
>   {
> -    tcg_gen_op6(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
> -                tcgv_i32_arg(a3), tcgv_i32_arg(a4), a5, a6);
> +    return tcg_gen_op6(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
> +                       tcgv_i32_arg(a3), tcgv_i32_arg(a4), a5, a6);
>   }
>   
>   /* Generic ops.  */
> @@ -286,18 +286,17 @@ void gen_set_label(TCGLabel *l)
>       tcg_gen_op1(INDEX_op_set_label, label_arg(l));
>   }
>   
> -static void add_last_as_label_use(TCGLabel *l)
> +static void add_as_label_use(TCGLabel *l, TCGOp *op)
>   {
>       TCGLabelUse *u = tcg_malloc(sizeof(TCGLabelUse));
>   
> -    u->op = tcg_last_op();
> +    u->op = op;
>       QSIMPLEQ_INSERT_TAIL(&l->branches, u, next);
>   }
>   
>   void tcg_gen_br(TCGLabel *l)
>   {
> -    tcg_gen_op1(INDEX_op_br, label_arg(l));
> -    add_last_as_label_use(l);
> +    add_as_label_use(l, tcg_gen_op1(INDEX_op_br, label_arg(l)));
>   }
>   
>   void tcg_gen_mb(TCGBar mb_type)
> @@ -514,8 +513,9 @@ void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *l)
>       if (cond == TCG_COND_ALWAYS) {
>           tcg_gen_br(l);
>       } else if (cond != TCG_COND_NEVER) {
> -        tcg_gen_op4ii_i32(INDEX_op_brcond_i32, arg1, arg2, cond, label_arg(l));
> -        add_last_as_label_use(l);
> +        TCGOp *op = tcg_gen_op4ii_i32(INDEX_op_brcond_i32,
> +                                      arg1, arg2, cond, label_arg(l));
> +        add_as_label_use(l, op);
>       }
>   }
>   
> @@ -1934,15 +1934,16 @@ void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *l)
>       if (cond == TCG_COND_ALWAYS) {
>           tcg_gen_br(l);
>       } else if (cond != TCG_COND_NEVER) {
> +        TCGOp *op;
>           if (TCG_TARGET_REG_BITS == 32) {
> -            tcg_gen_op6ii_i32(INDEX_op_brcond2_i32, TCGV_LOW(arg1),
> -                              TCGV_HIGH(arg1), TCGV_LOW(arg2),
> -                              TCGV_HIGH(arg2), cond, label_arg(l));
> +            op = tcg_gen_op6ii_i32(INDEX_op_brcond2_i32, TCGV_LOW(arg1),
> +                                   TCGV_HIGH(arg1), TCGV_LOW(arg2),
> +                                   TCGV_HIGH(arg2), cond, label_arg(l));
>           } else {
> -            tcg_gen_op4ii_i64(INDEX_op_brcond_i64, arg1, arg2, cond,
> -                              label_arg(l));
> +            op = tcg_gen_op4ii_i64(INDEX_op_brcond_i64, arg1, arg2, cond,
> +                                   label_arg(l));
>           }
> -        add_last_as_label_use(l);
> +        add_as_label_use(l, op);
>       }
>   }
>   
> @@ -1953,12 +1954,12 @@ void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *l)
>       } else if (cond == TCG_COND_ALWAYS) {
>           tcg_gen_br(l);
>       } else if (cond != TCG_COND_NEVER) {
> -        tcg_gen_op6ii_i32(INDEX_op_brcond2_i32,
> -                          TCGV_LOW(arg1), TCGV_HIGH(arg1),
> -                          tcg_constant_i32(arg2),
> -                          tcg_constant_i32(arg2 >> 32),
> -                          cond, label_arg(l));
> -        add_last_as_label_use(l);
> +        TCGOp *op = tcg_gen_op6ii_i32(INDEX_op_brcond2_i32,
> +                                      TCGV_LOW(arg1), TCGV_HIGH(arg1),
> +                                      tcg_constant_i32(arg2),
> +                                      tcg_constant_i32(arg2 >> 32),
> +                                      cond, label_arg(l));
> +        add_as_label_use(l, op);
>       }
>   }
>   

the tcg_last_op() referred to in this case can be another op than the 
one expected?
Are there other cases where usage of tcg_last_op could be a problem?

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


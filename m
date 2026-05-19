Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A420CD4F54
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 20:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPRFR-00031o-Na; Tue, 19 May 2026 16:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPRFQ-00031J-3H
 for qemu-devel@nongnu.org; Tue, 19 May 2026 16:41:04 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPRFO-0003Rp-7B
 for qemu-devel@nongnu.org; Tue, 19 May 2026 16:41:03 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so19975265e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 13:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779223260; x=1779828060; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OPsT7rySyyfxHZjdpFm+pfAZaki4QjQSY89EGYwyr9Y=;
 b=ZsXOUAW7vJURVi7ofPfMX7tCdQSD+22fJYbrOeaUsw1eMpXPDAYmiJQa4MgOi5FIUG
 VIcDgJ8OU5vly9rJsSm6XnK2WLBdMCcyi8k+JIgiN9p77BKqyrDh/TFP1kixe6fj9Ujd
 nUtjnC6sA4OVT8wnyuxMh0B2xg6kpj0jSaOQeF9OIoffm+CKCXr6z8SJb8oPXFsmhN94
 lP9prJdRFQNlIzSoAWQF3OKvsUnBI+xqDUsgohNY/ueuBaihNq5S0V8Qe0HOPS+Kn8nB
 xAJzTZCTJ6aKuNP/YxGxaOxqa1FXGD8pJFobBH+Dgh8LwuoXY/X0HaeG2mxCQByGDh0k
 NYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779223260; x=1779828060;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OPsT7rySyyfxHZjdpFm+pfAZaki4QjQSY89EGYwyr9Y=;
 b=aasZblL44HpV/kbcNQvBmAtHT4tMsLvO1F59h5WOQEVMm4EMGQqgEYjmtws7ckkP8e
 Ns5mUqE6U+wp2CXWcWjokShFCCEUa2EQCnSLga9w1InbG+DyyJlZPSGtPrjheT/jThUl
 0bi1yxUN7MZ67G2NNuaRQZbi666WeVzoSEMti3sjR96JmUjgUuNGiiTC57rBF6AmvXzD
 xaJQdTrP2jU4SRP19CpcoTCwwuCMD+1Ze6fvoq/49DfjMpNNSdblx6KNZaadLx98jMw8
 fl5kDdKF8Srl4IGs+cAwMYsAePLtf6uNQg1TM1OYrS6Dzf8FST6mVDCypdNYBeSdpK3E
 tJmA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/oKYkemP/BPIqVY9VHfp1WdUnsQNexKOIKwyogoJnhxye8Ac3XbYQv0sb9rNKdU1jSyJlzy980Cfad@nongnu.org
X-Gm-Message-State: AOJu0YxDBmZniXVuAm6mZi3soLvw6gMNTVtLCT2sstymDHvIOUT8NOvR
 GjFQliiLyV/yZxIpD2WbxdH9TU344+s2KnFPmo+le3ZehRXv2t/V7aKrRSeKMfcdooQ=
X-Gm-Gg: Acq92OGFIph/K4tdUWyOMCTpoCG8MNFtf1ZM2QVEEQ3tFevbXBEcdoRZI+x879mdAii
 rjffmRd9RLPlnOx64Z08mzyqWed9l0/2tFw1YOjp1EMcqHP6/EROloTN+xnFgcZrJYtqGV7L3/H
 nNSyP8iCa5g9ejmyv9ItcBTRJaVzoc2ybqAYIGCuYj9ZkKChW+gtA+7FmQbj8EmNgvKa0fF5/3Z
 dKvP3OsbDxS6GJ0yUMAxaczoIuOomn87kJ6cIL2BnPo60xBaALCX0AeNrCGgHWYCjUG+gvfl+YJ
 UVLInTUnX7I7t4qmfcZSvDQdKdrfgVsr9woBlOGlFIIoqJLL+LhxxF8fL+14OHDOuDaWKleqaoL
 paTnXNx5j+LrwApmx9gG9F0RNIDqf7xc8gJ584g05nW7bkRvvINOh8+YwaAiGD7crqTTG7u0Icw
 mSafarWFFnfwRUD9Opylq2LHtKd03VwwjotSgYoF2YXGdvglhTZAQc5d5ljNM9oN8963NAKvYg2
 zJL
X-Received: by 2002:a05:600c:4692:b0:489:a4:e555 with SMTP id
 5b1f17b1804b1-48fe6326445mr336783785e9.21.1779223260214; 
 Tue, 19 May 2026 13:41:00 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4dac000sm356145625e9.0.2026.05.19.13.40.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 13:40:59 -0700 (PDT)
Message-ID: <0f7c8dda-208c-416e-b722-b3e5033a1bbb@linaro.org>
Date: Tue, 19 May 2026 22:40:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 14/40] tcg: Optimize INDEX_op_mul[us]2 for 0 and 1
Content-Language: en-US
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
 <20260519-mips-octeon-missing-insns-v2-v9-14-d7dd735ecddd@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-14-d7dd735ecddd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 19/5/26 18:22, James Hilliard wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> Zero operands produce a zero high and low product. One operands produce
> a copy of the other operand and a zero or sign extension in the high
> half.
> 
> Fold those cases during TCG optimization so wide-multiply idioms used by
> target translators can collapse before code generation.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> ---
> Changes v7 -> v8:
>    - New patch from Richard Henderson's v7.5 multiplier rework.
> ---
>   tcg/optimize.c | 92 ++++++++++++++++++++++++++++++++++++++--------------------
>   1 file changed, 60 insertions(+), 32 deletions(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index b1abec69a5..a42ab16fb4 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2173,45 +2173,73 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
>   {
>       swap_commutative(op->args[0], &op->args[2], &op->args[3]);
>   
> -    if (arg_is_const(op->args[2]) && arg_is_const(op->args[3])) {
> -        uint64_t a = arg_const_val(op->args[2]);
> +    if (arg_is_const(op->args[3])) {
>           uint64_t b = arg_const_val(op->args[3]);
> -        uint64_t h, l;
> -        TCGArg rl, rh;
> +        TCGArg rl = op->args[0];
> +        TCGArg rh = op->args[1];
>           TCGOp *op2;
>   
> -        switch (op->opc) {
> -        case INDEX_op_mulu2:
> -            if (ctx->type == TCG_TYPE_I32) {
> -                l = (uint64_t)(uint32_t)a * (uint32_t)b;
> -                h = (int32_t)(l >> 32);
> -                l = (int32_t)l;
> -            } else {
> -                mulu64(&l, &h, a, b);
> -            }
> -            break;
> -        case INDEX_op_muls2:
> -            if (ctx->type == TCG_TYPE_I32) {
> -                l = (int64_t)(int32_t)a * (int32_t)b;
> -                h = l >> 32;
> -                l = (int32_t)l;
> -            } else {
> -                muls64(&l, &h, a, b);
> +        if (arg_is_const(op->args[2])) {
> +            uint64_t a = arg_const_val(op->args[2]);
> +            uint64_t h, l;
> +
> +            switch (op->opc) {
> +            case INDEX_op_mulu2:
> +                if (ctx->type == TCG_TYPE_I32) {
> +                    l = (uint64_t)(uint32_t)a * (uint32_t)b;
> +                    h = (int32_t)(l >> 32);
> +                    l = (int32_t)l;
> +                } else {
> +                    mulu64(&l, &h, a, b);
> +                }
> +                break;
> +            case INDEX_op_muls2:
> +                if (ctx->type == TCG_TYPE_I32) {
> +                    l = (int64_t)(int32_t)a * (int32_t)b;
> +                    h = l >> 32;
> +                    l = (int32_t)l;
> +                } else {
> +                    muls64(&l, &h, a, b);
> +                }
> +                break;
> +            default:
> +                g_assert_not_reached();
>               }
> -            break;
> -        default:
> -            g_assert_not_reached();
> -        }
>   
> -        rl = op->args[0];
> -        rh = op->args[1];
> +            /* The proper opcode is supplied by tcg_opt_gen_mov. */
> +            op2 = opt_insert_before(ctx, op, 0, 2);
> +            tcg_opt_gen_movi(ctx, op2, rl, l);
> +            tcg_opt_gen_movi(ctx, op, rh, h);
> +            return true;
> +        }
>   
> -        /* The proper opcode is supplied by tcg_opt_gen_mov. */
> -        op2 = opt_insert_before(ctx, op, 0, 2);
> +        if (b == 0) {
> +            op2 = opt_insert_before(ctx, op, 0, 2);
> +            tcg_opt_gen_movi(ctx, op2, rl, 0);
> +            tcg_opt_gen_movi(ctx, op, rh, 0);
> +            return true;
> +        }
> +        if (b == 1) {
> +            op2 = opt_insert_before(ctx, op, 0, 2);
> +            tcg_opt_gen_mov(ctx, op2, rl, op->args[2]);
> +
> +            switch (op->opc) {
> +            case INDEX_op_mulu2:
> +                tcg_opt_gen_movi(ctx, op, rh, 0);
> +                break;
> +            case INDEX_op_muls2:
> +                op->opc = INDEX_op_sar;
> +                op->args[0] = rh;
> +                op->args[1] = rl;
> +                op->args[2] =
> +                    arg_new_constant(ctx, tcg_type_size(ctx->type) * 8 - 1);
> +                break;
> +            default:
> +                g_assert_not_reached();
> +            }
>   
> -        tcg_opt_gen_movi(ctx, op, rl, l);
> -        tcg_opt_gen_movi(ctx, op2, rh, h);
> -        return true;
> +            return true;
> +        }
>       }
>       return finish_folding(ctx, op);
>   }
> 

Removing the indentation changes, the content of this patch is:

-- >8 --
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 3defc67c853..a42ab16fb4c 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2208,9 +2208,36 @@ static bool fold_multiply2(OptContext *ctx, TCGOp 
*op)

              /* The proper opcode is supplied by tcg_opt_gen_mov. */
              op2 = opt_insert_before(ctx, op, 0, 2);
-            tcg_opt_gen_movi(ctx, op, rl, l);
-            tcg_opt_gen_movi(ctx, op2, rh, h);
+            tcg_opt_gen_movi(ctx, op2, rl, l);
+            tcg_opt_gen_movi(ctx, op, rh, h);
+            return true;
+        }
+
+        if (b == 0) {
+            op2 = opt_insert_before(ctx, op, 0, 2);
+            tcg_opt_gen_movi(ctx, op2, rl, 0);
+            tcg_opt_gen_movi(ctx, op, rh, 0);
+            return true;
+        }
+        if (b == 1) {
+            op2 = opt_insert_before(ctx, op, 0, 2);
+            tcg_opt_gen_mov(ctx, op2, rl, op->args[2]);
+
+            switch (op->opc) {
+            case INDEX_op_mulu2:
+                tcg_opt_gen_movi(ctx, op, rh, 0);
+                break;
+            case INDEX_op_muls2:
+                op->opc = INDEX_op_sar;
+                op->args[0] = rh;
+                op->args[1] = rl;
+                op->args[2] =
+                    arg_new_constant(ctx, tcg_type_size(ctx->type) * 8 
- 1);
+                break;
+            default:
+                g_assert_not_reached();
+            }
              return true;
          }
      }
---

I don't understand this change:

-            tcg_opt_gen_movi(ctx, op, rl, l);
-            tcg_opt_gen_movi(ctx, op2, rh, h);
+            tcg_opt_gen_movi(ctx, op2, rl, l);
+            tcg_opt_gen_movi(ctx, op, rh, h);



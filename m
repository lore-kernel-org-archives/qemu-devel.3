Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D97C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 14:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk20i-0000Kw-Lw; Mon, 17 Feb 2025 09:22:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk20f-0000KW-Hf
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:22:09 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk20d-0000vk-Ay
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:22:09 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4398738217aso7552415e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 06:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739802125; x=1740406925; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DVcAAsjICbcv1ohJdPTm/dkn5mhvXJ6BDH5PRfaYl98=;
 b=HdwlCPHr98YK0K+sJXEgWRqUglSBQYf3Hdh1Cgv7CTpFqcwgnzmAz6mdHtvDT9xp/j
 vn9JalKrOMb2q8OXiiNgIvdWH81xw4oahEeB+w4Aw0K99aocVKU0JyOlGdClcoTa/XGQ
 q/ykzKQaDh48gcVHFP6hRYSp8o59n4k3v4pzpe9zyf1MR6bOKxvYQJiZ5l1eog+LvbpY
 +gsV6LD/UkcSnbUD93qTJxhovS8QCr8RUo/msDphc6SejD0CWxqQt7h3z037rRjurPGP
 6EJg0aSApjTb+NHFUTwM2Y5PNS3T9zm4wEqRVsYV9DT1KFl7ywQeV1beFn84LtflUqci
 k9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739802125; x=1740406925;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DVcAAsjICbcv1ohJdPTm/dkn5mhvXJ6BDH5PRfaYl98=;
 b=k7OKp9kIXS7P4kZClju5rPtAn5CqNaEPRmy3nBhZA2+Cp4OFBz6BopK4aYDMFXKdVF
 PxkQg6IN5X/6t/x+p18sWvEbcN2qgeEnypDMGqvm0wP16CDOt0yAW49orP5yj4xZxPZ9
 0wawFR+qvNeeou/KimUosskES7tMKGx9wEMVrxOXH2yCOeMTZMlLQqnss/b6NG/XsmMp
 +UXngwM1iT+j1YWjQdFF2DosboZdHLKvJZkduPl6bmWqa0xubikO3mbf00iculkYkJnX
 rbHkw3aBBhhtFy4jvIXWZ7zJPr2j+uwf6in8SVJzzCuFw5wrQY6a7uqx+nmI1LAcmGfK
 H17g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBbbR0REh3pfAQGP7L5xIv6RbgH5N49fy9Q8CtMHudmkabvGgcsyRF1tk/QEDOqaP0/RBe2myeE/8G@nongnu.org
X-Gm-Message-State: AOJu0YzTHILlcgY8hux8sMhsD9P3KzKdoKJv391bJiG9cnloStXdKNN+
 X8n8aefOL2mkFjXxC6HncRgQbiOGHXh481mgycrYxiA3ym/Qswt0lL0Znm45mPc=
X-Gm-Gg: ASbGncsTX22si21fMrcaPah8Vo7wGuT1IOr9WAKPc8y1rXJRP7igFDiSKLtmY3IpwbW
 SaqJUXhazvgcnZcuzQDrhWkRXv7N50qHxB/zFE2bw2v2XhXPsq4XT9a2+oYT6nmFYiD2h47/mNM
 IVbXP9DrkhnAJTpariK4yFfCmEMDq45WQ5Jci065c/+ZFgF8m4TUWnttgXLKTlMa1O+qAiMc1Dl
 GvPgMBh+UgB7f1V4NwnyDX5G6r7OBiCLF8SS+nlGzv0Y9cfqn6tnO7XyhDF8gs4NTbA6b23fkCd
 t8LeurAyiU6lNziiIISsHx4O/s9PjWTElr8=
X-Google-Smtp-Source: AGHT+IEtVLEuHK1q2skrgV1v5AzLTedVgqTzw7c+RCPZuCnkfedoxCFwDzyB9tV02jzF+nl9tg/UjA==
X-Received: by 2002:a05:600c:3151:b0:439:614b:1c15 with SMTP id
 5b1f17b1804b1-4396e6c4e2amr95642825e9.13.1739802125341; 
 Mon, 17 Feb 2025 06:22:05 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1aa779sm153436225e9.30.2025.02.17.06.22.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 06:22:04 -0800 (PST)
Message-ID: <fb27fd8f-5ff6-47a6-8499-eb9e7706b77a@linaro.org>
Date: Mon, 17 Feb 2025 15:22:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] tcg: Merge INDEX_op_qemu_*_{a32,a64}_*
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250205040341.2056361-1-richard.henderson@linaro.org>
 <20250205040341.2056361-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-ppc <qemu-ppc@nongnu.org>, Stefan Weil <sw@weilnetz.de>
In-Reply-To: <20250205040341.2056361-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 5/2/25 05:03, Richard Henderson wrote:
> Since 64-on-32 is now unsupported, guest addresses always
> fit in one host register.  Drop the replication of opcodes.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h            |  28 ++------
>   tcg/optimize.c                   |  21 ++----
>   tcg/tcg-op-ldst.c                |  82 +++++----------------
>   tcg/tcg.c                        |  42 ++++-------
>   tcg/tci.c                        | 119 ++++++-------------------------
>   tcg/aarch64/tcg-target.c.inc     |  36 ++++------
>   tcg/arm/tcg-target.c.inc         |  40 +++--------
>   tcg/i386/tcg-target.c.inc        |  69 ++++--------------
>   tcg/loongarch64/tcg-target.c.inc |  36 ++++------
>   tcg/mips/tcg-target.c.inc        |  51 +++----------
>   tcg/ppc/tcg-target.c.inc         |  68 ++++--------------
>   tcg/riscv/tcg-target.c.inc       |  24 +++----
>   tcg/s390x/tcg-target.c.inc       |  36 ++++------
>   tcg/sparc64/tcg-target.c.inc     |  24 +++----
>   tcg/tci/tcg-target.c.inc         |  60 ++++------------
>   15 files changed, 177 insertions(+), 559 deletions(-)


> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 43b6712286..295004b74f 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c


> -            case INDEX_op_qemu_ld_a32_i32:
> -            case INDEX_op_qemu_ld_a64_i32:
> -            case INDEX_op_qemu_st_a32_i32:
> -            case INDEX_op_qemu_st_a64_i32:
> -            case INDEX_op_qemu_st8_a32_i32:
> -            case INDEX_op_qemu_st8_a64_i32:
> -            case INDEX_op_qemu_ld_a32_i64:
> -            case INDEX_op_qemu_ld_a64_i64:
> -            case INDEX_op_qemu_st_a32_i64:
> -            case INDEX_op_qemu_st_a64_i64:
> -            case INDEX_op_qemu_ld_a32_i128:
> -            case INDEX_op_qemu_ld_a64_i128:
> -            case INDEX_op_qemu_st_a32_i128:
> -            case INDEX_op_qemu_st_a64_i128:
> +            case INDEX_op_qemu_ld_i32:
> +            case INDEX_op_qemu_st_i32:
> +            case INDEX_op_qemu_st8_i32:
> +            case INDEX_op_qemu_ld_i64:
> +            case INDEX_op_qemu_st_i64:
> +            case INDEX_op_qemu_ld_i128:
> +            case INDEX_op_qemu_st_i128:

Nice :)

> diff --git a/tcg/tci.c b/tcg/tci.c
> index 8c1c53424d..d223258efe 100644
> --- a/tcg/tci.c
> +++ b/tcg/tci.c
> @@ -154,16 +154,6 @@ static void tci_args_rrrbb(uint32_t insn, TCGReg *r0, TCGReg *r1,
>       *i4 = extract32(insn, 26, 6);
>   }
>   
> -static void tci_args_rrrrr(uint32_t insn, TCGReg *r0, TCGReg *r1,
> -                           TCGReg *r2, TCGReg *r3, TCGReg *r4)
> -{
> -    *r0 = extract32(insn, 8, 4);
> -    *r1 = extract32(insn, 12, 4);
> -    *r2 = extract32(insn, 16, 4);
> -    *r3 = extract32(insn, 20, 4);
> -    *r4 = extract32(insn, 24, 4);
> -}
> -
>   static void tci_args_rrrr(uint32_t insn,
>                             TCGReg *r0, TCGReg *r1, TCGReg *r2, TCGReg *r3)
>   {
> @@ -912,43 +902,21 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
>               tb_ptr = ptr;
>               break;
>   
> -        case INDEX_op_qemu_ld_a32_i32:
> +        case INDEX_op_qemu_ld_i32:
>               tci_args_rrm(insn, &r0, &r1, &oi);
> -            taddr = (uint32_t)regs[r1];
> -            goto do_ld_i32;
> -        case INDEX_op_qemu_ld_a64_i32:
> -            if (TCG_TARGET_REG_BITS == 64) {
> -                tci_args_rrm(insn, &r0, &r1, &oi);
> -                taddr = regs[r1];
> -            } else {
> -                tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
> -                taddr = tci_uint64(regs[r2], regs[r1]);
> -                oi = regs[r3];
> -            }
> -        do_ld_i32:
> +            taddr = regs[r1];
>               regs[r0] = tci_qemu_ld(env, taddr, oi, tb_ptr);
>               break;
>   
> -        case INDEX_op_qemu_ld_a32_i64:
> -            if (TCG_TARGET_REG_BITS == 64) {
> -                tci_args_rrm(insn, &r0, &r1, &oi);
> -                taddr = (uint32_t)regs[r1];
> -            } else {
> -                tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
> -                taddr = (uint32_t)regs[r2];
> -                oi = regs[r3];
> -            }
> -            goto do_ld_i64;
> -        case INDEX_op_qemu_ld_a64_i64:
> +        case INDEX_op_qemu_ld_i64:
>               if (TCG_TARGET_REG_BITS == 64) {
>                   tci_args_rrm(insn, &r0, &r1, &oi);
>                   taddr = regs[r1];
>               } else {
> -                tci_args_rrrrr(insn, &r0, &r1, &r2, &r3, &r4);
> -                taddr = tci_uint64(regs[r3], regs[r2]);
> -                oi = regs[r4];
> +                tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
> +                taddr = regs[r2];
> +                oi = regs[r3];
>               }
> -        do_ld_i64:
>               tmp64 = tci_qemu_ld(env, taddr, oi, tb_ptr);
>               if (TCG_TARGET_REG_BITS == 32) {
>                   tci_write_reg64(regs, r1, r0, tmp64);
> @@ -957,47 +925,23 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
>               }
>               break;
>   
> -        case INDEX_op_qemu_st_a32_i32:
> +        case INDEX_op_qemu_st_i32:
>               tci_args_rrm(insn, &r0, &r1, &oi);
> -            taddr = (uint32_t)regs[r1];
> -            goto do_st_i32;
> -        case INDEX_op_qemu_st_a64_i32:
> -            if (TCG_TARGET_REG_BITS == 64) {
> -                tci_args_rrm(insn, &r0, &r1, &oi);
> -                taddr = regs[r1];
> -            } else {
> -                tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
> -                taddr = tci_uint64(regs[r2], regs[r1]);
> -                oi = regs[r3];
> -            }
> -        do_st_i32:
> +            taddr = regs[r1];
>               tci_qemu_st(env, taddr, regs[r0], oi, tb_ptr);
>               break;
>   
> -        case INDEX_op_qemu_st_a32_i64:
> -            if (TCG_TARGET_REG_BITS == 64) {
> -                tci_args_rrm(insn, &r0, &r1, &oi);
> -                tmp64 = regs[r0];
> -                taddr = (uint32_t)regs[r1];
> -            } else {
> -                tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
> -                tmp64 = tci_uint64(regs[r1], regs[r0]);
> -                taddr = (uint32_t)regs[r2];
> -                oi = regs[r3];
> -            }
> -            goto do_st_i64;
> -        case INDEX_op_qemu_st_a64_i64:
> +        case INDEX_op_qemu_st_i64:
>               if (TCG_TARGET_REG_BITS == 64) {
>                   tci_args_rrm(insn, &r0, &r1, &oi);
>                   tmp64 = regs[r0];
>                   taddr = regs[r1];
>               } else {
> -                tci_args_rrrrr(insn, &r0, &r1, &r2, &r3, &r4);
> +                tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
>                   tmp64 = tci_uint64(regs[r1], regs[r0]);
> -                taddr = tci_uint64(regs[r3], regs[r2]);
> -                oi = regs[r4];
> +                taddr = regs[r2];
> +                oi = regs[r3];
>               }

My tci is rusty, but this LGTM.

> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 6e711cd53f..801cb6f3cb 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -3308,17 +3308,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out32(s, MODUD | TAB(args[0], args[1], args[2]));
>           break;
>   
> -    case INDEX_op_qemu_ld_a64_i32:
> -        if (TCG_TARGET_REG_BITS == 32) {
> -            tcg_out_qemu_ld(s, args[0], -1, args[1], args[2],
> -                            args[3], TCG_TYPE_I32);
> -            break;
> -        }
> -        /* fall through */
> -    case INDEX_op_qemu_ld_a32_i32:
> +    case INDEX_op_qemu_ld_i32:
>           tcg_out_qemu_ld(s, args[0], -1, args[1], -1, args[2], TCG_TYPE_I32);
>           break;
> -    case INDEX_op_qemu_ld_a32_i64:
> +    case INDEX_op_qemu_ld_i64:
>           if (TCG_TARGET_REG_BITS == 64) {
>               tcg_out_qemu_ld(s, args[0], -1, args[1], -1,
>                               args[2], TCG_TYPE_I64);
> @@ -3327,32 +3320,15 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                               args[3], TCG_TYPE_I64);
>           }
>           break;
> -    case INDEX_op_qemu_ld_a64_i64:
> -        if (TCG_TARGET_REG_BITS == 64) {
> -            tcg_out_qemu_ld(s, args[0], -1, args[1], -1,
> -                            args[2], TCG_TYPE_I64);
> -        } else {
> -            tcg_out_qemu_ld(s, args[0], args[1], args[2], args[3],
> -                            args[4], TCG_TYPE_I64);
> -        }
> -        break;
> -    case INDEX_op_qemu_ld_a32_i128:
> -    case INDEX_op_qemu_ld_a64_i128:
> +    case INDEX_op_qemu_ld_i128:
>           tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
>           tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], true);
>           break;
>   
> -    case INDEX_op_qemu_st_a64_i32:
> -        if (TCG_TARGET_REG_BITS == 32) {
> -            tcg_out_qemu_st(s, args[0], -1, args[1], args[2],
> -                            args[3], TCG_TYPE_I32);
> -            break;
> -        }
> -        /* fall through */
> -    case INDEX_op_qemu_st_a32_i32:
> +    case INDEX_op_qemu_st_i32:
>           tcg_out_qemu_st(s, args[0], -1, args[1], -1, args[2], TCG_TYPE_I32);
>           break;
> -    case INDEX_op_qemu_st_a32_i64:
> +    case INDEX_op_qemu_st_i64:
>           if (TCG_TARGET_REG_BITS == 64) {
>               tcg_out_qemu_st(s, args[0], -1, args[1], -1,
>                               args[2], TCG_TYPE_I64);
> @@ -3361,17 +3337,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                               args[3], TCG_TYPE_I64);
>           }
>           break;
> -    case INDEX_op_qemu_st_a64_i64:
> -        if (TCG_TARGET_REG_BITS == 64) {
> -            tcg_out_qemu_st(s, args[0], -1, args[1], -1,
> -                            args[2], TCG_TYPE_I64);
> -        } else {
> -            tcg_out_qemu_st(s, args[0], args[1], args[2], args[3],
> -                            args[4], TCG_TYPE_I64);
> -        }
> -        break;

Diff context isn't sufficient to review, but after applying and
looking at the result, PPC LGTM.


> @@ -833,29 +811,21 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_op_rrrr(s, opc, args[0], args[1], args[2], args[3]);
>           break;
>   
> -    case INDEX_op_qemu_ld_a32_i32:
> -    case INDEX_op_qemu_st_a32_i32:
> -        tcg_out_op_rrm(s, opc, args[0], args[1], args[2]);
> -        break;
> -    case INDEX_op_qemu_ld_a64_i32:
> -    case INDEX_op_qemu_st_a64_i32:
> -    case INDEX_op_qemu_ld_a32_i64:
> -    case INDEX_op_qemu_st_a32_i64:
> -        if (TCG_TARGET_REG_BITS == 64) {
> -            tcg_out_op_rrm(s, opc, args[0], args[1], args[2]);
> -        } else {
> +    case INDEX_op_qemu_ld_i64:
> +    case INDEX_op_qemu_st_i64:
> +        if (TCG_TARGET_REG_BITS == 32) {
>               tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, args[3]);
>               tcg_out_op_rrrr(s, opc, args[0], args[1], args[2], TCG_REG_TMP);
> +            break;
>           }
> -        break;
> -    case INDEX_op_qemu_ld_a64_i64:
> -    case INDEX_op_qemu_st_a64_i64:
> -        if (TCG_TARGET_REG_BITS == 64) {
> -            tcg_out_op_rrm(s, opc, args[0], args[1], args[2]);
> +        /* fall through */
> +    case INDEX_op_qemu_ld_i32:
> +    case INDEX_op_qemu_st_i32:
> +        if (TCG_TARGET_REG_BITS == 64 && s->addr_type == TCG_TYPE_I32) {
> +            tcg_out_ext32u(s, TCG_REG_TMP, args[1]);
> +            tcg_out_op_rrm(s, opc, args[0], TCG_REG_TMP, args[2]);
>           } else {
> -            tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, args[4]);
> -            tcg_out_op_rrrrr(s, opc, args[0], args[1],
> -                             args[2], args[3], TCG_REG_TMP);
> +            tcg_out_op_rrm(s, opc, args[0], args[1], args[2]);
>           }
>           break;

Also LGTM looking at applied changes, so I dare to:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

(thanksfully 64-bit hosts were trivial)


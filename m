Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4641C021B3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 23:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlFxK-0003nm-6t; Thu, 20 Feb 2025 18:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlFxI-0003fw-8B
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 18:27:44 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlFxF-0003O6-5x
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 18:27:43 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38f22fe889aso1255832f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 15:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740094059; x=1740698859; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7Wr6181q14F4WVMnw4hDnzoAr6pZykpyNNWHBd6x5w0=;
 b=DKC3iXYgtypDAiJH61NDIpqIxoBhvgLmG9nwbTsmGWdxnNx71BlZy4YlS1bYawGts/
 cUdHZLm9mYrZBHgHohFxrjmSFPLks6n6hU5bDGAUkMKZy23NPBz/VXYZlX71U8p4KCm2
 3ZElTeJ8Mdrk7qLNlVxQDBdgDQt2GUA6urNT3wcOwS7HOLfd8WyS7QneP/U1WMDU7ibr
 RViuaonBddm5b1z4tBTnPevhVgiI7tZIMqaebERaB7deQQCFqTL9I+e1Hu6lfUk/wU2f
 2zb+RJJcf710I0MpuvRLjp19h9mYq5tHh2tx9hRzCeNW0WoUyVn76oqUV00RrhNIWbSf
 NLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740094059; x=1740698859;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Wr6181q14F4WVMnw4hDnzoAr6pZykpyNNWHBd6x5w0=;
 b=BhecO8UiaoezZcaAzTpVxvJbbZpPFUAwr8TO/ZugXmEcE+GfdoBkro8/dgpwS2A3oC
 m8Nr6RUi7dxaIDraL28KD3J8eRBPJkPa5eDph2DOUqnOxyIoYkbU2ix6h4/MX68pWyAn
 KMhfBy5lxU5PLywmRwOxaudTJhD64OckJEDiGkFo4P7Kze9L+SXKk/kckXF3VVixs1oW
 Agup2nzq1NDSQ7CWC2Wi9cj1QMv3nWZeku9AwlmKCd2xSE+h/rdIHIfpeIaIMWrtrnAp
 UlRQBllOTFHVylPkbTxvBTiSjb5UsqV12yFsNyx2s9wMU5kDlSI2yPHYP0qvRaiFEUbL
 cx9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrI4gO3Ei3fdRtjvCPNAgoEi+b5QkTu9uAnQToPFL2nSWYCDpGZNmqFjLOhKddx1YKqDEkzslnr3wt@nongnu.org
X-Gm-Message-State: AOJu0Yz0zGDMDh/3XfF17wHm1GoCLN0H1QijDXuzJOOTyj01nTcMRitX
 wnwGaqMwQknXQdRGTu9PiI71vNx1U+9y4hdg4QyR+tZyjvWLIRsV48rJeUX69P4TtkkTodETB2c
 BSng=
X-Gm-Gg: ASbGncvnkUZA0j3to/pN3pMVHt5iVbDGhxV/8qHjrUiB90dYBaPMpJyDb1jMU+9GBjG
 p/fai7jeAMattfeKTlOQBVyvAhJIa4OaaZbLg2PGDZBr8cBuUi/oumLZmYe1dr2OmzQWzl01wbH
 ATZTeZotq4MHAHCMvsU0L9xsn4cNPe9OaoqDekNVNA00047fZ/cG2RZOZBSXjL6MKkBefpXAk5t
 8IeUh/WOqrPKPWPjmMYMCp4e+OaGuFPaeEwKX9QmQhbYi3st5IeazDkdyxf9Ekho9t835vjfspI
 tMSEVLvAhWMkWJbARW+11VKnqRZR2auL6Dp6i77fB89vaw9T8Oua3SGombo=
X-Google-Smtp-Source: AGHT+IECkEhXRMPw+Y4FT1tWpcf1H8Y4ZVkOT/sCF2MSFmIdWI7XD9iQwvSr3VYE96O3F8bFtVx5SQ==
X-Received: by 2002:a05:6000:1888:b0:38c:5bc1:1f03 with SMTP id
 ffacd0b85a97d-38f6e7563femr753648f8f.7.1740094059127; 
 Thu, 20 Feb 2025 15:27:39 -0800 (PST)
Received: from [192.168.69.157] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f69b3ca41sm2143574f8f.27.2025.02.20.15.27.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 15:27:38 -0800 (PST)
Message-ID: <95e6af77-05bf-46f5-9e85-ce913b08706e@linaro.org>
Date: Fri, 21 Feb 2025 00:27:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 33/42] tcg/riscv: Require TCG_TARGET_REG_BITS == 64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-riscv <qemu-riscv@nongnu.org>
References: <20230505212447.374546-1-richard.henderson@linaro.org>
 <20230505212447.374546-34-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20230505212447.374546-34-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 5/5/23 23:24, Richard Henderson wrote:
> The port currently does not support "oversize" guests, which
> means riscv32 can only target 32-bit guests.  We will soon be
> building TCG once for all guests.  This implies that we can
> only support riscv64.
> 
> Since all Linux distributions target riscv64 not riscv32,
> this is not much of a restriction and simplifies the code.
> 
> The brcond2 and setcond2 opcodes are exclusive to 32-bit hosts,
> so we can and should remove the stubs.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/riscv/tcg-target-con-set.h |   8 --
>   tcg/riscv/tcg-target.h         |  22 ++--
>   tcg/riscv/tcg-target.c.inc     | 232 +++++++++------------------------
>   3 files changed, 72 insertions(+), 190 deletions(-)


> diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
> index 0deb33701f..dddf2486c1 100644
> --- a/tcg/riscv/tcg-target.h
> +++ b/tcg/riscv/tcg-target.h
> @@ -25,11 +25,14 @@
>   #ifndef RISCV_TCG_TARGET_H
>   #define RISCV_TCG_TARGET_H
>   
> -#if __riscv_xlen == 32
> -# define TCG_TARGET_REG_BITS 32
> -#elif __riscv_xlen == 64
> -# define TCG_TARGET_REG_BITS 64
> +/*
> + * We don't support oversize guests.
> + * Since we will only build tcg once, this in turn requires a 64-bit host.
> + */
> +#if __riscv_xlen != 64
> +#error "unsupported code generation mode"
>   #endif
> +#define TCG_TARGET_REG_BITS 64
>   
>   #define TCG_TARGET_INSN_UNIT_SIZE 4
>   #define TCG_TARGET_TLB_DISPLACEMENT_BITS 20
> @@ -83,13 +86,8 @@ typedef enum {
>   #define TCG_TARGET_STACK_ALIGN          16
>   #define TCG_TARGET_CALL_STACK_OFFSET    0
>   #define TCG_TARGET_CALL_ARG_I32         TCG_CALL_ARG_NORMAL
> -#if TCG_TARGET_REG_BITS == 32
> -#define TCG_TARGET_CALL_ARG_I64         TCG_CALL_ARG_EVEN
> -#define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_EVEN
> -#else
>   #define TCG_TARGET_CALL_ARG_I64         TCG_CALL_ARG_NORMAL
>   #define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_NORMAL
> -#endif
>   #define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
>   
>   /* optional instructions */
> @@ -106,8 +104,8 @@ typedef enum {
>   #define TCG_TARGET_HAS_sub2_i32         1
>   #define TCG_TARGET_HAS_mulu2_i32        0
>   #define TCG_TARGET_HAS_muls2_i32        0
> -#define TCG_TARGET_HAS_muluh_i32        (TCG_TARGET_REG_BITS == 32)
> -#define TCG_TARGET_HAS_mulsh_i32        (TCG_TARGET_REG_BITS == 32)
> +#define TCG_TARGET_HAS_muluh_i32        0
> +#define TCG_TARGET_HAS_mulsh_i32        0

Should have we squashed the following with these changes?

-- >8 --
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index f7e1ca5a56f..e395ffcdaf5 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2323,10 +2323,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode 
opc, TCGType type,
          break;

-    case INDEX_op_mulsh_i32:
      case INDEX_op_mulsh_i64:
          tcg_out_opc_reg(s, OPC_MULH, a0, a1, a2);
          break;

-    case INDEX_op_muluh_i32:
      case INDEX_op_muluh_i64:
          tcg_out_opc_reg(s, OPC_MULHU, a0, a1, a2);
@@ -2399,4 +2397,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode 
opc, TCGType type,
      case INDEX_op_extu_i32_i64:
      case INDEX_op_extrl_i64_i32:
+    case INDEX_op_mulsh_i32:
+    case INDEX_op_muluh_i32:
      default:
          g_assert_not_reached();
@@ -2707,6 +2707,4 @@ tcg_target_op_def(TCGOpcode op, TCGType type, 
unsigned flags)

      case INDEX_op_mul_i32:
-    case INDEX_op_mulsh_i32:
-    case INDEX_op_muluh_i32:
      case INDEX_op_div_i32:
      case INDEX_op_divu_i32:
---

>   #define TCG_TARGET_HAS_ext8s_i32        1
>   #define TCG_TARGET_HAS_ext16s_i32       1
>   #define TCG_TARGET_HAS_ext8u_i32        1
> @@ -128,7 +126,6 @@ typedef enum {
>   #define TCG_TARGET_HAS_setcond2         1
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
>   
> -#if TCG_TARGET_REG_BITS == 64
>   #define TCG_TARGET_HAS_movcond_i64      0
>   #define TCG_TARGET_HAS_div_i64          1
>   #define TCG_TARGET_HAS_rem_i64          1
> @@ -165,7 +162,6 @@ typedef enum {
>   #define TCG_TARGET_HAS_muls2_i64        0
>   #define TCG_TARGET_HAS_muluh_i64        1
>   #define TCG_TARGET_HAS_mulsh_i64        1
> -#endif
>   
>   #define TCG_TARGET_DEFAULT_MO (0)


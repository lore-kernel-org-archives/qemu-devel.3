Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204F7C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 21:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlENR-0004mV-Ip; Thu, 20 Feb 2025 16:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlENF-0004l3-3P
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 16:46:27 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlEN9-0007jP-IC
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 16:46:21 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4399deda38cso8903195e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 13:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740087974; x=1740692774; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qFs6cHsY0bH0HxkSslAttAwXYobdhbjH6QBA95olbx8=;
 b=sQe1lQR7HnYNsmJNiVUNuRViDhQJ0kkqw+nwb4fiwTB92wv+P4uWula6yDExZgC7A2
 qeM+2Da9F2UkzFeszRpehasyVXqBquEvHQuGhx3pZGwpKBRtR7/sUHacTUVZ8SbH7xDU
 Yn7KggKtRjZ3k/XFEgVohI0Wv5vnKPIOltiQTwASDoLkd95Y/QISvuULB6cyAFutf4Nn
 qxjgeB4YcIkQxclJW+9hrsgSCgkfBcHFJWZ44RWvV+ssQwK7/g3KZLps4WH4/scNZwKD
 g9ZFuE/8PovfBafK28J+o/SVyo0hhAPtkm6s9HNh+QcZC6oavx6X1+7GaH7guZsI29DM
 fdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740087974; x=1740692774;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qFs6cHsY0bH0HxkSslAttAwXYobdhbjH6QBA95olbx8=;
 b=ixr/joHZxMfDlTb8dqhzNVQJ+/TV2zh5rXfpUEdtgk9PdrzSnYJouoSIh2TExN/EIp
 Bs2Haga/QvF3J+Ji50XayDuSvBV+6Y7fnnq8Pa04d6788JCZwEYtagJ2UcnBZ22weohB
 Yhr6i7rqVpeisvBRjAVNO+7ngbhGideM9qL5OObw7VQ1h4SPQJcPZxZb4ygWd0qDZ+tD
 ZCoQAQD0Enw9dKzK9Bi6phi76Tw1+1kIZUoD/8qn8UJemyyhMge4k6kGsdQmQCHiI674
 i2U2IvAcaQzwGtFGKza+Qfrr6QK6PcJR9P9TCurtG3GxUGpX+ronyLKo4JZ0Avz8n6as
 7eHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUohtcof1F9FJ8tUeECP++QNaFEU7U3ON6QeWt8+NwLJvwszSi+1l8pODjMB7qOdJ83oe854YIFXVq2@nongnu.org
X-Gm-Message-State: AOJu0YxtQwKanl9hnMMw6hwwreh6ds3Rho3wGYimGqp1sr7j5aD3SfGL
 EGRLbTJvMiQCqCS1PigCxhX/JP0abLZLQwLDBQnc7VH94+w2SLZ21BSxJds6NbP553vUwDL9VoI
 zXbg=
X-Gm-Gg: ASbGncu+iXBapGoJfyjWqwMkTYoBKJHPNupbGYRK0Nzj5xmFwZNblmhBq0JLDJ7GI6d
 XxZCu92qYPvMiHpwDf2mn31/vy55OhDeM7rxVuvCc2ML1yrslcEl2Km2xoQsqBaVif/0nZDihrv
 IHBHe7G1opwMY+g3XA6dR3puAqcexdPDHOKpb7W7rymLd+RT+qLKvGQeFzBO7YFQOclGfscuxjx
 PZ7zAqEejS7w05Ewb4+l4+N/OhfcfXFGuElXRFEAMnaX6wHttAr8cKI5o5XoVR8lEjwcierrhoK
 aHg/vVTZ3aGfMPK0p7nfdBn7L6Dy5rpKTs7kENDx0osKDeemjUqw0F3nw7A=
X-Google-Smtp-Source: AGHT+IF2OudTRDehoAET5Zy8h6YIwaGSctNL9agaLnHnH1v5IxzgxDyVwouSYw4tKvKbpE8Uv0aoQw==
X-Received: by 2002:a05:600c:35cc:b0:439:9386:ef6c with SMTP id
 5b1f17b1804b1-439ae1d7ba7mr6154745e9.2.1740087973744; 
 Thu, 20 Feb 2025 13:46:13 -0800 (PST)
Received: from [192.168.69.157] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43999e5beebsm67795315e9.22.2025.02.20.13.46.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 13:46:13 -0800 (PST)
Message-ID: <d7fad8ae-488a-48e9-8aa9-aa02eb706389@linaro.org>
Date: Thu, 20 Feb 2025 22:46:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 002/162] tcg: Remove INDEX_op_ext{8,16,32}*
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 17/2/25 00:07, Richard Henderson wrote:
> Use the fully general extract opcodes instead.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h            |  10 -
>   tcg/aarch64/tcg-target-has.h     |  10 -
>   tcg/arm/tcg-target-has.h         |   4 -
>   tcg/i386/tcg-target-has.h        |  10 -
>   tcg/loongarch64/tcg-target-has.h |  10 -
>   tcg/mips/tcg-target-has.h        |  13 -
>   tcg/ppc/tcg-target-has.h         |  12 -
>   tcg/riscv/tcg-target-has.h       |  10 -
>   tcg/s390x/tcg-target-has.h       |  10 -
>   tcg/sparc64/tcg-target-has.h     |  10 -
>   tcg/tcg-has.h                    |   6 -
>   tcg/tci/tcg-target-has.h         |  10 -
>   tcg/optimize.c                   |  61 +----
>   tcg/tcg-op.c                     | 430 ++++++++-----------------------
>   tcg/tcg.c                        |  46 ----
>   tcg/tci.c                        |  36 ---
>   docs/devel/tcg-ops.rst           |  14 -
>   tcg/aarch64/tcg-target.c.inc     |  22 +-
>   tcg/arm/tcg-target.c.inc         |   7 -
>   tcg/i386/tcg-target.c.inc        |  24 +-
>   tcg/loongarch64/tcg-target.c.inc |  22 +-
>   tcg/mips/tcg-target.c.inc        |  20 +-
>   tcg/ppc/tcg-target.c.inc         |  17 +-
>   tcg/riscv/tcg-target.c.inc       |  22 +-
>   tcg/s390x/tcg-target.c.inc       |  22 +-
>   tcg/sparc64/tcg-target.c.inc     |  14 +-
>   tcg/tci/tcg-target.c.inc         | 102 +++-----
>   27 files changed, 147 insertions(+), 827 deletions(-)


> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index fec6d678a2..48793ed439 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -414,17 +414,19 @@ void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
>       case -1:
>           tcg_gen_mov_i32(ret, arg1);
>           return;
> -    case 0xff:
> -        /* Don't recurse with tcg_gen_ext8u_i32.  */
> -        if (TCG_TARGET_HAS_ext8u_i32) {
> -            tcg_gen_op2_i32(INDEX_op_ext8u_i32, ret, arg1);
> -            return;
> -        }
> -        break;
> -    case 0xffff:
> -        if (TCG_TARGET_HAS_ext16u_i32) {
> -            tcg_gen_op2_i32(INDEX_op_ext16u_i32, ret, arg1);
> -            return;
> +    default:
> +        /*
> +         * Canonicalize on extract, if valid.  This aids x86 with its
> +         * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcode
> +         * which does not require matching operands.  Other backends can
> +         * trivially expand the extract to AND during code generation.
> +         */

            unsigned ofs = ctz32(arg2);
            int32_t val = arg2 >> ofs;

            if (!(val & (val + 1))) {
                unsigned len = cto32(val);
                if (TCG_TARGET_extract_valid(TCG_TYPE_I32, ofs, len)) {
                    tcg_gen_extract_i32(ret, arg1, ofs, len);
                    return;
                }
            }

> +        if (!(arg2 & (arg2 + 1))) {
> +            unsigned len = ctz32(~arg2);
> +            if (TCG_TARGET_extract_valid(TCG_TYPE_I32, 0, len)) {
> +                tcg_gen_extract_i32(ret, arg1, 0, len);
> +                return;
> +            }
>           }
>           break;
>       }


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A090C369BD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 06:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4wgH-0007Zm-6b; Wed, 16 Apr 2025 02:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4wgF-0007ZR-DD
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 02:55:31 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4wgD-00061b-HV
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 02:55:31 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3995ff6b066so3486333f8f.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 23:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744786528; x=1745391328; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fottfAnt4uVjBf9BdvfN4zjK9nb0hAR3xZr83Knb6y4=;
 b=MNTHmSMkU/EweybmzC1f0N9yxR+25pc7BvjiYOZMPm+KqqIPBK8LqrdN7k9Y57ivp0
 7XfeLdrTh2TODVMMwL9ho6pDHTDl8kstE4w6eBIYPkCeyTQld9QDw3i8lSfLVgv7LZVJ
 uEuGeYdYY3sXFTL3HtEGPj3M4yM4kHEiy+oZQh40CPed/qJe1DkllCOOGArf8HSkRE9k
 kX0+boUa+i3cF4s1c7XZHviCTT06pmpKGlTYyjDnd5YdJG/diNtwH0V0OYXPw+koIOiW
 1PGVG4tbWHZ5AAXCRwR0WAmgztEOSAFxIAB/xUkrRpENACFQ+AWZ7gkUNtIeFMVXC6ob
 s/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744786528; x=1745391328;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fottfAnt4uVjBf9BdvfN4zjK9nb0hAR3xZr83Knb6y4=;
 b=wroY3NFWeB4I1HrTsPjJuQa2YmwIRX3QBDDYssMP1dlWB68wf3xMmMgJmrExFAcZz6
 ClGkK8syTRewN+7eVtzUo38ltLe2f/Faecrala9FYyts02bTIH3G+b9YCFNcmldiIaR/
 9dCJA2YeNZj1LOCs8z3RyyKGiqfv7ActojmNtRaGipknOCJXCo/BzTvyiiI+QfJG4B4m
 4AXtx/2UTR2d/SUsALtDrzD1pzmtOf2OwfVIEVKEM/1lKNznpZU74esrYwxN6EWENCtf
 CL/ZlA8NJALqk+aOx5QeC/joDLxbfzCA1ZnfQfvzM++EFIN3CFWtHgmkbwAncf/VPuFp
 mBiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE1DP89HCRHTyWgM6S3HkfqRcBh3BtHv60I+E47fNOuj3GfAubrYFHMW/V4NfRqlIZc/9js96PB04r@nongnu.org
X-Gm-Message-State: AOJu0YxGGusk8j/VQcmQ8N9R2qIGodu22MMSXt+CnU1xt9b+o8udBblO
 BdPGg2yGDCV/FD1Liu3aVyAU3u3rfjnSZiXKiHxDnOETMPKOiq2ygyc6cfjXiDoO4NDE8d5HmNT
 4
X-Gm-Gg: ASbGncsu6BzfsolwEyau4aXwoG5FdTN9q6Khze6etzUMA0Ufokwb8a6st+icx0EDdxM
 1LTP8nbKLc+jCMN8cnSBPX1pxpI95UgSx9pmnltPDKXTe730n+qQedLuUYLt6hYRJQzNRm39hBJ
 OFK3c/nvjReDFbJQoOIeFWRjUC5FgTRp9dPXRvN6EM8fVRhvqoNH2JpM77I9OMKaHO+ci8tw2uj
 LUlDbI/rA9m4CVZKt+YVLwEcXaq2iUG8QJTgfdnQZc8WNGHrEPQNgPxfxxFeU1VYJXxL2JoQa2q
 0n4mBqtlibBp9UivcdPVLTcB4QdRj7gM5ms6i3ZAR1Nr2pyHhqdHsyCSDeeovl+fi0zkWjFnvGZ
 pJ89lRA==
X-Google-Smtp-Source: AGHT+IEWVOfBEPc1tDI/VIemY/zNrRhRH7b+t+O+50S7oaWdECMmD6ET9HEm4Lgj4Aew4xFM0dBtaA==
X-Received: by 2002:a05:6000:22c2:b0:391:29c0:83f5 with SMTP id
 ffacd0b85a97d-39ee5b990f9mr569619f8f.44.1744786527603; 
 Tue, 15 Apr 2025 23:55:27 -0700 (PDT)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b4c7eeesm11823565e9.1.2025.04.15.23.55.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 23:55:27 -0700 (PDT)
Message-ID: <7e614948-f344-4cb1-ae0d-c645fcff562f@linaro.org>
Date: Wed, 16 Apr 2025 08:55:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 159/163] tcg: Remove INDEX_op_qemu_st8_*
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-160-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250415192515.232910-160-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 15/4/25 21:25, Richard Henderson wrote:
> The i386 backend can now check TCGOP_FLAGS to select
> the correct set of constraints.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h            | 4 ----
>   tcg/aarch64/tcg-target-has.h     | 1 -
>   tcg/arm/tcg-target-has.h         | 1 -
>   tcg/i386/tcg-target-con-str.h    | 2 +-
>   tcg/i386/tcg-target-has.h        | 3 ---
>   tcg/loongarch64/tcg-target-has.h | 3 ---
>   tcg/mips/tcg-target-has.h        | 1 -
>   tcg/ppc/tcg-target-has.h         | 2 --
>   tcg/riscv/tcg-target-has.h       | 1 -
>   tcg/s390x/tcg-target-has.h       | 1 -
>   tcg/sparc64/tcg-target-has.h     | 1 -
>   tcg/tci/tcg-target-has.h         | 2 --
>   tcg/optimize.c                   | 1 -
>   tcg/tcg-op-ldst.c                | 9 ++-------
>   tcg/tcg.c                        | 4 ----
>   docs/devel/tcg-ops.rst           | 6 ------
>   tcg/i386/tcg-target.c.inc        | 9 ++++-----
>   17 files changed, 7 insertions(+), 44 deletions(-)


> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index 52285bcd54..40e640ff89 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -2457,7 +2457,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
>   
>       switch (memop & MO_SIZE) {
>       case MO_8:
> -        /* This is handled with constraints on INDEX_op_qemu_st8_i32. */
> +        /* This is handled with constraints on INDEX_op_qemu_st_*_i32. */

"... handled with constraints on INDEX_op_qemu_st_i32."

Either INDEX_op_qemu_st_i32 or INDEX_op_qemu_st_*.

>           tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || datalo < 4);
>           tcg_out_modrm_sib_offset(s, OPC_MOVB_EvGv + P_REXB_R + h.seg,
>                                    datalo, h.base, h.index, 0, h.ofs);
> @@ -3568,7 +3568,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           break;
>   
>       case INDEX_op_qemu_st_i32:
> -    case INDEX_op_qemu_st8_i32:
>           tcg_out_qemu_st(s, a0, -1, a1, a2, TCG_TYPE_I32);
>           break;
>       case INDEX_op_qemu_st_i64:
> @@ -4140,9 +4139,9 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>           return C_O1_I1(r, L);
>   
>       case INDEX_op_qemu_st_i32:
> -        return C_O0_I2(L, L);
> -    case INDEX_op_qemu_st8_i32:
> -        return C_O0_I2(s, L);
> +        return (TCG_TARGET_REG_BITS == 32 && flags == MO_8

)

> +                ? C_O0_I2(s, L)
> +                : C_O0_I2(L, L));

(misplaced parenthesis)

Nice!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



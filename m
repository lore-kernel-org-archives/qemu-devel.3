Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7FF606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 21:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=ilande.co.uk header.i=@ilande.co.uk header.a=rsa-sha256 header.s=20220518 header.b=UBfqJG+T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMAwt-0002Eb-CN; Wed, 28 Oct 2026 17:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xMAwr-0002DC-Fm
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 17:12:41 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xMAwp-0007el-LM
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 17:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=lWl5/llqNsLNDppNt/Psef6Vgli4O2yWNG2JGMcTYZM=; b=UBfqJG+TYfeGN8jjyi+/rkssRD
 OI7jzczk5kZGh5Eqzsptqcdc0u44fu/EzZ8+gpxxmzPQ7MsKffvrqxcPljcB8PGhWW2pKwRr0ord/
 3vvCppd7QQXXqO5erhknFMU8bIWg+QUwpeACA9AY/zrQSigD4p1McADuBapq9QTpHMDVr4yvtcf5M
 u3h/LtZG6RURHsrALy6GhXYGIZIHP/10m97kPZjR9YZNiuTks8bzUQ4BO2pSwPuIpJMyX0Af06xz7
 +5YZWZx7cJE3V4vn2vsxuLJifZiB+W6fs8c+YuPY4blio/1CeMIEi+3JJEIt3d5QNvExAAb4E8JLc
 SUpiC2k/Uv0MxSUmaKypCaI1HcQMKJOTqMtwStVEGN0+1HizsF+V0s7ykrWKl7kIYRK67fTJ42aXq
 mMqrWVKi/GFX+c32mVAaU5bzU0shBlHI3vEYMLi7wjvrl5nrJvQVbAZzcrpDL0sUEX5wBLGBwAeL9
 u20HYmAFQiC4iLyD93xDHmOHTaatAM2q32KCpqIHyCDWOIdF1UjQjt/cK1WYvXmCYAT+T8sk08O3F
 ptMbcqximr9dGPX2SR399twXqQmpMcsKd/2EdDmt0ySaLyQX74TCCJII/ytoOLmznCc2MwbFipd9z
 szT0oeYJzwIwz+/5vcuo93FLOa0DnZvvwgOKWTjPk=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xMAw3-004PzP-8J; Wed, 28 Oct 2026 21:11:51 +0000
Message-ID: <e366030c-f780-4e96-ba2d-558359013969@ilande.co.uk>
Date: Wed, 28 Oct 2026 21:12:29 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
References: <20261028163245.1031673-1-richard.henderson@linaro.org>
 <20261028163245.1031673-3-richard.henderson@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20261028163245.1031673-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 02/16] tcg: Add tcg_gen_lea_{i32,i64,tl}
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 28/10/2026 16:32, Richard Henderson wrote:

> Reviewed-by: Matt Turner <mattst88@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op.h         |  2 ++
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 43 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 46 insertions(+)
> 
> diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
> index 3721164236..a7d001c959 100644
> --- a/include/tcg/tcg-op.h
> +++ b/include/tcg/tcg-op.h
> @@ -83,6 +83,7 @@ typedef TCGv_i64 TCGv;
>   #define tcg_gen_shri_tl tcg_gen_shri_i64
>   #define tcg_gen_sar_tl tcg_gen_sar_i64
>   #define tcg_gen_sari_tl tcg_gen_sari_i64
> +#define tcg_gen_lea_tl tcg_gen_lea_i64
>   #define tcg_gen_brcond_tl tcg_gen_brcond_i64
>   #define tcg_gen_brcondi_tl tcg_gen_brcondi_i64
>   #define tcg_gen_setcond_tl tcg_gen_setcond_i64
> @@ -209,6 +210,7 @@ typedef TCGv_i64 TCGv;
>   #define tcg_gen_shri_tl tcg_gen_shri_i32
>   #define tcg_gen_sar_tl tcg_gen_sar_i32
>   #define tcg_gen_sari_tl tcg_gen_sari_i32
> +#define tcg_gen_lea_tl tcg_gen_lea_i32
>   #define tcg_gen_brcond_tl tcg_gen_brcond_i32
>   #define tcg_gen_brcondi_tl tcg_gen_brcondi_i32
>   #define tcg_gen_setcond_tl tcg_gen_setcond_i32
> diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
> index e694f0e38c..c9caab2138 100644
> --- a/include/tcg/tcg-op-def.h.inc
> +++ b/include/tcg/tcg-op-def.h.inc
> @@ -37,6 +37,7 @@ DEF3(ld8s, TCGV, TCGv_ptr, tcg_target_long)
>   DEF3(ld8u, TCGV, TCGv_ptr, tcg_target_long)
>   DEF3(ld16s, TCGV, TCGv_ptr, tcg_target_long)
>   DEF3(ld16u, TCGV, TCGv_ptr, tcg_target_long)
> +DEF5(lea, TCGV, TCGV, TCGV, unsigned, TINT)
>   DEF2(mov, TCGV, TCGV)
>   DEF2(movi, TCGV, TINT)
>   DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index 4814a493c0..29b6049650 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -820,6 +820,49 @@ void tcg_gen_ld16u(TCGType type, TCGTemp *dst,
>       tcg_gen_op_tti(INDEX_op_ld16u, type, dst, base, ofs);
>   }
>   
> +void tcg_gen_lea(TCGType type, TCGTemp *dst, TCGTemp *base,
> +                 TCGTemp *index, unsigned sh, int64_t imm)
> +{
> +    g_autoptr(TCGTemp) t = tcg_temp_new_ebb(type);
> +
> +    if (imm != 0) {
> +        if (TCG_TARGET_lea_imm_valid(type, imm)) {
> +            /*
> +             * The immediate is non-zero and valid.
> +             * If the shift is out of range, perform the shift first
> +             * so that we can still emit (base + t + imm) as one insn.
> +             */
> +            if (!TCG_TARGET_lea_sh_valid(type, sh)) {
> +                tcg_gen_shli(type, t, index, sh);
> +                index = t;
> +                sh = 0;
> +            }
> +            tcg_gen_op_tttii(INDEX_op_lea, type, dst, base, index, sh, imm);
> +            return;
> +        }
> +
> +        /*
> +         * If we can make the immediate smaller by folding it
> +         * into index before the shift, do so.
> +         */
> +        if (sh != 0 && imm == (imm >> sh) << sh) {
> +            tcg_gen_addi(type, t, index, imm >> sh);
> +            index = t;
> +            imm = 0;
> +        }
> +    }
> +
> +    if (sh == 0) {
> +        tcg_gen_add(type, dst, base, index);
> +    } else if (TCG_TARGET_lea_sh_valid(TCG_TYPE_I32, sh)) {
> +        tcg_gen_op_tttii(INDEX_op_lea, type, dst, base, index, sh, 0);
> +    } else {
> +        tcg_gen_shli(type, t, index, sh);
> +        tcg_gen_add(type, dst, base, t);
> +    }
> +    tcg_gen_addi(type, dst, dst, imm);
> +}
> +
>   void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
>   {
>       if (src != dst) {

Does this also need a corresponding documentation update in docs/devel/tcg-ops.rst?


ATB,

Mark.



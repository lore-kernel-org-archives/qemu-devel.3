Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2702C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 21:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4nnU-0004bK-QR; Tue, 15 Apr 2025 17:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4nnS-0004YD-Uq
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:26:23 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4nnQ-00076L-GB
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:26:22 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-736a7e126c7so5273745b3a.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 14:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744752379; x=1745357179; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZzRwRuqe6FXkOFdpKSZccvSY0g0pnYVAFnF8wnnjKoA=;
 b=t7S5GrijBF6ADUOi50womrBij1WriJjUgcvLYq9p8CmVBSwEYcVfkkKJ8FXivyZyZr
 NjqQWqXd1EcBVH+V5P/oJDkSMvNFhQKzD0M6WHIzS0Yxo4wr4TY0k86hNslZnBZ0Bn5q
 Yi9RyURht26HTVOjaOx/cWaWkC4VHsr5KJK9vs29p9jrlr5/IAFo3Izmtg/3X8KoIXkv
 Qubj3WkTRHMsSbRAOzBeNADAGTIcNJiccsErz0P2O8lurDP8S67g1UtDqlsPZ0G0HQOi
 U/vLTEpcLLH0JSiCsbpcmnVKSx62xgLG0L5yMtIEZNDy5d929qrR8MAac8etdHQ4+vEA
 rGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744752379; x=1745357179;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZzRwRuqe6FXkOFdpKSZccvSY0g0pnYVAFnF8wnnjKoA=;
 b=RMIKM3aYfzIppZ35y0WUX3AXOWcCpAFNj9Z77mmJZyS5tKJ1mnxW7Jeoo5f4/I5Qqd
 2NQl7s4xd7ib18oT1Jla/u1fboSvAwcoReO2veI02tQYjHDhkAj48dw0VyDK2NIOgPf8
 1VwlCsyBIWI9bbmle1SpDy4IMy1tnvmm5qtEtBZzIiM77lwL3zMA3VXvnt1dY1Cr6WLr
 JGPZlZZMKZ/4vcahuSbLPnG+3yNJZZCvuMM+DDji2hEgCdYiC8zyl9oupin9jlKFx2tx
 xpq3VL+lNXTkgFlc0Qq2XyB7D5I82CG9EQLVQ3egjLIcTaOJoRMKlcEnCFcjSedG+hMj
 NCTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf43XD+nGhOeAzNIFXcuI3Kmb2xNzVXLPaM5CTMgwbI2gVlG1T1kpcqeIU9pomE9WvKmZV2uyn58Jh@nongnu.org
X-Gm-Message-State: AOJu0YycyBuMzHeCP1wG0ZuNcqTRD31+2XovUPwSCdhNpevw9k6ULEaW
 OWSXghrU96ERNUiXb+6G9kNn96m2Ld/Cw1bffEcOpgzakszeIPeVOPEWtZ79tDAOciE8269Xx9z
 nlAo=
X-Gm-Gg: ASbGncv0eX9ffovD3z/TzAeajuyO2MjyV6gdeZ0t6plZmomBx3N88erRl3XoG9jCw11
 qG33SYwqkFD+VpoaL8CNar6qsWaFL2YZBoJLpCNmuSrXZTNHRCBQZUUyHcZA75V86gZK0CzWzhu
 OsfQutv1qyCG9zrmqRz+wGTUWtUwpLGb7LV40Ia1k9TpNZrX0WsFaveVzJFDYXCfFKZgFzo/btf
 uAvRlAU2Y+w7dfCa7kL0KY6Se4fme0SFeKnMW2OApvDtbJWW9b1QixrJzZcs7Pgj9CctMhW8WZq
 lH6RAp6Qrv/qls+1h+jsMUUHLrUwWdhQhZr0wVDkYQvS5/uEnpcSk6DnRNNWa4Yw
X-Google-Smtp-Source: AGHT+IGIuhMivJ5xp28YAvFwIHEeassIwnkH7FzAh8ovXPMtCfFfmEKMosAphi0W4qLp7H257dsTYw==
X-Received: by 2002:a05:6a00:1310:b0:736:5dc6:a14b with SMTP id
 d2e1a72fcca58-73c1f92cf8emr1298589b3a.13.1744752378773; 
 Tue, 15 Apr 2025 14:26:18 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f1035sm9003178b3a.114.2025.04.15.14.26.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 14:26:18 -0700 (PDT)
Message-ID: <08b1680a-8ce1-48a7-9605-05ffbb630aea@linaro.org>
Date: Tue, 15 Apr 2025 14:26:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 082/163] tcg/ppc: Drop fallback constant loading in
 tcg_out_cmp
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-83-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-83-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 4/15/25 12:23, Richard Henderson wrote:
> Use U and C constraints for brcond2 and setcond2, so that
> tcg_out_cmp2 automatically passes in-range constants
> to tcg_out_cmp.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/ppc/tcg-target-con-set.h |  4 +--
>   tcg/ppc/tcg-target.c.inc     | 49 ++++++++++++------------------------
>   2 files changed, 18 insertions(+), 35 deletions(-)
> 
> diff --git a/tcg/ppc/tcg-target-con-set.h b/tcg/ppc/tcg-target-con-set.h
> index 77a1038d51..14cd217287 100644
> --- a/tcg/ppc/tcg-target-con-set.h
> +++ b/tcg/ppc/tcg-target-con-set.h
> @@ -15,7 +15,7 @@ C_O0_I2(r, rC)
>   C_O0_I2(v, r)
>   C_O0_I3(r, r, r)
>   C_O0_I3(o, m, r)
> -C_O0_I4(r, r, ri, ri)
> +C_O0_I4(r, r, rU, rC)
>   C_O0_I4(r, r, r, r)
>   C_O1_I1(r, r)
>   C_O1_I1(v, r)
> @@ -34,7 +34,7 @@ C_O1_I2(v, v, v)
>   C_O1_I3(v, v, v, v)
>   C_O1_I4(v, v, v, vZM, v)
>   C_O1_I4(r, r, rC, rZ, rZ)
> -C_O1_I4(r, r, r, ri, ri)
> +C_O1_I4(r, r, r, rU, rC)
>   C_O2_I1(r, r, r)
>   C_N1O1_I1(o, m, r)
>   C_O2_I2(r, r, r, r)
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 339b3a0904..1782d05290 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -1777,9 +1777,8 @@ static void tcg_out_test(TCGContext *s, TCGReg dest, TCGReg arg1, TCGArg arg2,
>   }
>   
>   static void tcg_out_cmp(TCGContext *s, int cond, TCGArg arg1, TCGArg arg2,
> -                        int const_arg2, int cr, TCGType type)
> +                        bool const_arg2, int cr, TCGType type)
>   {
> -    int imm;
>       uint32_t op;
>   
>       tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || type == TCG_TYPE_I32);
> @@ -1796,18 +1795,15 @@ static void tcg_out_cmp(TCGContext *s, int cond, TCGArg arg1, TCGArg arg2,
>       case TCG_COND_EQ:
>       case TCG_COND_NE:
>           if (const_arg2) {
> -            if ((int16_t) arg2 == arg2) {
> +            if ((int16_t)arg2 == arg2) {
>                   op = CMPI;
> -                imm = 1;
> -                break;
> -            } else if ((uint16_t) arg2 == arg2) {
> -                op = CMPLI;
> -                imm = 1;
>                   break;
>               }
> +            tcg_debug_assert((uint16_t)arg2 == arg2);
> +            op = CMPLI;
> +            break;
>           }
>           op = CMPL;
> -        imm = 0;
>           break;
>   
>       case TCG_COND_TSTEQ:
> @@ -1821,14 +1817,11 @@ static void tcg_out_cmp(TCGContext *s, int cond, TCGArg arg1, TCGArg arg2,
>       case TCG_COND_LE:
>       case TCG_COND_GT:
>           if (const_arg2) {
> -            if ((int16_t) arg2 == arg2) {
> -                op = CMPI;
> -                imm = 1;
> -                break;
> -            }
> +            tcg_debug_assert((int16_t)arg2 == arg2);
> +            op = CMPI;
> +            break;
>           }
>           op = CMP;
> -        imm = 0;
>           break;
>   
>       case TCG_COND_LTU:
> @@ -1836,30 +1829,20 @@ static void tcg_out_cmp(TCGContext *s, int cond, TCGArg arg1, TCGArg arg2,
>       case TCG_COND_LEU:
>       case TCG_COND_GTU:
>           if (const_arg2) {
> -            if ((uint16_t) arg2 == arg2) {
> -                op = CMPLI;
> -                imm = 1;
> -                break;
> -            }
> +            tcg_debug_assert((uint16_t)arg2 == arg2);
> +            op = CMPLI;
> +            break;
>           }
>           op = CMPL;
> -        imm = 0;
>           break;
>   
>       default:
>           g_assert_not_reached();
>       }
>       op |= BF(cr) | ((type == TCG_TYPE_I64) << 21);
> -
> -    if (imm) {
> -        tcg_out32(s, op | RA(arg1) | (arg2 & 0xffff));
> -    } else {
> -        if (const_arg2) {
> -            tcg_out_movi(s, type, TCG_REG_R0, arg2);
> -            arg2 = TCG_REG_R0;
> -        }
> -        tcg_out32(s, op | RA(arg1) | RB(arg2));
> -    }
> +    op |= RA(arg1);
> +    op |= const_arg2 ? arg2 & 0xffff : RB(arg2);
> +    tcg_out32(s, op);
>   }
>   
>   static void tcg_out_setcond_eq0(TCGContext *s, TCGType type,
> @@ -4297,9 +4280,9 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_deposit_i64:
>           return C_O1_I2(r, 0, rZ);
>       case INDEX_op_brcond2_i32:
> -        return C_O0_I4(r, r, ri, ri);
> +        return C_O0_I4(r, r, rU, rC);
>       case INDEX_op_setcond2_i32:
> -        return C_O1_I4(r, r, r, ri, ri);
> +        return C_O1_I4(r, r, r, rU, rC);
>       case INDEX_op_add2_i64:
>       case INDEX_op_add2_i32:
>           return C_O2_I4(r, r, r, r, rI, rZM);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



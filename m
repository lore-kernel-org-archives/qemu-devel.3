Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E449606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Fstt5vhU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMP7H-0001hW-KE; Thu, 29 Oct 2026 08:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMP7E-0001gq-Ii
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 08:20:20 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMP7B-0000xO-Er
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 08:20:20 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-705cb6cedd5so466917eaf.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 05:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793276416; x=1793881216; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/5mWRpROm0oPq0q+cxFzttJvG/MC0mAeZTpybaLxv5I=;
 b=Fstt5vhUljkQh0bFG++ZHVsaYS3q91YEhVXIKIdQu/hvB4/j+tDZNgZQZRnWuqLp82
 cn/LKQgYrFMxAJOxpdD8tyJJ/K0CMrpjbPzPZ5ziGW56C+Xnh4NJteUcarw+Z8o3Sp2a
 GdTuGYKFayCil2HP1ir4qKogjYPGS44UgzKDuxw6Obtj0ny8jEmAWG5vc6ZZ6YIeRTDM
 X5H4IBN0ysP80UlCqcueBnHzEg1rhdV29tx+y7TpNY2HyIuHJdSAtQGr3I60erTSP0jD
 quFr9qZTNhSf54etMuanq+4A4OuLqN/RU8waVCKoUkA3ztENiB0kYA1ptQDW86TRALnk
 CP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793276416; x=1793881216;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/5mWRpROm0oPq0q+cxFzttJvG/MC0mAeZTpybaLxv5I=;
 b=Ju71exZwa022A6PiWr8/LM2X6lCE0rnkW57jQz3Avivbaoho0B8Df+gV5lbkjfkSH2
 mHFN+NL0GZKRBavV/ItgSh6+qDN8r5RtaZRzJ9Ih/noR28z9j1pUwCESHLAL+nwrFWOL
 cViW5NTqbis1DmxLRsBa0J8qDvEm/65Zivh8/r+hdnGtWQTT0J4GfmBag4EvSWT/Xmw0
 iXG6SrpcpE6+wEJHtfxOwmBwP3i/+lCsUB/3MZWxdZ7VOgTVeaU6K9fjNNVLDq/IAW+1
 HxwG4Vw5edparpIs3mtHy8JqwpuX5U+yTGcmjMI990j/Bl26MSyonOAQaKx+kjm0YCkR
 zB0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBycT07kOiXFoiwxSgh8u3nL2mrY5tPsLTfjS6M9KhNqBZxCjHGiTx5ICNOMcnCRQeg1TiU0a5PHQjTb@nongnu.org
X-Gm-Message-State: AFq9FYIB30S3CBnvORE0PR+L6qcoIYUSFIa/LUGJj1MMaNm9rYlzqfT7
 YCtXG7bB/zlBnfgpm7VSs5CjAgugukQjwV3eel7id95TpJAV8cWSa5ThjOLtpmJKYp8=
X-Gm-Gg: AYBFou3pThxF21+0/eKu0h4C46G0F0Z/ln4QuppViBkPhGbV0nHnG09J8yxByetXOCM
 Z7mwMmUw0cXOWvyKOoFr3N46tpKvc+J7yvEXOK+dLgw9QbbgmtkzjSOYeXogl8TUcer4Hd/6xjd
 rTf90iMCFdFyE2FlBlLZFAyEtS3QqPSFUv2igb0hL+Eaeht9garqv6x+BPteEDFHeDKvh6osUJN
 vyjMizVGRfmnUGgKXLRfEyU2RCkcvAj6EUnvyF2+hT2vaXyK1G9Pi+SgtsQWZVUYwZufAZFH+Lj
 OelPGqB44EQhKmFtu2HWfoPzLf+v1lSjs2G8wkbsd0x1jyul/vSBbhNviOxUADIvsazSJwWlZuh
 98wzxZkIxivLADWied47PfZrOuHvdpxisi2MGvBUMQvyHFqitPd5XWVWD8G+cnLg2u/Dv5lij3L
 Kc4EglaMRiNh8V1OjcDsQ/i2JydJQrD7oOOXJ9oV6xOo1Hwo/hE4J22OFLyZyY1uia7/T4dQEP4
 d3Jk5dOQ4vAexp02y89puQy1Y7iiFfwOchipUENu4tSaY+v3ec8QyNMcySanrvwnN5xM5XtLxkF
 v5cSMSOr2TPxh3fGKrG1QqljPnYF+Lx+zDRFjErV1qze7Do04Qjlk8dDYgVA/RtGVw==
X-Received: by 2002:a05:6820:f028:b0:712:b60d:2ed1 with SMTP id
 006d021491bc7-714ddd126c3mr1135479eaf.10.1793276415594; 
 Thu, 29 Oct 2026 05:20:15 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-7142bb7942fsm4213838eaf.5.2026.10.29.05.20.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 05:20:15 -0700 (PDT)
Message-ID: <07353a79-b037-42a2-9747-4c9f9a05e901@linaro.org>
Date: Thu, 29 Oct 2026 07:20:13 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] tcg/riscv64: Fix logical vector immediate matching
 and emission
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, qemu-arm@nongnu.org, qemu-stable@nongnu.org
References: <20261028143330.6518-1-philmd@oss.qualcomm.com>
 <20261028143330.6518-6-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261028143330.6518-6-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 09:33, Philippe Mathieu-Daudé wrote:
> and/or/xor_vec always have VECE 0, yet their constant was matched
> as a byte element and applied at the stale SEW of the previous op:
> "bic v4.8h, #0xf0" became "vand.vi ..., 15".
> 
> Add the 'N' constraint: use the smallest element size at which the
> constant replicates, if that element fits simm5, and switch SEW to
> it. A wider element can't fit when the smallest doesn't: its upper
> half repeats the smaller element, which would then be 0 or -1.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 5a63f5998791 ("tcg/riscv: Add support for basic vector opcodes")
> Reported-by: Aurelien Jarno <aurelien@aurel32.net>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   tcg/riscv64/tcg-target-con-set.h |  1 +
>   tcg/riscv64/tcg-target-con-str.h |  1 +
>   tcg/riscv64/tcg-target.c.inc     | 53 +++++++++++++++++++++++++++-----
>   3 files changed, 48 insertions(+), 7 deletions(-)
> 
> diff --git a/tcg/riscv64/tcg-target-con-set.h b/tcg/riscv64/tcg-target-con-set.h
> index 0fc26d3f98b4..9b4e219fac16 100644
> --- a/tcg/riscv64/tcg-target-con-set.h
> +++ b/tcg/riscv64/tcg-target-con-set.h
> @@ -26,4 +26,5 @@ C_O1_I2(v, v, v)
>   C_O1_I2(v, vK, v)
>   C_O1_I2(v, v, vK)
>   C_O1_I2(v, v, vL)
> +C_O1_I2(v, v, vN)
>   C_O1_I4(v, v, vL, vK, vK)
> diff --git a/tcg/riscv64/tcg-target-con-str.h b/tcg/riscv64/tcg-target-con-str.h
> index c04e15ddfa3c..d7e8b2ce4f2f 100644
> --- a/tcg/riscv64/tcg-target-con-str.h
> +++ b/tcg/riscv64/tcg-target-con-str.h
> @@ -19,3 +19,4 @@ CONST('I', TCG_CT_CONST_S12)
>   CONST('K', TCG_CT_CONST_S5)
>   CONST('L', TCG_CT_CONST_CMP_VI)
>   CONST('M', TCG_CT_CONST_M12)
> +CONST('N', TCG_CT_CONST_LOGICAL_VI)
> diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
> index 168932711796..4faf7ff36e07 100644
> --- a/tcg/riscv64/tcg-target.c.inc
> +++ b/tcg/riscv64/tcg-target.c.inc
> @@ -116,6 +116,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
>   #define TCG_CT_CONST_M12     0x200
>   #define TCG_CT_CONST_S5      0x400
>   #define TCG_CT_CONST_CMP_VI  0x800
> +#define TCG_CT_CONST_LOGICAL_VI 0x1000
>   
>   #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
>   #define ALL_VECTOR_REGS    MAKE_64BIT_MASK(32, 32)
> @@ -384,6 +385,22 @@ static const struct {
>       [TCG_COND_GEU] = { OPC_VMSGTU_VI,   1, 16, true  },
>   };
>   
> +/*
> + * Return the element size at which VAL is a replicated simm5,
> + * or -1 if there is none.  Used for vector logical ops, whose
> + * VECE is not meaningful.
> + */
> +static int vec_logical_immediate_vece(int64_t val)
> +{
> +    for (int e = MO_8; e <= MO_64; e++) {
> +        if (val == dup_const(e, val)) {
> +            int64_t x = sextract64(val, 0, 8 << e);
> +            return x >= -0x10 && x <= 0x0f ? e : -1;
> +        }
> +    }
> +    g_assert_not_reached();
> +}

This assert can trigger...

> +
>   /* test if a constant matches the constraint */
>   static bool tcg_target_const_match(int64_t val, int ct,
>                                      TCGType type, TCGCond cond, int vece)
> @@ -391,6 +408,10 @@ static bool tcg_target_const_match(int64_t val, int ct,
>       if (ct & TCG_CT_CONST) {
>           return 1;
>       }
> +    if ((ct & TCG_CT_CONST_LOGICAL_VI) &&
> +        vec_logical_immediate_vece(val) >= 0) {
> +        return true;
> +    }

... here.  Return -1 instead so...

>       if (type >= TCG_TYPE_V64) {
>           /* Val is replicated by VECE; extract the highest element. */
>           val >>= (-8 << vece) & 63;
> @@ -2769,6 +2790,23 @@ static const TCGOutOpStore outop_st = {
>   };
>   
>   
> +static void tcg_out_opc_vv_vi_logical(TCGContext *s, TCGType type,
> +                                      RISCVInsn o_vv, RISCVInsn o_vi,
> +                                      TCGReg vd, TCGReg vs2,
> +                                      TCGArg vi1, int c_vi1)
> +{
> +    if (c_vi1) {
> +        int vece = vec_logical_immediate_vece(vi1);
> +
> +        tcg_debug_assert(vece >= 0);

... it is properly handled by this assert anyway.


r~


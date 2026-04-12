Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF98E937F6
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 18:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBzdx-0001re-UI; Sun, 12 Apr 2026 14:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBzdr-0001rI-07
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 14:34:43 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBzdo-0002cs-Sv
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 14:34:42 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso35200185e9.3
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 11:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776018878; x=1776623678; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z47p09IWN2Vn2YLcunRWS2wrYP2mlSkMGBtCKHDCcro=;
 b=dpu7EmD+qLQx9JNV4TM9Kf0OWKP5EpFRKLkloCWpYmrrnfvOQ0MOIQW1xViiSsYNuw
 FZdBAxyxzDFIESxRcyX5puG4QwD1Cz5chwhzGkAyDvJA8Br5H+LqOFDl0PHeKxC3WApC
 EJ/gFrHzjAVlArYy+ZYjRARYqCqzbbEkbZFoSLWyFzITHV/J1kQ2Dwc7yX68ZNag0Quq
 uAxfDrSFEJnroFMfCwSQWdLiOOruyV5YPB/7iUzxNdSUFTXw4duIxR0cKw9Z+i/l5VQU
 f63MYVjHomh3IXbMzYGRjaKgOfISFB9rOo3wCqgBwE0677DM7rkauDB7ddswB3dmPe8I
 vM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776018878; x=1776623678;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z47p09IWN2Vn2YLcunRWS2wrYP2mlSkMGBtCKHDCcro=;
 b=ZDO3yyGeCAsI4f1H5ZghhiDEQVI/aliD4semK0yNz01a578oHTM5dI2IOe5mwewJaO
 XLM0EkEs2V3HftCGpuvGwKY8ITn4iCRYkskdbMAYbP7zyjL0gSvS0qbDIh+fecRQ6BT1
 iGvBcTpI6vCTvP2fbwSCozVAcNPFdxRz9pcG0u7LF+pyVhWfwR5YKvbOuAAMDMZArCT+
 uZoUzrevkDYz1bs10+g17r42nycH9YgNYR7Ifin4L9ZbYkECVOfqObzqfj3531BsUs8d
 EkfY41Mxtltw5Y6cNT0p+McKV4HfYj1LrW7msqbqU9Hcg36THsqyaH0eEI0sZXr1BR5/
 BRTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhPWCbnmL/7ABIT6n6bDIM1K9nDW0tCK7RWUnqG2FKosLNXNL36YQO1SpCZ+mOMiNeMAXt39TEwLfD@nongnu.org
X-Gm-Message-State: AOJu0Yyi7DQYUM0dIMPkLSu/gzVYIn5x4r9gJmj/kNQksrsUzz9eVRjB
 B3NInYT6nxfKPklL3iG/1U5E4kvkRLBdTCRwzkp28Y9ADXvZ2BwEsnjpSPLYh4Q9cws=
X-Gm-Gg: AeBDievcRdXZdNGrQzuu5KYOU/A6jq5vOn25N/8YZYA2hp6bBsDiFF1/Meh9KoM5XZD
 OFzMU7UG/PuJVkbkrl79ENmf7aJo1qjK0UysmRIaPEH90/Yqx8egzpCGveiEJvUkBH6Mxs0fE4v
 FxJ90TA5gm+mwQVNDj9Ab+52jgct7xYMx4BQEnUI9tifQshWnvjs+Deo/OJQwQmRvTQTYVf4UxB
 bI0L5LO8MT/aF5++NRnkp1Vq/IYPytjKTVngYlbwuo7r7rY0LILq8XUx8fiuyFJQpLfLjA0DNp9
 FVzOwmnU0xEywF04kTQZWNQN7BXZVegCjXsS4CTGn/21ZJljwwaego5yMyFg5pU/v3jH1tAiWuY
 lAszo+WOitw2BCgtTK+Lq3iQLy/+Sc3EzgxONOI/2BuHhxrlZZsbNQqyy0ZmnLAch3AftDH/NLv
 VpVvYt5Fa4Zm4AkYu3Q7HCe+UGqSN1NYqQe/I0IohTpASlJQ9boexVYxS9B009H19gOQ==
X-Received: by 2002:a05:600d:d:b0:488:9e43:9690 with SMTP id
 5b1f17b1804b1-488d67dbf4amr110719045e9.10.1776018878214; 
 Sun, 12 Apr 2026 11:34:38 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488df2a1237sm252066775e9.6.2026.04.12.11.34.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 11:34:37 -0700 (PDT)
Message-ID: <096d4e04-c1a4-4956-909c-9b5e30cfa8a8@linaro.org>
Date: Sun, 12 Apr 2026 20:34:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] target/mips: add Octeon COP2 crypto core support
Content-Language: en-US
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>
References: <20260411070637.72421-1-james.hilliard1@gmail.com>
 <20260411070637.72421-4-james.hilliard1@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260411070637.72421-4-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

On 11/4/26 09:06, James Hilliard wrote:
> Octeon processors expose their crypto engines through selector-driven
> DMFC2/DMTC2 accesses rather than architected standalone opcodes. Add
> the common COP2 state, selector decode, and helper plumbing for the base
> engine set.
> 
> This covers the initial hash, AES, CRC, GFM, 3DES, KASUMI, and SNOW3G
> engines and moves the implementation into octeon_crypto.c to keep the
> MIPS helper layer manageable.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>   target/mips/cpu.h                  |  165 +++
>   target/mips/helper.h               |    3 +
>   target/mips/tcg/meson.build        |    1 +
>   target/mips/tcg/octeon.decode      |    2 +
>   target/mips/tcg/octeon_crypto.c    | 1628 ++++++++++++++++++++++++++++
>   target/mips/tcg/octeon_translate.c |    6 +
>   target/mips/tcg/op_helper.c        |   14 +
>   target/mips/tcg/translate.c        |  196 ++++
>   8 files changed, 2015 insertions(+)
>   create mode 100644 target/mips/tcg/octeon_crypto.c


> diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
> index 2e3fe1fa16..42445e5526 100644
> --- a/target/mips/tcg/translate.c
> +++ b/target/mips/tcg/translate.c
> @@ -9127,6 +9127,195 @@ static void gen_cp1(DisasContext *ctx, uint32_t opc, int rt, int fs)
>       }
>   }
>   
> +static bool octeon_cop2_is_supported_dmfc2(uint16_t sel)
> +{
> +    switch (sel) {
> +    case OCTEON_COP2_SEL_3DES_KEY0:
> +    case OCTEON_COP2_SEL_3DES_KEY1:
> +    case OCTEON_COP2_SEL_3DES_KEY2:
> +    case OCTEON_COP2_SEL_3DES_IV:
> +    case OCTEON_COP2_SEL_3DES_RESULT:
> +    case OCTEON_COP2_SEL_3DES_RESULT_IN:
> +    case OCTEON_COP2_SEL_AES_RESULT0:
> +    case OCTEON_COP2_SEL_AES_RESULT1:
> +    case OCTEON_COP2_SEL_CRC_POLYNOMIAL:
> +    case OCTEON_COP2_SEL_AES_IV0:
> +    case OCTEON_COP2_SEL_AES_IV1:
> +    case OCTEON_COP2_SEL_CRC_IV:
> +    case OCTEON_COP2_SEL_CRC_LEN:
> +    case OCTEON_COP2_SEL_CRC_IV_REFLECT:
> +    case OCTEON_COP2_SEL_HSH_DATW0:
> +    case OCTEON_COP2_SEL_HSH_DATW1:
> +    case OCTEON_COP2_SEL_HSH_DATW2:
> +    case OCTEON_COP2_SEL_HSH_DATW3:
> +    case OCTEON_COP2_SEL_HSH_DATW4:
> +    case OCTEON_COP2_SEL_HSH_DATW5:
> +    case OCTEON_COP2_SEL_HSH_DATW6:
> +    case OCTEON_COP2_SEL_HSH_DATW7:
> +    case OCTEON_COP2_SEL_HSH_IV0:
> +    case OCTEON_COP2_SEL_HSH_IV1:
> +    case OCTEON_COP2_SEL_HSH_IV2:
> +    case OCTEON_COP2_SEL_HSH_IV3:
> +    case OCTEON_COP2_SEL_HSH_IVW0:
> +    case OCTEON_COP2_SEL_HSH_IVW1:
> +    case OCTEON_COP2_SEL_HSH_IVW2:
> +    case OCTEON_COP2_SEL_HSH_IVW3:
> +    case OCTEON_COP2_SEL_HSH_IVW4:
> +    case OCTEON_COP2_SEL_HSH_IVW5:
> +    case OCTEON_COP2_SEL_HSH_IVW6:
> +    case OCTEON_COP2_SEL_HSH_IVW7:
> +    case OCTEON_COP2_SEL_AES_DAT0:
> +    case OCTEON_COP2_SEL_GFM_MUL_REFLECT0:
> +    case OCTEON_COP2_SEL_GFM_MUL_REFLECT1:
> +    case OCTEON_COP2_SEL_GFM_RESINP_REFLECT0:
> +    case OCTEON_COP2_SEL_GFM_RESINP_REFLECT1:
> +    case OCTEON_COP2_SEL_GFM_MUL0:
> +    case OCTEON_COP2_SEL_GFM_MUL1:
> +    case OCTEON_COP2_SEL_GFM_RESINP0:
> +    case OCTEON_COP2_SEL_GFM_RESINP1:
> +    case OCTEON_COP2_SEL_GFM_POLY:
> +        return true;
> +    default:
> +        return false;
> +    }
> +}
> +
> +static bool octeon_cop2_is_supported_dmtc2(uint16_t sel)
> +{
> +    switch (sel) {
> +    case OCTEON_COP2_SEL_3DES_KEY0:
> +    case OCTEON_COP2_SEL_3DES_KEY1:
> +    case OCTEON_COP2_SEL_3DES_KEY2:
> +    case OCTEON_COP2_SEL_3DES_IV:
> +    case OCTEON_COP2_SEL_3DES_RESULT_IN:
> +    case OCTEON_COP2_SEL_3DES_ENC_CBC:
> +    case OCTEON_COP2_SEL_KAS_ENC_CBC:
> +    case OCTEON_COP2_SEL_3DES_ENC:
> +    case OCTEON_COP2_SEL_KAS_ENC:
> +    case OCTEON_COP2_SEL_3DES_DEC_CBC:
> +    case OCTEON_COP2_SEL_3DES_DEC:
> +    case OCTEON_COP2_SEL_AES_IV0:
> +    case OCTEON_COP2_SEL_AES_IV1:
> +    case OCTEON_COP2_SEL_AES_KEY0:
> +    case OCTEON_COP2_SEL_AES_KEY1:
> +    case OCTEON_COP2_SEL_AES_KEY2:
> +    case OCTEON_COP2_SEL_AES_KEY3:
> +    case OCTEON_COP2_SEL_AES_ENC_CBC0:
> +    case OCTEON_COP2_SEL_AES_ENC0:
> +    case OCTEON_COP2_SEL_AES_DEC_CBC0:
> +    case OCTEON_COP2_SEL_AES_DEC0:
> +    case OCTEON_COP2_SEL_AES_KEYLENGTH:
> +    case OCTEON_COP2_SEL_CRC_WRITE_POLYNOMIAL:
> +    case OCTEON_COP2_SEL_CRC_IV:
> +    case OCTEON_COP2_SEL_CRC_WRITE_LEN:
> +    case OCTEON_COP2_SEL_CRC_WRITE_IV_REFLECT:
> +    case OCTEON_COP2_SEL_CRC_WRITE_BYTE:
> +    case OCTEON_COP2_SEL_CRC_WRITE_HALF:
> +    case OCTEON_COP2_SEL_CRC_WRITE_WORD:
> +    case OCTEON_COP2_SEL_CRC_WRITE_DWORD:
> +    case OCTEON_COP2_SEL_CRC_WRITE_VAR:
> +    case OCTEON_COP2_SEL_CRC_WRITE_POLYNOMIAL_REFLECT:
> +    case OCTEON_COP2_SEL_CRC_WRITE_BYTE_REFLECT:
> +    case OCTEON_COP2_SEL_CRC_WRITE_HALF_REFLECT:
> +    case OCTEON_COP2_SEL_CRC_WRITE_WORD_REFLECT:
> +    case OCTEON_COP2_SEL_CRC_WRITE_DWORD_REFLECT:
> +    case OCTEON_COP2_SEL_CRC_WRITE_VAR_REFLECT:
> +    case OCTEON_COP2_SEL_HSH_DAT0:
> +    case OCTEON_COP2_SEL_HSH_DAT1:
> +    case OCTEON_COP2_SEL_HSH_DAT2:
> +    case OCTEON_COP2_SEL_HSH_DAT3:
> +    case OCTEON_COP2_SEL_HSH_DAT4:
> +    case OCTEON_COP2_SEL_HSH_DAT5:
> +    case OCTEON_COP2_SEL_HSH_DAT6:
> +    case OCTEON_COP2_SEL_HSH_IV0:
> +    case OCTEON_COP2_SEL_HSH_IV1:
> +    case OCTEON_COP2_SEL_HSH_IV2:
> +    case OCTEON_COP2_SEL_HSH_IV3:
> +    case OCTEON_COP2_SEL_HSH_DATW0:
> +    case OCTEON_COP2_SEL_HSH_DATW1:
> +    case OCTEON_COP2_SEL_HSH_DATW2:
> +    case OCTEON_COP2_SEL_HSH_DATW3:
> +    case OCTEON_COP2_SEL_HSH_DATW4:
> +    case OCTEON_COP2_SEL_HSH_DATW5:
> +    case OCTEON_COP2_SEL_HSH_DATW6:
> +    case OCTEON_COP2_SEL_HSH_DATW7:
> +    case OCTEON_COP2_SEL_HSH_DATW8:
> +    case OCTEON_COP2_SEL_HSH_DATW9:
> +    case OCTEON_COP2_SEL_HSH_DATW10:
> +    case OCTEON_COP2_SEL_HSH_DATW11:
> +    case OCTEON_COP2_SEL_HSH_DATW12:
> +    case OCTEON_COP2_SEL_HSH_DATW13:
> +    case OCTEON_COP2_SEL_HSH_DATW14:
> +    case OCTEON_COP2_SEL_HSH_DATW15:
> +    case OCTEON_COP2_SEL_HSH_IVW0:
> +    case OCTEON_COP2_SEL_HSH_IVW1:
> +    case OCTEON_COP2_SEL_HSH_IVW2:
> +    case OCTEON_COP2_SEL_HSH_IVW3:
> +    case OCTEON_COP2_SEL_HSH_IVW4:
> +    case OCTEON_COP2_SEL_HSH_IVW5:
> +    case OCTEON_COP2_SEL_HSH_IVW6:
> +    case OCTEON_COP2_SEL_HSH_IVW7:
> +    case OCTEON_COP2_SEL_GFM_MUL_REFLECT0:
> +    case OCTEON_COP2_SEL_GFM_MUL_REFLECT1:
> +    case OCTEON_COP2_SEL_GFM_XOR0_REFLECT:
> +    case OCTEON_COP2_SEL_GFM_MUL0:
> +    case OCTEON_COP2_SEL_GFM_MUL1:
> +    case OCTEON_COP2_SEL_GFM_RESINP0:
> +    case OCTEON_COP2_SEL_GFM_RESINP1:
> +    case OCTEON_COP2_SEL_GFM_XOR0:
> +    case OCTEON_COP2_SEL_GFM_POLY:
> +    case OCTEON_COP2_SEL_HSH_STARTSHA1_COMPAT:
> +    case OCTEON_COP2_SEL_HSH_STARTMD5:
> +    case OCTEON_COP2_SEL_SNOW3G_START:
> +    case OCTEON_COP2_SEL_SNOW3G_MORE:
> +    case OCTEON_COP2_SEL_HSH_STARTSHA256:
> +    case OCTEON_COP2_SEL_HSH_STARTSHA1:
> +    case OCTEON_COP2_SEL_GFM_XORMUL1_REFLECT:
> +    case OCTEON_COP2_SEL_HSH_STARTSHA512:
> +    case OCTEON_COP2_SEL_GFM_XORMUL1:
> +    case OCTEON_COP2_SEL_AES_ENC_CBC1:
> +    case OCTEON_COP2_SEL_AES_ENC1:
> +    case OCTEON_COP2_SEL_AES_DEC_CBC1:
> +    case OCTEON_COP2_SEL_AES_DEC1:
> +        return true;
> +    default:
> +        return false;
> +    }
> +}
> +
> +static bool gen_octeon_cop2(DisasContext *ctx)
> +{
> +    enum {
> +        OCTEON_CP2_RS_DMFC2 = 0x01,
> +        OCTEON_CP2_RS_DMTC2 = 0x05,
> +    };
> +    int rs = extract32(ctx->opcode, 21, 5);
> +    int rt = extract32(ctx->opcode, 16, 5);
> +    uint16_t sel = ctx->opcode;
> +    TCGv t0;
> +
> +    switch (rs) {
> +    case OCTEON_CP2_RS_DMFC2:
> +        if (!octeon_cop2_is_supported_dmfc2(sel)) {
> +            return false;
> +        }
> +        t0 = tcg_temp_new();
> +        gen_helper_octeon_cop2_dmfc2(t0, tcg_env, tcg_constant_i32(sel));
> +        gen_store_gpr(t0, rt);
> +        return true;
> +    case OCTEON_CP2_RS_DMTC2:
> +        if (!octeon_cop2_is_supported_dmtc2(sel)) {
> +            return false;
> +        }
> +        t0 = tcg_temp_new();
> +        gen_load_gpr(t0, rt);
> +        gen_helper_octeon_cop2_dmtc2(tcg_env, t0, tcg_constant_i32(sel));
> +        return true;
> +    default:
> +        return false;
> +    }
> +}

All this code doesn't belong to translate.c but octeon_translate.c.

>   static void gen_movci(DisasContext *ctx, int rd, int rs, int cc, int tf)
>   {
>       TCGLabel *l1;
> @@ -14860,6 +15049,13 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
>           }
>           break;
>       case OPC_CP2:
> +        if (ctx->insn_flags & INSN_OCTEON) {
> +            if (gen_octeon_cop2(ctx)) {

Ditto, declare gen_octeon_cop2() prototype in translate.h.

> +                break;
> +            }
> +            generate_exception_err(ctx, EXCP_CpU, 2);
> +            break;
> +        }
>           check_insn(ctx, ASE_LMMI);
>           /* Note that these instructions use different fields.  */
>           gen_loongson_multimedia(ctx, sa, rd, rt);



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7310BC47DDB
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 16:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSJlo-0006Wz-Q3; Tue, 23 Jan 2024 11:37:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rSJle-0006W4-LD
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 11:36:54 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rSJlc-0002Wh-Cq
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 11:36:54 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d76943baafso11196355ad.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 08:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706027809; x=1706632609; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SCidF9PI/IX78S6phx1p5rF3LOJ/M79Hvy7nzWt5Ah0=;
 b=P4Jtil74gTQNsMea0+qk4h78q+Vc1ln0NjH0Vb2qxtnyb8Acqt9U1/pJbdbhlVF9v7
 Nzyk6INXTmwhLJB1p/9wnnojNaytPo1wVz9pWHXsVznTf3EKoqv1t0zRjCsUHZgAP3mK
 7KVnx18rsIKtItlNug3UHC1lTf6JSVHcmn8oB1j2pu2/FYA5z3VfphQN2ZEH7VmuyVG0
 C8Y71ovUkcrDF/JWw5JYweNhyU3byxvGRBKhQME5G8iJArgFwLSe8OkkQVehZ4mfPqXR
 7PD6xaLHyHcqk09qqsl6gFPOXFY2acfoN7v8MbhR0Nw+zQfyNlHgDmvu/qlx5Yf3HDc7
 nUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706027809; x=1706632609;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SCidF9PI/IX78S6phx1p5rF3LOJ/M79Hvy7nzWt5Ah0=;
 b=l6EUuzV4dF87kJTsD0575VkAowkJPoLfWTyjHWK8KAOv0jnMin5utanVfu9Kn8GyPR
 XWkIwSwst1F5NmJVeD6cW2du5ejhAEHx6Wnphr2/0fNXZYQhcPgSlujpoVR2lM0qrik/
 iFnxOnWKUkjPNmCocww700GLed12w+WbhIh2wjb25jUvIFdGjEBBc1+gFS7uTzaRzOyt
 twS2XJ9l4ibXb7yhojyw9Nx5CQ4YsXl6QqKy4LqGc2EE2mAh//L53OVOdySKshFu1bF/
 iy6IdYekf/wE/d4c2B4Ks36j/g02NTFnAOGpc+BpUmLLt5dUHHo7YAW/n4DYb0R6pQRg
 pzfQ==
X-Gm-Message-State: AOJu0YzgD5IOWT8H0bjPRg6EE/zhU9TEecpep+3y7SdygCrRfJ+sonq3
 XHtFzKebZ8emQPljkwM8XqYQMp+dk+Hv6gDIIm/ow4svxwYERyzmdB2CAKpTnW4=
X-Google-Smtp-Source: AGHT+IHzOV9jihvs14dTKO+AQOBswgvOx3dd7ZrFjNbi+ji9kNIyU3aPgL39lbHRDXViTddJDGK/TQ==
X-Received: by 2002:a17:902:aa83:b0:1d5:ea48:8c72 with SMTP id
 d3-20020a170902aa8300b001d5ea488c72mr3253572plr.75.1706027809138; 
 Tue, 23 Jan 2024 08:36:49 -0800 (PST)
Received: from [192.168.68.110] ([152.234.127.94])
 by smtp.gmail.com with ESMTPSA id
 u19-20020a170903305300b001d714a6eff7sm8031626pla.80.2024.01.23.08.36.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 08:36:48 -0800 (PST)
Message-ID: <cbc3c480-4555-4341-9454-97ac9044a8a6@ventanamicro.com>
Date: Tue, 23 Jan 2024 13:36:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] target/riscv: Check 'A' and split extensions for
 atomic instructions
To: Rob Bradford <rbradford@rivosinc.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
References: <20240123111030.15074-1-rbradford@rivosinc.com>
 <20240123111030.15074-3-rbradford@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240123111030.15074-3-rbradford@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 1/23/24 08:10, Rob Bradford wrote:
> Following the pattern for 'M' and Zmmul check if either the 'A'
> extension is enabled or the appropriate split extension for the
> instruction.
> 
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/insn_trans/trans_rva.c.inc | 56 +++++++++++++++----------
>   1 file changed, 34 insertions(+), 22 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
> index f0368de3e4..267930e5bc 100644
> --- a/target/riscv/insn_trans/trans_rva.c.inc
> +++ b/target/riscv/insn_trans/trans_rva.c.inc
> @@ -18,6 +18,18 @@
>    * this program.  If not, see <http://www.gnu.org/licenses/>.
>    */
>   
> +#define REQUIRE_A_OR_ZAAMO(ctx) do {                      \
> +    if (!ctx->cfg_ptr->ext_zaamo && !has_ext(ctx, RVA)) { \
> +        return false;                                     \
> +    }                                                     \
> +} while (0)
> +
> +#define REQUIRE_A_OR_ZALRSC(ctx) do {                      \
> +    if (!ctx->cfg_ptr->ext_zalrsc && !has_ext(ctx, RVA)) { \
> +        return false;                                     \
> +    }                                                     \
> +} while (0)
> +
>   static bool gen_lr(DisasContext *ctx, arg_atomic *a, MemOp mop)
>   {
>       TCGv src1;
> @@ -96,143 +108,143 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
>   
>   static bool trans_lr_w(DisasContext *ctx, arg_lr_w *a)
>   {
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZALRSC(ctx);
>       return gen_lr(ctx, a, (MO_ALIGN | MO_TESL));
>   }
>   
>   static bool trans_sc_w(DisasContext *ctx, arg_sc_w *a)
>   {
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZALRSC(ctx);
>       return gen_sc(ctx, a, (MO_ALIGN | MO_TESL));
>   }
>   
>   static bool trans_amoswap_w(DisasContext *ctx, arg_amoswap_w *a)
>   {
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, (MO_ALIGN | MO_TESL));
>   }
>   
>   static bool trans_amoadd_w(DisasContext *ctx, arg_amoadd_w *a)
>   {
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, (MO_ALIGN | MO_TESL));
>   }
>   
>   static bool trans_amoxor_w(DisasContext *ctx, arg_amoxor_w *a)
>   {
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, (MO_ALIGN | MO_TESL));
>   }
>   
>   static bool trans_amoand_w(DisasContext *ctx, arg_amoand_w *a)
>   {
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, (MO_ALIGN | MO_TESL));
>   }
>   
>   static bool trans_amoor_w(DisasContext *ctx, arg_amoor_w *a)
>   {
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, (MO_ALIGN | MO_TESL));
>   }
>   
>   static bool trans_amomin_w(DisasContext *ctx, arg_amomin_w *a)
>   {
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, (MO_ALIGN | MO_TESL));
>   }
>   
>   static bool trans_amomax_w(DisasContext *ctx, arg_amomax_w *a)
>   {
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, (MO_ALIGN | MO_TESL));
>   }
>   
>   static bool trans_amominu_w(DisasContext *ctx, arg_amominu_w *a)
>   {
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, (MO_ALIGN | MO_TESL));
>   }
>   
>   static bool trans_amomaxu_w(DisasContext *ctx, arg_amomaxu_w *a)
>   {
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, (MO_ALIGN | MO_TESL));
>   }
>   
>   static bool trans_lr_d(DisasContext *ctx, arg_lr_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZALRSC(ctx);
>       return gen_lr(ctx, a, MO_ALIGN | MO_TEUQ);
>   }
>   
>   static bool trans_sc_d(DisasContext *ctx, arg_sc_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZALRSC(ctx);
>       return gen_sc(ctx, a, (MO_ALIGN | MO_TEUQ));
>   }
>   
>   static bool trans_amoswap_d(DisasContext *ctx, arg_amoswap_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, (MO_ALIGN | MO_TEUQ));
>   }
>   
>   static bool trans_amoadd_d(DisasContext *ctx, arg_amoadd_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, (MO_ALIGN | MO_TEUQ));
>   }
>   
>   static bool trans_amoxor_d(DisasContext *ctx, arg_amoxor_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, (MO_ALIGN | MO_TEUQ));
>   }
>   
>   static bool trans_amoand_d(DisasContext *ctx, arg_amoand_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, (MO_ALIGN | MO_TEUQ));
>   }
>   
>   static bool trans_amoor_d(DisasContext *ctx, arg_amoor_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, (MO_ALIGN | MO_TEUQ));
>   }
>   
>   static bool trans_amomin_d(DisasContext *ctx, arg_amomin_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, (MO_ALIGN | MO_TEUQ));
>   }
>   
>   static bool trans_amomax_d(DisasContext *ctx, arg_amomax_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, (MO_ALIGN | MO_TEUQ));
>   }
>   
>   static bool trans_amominu_d(DisasContext *ctx, arg_amominu_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, (MO_ALIGN | MO_TEUQ));
>   }
>   
>   static bool trans_amomaxu_d(DisasContext *ctx, arg_amomaxu_d *a)
>   {
>       REQUIRE_64BIT(ctx);
> -    REQUIRE_EXT(ctx, RVA);
> +    REQUIRE_A_OR_ZAAMO(ctx);
>       return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, (MO_ALIGN | MO_TEUQ));
>   }


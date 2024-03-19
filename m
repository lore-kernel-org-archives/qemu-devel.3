Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64AAFC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 13:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmZb4-0004Lr-2o; Tue, 19 Mar 2024 09:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZb2-0004KG-8j
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:33:40 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZb0-0001Xp-NR
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:33:40 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41464711dc8so5715315e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 06:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710855217; x=1711460017; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5v4XH0pkldfByQ1yCmAtbPt7BhoeRoQpXlOBflGX6dw=;
 b=yx+nUsEFFO2c92PxV+fFzy16Ys8S4Ykkur0KoWXQqJ29fWiqatJ8unIF3vArUICaxO
 ljNuMPNMZwYPpsGSMi0rK4PXCqq6BpHJdIyoabwB1FfLs35mVIlrxM8FfRNl/FxsK+yu
 3bJF/jEtvGC9Fa+eo/WcCvTHTiNB5s3UIJ5AbkQqlXXnZv3yBBZ7BKDT4ggjxpXJqUFr
 Mn5M1K8MnhJKthZjkEBw8bzJk3FXaGJTCBRaHSyVdcz41a+DxuZ5GBLgk5MEO/7l5R4c
 Z3UYwOnupTOE4/HXyGpArCpMekZp/d215jRlI+9dS5jTw+OaoEgX3N5hQRy17UUIkL+r
 X+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710855217; x=1711460017;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5v4XH0pkldfByQ1yCmAtbPt7BhoeRoQpXlOBflGX6dw=;
 b=X2tf7SdjXnjQzlJkGMaJVZgNU2oeeY1J1twi5mTvOK7S/R3aw5OH6o9D6Y1dc4Gnfl
 T8wB30Rv2x80VE7+BgadMSI2s4PjSe+hszs9OgEUF/8NDnpmaaet7ClUjhW980VW85tK
 MiiwqIq4ljEX2e51O5Ly5+/vPaiWTS0vMD6/JC+316pPNClQp+CwdeJ91JZyb6Zoe28f
 wlI434qSl86seV+XOfIFgMmLAZGIjjKoKCj/MjVSxHDGjFHSjViMhnkdbJSpJ0in8MOz
 8pgaS6tdIviD9LswwLlKyiSn4GxggXIzoGAjvNULb8LzDIlH7PP1jmD9l6DwFmacrlE7
 re/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwKGVmYX1NnYPXzb2VntY8mkb2nmfaM5rZGzAy8WuEmy/Y5NxhwnMqY3a4EWEMlmdMMnAPt7cSfBXKEporAr9PRWoyGhk=
X-Gm-Message-State: AOJu0YyTi4n9TmvAqWsbieA5/+wkK3fA7TLUKTG90nGc/WwsPPE7C+nB
 K3KwR1pd+g3PL65Cx6D6zHaQIGfc+WpLSSvC7eR9wnaeCxlr0z1hUyHdBu4JF0Q=
X-Google-Smtp-Source: AGHT+IFLxR/roaGXvWyOzqE+Ywahhq/IEowzA8MixlNC1tqLSgoOAkBMuAJCWzKWqYqK0UZSPoV0VQ==
X-Received: by 2002:a05:600c:3b04:b0:414:a54:ec04 with SMTP id
 m4-20020a05600c3b0400b004140a54ec04mr1929404wms.4.1710855217136; 
 Tue, 19 Mar 2024 06:33:37 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a05600c4fd200b004140bece5d1sm8844879wmq.8.2024.03.19.06.33.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 06:33:36 -0700 (PDT)
Message-ID: <cd395590-873e-467c-a6e1-8360d81b4904@linaro.org>
Date: Tue, 19 Mar 2024 17:33:35 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/22] plugins: Add PLUGIN_GEN_AFTER_TB
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-10-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240316015720.3661236-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/16/24 05:57, Richard Henderson wrote:
> Delay test of plugin_tb->mem_helper until the inject pass.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/plugin-gen.c | 37 ++++++++++++++++---------------------
>   1 file changed, 16 insertions(+), 21 deletions(-)
> 
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index f92aa80510..aa74e580bd 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -75,6 +75,7 @@ enum plugin_gen_from {
>       PLUGIN_GEN_FROM_INSN,
>       PLUGIN_GEN_FROM_MEM,
>       PLUGIN_GEN_AFTER_INSN,
> +    PLUGIN_GEN_AFTER_TB,
>       PLUGIN_GEN_N_FROMS,
>   };
>   
> @@ -615,20 +616,9 @@ static void inject_mem_enable_helper(struct qemu_plugin_tb *ptb,
>   /* called before finishing a TB with exit_tb, goto_tb or goto_ptr */
>   void plugin_gen_disable_mem_helpers(void)
>   {
> -    /*
> -     * We could emit the clearing unconditionally and be done. However, this can
> -     * be wasteful if for instance plugins don't track memory accesses, or if
> -     * most TBs don't use helpers. Instead, emit the clearing iff the TB calls
> -     * helpers that might access guest memory.
> -     *
> -     * Note: we do not reset plugin_tb->mem_helper here; a TB might have several
> -     * exit points, and we want to emit the clearing from all of them.
> -     */
> -    if (!tcg_ctx->plugin_tb->mem_helper) {
> -        return;
> +    if (tcg_ctx->plugin_insn) {
> +        tcg_gen_plugin_cb(PLUGIN_GEN_AFTER_TB);
>       }
> -    tcg_gen_st_ptr(tcg_constant_ptr(NULL), tcg_env,
> -                   offsetof(CPUState, plugin_mem_cbs) - offsetof(ArchCPU, env));
>   }
>   
>   static void plugin_gen_insn_udata(const struct qemu_plugin_tb *ptb,
> @@ -679,14 +669,11 @@ static void plugin_gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
>       inject_mem_enable_helper(ptb, insn, begin_op);
>   }
>   
> -static void gen_disable_mem_helper(struct qemu_plugin_tb *ptb,
> -                                   struct qemu_plugin_insn *insn)
> +static void gen_disable_mem_helper(void)
>   {
> -    if (insn->mem_helper) {
> -        tcg_gen_st_ptr(tcg_constant_ptr(0), tcg_env,
> -                       offsetof(CPUState, plugin_mem_cbs) -
> -                       offsetof(ArchCPU, env));
> -    }
> +    tcg_gen_st_ptr(tcg_constant_ptr(0), tcg_env,
> +                   offsetof(CPUState, plugin_mem_cbs) -
> +                   offsetof(ArchCPU, env));
>   }
>   
>   static void gen_udata_cb(struct qemu_plugin_dyn_cb *cb)
> @@ -812,9 +799,17 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
>               tcg_ctx->emit_before_op = op;
>   
>               switch (from) {
> +            case PLUGIN_GEN_AFTER_TB:
> +                if (plugin_tb->mem_helper) {
> +                    gen_disable_mem_helper();
> +                }
> +                break;
> +
>               case PLUGIN_GEN_AFTER_INSN:
>                   assert(insn != NULL);
> -                gen_disable_mem_helper(plugin_tb, insn);
> +                if (insn->mem_helper) {
> +                    gen_disable_mem_helper();
> +                }
>                   break;
>   
>               case PLUGIN_GEN_FROM_TB:

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BD8C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 13:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmZAf-0006t8-4b; Tue, 19 Mar 2024 09:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZAd-0006sl-5Z
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:06:23 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZAb-00053p-Gb
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:06:22 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41468f6d584so822835e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 06:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710853579; x=1711458379; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q7whiBEh3YqynAWv6MZEohkDqdazViQIKQURYtSyZ40=;
 b=RsosWlxHwCv0oestJ27w7jposxWxHGiqp08oTF2IHRfPKldZMII2MTx+MY1nd4IhnQ
 +9xNBmHuJELugaoMoBkv/NHgFGRouBlSr1Rjn3i4bTvVv//eHbau2JpIsttiqavs2FkU
 BNVJVzsDPy3zcUFNsFOTbemlSRzeOQFsL9ZuDfkXdVJpOLGlNFHHvw+TWvJRJvoLxDbi
 htn+EyNq4jWjWmjLDUZiO1wSE3wjTTKPAeH5fWyCHFic7pkPsqVe1oK9iDpt3/Rd9Icp
 T1QfpfPnmR6TclNLW6Oaa4q+YV+9Fm6DNkPWYd2rKIGjj8QBW2vHTr2TdGiqXbWRAMNX
 uGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710853579; x=1711458379;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q7whiBEh3YqynAWv6MZEohkDqdazViQIKQURYtSyZ40=;
 b=ewM+iuqWZGHV+X7rP8gbN2sptR7xcfac98fUP+Fnd/lyxK9ywn7rP2QSyq5OJP5X0e
 7oKic9PXVyb8pUht3D9mXNNe4etJ6/BhN7pZ3nhFB/EskUSL6xQroPrqj+B/1u+oMvZ1
 LtwtOUSOcl09pfxoeySx32CLIpOEgsz+xoFFfBEkpAIp3FrQP4xIPHQHvk5R0mbioBNg
 8uIlqXgrXEtin9gIom9EOSbaCqgGdlS/xDXYMBVk3V4ygXx7jtgw6GkAKTvFzObgQ3L2
 UplxQxihHhFjpH7IAvmKBtrJw/6yNdCm3UrGNcRVwGNcDvrJB9Z//pDA7s44ZuSdkD2B
 e7Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHocw9sH9f2kHTLbE7o0Et3LRDH6Bfsm0yjcwDv1yAo//JNr24wjkaG0pdYl05KqL3EO+LZnp8QVjXIoDa49HMqIsj/bI=
X-Gm-Message-State: AOJu0YwAeGpXegfMHTC86TFjsQkjJsnyuPGh2dCaZH2WgtGF2ukXiKZ3
 zF+Km5s0QPcCHA6uwBCywR09gFwWHPuk8BESoSubRO1OZ83XWn+xKTi8U23799Q=
X-Google-Smtp-Source: AGHT+IEbllnJlt6HQNtv2iigklkQFHOfnWvIXr+6resGY628mIa67I5/nxpXZJPPwbCMEXGctZFOUw==
X-Received: by 2002:adf:fdcc:0:b0:33e:c3ca:e9ff with SMTP id
 i12-20020adffdcc000000b0033ec3cae9ffmr10441984wrs.61.1710853578621; 
 Tue, 19 Mar 2024 06:06:18 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 h2-20020a5d6e02000000b0033e91e53e8fsm12430269wrz.24.2024.03.19.06.06.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 06:06:18 -0700 (PDT)
Message-ID: <818b0c0f-a089-43bb-88ac-4f198f98f699@linaro.org>
Date: Tue, 19 Mar 2024 17:06:15 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/22] tcg: Remove TCG_CALL_PLUGIN
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-14-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240316015720.3661236-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32f.google.com
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
> Since we no longer emit plugin helpers during the initial code
> translation phase, we don't need to specially mark plugin helpers.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg.h |  2 --
>   plugins/core.c    | 10 ++++------
>   tcg/tcg.c         |  4 +---
>   3 files changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index 95a7f4d010..df66e8f012 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -353,8 +353,6 @@ typedef TCGv_ptr TCGv_env;
>   #define TCG_CALL_NO_SIDE_EFFECTS    0x0004
>   /* Helper is G_NORETURN.  */
>   #define TCG_CALL_NO_RETURN          0x0008
> -/* Helper is part of Plugins.  */
> -#define TCG_CALL_PLUGIN             0x0010
>   
>   /* convenience version of most used call flags */
>   #define TCG_CALL_NO_RWG         TCG_CALL_NO_READ_GLOBALS
> diff --git a/plugins/core.c b/plugins/core.c
> index b0a2e80874..b0615f1e7f 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -339,9 +339,8 @@ void plugin_register_dyn_cb__udata(GArray **arr,
>                                      void *udata)
>   {
>       static TCGHelperInfo info[3] = {
> -        [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG | TCG_CALL_PLUGIN,
> -        [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG | TCG_CALL_PLUGIN,
> -        [QEMU_PLUGIN_CB_RW_REGS].flags = TCG_CALL_PLUGIN,
> +        [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
> +        [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
>           /*
>            * Match qemu_plugin_vcpu_udata_cb_t:
>            *   void (*)(uint32_t, void *)
> @@ -375,9 +374,8 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
>           !__builtin_types_compatible_p(qemu_plugin_meminfo_t, int32_t));
>   
>       static TCGHelperInfo info[3] = {
> -        [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG | TCG_CALL_PLUGIN,
> -        [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG | TCG_CALL_PLUGIN,
> -        [QEMU_PLUGIN_CB_RW_REGS].flags = TCG_CALL_PLUGIN,
> +        [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
> +        [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
>           /*
>            * Match qemu_plugin_vcpu_mem_cb_t:
>            *   void (*)(uint32_t, qemu_plugin_meminfo_t, uint64_t, void *)
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 0bf218314b..363a065e28 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -2269,9 +2269,7 @@ static void tcg_gen_callN(void *func, TCGHelperInfo *info,
>   
>   #ifdef CONFIG_PLUGIN
>       /* Flag helpers that may affect guest state */
> -    if (tcg_ctx->plugin_insn &&
> -        !(info->flags & TCG_CALL_PLUGIN) &&
> -        !(info->flags & TCG_CALL_NO_SIDE_EFFECTS)) {
> +    if (tcg_ctx->plugin_insn && !(info->flags & TCG_CALL_NO_SIDE_EFFECTS)) {
>           tcg_ctx->plugin_insn->calls_helpers = true;
>       }
>   #endif

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


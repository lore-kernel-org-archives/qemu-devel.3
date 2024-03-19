Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5B3C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 13:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmZWe-0007bN-Lg; Tue, 19 Mar 2024 09:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZWJ-0007Re-Fs
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:28:51 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmZWG-0000XI-Pw
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:28:46 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33e672e10cfso2892340f8f.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 06:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710854922; x=1711459722; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ar8Dn8I23tnfEFzp8mWNlSwbpiMBQYJeSRLqPxYz7YA=;
 b=aW0ZGrspMVFOIy2s1sTPR9Gyxfpok6HeUZCvCGhbYZ/c2oPN4ihlcOxSW8l/g2nR5D
 Wj1fmXa/YTbCXlVm37dDBKnN4OHWh6fV7EZqmkXIUj0Jz8WJcfWyC+J+vzO+9SXCRwx9
 PKeof1QwDSvwomdAFOAUcJagocUzmDvuSZgwKojJt663dyViZAR4gqBTPcOmi4SyBVKY
 PVCPLB/iGvC+Vb1YFfTgndKIoxtWUpgd+ahZXK8BxWokzceqhlQa7HRSoVhtkWPJizPy
 y6MEPTGomEXVV5s1FeF08TCprC49Wbsxl9jhq+nvzbASQrRLYo40t/X+TvDBe+1Rk2dM
 rlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710854922; x=1711459722;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ar8Dn8I23tnfEFzp8mWNlSwbpiMBQYJeSRLqPxYz7YA=;
 b=w7nJuMt2UMiDfg7bCrBJ09+laGF2xrPhNrjIGzhqS3tTlhLJ3H8aX8/Y6AAB4bgexZ
 1HfDNNTYo4x7p7Fd4LiIJmutKlI5HBVdO+3sJVNYyWnmQ8CZ/TwXWnLbifsy3c5fw5zl
 N0Tp7u0f3cFpp4eq/Zvfhg/9VsgMGd/NwFUeffBJT7aMMi4tYZJ7WS3NJgSKiTk3rxYK
 iSlEZJej9rd8NFPsK41q6HJoLbe0DAo7MPSmMhEBK4oNNk9NBfXeKeJ2lnQS52g9TB1r
 bnXA73tIBh3aeTHXzmjyVRgAKE9g2f0TRf32S0xI5LW2Gf2+hqml3VlGWX0jpR9+rTs9
 7Etg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpRSURSsOAtrhIcvJj5+XcvXFXvNDLgTwnJnYJwi0qmOznsRKVYYOyfD1s15d1SMx40rTXMw8OK9mbGE2E0nCknLIVC1I=
X-Gm-Message-State: AOJu0Yx0n0Ak0Yqv+xV0WqpB8W8hKbKPCaSIXbZ8HkB+XZJvXwhBpdZU
 fpuDjU3E1B7WOsZRkvXuFEf1lgP7HQdba4NlElh6iilrk5BI5IsXPJet7q03hBc=
X-Google-Smtp-Source: AGHT+IFUPErhW+BlaPIO2liTGsujzDqrbQPTeYZsJmnxmNZ2j4V8XPEAg0oVNSw4wcByj25WD5aefA==
X-Received: by 2002:adf:e44d:0:b0:33e:7869:fbcd with SMTP id
 t13-20020adfe44d000000b0033e7869fbcdmr1825290wrm.53.1710854922018; 
 Tue, 19 Mar 2024 06:28:42 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 dw11-20020a0560000dcb00b0033b66c2d61esm12316405wrb.48.2024.03.19.06.28.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 06:28:41 -0700 (PDT)
Message-ID: <c845395d-2a24-43b7-ad62-90aa21085e1b@linaro.org>
Date: Tue, 19 Mar 2024 17:28:40 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/22] plugins: Introduce PLUGIN_CB_MEM_REGULAR
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-17-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240316015720.3661236-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x435.google.com
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
> Use different enumerators for vcpu_udata and vcpu_mem callbacks.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/plugin.h  | 1 +
>   accel/tcg/plugin-gen.c | 2 +-
>   plugins/core.c         | 4 ++--
>   3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
> index cf9758be55..34498da717 100644
> --- a/include/qemu/plugin.h
> +++ b/include/qemu/plugin.h
> @@ -67,6 +67,7 @@ union qemu_plugin_cb_sig {
>   
>   enum plugin_dyn_cb_type {
>       PLUGIN_CB_REGULAR,
> +    PLUGIN_CB_MEM_REGULAR,
>       PLUGIN_CB_INLINE,
>   };
>   
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index 669e343cfb..6f0731b479 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -367,7 +367,7 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
>   
>                   if (cb->rw & rw) {
>                       switch (cb->type) {
> -                    case PLUGIN_CB_REGULAR:
> +                    case PLUGIN_CB_MEM_REGULAR:
>                           gen_mem_cb(cb, meminfo, addr);
>                           break;
>                       case PLUGIN_CB_INLINE:
> diff --git a/plugins/core.c b/plugins/core.c
> index b0615f1e7f..0213513ec6 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -391,7 +391,7 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
>   
>       struct qemu_plugin_dyn_cb *dyn_cb = plugin_get_dyn_cb(arr);
>       dyn_cb->userp = udata;
> -    dyn_cb->type = PLUGIN_CB_REGULAR;
> +    dyn_cb->type = PLUGIN_CB_MEM_REGULAR;
>       dyn_cb->rw = rw;
>       dyn_cb->regular.f.vcpu_mem = cb;
>   
> @@ -547,7 +547,7 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
>                   break;
>           }
>           switch (cb->type) {
> -        case PLUGIN_CB_REGULAR:
> +        case PLUGIN_CB_MEM_REGULAR:
>               cb->regular.f.vcpu_mem(cpu->cpu_index, make_plugin_meminfo(oi, rw),
>                                      vaddr, cb->userp);
>               break;

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


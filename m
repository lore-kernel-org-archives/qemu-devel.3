Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C82DC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 15:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKJR5-0000xK-Tm; Thu, 20 Jun 2024 11:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKJQz-0000u0-OO
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:10:46 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKJQv-0005tL-8y
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:10:42 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-704189f1225so1083971b3a.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 08:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718896239; x=1719501039; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=couKp3+oioY7YLF7+lR3C8mYCozsX+bclXQNuCfCyE8=;
 b=qcOgVNSz9sAJnmxEaUOb2F4f0uz+YisIIXTO1bTgbLiAahs41s8Yci/P3dDRJSbnYp
 1IifcPpOLPruB8I8/RIuVq//XTIiHgb5vtc3gFvL+6Jq8tRAlgl6ZegLS2PWZtO2/aPB
 i7tKcZhLBL0KEfwuVc0jQes12aZotMEyeO75rPr/SUJeVFr/H+NW5u+EQN36/EyDb4Cw
 rF92phB/ZAlKLtX6Lv0jb+tB/XKUL9kGvBEQYDetdBWQo+B0/qlOIGIY5uQIkSr7juNU
 KYgOpZZSbeJ1LyXjlgSFfaw8VZyplI2A4bA3LKUpprNYK/gU+Na2BFmPtbEGNsDe1dIx
 WiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718896239; x=1719501039;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=couKp3+oioY7YLF7+lR3C8mYCozsX+bclXQNuCfCyE8=;
 b=o8jW9Sr+tDf2j2pLQwyuWFCq5r1xmeH1JGaAOXDUfWie8mv2UgGhy0e9cmJYNF0Xmj
 gZOv7ZWICPBbznVPoIYfpiEISaK36s4rJC0lkGXnnFPEvTnvJMPetEF6FzH8kLpTbSQG
 OlcDF1ptGDx08cGo1IM6hdBC8QM4GfNXX3+FR7xM3pjrQV5N4kYQTTxFJKIrIdfR3Dd9
 GgVm9VJgtx46RIkl5iPv33NuHLNBXvymWMOjTZSlQkD8D1di3qJyoW6TPkJrubaQzRlP
 naL/A94g1TkttpVnNYbBfyPk6w440M785v6k/lK+I+tnfxXJEhy/wJCjnVFJwz/NM5yG
 DwlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUucaR5mmtEvwU2T/vAqUDK1l4ocOR7+C7M1pfBqmhnWWLdGoSHW/FNWNqAteAnOiQjmnMV0AuKKPHl3Rz/PiAsK9DdhJs=
X-Gm-Message-State: AOJu0YzdkCkTwqYDbaBPTXTdWcxJiHEwJXYc+JMzpevYTtybrv1WkBZA
 pFGFxYqqIrj8ynzg/3LusFBcrvYEeNBzi6TcUB9V+V0JZkyzYN9rAO7rNGlt0dyP8XPYm6w2L0W
 o
X-Google-Smtp-Source: AGHT+IHR5jWxhqOfjgyf0S15ZaNGcYvPho27DW0uvNy0GOBIiblwQO9cErc4E+QjbDYz7M7RF5vx/A==
X-Received: by 2002:a17:90a:8a02:b0:2c2:f704:5278 with SMTP id
 98e67ed59e1d1-2c7b5dc7f9emr5523033a91.42.1718896239300; 
 Thu, 20 Jun 2024 08:10:39 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c7e55e0cd4sm1809589a91.25.2024.06.20.08.10.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 08:10:38 -0700 (PDT)
Message-ID: <41ef1b35-f3cc-471f-b84a-ae90b31432da@linaro.org>
Date: Thu, 20 Jun 2024 08:10:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] target/i386: give CC_OP_POPCNT low bits
 corresponding to MO_TL
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240620095419.386958-1-pbonzini@redhat.com>
 <20240620095419.386958-3-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240620095419.386958-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 6/20/24 02:54, Paolo Bonzini wrote:
> Handle it like the other arithmetic cc_ops.  This simplifies a
> bit the implementation of bit test instructions.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/cpu.h           | 13 +++++++++++--
>   target/i386/tcg/translate.c |  3 +--
>   2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index f54cd93b3f9..8504a7998fd 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1275,6 +1275,7 @@ typedef enum {
>       CC_OP_ADCX, /* CC_DST = C, CC_SRC = rest.  */
>       CC_OP_ADOX, /* CC_SRC2 = O, CC_SRC = rest.  */
>       CC_OP_ADCOX, /* CC_DST = C, CC_SRC2 = O, CC_SRC = rest.  */
> +    CC_OP_CLR, /* Z and P set, all other flags clear.  */
>   
>       CC_OP_MULB, /* modify all flags, C, O = (CC_SRC != 0) */
>       CC_OP_MULW,
> @@ -1331,8 +1332,16 @@ typedef enum {
>       CC_OP_BMILGL,
>       CC_OP_BMILGQ,
>   
> -    CC_OP_CLR, /* Z set, all other flags clear.  */
> -    CC_OP_POPCNT, /* Z via CC_DST, all other flags clear.  */
> +    /*
> +     * Note that only CC_OP_POPCNT (i.e. the one with MO_TL size)
> +     * is used or implemented, because the translation needs
> +     * to zero-extend CC_DST anyway.
> +     */
> +    CC_OP_POPCNTB__, /* Z via CC_DST, all other flags clear.  */
> +    CC_OP_POPCNTW__,
> +    CC_OP_POPCNTL__,
> +    CC_OP_POPCNTQ__,
> +    CC_OP_POPCNT = sizeof(target_ulong) == 8 ? CC_OP_POPCNTQ__ : CC_OP_POPCNTL__,
>   
>       CC_OP_NB,
>   } CCOp;
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index f32cda4e169..934c514e64f 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -1019,8 +1019,6 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
>                                .imm = CC_Z };
>       case CC_OP_CLR:
>           return (CCPrepare) { .cond = TCG_COND_ALWAYS };
> -    case CC_OP_POPCNT:
> -        return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_src };

The previous patch needs to have changed this to dst.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


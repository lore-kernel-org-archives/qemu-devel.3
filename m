Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6135DD0E6C5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 17:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2w5w-0005tt-Ca; Mon, 21 Oct 2024 13:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t2w5s-0005tS-0L
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 13:21:24 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t2w5p-00039y-6X
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 13:21:22 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20c6f492d2dso54619225ad.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 10:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729531279; x=1730136079; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RrgCmpZDjIwsYYDFIz17x4PMi1pRAGPEB0zDgNvBUOw=;
 b=NdJrDWNO5dCBI683Rhfk6Ul9wK2yqyfhrjyb86Lorf6YTVJZSt6Kwr7/bEa1RshaAN
 Zz3vpI6niWGHFh4LrNxXOVWokFpECKdHzkd3gnk56YpfQiTC9SCzKuYJhYk1nNbuS8qU
 e4gq9tdP48yjotPa1slI79bpgJ7Doolwgiu99iPF2/OODyFWO38VKnkzW4nYKnfKVRLl
 9RqWOcUyj3Vx1rYRzLfgmOWG0fSN+Y2xDSZcXTtHUsev7eBM+IkJfKsg7DNvVG9xdPe9
 qeDm55aIclPxjyes6vmVCHn7vG9SOH3KBVllsZrjGj0CNVnuQf6h83IWY35FiCVJz8gt
 nkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729531279; x=1730136079;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RrgCmpZDjIwsYYDFIz17x4PMi1pRAGPEB0zDgNvBUOw=;
 b=SiLwawJqTF8D774LxZJVOFPypY3emBMs6fRY0f+Ps4wy0c8HTrvZ7qE7AZQJ6AjLOP
 dfiWxIQZCB636wzrsiLEt1FQ8BJxv1uEAKNmBpJLNqKjukcnofHxAmyPd+dgLkZ0G/iv
 pnWQI0MNIB3JWsSgZ6HoG26ETZzwxEPuATCEcVuXyMy15nV6S/TVTd9UZyDiPc2FnCX2
 D259+2x58Ew3JFFW8dXWYJtrMpzjTTnYOHSt9s7cu5n6XjPtXJlUucTXfm1a45cVlNBS
 njQGePKMI49QT9UERa+gTg5TQg9/IG7h5kmEqzrmUyAMvJqp4hTosyklaDL9S2HL8mDO
 ixVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuWqdJwvPFTU6+K94W+BEVitmteUGI919G7xH6qO9+lN+8eF2rOHmnZ48mq9D4w7/5bQKN/K5WrVMe@nongnu.org
X-Gm-Message-State: AOJu0YyKoFSSu+JNtWoaDkETMrX60XBJq8yMMbtexLIRQPprYb6s9SpT
 bKkZ6iSqyZgnttlhBkQaJ5dyIh9G2vUUa26gETvL+XOukmAucuyaIu+3TfZSbUg=
X-Google-Smtp-Source: AGHT+IFitcCMG57mDCC2dFSPCNzYd3LgwtLAnL81/3Vzasa50YzIMibZfK4aQdL+U46pnHGgBd2Hpw==
X-Received: by 2002:a17:902:d50d:b0:20d:1a47:ecd5 with SMTP id
 d9443c01a7336-20e5a9530camr130756315ad.61.1729531279390; 
 Mon, 21 Oct 2024 10:21:19 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f109d54sm28317165ad.309.2024.10.21.10.21.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 10:21:19 -0700 (PDT)
Message-ID: <26fa8078-35e1-4c11-ab5c-1c8ae08d296f@linaro.org>
Date: Mon, 21 Oct 2024 10:21:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Do not re-compute new pc with CF_PCREL
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-stable@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20240101230617.129349-1-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240101230617.129349-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 1/1/24 15:06, Richard Henderson wrote:
> With PCREL, we have a page-relative view of EIP, and an
> approximation of PC = EIP+CSBASE that is good enough to
> detect page crossings.  If we try to recompute PC after
> masking EIP, we will mess up that approximation and write
> a corrupt value to EIP.
> 
> We already handled masking properly for PCREL, so the
> fix in b5e0d5d2 was only needed for the !PCREL path.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: b5e0d5d22fbf ("target/i386: Fix 32-bit wrapping of pc/eip computation")
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/tcg/translate.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index 037bc47e7c..e68375b19d 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -2845,10 +2845,6 @@ static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num)
>           }
>       }
>       new_eip &= mask;
> -    new_pc = new_eip + s->cs_base;
> -    if (!CODE64(s)) {
> -        new_pc = (uint32_t)new_pc;
> -    }
>   
>       gen_update_cc_op(s);
>       set_cc_op(s, CC_OP_DYNAMIC);
> @@ -2864,6 +2860,8 @@ static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num)
>               tcg_gen_andi_tl(cpu_eip, cpu_eip, mask);
>               use_goto_tb = false;
>           }
> +    } else if (!CODE64(s)) {
> +        new_pc = (uint32_t)(new_eip + s->cs_base);
>       }
>   
>       if (use_goto_tb && translator_use_goto_tb(&s->base, new_pc)) {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


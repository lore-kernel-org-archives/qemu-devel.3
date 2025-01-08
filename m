Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06B3E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 17:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVa1q-00045B-6l; Wed, 08 Jan 2025 12:39:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVa1n-000452-R3
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 12:39:35 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVa1m-0000gE-9r
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 12:39:35 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so798225e9.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 09:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736357972; x=1736962772; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4n1n41uKCVFaLekMpVjsoVGswrSou+d/EA23cCIb6xE=;
 b=NpOe+5r6DSjL87Su9SuPfeuDpHC7QqoJ9eKVOKXfbQLZruIziUVkIbrmDsuIprjPVU
 FonnBFW4PixkF/dj7lutVIya1OgWttLZSJfVh5W6ssiU8qpghGuEeHO5coomYxcKznRA
 7SM7N3twpHswf5c/hNeBv2AaWuje1AfYoq38XhwblG4b8gI9wFLBIylMKLVc3KndKO2P
 aHMYzIkwzfUouQ0XCsBBgyiv8/gLfNSaYebKo2TADhnPPkLo7JrdL305/26VVR97jE1h
 1N9ioIr+ZDj8UBgX3GYWkuND7dH1gKwUFTB+Gwlv9QKuPzKA5PDb9Ozzq4pomnHk8biz
 JsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736357972; x=1736962772;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4n1n41uKCVFaLekMpVjsoVGswrSou+d/EA23cCIb6xE=;
 b=sbiXSl/vzoeB5L+4q9FpyFiLUI7LJEIyiWeu8wI35UZktUOCTT/zuHoi8ot4x77js1
 omZ7di1FHo+ShnQe93g3Bvs6iDrHFJ9IAzE/A3xzo3q5rltumpTULk/89F2k7NpxTSqc
 Iu9JRYA0xl1IailoMOd/4z7AFDa7XY5lF0ZqsUxb+QiF9iEAayWyO0qsOCVabRFhSKhI
 KdTFqlBmd0WY18OSsa8nGlAEfA4SgpHreltXMcxDgGynLy2zUc44VVXr2tXGWnqafedL
 1p2QHnKKBp6iV6FyOKzKsrhebHO5oOCxfSVFBXM+qQBpajWzHsbePr9L4vCPkNFKKLdV
 okhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU622p3XAg1adU8U+prU1ceNPNHBJm1ZbzgAcuGjemN2lnkEN8FFy6OqSSiua+TH/soDzW9ox+ULMeP@nongnu.org
X-Gm-Message-State: AOJu0YzfDi4ouDJRuXl6hcNvaQma4cQyy4Fhx1+fty0BIpO+DSjHuUDU
 98m/E8cy1zn/HoBIhwClbJb1SVirJ5iW2NMgSKfdH4TrXUMK5iA5V7OS3n7+WhOh1eCzMM1z4OU
 D424=
X-Gm-Gg: ASbGncvrP70q/A42t50oalAcAPcS6mM91c6mfyRcSzL1ySY6gF+V1k2Q6p66gLi08bN
 vUx3DN+rae+c+8QoDSXOY/e5y5ke+3oukjrfpw8lPpd6WiEASaJbqcC/BSt997Tzj/RrM0jS7mO
 R7MxY87Ro7HXE2ZpFy3svP1X9KQpYeYhtysifqSi3+r9HPdnPsvT6Pa3GmN4ncUnoYdXKkdq77g
 qNhOIS2CItkMTU1rwLQ7k4CgR7L/wV3sVEcRoX4I14SmULahxNB2FbR3f8QMOAyIiEdPRZk6EAn
 lI25hhN1AJ5XW/jTjCyntkfN
X-Google-Smtp-Source: AGHT+IGiJ1nqYjFwzcwhkQDM998tztum+TPr4RW5yEDZCGIoESMvgo3tBTeYlJuHa6unfOrzBew+7A==
X-Received: by 2002:a05:600c:35c1:b0:436:a3a3:a70c with SMTP id
 5b1f17b1804b1-436e26ef06cmr23867165e9.28.1736357972118; 
 Wed, 08 Jan 2025 09:39:32 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2da66d9sm27998205e9.1.2025.01.08.09.39.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 09:39:31 -0800 (PST)
Message-ID: <1271a667-845a-458b-b8e8-b3a9a75fafc3@linaro.org>
Date: Wed, 8 Jan 2025 18:39:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/81] tcg: Replace TCGOP_VECL with TCGOP_TYPE
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 7/1/25 08:59, Richard Henderson wrote:
> In the replacement, drop the TCGType - TCG_TYPE_V64 adjustment,
> except for the call to tcg_out_vec_op.  Pass type to tcg_gen_op[1-6],
> so that all integer opcodes gain the type.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg.h      |   2 +-
>   tcg/tcg-internal.h     |  13 ++---
>   tcg/optimize.c         |  10 +---
>   tcg/tcg-op-ldst.c      |  26 ++++++----
>   tcg/tcg-op-vec.c       |   8 +--
>   tcg/tcg-op.c           | 113 +++++++++++++++++++++++------------------
>   tcg/tcg.c              |  11 ++--
>   docs/devel/tcg-ops.rst |  15 +++---
>   8 files changed, 105 insertions(+), 93 deletions(-)


> @@ -3320,7 +3333,7 @@ void tcg_gen_exit_tb(const TranslationBlock *tb, unsigned idx)
>           tcg_debug_assert(idx == TB_EXIT_REQUESTED);
>       }
>   
> -    tcg_gen_op1i(INDEX_op_exit_tb, val);
> +    tcg_gen_op1i(INDEX_op_exit_tb, 0, val);

Having TCG_TYPE_I32 = 0 is confusing.

Should we define TCG_TYPE_VOID = 0 first, shifting all other types
(and updating tcg_type_size())?

Otherwise,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   }
>   
>   void tcg_gen_goto_tb(unsigned idx)
> @@ -3335,7 +3348,7 @@ void tcg_gen_goto_tb(unsigned idx)
>       tcg_ctx->goto_tb_issue_mask |= 1 << idx;
>   #endif
>       plugin_gen_disable_mem_helpers();
> -    tcg_gen_op1i(INDEX_op_goto_tb, idx);
> +    tcg_gen_op1i(INDEX_op_goto_tb, 0, idx);
>   }



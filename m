Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D862C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 12:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjeQA-0006dh-Jf; Mon, 11 Mar 2024 08:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjeQ9-0006dW-P9
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 08:06:21 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjeQ7-0005ro-W2
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 08:06:21 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33e5978fc1bso1827239f8f.3
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 05:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710158776; x=1710763576; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CNHGBZTFx7Gfko0uNtcYewxNLptzpR2rKXJulq3/EhU=;
 b=KM5DTlWnr8ZyKao7mCJj/u3/3J+3FTRlLl8eyzATjXjMuy5YlsVraWyXjx5kZaPZTH
 TSV1XkeAvRIPbG1Cd4zqPBYPVNDXSGfzQajsGoUPOnI4CZ3Wsy/UzQaeP+2ZSmmi6c4t
 eqP72F5ZaIfFbF1wvgfVAQ4REGteDq6FIpxi7FbMr4OwYn0q48VQE0gD6tuO7bIAGmlj
 EYZEsWv9eRN8lMYz2XJ7uDKzOBAMgvdzHn6WW1uMDHpQgeNjMhj9p4+489VOtOnqqi6q
 n4SZNvhJcw/YirfWg4wZSct1pFx8s9p5SJ9Jgh2MJidzB7rMSlrY/aSs4n8MJvLhc8fk
 xpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710158776; x=1710763576;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CNHGBZTFx7Gfko0uNtcYewxNLptzpR2rKXJulq3/EhU=;
 b=AF6xVv/3cUv+urEcL2ZLEWNV0Pcv6c8BAEcyljHJ5wZIOmPDrYsR5aAnkSMULp3E4C
 AdNQUxokK5HCFTHFKhM0dLJpvAL2nuaX5pZW8ivcVmY2kuS8FvlXxHIHCaFyRifVTfLs
 ROyuCk+YUvVkED4pdXzq+M0uLmfFCgBDyQW8iHaiNYFoQvsRUWOH9eFQY0BgCtoV51sn
 yY7UesXu/z5jAAo9WG/DnUIfc3TRtQTYH2qtWCSO2ORQgRYsC+Dm2g9LVHbcBx9860EO
 uEfjzocz2ah6s70s/c04EkBKLIrjCrqijaAp8bqx4DHrubjGYmh/TOwyW8MzWaDfSZAe
 /Zjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbJXQnwSMFLv1Rfw0p+f8lgRldgH+9iG7ku0NsTPdjTkQ6984zYflCIUtDoVk0LpEPxsCqEjmEk8CeqcRNi5Lw1YrWHpw=
X-Gm-Message-State: AOJu0Yyi/V08h7GWOPefjgNaeKYZi5zSLT8x95iOZ6V3IanKu3h/lzbU
 TSNiCQyRhxP92Bjs3x7GFSlJj7VFey284WbUAS+kRYvgEJPEZaD8Z9CrNYAQuCQ=
X-Google-Smtp-Source: AGHT+IGzP9N37n1tlWa2/yqaEW0etKMvjAzdr6w19KD87BBjOG1+qWnKf2Sk5d7W7hpRIfAvVVD3EA==
X-Received: by 2002:adf:e481:0:b0:33d:2f2f:b135 with SMTP id
 i1-20020adfe481000000b0033d2f2fb135mr4114250wrm.46.1710158775754; 
 Mon, 11 Mar 2024 05:06:15 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.167.228])
 by smtp.gmail.com with ESMTPSA id
 r10-20020adff70a000000b0033dec836ea6sm6292177wrp.99.2024.03.11.05.06.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 05:06:15 -0700 (PDT)
Message-ID: <513f4a87-d7b9-4973-aa59-48aabd673fb4@linaro.org>
Date: Mon, 11 Mar 2024 13:06:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/aarch64: fix assertion failure on TSTxx of UINT32_MAX
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20240311082632.671163-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240311082632.671163-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 11/3/24 09:26, Paolo Bonzini wrote:
> These are translated to CBZ and CBNZ instructions, and the code generation part
> of tcg_out_brcond checks that c is one of TCG_COND_EQ or TCG_COND_NE.
> 
> Fixes: 34aff3c2e06 ("tcg/aarch64: Generate CBNZ for TSTNE of UINT32_MAX", 2024-02-03)
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tcg/aarch64/tcg-target.c.inc | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
> index dec8ecc1b65..6ed174bd172 100644
> --- a/tcg/aarch64/tcg-target.c.inc
> +++ b/tcg/aarch64/tcg-target.c.inc
> @@ -1465,6 +1465,7 @@ static void tcg_out_brcond(TCGContext *s, TCGType ext, TCGCond c, TCGArg a,
>       case TCG_COND_TSTNE:
>           /* tst xN,0xffffffff; b.ne L -> cbnz wN,L */
>           if (b_const && b == UINT32_MAX) {
> +            c = (c == TCG_COND_TSTEQ ? TCG_COND_EQ : TCG_COND_NE);

Correct. Richard posted the same fix but using tcg_tst_eqne_cond:
https://lore.kernel.org/qemu-devel/20240309175102.726332-3-richard.henderson@linaro.org/

>               ext = TCG_TYPE_I32;
>               need_cmp = false;
>               break;



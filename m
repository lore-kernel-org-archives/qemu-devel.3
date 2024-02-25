Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3B5C54E41
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Feb 2024 10:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reBYs-0005ue-63; Sun, 25 Feb 2024 05:16:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1reBYq-0005uK-8e
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 05:16:44 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1reBYo-0003Ky-Np
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 05:16:43 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-59d489e8d68so1039529eaf.2
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 02:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708856201; x=1709461001; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KgUAZqcf4NokaguLeLczXKMjS0HPveziLQK00VWV5Js=;
 b=DWLyyn0lNV1sDYjJghcdK+Zjf0c7k5QvW8bYD0LKqIzPCIQvpMc4kAuozXdh3UWzgb
 jR2xjqj1nWr5sF+rFqZ5auDBiFyj16+l6VjzShgWD0PnGOZL/EyeHsDENBgfwbd28IDZ
 JWQ8R76/WGeoo7Ts8MJ4Q739OPwlMavMJ/DWybOgznVHC2C5/pkF3Tf2jUcWv9K4K6aL
 oDD6QE8jkKw/HYI5PYXanlHfv8GLvDfc87nqosjcHBkWyT5RV5Deii4WzXnxwcKjAgE8
 aosh7YOX9PJSwgV9kkIKzBebYn1ICSAlovnPPfSMGt7HQYy3UKJWi3ZlUKt5LUp3/fQm
 LHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708856201; x=1709461001;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KgUAZqcf4NokaguLeLczXKMjS0HPveziLQK00VWV5Js=;
 b=RAEvoBQL9gXveiq/1c02RJ9SypKE2pMWbAg6h8FA2livmo8fAvXpF6htzZWDemHUHH
 V0UlN04I2Ir1WTjeBTzvsI/7SmcGN3u4j0ZHymizPAWJC4yzzKej8XDe938+jj6GFFBo
 9vF9ekn2irJhLdUKRpnL3D/Otv996lzRLVEg6G0q3+QWbumbfS/3Nxbc6A8wVy6aAuOm
 fKcBfPVTU/qVPvAvWfMU0uLE7q1wMz1Emd6h9QCqK76jksMz7Klp7n+K3nznomU6qFf0
 gTyQrinkWftx6G09k1CupnpjIUcM0NU0DPpTAdD2TwdkLf/lMtjhKpzz9EsHnqQVzdn/
 WOaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+gO0kh642cGz024Q1VhLzvGrudJE+ubQQd2gZAqYPzz84OjEU67hiOhBpsQCUHiEJO8Bpg6HsNmJJA6cLJxpPswXMBrI=
X-Gm-Message-State: AOJu0YxGFbVRToii6N5YxFNlJGCoRBEaw3p4ZXJEj6SxnWXhwueyPoIb
 RHa0bBEyQh27Udgh9E1CAx/UynJlnSBbPzseE+CyjjTizrfeHAjKJO1qMb4MYgg=
X-Google-Smtp-Source: AGHT+IGoMljyIaMPS3xAXPt8XS4Bise8Xc7SixJRNQQnqiwEzjOB+ZbokE1jIyrevjR7DFo4VtzO/A==
X-Received: by 2002:a05:6358:a09c:b0:17b:5864:4ae4 with SMTP id
 u28-20020a056358a09c00b0017b58644ae4mr6102550rwn.20.1708856200880; 
 Sun, 25 Feb 2024 02:16:40 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 c8-20020a62e808000000b006e0ad616be3sm2147142pfi.110.2024.02.25.02.16.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Feb 2024 02:16:40 -0800 (PST)
Message-ID: <439bbdad-ad63-4975-968a-e050564f002e@ventanamicro.com>
Date: Sun, 25 Feb 2024 07:16:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: Fix shift count overflow
To: "demin.han" <demin.han@starfivetech.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com
References: <20240225032720.375078-1-demin.han@starfivetech.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240225032720.375078-1-demin.han@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc36.google.com
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



On 2/25/24 00:27, demin.han wrote:
> The result of (8 - 3 - vlmul) is negtive when vlmul >= 6,
> and results in wrong vill.
> 
> Signed-off-by: demin.han <demin.han@starfivetech.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/vector_helper.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 84cec73eb2..fe56c007d5 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -44,6 +44,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>       target_ulong reserved = s2 &
>                               MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
>                                               xlen - 1 - R_VTYPE_RESERVED_SHIFT);
> +    uint16_t vlen = cpu->cfg.vlenb << 3;
>       int8_t lmul;
>   
>       if (vlmul & 4) {
> @@ -53,10 +54,8 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>            * VLEN * LMUL >= SEW
>            * VLEN >> (8 - lmul) >= sew
>            * (vlenb << 3) >> (8 - lmul) >= sew
> -         * vlenb >> (8 - 3 - lmul) >= sew
>            */
> -        if (vlmul == 4 ||
> -            cpu->cfg.vlenb >> (8 - 3 - vlmul) < sew) {
> +        if (vlmul == 4 || (vlen >> (8 - vlmul)) < sew) {
>               vill = true;
>           }
>       }


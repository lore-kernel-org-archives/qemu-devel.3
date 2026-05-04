Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB49FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 06:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJn7I-0002sM-EE; Mon, 04 May 2026 02:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wJn7B-0002qf-It
 for qemu-devel@nongnu.org; Mon, 04 May 2026 02:49:13 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wJn79-00009E-Rf
 for qemu-devel@nongnu.org; Mon, 04 May 2026 02:49:13 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso28273335e9.3
 for <qemu-devel@nongnu.org>; Sun, 03 May 2026 23:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777877350; x=1778482150; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1k45xLpLHb0qdPbiKWgQOPZfUPhlvLzAYHcCXM1ad1g=;
 b=P8Tq5pvqewwxxDY5EO8HRD7m8i5XZkF+Xtg1w3Md9j5+TaY9Y3U4yFWNelGY99jtrE
 bFiuan21mnuWyjE0REKQ45ZXrRzCBsA77+AJp5N3Z62/OWEJPzJXLt7J7s1k3bX2wWj0
 XMH2+ywDFCBDz9JhVK8TpADdG3+ebJ9hR/coQtKAUyRD1AK3P5bmVl6Qe5HjgHSuM+MC
 x/GOer0ZmYGCokn9wqVA6NgJO1apQapiO+hQt5DcJc4FK4Ixcb2+y4FHa6d6FhRMt70V
 tHgCS8sHb/8b7KW9fnPOTvvvlS5v9LFsK6ekeDgR+g8Hqz7Hal0QABQMtJKtzr1bLw7w
 9xBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777877350; x=1778482150;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1k45xLpLHb0qdPbiKWgQOPZfUPhlvLzAYHcCXM1ad1g=;
 b=CXa3TjKqCDBee1sCrxgvMRGNYXgxg6TDmNAFgdNnqkuXdC+oxL/JXG4IkdLZa9cQa8
 aK7HIPp/6HTa8A616gq/v8G5DaeAF1xXrx/X8qQvhfthAvQt22N0jiuYoWJ2dgyEdWt7
 x4aHbVJKmD8TEHaL7kmj3m/HlQ56hz8N2aPTqlY1l+1LVnGQthQX+nSe8FxC5xvLfZa5
 tx4Y1u7riF9xsnTAg6ntM/tY1Xpk9IapiC0qrH93PesNsfPLC6e7YfyiYwopW7+A4k0f
 4lRSuHuEZnBsAI/SF6eATKp2YjP+BB+D8SwIlGEK2i/+mczk7WO77Idxi+nOGtSf6da1
 hWhA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9SQVcngOx7FhseZhY881SzZczy7PvzONfp55pPLe7ggpuVrgGnFA5ZkH6mVlytbMU0Hoy47EFLKh4Z@nongnu.org
X-Gm-Message-State: AOJu0YzXG4IhowvIkRIz2JtVk56TL9c2U0Rl9QLvfm9yKjsQVsh0xr9n
 /yHwKxV/rQIDTC3NuNEf4qCQfC0bIyhHuz1N6GgHecR0UM381b3n+HuCRirUv2qNq34=
X-Gm-Gg: AeBDiesMH+I2n/z/wdvGDek6piiWaiKNFHNJxPsgiw8U71iCa1GrKoxDFzjRDBJDZAt
 zc3psjlZxwIWyIKtJcjzQXxgCN6zVJnL3Hp/ja9VBplBCzqNFAXKxffplCo3j2r01am65/G1HTf
 n37fgpBDy67/5fIKvbsuze+qhfiK9zWx5k7pCUB9NXODz8muSCNh+RjjhphM+ojwK6LX7r5atr+
 Pm4TYnO3h4dFuP5Y1+CaNxSa2TUNaHuSwtCCzDNkvpnFNXdq4GR3OHz4SlPfiJIv15Upm0ZoiF4
 g7u/HCuAzBnZvlzswwCF2PZx5yCcyrku7k2DSa1zOqTkOWnFI18bUr/DOx3y7tG4Vfn7Dp6TdvX
 ylBxjIsE5x2XVTmH/Ay/rWMIKQwnWbknurTh85WSpVw2gBs5a08FAqKAPWPtR/V/C34n4qzhsQw
 2A4oi7mUCQFodGICXkQYsRPuBsxlCr8vuFiGCFc3HVH1BKiA+SGRG80Yi26M/xMUqRE9womKnAP
 At4
X-Received: by 2002:a05:600c:3e05:b0:489:1ff1:74df with SMTP id
 5b1f17b1804b1-48a9852fbcfmr139519015e9.1.1777877349778; 
 Sun, 03 May 2026 23:49:09 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a9919fc3asm83929775e9.0.2026.05.03.23.49.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 May 2026 23:49:09 -0700 (PDT)
Message-ID: <e36f1d1b-89db-443b-aa48-6247831a8247@linaro.org>
Date: Mon, 4 May 2026 08:49:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hvf: arm: override HV_SYS_REG_MDCR_EL2
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260501231353.63184-1-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260501231353.63184-1-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 2/5/26 01:13, Mohamed Mediouni wrote:
> In older SDKs, MDCR_EL2 was defined incorrectly.
> 
> As such, override it with a #define if compiling with an older macOS
> SDK.
> 
> This is a workaround because the macOS CI setup we currently rely on
> has not been kept up to date, to be able to land nested virtualization
> support.
> 
> Once CI is updated, the SME stubs can be removed and this
> commit can be reverted.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   target/arm/hvf/hvf.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 4f0f7ffba1..79209bc8e9 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -468,6 +468,15 @@ static const struct hvf_reg_match hvf_sme2_preg_match[] = {
>   #define HVF_TO_KVMID(HVF)  \
>       (CP_REG_ARM64 | CP_REG_SIZE_U64 | CP_REG_ARM64_SYSREG | (HVF))
>   
> +/*
> + * In older SDKs, MDCR_EL2 was defined incorrectly.
> + * As such, override it with a #define if compiling with an older macOS SDK.
> + * https://lore.kernel.org/qemu-devel/BCCED674-EAEF-4755-9BE1-116FB36FB5C9@apple.com/
> + */
> +#if !defined(MAC_OS_VERSION_26_0)

Not sure about this check, i.e. wouldn't it clash with 26.1 release?
I'd expect a check such:

    #if MAC_OS_X_VERSION_MAX_ALLOWED < 260000

> +#define HV_SYS_REG_MDCR_EL2 0xe089
> +#endif
> +
>   /*
>    * Verify this at compile-time.
>    *



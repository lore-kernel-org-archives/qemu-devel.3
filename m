Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AD7C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 07:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpNkG-0000HM-CA; Wed, 27 Mar 2024 03:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpNkE-0000GV-J6
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 03:30:46 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpNkC-0003ok-Nj
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 03:30:46 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a4a387ff7acso357688566b.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 00:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711524640; x=1712129440; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/pBkl5pSQwxSD6lsLdcXmyiXV+OQ4hUaYKQVZznma+o=;
 b=nYaRO2ntBDsufniYM1Uvw2UDUY89IbdFsa7HckaUAo2difXGCjy5H39ggoWloYmHiy
 1QZ/WjgtCS3qX7Ft3Y+ntyc+oFSZY7xUg6E52FL6K4Pl4zTeBTNvpAkrU8QkDF3tJthA
 9wx7rOWnuco1ZhnGxqC6P2gDSUMj2yb/jNZC8Aeb34cYOdPB97KCsBu1k/wv9v3Rj8MJ
 Ml+ptRiaS5+bM1XCI9wVYDWr/B3X5umQNoZCF676ibGTcKBKCTmA4aaggq3V1Y/5nTDu
 W2IVujyJI2C34bZV92DXYPVxohixTOuzhnPPY6sn6YM/rIBDhqx94LDlm7Twsg1ipJO9
 5XTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711524640; x=1712129440;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/pBkl5pSQwxSD6lsLdcXmyiXV+OQ4hUaYKQVZznma+o=;
 b=oBgsqeEpFT6KWWV7Nm7rx7RUVPM1RTTJsja+1wCOUBeyPCucXQTNFwuMGpfnHIfhlq
 5Z2qeNRlA5IrXG0eOM4Xs8cmOuGNm0Mu+cUTAaah6jY5Fzq4Ruz46ThMoIxyAvwGOsrG
 fQswz+tZj13tBDyck0RVx0oyavSRseBgpUxNwLG6JC6qtioA86d6CWCgzIBnvItGF2Fe
 NCRuDumlm26/LEzPSXwsYrInGscgvqgRohnVxKtjD05XiLvtFYMRXr1/j65f+PIg8QUN
 DYPwne0WujfPRaGuQbBG55KNoP2wueaVD8F9hL9Cz7dnZoT/acFSomkXA+Qti4qvlQ7n
 yPLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXphJU/28YapdX7zpASvud4Y1XApdIHJy3PXmoj3GlqnIurvFr4XrjAm603YJr0+GkleVMq/sAW0FQ7Z5VYM7icNjnmLgw=
X-Gm-Message-State: AOJu0Ywwn9MvcjwE+82UFmav2vQPT/VOO/TVH/IhzfvvKQyqKXdo1qWA
 2lU3FBedbo6OEP987s4E9FhPqspIEh5Av/Zok4C6mBOWZa90yMF5qVFbLy+jcDpoJBxgczoJuRN
 4
X-Google-Smtp-Source: AGHT+IGZpA+rnXxs0Xuhvih6y3/Pd/XxlvrnFFiE6K8Kep55/bwSslVG7cuUggIwgsu58zp41FuZXA==
X-Received: by 2002:a17:906:3613:b0:a46:a3bc:b343 with SMTP id
 q19-20020a170906361300b00a46a3bcb343mr2319679ejb.21.1711524639904; 
 Wed, 27 Mar 2024 00:30:39 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 x20-20020a170906b09400b00a469e55767dsm5067011ejy.214.2024.03.27.00.30.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 00:30:39 -0700 (PDT)
Message-ID: <ee9e7b85-944a-4f43-91c8-aa072f1fb990@linaro.org>
Date: Wed, 27 Mar 2024 08:30:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0] tcg/optimize: Fix sign_mask for logical
 right-shift
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20240326222259.528099-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240326222259.528099-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 26/3/24 23:22, Richard Henderson wrote:
> The 'sign' computation is attempting to locate the sign bit that has
> been repeated, so that we can test if that bit is known zero.  That
> computation can be zero if there are no known sign repetitions.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 93a967fbb57 ("tcg/optimize: Propagate sign info for shifting")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2248
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c                    |  2 +-
>   tests/tcg/aarch64/test-2248.c     | 25 +++++++++++++++++++++++++
>   tests/tcg/aarch64/Makefile.target |  1 +
>   3 files changed, 27 insertions(+), 1 deletion(-)
>   create mode 100644 tests/tcg/aarch64/test-2248.c


> diff --git a/tests/tcg/aarch64/test-2248.c b/tests/tcg/aarch64/test-2248.c
> new file mode 100644
> index 0000000000..6cc20e3c6c
> --- /dev/null
> +++ b/tests/tcg/aarch64/test-2248.c
> @@ -0,0 +1,25 @@

   /* SPDX-License-Identifier: GPL-2.0-or-later */

   /* See https://gitlab.com/qemu-project/qemu/-/issues/2248 */

> +#include <assert.h>
> +
> +__attribute__((noinline))
> +long test(long x, long y, long sh)
> +{
> +    long r;
> +    asm("cmp   %1, %2\n\t"
> +        "cset  x12, lt\n\t"
> +        "and   w11, w12, #0xff\n\t"
> +        "cmp   w11, #0\n\t"
> +        "csetm x14, ne\n\t"
> +        "lsr   x13, x14, %3\n\t"
> +        "sxtb  %0, w13"
> +        : "=r"(r)
> +        : "r"(x), "r"(y), "r"(sh)
> +        : "x11", "x12", "x13", "x14");
> +    return r;
> +}
> +
> +int main()
> +{
> +    long r = test(0, 1, 2);
> +    assert(r == -1);
> +    return 0;
> +}

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A478F10F996B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXqJ-00030D-Ta; Wed, 08 Apr 2026 14:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAXqG-0002aU-FS
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:41:32 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAOLz-0000yM-Ii
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 04:33:40 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so18228895e9.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 01:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775637218; x=1776242018; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lTiyfeoSbM6oi9Y2ehhT2k0lqRLvboHUmVyhx3Xj1x8=;
 b=vf1Hral6nd1z1WluzDaPsFtTHl7QAWNReTJVOompq0UAkIqrdXp7qk9gTtlpKVVMZz
 XmhH4m6zWY47j7Uxs21779zCgtzDDb1K0MJp/pFLudwNKKC9MlCrcCvzByuNd5pKtUug
 zFDutwY9JnpIq3zwpPifsqXIQJnrwULDgQNgmFJcxair3F7KnJyypiVWbrOVT07W8tf3
 w4QXzlbib1pkRd4kOLQwfI3qJRSVIpzsEpMiPxAV0HCqykEmIFaFofNbqECvJzoBJZpN
 0P9zDn4aC20W3WuStCGAaFZssG5N1SFqHqv/uwonohSX4ZocDFIeWTlYd5kbWsqrmISj
 gK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775637218; x=1776242018;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lTiyfeoSbM6oi9Y2ehhT2k0lqRLvboHUmVyhx3Xj1x8=;
 b=Qib3S/+GudwdPzZxZ6L+pSwfxX/vH1HqzxorNEC+2kZdw4p7G5GBSXRCFcYeBPfE54
 l5Ww+tLEcwONtV18dpfBIMnBuMDWeu5A/aOMI3Arur+3kjLcZZ4baZEUPii4UTL2hqYv
 JFrvvdS2Jgy3+jjFk1pNLj1Pe87+yb7YW2j955VwI7sOJMYgyQLWI8617Qk5+iu5QnHG
 GN08Pvy+M9KydhALD2NCjjN1k5iR9SgJmrVKZZ9VfvNO6KIRwIznHhHMfjsc1l6jN+Oe
 /iVw3MrCyxKd4CfO1oGG/42axD2sWuQcfcrazW1KFCY+bIQ1ko1urfDIYnAeoEJYJPSi
 tE2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVItPXGpAvN9hsdrL3b+rOU0eTT8oHup3UyOSKLM/BVaxj7sKWxu7Xo8acFkxRduLP5FY3+GwpuTKVf@nongnu.org
X-Gm-Message-State: AOJu0YwhXHSfDEPgRCt7+T2swsTyGsmkdHooyjJEEFPJci3pQjkDZTIz
 QJL5dznYmzxLAJ0yuu40neR0w5ZoxRw9FXs6nRN1RgOdBP4Hw6S72wcEFhOs666XNJ5e9O4EyFv
 M/EA+skw=
X-Gm-Gg: AeBDieuz/Jk5DgF6X4lK67CmSSXg83UVTv1i71sqIrztJ5TGTu8zU7r1wd/b9XUWfgp
 UQ01n+oZrGfIT+TbGLfiFwfu+yHdFRBYMoinA/yDcoZ2n1O9OWHzhBQmvRzy6snRjFX9Gx5geA0
 C6Jda4iV8d9h5xTylbueTZ5XVu3wlFTwG5MWXhBAosYLUKN76yJvsNb5rt8aGUBOos6w2Quw9DY
 rqT1WDQpg0NdICH7eJHkqrv9k/9mCfbW5XaNHWgdB3LuXhEmADROuxTtYQKFYD/ac574yeRoirG
 sFPP5ZDYZw0t1hgUbzLMp6PWBr6uTUkVkRP5xP/mEX1y/htKcRypfq5uKfF38Dd3XxC66IGF+Vq
 BCJ5UbNepbvOYhx5jBQuDxj+evXgsGQBPngLKDqn2Vkul2KpcXFTivWDWOgA/vKCf/NM0tJ4Mkv
 ZBRfKgZ2zahjB1TWnOdFJe/TXuaGZyj9XkMZJyeKHrgybrJvEmJywmYYjRiaqxjGQlFA==
X-Received: by 2002:a05:600c:4886:b0:488:a797:f0ac with SMTP id
 5b1f17b1804b1-488a797f2d4mr115435815e9.28.1775637218067; 
 Wed, 08 Apr 2026 01:33:38 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488c5d854ebsm13106715e9.19.2026.04.08.01.33.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 01:33:37 -0700 (PDT)
Message-ID: <6e4dae05-7d24-4cbe-8653-97890d87706a@linaro.org>
Date: Wed, 8 Apr 2026 10:33:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 17/21] target/arm/tcg/arm_ldst.h: merge in translate.c
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: jim.macarthur@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
 <20260407222208.271838-18-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260407222208.271838-18-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 8/4/26 00:22, Pierrick Bouvier wrote:
> Only translate.c uses those functions, thus move them back to this file.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/arm_ldst.h  | 47 --------------------------------------
>   target/arm/tcg/translate.c | 24 ++++++++++++++++++-
>   2 files changed, 23 insertions(+), 48 deletions(-)

As per v10:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



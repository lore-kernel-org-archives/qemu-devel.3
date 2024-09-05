Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB02CD5BB6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 11:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smB4r-0005qI-9z; Thu, 05 Sep 2024 07:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smB4f-0005mx-Gk
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:54:53 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smB4d-0002aw-Qf
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:54:53 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3787e067230so426924f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 04:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725537289; x=1726142089; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sfHmpBluUEk97UorwiKAMCpBaYBXciQ16mUNEEIlTbo=;
 b=F7GWWYKNav2/2VIqtDGC2jVh3j4en7XqJ4keInNmMxkCAR1YY48JVyd2WKg/vHsAfM
 f6rXUV4WqL1+3nfFNN+SHyfe9r+tOSZJjFMiv5SqK5/2g2vRwIECk2OI0WkSGY4gjlbn
 +prJjEdDm/YUsTOBqU4vnJ/ag+c4UnZyTn8ftHBw1tOUcQVyU0Io33uSqBpKxCFoXv+y
 xNDP1LFnu0oniaLfYgz6Jd+sf/NipNEHeEwhHmbTdxpU4mWpk4ZlMkR9V3noPJ+5h9p9
 mS6iXGbAzlOpbDuwBUwKQEZ8Ud3Db39mFt5Y9iWZDfvIkFTH0glbbzXONe1bHpl6h9cd
 b1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725537289; x=1726142089;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sfHmpBluUEk97UorwiKAMCpBaYBXciQ16mUNEEIlTbo=;
 b=djYBcztU20Z1SumO6PL8+7V/A3a/FavDVdzCe5fm7SL/RWnruODn6nuTpaZTVKs8fW
 wc4vhe9fvUfHf7+EI431e4HDqmjKnqemYIq2/TGFhw9czflaKJB3gBvCqjVGN9J5o/fd
 owVHD1jEfgBcx/KSjWzVVoCmOEuFYGcoOJ5ZcDhXi2ZLyBMwhSfM+d0QqaiNtZyJZ41G
 mhshe/Ngw0SQwW+5RnTs7UuvhgeROHoB94cGYWZdBXNhHkJDnyjr/Zix6rAoKavKe9n8
 vfRGku/zMwsp+rKQ5f/4qoaUSm8vdTI1YXZ4PWYKgMB9kXGEPPv0NPeiyM1sPuBJ6lDw
 nF8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH/fLPP79nVD7Nf/u8ysS+1/KzcqXXC/SJyGr5mTFMt0TKIyButpu+lIzMlJZWA6LHEdaSdlqCuGbJ@nongnu.org
X-Gm-Message-State: AOJu0YzGa+grFWvftad4dMZyATBlY8+mlsIhDLWV9O9AKqlbPPUXt+FO
 fqWTLsxGB1Vi08i9meWrdBKNaruyisAJpN6EgGbZc9zTIpo8gzV5oU1/tFaFYYE=
X-Google-Smtp-Source: AGHT+IGMV58wtIgVAmZ0j5v0vC5Ns7f7npYxRHXNdeX74yUY/sMFK8lIVfHHDAaLJ8dAReWtWWii+A==
X-Received: by 2002:adf:f503:0:b0:376:37e:2729 with SMTP id
 ffacd0b85a97d-376dd71a9b5mr4455547f8f.31.1725537289353; 
 Thu, 05 Sep 2024 04:54:49 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba7b4271fsm266038035e9.29.2024.09.05.04.54.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2024 04:54:48 -0700 (PDT)
Message-ID: <6dd42fd2-81ad-460d-946b-ab1afdcfdaea@linaro.org>
Date: Thu, 5 Sep 2024 13:54:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 12/53] hw/arm: Remove 'z2' machine
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-13-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 3/9/24 18:07, Peter Maydell wrote:
> The 'z2' machine was deprecated in 9.0, so we can remove it for
> 9.2.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   MAINTAINERS                             |   1 -
>   configs/devices/arm-softmmu/default.mak |   1 -
>   hw/arm/z2.c                             | 355 ------------------------
>   hw/arm/Kconfig                          |   9 -
>   hw/arm/meson.build                      |   1 -
>   5 files changed, 367 deletions(-)
>   delete mode 100644 hw/arm/z2.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



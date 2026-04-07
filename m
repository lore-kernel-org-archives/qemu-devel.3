Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808B8FF5134
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABop-0004tP-IB; Tue, 07 Apr 2026 15:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wABof-0004lb-Uc
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:10:27 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wABoe-0002nk-GE
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:10:25 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488a041eae5so27158475e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 12:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775589023; x=1776193823; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QLMPykG6lfcrNa00ISi1soNyoXLxQUOTl5+omE2304A=;
 b=W7jo7chFTHqDjFQWbJjY/TctKnk5aLFMV5I2VcBMQ1RzFXFgS9k6cOnicxJzmfIK9X
 7LnW0QI/RWL0I2aqsQYdXnNbGuzRx7B38eN0gx7NkuxBXY6OqEO6AC2KyVGMrnw5mji9
 rbs70rKuvG25nUa6Xeg5SJGtp8CMwc2zq2p0E4urmMIr/Fc+PMNxpefRpWi6118rpJ95
 hmwQvxSflw89b3L2izuosITtpQeq603gWyi2gI/Zv9CYv89ism7hp93vKpdfKrJvqn2H
 wCdhcIGx94oOvX9E8SLV4azhaaM/pRhiqhBHHts+TLHZDrYXlbGzfOv6i4gtYxHHse5b
 FdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775589023; x=1776193823;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QLMPykG6lfcrNa00ISi1soNyoXLxQUOTl5+omE2304A=;
 b=eSgqHpWOXLjDPrzOr6Hife46NdfKOzYdBbtwIRxfH7zlodGr4aD4Q5ECSZv04wpKfx
 UFLTg2mOmdPffpK4IWB8Z/dpiZh1E3O763zPjGKIxu+eFs/UFOf3LhjFk7fc6oLko0E+
 ayURi8xX0AdLVVf1CNUs5mvfgmN0rhCviwEbbpThGTMnreOq2xAOyR2XeIH8h2j4UnqM
 5ZhucciCsXBb2dBAksH2O+CGH/BwBFHT/UUzX6lVLoWRIfB0mESdfot5kqgY+uGcr8VG
 XkF+K1IhfbEuvN8cFjL4sOrVT0ZB4RxHn+rGQehWZ4CVXeUY4WU0CrGycdEP50yAT1Pv
 ulvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPoWrXSVUKqebqBKbtkPyd78/s77Xvr6PKlbNtkR3+qbek9UrOYjmOmHZ97b3V1H3FBiaHGHuLsXsG@nongnu.org
X-Gm-Message-State: AOJu0YxXC9gtfQZAnZBGYp9Bkt43oDO1mZgQO61F69tvNsXWaagblv9G
 RYT+OALFgBgn1l4s5QxbmUEfTPoyITFc9/7sQKSoEDOu1wdoFtVsROWXrDSPLYfe6f0=
X-Gm-Gg: AeBDiesy+KuA387x/TgD13ZRJ2A8xDGZEBxy4AABai+QY39cKBRWZQWl1bQoWdwiCr0
 GNPgVuxf1VhoZPWSJ7gB4BkDJtqL4B65s21DYgUpYTuxKqEH9voMxlg8QQvxGyTfxmRPRcH3b74
 +SFmjKJUcco43w/nYZpwFKYLgnjcOhhb+5W8zAcd5k7dM+ZmuOMl04jNIQXfj8PdnnU6Qs4v9XD
 0rDZkjohSqF5leahwb8/cxPoqv7Vy//FJ4mXCQEOAQea/hc4uCqwjFdZ4ymk0E27bKPHb1pEZqo
 iGgB9gNVawRYyLzPhItXWedcppkEACsb57/uX9iasqlQakdVUxJmljoPYpTvaiU2CJP5yLJfVqm
 UyXMruojD4lHUv/Jcycq8ZGr2+nmz8SZwI7Dsn60Rl/xphwsc5UUXZyYDQ1Jub63ZlrMwpqEV21
 ZuDwsoC66mO0XkHQg3FMtD+pvmkEFsPEOb3k/NS1ME41QIa+K9FEqI5pQQGGGa3uq+pA==
X-Received: by 2002:a05:600c:1f96:b0:483:8062:b2f with SMTP id
 5b1f17b1804b1-488996e142bmr256112735e9.6.1775589022842; 
 Tue, 07 Apr 2026 12:10:22 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488a4b2e111sm309589695e9.1.2026.04.07.12.10.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 12:10:21 -0700 (PDT)
Message-ID: <546a4f8a-dae1-4f4a-a77f-6414fffb56ef@linaro.org>
Date: Tue, 7 Apr 2026 21:10:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 07/20] target/arm/tcg/translate-mve.c: make compilation
 unit common
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org
References: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
 <20260407022748.57629-8-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260407022748.57629-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 7/4/26 04:27, Pierrick Bouvier wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/meson.build | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D04FC28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 20:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyGD2-0004mX-Q0; Fri, 28 Mar 2025 16:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tyGD0-0004mA-My
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:21:42 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tyGCw-0002F0-C5
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:21:42 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3995ff6b066so1480571f8f.3
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 13:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743193293; x=1743798093; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y8MTxiVBC7VcrNXVy9r2qScI2l/j8PCSMb/f+kQMEVY=;
 b=DaKAbkTeC7E7OyTRxx6WbL+W2aGhuro34sD3NdLhdLbOnXiss042KrwbvHMyIMgSZp
 FlbMttRzqsrn0JPTJv3pQa6Wv3T1GMc9qknmJniiLrqDY6V6SyDz3306i+glMrLeAQQ8
 g2Mf380jkCfAPoEK+kb5P4Ux+MYYi5zsobwNxuIqBZPiihKoMrEUmCGbry+mSgzjvjtB
 z8mjLD2wHF5kLchAtMLmjXSXOOCWV+gVPwlsIfCdFx4iC7Qs1EL2afSy+bCkX0kUwiiB
 zZ1STe8dwmI27pX04HWgJWHFRwFgVnj/524+U7Tb9XE+ZRwHG9OuH+6/5uV63RVP/H2C
 iDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743193293; x=1743798093;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y8MTxiVBC7VcrNXVy9r2qScI2l/j8PCSMb/f+kQMEVY=;
 b=sbU56rt/KrdGXAVADv5I1FMXiHzF1UsL8nhONUpUI6Cl7bkP7eK/3vLJwKaN5NL1QI
 xjxZ9vOz1SW7Kz1M2ta6MbFxyf/aTRLVwQXCB8ui/D1Nztz009mmnuoFxjc3omYRjhFJ
 a2h1oN/PH17Aj8y1uAi7k7F4Y0RUz7RgjLa2FGtdgaPHXDBpqXfeRRbKcv6uCZoTt+Zv
 1NWuVKqMTzJU9xlyqnurxVAqBapXPZVWNg50vHF7BKbPSn07FmDDz6O+I7IkiuTG2zHB
 u9Ck5Vc+eWRPzpnPy5zSRHvNOOTQxJPwxJIqNwPbVv06TQR0MsllTchOphGkbrEVQoqW
 dcCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkaXpMkZzbp5hWqDVAslyv0Pc6aqLNARA0Wu492EPFs2A4FMYv6ToU7cfdHz0/Bvfqnboiyy+zvZFD@nongnu.org
X-Gm-Message-State: AOJu0YypCaiKlkymlj80+5S44b5So0z1UBd51sEaiFpZp50WOJ+/WFYp
 hJFReUVfTOonnDmJTT77sJeWK/URcPKSxureuQrdwC6EdtZSPKwmeRJpw099zgM=
X-Gm-Gg: ASbGncssLxK7hUrdgvC2sOsfLY+GNkmKQWSdzHgrld7IZg97AATQ34VwhVWzJO3OKn2
 U+BCbwTTrD33OdlaoMexO+x0P2DEDVq89FH6YbhIUupfX8QMcwCB2Api6NvFD1egUWVm3e1Vf6S
 5iVWI6l2u4UusPHdhEIQwpFHgyMQAd2hYzu5IYANc/bRnifIT6Lbq5VqcxpOFzO0e7xETn66FHU
 YYokHhNqQFa9cBu21FRabS7wO4qTjWVbvYAnh3eUN3FeLoW3B8/oBgwhi6PtVqicAUD2m2ZCPPj
 JNRLnMUL22KeAYG/qJJWnhV1k5eTgcmKkpTjBRe6Fx2yUzICYlD3tUp4XEkfDPcch1p8ACijEkk
 tPR22ePyP0kGE
X-Google-Smtp-Source: AGHT+IG/IU9Z5R/wwn609W1CWvq/SyYkzMpRXF6djkbrdRFvY046jUcrAmhf/xMVsRqX5dqq4ZhcdA==
X-Received: by 2002:a5d:47c8:0:b0:391:1806:e23f with SMTP id
 ffacd0b85a97d-39c120daed9mr323930f8f.17.1743193293193; 
 Fri, 28 Mar 2025 13:21:33 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8314b5e7sm83011405e9.35.2025.03.28.13.21.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 13:21:32 -0700 (PDT)
Message-ID: <2f2c78b2-a04e-4c00-90ea-93fbecf484f0@linaro.org>
Date: Fri, 28 Mar 2025 21:21:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] accel/tcg: Build translator.c twice
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250328200459.483089-1-richard.henderson@linaro.org>
 <20250328200459.483089-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250328200459.483089-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 28/3/25 21:04, Richard Henderson wrote:
> Drop some unnecessary includes.  Change the offsetof expressions
> to be based on CPUState instead of ArchCPU.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/translator.c | 14 ++++++--------
>   accel/tcg/meson.build  |  2 +-
>   2 files changed, 7 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



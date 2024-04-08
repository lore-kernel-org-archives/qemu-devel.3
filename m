Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F94DC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 16:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtsBw-0001eI-PL; Mon, 08 Apr 2024 12:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtsBt-0001dW-8A
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:49:53 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtsBr-0002XZ-2X
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:49:52 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6ed5109d924so649149b3a.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 09:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712594989; x=1713199789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mFUFUI2E189l30lWTN9/i+Fm4WvwTn2tzQWvrzz1xdE=;
 b=SWDKNO1CC1JO7nd2bXQISkYpRNzPr3z++bu1wjz4bC/sq6ZMBP/cJ7iDwCUoj/sAIt
 LqMafRqfgCbO1YsdYi7pl4M6kRpIjm9zQctxkPblsO5bg/XzfEZAx5pbv4tunfMoeOu9
 slRTYmUZrgEa31hCiCDSLckTyhPBCXMoN/gpL01ISXmiw3k8WWpNqXv3KaOvyapPdyPS
 LqHVmrbf2U7L1v4Qatuqhbqsc68o1j+I+6OvB0S4n1WywihQ/0lW2m4qNk5s7+U5aLGo
 y5WuV+5EVS7wOTe1Q57rXLiL6jiLm3P0le/W2ZqE/WluMR7mkgbYV1qbY38Gk1LcIh0f
 pG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712594989; x=1713199789;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mFUFUI2E189l30lWTN9/i+Fm4WvwTn2tzQWvrzz1xdE=;
 b=cKvQfFdelm9bfCIUgNpJcs/OGksDR9sNgU96Uz34QJBotOKTlTU9JdPwE3q12h+N9r
 ODmTMpvYF87+Eby0DguZl+H0TzAAp86P5Zuc7NLwOsiSRY0D46phVS5L4jxzFdJxirHW
 DuKKfpi9bAJM50os/24L9Id77yPHuQPDaLmMAdscjhs5POKazCz5SP/jMUUbAOKAsngp
 PBUr3LPe4aljGlvVJEV0xky5iXTKKSqJvn60pEus5moxOmip3DBGqeONJrRGoBRI+564
 Xw47T4g51jrUVAHfkcYRwyK+wXkxS03XLOvbymTsyHqttYgnbd7GTHmBbf8Liuqco9Mi
 TSLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz2/18FpYpLvH42llP88zQumU4oQ/DrtZwOxsBXGz803Qvw6HzAMJFNhXj/mxniNuvOf8EIbuUtBMY0CVUoAIxfQm6jo4=
X-Gm-Message-State: AOJu0Yy6vMdteAF4hBsxN32ejbEElJvMjF4MaHwkiVksMEwvj3yWgdUB
 8eiziyKwU9uxHuTTihHfZ7zL1SUCWnI7k+2k52Y/R6thFIlpQ1jq7AX8sBPXhkg=
X-Google-Smtp-Source: AGHT+IESqM7WSpf55iyqbvO1KLhMaKxc+e94uUA2wQnjIch5pg6zn4aohUw5lRqejNV44HRL88cfGA==
X-Received: by 2002:a05:6a20:9686:b0:1a7:57d9:9358 with SMTP id
 hp6-20020a056a20968600b001a757d99358mr3776595pzc.16.1712594989461; 
 Mon, 08 Apr 2024 09:49:49 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a170902dacc00b001e0fcf995easm7171258plx.202.2024.04.08.09.49.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 09:49:49 -0700 (PDT)
Message-ID: <764d67f5-e9f3-4690-a011-31261692d677@linaro.org>
Date: Mon, 8 Apr 2024 06:49:46 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/18] ramfb: move stubs out of stubs/
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20240408155330.522792-1-pbonzini@redhat.com>
 <20240408155330.522792-14-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240408155330.522792-14-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 4/8/24 05:53, Paolo Bonzini wrote:
> Since the ramfb stubs are needed exactly when the Kconfig symbols are not
> needed, move them to hw/display/ and compile them when ramfb.c is absent.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   stubs/ramfb.c => hw/display/ramfb-stubs.c | 0
>   hw/display/meson.build                    | 2 +-
>   stubs/meson.build                         | 1 -
>   3 files changed, 1 insertion(+), 2 deletions(-)
>   rename stubs/ramfb.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


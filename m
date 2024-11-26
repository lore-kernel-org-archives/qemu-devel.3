Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E186D3B98B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 13:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFvyR-0006P7-JJ; Tue, 26 Nov 2024 08:51:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFvyQ-0006IH-00
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:51:26 -0500
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFvyN-0003E5-Mm
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:51:25 -0500
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-296c184ed6bso3280456fac.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 05:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732629082; x=1733233882; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=79asTNGV4op9cvtOw27m9+qQ3OgMEMPYNb2Ud367Lic=;
 b=hR68q+k7LgDUojUr3wB53a9SeT+9YSHPWUZa/NxyAf6+ryZALQYVlBta9QMw3KcSKU
 mb8LVoXA7k3lsxWwZGHCjioLsMqV1+Bk7S5CyuPF32TkscjAuV/WVPFY5Lz3v3xwWrO/
 vpjRyxWNZWk5AxVPFRbofqzl8INVUp24XfSHRTjOwWTHBdLKzc5pNMGdpwbp72oK8TVn
 2Bo6Eo5owAdO1JZ9o6jfTYEwk0km8jlxOyokQejXeemYEgd/7bs37Ba1gCEffDYOK5Fa
 JkxyjFHuoisWEPMNCGULEuVL8wDor8wPGvncHtdyAeqRqEFKFsWNyCOtBKGtH/FBriGx
 MAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732629082; x=1733233882;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=79asTNGV4op9cvtOw27m9+qQ3OgMEMPYNb2Ud367Lic=;
 b=rkaRTXb/Zf5ygRE2DDP4ep3IZlXcZ53MmVVtKyhH+9Ghv78pKmpfcbxmb+Dx/b/NIz
 wxldA3TKePkckNYRL2X2O3fTJTxEcvHwZOwkz5qZsOMHmbf33fQzzNP1CnIDakAwx5oY
 54Ln3T4S90s9V7NN/Xf0DXimGtNqFEIhSbsDYPTbyuEuaz55hoVO9AitTgG4YQmhI8a7
 4GGA6ge/41paF73lL+D7Ijl0RXESz9hNhPN++LRf3HXzr6MbU3n9L0JaSSJoxm/H65Y2
 hZFKakrCne6bpwGkAV1gxJNSoa1JeonZ4vhh04Dq8flsRckAxQhwM0XUEHK+OrIKIDhR
 Py5w==
X-Gm-Message-State: AOJu0Yx6jKqbbkvXlf7aMqBefLxba+ZdyejVy66sKcTEofmTovlgQT4m
 RUQ4Z9EHHLeAsD9/JCLOLLn5QbguYT+McgoUgpYWL1q0OR4aNOIwV0YYmBNqNNRH2pQOG/bYleF
 E
X-Gm-Gg: ASbGncs0AGJ9QZYmFWqIB3yVcCmlS+cbnYAxv0ZcgAm7TKQMWGRM6ZTSNLAG/ObQ4qJ
 ejz5d9r7L2x/8eRRJUu/MSAKWBxWKU0IRwdsPHfRUByd3f0MxMB4p3P82tQBnfjXA8/GvglnxCz
 lQBfrKDb0+FN9QJRaAhfrLXqtkVqTtuEZEUxVXPMh6Amva4HFQFcY6p1hpyON2JJ361yvSxkaR6
 +2Q2ioTxPkYta5kBGo3TNRRahQPScYDIFb7LoGhx2DCZUaVPMvULoUzqkLrupvu7w==
X-Google-Smtp-Source: AGHT+IFmzKKeSIBp+35rT03TW50Y6N0lGY4WJTdNayWDygSp7H7GWQ4ytdYWT8vJE00RdY5HNZx9dA==
X-Received: by 2002:a05:6870:a2c2:b0:297:2376:9bdf with SMTP id
 586e51a60fabf-2972376d51dmr9096472fac.8.1732629082216; 
 Tue, 26 Nov 2024 05:51:22 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2971d56e689sm3932221fac.4.2024.11.26.05.51.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 05:51:21 -0800 (PST)
Message-ID: <91cb9886-9fb0-49a5-9cdb-73206a57c6f2@linaro.org>
Date: Tue, 26 Nov 2024 07:51:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] target/mips: Rename gen_move_low32() ->
 gen_move_low32_tl()
To: qemu-devel@nongnu.org
References: <20241126131546.66145-1-philmd@linaro.org>
 <20241126131546.66145-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241126131546.66145-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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

On 11/26/24 07:15, Philippe Mathieu-Daudé wrote:
> MIPS gen_move_low32() takes a target-specific TCGv argument.
> Rename it as gen_move_low32_tl() to clarify, like other TCG
> core helpers.
> 
> Mechanical change doing:
> 
>    $ sed -i -e 's/gen_move_low32/gen_move_low32_tl/' \
>       $(git grep -l gen_move_low32)
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


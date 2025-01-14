Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040B8E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 16:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXkFX-0002uQ-MF; Tue, 14 Jan 2025 11:58:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXkFR-0002qy-9j
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 11:58:37 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXkFP-000236-CJ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 11:58:37 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-385eed29d17so2842462f8f.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 08:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736873912; x=1737478712; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vMfgNFVqnyQxjCDBuP/yYydDyLjw9Uc5jVaxjl6VLlI=;
 b=vwMxwH5AJow9sqG1N1ovGq/kBf3/79IXx9LQAK5eGr6rI8DaukhiuyNNdDVZ5f0FrE
 kZTlMBp/V44qc3qduDIiJuqCRYmuzKsOAd19pIGeTvW7A6daHr1J/+StGo4yGt/BhRy2
 eKNQHkQJWk+41e9kJWLjwBqbfMy3euPbiJmAFOLHKNCRAVAj0wgYr28sxU6vjFc448Ch
 FFt7txywi3jxy+iF2KNgdifleQH03uyTY6K4ugG9hbQQTNibnLiFsQSPP5Yh20BOo+wl
 aBY8qgls25PWPf02k3Y5B2Y2697vKSBwvDGdUJdlXe+Zba87U3Uvn8gZyspl+vsjxsRf
 AYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736873912; x=1737478712;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vMfgNFVqnyQxjCDBuP/yYydDyLjw9Uc5jVaxjl6VLlI=;
 b=ufQzRldnmTVibRxACcLN+4tMUvqRgdXnt9znu8lNH3af2VbCLBw14x0TflpXsSeWS2
 6ITYp+uRO9pqShdsNDMYCucHFwBtZ2CPF/Hxqyb9bPF8h/BQGH2iINS6JH3dC8kmZ1mc
 Jp/BwkMQ9Nje9DQbzK2tnvfZfLE7ct4X3Mc5Keshj3xhpQMvQ43Sr6MBvdbnzXgAWlms
 Z5p/eJ6K/pM6JFUKOswZTJdD9emi5vt/M9tv+EdGNAwPMREe1GHgZHwhQkACunMn8zRJ
 zIV2DP+VsB7qJ0P5dwf9ufIwVf8QlSLx6n4fDe1FzTuu2wQIycwRQmP2C/dcSKe0u13u
 99Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIgR36KP5YVwJm/cW+yupaNVWRdvvIU4qPRhPQm9T1CbHvLxU5MZiRtL1T/huToDOEL9YThIhkXElo@nongnu.org
X-Gm-Message-State: AOJu0YyrcuAGocpEiGoKxm43Kqs17fsUspPrlCnVZNpV/4JMb70lgk8/
 2djGMJ5BdQZKTfqf24NPoBzBALfl33sE1TsImeyMSzp4pibGNgF8MsqHOC6VFYg=
X-Gm-Gg: ASbGncu3cjs3U0AXWsdVg3EM/qlVp7T5InV0brcBCzwSH72sQwJtpxS5py0ESA7h/ad
 Y2D61eosIISBSUwnn5D0KsM+661yKWfPHLnwQRZKZ+olvmGiSzXOSrS/cMtQWR6MrFOK9ukk4Hs
 hqAXGbzJ0x6VZcj4Yxud1FCvsnuNiF3C/l4EICqhiSxghEa2OaYeefcYegZN42O4psOO/VbbR8F
 WmK21cE2vsC4rHzRgM8g6ACVfgbPmUweispG9vcux5YCHn0NoWHS7QbyRePVeikzhS6Hnl/1vyH
 Tvfc1l6eSNgnSuL2MQAuevtW
X-Google-Smtp-Source: AGHT+IGBdQCcV9HF9zs7WhxlEV5M+Azpc56H5wIw6Hzz95JJBjtOOcSAMBD6aoNm/BAxu/+2nY6bjA==
X-Received: by 2002:a05:6000:712:b0:388:da10:ff13 with SMTP id
 ffacd0b85a97d-38a87306e8bmr24903442f8f.21.1736873912606; 
 Tue, 14 Jan 2025 08:58:32 -0800 (PST)
Received: from [192.168.69.151] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e383f8asm15155216f8f.29.2025.01.14.08.58.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 08:58:32 -0800 (PST)
Message-ID: <11a228a8-2d5c-4f80-89ae-b0f1ebecb271@linaro.org>
Date: Tue, 14 Jan 2025 17:58:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/81] tcg: Pass type and flags to tcg_target_op_def
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-28-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-28-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> Allow the backend to make constraint choices based on more parameters.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c                        | 4 ++--
>   tcg/aarch64/tcg-target.c.inc     | 3 ++-
>   tcg/arm/tcg-target.c.inc         | 3 ++-
>   tcg/i386/tcg-target.c.inc        | 3 ++-
>   tcg/loongarch64/tcg-target.c.inc | 3 ++-
>   tcg/mips/tcg-target.c.inc        | 3 ++-
>   tcg/ppc/tcg-target.c.inc         | 3 ++-
>   tcg/riscv/tcg-target.c.inc       | 3 ++-
>   tcg/s390x/tcg-target.c.inc       | 3 ++-
>   tcg/sparc64/tcg-target.c.inc     | 3 ++-
>   tcg/tci/tcg-target.c.inc         | 3 ++-
>   11 files changed, 22 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



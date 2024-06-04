Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677A5C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEVuP-0006JK-Ty; Tue, 04 Jun 2024 11:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEVuO-0006H5-Iq
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:17:08 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEVuM-0003fj-Qy
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:17:08 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a6302bdb54aso728059066b.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 08:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717514225; x=1718119025; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hM0WZDygfTvNIzIVig7EPsdZjnupaEdynxFwaNAYw4k=;
 b=Ivf8sK09JqpPszJkMtt6KRi2G6nVEapSLaBIhxFdzz+yn2M1oeRw7KFc8uC41YBL9X
 zHI8Tq9nyFLOO1wk7w8yjfkII2MCS9xZkJz6R0unttkO4VVkSq3vq1oASMlodIt3aiEF
 QpT6N0/wVulQzfBdX0QiMl0vXqK4hPY1v6y1q4mB3NhY1XxcG+gNwglRk4LPjn6fauos
 mEH2sRYfqBdQh1FTYjAy0llUCawpF0cA4Wzmfnp90LW0ihfg91WYSrfHYxbZcVbuokpS
 ix+tAD9AdVYZc4+5rl2iqXNuAR1HZDDXZFdMcpXYiffpypt0BFVeci41/pydjWLWkn5h
 iy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717514225; x=1718119025;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hM0WZDygfTvNIzIVig7EPsdZjnupaEdynxFwaNAYw4k=;
 b=M03KdwzhF2oijtq/QHkCxXfxu2ROKe0waD0AXJ0HX5nEO5bzAt5K8FlmNQQwrqNx5f
 i/LqoFH1gvtUn5nEAhRPfNoD4r1rt2qkM9zqiNvSViupCbVW4iAUeJAVpclNi/APSReV
 h8h8NZGSHkZnIDDmhLejZkUZcRLUR5W2WDhQx9jMiRSU5hhkYYU4qrnN8pxAyCfgLAW/
 eT6Nx+orxSoaX1A+kH/wewvkIiF/kTpwEqh4F4vCzSbGQ7m9Mjtesb4Te+JfIQkz5MCX
 9EUZcUQrHFLQis+2FQ62PGPIAQAgi+M4FV+re1Ab5ewsnoW8LKBznlNKXZmoN0TypKd+
 OZLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5dXv05MRAyBo5k+ibkyT9rC3hRIKXCMFQK8z3cpDdS5WtCawfM8wLXc9aD7rQhoL+EDLuNu+Ips24F2dMd61Q6ocziUU=
X-Gm-Message-State: AOJu0YwTWdbfDXjNmFucMsmara9V+rrt+Zqa94NfVBbdX81aunLIt1sk
 21bXk1+TgA5aRJs/5w6Cbxe6e14yZ/rUWVOfsOnOMRwUJ57zff5KVFSiNDsAi3c=
X-Google-Smtp-Source: AGHT+IFSG3qsHMPCiE5PZcN5SeCeIbu40mZP+pW4Wi94oFGERhW7wzvwyzwFhZGixfPEA1cLqwFyWg==
X-Received: by 2002:a17:906:408a:b0:a68:43a6:fbdf with SMTP id
 a640c23a62f3a-a6843a6febfmr706181166b.49.1717514224941; 
 Tue, 04 Jun 2024 08:17:04 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68b96fefd3sm496325966b.146.2024.06.04.08.17.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 08:17:04 -0700 (PDT)
Message-ID: <36f7fee8-3fc6-4094-ae60-352d2aaaf135@linaro.org>
Date: Tue, 4 Jun 2024 17:17:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] scripts/coverity-scan/COMPONENTS.md: Add crypto
 headers in host/include to the crypto component
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20240604145934.1230583-1-peter.maydell@linaro.org>
 <20240604145934.1230583-4-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240604145934.1230583-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

On 4/6/24 16:59, Peter Maydell wrote:
> host/include/*/host/crypto/ are relatively new headers; add them
> to the crypto component.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   scripts/coverity-scan/COMPONENTS.md | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>




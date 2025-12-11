Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8175D41D55
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 15:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTiRI-0002jz-Kp; Thu, 11 Dec 2025 10:18:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vTiRF-0002jL-LX
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:18:42 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vTiRE-0002go-7u
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:18:41 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42e2d02a3c9so146917f8f.3
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 07:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765466318; x=1766071118; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fhJ8e5w38AnuD06lyPkirTR1wBtOPe7ryXgBk91XOrg=;
 b=EKsuUIjTUY+ywzkGbhJT1CXbd+L635Hkjl5yFPuIyNTJvlLtIRp+9Fky3q2ev5fei0
 Xk127VrJId8ZIN38ighCnATusIqoZSL4r2ZzS9treSnDRlB4qckc9Ipy24OtI1ReqXuR
 54ftgzi6HGvJdHb981ZiX15rrQeqBMj8xeQuQ9pQxNEI3Eqt9GoYICmZDPJ3NpC4zied
 6+7hhwFS/C4jxRyek6Pfe5puBqWBDXHr77kdK6OJ0yf0E6D5sVfhoSiad2IDLe2gUF4h
 U0cHlw9NQhgefAtvGE2wjt3Q0tqOK74c99v/JeZcEWwbdLNZqc+jmCFzQlrfIYdyO18B
 ycYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765466318; x=1766071118;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fhJ8e5w38AnuD06lyPkirTR1wBtOPe7ryXgBk91XOrg=;
 b=kZuKsSjlmhsuocqhm9rF3K9Nijbs1MvVHqJoFgL88yWCDMVmwvyt0GHj76cp/oph63
 /msd1kRI0rc3fHH2sLI83sak2UYoOpXEnERHtwmhCoP++hGc8xeVbOrQo5HLSsmmfaV4
 v9PlR1vCBmNf/3ulDMNIrc1xQ43ddDCdJsbK8wsSSnhiUjPUdKDFww7JLf1w/diNT+NW
 AnhyZCB/XFdzGdrjhLBjzq8UJYBjShZQf1EaWP0x4Fylb9sSss5WCXWSyRgxFWAIoToR
 tKp+xtJgzE2Kp7RgadQwlg/QEArvoJdU7WTCx6MLbhY5f0wt7YdXYrUI+lcuZ9XIJP7g
 Cm8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCURP8QC1CoFkfPFBfHVmWFUP3w38pLxA34z6wOrGNhKcvNJF5Be5Pph4vyA5uqbO5CvrSWhdx7iIg+5@nongnu.org
X-Gm-Message-State: AOJu0YxZeb6tTqvq9ybbxOonR867m+yUGYrwOTn9SXHEf3n9AuRetIsc
 wW75Jwt13m+l1MOmDwyjQ3JGr8FPrfuiwoV3d9ACiMIb+XNsne/4Kb2dyacE5Zo4Vuxiga0+X/2
 kMSm834w=
X-Gm-Gg: AY/fxX6YvMTsdkj3Cla6ZQbeC1S9vC+kmj2+akHPeUN/bAvaDx2s++aPnPAcpF6iydv
 MEg/SajH0D9nVkdXsV5HcxY4QLprAijqSSv4RJUuzJ6YvilaC45FWii2jXoNGEetKmBikiTt0q0
 BsrynUQuvOnCer7AFOIiSd58AKtSCNWtctdKOphunNO0pKKhwiwOKA6htTwG8s+M8Xchy2mI6d3
 5TRyXTUfhuA+HaP394TsoCVhNXFDUMNVleSan/uHQkNXRXppWUz8geEunT3Kss1pTfomFB1+o2A
 VbJY0TUnn2oroDKu2ntDB8Pd83v3gqbnoAuVG6en3g2Y0wuTjW6kw0JXtEpXjV60Du0iAMSJBQ6
 2j9dUco+qHFVJ5iNWwIdM/JuTAlqZH5AdxBYgBfF8Zl/Fv6fAfY8q2U6V4//YjnHnOcaerLotwD
 BVKm6iU4CdCYFtwexq/qnTtqeTcl37UYf1Pu8h5GnhhUR06zbjMX3vvQ==
X-Google-Smtp-Source: AGHT+IFW8yyD50rMHB7LcSjVEW8hc/jNmcurEwCqp36H9qyLibKDc3koEEgE+zhy/rcTSsMTkyquLQ==
X-Received: by 2002:a05:6000:2c02:b0:42b:3a84:1ee1 with SMTP id
 ffacd0b85a97d-42fa39d1d17mr6918326f8f.18.1765466318167; 
 Thu, 11 Dec 2025 07:18:38 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b85feasm6591879f8f.27.2025.12.11.07.18.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 07:18:37 -0800 (PST)
Message-ID: <49968449-5363-42d8-b9ca-e77da8c81986@linaro.org>
Date: Thu, 11 Dec 2025 16:18:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 0/7] hw/arm/omap: Remove omap_badwidth_* functions
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20251210183700.3446237-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251210183700.3446237-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 10/12/25 19:36, Peter Maydell wrote:

> Peter Maydell (7):
>    hw/sd/omap_mmc: Remove omap_badwidth_* calls
>    hw/i2c/omap_i2c: Remove omap_badwidth_* calls
>    hw/gpio/omap_gpio: Remove omap_badwidth_* calls
>    hw/dma/omap_dma: Remove omap_badwidth_* calls
>    hw/arm/omap1: Remove omap_badwidth_read* calls
>    hw/arm/omap1: Remove omap_badwidth_write* calls
>    hw/arm/omap1: Remove omap_badwidth_* implementations
> 
>   include/hw/arm/omap.h |  10 ---
>   hw/arm/omap1.c        | 203 +++++++++++++++++++++---------------------
>   hw/dma/omap_dma.c     |   7 +-
>   hw/gpio/omap_gpio.c   |   7 +-
>   hw/i2c/omap_i2c.c     |   7 +-
>   hw/sd/omap_mmc.c      |   7 +-
>   6 files changed, 122 insertions(+), 119 deletions(-)

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



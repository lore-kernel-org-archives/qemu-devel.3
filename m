Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A80EC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 19:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY9Xd-0000aT-Hu; Wed, 15 Jan 2025 14:59:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY9Xc-0000a2-CG
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:59:04 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY9Xa-0004SG-E5
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:59:04 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso631285e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 11:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736971140; x=1737575940; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ige8eb1KOR1oJRiAo4BEyh0pqZYcGy6RVeJm8e+wsz8=;
 b=r3xMSbdyYa8p9SG1I7DKrQBvPpjvIksQWW7vRj26wKWw6FGslq7NoG01Rmhv84yFO0
 LK7jolZ6zCBglBjEV4++djwD3RdIek5S9o6Qc1wcyc0v+ZXxXDlV5oiLHGTRBIgsAxjG
 zSX+F4O8jPUmYokqiG5ra42tWvH+ektqN3Gv41KFb4+advJmZQjEKMap82RGXh7mpiHa
 TIVHSepdTZekMQ1s0gRHUx9snB0A/RXkfclNjEr8QnHJSfggV5wqR31ccERXloOHsAws
 5YzQ2z7s70WMjAqQL32YC21Ib1w6kMkoSbjs21St85ScKriVVMtiUo7eLoRUrCVk7K10
 imSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736971140; x=1737575940;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ige8eb1KOR1oJRiAo4BEyh0pqZYcGy6RVeJm8e+wsz8=;
 b=oIy3pnyVHjk+IPEFNN8tQndH5Q0oQFAVT7Hd2+oNUvkf/5hADM1gfCm7KgSTLoBf+z
 +gorqGVBBggz1blK2WCFw5Kh8F4J7e+1jvD433+Dvm+1q6TPcSECd5FYTzzZT4XCeIIV
 77rb4kG7YdbXDdubGp96q1r5ijz8gQjwKLNkxLaHvRTGGM8ka6Q/yY8hVive4ZdbXFR4
 2lJf8PYK2a+yToAwjfU63uhJcrjm1Tr9l196h2b+lRAwoORU/BuIAEl6s28U+BXZ/YEv
 7z3IfdBaiZ5Z4qavyiicK1o7CvqvBIMQK8yaacOAW9MmMwl1xnAaWOCTQ6R3MmPoZdYZ
 5jXg==
X-Gm-Message-State: AOJu0Yy+lUe46RbWeyi3lWS5P36Yd1KWkYXihrx0y5Wzy0iGA3Wc6+9k
 NMClqt7yvftZ8P0s1RKOb6wotdPDoBwOmuckBGi2Myn23Y/YbkxeFbILsklNanBm16YK2oi9BrV
 XpV0=
X-Gm-Gg: ASbGncsAHezAyVUiCCVTvwaj6t09N2mJbvGGA4owivn8g9OvB6mE2UQEsRsI+em77f0
 Ph/dz+h+35R0wuybAUhrJe+EaP40aqfC+d+XYBn8+K9Ps/THtZokHNUFzPwY9Occ5a/UbSlW/5U
 Lqp0sEhraMYzz2KkgoGBnfSzFyiIWW4wLcng5xjFeU/1erk3g5xlpywE0KbAngxJIzIMKY/f0Kp
 7wk5NWVI/e/ZwFapMUCANCQBuMV1xMFuYWDYYkC4fZP80Bjn4+ypb7Lzsd4S3UXjdfgeljKtNOf
 Lw13QuPndsUY2m1jCkYA6y1B
X-Google-Smtp-Source: AGHT+IGcmXrMohZDfQRGrPL3qgUfi3rjxJ1amhJ8E/QRWP8fgWeILaYMlxvHAYrsXY0BqEthNGH8LQ==
X-Received: by 2002:a05:600c:1da0:b0:434:a923:9310 with SMTP id
 5b1f17b1804b1-436e26a1b4amr297188235e9.15.1736971140369; 
 Wed, 15 Jan 2025 11:59:00 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74995c3sm34617975e9.1.2025.01.15.11.58.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 11:58:59 -0800 (PST)
Message-ID: <41e195c3-7dbd-4e39-aaeb-0a40119cc5b0@linaro.org>
Date: Wed, 15 Jan 2025 20:58:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] MAINTAINERS: Remove myself as Avocado Framework
 reviewer
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250106055024.70139-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250106055024.70139-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 6/1/25 06:50, Philippe Mathieu-Daudé wrote:
> While I was very enthusiastic when Avocado was presented to
> the QEMU community and pushed forward to have it integrated,
> time passed and I lost interest. Be honest, remove my R: tag
> to not give fake expectation I'd review patches related to
> Avocado anymore.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2101b512175..8d7044e91fa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4196,7 +4196,6 @@ F: tests/tcg/Makefile.target
>   Integration Testing with the Avocado framework
>   W: https://trello.com/b/6Qi1pxVn/avocado-qemu
>   R: Cleber Rosa <crosa@redhat.com>
> -R: Philippe Mathieu-Daudé <philmd@linaro.org>
>   R: Wainer dos Santos Moschetta <wainersm@redhat.com>
>   S: Odd Fixes
>   F: tests/avocado/

ping?


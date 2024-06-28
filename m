Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B30C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 18:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFx9-0007br-Os; Fri, 28 Jun 2024 14:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNFx8-0007WQ-Df
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 14:04:06 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNFx6-0003Lu-Lj
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 14:04:06 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f6fabe9da3so6113915ad.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 11:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719597843; x=1720202643; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=86OpSW2GnI7WXslcBv+zmT5zqfgk7GYN9g+W1COQTUw=;
 b=dwic8UdfWfcjNyVeJ+fV1mCJtBXeIa2f7ddH/MtO9v7cucxJPI47ZWH6g7FzWGqT7t
 rTUQLCyhsIBRN+Wzd5F1grpuDevl3tZHMsbyUs4pDkFjaVFNBV7QzYZ4OfF48RYM5U00
 +VCt+br5ZT8Vqxoiw6C8vHMrk/5p/Fqi/kseiqoMHgLThfJJ/v4k1s31md190czzN6wG
 de89FZXWjKXzsGxV4+JQFijkuG1zAUvxw45RL+e73vthVdECm6l/32C6eSWX4KzlmDwE
 1LvQwtj1AXHO9NShzGVbYyDEKuxUvRyhdGgVJ8z32xKww8aSEEaq9l5FwOy2BOzIeR/x
 VNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719597843; x=1720202643;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=86OpSW2GnI7WXslcBv+zmT5zqfgk7GYN9g+W1COQTUw=;
 b=Ysf8+B/U+IWaaFxz/fv5OzBLCCbSVp9jzikAqG1mfhfsd69+V2d3lT6tEd8kvaI5rL
 PPysVqbCoDegdeOy3B+RsUZTUkju1386TWYRulVBWgbfsmQiljsfMxlmsOxqSscvAhrG
 vbFIC91g7y6f6TXePHh8YbVyNdj3B5OWzIDxat444ZCxorYABOmXsZLwIdGgQYEDz9cT
 ZWn8MvVYoW77n9qC576UGa1gy89XxuPxtBtWP64MihHNNhey9KxKILmMTbYXRhbDt63Y
 v+2H8mOw0laoMuTVdhsTNpXb+OVCWFtJVWG6nlbXnF/40i5zJbw48jcyb1FtbfObiq3Z
 5N8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9+SPermsb9uldZDmFZvfzaWBa/HdDQNqAPdxR0cWJo6Jjd5D/Osl7oV4TIJP6edIcDV2QPbXeo6Xw4zsOITeol5cuj+4=
X-Gm-Message-State: AOJu0YxAyeP0yRGxBml41XcWSxTADC7CAUJWhldNH4okO33Y/HiC3n3C
 SACnLv4bkMTT8CYu35LrG9kIrjcEsmjTTVoNI6YhYzjZHV2Amw4V2NC8D7Qz9a9hQBmSfmN70kt
 Z
X-Google-Smtp-Source: AGHT+IEzqvETD8tTKwUZqmZONBcftp4pKijl2S89LYoC4XxBkog8ZPgPU56QKtNN1ZuKdTIBktEmTw==
X-Received: by 2002:a17:902:ced0:b0:1e0:bae4:48f9 with SMTP id
 d9443c01a7336-1fa23ee263dmr160620765ad.32.1719597843079; 
 Fri, 28 Jun 2024 11:04:03 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac10d14b5sm18684595ad.27.2024.06.28.11.04.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 11:04:02 -0700 (PDT)
Message-ID: <ce6328f3-96bb-4c21-9dea-74d67b96f357@linaro.org>
Date: Fri, 28 Jun 2024 11:04:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/23] tests/lcitool: fix debian-i686-cross toolchain
 prefix
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628124258.832466-1-alex.bennee@linaro.org>
 <20240628124258.832466-2-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240628124258.832466-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 6/28/24 05:42, Alex Bennée wrote:
> I guess we never noticed and tried to build with this cross image. Fix
> the toolchain prefix so we actually build 32 bit images.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   tests/docker/dockerfiles/debian-i686-cross.docker | 2 +-
>   tests/lcitool/refresh                             | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

OMG.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


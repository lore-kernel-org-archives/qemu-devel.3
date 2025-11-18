Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF0ACEE343
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 18:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQFP-000168-Sm; Tue, 18 Nov 2025 13:16:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQF8-0000zR-F9
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 13:15:59 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQF6-0007eS-M9
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 13:15:54 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so36053485e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 10:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763489751; x=1764094551; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gBa5JXyTqVQXilGJVv42TDvg6E6gJT7oMfgNb/Q2eT8=;
 b=ENS61EuUFBH6fJ76TMv7Tlaf7kit2q2+kjDd3RQQPfwDbJhr0P4gYhS0pLIC4rdcq7
 DJ6d0R59fCjDrsGQatVfaYXGPJPSsLA8B+buiMJ88StZeMy3juBkOyf3MbTBI3a7i0sP
 f0yCb87zzgPSjIoV/4iABG3EmpCJW8bBysZyD2DV26Mdk3pRoc0q8X9KhfTtxycWQDih
 7XtzHdyJab+lFoggQrQ4eb90hjDzBbhv+0L7OHxsbJ2CkC8HyohB/Iku+z0VsY3+ne6Z
 wZ5qEUEknfRDL1uNXwIFMLUg97wjCHX8pR7rlYdblk2e+JWvbeUeUHWKDX8E/gtaOvpX
 Bypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489751; x=1764094551;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gBa5JXyTqVQXilGJVv42TDvg6E6gJT7oMfgNb/Q2eT8=;
 b=ROxXSxCIR+l283Cah61aRHlr+r+eLLluErvWgEAq5l0XDYM325h35kNGwt583SX+XQ
 /sYVlTlm7AtFs9HsqLEPqukiP/76L0XiKDE7wWSAYZE7O2aXdZ4dl8M/y05CmOzqVMm9
 OysFM5bgAJBaiQDJ4+KTd00IBD4h6TE5nHlQMeicOLlhAIgaE4jWQSRWW8ubDLBoolep
 Rd8akOf+vrV+pMCDmQFUTgxU3gX1Bcyp+5NAl1E8/CEfRZlxH74CTe0wIrtQ+7vfblTC
 B3O/djWBdzH65NHdOOl1PlyZ9IZOtlqSmQO5Kiii40+dPrHZhJrgYQW6ndPH8tYFY0WG
 OHHA==
X-Gm-Message-State: AOJu0YzmpiP78l8USySoDgIlycMfTWcZdLseOYaAKgOcIRVknnBt2Q/Z
 x/VrlR/CeItAwGOvjAEot/J2cTbqMvAFbiwqbbqpyPab4cV397jqhcOgB0mr+xC1AvoxK1hGJhB
 ORmrbuaSkZw==
X-Gm-Gg: ASbGnctDQSjKCje2JouEDp6P7HZG6mu85zz+VECJfqLECwyPTdsoHVtVg8ZhyaUsnTR
 MXgneJoiwFbCKqf1VWFprH8B3+8YUAf3kvAUFoSNol8xPwIY6ZksXeK7k5e6pjUGz6KALT2IfUt
 SxZeqSGkRAKtqn7peNgUe0kToOs1NinRVdbNiBgS1iLkAyyzpigOaZvDBJuy2ZJT8rWXWpWyoLc
 mKbz2DvkgPUXAJMQIYYhP2qflcNVN9YaKSxAgMMtTsNSC7q5Nvi9qqaipjSuKN3PegklScycKqi
 y7wzg0FetrgL3363olV991q0ZPFOeza2MrCuNaE/+vr+SFPJhsDcKDTz9zNMFDth0X8Wmg5bL8Z
 AqHeyx8yavU60LKFHyeTZ/VDFmZB97a+Wz048grScoPum4TLDCS2RfnAwntyd1VE+c5Qo7JU737
 NovEmsOdvm8PxJ1lzPjtJ1pmipsbsdiUrQV4QJsjxl0OQiUgLjTIL9UQ==
X-Google-Smtp-Source: AGHT+IEKB9J6LNyGCqQW8ICvXZlqTObg8y77ZHu+u6PCXEOkS49KojFdDtx14grVnBYvosC+VIi5lA==
X-Received: by 2002:a05:600c:3109:b0:477:af74:ed64 with SMTP id
 5b1f17b1804b1-477af74efd9mr13663175e9.27.1763489750754; 
 Tue, 18 Nov 2025 10:15:50 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b1012a92sm3489675e9.4.2025.11.18.10.15.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 10:15:50 -0800 (PST)
Message-ID: <48254249-f4ac-49d7-8bd2-c98ee65476a1@linaro.org>
Date: Tue, 18 Nov 2025 19:15:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2] buildsys: Remove dead 'mips' entry in
 supported_cpus[] array
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20251117114200.60917-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251117114200.60917-1-philmd@linaro.org>
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

On 17/11/25 12:42, Philippe Mathieu-Daudé wrote:
> Remove 'mips' from supported_cpus[], forgotten in commit
> 269ffaabc84 ("buildsys: Remove support for 32-bit MIPS hosts").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Queued, thanks.


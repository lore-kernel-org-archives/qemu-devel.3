Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95186606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UYfWKq0J
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoQ2-0002tc-JR; Fri, 30 Oct 2026 11:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMoPz-0002bo-1B
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:21:23 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMoPx-0000np-FG
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:21:22 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6f74f6b46abso478357eaf.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793373680; x=1793978480; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=J0i8xu9thU+b/E7SW7OYrVTonijJ1tFdqXB4Tn48XYs=;
 b=UYfWKq0JMZKmj3XtmFZHNCVeLhyarFhEDcCHv6FbyCRX8olsDiiUvHGiHx00m/UaEd
 S41aZh3qVLdrNTy30Xs/BG72yputqbJ7gvPaYYTcdbfbDE2UV5JWxtTbVsOdDVErLYB0
 lGBZOXmKvzX3GO8p0oNjvfvx0nHppqJ5dOyZOZ6bE66jzGrRzsjA8C+S8dn1BLw5Inek
 MgdAZu/PpHyau8UI5NoNDCP/7fLESlsrfGjF/GWeVzJqEi4PWKY7jJnhL+9RqWYxpLh8
 lprT7KaqC3mz4/XX6+LBmkPK9/oESCd5ebKRNzcbI9Do5VYeuIRq04r3ClckPjwfougr
 SWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793373680; x=1793978480;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J0i8xu9thU+b/E7SW7OYrVTonijJ1tFdqXB4Tn48XYs=;
 b=u1mNJTGyF8tlKbe559+pw+w/Eud0YJxL5OdUKFHA/JPnObuNWVKAveSZDEeKpqT2HW
 QeGAOo2jjHPYWK1W6ydecBflgUZF+oTa9l7W5sAbXlk/N2o3nK8pTjAQvu6Jc1/zQdPU
 EQ3Wwern0Dt5ogMzP2sx+pRiC7njq5aB9M9tnIToom9rAhtqLFzkASEI3uO/iOjmxyEl
 epeSUfn+bxemjjo7Nwdlry7QhLa/WqdkWl4w3dIkRiXOTK3sDbjaKZLk/nVbGdgD6GoZ
 vDK7FsU3s2KtPPRfXPK1ZooJgMFroCLrAFQuC/U7AUzGqtS7uD1F4C1KGVNCVRGSt2FB
 U3XA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9iFsVNzldU5SkTnZZCLQdXG4+GT0AqWdjmsyrHdsDpkFQPN2VUbUnGF31likjC/Rz5jMWb2tY0VZC@nongnu.org
X-Gm-Message-State: AFq9FYI14OAwh3pJOmdsj6bsKCHWM/Ushoctws1m7f47eMtp4iE0QPuT
 7+LuYv58g02dmIilJS9JuXWevBOMUEXUGtzwT3nIhxsLBT/zMh6VtJoclIsppHdCR4Q=
X-Gm-Gg: AYBFou2FZcN/MNTCYgd5EydrNNVAix0DbZQZU7T8F10y0zsqgAYQfOJ2mLLqoiLHyg4
 REdtbEtwz8mPwLgOAdoaLfP+UPWBjXz55TXPrAR3CN5rQ7dmllgThpiTjG3D3AP4cxJjLZVkm4c
 4S8YTGkPXnxH/SQMn+q0toW+wvmNvQJSppOOhtmOEqNaZgdY9VFa2p3Ue2CocBDQuF6XK+j/8Zt
 K3db3laE+g5VvkSZLdvaiyi47qgsSUumKMguDgKLvcPt+jFqV+/M7nrw/IO7//HobNcDJ74RfGq
 /jJrYazadrEmzfqMYcaWuCxwinYP5qnx7jkPHz90hhyDNScoaU5LIG0yuo38BN2hPrtgcH+5bYD
 yQNcFvbpylvIg64h1RIxWRq6AL18Zz46OkjtfXZ5XthazQD++/slKFgPh1MYJ/KwDQYDX+jqVdb
 cGbCLF6gGlJ0LyaE7zJJ7OD7ssx85A0+9vXflEQGu1MR8BBoMcxqjXJ7zCIvkXPoCd3eLvn4xPo
 sHH5glwdUBQIz4Tqn/60JnbKYT4igYiMTJzPY6wiMKLUW5TUj/4+NDThTxeCT+OOeXuI7NuQSZ9
 e4TKDZ1jLR2A5iZ5o+19TWWKERF0Z6hVA2ILszzXrMtC
X-Received: by 2002:a05:6820:1396:b0:6f9:91c9:4e44 with SMTP id
 006d021491bc7-714f2885ca1mr1473276eaf.21.1793373679819; 
 Fri, 30 Oct 2026 08:21:19 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-714f2a818b9sm2185489eaf.1.2026.10.30.08.21.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 08:21:19 -0700 (PDT)
Message-ID: <f20d9199-cabd-42a4-b3f6-e4d79d1d8edb@linaro.org>
Date: Fri, 30 Oct 2026 10:21:16 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] tests/tcg: Add minimal TAP helper header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo
 <arikalo@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20261030145218.58385-1-philmd@oss.qualcomm.com>
 <20261030145218.58385-2-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261030145218.58385-2-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 09:52, Philippe Mathieu-Daudé wrote:
> Add a small header to report test results using the Test Anything
> Protocol, which meson parses when the test declares the 'tap'
> protocol:
> 
>   - TAP_START() prints the TAP version line.
>   - tap_report() prints one numbered "ok" / "not ok" line, with a
>     printf-style description.
>   - TAP_CHECK() reports a condition, using its text as description.
>   - tap_assert() is a non-fatal assert: it prints a '# FAIL' TAP
>     diagnostic and counts the failure in tap_assert_failures, for
>     tests grouping several asserts into a single reported result.
>   - tap_done() prints the plan and returns the exit status for main().
> 
> The counters are static, so each test must be a single translation
> unit.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   MAINTAINERS             |  1 +
>   tests/tcg/include/tap.h | 60 +++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 61 insertions(+)
>   create mode 100644 tests/tcg/include/tap.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


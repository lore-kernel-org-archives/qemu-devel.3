Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67932C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 15:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbhzq-0007hN-Jj; Sat, 25 Jan 2025 10:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbhzp-0007h1-2g
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:22:53 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbhzn-0003b0-HQ
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:22:52 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21631789fcdso55482985ad.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 07:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737818569; x=1738423369; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D4BSkQGBBkAkMLNgmh6Tm1IL9WXjGJ2/clHmzQBGQjY=;
 b=nfyPs8tVWAeIXaioqJhNsPl1+EcOccQszqCOzpHr9/NWJwskhYUfpZAKqULaKkSePv
 FxTCLS3fMsMv0XLBtl2DLVBZQKvZe/DOqAPoyJCsJ7rGEbVRS8JLV/ZGDXc038LzH2PX
 6NEMSRDRENDvaamI/S+qT9A0+tyQUe/ti7s9pTI7zC/trhBkfxhHhLsyOb4bA9SOnXo0
 d+2fnosZ2Y2jc4s8l9ls/QghS9HBHZgL6FfPjD5WiWmNKHnJ7OXdoTWqmEwwC7PeLf1t
 Z2R1aorm00RmnF/ej9TnvS1dqIFzMO2FytxMph35fg2URy/jfh8g0I244P1AUAGqab4i
 +5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737818569; x=1738423369;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D4BSkQGBBkAkMLNgmh6Tm1IL9WXjGJ2/clHmzQBGQjY=;
 b=wD2+OgDEfdqsk6wTO0VwrtqZzdSpu4P0jofHtdOobK+qX2aKbOjtha5+xtv6224HJb
 wD8jB8l/igk3kkYeN+5euQ82d7rk8zgKaBsan3Kh/5cDrtI6aWeDXOERGIUXaeybQDxJ
 gl5Z9m0+DX7t5vpXFpShcwMcnO3mTNQwM59Iw/yA1mTzMw7XzvVoKXgL2qCY1f1Al+tk
 JCTa3HAEVs1lrEJgBsVBk68LdmEiQ/QaldW5dtFaMotV8Chx2bNcet2S7/3HKjvVd8TN
 hJIuRpdQ5m496yJ2GlRKloryoWVmJ5iC4Va+4ODtpyI+a3RQsNoC8x21xQXL9j41926H
 p1GQ==
X-Gm-Message-State: AOJu0YytflEFpZ/KRzOT4qok4nLOr7PyOlDmJ99KYAJ2kmTPAGJ0WLix
 NVDt0lrskz/+o9EqvKhFXdO7c945q9qHxsKFEziZc/E12qgjOBRx04QUHah8Crs0ihwoDqI/ELR
 G
X-Gm-Gg: ASbGncsVFlxYv6VxlhZkFTgBHvKib3I9az3giMYbBhCDaai3a3YqIxU6uHp5VDgM/Fb
 e6w0xxITzzByZXamgLJQL6+4MC6t+bkMV0YmtBktkEuGgStq23IL8I4LNha0HYDzynYgm1/CRZz
 tWNFDsGgYY4xyuXLZITEv7jhGGURdIuJ/DVFNeTZhFLoqLyEpVjrpFTdX2UhYG1/FtU1/ALOOw4
 uTv/stQZiencw+wsTi2pfPjvRlBXzxq2OefjUY7nm0z72yG5pNOFyt5t4tK35LJXXuvDxDOPjou
 T8Qcryi13/IZIOT9Ct+sgQ==
X-Google-Smtp-Source: AGHT+IHT7QukuWwEmrF4syiY+WDR8ENFfsvAWKMRyAO534YBHZdS+Kt3tRzcYhZPBrHOQuDOW3UlDQ==
X-Received: by 2002:a17:903:2c5:b0:215:7287:67bb with SMTP id
 d9443c01a7336-21d99236461mr193258705ad.0.1737818569485; 
 Sat, 25 Jan 2025 07:22:49 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da41415e9sm33626225ad.116.2025.01.25.07.22.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 07:22:49 -0800 (PST)
Message-ID: <8455d306-a028-4bb4-89c3-2c7148e93644@linaro.org>
Date: Sat, 25 Jan 2025 07:22:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/76] target/arm: Use fp_status_f16_a64 in AArch64-only
 helpers
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-16-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-16-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 1/24/25 08:27, Peter Maydell wrote:
> We directly use fp_status_f16 in a handful of helpers that are
> AArch64-specific; switch to fp_status_f16_a64 for these.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/sme_helper.c | 4 ++--
>   target/arm/tcg/vec_helper.c | 8 ++++----
>   2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


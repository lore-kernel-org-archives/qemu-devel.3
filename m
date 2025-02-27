Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E2FC197BF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 22:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnm8L-0006uZ-DU; Thu, 27 Feb 2025 17:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnm8J-0006uG-Hz
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 17:13:31 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnm8F-0001Ad-5g
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 17:13:31 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-390df942558so1085319f8f.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 14:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740694405; x=1741299205; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EKjt7OaVeFCo/1mU93GE+u5feO/byVl6qntu/LV2L5w=;
 b=ahClPwkXjgmeAnJhIOKwmCijlmI5Nexg5AXRBQOJmVKjtX+fc92Y7kEnXubmx6jwtC
 k/t8bDi83BBcIMbGiJvGd5MUeY23tOw3wKUVLN2fBYWtiM2OmMCfpS56q4m9O4xkeuvP
 tSWDi5kHgUwpkhy4rcrNM7m84u9+aSS67kv736GTGap6D2F4GZhCTMLDw+GPkBvI+Log
 80R6rD5bpFmV//3N1nnJtIX5837t/VHZJlil8Do2sb6fNlSREcHeEiBj2OjPkfpw8fgB
 A+O336ZASD2kQXsTVVCW9D9gvixJ/Z9Uq4DNxQ2ywd7yeXOABf+D31tVR8Api/8+OsbM
 WKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740694405; x=1741299205;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EKjt7OaVeFCo/1mU93GE+u5feO/byVl6qntu/LV2L5w=;
 b=aOjKMZG9MAO36ozpK2oNoeb9fGBIKGKSpvfRhzczcWfu20kNr/8VTXdhgAmckaJJAC
 21rpb0YLdQ6P87pZ1PLgfFo0qG8/lcR3Wm3E6fSobgTya4RvjQeD2VvncfWW5Kq5CS39
 HUJCGDNaVk626/jCHKnD0kPnUHVToscZCNtYGrZnMimS1ifOuLaGHqRWILh5sAlHXH8M
 DdXBYEAFh+MK0rCuCzYe7Azf5neNA/H0ba9WysDiPtneoZBM25MLPhsKL91UM6DOYxef
 3gLPVlhxo69+NbOLdsgdA8NOFdja6u2Jq5mku3cLydhb4ygx9gNdiN/vIx366/IK/Xm9
 K2Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJiIBy7XUmeLvPNnqgG3hAnUuEbgVXyTJLnvrgSraurK+3CybPyZydChOl1gvaGdrWF0HyFwHjEC5e@nongnu.org
X-Gm-Message-State: AOJu0YzpUVsEe/+MjW/ZpFD1GaVVD5QCzwtRRgNvPVT05dOQuy8RD+0+
 yZcuQmUbbOsfrhX0C2GXvXlDFdS/dW91HlRK2usT9paXrxHmR7zd0uOCD9JOWvtS+RjbiVF+47Y
 Ul9Aqyw==
X-Gm-Gg: ASbGncuPBZOrYXGr94ucobCc1Y6LcFYgReTIPogX1n40zdaAVjy7PfcwLDTm6j3R+GH
 Rx02dpwc7xKHjm6d11TZ/WcGzX7x9dLQWJx+Qi7csEsqWAIYN0xvfV4+Hmkp3OcWHt14Fym2s4z
 hSzC+18pv6hXc0MCIVl/nWoEMRgVNOJWcYWH1/aJ2TPs5Fg1wUHQH7CFpT6mb3dJ0aFSB4Z+D5C
 pWw+X2uHH7/Z47mQ0zWrybycD60P3gpTPHXjX4r9QnR0xUeIuIxsw9hQ5r+InxHBg+ydXuQfaoh
 MpxO10P/jhx09uWg+sIeUZOL7BEIVoCCxzCx9vQSyprfvzipkL9ElnSKhzzElZI7/7WS4Q==
X-Google-Smtp-Source: AGHT+IG2JiV/h/j3MG+kyJpcqY64QdPNgtOEQoRyhJlpEirListzQ64z+ey9E/7vQiGRW5fBhFBcaw==
X-Received: by 2002:a5d:6d0d:0:b0:38f:39e5:6b5d with SMTP id
 ffacd0b85a97d-390eca5309dmr719346f8f.44.1740694404873; 
 Thu, 27 Feb 2025 14:13:24 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a66c9sm3261277f8f.33.2025.02.27.14.13.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 14:13:23 -0800 (PST)
Message-ID: <de97c1c5-b27e-4997-8009-4b9ff4984cfc@linaro.org>
Date: Thu, 27 Feb 2025 23:13:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 034/162] tcg: Convert mul to TCGOutOpBinary
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-35-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-35-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 17/2/25 00:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c                        |  6 ++-
>   tcg/aarch64/tcg-target.c.inc     | 18 ++++---
>   tcg/arm/tcg-target.c.inc         | 23 ++++----
>   tcg/i386/tcg-target.c.inc        | 47 +++++++++-------
>   tcg/loongarch64/tcg-target.c.inc | 24 +++++----
>   tcg/mips/tcg-target.c.inc        | 43 +++++++++------
>   tcg/ppc/tcg-target.c.inc         | 42 +++++++--------
>   tcg/riscv/tcg-target.c.inc       | 21 ++++----
>   tcg/s390x/tcg-target.c.inc       | 92 ++++++++++++++++++--------------
>   tcg/sparc64/tcg-target.c.inc     | 28 +++++++---
>   tcg/tci/tcg-target.c.inc         | 14 +++--
>   11 files changed, 210 insertions(+), 148 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



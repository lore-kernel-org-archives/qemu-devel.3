Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F070C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 16:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYpIo-0001nw-I4; Fri, 17 Jan 2025 11:34:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYpIm-0001nV-UW
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:34:32 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYpIk-00075k-KE
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:34:32 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-436249df846so15666765e9.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 08:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737131668; x=1737736468; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NJbxbifsPoPkmiy+DwSNRXcXtmQwysecWo9Wj6j4Lag=;
 b=xPRYAfOqPh9VC1mmYdfWrclwJ4MW4TjZNQFWE0soywsJ05AQgszWaiBeqc0gXBkd8V
 WKOKC1TdVsE0cbVoa6v8rjB9NGf4TJQQ5e9j+4LRWqrLidyzgdohz2nMB0AYiHzhrg4y
 DuDutTNaYsgF7zsoyGqvbZrm0WJ1DQ7RK7DwGMhivqxTlQwO4BVaJEICmMzRPU92U2Nk
 yZ+5cYm0k33v3vGY4YH65E7s4wxMcRGfK4sYJOARg2NwPeejCznP/rhXf2LmyzjRqslN
 f73yul+hHwGxNjkKvMOPhIpEB9ChMMBEdSOl/nXNZ1F5bj9fxcjIAaqoY+pMjwcPXqbz
 gMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737131668; x=1737736468;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NJbxbifsPoPkmiy+DwSNRXcXtmQwysecWo9Wj6j4Lag=;
 b=XdAx8+4KGeluHy5iVVt5TjYQpNpQvJ0p8mNXfnZAJ3stsK5DGOkLIsTSBnAcfzpCXD
 dGk8CD/7Y1jDFbjT+DL6iEkhgfB5wZsMdXHFK8dZEZjx1bH2McqPQ4U9hRBvy0Qxx3oF
 iTdEOk5P6qU4u2gcGQLT7nKUhWuxCoaxAafreyhOrrwcku9QJtMPDsN2ERnFLVWj9ZSy
 xu8L6CGBVXt6q1VVenv1X5hOUZHasxT7SPCALgI5ggLgrRPHrraQn5PGyxh53W19MBp8
 nkD9KMQwHHAEGjRhxQQ/8bXoa70k9HO+d/iIgP6Nv/creXjuDcI2hd7L6/VIehwjpUn1
 MsGw==
X-Gm-Message-State: AOJu0YzjepdK6N9fKufPXm26TP3sxBEOTRktpW3hcvwJugZ1FxJEafnN
 nZgbW7cqBbnRhntz+GVfUsZzZFVKZuMbgp/71CR6vo77esOb3ihdKgLhK7wEhsGRlZiDyjsRIO2
 FFTA=
X-Gm-Gg: ASbGncv+mKS/I0g80cZmiu8LsPsyb5bRfpBIxo9BnFYd5wxraUQ9eOtbzwBitGeNjvS
 qonVYcW4f3GkZc/FP0VORMd0uFxoCFczHGkpEz6bZWBGQQrm7QKMCd3tzz6mEAwohnHvhjHbtFu
 76PHy9LyapcHorRiZF3PNv69E6BMUyVwJVQO6P0K61Y+yiCJs1SY3SOxShfbT2PyYBJGLJFW7AH
 dGjUzjoU8M9IEj3DVIowRyFvQBX+7C3kcPetZYuO9l5Z8A9UcLrqOf+JhPF7ciEhsgp1SrmUCx6
 qaC9z9k8um6CHq/zjHEkr8Gn
X-Google-Smtp-Source: AGHT+IGeBC1L4sxIGI4JUJas0QG8nV8YqoST7vrNQjU0yJlWO64hwZsauajUGjj3+ETtUsw9RIueBw==
X-Received: by 2002:a05:600c:1f8e:b0:434:f82b:c5e6 with SMTP id
 5b1f17b1804b1-438913c7ed2mr28691825e9.1.1737131668458; 
 Fri, 17 Jan 2025 08:34:28 -0800 (PST)
Received: from [192.168.69.151] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43890417a76sm37905685e9.16.2025.01.17.08.34.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 08:34:26 -0800 (PST)
Message-ID: <6b7da4ca-eafc-4a02-86e8-6de59628ccfc@linaro.org>
Date: Fri, 17 Jan 2025 17:34:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] target/arm: Constify lot of helpers taking
 CPUARMState argument
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250116230435.87580-1-philmd@linaro.org>
 <20250116230435.87580-3-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250116230435.87580-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 17/1/25 00:04, Philippe Mathieu-Daudé wrote:
> When methods don't modify the CPUARMState* argument,
> we can mark it const. This allow enforcing places where
> the CPU env shouldn't be modified at all,
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> I went via the "modify one and fix until it builds" path,
> and the result seemed trivial enough, but can try to split
> if requested.

Re-reading me again, this sounds like a random patch, which isn't :)

What I meant is I made const the functions that I want to use
with a Const CPUState*, then I built and fixed the call sites.

> ---
>   target/arm/cpu-features.h |  2 +-
>   target/arm/cpu.h          | 71 ++++++++++++++++++++-------------------
>   target/arm/internals.h    | 10 +++---
>   target/arm/helper.c       | 25 +++++++-------
>   target/arm/ptw.c          |  2 +-
>   target/arm/tcg/m_helper.c |  8 ++---
>   target/arm/vfp_helper.c   |  6 ++--
>   7 files changed, 63 insertions(+), 61 deletions(-)




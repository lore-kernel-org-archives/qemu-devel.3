Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B6FE77198
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 22:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUvVA-0001qr-VA; Mon, 06 Jan 2025 17:23:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUvV7-0001pp-2A
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 17:23:09 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUvV5-00014j-8J
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 17:23:08 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3862d161947so7085355f8f.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 14:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736202185; x=1736806985; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=awi54OXqAZQUMkMH+e2ACY0rcYOKRE/qXOz5jIV7t0w=;
 b=tI4/iS8HWowM704L6t/rypdHEtUAtc8pbphQnOImpVMUHb+R+xELnb48qc3Jfdvctx
 0ZFWHV1TVgJRc6YwjWM3MV48Mb0aD2mr5X4YR8AWZRHQsb9N9NIPRAEREdsFTmyzE90m
 Ll3ZrtBXFIKEnCu+a9DFjOQ30BmXKQU6GIg+DJIn8QSXqs1JkEDCHstbS9mZEHViCngc
 TnWDCtC8+tB9tF59SZMwsY4d9aB/8wMVOx6mQ4UN3usA4JFUDF3t8gFqHJpFymyp793T
 7Wt+13JBcQpHWL26fuV//5kezlU09X0Rdjld3FSrXzjZ96x+I4ZqrQ3Yl2Nd0MijvZpH
 N7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736202185; x=1736806985;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=awi54OXqAZQUMkMH+e2ACY0rcYOKRE/qXOz5jIV7t0w=;
 b=Yux7JsPqs06t27U2LlqLYTAW7um93I2pISFgSuyDlwRr922+GcctCVQuIS6BtvkqXq
 8xYxDMRRQiW8Vs93hhtIQKKdFzeHsNfNSEVxyK0kGqNYCNF0k9Ufqr7QrILpiVv5Zayt
 iyWbQNXkl7v+JDNGT7FuBVBDabXlyZwoz49eEUyCdDWVnKog8mqBlL683LbHQhbcZ6vy
 gKHbhzTC5Fai3OHwj84aN7Xs63wJ5+wgdFjp+nz90tFCbuIdD3agjzZAD/T9sCo1VgF1
 0KBweyWA1V5s2A/0Umb/YwSTXsG0leYitP7sfG5OKdirlErwTu+phlXgXN0clsHYCuLM
 i3wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmAloWA4Sb44mW/R+nSHvsDJnfNcisX8e/7kNnfNpftdSDo1SyeN1+cTNSryBChd04Hu94OJsUGRve@nongnu.org
X-Gm-Message-State: AOJu0YzbF2pTJvdaMevZ9N1Vu08Bs3+5V+MFc1mXIPS1OWvofcHIb3AD
 rR+cCJHJypdxjA3duInSi06HiwJN8q2KvvJZGqQeIzxME0zxg/5yyGHegrlJxIE=
X-Gm-Gg: ASbGncsp1BCTaeWUJYu22xcMFfJUXAZLCC7FwToM75JKmDnQa54nZc/8lSs+TII/JLS
 8cnyictbTCmp0ODfcnRbAcjKFpz8hUpq5I2pJw+YzJ7kyUaxEy1Gk5cFL9A7T6weJR/vMr6weGh
 DAK7gwyI6diZ2euw3QGNYAgH8MGTprJgJCQdyyFnGpoE7d1BgkQHTNlXC5dhH2I0HII3cnKXz6t
 ghtPre077UiY0cDbmVuuaxrQ4yjkexE+/ypOERrteUOCmoVj/iMqYAzG5SpLijorc2ZMlrGaF1f
 9FwlFXxkAxsvk+RYxqvBQVqA
X-Google-Smtp-Source: AGHT+IHPs1JE8fQZedNIMwsz/5Hqk7qQHDScbzCp6mK7rH0iaqandU5jX8n5uJYoq0af4zCsSvS4PQ==
X-Received: by 2002:a5d:6484:0:b0:388:cacf:24c1 with SMTP id
 ffacd0b85a97d-38a223ff10bmr50812068f8f.58.1736202185034; 
 Mon, 06 Jan 2025 14:23:05 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e278sm49450691f8f.75.2025.01.06.14.23.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 14:23:04 -0800 (PST)
Message-ID: <6a4417de-618f-4e37-b9c3-02b40e12a00b@linaro.org>
Date: Mon, 6 Jan 2025 23:23:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 64/73] tcg: Merge integer add2, sub2 operations
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
 <20250102180654.1420056-65-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102180654.1420056-65-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 2/1/25 19:06, Richard Henderson wrote:
> For TCI, we're losing type information from the interpreter.
> Limit the opcodes to the host register size; on 64-bit host
> it's just as easy to reconstruct 64-bit operands for normal add/sub.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h        |  6 +--
>   tcg/tci/tcg-target-has.h     |  4 +-
>   target/arm/tcg/translate.c   |  2 +-
>   tcg/optimize.c               |  7 ++-
>   tcg/tcg-op.c                 |  8 ++--
>   tcg/tcg.c                    | 18 +++-----
>   tcg/tci.c                    | 50 +++++++++++-----------
>   tcg/aarch64/tcg-target.c.inc | 26 ++++-------
>   tcg/arm/tcg-target.c.inc     |  8 ++--
>   tcg/i386/tcg-target.c.inc    | 10 ++---
>   tcg/mips/tcg-target.c.inc    | 10 +++--
>   tcg/ppc/tcg-target.c.inc     | 20 +++------
>   tcg/riscv/tcg-target.c.inc   | 24 ++++-------
>   tcg/s390x/tcg-target.c.inc   | 83 ++++++++++++++++++------------------
>   tcg/sparc64/tcg-target.c.inc | 40 ++++++++---------
>   tcg/tci/tcg-target.c.inc     | 10 ++---
>   16 files changed, 143 insertions(+), 183 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



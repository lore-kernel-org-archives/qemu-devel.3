Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB679C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 20:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY9rw-0000vJ-62; Wed, 15 Jan 2025 15:20:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY9rt-0000uF-OK
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 15:20:02 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY9rs-0007ua-4g
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 15:20:01 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385ef8b64b3so213192f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 12:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736972398; x=1737577198; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jT+j2dKxqP5nVBFv+RhkwgmbYY7oUcCS5yYprvuue9A=;
 b=izDVXo7TRuEv8hyhsnTY4ACN1B4u456cyx1h+vT3jGN7DuiWjoYkW9t5rgaR8Vd83z
 oeEEFL0V4Slrtr3ry5uKa1V3Sc3Zw4Mzmwlrj/KYB+s6RMrNvPGArEy6QLU7njKE85jC
 gaQNrUZv9arpoQIH/NvEJmGrfIhORXSWSbijyYxfRXBF7gguWKkLDtb6+1j+3GNB8zbA
 FIaCdhXDwm5UVgNgBVj4g6QuGEqjM21AJCOQil3lAjUfOFRo1tYWzXOJo/oKUJBc60fX
 8xrTqkW3yMNjgv9gCu/skZnhMdftv9qxb+zH0waW3VGhVHrj5T/YhIgXDYQdtLssj0M2
 zdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736972398; x=1737577198;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jT+j2dKxqP5nVBFv+RhkwgmbYY7oUcCS5yYprvuue9A=;
 b=CjsrR+eH5dlLe/FHJBZtwgHJQhQIx2cRc4STRNCIpv2O8qe2QMVddlCJP1z4hUbjMn
 4y9/zUF0h/PbxGpA2OCvEhE0U0DLGAqJlov/3dS7Guzi/L9PseLCYHfWxjBjqLsP129F
 4Zut416hqxQUH+nigQVq9nzcU+I+/8tSjL6tKwPZV5RFZFozAn9tSNlsDycxMnVzy9xJ
 GYC7UeIYOSgqv+H3BLOqLzpIrS+fmyOm3Kj61X9YxJWBcvYi2TGuxrei5D6eSwNeJ0Jm
 hMiOPeeK3rOqSHZFjY4jMezB9N2B26MNeHH4JS7G5gt7iO3Y5cnJv9BpgIqwkQDKIttL
 d2oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJFpKbPi2rVL1dpqJY+M/o7MQAjwsKO+mdnab8xxDOAJ6lrkCgjv4XSmaxnwabGcofH/UgJyK/KtGb@nongnu.org
X-Gm-Message-State: AOJu0YzHirru3f8e+oEx0Z/hiy3TqOJtkpaEIekoYs/6gEs1Wm5g76jO
 HzV2O2gQOVxTOrTviq2Bk6LzRPCTG/L0CBSHhKa/915YzJjp1oXZvub1LbgUmzI7J/6fRtnEXmQ
 m5QQ=
X-Gm-Gg: ASbGncsao9ZCysUy806NWStSREu9AS/pcVWH+ElaBEDiuVOrtUZsQRTmzKhfXZDGsjj
 ePm/emfNwp2Bzmdai/8JURJf7FmAp958VBumyDrDQpEYhUowXAwwUKjsDgJF2VicyVEk9nik35A
 00qL+VTYcYUREP3rgx0xcNhDbQfPjZvOCqh9dZ9eA6R52yqlJf8IeHxpRE9+w0y5BOk8NfrSP9W
 7X161mEcKPPR8xv84hDYH+cQPojn2BRaFAI/8KH6IjIcUTGUBE7xrF8CqTQk1D+WNhamCnlrDiq
 XixrAs86TIOemMqFZ4zdXtWu
X-Google-Smtp-Source: AGHT+IFUwQWbzU/jANqKFuVjB8jGWc6IJjULOCnHaIUR4h9Bk3UjIJd1Qsnkz1r0wwfiTLM50mFDwQ==
X-Received: by 2002:a05:6000:2aa:b0:385:fa26:f0d9 with SMTP id
 ffacd0b85a97d-38a87086c15mr29111611f8f.0.1736972398549; 
 Wed, 15 Jan 2025 12:19:58 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b81ccsm18780107f8f.65.2025.01.15.12.19.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 12:19:58 -0800 (PST)
Message-ID: <7fdad816-9060-4c37-9d04-5a50be4bd1f4@linaro.org>
Date: Wed, 15 Jan 2025 21:19:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 48/81] tcg: Remove TCG_TARGET_HAS_deposit_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-49-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-49-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> Make extract and sextract "unconditional" in the sense

Typo "Make deposit ..."

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> that the opcodes are always present.  Rely instead on
> TCG_TARGET_deposit_valid, now always defined.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target-has.h     |  3 +--
>   tcg/arm/tcg-target-has.h         |  2 +-
>   tcg/i386/tcg-target-has.h        |  5 +----
>   tcg/loongarch64/tcg-target-has.h |  3 +--
>   tcg/mips/tcg-target-has.h        |  3 +--
>   tcg/ppc/tcg-target-has.h         |  3 +--
>   tcg/riscv/tcg-target-has.h       |  4 ++--
>   tcg/s390x/tcg-target-has.h       |  3 +--
>   tcg/sparc64/tcg-target-has.h     |  4 ++--
>   tcg/tcg-has.h                    |  8 --------
>   tcg/tci/tcg-target-has.h         |  3 +--
>   tcg/tcg-op.c                     | 22 +++++++++++-----------
>   tcg/tcg.c                        | 31 +++++++++++--------------------
>   tcg/tci.c                        |  4 ----
>   tcg/tci/tcg-target.c.inc         |  2 +-
>   15 files changed, 35 insertions(+), 65 deletions(-)



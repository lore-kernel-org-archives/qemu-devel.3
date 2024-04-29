Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2728C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 10:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1OUT-0004U9-AQ; Mon, 29 Apr 2024 06:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1OUR-0004Tv-8O
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:44:07 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1OUP-0003gu-Mw
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:44:06 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-34c8f393195so1584302f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 03:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714387444; x=1714992244; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MMQip0ScKu6UJng72eb7YxIW4Fh3OzMaVP6k73rvr9g=;
 b=VNM3jp9WJswt/C6QVKmaLx1ulVhOzh98lvBc+GC2le9zsYYmCmTOqXzJM0Zgc4eECt
 3LRAoZEp0gLp6JXtF6b9alViu9hdTBWWgUnjVq8uPpZ6CfjqVtIosIkcvYbMzykDqfZc
 If3VfRcIAyp3C+WFaiGfBFQeWVeb3/bGcyuJbdasWsswIYNGyEHMVFsPgKF3x/29CwyT
 iEdJ8QTM4UGtc38bRcHaiMjVWAjEiulTZZ0uOzpXCyXAwV4ejslIZbVX14sOt5OuuVmC
 O7OB9T/fXNhIkYBa5wQwSKDhDTtYbvh/vqK3+slx9u3GbrML5q5kv+51g4Cptva2RazQ
 cWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714387444; x=1714992244;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MMQip0ScKu6UJng72eb7YxIW4Fh3OzMaVP6k73rvr9g=;
 b=iDFfEjaXLuE94AIXsvUThDTdh+9DWNyfU0ahNRbPko5/tNZ8CtL1iSFsg6fhdxXWxS
 7WPIL82HKgOMkW59rvfEK4nEHl5itCTSvpGtOpaKPmWncmFYioMGi2jGI5XcRkGFLgDm
 5AVLW/ZbqN6wGqc6WoYbplMC6KTm2a0fzrJzYK01OsQ/vvbFQxlCCWHfPg7pFBNw/Jhq
 T3hnT2pvhumwD5vPIYlmizLh40PNKkCoMhvj1hSa2S1iraxlmA6LDBi15ZPLOFiWuHCn
 wd8+Hpl16tvWe1W3OrHA1KioBhHy1CXA2/CMq/LlH1yimdp4wTUeKw7NHrgEgutIzAK7
 UV8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM0FCvspk3qtGWkyNtNxfndTL6z2PjzBYuBjI6PGezv/YeSntlz7GYxpAQMkYjSqbULuBzW7fE5I/cAK9NZ9yspkyb2N8=
X-Gm-Message-State: AOJu0YzmGqnDm8CFFkHXbLPpJFPgjtYn66Gh2LO4NQuTF0k6TWquJiaT
 rD6bLY+GSkIYyYnTLLpc6Y6ugxxOuaKphcCjeax/ZQsTrTVki9lHDCzQZjf4AybwsNc7jWzmSef
 GVcM=
X-Google-Smtp-Source: AGHT+IEFfTqAstGC/kBjm1KXAKObLehKcrNA8TTIaReakiOCDRtd2OnbI+oIm4clxSpO/FetqZ+uYA==
X-Received: by 2002:a05:6000:14e:b0:34c:72a9:b656 with SMTP id
 r14-20020a056000014e00b0034c72a9b656mr6176254wrx.55.1714387443989; 
 Mon, 29 Apr 2024 03:44:03 -0700 (PDT)
Received: from [10.79.37.248] ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 i17-20020adfe491000000b0034cc9dcccbdsm4469610wrm.113.2024.04.29.03.44.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 03:44:03 -0700 (PDT)
Message-ID: <09808b42-e260-4edb-92e1-960f6a9b3432@linaro.org>
Date: Mon, 29 Apr 2024 12:44:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/33] plugins: Use translator_st for
 qemu_plugin_insn_data
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424233131.988727-1-richard.henderson@linaro.org>
 <20240424233131.988727-12-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424233131.988727-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 25/4/24 01:31, Richard Henderson wrote:
> Use the bytes that we record for the entire TB, rather than
> a per-insn GByteArray.  Record the length of the insn in
> plugin_gen_insn_end rather than infering from the length
> of the array.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/plugin.h  | 14 +-------------
>   accel/tcg/plugin-gen.c |  7 +++++--
>   accel/tcg/translator.c | 26 --------------------------
>   plugins/api.c          | 12 +++++++-----
>   tcg/tcg.c              |  3 +--
>   5 files changed, 14 insertions(+), 48 deletions(-)

Nice!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



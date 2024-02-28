Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5BCC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfHye-00036e-4D; Wed, 28 Feb 2024 06:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rfHyd-00036T-FV
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:19:55 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rfHyV-0006dF-JW
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:19:55 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33d90dfe73cso424982f8f.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709119185; x=1709723985; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BfOZ0l6xCWBsZGW7kbOI7sVKHTlqVkLybtUYVscI9B0=;
 b=IJk8AIa4kLrKCAd/4iyTwSTY2Cp6NrzGIbkx4cF1E7IkHdXP8Q+AtlEz099pSO05A4
 Ii8KRAHsxAW/Eg9z2aBPhzvqPWjdESVNczqEO51VXelleb+cbTNhL7hg29i3CaEeZqFH
 M99P42x7FWrMg0yxKoEwhtXz4NLOc6iee/Je/jkLIoqsWS2zoSJuZ3QZJxWyvWcklWct
 BqbS357BVp4m/N6vdhkoykZiQZt88TGXeaDjqt9D1BNTSlqwzZ+QRWkhS7A8KxHLmWmU
 jAnyKJIJbfy4NlHpE2um9cbk37x8Rj8Ddc1FYjSWf43G4ZK5WuWpm4vluGmEygBY2qNG
 rXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709119185; x=1709723985;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BfOZ0l6xCWBsZGW7kbOI7sVKHTlqVkLybtUYVscI9B0=;
 b=OaGYAf29yKF9k3GvsaBaxJz0J6kZn7sXt4N8wwOrnHby3lYC1NHwWWSWtpIOOk5pPa
 8kSL/S1Fd5qrjHR8pos7K3WIbWVTOAh1CXVsCfmiKzOML6olIXrg+vrs8cjAOX7PW4oR
 Aoc9sjaVsl8RXMqBXfqBAOm/IqY7JCZ7BoZu+FmSRCXRiYYneHpnn1lwVCXjZT8xBj9d
 d2UKIrKD1b0jgnCg422A5UmakKQV8OvE9PEfYUzesAFyhs1tf9q27T82ndA5d3Y+LWXt
 mCrsReJKHoWJeYTXB/I6AX0mqrhV4CYTG7bSpaVrBapu9SgpabY+JLTke4sVyFOPRuxX
 Kw4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGTn/dIDokhC8nKpOsnr8uZQMbxpdFw8slPhNJmIAj1Opq820Fb4OPQqi6qn+BhCga67K0+pEcugP03bDrUw2vvDSKmn4=
X-Gm-Message-State: AOJu0YzLX6RxptRNy9ymXCG7X6sqCid3ppfkFE3gHKngRuvOUAWzcy9w
 R90hCvHMBvAHyUkLDMFWWLb1CjqG6hPgPnIdlNagrJDUQ4IU600ETm0JelqGsCzot9npuAjCKfP
 4
X-Google-Smtp-Source: AGHT+IEixSKzi5y69gFpw4iQjCh2kzQOl2rFkJP+nlYeMU4bxeS7fdON0U+70cY1MaRxKJm8SIDTDw==
X-Received: by 2002:a5d:58db:0:b0:33d:b312:2130 with SMTP id
 o27-20020a5d58db000000b0033db3122130mr2155634wrf.11.1709119184753; 
 Wed, 28 Feb 2024 03:19:44 -0800 (PST)
Received: from [192.168.169.175] ([92.88.171.236])
 by smtp.gmail.com with ESMTPSA id
 t8-20020adfe108000000b0033b4dae972asm14132959wrz.37.2024.02.28.03.19.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 03:19:44 -0800 (PST)
Message-ID: <1f179ee4-cab6-49c8-a625-2ac9dbe4e3d2@linaro.org>
Date: Wed, 28 Feb 2024 12:19:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/optimize: fix uninitialized variable
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240228110641.287205-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240228110641.287205-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 28/2/24 12:06, Paolo Bonzini wrote:
> The variables uext_opc and sext_opc are used without initialization if
> TCG_TARGET_extract_i{32,64}_valid returns false.  The result, depending
> on the compiler, might be the generation of extract and sextract opcodes

Shouldn't compilers bark?

> with invalid offset and count, or just random data in the TCG opcode
> stream.
> 
> Fixes: ceb9ee06b71 ("tcg/optimize: Handle TCG_COND_TST{EQ,NE}", 2024-02-03)
> Cc: Richard Henderson <pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tcg/optimize.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



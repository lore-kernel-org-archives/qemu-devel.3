Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84093C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 12:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uATAU-0001LO-Fg; Thu, 01 May 2025 08:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uATAS-0001Kj-27
 for qemu-devel@nongnu.org; Thu, 01 May 2025 08:37:32 -0400
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uATAP-0006Ws-UB
 for qemu-devel@nongnu.org; Thu, 01 May 2025 08:37:31 -0400
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-861525e9b0aso83896539f.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 05:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746103048; x=1746707848; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OFLNWV1qq8c2xcjhD4Kt0ZteyeD8hgPsBSiHuXkmMIU=;
 b=gBv2Gm4W6IMEg3LQg4I+SzAdWFcgD8lUA8RSWJKWPaxL1Mlt2O8hb9ZuxcC1hkZXtI
 2KM2i5qkyKIpW4Q74g9QkRFxl7963hfZJ8W1Outv/Pob/fJBlNy/m3biBTCZJRnY0UWV
 +urpC2j518id3DaxxhaZO/c3pSyAUlAahE8h0s+dUlbfkoFKbMksk9uDG0xkrVRyMGS9
 7GzlHVyCnub9EDLD8YFBO053W8IoYu1jYgrxPL16eGnKTotAnJ1N7ZECzO+iYZagIcft
 kTlcJWsOKH6k5CZv/gXCLPK8feGaRhWpp0oZ1Ag017I/s1jVTJbz7dxmk4fedSpSpmpf
 BiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746103048; x=1746707848;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OFLNWV1qq8c2xcjhD4Kt0ZteyeD8hgPsBSiHuXkmMIU=;
 b=AIx2WF/X+CI59MNyY3iQt41g43U9t0WU3w1CV1HMxLipiEs5bPRhr8snN55S90IO8r
 5WnYTSKSlUw+kEu3+b0SlHUCymuxS8geGFSMW5Aw+uvQ/7oJSQTZ8JHjdTISDjIOdqj4
 zHhV5Z+xuL/CIAcX0Y9wExAkHWRmIpnwYxRXs4R/BSz0d1BPiUDj2x2iLcbE9FqDjTJ5
 rZoNVLoRrDPYSjB6Cp4gHfsFOlYEeSQ9mm5wviDF7h5WENtussJT2Y4eBwjlTeM0TCC3
 YWdwFtd0xWlL/9tkISLbqbkGqQGDcXNGPv9TJAJ4o634nZzzsgpV1b8k1z33bYuU7dUK
 W6wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYLaCTHIAdatqNO5ARyFSWueVcj2X4/2AFTjnFP68kfxG2wZpr3DJO8v/HAuHuvtxCq6eJRn5rfxSO@nongnu.org
X-Gm-Message-State: AOJu0YwXw4mPdGfhWFbGz80EhUy71o0RadCqSvDQYp0ZfIdPx4m+20JE
 JaJJu+uVI2ThrOMAsiO1+VV2l0yCcU2urcGgbLDws2AA/FwHC3fg3aDjoU16o6k=
X-Gm-Gg: ASbGncttqhkJJN4EwBkheoEIrylE4PbquHqbCEgLuGVMZiK3WurW39AjdZ5jhinUWxq
 qhOTGa+MjigG0XSuobv2tprS90uGNePhlKhv4tfmez1tlD0PNNT4wCITu6WIUX9xfabu+TeZT6Y
 1dIBBHn36jgajvr/epRw9Zu9syshIQ9degFxv4zPiQhx5+YbDsj1ru3worJQmcyPBV23uYT/ihM
 TU1+u8XwPu9fDlBYSIYJHnuA+a6Vg3LE4ZmKm4m3R2NHVZ6wtEudqpq7dmAxtoYSC1AIohKqhGD
 uuC2sJd0OuUvbudsDBS4pFXS89iLMYeLWp+8Oik2pJHYxFl1TIJqO0HQs6T9x++Sb8tXIZs1MXs
 EUf2CsLVD
X-Google-Smtp-Source: AGHT+IH+raCXF5fReJz062i2/TWQ45LLYwoydyUGw/n1VxugfP4hiWInS2ybHZMoefAt9oGRXjy5OQ==
X-Received: by 2002:a6b:6002:0:b0:864:ab75:758 with SMTP id
 ca18e2360f4ac-864ab750875mr80248839f.4.1746103048348; 
 Thu, 01 May 2025 05:37:28 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f883014619sm137173173.105.2025.05.01.05.37.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 05:37:27 -0700 (PDT)
Message-ID: <8535f4b3-79cb-46f7-a313-4d0f9f4603dc@linaro.org>
Date: Thu, 1 May 2025 14:37:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] accel/tcg: Don't use TARGET_LONG_BITS in
 decode_sleb128
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20250430230631.2571291-1-richard.henderson@linaro.org>
 <20250430230631.2571291-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250430230631.2571291-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d33;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd33.google.com
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

On 1/5/25 01:06, Richard Henderson wrote:
> When we changed decode_sleb128 from target_long to
> int64_t, we failed to adjust the shift limit.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: c9ad8d27caa ("tcg: Widen gen_insn_data to uint64_t")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/translate-all.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



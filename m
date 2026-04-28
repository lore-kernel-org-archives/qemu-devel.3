Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F36FF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 06:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHbcz-0001Hf-Il; Tue, 28 Apr 2026 02:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbcA-00011F-Co
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 02:08:16 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbc7-0007VW-TE
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 02:08:10 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-445795cf6f1so798890f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 23:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777356486; x=1777961286; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uFU2ZGoSm/almi5MTkoDlVd5GRD8jawMKIRCUPbOpnY=;
 b=wl8UOxHnLLfgCceAdL+B8kcKsJ3auwc/VxJNVDsdCr0F64HwVv3iiSOu4Xw6S+3JLR
 KodEXJWrS11oJNZ2dW7aPEqZcHw3aEeqvE/WbIjjY+hElwk6gPakPA6UB4z1BwDr5sMj
 ze2xOssfNm1WXHjQCdBv1mw/vGGrC4/VE/nJCKMgi9+eytNEXdxXxwRo3NeRoZnabtkN
 eh+m66Rrk+jck/mMlgMk+nqoBWkWWVgS4A6U7qo0Bb2MIfgaFfvWRx+HLfg27HbwZWAn
 zEJ6e/hF7TGYk+L1V449/FYJByJf0gdbPjN0o6SnIhtUgPghT753sKyuBrLFz4ZpdwoS
 XDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777356486; x=1777961286;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uFU2ZGoSm/almi5MTkoDlVd5GRD8jawMKIRCUPbOpnY=;
 b=J/WGVPpk4zxNFHGRnWflAu3QrFSk+8o5blaNS1tuyzSjhmzj+IeZIizSE1P/du8QQ4
 716/ngNmD63FBGNwcaKmVkMUyUBTo2ggSMyJFNobHq5rjq8Vxf6l0ry9dFBeVGEhMx89
 ZxwAJX4/xIj2ZsnC6kXoDFDxTOSJS4wEDIFEZvaT9LrguJ7NNNfJstfFWwTP9UXpQvlX
 Q7DpFNNY/wHh0S40528Jcejntfju/P+oXCIQSN+zbdkkFcenez4egpbPyftmD2C177s7
 h/U4IVlzUQi9t0G8XW1QwXEMosnk3cZWD2TFJz9f9TlxcNHyF8C/dpyj4rveB7IuiaRa
 JEEg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9PmHG7ACeb+htLUGxXBK6ADuxPKNbXR1z2h9RrYBFTWKhGOENlmMmThPf2cU3tE6gzp2DWDFTfHPuV@nongnu.org
X-Gm-Message-State: AOJu0YxtyiHjVPt6VHlHs4g8wI0G516MZFLWeALmEVmII1XDW8V8BexR
 QGodV3RVtYcHxgE9ZsKkyJVrRdqiOrPq7e/rVFGBjFX7t/XkSrUtPLiLYwuRY8mF9/s=
X-Gm-Gg: AeBDiet1tlYcwcF6aioZ9GSbboL+edEWk3vpC9eUNCczsiZO2EgdVKSOZEMlCVyfgnI
 QJLS0FxP/5vuTfHupDjyywa7DWyxzPmxLDbAizf8ex4ZWR1Kl0z3gEjspWUthIXez7/jIG6Lnr6
 xU/vvMhynVHsdcpDJu3fHQYx2HIFHOuUk2AmNgTCjfPJOlzDsRuBqa/mIxOs4+e5/1wSHbrMaeo
 tOkK8bDR/nvi3lqyYgp+OA2rD9W9sXLwMmbZ12WjLLQr1wySNC32kMcBX7iVCGsib9/jnbUkRUL
 Ci1/EOv+sjYC6Y0TME8WH5Pmrturr+9gx2WGA4pl2AteHYCds6hY9uvG3bapFk4fdUECHGnJW2U
 19gQPF7VaT9shY4L0o77FCnsm8tg4PPirQgyAMVLAblJc8f22vwy2kueftDFWzoAOj5hELV2ojh
 TleaqQpSIx2234tMNThmvL+AqKpot+pflUM6id0brf7dfXLj+yb5hDwsdBWOED67gjsMUYxm+p1
 HJZ
X-Received: by 2002:a5d:5f85:0:b0:43d:761d:5423 with SMTP id
 ffacd0b85a97d-446493f4b0dmr2720123f8f.16.1777356486160; 
 Mon, 27 Apr 2026 23:08:06 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463d02f270sm3736683f8f.9.2026.04.27.23.08.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 23:08:05 -0700 (PDT)
Message-ID: <d9588eb6-a162-4f4f-9516-27300662ecb3@linaro.org>
Date: Tue, 28 Apr 2026 08:08:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 42/84] fpu: Inline float64_unpack_raw into callers
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-43-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-43-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 26/4/26 15:39, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 13 +++----------
>   1 file changed, 3 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


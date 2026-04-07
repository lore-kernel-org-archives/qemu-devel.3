Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A669CFF5135
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABoy-0004u0-K0; Tue, 07 Apr 2026 15:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wABoo-0004sq-Nj
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:10:34 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wABon-0002oW-9x
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:10:34 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43cfbd17589so4305656f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 12:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775589032; x=1776193832; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QLMPykG6lfcrNa00ISi1soNyoXLxQUOTl5+omE2304A=;
 b=zYB2fM3QA5r7/jXWUhGXTGZpLmgv8HlwVDF02p4GKXpRhKdtKiOJ7cEEItF4RYP2+Y
 ekRpigIkdoGJ2Uy1cA8j7sLCmQ1bBKfPVLWTH5bRiUxadOTYlxqR4ahT7ZEPpOTiSeIG
 jnQQ9QO/nqS/t9DmU8qFu5riQHsUXZ8KR8UeBqnMTFofywPESJ2UpTLiGIOfPwJH4DOU
 CdQC5lc7Rzv0OMKMBTUemluDO7GjGrc5GmqvmIGpDCJYJ04g5DxxKGzfydIkI+/vRUpU
 0/8/GzWWFNsMt/JgAjzXaLUh32Hfxh4UdjBUtTi21UWVG3o3krhzX9LkcyK85Syt5nKN
 Acgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775589032; x=1776193832;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QLMPykG6lfcrNa00ISi1soNyoXLxQUOTl5+omE2304A=;
 b=ckueSwI8qGAs1QUU8KQoZPfWrNwdwylTfaqrUMJ5134KSjFkMrzKu7FESfFt05eOm+
 P/MCnVO+0BdXOY9WMbEYgyDJ2VsGACSIn22wqxlsuNcUvOIZBU8UHYlm4aXXUoZiSmFN
 vyYoQPFzBA0Vm2O+g70W9TR19e8Aamd/OibCXqCCfVCTSN9AII+IhsWGwXzuKH8zahm+
 6o4oeFsTrO0cisiuy+OG2bnw5RomYDKrCtPmM1igal8djjtfPTf3qci6Nb0ci17vESBu
 5S2vZCttp/sON2NESglS2t39WQViuLVs3VPiesjQbQ0BAbplWlBcLQQfTfpgGPLdQjh2
 2X7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/Hun9UXVqrPBrncQo0ttOB/+kHrNQwYr8Xc0gsWAcl8DibZtlRG8Wi7zVbwRC+1/1lCGpn0FaHrzg@nongnu.org
X-Gm-Message-State: AOJu0YyW+ZZJkGvLRfRGYIx4JOVp11P6x+g+x3dCDrr8bv/8SdxfBlqF
 c7wnHbA6GWUjkP8sLfrlYDAavggZif23J4Zkh1IGi9hh1NVv+7ROHc46t3z5MCTxqY0=
X-Gm-Gg: AeBDieuIhecQPe0cj1cq3lBHGESe0SEuk5BkCZbUTkH4LsF3RWZnETXFa8wsYSR4b+H
 AS/Q8wjL3tlqWwg3ghhQXXQtYgg4RWj7oVAR72r3SPKg0ccZ1hz/IoWSDbtVbvwKU11F4KrgerY
 I9gO26UQXOk113dEfj3B2w8CYwMAXFsdxPl4krTPEdk7t00U3CNwtbJQ59AnEP+zMmZav7C/4vN
 F3JPJzKl2pGbqOTQolE8HBNum1gyyuUPf1KpuYJzBAd51b55Z5XMz1YldOzwQwMUQOdq/OLR4ha
 qJpsP2eOBKcw68jCksDVPnsMDdzIIUHYLSI7hC0HEN2vgB58BIS7I6KKb8/SAmBYEia2MXxCSDn
 oC5bD+UdfCkQm4NJIbJVamczRH3HOPJTE2bbBVNc4bczHB24luuOtGgixGfbtoDpVDuqgvnK7fh
 xvZAIm8Rg6Wg13hiN3Q3FXKnV5gSZE2WlwT8hrncbZiHRglrV9NYgFtc3lWog67iv9SA==
X-Received: by 2002:a5d:5d08:0:b0:43b:80a0:d92 with SMTP id
 ffacd0b85a97d-43d2930fd53mr25241810f8f.45.1775589031784; 
 Tue, 07 Apr 2026 12:10:31 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4f1a99sm55294838f8f.32.2026.04.07.12.10.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 12:10:31 -0700 (PDT)
Message-ID: <e0eb7051-660c-401e-aac7-29c03d5e50f1@linaro.org>
Date: Tue, 7 Apr 2026 21:10:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 08/20] target/arm/tcg/translate-m-nocp.c: make
 compilation unit common
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org
References: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
 <20260407022748.57629-9-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260407022748.57629-9-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 7/4/26 04:27, Pierrick Bouvier wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/meson.build | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


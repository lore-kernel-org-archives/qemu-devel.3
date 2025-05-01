Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E1AC3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANUV-0002mY-PR; Thu, 01 May 2025 02:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANUM-0002VK-Ef
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:33:44 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANUK-0000pn-Qu
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:33:42 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso548506b3a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746081219; x=1746686019; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C9ycyi7AmkNa/tBptixkItiPvVnn/JX03BHOL8G0IdA=;
 b=VN/AEtilmSNr3q8xOsCz3AIMKXDOwWhA6T9PPVfRwFL8MoQWV4eK1mdz7EomCHRhVY
 NqlrkJzTzQ5rmA7EaV3AUAf8P6DSpozxc6MwsCVyONTFX01lorVsmiGA1PYObBAJMmLm
 nd9REOaUE6j+uru6Z8mHetJkcnSCZTS3ieeV0aAyiACyGtKAmujc/X+55MYotn0IHG//
 YZWyHazEkXiYaRUTpdYzGlVC/fu44pCx/VVDGL2XBZWOnls4DL4u8YEgb/CSuSTuJKQH
 AvXHB0KqcQJm6K2vjQ7JzQKbFjMyWbiKJpIek1405gbOuqQPuVMDAAxbzZfmJJQeepwA
 gEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746081219; x=1746686019;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C9ycyi7AmkNa/tBptixkItiPvVnn/JX03BHOL8G0IdA=;
 b=dAUVG2UNlo05pb6UEDPnbU+SBYyU5nhtaXUaMURRrrDzdWvSjuGZ3gsO3pEMaRTiIx
 /eNCpOq0xC3CG9Zv5adfq8sSa2JojlYZ0fSBsjlnQpwlq61GP0Cv/yM/tV/ep7dvJbbo
 Scgm7Vjyy9eUh6OYAFhsA466qd+W9O48R7+MLkNdA7tDy0to0VP5Y1s+txyKzHe8FoI0
 rrVmc2LWSHEnK15i+B1fpKmkIq53sZCPJXr+eWv2q++MwutKu65uZh5hGh7b7SjC4xRs
 SXIzzf1IxfHB6X0jFF1XvkGX7Qopt5Hsc6BTCq6CFrVG7kRn21TVP5dyu5s9tpWPLmDL
 0ZzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlv32W0/F30WnN8bnLzrIN1+5PlihSldPG1dfMTI7Dp/DVUp6CxYzZYvDhEnY2A3QsuK6ofcE3mV62@nongnu.org
X-Gm-Message-State: AOJu0YzEnZVV+4hjXZDLsa3iTM08OxhLEqYlLUWQ38pozmO88K70iv45
 8PlE6bCfF6FX9EJrdodPUW65S4ucm7bNbpsykR0sbhVODAcXCS4TlpNrP4gRtLc=
X-Gm-Gg: ASbGncugPph6iMzUbaCxjACcZKEtdyhLctZ/3CN++1v+QHqXxKlRXEpNq6yExqM99Zv
 ii+bpA3Wv88nf1GAK5GifzFEmgBHrvQZIO661pGfxMoD0g02q0V0L8M9D1d9/9CxUOBN8lK2GKX
 Cp+PKkQxYhb+TU3bviUZP7dDh/8yjyJswYe36LbvALpM9F61i8QP11c+WykI7+vtR4d6anagjs3
 XYnBv2rZpBxu3pugiaDZ3F0X0hlIu6+tXAjmkG6jG5oj7ZnArTZTu+8M6bWKQ97FjjSb3vSowY1
 rt4jSRjKr1c9fDFaD95frmTMkImp4W+Ob+RthRnov935RHh2E3/ZXg==
X-Google-Smtp-Source: AGHT+IFDSGgR0AT/pyQiWD3CIyyTQfTKsgEymMIfwi1NWu8X+gUwk5/oZFOfIkB95HyApUSlbtMlHQ==
X-Received: by 2002:a05:6a00:3003:b0:736:b400:b58f with SMTP id
 d2e1a72fcca58-74048fcf549mr2426260b3a.0.1746081219613; 
 Wed, 30 Apr 2025 23:33:39 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm123957b3a.93.2025.04.30.23.33.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 23:33:39 -0700 (PDT)
Message-ID: <d08f5e70-d48d-4f81-807d-2680c637ec39@linaro.org>
Date: Wed, 30 Apr 2025 23:33:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] accel/tcg: Use vaddr in cpu_loop.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250430230631.2571291-1-richard.henderson@linaro.org>
 <20250430230631.2571291-7-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250430230631.2571291-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 4/30/25 4:06 PM, Richard Henderson wrote:
> Use vaddr instead of abi_ptr or target_ulong for a guest address.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/user/cpu_loop.h | 12 +++++-------
>   accel/tcg/user-exec.c   |  2 +-
>   linux-user/signal.c     |  4 ++--
>   3 files changed, 8 insertions(+), 10 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



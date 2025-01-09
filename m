Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5E2E7719C
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 22:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW15K-0003Jl-Lp; Thu, 09 Jan 2025 17:33:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW15I-0003JO-B3
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 17:33:00 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW15G-0005Mr-OT
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 17:33:00 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso806893f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 14:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736461976; x=1737066776; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=foA7LkYN2z+eykO9pEtwfGhIxJcZ/6/9RqVY8gZtngI=;
 b=e7Vh9qyfQstmqY0s8XkVVdwEqUV9c7LhDoAhto54H30lg943gRzQhPGm30/8JzHrjd
 Qz8eotSOWhFJQVV7P+Lt3Q7rRZWj6J9aezHcWTslBVGU8bnzg8Rj1E//WGWFGNURcSHS
 61LfIrWpyXPVuPOq7fmnEFjO7J0sse9RGCSjgjT0SH/vT2hqmCze+oxz1kttlSqRD7nN
 Qy1HqyUUWPA/6xyqNXT2/f50cjMuchrKCTMGc0C9j+pfLfVzxPkzH+b+CmrVxzTlHUXV
 QqUgeVVFNUFpPlPZvELbyLZKBbQJLNslsZl0eZ0j0s8dmNoTAvludz9ONICIngX/eUdm
 fYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736461976; x=1737066776;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=foA7LkYN2z+eykO9pEtwfGhIxJcZ/6/9RqVY8gZtngI=;
 b=nRlh+pzSC7tQ4sj1xRQ2mk3hv+P/TciX6Xqe2O6rL87ef8gDVGhTtRjMl9eP4hz4/P
 ZPzgFTao0uTjjcSaVnz9UWSm4/toW5kEDCIDq7PehpzJn5kOlo1+Gg/pM0ksM9KWQbl2
 j/PEmsvQMKNiTVRJEU/O3rxDEtA+NZAMe46M9yKfYdhBV2Xz0Ks1Bekvrnr/hR0JWXuh
 IR6bfQDTSepV+YQdwjsjtDWaXtekygDhnLYR5A8tirvoFiqk85FvXOc1KmGXSoG0W0DX
 XELeAOu/Tv4EHlV2YRqLfLeiGKUw4W4ceZaGHIB0hGiOcDFPGB7bvpVt1wBw/Lxy/gLq
 jd1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3kMrUOQA0nzdCeBiVnqnCFGJqqfmOKVb8t3H+K1gBjAa7FhQ2Nhe5rgJbSu1cS6CY/sdEukbPbORO@nongnu.org
X-Gm-Message-State: AOJu0Yx49zTUKaQ4tB5D1t99ReaEUXZUB2dpNqz/4XSAMkKCcbppZGHK
 SwRRuvPzuQFVbA7qPa0sjATJpcntAQf0gn2kjL2mR6IG4dSigFRStNke5SVS7eg=
X-Gm-Gg: ASbGnctlwwRgmYd3qu5SeXN3Q6RE7fdErMpBOu+NULUbAL5EAEMGJQfEvTwxdxDzboW
 aucFw4418M9hwIPhVRnBSmsGxluvuU+Ybw13DsGJKexRnBS0KpmF6DcUIgvt1W0mhC+HeSJoCgS
 Tt96GeXlNhFpTJoAU5yg+NF7EOP4UHLzcxUVLjE26J9XhDfo3dGolontSV4ymP7P37esB7Q2HBy
 lmBF8myt1noaM6ni+2hO9J6s/H7KXrsywkJDtfvkk2exdzYrsQdyuQTH8bSI67h+crxxxBRDnMo
 0DlzAAMMVBAchvml+Lg2DLvdFJQ=
X-Google-Smtp-Source: AGHT+IFvIQGwZJ1uiVX3HTcE1pxzOP4PUjSHn0jFCPVVFth0KpVpF5b4GYeFnI5r9c5aFeQeT8N4yA==
X-Received: by 2002:a05:6000:1ac6:b0:386:36e7:f44f with SMTP id
 ffacd0b85a97d-38a872db271mr6874487f8f.18.1736461976680; 
 Thu, 09 Jan 2025 14:32:56 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436dd11d8b4sm65616135e9.1.2025.01.09.14.32.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 14:32:56 -0800 (PST)
Message-ID: <75a62284-a2d2-43f5-8995-7798cb069118@linaro.org>
Date: Thu, 9 Jan 2025 23:32:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 57/81] tcg/optimize: Emit add r,r,-1 in
 fold_setcond_tst_pow2
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-58-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-58-richard.henderson@linaro.org>
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

On 7/1/25 09:00, Richard Henderson wrote:
> We canonicalize subtract with constant to add with constant.
> Fix this missed instance.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



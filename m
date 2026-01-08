Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B773D1D48D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdwTE-0000jc-JP; Thu, 08 Jan 2026 15:19:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwT3-0000XF-Lg
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:18:55 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwT2-0002Wj-5C
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:18:49 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-81dbc0a99d2so206792b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 12:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767903526; x=1768508326; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gNMnDIlmnY1O1zi5TWeAUwNZ1j0rFpTtl8XV+K8iN9Q=;
 b=H30t85i3PYKq8BAIs8UCXYsSU3ZYYDpAnSgVXw8g/JEFCUl3+Gm/DjgGQnQ4y8vr1z
 uYiu9iJz2JqqScZGnvXTPknzrrc0CFUTqqf2IVkQaN120xVBlz751+jBVTLBhAXgiepl
 VH+f1hmFfk5y9WSvmy+vlolS+xLpVIH6rFW7qqPxcZniHhEnXmG4EbguOr+fPJJsGshF
 I6UvAdX2QR3V1NK/AeW96NCJceXLIVEDPz5cx+oW3KQkRN6eA7vjzqCp73bwrUdl1/TB
 TZRqWQhIhwO3KIllCFSVY+ZLTjgw8wh1SAkQEq4K9XYBC8Jp9Svhx6mHnA1CbJg3C29B
 HebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767903526; x=1768508326;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gNMnDIlmnY1O1zi5TWeAUwNZ1j0rFpTtl8XV+K8iN9Q=;
 b=eo6oVYTjiLDkYx3zA4SrIVoFTZGP45L1oy0VkdZjvYxjoCQjCXTtFu8N/YZdbE1617
 5aJ/zD7y1S89PTwqZNHZFmu7hyg5lLf4V+vZVuP4esNEI0AMTlNHqlGnEFMdwppMHpFs
 DH0fiiJn7uEpRMB0ZElwmUVpkWDR4QmnBsZ2jrAXarRyV6reg/B4lPiSDKCh6S5sgXup
 BSjCu7puAcRWGnkDTY60vF1FLBR62j04vpRSchs29ZdHrz19mApQ7ZSnpzWty6/tCYoe
 w+wJZCHM3L3YHEkur9Q8Y0LZiErklemY1i4yCp5v26fUD63QUEnUbqqW1r/wpi5L3Kwh
 phjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWo/MQuitrZnnORgpV64dSCJlMNTOb2mu6qmwGQ8ET4yfzuKPgg8jl8tOedZuhmF6RzZCmZsunOb2EB@nongnu.org
X-Gm-Message-State: AOJu0Yx64vTxbzOVtNO3E3irqVJuJr9bnqNtsFmIPt6BbS6NjVykkywW
 bQAUTrtk58Hi1ifr0X0A/aYXWgexTFDdh3x6W1polPSuIbr4HaQ/oxNXl3ISc2/5cqA=
X-Gm-Gg: AY/fxX6EQbuWLM4aFhi1WIzfsIt8iCx6JHk1Y5z+r44/1eyd1lHmqSWhSBhH2H32eQe
 +HWHE+EFjniS3sWzLwM13Qip4/HrHdaLM7VbcdAQ10UX0v20pu42kxx+aVxQLFDnTEStzvTYpAa
 D8l5DKqnGh8bEtamoO7sNHrsBEd2A4IQF0ZPYWpbtCM2Xb5LOxih4rZ7HGV6rJrUBnLoGRQh0Cd
 q7uKZKFn2I99ItseIKzIV0HD9G9+21TW+qObcKjcTkdUKt9YZuVGZGxvVYA/mO7OIWgZru4A5ll
 vKE6+o6n63mnyh6q1DZoOS7k1Ng6vcYysCkx9QmevniZadRol16kYZQ9kP8eodlkik+XiFceEvY
 xjpKDac946rY2xqb1D0uVWiCD061rAtRSN+jCS61T12shEQfQu0mr51FcvJinrmWbsitxHedMXP
 cCOu3V21QhviQs2lW7Ggl+bCUaPbR/RkvXTz2+BirvR4mrnf3e7XAkAUkU
X-Google-Smtp-Source: AGHT+IGzsuDSZFr4pqgNwxv6VedRjCoLdQzI7krOI7vCiM4WWNIcmuSDhwoWiPW/v/+26GswgiEvDQ==
X-Received: by 2002:a05:6a00:1a10:b0:81c:c98c:aea8 with SMTP id
 d2e1a72fcca58-81cc98cb5a1mr3277391b3a.61.1767903525967; 
 Thu, 08 Jan 2026 12:18:45 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819c52f90c0sm8428838b3a.41.2026.01.08.12.18.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:18:45 -0800 (PST)
Message-ID: <67d8286c-2577-4b09-8ae8-637e50772681@linaro.org>
Date: Thu, 8 Jan 2026 12:18:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/50] meson: Drop host_arch rename for riscv64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-15-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

On 1/7/26 9:29 PM, Richard Henderson wrote:
> This requires renaming several directories:
> tcg/riscv, linux-user/include/host/riscv, and
> common-user/host/riscv.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   host/include/{riscv => riscv64}/host/cpuinfo.h           | 0
>   linux-user/include/host/{riscv => riscv64}/host-signal.h | 0
>   tcg/{riscv => riscv64}/tcg-target-con-set.h              | 0
>   tcg/{riscv => riscv64}/tcg-target-con-str.h              | 0
>   tcg/{riscv => riscv64}/tcg-target-has.h                  | 0
>   tcg/{riscv => riscv64}/tcg-target-mo.h                   | 0
>   tcg/{riscv => riscv64}/tcg-target-reg-bits.h             | 0
>   tcg/{riscv => riscv64}/tcg-target.h                      | 0
>   MAINTAINERS                                              | 2 +-
>   common-user/host/{riscv => riscv64}/safe-syscall.inc.S   | 0
>   configure                                                | 4 ++--
>   meson.build                                              | 2 --
>   tcg/{riscv => riscv64}/tcg-target-opc.h.inc              | 0
>   tcg/{riscv => riscv64}/tcg-target.c.inc                  | 0
>   14 files changed, 3 insertions(+), 5 deletions(-)
>   rename host/include/{riscv => riscv64}/host/cpuinfo.h (100%)
>   rename linux-user/include/host/{riscv => riscv64}/host-signal.h (100%)
>   rename tcg/{riscv => riscv64}/tcg-target-con-set.h (100%)
>   rename tcg/{riscv => riscv64}/tcg-target-con-str.h (100%)
>   rename tcg/{riscv => riscv64}/tcg-target-has.h (100%)
>   rename tcg/{riscv => riscv64}/tcg-target-mo.h (100%)
>   rename tcg/{riscv => riscv64}/tcg-target-reg-bits.h (100%)
>   rename tcg/{riscv => riscv64}/tcg-target.h (100%)
>   rename common-user/host/{riscv => riscv64}/safe-syscall.inc.S (100%)
>   rename tcg/{riscv => riscv64}/tcg-target-opc.h.inc (100%)
>   rename tcg/{riscv => riscv64}/tcg-target.c.inc (100%)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


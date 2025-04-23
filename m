Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E3AC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 10:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Xdd-0002Qp-9J; Wed, 23 Apr 2025 06:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Xdb-0002PF-W0
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:47:32 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Xda-00073D-5j
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:47:31 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3913d129c1aso605029f8f.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 03:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745405248; x=1746010048; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d35VazuwwTo6rIIsoHBG8IeRdQGisd6oQW+QHgCIWgg=;
 b=Imzem50wduKFpioTven/l3vVFbQj0veqcsh54yMvsS5fz3LgtxLm4mbbAZzOu0gvjg
 HTd07KmIs2hF9a5RFW5C846bKEGUqh+l4+ciN3ZFtBG7HmfUI5vCElp9DPsTuf3HyfGG
 I/Sn/vHKgRr6iNpPs541qCmeuLHEZodJMl1wQaxzEAhOZBaAl6ccDfnyLgy5yWEh7Fvg
 4VCN3FW7P5IfIhhzodmTeq9Ms5Q+jnbP2vqJKryWiAZGtUyvZS8bMaxacsx7c+adNbS5
 U/MN2pbWaGnfEQkz3X4YLlihg87LtGd0MdxLyGWqgljvtaMgpNbrQ9MjpJ3341lhNl4R
 uFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745405248; x=1746010048;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d35VazuwwTo6rIIsoHBG8IeRdQGisd6oQW+QHgCIWgg=;
 b=XND+03h537/s/4JSW0s2WNEeOwVcg6EQqa8US4iVIegi4AZm9udpP54VIwM3Xk20UK
 VHP9v0YVztH8Gfsk26O8+vrIJZkCT5l/Qib9TAT4gKW+kUhStYQYYDQ+uxe8GVu1TuXf
 ipeuVFvh3nmkJjz4RCdMgj3tODz9UyjjGGLzcfHWzQKNeaoyeMeTuGG3XUQGxnHwyxQ+
 DRf5uldoiNb3yhJaeVra2nq6zTpdscmHkIzCVXLViiJ3jyVyz1viBibqeJjie8k7zHo8
 7cb4sL8JrFZOPUg4f9P2EwrNu9K9/xY13REUGx2vYpavyCKNnZvunreJ+/iNABwQcwSn
 KAsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWunTwwbZqKjvq8cv6DFW1hXVdSuVN7Zqi7jcLZ4mgUnfXJSXaWbECBZzXNJuxtDO+Ceg8xVKTTtlSa@nongnu.org
X-Gm-Message-State: AOJu0Yx3snq7y9whyS5fxMex2qkyffuZjW0N1dDaF6JB9roKhldmXlN4
 4s9eKEjoePajQ7dDiqrdiKcVx90Ibwy6rPRfp//KhZSDX38pqws6vJcWNoKKp9p/+DGiEv6pXq/
 p
X-Gm-Gg: ASbGncsBQQblnik2GA5++nmTiAUsIxoPGYNasDhXCpYcETyaWiK+H90YClvbtWS81fb
 Rx22skon5pOnya2cRae/hGhiz3WtzpI5zaxELSmwPMyXIlyml+ABEOKFI/1HrpIQKoi+5nJhByD
 l7qiwHslDgjxIBycxR0upJQuL/837Vogssk+cpL3zx0qW7JkmuOqKb0gXrC8/As+qSR5CcLjw++
 O2SgI2yGziE3hcRPmm+pgnjQF1Pc+ezpjcFgi+bVOCJJWE72WbXl0yr420RcVuX5JTnsx6u4T+F
 Uh3DCyr/WuSOjXn6soOLUAB+rGdg8kwuCUU4rWImGH1MYzDflMM01SlDQ0mxlF4Ac9G4+snQzyo
 u95r3G4ggHTxdnnrHCto=
X-Google-Smtp-Source: AGHT+IFFwxw8u6RIaPLoGcWA8IzJiU0YNHkd75HWk3XVr6CnrLijFSRpaWIO2fxDHv2jt17N7cllwQ==
X-Received: by 2002:a05:6000:22c4:b0:39f:cfc:d520 with SMTP id
 ffacd0b85a97d-3a067243ce4mr1858274f8f.15.1745405248488; 
 Wed, 23 Apr 2025 03:47:28 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa420683sm18426740f8f.20.2025.04.23.03.47.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 03:47:27 -0700 (PDT)
Message-ID: <5a5f0fde-3881-41a0-82d9-ec8e9987f97a@linaro.org>
Date: Wed, 23 Apr 2025 12:47:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 147/147] tcg: Convert TARGET_SUPPORTS_MTTCG to
 TCGCPUOps::mttcg_supported field
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-148-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-148-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 22/4/25 21:28, Richard Henderson wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Instead of having a compile-time TARGET_SUPPORTS_MTTCG definition,
> have each target set the 'mttcg_supported' field in the TCGCPUOps
> structure.
> 

This part -->

> Since so far we only emulate one target architecture at a time,
> tcg_init_machine() gets whether MTTCG is supported via the
> current CPU class (CPU_RESOLVING_TYPE).
> 
> Since TARGET_SUPPORTS_MTTCG isn't available anymore,
> instead of emiting a warning when the 'thread' property
> is set in tcg_set_thread(), emit it in tcg_init_machine()
> where it is consumed.

<-- is now implemented by patch #144 "accel/tcg: Move mttcg warning
to tcg_init_machine" so can be removed.

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20250405161320.76854-17-philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/accel/tcg/cpu-ops.h              |  8 ++++++++
>   include/exec/poison.h                    |  1 -
>   accel/tcg/tcg-all.c                      | 11 +++++------
>   target/alpha/cpu.c                       |  1 +
>   target/arm/cpu.c                         |  1 +
>   target/arm/tcg/cpu-v7m.c                 |  1 +
>   target/avr/cpu.c                         |  1 +
>   target/hexagon/cpu.c                     |  1 +
>   target/hppa/cpu.c                        |  1 +
>   target/i386/tcg/tcg-cpu.c                |  1 +
>   target/loongarch/cpu.c                   |  1 +
>   target/m68k/cpu.c                        |  1 +
>   target/microblaze/cpu.c                  |  1 +
>   target/mips/cpu.c                        |  1 +
>   target/openrisc/cpu.c                    |  1 +
>   target/ppc/cpu_init.c                    |  1 +
>   target/riscv/tcg/tcg-cpu.c               |  1 +
>   target/rx/cpu.c                          |  1 +
>   target/s390x/cpu.c                       |  1 +
>   target/sh4/cpu.c                         |  1 +
>   target/sparc/cpu.c                       |  1 +
>   target/tricore/cpu.c                     |  1 +
>   target/xtensa/cpu.c                      |  1 +
>   configs/targets/aarch64-softmmu.mak      |  1 -
>   configs/targets/alpha-softmmu.mak        |  1 -
>   configs/targets/arm-softmmu.mak          |  1 -
>   configs/targets/hppa-softmmu.mak         |  1 -
>   configs/targets/i386-softmmu.mak         |  1 -
>   configs/targets/loongarch64-softmmu.mak  |  1 -
>   configs/targets/microblaze-softmmu.mak   |  1 -
>   configs/targets/microblazeel-softmmu.mak |  1 -
>   configs/targets/mips-softmmu.mak         |  1 -
>   configs/targets/mipsel-softmmu.mak       |  1 -
>   configs/targets/or1k-softmmu.mak         |  1 -
>   configs/targets/ppc64-softmmu.mak        |  1 -
>   configs/targets/riscv32-softmmu.mak      |  1 -
>   configs/targets/riscv64-softmmu.mak      |  1 -
>   configs/targets/s390x-softmmu.mak        |  1 -
>   configs/targets/sparc-softmmu.mak        |  1 -
>   configs/targets/sparc64-softmmu.mak      |  1 -
>   configs/targets/x86_64-softmmu.mak       |  1 -
>   configs/targets/xtensa-softmmu.mak       |  1 -
>   configs/targets/xtensaeb-softmmu.mak     |  1 -
>   docs/devel/multi-thread-tcg.rst          |  2 +-
>   44 files changed, 34 insertions(+), 28 deletions(-)



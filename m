Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60646E8783D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnINF-0005sW-UY; Tue, 03 Feb 2026 10:31:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnIN4-0005kp-UP
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:31:21 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnIN2-0004c7-Ur
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:31:18 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so61400265e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770132675; x=1770737475; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RhRR/tvgobe44eDIZQUYkoiXGZjba4+TL3KGYXtFOcs=;
 b=VYqm7dwiPvZYafWDeKx3y3KM6jomx6msQVPH8CtH7zGrqDcRT4tiaLZyudGpGpgTLV
 AHAPIgCeIVHor/ykAYCWIpVUdcR7F1hcMHmVxso7BpPz8kgYhcfGHl0X1lSVvdEs+Rgt
 Enk32fYl/Sv+q5qgyHzaeZ13sziXMhsMJOOTACUIu4vRmtkW6wBF/2to5oXY5RW2DZvf
 qiXrJNuD0hyPaA2vJ2l2VjHcJYsCtl5SJbOojwOW1tVMzo+Ozw/SpCV08yZoegEgIs77
 kyTltAddVudVoWVq1rSNNvFwHekUhmRbW0u0qDle2iJW5MhWki4GQU45xSN6X/cmsvKf
 sAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770132675; x=1770737475;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RhRR/tvgobe44eDIZQUYkoiXGZjba4+TL3KGYXtFOcs=;
 b=NAc9GXOXSU0L2tMZbGF1xupm+93nMoLc/HNPwCqrL2fsbzIKxOX0fWwwaGDhos9X9i
 +nKPw2OZ6VHF5/Br2Ayk9vnCreTGO6dqj43tG/KsJsCKfnMRzYC5c6WKDyObHc5BN29/
 6rCfyhknaaMg90xjeSnemTmILIO+XpY4ZZy2tAJhnAA7kzjfqR185kUr7Dk8Ru+upMf5
 9IfZF7QXtVlCl8emxEHCAXICMhQjD7910lHplAejYZHStomGAw60qcRWI4hmK5WbCeIt
 k66ZGP60+v6RTLQm9xU9GbRdlVD9wGqZIoK6Tq/E1EEcFXk7YH/nUgp5NpZ8QXISDemx
 1OAQ==
X-Gm-Message-State: AOJu0Yz0IEVEnsOf8VY/RxcbFymuQfUgh6C976C7lCOO11VdtEOIY4rm
 YcTnm8EnZ3uuI5GD64i/phd5YAfrSAII/2KAPndAeoJBSAYj/cm8bMgkg0qygT1UjALvVX+PTjz
 Whr7fDQk=
X-Gm-Gg: AZuq6aKKhvDDZyvowVUeW+9dB1zp9RHEoMEqLxP0U9QUWuH3cCL3MBGefkQnT3GLb47
 uGKb3TLOLkSMpSioBvsAw2VQgGuS5v8w7Gp6GrkKFR6aFlXKXz3N6qpDbZYSusclnvnC14jEil8
 ZP4g1Rj7fg0sxStgLK8WD7oKGOEgOBiSS82hNwESTxMs7V4lmqzV9eBz4onDn2zlT8u6uuS8OPA
 JVDyURqunYjdIBWmgAVraBQlumkSi7h+Tfm1b7iOLZsc053dO7j9ctNo6CbnDFK2uroG/Nkp+Uh
 s2PTpZN39Ai09p09EEhmH4NrLdvNzN/tIniYsdgiZcvexNWJEl/HTjnla9scLYkwP4DgxuQndot
 81i4WIteBWMy5mVdMfDTmtBWacowYfcyiZEIVBGXAXVq56uBImmTqybvXkqCBqdSMW0L3aWh4z3
 jSPleiinCUJ5Ma6Zp9Rn1QH4RWdPI8uVAiVibRDzVAhPoS2WqkKWQytw==
X-Received: by 2002:a05:600c:3549:b0:475:da1a:5418 with SMTP id
 5b1f17b1804b1-4830e9351f5mr623115e9.1.1770132674934; 
 Tue, 03 Feb 2026 07:31:14 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830511bfc6sm127269135e9.2.2026.02.03.07.31.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 07:31:14 -0800 (PST)
Message-ID: <19df569b-63fa-4815-96ff-7674782e0797@linaro.org>
Date: Tue, 3 Feb 2026 16:31:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Inline translator_ld[uw,l,q]() calls
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>, Alistair Francis <alistair.francis@wdc.com>
References: <20260202213810.97141-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260202213810.97141-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 2/2/26 22:38, Philippe Mathieu-Daudé wrote:
> In preparation of removing the translator_ld[uw,l,q]() methods,
> inline them for the RISC-V targets, using mo_endian(ctx) -- which
> we introduced in commit 504f7f304ff -- instead of MO_TE.
> 
> Mechanical change using the following Coccinelle 'spatch' script:
> 
>      @@
>      expression env, db, pc, do_swap;
>      @@
>      (
>      - translator_lduw(env, db, pc)
>      + translator_lduw_end(env, db, pc, mo_endian(ctx))
>      |
>      - translator_ldl(env, db, pc)
>      + translator_ldl_end(env, db, pc, mo_endian(ctx))
>      |
>      - translator_ldq(env, db, pc)
>      + translator_ldq_end(env, db, pc, mo_endian(ctx))
>      )
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/riscv/translate.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)

Patch queued, thanks.


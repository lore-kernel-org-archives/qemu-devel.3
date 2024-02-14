Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01914C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 13:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raFQE-0001yJ-9k; Wed, 14 Feb 2024 08:35:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1raFQD-0001xc-0T
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 08:35:33 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1raFQB-0008Hk-4T
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 08:35:32 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e0a5472e7cso2415672b3a.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 05:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1707917730; x=1708522530; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d8eMejq/XTlTm8gXWw1cBmEStlv8jE48q3f1EHcaeJY=;
 b=RCQcNe0eUXJH3uLGOthlhNfXc1rw8y/kdRJjpV+B7JZ2XHtGHEm/cAF//vIDZqaq2Z
 O6GCxPgoV1A60v1p8T/7jgeE7G5eL8qO2baMIltgxdrco2/zcWbIaR6z/hSG4Y7mJKIG
 goTBteQ+DSk8iDEugWUolQLX2lflXQE9ZNJwv+exkx81oEtzHlWxq/ILWnwh/zKvzSaQ
 rudrFqMkMDQyLv/42bIaPRmKQss3i2Ou1cytBWYY1NflwC0q5TRJkf3EvIcFQoYSMx0s
 aVkfJXCJctjz6xRYRTcmBWqJ7u4facF8I0n5BKr2xPitzCd/wqdOTySr/66/14m1Ooiz
 5xIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707917730; x=1708522530;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d8eMejq/XTlTm8gXWw1cBmEStlv8jE48q3f1EHcaeJY=;
 b=URh3xrCFeUi1BlDS96xGJmcfd/5YwF3Ue2CWxZHJtxWv+IqRrthiwuuPjhMSMOG0I6
 WkOa/Veu6MwmfdVhuK/WZQ0whO5y8F2wCi3Hb+Gb7o/AL6VMjFAUsw6uzS4UwzMTQmwx
 u3ON/F+J4WOV6AM9dnve6Anf2kAsixdsAMRGKatZEdq3fwked2PydwdbL/7ZQef/XGf7
 Sxx2+xmEAnc2TnI2zeyNGqLbRQ7HiplgMbQkbbLrJ1wZNKCb6tDzsQcEUWQajf5dBgAf
 UPecU+EyPgtvNLqe+7NHYpGoebw0I2RRegNBUonRSbR6ZG3ytvpzKLxJrXsczQ1mFbju
 pGKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM/Xvd4q+ri8WWuLbTU7lny4CrvODKj0MUtQLhd2VufOg+b1ij6piBEVUR3rokA3Gs9fn/UNyqcTOklL5aA8JAKWOeSVE=
X-Gm-Message-State: AOJu0YwLYfMs9F1Xk1VHxfP4OaZ3QS6XzE3taPrqec77qvTjkXvkNK5z
 MzHPGz+8Dk+eAuloPzi8feEJgW6WALVxE8Qj5sKWGAnPWosYUg2OSr5jUOMxYuY=
X-Google-Smtp-Source: AGHT+IE092Cn0a+xHV8c6gQtLATWhX4T2hG7cfGiMxp3zN1Cowau6xwTGDj0SpwEdzF/CUC+DIJ4uw==
X-Received: by 2002:a05:6a20:9f07:b0:19e:4e58:b4aa with SMTP id
 mk7-20020a056a209f0700b0019e4e58b4aamr3077173pzb.54.1707917729706; 
 Wed, 14 Feb 2024 05:35:29 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 d30-20020a17090a6f2100b0029899165611sm1475472pjk.35.2024.02.14.05.35.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 05:35:29 -0800 (PST)
Message-ID: <3da767e4-26f8-4c92-a241-4111c2befdc2@ventanamicro.com>
Date: Wed, 14 Feb 2024 10:35:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] RISC-V: Add Ztso extension
Content-Language: en-US
To: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>
References: <20240207122256.902627-1-christoph.muellner@vrull.eu>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240207122256.902627-1-christoph.muellner@vrull.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 2/7/24 09:22, Christoph Müllner wrote:
> The first patch of this series picks up an earlier v2 Ztso patch from Palmer,
> which can be found here:
>    https://patchwork.kernel.org/project/qemu-devel/patch/20220917072635.11616-1-palmer@rivosinc.com/
> This patch did not apply cleanly but the necessary changes were trivial.
> There was a request to extend the commit message, which is part of the
> posted patch of this series.  As this patch was reviewed a year ago,
> I believe it could be merged.
> 
> The second patch simply exposes Ztso via hwprobe.

It's also worth mentioning that the second patch relies on:

"[PATCH 0/2] linux-user/riscv: Sync hwprobe keys with kernel"

To be applied beforehand.



Thanks,

Daniel


> 
> Relevant in this context might be also, that Richard's patch to improve
> TCG's memory barrier selection depending on host and guest memory ordering
> landed in June 2023:
>    https://lore.kernel.org/all/a313b36b-dcc1-f812-ccbd-afed1cbd523b@linaro.org/T/
> 
> The first patch was already sent as part of an RFC series for Ssdtso:
>    https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg02962.html
> Since I don't want to keep this patch until the ratification of Ssdtso,
> I would like to get this merged independent of Ssdtso.
> 
> This series is based on today's riscv-to-apply.next with my other series
> that adds the new hwprobe keys
> (https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg01293.html).
> 
> This series can also be found here:
>    https://github.com/cmuellner/qemu/tree/ztso
> 
> Christoph Müllner (1):
>    linux-user/riscv: Add Ztso extension to hwprobe
> 
> Palmer Dabbelt (1):
>    RISC-V: Add support for Ztso
> 
>   linux-user/syscall.c                    |  3 +++
>   target/riscv/cpu.c                      |  2 ++
>   target/riscv/cpu_cfg.h                  |  1 +
>   target/riscv/insn_trans/trans_rva.c.inc | 11 ++++++++---
>   target/riscv/insn_trans/trans_rvi.c.inc | 16 ++++++++++++++--
>   target/riscv/insn_trans/trans_rvv.c.inc | 20 ++++++++++++++++++++
>   target/riscv/translate.c                |  3 +++
>   7 files changed, 51 insertions(+), 5 deletions(-)
> 


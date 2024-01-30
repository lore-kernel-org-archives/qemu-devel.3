Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6385BC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 11:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUmhu-0008Mz-Nr; Tue, 30 Jan 2024 06:55:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUmhp-0008KW-BX
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:55:10 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUmhm-0000nj-J8
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:55:09 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-55a8fd60af0so4084596a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 03:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706615704; x=1707220504; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/zV858AZvLi7xCe5NWW77dgGCH9fJvJbUOlwXik95x8=;
 b=kbTxBy+ADIAYpOuIbEt3sM8r5yCQiuaFvCE9ZE9LO7gwyy4SnvlzDERgb3jo+ZZ+T9
 h3mRGt1EqIP1bq+zuNMn9lbdirw1hZWYiLQWKvWOYCnT+lA2XdKpVQRmKCzf/MZK2r6J
 JK6CC2MnBYiZnKfSTF9n1kZ8WYYXp5AEbGeQLsX4bD4LD5CpiQzDH6Q97L7M+wS2Iyfh
 tz3Pxq5bL1dc7ZW7FUHgsxJyLNsajOP6TMUcy07QxOsenSi3bW+IT1AaIgcU9cH4TMnu
 qRo2jVGM15AhOznaSqpMVRgi+O0pheBamOnsG2jCbYY1waD64QvUd3D9x0zhPaKOTOEB
 3e0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706615704; x=1707220504;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/zV858AZvLi7xCe5NWW77dgGCH9fJvJbUOlwXik95x8=;
 b=Yt8XUt/tKSJyN7rqgh1HNAUWR52v1PgxUPfZR3MDcofVYh0n5pBSjD7eoLyJy6+lzE
 9TcggqloNZsgPmhiApV1Ob8gd4fEEN1YXOU30prO1qEhO47SkpwAnhH+Y1Gmloer9EFv
 CYiMryFvRVl4VhAciWDSimtkWHCogqGBaCNzwjjVi4mWqCosiFVAjoHvuN1s8iCo4RCz
 OzrOWIQNe1i/v1QjRtTO0jPZoRdIuCMTP8xrZeOlAnVkCysmZPJhDYALA6M6XGT0lhSF
 4xDcw7+6Xq52qq2c6Sn83DbVjfqmlfeOnyowNABEeu7QbfVvTOfUtmebuthXN75J6uHY
 VqRA==
X-Gm-Message-State: AOJu0YzNaGwCz79E8GIsYy+yGGtxtWqd5l4Kp/hDFJlw2pSmt8Nz5igZ
 Zimm45VVw4bQtgx90Qq6+jGG36VCdE5qODa/Gba1MFfhVf53rrTiJf2LS4Ot3S48gIR6oAFJJXI
 l
X-Google-Smtp-Source: AGHT+IHJ2wGQ3eQoN91uawIuGQA9GLEnrJ2lwP283Z7FQIs65GTAj4owklimzcxB5wSN9WxYzhgYIQ==
X-Received: by 2002:a17:906:255b:b0:a35:da0b:d011 with SMTP id
 j27-20020a170906255b00b00a35da0bd011mr3354347ejb.61.1706615704656; 
 Tue, 30 Jan 2024 03:55:04 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a170906281000b00a35becf3f0csm2073977ejc.85.2024.01.30.03.55.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 03:55:04 -0800 (PST)
Message-ID: <c0b73d73-bb73-46d5-849a-b4f6542b8c2f@linaro.org>
Date: Tue, 30 Jan 2024 12:55:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] sparc/leon3: Add support for -smp
Content-Language: en-US
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-devel@nongnu.org
References: <20240116130213.172358-1-chigot@adacore.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240116130213.172358-1-chigot@adacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 16/1/24 14:02, Clément Chigot wrote:
> V2 modifications
>   - Patch1: Add SPDX copyright tags.
>   - Patch3: Add defines for MP_STATUS fields. Improve comments.
>   - Patch4: Improve a comment.
>   - Patch6: Dropped as already merged.
> 
> ---
> 
> This series allows leon3 emulations to record up 4 CPUs.
> 
> It requires some enhancements in the grlib_irqmp device and adding the
> cpu_index field in the asr17 instruction.
> 
> It has been tested locally with various bareboard runtimes.
> 
> 
> Clément Chigot (8):
>    sparc/grlib: split out the headers for each peripherals
>    intc/grlib_irqmp: add ncpus property
>    intc/grlib_irqmp: implements the multiprocessor status register
>    intc/grlib_irqmp: implements multicore irq
>    target/sparc: implement asr17 feature for smp
>    leon3: implement multiprocessor
>    leon3: check cpu_id in the tiny bootloader
>    MAINTAINERS: replace Fabien by myself as Leon3 maintainer

Cc'ing maintainers per:

$ ./scripts/get_maintainer.pl -f hw/sparc/leon3.c
"Clément Chigot" <chigot@adacore.com> (maintainer:Leon3)
Frederic Konrad <konrad.frederic@yahoo.fr> (maintainer:Leon3)
Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> (maintainer:SPARC TCG CPUs)
Artyom Tarasenko <atar4qemu@gmail.com> (maintainer:SPARC TCG CPUs)

Mark / Artyom if you don't have PR planned I can take the v3 if you Ack.

Regards,

Phil.


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DB1C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 00:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thHbv-0006HF-MM; Sun, 09 Feb 2025 19:25:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1thHbp-0006Fl-NA; Sun, 09 Feb 2025 19:25:09 -0500
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1thHbo-0000AC-4O; Sun, 09 Feb 2025 19:25:09 -0500
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-4bbb91481deso147572137.0; 
 Sun, 09 Feb 2025 16:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739147106; x=1739751906; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wu7U5ZmiKirMU7YBqYpSKXK3U+c31+6gzWljqTJWANM=;
 b=Dc9cLnHp2O7NpmNMREw2VvVpaajsghKnu5AEjYXA1VJlFKqxDKzZx+LPhuChs+Ng/e
 Me5ptGUbHrpKp0nwzeRrZoAVsw0ZywkP8leDvcqdWr0nLr73bN6TKb3GoSQktApattfn
 oXMKLwOn5wKG9ghdoQxRagjF64/18siYcbXu111+rdTW6A2rypoIGtiOK/DMcpPdqwu6
 UT8BlI2RqRNWvuw4NSZsF4ywCFAiAj6skcVzccihf7ZA/Np0u8yQVgXDyVXa0ZdDG73E
 6Vd70OiZkqeH0JS3yJ3fa4yd7VijePRRLQOy/PLfaBT4o/hCBzmb53qWwAgyMlZm7AyQ
 fb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739147106; x=1739751906;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wu7U5ZmiKirMU7YBqYpSKXK3U+c31+6gzWljqTJWANM=;
 b=IgaU9fPIUmVq8uxVvHEh2Xhj8NH9l/CUQJ3kQEdGNQXXFVzJNCTKmXHWbYpDtoIjh/
 35BHZEMLgrbJ8bbhumDhkLM6oqKaTl3UKIRYgqoB/EDYhtg5tacPGB0QN14w86EkbY+M
 34ShWPwvOEQgRJgFLLjun7oytcOeNk+MpwBx7iK4UShwgj04BZs7qhITcEqNBMXaf5dq
 /wJfmppTbFPXPLNTChoWsomzpUypIxY5Z24NkVujj0GUGyY3k5OKuTgBXYHVTWW8B8zS
 SUH2XtBiGEeV57qH0WEzcF3GlGU/wpYB7/g0BQXumOx3OUAgmQ/q8kagcIkn76KKOV7P
 Iqhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeoOjbda24BsmjOdRTdCHTgH+CaXVc/QfU/Yt74EG6ln4jCTk/2wDgzaXwrcdVPgHD5pvBAKFhqeQs@nongnu.org
X-Gm-Message-State: AOJu0YxBT6xIxcT5h7mrmTc/2u321GTuSbaw7bZusQbzthG7zB0MUj1m
 U4Hb66CKgV6MVNoQcGPExyjJBcPhf4bK5lShaU/JzeldxPeMONts7ZBluhBCnF4rVA0+x1WkA3n
 wxFHY/pNkzxt23TJpguBII8G/12c=
X-Gm-Gg: ASbGnctl+YCiDjgWGiz0AEV2NrwUm4LYxjskcJRwvkrqmeTF3tCDmlg1qI0o8w1XleK
 aDqNSIXeH7OBZ9E+3/41Up3f5mP9lPvIjXsRjt1oKRkT4OEwwD+nAea4nqYYyB5KFhkf5DgV7Sr
 4qEM1vOt8LQWekRC3yiaOK9ASn0A==
X-Google-Smtp-Source: AGHT+IF8oU+X2hzIWh+nD0IkajaFcgO3M0HROhCYSxnbF7OQPTCTv/2iVIq6iHxq6h703q1zQSVFyEZxHfBxtNY+35I=
X-Received: by 2002:a05:6102:41a4:b0:4b1:3409:5dcd with SMTP id
 ada2fe7eead31-4ba85f460c3mr7791143137.20.1739147106659; Sun, 09 Feb 2025
 16:25:06 -0800 (PST)
MIME-Version: 1.0
References: <20250206181827.41557-1-philmd@linaro.org>
 <20250206181827.41557-2-philmd@linaro.org>
In-Reply-To: <20250206181827.41557-2-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 10 Feb 2025 10:24:40 +1000
X-Gm-Features: AWEUYZno3SYWGKe9HJgpSRFmacBP9jzlQhpPd-nyINH1448CD9vo-NHQmqKNGW0
Message-ID: <CAKmqyKPSewTC3dkzCaZRu26f0qoZhvnr_RXPNuH9SfgxNuVcLQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] MAINTAINERS: Unify Alistair's professional email
 address
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>, Sunil V L <sunilvl@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e31;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe31.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Feb 7, 2025 at 4:22=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> Alistair's email is typed differently, so the get_maintainer.pl
> script add it twice :) Unify to reduce traffic.
>
>   $ git grep -h 'Alistair Francis' -- MAINTAINERS | sort -u
>   M: Alistair Francis <Alistair.Francis@wdc.com>
>   M: Alistair Francis <alistair.francis@wdc.com>

These two should be combined

>   M: Alistair Francis <alistair@alistair23.me>

But this is actually my personal email for older non WDC work
(basically not RISC-V stuff).

It all goes to the same place but there is some distinction between
the two, so I'd probably like to keep this one separate. If it's too
annoying for others then I'm happy to consolidate them though

Alistair

>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  MAINTAINERS | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0cf37fce7b5..b7ac1519ee3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -318,7 +318,7 @@ F: tests/functional/test_ppc_74xx.py
>
>  RISC-V TCG CPUs
>  M: Palmer Dabbelt <palmer@dabbelt.com>
> -M: Alistair Francis <alistair.francis@wdc.com>
> +M: alistair.francis <alistair.francis@wdc.com>
>  M: Bin Meng <bmeng.cn@gmail.com>
>  R: Weiwei Li <liwei1518@gmail.com>
>  R: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> @@ -753,7 +753,7 @@ F: docs/system/arm/digic.rst
>
>  Goldfish RTC
>  M: Anup Patel <anup.patel@wdc.com>
> -M: Alistair Francis <Alistair.Francis@wdc.com>
> +M: alistair.francis <alistair.francis@wdc.com>
>  L: qemu-riscv@nongnu.org
>  S: Maintained
>  F: hw/rtc/goldfish_rtc.c
> @@ -1009,7 +1009,7 @@ F: tests/functional/test_arm_tuxrun.py
>
>  Xilinx Zynq
>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> -M: Alistair Francis <alistair@alistair23.me>
> +M: alistair.francis <alistair@alistair23.me>
>  M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
>  S: Maintained
> @@ -1593,7 +1593,7 @@ F: pc-bios/vof*
>  RISC-V Machines
>  ---------------
>  OpenTitan
> -M: Alistair Francis <Alistair.Francis@wdc.com>
> +M: Alistair Francis <alistair.francis@wdc.com>
>  L: qemu-riscv@nongnu.org
>  S: Supported
>  F: hw/riscv/opentitan.c
> @@ -1628,7 +1628,7 @@ F: include/hw/riscv/shakti_c.h
>  F: include/hw/char/shakti_uart.h
>
>  SiFive Machines
> -M: Alistair Francis <Alistair.Francis@wdc.com>
> +M: Alistair Francis <alistair.francis@wdc.com>
>  M: Bin Meng <bmeng.cn@gmail.com>
>  M: Palmer Dabbelt <palmer@dabbelt.com>
>  L: qemu-riscv@nongnu.org
> @@ -3842,7 +3842,7 @@ F: tcg/ppc/
>
>  RISC-V TCG target
>  M: Palmer Dabbelt <palmer@dabbelt.com>
> -M: Alistair Francis <Alistair.Francis@wdc.com>
> +M: Alistair Francis <alistair.francis@wdc.com>
>  L: qemu-riscv@nongnu.org
>  S: Maintained
>  F: tcg/riscv/
> --
> 2.47.1
>
>


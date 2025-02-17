Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC5DC021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 05:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjtMN-0005yG-PI; Mon, 17 Feb 2025 00:07:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tjtLs-0005xC-An; Mon, 17 Feb 2025 00:07:31 -0500
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tjtLq-0005zl-Nj; Mon, 17 Feb 2025 00:07:28 -0500
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4bbdf3081acso2622426137.2; 
 Sun, 16 Feb 2025 21:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739768845; x=1740373645; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ijyBLFWKZgoxP19ZwyN1K2uMa26g+cJPr9CkxbwnzRI=;
 b=MHbweBWQ99d/f04kj9OGD+f4bHiinvsgL++aWmj++XqWX2KkfbI1zgalw9rhdDydBj
 laVtq0yLv5UeNlfdDy1LvPYE1ewYl9jLDEYspJ3bQEzsRSAldE7AgxL1paKo70gf9slu
 UsdS5IT1rxkanHHaTjLmq22DXIpZ75prvopMwu0JpWa5ZCX74pgHUOBpbU5mnEa2pocj
 RhsghWHP5/CQBpFW0igiUgcgKHxwN0LwHaV5XVq4Tug6TzJQM41t/7jXvX1FaRNXhwyq
 6NqqsG+McOis+EcpA3wEOARtvGrtqqNgvcSJ/hdaDQTgW01yrfIYXjdsNXuQUIy+Qtst
 lECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739768845; x=1740373645;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ijyBLFWKZgoxP19ZwyN1K2uMa26g+cJPr9CkxbwnzRI=;
 b=K+oZ0D3M55m5J28RKEpXeCVSVAPZZDe0W0jiTMLlnDtIUHPAXGRZIaHxgT/9FmzlVm
 wrGTR65KnU1h2kPIbflG5xgnrrHC5iAga/w9hBca266ASRroU85WlC+aP5+kVMBF+DQe
 gxDjPIrLBpXe4msd68YEGj1diHiHBy66CR4ua/ZvoIqllUv82x9A07/9R/fR52amT79D
 dDbaIY7X4hpko86+EVwQ1tVnhmOBtYRAyDowj/RmhoNx7Z9IWM+/P9Ak1q0e1kuy8EPF
 NL31DhMdJU+z/1JUPl6u+8+SHS6GS6uLMzBCLowPNjHKnJ9fF381Jg8xZh74W49744Fo
 0nng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNKO76cDlHzblxKn7kFX1abVrifypYqFTbBIwFn4ZX0ibr/8poLBUxyYeW2WAZusdiqojR9/+HoAE3@nongnu.org
X-Gm-Message-State: AOJu0YwxYXOozrUs36B/bmS5jJuxrf/Y4/btInTZLZmVhs+mFPwewbpE
 nF3DqJ0CNcJD4nTuEIzk4w1jbCtGV9Io01ffihPVfbaOExzAbqBwk9dxOccTvHkbfA44uFWGtuE
 WBU3VtUC3I21aaHvlHnoihXNTT/Q=
X-Gm-Gg: ASbGncu/5HLPyA3x2urBeOy2BThzUTwmHAcMDXiU2cvkA85MVMAI+zJNsRnz7o6fyM5
 KEsQPDFYYpjY0hfRx0J5JiOgTj5CMrTD+NUFQQygO/o1eRm3bZYM70ZmvGfEWJvA2nFxJqJXL1t
 6Lr3wnWna4LvL+E3L8W0Q970zKcw==
X-Google-Smtp-Source: AGHT+IFct2DkbsZCPKDCg0t0DiOeeju7mNwaBiP9AUiFTtSZ7BH6N28hLWG2vAEU/Dor58MCQec7oAV/HI2NTu7tyiw=
X-Received: by 2002:a05:6102:150f:b0:4bb:cf34:3757 with SMTP id
 ada2fe7eead31-4bd3ff3f0a5mr4197766137.17.1739768843470; Sun, 16 Feb 2025
 21:07:23 -0800 (PST)
MIME-Version: 1.0
References: <20250213145640.117275-1-cleger@rivosinc.com>
In-Reply-To: <20250213145640.117275-1-cleger@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 17 Feb 2025 15:06:57 +1000
X-Gm-Features: AWEUYZmAEOz5xs-fTwXRo1R-m7E6K8Tz73ur-lg9XHTKbSDnL_av8OYu2CQSIyE
Message-ID: <CAKmqyKP++TPfVbvD0M3vtb4RPYd21NHe1z0-R32RsY60Owj=oQ@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: remove warnings about Smdbltrp/Smrnmi
 being disabled
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2f.google.com
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

On Fri, Feb 14, 2025 at 12:57=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@ri=
vosinc.com> wrote:
>
> As raised by Richard Henderson, these warnings are displayed in user
> only as well. Since they aren't really useful for the end-user, remove
> them and add a "TODO" note in the leading comments.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>
> v2:
>  - Remove Tommy bouncing mail from the recipient list
>  - Entirely remove warnings and add "TODO" in the leading comments
>
>  target/riscv/tcg/tcg-cpu.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 0a137281de..94bfafd7db 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1432,22 +1432,20 @@ static void riscv_init_max_cpu_extensions(Object =
*obj)
>      }
>
>      /*
> -     * ext_smrnmi requires OpenSBI changes that our current
> +     * TODO: ext_smrnmi requires OpenSBI changes that our current
>       * image does not have. Disable it for now.
>       */
>      if (cpu->cfg.ext_smrnmi) {
>          isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smrnmi), false);
> -        qemu_log("Smrnmi is disabled in the 'max' type CPU\n");
>      }
>
>      /*
> -     * ext_smdbltrp requires the firmware to clear MSTATUS.MDT on startu=
p to
> -     * avoid generating a double trap. OpenSBI does not currently suppor=
t it,
> +     * TODO: ext_smdbltrp requires the firmware to clear MSTATUS.MDT on =
startup
> +     * to avoid generating a double trap. OpenSBI does not currently sup=
port it,
>       * disable it for now.
>       */
>      if (cpu->cfg.ext_smdbltrp) {
>          isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smdbltrp), false)=
;
> -        qemu_log("Smdbltrp is disabled in the 'max' type CPU\n");
>      }
>  }
>
> --
> 2.47.2
>
>


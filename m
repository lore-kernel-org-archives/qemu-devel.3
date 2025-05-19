Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89114C3ABC9
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 00:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGoXB-0005C7-TD; Sun, 18 May 2025 20:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGoX5-0005Bk-AI; Sun, 18 May 2025 20:39:08 -0400
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGoX3-0002Wf-Ed; Sun, 18 May 2025 20:39:07 -0400
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-52410fb2afeso2630585e0c.3; 
 Sun, 18 May 2025 17:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747615143; x=1748219943; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vh1Cavi6wiUbzWMPFYbDdJIeqwpWgOusQ+B/B7D4w1c=;
 b=FeaqCM8pxH6xO/j8Omcze918kOmOY+Z6SMkV7sqzr/Tio64+JFhLaxI6TukKV9jhoo
 oKC9kUGanuMHvq8Utb8/djwegHoYr/JwymR//6g8kneJKs7iBVD6yn1Ie6fjYNmufiFK
 sfp6Y9FJUcxRiu+aaLxCGuFiIGs8x/VeMM5f8GhtQWBNRC0uII/0fn52fs9KL2y2hd3L
 P+vsyZQmDIxQ2mXQmjoU9rTvSf8v+DQAmgLs0iGOOhjxmD4kJAil8YvLOB9F1LPvpxpC
 vIgZmyzAYXjZUfCBM5nktM+JDc+4ELG3w6DokXZBap68/qiU+BvBHUtPqT/6ANAgR5nj
 g/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747615143; x=1748219943;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vh1Cavi6wiUbzWMPFYbDdJIeqwpWgOusQ+B/B7D4w1c=;
 b=M6EYBc7jpYDWUe1VGt+FEBigcbuM0V+eCh+rQ1iOL9gY5l4hhzWMdIXz1rTIZkao+u
 IvPyxzOnjiwgUjJR3MWb5TiED9IVzOp2298uPnj07bWnP4nVsVg4YNGXruvYm7ZzPHok
 mmq2dMJ77gI0tZMWCiwdgZdmSjZGpWTq3+CcJUutPBxV+AaoeUhjxuPkzLBZ0Jhr0xD2
 uRdGTddoWcG0d4JAcf2dNmiUBHKAUKuNiZyJsgZPXntTvQJ80FaF0jAwtBV7fxped6UQ
 58LQxZuv/gHUkF7zNDBPBTOHDD31TrHiVpWcjTWL0GBxbeaEmdBGG3HxbXOgbQK9sTIM
 /Hng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuxpSgY6bflS62cZKt9uvpEA3KieRVxWi258NeT0LSc4NMmfrK78z45bLrXDgP8WqLD0rfaz90hz8z@nongnu.org
X-Gm-Message-State: AOJu0Yz61mOLSONk11MMS290c5DBpH4PND9k4PrQpFB+WHKM9I2ZiXoP
 xeW2xfjANgWD9kQHbi7SI3nF9OzsC5JmMFR/nvSBy+y6mSJgWgIXcCo44kXELVr5h0uEKfzEZP5
 YMzTtikVYtjHEYWMs/Pnil3UfoGQRPEc=
X-Gm-Gg: ASbGncsekTh1pOCCsppNO6H9b7M3OlW2fgbBv4f5otbg0uoDZvw0t3YA1Do19RabYPI
 aTkikJF9EDJqSGZxqAR5Nc2kh6RBN967EsRWfWPeUg/Zzbslme0Aut6Rq8pDAN0geTs7Vfs9O65
 KdqqmUtScV+pT2ilVCPpzaT+S28DoRnNoUl+NR5wdi7idu4RmqJyP0PXOjrmv7+mX6TvZvkbVhN
 A==
X-Google-Smtp-Source: AGHT+IEWFx6UqXaZVykPnP5nvKj4ucAeWrF/oD6GTMTqPePbFzdPEE438G51ozSoCxxLRDYDwQbLi5pfScrndV1w3r0=
X-Received: by 2002:a05:6122:3bd5:b0:523:a88b:9ac5 with SMTP id
 71dfb90a1353d-52dba9513d2mr10544621e0c.9.1747615143509; Sun, 18 May 2025
 17:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250409025131.3670-1-jim.shu@sifive.com>
 <20250409025131.3670-3-jim.shu@sifive.com>
In-Reply-To: <20250409025131.3670-3-jim.shu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 19 May 2025 10:38:36 +1000
X-Gm-Features: AX0GCFtO3kXj1aMhC64-UgpDvfU2MpG6YBhHiWgSKP2M-L49JINgffTQR_7zc4o
Message-ID: <CAKmqyKPT+_a5JwK+tHokJWBeEdjj1HEXoQTgrYJN9fC=tJa8-A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] hw/intc: riscv_aclint: Fix mtime write for sstc
 extension
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
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

On Wed, Apr 9, 2025 at 12:52=E2=80=AFPM Jim Shu <jim.shu@sifive.com> wrote:
>
> When changing the mtime value, the period of [s|vs]timecmp timers
> should also be updated, similar to the period of mtimecmp timer.
>
> The period of the stimecmp timer is the time until the next S-mode
> timer IRQ. The value is calculated as "stimecmp - time". [1]
> It is equal to "stimecmp - mtime" since the time CSR is a read-only
> shadow of the memory-mapped mtime register.
> Thus, changing mtime value will update the period of stimecmp timer.
>
> Similarly, the period of vstimecmp timer is calculated as "vstimecmp -
> (mtime + htimedelta)" [2], so changing mtime value will update the
> period of vstimecmp timer.
>
> [1] RISC-V Priv spec ch 9.1.1. Supervisor Timer (stimecmp) Register
> A supervisor timer interrupt becomes pending, as reflected in the STIP
> bit in the mip and sip registers whenever time contains a value
> greater than or equal to stimecmp.
> [2] RISC-V Priv spec ch19.2.1. Virtual Supervisor Timer (vstimecmp) Regis=
ter
> A virtual supervisor timer interrupt becomes pending, as reflected in
> the VSTIP bit in the hip register, whenever (time + htimedelta),
> truncated to 64 bits, contains a value greater than or equal to
> vstimecmp
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/intc/riscv_aclint.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
> index db374a7c2d..5f4a17e177 100644
> --- a/hw/intc/riscv_aclint.c
> +++ b/hw/intc/riscv_aclint.c
> @@ -28,6 +28,7 @@
>  #include "qemu/module.h"
>  #include "hw/sysbus.h"
>  #include "target/riscv/cpu.h"
> +#include "target/riscv/time_helper.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/intc/riscv_aclint.h"
>  #include "qemu/timer.h"
> @@ -240,6 +241,10 @@ static void riscv_aclint_mtimer_write(void *opaque, =
hwaddr addr,
>              riscv_aclint_mtimer_write_timecmp(mtimer, RISCV_CPU(cpu),
>                                                mtimer->hartid_base + i,
>                                                mtimer->timecmp[i]);
> +            riscv_timer_write_timecmp(env, env->stimer, env->stimecmp, 0=
, MIP_STIP);
> +            riscv_timer_write_timecmp(env, env->vstimer, env->vstimecmp,
> +                                      env->htimedelta, MIP_VSTIP);
> +
>          }
>          return;
>      }
> --
> 2.17.1
>
>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33580C3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 03:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0XNT-0008PJ-7Z; Thu, 03 Apr 2025 23:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0XNP-0008P0-AP; Thu, 03 Apr 2025 23:05:51 -0400
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0XNN-0000H4-R0; Thu, 03 Apr 2025 23:05:51 -0400
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-86b9d1f729eso770413241.3; 
 Thu, 03 Apr 2025 20:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743735948; x=1744340748; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IWmnXqdlB0nFjCg5iRnM4KwJZslYg9snhPDyW07FDOU=;
 b=XHcd06iwThgBdTE02ZuNOPibmE4RmjJXZbK+5bcjyJdVJY7EarEVB+4/KrzDKn3o+b
 Wz2NNBbfkamdPG8Q6O7xItBOsa7nmICuUGPmUle+1kiB5KH6m4sC8+MSZJDxpwcqr+pf
 In+uwQfAP/ysN7VgTcOHmDiOSiStbB9WTM6NK1pMz4SkUwV1OMOHZcnT6QuoJ+0dWCDf
 bzF6j35wPb9c5UTIjupRs1lExLNt0xeqFcXQJnn8iutNvZOzq4z7H8Cht2oGx9SCh1W4
 IJvmUdCk/ExT7CCEbZVVN5b0vnXBk/JlrmOYnWO5KVSeTf0HAatSXQbb909543tmcpE1
 KVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743735948; x=1744340748;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IWmnXqdlB0nFjCg5iRnM4KwJZslYg9snhPDyW07FDOU=;
 b=Wb0TRz2CUL40tJ+DTePOF4yl6UwXt0qmOaZ2igRX9o8ozWRjNSMlQ5ub42GbjdmqtY
 2cOgsK3DcrOZEfbqr+lxQel1R1v3gerPB56N02xol8KyiJsTSPFLObiP2WT+WC/h0tGr
 Tte927yjFFC4Bf8OnRfrFbyWKD1IzQeDiYWbMqGXe585OjgpV/EJUeuBIaaLWVwWJZyG
 R89w65EH3hFupEP5bzFgXR3yFhfYxyfsqQO+s2WlrvPDJViDmZJyddVX3oBzuDbq1YH6
 tq4VMPHKmD2C/PGBojXGONhhaEmpyDqHhdd3gPRahl7T8VO7Yxu+ys6ivFj7GeyjkYJ9
 VSJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4qTiuh4xFOiSAjmtNh9ju+ABeLKhSFvZNlBAs0Qx4BakhYFKEfPPAUEYVxLQ3Utq/dcQjBFQvLrvD@nongnu.org
X-Gm-Message-State: AOJu0Yx35RdPn+jIAjeenU3XlgE4U1/y78oN1NgzeU34csDBRH5fTmIY
 VDH8A03lJ4pHvgMW2BqHkzJGkCvU6ce6zrDrF4kLp9WXg8VfhIf8Jvt7pQ7ikN1IFgZejDLogtG
 DMp852ENSPTBLZTadKbhQHCSkpiMqXA==
X-Gm-Gg: ASbGncvM1DgxEbg0jB9p9+tib3B4ytov6M/ZGmQF5yRKNlDho6FKoc8mi0MxR0gFgPB
 weLpVXGhH3j9UTmbNLEz7G0LwtTlElqtSiPRdbQtcqy4FYEvEFHFNqM2pcKT0R/yiG12XT9dBeJ
 2x71RJhnmSCebRM8RsZozP5VHviB8bzAMA0tW2EdqZ8ZP7fQ+9bgWzGz1w
X-Google-Smtp-Source: AGHT+IGxi7hAhGEEeklXfIkN5yeytNfI9Pxn6+LB1mPa0QPDdDlAJLLE4Dj+sIidTI4QRiVdNLcu7+FxpqSvJQmhM7k=
X-Received: by 2002:a05:6102:1481:b0:4c4:df5b:330f with SMTP id
 ada2fe7eead31-4c8554696f1mr1511662137.17.1743735948284; Thu, 03 Apr 2025
 20:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250319192153.28549-1-jim.shu@sifive.com>
 <20250319192153.28549-2-jim.shu@sifive.com>
In-Reply-To: <20250319192153.28549-2-jim.shu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Apr 2025 13:05:22 +1000
X-Gm-Features: ATxdqUF-cQF2UYDxTUJi4TeCcUCCoG1eHiq6te7ZJcsm6t6aVxCzkkmULNrSEaI
Message-ID: <CAKmqyKM5d7JZbkEfNtxGE8yXkgLfxpRkb+Bsn8b=gX_bkAoioQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] target/riscv: Add the checking into stimecmp write
 function.
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x934.google.com
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

On Thu, Mar 20, 2025 at 5:22=E2=80=AFAM Jim Shu <jim.shu@sifive.com> wrote:
>
> Preparation commit to let aclint timer to use stimecmp write function.
> Aclint timer doesn't call sstc() predicate so we need to check inside
> the stimecmp write function.
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/time_helper.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
> index bc0d9a0c4c..aebf0798d0 100644
> --- a/target/riscv/time_helper.c
> +++ b/target/riscv/time_helper.c
> @@ -46,8 +46,23 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEM=
UTimer *timer,
>  {
>      uint64_t diff, ns_diff, next;
>      RISCVAclintMTimerState *mtimer =3D env->rdtime_fn_arg;
> -    uint32_t timebase_freq =3D mtimer->timebase_freq;
> -    uint64_t rtc_r =3D env->rdtime_fn(env->rdtime_fn_arg) + delta;
> +    uint32_t timebase_freq;
> +    uint64_t rtc_r;
> +
> +    if (!riscv_cpu_cfg(env)->ext_sstc || !env->rdtime_fn ||
> +        !env->rdtime_fn_arg || !get_field(env->menvcfg, MENVCFG_STCE)) {
> +        /* S/VS Timer IRQ depends on sstc extension, rdtime_fn(), and ST=
CE. */
> +        return;
> +    }
> +
> +    if (timer_irq =3D=3D MIP_VSTIP &&
> +        (!riscv_has_ext(env, RVH) || !get_field(env->henvcfg, HENVCFG_ST=
CE))) {
> +        /* VS Timer IRQ also depends on RVH and henvcfg.STCE. */
> +        return;
> +    }
> +
> +    timebase_freq =3D mtimer->timebase_freq;
> +    rtc_r =3D env->rdtime_fn(env->rdtime_fn_arg) + delta;
>
>      if (timecmp <=3D rtc_r) {
>          /*
> --
> 2.17.1
>
>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFBEC0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcwv6-0006TW-I2; Tue, 28 Jan 2025 20:31:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcwv2-0006Sc-6N; Tue, 28 Jan 2025 20:31:04 -0500
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcwv0-0002CQ-9t; Tue, 28 Jan 2025 20:31:03 -0500
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-8641c7574a5so1455248241.1; 
 Tue, 28 Jan 2025 17:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738114260; x=1738719060; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qaLUs9twnx89ethfBEVX2/9DHnVMqQcRSUAy5j8RYdM=;
 b=Z9He5/z6Fua1+OpNAApgNNtouv5UwQVwnMKn6CpwFcIonCvPJODYHE/MS55d2zZwNV
 bEGs97sjoR8s9AGkkpA8Pe82qiLTH+WFTui2f8wWrTg/QLQNGHUXOOyhFm1t1iAbR1+A
 BlrkaHb2DN5KEh6qDZJzTZM+goiz47r/KWewq/9x2AtrXWEiJjpjXburKSHDRCN2C6Q7
 P+PqLJgW2B0RJ5siS8jLmm5SoGolqvLlJuhWK9hXGVTOnBlTQ1NDM0rTz9lYe6foQTcW
 r8NfM+V8n7bo/bPz0FFuEWijrH0D1Qce8JA4BsjRM/SrENUTfoJHWBoHkhPArG1unJcz
 deKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114260; x=1738719060;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qaLUs9twnx89ethfBEVX2/9DHnVMqQcRSUAy5j8RYdM=;
 b=Mkzvn/yFgSM/aoThZQzaQBqArpw99M7eZ9SFAno88v7kWsoqz+BAi1K2oXFsLpF8Ms
 YXRNSdaBwCvn/MYc+/lNjFN7LyF4p1ilzzd+MG2VEIpZ2HYKG4xzcNe3x9p9zlznA4PR
 4ao329Dte29EfskNpmn70JIluy5VbFq4XwqNNQzncey4mxl9zYvWP6TZlV68JkUd+2F4
 qKYk3pw9P7hbYqTwqiZgZ4z8B5ImBfoZ+wTkzV5S6RJubXrRSQHtiKKiGKIvZ8VXVvGy
 Nl2bL0VJGdu6r0UJuomGKAYhownjGj68Fn8IroJ6XDE1QcxvaQQwSOo0F4Wpmgpt9h9r
 yUbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBqd/CbVV//DwrbW7MlN0nly9pa/y/Nj6Cwb3KoHuCsS7m+dck54jxYmRfgzrJFotMDXtzZ6CT0qci@nongnu.org
X-Gm-Message-State: AOJu0YyoK3j9EzjLsN333IRTbTT1cVA6EPLQF0WlHO2Je7GXKND8KPl4
 Yq3S7ph3HW723rrRW/3a04YGe7wvHbsuhqdNRQARUX79Cl/ycEnO1AkJXN7cNhfu3CGA4mrAJ42
 F0NTtBMdpWbKjOp4rfCsbNhRfETo=
X-Gm-Gg: ASbGnctFEdfW/W/oXEiOaOzgRmXLSuwg5Lmi9qOrzobZ69elKtYEuPP1t5Nr/0nMTHe
 4F/92YxqlLt5Wl0gSJs+S4u7IwQGvU7f8cQrC1qr2ocXbV8y+QUQnHqDlcUR85oi1/sYDFO9awH
 2CsbHy4Hlost71Eb5YSjmQiYRMqw==
X-Google-Smtp-Source: AGHT+IErclkbByHOVbLcd72MsHRfKWOn6hn+dNTlP0qzB0cbvJ3WM5279XuR5EmfF5qaLPp0YyH5czJcCSUGQNDuHcM=
X-Received: by 2002:a05:6102:3e15:b0:4b2:5c2a:cc9d with SMTP id
 ada2fe7eead31-4b9a5230b82mr1406292137.16.1738114260623; Tue, 28 Jan 2025
 17:31:00 -0800 (PST)
MIME-Version: 1.0
References: <20250124101452.2519171-1-max.chou@sifive.com>
In-Reply-To: <20250124101452.2519171-1-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 29 Jan 2025 11:30:34 +1000
X-Gm-Features: AWEUYZm2vbORMTeE-Aw4qVaKw3xv7oYNkY89t_UXLhUhssO1tGfxt__CBkyXiuY
Message-ID: <CAKmqyKP+cM0eeZ3BnN2R_ToNvKbqcPJsFd8QvZOAWTzAu5g6zA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: rvv: Fix unexpected behavior of vector
 reduction instructions when vl is 0
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x931.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Jan 24, 2025 at 8:16=E2=80=AFPM Max Chou <max.chou@sifive.com> wrot=
e:
>
> According to the Vector Reduction Operations section in the RISC-V "V"
> Vector Extension spec,
> "If vl=3D0, no operation is performed and the destination register is not
> updated."
>
> The vd should be updated when vl is larger than 0.
>
> Signed-off-by: Max Chou <max.chou@sifive.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/vector_helper.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 5386e3b97c5..7773df6a7c7 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -4659,7 +4659,9 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,   =
       \
>          }                                                 \
>          s1 =3D OP(s1, (TD)s2);                              \
>      }                                                     \
> -    *((TD *)vd + HD(0)) =3D s1;                             \
> +    if (vl > 0) {                                         \
> +        *((TD *)vd + HD(0)) =3D s1;                         \
> +    }                                                     \
>      env->vstart =3D 0;                                      \
>      /* set tail elements to 1s */                         \
>      vext_set_elems_1s(vd, vta, esz, vlenb);               \
> @@ -4745,7 +4747,9 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,   =
        \
>          }                                                  \
>          s1 =3D OP(s1, (TD)s2, &env->fp_status);              \
>      }                                                      \
> -    *((TD *)vd + HD(0)) =3D s1;                              \
> +    if (vl > 0) {                                          \
> +        *((TD *)vd + HD(0)) =3D s1;                          \
> +    }                                                      \
>      env->vstart =3D 0;                                       \
>      /* set tail elements to 1s */                          \
>      vext_set_elems_1s(vd, vta, esz, vlenb);                \
> --
> 2.34.1
>
>


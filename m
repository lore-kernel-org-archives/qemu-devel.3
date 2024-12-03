Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE9EE6C614
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 08:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tINpm-0001F0-DT; Tue, 03 Dec 2024 03:00:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tINpg-0001DA-4x; Tue, 03 Dec 2024 03:00:33 -0500
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tINpd-00070i-JM; Tue, 03 Dec 2024 03:00:31 -0500
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-5150f63db70so1408596e0c.3; 
 Tue, 03 Dec 2024 00:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733212827; x=1733817627; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxETQswXqcE5Qi2+tppie1f1NtEF1M+LVuf/RyGAris=;
 b=KbvCJXI0d/v/FyzEZvzZoJffs954+f72zbJ2Rl06NrPw0Eoj9QmGzZJvTHbOPfHTVl
 yk2807kjmB6uIGk6meANRvdAvqSIlCYCHToJYwUhHuCpuLXJE4OxlrRLigIrccZNvQzC
 ymQSi1ykTX1u8Jwe0PT722IiA+Y/W5bKkY8t55/7x3vYboOOJnJXD+5R/wLy5Yvy7TgL
 8WsuKtKbspnBrYdggzPitJM5Q3963phBHRqnEZWX2TD8THswl/GvMvp5q31SyHqNj+ac
 4SLIc/Ikeei8bpW/1zjHZnGfDBaTHFadoHGtLSLQGJJFY/C80ml4UEPsFFOVdXK6cUW+
 XUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733212827; x=1733817627;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FxETQswXqcE5Qi2+tppie1f1NtEF1M+LVuf/RyGAris=;
 b=Lt7qtU55eAM5bhRlcFeki6MV/IiPqYGXENQhImLdUtIpacxD8MeR54tY5LTuQmxPM3
 vll2NCijtdBqzvVZr767V/t5fdz1yMIyHIJQwajoqnV3fIuxLZ4KjtgsyFT6xbb4ce5Q
 XJU0vgoxEy8IIjE+kqXv/95yBXl9n7wKt+u5WxyPmyfH7cUP9+lZoOB5vRijhnyLtvWD
 WRcT9U81yc978rGfBkuo69lZ0lA0WWOncNrzijvTQ/A6kxSGaNRbRr2IhXXbs1+U1D1N
 Vduk11YOvMP/vrsGgESmOXhYx1Y2GvWrwzA13RqJ/n7RTNgNkJ2BNOdpOzGCk7L+bS9f
 1bnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDqY0g/NhyBGH41Afq+c2BXZpeSLptlu1JKhx7zWCtsjlAr0gyZdYVHBnu4TQ0xGCjthYpFJsBRDJ7@nongnu.org
X-Gm-Message-State: AOJu0Yy6balONXleqRKS2egxHA5F1nQgILqVcM2sNaAfYwtyhLCD2wpz
 vg5UMPYHQd0mWGCXDO50YqiRkFwoDwOpzbJ/wm9Ygu4jaiS1K4vh878EI7MII5rie1TlRQpCkvf
 dIaB3yYg82R4J8Q0D5iKvPcdKinLx18By
X-Gm-Gg: ASbGnctM9cGHWDnDF5vGMNWmlgYiEoPDY6kB1bqgSIxIto+6DyZhhebxmVyI+ounz5V
 oDldYL9IER74qJ4BmaGAvNRxJNVITk3IJ
X-Google-Smtp-Source: AGHT+IFTtEJqxa/E5hJ2QtLSJBSQE/K07AKJ3trQXXFfqrW9MjVxlra+coiIFG3+QKDSPYNGCW1o7rBwyTEevwOUdC4=
X-Received: by 2002:a05:6102:d87:b0:4af:5853:fc7a with SMTP id
 ada2fe7eead31-4af973840dbmr2075834137.23.1733212826890; Tue, 03 Dec 2024
 00:00:26 -0800 (PST)
MIME-Version: 1.0
References: <20241203034932.25185-1-fea.wang@sifive.com>
 <20241203034932.25185-7-fea.wang@sifive.com>
In-Reply-To: <20241203034932.25185-7-fea.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 3 Dec 2024 17:00:00 +0900
Message-ID: <CAKmqyKNsPO4=yGcV+UZ6YnFobd3Y9GgN72f+yfKeGBZYBkA6Hg@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] target/riscv: Check svukte is not enabled in RV32
To: "Fea.Wang" <fea.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2b.google.com
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

On Tue, Dec 3, 2024 at 12:39=E2=80=AFPM Fea.Wang <fea.wang@sifive.com> wrot=
e:
>
> The spec explicitly says svukte doesn't support RV32. So check that it
> is not enabled in RV32.
>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/tcg/tcg-cpu.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index c62c221696..3b99c8c9e3 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -652,6 +652,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu=
, Error **errp)
>          return;
>      }
>
> +    if (mcc->misa_mxl_max =3D=3D MXL_RV32 && cpu->cfg.ext_svukte) {
> +        error_setg(errp, "svukte is not supported for RV32");
> +        return;
> +    }
> +
>      /*
>       * Disable isa extensions based on priv spec after we
>       * validated and set everything we need.
> --
> 2.34.1
>
>


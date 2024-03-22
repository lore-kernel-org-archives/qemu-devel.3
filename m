Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5337C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 04:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnWeU-0000IK-8o; Fri, 22 Mar 2024 00:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnWeS-0000I0-Cy; Fri, 22 Mar 2024 00:37:08 -0400
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnWeQ-0001e2-NL; Fri, 22 Mar 2024 00:37:08 -0400
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-4765a8015bbso612675137.1; 
 Thu, 21 Mar 2024 21:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711082225; x=1711687025; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2i46XHZIxmwskYjfKdfd2egddjUx8933ndgD96adCWY=;
 b=EqB75JMi7OkmbQPqLImLRdjIki+BNPBGWU2hBxMXNFfTqPza6bPmiZjkTx2Ne0pt4n
 Uupe9MkTtp/ECG0yrz2RXMO1CuCtctL0YhqW07NPD/oqFPBesAIMN6vccINyBr1PqzSq
 NDtrK7vx3L+yyEXhhgPW2ag1WFQvJQmhkI6jVol61P/1JtdBU7eQmi4LNkX0Xz9CqQ6u
 6RvdEkMW6KPUiaJ8/d2Fasr1Q3bHevhAUs/8KvfIn70cI7WeLOpXyj/cqrKh7ifvGN4z
 NfiRzfJfEZJxLZXN6MAscI6h7mlAu+vCpr1jJ/OJGLaGWhok/nJO0TLYwnUmxOdGGPIc
 m2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711082225; x=1711687025;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2i46XHZIxmwskYjfKdfd2egddjUx8933ndgD96adCWY=;
 b=gJo4bl4RZp8JK0GYuDto6A10F71Qtw3KeD/rW2aw7vyx17NvRRMX6FODlO8vB3G7SZ
 3IBkyDMGbxb4AOjRpfavHYoyOwm+4QIgHl3BF2kQVQKSW7a7ieWrP6h67CmJuBUWe3u/
 JOOtA4XRzMozm25WewKFp+/70Tvh0rWc4xLpED97XlpCWBbsoOMmgNTsKl9COKS7YePR
 fYxpjhWt2h1+vxlr3/jZxgNjwPSyjpUDmDjq29BxfWYt8oMNwy0IFR4izKDZ8M2qXJtF
 GaisCLLPB/0OE5lnZMc1QOyHthdEGc7Zaq65M0O0JtLOha++Ixm3wymtUSuXCOqIExXs
 ihvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBQpHi2IJL8I3DK/cUEKov2mHW1c3uWF4nIlGyPy1OAsaYD2wfqyfhEEuLjgG8RuINaB1YcgWgTHOW8e7nnfKB4gU7Aec=
X-Gm-Message-State: AOJu0YzgNL7wZRH6w9gtQFVNUGQ8Pg+FFpwifNhAAfGNXIUUfW6UKvL9
 IC3NGsThaATCPDuuqCRCo07qi9TjkvJLHe9h8DOajlDgpePmtfS/YNiNFjn7agCq71Kxc3PawjF
 1d2C0IHPGFe1dJtvvJ2iTGJb59Wk=
X-Google-Smtp-Source: AGHT+IEJ/bf+wqpYIwzFgFpmHBqkpwPGcI+B1G11PliVxy2HkfAQ77F2z/vNPM+vLezZqxtjDxTFOBPH2Un2ZHqeTpw=
X-Received: by 2002:a67:fe94:0:b0:476:c86d:a9fc with SMTP id
 b20-20020a67fe94000000b00476c86da9fcmr1437991vsr.9.1711082225266; Thu, 21 Mar
 2024 21:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240321170929.1162507-1-max.chou@sifive.com>
In-Reply-To: <20240321170929.1162507-1-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 22 Mar 2024 14:36:39 +1000
Message-ID: <CAKmqyKPbSEd2OaPta0SwcTn4VMo3E2ueSRH1Av9ALzhi_Ms3vg@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: rvv: Remove the dependency of Zvfbfmin to
 Zfbfmin
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Andrew Jones <ajones@ventanamicro.com>, Rob Bradford <rbradford@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e29;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe29.google.com
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

On Fri, Mar 22, 2024 at 3:16=E2=80=AFAM Max Chou <max.chou@sifive.com> wrot=
e:
>
> According to the Zvfbfmin definition in the RISC-V BF16 extensions spec,
> the Zvfbfmin extension only requires either the V extension or the
> Zve32f extension.
>
> Signed-off-by: Max Chou <max.chou@sifive.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/tcg/tcg-cpu.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 63192ef54f3..b5b95e052d2 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -530,11 +530,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu=
, Error **errp)
>          return;
>      }
>
> -    if (cpu->cfg.ext_zvfbfmin && !cpu->cfg.ext_zfbfmin) {
> -        error_setg(errp, "Zvfbfmin extension depends on Zfbfmin extensio=
n");
> -        return;
> -    }
> -
>      if (cpu->cfg.ext_zvfbfmin && !cpu->cfg.ext_zve32f) {
>          error_setg(errp, "Zvfbfmin extension depends on Zve32f extension=
");
>          return;
> --
> 2.34.1
>
>


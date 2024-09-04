Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A25CD37B5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 00:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sldmu-0000wq-IS; Tue, 03 Sep 2024 20:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sldmt-0000vK-8v; Tue, 03 Sep 2024 20:22:19 -0400
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sldmr-0007jH-OL; Tue, 03 Sep 2024 20:22:19 -0400
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-498d7c37921so2455546137.2; 
 Tue, 03 Sep 2024 17:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725409336; x=1726014136; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C61qDDmE4TSHaYq9v1d7qZZDECeQG4OezP4WL3yCqFA=;
 b=SjKvw6C1YuT8N4n+oz3y8JcgsXNgduJ3zLzvIp+oC410COI0JpisjsXxRE4d0l/P7H
 vbuS9H5sQVPRnGBzy7eny6jnhsgcaMsDB11PPTUZjjBNqXJ5K2u9rMZKOJ4ZJIQFJers
 gM/Y6fSlQjB3HAkwbwgQ/r7GVHLcbtWOPg7FWoTFm5mECV6G+CY7PNVcM9SnGx51ko6f
 +gjyszeRa+3NwpzThFTOzsycBkmcl4qGlb1TbYLz9XckEgUJ9TN8ONb4stXtmJNO9OC/
 bZnF5CUVFZnJRw19G2bcmNsi8zvnjMAUyiHsDPNYup5r3jSgekfNnxXjf69JgvQp3aQR
 /qyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725409336; x=1726014136;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C61qDDmE4TSHaYq9v1d7qZZDECeQG4OezP4WL3yCqFA=;
 b=IzqH9FtxkB9R2D5nc5OYtUNP6g5Hu+bGyCyJ8X4i4okX2ltRFabSMQ+AC/GI53YGJA
 vES2Er2htugwE9fLPDcZTG/f3KEp5l/39JN5YssjsjxCPiavpszw8uOhGE6r7I1o5BWM
 BUegb5ca/XMIpUTVO9dwqizZwR36BUIcZd0ld9irDzCcRIGrGRWqswEDKjWPVlWJzLNV
 955ZhnS1Nlm1DwMGyUBJEdnXKyjrfe4p4PQQG3Jy4g2YfPMkx3Cmdg9Kx7NKd7xSkeUt
 OGXXrJvVOHgdZyhahM6KDdRnv+ZoArbCfOgrI+UBKIwBI4uqpwJLmWHjGkNhattCblI/
 /qLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg3sEXrUIVttx97/9cWHDfFQ3a2dDd35oaB7IFsiPOmVSb7iqMz1011Gb5lUMdGizovxWRSHSirBpo@nongnu.org
X-Gm-Message-State: AOJu0Yzl33p8PlI1Z9LuPP3AyFCeqMVAoXG/cCOze8F290d8MyhMfcbo
 U03JafBR6FjEiukwXWmXFbeneKEtgDCwY6CIPhjgUP4fjEBA9qTd7OubMK4BzN2XqrrVPJiS8Nb
 XZPRbcR3MtDABq48FVoLEWKU1204=
X-Google-Smtp-Source: AGHT+IFRHNZ5ben9BdlLXdHaTqavdgLtr7FBLpPr+lOR0ldPMXCeIdoKEj/gesndom0c5essOFvevV5F32846BilCgY=
X-Received: by 2002:a05:6102:cd4:b0:498:de1b:a8fb with SMTP id
 ada2fe7eead31-49bad26f9d8mr4191862137.10.1725409336118; Tue, 03 Sep 2024
 17:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240902103433.18424-1-m.klauchek@syntacore.com>
In-Reply-To: <20240902103433.18424-1-m.klauchek@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 4 Sep 2024 10:21:50 +1000
Message-ID: <CAKmqyKMg1LGmzMEzAB8JzKzkc2d1Oy+4iP=yHoix1Fp+jdW+UA@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/riscv/cpu.c: Add 'fcsr' register to QEMU log
 as a part of F extension
To: Maria Klauchek <m.klauchek@syntacore.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2a;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2a.google.com
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

On Mon, Sep 2, 2024 at 11:38=E2=80=AFPM Maria Klauchek <m.klauchek@syntacor=
e.com> wrote:
>
> FCSR is a part of F extension. Print it to log if FPU option is enabled.
>
> Signed-off-by: Maria Klauchek <m.klauchek@syntacore.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a90808a3ba..6ff6096777 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -839,6 +839,12 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE =
*f, int flags)
>          }
>      }
>      if (flags & CPU_DUMP_FPU) {
> +        target_ulong val =3D 0;
> +        RISCVException res =3D riscv_csrrw_debug(env, CSR_FCSR, &val, 0,=
 0);
> +        if (res =3D=3D RISCV_EXCP_NONE) {
> +            qemu_fprintf(f, " %-8s " TARGET_FMT_lx "\n",
> +                    csr_ops[CSR_FCSR].name, val);
> +        }
>          for (i =3D 0; i < 32; i++) {
>              qemu_fprintf(f, " %-8s %016" PRIx64,
>                           riscv_fpr_regnames[i], env->fpr[i]);
> --
> 2.25.1
>
>


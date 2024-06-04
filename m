Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F82C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 03:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEKpN-0004st-M5; Mon, 03 Jun 2024 23:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEKpM-0004sO-4t; Mon, 03 Jun 2024 23:27:12 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEKpK-0003J9-Jc; Mon, 03 Jun 2024 23:27:11 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4e8a6159479so1963645e0c.3; 
 Mon, 03 Jun 2024 20:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717471629; x=1718076429; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VFBi49EVUbzCfZZdNzdbeX+72Edejgi/LpWGcb1wyBE=;
 b=h9JRNoEHCnCsBbB4AP/Fmme7237lIjb8qVbjOF8BEkno/JJbg1fNfgmocQwQvnjTYo
 XQrNZKzLeRXPexds2hK/AVcP/Y2rirX6R1Qaf1k3Ht7GlGhdssfKaKU2oTVwEsY456/e
 sX/K2HGG+rWI2bmPF2teYGdWD1qo35h+eSfWneKYhX3YqK/2HXVEnIFix8BtUaKBGgYM
 Oqx4WVnakt05Vk2XPLo2wsZGfULJZo1mqFlb+m/lRXuxIzVyyh0ta4skuglD4ticOlj3
 qEYxHd0ZkNmn30D3Px6CiRte7nOZG7niQAkuBlCY00/nHFTfLhdSF+D//SCoLPqpxpVT
 Xh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717471629; x=1718076429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VFBi49EVUbzCfZZdNzdbeX+72Edejgi/LpWGcb1wyBE=;
 b=unF1PnK+wacMpnEmQc9PPuQLOir7bz2fSDyauuUot+bseXVQEycIdH4fVWN8FylrSm
 RvGLQl9soUC4jK00z9pZA0S3nPYpkmT2lygnqrD4fO3x6vc8p5a+C6WwlAcOB63Eng7v
 xDASCLsGhKCiYfS09ir4wbp0RZo/6PiPdK9Q6ZIZnfn4X3MP4Rw8d1S0NOBpI0XxUScl
 835Stxn57+6xhDAGGmRScrBcbPrWaFxVG0TOr81G/76QBmGBIIVL+vzedPiWsKPE14Xo
 ytzw04Ne5o04DER/dizhNb9fOH2cHs90nk1dHsL0Ql8vIbImHhvA7d8HVa91oT2vIh68
 7cbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiNw11didSzQVC7SiEC5DAKqxg87jWSEz7rQj/Zh0Dbwqaagl7W72/+WZsAQuzcRHVCmc6ijLiMdAFKKe+CaDtrjO+18WIARolXrvbRbNmfCJ0SRrkIuIy+L4=
X-Gm-Message-State: AOJu0Yyh8KnZvX/cqyVs6tRWYCeYiGizGBAJBMU58kjwGvMF8p6bno+D
 wtVDjGB7cRxtP3hfd66EB/fA5pWdoZI6ISjAJXm2itnYU+fRfxjvdUbU5ACEvAjOMI+D9oPG8PL
 BXkllGLpN8POdoyl8awc+prTgAg4=
X-Google-Smtp-Source: AGHT+IHTXBFeAk4Ynip1cuqB/WO1BoRfo1MAK+XDplmj7GyWMoPDaXLakWcalxDidL5r8fl+Tlo9mo4n5oo/uMHn4So=
X-Received: by 2002:a05:6122:d8b:b0:4d1:34a1:c892 with SMTP id
 71dfb90a1353d-4eb02e7ba68mr11172377e0c.13.1717471627180; Mon, 03 Jun 2024
 20:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240524061411.341599-1-sunilvl@ventanamicro.com>
 <20240524061411.341599-11-sunilvl@ventanamicro.com>
In-Reply-To: <20240524061411.341599-11-sunilvl@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 13:26:41 +1000
Message-ID: <CAKmqyKOWfOSyRia4N9KtMwFj=40Optk0DLX7RLA==qKJEd3X8w@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] tests/qtest/bios-tables-test: Add empty ACPI
 data files for RISC-V
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, Haibo1 Xu <haibo1.xu@intel.com>, 
 Anup Patel <apatel@ventanamicro.com>, Andrew Jones <ajones@ventanamicro.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
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

On Fri, May 24, 2024 at 4:15=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> As per process documented (steps 1-3) in bios-tables-test.c, add empty
> AML data files for RISC-V ACPI tables and add the entries in
> bios-tables-test-allowed-diff.h.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/data/acpi/virt/riscv64/APIC           | 0
>  tests/data/acpi/virt/riscv64/DSDT           | 0
>  tests/data/acpi/virt/riscv64/FACP           | 0
>  tests/data/acpi/virt/riscv64/MCFG           | 0
>  tests/data/acpi/virt/riscv64/RHCT           | 0
>  tests/data/acpi/virt/riscv64/SPCR           | 0
>  tests/qtest/bios-tables-test-allowed-diff.h | 6 ++++++
>  7 files changed, 6 insertions(+)
>  create mode 100644 tests/data/acpi/virt/riscv64/APIC
>  create mode 100644 tests/data/acpi/virt/riscv64/DSDT
>  create mode 100644 tests/data/acpi/virt/riscv64/FACP
>  create mode 100644 tests/data/acpi/virt/riscv64/MCFG
>  create mode 100644 tests/data/acpi/virt/riscv64/RHCT
>  create mode 100644 tests/data/acpi/virt/riscv64/SPCR
>
> diff --git a/tests/data/acpi/virt/riscv64/APIC b/tests/data/acpi/virt/ris=
cv64/APIC
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/virt/riscv64/DSDT b/tests/data/acpi/virt/ris=
cv64/DSDT
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/virt/riscv64/FACP b/tests/data/acpi/virt/ris=
cv64/FACP
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/virt/riscv64/MCFG b/tests/data/acpi/virt/ris=
cv64/MCFG
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/virt/riscv64/RHCT b/tests/data/acpi/virt/ris=
cv64/RHCT
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/virt/riscv64/SPCR b/tests/data/acpi/virt/ris=
cv64/SPCR
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bi=
os-tables-test-allowed-diff.h
> index dfb8523c8b..d8610c8d72 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,7 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/virt/riscv64/APIC",
> +"tests/data/acpi/virt/riscv64/DSDT",
> +"tests/data/acpi/virt/riscv64/FACP",
> +"tests/data/acpi/virt/riscv64/MCFG",
> +"tests/data/acpi/virt/riscv64/RHCT",
> +"tests/data/acpi/virt/riscv64/SPCR",
> --
> 2.40.1
>


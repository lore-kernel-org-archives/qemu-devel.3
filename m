Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDFAC83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 03:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugadI-0001MQ-Tt; Mon, 28 Jul 2025 23:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugadG-0001J5-1r; Mon, 28 Jul 2025 23:04:02 -0400
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugadE-0003Rj-9a; Mon, 28 Jul 2025 23:04:01 -0400
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-4e9b26a5e45so2339143137.1; 
 Mon, 28 Jul 2025 20:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753758238; x=1754363038; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x8g/BV20lwwELuWSSxHvwFEO+2Rmf/ujAINqgMwpBuQ=;
 b=SdQy10ms2H4iPIPpU9qT/XAuWafVvuxVQtFHlaheUCO3PX3rYWsUXA4JPza+bEooih
 oVr1sS+NIX4TC+dqPJV6htIB+SSDLTwk0gVcZDVEHHnN+S6cm4Tlk6E0dTEBZ7UOHtNQ
 R0usZozanlNAKkIHFZRTeqBz+VKbi7KhABz6rXHW3yGdrNgw84eJqZTaFjycw14+ZwDb
 D3rsF65Be9ecMGQKxEqXSNTG+WEe00IzaTbyy/Ezv3+JTsjM5/+usHIKc0u5GwO48T4i
 GvEn72TGweDuTSYubMG+rnqUbyDFiDNlYvAYdlAYYDkPtU1se/z8+uShX2TIWXRGGcqq
 CGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753758238; x=1754363038;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x8g/BV20lwwELuWSSxHvwFEO+2Rmf/ujAINqgMwpBuQ=;
 b=SK28ev8ym1x3SJdeJYx7c+T9tjWmkSAcgH2sDiwM4rbQ2T6qlKauJ7qM4mIKxnm6sF
 Rk1XR4qUccn/VvbHLoJWr7MwzJ5IFrN4s7MXEpqUp125gtG/BMqqvp6TM/k1H8pv3kG8
 vjzuWgMIJ+K2Hr9ja0bFOjiJp4jYDhvYr8A0C0vxp5f0OiGCNGCAovMlI4ofU3Slnrhi
 1gfXOLcFWa5Iy2fzXxltFNVL4GDq73SYuewpU2xxIyqZZ2nuloL01iEQ9uQ+jYL/D6tM
 77p1/WLaNog5/xLIz3p5nJFeL19XyLiNFrzBnG+CUhgyJj9GSxu33xtzyNRdvQ/cqMrj
 zWkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWns/MshmNblJG1+1kAjmk7+5Bepv2Q0c5ej5hu67z2uP8aN0aWyBVa4moUSirjpyJTLIrrMz8auOSJ@nongnu.org
X-Gm-Message-State: AOJu0YzXqPD/B0KKkIhYo5MFFa9+DFJYh5Ja7R68n3u4GD+z6x8oZWnH
 +Vy8+0xJwHmragPY5nrdRsPCuhOodkKvcM7xc+yQK574o99OrOmvRdrmkShq8heSyCuSu8p4hlf
 seoKcl+nvYNwJDnIuUv1cWM3DddinlNo=
X-Gm-Gg: ASbGnctt2uax0g40rVSF4MnSZGHDt8ez+xVl1Fr1kgHV5ajEtGr4XKSOnAp1TvwCLO5
 7mXGz0IKQ5tKGnErN7qH/4rUqA6D7xnezGq1DnawuLjUwd53rRxA6NWr72vAVKR3N85qGcvwVzL
 duo0LsVF70aeOcW/c7K4Apon4j4NaRgAuZt24GuRzBOxTjKZkUmOr8tUJr6jVwAYbDMamYhbsfB
 GUiAgOCBfbhxPX73eesjtZLM/FtnYYamd3LaA==
X-Google-Smtp-Source: AGHT+IGLaG1whjpzcVhj3u+KDVG1KH2sipQwvPag+lyWsK94eSTMal3B7K+8GdlUrjusuStSVRBHPRJi26usFeYbsUE=
X-Received: by 2002:a05:6102:2913:b0:4e6:443d:9b1a with SMTP id
 ada2fe7eead31-4fa3ff8311bmr5265263137.24.1753758238255; Mon, 28 Jul 2025
 20:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250724110350.452828-1-sunilvl@ventanamicro.com>
In-Reply-To: <20250724110350.452828-1-sunilvl@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 29 Jul 2025 13:03:32 +1000
X-Gm-Features: Ac12FXya03cZBVJE8m7cZSIf3X3M2lcy3vr6tEj61e3vM32ZoWnOYNhjdqEBOWQ
Message-ID: <CAKmqyKPNsnqTqOkhBDGaNisk9cR58_FkY+c+ebFB9idAbjJ2hw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] RISC-V: ACPI: Update FADT and MADT versions
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
 Atish Kumar Patra <atishp@rivosinc.com>
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

On Thu, Jul 24, 2025 at 9:04=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> Since RISC-V support is added only in ACPI 6.6, it should adhere to the
> expected FADT and MADT versions. Update them.
>
> Changes since v1:
>         1) Updated code comments to reflect ACPI 6.6 chapter number.
>         2) Added Michael's Ack.
>
> Sunil V L (3):
>   bios-tables-test-allowed-diff.h: Allow RISC-V FADT and MADT changes
>   hw/riscv/virt-acpi-build.c: Update FADT and MADT versions
>   tests/data/acpi/riscv64: Update expected FADT and MADT

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  hw/riscv/virt-acpi-build.c        |  25 ++++++++++---------------
>  tests/data/acpi/riscv64/virt/APIC | Bin 116 -> 116 bytes
>  tests/data/acpi/riscv64/virt/FACP | Bin 276 -> 276 bytes
>  3 files changed, 10 insertions(+), 15 deletions(-)
>
> --
> 2.43.0
>
>


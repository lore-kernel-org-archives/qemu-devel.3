Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192B4C3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 23:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTUtE-0000hJ-Gh; Mon, 15 Jul 2024 19:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sTUtC-0000gH-QV; Mon, 15 Jul 2024 19:13:50 -0400
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sTUt4-0008W9-AL; Mon, 15 Jul 2024 19:13:50 -0400
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-4f2ee99e2d0so1431237e0c.0; 
 Mon, 15 Jul 2024 16:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721085220; x=1721690020; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YP2pa5m2p/qQSsKudUcc+T1gLsbfHKca4hCaD7YWDLo=;
 b=jSI7IjYwmJLm9mZ7hLRE3KYEnSLO+FxT9rspCWbZDU5MELif2kvZR40Li1gnxfbn9L
 M7kmsTLR/f9IR10uUoyIuteQdZZylKq3sX3koZe2bTYGF1ohygjnf71lOAbaMShDuqZa
 BJFCfpwRj2KY7MBAnFu0KiuS6ItZT1BeYKX8rqrq4qubA9gUe9ULQogiVEKt9RP8GmDS
 XfdS9yMpFqWUfsKuhb1ZrP4iHaCDoPgmBeAxakosbVZ7tsryWF7EhH2YgjTTOELfFlVL
 ODh5FwyQ7hfJFvjEcPX7l9gOFHO+9OqykLUoNceIQWBEir43KFTZD4HNkccSR1JKt4tM
 VkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721085220; x=1721690020;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YP2pa5m2p/qQSsKudUcc+T1gLsbfHKca4hCaD7YWDLo=;
 b=tDAKHLc7hEDVw0tpdd7RTDZbxHBvGorNRagQiCgS+HaCkHr8nkvbxVVervv4dm1VGF
 hkkGU0ZKh1R5xBkQsiHByDNhn+mUhq+K7cCWfo0nh4KK14jyp+Uv0NtgqgoF8QD0pNH6
 XuVUqPJoZF03gMJg31SLTnou7MGyoNEcXhb8DBgV+DCh3ZlSv3FEUD+9RduBQ6w4LtoH
 H872xJ/+e2dvwUphRwj+r93SkMecZFQvvOu8yznUYpnKu9rvM9wlO43rjP+VpTl1azwn
 TBg1BaWkOtMMnwr/zCdlzRyK1NSRPEr36ccuHZuHgQA069ltEahpFLRxLPt4mqXeF/bx
 oixw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgmdCJ+63vjyZfPIBqdxJl7GcAxnzSk0KkYb8HbYuauDrl6NWHrtKtF4xI8s5iovUvXwqdUFT6Te2YFmhaXMrq+XQlepA=
X-Gm-Message-State: AOJu0YwEKkWBWta7w3JxQMVT2QcBjCdxmArNJtJqJg4IG07B9NsTTjL1
 WlNt+VH1gF59yBt+Nx2pJcJgih7JVJCuKtXwvWKXiQHh0Uu5fFhTEb6FmWVInUhvMqCCGC2Yqjq
 QKZJc0pseINTyv9/jYz1N5VEudM8=
X-Google-Smtp-Source: AGHT+IHjLrzFuSBkYc327CA6YxaV6lK+0UEULzNoG+do9/XliWKanqiHo+A2jjJe2lmuVYxsIJhHdFbBZgo0T7w+jmY=
X-Received: by 2002:a05:6122:3124:b0:4d4:21cc:5f4f with SMTP id
 71dfb90a1353d-4f4d08636femr459984e0c.11.1721085219978; Mon, 15 Jul 2024
 16:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240715090455.145888-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240715090455.145888-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jul 2024 09:13:13 +1000
Message-ID: <CAKmqyKO5Gi=pr=fFmqXJ8qgLNQ7tzecjRkdYns7syxEmZDKAXQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/riscv/virt.c: re-insert and deprecate 'riscv,
 delegate'
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, Conor Dooley <conor@kernel.org>, 
 Anup Patel <apatel@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Jul 15, 2024 at 7:05=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Commit b1f1e9dcfa renamed 'riscv,delegate' to 'riscv,delegation' since
> it is the correct name as per dt-bindings, and the absence of the
> correct name will result in validation fails when dumping the dtb and
> using dt-validate.
>
> But this change has a side-effect: every other firmware available that
> is AIA capable is using 'riscv,delegate', and it will fault/misbehave if
> this property isn't present. The property was added back in QEMU 7.0,
> meaning we have 2 years of firmware development using the wrong
> property.
>
> Re-introducing 'riscv,delegate' while keeping 'riscv,delegation' allows
> older firmwares to keep booting with the 'virt' machine.
> 'riscv,delegate' is then marked for future deprecation with its use
> being discouraged from now on.
>
> Cc: Conor Dooley <conor@kernel.org>
> Cc: Anup Patel <apatel@ventanamicro.com>
> Fixes: b1f1e9dcfa ("hw/riscv/virt.c: aplic DT: rename prop to 'riscv, del=
egation'")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>
> v2:
>  - changed commit msg to remove the 'dt-validate won't complain about
>    it' bit since that was incorrect.
>
>  docs/about/deprecated.rst | 11 +++++++++++
>  hw/riscv/virt.c           |  9 +++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 20b7a17cf0..88f0f03786 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -479,6 +479,17 @@ versions, aliases will point to newer CPU model vers=
ions
>  depending on the machine type, so management software must
>  resolve CPU model aliases before starting a virtual machine.
>
> +RISC-V "virt" board "riscv,delegate" DT property (since 9.1)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The "riscv,delegate" DT property was added in QEMU 7.0 as part of
> +the AIA APLIC support.  The property changed name during the review
> +process in Linux and the correct name ended up being
> +"riscv,delegation".  Changing the DT property name will break all
> +available firmwares that are using the current (wrong) name.  The
> +property is kept as is in 9.1, together with "riscv,delegation", to
> +give more time for firmware developers to change their code.
> +
>  Migration
>  ---------
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index bc0893e087..9981e0f6c9 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -651,6 +651,15 @@ static void create_fdt_one_aplic(RISCVVirtState *s, =
int socket,
>          qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegation",
>                                 aplic_child_phandle, 0x1,
>                                 VIRT_IRQCHIP_NUM_SOURCES);
> +        /*
> +         * DEPRECATED_9.1: Compat property kept temporarily
> +         * to allow old firmwares to work with AIA. Do *not*
> +         * use 'riscv,delegate' in new code: use
> +         * 'riscv,delegation' instead.
> +         */
> +        qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegate",
> +                               aplic_child_phandle, 0x1,
> +                               VIRT_IRQCHIP_NUM_SOURCES);
>      }
>
>      riscv_socket_fdt_write_id(ms, aplic_name, socket);
> --
> 2.45.2
>
>


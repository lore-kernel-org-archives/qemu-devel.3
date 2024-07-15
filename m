Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEC9C3DA42
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 00:37:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sT9he-00049H-BS; Sun, 14 Jul 2024 20:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sT9hc-00046z-DP; Sun, 14 Jul 2024 20:36:28 -0400
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sT9ha-00010c-NA; Sun, 14 Jul 2024 20:36:28 -0400
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-4f2f39829a9so1301512e0c.2; 
 Sun, 14 Jul 2024 17:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721003784; x=1721608584; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sTNGB0fyGXxdKkWp2awMuHK25c5Y18PIoVdDO2+siOU=;
 b=PmpmmGRlaJ+/R+kf3sxefwlRiVt1ogFTIsrSVLwYZmqFLlI8GpsdGHl64+LrysyXyD
 lPtsB/9ma/+igutMPkOXSmSdzspscC1DznoWYaLId5NQ+yTt+7h7omigjchWgjzlBDd1
 BdecCdLMFZBbuN9nIBIFQe4DLJR07puwHMa86lv5+Bbuluqg0k0+e6PMmPV/w7b/XKgK
 fblGH3x3MINMjJsxKOPiMAfDjnu0tP8YBB89hCNdj+DHzz//PX/jbDvu3BWWcQOuH/ug
 7mQOQ6jZejk0vVLT81yaB1414MYdLHrAXsowlBG1r90a/1iH+IHCQPrPPGxTiNW2bT4E
 DsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721003784; x=1721608584;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sTNGB0fyGXxdKkWp2awMuHK25c5Y18PIoVdDO2+siOU=;
 b=CssGmenpQ1Hmpb6HIOj5hGC6saFYD1k0vLV4mrl1YI27gNWYRFTY6CLUI+X7DUN9pN
 ycuaPX9Ynk3c3iMuIZj6YzZ6WdH81vz5/VOkK9rMWwKDo2cUvgntaxD+suPkX/GusvM/
 mt8kk0JvQ+I5qCm/e4m1WkFG2Sz47Nx06q6yldjn9lGg2SkvFvFtHwtr+Ma8MOZkqm3o
 kLEZf5afhv3lRf7oG0omcdk4XPhIMIEeb824kPW//Rn1FzbLhiVTjDTetuzEFHJjeRbW
 Ba2hjzgDWvEpRQo3MhHOa53UTiu0ts8LBulc/vtOIwQieyloRgwdAs2XaSicA+gX813n
 z5jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ2QQ846WDysSqJsehnlU29LQJ7b6FDRQGQUXBjtg7yJUONz8Y8ofI/TCTB5RTOwhuydfyavVFM8qyh4x4S/bkPtmqJEE=
X-Gm-Message-State: AOJu0YwJ8aiBYGpeL1bA8Q1d4/3DlXoHQ9qGihYNT/9pgSXl3M+s+SIX
 Oh42T4jqRY1IT6PygmWZCRyjb4bXeO/dLprg2PgCAWf9DqVyl3IfUi3XhFyTgWsvLoJX7Cxvq70
 IrBmY/t52Ze7EUc3q0hdSeVZBrPE=
X-Google-Smtp-Source: AGHT+IGWFMdXnaZYcIU0kohzI46jugKHee1Jbq0pEhVcVq4Y3vXt+iErmrn+yH/5CQ0GbjM8IXiiffkfGwK7TvcJ9Io=
X-Received: by 2002:a05:6122:3c88:b0:4f2:f1df:89c3 with SMTP id
 71dfb90a1353d-4f33efcc8b1mr23649157e0c.0.1721003784036; Sun, 14 Jul 2024
 17:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240713174325.107685-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240713174325.107685-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jul 2024 10:35:57 +1000
Message-ID: <CAKmqyKP1dTXoaRWGX3cCAY4VmqFtBbpjCjDsmxbMyyM6gAzPRg@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/virt.c: re-insert and deprecate 'riscv, delegate'
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, Conor Dooley <conor@kernel.org>, 
 Anup Patel <apatel@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
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

On Sun, Jul 14, 2024 at 3:44=E2=80=AFAM Daniel Henrique Barboza
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
> Re-introducing 'riscv,delegate' while keeping 'riscv,delegation' will
> make current firmwares to keep booting with the 'virt' machine and
> dt-validate won't complain about it since we're still using the expected
> property 'riscv,delegation'. 'riscv,delegate' is then marked for future
> deprecation and its use is being discouraged.
>
> Cc: Conor Dooley <conor@kernel.org>
> Cc: Anup Patel <apatel@ventanamicro.com>
> Fixes: b1f1e9dcfa ("hw/riscv/virt.c: aplic DT: rename prop to 'riscv, del=
egation'")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
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


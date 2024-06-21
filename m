Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DC2C2BA18
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 01:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKSv5-0006uQ-Kc; Thu, 20 Jun 2024 21:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sKSv3-0006td-FC; Thu, 20 Jun 2024 21:18:25 -0400
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sKSv1-0003kO-SX; Thu, 20 Jun 2024 21:18:25 -0400
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-48ed52b59acso550749137.1; 
 Thu, 20 Jun 2024 18:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718932702; x=1719537502; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sQefYDcRDKx2mETSvmE1rP9bHZNUYtmYm3McKVPfHbA=;
 b=FyYd1JP9GbnxfEIiKo1uoUHYBWtv4Mt4aJXpnL3JlRbQ7mJnPJcpbLO+lWiV4WDpRA
 zW3jT1DaZhjPpgzJo0Wao0BNwgz43JJ3N/6402uJqMaH6rNKJjB/fgfEJnHk+9oes1RG
 ycalw/p7BASDpsTPJ3lVXyPeNkJS5Hv0t7TqeE8XTYsQWJ5oD9pZ8zxd3z3X7ggM7mGR
 5eSlPaCRMC6OrM9qaTrkwxHYXnW0Xt6rjFiVr+UsIIMMN2kj630YycFC6kQi22bm0hI0
 UV7gmHpoi300wWDdK/qeyHYfQhrTMEc3q6m5uNGGrHQ9pH0Byg7q7qJW3F2Ww2xjX7Og
 ySMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718932702; x=1719537502;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sQefYDcRDKx2mETSvmE1rP9bHZNUYtmYm3McKVPfHbA=;
 b=vEG08i6M5Oo8J8bKVLQqmHGak953sVTFCxVVnNvz+yURWi9OEb/uDGNkRjmQktbdnF
 W3TJOfeWyITvdpDgJzWGwD6IO6lxl8CtjUYQyfsgZ+yQpkBGIZJc7p2+J4vTC2EJjNV7
 1O94CRd4y4BnMmxaL/y69FoZyx9PI5E8vRDFGPJABKyZeK82SD1SMl6tk2t2OakiW2cg
 knC632hTmduh/Tx0QpIbqNftBFdhfneSxqtuswHmcpJ9LlAlUEXduhjjnqjqyHZgwH6y
 sO+KWAkB26w6Ab1whi3V+RHDRkyoLLw+NV4M35O9X3Z4GEGz3AybIg8Ms6eAeoVS46IY
 Yw/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTgLpKW4ZcVdbfNuqnnvfmc++8g64pL8DFGPmePhk18RLVs0gg9xVix0dYH0bbHtlluQpgogeQqLIXRm0iT8uDwf87u3w=
X-Gm-Message-State: AOJu0YwYaYBoITTlPBWpPxtl+Ag1HlO0FnAS6+6zVRDiTq1zcWMEIKop
 p4Q0jaINuL4jd2Sfwgw0EkXKnLYHfZv63gRq0eJmgYHqoS4mbxT1Bs7Dm7n75GD2gODuYqslQP7
 cuZpeTQeTw5Z1Pugr0PfNr9jOPIw=
X-Google-Smtp-Source: AGHT+IFOfnY22n/PqR/hGczSfXyXeEkHn2iOmcrbIw9G2pC/5Z0AlLZab0n9elW19Qm03PsZuxB4AW1OsUTpDsRa9u4=
X-Received: by 2002:a67:ff07:0:b0:48d:88b6:9476 with SMTP id
 ada2fe7eead31-48f13008bdcmr7026012137.7.1718932701698; Thu, 20 Jun 2024
 18:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240620064718.275427-1-sunilvl@ventanamicro.com>
In-Reply-To: <20240620064718.275427-1-sunilvl@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 21 Jun 2024 11:17:55 +1000
Message-ID: <CAKmqyKNoq07ApxXXFFwuBrAQ_x-7coMbBJ4tXdeYb=tJLTvMmg@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/virt.c: Make block devices default to virtio
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Anup Patel <apatel@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe32.google.com
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

On Thu, Jun 20, 2024 at 4:48=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> RISC-V virt is currently missing default type for block devices. Without
> this being set, proper backend is not created when option like -cdrom
> is used. So, make the virt board's default block device type be
> IF_VIRTIO similar to other architectures.
>
> We also need to set no_cdrom to avoid getting a default cdrom device.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 8675c3a7d1..b0871b7f81 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1764,6 +1764,8 @@ static void virt_machine_class_init(ObjectClass *oc=
, void *data)
>      mc->init =3D virt_machine_init;
>      mc->max_cpus =3D VIRT_CPUS_MAX;
>      mc->default_cpu_type =3D TYPE_RISCV_CPU_BASE;
> +    mc->block_default_type =3D IF_VIRTIO;
> +    mc->no_cdrom =3D 1;
>      mc->pci_allow_0_address =3D true;
>      mc->possible_cpu_arch_ids =3D riscv_numa_possible_cpu_arch_ids;
>      mc->cpu_index_to_instance_props =3D riscv_numa_cpu_index_to_props;
> --
> 2.34.1
>
>


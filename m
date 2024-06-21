Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A03C2BA18
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 02:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKTiu-00068N-3A; Thu, 20 Jun 2024 22:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sKTit-00067y-6g; Thu, 20 Jun 2024 22:09:55 -0400
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sKTir-0003ai-Q3; Thu, 20 Jun 2024 22:09:54 -0400
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-4ecf11df664so386993e0c.2; 
 Thu, 20 Jun 2024 19:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718935792; x=1719540592; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WU+VLKo55W06/DCKARvCNWyt7VOTierA8uAlS4QSXB8=;
 b=JjppT+ORK5LUmwK4qWMFUynZUhcn69QFmjZRmVVengR3GXh41wBeGQQ2/GhEBqI8hR
 bm2On7Zy6NqRgPl4yvaVeRSOV976tbnUOf2F4jktOQbs8MyY3/Db2SoR44Uc62CNs8iV
 x3mX316xYQ9QAw43WZ+K0hF086IYlv9uLhR+s/IDMR8Yzi6cVQHTvO1eBM0el08Xtine
 oB5wsXPpTuByMxYskaJJ67+uoB6E2Gk5hSTNz6yg+qy87yxKdB/YA0QfpW8UrDkRiJz6
 5wAn7EiZJSQq6cgc33XOKKXW9w7CH+lqJ5gpgpJcUxk2SaIdkSHqtO9Z6IWP77aMhL7C
 Nv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718935792; x=1719540592;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WU+VLKo55W06/DCKARvCNWyt7VOTierA8uAlS4QSXB8=;
 b=HkKZ974uUbXPU2KgLrnTMHKIPGUn3ijmOowsHNcmXTW0HLJ+SJ5QONqA2wDaCTlw36
 hmuGm9GJTmV87ndqLO1GGVFkQSzlbjmLyQ5sbjeOaSBmi7SAWAcz4hfBwfJmapzwgjgX
 U0dSAzZRz3VhNKlxRxWSymm7WGqyyW09+EDLCsV0Hf/S5+/3T+CrBG+S1bPe63mNV5aY
 IeJcFDuRS6Bm6LJuZ6ADps6OwDUgwWOZcdH7XffdnwFzzNXgpUhkAIo0YeW7GLTPW4GX
 wDBnnn4vVxZoIXPrE5V+G84kuR+1dCJ8ysh+hBI/pTtZa2EVGch17RlQM4SjHVderdE6
 0e8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlh1Vzf2n6oZefiWMmqGSTJExri/6JcWjuxY+qR2lFJ9V3GMYi82rIVAKMw3LK7uS9xNDgK/s92VCFGsl9iJoYMxbtzbo=
X-Gm-Message-State: AOJu0YzW8QdwWwxO6TS0iErdIJQHm6oOeuXMQSlsnOoM6VY8Z9KrBweW
 CIzSackH6QGEvMSmNLp2tBSOsXxbJqI6IF37s8RPxWzw83s2NyMT4OidnzORNnUGy5yqioORCqY
 HtucPREn+riuIkZfb0+x5Pg7+sIM=
X-Google-Smtp-Source: AGHT+IETCJahy6eFu6nYz4YB7DGpDecbtqKpRxIrfc0YUF/m6KDL/x1HJqDyvuNoeGqFyQZw7iNG0xN3eCFvvjpuZVA=
X-Received: by 2002:a05:6122:738:b0:4ef:320f:9f13 with SMTP id
 71dfb90a1353d-4ef320fa00bmr5254510e0c.0.1718935792390; Thu, 20 Jun 2024
 19:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240620064718.275427-1-sunilvl@ventanamicro.com>
In-Reply-To: <20240620064718.275427-1-sunilvl@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 21 Jun 2024 12:09:26 +1000
Message-ID: <CAKmqyKPe8ks0Ohnw2JUy2YB8-9wTH=_fX_DdtqrwNYu=BXG6RQ@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa33.google.com
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

Thanks!

Applied to riscv-to-apply.next

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


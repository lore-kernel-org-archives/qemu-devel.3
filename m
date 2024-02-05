Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690B3C4828F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 02:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWpCQ-0008SG-C0; Sun, 04 Feb 2024 21:59:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWpCP-0008S3-4N; Sun, 04 Feb 2024 21:59:09 -0500
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWpCN-0006p5-Lf; Sun, 04 Feb 2024 21:59:08 -0500
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-7d2e21181c1so1979602241.3; 
 Sun, 04 Feb 2024 18:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707101946; x=1707706746; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uUWSDY/q/U0JePTCElKjn0OAaT5Ppg2W3L7jH8akprQ=;
 b=cFoQ9AJ7uiH81RYniKRsGxDvXNqQ+JH3q1BNvBgeo0tYEQzdqaNofIhBax/yr7B1xn
 3YlMHy7Vdu9hHtq+lkc3QYzyWMqHJJgB7f3NR3YeFZnFEs0TZ5zhMS4Br4KZghzFsunR
 1v1+7wXnxlRGZ15zF76tSOieUiu63Ue3/bu0xye//IiCBfG7miG8yKz/GX46FNKsBB/T
 q8ZDfNMg4G/+PgtQ6+UJWSk9V1dZSH9Ptw3g0II8DUeohRmthWaExFYQlb1EubB3zWtK
 dvVX1X0jvbZzUMq7PrghFkTCq0tmSZBXfBk09S6DfJrD8kjcGfMn39ybI5LyJBdw4JRB
 ECEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707101946; x=1707706746;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uUWSDY/q/U0JePTCElKjn0OAaT5Ppg2W3L7jH8akprQ=;
 b=h8Z6rz47D59a4MU/+KNUeQ+oIuQzQ6H3rg8oqJVZ7rZk9lOTKV6yf2y/CbgGP5aJdO
 ptuBOzC/vHn00ITK8aIX+hFez2nEDcD8Bg9k5gjrol/1FtCdYoWIjtl6G2oiOtp81d1N
 wowIMCV+PBnhT2ZFOwK2rQpEVmxwSMWUsNl6JmIGpaVZRsc7FvMM5wIFZuaqgMMhjpzG
 K4Xn5eWDNepYweNtTOrWLQmg+bodfjWdkCXTRJ/jqa+p9O/0rOzVDZMI+h/TlZeOKNGy
 IYQy36ULhUajQPSf1qzXfYT78Q4z1JD9Ft3vFS4DQtWYAJ9ot8QGIYcD1lDcfCFR8hF+
 Ya7Q==
X-Gm-Message-State: AOJu0Yx5ld+mAAtx/e3DfaIsVMn6JYkUfOsz9Fer1x9WAMcWtboeXhs0
 NefaTleOYpF439J56h9Uy2+dter58KdgdMyQvMr0/9zmag0QHmwthW657Gv5KkaOBJ1YwtCHMLW
 ddirKDEvGPOFA+fjbrhad1VmpIyQ=
X-Google-Smtp-Source: AGHT+IEZZ1fT1JeDi1NhS4cEICFh1caFwsQyyKbr+2JSVHqZyrs8e9/Mt7kTn9JXYUWXESrnK28h3YJ/fJxR/Xc0d1s=
X-Received: by 2002:a05:6102:9a8:b0:46b:34ea:8fcd with SMTP id
 f8-20020a05610209a800b0046b34ea8fcdmr7595411vsb.8.1707101946189; Sun, 04 Feb
 2024 18:59:06 -0800 (PST)
MIME-Version: 1.0
References: <20240122221529.86562-1-dbarboza@ventanamicro.com>
 <20240122221529.86562-4-dbarboza@ventanamicro.com>
In-Reply-To: <20240122221529.86562-4-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Feb 2024 12:58:40 +1000
Message-ID: <CAKmqyKOsseXBLeYineLAWfq8B2roqapRSN3EoqEqCri4zz7Vbw@mail.gmail.com>
Subject: Re: [PATCH 3/7] hw/riscv/virt.c: use g_autofree in
 create_fdt_socket_cpus()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x933.google.com
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

On Tue, Jan 23, 2024 at 8:16=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Move all char pointers to the loop. Use g_autofree in all of them to
> avoid the g_free() calls.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index f9fd1341fc..373b1dd96b 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -215,12 +215,16 @@ static void create_fdt_socket_cpus(RISCVVirtState *=
s, int socket,
>      int cpu;
>      uint32_t cpu_phandle;
>      MachineState *ms =3D MACHINE(s);
> -    char *name, *cpu_name, *core_name, *intc_name, *sv_name;
>      bool is_32_bit =3D riscv_is_32bit(&s->soc[0]);
>      uint8_t satp_mode_max;
>
>      for (cpu =3D s->soc[socket].num_harts - 1; cpu >=3D 0; cpu--) {
>          RISCVCPU *cpu_ptr =3D &s->soc[socket].harts[cpu];
> +        g_autofree char *name =3D NULL;
> +        g_autofree char *cpu_name =3D NULL;
> +        g_autofree char *core_name =3D NULL;
> +        g_autofree char *intc_name =3D NULL;
> +        g_autofree char *sv_name =3D NULL;
>
>          cpu_phandle =3D (*phandle)++;
>
> @@ -233,12 +237,10 @@ static void create_fdt_socket_cpus(RISCVVirtState *=
s, int socket,
>              sv_name =3D g_strdup_printf("riscv,%s",
>                                        satp_mode_str(satp_mode_max, is_32=
_bit));
>              qemu_fdt_setprop_string(ms->fdt, cpu_name, "mmu-type", sv_na=
me);
> -            g_free(sv_name);
>          }
>
>          name =3D riscv_isa_string(cpu_ptr);
>          qemu_fdt_setprop_string(ms->fdt, cpu_name, "riscv,isa", name);
> -        g_free(name);
>
>          if (cpu_ptr->cfg.ext_zicbom) {
>              qemu_fdt_setprop_cell(ms->fdt, cpu_name, "riscv,cbom-block-s=
ize",
> @@ -277,10 +279,6 @@ static void create_fdt_socket_cpus(RISCVVirtState *s=
, int socket,
>          core_name =3D g_strdup_printf("%s/core%d", clust_name, cpu);
>          qemu_fdt_add_subnode(ms->fdt, core_name);
>          qemu_fdt_setprop_cell(ms->fdt, core_name, "cpu", cpu_phandle);
> -
> -        g_free(core_name);
> -        g_free(intc_name);
> -        g_free(cpu_name);
>      }
>  }
>
> --
> 2.43.0
>
>


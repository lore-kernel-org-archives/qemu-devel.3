Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2CCC27C50
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 00:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEeZ8-00064R-J0; Tue, 04 Jun 2024 20:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEeZ3-00062v-OB; Tue, 04 Jun 2024 20:31:42 -0400
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEeZ1-0004ip-AV; Tue, 04 Jun 2024 20:31:40 -0400
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-4e4f0020ca3so564567e0c.2; 
 Tue, 04 Jun 2024 17:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717547498; x=1718152298; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Abu6w6UYmgqYZztZpjNqKH+OXhgQvA2ezFBaJ4bjAW0=;
 b=JjjinAOEuRh/SxrLDG5L2c1Xvyw9yW4ksMcUZPhh7X+7kgoKbDEzWoPXOjNgZF7cVt
 6hdwPmKHbg7M40MBukSsbzGRUwnkXwKNVw9IQm9fAFjZZcxE7+OUY61tLX/rmVUOByrJ
 VVbqDcbqfWHQApRjkaIVobOFY/1NEVE38bMcS2dnjwwtPOgH50HmoFA6dTbUTWKWWo+T
 2G5ugnMVfScm14Q5SizNyOWl5k0VHklub6ZYPa3+kabmM0YHWGV4S4n4ZlL3GTPaRKcY
 kxHICz/bJ3hKVrYtLWYdWVdMEqzv1cASXRA7T2j/fHNjpTc6yldlQ2JNk5ISda5hyAIX
 DYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717547498; x=1718152298;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Abu6w6UYmgqYZztZpjNqKH+OXhgQvA2ezFBaJ4bjAW0=;
 b=X5lMogvwC1yhpsJNTzJ3ZwVpFiU3TsCpjarztej69ZoyAikUWX1Mlwl+soBfe156Ku
 4K/ZiFa7ppmIYM/uIQoSxz6t/i2GhB/o8IiaQo5wyVDn5LTaFFcfuGt3dQeQu8FBYw8T
 NAfpaLvVojV40TM3dG7P9ITifaq4vAyGtBheYGW94XmspGEnmdOJvEZVMkTPB5FJAhS4
 haBS58YCzuqvAzMW7Yc0LkulShEoNu5VGK5L9wK3d/U2z3PqsE9VKfWMHzQtNY0Luxz+
 AQr6rv1NINNdDtzjtDNmquAslrlHNYct7L2xnbtR7mwWAPcI4o+y2QRnjMuvWO9AKaBt
 aAaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU94Pv0WaNJdnJXh8DldP/MjSakjGvfCIJkIDmRLxDbmMSrbH+x02bompiUpIL9PmFkgIy77TdKD9BWxVKIaCVgFK+ZjwM=
X-Gm-Message-State: AOJu0YzKgzFpn3aDcXPFiwN1wN5W5zyFyauiwO+xYaZSQh/dCi4rfjU4
 InIP7mZlUKCuDMMwEq07Sb0gzBueOpEqMDXKZrcjGtUqIyK/Cy5EVEZk50VgE874niomzujBe64
 1v0UhL4TzrJjLIueuS6azUvUjPTg=
X-Google-Smtp-Source: AGHT+IEyTzcFxH5dXtc+7P+1BzvdwkKC1COYO0eGGxrqUXUDLdMncJKLV3XSPcn3I8sIZ6+yuC++z8UZhaKPd7/8ByM=
X-Received: by 2002:a1f:4845:0:b0:4df:261c:fc0c with SMTP id
 71dfb90a1353d-4eb3a4ff145mr1324274e0c.13.1717547497713; Tue, 04 Jun 2024
 17:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240531202759.911601-1-dbarboza@ventanamicro.com>
 <20240531202759.911601-5-dbarboza@ventanamicro.com>
In-Reply-To: <20240531202759.911601-5-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 5 Jun 2024 10:31:11 +1000
Message-ID: <CAKmqyKMLWKPD4FjXS4SoAYqd1f66m-0jpqjSNpQtpmiWj+xy0Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] hw/riscv/virt.c: aplic DT: add 'qemu,
 aplic' to 'compatible'
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, apatel@ventanamicro.com, ajones@ventanamicro.com, 
 conor@kernel.org
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

On Sat, Jun 1, 2024 at 6:31=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> The DT docs for riscv,aplic [1] predicts a 'qemu,aplic' enum in the
> 'compatible' property.
>
> [1] Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.ya=
ml
>
> Reported-by: Conor Dooley <conor@kernel.org>
> Fixes: e6faee65855b ("hw/riscv: virt: Add optional AIA APLIC support to v=
irt machine")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 5505047945..366fe042cc 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -606,6 +606,9 @@ static void create_fdt_one_aplic(RISCVVirtState *s, i=
nt socket,
>      g_autofree char *aplic_name =3D fdt_get_aplic_nodename(aplic_addr);
>      g_autofree uint32_t *aplic_cells =3D g_new0(uint32_t, num_harts * 2)=
;
>      MachineState *ms =3D MACHINE(s);
> +    static const char * const aplic_compat[2] =3D {
> +        "qemu,aplic", "riscv,aplic"
> +    };
>
>      for (cpu =3D 0; cpu < num_harts; cpu++) {
>          aplic_cells[cpu * 2 + 0] =3D cpu_to_be32(intc_phandles[cpu]);
> @@ -613,7 +616,9 @@ static void create_fdt_one_aplic(RISCVVirtState *s, i=
nt socket,
>      }
>
>      qemu_fdt_add_subnode(ms->fdt, aplic_name);
> -    qemu_fdt_setprop_string(ms->fdt, aplic_name, "compatible", "riscv,ap=
lic");
> +    qemu_fdt_setprop_string_array(ms->fdt, aplic_name, "compatible",
> +                                  (char **)&aplic_compat,
> +                                  ARRAY_SIZE(aplic_compat));
>      qemu_fdt_setprop_cell(ms->fdt, aplic_name, "#address-cells",
>                            FDT_APLIC_ADDR_CELLS);
>      qemu_fdt_setprop_cell(ms->fdt, aplic_name,
> --
> 2.45.1
>
>


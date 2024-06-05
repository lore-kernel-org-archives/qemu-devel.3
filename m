Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5A6C27C50
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 00:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEeMy-0003Il-MQ; Tue, 04 Jun 2024 20:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEeMx-0003Hr-2s; Tue, 04 Jun 2024 20:19:11 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEeMv-0008Q0-79; Tue, 04 Jun 2024 20:19:10 -0400
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-80b497f7576so14241241.1; 
 Tue, 04 Jun 2024 17:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717546747; x=1718151547; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+S8bjZ7jiCvl0zQKEWwXOK3CH/7UFyA3n1NpFw4vA0=;
 b=j0fRbz2pHcK+RyYtgi+ILLZ+PkQJZuxg6YVlRzgUYycZIeG8KLXKhiSPcW4lhg9ztf
 dzA4UQMICY38R6f0sWc3vzrc9UpbjGIGBq2X/he+YAMlP8mjr0oReDnQED66M1/zkfwd
 CJ9wmiddJiIdPhNQD1O5cP4DfmN3BYtjc9ckLtvd30NUkyziOGGdvYaZ4mXWqgIovbts
 4kykSdpVMSHk1TbEyQYzrs430//otSc8yUzn3iwD96+NzG5pG+8Di0YBexfrdbvGP2N8
 q4Kr2ie3aKEOfxj5t5+UW2iu+VVqxkLBDukXeWren+VLAbrLFKNfbWtgGreEazG7tXhE
 0gJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717546747; x=1718151547;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d+S8bjZ7jiCvl0zQKEWwXOK3CH/7UFyA3n1NpFw4vA0=;
 b=moMoK5obm/+HxbVZkFdZO1V5i1s57uLAE4hdqbD1DTR6qRqKmYIUd11rMwaM5gdwvh
 dYXagVScDDiN/yMImpcq1ZX+iCmZrJnr7Y4VzpndQC4Zw1bialJPJ5g2DdW+G9fvUrXA
 lC4YQOp4060Etn43/R0zwiZniKTyXel/NJIthAWlZCGUllhKl3wrAYNjOVVSxWl1Dfc2
 WmA1c0dr1sRAnnREU6sDhIiC9Yb5FEzlPjA2gLCWgwWaciPZFBLfR7TovLTgX5l8LJbv
 koWJVj9mjRHUSS9F0LFI7bnPuzLZ8Nm9AtWjMohgoWf5rRW3Et93CiiVskgd1kKJjOJg
 V0jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+N7R0WyttSQp6EQwtVU8pk2QDAySWi9eMnBIvbLpvsjiwVWSJmrKVUcR+Y9TRIBfCiJcWVqZvXPE+v6j0ZeER9aLe4Fg=
X-Gm-Message-State: AOJu0YyzcGJpXIkKzPDnxoNjjXMlitJUPAm7nrMu1uF4J+egr0Y4icYE
 326ziOtWQFrMbHwCZnEl+co/eCQUnPVxqOuf5QH9h7ZKj9YG6GxNOjKujXtX/KEisc3S1RGg92N
 2OHxce8+4HTsq4n1djfAI0ctkjM8=
X-Google-Smtp-Source: AGHT+IEVLck2/mkyzgSlCvi0uKMXFIjAVhIB4qpJz+AytEOR3FjVMS2TkI8la5SV3DNpjFEXmf1pWNNS5B7RngiPzGs=
X-Received: by 2002:a05:6102:58c5:b0:48b:ba90:792e with SMTP id
 ada2fe7eead31-48c047f5024mr1162890137.5.1717546747263; Tue, 04 Jun 2024
 17:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240531202759.911601-1-dbarboza@ventanamicro.com>
 <20240531202759.911601-3-dbarboza@ventanamicro.com>
In-Reply-To: <20240531202759.911601-3-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 5 Jun 2024 10:18:41 +1000
Message-ID: <CAKmqyKNH57fEG8dbgvcSmO84UUhxJChtP57gU2z5fgd79xNFMA@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] hw/riscv/virt.c: add aplic nodename helper
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, apatel@ventanamicro.com, ajones@ventanamicro.com, 
 conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
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
> We'll change the aplic DT nodename in the next patch and the name is
> hardcoded in 2 different functions. Create a helper to change a single
> place later.
>
> While we're at it, in create_fdt_socket_aplic(), move 'aplic_name'
> inside the conditional to avoid allocating a string that won't be used
> when socket =3D=3D NULL.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 1a7e1e73c5..07a07f5ce1 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -588,6 +588,12 @@ static void create_fdt_imsic(RISCVVirtState *s, cons=
t MemMapEntry *memmap,
>
>  }
>
> +/* Caller must free string after use */
> +static char *fdt_get_aplic_nodename(unsigned long aplic_addr)
> +{
> +    return g_strdup_printf("/soc/aplic@%lx", aplic_addr);
> +}
> +
>  static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
>                                   unsigned long aplic_addr, uint32_t apli=
c_size,
>                                   uint32_t msi_phandle,
> @@ -597,7 +603,7 @@ static void create_fdt_one_aplic(RISCVVirtState *s, i=
nt socket,
>                                   bool m_mode, int num_harts)
>  {
>      int cpu;
> -    g_autofree char *aplic_name =3D NULL;
> +    g_autofree char *aplic_name =3D fdt_get_aplic_nodename(aplic_addr);
>      g_autofree uint32_t *aplic_cells =3D g_new0(uint32_t, num_harts * 2)=
;
>      MachineState *ms =3D MACHINE(s);
>
> @@ -606,7 +612,6 @@ static void create_fdt_one_aplic(RISCVVirtState *s, i=
nt socket,
>          aplic_cells[cpu * 2 + 1] =3D cpu_to_be32(m_mode ? IRQ_M_EXT : IR=
Q_S_EXT);
>      }
>
> -    aplic_name =3D g_strdup_printf("/soc/aplic@%lx", aplic_addr);
>      qemu_fdt_add_subnode(ms->fdt, aplic_name);
>      qemu_fdt_setprop_string(ms->fdt, aplic_name, "compatible", "riscv,ap=
lic");
>      qemu_fdt_setprop_cell(ms->fdt, aplic_name, "#address-cells",
> @@ -648,7 +653,6 @@ static void create_fdt_socket_aplic(RISCVVirtState *s=
,
>                                      uint32_t *aplic_phandles,
>                                      int num_harts)
>  {
> -    g_autofree char *aplic_name =3D NULL;
>      unsigned long aplic_addr;
>      MachineState *ms =3D MACHINE(s);
>      uint32_t aplic_m_phandle, aplic_s_phandle;
> @@ -674,9 +678,8 @@ static void create_fdt_socket_aplic(RISCVVirtState *s=
,
>                           aplic_s_phandle, 0,
>                           false, num_harts);
>
> -    aplic_name =3D g_strdup_printf("/soc/aplic@%lx", aplic_addr);
> -
>      if (!socket) {
> +        g_autofree char *aplic_name =3D fdt_get_aplic_nodename(aplic_add=
r);
>          platform_bus_add_all_fdt_nodes(ms->fdt, aplic_name,
>                                         memmap[VIRT_PLATFORM_BUS].base,
>                                         memmap[VIRT_PLATFORM_BUS].size,
> --
> 2.45.1
>
>


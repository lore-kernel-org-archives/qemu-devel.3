Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7533BC369D9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 00:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAHWW-0005Ka-0X; Wed, 30 Apr 2025 20:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAHWT-0005KH-I0; Wed, 30 Apr 2025 20:11:29 -0400
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAHWQ-0003EC-2K; Wed, 30 Apr 2025 20:11:28 -0400
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-527b70bd90dso150788e0c.3; 
 Wed, 30 Apr 2025 17:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746058284; x=1746663084; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/HswOtG8xVONKBtth2sYjXIGZUcBRH/WDgRLil7O2tM=;
 b=YPpfcIv/9B6QkHsAaYxe9wl9Swd3o2Kpj9N+qV31M6dJjKqDnCHJIwHVdFAOtQr5hl
 Z2fQtlB2PjQ+u2vtZbP0ST4mm5gFvxc3dlo13NRAuTijOwhz68sq1W0N6MSi8yBO+puK
 Yso5Ml/XtspNu/zee/Qeqyc8H4ygpMlUSOPlF3XMpJim2gxFgHoT5/3dOOPNiPZEfOrA
 9Mo+W/5qyh9hYpjqA0iESGV7JuWJHOug71ERLNvOvLxnjUHei+hO6P5CD0NXj6b2zoeA
 ZTCIl/a7MghwT9uo8i3h9TWOSHF6cTDGmocPSjoOV/8Ds1FFPu9cg7h3vMMJFDfZLjon
 lhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746058284; x=1746663084;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/HswOtG8xVONKBtth2sYjXIGZUcBRH/WDgRLil7O2tM=;
 b=ncuVpmLly/JeCmJhDF0Fmw3yWoRwvVttojIIJSTD5/DkhodO7r6Gv4/ZM+0PA31TL5
 B/SglLU2q5uipe+BrCOpQVe0gI5Hfrhx2o4JpOmxDurHZH6lAihT1v1PMUXJieUyljlP
 s04nkbOjtEE8h5AD+FfK+AU4shIUkqtQUpKbUb6FRwCiZLxR7BNVFJDrX5018fRlYQBq
 wMCsh1cFewOFDubc0ns/7XeHBcGcTTv+3vhl4fxsaQ39M7kWjDoEG/wR2wV2iQVSDW+I
 g/1NmuTDkm693x/1yQADLcDYicpKWXLGoR39EjPHkqYeaHIjRSidxSty8ouSd0lx/S1m
 oHxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFnUstewzzmc+pYfG0t54gKNYm9KZiOCB+Sks+9Awr1qFZqIYu5gqMp0FX+psyM5NtJCtJWFOG9zVV@nongnu.org
X-Gm-Message-State: AOJu0YwxCfFC9rv2dVOdePPhSe9jxIV0v9CRnu+cRvE+q9L2GWvMdjPi
 T8j/RGXzBvd4C8EpEIpkBx+rnPQ898nMyo4UcfZfFm/YAk6LMriPOfZxe/jwLYAe9MJKM+UDHFh
 RpcTtU+z/McrNzm2lxqeAJYPr3WI=
X-Gm-Gg: ASbGncse6vRZN88TDHUzGSmw+hMcj9YcUOYZ89yo0zJmo3pty7/A5gJ/rdq7SczjTFB
 YTERNkCueoAqY1Hu/bN5I3TL33zqJkwrLOrRQNGOTy5l1zmdgLbPYRuSjiNTpbpQXGciCvYkJ4Q
 llH8dAFwWnth+2ISTrDC/LwhgM1mDql6sydx0dKCH7ydUyj0qaX9TKAzc1Wt3ny0s=
X-Google-Smtp-Source: AGHT+IE0LaKPvynRIfnvLNI0pOKDJzof8qB3amJeVHgGHOLyEloKI5ixpodPvv6YF6AwCCmP4l3OXzUK379Q/P8jc9s=
X-Received: by 2002:a05:6122:3296:b0:529:1a6a:cc35 with SMTP id
 71dfb90a1353d-52ade3a4b03mr496420e0c.6.1746058284352; Wed, 30 Apr 2025
 17:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250429125811.224803-1-dbarboza@ventanamicro.com>
 <20250429125811.224803-7-dbarboza@ventanamicro.com>
In-Reply-To: <20250429125811.224803-7-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 1 May 2025 10:10:57 +1000
X-Gm-Features: ATxdqUE7XsM9WOqjK7RbrZY4_dJSGotS4i8NSgB-vS4RTbSK5ijoGLelLEczYzI
Message-ID: <CAKmqyKNkj-uBOCXmjq0UJ8CD49U1nqWYeCuWYSs-tWBxR+0fRw@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] hw/riscv/virt.c: use s->memmap in
 create_fdt_sockets() path
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 joel@jms.id.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa33.google.com
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

On Tue, Apr 29, 2025 at 11:01=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> create_fdt_sockets() and all its fdt helpers (create_fdt_socket_aplic(),
> create_fdt_imsic(), create_fdt_socket_plic(), create_fdt_socket_aclint()
> and create_fdt_socket_memory()) can use s->memmap from their
> RISCVVirtState pointer instead of having an extra memmap argument.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 89 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 47 insertions(+), 42 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 5f31c95955..2383a557bd 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -300,14 +300,13 @@ static void create_fdt_socket_cpus(RISCVVirtState *=
s, int socket,
>      }
>  }
>
> -static void create_fdt_socket_memory(RISCVVirtState *s,
> -                                     const MemMapEntry *memmap, int sock=
et)
> +static void create_fdt_socket_memory(RISCVVirtState *s, int socket)
>  {
>      g_autofree char *mem_name =3D NULL;
>      uint64_t addr, size;
>      MachineState *ms =3D MACHINE(s);
>
> -    addr =3D memmap[VIRT_DRAM].base + riscv_socket_mem_offset(ms, socket=
);
> +    addr =3D s->memmap[VIRT_DRAM].base + riscv_socket_mem_offset(ms, soc=
ket);
>      size =3D riscv_socket_mem_size(ms, socket);
>      mem_name =3D g_strdup_printf("/memory@%lx", (long)addr);
>      qemu_fdt_add_subnode(ms->fdt, mem_name);
> @@ -318,7 +317,7 @@ static void create_fdt_socket_memory(RISCVVirtState *=
s,
>  }
>
>  static void create_fdt_socket_clint(RISCVVirtState *s,
> -                                    const MemMapEntry *memmap, int socke=
t,
> +                                    int socket,
>                                      uint32_t *intc_phandles)
>  {
>      int cpu;
> @@ -339,21 +338,22 @@ static void create_fdt_socket_clint(RISCVVirtState =
*s,
>          clint_cells[cpu * 4 + 3] =3D cpu_to_be32(IRQ_M_TIMER);
>      }
>
> -    clint_addr =3D memmap[VIRT_CLINT].base + (memmap[VIRT_CLINT].size * =
socket);
> +    clint_addr =3D s->memmap[VIRT_CLINT].base +
> +                 (s->memmap[VIRT_CLINT].size * socket);
>      clint_name =3D g_strdup_printf("/soc/clint@%lx", clint_addr);
>      qemu_fdt_add_subnode(ms->fdt, clint_name);
>      qemu_fdt_setprop_string_array(ms->fdt, clint_name, "compatible",
>                                    (char **)&clint_compat,
>                                    ARRAY_SIZE(clint_compat));
>      qemu_fdt_setprop_cells(ms->fdt, clint_name, "reg",
> -        0x0, clint_addr, 0x0, memmap[VIRT_CLINT].size);
> +        0x0, clint_addr, 0x0, s->memmap[VIRT_CLINT].size);
>      qemu_fdt_setprop(ms->fdt, clint_name, "interrupts-extended",
>          clint_cells, s->soc[socket].num_harts * sizeof(uint32_t) * 4);
>      riscv_socket_fdt_write_id(ms, clint_name, socket);
>  }
>
>  static void create_fdt_socket_aclint(RISCVVirtState *s,
> -                                     const MemMapEntry *memmap, int sock=
et,
> +                                     int socket,
>                                       uint32_t *intc_phandles)
>  {
>      int cpu;
> @@ -380,8 +380,10 @@ static void create_fdt_socket_aclint(RISCVVirtState =
*s,
>      aclint_cells_size =3D s->soc[socket].num_harts * sizeof(uint32_t) * =
2;
>
>      if (s->aia_type !=3D VIRT_AIA_TYPE_APLIC_IMSIC) {
> -        addr =3D memmap[VIRT_CLINT].base + (memmap[VIRT_CLINT].size * so=
cket);
> +        addr =3D s->memmap[VIRT_CLINT].base +
> +               (s->memmap[VIRT_CLINT].size * socket);
>          name =3D g_strdup_printf("/soc/mswi@%lx", addr);
> +
>          qemu_fdt_add_subnode(ms->fdt, name);
>          qemu_fdt_setprop_string(ms->fdt, name, "compatible",
>              "riscv,aclint-mswi");
> @@ -396,13 +398,13 @@ static void create_fdt_socket_aclint(RISCVVirtState=
 *s,
>      }
>
>      if (s->aia_type =3D=3D VIRT_AIA_TYPE_APLIC_IMSIC) {
> -        addr =3D memmap[VIRT_CLINT].base +
> +        addr =3D s->memmap[VIRT_CLINT].base +
>                 (RISCV_ACLINT_DEFAULT_MTIMER_SIZE * socket);
>          size =3D RISCV_ACLINT_DEFAULT_MTIMER_SIZE;
>      } else {
> -        addr =3D memmap[VIRT_CLINT].base + RISCV_ACLINT_SWI_SIZE +
> -            (memmap[VIRT_CLINT].size * socket);
> -        size =3D memmap[VIRT_CLINT].size - RISCV_ACLINT_SWI_SIZE;
> +        addr =3D s->memmap[VIRT_CLINT].base + RISCV_ACLINT_SWI_SIZE +
> +               (s->memmap[VIRT_CLINT].size * socket);
> +        size =3D s->memmap[VIRT_CLINT].size - RISCV_ACLINT_SWI_SIZE;
>      }
>      name =3D g_strdup_printf("/soc/mtimer@%lx", addr);
>      qemu_fdt_add_subnode(ms->fdt, name);
> @@ -419,14 +421,15 @@ static void create_fdt_socket_aclint(RISCVVirtState=
 *s,
>      g_free(name);
>
>      if (s->aia_type !=3D VIRT_AIA_TYPE_APLIC_IMSIC) {
> -        addr =3D memmap[VIRT_ACLINT_SSWI].base +
> -            (memmap[VIRT_ACLINT_SSWI].size * socket);
> +        addr =3D s->memmap[VIRT_ACLINT_SSWI].base +
> +               (s->memmap[VIRT_ACLINT_SSWI].size * socket);
> +
>          name =3D g_strdup_printf("/soc/sswi@%lx", addr);
>          qemu_fdt_add_subnode(ms->fdt, name);
>          qemu_fdt_setprop_string(ms->fdt, name, "compatible",
>              "riscv,aclint-sswi");
>          qemu_fdt_setprop_cells(ms->fdt, name, "reg",
> -            0x0, addr, 0x0, memmap[VIRT_ACLINT_SSWI].size);
> +            0x0, addr, 0x0, s->memmap[VIRT_ACLINT_SSWI].size);
>          qemu_fdt_setprop(ms->fdt, name, "interrupts-extended",
>              aclint_sswi_cells, aclint_cells_size);
>          qemu_fdt_setprop(ms->fdt, name, "interrupt-controller", NULL, 0)=
;
> @@ -437,7 +440,7 @@ static void create_fdt_socket_aclint(RISCVVirtState *=
s,
>  }
>
>  static void create_fdt_socket_plic(RISCVVirtState *s,
> -                                   const MemMapEntry *memmap, int socket=
,
> +                                   int socket,
>                                     uint32_t *phandle, uint32_t *intc_pha=
ndles,
>                                     uint32_t *plic_phandles)
>  {
> @@ -451,7 +454,8 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
>      };
>
>      plic_phandles[socket] =3D (*phandle)++;
> -    plic_addr =3D memmap[VIRT_PLIC].base + (memmap[VIRT_PLIC].size * soc=
ket);
> +    plic_addr =3D s->memmap[VIRT_PLIC].base +
> +                (s->memmap[VIRT_PLIC].size * socket);
>      plic_name =3D g_strdup_printf("/soc/plic@%lx", plic_addr);
>      qemu_fdt_add_subnode(ms->fdt, plic_name);
>      qemu_fdt_setprop_cell(ms->fdt, plic_name,
> @@ -490,7 +494,7 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
>      }
>
>      qemu_fdt_setprop_cells(ms->fdt, plic_name, "reg",
> -        0x0, plic_addr, 0x0, memmap[VIRT_PLIC].size);
> +        0x0, plic_addr, 0x0, s->memmap[VIRT_PLIC].size);
>      qemu_fdt_setprop_cell(ms->fdt, plic_name, "riscv,ndev",
>                            VIRT_IRQCHIP_NUM_SOURCES - 1);
>      riscv_socket_fdt_write_id(ms, plic_name, socket);
> @@ -499,8 +503,8 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
>
>      if (!socket) {
>          platform_bus_add_all_fdt_nodes(ms->fdt, plic_name,
> -                                       memmap[VIRT_PLATFORM_BUS].base,
> -                                       memmap[VIRT_PLATFORM_BUS].size,
> +                                       s->memmap[VIRT_PLATFORM_BUS].base=
,
> +                                       s->memmap[VIRT_PLATFORM_BUS].size=
,
>                                         VIRT_PLATFORM_BUS_IRQ);
>      }
>  }
> @@ -587,7 +591,7 @@ static void create_fdt_one_imsic(RISCVVirtState *s, h=
waddr base_addr,
>      qemu_fdt_setprop_cell(ms->fdt, imsic_name, "phandle", msi_phandle);
>  }
>
> -static void create_fdt_imsic(RISCVVirtState *s, const MemMapEntry *memma=
p,
> +static void create_fdt_imsic(RISCVVirtState *s,
>                               uint32_t *phandle, uint32_t *intc_phandles,
>                               uint32_t *msi_m_phandle, uint32_t *msi_s_ph=
andle)
>  {
> @@ -596,12 +600,12 @@ static void create_fdt_imsic(RISCVVirtState *s, con=
st MemMapEntry *memmap,
>
>      if (!kvm_enabled()) {
>          /* M-level IMSIC node */
> -        create_fdt_one_imsic(s, memmap[VIRT_IMSIC_M].base, intc_phandles=
,
> +        create_fdt_one_imsic(s, s->memmap[VIRT_IMSIC_M].base, intc_phand=
les,
>                               *msi_m_phandle, true, 0);
>      }
>
>      /* S-level IMSIC node */
> -    create_fdt_one_imsic(s, memmap[VIRT_IMSIC_S].base, intc_phandles,
> +    create_fdt_one_imsic(s, s->memmap[VIRT_IMSIC_S].base, intc_phandles,
>                           *msi_s_phandle, false,
>                           imsic_num_bits(s->aia_guests + 1));
>
> @@ -678,7 +682,7 @@ static void create_fdt_one_aplic(RISCVVirtState *s, i=
nt socket,
>  }
>
>  static void create_fdt_socket_aplic(RISCVVirtState *s,
> -                                    const MemMapEntry *memmap, int socke=
t,
> +                                    int socket,
>                                      uint32_t msi_m_phandle,
>                                      uint32_t msi_s_phandle,
>                                      uint32_t *phandle,
> @@ -695,18 +699,19 @@ static void create_fdt_socket_aplic(RISCVVirtState =
*s,
>
>      if (!kvm_enabled()) {
>          /* M-level APLIC node */
> -        aplic_addr =3D memmap[VIRT_APLIC_M].base +
> -                     (memmap[VIRT_APLIC_M].size * socket);
> -        create_fdt_one_aplic(s, socket, aplic_addr, memmap[VIRT_APLIC_M]=
.size,
> +        aplic_addr =3D s->memmap[VIRT_APLIC_M].base +
> +                     (s->memmap[VIRT_APLIC_M].size * socket);
> +        create_fdt_one_aplic(s, socket, aplic_addr,
> +                             s->memmap[VIRT_APLIC_M].size,
>                               msi_m_phandle, intc_phandles,
>                               aplic_m_phandle, aplic_s_phandle,
>                               true, num_harts);
>      }
>
>      /* S-level APLIC node */
> -    aplic_addr =3D memmap[VIRT_APLIC_S].base +
> -                 (memmap[VIRT_APLIC_S].size * socket);
> -    create_fdt_one_aplic(s, socket, aplic_addr, memmap[VIRT_APLIC_S].siz=
e,
> +    aplic_addr =3D s->memmap[VIRT_APLIC_S].base +
> +                 (s->memmap[VIRT_APLIC_S].size * socket);
> +    create_fdt_one_aplic(s, socket, aplic_addr, s->memmap[VIRT_APLIC_S].=
size,
>                           msi_s_phandle, intc_phandles,
>                           aplic_s_phandle, 0,
>                           false, num_harts);
> @@ -714,8 +719,8 @@ static void create_fdt_socket_aplic(RISCVVirtState *s=
,
>      if (!socket) {
>          g_autofree char *aplic_name =3D fdt_get_aplic_nodename(aplic_add=
r);
>          platform_bus_add_all_fdt_nodes(ms->fdt, aplic_name,
> -                                       memmap[VIRT_PLATFORM_BUS].base,
> -                                       memmap[VIRT_PLATFORM_BUS].size,
> +                                       s->memmap[VIRT_PLATFORM_BUS].base=
,
> +                                       s->memmap[VIRT_PLATFORM_BUS].size=
,
>                                         VIRT_PLATFORM_BUS_IRQ);
>      }
>
> @@ -733,7 +738,7 @@ static void create_fdt_pmu(RISCVVirtState *s)
>      riscv_pmu_generate_fdt_node(ms->fdt, hart.pmu_avail_ctrs, pmu_name);
>  }
>
> -static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *mem=
map,
> +static void create_fdt_sockets(RISCVVirtState *s,
>                                 uint32_t *phandle,
>                                 uint32_t *irq_mmio_phandle,
>                                 uint32_t *irq_pcie_phandle,
> @@ -769,20 +774,20 @@ static void create_fdt_sockets(RISCVVirtState *s, c=
onst MemMapEntry *memmap,
>          create_fdt_socket_cpus(s, socket, clust_name, phandle,
>                                 &intc_phandles[phandle_pos]);
>
> -        create_fdt_socket_memory(s, memmap, socket);
> +        create_fdt_socket_memory(s, socket);
>
>          if (virt_aclint_allowed() && s->have_aclint) {
> -            create_fdt_socket_aclint(s, memmap, socket,
> +            create_fdt_socket_aclint(s, socket,
>                                       &intc_phandles[phandle_pos]);
>          } else if (tcg_enabled()) {
> -            create_fdt_socket_clint(s, memmap, socket,
> +            create_fdt_socket_clint(s, socket,
>                                      &intc_phandles[phandle_pos]);
>          }
>      }
>
>      if (s->aia_type =3D=3D VIRT_AIA_TYPE_APLIC_IMSIC) {
> -        create_fdt_imsic(s, memmap, phandle, intc_phandles,
> -            &msi_m_phandle, &msi_s_phandle);
> +        create_fdt_imsic(s, phandle, intc_phandles,
> +                         &msi_m_phandle, &msi_s_phandle);
>          *msi_pcie_phandle =3D msi_s_phandle;
>      }
>
> @@ -791,7 +796,7 @@ static void create_fdt_sockets(RISCVVirtState *s, con=
st MemMapEntry *memmap,
>       * mode, we'll use only one APLIC instance.
>       */
>      if (!virt_use_emulated_aplic(s->aia_type)) {
> -        create_fdt_socket_aplic(s, memmap, 0,
> +        create_fdt_socket_aplic(s, 0,
>                                  msi_m_phandle, msi_s_phandle, phandle,
>                                  &intc_phandles[0], xplic_phandles,
>                                  ms->smp.cpus);
> @@ -805,11 +810,11 @@ static void create_fdt_sockets(RISCVVirtState *s, c=
onst MemMapEntry *memmap,
>              phandle_pos -=3D s->soc[socket].num_harts;
>
>              if (s->aia_type =3D=3D VIRT_AIA_TYPE_NONE) {
> -                create_fdt_socket_plic(s, memmap, socket, phandle,
> +                create_fdt_socket_plic(s, socket, phandle,
>                                         &intc_phandles[phandle_pos],
>                                         xplic_phandles);
>              } else {
> -                create_fdt_socket_aplic(s, memmap, socket,
> +                create_fdt_socket_aplic(s, socket,
>                                          msi_m_phandle, msi_s_phandle, ph=
andle,
>                                          &intc_phandles[phandle_pos],
>                                          xplic_phandles,
> @@ -1125,7 +1130,7 @@ static void finalize_fdt(RISCVVirtState *s)
>      uint32_t irq_pcie_phandle =3D 1, irq_virtio_phandle =3D 1;
>      uint32_t iommu_sys_phandle =3D 1;
>
> -    create_fdt_sockets(s, s->memmap, &phandle, &irq_mmio_phandle,
> +    create_fdt_sockets(s, &phandle, &irq_mmio_phandle,
>                         &irq_pcie_phandle, &irq_virtio_phandle,
>                         &msi_pcie_phandle);
>
> --
> 2.49.0
>
>


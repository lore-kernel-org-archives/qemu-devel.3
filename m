Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A96C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 00:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAHXP-0005yw-5a; Wed, 30 Apr 2025 20:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAHXL-0005y9-Ux; Wed, 30 Apr 2025 20:12:23 -0400
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAHXK-0003GC-CV; Wed, 30 Apr 2025 20:12:23 -0400
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-4c300c82ca8so175494137.2; 
 Wed, 30 Apr 2025 17:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746058341; x=1746663141; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ok9LHn+BCgRcv91gubvhTxw/HmAZIs4QadHaojbuuo8=;
 b=bwKg0eEhLismXNo021Sw1Zgh9/GK/LqXbqOQzL/3wsHOdRyabx5crtsvuDdr3UC22B
 ZO8r9dH1UT16Mv+A3lMJ02Pa2vjhImoSEMDHgaRTBAkjV8uY7e2KwmMds2RJo7veFt3W
 pTm57ce1/YMBtQV49b1YFSD7Pwyc+mQeDF0DfWgpCcCabs2fF0XlKlkMnPTxMmXHPOwq
 O9aE1wk1ivNLHDq3Ag7oUw9RbDnvOIzhHs2jFY46Q7Zz2lL1qZHlkLzE4Q4q1U4Q8GdU
 qJ26gxO4oK7/GCz0QuOaCIl02aFnojZ1RKUbiA+0pK0OKjwH3LPmZKNykYV4uD4zS28Y
 n3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746058341; x=1746663141;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ok9LHn+BCgRcv91gubvhTxw/HmAZIs4QadHaojbuuo8=;
 b=prLCPTVhwmHpfODYWc02MxpUBTmGwXT2rVVDbw1B5X+9ytMAg5uh3axdfX321qBYca
 ZKTuVFXjwQixdllYr5rbHspLxfY1cGcqE+lW3g8aZ4jSh+rOIh8/6zb48Dn3OR1pm+4X
 xHZ4xRWY9EPrcVLuBhthJCunKQcZfr5KDE50azBLdsZB6JnzOnl4S+qJpvjUSildXz5g
 6Myy1cRW9CoMDGEvO4N+C+28myf1L61rgni30ymDQQnq0Tnec3WODKP98fOohmwmL6i6
 W5kZRMfBAcogwR5XwCyN6j/55VHQJQzi9+jK94uTmJr3mMDzTI0vz1z3pjcZpxVLbOF3
 3x3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpQbtB0LbcgYni9zmMt0AGSwz7J3op8/szyQD38zyJUMMDSaobPveeqv8Va6AlnE/pFgj9dYVz5cL2@nongnu.org
X-Gm-Message-State: AOJu0YyNH7PpzoRpdWl+wFwZgkdAuxYY2M1V6h1exM3hQXEtyzLslNIb
 e77PKatbCEWSk0CzJArHvk2MrQeusmt37+N4vpWClsiUcHWn32uwThyUrhw/yUnpYkBCbix2c7U
 U555/hJHzuxxw4UBvLnbzPBIFDHD3QA==
X-Gm-Gg: ASbGncsUQgnX/gCX9lIxzRDlBZjH/bAFgk/Don1+ojHWtR7aJrHRbr44EiwL8BAIGa/
 KICJ7FT3PWRLHuj98jfOnFA2PBKzFauUdkCf5rxcoCunyQFwitKG2n2/OlAjM90zewkAxVIzu4g
 hr6f2ZAgHoA+o4CcL39tyuazHKg2cWThhQgn0FsEhWm12mZuo/Q4dE
X-Google-Smtp-Source: AGHT+IE8hrxaf+sSZK9q4Q/yDb7YCf/6knke/tte+95AksGgcvd9dkiCuIdTvGQNnu4klZpuK8t/0E6HGu6D6RLsyTs=
X-Received: by 2002:a05:6102:5e86:b0:4c4:e414:b4eb with SMTP id
 ada2fe7eead31-4dad4943973mr4569668137.12.1746058340664; Wed, 30 Apr 2025
 17:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250429125811.224803-1-dbarboza@ventanamicro.com>
 <20250429125811.224803-8-dbarboza@ventanamicro.com>
In-Reply-To: <20250429125811.224803-8-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 1 May 2025 10:11:54 +1000
X-Gm-Features: ATxdqUHw5zM0lYRVdRHQNHirl7SDAtDRP134-ITxEhDcjzHSPZBqxr0kIMJeYbQ
Message-ID: <CAKmqyKM-1Uxsn-VDVXmwOAikb76xAzBoSpZfJhk4MFL6eKNtjg@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] hw/riscv/virt.c: use s->memmap in
 create_fdt_virtio()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 joel@jms.id.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2d;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2d.google.com
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

On Tue, Apr 29, 2025 at 11:02=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> create_fdt_virtio() can use s->memmap instead of having an extra
> argument for it.
>
> While we're at it rewrite it a little bit to avoid the clunky line in
> 'name' and code repetition:
>
> - declare 'virtio_base' out of the loop since it never changes;
> - declare a 'size' variable. Use it to calculate the address of the
>   virtio device in an 'addr' variable;
> - use 'addr' in the 'name' g_strdup_printf();
> - use 'addr' and 'size' when creating the 'reg' property.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 2383a557bd..46ac42058e 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -841,21 +841,24 @@ static void create_fdt_sockets(RISCVVirtState *s,
>      riscv_socket_fdt_write_distance_matrix(ms);
>  }
>
> -static void create_fdt_virtio(RISCVVirtState *s, const MemMapEntry *memm=
ap,
> -                              uint32_t irq_virtio_phandle)
> +static void create_fdt_virtio(RISCVVirtState *s, uint32_t irq_virtio_pha=
ndle)
>  {
>      int i;
>      MachineState *ms =3D MACHINE(s);
> +    hwaddr virtio_base =3D s->memmap[VIRT_VIRTIO].base;
>
>      for (i =3D 0; i < VIRTIO_COUNT; i++) {
> -        g_autofree char *name =3D  g_strdup_printf("/soc/virtio_mmio@%lx=
",
> -            (long)(memmap[VIRT_VIRTIO].base + i * memmap[VIRT_VIRTIO].si=
ze));
> +        g_autofree char *name =3D NULL;
> +        uint64_t size =3D s->memmap[VIRT_VIRTIO].size;
> +        hwaddr addr =3D virtio_base + i * size;
> +
> +        name =3D g_strdup_printf("/soc/virtio_mmio@%"HWADDR_PRIx, addr);
>
>          qemu_fdt_add_subnode(ms->fdt, name);
>          qemu_fdt_setprop_string(ms->fdt, name, "compatible", "virtio,mmi=
o");
>          qemu_fdt_setprop_cells(ms->fdt, name, "reg",
> -            0x0, memmap[VIRT_VIRTIO].base + i * memmap[VIRT_VIRTIO].size=
,
> -            0x0, memmap[VIRT_VIRTIO].size);
> +                               0x0, addr,
> +                               0x0, size);
>          qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
>              irq_virtio_phandle);
>          if (s->aia_type =3D=3D VIRT_AIA_TYPE_NONE) {
> @@ -1134,7 +1137,7 @@ static void finalize_fdt(RISCVVirtState *s)
>                         &irq_pcie_phandle, &irq_virtio_phandle,
>                         &msi_pcie_phandle);
>
> -    create_fdt_virtio(s, s->memmap, irq_virtio_phandle);
> +    create_fdt_virtio(s, irq_virtio_phandle);
>
>      if (virt_is_iommu_sys_enabled(s)) {
>          create_fdt_iommu_sys(s, irq_mmio_phandle, msi_pcie_phandle,
> --
> 2.49.0
>
>


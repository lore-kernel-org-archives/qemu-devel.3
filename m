Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377F6E77183
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 03:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNORG-0005JN-9n; Mon, 16 Dec 2024 22:40:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tNORD-0005J7-Qh; Mon, 16 Dec 2024 22:39:59 -0500
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tNORC-0001kY-0J; Mon, 16 Dec 2024 22:39:59 -0500
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-4aff1c57377so2570203137.0; 
 Mon, 16 Dec 2024 19:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734406795; x=1735011595; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e0QNTPLjcwfUBSTQjEvcVF/2fKXU6mt6AS/45tw3vE4=;
 b=KNvDY/Y3FNhVbO09mDGRyL34tqvCi2HVs3lygcgDoj+/5Qo/1VZ2PNGgYx0XfELmpB
 wd/JUm56rWPd6n20h0Nr0gEsgUZjo5MWTJmN8uIqYZJRAdcUU/bfT9kh+OAGxnOxi42V
 Fvg+p7T6ezuyvGaGjLr4vvbuY4GCgwgbyjB9JH6+qNhQKgLTZ+6k4ZIsw3Q09k4ACx3K
 3G+zOm4QOiPd7uKn62FNIQ0VSQPEEp4ku3nWdduMWP9Z4VIWourvT47drGiNjmCLpyOQ
 LWWSECQPge42pkaohH00O0hyq82XjfHCbjxGHq8gnLBWnJptDT+O+/c8Vi4i0NzqCmfL
 qvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734406795; x=1735011595;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e0QNTPLjcwfUBSTQjEvcVF/2fKXU6mt6AS/45tw3vE4=;
 b=wKWW5cu84Bp2gE62Sib+QifIrQGthPRaChTJHdjzb38cNfOvTGOai7Yr7Dpq1OIIzu
 lHVq1sLpOI8BezGwIScfPvpfUuCqcPWW0rJVjOeQEHLdU40RGgqwYQfruplxZX5oRDQ2
 U/go7GB6127nZ0pLxAT41jrNhKCpwHYTH8yCggkcs86cxGSXUBwt8afgR+tGeckdIugD
 EfHNo/BuQKaTmWz3jYEpVAB4F8pZrHX/6b3i8SbqW+2Mh3wV5UFg+ef+FvE5aUjW/kZq
 528xfOGG2UySrsmdWqxH9CQqLydrPCTkUhESaBZPCeJK/cnpAYRIm72e/IRB3I72wtfc
 d7HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3/QQ44e5VZXYF6xQOb+OYjXydrS9dsRfgfRtCDiWaIhaupNM8LsoiRea6eYp1WCs+c+HJYOmovJI8@nongnu.org
X-Gm-Message-State: AOJu0Yxgd1m/hvZtuQ/SWB6SUJlTWEWkTPCU9oMcvDZLgLvtJn9cGM9Z
 CP3KgRjQnmNJSa3cwJktFs6R0Rtcc+2tu31Nm2btw3UbRLoz1ny4tM5DCgJHfsc74WE9b4WM9+/
 hoEBm5GksfGgIPFgqgzhW+NpYVjk=
X-Gm-Gg: ASbGncuu/0PTCAhfxN8HX6tbQzmssdA1jzyTD/lZ5bmmX6n7LOSv+ORmXaA8mltgw8y
 ffifDiN5LLWJGMhsOX68JHZ/s9slIQrP8O7iw7NTJDmXvoFyDU7Eqe4t8gxkhiBbSJBRb
X-Google-Smtp-Source: AGHT+IHFiIeTPAyKiUiNnIDUxhtnpGkOwL5yujW4LtZCgpd6qTAp5+V4B4lFxnTh9nK8UQVJM4oP+/FBnK29yMk/9W4=
X-Received: by 2002:a67:ebd6:0:b0:4b1:f903:98d3 with SMTP id
 ada2fe7eead31-4b29dc54ee8mr1822566137.7.1734406795097; Mon, 16 Dec 2024
 19:39:55 -0800 (PST)
MIME-Version: 1.0
References: <20241120153935.24706-1-jim.shu@sifive.com>
 <20241120153935.24706-2-jim.shu@sifive.com>
In-Reply-To: <20241120153935.24706-2-jim.shu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 17 Dec 2024 13:39:29 +1000
Message-ID: <CAKmqyKOTBkNpwvuGonW80T6LQtMu4sBWA_cu58S4+pMMkZAvcw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] hw/riscv: Support to load DTB after 3GB memory on
 64-bit system.
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e36;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe36.google.com
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

On Thu, Nov 21, 2024 at 1:41=E2=80=AFAM Jim Shu <jim.shu@sifive.com> wrote:
>
> Larger initrd image will overlap the DTB at 3GB address. Since 64-bit
> system doesn't have 32-bit addressable issue, we just load DTB to the end
> of dram in 64-bit system.
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>  hw/riscv/boot.c            | 14 +++++++++-----
>  hw/riscv/microchip_pfsoc.c |  4 ++--
>  hw/riscv/sifive_u.c        |  4 ++--
>  hw/riscv/spike.c           |  4 ++--
>  hw/riscv/virt.c            |  2 +-
>  include/hw/riscv/boot.h    |  2 +-
>  6 files changed, 17 insertions(+), 13 deletions(-)
>
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 2e319168db..d36d3a7104 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -293,7 +293,7 @@ out:
>   * The FDT is fdt_packed() during the calculation.
>   */
>  uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
> -                                MachineState *ms)
> +                                MachineState *ms, RISCVHartArrayState *h=
arts)
>  {
>      int ret =3D fdt_pack(ms->fdt);
>      hwaddr dram_end, temp;
> @@ -317,11 +317,15 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, h=
waddr dram_size,
>
>      /*
>       * We should put fdt as far as possible to avoid kernel/initrd overw=
riting
> -     * its content. But it should be addressable by 32 bit system as wel=
l.
> -     * Thus, put it at an 2MB aligned address that less than fdt size fr=
om the
> -     * end of dram or 3GB whichever is lesser.
> +     * its content. But it should be addressable by 32 bit system as wel=
l in RV32.
> +     * Thus, put it near to the end of dram in RV64, and put it near to =
the end
> +     * of dram or 3GB whichever is lesser in RV32.
>       */
> -    temp =3D (dram_base < 3072 * MiB) ? MIN(dram_end, 3072 * MiB) : dram=
_end;
> +    if (!riscv_is_32bit(harts)) {
> +        temp =3D dram_end;
> +    } else {
> +        temp =3D (dram_base < 3072 * MiB) ? MIN(dram_end, 3072 * MiB) : =
dram_end;
> +    }
>
>      return QEMU_ALIGN_DOWN(temp - fdtsize, 2 * MiB);
>  }
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index f9a3b43d2e..ba8b0a2c26 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -519,7 +519,7 @@ static void microchip_icicle_kit_machine_init(Machine=
State *machine)
>      bool kernel_as_payload =3D false;
>      target_ulong firmware_end_addr, kernel_start_addr;
>      uint64_t kernel_entry;
> -    uint32_t fdt_load_addr;
> +    uint64_t fdt_load_addr;
>      DriveInfo *dinfo =3D drive_get(IF_SD, 0, 0);
>
>      /* Sanity check on RAM size */
> @@ -625,7 +625,7 @@ static void microchip_icicle_kit_machine_init(Machine=
State *machine)
>          /* Compute the fdt load address in dram */
>          fdt_load_addr =3D riscv_compute_fdt_addr(memmap[MICROCHIP_PFSOC_=
DRAM_LO].base,
>                                                 memmap[MICROCHIP_PFSOC_DR=
AM_LO].size,
> -                                               machine);
> +                                               machine, &s->soc.u_cpus);
>          riscv_load_fdt(fdt_load_addr, machine->fdt);
>
>          /* Load the reset vector */
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index c5e74126b1..05467e833a 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -519,7 +519,7 @@ static void sifive_u_machine_init(MachineState *machi=
ne)
>      const char *firmware_name;
>      uint32_t start_addr_hi32 =3D 0x00000000;
>      int i;
> -    uint32_t fdt_load_addr;
> +    uint64_t fdt_load_addr;
>      uint64_t kernel_entry;
>      DriveInfo *dinfo;
>      BlockBackend *blk;
> @@ -606,7 +606,7 @@ static void sifive_u_machine_init(MachineState *machi=
ne)
>
>      fdt_load_addr =3D riscv_compute_fdt_addr(memmap[SIFIVE_U_DEV_DRAM].b=
ase,
>                                             memmap[SIFIVE_U_DEV_DRAM].siz=
e,
> -                                           machine);
> +                                           machine, &s->soc.u_cpus);

This patch breaks boots with the sifive_u board.

This diff fixes it, I'm going to squash the diff into this patch

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index ff6e26dec8..fd59124500 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -518,6 +518,7 @@ static void sifive_u_machine_init(MachineState *machine=
)
    target_ulong firmware_end_addr, kernel_start_addr;
    const char *firmware_name;
    uint32_t start_addr_hi32 =3D 0x00000000;
+    uint32_t fdt_load_addr_hi32 =3D 0x00000000;
    int i;
    uint64_t fdt_load_addr;
    uint64_t kernel_entry;
@@ -611,6 +612,7 @@ static void sifive_u_machine_init(MachineState *machine=
)

    if (!riscv_is_32bit(&s->soc.u_cpus)) {
        start_addr_hi32 =3D (uint64_t)start_addr >> 32;
+        fdt_load_addr_hi32 =3D fdt_load_addr >> 32;
    }

    /* reset vector */
@@ -625,7 +627,7 @@ static void sifive_u_machine_init(MachineState *machine=
)
        start_addr,                    /* start: .dword */
        start_addr_hi32,
        fdt_load_addr,                 /* fdt_laddr: .dword */
-        0x00000000,
+        fdt_load_addr_hi32,
        0x00000000,
                                       /* fw_dyn: */
    };


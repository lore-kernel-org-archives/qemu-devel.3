Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867D2E6C60C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 06:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIMdK-00014y-2V; Tue, 03 Dec 2024 01:43:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIMdI-00014U-Ja; Tue, 03 Dec 2024 01:43:40 -0500
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIMdH-0001dq-2W; Tue, 03 Dec 2024 01:43:40 -0500
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-84ff43e87cbso1379999241.1; 
 Mon, 02 Dec 2024 22:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733208217; x=1733813017; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4BKQy3qATnBNI7ec3G+vPTKJRLb85RoZxvf/K43mVk0=;
 b=d7IITJeiILv4+Zs5oT+WKNwjba1pjPgoMDgegIFrzQT0IH01yNqOv4VbGaRAgZSa/y
 KXfOaw9Qft4pEga8Qwx5y4X5ayk7lWk9lSSiQbwtX1pXHLqS2htPLPyfljCOpUiADOE+
 DzQW7cM8VunlawToL1Qzw/jbwQu0Gpz/k1SbidJ8vTFmAjUD/QimdfVKbWgAIF7mFN06
 nfUw8/v7x/oSBqaaUruGOEEollHpUN5E96Bt7r5+tFUQcfODjBbljzKmpyf+tdw9dRPe
 N4teuiaqEt45A+hXt+2CsUN1Ljd+YSRixbSBjWTeXNinEy8GBYUCbz9ZOn7iDlp+IGHC
 fIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733208217; x=1733813017;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4BKQy3qATnBNI7ec3G+vPTKJRLb85RoZxvf/K43mVk0=;
 b=I0sH0dkQ7eDyuYDR3ye6/1GxheMZknQCSwlZm0BvFauH51BUnPiBiugQLnQCbz4JVU
 kKc7O/Tw2IEAVErWV66VO0260lJ01a5cE9U0KNOYWyOR5JmtawhBeLmZDe29/QZCHBlb
 oNUyQp3a9qPAtCaMq8vByibchLlYBPbZovEa4wFHD4NVRHQEPSQy0i3B6e2GVN0kZl5Y
 zePjOz7imvCO4pdDK8hBIaC+ny6BPaEaf5QWHDw/jQiV6M6a3ZbdvDv7QL4Mj3nlFCRn
 2sj/LrC7Jrju310dGt1Pd9jXZnCzp0fYX1ZpmhCDk+iiqJWayR3wgg9FziYeO7dROnum
 2TDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYVElCmY889MyZcPAcz7T2T87meoXtIgo6vPNSH+DMBQSApeTtZk4cxNZDFwQvGBFe0IE0O7P4BFXE@nongnu.org
X-Gm-Message-State: AOJu0Yxc+pF3kEcGsFAtZsACkz/9wB65Dz6bND6rY4uIn8NIcMOZ1uu/
 Ovc4GBmCnRCBZ+1IY1bBkSVuVcaWQ+R/sz9zdqTM3HkRebNZ1aV3Ox9eeVooo+lV6AxwQcpUzU6
 mBOD1V9YaIMmOOO2ccHMuKwSsD4w=
X-Gm-Gg: ASbGncsQJwsS3gS53UYEsr5PCovU0uTwFjo2UR8mRzJqRsqs6O6d01idsmgVr5e0hOe
 XWz9uI1sda2vVxUpAtyayReCZdwzXgjGH
X-Google-Smtp-Source: AGHT+IF9gI8QUt1K+i25OoPMlZM4tXiBwPiMswQ/ANXQIZ2F3ZMCQpi/OncyW4+cac2T8y8DxefizGp1MBWaybDnotk=
X-Received: by 2002:a05:6102:370a:b0:4af:30c3:6a2c with SMTP id
 ada2fe7eead31-4af9723e314mr2013750137.10.1733208217700; Mon, 02 Dec 2024
 22:43:37 -0800 (PST)
MIME-Version: 1.0
References: <20241120153935.24706-1-jim.shu@sifive.com>
 <20241120153935.24706-4-jim.shu@sifive.com>
In-Reply-To: <20241120153935.24706-4-jim.shu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 3 Dec 2024 15:43:11 +0900
Message-ID: <CAKmqyKNwC_9kJDuyui1SscZ5TOmWVCo-PdDzzRSJjFSnD5TxnQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] hw/riscv: Add the checking if DTB overlaps to
 kernel or initrd
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92e.google.com
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

On Thu, Nov 21, 2024 at 12:42=E2=80=AFAM Jim Shu <jim.shu@sifive.com> wrote=
:
>
> DTB is placed to the end of memory, so we will check if the start
> address of DTB overlaps to the address of kernel/initrd.
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/boot.c         | 25 ++++++++++++++++++++++++-
>  include/hw/riscv/boot.h |  3 +++
>  2 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 81d27f935e..bc8074fec8 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -70,6 +70,7 @@ char *riscv_plic_hart_config_string(int hart_count)
>  void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *hart=
s)
>  {
>      info->kernel_size =3D 0;
> +    info->initrd_size =3D 0;
>      info->is_32bit =3D riscv_is_32bit(harts);
>  }
>
> @@ -213,6 +214,9 @@ static void riscv_load_initrd(MachineState *machine, =
RISCVBootInfo *info)
>          }
>      }
>
> +    info->initrd_start =3D start;
> +    info->initrd_size =3D size;
> +
>      /* Some RISC-V machines (e.g. opentitan) don't have a fdt. */
>      if (fdt) {
>          end =3D start + size;
> @@ -309,6 +313,7 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwa=
ddr dram_size,
>      int ret =3D fdt_pack(ms->fdt);
>      hwaddr dram_end, temp;
>      int fdtsize;
> +    uint64_t dtb_start, dtb_start_limit;
>
>      /* Should only fail if we've built a corrupted tree */
>      g_assert(ret =3D=3D 0);
> @@ -319,6 +324,17 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hw=
addr dram_size,
>          exit(1);
>      }
>
> +    if (info->initrd_size) {
> +        /* If initrd is successfully loaded, place DTB after it. */
> +        dtb_start_limit =3D info->initrd_start + info->initrd_size;
> +    } else if (info->kernel_size) {
> +        /* If only kernel is successfully loaded, place DTB after it. */
> +        dtb_start_limit =3D info->image_high_addr;
> +    } else {
> +        /* Otherwise, do not check DTB overlapping */
> +        dtb_start_limit =3D 0;
> +    }
> +
>      /*
>       * A dram_size =3D=3D 0, usually from a MemMapEntry[].size element,
>       * means that the DRAM block goes all the way to ms->ram_size.
> @@ -338,7 +354,14 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hw=
addr dram_size,
>          temp =3D (dram_base < 3072 * MiB) ? MIN(dram_end, 3072 * MiB) : =
dram_end;
>      }
>
> -    return QEMU_ALIGN_DOWN(temp - fdtsize, 2 * MiB);
> +    dtb_start =3D QEMU_ALIGN_DOWN(temp - fdtsize, 2 * MiB);
> +
> +    if (dtb_start_limit && (dtb_start < dtb_start_limit)) {
> +        error_report("No enough memory to place DTB after kernel/initrd"=
);
> +        exit(1);
> +    }
> +
> +    return dtb_start;
>  }
>
>  /*
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index 06b51ed086..7d59b2e6c6 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -32,6 +32,9 @@ typedef struct RISCVBootInfo {
>      hwaddr image_low_addr;
>      hwaddr image_high_addr;
>
> +    hwaddr initrd_start;
> +    ssize_t initrd_size;
> +
>      bool is_32bit;
>  } RISCVBootInfo;
>
> --
> 2.17.1
>
>


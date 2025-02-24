Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0928FC021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 05:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmR7s-00033j-SH; Mon, 24 Feb 2025 00:35:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmQou-0008QQ-UV
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 00:16:05 -0500
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmQot-0006uZ-CB
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 00:15:56 -0500
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-8670fd79990so1143641241.3
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 21:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740374153; x=1740978953; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p1TTEGIxZo2tw5gO+mFK8UbCpQYX5W0Iy95rgepM7eg=;
 b=jqxNh515gURB+zVJMJIJYS3Oqn4mWLnSXxMEj2cTzZ77DIo/xZKaTZlzcq/Klwi9Ql
 n/xCUW8fS3jaL0OLWvBKq1QJQVVCzZdNPqRSHigXqIR1o5pHGkInqoh1xOPf5VIEV7HH
 MGRj59bxoGJLxnye2LPj7ddyRpO11bgu2I2Sohjdt4yuAiGnn+plJtP0TZph03zL9/Vf
 +QxT0yXEMnEdjyabHDB9jlKndd7NhqHKRBcKFO7cy4gOGX8fszkB6erEB7zRGgjfEX1h
 zcvcznfsf+06/fp0R2HdLd4itMX2C9DO0VMZ71RfwwSFhln7BFuNjhKuOt1pDBbvMgN6
 Yeng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740374153; x=1740978953;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p1TTEGIxZo2tw5gO+mFK8UbCpQYX5W0Iy95rgepM7eg=;
 b=o9DZeExf59ZFP5FQXbwJlajdc2J0qx2hhIruzjW/pbsr/lcIS431yOdy3cd58wVyRc
 mR6loLdXAf3nmYV7Uwp1BEWGJIGbtTK1bBFEuaMVak0QEQ76nixP7yCzmKMnPh2GXuVz
 4SPQYSEbdJ1whfhUvwLNFqbeooTXoKligxbmX/NgLMobya7LMs83yuN7UwjpLm+YoIOR
 CdOIrx4fTQoMbrlPngHYVmmv/VxGgEtFkPMtqUKNtrjNz0N0gudfl2RgL/Xuya62phka
 qEiwaau2v+uf0LLGFhLjNLF3MR/v9fCtxdO0xH3x0A7oHS9TcOHmW3m6t+JyeMbOd/hy
 2++w==
X-Gm-Message-State: AOJu0YzZnkz6Wdhm7ktjiKSQXbKTqu5pXbcIzAO6NYdt8zymMLau7/kI
 zR4HAdTKQO5x7luedq2sgIiwXWMIDoRM2PAiliJWR6QiSqaFyhcp0EQrGEXxpuDBWKERTGKZWio
 iY78GS2lUQu4JatLWXrgbE6auccY=
X-Gm-Gg: ASbGncvW1WBl201c+27iVYHxJiYnyKq+cR3HIyJR/lO7sKrcQ0/LrTOLY5dqcUeBKsb
 DxBeZxK0I1Sr8s32HTkutbtwKk2wHaKwNhfAO1WRS7LMS5swznuXJvqBfNrGfFBzKm15mY6rQD1
 Jm7F/2fwVWht/NKErQLC4M9wibvCbx1UtbEEWN
X-Google-Smtp-Source: AGHT+IHtfwqduIQ80zNvSTTEP5CiVGAGEmOVs4fbekdL9JYuAL0/YM7gm7qVOsOs4LL2I58P7mrzRNqj/yRH0iTOpog=
X-Received: by 2002:a05:6102:38cb:b0:4bb:d394:46c0 with SMTP id
 ada2fe7eead31-4bfc0048c15mr5752333137.1.1740374153162; Sun, 23 Feb 2025
 21:15:53 -0800 (PST)
MIME-Version: 1.0
References: <20250214062443.9936-1-sebastian.huber@embedded-brains.de>
 <20250214062443.9936-3-sebastian.huber@embedded-brains.de>
In-Reply-To: <20250214062443.9936-3-sebastian.huber@embedded-brains.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2025 15:15:26 +1000
X-Gm-Features: AWEUYZk6EHZldxLpSkZOveZ5UKlM_Oyyw2VgPx1xT0JwBQeJ2Z9WI9qhADum_Lg
Message-ID: <CAKmqyKN60a4hFPftFKOKPWT0J9NCXOURXYSGA+3pAsj5c0oBFw@mail.gmail.com>
Subject: Re: [PATCH 2/5] hw/riscv: More flexible FDT placement for MPFS
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel@nongnu.org, Conor Dooley <conor.dooley@microchip.com>, 
 Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x934.google.com
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

On Fri, Feb 14, 2025 at 4:26=E2=80=AFPM Sebastian Huber
<sebastian.huber@embedded-brains.de> wrote:
>
> If the kernel entry is in the high DRAM area, place the FDT into this
> area.
>
> Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/microchip_pfsoc.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index ec7e2e4226..2ddc3464bb 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -626,8 +626,15 @@ static void microchip_icicle_kit_machine_init(Machin=
eState *machine)
>          kernel_entry =3D boot_info.image_low_addr;
>
>          /* Compute the fdt load address in dram */
> -        fdt_load_addr =3D riscv_compute_fdt_addr(memmap[MICROCHIP_PFSOC_=
DRAM_LO].base,
> -                                               memmap[MICROCHIP_PFSOC_DR=
AM_LO].size,
> +        hwaddr kernel_ram_base =3D memmap[MICROCHIP_PFSOC_DRAM_LO].base;
> +        hwaddr kernel_ram_size =3D memmap[MICROCHIP_PFSOC_DRAM_LO].size;
> +
> +        if (kernel_entry - kernel_ram_base >=3D kernel_ram_size) {
> +            kernel_ram_base =3D memmap[MICROCHIP_PFSOC_DRAM_HI].base;
> +            kernel_ram_size =3D mem_high_size;
> +        }
> +
> +        fdt_load_addr =3D riscv_compute_fdt_addr(kernel_ram_base, kernel=
_ram_size,
>                                                 machine, &boot_info);
>          riscv_load_fdt(fdt_load_addr, machine->fdt);
>
> --
> 2.43.0
>
>


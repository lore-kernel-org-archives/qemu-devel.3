Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E774FC3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 02:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0WlM-0001LA-Fi; Thu, 03 Apr 2025 22:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0WlK-0001Kf-IJ; Thu, 03 Apr 2025 22:26:30 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0WlF-0002xM-KV; Thu, 03 Apr 2025 22:26:30 -0400
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-86d587dbc15so1414336241.1; 
 Thu, 03 Apr 2025 19:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743733584; x=1744338384; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xoWNwpmcSVbQC8ZI9sjJh7JOlnUzP91VymYLY8630K0=;
 b=KqxxElDQb3gFVMnZavTT9uSQnN1H/6/a+tglx4zHcXjfiax8yI0HxASB+Slz+/eoOL
 cJ4zC7ppED4jzoDhbjRQy1lOz64D5bx/1Bcux0dl1xND5Aa7OqFKSP1AMnEZw3XP717O
 GGVrV4NGcgrn6HrIQW9e7sx0ZUkpoFk2ukXmuVzeDyK+e04sIt60Vry2hXyHLHK1662Y
 HenHb8e9kW/v++uMLzZUo7R9hZp9AfA/Bx5fTpj52izI5KfyDnU7NF3RmFMgL/wVcgoW
 joonEa6F9RzaUxrSCSJ6/eic/DIb4VRp1VlURjTEvhmEQcYOpsPktMQwneg0gxFyowFD
 1SOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743733584; x=1744338384;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xoWNwpmcSVbQC8ZI9sjJh7JOlnUzP91VymYLY8630K0=;
 b=mIXpSMTg6fNZqnPErNtMo3M5+1/cLbftRYCVQqxKZ1Btisa1EoKeyncw8vNrrihUjs
 1Ef9/3tm+ISezd8biHu4wWf9bGvjeU3tIpOcfOJbi71/k09qzxv8wTdALINH01ATMKhA
 GnHCXLdYhzfCZbheCbzohlAyk0KuhKS5AmWZiGWmjLUzdR5HA0+sTcG6gEoSyQcjrUbO
 3g8AeskBzf+W3dmJ1k8lIQGd3U2phy86yXTaPriiVqf3ihCZKbqDYZxQYWwGwLLbSs63
 vNT6Ec0tGlMNd+hovIXAU7GG4fFOkbWBL3hXrwaTIPwcsYF/PMaUcGEE0Vmd3vgvI8Qh
 e+xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0CTk6HFhXMr5nEM97M/0eMgOHbJx8Ak3L3IKEZq4qD0phVEG3OcUxn+zYZY/GztFfEqcZja1Wu1lw@nongnu.org
X-Gm-Message-State: AOJu0YygP4PpdBTnkBd2pYJooUiAQFMLW8SdebSCQsL9V5yYTVNArQKO
 ado0B+RyF0TFpNFhqiAmYhkhmAd2z/PSOzdmQTiVuQsZ1po2QbY2/Tfdcq64jvnBsDm5Pvjo2nN
 nNN8jFz9NI0EEw3pC5Kf2rJEXGJE=
X-Gm-Gg: ASbGnctswjietVXHdcdooafwDvi1m9bRC9XG/qOqqmlLlty5sZsdhBlVZxDqSffjSXh
 MLz/zb8q4nbNeKckvEs7775gk5VKf5mzXmAvO4BfX/IoSfZiqKMWVSwLmg1ld5o6z5CquTBZXi2
 +t8eeLlK2xufvWn7vsifys5U7eXrlY/TAL7x5Q2ZmzgcGKnjzs5Gzhw1LG
X-Google-Smtp-Source: AGHT+IEMt73g3L8OhnEe2LaNF+aKt2rbP9dDJH7dny7BZLfsDzmcR1P0bzmfUf7IA0j11JrD71NQRZnLduDDKV6y4t0=
X-Received: by 2002:a67:e953:0:b0:4c3:64c0:8b14 with SMTP id
 ada2fe7eead31-4c8459ee36cmr4327808137.3.1743733583979; Thu, 03 Apr 2025
 19:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250319061342.26435-1-sebastian.huber@embedded-brains.de>
 <20250319061342.26435-7-sebastian.huber@embedded-brains.de>
In-Reply-To: <20250319061342.26435-7-sebastian.huber@embedded-brains.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Apr 2025 12:25:57 +1000
X-Gm-Features: ATxdqUHXAi0hSmNdAVLf_1CRHl1Ctj65GsBr_dqfJXbfFHjVa8YIyZCMo_nEW2s
Message-ID: <CAKmqyKMzAONAoUOE_MotOVhTXF5xEGbXR1S_xEfZcbH3PKu6Bw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] hw/riscv: microchip_pfsoc: Rework documentation
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
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

On Wed, Mar 19, 2025 at 4:14=E2=80=AFPM Sebastian Huber
<sebastian.huber@embedded-brains.de> wrote:
>
> Mention that running the HSS no longer works.  Document the changed boot
> options.  Reorder documentation blocks.  Update URLs.
>
> Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  docs/system/riscv/microchip-icicle-kit.rst | 124 +++++++--------------
>  1 file changed, 43 insertions(+), 81 deletions(-)
>
> diff --git a/docs/system/riscv/microchip-icicle-kit.rst b/docs/system/ris=
cv/microchip-icicle-kit.rst
> index 40798b1aae..9809e94b84 100644
> --- a/docs/system/riscv/microchip-icicle-kit.rst
> +++ b/docs/system/riscv/microchip-icicle-kit.rst
> @@ -5,10 +5,10 @@ Microchip PolarFire SoC Icicle Kit integrates a PolarFi=
re SoC, with one
>  SiFive's E51 plus four U54 cores and many on-chip peripherals and an FPG=
A.
>
>  For more details about Microchip PolarFire SoC, please see:
> -https://www.microsemi.com/product-directory/soc-fpgas/5498-polarfire-soc=
-fpga
> +https://www.microchip.com/en-us/products/fpgas-and-plds/system-on-chip-f=
pgas/polarfire-soc-fpgas
>
>  The Icicle Kit board information can be found here:
> -https://www.microsemi.com/existing-parts/parts/152514
> +https://www.microchip.com/en-us/development-tool/mpfs-icicle-kit-es
>
>  Supported devices
>  -----------------
> @@ -26,95 +26,48 @@ The ``microchip-icicle-kit`` machine supports the fol=
lowing devices:
>  * 2 GEM Ethernet controllers
>  * 1 SDHC storage controller
>
> +The memory is set to 1537 MiB by default.  A sanity check on RAM size is
> +performed in the machine init routine to prompt user to increase the RAM=
 size
> +to > 1537 MiB when less than 1537 MiB RAM is detected.
> +
>  Boot options
>  ------------
>
> -The ``microchip-icicle-kit`` machine can start using the standard -bios
> -functionality for loading its BIOS image, aka Hart Software Services (HS=
S_).
> -HSS loads the second stage bootloader U-Boot from an SD card. Then a ker=
nel
> -can be loaded from U-Boot. It also supports direct kernel booting via th=
e
> --kernel option along with the device tree blob via -dtb. When direct ker=
nel
> -boot is used, the OpenSBI fw_dynamic BIOS image is used to boot a payloa=
d
> -like U-Boot or OS kernel directly.
> -
> -The user provided DTB should have the following requirements:
> -
> -* The /cpus node should contain at least one subnode for E51 and the num=
ber
> -  of subnodes should match QEMU's ``-smp`` option
> -* The /memory reg size should match QEMU=E2=80=99s selected ram_size via=
 ``-m``
> -* Should contain a node for the CLINT device with a compatible string
> -  "riscv,clint0"
> -
> -QEMU follows below truth table to select which payload to execute:
> -
> -=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D =3D=3D=3D=3D=3D=3D=3D
> --bios    -kernel       -dtb payload
> -=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D =3D=3D=3D=3D=3D=3D=3D
> -    N          N don't care     HSS
> -    Y don't care don't care     HSS
> -    N          Y          Y  kernel
> -=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D =3D=3D=3D=3D=3D=3D=3D
> -
> -The memory is set to 1537 MiB by default which is the minimum required h=
igh
> -memory size by HSS. A sanity check on ram size is performed in the machi=
ne
> -init routine to prompt user to increase the RAM size to > 1537 MiB when =
less
> -than 1537 MiB ram is detected.
> -
> -Running HSS
> ------------
> -
> -HSS 2020.12 release is tested at the time of writing. To build an HSS im=
age
> -that can be booted by the ``microchip-icicle-kit`` machine, type the fol=
lowing
> -in the HSS source tree:
> -
> -.. code-block:: bash
> -
> -  $ export CROSS_COMPILE=3Driscv64-linux-
> -  $ cp boards/mpfs-icicle-kit-es/def_config .config
> -  $ make BOARD=3Dmpfs-icicle-kit-es
> -
> -Download the official SD card image released by Microchip and prepare it=
 for
> -QEMU usage:
> -
> -.. code-block:: bash
> -
> -  $ wget ftp://ftpsoc.microsemi.com/outgoing/core-image-minimal-dev-icic=
le-kit-es-sd-20201009141623.rootfs.wic.gz
> -  $ gunzip core-image-minimal-dev-icicle-kit-es-sd-20201009141623.rootfs=
.wic.gz
> -  $ qemu-img resize core-image-minimal-dev-icicle-kit-es-sd-202010091416=
23.rootfs.wic 4G
> -
> -Then we can boot the machine by:
> -
> -.. code-block:: bash
> -
> -  $ qemu-system-riscv64 -M microchip-icicle-kit -smp 5 \
> -      -bios path/to/hss.bin -sd path/to/sdcard.img \
> -      -nic user,model=3Dcadence_gem \
> -      -nic tap,ifname=3Dtap,model=3Dcadence_gem,script=3Dno \
> -      -display none -serial stdio \
> -      -chardev socket,id=3Dserial1,path=3Dserial1.sock,server=3Don,wait=
=3Don \
> -      -serial chardev:serial1
> +The ``microchip-icicle-kit`` machine provides some options to run a firm=
ware
> +(BIOS) or a kernel image.  QEMU follows below truth table to select the
> +firmware:
>
> -With above command line, current terminal session will be used for the f=
irst
> -serial port. Open another terminal window, and use ``minicom`` to connec=
t the
> -second serial port.
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +-bios          -kernel    firmware
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +none                    N this is an error
> +none                    Y the kernel image
> +NULL, default           N hss.bin
> +NULL, default           Y opensbi-riscv64-generic-fw_dynamic.bin
> +other          don't care the BIOS image
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -.. code-block:: bash
> +Direct Kernel Boot
> +------------------
>
> -  $ minicom -D unix\#serial1.sock
> +Use the ``-kernel`` option to directly run a kernel image.  When a direc=
t
> +kernel boot is requested, a device tree blob may be specified via the ``=
-dtb``
> +option.  Unlike other QEMU machines, this machine does not generate a de=
vice
> +tree for the kernel.  It shall be provided by the user.  The user provid=
ed DTB
> +should meet the following requirements:
>
> -HSS output is on the first serial port (stdio) and U-Boot outputs on the
> -second serial port. U-Boot will automatically load the Linux kernel from
> -the SD card image.
> +* The ``/cpus`` node should contain at least one subnode for E51 and the=
 number
> +  of subnodes should match QEMU's ``-smp`` option.
>
> -Direct Kernel Boot
> -------------------
> +* The ``/memory`` reg size should match QEMU=E2=80=99s selected RAM size=
 via the ``-m``
> +  option.
>
> -Sometimes we just want to test booting a new kernel, and transforming th=
e
> -kernel image to the format required by the HSS bootflow is tedious. We c=
an
> -use '-kernel' for direct kernel booting just like other RISC-V machines =
do.
> +* It should contain a node for the CLINT device with a compatible string
> +  "riscv,clint0".
>
> -In this mode, the OpenSBI fw_dynamic BIOS image for 'generic' platform i=
s
> -used to boot an S-mode payload like U-Boot or OS kernel directly.
> +When ``-bios`` is not specified or set to ``default``, the OpenSBI
> +``fw_dynamic`` BIOS image for the ``generic`` platform is used to boot a=
n
> +S-mode payload like U-Boot or OS kernel directly.
>
>  For example, the following commands show building a U-Boot image from U-=
Boot
>  mainline v2021.07 for the Microchip Icicle Kit board:
> @@ -146,4 +99,13 @@ CAVEATS:
>    ``u-boot.bin`` has to be used which does contain one. To use the ELF i=
mage,
>    we need to change to CONFIG_OF_EMBED or CONFIG_OF_PRIOR_STAGE.
>
> +Running HSS
> +-----------
> +
> +The machine ``microchip-icicle-kit`` used to run the Hart Software Servi=
ces
> +(HSS_), however, the HSS development progressed and the QEMU machine
> +implementation lacks behind.  Currently, running the HSS no longer works=
.
> +There is missing support in the clock and memory controller devices.  In
> +particular, reading from the SD card does not work.
> +
>  .. _HSS: https://github.com/polarfire-soc/hart-software-services
> --
> 2.43.0
>


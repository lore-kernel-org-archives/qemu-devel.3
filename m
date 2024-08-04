Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69D0C3DA64
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 23:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sakpN-0002Ef-2S; Sun, 04 Aug 2024 19:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sakpJ-0002BO-FM; Sun, 04 Aug 2024 19:39:51 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sakpH-0007or-6E; Sun, 04 Aug 2024 19:39:49 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4f524fa193aso2770606e0c.0; 
 Sun, 04 Aug 2024 16:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722814786; x=1723419586; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0U+xTyauori1vXxzIwfbAzhc9juTw6yqskrRV1bW3+8=;
 b=Gos9YN1NhQGb5EoEPw+wgcTwW79nAXIDD5LmCJJCKZexWnkAJ1yFXnWmywZdlyIRcL
 U9tQ4VV7wpfAHOBSbCGpxOoMP7EDutvsV957z+EF9dyzoMmTL0e+sTxwETmHZwOVs/FO
 7ImdFp7h+tlMe7Ji0jKfm5UJB6l94YTFvMj9bI+KIwZGszw93aHkd0wVj/HGGe+2otng
 ErnHE8c671CfVLMwOOdWd84wK9xokkiPX65IGC9tvqUjmrfpbye9BZifJfGVv4bfqKNo
 ECFteDtAwh/8E06ZQuTkr5Z2W8FwsMmJ6Z+ws93kOraCPFmupqelmOw2qoCmmwHjyeVe
 cHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722814786; x=1723419586;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0U+xTyauori1vXxzIwfbAzhc9juTw6yqskrRV1bW3+8=;
 b=gfxGhCQq/t3kJ2d/EyPTztfEfOVyk/PCuvDcuAqElznWeW4iUtQig1/PpNP1AaMU0h
 th7PV2AvnjhcFKQqgLTtVn9o8nGutK3vhD9bllWBcKcsYPiVqLf79D0YAUzIoQ6VpC5y
 cidd42TPU3Q2TTIBLZIUmIRXJmOWpBTOr7lm4ci9AAt8OjmzE2kCKGzEjckikHm8gSpo
 xlmP7rhdHkLAbVoiVb+z7EbXu7lcvUhswv9Yftvu7sD1+bfplPVnFheLuSgrmPfL7lPP
 teqi0JtUvuT6E5ERr9Y6dZ8S+g9ZX168CmcpIaGckCuVgSFoYKOoXgg3eXfCko/85Mq5
 huwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK/WcojHNextNs3+Zg3Xn98LuGmCeAThZXC5Zg1nJX+fve5aVDQZnMCpDR7N1oD2sWtLWsKfUmL1HO0+Y+EUZkCVafD80=
X-Gm-Message-State: AOJu0YzcUuHRrYfHlXPiSarqk6/Y2ZDXiwHQWyOkKJiQRPyP6tlsLwsA
 3DqSRqgg/jsgWr/+MzkpGdz2TUwAwE9BTajctuHD8MkoIzWIv6vdoRwb0zOZfxRrBL0OLBdlluH
 O+cqyx8xQmbOwhA0xqr3GOJodf/w=
X-Google-Smtp-Source: AGHT+IHOqRIPG19vFo4wGbH1y83M3KBLt6Xf6GCgMoY5z5cx0p0LEca++gJSfhXLLHbmK++MNobYcxv64cxQta+YI28=
X-Received: by 2002:a05:6122:1681:b0:4f5:312a:6573 with SMTP id
 71dfb90a1353d-4f8a0ebefafmr7092164e0c.5.1722814785536; Sun, 04 Aug 2024
 16:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240801154334.1009852-1-dbarboza@ventanamicro.com>
 <20240801154334.1009852-13-dbarboza@ventanamicro.com>
In-Reply-To: <20240801154334.1009852-13-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Aug 2024 09:39:19 +1000
Message-ID: <CAKmqyKMV5ip0YMhF97=aPex2q5_-T-MY84ZptGZHxUOu4tF2OA@mail.gmail.com>
Subject: Re: [PATCH for-9.2 v6 12/12] docs/specs: add riscv-iommu
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, jason.chien@sifive.com, frank.chang@sifive.com, 
 ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
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

On Fri, Aug 2, 2024 at 1:46=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Add a simple guideline to use the existing RISC-V IOMMU support we just
> added.
>
> This doc will be updated once we add the riscv-iommu-sys device.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  docs/specs/index.rst       |  1 +
>  docs/specs/riscv-iommu.rst | 80 ++++++++++++++++++++++++++++++++++++++
>  docs/system/riscv/virt.rst | 13 +++++++
>  3 files changed, 94 insertions(+)
>  create mode 100644 docs/specs/riscv-iommu.rst
>
> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> index 1484e3e760..c68cd9ae6c 100644
> --- a/docs/specs/index.rst
> +++ b/docs/specs/index.rst
> @@ -33,3 +33,4 @@ guest hardware that is specific to QEMU.
>     virt-ctlr
>     vmcoreinfo
>     vmgenid
> +   riscv-iommu
> diff --git a/docs/specs/riscv-iommu.rst b/docs/specs/riscv-iommu.rst
> new file mode 100644
> index 0000000000..e3b8f7208e
> --- /dev/null
> +++ b/docs/specs/riscv-iommu.rst
> @@ -0,0 +1,80 @@
> +.. _riscv-iommu:
> +
> +RISC-V IOMMU support for RISC-V machines
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +QEMU implements a RISC-V IOMMU emulation based on the RISC-V IOMMU spec
> +version 1.0 `iommu1.0`_.
> +
> +The emulation includes a PCI reference device, riscv-iommu-pci, that QEM=
U
> +RISC-V boards can use.  The 'virt' RISC-V machine is compatible with thi=
s
> +device.
> +
> +riscv-iommu-pci reference device
> +--------------------------------
> +
> +This device implements the RISC-V IOMMU emulation as recommended by the =
section
> +"Integrating an IOMMU as a PCIe device" of `iommu1.0`_: a PCI device wit=
h base
> +class 08h, sub-class 06h and programming interface 00h.
> +
> +As a reference device it doesn't implement anything outside of the speci=
fication,
> +so it uses a generic default PCI ID given by QEMU: 1b36:0014.
> +
> +To include the device in the 'virt' machine:
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-riscv64 -M virt -device riscv-iommu-pci,[optional_pci_op=
ts] (...)
> +
> +This will add a RISC-V IOMMU PCI device in the board following any addit=
ional
> +PCI parameters (like PCI bus address).  The behavior of the RISC-V IOMMU=
 is
> +defined by the spec but its operation is OS dependent.  As of this writi=
ng the
> +existing Linux kernel support `linux-v8`_, not yet merged, will configur=
e the IOMMU
> +to create IOMMU groups with any eligible cards available in the system,
> +regardless of factors such as the order in which the devices are added i=
n the
> +command line.
> +
> +This means that these command lines are equivalent as far as the current
> +IOMMU kernel driver behaves:
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-riscv64 \
> +        -M virt,aia=3Daplic-imsic,aia-guests=3D5 \
> +        -device riscv-iommu-pci,addr=3D1.0,vendor-id=3D0x1efd,device-id=
=3D0xedf1 \
> +        -device e1000e,netdev=3Dnet1 -netdev user,id=3Dnet1,net=3D192.16=
8.0.0/24 \
> +        -device e1000e,netdev=3Dnet2 -netdev user,id=3Dnet2,net=3D192.16=
8.200.0/24 \
> +        (...)
> +
> +  $ qemu-system-riscv64 \
> +        -M virt,aia=3Daplic-imsic,aia-guests=3D5 \
> +        -device e1000e,netdev=3Dnet1 -netdev user,id=3Dnet1,net=3D192.16=
8.0.0/24 \
> +        -device e1000e,netdev=3Dnet2 -netdev user,id=3Dnet2,net=3D192.16=
8.200.0/24 \
> +        -device riscv-iommu-pci,addr=3D1.0,vendor-id=3D0x1efd,device-id=
=3D0xedf1 \
> +        (...)
> +
> +Both will create iommu groups for the two e1000e cards.
> +
> +Another thing to notice on `linux-v8`_ is that the kernel driver conside=
rs an IOMMU
> +identified as a Rivos device, i.e. it uses Rivos vendor ID.  To use the =
riscv-iommu-pci
> +device with the existing kernel support we need to emulate a Rivos PCI I=
OMMU by
> +setting 'vendor-id' and 'device-id':
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-riscv64 -M virt        \
> +     -device riscv-iommu-pci,vendor-id=3D0x1efd,device-id=3D0xedf1 (...)
> +
> +Several options are available to control the capabilities of the device,=
 namely:
> +
> +- "bus": the bus that the IOMMU device uses
> +- "ioatc-limit": size of the Address Translation Cache (default to 2Mb)
> +- "intremap": enable/disable MSI support
> +- "ats": enable ATS support
> +- "off" (Out-of-reset translation mode: 'on' for DMA disabled, 'off' for=
 'BARE' (passthrough))
> +- "s-stage": enable s-stage support
> +- "g-stage": enable g-stage support
> +
> +.. _iommu1.0: https://github.com/riscv-non-isa/riscv-iommu/releases/down=
load/v1.0/riscv-iommu.pdf
> +
> +.. _linux-v8: https://lore.kernel.org/linux-riscv/cover.1718388908.git.t=
jeznach@rivosinc.com/
> diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> index c3f94f63da..dd884ea919 100644
> --- a/docs/system/riscv/virt.rst
> +++ b/docs/system/riscv/virt.rst
> @@ -84,6 +84,19 @@ none``, as in
>
>  Firmware images used for pflash must be exactly 32 MiB in size.
>
> +riscv-iommu support
> +-------------------
> +
> +The board has support for the riscv-iommu-pci device by using the follow=
ing
> +command line:
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-riscv64 -M virt -device riscv-iommu-pci (...)
> +
> +Refer to :ref:`riscv-iommu` for more information on how the RISC-V IOMMU=
 support
> +works.
> +
>  Machine-specific options
>  ------------------------
>
> --
> 2.45.2
>
>


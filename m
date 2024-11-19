Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DC2D60D09
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 02:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDDob-0007Mb-It; Mon, 18 Nov 2024 21:18:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDDoa-0007M7-AC; Mon, 18 Nov 2024 21:18:04 -0500
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDDoY-0001wx-K1; Mon, 18 Nov 2024 21:18:04 -0500
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-8570543feaaso174761241.2; 
 Mon, 18 Nov 2024 18:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731982681; x=1732587481; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q5uG8pi4qHCg5dp1cKoICpX006whs+vSrbL8C7f4tRI=;
 b=SgLtnAdIcuuzCr3X239TJGw1KO17meRK/4kCHLcHUK8VZ8x4C0symEJZx+rnsp1LYY
 8eytD4xaVb7snqFkWTeB7d/9Oa/smHWmLz9B0xWmpmafkqgO59Nvfct0D3OPaITrZC7g
 7GvlkTvJF9EuutN8cHzDVQnHl0hXMrcFQRgn54biUnawbF3BusYhiK6ef0EP6Q74EEae
 oz7m3KyCIErbUMN+yXlHEpODy1Ci7WS7Q43wVbsHlH3j+VPcSGuHIfwGZ0jFBf5XW1tt
 xQO8Uw/CqDanVulhOh1RBzsMfbqXk/7z3srFAgURtvaapPXvMdEyNRFACavAFQkaiSSc
 lgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731982681; x=1732587481;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q5uG8pi4qHCg5dp1cKoICpX006whs+vSrbL8C7f4tRI=;
 b=lpe25YnGN85Ph7agHBggwIKaazrJEIyWAjYp9f5KErNvJDr3k5KDXj9ylZsx+IwQoT
 MmQPSnCDH3CKbBbeHocm6TmpxaofYkqdzoZyixCkzgb1vRAUmA8OqRStRzoTuzL/3bBY
 wPeGseMRlicqwgqTS3JD5o7H0Zv03qq4et8YTgyZJao0kKrEy6eIqTiSwi/QCdqtnnZV
 /cJZwdlQx5c2pk0vbQnBShnYFSrMG+qViNApVuTpOz4JipLFyeQ4AE0plbezaLKkBJfO
 prFsK6/jLwMvlQQIxfiJN3DHvp1MchgNvolMGBNOnl3xoRUKMORbbhW7oIBwgvt+5uIO
 5waQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ/yqPZWnqhxJB5cWSlzcG4YePvDDZYsZ1eMQkInuXLpxxIUX3OrxUWt5HJTSiIPWmiIkDyQxsyPqQ@nongnu.org
X-Gm-Message-State: AOJu0Yw3Flq5amyNBKxzpON6Lox0ENBVHkM2wab4H/lD5Jy3Det5Yer7
 r8uXVeMFBShGO1JhmOG/kwx6+CWF9tfGQhc0QSSIrzuhgaxP1VV2RaQl1YskiZXfjlY19IGh7JI
 v2HfRt1zhxyWsl6I93fHbGVMZyTo=
X-Google-Smtp-Source: AGHT+IHvr5W2qZKXf+XqQmQOGQ6cd7bC5v09+iRdETgTLOsjtC87xyB2W2wxBU780JEU2KbDaMondSUHnTpfv7v8x+4=
X-Received: by 2002:a05:6102:3f04:b0:4a5:b0d3:cbbe with SMTP id
 ada2fe7eead31-4ad630186a3mr13465842137.1.1731982681097; Mon, 18 Nov 2024
 18:18:01 -0800 (PST)
MIME-Version: 1.0
References: <20241106133407.604587-1-dbarboza@ventanamicro.com>
 <20241106133407.604587-8-dbarboza@ventanamicro.com>
In-Reply-To: <20241106133407.604587-8-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 Nov 2024 12:17:35 +1000
Message-ID: <CAKmqyKPg8RibBZ_jOvcp1o5zgPk20YvszgusznFubTZUw3RKbQ@mail.gmail.com>
Subject: Re: [PATCH for-10.0 7/7] docs/specs: add riscv-iommu-sys information
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x933.google.com
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

On Wed, Nov 6, 2024 at 11:35=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  docs/specs/riscv-iommu.rst | 30 +++++++++++++++++++++++++++---
>  docs/system/riscv/virt.rst | 10 ++++++++++
>  2 files changed, 37 insertions(+), 3 deletions(-)
>
> diff --git a/docs/specs/riscv-iommu.rst b/docs/specs/riscv-iommu.rst
> index 463f4cffb6..b1538c9ead 100644
> --- a/docs/specs/riscv-iommu.rst
> +++ b/docs/specs/riscv-iommu.rst
> @@ -6,9 +6,9 @@ RISC-V IOMMU support for RISC-V machines
>  QEMU implements a RISC-V IOMMU emulation based on the RISC-V IOMMU spec
>  version 1.0 `iommu1.0`_.
>
> -The emulation includes a PCI reference device, riscv-iommu-pci, that QEM=
U
> -RISC-V boards can use.  The 'virt' RISC-V machine is compatible with thi=
s
> -device.
> +The emulation includes a PCI reference device (riscv-iommu-pci) and a pl=
atform
> +bus device (riscv-iommu-sys) that QEMU RISC-V boards can use.  The 'virt=
'
> +RISC-V machine is compatible with both devices.
>
>  riscv-iommu-pci reference device
>  --------------------------------
> @@ -83,6 +83,30 @@ Several options are available to control the capabilit=
ies of the device, namely:
>  - "s-stage": enable s-stage support
>  - "g-stage": enable g-stage support
>
> +riscv-iommu-sys device
> +----------------------
> +
> +This device implements the RISC-V IOMMU emulation as a platform bus devi=
ce that
> +RISC-V boards can use.
> +
> +For the 'virt' board the device is disabled by default.  To enable it us=
e the
> +'iommu-sys' machine option:
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-riscv64 -M virt,iommu-sys=3Don (...)
> +
> +There is no options to configure the capabilities of this device in the =
'virt'
> +board using the QEMU command line.  The device is configured with the fo=
llowing
> +riscv-iommu options:
> +
> +- "ioatc-limit": default value (2Mb)
> +- "intremap": enabled
> +- "ats": enabled
> +- "off": on (DMA disabled)
> +- "s-stage": enabled
> +- "g-stage": enabled
> +
>  .. _iommu1.0: https://github.com/riscv-non-isa/riscv-iommu/releases/down=
load/v1.0/riscv-iommu.pdf
>
>  .. _linux-v8: https://lore.kernel.org/linux-riscv/cover.1718388908.git.t=
jeznach@rivosinc.com/
> diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> index 8e9a2e4dda..537aac0340 100644
> --- a/docs/system/riscv/virt.rst
> +++ b/docs/system/riscv/virt.rst
> @@ -94,6 +94,12 @@ command line:
>
>    $ qemu-system-riscv64 -M virt -device riscv-iommu-pci (...)
>
> +It also has support for the riscv-iommu-sys platform device:
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-riscv64 -M virt,iommu-sys=3Don (...)
> +
>  Refer to :ref:`riscv-iommu` for more information on how the RISC-V IOMMU=
 support
>  works.
>
> @@ -129,6 +135,10 @@ The following machine-specific options are supported=
:
>    having AIA IMSIC (i.e. "aia=3Daplic-imsic" selected). When not specifi=
ed,
>    the default number of per-HART VS-level AIA IMSIC pages is 0.
>
> +- iommu-sys=3D[on|off]
> +
> +  Enables the riscv-iommu-sys platform device. Defaults to 'off'.
> +
>  Running Linux kernel
>  --------------------
>
> --
> 2.45.2
>
>


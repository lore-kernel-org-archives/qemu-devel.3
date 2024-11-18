Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E9BD10F40
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 02:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCr4w-0008TZ-DY; Sun, 17 Nov 2024 21:01:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tCr4u-0008TH-IS; Sun, 17 Nov 2024 21:01:24 -0500
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tCr4s-000647-Oz; Sun, 17 Nov 2024 21:01:24 -0500
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-513d1a9552cso1591047e0c.1; 
 Sun, 17 Nov 2024 18:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731895281; x=1732500081; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pKbRqbS1FVA0Rvlwjoo3u1PxJLZpC+kq8wbjoMwrbyg=;
 b=JtTsAbxI7inHF+hoQbt8DwrDz9HH588PwvhtyNtbssApKmz4TC8PMvMFde/v9OnVoB
 8q+KMX6GO53QHJhB7gA4iF/oY2zuHs50SQap/VMjuBSkeeb4SJrYEmvN7cgzIg7OAbwm
 epObyESR/reZtyQRYAy/sBoXe8EmqJNCneuXSSQF4WF6nqvE/cP6HomG0x0XWQBfcdWR
 MAqiwWvQVy+f4nmm28aSOZuF0hkWwrbmShvpxWev7dfdvQM86ZBAH/Fn5vRXAUF5iOHL
 AOHPtN3XQBzlSPJdj33jxZ472d2JTn6lYw8nf2NzLdL7Nqb5h5ewrtHZmZPZk5kbW0Co
 5a6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731895281; x=1732500081;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pKbRqbS1FVA0Rvlwjoo3u1PxJLZpC+kq8wbjoMwrbyg=;
 b=XvdIzvo7y9GRWpYofjL407eVZyHwh4a+bpLR/AiPqSeCJ3WQPTVd3jr7oB2dHZeMrQ
 wjI66IbytI/+4DLjqnPd8UJ+SXVQk6HbHwPb7UIvD1GLYjUubKkUA3zNbZBilqruhBpy
 jCaxuS2ci4EI6tXeD67o5ndObVI9/1GsISuEv0WWKiFnYJEu+ic+KsuTxXGk1IJv2Jrr
 rlsTMgJM5kOg2HrhNhWqBCImZw2DOtt+6Ld0zl+Yh5A++K3rlzc5mYEu2aaP4h0PVsEq
 ErGbVCzvjJ+k3mIEJnA1k/grrrmwmIfGD8rChtKHHEgEI+JiJgzyIptA7Xg87AodRXHt
 Ntgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSkEn33IR0JS/61e2MqyOSjZj+FH0Yut9tzOT/RiH8rAQnKQfxkSsL4qfWx0gnryfege+rYCabz9Ut@nongnu.org
X-Gm-Message-State: AOJu0YxKblG6Nk72nteKgrMGyrWQ+NhwCF1f3GQ7mWOwOBFYlr2agLGp
 0nv/66R6BCQjkRNC/3/Yo8RtdcnfsHQUeU37nulPZpobKQlR3XqtUdqiQG5cHaF9o9EtiHi6hoZ
 5H2/BJ7VGjIwGeb6tVPqwbRtLYKs=
X-Google-Smtp-Source: AGHT+IHuaIQVWJRF0ABzSEPpxd/BbXZmFuQ25tEUxB9VnBAa53f7eNYN0tg0bmffCkaUz1uYTzDeNG0Ddj2yA7zNz88=
X-Received: by 2002:a05:6122:1ad3:b0:50d:35d9:ad5a with SMTP id
 71dfb90a1353d-51478557213mr8806953e0c.5.1731895281094; Sun, 17 Nov 2024
 18:01:21 -0800 (PST)
MIME-Version: 1.0
References: <20241010190337.376987-1-dbarboza@ventanamicro.com>
 <20241010190337.376987-9-dbarboza@ventanamicro.com>
In-Reply-To: <20241010190337.376987-9-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 Nov 2024 12:00:55 +1000
Message-ID: <CAKmqyKNBy8Pb7cRfkS3FdZ_T0TYWH8y4ap0_szKEW4_917r6KA@mail.gmail.com>
Subject: Re: [PATCH 8/8] docs: update riscv/virt.rst with kernel-irqchip=split
 support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
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

On Fri, Oct 11, 2024 at 5:05=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Also add a new page, docs/specs/riscv-aia.rst, where we're documenting
> the state of AIA support in QEMU w.r.t the controllers being emulated or
> not depending on the AIA and accelerator settings.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  docs/specs/index.rst       |  1 +
>  docs/specs/riscv-aia.rst   | 83 ++++++++++++++++++++++++++++++++++++++
>  docs/system/riscv/virt.rst |  7 ++++
>  3 files changed, 91 insertions(+)
>  create mode 100644 docs/specs/riscv-aia.rst
>
> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> index 6495ed5ed9..9a7d61161f 100644
> --- a/docs/specs/index.rst
> +++ b/docs/specs/index.rst
> @@ -36,3 +36,4 @@ guest hardware that is specific to QEMU.
>     vmgenid
>     rapl-msr
>     rocker
> +   riscv-aia
> diff --git a/docs/specs/riscv-aia.rst b/docs/specs/riscv-aia.rst
> new file mode 100644
> index 0000000000..8097e2f897
> --- /dev/null
> +++ b/docs/specs/riscv-aia.rst
> @@ -0,0 +1,83 @@
> +.. _riscv-aia:
> +
> +RISC-V AIA support for RISC-V machines
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +AIA (Advanced Interrupt Architecture) support is implemented in the ``vi=
rt``
> +RISC-V machine for TCG and KVM accelerators.
> +
> +The support consists of two main modes:
> +
> +- "aia=3Daplic": adds one or more APLIC (Advanced Platform Level Interru=
pt Controller)
> +  devices
> +- "aia=3Daplic-imsic": adds one or more APLIC device and an IMSIC (Incom=
ing MSI
> +   Controller) device for each CPU
> +
> +From an user standpoint, these modes will behave the same regardless of =
the accelerator
> +used.  From a developer standpoint the accelerator settings will change =
what it being
> +emulated in userspace versus what is being emulated by an in-kernel irqc=
hip.
> +
> +When running TCG, all controllers are emulated in userspace, including m=
achine mode
> +(m-mode) APLIC and IMSIC (when applicable).
> +
> +When running KVM:
> +
> +- no m-mode is provided, so there is no m-mode APLIC or IMSIC emulation =
regardless of
> +  the AIA mode chosen
> +- with "aia=3Daplic", s-mode APLIC will be emulated by userspace
> +- with "aia=3Daplic-imsic" there are two possibilities.  If no additiona=
l KVM option
> +  is provided there will be no APLIC or IMSIC emulation in userspace, an=
d the virtual
> +  machine will use the provided in-kernel APLIC and IMSIC controllers.  =
If the user
> +  chooses to use the irqchip in split mode via "-accel kvm,kernel-irqchi=
p=3Dsplit",
> +  s-mode APLIC will be emulated while using the s-mode IMSIC from the ir=
qchip
> +
> +The following table summarizes how the AIA and accelerator options defin=
es what
> +we will emulate in userspace:
> +
> +
> +.. list-table:: How AIA and accel options changes controller emulation
> +   :widths: 25 25 25 25 25 25 25
> +   :header-rows: 1
> +
> +   * - Accel
> +     - Accel props
> +     - AIA type
> +     - APLIC m-mode
> +     - IMSIC m-mode
> +     - APLIC s-mode
> +     - IMSIC s-mode
> +   * - tcg
> +     - ---
> +     - aplic
> +     - emul
> +     - n/a
> +     - emul
> +     - n/a
> +   * - tcg
> +     - ---
> +     - aplic-imsic
> +     - emul
> +     - emul
> +     - emul
> +     - emul
> +   * - kvm
> +     - ---
> +     - aplic
> +     - n/a
> +     - n/a
> +     - emul
> +     - n/a
> +   * - kvm
> +     - none
> +     - aplic-imsic
> +     - n/a
> +     - n/a
> +     - in-kernel
> +     - in-kernel
> +   * - kvm
> +     - irqchip=3Dsplit
> +     - aplic-imsic
> +     - n/a
> +     - n/a
> +     - emul
> +     - in-kernel
> diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> index 9a06f95a34..8cbedf73ef 100644
> --- a/docs/system/riscv/virt.rst
> +++ b/docs/system/riscv/virt.rst
> @@ -110,6 +110,13 @@ The following machine-specific options are supported=
:
>    MSIs. When not specified, this option is assumed to be "none" which se=
lects
>    SiFive PLIC to handle wired interrupts.
>
> +  This option also interacts with '-accel kvm'.  When using "aia=3Daplic=
-imsic"
> +  with KVM, it is possible to set the use of the kernel irqchip in split=
 mode
> +  by using "-accel kvm,kernel-irqchip=3Dsplit".  In this case the ``virt=
`` machine
> +  will emulate the APLIC controller instead of using the APLIC controlle=
r from
> +  the irqchip.  See :ref:`riscv-aia` for more details on all available A=
IA
> +  modes.
> +
>  - aia-guests=3Dnnn
>
>    The number of per-HART VS-level AIA IMSIC pages to be emulated for a g=
uest
> --
> 2.45.2
>
>


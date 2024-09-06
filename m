Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89620C54FC6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 05:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smRQY-0008E2-Vq; Fri, 06 Sep 2024 01:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smRQN-0007dc-9A; Fri, 06 Sep 2024 01:22:24 -0400
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smRQL-0000SJ-HJ; Fri, 06 Sep 2024 01:22:23 -0400
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-49bcfbc732eso537103137.3; 
 Thu, 05 Sep 2024 22:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725600140; x=1726204940; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lb9CyT2Mz/f/J9Y1XlwA6FFJMUqTNefZ6WHuzpE919c=;
 b=Zag6cGifePbveW40s61pux+2VEF+ioWWoGHOd/fa+xxzDcq7LnHOEDB/bo7N5VevbX
 hlTjS/kmDQ9yctiWndfKs5QiI4hW1FmJ1DJnlOBovgIG2lC+nn8lNBHRjnZxshVNiI2S
 c0x5+s86VMT56uV+0PQaYpYJvh2edZ5OSy0g5potRaY3VSz7JaTlHHU0T5cIwwUE7DVN
 9C3gf86R6BtI4q1Cw9QiBbMpimPPI1bsHHKFa3+LsEqkGOf4kbKSFVdrrxhSp/oIX9KD
 CigeZu+/C5gfWfE4oStKIfbLQ4boBigSAbDeGhFd1fPSxAGYewK7ELppCA0C3YmY3pcz
 2sUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725600140; x=1726204940;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lb9CyT2Mz/f/J9Y1XlwA6FFJMUqTNefZ6WHuzpE919c=;
 b=mm1Z28Zv0i/+YkoxrqBoooZ+UQa/juayjBUQgnhzbg678P5JGth2OujnDfRvOd4JbO
 vZbqBz5RFM52KjpQbR/kbUmf3zZBO/0SA4CYv2qLrmRmWYYKoSrGrblaL9azNA5u5/rJ
 3l5yG99eu6Ymz2N1T+qIramH8bwqT5l25OdcLczKnRojGJCqMerkCd9453H8ihF95xNo
 03dR8mFvgym9/QzPM9wddJNEj62jQR/E/owdFZUd4LNEC9VWXPqMEU46G2NcCsOiI3Ir
 /boWJpv8A9NVStfIUhcizuJqfxeOgllUgtOHw3uP+0oDSUsAwiiQpv6EF/HrPGjjl9V4
 fqZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaSBKsSGZPkCJNG/DWGvDT1vjLSWJGwKI5zJ9cLIK2buiJy1FzpJX1ato31jkdhp1++1X+0rdNn/+n@nongnu.org
X-Gm-Message-State: AOJu0Yz3gZTFJL+SfT+a93kKbYnJSY1s5i+b0VZpkegXP6eR76K/i55T
 0E1JhwTdrhnt8jDJmYBhjdYrqHaNeP5hqa2HBwBNmguBMmjxTmzvcF6hqeebrw988eAw8DNGeMT
 UhfmSaggmG0S3pIQtx2SQ7WjhCRE=
X-Google-Smtp-Source: AGHT+IGK4te7aGaVonw84FO7O/F3aH8alWcJ86rOgHcUYmuj6zaXVrowSpLrqySHMDCat1t7Se+cgXeU+Dtz7UlWiE0=
X-Received: by 2002:a05:6102:2ad5:b0:498:e517:70dd with SMTP id
 ada2fe7eead31-49bde1a0100mr1583951137.12.1725600140047; Thu, 05 Sep 2024
 22:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240903201633.93182-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240903201633.93182-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 6 Sep 2024 15:21:54 +1000
Message-ID: <CAKmqyKNeFdp0ruZ7GZK-+T9RZD=zY67HDzsC=x-FrLRaiYwycA@mail.gmail.com>
Subject: Re: [PATCH v7 00/12] riscv: QEMU RISC-V IOMMU Support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com, tjeznach@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2b.google.com
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

On Wed, Sep 4, 2024 at 6:17=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> In this new version the only significant code change was made in patch
> 3, where we're no longer modifying the host address with the translated
> address. The remaining of the changes consist in adding more in-code
> docs (a.k.a comments) on the design choices made in the emulation.
>
> The docs were also changed to mention that, to test this emulation,
> we're using the following kernel:
>
> https://github.com/ventanamicro/linux/tree/dev-upstream
>
> it is based on the latest kernel support posted by Tomasz with
> additional features like VFIO passthrough and irqbypass. Users can use
> this kernel for testing, if they want, until the kernel upstream support
> is more feature completed. At that point we'll remove this Ventana Micro
> github repo from the docs and point to the upstream kernel.
>
> Patches based on alistair/riscv-to-apply.next.
>
> All patches reviewed/acked.
>
> Changes from v6:
> - patch 2:
>   - align RISCV_IOMMU_REG_ICVEC macro value 0x02F8
> - patch 3:
>   - do not modify the host address with the translated (guest) address in
>     riscv_iommu_msi_write(), RISCV_IOMMU_MSI_PTE_M_BASIC case
>   - added a comment explaining the need for the IOVA =3D=3D GPA check
> - patch 8:
>   - added a comment explaining the design decision to not cache identity-=
mapped
>     translations in riscv_iommu_translate()
> - patch 12:
>   - added extra info about how the IOMMU emulation is being tested and
>     which kernel branch users can try it out
> - v6 link: https://lore.kernel.org/qemu-riscv/20240801154334.1009852-1-db=
arboza@ventanamicro.com/
>
>
> Daniel Henrique Barboza (4):
>   pci-ids.rst: add Red Hat pci-id for RISC-V IOMMU device
>   test/qtest: add riscv-iommu-pci tests
>   qtest/riscv-iommu-test: add init queues test
>   docs/specs: add riscv-iommu
>
> Tomasz Jeznach (8):
>   exec/memtxattr: add process identifier to the transaction attributes
>   hw/riscv: add riscv-iommu-bits.h
>   hw/riscv: add RISC-V IOMMU base emulation
>   hw/riscv: add riscv-iommu-pci reference device
>   hw/riscv/virt.c: support for RISC-V IOMMU PCIDevice hotplug
>   hw/riscv/riscv-iommu: add Address Translation Cache (IOATC)
>   hw/riscv/riscv-iommu: add ATS support
>   hw/riscv/riscv-iommu: add DBG support

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  docs/specs/index.rst             |    1 +
>  docs/specs/pci-ids.rst           |    2 +
>  docs/specs/riscv-iommu.rst       |   90 ++
>  docs/system/riscv/virt.rst       |   13 +
>  hw/riscv/Kconfig                 |    4 +
>  hw/riscv/meson.build             |    1 +
>  hw/riscv/riscv-iommu-bits.h      |  421 ++++++
>  hw/riscv/riscv-iommu-pci.c       |  202 +++
>  hw/riscv/riscv-iommu.c           | 2431 ++++++++++++++++++++++++++++++
>  hw/riscv/riscv-iommu.h           |  149 ++
>  hw/riscv/trace-events            |   17 +
>  hw/riscv/trace.h                 |    1 +
>  hw/riscv/virt.c                  |   33 +-
>  include/exec/memattrs.h          |    5 +
>  include/hw/pci/pci.h             |    1 +
>  include/hw/riscv/iommu.h         |   36 +
>  meson.build                      |    1 +
>  tests/qtest/libqos/meson.build   |    4 +
>  tests/qtest/libqos/riscv-iommu.c |   76 +
>  tests/qtest/libqos/riscv-iommu.h |  101 ++
>  tests/qtest/meson.build          |    1 +
>  tests/qtest/riscv-iommu-test.c   |  220 +++
>  22 files changed, 3809 insertions(+), 1 deletion(-)
>  create mode 100644 docs/specs/riscv-iommu.rst
>  create mode 100644 hw/riscv/riscv-iommu-bits.h
>  create mode 100644 hw/riscv/riscv-iommu-pci.c
>  create mode 100644 hw/riscv/riscv-iommu.c
>  create mode 100644 hw/riscv/riscv-iommu.h
>  create mode 100644 hw/riscv/trace-events
>  create mode 100644 hw/riscv/trace.h
>  create mode 100644 include/hw/riscv/iommu.h
>  create mode 100644 tests/qtest/libqos/riscv-iommu.c
>  create mode 100644 tests/qtest/libqos/riscv-iommu.h
>  create mode 100644 tests/qtest/riscv-iommu-test.c
>
> --
> 2.45.2
>
>


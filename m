Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC659D7494E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 01:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5xXB-0004L8-3a; Tue, 29 Oct 2024 21:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t5xX9-0004Jy-0T; Tue, 29 Oct 2024 21:30:03 -0400
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t5xX7-0008UE-5w; Tue, 29 Oct 2024 21:30:02 -0400
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-84fd01c9defso1929169241.0; 
 Tue, 29 Oct 2024 18:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730251800; x=1730856600; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LcsuV1giHEMWV/84waaTqLHpKCE7Q0iQAptGH4wCTmE=;
 b=k9goHvsKwoEWgT0JK+G0zabv5yNmUjHZ6J2/CGfra/4ELH3nsusSYEu0Rw2+NIjxbT
 ds4USxeAlUvrIaWB4g4NGnQLm5bGKvsCxDOvDonl5CjCGCrWRI9wNUK8zw4K7BTVgP1y
 8i8K8irplJrsuIerXzsWqMg3crtcIQiZGms8b+/mRdwPJY4/GUBrb/fpnhlXYUhb6WAP
 7UydJu07ed1t8IJBCV42CieO7iRPn3yt3ikon0td24PguCjommQrK+ZnVNNpm4pl50yD
 zC4OFO4XCTg6MswYLzvNSn0T1UBKGHbVWVwPM0IwrvSec5Tau1gsoBNkqQy5GfMO3Ee7
 NHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730251800; x=1730856600;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LcsuV1giHEMWV/84waaTqLHpKCE7Q0iQAptGH4wCTmE=;
 b=Y64w4lvx6iej+asi/hZArStWF65W7a30MxlL45d8aGnuAGptNM7UqjKCYS3JCrXMWJ
 OZiWqzseiR7QsGLQn0DBc7OGqRTvbpvAMfwMQzyjbL8X0kwxfxPWbBmWUSGb9Dynx2iQ
 sDnF2Kh4dVkok9O92qtOeb29FQkMB+xQLNnwAWoZuMAL0ZeYpMmpig+Z/oKigxBp4x/+
 MqqakmhD6OL143AOhXjbQxP/xMqOwpcOK+ZQg1sqQt20MrR9ROz9WylrnUajXicqWgCp
 MQo2K4CYuTPW3Cb3WslSm14D10gt0DoqWpOQJMjPPQtSEMo7wWkjIFoRgGR5RnJYENpX
 5nSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDubjuCvutA4RR+7kXGNU6NlA/jgQa5LnOeiq91tv0yhvrIgEwKm+UefTc3jViGyCoL7eaUdP2OaXw@nongnu.org
X-Gm-Message-State: AOJu0YydF0IF2k30PQylLnO1217oIVGSsSUXXeBSEW/uA7fZz/wfDWy/
 2pVfn99qtDaIiUh51NFz71fXsOe/iXNOqZlBulhgGi/ZF0ox7TW+Tv86YS3vbNlaIaxzx7KiRyz
 5r7Z2/Xs0R8wDtgotLvACWwjGCx8=
X-Google-Smtp-Source: AGHT+IH0jRTQld5Qvc0UZS1MMPuyd/DR5bydrPtnZItp0LzgZuTDnYjtG4xgHM2C6P0FxG4nZnRt8RHDfJTfH0NIW5c=
X-Received: by 2002:a05:6102:304f:b0:4a8:c03f:f4bd with SMTP id
 ada2fe7eead31-4a8cfd8cd2amr12636926137.29.1730251799676; Tue, 29 Oct 2024
 18:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20241016204038.649340-1-dbarboza@ventanamicro.com>
In-Reply-To: <20241016204038.649340-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 30 Oct 2024 11:29:32 +1000
Message-ID: <CAKmqyKMJYxrucf+b4JecTF3vn6ZhbP9ZMBFm1tP71gm=ZsiQsQ@mail.gmail.com>
Subject: Re: [PATCH v10 00/12] riscv: QEMU RISC-V IOMMU support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92b.google.com
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

On Thu, Oct 17, 2024 at 6:41=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> In this new version we fixed address alignment issues in some command
> queue commands, pointed out by Jason in v9.
>
> No other changes made. Series based on alistair/riscv-to-apply.next.
>
> All patches reviewed.
>
> Changes from v9:
> - patch 3:
>   - fixed cmd.dword1 alignment in riscv_iommu_process_cq_tail()
> - patch 8:
>   - fixed cmd.dword1 alignment in riscv_iommu_process_cq_tail()
> - v9 link: https://lore.kernel.org/qemu-riscv/20241004155721.2154626-1-db=
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
>  hw/riscv/riscv-iommu.c           | 2399 ++++++++++++++++++++++++++++++
>  hw/riscv/riscv-iommu.h           |  130 ++
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
>  tests/qtest/riscv-iommu-test.c   |  210 +++
>  22 files changed, 3748 insertions(+), 1 deletion(-)
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


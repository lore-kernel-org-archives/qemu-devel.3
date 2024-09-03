Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86778CD37AA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 20:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slZxH-00043z-46; Tue, 03 Sep 2024 16:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1slZxF-00040L-3H
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:16:45 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1slZxC-0004Og-EZ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 16:16:44 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-204d391f53bso41125025ad.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 13:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1725394600; x=1725999400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P0qwpmi2We/KeOgu3I8ChwK/WN0aHTMzGUyH4y3uCP0=;
 b=l3r0eKiNuHHqB3MTeEJvIx8tBCjtAFJbGnAJTszoN5cU7F7dEw/Vvdi7Y0CrL9pZpO
 1omzyTmaQutoJB/96vGNjDoYKfXoEehYqytazLY9x226vuJu1jZa6C1Bw18lk/RrlmuG
 dxFq1rx2yR/+h6+lEODdnbS7lNyPcu0c+TbBTQVV7JL0hwnXHMPpbjV9/HvcufJkKGwK
 ZxjXnz3hpUe1piLYWypSr6WPKxr5DPGDaki4MUOh4DwyokEWH9udpZ1i61d8Tt1LrO22
 8HRepTuUqDjkuCXYBCs563HwTHS9TyNoPSr1tA6NdaJWFhTp/m9hxmt7/Fd/K4gGB7Pv
 z8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725394600; x=1725999400;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P0qwpmi2We/KeOgu3I8ChwK/WN0aHTMzGUyH4y3uCP0=;
 b=WSCdTu5K7aZXPk/AWRkirJ2fDEbMW8BMhjl/CytUR+PgCPISWNMoejrf9Va7r9YBP1
 BpXFIlaJ9b/C8EhTGHNIqJt4Z0ztMgk+RqHsE9oGlFvICN2KczGPjJt5wUn8i6UIhEcv
 SiEK+FMJprlWNWl8gNHNiBoIxirrEBZ0eZIBlHonUArXjgVABigEwTNopRNdYyijroMt
 GD2btwYj6GUvdNsEMTqGnJkCyyNQu/taGXLxw8yy6uThTurwPTAoCbV9a2MDPQFaO2v+
 3mqMDdGDyJ8hFpd7iMwgecmbl6AXbisD/rfar5DTr3dBT20qUJsHM41us0bE2Plt5qoH
 em4w==
X-Gm-Message-State: AOJu0YwsoXX76G9ic6x+dzInHoTnswgs9yrC5ig3UJzo+nRAEBpg+mep
 PEDJyFyUINinNL9/TSOreWu+hLrxSEvAYQLwzOiChDMV0mWuhasYt3i4PwHd9fZ1O/TAUwgEkcC
 Z
X-Google-Smtp-Source: AGHT+IHrDXBUtAf75DwJC7E4itQo2urgfU96ngD2OfT++orDLztq4qWTrzKQhHdRamAmsKjBJnFyEQ==
X-Received: by 2002:a17:902:f690:b0:205:8a1a:53eb with SMTP id
 d9443c01a7336-2058a1a5c86mr54011025ad.18.1725394599944; 
 Tue, 03 Sep 2024 13:16:39 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.170.227.130])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-206aea531b3sm2189745ad.216.2024.09.03.13.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 13:16:39 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, tjeznach@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v7 00/12] riscv: QEMU RISC-V IOMMU Support
Date: Tue,  3 Sep 2024 17:16:19 -0300
Message-ID: <20240903201633.93182-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi,

In this new version the only significant code change was made in patch
3, where we're no longer modifying the host address with the translated
address. The remaining of the changes consist in adding more in-code
docs (a.k.a comments) on the design choices made in the emulation.

The docs were also changed to mention that, to test this emulation,
we're using the following kernel:

https://github.com/ventanamicro/linux/tree/dev-upstream

it is based on the latest kernel support posted by Tomasz with
additional features like VFIO passthrough and irqbypass. Users can use
this kernel for testing, if they want, until the kernel upstream support
is more feature completed. At that point we'll remove this Ventana Micro
github repo from the docs and point to the upstream kernel.

Patches based on alistair/riscv-to-apply.next. 

All patches reviewed/acked. 

Changes from v6:
- patch 2:
  - align RISCV_IOMMU_REG_ICVEC macro value 0x02F8
- patch 3:
  - do not modify the host address with the translated (guest) address in
    riscv_iommu_msi_write(), RISCV_IOMMU_MSI_PTE_M_BASIC case
  - added a comment explaining the need for the IOVA == GPA check
- patch 8:
  - added a comment explaining the design decision to not cache identity-mapped
    translations in riscv_iommu_translate()
- patch 12:
  - added extra info about how the IOMMU emulation is being tested and
    which kernel branch users can try it out
- v6 link: https://lore.kernel.org/qemu-riscv/20240801154334.1009852-1-dbarboza@ventanamicro.com/


Daniel Henrique Barboza (4):
  pci-ids.rst: add Red Hat pci-id for RISC-V IOMMU device
  test/qtest: add riscv-iommu-pci tests
  qtest/riscv-iommu-test: add init queues test
  docs/specs: add riscv-iommu

Tomasz Jeznach (8):
  exec/memtxattr: add process identifier to the transaction attributes
  hw/riscv: add riscv-iommu-bits.h
  hw/riscv: add RISC-V IOMMU base emulation
  hw/riscv: add riscv-iommu-pci reference device
  hw/riscv/virt.c: support for RISC-V IOMMU PCIDevice hotplug
  hw/riscv/riscv-iommu: add Address Translation Cache (IOATC)
  hw/riscv/riscv-iommu: add ATS support
  hw/riscv/riscv-iommu: add DBG support

 docs/specs/index.rst             |    1 +
 docs/specs/pci-ids.rst           |    2 +
 docs/specs/riscv-iommu.rst       |   90 ++
 docs/system/riscv/virt.rst       |   13 +
 hw/riscv/Kconfig                 |    4 +
 hw/riscv/meson.build             |    1 +
 hw/riscv/riscv-iommu-bits.h      |  421 ++++++
 hw/riscv/riscv-iommu-pci.c       |  202 +++
 hw/riscv/riscv-iommu.c           | 2431 ++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu.h           |  149 ++
 hw/riscv/trace-events            |   17 +
 hw/riscv/trace.h                 |    1 +
 hw/riscv/virt.c                  |   33 +-
 include/exec/memattrs.h          |    5 +
 include/hw/pci/pci.h             |    1 +
 include/hw/riscv/iommu.h         |   36 +
 meson.build                      |    1 +
 tests/qtest/libqos/meson.build   |    4 +
 tests/qtest/libqos/riscv-iommu.c |   76 +
 tests/qtest/libqos/riscv-iommu.h |  101 ++
 tests/qtest/meson.build          |    1 +
 tests/qtest/riscv-iommu-test.c   |  220 +++
 22 files changed, 3809 insertions(+), 1 deletion(-)
 create mode 100644 docs/specs/riscv-iommu.rst
 create mode 100644 hw/riscv/riscv-iommu-bits.h
 create mode 100644 hw/riscv/riscv-iommu-pci.c
 create mode 100644 hw/riscv/riscv-iommu.c
 create mode 100644 hw/riscv/riscv-iommu.h
 create mode 100644 hw/riscv/trace-events
 create mode 100644 hw/riscv/trace.h
 create mode 100644 include/hw/riscv/iommu.h
 create mode 100644 tests/qtest/libqos/riscv-iommu.c
 create mode 100644 tests/qtest/libqos/riscv-iommu.h
 create mode 100644 tests/qtest/riscv-iommu-test.c

-- 
2.45.2



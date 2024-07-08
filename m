Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D10C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 11:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQmqg-0001YF-9l; Mon, 08 Jul 2024 07:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sQmqW-0001V1-UY
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 07:47:54 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sQmqV-0000yo-4Y
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 07:47:52 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70b31272a04so485169b3a.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 04:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1720439269; x=1721044069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ssh9Ma5QgQhP/BtP7tTXA/GVszx1SV/i+1JHJhg9ESA=;
 b=gxaGU/JE96JSn80dUi2ePw94OlhIgzyXSGj2XXSTmQKAjrAMLt+FTpw15rXCkvOJO9
 KDHan7vX6T+/9DMbPRpVtKzro//hEamLAUWcBQryAfMD+sDzVESo+ddWRw/7LsHj5gEZ
 Anm+vxXemmpGT9KVGo8AtVb7QrV/lC+b4htj44DBseExO7+J8cgKOXKkFqNHkXm3cE4I
 u/fzz1bDJ4g1YPCT2WAWw5mlYh7tGnmJe29+Eoqq0xkSq5YggjoXPOeYpqUcU9YQ4Fgz
 Yg43Ib1wjG/zKkd5FzDBtIE6q1mEjYgT23zqDSYJG+SbTNKnl+Ke2TEC0wsTrynkWW9/
 fGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720439269; x=1721044069;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ssh9Ma5QgQhP/BtP7tTXA/GVszx1SV/i+1JHJhg9ESA=;
 b=Lap2jmHhMrsD8nWA5dfEySr832oCpwQn0vd8rlps1rHACDkMfp+I9zBg2sSgP/ox5w
 qTkYLEHmtLymCtc3GU9sn88YhImLLZpAR6oLBsOQYjr8vbMlY/MX+7NyRw8BKTxvu86Z
 laPZ+DqvRZDpkSN+jkvKfDY1/GDmXZtu5FQB0glBw/5Y+UR5x2+5KLHOL0rt1fje/JZ8
 ItRIBBhSBMk1Yx5g1pAcV5K4QPG0QVsB/LhbdpN9GGWdCc2iD4EiWO2vS545LaoxwY6q
 6wmIRQunvqveVBbX1Jf2YK/sSomo+p775b4h2UWU5/4o7M90KcSSeqnnoQ7/39+9hrr5
 u76Q==
X-Gm-Message-State: AOJu0Yy4IajwTeY41tA9lg+QVXVc7w882pMUzaxAJEYfPHNvHDNXX/eu
 wFfQ1sUFHcwPGV3hF3A6tq8f/npsD0bHZOLBswSSw3LqwsbdaLIhHP3p9+tw2Tg2vtiYsqt7HqD
 s
X-Google-Smtp-Source: AGHT+IHhFf90uJYjckUVJiyJIN5pTNRa742f7177KFnSlPLgblkecaZn1VQ0Dik7DxH5gdlDw1E8Jw==
X-Received: by 2002:a05:6a20:3ca1:b0:1c0:f0af:60d with SMTP id
 adf61e73a8af0-1c0f0af0874mr4923498637.6.1720439268636; 
 Mon, 08 Jul 2024 04:47:48 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b2a432ac6sm2769642b3a.94.2024.07.08.04.47.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 04:47:48 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v2 0/9] RISC-V: ACPI: Namespace updates
Date: Mon,  8 Jul 2024 17:17:32 +0530
Message-ID: <20240708114741.3499585-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This series adds few updates to RISC-V ACPI namespace for virt platform.
Additionally, it has patches to enable ACPI table testing for RISC-V.

1) PCI Link devices need to be created outside the scope of the PCI root
complex to ensure correct probe ordering by the OS. This matches the
example given in ACPI spec as well.

2) Add PLIC and APLIC as platform devices as well to ensure probing
order as per BRS spec [1] requirement.

3) BRS spec requires RISC-V to use new ACPI ID for the generic UART. So,
update the HID of the UART.

4) Enabled ACPI tables tests for RISC-V which were originally part of
[2] but couldn't get merged due to updates required in the expected AML
files. I think combining those patches with this series makes it easier
to merge since expected AML files are updated.

[1] - https://github.com/riscv-non-isa/riscv-brs
[2] - https://lists.gnu.org/archive/html/qemu-devel/2024-06/msg04734.html

Changes since v1:
	1) Made changes in gpex-acpi.c generic as per feedback from
	   Michael. This changes the DSDT for aarch64/virt and microvm
	   machines. Hence, few patches are added to update the expected
	   DSDT files for those machine so that CI tests don't fail.
	2) Added patches to enable ACPI tables tests for RISC-V
	   including a patch to remove the fallback path to
	   search for expected AML files.
	3) Rebased and added tags.

Sunil V L (9):
  hw/riscv/virt-acpi-build.c: Add namespace devices for PLIC and APLIC
  hw/riscv/virt-acpi-build.c: Update the HID of RISC-V UART
  tests/acpi: Allow DSDT acpi table changes for aarch64
  acpi/gpex: Create PCI link devices outside PCI root bridge
  tests/acpi: update expected DSDT blob for aarch64 and  microvm
  tests/qtest/bios-tables-test.c: Remove the fall back path
  tests/acpi: Add empty ACPI data files for RISC-V
  tests/qtest/bios-tables-test.c: Enable basic testing for RISC-V
  tests/acpi: Add expected ACPI AML files for RISC-V

 hw/pci-host/gpex-acpi.c                       |  13 ++---
 hw/riscv/virt-acpi-build.c                    |  49 +++++++++++++++++-
 tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5196 bytes
 .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5282 bytes
 tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6557 bytes
 tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7679 bytes
 tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5398 bytes
 tests/data/acpi/riscv64/virt/APIC             | Bin 0 -> 116 bytes
 tests/data/acpi/riscv64/virt/DSDT             | Bin 0 -> 3576 bytes
 tests/data/acpi/riscv64/virt/FACP             | Bin 0 -> 276 bytes
 tests/data/acpi/riscv64/virt/MCFG             | Bin 0 -> 60 bytes
 tests/data/acpi/riscv64/virt/RHCT             | Bin 0 -> 332 bytes
 tests/data/acpi/riscv64/virt/SPCR             | Bin 0 -> 80 bytes
 tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 3023 -> 3023 bytes
 tests/qtest/bios-tables-test.c                |  40 +++++++++-----
 15 files changed, 81 insertions(+), 21 deletions(-)
 create mode 100644 tests/data/acpi/riscv64/virt/APIC
 create mode 100644 tests/data/acpi/riscv64/virt/DSDT
 create mode 100644 tests/data/acpi/riscv64/virt/FACP
 create mode 100644 tests/data/acpi/riscv64/virt/MCFG
 create mode 100644 tests/data/acpi/riscv64/virt/RHCT
 create mode 100644 tests/data/acpi/riscv64/virt/SPCR

-- 
2.43.0



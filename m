Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59632C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 17:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTPEl-0004hH-14; Mon, 15 Jul 2024 13:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sTPEh-0004ec-Ui
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 13:11:40 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sTPEg-00072a-4r
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 13:11:39 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-24c0dbd2866so2434116fac.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 10:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1721063496; x=1721668296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3b9zgldxquse9HLyjalgcEYR7BU6o4YG8KsqpF1CMxg=;
 b=HK1LTk2chcbBiHaz3547Sl1KJNVh5jI0Twz2r3XwrHEG7SxB+a9luD/3H8jQFkhv0R
 xkKzoFJHIzVsnbkQPt/88QM3ZAbbcAWgXylD+wTKjO4tjRZwYropmZM8Plr9CeRedPtw
 0fuRwRT/YC7S+8Wnrg5up2hX9YjtFj+3jlt24PEFVkacjIJOx5ykhfQ0k0I72DYomg+S
 MTxcGRT/9LUDyv/60shWPyDTlZZ8cMrDMQ9hTMfW2P6LQ54JBA7nrDjbkVguyZsCJFP/
 HKmswSLSyK8NAGopBYu9KlAJ5AsEuH945zg/DH0MhESryWazH3r9bL7q/owA5HEPQGzi
 MUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721063496; x=1721668296;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3b9zgldxquse9HLyjalgcEYR7BU6o4YG8KsqpF1CMxg=;
 b=a0d+x1WHeUXTt36dQMKCpkqCQv/JLvFD8Z6Xfizga1QykhMTLKA3KAXmmWNbx9HDyo
 b0eFBzpL13wtSyyWD4w3I2IZNo4CkzOfNd50STfj4+ekl9n2XiSQaNnwyAx2wQiMxAcw
 d4ul0Jp+wwMg3FKrNDpwMdPtZtKYp9uJNX+dAhbh4yp2fp5clVQdxOcOavt6zhpb3WDn
 kTCiTOQhEEFJQwXbQH2/8HM1vWTaizk9fAKEu3JBUnoPS49Axb601YnzUCDTAXsNAzp5
 L2YOVrZUDzpLcTZmZqOHiU/F7PgvJulhgIVNMcVY857UmjE9KcjraaKk6HiJqGERAERO
 MVJg==
X-Gm-Message-State: AOJu0YyJMoKtfHo673zAA34KEufIn6gEpb5eqZC0pFYBxB+Cs3tY5NHF
 QZ2v4nQO5PqzXcWGBrEZPZ1fsPwe4Jgzp7rWANAQ+6sGsMSspR66BLhjZipn6tzna6R8oZcizih
 rQIs=
X-Google-Smtp-Source: AGHT+IHHzyUFRF74iC7GjyNwENTF2yWQR9mg0tcTaPDgWcnmJk09XbHrGtYOlz88WfT1NJ04pma+gw==
X-Received: by 2002:a05:6871:73a2:b0:254:9501:db80 with SMTP id
 586e51a60fabf-25eae7cd504mr18087625fac.14.1721063495814; 
 Mon, 15 Jul 2024 10:11:35 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eca85ccsm4752618b3a.178.2024.07.15.10.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 10:11:35 -0700 (PDT)
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
Subject: [PATCH v3 0/9] RISC-V: ACPI: Namespace updates
Date: Mon, 15 Jul 2024 22:41:20 +0530
Message-ID: <20240715171129.1168896-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-oa1-x2a.google.com
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

[1] - https://github.com/riscv-non-isa/riscv-brs/blob/main/acpi.adoc
[2] - https://lists.gnu.org/archive/html/qemu-devel/2024-06/msg04734.html

Changes since v2:
	1) Updated commit message with exact requirement in the BRS.
	2) Addressed Igor's comments.
	3) Rebased and updated tags.

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

 hw/pci-host/gpex-acpi.c                       |  13 +++---
 hw/riscv/virt-acpi-build.c                    |  34 ++++++++++++++-
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
 tests/qtest/bios-tables-test.c                |  40 ++++++++++++------
 15 files changed, 66 insertions(+), 21 deletions(-)
 create mode 100644 tests/data/acpi/riscv64/virt/APIC
 create mode 100644 tests/data/acpi/riscv64/virt/DSDT
 create mode 100644 tests/data/acpi/riscv64/virt/FACP
 create mode 100644 tests/data/acpi/riscv64/virt/MCFG
 create mode 100644 tests/data/acpi/riscv64/virt/RHCT
 create mode 100644 tests/data/acpi/riscv64/virt/SPCR

-- 
2.43.0



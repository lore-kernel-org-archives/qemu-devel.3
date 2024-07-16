Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98219C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 14:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTjOo-0003x6-W9; Tue, 16 Jul 2024 10:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sTjOn-0003nO-Ba
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:43:25 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sTjOj-0002zM-Sj
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:43:25 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2c9a1ea8cc3so3964806a91.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 07:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1721141000; x=1721745800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UCtsxLnoZGVjeVIDgQJyyTdc9T9bjwrYX9tr3p9atSE=;
 b=lALfubuFO1VHEjlU96pABzzKJS4Ey9bVknfKafI+lP2NhE2M5tTXfvWh34jLKbIzZ5
 2i25rpXrszJEvzW+Ni0M31s0+Zb1aJ3KFbYW9GtcHeip1QxBmc/NyqMod/A7O6ZxaPwc
 d6Hs6sjKexABQpOs6jswItC0O3ET2Mj32DLObzGKlWxY/oNkkzJluxzbWbikqw+MFSgM
 IlLx96jJ1PSPqcClUL7b/Arc+cIWTbebYFm+nT+wmJYrp0DF/1rHt7rtujj+YdkkOmFj
 IBbBWczDVHa2CvYiVxgQ7W+3fmXjEAiglWFaoQWqWlINs9sbmQgGCDDLcpBPcLrMbq9Z
 S/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721141000; x=1721745800;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UCtsxLnoZGVjeVIDgQJyyTdc9T9bjwrYX9tr3p9atSE=;
 b=EUxnNUHqDl5S4eou6X+FOVBmKvCqeBqs1Lsf18R4l9pVTG7m2gc7iEBEA2dwApcqLd
 9d0cvjAFKkcPDah/v0mOZMRF9IYAkIG+mIX/6mK+uIBU+N01KIKtW2hTJizJ2FV91s0y
 7JW66wKmC35ggvycLlrNYLTj8O+QTn7lKE4z3zvaWeWfe++rlGq0WNRbycFU4IJJ8Hfw
 HGd9kj/KBCSOSJfZhRArHWfKzi4NFhEjHjTsiOrldcgqDH84I232z4zBv+61zhQHNDqm
 602o5W/fOFUhJEsbd3T0Uo8sOmWIo4h8Nv/WH/2kbhx+U4MujskGGkyECQ576mkWwLkX
 53OA==
X-Gm-Message-State: AOJu0YwuR5caa0CylcCwiHqQ1Q0ZnokswSMJMfmzB1ZTqHs3GqMpN6E8
 kK/UqG7wcbgZLvJCA08bGFQIMPJe4jHR+Q37Oji8jiJa26VK7OBRW81zLX/rse3HVCHQnAdpDxb
 JS4w=
X-Google-Smtp-Source: AGHT+IG3oRbCfTyk5v0zSBnsAdlgFwa8NzZU8JvW6kH9MvvNv9IQS6PDzCLwnZslGlhCV9ia3yRFWQ==
X-Received: by 2002:a17:90a:9c3:b0:2c9:90fa:b9f8 with SMTP id
 98e67ed59e1d1-2cb37de324cmr3226056a91.10.1721140999730; 
 Tue, 16 Jul 2024 07:43:19 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2caf480d61bsm6084782a91.18.2024.07.16.07.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 07:43:19 -0700 (PDT)
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
Subject: [PATCH v4 0/9] RISC-V: ACPI: Namespace updates
Date: Tue, 16 Jul 2024 20:12:57 +0530
Message-ID: <20240716144306.2432257-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pj1-x1031.google.com
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

[1] - https://github.com/riscv-non-isa/riscv-brs/releases/download/v0.0.2/riscv-brs-spec.pdf (Chapter 6)
[2] - https://lists.gnu.org/archive/html/qemu-devel/2024-06/msg04734.html

Changes since v3:
	1) Provided link to PDF of the BRS spec instead of source file + commit id.
	2) Updated tags.

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



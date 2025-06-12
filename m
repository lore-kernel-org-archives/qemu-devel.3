Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC17C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 09:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPdqf-0002GK-8y; Thu, 12 Jun 2025 05:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uPdqX-0002Fm-Jr
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 05:03:42 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uPdqT-0000Hd-DW
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 05:03:41 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxLHLcl0poaLcUAQ--.15377S3;
 Thu, 12 Jun 2025 17:03:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxzxvZl0poBIYXAQ--.19666S2;
 Thu, 12 Jun 2025 17:03:22 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v3 0/5] Add bios-tables-test for LoongArch system
Date: Thu, 12 Jun 2025 17:03:16 +0800
Message-Id: <20250612090321.3416594-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxzxvZl0poBIYXAQ--.19666S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patchset adds bios-tables-test for LoongArch64 virt machine
system. Some basic ACPI tables is added here, and it passes with
command make check-qtest-loongarch64 with the result:
 qtest-loongarch64/bios-tables-test OK 42.00s 5 subtests passed

---
v2 .. v3:
  1. Replace parameter cores=4,threads=2 with cores=2,threads=2 in test
     case test_acpi_loongarch64_virt_topology(), so that it passes to
     run on big endian S390 qemu host.
v1 .. v2:
  1. Replace 1024 * 1024 with MiB macro.
  2. Add memory size of all node and node instance and with numa memory
     test case.
  3. Remove requirement with virtio-blk-pci with test case.
  4. Merge patch 6 and patch 3 into together, and adjust patch order.
  5. Add oem-id test case.
---
Bibo Mao (5):
  tests/acpi: Add empty ACPI data files for LoongArch
  tests/qtest/bios-tables-test: Add basic testing for LoongArch
  rebuild-expected-aml.sh: Add support for LoongArch
  tests/acpi: Fill acpi table data for LoongArch
  tests/acpi: Remove stale allowed tables

 tests/data/acpi/loongarch64/virt/APIC         | Bin 0 -> 108 bytes
 .../data/acpi/loongarch64/virt/APIC.topology  | Bin 0 -> 153 bytes
 tests/data/acpi/loongarch64/virt/DSDT         | Bin 0 -> 4641 bytes
 tests/data/acpi/loongarch64/virt/DSDT.memhp   | Bin 0 -> 5862 bytes
 tests/data/acpi/loongarch64/virt/DSDT.numamem | Bin 0 -> 4647 bytes
 .../data/acpi/loongarch64/virt/DSDT.topology  | Bin 0 -> 4943 bytes
 tests/data/acpi/loongarch64/virt/FACP         | Bin 0 -> 268 bytes
 tests/data/acpi/loongarch64/virt/MCFG         | Bin 0 -> 60 bytes
 tests/data/acpi/loongarch64/virt/PPTT         | Bin 0 -> 76 bytes
 .../data/acpi/loongarch64/virt/PPTT.topology  | Bin 0 -> 176 bytes
 tests/data/acpi/loongarch64/virt/SLIT         |   0
 tests/data/acpi/loongarch64/virt/SLIT.numamem | Bin 0 -> 48 bytes
 tests/data/acpi/loongarch64/virt/SPCR         | Bin 0 -> 80 bytes
 tests/data/acpi/loongarch64/virt/SRAT         | Bin 0 -> 104 bytes
 tests/data/acpi/loongarch64/virt/SRAT.memhp   | Bin 0 -> 144 bytes
 tests/data/acpi/loongarch64/virt/SRAT.numamem | Bin 0 -> 144 bytes
 .../data/acpi/loongarch64/virt/SRAT.topology  | Bin 0 -> 152 bytes
 tests/data/acpi/rebuild-expected-aml.sh       |   4 +-
 tests/qtest/bios-tables-test.c                |  79 ++++++++++++++++++
 tests/qtest/meson.build                       |   1 +
 20 files changed, 82 insertions(+), 2 deletions(-)
 create mode 100644 tests/data/acpi/loongarch64/virt/APIC
 create mode 100644 tests/data/acpi/loongarch64/virt/APIC.topology
 create mode 100644 tests/data/acpi/loongarch64/virt/DSDT
 create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.memhp
 create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.numamem
 create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.topology
 create mode 100644 tests/data/acpi/loongarch64/virt/FACP
 create mode 100644 tests/data/acpi/loongarch64/virt/MCFG
 create mode 100644 tests/data/acpi/loongarch64/virt/PPTT
 create mode 100644 tests/data/acpi/loongarch64/virt/PPTT.topology
 create mode 100644 tests/data/acpi/loongarch64/virt/SLIT
 create mode 100644 tests/data/acpi/loongarch64/virt/SLIT.numamem
 create mode 100644 tests/data/acpi/loongarch64/virt/SPCR
 create mode 100644 tests/data/acpi/loongarch64/virt/SRAT
 create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.memhp
 create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.numamem
 create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.topology


base-commit: d9ce74873a6a5a7c504379857461e4ae64fcf0cd
-- 
2.39.3



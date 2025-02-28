Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B6DC282CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 09:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnwek-0000Vh-OT; Fri, 28 Feb 2025 04:27:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tnweg-0000Us-SU
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 04:27:39 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tnwee-0001Ci-3o
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 04:27:38 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxHHKBgcFnXtOFAA--.33119S3;
 Fri, 28 Feb 2025 17:27:29 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxLseBgcFnU5YtAA--.40659S2;
 Fri, 28 Feb 2025 17:27:29 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 0/6] Add bios-tables-test for LoongArch64 system
Date: Fri, 28 Feb 2025 17:27:23 +0800
Message-Id: <20250228092729.543097-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxLseBgcFnU5YtAA--.40659S2
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This patchset add bios-tables-test for LoongArch64 virt machine
system. It works with UEFI bios, with uefi-test-tools LoongArch64
support is added to build bios-tables-test.loongarch64.iso.

Also with test case bios-tables-test, LoongArch64 support is added
and some basic ACPI tables is added here. It passes with command
make check-qtest-loongarch64 with the result:
 qtest-loongarch64/bios-tables-test OK 29.52s 4 subtests passed

Bibo Mao (6):
  uefi-test-tools:: Add LoongArch64 support
  tests/data/uefi-boot-images: Add ISO image for LoongArch system
  tests/qtest/bios-tables-test: Add basic testing for LoongArch64
  tests/acpi: Add empty ACPI data files for LoongArch64
  tests/acpi: Fill acpi table data for LoongArch
  tests/qtest: Enable bios-tables-test for LoongArch

 tests/data/acpi/loongarch64/virt/APIC         | Bin 0 -> 108 bytes
 .../data/acpi/loongarch64/virt/APIC.topology  | Bin 0 -> 213 bytes
 tests/data/acpi/loongarch64/virt/DSDT         | Bin 0 -> 3614 bytes
 tests/data/acpi/loongarch64/virt/DSDT.memhp   | Bin 0 -> 4951 bytes
 tests/data/acpi/loongarch64/virt/FACP         | Bin 0 -> 268 bytes
 tests/data/acpi/loongarch64/virt/MCFG         | Bin 0 -> 60 bytes
 tests/data/acpi/loongarch64/virt/PPTT         | Bin 0 -> 76 bytes
 .../data/acpi/loongarch64/virt/PPTT.topology  | Bin 0 -> 296 bytes
 tests/data/acpi/loongarch64/virt/SLIT         |   0
 tests/data/acpi/loongarch64/virt/SLIT.memhp   | Bin 0 -> 48 bytes
 tests/data/acpi/loongarch64/virt/SPCR         | Bin 0 -> 80 bytes
 tests/data/acpi/loongarch64/virt/SRAT         | Bin 0 -> 104 bytes
 tests/data/acpi/loongarch64/virt/SRAT.memhp   | Bin 0 -> 184 bytes
 .../data/acpi/loongarch64/virt/SRAT.topology  | Bin 0 -> 216 bytes
 .../bios-tables-test.loongarch64.iso.qcow2    | Bin 0 -> 12800 bytes
 tests/qtest/bios-tables-test.c                |  62 ++++++++++++++++++
 tests/qtest/meson.build                       |   3 +-
 tests/uefi-test-tools/Makefile                |   5 +-
 .../UefiTestToolsPkg/UefiTestToolsPkg.dsc     |   6 +-
 tests/uefi-test-tools/uefi-test-build.config  |  10 +++
 20 files changed, 82 insertions(+), 4 deletions(-)
 create mode 100644 tests/data/acpi/loongarch64/virt/APIC
 create mode 100644 tests/data/acpi/loongarch64/virt/APIC.topology
 create mode 100644 tests/data/acpi/loongarch64/virt/DSDT
 create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.memhp
 create mode 100644 tests/data/acpi/loongarch64/virt/FACP
 create mode 100644 tests/data/acpi/loongarch64/virt/MCFG
 create mode 100644 tests/data/acpi/loongarch64/virt/PPTT
 create mode 100644 tests/data/acpi/loongarch64/virt/PPTT.topology
 create mode 100644 tests/data/acpi/loongarch64/virt/SLIT
 create mode 100644 tests/data/acpi/loongarch64/virt/SLIT.memhp
 create mode 100644 tests/data/acpi/loongarch64/virt/SPCR
 create mode 100644 tests/data/acpi/loongarch64/virt/SRAT
 create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.memhp
 create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.topology
 create mode 100644 tests/data/uefi-boot-images/bios-tables-test.loongarch64.iso.qcow2


base-commit: b69801dd6b1eb4d107f7c2f643adf0a4e3ec9124
-- 
2.39.3



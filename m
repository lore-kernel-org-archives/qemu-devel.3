Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54C1C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 15:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzyHH-0006Cy-3L; Fri, 28 Aug 2026 11:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wzyHE-0006CE-2d; Fri, 28 Aug 2026 11:13:56 -0400
Received: from [115.124.30.131] (helo=out30-131.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wzyHB-0002f3-7Z; Fri, 28 Aug 2026 11:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1787930016; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=ooUWlanYV7gNkQZNCh6ZXUk1lJgKVukrOSt2aaGbE7k=;
 b=c65ChS6niY/kKNbphyU/uUp3P+HEgBt+yq7rEXe01S5UparQ2ZHYd9/ggMxf/Ud26HcsNCbq3ZqBOfT8Q51ak0my+9duOOytNrKgUuEbuHT3x4Z3Tbl8kDoWhCFqrP4nzGYN8F+mhxbJP9Ds+NKTelLmmkjm2W9ll2INOx61dZk=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R841e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=cp0613@linux.alibaba.com; NM=1; PH=DS; RN=19; SR=0;
 TI=SMTPD_---0X9md4z4_1787930015; 
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com
 fp:SMTPD_---0X9md4z4_1787930015 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 28 Aug 2026 23:13:35 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, jic23@kernel.org
Cc: pbonzini@redhat.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 anisinha@redhat.com, dave.jiang@intel.com, alison.schofield@intel.com,
 junjie.cao@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: [PATCH v4 6/6] tests/qtest: Update RISC-V CXL ACPI golden master
 binaries
Date: Fri, 28 Aug 2026 23:13:05 +0800
Message-ID: <20260828151317.815-7-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828151317.815-1-cp0613@linux.alibaba.com>
References: <20260828151317.815-1-cp0613@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.131 (deferred)
Received-SPF: pass client-ip=115.124.30.131;
 envelope-from=cp0613@linux.alibaba.com;
 helo=out30-131.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Populate the DSDT.cxl and CEDT.cxl golden master binaries for the
RISC-V CXL bios-tables test and empty
bios-tables-test-allowed-diff.h, following the bios-tables-test update
process.

The expected AML added by this series is:

DSDT.cxl:
  Device (PC0C)        // ACPI0016 CXL host bridge (pxb-cxl, bus 0x0C)
    Name (_CRS, ResourceTemplate () {
        DWordMemory (... 0x40400000 .. 0x405FFFFF ...)   // 32-bit MMIO
        QWordMemory (... 0x400100000 .. 0x40020FFFF ...) // 64-bit MMIO
        WordBusNumber (... 0x000C .. 0x000D ...)
    })
    Method (_OSC, ...)   // PCI host bridge + CXL UUIDs
  Device (CXLM)        // ACPI0017 CXL memory controller
    Name (_HID, "ACPI0017")
    Name (_DEP, Package () { \_SB.PC0C })
    Method (_STA, ...) / Method (_DSM, ...)

CEDT.cxl:
  CHBS : CXL Host Bridge Structure, Register base 0x800000000
  CFMWS: CXL Fixed Memory Window, base 0x810000000, size 4G

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 tests/data/acpi/riscv64/virt/CEDT.cxl       | Bin 0 -> 108 bytes
 tests/data/acpi/riscv64/virt/DSDT.cxl       | Bin 0 -> 6331 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   2 --
 3 files changed, 2 deletions(-)

diff --git a/tests/data/acpi/riscv64/virt/CEDT.cxl b/tests/data/acpi/riscv64/virt/CEDT.cxl
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..81d746dfb09ccb147e26bb64060404ca3191d097 100644
GIT binary patch
literal 108
zc-nJzbqUE~U|?VjaPoKd2v%^42yj*a0!E-1hz+6{7!(+IKx!BefCEf2LP-snumA^?
O0aMEg#QH!C(hmS*@&^F`

literal 0
Hc-jL100001

diff --git a/tests/data/acpi/riscv64/virt/DSDT.cxl b/tests/data/acpi/riscv64/virt/DSDT.cxl
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..c42c37a6a25998a70c42098b500a5e7163ae1513 100644
GIT binary patch
literal 6331
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

literal 0
Hc-jL100001

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index c05fb697a5..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,3 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"riscv64/virt/DSDT.cxl",
-"riscv64/virt/CEDT.cxl",
-- 
2.50.1



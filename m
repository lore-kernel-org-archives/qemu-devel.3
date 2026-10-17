Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FA2CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB78-0002T6-Lm; Sat, 17 Oct 2026 16:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB6Q-0007zm-QB; Sat, 17 Oct 2026 16:34:02 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB6P-0004jG-2Y; Sat, 17 Oct 2026 16:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268906; bh=qRvolJ5qa/tOZOHlXgDhJ4v57RaF5JF67FPon2iMbWw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nddUsQAuQJYrXwdYwx4PbpgLVuvhS5WDFn4ADgAU1PQHs1s5ga6uIL5kqgTeAKU6Q
 km12aQSU+6P8ffR+QENe0j27Zl0+nC1NPVTrbduVL9qPUfFD7GzA/rAMtoRxgoV+NG
 SGredi++cQgl/lkldXYEclV64BH/w5A5Fdto/yhWwR4hfUkLKsyAUMdt8VbX3+6gbD
 mFj/uBaaUSxHyGVyAspFK5rH4etoe6zwsUIUNm/GN6ScmpC2GyNs3kkAytyEYIVPpy
 ihDYAfJn2aafXuRAfMW/gWsKvCA0DmLelYT6EP8DV+C6KBDO4CMl8d8wEVInzdc6cL
 gTdBja2YrCxkw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 81DF31DE789;
 Sat, 17 Oct 2026 23:28:26 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5C8E144345A;
 Sat, 17 Oct 2026 23:28:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Rick Richard <rick@sloservers.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 72/73] tests/qtest/bios-tables-test: Update riscv64
 virt SPCR golden reference
Date: Sat, 17 Oct 2026 23:26:30 +0300
Message-ID: <20261017202638.728621-72-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Rick Richard <rick@sloservers.com>

Update the riscv64 virt SPCR golden reference file to have the fix for
the UART register width.

Diffs from iasl:

@@ -1,58 +1,58 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20230628 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
  * Disassembly of tests/data/acpi/riscv64/virt/SPCR, Sat Oct  3 08:44:51 2026
  *
  * ACPI Data Table [SPCR]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "SPCR"    [Serial Port Console Redirection Table]
 [004h 0004 004h]                Table Length : 0000005A
 [008h 0008 001h]                    Revision : 04
-[009h 0009 001h]                    Checksum : 13
+[009h 0009 001h]                    Checksum : 2B
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001

 [024h 0036 001h]              Interface Type : 12
 [025h 0037 003h]                    Reserved : 000000

 [028h 0040 00Ch]        Serial Port Register : [Generic Address Structure]
 [028h 0040 001h]                    Space ID : 00 [SystemMemory]
-[029h 0041 001h]                   Bit Width : 20
+[029h 0041 001h]                   Bit Width : 08
 [02Ah 0042 001h]                  Bit Offset : 00
 [02Bh 0043 001h]        Encoded Access Width : 01 [Byte Access:8]
 [02Ch 0044 008h]                     Address : 0000000010000000

 [034h 0052 001h]              Interrupt Type : 10
 [035h 0053 001h]         PCAT-compatible IRQ : 00
 [036h 0054 004h]                   Interrupt : 0000000A
 [03Ah 0058 001h]                   Baud Rate : 07
 [03Bh 0059 001h]                      Parity : 00
 [03Ch 0060 001h]                   Stop Bits : 01
 [03Dh 0061 001h]                Flow Control : 00
 [03Eh 0062 001h]               Terminal Type : 03
 [04Ch 0076 001h]                    Reserved : 00
 [040h 0064 002h]               PCI Device ID : FFFF
 [042h 0066 002h]               PCI Vendor ID : FFFF
 [044h 0068 001h]                     PCI Bus : 00
 [045h 0069 001h]                  PCI Device : 00
 [046h 0070 001h]                PCI Function : 00
 [047h 0071 004h]                   PCI Flags : 00000000
 [04Bh 0075 001h]                 PCI Segment : 00
 [04Ch 0076 004h]                    Reserved : 00000000

 Raw Table Data: Length 90 (0x5A)

-    0000: 53 50 43 52 5A 00 00 00 04 13 42 4F 43 48 53 20  // SPCRZ.....BOCHS
+    0000: 53 50 43 52 5A 00 00 00 04 2B 42 4F 43 48 53 20  // SPCRZ....+BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
-    0020: 01 00 00 00 12 00 00 00 00 20 00 01 00 00 00 10  // ......... ......
+    0020: 01 00 00 00 12 00 00 00 00 08 00 01 00 00 00 10  // ................
     0030: 00 00 00 00 10 00 0A 00 00 00 07 00 01 00 03 00  // ................
     0040: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
     0050: 00 00 00 00 02 00 58 00 2E 00                    // ......X...

Signed-off-by: Rick Richard <rick@sloservers.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20261005104008.214588-4-rick@sloservers.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 71041ce05c95fe47fd24175bb2b974bb14f3d029)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/virt/SPCR
index 59d2c8f7f2..6003c230b1 100644
Binary files a/tests/data/acpi/riscv64/virt/SPCR and b/tests/data/acpi/riscv64/virt/SPCR differ
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index aae973048a..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/riscv64/virt/SPCR",
-- 
2.47.3



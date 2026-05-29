Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54ECACD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 02:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSmzu-0000gJ-Tc; Thu, 28 May 2026 22:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangxiang@iscas.ac.cn>)
 id 1wSmzt-0000g7-NN
 for qemu-devel@nongnu.org; Thu, 28 May 2026 22:30:53 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangxiang@iscas.ac.cn>)
 id 1wSmzp-0007N3-9f
 for qemu-devel@nongnu.org; Thu, 28 May 2026 22:30:53 -0400
Received: from localhost (unknown [122.194.100.152])
 by APP-03 (Coremail) with SMTP id rQCowAC3m+JS+hhqAEPNEg--.56S2;
 Fri, 29 May 2026 10:30:42 +0800 (CST)
From: Xiang W <wangxiang@iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: Xiang W <wangxiang@iscas.ac.cn>, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, peter.maydell@linaro.org
Subject: [PATCH v2 3/3] tests/qtest/bios-tables-test: Fix Terminal Type and
 Language field order in SPCR table
Date: Fri, 29 May 2026 10:31:00 +0800
Message-ID: <20260529023100.42508-4-wangxiang@iscas.ac.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529023100.42508-1-wangxiang@iscas.ac.cn>
References: <20260529023100.42508-1-wangxiang@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAC3m+JS+hhqAEPNEg--.56S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AFWxCw15uw1xZF4kur4kZwb_yoW7KFy8pF
 1Utw4qgr48J34xCr1IgFnxJF13GFs3CF1DGry3AryI9F42qF15Arn7tryUK3y5Ar1DWF18
 ZFn7J34vq348GaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
 1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
 6r1q6r43MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
 W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
 1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6x
 IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
 x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
 DU0xZFpf9x0JUyGQDUUUUU=
X-Originating-IP: [122.194.100.152]
X-CM-SenderInfo: pzdqw5pldqwq5lvft2wodfhubq/
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=wangxiang@iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

According to the ACPI Serial Port Console Redirection Table (SPCR)
specification, the field order after Flow Control is:

  - Terminal Type (offset 62, 1 byte)
  - Language (offset 63, 1 byte)

This fixes:
  - tests/data/acpi/loongarch64/virt/SPCR
  - tests/data/acpi/riscv64/virt/SPCR

Diffs from iasl:
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20250404 (64-bit version)
  * Copyright (c) 2000 - 2025 Intel Corporation
  *
- * Disassembly of tests/data/acpi/riscv64/virt/SPCR
+ * Disassembly of /tmp/aml-3fYW7T
  *
  * ACPI Data Table [SPCR]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "SPCR"    [Serial Port Console Redirection Table]
 [004h 0004 004h]                Table Length : 0000005A
 [008h 0008 001h]                    Revision : 04
 [009h 0009 001h]                    Checksum : 13
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001

 [024h 0036 001h]              Interface Type : 12
 [025h 0037 003h]                    Reserved : 000000

 [028h 0040 00Ch]        Serial Port Register : [Generic Address Structure]
 [028h 0040 001h]                    Space ID : 00 [SystemMemory]
 [029h 0041 001h]                   Bit Width : 20
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
-[03Eh 0062 001h]               Terminal Type : 00
-[03Fh 0063 001h]                    Language : 03
+[03Eh 0062 001h]               Terminal Type : 03
+[03Fh 0063 001h]                    Language : 00
 [040h 0064 002h]               PCI Device ID : FFFF
 [042h 0066 002h]               PCI Vendor ID : FFFF
 [044h 0068 001h]                     PCI Bus : 00
 [045h 0069 001h]                  PCI Device : 00
 [046h 0070 001h]                PCI Function : 00
 [047h 0071 004h]                   PCI Flags : 00000000
 [04Bh 0075 001h]                 PCI Segment : 00
 [04Ch 0076 004h]             Uart Clock Freq : 00000000
 [050h 0080 004h]           Precise Baud rate : 00000000
 [054h 0084 002h]       NameSpaceStringLength : 0002
 [056h 0086 002h]       NameSpaceStringOffset : 0058
 [058h 0088 002h]             NamespaceString : "."

 Raw Table Data: Length 90 (0x5A)

     0000: 53 50 43 52 5A 00 00 00 04 13 42 4F 43 48 53 20  // SPCRZ.....BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
     0020: 01 00 00 00 12 00 00 00 00 20 00 01 00 00 00 10  // ......... ......
-    0030: 00 00 00 00 10 00 0A 00 00 00 07 00 01 00 00 03  // ................
+    0030: 00 00 00 00 10 00 0A 00 00 00 07 00 01 00 03 00  // ................
     0040: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
     0050: 00 00 00 00 02 00 58 00 2E 00                    // ......X...

 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20250404 (64-bit version)
  * Copyright (c) 2000 - 2025 Intel Corporation
  *
- * Disassembly of tests/data/acpi/loongarch64/virt/SPCR
+ * Disassembly of /tmp/aml-Z0WhKt
  *
  * ACPI Data Table [SPCR]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "SPCR"    [Serial Port Console Redirection Table]
 [004h 0004 004h]                Table Length : 00000050
 [008h 0008 001h]                    Revision : 02
 [009h 0009 001h]                    Checksum : C1
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001

 [024h 0036 001h]              Interface Type : 00
 [025h 0037 003h]                    Reserved : 000000

 [028h 0040 00Ch]        Serial Port Register : [Generic Address Structure]
 [028h 0040 001h]                    Space ID : 00 [SystemMemory]
 [029h 0041 001h]                   Bit Width : 20
 [02Ah 0042 001h]                  Bit Offset : 00
 [02Bh 0043 001h]        Encoded Access Width : 01 [Byte Access:8]
 [02Ch 0044 008h]                     Address : 000000001FE001E0

 [034h 0052 001h]              Interrupt Type : 00
 [035h 0053 001h]         PCAT-compatible IRQ : 00
 [036h 0054 004h]                   Interrupt : 00000042
 [03Ah 0058 001h]                   Baud Rate : 07
 [03Bh 0059 001h]                      Parity : 00
 [03Ch 0060 001h]                   Stop Bits : 01
 [03Dh 0061 001h]                Flow Control : 00
-[03Eh 0062 001h]               Terminal Type : 00
-[03Fh 0063 001h]                    Language : 03
+[03Eh 0062 001h]               Terminal Type : 03
+[03Fh 0063 001h]                    Language : 00
 [040h 0064 002h]               PCI Device ID : FFFF
 [042h 0066 002h]               PCI Vendor ID : FFFF
 [044h 0068 001h]                     PCI Bus : 00
 [045h 0069 001h]                  PCI Device : 00
 [046h 0070 001h]                PCI Function : 00
 [047h 0071 004h]                   PCI Flags : 00000000
 [04Bh 0075 001h]                 PCI Segment : 00
 [04Ch 0076 004h]             Uart Clock Freq : 00000000
 /**** ACPI table terminates in the middle of a data structure! (dump table)
 CurrentOffset: 50, TableLength: 50 ***/

Reference:
https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial-port-console-redirection-table

Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>
---
 tests/data/acpi/loongarch64/virt/SPCR       | Bin 80 -> 80 bytes
 tests/data/acpi/riscv64/virt/SPCR           | Bin 90 -> 90 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 3 files changed, 1 deletion(-)

diff --git a/tests/data/acpi/loongarch64/virt/SPCR b/tests/data/acpi/loongarch64/virt/SPCR
index 3cc9bbcfb8051e632592d9db0fe3dba0af53ed8d..7bb819cd0d2ad20269e40e4a738709a45260cbb2 100644
GIT binary patch
delta 23
TcmWFtm|!Qw%<vxw7?1z}S|J61

delta 23
TcmWFtm|!Qw!2BNw7?1z}S{?;}

diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/virt/SPCR
index 09617f8793a6f7b1f08172f735b58aa748671540..59d2c8f7f215a604612cbd0294c18bc6301e208a 100644
GIT binary patch
delta 10
Rcma!wnqbGo%rMbG3IGpM0&@TW

delta 10
Rcma!wnqbGoz&z1G3IGpJ0&@TW

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index aae973048a..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/riscv64/virt/SPCR",
-- 
2.47.3



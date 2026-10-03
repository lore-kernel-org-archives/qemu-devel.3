Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA7FCA5FEC
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 16:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD2MU-0006Ku-RH; Sat, 03 Oct 2026 12:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rick@sloservers.com>)
 id 1xD2MD-0006F8-8u; Sat, 03 Oct 2026 12:13:08 -0400
Received: from vps.sloservers.com ([204.109.61.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rick@sloservers.com>)
 id 1xD2M8-0005nL-Qw; Sat, 03 Oct 2026 12:13:05 -0400
Received: from thinking.duckdns.org (unknown [192.168.11.4])
 by vps.sloservers.com (Postfix) with ESMTPS id 4E4DB24275;
 Sat, 03 Oct 2026 16:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sloservers.com;
 s=mail; t=1791043976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YZ6lLZG0dcN6vFa/iiIpdp8gfeHQvdvxql/4MZSjz2o=;
 b=fBfjdMMFuUZpPi3tsuzO9AxFExrgfMb50bcwuHFnDfTwsUNH1XwBEPbzdQ1sgXf4oNJXgP
 DPAPaNtEPtpN5niv7o1KzYhDEDIA+LlmhEI1dzsHVC3Gf5Hn1ahyILe0mm5g/5u66X2BC/
 6qMFv1Bos+CN6sJYokkvoZl+nsOI+GDdFADGR+9VAdTb03ZClNLzzwPxOEXoIW/CV1QeGj
 BZZYmixV/PL0S3ChEhVD5+gJSsqSqTMjS6+P/1/ul56CrI7wTVGWjj4FStzhOaKr6+V2uk
 CNeQCQfu+53wut17pkvNJbTwlex1dH46muauph+U4mPho1oYpBIRcEQ7WatQwg==
Received: from ollopa-pc.thinking.duckdns.org (OPNsense.thinking.duckdns.org
 [192.168.1.5])
 by thinking.duckdns.org (Postfix) with ESMTPSA id AD5771004;
 Sat, 03 Oct 2026 09:12:55 -0700 (PDT)
From: Rick Richard <rick@sloservers.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>
Subject: [PATCH 3/3] tests/qtest/bios-tables-test: Update riscv64 virt SPCR
 golden reference
Date: Sat,  3 Oct 2026 09:12:48 -0700
Message-ID: <20261003161248.38903-4-rick@sloservers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261003161248.38903-1-rick@sloservers.com>
References: <20261003161248.38903-1-rick@sloservers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=204.109.61.218; envelope-from=rick@sloservers.com;
 helo=vps.sloservers.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Update the riscv64 virt SPCR golden reference file to have the fix for
the UART register width.

Diffs from iasl:

@@ -1,58 +1,58 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20230628 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
- * Disassembly of tests/data/acpi/riscv64/virt/SPCR, Sat Oct  3 08:44:51 2026
+ * Disassembly of /tmp/aml-10NUW3, Sat Oct  3 08:44:51 2026
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
---
 tests/data/acpi/riscv64/virt/SPCR           | Bin 90 -> 90 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)

diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/virt/SPCR
index 59d2c8f7f215a604612cbd0294c18bc6301e208a..6003c230b1a901e16dded8719e29dfd81055b474 100644
GIT binary patch
delta 21
ccma!w;tCFM4vJ!6U|`Xn$R*FnF;U9^05RMIE&u=k

delta 21
ccma!w;tCFM4vJ!6U|<oR$R*FHFj30@05N0)E&u=k

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index aae97304..dfb8523c 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/riscv64/virt/SPCR",
-- 
2.43.0



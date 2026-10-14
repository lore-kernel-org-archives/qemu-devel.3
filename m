Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64354CC6B1C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpsQ-0003KX-Aq; Tue, 13 Oct 2026 23:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpsM-000391-EZ
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:41:58 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpsK-0001pz-Ld
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:41:58 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cc4b1f7e8f4so2193512a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949315; x=1792554115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xdvPWuv8zxakG1FAo70OqA0FhB4rWKcTdR7oA6UwWSU=;
 b=nPSFIDPsQrz6HNajv1imaT97dPf9oov/1xD/LaH9+99zIMioNG2F+Ch/FxKc9fPEx+
 U7lr0PA/hX63+bCUbnX6G0qxrwf7akfx/ixIPHPCuyAN+iq1jMO5VYIDG3QpvKD9RAR+
 ZlnSW9VcGBFad6lPIkkoiYjZoDmJSpbaxj/cSyj+Xp3y1CwJvd+xz1J2J/UXLxROFUz9
 EVjG/G/1OTm0DV+2L/yvHOnJXOgLIkb1FF78KfvgtD8Y3Mh/GKeWRfuymxe8qfb/rTbj
 SHwOpK3YNQeJsyFuVGS3ngCeV0Enq9ayVHDMcfCsYvjyi40pfRuvVhtN+px1CNip1Z48
 1xkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949315; x=1792554115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xdvPWuv8zxakG1FAo70OqA0FhB4rWKcTdR7oA6UwWSU=;
 b=ctJ16jLCQhFyqZHvM4RDQkzprIRuBpQeuppXXAnax4uJ2dfctn9fdxP1/OUwy1aWh1
 2nGnOgnaoggik2a+eMfAi6K8lt8HYX2XQk7DEt1asAoaTytTOgK9aljo0nXpLD7bAAEv
 YubUBL/L8ohthTimCGeX5K2HClFK+y4FPaJ3h0LE9d+XVS/A91gWrwc54P85BZg/Kilb
 eaoruvYjV6YCnQSeSDi67a4TuOfDYRuIyp7ndn3l3+urmvmXJJWypLxjMhQ/Nxwpz5d3
 Y3Us3WubSOcspGKqHU4o5veWH1IknPU9IUZcjccIrvecfMwEDOI2kUr5g0Oxe+lamlz9
 KNwQ==
X-Gm-Message-State: AFq9FYJpfM/zPnbDkeJ9D6xJTl1Xvef+3vvmNANYB9nuxjA3ouS/236F
 VKkHpk6MG8zJUpDRS2Br+GkDlbBe/cK9801BBem5WTbApCnqmnDehp1bnMTYwA==
X-Gm-Gg: AYBFou0xn0rH2A2ENpnj2OmdQy/pp1MoWsYWs+7U4qdKkwF/rz9VUSB8XRpmFizwtrK
 lNi9V45PuW5xjGiHD+ARNcaE/xSo6PvjllIsIaDXAoLfvYvBrGe0Gm1XxS4WyQ2KCD9N+7rV10f
 wnOZ/7dfTMAYhF7HLHkUntrjAiGmaM6PYba4XdS4GkJlzjdYJ4l57kEzeDVX2nXu66+XXn3ixBe
 UYGRpJH3Tew/77UNi893mU6kLj5dIbe+NYbIRmH810+YvX37P+2RLfyJHVL2QWVqJUcWc6jeB8C
 vLg1Cgg64gK4XU4rd4BPVrS9PilK+6htYaQfLc4vx/7JwzToLUtlbjsawAllrN0DUQAIVoffQ0V
 CYeQgkSAeINRoHtzTpTl5Nq3Qi4Xl963B0haX2kZsC23LYkNQxS+mJ0ZYcgT0hUDJ+tC7Oxyq42
 GmFW9Ji75x+28a4/GFpS9Koh1yJnSVow7GIXTSM5psrRGPeOm1VJqm3YVZAW+TtLy2g19PRymBt
 +79vcWoMCEi5qME
X-Received: by 2002:a17:90b:1dd1:b0:3a7:e0f4:2857 with SMTP id
 98e67ed59e1d1-3ab3a359dd3mr10494895a91.1.1791949315167; 
 Tue, 13 Oct 2026 20:41:55 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:41:54 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Rick Richard <rick@sloservers.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-stable@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 48/52] tests/qtest/bios-tables-test: Update riscv64 virt SPCR
 golden reference
Date: Wed, 14 Oct 2026 13:39:03 +1000
Message-ID: <20261014033907.3332383-49-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
---
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 tests/data/acpi/riscv64/virt/SPCR           | Bin 90 -> 90 bytes
 2 files changed, 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index aae973048a..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/riscv64/virt/SPCR",
diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/virt/SPCR
index 59d2c8f7f2..6003c230b1 100644
Binary files a/tests/data/acpi/riscv64/virt/SPCR and b/tests/data/acpi/riscv64/virt/SPCR differ
-- 
2.55.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24403CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWQG-0007DF-Hs; Thu, 15 Oct 2026 21:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWNU-0001iI-3Q
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:04:58 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWNS-0004QS-EB
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:04:55 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2e985106c0cso1409315ad.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112693; x=1792717493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xdvPWuv8zxakG1FAo70OqA0FhB4rWKcTdR7oA6UwWSU=;
 b=iCatMH1bqpdjFyApQiCMY54NM+IpbHj6Jqx4eJKQnvKC5DC7YzZjfQ9CS5pTDFXuFC
 GqfDP68lbpbHXT+CwjGKLOLzcTCsrnvnehZ4SBb6Ac7aYGgvFQ3/fHT/6rRmWn+tkdT/
 OeuihG3v/sbYoKhhXSYiQ8H8VHy7jnjYfoIvMUc2z8828sY28v7Rq0alF0OEcSZ4aEMj
 gdeJH2rl/pzhlSGsC/GopDRMpmiw2knnlRlB2GQOb3+OvMdQY0aL8pTd6tM+WWBgnGfL
 rIi2sLPcLTmdGhrB2SyP0d7Vb1fG7RciQn+h9Hh9+6BtPHMgqIyAZNvKt+uLN7qgJWAu
 F3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112693; x=1792717493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xdvPWuv8zxakG1FAo70OqA0FhB4rWKcTdR7oA6UwWSU=;
 b=iu2oTb4yRGRndujeSJIdPf7KyWb6TnEhOCE7e48zbauE/DewabjMugZGMhPV4mBNlY
 pVc4YBg/QnfhcJaWsBCGm0RICGQZyrA3gLlw1kaSw86sYsQ0emLqqmTbNddKUegf+K1n
 ZmzfY3GEExCxycauuKMYgkNp7Bhg3HRoVe/qc+1kYVMTXQDbdvtiJkaChbcHjXZaIPkl
 Dvd19Bo0EQHEe+jg243RVbegjy5/iebQwVI7V/8qoSU73Yq+aVeEN2m1oSa0H7SXIpps
 6fYMTua4xzmjZDPx7hvoxK4aWbgn4JRqz0guaijKjeb/Pl+bKfe2elcGSIcQCl9seplx
 hEEQ==
X-Gm-Message-State: AFq9FYKNHZqHXFHfMjWBJN8OK3QTRtspm6JJHdtQ9C0DLAv1kpn1BnFC
 PTJ9oqRzkUZvB7IWZ/N0eAFRny7xjKWV/0OxQ2wSAqdSMVa0Zcorvk3uiADamw==
X-Gm-Gg: AYBFou0CsjAEGIi1YOQIW/ikV6TIJKDtoJAdKXdrFbOBWj+D7Us61HS41JKiQMpA3Tz
 EYTyR6ntODixb1/jBZadmFGM2hScYz6x4sbFFA7vbHowi15LXhTjGbsrneYdsjAKI9L98JjLULe
 wyfZK09ueLBNTXJKD2m9o5A8SIlJciwmbokDISOef9T0u2uElWjVULN2mmaEtOzQaR4pSpv7nSz
 bTesSCC00HajDhFQC2DLFBRaSsdWT8iikMY/laLdFc4ygaItJ7DmIm8iZI+u8+UGRH29zUfxgSz
 S+TwUM6uESMCrGZ1gB7cV71psye7SF5bNL1pS3quXyNu3Qo/tSM4e8uXRTfafCU0vnWU9lamMME
 zrm5jhe2mOBdnkZhdTz2J8n1tbdHgtUAm0bhcpV68SmW2gHBJ9LSosJPlJRnx13GUQEaUSigMFa
 fDYYwB746T1F05kYDHih2NMfcMMHao0NmLRwD3IDEBt5udm2mo+07aTHAT/yqOMnLDB/jvCOd5v
 CBlrUcjXUJLFB0U
X-Received: by 2002:a17:903:2b07:b0:2e5:a350:34f8 with SMTP id
 d9443c01a7336-2e84280a507mr195698905ad.3.1792112693009; 
 Thu, 15 Oct 2026 18:04:53 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:04:52 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Rick Richard <rick@sloservers.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-stable@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 43/50] tests/qtest/bios-tables-test: Update riscv64 virt
 SPCR golden reference
Date: Fri, 16 Oct 2026 11:02:30 +1000
Message-ID: <20261016010237.1102834-44-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
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



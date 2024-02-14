Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC95C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDDc-0000jO-0C; Wed, 14 Feb 2024 06:14:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDDa-0000iP-B8
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDDX-0006pr-Ch
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K7Ls7uqSEpQ5boWF/LDBroh1T2tN1l+pN+CXJNHb3ag=;
 b=QSXN9982Dgsr8/wI+BQdDc7MDPAMFcmyF4sbofxq1rJBw8qfOyHePwMDhEuCy8obBoPOX9
 phVRBcbDYtD4iN4Au79GYgqOcr/evTqghynpSxcZNZtfkVHTJVyiDelwTAuRudVZRDgpEo
 Q1HqWG/OrU9bD6Yu2KAeM5dk+zWyKyA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-0ZmcHcfcOfKImUz2NcWXAQ-1; Wed, 14 Feb 2024 06:14:17 -0500
X-MC-Unique: 0ZmcHcfcOfKImUz2NcWXAQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a357c92f241so317422066b.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:14:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909255; x=1708514055;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K7Ls7uqSEpQ5boWF/LDBroh1T2tN1l+pN+CXJNHb3ag=;
 b=k8Ijms7xTWn0za2UIhm9ZrtB56/oJVk7B4GhT1shjyEdMR0UIRjxG6g95mOcK9wWUH
 foKwP2sC25Q6+NRjPyKc0MkWkYhgvBXtyjDjToN80KU7VqzkrBrMnKUBdhRiiRD0oYCG
 0cT6XtR/uM7NFJob8wbcT4ieNhDIuzWCCMkb5IkpYZvnE56EnlDbPPRa7tKpHnAPcYpH
 LfYm9sSDIaR+iPRRoH8xNuLEGj8lH+PDBhed8QOoPURwtg00b94YvG4HCRmrCp7dCOs5
 vWm9EnZNs6tw+Xls/HjVQRV6BltCkTYRmhEMecZPZr6Sacv0HLhuWx/S3fA5C7bFCFZJ
 iA9w==
X-Gm-Message-State: AOJu0YxeUyTAlotNaAVcYuv4Qo3eCKVXznzDWdeLwwy/JDe1R3oM+YUo
 Wlkr4op2uiNmp7n41nJ9vw6EJs6zRhJ25HE8i+laUQV/9IJvP5nK/OxqC11zWQJXsAeeGtCPl1v
 KkNnPg6KkP/P13vVP5R06ilz74R20TMHH1xCxnMrkioQM+z/ESGTn1bdPSAHE8QzjMXxhAKYeiH
 xaESoMgEGTjLGAehVAxwiv4wvKHHjd9Q==
X-Received: by 2002:a17:906:f296:b0:a3d:22bf:38f2 with SMTP id
 gu22-20020a170906f29600b00a3d22bf38f2mr1361131ejb.74.1707909255614; 
 Wed, 14 Feb 2024 03:14:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFR1NFPQUEoHPiht1HLUE2CwOTlfELq5I9aa20YUAw3YB1FYDwmksa+1vFOrOHcvr7NO12XcA==
X-Received: by 2002:a17:906:f296:b0:a3d:22bf:38f2 with SMTP id
 gu22-20020a170906f29600b00a3d22bf38f2mr1361108ejb.74.1707909255270; 
 Wed, 14 Feb 2024 03:14:15 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXNy+daEVEzH3m+Zc2jBIlfOYy3WTecnhu0VaX+FVqO9XHk6iV0rCW3G2IDaaXp5SbjYXoUa05H8Z7upGXzvt3hiTz9RHzN0uOPgeM4dLgZl+O8TYde9R0paSwud5fSYQ1dN6YcBicFI3VwviCLcZQE0R4=
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 cx7-20020a170907168700b00a3cdccd7e41sm2180051ejd.98.2024.02.14.03.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:14:14 -0800 (PST)
Date: Wed, 14 Feb 2024 06:14:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bui Quang Minh <minhquangbui99@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 18/60] test: bios-tables-test: add IVRS changed binary
Message-ID: <7618fffdf16e03377390e51c033f0b14d772333a.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Bui Quang Minh <minhquangbui99@gmail.com>

Following the instructions in bios-tables-test, this adds the changed
IVRS.ivrs binary.

New IVRS differs in length, checksum, it enables EFRSup in Virtualization
Info and adds IVHD type 0x11 with the same device entries as in IVHD type
0x10.

ASL diff:

 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20230628 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
- * Disassembly of tests/data/acpi/q35/IVRS.ivrs, Wed Nov  8 21:39:58 2023
+ * Disassembly of /tmp/aml-2ODND2, Wed Nov  8 21:39:58 2023
  *
  * ACPI Data Table [IVRS]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "IVRS"    [I/O Virtualization Reporting Structure]
-[004h 0004 004h]                Table Length : 00000068
+[004h 0004 004h]                Table Length : 000000B0
 [008h 0008 001h]                    Revision : 01
-[009h 0009 001h]                    Checksum : 43
+[009h 0009 001h]                    Checksum : 74
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001

-[024h 0036 004h]         Virtualization Info : 00002800
+[024h 0036 004h]         Virtualization Info : 00002801
 [028h 0040 008h]                    Reserved : 0000000000000000

 [030h 0048 001h]               Subtable Type : 10 [Hardware Definition Block (IVHD)]
 [031h 0049 001h]       Flags (decoded below) : D1
                                      HtTunEn : 1
                                       PassPW : 0
                                    ResPassPW : 0
                                 Isoc Control : 0
                                Iotlb Support : 1
                                     Coherent : 0
                             Prefetch Support : 1
                                  PPR Support : 1
 [032h 0050 002h]                      Length : 0038
 [034h 0052 002h]                    DeviceId : 0010
 [036h 0054 002h]           Capability Offset : 0040
 [038h 0056 008h]                Base Address : 00000000FED80000
@@ -108,25 +108,129 @@
                                   LINT1 Pass : 0

 [060h 0096 001h]               Subtable Type : 48 [Device Entry: Special Device]
 [061h 0097 002h]                   Device ID : 0000
 [063h 0099 001h] Data Setting (decoded below) : 00
                                     INITPass : 0
                                     EIntPass : 0
                                      NMIPass : 0
                                     Reserved : 0
                                  System MGMT : 0
                                   LINT0 Pass : 0
                                   LINT1 Pass : 0
 [064h 0100 001h]                      Handle : 00
 [065h 0101 002h]       Source Used Device ID : 00A0
 [067h 0103 001h]                     Variety : 01

-Raw Table Data: Length 104 (0x68)
+[068h 0104 001h]               Subtable Type : 11 [Hardware Definition Block (IVHD)]
+[069h 0105 001h]       Flags (decoded below) : 11
+                                     HtTunEn : 1
+                                      PassPW : 0
+                                   ResPassPW : 0
+                                Isoc Control : 0
+                               Iotlb Support : 1
+                                    Coherent : 0
+                            Prefetch Support : 0
+                                 PPR Support : 0
+[06Ah 0106 002h]                      Length : 0048
+[06Ch 0108 002h]                    DeviceId : 0010
+[06Eh 0110 002h]           Capability Offset : 0040
+[070h 0112 008h]                Base Address : 00000000FED80000
+[078h 0120 002h]           PCI Segment Group : 0000
+[07Ah 0122 002h]         Virtualization Info : 0000
+[07Ch 0124 004h]                  Attributes : 00000000
+[080h 0128 008h]                   EFR Image : 00000000000029D3
+[088h 0136 008h]                    Reserved : 0000000000000000
+
+[090h 0144 001h]               Subtable Type : 02 [Device Entry: Select One Device]
+[091h 0145 002h]                   Device ID : 0000
+[093h 0147 001h] Data Setting (decoded below) : 00
+                                    INITPass : 0
+                                    EIntPass : 0
+                                     NMIPass : 0
+                                    Reserved : 0
+                                 System MGMT : 0
+                                  LINT0 Pass : 0
+                                  LINT1 Pass : 0
+
+[094h 0148 001h]               Subtable Type : 02 [Device Entry: Select One Device]
+[095h 0149 002h]                   Device ID : 0008
+[097h 0151 001h] Data Setting (decoded below) : 00
+                                    INITPass : 0
+                                    EIntPass : 0
+                                     NMIPass : 0
+                                    Reserved : 0
+                                 System MGMT : 0
+                                  LINT0 Pass : 0
+                                  LINT1 Pass : 0
+
+[098h 0152 001h]               Subtable Type : 02 [Device Entry: Select One Device]
+[099h 0153 002h]                   Device ID : 0010
+[09Bh 0155 001h] Data Setting (decoded below) : 00
+                                    INITPass : 0
+                                    EIntPass : 0
+                                     NMIPass : 0
+                                    Reserved : 0
+                                 System MGMT : 0
+                                  LINT0 Pass : 0
+                                  LINT1 Pass : 0
+
+[09Ch 0156 001h]               Subtable Type : 02 [Device Entry: Select One Device]
+[09Dh 0157 002h]                   Device ID : 00F8
+[09Fh 0159 001h] Data Setting (decoded below) : 00
+                                    INITPass : 0
+                                    EIntPass : 0
+                                     NMIPass : 0
+                                    Reserved : 0
+                                 System MGMT : 0
+                                  LINT0 Pass : 0
+                                  LINT1 Pass : 0
+
+[0A0h 0160 001h]               Subtable Type : 02 [Device Entry: Select One Device]
+[0A1h 0161 002h]                   Device ID : 00FA
+[0A3h 0163 001h] Data Setting (decoded below) : 00
+                                    INITPass : 0
+                                    EIntPass : 0
+                                     NMIPass : 0
+                                    Reserved : 0
+                                 System MGMT : 0
+                                  LINT0 Pass : 0
+                                  LINT1 Pass : 0
+
+[0A4h 0164 001h]               Subtable Type : 02 [Device Entry: Select One Device]
+[0A5h 0165 002h]                   Device ID : 00FB
+[0A7h 0167 001h] Data Setting (decoded below) : 00
+                                    INITPass : 0
+                                    EIntPass : 0
+                                     NMIPass : 0
+                                    Reserved : 0
+                                 System MGMT : 0
+                                  LINT0 Pass : 0
+                                  LINT1 Pass : 0
+
+[0A8h 0168 001h]               Subtable Type : 48 [Device Entry: Special Device]
+[0A9h 0169 002h]                   Device ID : 0000
+[0ABh 0171 001h] Data Setting (decoded below) : 00
+                                    INITPass : 0
+                                    EIntPass : 0
+                                     NMIPass : 0
+                                    Reserved : 0
+                                 System MGMT : 0
+                                  LINT0 Pass : 0
+                                  LINT1 Pass : 0
+[0ACh 0172 001h]                      Handle : 00
+[0ADh 0173 002h]       Source Used Device ID : 00A0
+[0AFh 0175 001h]                     Variety : 01
+
+Raw Table Data: Length 176 (0xB0)

-    0000: 49 56 52 53 68 00 00 00 01 43 42 4F 43 48 53 20  // IVRSh....CBOCHS
+    0000: 49 56 52 53 B0 00 00 00 01 74 42 4F 43 48 53 20  // IVRS.....tBOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
-    0020: 01 00 00 00 00 28 00 00 00 00 00 00 00 00 00 00  // .....(..........
+    0020: 01 00 00 00 01 28 00 00 00 00 00 00 00 00 00 00  // .....(..........
     0030: 10 D1 38 00 10 00 40 00 00 00 D8 FE 00 00 00 00  // ..8...@.........
     0040: 00 00 00 00 44 00 00 00 02 00 00 00 02 08 00 00  // ....D...........
     0050: 02 10 00 00 02 F8 00 00 02 FA 00 00 02 FB 00 00  // ................
-    0060: 48 00 00 00 00 A0 00 01                          // H.......
+    0060: 48 00 00 00 00 A0 00 01 11 11 48 00 10 00 40 00  // H.........H...@.
+    0070: 00 00 D8 FE 00 00 00 00 00 00 00 00 00 00 00 00  // ................
+    0080: D3 29 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // .)..............
+    0090: 02 00 00 00 02 08 00 00 02 10 00 00 02 F8 00 00  // ................
+    00A0: 02 FA 00 00 02 FB 00 00 48 00 00 00 00 A0 00 01  // ........H.......

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
Message-Id: <20240111154404.5333-8-minhquangbui99@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 tests/data/acpi/q35/IVRS.ivrs               | Bin 104 -> 176 bytes
 2 files changed, 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index ac420db6b7..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/q35/IVRS.ivrs",
diff --git a/tests/data/acpi/q35/IVRS.ivrs b/tests/data/acpi/q35/IVRS.ivrs
index 17611202e53a32f7da8e4925d6955b384670b8b1..7f9e91aabc0b7777a7efc9f219587a4f91f0edb1 100644
GIT binary patch
delta 63
zcmd1Uz{uqp78JaJfq{XsWFnUoBjZF>XH`K#4+a4S2cY1Me?S5bE^ES>3=9)pl>vea
B3FiO+

delta 22
dcmdnMn8D>478IPpz`(%hJdsO^kzt~$GXOlo1j7IT

-- 
MST



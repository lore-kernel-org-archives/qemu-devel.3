Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4587EC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSMp-0004az-1M; Mon, 14 Jul 2025 19:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSJE-0005Or-N4
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:10:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSJC-0005zq-6C
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HHpH/dEfrSL64WNz8DgnaOGW+sTN6Mrep3tcTvJ3rKM=;
 b=YZ8nR5gRLpRLCxZy4wRE8auBfyxWNvbSpMXWEHUvqAS7FR03yZc3+gKBkmqfEuf/Y9cJd7
 C5lbsaO47W5/6mXSyBMePQxXw1kloXBeijQYjVxrIx0WRcaT09gi/Ndl3WY0NbaTIZr3EP
 ioPvbgh54QAUPGTznx4xPFpV9dOZ/nw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-fUmSHb_OOwGvVht4so3ISw-1; Mon, 14 Jul 2025 19:10:04 -0400
X-MC-Unique: fUmSHb_OOwGvVht4so3ISw-1
X-Mimecast-MFC-AGG-ID: fUmSHb_OOwGvVht4so3ISw_1752534603
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4560f28b2b1so7124735e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534602; x=1753139402;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HHpH/dEfrSL64WNz8DgnaOGW+sTN6Mrep3tcTvJ3rKM=;
 b=ZkX98fxBitxAPxOWA5nr58fVMijMc9GvtardCkjIQaZ9Wz8Hr2PDijT6RWhqgG+0hs
 /oknvuPhA5ZbajmuKyArUt7nEEt2BdN5mxx3C8OESZl6UgDWYij9U7xHV5GfXjU2lj9M
 1Bf88uvErI/DBQ/wF1YyEK4AlnQeZu3sANLEGB3BuMocUGG3It5U5OQp6fcTAusWQV6c
 2rELaEOH3dV8FjOHJBvOIieKDMVN6yPBGa1g5/JHV9+01hGbyYDSVVbg6i8qHTVAwjIK
 SDLaC5PR7NrZ5kqQVMajwBj9y7RLbp8j+Z3kD/9VwJHOG72Ja3y82U0895Dro7DfPZqU
 GlpQ==
X-Gm-Message-State: AOJu0YzQPEOQCdIR1mDDWcfdlid5Q8J1blqDo8e7aPsrZQpiVRCoD+GW
 aoDuEdYZsybM1ceRsU0Fzprzp9bL39qxfCbbQG2XR9/kEyx6lOLuV6fDgxHeX1z7NyLiGe5RGl+
 /p1bsCopz49N8nBOz4YknKooRlRJlM62UpePrGPiYIFl4Yx2OUW28y6M2l5cdqmbmjryr45VfYh
 ZmqWVCjaJkDjOon+oHzNpxORJiY0GfGlbAZg==
X-Gm-Gg: ASbGncuumrJ5/IylyxUPpglXT/N2ZVowMnp0TNQZDBayljz5iCjyqlup4dXHPrjlLxg
 Jk47SdQQRgaYlll/KqWiY8VrgyXfANM8vGB2GDZUX5YQUbZN2l6YAseaBhFKdX6A7/z8abFc0I/
 MrLeA7fN6NGMfDotJ7pQ1gf+zF7BcdNDn4NN/FDfUOLqSzYfSi58oEM8YhDifWLfE1MbR0c7xBY
 oax+AmRhO/GOPCkLGLJ2ZuW48Fp2WesZnlYL1w9eqAMyn2aisXxc3SWy7jta73tZ2dHDKdgoGZV
 FkEy4z6IPym31/IkBlwA2o8aon19Jjdi
X-Received: by 2002:a05:600c:3d8f:b0:43b:ca39:6c75 with SMTP id
 5b1f17b1804b1-45565ed6320mr142241565e9.16.1752534602367; 
 Mon, 14 Jul 2025 16:10:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgIcMK/OpdqavfiboPDFVPq/xsZ3FOLnChRalYtnDdcdO0eL38Ngsj9gexgNpDkwIqVYF/dw==
X-Received: by 2002:a05:600c:3d8f:b0:43b:ca39:6c75 with SMTP id
 5b1f17b1804b1-45565ed6320mr142241365e9.16.1752534601815; 
 Mon, 14 Jul 2025 16:10:01 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e211dcsm13234881f8f.84.2025.07.14.16.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:10:01 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:09:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 86/97] tests: virt: Update expected ACPI tables for virt test
Message-ID: <1724a0462a62afc4635317a8d97142cba81be219.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Alireza Sanaee <alireza.sanaee@huawei.com>

Update the ACPI tables according to the acpi aml_build change, also
empty bios-tables-test-allowed-diff.h.

The disassembled differences between actual and expected PPTT shows
below. Only about the root node adding and identification flag set
as expected.

Diff regarding Loongarch64:

 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20230628 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
- * Disassembly of tests/data/acpi/loongarch64/virt/PPTT, Mon Jul 14 16:15:12 2025
+ * Disassembly of /tmp/aml-4A0092, Mon Jul 14 16:15:12 2025
  *
  * ACPI Data Table [PPTT]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "PPTT"    [Processor Properties Topology Table]
-[004h 0004 004h]                Table Length : 0000004C
+[004h 0004 004h]                Table Length : 00000060
 [008h 0008 001h]                    Revision : 02
-[009h 0009 001h]                    Checksum : A8
+[009h 0009 001h]                    Checksum : 27
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001

 [024h 0036 001h]               Subtable Type : 00 [Processor Hierarchy Node]
 [025h 0037 001h]                      Length : 14
 [026h 0038 002h]                    Reserved : 0000
-[028h 0040 004h]       Flags (decoded below) : 00000001
+[028h 0040 004h]       Flags (decoded below) : 00000011
                             Physical package : 1
                      ACPI Processor ID valid : 0
                        Processor is a thread : 0
                               Node is a leaf : 0
-                    Identical Implementation : 0
+                    Identical Implementation : 1
 [02Ch 0044 004h]                      Parent : 00000000
 [030h 0048 004h]           ACPI Processor ID : 00000000
 [034h 0052 004h]     Private Resource Number : 00000000

 [038h 0056 001h]               Subtable Type : 00 [Processor Hierarchy Node]
 [039h 0057 001h]                      Length : 14
 [03Ah 0058 002h]                    Reserved : 0000
-[03Ch 0060 004h]       Flags (decoded below) : 0000000A
+[03Ch 0060 004h]       Flags (decoded below) : 00000011
+                            Physical package : 1
+                     ACPI Processor ID valid : 0
+                       Processor is a thread : 0
+                              Node is a leaf : 0
+                    Identical Implementation : 1
+[040h 0064 004h]                      Parent : 00000024
+[044h 0068 004h]           ACPI Processor ID : 00000000
+[048h 0072 004h]     Private Resource Number : 00000000
+
+[04Ch 0076 001h]               Subtable Type : 00 [Processor Hierarchy Node]
+[04Dh 0077 001h]                      Length : 14
+[04Eh 0078 002h]                    Reserved : 0000
+[050h 0080 004h]       Flags (decoded below) : 0000000A
                             Physical package : 0
                      ACPI Processor ID valid : 1
                        Processor is a thread : 0
                               Node is a leaf : 1
                     Identical Implementation : 0
-[040h 0064 004h]                      Parent : 00000024
-[044h 0068 004h]           ACPI Processor ID : 00000000
-[048h 0072 004h]     Private Resource Number : 00000000
+[054h 0084 004h]                      Parent : 00000038
+[058h 0088 004h]           ACPI Processor ID : 00000000
+[05Ch 0092 004h]     Private Resource Number : 00000000

-Raw Table Data: Length 76 (0x4C)
+Raw Table Data: Length 96 (0x60)

-    0000: 50 50 54 54 4C 00 00 00 02 A8 42 4F 43 48 53 20  // PPTTL.....BOCHS
+    0000: 50 50 54 54 60 00 00 00 02 27 42 4F 43 48 53 20  // PPTT`....'BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
-    0020: 01 00 00 00 00 14 00 00 01 00 00 00 00 00 00 00  // ................
-    0030: 00 00 00 00 00 00 00 00 00 14 00 00 0A 00 00 00  // ................
-    0040: 24 00 00 00 00 00 00 00 00 00 00 00              // $...........
+    0020: 01 00 00 00 00 14 00 00 11 00 00 00 00 00 00 00  // ................
+    0030: 00 00 00 00 00 00 00 00 00 14 00 00 11 00 00 00  // ................
+    0040: 24 00 00 00 00 00 00 00 00 00 00 00 00 14 00 00  // $...............
+    0050: 0A 00 00 00 38 00 00 00 00 00 00 00 00 00 00 00  // ....8...........

Diff regarding ARM64:
/*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20200925 (64-bit version)
  * Copyright (c) 2000 - 2020 Intel Corporation
  *
- * Disassembly of tests/data/acpi/aarch64/virt/PPTT, Thu Apr 24 11:02:39 2025
+ * Disassembly of /tmp/aml-E0RF52, Thu Apr 24 11:02:39 2025
  *
  * ACPI Data Table [PPTT]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
  */

 [000h 0000   4]                    Signature : "PPTT"    [Processor Properties Topology Table]
-[004h 0004   4]                 Table Length : 0000004C
+[004h 0004   4]                 Table Length : 00000060
 [008h 0008   1]                     Revision : 02
-[009h 0009   1]                     Checksum : A8
+[009h 0009   1]                     Checksum : 27
 [00Ah 0010   6]                       Oem ID : "BOCHS "
 [010h 0016   8]                 Oem Table ID : "BXPC    "
 [018h 0024   4]                 Oem Revision : 00000001
 [01Ch 0028   4]              Asl Compiler ID : "BXPC"
 [020h 0032   4]        Asl Compiler Revision : 00000001

 [024h 0036   1]                Subtable Type : 00 [Processor Hierarchy Node]
 [025h 0037   1]                       Length : 14
 [026h 0038   2]                     Reserved : 0000
-[028h 0040   4]        Flags (decoded below) : 00000001
+[028h 0040   4]        Flags (decoded below) : 00000011
                             Physical package : 1
                      ACPI Processor ID valid : 0
                        Processor is a thread : 0
                               Node is a leaf : 0
-                    Identical Implementation : 0
+                    Identical Implementation : 1
 [02Ch 0044   4]                       Parent : 00000000
 [030h 0048   4]            ACPI Processor ID : 00000000
 [034h 0052   4]      Private Resource Number : 00000000

 [038h 0056   1]                Subtable Type : 00 [Processor Hierarchy Node]
 [039h 0057   1]                       Length : 14
 [03Ah 0058   2]                     Reserved : 0000
-[03Ch 0060   4]        Flags (decoded below) : 0000000A
+[03Ch 0060   4]        Flags (decoded below) : 00000011
+                            Physical package : 1
+                     ACPI Processor ID valid : 0
+                       Processor is a thread : 0
+                              Node is a leaf : 0
+                    Identical Implementation : 1
+[040h 0064   4]                       Parent : 00000024
+[044h 0068   4]            ACPI Processor ID : 00000000
+[048h 0072   4]      Private Resource Number : 00000000
+
+[04Ch 0076   1]                Subtable Type : 00 [Processor Hierarchy Node]
+[04Dh 0077   1]                       Length : 14
+[04Eh 0078   2]                     Reserved : 0000
+[050h 0080   4]        Flags (decoded below) : 0000000A
                             Physical package : 0
                      ACPI Processor ID valid : 1
                        Processor is a thread : 0
                               Node is a leaf : 1
                     Identical Implementation : 0
-[040h 0064   4]                       Parent : 00000024
-[044h 0068   4]            ACPI Processor ID : 00000000
-[048h 0072   4]      Private Resource Number : 00000000
+[054h 0084   4]                       Parent : 00000038
+[058h 0088   4]            ACPI Processor ID : 00000000
+[05Ch 0092   4]      Private Resource Number : 00000000

-Raw Table Data: Length 76 (0x4C)
+Raw Table Data: Length 96 (0x60)

-    0000: 50 50 54 54 4C 00 00 00 02 A8 42 4F 43 48 53 20  // PPTTL.....BOCHS
+    0000: 50 50 54 54 60 00 00 00 02 27 42 4F 43 48 53 20  // PPTT`....'BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
-    0020: 01 00 00 00 00 14 00 00 01 00 00 00 00 00 00 00  // ................
-    0030: 00 00 00 00 00 00 00 00 00 14 00 00 0A 00 00 00  // ................
-    0040: 24 00 00 00 00 00 00 00 00 00 00 00              // $...........
+    0020: 01 00 00 00 00 14 00 00 11 00 00 00 00 00 00 00  // ................
+    0030: 00 00 00 00 00 00 00 00 00 14 00 00 11 00 00 00  // ................
+    0040: 24 00 00 00 00 00 00 00 00 00 00 00 00 14 00 00  // $...............
+    0050: 0A 00 00 00 38 00 00 00 00 00 00 00 00 00 00 00  // ....8...........

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Message-Id: <20250714173146.511-5-alireza.sanaee@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h    |   5 -----
 tests/data/acpi/aarch64/virt/PPTT              | Bin 76 -> 96 bytes
 tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt | Bin 156 -> 176 bytes
 tests/data/acpi/aarch64/virt/PPTT.topology     | Bin 336 -> 356 bytes
 tests/data/acpi/loongarch64/virt/PPTT          | Bin 76 -> 96 bytes
 tests/data/acpi/loongarch64/virt/PPTT.topology | Bin 176 -> 196 bytes
 6 files changed, 5 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 5c3ff47748..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,6 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/PPTT",
-"tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt",
-"tests/data/acpi/aarch64/virt/PPTT.topology",
-"tests/data/acpi/loongarch64/virt/PPTT",
-"tests/data/acpi/loongarch64/virt/PPTT.topology",
diff --git a/tests/data/acpi/aarch64/virt/PPTT b/tests/data/acpi/aarch64/virt/PPTT
index 7a1258ecf123555b24462c98ccbb76b4ac1d0c2b..15598a9b8a3cc0cdd50bc1f77c73ae0ba728a272 100644
GIT binary patch
literal 96
zcmWFt2nk7GU|?WUck*}k2v%^42yj+VP*7lGU|;~TK{SI11A`!lMg~wZ6*Ms}1_lNT
GBryOJwg&+K

delta 38
lcmYfB;R*-{3GrcIU|?D?kxP!1k%57MVWOijj|zwZ1ptDp1jzsZ

diff --git a/tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt b/tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt
index 4eef303a5b6168c6bc3795c2e2c53f65b4c4cfd4..7b613ddaf4b8cfa13821aa2e835d290077221897 100644
GIT binary patch
literal 176
zcmWFt2npH1z`(%7>*Vk35v<@85#X$#prF9Wz`y`vgJ=d31_nV8jSQe-DrjO{3=9kw
cIK;qafdG<TWHFH55|CS9`b8MvV$4u60Ia$R0RR91

literal 156
zcmWFt2nm_Pz`(%t&&l7}BUr&HBEVTeK|z6$fq?<U2GI;63=Ciz8Hg}2a4|42sNfKT
Yt4Gp{EC$k>0J0aRA8H;*j2S8h0Ax)G0RR91

diff --git a/tests/data/acpi/aarch64/virt/PPTT.topology b/tests/data/acpi/aarch64/virt/PPTT.topology
index 3fbcae5ff08aaf16fedf4da45e941661d79c1174..6b864f035c9f48845e9a3beb482c5171074864a5 100644
GIT binary patch
literal 356
zcmZ|Jy$!-Z42I$N5`MY}q#M8m1tU-=4FwV>k%E$fooE=0As7OE(HU70xbf+cKc7n(
z$9sb2(VvIo#rkU*%*+y?w>lZN>anWrX0`ziKkPKK4!HfX=}%Q=+NW$ZWuHLf`OMea
hV17%?%3eOBs@XTNa1XW&=GnMUx9k(F!kpW>+6M@C5CH%H

literal 336
zcmZ{eu?>ST5JjI!ARUzlxPl>4Lqib>OQFax86bl(1mmC&2Av}Kh0lKS`?{3IF$E~T
z?a=jaYd@(oGYf$3nnYNqPuw2O348vr8hBl>qc``-^-S&$D0V+`u$yCwcJZz<t!GYl
XXW)LqO2-trzE8Wv0G0c<vqxqN0DKMs

diff --git a/tests/data/acpi/loongarch64/virt/PPTT b/tests/data/acpi/loongarch64/virt/PPTT
index 7a1258ecf123555b24462c98ccbb76b4ac1d0c2b..15598a9b8a3cc0cdd50bc1f77c73ae0ba728a272 100644
GIT binary patch
literal 96
zcmWFt2nk7GU|?WUck*}k2v%^42yj+VP*7lGU|;~TK{SI11A`!lMg~wZ6*Ms}1_lNT
GBryOJwg&+K

delta 38
lcmYfB;R*-{3GrcIU|?D?kxP!1k%57MVWOijj|zwZ1ptDp1jzsZ

diff --git a/tests/data/acpi/loongarch64/virt/PPTT.topology b/tests/data/acpi/loongarch64/virt/PPTT.topology
index d91e55b2399d9949dbb8e4c8cf634af1a0e56df4..7fc92984694d2cac7bf867c7fea696e135f8c758 100644
GIT binary patch
literal 196
zcmWFt2njjDz`($y<>c?|5v<@85#X$#prF9Wz`y`vgJ=d31_nV8jSQe-DrjN?3=9kw
lXkvT}3=BRv#K7i*fCvLzFR~a&ZwJVIF#RG7a4}}67yz3v3IPBB

literal 176
zcmWFt2npH1z`($y@8s|75v<@85#X$#prF9Wz`y`vgJ=d31_m&V3`8It6*MtE1_lNT
b9Aa=Ykn|#pf%KMu+yc`t!T=XzhKd0IvU~{v

-- 
MST



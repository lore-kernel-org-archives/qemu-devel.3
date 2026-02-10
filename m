Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA548EA811B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpoAC-00022q-VG; Tue, 10 Feb 2026 08:52:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoA5-0001yo-8R
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:17 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoA1-0006Jh-S2
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:16 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4833115090dso8111455e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 05:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770731532; x=1771336332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zta9umikbAPUw+uUWP55d9xpJhXgxfyHHlklUmDXa7k=;
 b=fClKSFuaACpNYtQ6D/HmhHTtl9AB4rVEr83BZY+NkfdLoQtX8TtqdAoJQ8BSESU3zr
 rbuYYWc1BdUe0tgvMjXXbeoSC/3J5/VMbhSNLIdBS75ZNxt9s9KqRounFY9n0qPeqj68
 ms/XJ7Qp2hL+kyXlifPA6IayATTB0/s2QfVEXmQEZ7VT+oGSiehsBQOw/8M5lR8HsJrj
 4Od+27CfKWRFZCKi7mYhmuQwEIEYqmC5X0hxsvTwYQ7dMprsKWsDzE/Kxi7+PSNiRE2G
 jxyUMwzICVdSO+PbJuy5Qc7d9VILPlH7nO7M1dc5O2HmtZ5hMYTxCL4d1lR88bbeHczS
 XYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770731532; x=1771336332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Zta9umikbAPUw+uUWP55d9xpJhXgxfyHHlklUmDXa7k=;
 b=X95FogecbPRFuK2Jl/FJGeKhaOhW2TAg3VEhN0rRoCQPMiIPbuzVcY67jkjRSTLgX0
 mI7x3t0+RS+avAdJaVP51htTNyUx+UfjX+XFC3GeVeVnjdy6A5PBCXrtXZfyP42Shdv7
 +gMTgbPfUnoOImyKIjQEF92OuqrC6MMzRC17rnZdhqvF9ptLI6oierwmAsbVj8YS/I3L
 8UbmJZAUSbVUR0dhRfbqAEikEkKnFZ+auBB95aS0/jBCOsrY7X5loKhR6T88WfZkNvR+
 RcZ9Ui5i+t4xhYbwSf6dWD0MhQH20fCk+YvtpTtWzVRn8MM7f3gnyetp6APmpyWMtnqL
 9D1Q==
X-Gm-Message-State: AOJu0YxFVHeP8gBZ5TRyI9cQI3Ck/XIjQlnRxhCE08JZ/SsvaY06BsEl
 /kRZNk1xip9DR9ARZ9CtBJ1x7omXX5sYLYdAhjMuemhYb0XGUEdwJgw45fh5lbvs9+zhNq1qmrB
 +Jyoa
X-Gm-Gg: AZuq6aI5kNYdLWJcIeWXvjqLPtFwfI/+Z/GCFMpFNT5p663Zm5i9g4pPhSUnbKx7x1Y
 syVgVU7X4f5tX0JmBC05G9d97kRja78Rx0pOzEaDu+Pkdpb/R7q+wz5S0MDjz0PJEHJi/m0xUvg
 B4l4uL/UWalI9soBTxFW8SKQJGBV1pcAw6We1moMLqh1ZszEabNidX6qTUPmlqD82Xgq3I+2hKO
 gVLXviPVpHv2Iiaw15yNtjZFuRgNBth1db9MwiLKbW3KvSO7DWaKY4J+Gr0m+eIGRpyZX02jJrx
 PKhP0Dk4ku3B3MachUKOQYcLOQFz9Xhe279gv8o5WoeR4uioRUzKEbz09naWDtJFyYP0t1flbGj
 RHuU+4IbJx882Wr4SBInUh4p3EWalT74O61t/hNdkRjPSEnTqpnEeSkQv60wBasr/KYf1FudDYr
 DCBuE0VYWQGbO+57ZuNrEGUux1UgM6ARslhXHmJ9V1HYc5HmdvJ7Q/aSj8qyUkk32DZIfraMjQF
 EawRKg4wc8H0LE0OSocjgN+5P9QpzA=
X-Received: by 2002:a05:600c:674f:b0:471:13dd:bae7 with SMTP id
 5b1f17b1804b1-4832022aee5mr194308745e9.30.1770731532085; 
 Tue, 10 Feb 2026 05:52:12 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d77f9sm64344875e9.3.2026.02.10.05.52.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 05:52:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/26] tests: data: update AArch64 ACPI tables
Date: Tue, 10 Feb 2026 13:51:45 +0000
Message-ID: <20260210135206.229528-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135206.229528-1-peter.maydell@linaro.org>
References: <20260210135206.229528-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

After the previous commit introducing GICv3 + GICv2m configurations,
update the AArch64 ACPI tables for the GICv2 case.

Changes to the ACPI tables:

tests/data/acpi/aarch64/virt/IORT.dsl:

@@ -11,68 +11,49 @@
  */

 [000h 0000 004h]                   Signature : "IORT"    [IO Remapping Table]
-[004h 0004 004h]                Table Length : 00000080
+[004h 0004 004h]                Table Length : 00000054
 [008h 0008 001h]                    Revision : 05
-[009h 0009 001h]                    Checksum : B1
+[009h 0009 001h]                    Checksum : 3C
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001

-[024h 0036 004h]                  Node Count : 00000002
+[024h 0036 004h]                  Node Count : 00000001
 [028h 0040 004h]                 Node Offset : 00000030
 [02Ch 0044 004h]                    Reserved : 00000000

-[030h 0048 001h]                        Type : 00
-[031h 0049 002h]                      Length : 0018
-[033h 0051 001h]                    Revision : 01
+[030h 0048 001h]                        Type : 02
+[031h 0049 002h]                      Length : 0024
+[033h 0051 001h]                    Revision : 03
 [034h 0052 004h]                  Identifier : 00000000
 [038h 0056 004h]               Mapping Count : 00000000
-[03Ch 0060 004h]              Mapping Offset : 00000000
+[03Ch 0060 004h]              Mapping Offset : 00000024

-[040h 0064 004h]                    ItsCount : 00000001
-[044h 0068 004h]                 Identifiers : 00000000
-
-[048h 0072 001h]                        Type : 02
-[049h 0073 002h]                      Length : 0038
-[04Bh 0075 001h]                    Revision : 03
-[04Ch 0076 004h]                  Identifier : 00000001
-[050h 0080 004h]               Mapping Count : 00000001
-[054h 0084 004h]              Mapping Offset : 00000024
-
-[058h 0088 008h]           Memory Properties : [IORT Memory Access Properties]
-[058h 0088 004h]             Cache Coherency : 00000001
-[05Ch 0092 001h]       Hints (decoded below) : 00
+[040h 0064 008h]           Memory Properties : [IORT Memory Access Properties]
+[040h 0064 004h]             Cache Coherency : 00000001
+[044h 0068 001h]       Hints (decoded below) : 00
                                    Transient : 0
                               Write Allocate : 0
                                Read Allocate : 0
                                     Override : 0
-[05Dh 0093 002h]                    Reserved : 0000
-[05Fh 0095 001h] Memory Flags (decoded below) : 03
+[045h 0069 002h]                    Reserved : 0000
+[047h 0071 001h] Memory Flags (decoded below) : 03
                                    Coherency : 1
                             Device Attribute : 1
                Ensured Coherency of Accesses : 0
-[060h 0096 004h]               ATS Attribute : 00000000
-[064h 0100 004h]          PCI Segment Number : 00000000
-[068h 0104 001h]           Memory Size Limit : 40
-[069h 0105 002h]          PASID Capabilities : 0000
-[06Bh 0107 001h]                    Reserved : 00
+[048h 0072 004h]               ATS Attribute : 00000000
+[04Ch 0076 004h]          PCI Segment Number : 00000000
+[050h 0080 001h]           Memory Size Limit : 40
+[051h 0081 002h]          PASID Capabilities : 0000
+[053h 0083 001h]                    Reserved : 00

-[06Ch 0108 004h]                  Input base : 00000000
-[070h 0112 004h]                    ID Count : 0000FFFF
-[074h 0116 004h]                 Output Base : 00000000
-[078h 0120 004h]            Output Reference : 00000030
-[07Ch 0124 004h]       Flags (decoded below) : 00000000
-                              Single Mapping : 0
+Raw Table Data: Length 84 (0x54)

-Raw Table Data: Length 128 (0x80)
-
-    0000: 49 4F 52 54 80 00 00 00 05 B1 42 4F 43 48 53 20  // IORT......BOCHS
+    0000: 49 4F 52 54 54 00 00 00 05 3C 42 4F 43 48 53 20  // IORTT....<BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
-    0020: 01 00 00 00 02 00 00 00 30 00 00 00 00 00 00 00  // ........0.......
-    0030: 00 18 00 01 00 00 00 00 00 00 00 00 00 00 00 00  // ................
-    0040: 01 00 00 00 00 00 00 00 02 38 00 03 01 00 00 00  // .........8......
-    0050: 01 00 00 00 24 00 00 00 01 00 00 00 00 00 00 03  // ....$...........
-    0060: 00 00 00 00 00 00 00 00 40 00 00 00 00 00 00 00  // ........@.......
-    0070: FF FF 00 00 00 00 00 00 30 00 00 00 00 00 00 00  // ........0.......
+    0020: 01 00 00 00 01 00 00 00 30 00 00 00 00 00 00 00  // ........0.......
+    0030: 02 24 00 03 00 00 00 00 00 00 00 00 24 00 00 00  // .$..........$...
+    0040: 01 00 00 00 00 00 00 03 00 00 00 00 00 00 00 00  // ................
+    0050: 40 00 00 00                                      // @...

tests/data/acpi/aarch64/virt/IORT.smmuv3-dev.dsl:

@@ -11,164 +11,120 @@
  */

 [000h 0000 004h]                   Signature : "IORT"    [IO Remapping Table]
-[004h 0004 004h]                Table Length : 0000016C
+[004h 0004 004h]                Table Length : 00000104
 [008h 0008 001h]                    Revision : 05
-[009h 0009 001h]                    Checksum : C8
+[009h 0009 001h]                    Checksum : 49
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001

-[024h 0036 004h]                  Node Count : 00000004
+[024h 0036 004h]                  Node Count : 00000003
 [028h 0040 004h]                 Node Offset : 00000030
 [02Ch 0044 004h]                    Reserved : 00000000

-[030h 0048 001h]                        Type : 00
-[031h 0049 002h]                      Length : 0018
-[033h 0051 001h]                    Revision : 01
+[030h 0048 001h]                        Type : 04
+[031h 0049 002h]                      Length : 0044
+[033h 0051 001h]                    Revision : 04
 [034h 0052 004h]                  Identifier : 00000000
 [038h 0056 004h]               Mapping Count : 00000000
 [03Ch 0060 004h]              Mapping Offset : 00000000

-[040h 0064 004h]                    ItsCount : 00000001
-[044h 0068 004h]                 Identifiers : 00000000
-
-[048h 0072 001h]                        Type : 04
-[049h 0073 002h]                      Length : 0058
-[04Bh 0075 001h]                    Revision : 04
-[04Ch 0076 004h]                  Identifier : 00000001
-[050h 0080 004h]               Mapping Count : 00000001
-[054h 0084 004h]              Mapping Offset : 00000044
-
-[058h 0088 008h]                Base Address : 000000000C000000
-[060h 0096 004h]       Flags (decoded below) : 00000001
+[040h 0064 008h]                Base Address : 000000000C000000
+[048h 0072 004h]       Flags (decoded below) : 00000001
                              COHACC Override : 1
                                HTTU Override : 0
                       Proximity Domain Valid : 0
                               DeviceID Valid : 0
-[064h 0100 004h]                    Reserved : 00000000
-[068h 0104 008h]               VATOS Address : 0000000000000000
-[070h 0112 004h]                       Model : 00000000
-[074h 0116 004h]                  Event GSIV : 00000090
-[078h 0120 004h]                    PRI GSIV : 00000091
-[07Ch 0124 004h]                   GERR GSIV : 00000093
-[080h 0128 004h]                   Sync GSIV : 00000092
-[084h 0132 004h]            Proximity Domain : 00000000
-[088h 0136 004h]     Device ID Mapping Index : 00000000
+[04Ch 0076 004h]                    Reserved : 00000000
+[050h 0080 008h]               VATOS Address : 0000000000000000
+[058h 0088 004h]                       Model : 00000000
+[05Ch 0092 004h]                  Event GSIV : 00000090
+[060h 0096 004h]                    PRI GSIV : 00000091
+[064h 0100 004h]                   GERR GSIV : 00000093
+[068h 0104 004h]                   Sync GSIV : 00000092
+[06Ch 0108 004h]            Proximity Domain : 00000000
+[070h 0112 004h]     Device ID Mapping Index : 00000000

-[08Ch 0140 004h]                  Input base : 00000000
-[090h 0144 004h]                    ID Count : 0000FFFF
-[094h 0148 004h]                 Output Base : 00000000
-[098h 0152 004h]            Output Reference : 00000030
-[09Ch 0156 004h]       Flags (decoded below) : 00000000
-                              Single Mapping : 0
+[074h 0116 001h]                        Type : 04
+[075h 0117 002h]                      Length : 0044
+[077h 0119 001h]                    Revision : 04
+[078h 0120 004h]                  Identifier : 00000001
+[07Ch 0124 004h]               Mapping Count : 00000000
+[080h 0128 004h]              Mapping Offset : 00000000

-[0A0h 0160 001h]                        Type : 04
-[0A1h 0161 002h]                      Length : 0058
-[0A3h 0163 001h]                    Revision : 04
-[0A4h 0164 004h]                  Identifier : 00000002
-[0A8h 0168 004h]               Mapping Count : 00000001
-[0ACh 0172 004h]              Mapping Offset : 00000044
-
-[0B0h 0176 008h]                Base Address : 000000000C020000
-[0B8h 0184 004h]       Flags (decoded below) : 00000001
+[084h 0132 008h]                Base Address : 000000000C020000
+[08Ch 0140 004h]       Flags (decoded below) : 00000001
                              COHACC Override : 1
                                HTTU Override : 0
                       Proximity Domain Valid : 0
                               DeviceID Valid : 0
-[0BCh 0188 004h]                    Reserved : 00000000
-[0C0h 0192 008h]               VATOS Address : 0000000000000000
-[0C8h 0200 004h]                       Model : 00000000
-[0CCh 0204 004h]                  Event GSIV : 00000094
-[0D0h 0208 004h]                    PRI GSIV : 00000095
-[0D4h 0212 004h]                   GERR GSIV : 00000097
-[0D8h 0216 004h]                   Sync GSIV : 00000096
-[0DCh 0220 004h]            Proximity Domain : 00000000
-[0E0h 0224 004h]     Device ID Mapping Index : 00000000
+[090h 0144 004h]                    Reserved : 00000000
+[094h 0148 008h]               VATOS Address : 0000000000000000
+[09Ch 0156 004h]                       Model : 00000000
+[0A0h 0160 004h]                  Event GSIV : 00000094
+[0A4h 0164 004h]                    PRI GSIV : 00000095
+[0A8h 0168 004h]                   GERR GSIV : 00000097
+[0ACh 0172 004h]                   Sync GSIV : 00000096
+[0B0h 0176 004h]            Proximity Domain : 00000000
+[0B4h 0180 004h]     Device ID Mapping Index : 00000000

-[0E4h 0228 004h]                  Input base : 00000000
-[0E8h 0232 004h]                    ID Count : 0000FFFF
-[0ECh 0236 004h]                 Output Base : 00000000
-[0F0h 0240 004h]            Output Reference : 00000030
-[0F4h 0244 004h]       Flags (decoded below) : 00000000
-                              Single Mapping : 0
+[0B8h 0184 001h]                        Type : 02
+[0B9h 0185 002h]                      Length : 004C
+[0BBh 0187 001h]                    Revision : 03
+[0BCh 0188 004h]                  Identifier : 00000002
+[0C0h 0192 004h]               Mapping Count : 00000002
+[0C4h 0196 004h]              Mapping Offset : 00000024

-[0F8h 0248 001h]                        Type : 02
-[0F9h 0249 002h]                      Length : 0074
-[0FBh 0251 001h]                    Revision : 03
-[0FCh 0252 004h]                  Identifier : 00000003
-[100h 0256 004h]               Mapping Count : 00000004
-[104h 0260 004h]              Mapping Offset : 00000024
-
-[108h 0264 008h]           Memory Properties : [IORT Memory Access Properties]
-[108h 0264 004h]             Cache Coherency : 00000001
-[10Ch 0268 001h]       Hints (decoded below) : 00
+[0C8h 0200 008h]           Memory Properties : [IORT Memory Access Properties]
+[0C8h 0200 004h]             Cache Coherency : 00000001
+[0CCh 0204 001h]       Hints (decoded below) : 00
                                    Transient : 0
                               Write Allocate : 0
                                Read Allocate : 0
                                     Override : 0
-[10Dh 0269 002h]                    Reserved : 0000
-[10Fh 0271 001h] Memory Flags (decoded below) : 03
+[0CDh 0205 002h]                    Reserved : 0000
+[0CFh 0207 001h] Memory Flags (decoded below) : 03
                                    Coherency : 1
                             Device Attribute : 1
                Ensured Coherency of Accesses : 0
-[110h 0272 004h]               ATS Attribute : 00000000
-[114h 0276 004h]          PCI Segment Number : 00000000
-[118h 0280 001h]           Memory Size Limit : 40
-[119h 0281 002h]          PASID Capabilities : 0000
-[11Bh 0283 001h]                    Reserved : 00
+[0D0h 0208 004h]               ATS Attribute : 00000000
+[0D4h 0212 004h]          PCI Segment Number : 00000000
+[0D8h 0216 001h]           Memory Size Limit : 40
+[0D9h 0217 002h]          PASID Capabilities : 0000
+[0DBh 0219 001h]                    Reserved : 00

-[11Ch 0284 004h]                  Input base : 00000000
-[120h 0288 004h]                    ID Count : 000001FF
-[124h 0292 004h]                 Output Base : 00000000
-[128h 0296 004h]            Output Reference : 00000048
-[12Ch 0300 004h]       Flags (decoded below) : 00000000
+[0DCh 0220 004h]                  Input base : 00000000
+[0E0h 0224 004h]                    ID Count : 000001FF
+[0E4h 0228 004h]                 Output Base : 00000000
+[0E8h 0232 004h]            Output Reference : 00000030
+[0ECh 0236 004h]       Flags (decoded below) : 00000000
                               Single Mapping : 0

-[130h 0304 004h]                  Input base : 00001000
-[134h 0308 004h]                    ID Count : 000000FF
-[138h 0312 004h]                 Output Base : 00001000
-[13Ch 0316 004h]            Output Reference : 000000A0
-[140h 0320 004h]       Flags (decoded below) : 00000000
+[0F0h 0240 004h]                  Input base : 00001000
+[0F4h 0244 004h]                    ID Count : 000000FF
+[0F8h 0248 004h]                 Output Base : 00001000
+[0FCh 0252 004h]            Output Reference : 00000074
+[100h 0256 004h]       Flags (decoded below) : 00000000
                               Single Mapping : 0

-[144h 0324 004h]                  Input base : 00000200
-[148h 0328 004h]                    ID Count : 00000DFF
-[14Ch 0332 004h]                 Output Base : 00000200
-[150h 0336 004h]            Output Reference : 00000030
-[154h 0340 004h]       Flags (decoded below) : 00000000
-                              Single Mapping : 0
+Raw Table Data: Length 260 (0x104)

-[158h 0344 004h]                  Input base : 00001100
-[15Ch 0348 004h]                    ID Count : 0000EEFF
-[160h 0352 004h]                 Output Base : 00001100
-[164h 0356 004h]            Output Reference : 00000030
-[168h 0360 004h]       Flags (decoded below) : 00000000
-                              Single Mapping : 0
-
-Raw Table Data: Length 364 (0x16C)
-
-    0000: 49 4F 52 54 6C 01 00 00 05 C8 42 4F 43 48 53 20  // IORTl.....BOCHS
+    0000: 49 4F 52 54 04 01 00 00 05 49 42 4F 43 48 53 20  // IORT.....IBOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
-    0020: 01 00 00 00 04 00 00 00 30 00 00 00 00 00 00 00  // ........0.......
-    0030: 00 18 00 01 00 00 00 00 00 00 00 00 00 00 00 00  // ................
-    0040: 01 00 00 00 00 00 00 00 04 58 00 04 01 00 00 00  // .........X......
-    0050: 01 00 00 00 44 00 00 00 00 00 00 0C 00 00 00 00  // ....D...........
-    0060: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
-    0070: 00 00 00 00 90 00 00 00 91 00 00 00 93 00 00 00  // ................
-    0080: 92 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
-    0090: FF FF 00 00 00 00 00 00 30 00 00 00 00 00 00 00  // ........0.......
-    00A0: 04 58 00 04 02 00 00 00 01 00 00 00 44 00 00 00  // .X..........D...
-    00B0: 00 00 02 0C 00 00 00 00 01 00 00 00 00 00 00 00  // ................
-    00C0: 00 00 00 00 00 00 00 00 00 00 00 00 94 00 00 00  // ................
-    00D0: 95 00 00 00 97 00 00 00 96 00 00 00 00 00 00 00  // ................
-    00E0: 00 00 00 00 00 00 00 00 FF FF 00 00 00 00 00 00  // ................
-    00F0: 30 00 00 00 00 00 00 00 02 74 00 03 03 00 00 00  // 0........t......
-    0100: 04 00 00 00 24 00 00 00 01 00 00 00 00 00 00 03  // ....$...........
-    0110: 00 00 00 00 00 00 00 00 40 00 00 00 00 00 00 00  // ........@.......
-    0120: FF 01 00 00 00 00 00 00 48 00 00 00 00 00 00 00  // ........H.......
-    0130: 00 10 00 00 FF 00 00 00 00 10 00 00 A0 00 00 00  // ................
-    0140: 00 00 00 00 00 02 00 00 FF 0D 00 00 00 02 00 00  // ................
-    0150: 30 00 00 00 00 00 00 00 00 11 00 00 FF EE 00 00  // 0...............
-    0160: 00 11 00 00 30 00 00 00 00 00 00 00              // ....0.......
+    0020: 01 00 00 00 03 00 00 00 30 00 00 00 00 00 00 00  // ........0.......
+    0030: 04 44 00 04 00 00 00 00 00 00 00 00 00 00 00 00  // .D..............
+    0040: 00 00 00 0C 00 00 00 00 01 00 00 00 00 00 00 00  // ................
+    0050: 00 00 00 00 00 00 00 00 00 00 00 00 90 00 00 00  // ................
+    0060: 91 00 00 00 93 00 00 00 92 00 00 00 00 00 00 00  // ................
+    0070: 00 00 00 00 04 44 00 04 01 00 00 00 00 00 00 00  // .....D..........
+    0080: 00 00 00 00 00 00 02 0C 00 00 00 00 01 00 00 00  // ................
+    0090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
+    00A0: 94 00 00 00 95 00 00 00 97 00 00 00 96 00 00 00  // ................
+    00B0: 00 00 00 00 00 00 00 00 02 4C 00 03 02 00 00 00  // .........L......
+    00C0: 02 00 00 00 24 00 00 00 01 00 00 00 00 00 00 03  // ....$...........
+    00D0: 00 00 00 00 00 00 00 00 40 00 00 00 00 00 00 00  // ........@.......
+    00E0: FF 01 00 00 00 00 00 00 30 00 00 00 00 00 00 00  // ........0.......
+    00F0: 00 10 00 00 FF 00 00 00 00 10 00 00 74 00 00 00  // ............t...
+    0100: 00 00 00 00                                      // ....

tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy.dsl:

@@ -11,129 +11,92 @@
  */

 [000h 0000 004h]                   Signature : "IORT"    [IO Remapping Table]
-[004h 0004 004h]                Table Length : 00000114
+[004h 0004 004h]                Table Length : 000000C0
 [008h 0008 001h]                    Revision : 05
-[009h 0009 001h]                    Checksum : 4A
+[009h 0009 001h]                    Checksum : 1C
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001

-[024h 0036 004h]                  Node Count : 00000003
+[024h 0036 004h]                  Node Count : 00000002
 [028h 0040 004h]                 Node Offset : 00000030
 [02Ch 0044 004h]                    Reserved : 00000000

-[030h 0048 001h]                        Type : 00
-[031h 0049 002h]                      Length : 0018
-[033h 0051 001h]                    Revision : 01
+[030h 0048 001h]                        Type : 04
+[031h 0049 002h]                      Length : 0044
+[033h 0051 001h]                    Revision : 04
 [034h 0052 004h]                  Identifier : 00000000
 [038h 0056 004h]               Mapping Count : 00000000
 [03Ch 0060 004h]              Mapping Offset : 00000000

-[040h 0064 004h]                    ItsCount : 00000001
-[044h 0068 004h]                 Identifiers : 00000000
-
-[048h 0072 001h]                        Type : 04
-[049h 0073 002h]                      Length : 0058
-[04Bh 0075 001h]                    Revision : 04
-[04Ch 0076 004h]                  Identifier : 00000001
-[050h 0080 004h]               Mapping Count : 00000001
-[054h 0084 004h]              Mapping Offset : 00000044
-
-[058h 0088 008h]                Base Address : 0000000009050000
-[060h 0096 004h]       Flags (decoded below) : 00000001
+[040h 0064 008h]                Base Address : 0000000009050000
+[048h 0072 004h]       Flags (decoded below) : 00000001
                              COHACC Override : 1
                                HTTU Override : 0
                       Proximity Domain Valid : 0
                               DeviceID Valid : 0
-[064h 0100 004h]                    Reserved : 00000000
-[068h 0104 008h]               VATOS Address : 0000000000000000
-[070h 0112 004h]                       Model : 00000000
-[074h 0116 004h]                  Event GSIV : 0000006A
-[078h 0120 004h]                    PRI GSIV : 0000006B
-[07Ch 0124 004h]                   GERR GSIV : 0000006D
-[080h 0128 004h]                   Sync GSIV : 0000006C
-[084h 0132 004h]            Proximity Domain : 00000000
-[088h 0136 004h]     Device ID Mapping Index : 00000000
+[04Ch 0076 004h]                    Reserved : 00000000
+[050h 0080 008h]               VATOS Address : 0000000000000000
+[058h 0088 004h]                       Model : 00000000
+[05Ch 0092 004h]                  Event GSIV : 0000006A
+[060h 0096 004h]                    PRI GSIV : 0000006B
+[064h 0100 004h]                   GERR GSIV : 0000006D
+[068h 0104 004h]                   Sync GSIV : 0000006C
+[06Ch 0108 004h]            Proximity Domain : 00000000
+[070h 0112 004h]     Device ID Mapping Index : 00000000

-[08Ch 0140 004h]                  Input base : 00000000
-[090h 0144 004h]                    ID Count : 0000FFFF
-[094h 0148 004h]                 Output Base : 00000000
-[098h 0152 004h]            Output Reference : 00000030
-[09Ch 0156 004h]       Flags (decoded below) : 00000000
-                              Single Mapping : 0
+[074h 0116 001h]                        Type : 02
+[075h 0117 002h]                      Length : 004C
+[077h 0119 001h]                    Revision : 03
+[078h 0120 004h]                  Identifier : 00000001
+[07Ch 0124 004h]               Mapping Count : 00000002
+[080h 0128 004h]              Mapping Offset : 00000024

-[0A0h 0160 001h]                        Type : 02
-[0A1h 0161 002h]                      Length : 0074
-[0A3h 0163 001h]                    Revision : 03
-[0A4h 0164 004h]                  Identifier : 00000002
-[0A8h 0168 004h]               Mapping Count : 00000004
-[0ACh 0172 004h]              Mapping Offset : 00000024
-
-[0B0h 0176 008h]           Memory Properties : [IORT Memory Access Properties]
-[0B0h 0176 004h]             Cache Coherency : 00000001
-[0B4h 0180 001h]       Hints (decoded below) : 00
+[084h 0132 008h]           Memory Properties : [IORT Memory Access Properties]
+[084h 0132 004h]             Cache Coherency : 00000001
+[088h 0136 001h]       Hints (decoded below) : 00
                                    Transient : 0
                               Write Allocate : 0
                                Read Allocate : 0
                                     Override : 0
-[0B5h 0181 002h]                    Reserved : 0000
-[0B7h 0183 001h] Memory Flags (decoded below) : 03
+[089h 0137 002h]                    Reserved : 0000
+[08Bh 0139 001h] Memory Flags (decoded below) : 03
                                    Coherency : 1
                             Device Attribute : 1
                Ensured Coherency of Accesses : 0
-[0B8h 0184 004h]               ATS Attribute : 00000000
-[0BCh 0188 004h]          PCI Segment Number : 00000000
-[0C0h 0192 001h]           Memory Size Limit : 40
-[0C1h 0193 002h]          PASID Capabilities : 0000
-[0C3h 0195 001h]                    Reserved : 00
+[08Ch 0140 004h]               ATS Attribute : 00000000
+[090h 0144 004h]          PCI Segment Number : 00000000
+[094h 0148 001h]           Memory Size Limit : 40
+[095h 0149 002h]          PASID Capabilities : 0000
+[097h 0151 001h]                    Reserved : 00

-[0C4h 0196 004h]                  Input base : 00000000
-[0C8h 0200 004h]                    ID Count : 000001FF
-[0CCh 0204 004h]                 Output Base : 00000000
-[0D0h 0208 004h]            Output Reference : 00000048
-[0D4h 0212 004h]       Flags (decoded below) : 00000000
+[098h 0152 004h]                  Input base : 00000000
+[09Ch 0156 004h]                    ID Count : 000001FF
+[0A0h 0160 004h]                 Output Base : 00000000
+[0A4h 0164 004h]            Output Reference : 00000030
+[0A8h 0168 004h]       Flags (decoded below) : 00000000
                               Single Mapping : 0

-[0D8h 0216 004h]                  Input base : 00001000
-[0DCh 0220 004h]                    ID Count : 000000FF
-[0E0h 0224 004h]                 Output Base : 00001000
-[0E4h 0228 004h]            Output Reference : 00000048
-[0E8h 0232 004h]       Flags (decoded below) : 00000000
+[0ACh 0172 004h]                  Input base : 00001000
+[0B0h 0176 004h]                    ID Count : 000000FF
+[0B4h 0180 004h]                 Output Base : 00001000
+[0B8h 0184 004h]            Output Reference : 00000030
+[0BCh 0188 004h]       Flags (decoded below) : 00000000
                               Single Mapping : 0

-[0ECh 0236 004h]                  Input base : 00000200
-[0F0h 0240 004h]                    ID Count : 00000DFF
-[0F4h 0244 004h]                 Output Base : 00000200
-[0F8h 0248 004h]            Output Reference : 00000030
-[0FCh 0252 004h]       Flags (decoded below) : 00000000
-                              Single Mapping : 0
+Raw Table Data: Length 192 (0xC0)

-[100h 0256 004h]                  Input base : 00001100
-[104h 0260 004h]                    ID Count : 0000EEFF
-[108h 0264 004h]                 Output Base : 00001100
-[10Ch 0268 004h]            Output Reference : 00000030
-[110h 0272 004h]       Flags (decoded below) : 00000000
-                              Single Mapping : 0
-
-Raw Table Data: Length 276 (0x114)
-
-    0000: 49 4F 52 54 14 01 00 00 05 4A 42 4F 43 48 53 20  // IORT.....JBOCHS
+    0000: 49 4F 52 54 C0 00 00 00 05 1C 42 4F 43 48 53 20  // IORT......BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
-    0020: 01 00 00 00 03 00 00 00 30 00 00 00 00 00 00 00  // ........0.......
-    0030: 00 18 00 01 00 00 00 00 00 00 00 00 00 00 00 00  // ................
-    0040: 01 00 00 00 00 00 00 00 04 58 00 04 01 00 00 00  // .........X......
-    0050: 01 00 00 00 44 00 00 00 00 00 05 09 00 00 00 00  // ....D...........
-    0060: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
-    0070: 00 00 00 00 6A 00 00 00 6B 00 00 00 6D 00 00 00  // ....j...k...m...
-    0080: 6C 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // l...............
-    0090: FF FF 00 00 00 00 00 00 30 00 00 00 00 00 00 00  // ........0.......
-    00A0: 02 74 00 03 02 00 00 00 04 00 00 00 24 00 00 00  // .t..........$...
-    00B0: 01 00 00 00 00 00 00 03 00 00 00 00 00 00 00 00  // ................
-    00C0: 40 00 00 00 00 00 00 00 FF 01 00 00 00 00 00 00  // @...............
-    00D0: 48 00 00 00 00 00 00 00 00 10 00 00 FF 00 00 00  // H...............
-    00E0: 00 10 00 00 48 00 00 00 00 00 00 00 00 02 00 00  // ....H...........
-    00F0: FF 0D 00 00 00 02 00 00 30 00 00 00 00 00 00 00  // ........0.......
-    0100: 00 11 00 00 FF EE 00 00 00 11 00 00 30 00 00 00  // ............0...
-    0110: 00 00 00 00                                      // ....
+    0020: 01 00 00 00 02 00 00 00 30 00 00 00 00 00 00 00  // ........0.......
+    0030: 04 44 00 04 00 00 00 00 00 00 00 00 00 00 00 00  // .D..............
+    0040: 00 00 05 09 00 00 00 00 01 00 00 00 00 00 00 00  // ................
+    0050: 00 00 00 00 00 00 00 00 00 00 00 00 6A 00 00 00  // ............j...
+    0060: 6B 00 00 00 6D 00 00 00 6C 00 00 00 00 00 00 00  // k...m...l.......
+    0070: 00 00 00 00 02 4C 00 03 01 00 00 00 02 00 00 00  // .....L..........
+    0080: 24 00 00 00 01 00 00 00 00 00 00 03 00 00 00 00  // $...............
+    0090: 00 00 00 00 40 00 00 00 00 00 00 00 FF 01 00 00  // ....@...........
+    00A0: 00 00 00 00 30 00 00 00 00 00 00 00 00 10 00 00  // ....0...........
+    00B0: FF 00 00 00 00 10 00 00 30 00 00 00 00 00 00 00  // ........0.......

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/data/acpi/aarch64/virt/IORT               | Bin 128 -> 84 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev    | Bin 364 -> 260 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 276 -> 192 bytes
 tests/qtest/bios-tables-test-allowed-diff.h     |   3 ---
 4 files changed, 3 deletions(-)

diff --git a/tests/data/acpi/aarch64/virt/IORT b/tests/data/acpi/aarch64/virt/IORT
index a234aae4c2d04668d34313836d32ca20e19c0880..389f7a8d7d6fa47a3e2b61169604e580afe0e07b 100644
GIT binary patch
delta 42
ocmZo*4B_(h4+;rkU|?XinaCw2$_Qi`05J$KsW32u850Ag0fA}+)Bpeg

literal 128
zcmebD4+?2uU|?X~=;ZJ05v<@85#X!<1dKp25F11@0kHuPgMkDCNC*yK93~3}W)K^M
VRiHGGVg_O`aDdYP|3ers^8jQ#3IPBB

diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev b/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev
index 43a15fe2bf6cc650ffcbceff86919ea892928c0e..60cfed1361976ef26b280c11ba2e233f1cfd9383 100644
GIT binary patch
delta 107
zcmaFE)WXE&=^qrr!pOkD>N$~1N|Kp@fx!TXL4d`Dfd#?>k`qJCc|ig|l@Ks-tvM%?
f4+Aq3kjpfgkx^X+rjJ2@f#E+$5s)r{C}scviuDRY

literal 364
zcmZ{fJr2S!3`R{GHjrRr?7#sy0%{q`R0Iq?1S1FGpOxcq8m<tYlei!xEPeUx=g4uE
z&3e1*iS(akQ`MWIY*$r5fJAe3hh`|mL=<&lg=@uWu3E(IK+XCQ#q)q2(HWg0>Q3)t
zYVYaX4D^|s{hfQ^-WA=^4SmP&+-xs-&ISG36s0{Cg_tMzsZpm|Mj~NF{9%j*{g48;
Ly=4r0!Ej@55yu$;

diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy b/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy
index 5779d0e225a62b9cd70bebbacb7fd1e519c9e3c4..e2de4049f044bdfe5b3e656b94282ddf17832d9f 100644
GIT binary patch
delta 74
zcmbQjbbyh|(?2NW00RR9tIR|$DM=<E%K(T$fW?J@1;PT76GP28nS2<S8G&r3i7V9^
M4JKX`=71>$0E=4*h5!Hn

literal 276
zcmX|*F%E-33<NiD6e*BEqDV=R2jmF|QUDE6l7crRq2t|r;j%V1EA6d4KKX8#p6}`e
zWMeyZ{i|;0M^{rskXkaOZ?x(HL5I8vGlJCOyH2ySgwGY(@nL@Hh5i}yh;gs{y<|n2
l5C!^5+dlb{s<DhV=&eTq=ql#HxG3hl!1Vnn$u=^kvp;ma5&-}J

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 7acaf464dd..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,4 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/IORT",
-"tests/data/acpi/aarch64/virt/IORT.smmuv3-dev",
-"tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy",
-- 
2.43.0



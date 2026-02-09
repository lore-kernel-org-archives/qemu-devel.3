Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB10EF06EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 02:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpH2P-0006L7-56; Sun, 08 Feb 2026 21:30:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1vpH2M-0006JV-JN; Sun, 08 Feb 2026 21:30:07 -0500
Received: from mxct.zte.com.cn ([183.62.165.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1vpH2K-0008Ux-2V; Sun, 08 Feb 2026 21:30:06 -0500
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4f8TDk4l2Qz4xQX9;
 Mon, 09 Feb 2026 10:29:58 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
 by mse-fl1.zte.com.cn with SMTP id 6192Tpm8096848;
 Mon, 9 Feb 2026 10:29:51 +0800 (+08)
 (envelope-from liu.xuemei1@zte.com.cn)
Received: from mapi (xaxapp05[null]) by mapi (Zmail) with MAPI id mid32;
 Mon, 9 Feb 2026 10:29:52 +0800 (CST)
X-Zmail-TransId: 2afc698946a0ca6-97264
X-Mailer: Zmail v1.0
Message-ID: <20260209102952911oaGqnPAGoOC03UAW6X7jW@zte.com.cn>
In-Reply-To: <20260209102128930gN_7xu7bNIZcEawnIz3c7@zte.com.cn>
References: 20260209102128930gN_7xu7bNIZcEawnIz3c7@zte.com.cn
Date: Mon, 9 Feb 2026 10:29:52 +0800 (CST)
Mime-Version: 1.0
From: <liu.xuemei1@zte.com.cn>
To: <imammedo@redhat.com>, <alistair.francis@wdc.com>,
 <dbarboza@ventanamicro.com>, <sunilvl@ventanamicro.com>,
 <anisinha@redhat.com>
Cc: <pbonzini@redhat.com>, <palmer@dabbelt.com>, <liwei1518@gmail.com>,
 <zhiwei_liu@linux.alibaba.com>, <mst@redhat.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>, <liu.xuemei1@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHY2IDQvNF0gdGVzdHMvYWNwaTogQWRkIGFjcGkgZ2VkIGFuZCBwb3dlciBidXR0b24gaW4gRFNEVCBmb3IKCiBSSVNDLVY=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6192Tpm8096848
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: liu.xuemei1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Mon, 09 Feb 2026 10:29:58 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 698946A6.000/4f8TDk4l2Qz4xQX9
Received-SPF: pass client-ip=183.62.165.209;
 envelope-from=liu.xuemei1@zte.com.cn; helo=mxct.zte.com.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: Xuemei Liu <liu.xuemei1@zte.com.cn>

Update the reference DSDT blob to include acpi ged and power button
for RISC-V.

DSDT diff:
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x00000DD2 (3538)
+ *     Length           0x00000E61 (3681)
  *     Revision         0x02
- *     Checksum         0x25
+ *     Checksum         0xFC
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
@@ -1463,6 +1463,39 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
                 })
             }
         }
+
+        Device (\_SB.GED)
+        {
+            Name (_HID, "ACPI0013" /* Generic Event Device */)  // _HID: Hardware ID
+            Name (_UID, "GED")  // _UID: Unique ID
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000009,
+                }
+            })
+            OperationRegion (EREG, SystemMemory, 0x10101000, 0x04)
+            Field (EREG, DWordAcc, NoLock, WriteAsZeros)
+            {
+                ESEL,   32
+            }
+
+            Method (_EVT, 1, Serialized)  // _EVT: Event
+            {
+                Local0 = ESEL /* \_SB_.GED_.ESEL */
+                If (((Local0 & 0x02) == 0x02))
+                {
+                    Notify (PWRB, 0x80) // Status Change
+                }
+            }
+        }
+
+        Device (PWRB)
+        {
+            Name (_HID, "PNP0C0C" /* Power Button Device */)  // _HID: Hardware ID
+            Name (_UID, Zero)  // _UID: Unique ID
+        }
     }
 }

Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
---
 tests/data/acpi/riscv64/virt/DSDT           | Bin 3538 -> 3681 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)

diff --git a/tests/data/acpi/riscv64/virt/DSDT b/tests/data/acpi/riscv64/virt/DSDT
index 968e1a15c87bb5753b3a84ddb357e26312767220..90de02e889f0057cbaeadb932ae135e2ca8943c9 100644
GIT binary patch
delta 170
zcmca4{ZNL>CD<h-k&l6a>CZ$iX(pe?8`W3y)<-uvvB&7e2Rp^PySl`4#Cv$U@H#pN
zcp4ZO8Z&UjhXT1k2_VZkC|Hn>i@TGJftit$fq|itA-cge$km;Jhe1F<fQu!%ksHKy
zb`5s*Q4o=hcMS{SEC6v576?qPPT*o<;9_bE2oG}NYKU%<1TjFC3ApeE_yrg^8#qHO
GV*mhK>?tS!

delta 25
hcmaDTb4i-ZCD<k85-$S-lj=k+X(r!W8`W3y0sv*P2bll>

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 8e85fcdee9..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/riscv64/virt/DSDT",
-- 
2.27.0


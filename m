Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5376DCD4F35
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 01:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJMNz-0003qa-Ao; Wed, 12 Nov 2025 20:44:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1vJMNw-0003oN-2m; Wed, 12 Nov 2025 20:44:28 -0500
Received: from mxhk.zte.com.cn ([160.30.148.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1vJMNt-0004Ou-FD; Wed, 12 Nov 2025 20:44:27 -0500
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4d6NNh2Z5Pz7VGTQ;
 Thu, 13 Nov 2025 09:44:20 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
 by mse-fl2.zte.com.cn with SMTP id 5AD1iEEK042350;
 Thu, 13 Nov 2025 09:44:14 +0800 (+08)
 (envelope-from liu.xuemei1@zte.com.cn)
Received: from mapi (xaxapp02[null]) by mapi (Zmail) with MAPI id mid32;
 Thu, 13 Nov 2025 09:44:15 +0800 (CST)
Date: Thu, 13 Nov 2025 09:44:15 +0800 (CST)
X-Zmail-TransId: 2afa691537ef244-cc547
X-Mailer: Zmail v1.0
Message-ID: <20251113094415092DtFmNd_mcxtATexVfYz7E@zte.com.cn>
In-Reply-To: <2025111309270952219AjKpVEnbJXB7fcGTE4g@zte.com.cn>
References: 2025111309270952219AjKpVEnbJXB7fcGTE4g@zte.com.cn
Mime-Version: 1.0
From: <liu.xuemei1@zte.com.cn>
To: <imammedo@redhat.com>, <alistair.francis@wdc.com>,
 <dbarboza@ventanamicro.com>, <sunilvl@ventanamicro.com>,
 <anisinha@redhat.com>
Cc: <pbonzini@redhat.com>, <palmer@dabbelt.com>, <liwei1518@gmail.com>,
 <zhiwei_liu@linux.alibaba.com>, <mst@redhat.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>, <liu.xuemei1@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHY0IFJFU0VORCAyLzJdIHRlc3RzL2FjcGk6IEFkZCBhY3BpIGdlZCBhbmQgcG93ZXIgYnV0dG9uIGluCgogRFNEVCBmb3IgUklTQy1W?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 5AD1iEEK042350
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: liu.xuemei1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Thu, 13 Nov 2025 09:44:20 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 691537F4.000/4d6NNh2Z5Pz7VGTQ
Received-SPF: pass client-ip=160.30.148.35;
 envelope-from=liu.xuemei1@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: Xuemei Liu <liu.xuemei1@zte.com.cn>

Update the reference DSDT blob to include acpi ged and power button
for RISC-V.

DSDT diff:
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


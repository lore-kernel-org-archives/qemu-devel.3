Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C328CCD187
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 11:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6p6w-00033e-Ei; Thu, 09 Oct 2025 07:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1v6p6u-000335-Eu; Thu, 09 Oct 2025 07:47:04 -0400
Received: from mxct.zte.com.cn ([183.62.165.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1v6p6k-0005qd-KW; Thu, 09 Oct 2025 07:47:04 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4cj7Pr4F28z4xPSN;
 Thu, 09 Oct 2025 19:46:40 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
 by mse-fl2.zte.com.cn with SMTP id 599BkasB001038;
 Thu, 9 Oct 2025 19:46:36 +0800 (+08)
 (envelope-from liu.xuemei1@zte.com.cn)
Received: from mapi (xaxapp02[null]) by mapi (Zmail) with MAPI id mid32;
 Thu, 9 Oct 2025 19:46:38 +0800 (CST)
Date: Thu, 9 Oct 2025 19:46:38 +0800 (CST)
X-Zmail-TransId: 2afa68e7a09efe5-4eda8
X-Mailer: Zmail v1.0
Message-ID: <20251009194638848-j-_SL5_11Zm6qokf3zpU@zte.com.cn>
In-Reply-To: <202510091940382809HwqVAalRODBWrvsUvqF8@zte.com.cn>
References: 202510091940382809HwqVAalRODBWrvsUvqF8@zte.com.cn
Mime-Version: 1.0
From: <liu.xuemei1@zte.com.cn>
To: <liu.xuemei1@zte.com.cn>
Cc: <pbonzini@redhat.com>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <sunilvl@ventanamicro.com>,
 <bjorn@rivosinc.com>, <anisinha@redhat.com>, <qemu-riscv@nongnu.org>,
 <qemu-devel@nongnu.org>, <liu.xuemei1@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHY0IDIvMl0gdGVzdHMvYWNwaTogQWRkIGFjcGkgZ2VkIGFuZCBwb3dlciBidXR0b24gaW4gRFNEVCBmb3LCoFJJU0MtVg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 599BkasB001038
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: liu.xuemei1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Thu, 09 Oct 2025 19:46:40 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68E7A0A0.000/4cj7Pr4F28z4xPSN
Received-SPF: pass client-ip=183.62.165.209;
 envelope-from=liu.xuemei1@zte.com.cn; helo=mxct.zte.com.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01,
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
index 527f239dab13a00ad42e5a70b8dc2b89f12aa84a..caeb46842ad39f7b5f8a8e1d99befd58a268340a 100644
GIT binary patch
delta 170
zcmca4{ZNL>CD<h-k&l6a>Gwn~X(pe?8`W3y)<-uvvB&7e2Rp^PySl`4#Cv$U@H#pN
zcp4ZO8Z&UjhXT1k2_VZkC|Hn>i@TGJftit$fq|itA-cge$km;Jhe1F<fQu!%ksHKy
zb`5s*Q4o=hcMS{SEC6v576?qPPT*o<;9_bE2oG}NYKU%<1TjFC3ApeE_yrg^8#qHO
GV*mhKP$?$>

delta 25
hcmaDTb4i-ZCD<k85-$S-lgdOcX(r!W8`W3y0sv*E2bcf=

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 8e85fcdee9..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/riscv64/virt/DSDT",
-- 
2.27.0


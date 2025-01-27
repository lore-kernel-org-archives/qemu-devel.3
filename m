Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2EAC02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 08:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgeP-0002Je-Q2; Tue, 28 Jan 2025 03:08:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgcJ-0005VP-4c; Tue, 28 Jan 2025 03:06:40 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgcG-0003fL-QR; Tue, 28 Jan 2025 03:06:38 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 710D5E1B80;
 Tue, 28 Jan 2025 10:57:09 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E0E3D1A6333;
 Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 47FA8520F7; Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.3 57/58] tests: acpi: update expected blobs
Date: Mon, 27 Jan 2025 23:25:43 +0300
Message-Id: <20250127202547.3723716-57-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
References: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

_DSM function 7 AML should have followig change:

               If ((Arg2 == 0x07))
               {
  -                Local0 = Package (0x02)
  -                    {
  -                        Zero,
  -                        ""
  -                    }
                   Local2 = AIDX (DerefOf (Arg4 [Zero]), DerefOf (Arg4 [One]
                       ))
  -                Local0 [Zero] = Local2
  +                Local0 = Package (0x02) {}
  +                If (!((Local2 == Zero) || (Local2 == 0xFFFFFFFF)))
  +                {
  +                    Local0 [Zero] = Local2
  +                    Local0 [One] = ""
  +                }
  +
                   Return (Local0)
               }
           }

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250115125342.3883374-4-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 9fb1c9a1bb26e111ee5fa5538070cd684de14c08)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: rebuild acpi tables for 9.1)

diff --git a/tests/data/acpi/x86/pc/DSDT b/tests/data/acpi/x86/pc/DSDT
index c93ad6b7f8..9bb2ec932e 100644
Binary files a/tests/data/acpi/x86/pc/DSDT and b/tests/data/acpi/x86/pc/DSDT differ
diff --git a/tests/data/acpi/x86/pc/DSDT.acpierst b/tests/data/acpi/x86/pc/DSDT.acpierst
index f643fa2d03..2f63056963 100644
Binary files a/tests/data/acpi/x86/pc/DSDT.acpierst and b/tests/data/acpi/x86/pc/DSDT.acpierst differ
diff --git a/tests/data/acpi/x86/pc/DSDT.acpihmat b/tests/data/acpi/x86/pc/DSDT.acpihmat
index 9d3695ff28..a89af57a88 100644
Binary files a/tests/data/acpi/x86/pc/DSDT.acpihmat and b/tests/data/acpi/x86/pc/DSDT.acpihmat differ
diff --git a/tests/data/acpi/x86/pc/DSDT.bridge b/tests/data/acpi/x86/pc/DSDT.bridge
index 840b45f354..380be8ef4e 100644
Binary files a/tests/data/acpi/x86/pc/DSDT.bridge and b/tests/data/acpi/x86/pc/DSDT.bridge differ
diff --git a/tests/data/acpi/x86/pc/DSDT.cphp b/tests/data/acpi/x86/pc/DSDT.cphp
index dbc0141b2b..4932fd0031 100644
Binary files a/tests/data/acpi/x86/pc/DSDT.cphp and b/tests/data/acpi/x86/pc/DSDT.cphp differ
diff --git a/tests/data/acpi/x86/pc/DSDT.dimmpxm b/tests/data/acpi/x86/pc/DSDT.dimmpxm
index 1294f655d4..a4d21d12f5 100644
Binary files a/tests/data/acpi/x86/pc/DSDT.dimmpxm and b/tests/data/acpi/x86/pc/DSDT.dimmpxm differ
diff --git a/tests/data/acpi/x86/pc/DSDT.hpbridge b/tests/data/acpi/x86/pc/DSDT.hpbridge
index 8012b5eb31..55a11f22d1 100644
Binary files a/tests/data/acpi/x86/pc/DSDT.hpbridge and b/tests/data/acpi/x86/pc/DSDT.hpbridge differ
diff --git a/tests/data/acpi/x86/pc/DSDT.ipmikcs b/tests/data/acpi/x86/pc/DSDT.ipmikcs
index 0a891baf45..852f0bbc5c 100644
Binary files a/tests/data/acpi/x86/pc/DSDT.ipmikcs and b/tests/data/acpi/x86/pc/DSDT.ipmikcs differ
diff --git a/tests/data/acpi/x86/pc/DSDT.memhp b/tests/data/acpi/x86/pc/DSDT.memhp
index 9b442a64cf..cd6bbd7a9f 100644
Binary files a/tests/data/acpi/x86/pc/DSDT.memhp and b/tests/data/acpi/x86/pc/DSDT.memhp differ
diff --git a/tests/data/acpi/x86/pc/DSDT.nohpet b/tests/data/acpi/x86/pc/DSDT.nohpet
index 1754c68788..52de3e7f4e 100644
Binary files a/tests/data/acpi/x86/pc/DSDT.nohpet and b/tests/data/acpi/x86/pc/DSDT.nohpet differ
diff --git a/tests/data/acpi/x86/pc/DSDT.numamem b/tests/data/acpi/x86/pc/DSDT.numamem
index 9fc731d3d2..c92d6a8b4d 100644
Binary files a/tests/data/acpi/x86/pc/DSDT.numamem and b/tests/data/acpi/x86/pc/DSDT.numamem differ
diff --git a/tests/data/acpi/x86/pc/DSDT.roothp b/tests/data/acpi/x86/pc/DSDT.roothp
index e654c83ebe..0198a6d956 100644
Binary files a/tests/data/acpi/x86/pc/DSDT.roothp and b/tests/data/acpi/x86/pc/DSDT.roothp differ
diff --git a/tests/data/acpi/x86/q35/DSDT b/tests/data/acpi/x86/q35/DSDT
index fb89ae0ac6..3223604f7d 100644
Binary files a/tests/data/acpi/x86/q35/DSDT and b/tests/data/acpi/x86/q35/DSDT differ
diff --git a/tests/data/acpi/x86/q35/DSDT.acpierst b/tests/data/acpi/x86/q35/DSDT.acpierst
index 46fd25400b..88dd156d95 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.acpierst and b/tests/data/acpi/x86/q35/DSDT.acpierst differ
diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat b/tests/data/acpi/x86/q35/DSDT.acpihmat
index 61c5bd52a4..fe708b4403 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.acpihmat and b/tests/data/acpi/x86/q35/DSDT.acpihmat differ
diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator b/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator
index 3aaa2bbdf5..a9a7cec8d7 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator and b/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator differ
diff --git a/tests/data/acpi/x86/q35/DSDT.applesmc b/tests/data/acpi/x86/q35/DSDT.applesmc
index 944209adea..bebf7d716c 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.applesmc and b/tests/data/acpi/x86/q35/DSDT.applesmc differ
diff --git a/tests/data/acpi/x86/q35/DSDT.bridge b/tests/data/acpi/x86/q35/DSDT.bridge
index d9938dba8f..74b8553af4 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.bridge and b/tests/data/acpi/x86/q35/DSDT.bridge differ
diff --git a/tests/data/acpi/x86/q35/DSDT.core-count b/tests/data/acpi/x86/q35/DSDT.core-count
index a24b04cbdb..d893781416 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.core-count and b/tests/data/acpi/x86/q35/DSDT.core-count differ
diff --git a/tests/data/acpi/x86/q35/DSDT.core-count2 b/tests/data/acpi/x86/q35/DSDT.core-count2
index 3a0cb8c581..ac87bc5db0 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.core-count2 and b/tests/data/acpi/x86/q35/DSDT.core-count2 differ
diff --git a/tests/data/acpi/x86/q35/DSDT.cphp b/tests/data/acpi/x86/q35/DSDT.cphp
index 20955d0aa3..6b8eca2586 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.cphp and b/tests/data/acpi/x86/q35/DSDT.cphp differ
diff --git a/tests/data/acpi/x86/q35/DSDT.cxl b/tests/data/acpi/x86/q35/DSDT.cxl
index afcdc0d0ba..9755fd2c53 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.cxl and b/tests/data/acpi/x86/q35/DSDT.cxl differ
diff --git a/tests/data/acpi/x86/q35/DSDT.dimmpxm b/tests/data/acpi/x86/q35/DSDT.dimmpxm
index 228374b55b..5a0ff97b9e 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.dimmpxm and b/tests/data/acpi/x86/q35/DSDT.dimmpxm differ
diff --git a/tests/data/acpi/x86/q35/DSDT.ipmibt b/tests/data/acpi/x86/q35/DSDT.ipmibt
index 45f911ada5..a7e79e4983 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.ipmibt and b/tests/data/acpi/x86/q35/DSDT.ipmibt differ
diff --git a/tests/data/acpi/x86/q35/DSDT.ipmismbus b/tests/data/acpi/x86/q35/DSDT.ipmismbus
index e5d6811bee..075ac613d2 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.ipmismbus and b/tests/data/acpi/x86/q35/DSDT.ipmismbus differ
diff --git a/tests/data/acpi/x86/q35/DSDT.ivrs b/tests/data/acpi/x86/q35/DSDT.ivrs
index 46fd25400b..88dd156d95 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.ivrs and b/tests/data/acpi/x86/q35/DSDT.ivrs differ
diff --git a/tests/data/acpi/x86/q35/DSDT.memhp b/tests/data/acpi/x86/q35/DSDT.memhp
index 5ce081187a..812ed0fd18 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.memhp and b/tests/data/acpi/x86/q35/DSDT.memhp differ
diff --git a/tests/data/acpi/x86/q35/DSDT.mmio64 b/tests/data/acpi/x86/q35/DSDT.mmio64
index bdf36c4d57..3d5131761c 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.mmio64 and b/tests/data/acpi/x86/q35/DSDT.mmio64 differ
diff --git a/tests/data/acpi/x86/q35/DSDT.multi-bridge b/tests/data/acpi/x86/q35/DSDT.multi-bridge
index 1db43a69e4..a98567b923 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.multi-bridge and b/tests/data/acpi/x86/q35/DSDT.multi-bridge differ
diff --git a/tests/data/acpi/x86/q35/DSDT.nohpet b/tests/data/acpi/x86/q35/DSDT.nohpet
index c13e45e361..a550cf23c0 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.nohpet and b/tests/data/acpi/x86/q35/DSDT.nohpet differ
diff --git a/tests/data/acpi/x86/q35/DSDT.numamem b/tests/data/acpi/x86/q35/DSDT.numamem
index ba6669437e..22b2a21705 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.numamem and b/tests/data/acpi/x86/q35/DSDT.numamem differ
diff --git a/tests/data/acpi/x86/q35/DSDT.pvpanic-isa b/tests/data/acpi/x86/q35/DSDT.pvpanic-isa
index 6ad42873e9..c26f9b1ba6 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.pvpanic-isa and b/tests/data/acpi/x86/q35/DSDT.pvpanic-isa differ
diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count b/tests/data/acpi/x86/q35/DSDT.thread-count
index a24b04cbdb..d893781416 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.thread-count and b/tests/data/acpi/x86/q35/DSDT.thread-count differ
diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count2 b/tests/data/acpi/x86/q35/DSDT.thread-count2
index 3a0cb8c581..ac87bc5db0 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.thread-count2 and b/tests/data/acpi/x86/q35/DSDT.thread-count2 differ
diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm12 b/tests/data/acpi/x86/q35/DSDT.tis.tpm12
index e381ce4cbf..0a91b7ba85 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.tis.tpm12 and b/tests/data/acpi/x86/q35/DSDT.tis.tpm12 differ
diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm2 b/tests/data/acpi/x86/q35/DSDT.tis.tpm2
index a09253042c..b9c83bea1f 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.tis.tpm2 and b/tests/data/acpi/x86/q35/DSDT.tis.tpm2 differ
diff --git a/tests/data/acpi/x86/q35/DSDT.type4-count b/tests/data/acpi/x86/q35/DSDT.type4-count
index edc23198cd..16b4677587 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.type4-count and b/tests/data/acpi/x86/q35/DSDT.type4-count differ
diff --git a/tests/data/acpi/x86/q35/DSDT.viot b/tests/data/acpi/x86/q35/DSDT.viot
index 64e81f5711..70103820a9 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.viot and b/tests/data/acpi/x86/q35/DSDT.viot differ
diff --git a/tests/data/acpi/x86/q35/DSDT.xapic b/tests/data/acpi/x86/q35/DSDT.xapic
index d4acd851c6..5a6310f453 100644
Binary files a/tests/data/acpi/x86/q35/DSDT.xapic and b/tests/data/acpi/x86/q35/DSDT.xapic differ
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 3eab70014c..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,40 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/x86/pc/DSDT",
-"tests/data/acpi/x86/pc/DSDT.acpierst",
-"tests/data/acpi/x86/pc/DSDT.acpihmat",
-"tests/data/acpi/x86/pc/DSDT.bridge",
-"tests/data/acpi/x86/pc/DSDT.cphp",
-"tests/data/acpi/x86/pc/DSDT.dimmpxm",
-"tests/data/acpi/x86/pc/DSDT.hpbridge",
-"tests/data/acpi/x86/pc/DSDT.ipmikcs",
-"tests/data/acpi/x86/pc/DSDT.memhp",
-"tests/data/acpi/x86/pc/DSDT.nohpet",
-"tests/data/acpi/x86/pc/DSDT.numamem",
-"tests/data/acpi/x86/pc/DSDT.roothp",
-"tests/data/acpi/x86/q35/DSDT",
-"tests/data/acpi/x86/q35/DSDT.acpierst",
-"tests/data/acpi/x86/q35/DSDT.acpihmat",
-"tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator",
-"tests/data/acpi/x86/q35/DSDT.applesmc",
-"tests/data/acpi/x86/q35/DSDT.bridge",
-"tests/data/acpi/x86/q35/DSDT.core-count",
-"tests/data/acpi/x86/q35/DSDT.core-count2",
-"tests/data/acpi/x86/q35/DSDT.cphp",
-"tests/data/acpi/x86/q35/DSDT.cxl",
-"tests/data/acpi/x86/q35/DSDT.dimmpxm",
-"tests/data/acpi/x86/q35/DSDT.ipmibt",
-"tests/data/acpi/x86/q35/DSDT.ipmismbus",
-"tests/data/acpi/x86/q35/DSDT.ivrs",
-"tests/data/acpi/x86/q35/DSDT.memhp",
-"tests/data/acpi/x86/q35/DSDT.mmio64",
-"tests/data/acpi/x86/q35/DSDT.multi-bridge",
-"tests/data/acpi/x86/q35/DSDT.nohpet",
-"tests/data/acpi/x86/q35/DSDT.numamem",
-"tests/data/acpi/x86/q35/DSDT.pvpanic-isa",
-"tests/data/acpi/x86/q35/DSDT.thread-count",
-"tests/data/acpi/x86/q35/DSDT.thread-count2",
-"tests/data/acpi/x86/q35/DSDT.tis.tpm12",
-"tests/data/acpi/x86/q35/DSDT.tis.tpm2",
-"tests/data/acpi/x86/q35/DSDT.type4-count",
-"tests/data/acpi/x86/q35/DSDT.viot",
-"tests/data/acpi/x86/q35/DSDT.xapic",
-- 
2.39.5



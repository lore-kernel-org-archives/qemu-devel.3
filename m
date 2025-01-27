Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9C3C02192
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 07:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgSG-0008P1-WA; Tue, 28 Jan 2025 02:56:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgS2-0007nL-9b; Tue, 28 Jan 2025 02:56:07 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgRw-00009n-4S; Tue, 28 Jan 2025 02:55:58 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1D1D8E1AD8;
 Tue, 28 Jan 2025 10:53:00 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8BD841A62C7;
 Tue, 28 Jan 2025 10:53:25 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 4108352025; Tue, 28 Jan 2025 10:53:25 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.16 31/31] tests: acpi: update expected blobs
Date: Tue, 28 Jan 2025 00:41:23 +0300
Message-Id: <20250127214124.3730126-31-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.16-20250128004119@cover.tls.msk.ru>
References: <qemu-stable-7.2.16-20250128004119@cover.tls.msk.ru>
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

diff --git a/tests/data/acpi/pc/DSDT b/tests/data/acpi/pc/DSDT
index b688686dc3..246bcadaa7 100644
Binary files a/tests/data/acpi/pc/DSDT and b/tests/data/acpi/pc/DSDT differ
diff --git a/tests/data/acpi/pc/DSDT.acpierst b/tests/data/acpi/pc/DSDT.acpierst
index 86259be9d1..3074cecb6c 100644
Binary files a/tests/data/acpi/pc/DSDT.acpierst and b/tests/data/acpi/pc/DSDT.acpierst differ
diff --git a/tests/data/acpi/pc/DSDT.acpihmat b/tests/data/acpi/pc/DSDT.acpihmat
index e2cc2a6fc9..0a32881d58 100644
Binary files a/tests/data/acpi/pc/DSDT.acpihmat and b/tests/data/acpi/pc/DSDT.acpihmat differ
diff --git a/tests/data/acpi/pc/DSDT.bridge b/tests/data/acpi/pc/DSDT.bridge
index 75016fd4b7..95c12aa316 100644
Binary files a/tests/data/acpi/pc/DSDT.bridge and b/tests/data/acpi/pc/DSDT.bridge differ
diff --git a/tests/data/acpi/pc/DSDT.cphp b/tests/data/acpi/pc/DSDT.cphp
index 53eb0dd7d4..ac40cbc595 100644
Binary files a/tests/data/acpi/pc/DSDT.cphp and b/tests/data/acpi/pc/DSDT.cphp differ
diff --git a/tests/data/acpi/pc/DSDT.dimmpxm b/tests/data/acpi/pc/DSDT.dimmpxm
index 9089d994e0..b8b62cf9e9 100644
Binary files a/tests/data/acpi/pc/DSDT.dimmpxm and b/tests/data/acpi/pc/DSDT.dimmpxm differ
diff --git a/tests/data/acpi/pc/DSDT.hpbridge b/tests/data/acpi/pc/DSDT.hpbridge
index 86259be9d1..3074cecb6c 100644
Binary files a/tests/data/acpi/pc/DSDT.hpbridge and b/tests/data/acpi/pc/DSDT.hpbridge differ
diff --git a/tests/data/acpi/pc/DSDT.ipmikcs b/tests/data/acpi/pc/DSDT.ipmikcs
index 39427103aa..40edcc0f94 100644
Binary files a/tests/data/acpi/pc/DSDT.ipmikcs and b/tests/data/acpi/pc/DSDT.ipmikcs differ
diff --git a/tests/data/acpi/pc/DSDT.memhp b/tests/data/acpi/pc/DSDT.memhp
index 987a263339..b2a7fd0dbd 100644
Binary files a/tests/data/acpi/pc/DSDT.memhp and b/tests/data/acpi/pc/DSDT.memhp differ
diff --git a/tests/data/acpi/pc/DSDT.nohpet b/tests/data/acpi/pc/DSDT.nohpet
index fc7598b762..713aae4d8a 100644
Binary files a/tests/data/acpi/pc/DSDT.nohpet and b/tests/data/acpi/pc/DSDT.nohpet differ
diff --git a/tests/data/acpi/pc/DSDT.numamem b/tests/data/acpi/pc/DSDT.numamem
index 85af400cdb..70b44ec476 100644
Binary files a/tests/data/acpi/pc/DSDT.numamem and b/tests/data/acpi/pc/DSDT.numamem differ
diff --git a/tests/data/acpi/pc/DSDT.roothp b/tests/data/acpi/pc/DSDT.roothp
index 545512adfa..1030c94cc5 100644
Binary files a/tests/data/acpi/pc/DSDT.roothp and b/tests/data/acpi/pc/DSDT.roothp differ
diff --git a/tests/data/acpi/q35/DSDT b/tests/data/acpi/q35/DSDT
index 2771bcea89..5c2b505163 100644
Binary files a/tests/data/acpi/q35/DSDT and b/tests/data/acpi/q35/DSDT differ
diff --git a/tests/data/acpi/q35/DSDT.acpierst b/tests/data/acpi/q35/DSDT.acpierst
index b45abca7c2..1fd50e1c8b 100644
Binary files a/tests/data/acpi/q35/DSDT.acpierst and b/tests/data/acpi/q35/DSDT.acpierst differ
diff --git a/tests/data/acpi/q35/DSDT.acpihmat b/tests/data/acpi/q35/DSDT.acpihmat
index d90fd4723a..c224736325 100644
Binary files a/tests/data/acpi/q35/DSDT.acpihmat and b/tests/data/acpi/q35/DSDT.acpihmat differ
diff --git a/tests/data/acpi/q35/DSDT.acpihmat-noinitiator b/tests/data/acpi/q35/DSDT.acpihmat-noinitiator
index 279fafa821..ecdb94cc67 100644
Binary files a/tests/data/acpi/q35/DSDT.acpihmat-noinitiator and b/tests/data/acpi/q35/DSDT.acpihmat-noinitiator differ
diff --git a/tests/data/acpi/q35/DSDT.applesmc b/tests/data/acpi/q35/DSDT.applesmc
index fdf6d14428..241a02dcf4 100644
Binary files a/tests/data/acpi/q35/DSDT.applesmc and b/tests/data/acpi/q35/DSDT.applesmc differ
diff --git a/tests/data/acpi/q35/DSDT.bridge b/tests/data/acpi/q35/DSDT.bridge
index b41a4dddc0..bb41a3c218 100644
Binary files a/tests/data/acpi/q35/DSDT.bridge and b/tests/data/acpi/q35/DSDT.bridge differ
diff --git a/tests/data/acpi/q35/DSDT.core-count2 b/tests/data/acpi/q35/DSDT.core-count2
index 375aceed6b..5e0da94644 100644
Binary files a/tests/data/acpi/q35/DSDT.core-count2 and b/tests/data/acpi/q35/DSDT.core-count2 differ
diff --git a/tests/data/acpi/q35/DSDT.cphp b/tests/data/acpi/q35/DSDT.cphp
index a0ecafc36c..6d64cd51f6 100644
Binary files a/tests/data/acpi/q35/DSDT.cphp and b/tests/data/acpi/q35/DSDT.cphp differ
diff --git a/tests/data/acpi/q35/DSDT.cxl b/tests/data/acpi/q35/DSDT.cxl
index 267709e4e4..737e5a2447 100644
Binary files a/tests/data/acpi/q35/DSDT.cxl and b/tests/data/acpi/q35/DSDT.cxl differ
diff --git a/tests/data/acpi/q35/DSDT.dimmpxm b/tests/data/acpi/q35/DSDT.dimmpxm
index f0659716e3..665a0c88ff 100644
Binary files a/tests/data/acpi/q35/DSDT.dimmpxm and b/tests/data/acpi/q35/DSDT.dimmpxm differ
diff --git a/tests/data/acpi/q35/DSDT.ipmibt b/tests/data/acpi/q35/DSDT.ipmibt
index 9c52529919..25ddd90f8e 100644
Binary files a/tests/data/acpi/q35/DSDT.ipmibt and b/tests/data/acpi/q35/DSDT.ipmibt differ
diff --git a/tests/data/acpi/q35/DSDT.ipmismbus b/tests/data/acpi/q35/DSDT.ipmismbus
index 3f32dffdbf..3367016d9a 100644
Binary files a/tests/data/acpi/q35/DSDT.ipmismbus and b/tests/data/acpi/q35/DSDT.ipmismbus differ
diff --git a/tests/data/acpi/q35/DSDT.ivrs b/tests/data/acpi/q35/DSDT.ivrs
index b45abca7c2..1fd50e1c8b 100644
Binary files a/tests/data/acpi/q35/DSDT.ivrs and b/tests/data/acpi/q35/DSDT.ivrs differ
diff --git a/tests/data/acpi/q35/DSDT.memhp b/tests/data/acpi/q35/DSDT.memhp
index 28a192c69a..bfd2278260 100644
Binary files a/tests/data/acpi/q35/DSDT.memhp and b/tests/data/acpi/q35/DSDT.memhp differ
diff --git a/tests/data/acpi/q35/DSDT.mmio64 b/tests/data/acpi/q35/DSDT.mmio64
index 8fda921296..5b50f66a1e 100644
Binary files a/tests/data/acpi/q35/DSDT.mmio64 and b/tests/data/acpi/q35/DSDT.mmio64 differ
diff --git a/tests/data/acpi/q35/DSDT.multi-bridge b/tests/data/acpi/q35/DSDT.multi-bridge
index 3dba4d8436..2f37a6f8b6 100644
Binary files a/tests/data/acpi/q35/DSDT.multi-bridge and b/tests/data/acpi/q35/DSDT.multi-bridge differ
diff --git a/tests/data/acpi/q35/DSDT.nohpet b/tests/data/acpi/q35/DSDT.nohpet
index b116947dac..5c17ed809d 100644
Binary files a/tests/data/acpi/q35/DSDT.nohpet and b/tests/data/acpi/q35/DSDT.nohpet differ
diff --git a/tests/data/acpi/q35/DSDT.numamem b/tests/data/acpi/q35/DSDT.numamem
index 5eb6159d5f..e92f2a0c7a 100644
Binary files a/tests/data/acpi/q35/DSDT.numamem and b/tests/data/acpi/q35/DSDT.numamem differ
diff --git a/tests/data/acpi/q35/DSDT.pvpanic-isa b/tests/data/acpi/q35/DSDT.pvpanic-isa
index 908e7b6606..308ed32bf0 100644
Binary files a/tests/data/acpi/q35/DSDT.pvpanic-isa and b/tests/data/acpi/q35/DSDT.pvpanic-isa differ
diff --git a/tests/data/acpi/q35/DSDT.tis.tpm12 b/tests/data/acpi/q35/DSDT.tis.tpm12
index ce2c2c29c2..a7ec593951 100644
Binary files a/tests/data/acpi/q35/DSDT.tis.tpm12 and b/tests/data/acpi/q35/DSDT.tis.tpm12 differ
diff --git a/tests/data/acpi/q35/DSDT.tis.tpm2 b/tests/data/acpi/q35/DSDT.tis.tpm2
index e9e4b7f6ed..ee242eceba 100644
Binary files a/tests/data/acpi/q35/DSDT.tis.tpm2 and b/tests/data/acpi/q35/DSDT.tis.tpm2 differ
diff --git a/tests/data/acpi/q35/DSDT.viot b/tests/data/acpi/q35/DSDT.viot
index 6b436f9cd9..60451836ff 100644
Binary files a/tests/data/acpi/q35/DSDT.viot and b/tests/data/acpi/q35/DSDT.viot differ
diff --git a/tests/data/acpi/q35/DSDT.xapic b/tests/data/acpi/q35/DSDT.xapic
index f47f091222..9f96175d93 100644
Binary files a/tests/data/acpi/q35/DSDT.xapic and b/tests/data/acpi/q35/DSDT.xapic differ
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 7e7745db39..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,36 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/pc/DSDT",
-"tests/data/acpi/pc/DSDT.acpierst",
-"tests/data/acpi/pc/DSDT.acpihmat",
-"tests/data/acpi/pc/DSDT.bridge",
-"tests/data/acpi/pc/DSDT.cphp",
-"tests/data/acpi/pc/DSDT.dimmpxm",
-"tests/data/acpi/pc/DSDT.hpbridge",
-"tests/data/acpi/pc/DSDT.ipmikcs",
-"tests/data/acpi/pc/DSDT.memhp",
-"tests/data/acpi/pc/DSDT.nohpet",
-"tests/data/acpi/pc/DSDT.numamem",
-"tests/data/acpi/pc/DSDT.roothp",
-"tests/data/acpi/q35/DSDT",
-"tests/data/acpi/q35/DSDT.acpierst",
-"tests/data/acpi/q35/DSDT.acpihmat",
-"tests/data/acpi/q35/DSDT.acpihmat-noinitiator",
-"tests/data/acpi/q35/DSDT.applesmc",
-"tests/data/acpi/q35/DSDT.bridge",
-"tests/data/acpi/q35/DSDT.core-count2",
-"tests/data/acpi/q35/DSDT.cphp",
-"tests/data/acpi/q35/DSDT.cxl",
-"tests/data/acpi/q35/DSDT.dimmpxm",
-"tests/data/acpi/q35/DSDT.ipmibt",
-"tests/data/acpi/q35/DSDT.ipmismbus",
-"tests/data/acpi/q35/DSDT.ivrs",
-"tests/data/acpi/q35/DSDT.memhp",
-"tests/data/acpi/q35/DSDT.mmio64",
-"tests/data/acpi/q35/DSDT.multi-bridge",
-"tests/data/acpi/q35/DSDT.nohpet",
-"tests/data/acpi/q35/DSDT.numamem",
-"tests/data/acpi/q35/DSDT.pvpanic-isa",
-"tests/data/acpi/q35/DSDT.tis.tpm12",
-"tests/data/acpi/q35/DSDT.tis.tpm2",
-"tests/data/acpi/q35/DSDT.viot",
-"tests/data/acpi/q35/DSDT.xapic",
-- 
2.39.5



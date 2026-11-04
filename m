Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A3A606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aD4PFTl9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOZLO-0004pl-Ft; Wed, 04 Nov 2026 06:39:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kaloz@kernel.org>) id 1xOZLG-0004iL-7H
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 06:39:47 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kaloz@kernel.org>) id 1xOZLE-0005IO-CR
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 06:39:45 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1D02743CAC;
 Wed,  4 Nov 2026 11:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BDF1F0093A;
 Wed,  4 Nov 2026 11:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793792383;
 bh=BHQajK5OJDrjW15Yu7Lh3UraBXxSpGrePeizG+gkqIE=;
 h=From:To:Cc:Subject:Date;
 b=aD4PFTl9ogrI0QT0VFkfpI+m1oRWJmCQy8xQJ9OB82bFEtp9JkvyGHA9TtTxWNSlh
 x1Rth0GLxvNWi1AdTZFZdp53fFhOr4K1u7GGGAM7j/bM6LVXYZr/V0Cq808FRa6Xvp
 q2GF8+fcxscrfVrH/JKdUNuHll3rXUPmxsEdGIMcG0VyYmBn5oXiTZx4QXeK7VNzos
 AJbJ/OLbaGqlSq1I0ASwlfB1NEh2C2L5Vp9+XU2KbRRZRjZ8d3VV0tMdHicHBxdzdh
 caVNUyCZ/r1zrIm5oy78dC9NLeoQDG8CWhczLXlNncm+yDFYvTIqL5C0SrDSieV3EG
 Wl6JDNpsx/05A==
From: Imre Kaloz <kaloz@kernel.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH] hw/sparc/sun4m: Add an FCode PROM naming the SS-20 DBRI node
Date: Wed,  4 Nov 2026 12:38:26 +0100
Message-ID: <20261104113826.12838-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=kaloz@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Sun's OBP probes the DBRI slot on the SS-20 and builds a node without
a name from the all-zero PROM, which guests then trip over. Provide a
minimal FCode image naming the node SUNW,DBRI with its register range.

Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 hw/sparc/sun4m.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 550acdff6d..649087dc12 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -557,6 +557,31 @@ static void cg3_init(hwaddr addr, qemu_irq irq, int vram_size, int width,
 
 static const uint8_t idreg_data[] = { 0xfe, 0x81, 0x01, 0x03 };
 
+/*
+ * toke: fcode-version2 " SUNW,DBRI" device-name my-address h# 10000 +
+ * my-space encode-phys h# 100 encode-int encode+ " reg" property fcode-end
+ */
+static const uint8_t dbri_fcode[] = {
+    0xf1, 0x08, 0x04, 0x9c, 0x00, 0x00, 0x00, 0x32,
+    0x12, 0x09, 0x53, 0x55, 0x4e, 0x57, 0x2c, 0x44,
+    0x42, 0x52, 0x49, 0x02, 0x01, 0x01, 0x02, 0x10,
+    0x00, 0x01, 0x00, 0x00, 0x1e, 0x01, 0x03, 0x01,
+    0x13, 0x10, 0x00, 0x00, 0x01, 0x00, 0x01, 0x11,
+    0x01, 0x12, 0x12, 0x03, 0x72, 0x65, 0x67, 0x01,
+    0x10, 0x00
+};
+
+static void dbri_prom_init(hwaddr addr)
+{
+    MemoryRegion *rom = g_new(MemoryRegion, 1);
+
+    memory_region_init_rom(rom, NULL, "sun-DBRI.prom", 0x40, &error_fatal);
+    memory_region_add_subregion(get_system_memory(), addr, rom);
+    address_space_write_rom(&address_space_memory, addr,
+                            MEMTXATTRS_UNSPECIFIED,
+                            dbri_fcode, sizeof(dbri_fcode));
+}
+
 static void idreg_init(hwaddr addr)
 {
     DeviceState *dev;
@@ -1025,8 +1050,7 @@ static void sun4m_hw_init(MachineState *machine)
     if (hwdef->dbri_base) {
         /* ISDN chip with attached CS4215 audio codec */
         /* prom space */
-        create_unimplemented_device("sun-DBRI.prom",
-                                    hwdef->dbri_base + 0x1000, 0x30);
+        dbri_prom_init(hwdef->dbri_base + 0x1000);
         /* reg space */
         create_unimplemented_device("sun-DBRI",
                                     hwdef->dbri_base + 0x10000, 0x100);

base-commit: 33eb51c859834f2024090bf843c69814267b6c26
-- 
2.47.3



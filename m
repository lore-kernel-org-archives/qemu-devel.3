Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9898C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 05:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whh0n-0006k9-Ix; Thu, 09 Jul 2026 01:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1whh0m-0006jo-5I
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 01:09:24 -0400
Received: from sonic317-22.consmr.mail.gq1.yahoo.com ([98.137.66.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1whh0k-0005m5-1z
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 01:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1783573759; bh=kmy5paPyj91SKIk+LerOoztgxWQwrnHMoCIHazjSiVs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=MZH1mclGU4ruI0+LdCfz41JXG+oFEb2obJMU86XAXmUnDbkgnzcvPOU3vI2lTgYWJ9WwmbNO4Dc0JBKFcZ7907YarMhwSWFTL+w1C4eXnXdE2xwm/JB/JhiB02cpbPtxbHc3nJe57IHdLs/UhOnhxRVf+cGQfaE208xDb23LU3nSZ16Xr+3G7cpaRHsfk3Lva/OG7AAprYD+VP/PSIuaR7rsfoh+BxDAW4SPZkAKNLG8JPz8mQS2xxmhc909q/bU+7s+yBobMC7a7JVYpvrCTQHQDIGgitHgBu+99UpBQEiec1YqflxORLviNizSr26hwOeEbyAJWKE7vsb/4NZ8/g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1783573759; bh=JmeEKn342st9g/1wzewS85akdS4ip0dtXJIO74yrS2U=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=PXyiGPD4PNxyTImzKgviWGm8dtgbgBfh/liU531VG1GdGZ8lS4hw+DMTMYsKNQIuYCK6rkdnJmCQ4pkgnsXctTfMsDacLI+0S3GOWpc9aSWBaIUFboqNTKyiJ0pX2Lt+GDTZXVWJgmbRzRwjUhCJ8kyGD9jPerSuS2I+Zf7ZTJggwIfeM25y4/pftZA9rhaZTT+zpb7oqsg3n1H3qLRuU7i30/ddozOOp1MUqfxRmp3fLMc0et1obAFVKfLR/OaD3F/OCsxPAGNii4pH8Mrrn+vV/Zpp+1bDTn62JPiNxpQUOQa7ojsuFzXRUx0mLnW1+YP5mSk/9Q319Ut0FlMstQ==
X-YMail-OSG: JP3ORNQVM1k7hVrC4QRxWlHnl6u6wxJSELA1u95XKrM1igfBPtXXr0OpuihtPfO
 5cp8z1HRaH0cfXc807kU5utm9UtPJiUkkBxFq1h4yzJAfLTQvcp_sotOvnhJwnzJUGFL3kioZuwb
 AlbGRAZfAeuleMrpQDK8CkI3N29t1qrc.IAUDEx74O1mEkuXT.vSrsciOuPN1dAGN95KMawL0Cp2
 lrz4wp7z46yNzrBjY4WyB2I72FxrhTp1.3BxNcmjPiBo24spuU.LREAKR56X2hlV0JrRIfbYIVcF
 mxCH7lajxMCHFxRuFkNx.gN4CxBuqD011.2YzhhNDOdrvI7ber9yX8RWc04vruV0GT_lBrSEZzuF
 JCu1UINFn2MQRIwig2bIyHozxtYTmjyBg7XQ4KNR9VCtmt.olfqLvtE_m0dOYyKlRj..4id4dxeN
 hm3aN2Ga1UZsUMi8vQ5_mjMf_E3SSFtRvI7SLQfyRwVhOTj170LnqS3D5DuFACh_iEkEsfwNL8Zk
 eQIpDYzakaaj9w0DH5fVzqMA5SYSKqaGqqMTKndelRgEhG_3NcCwKyFyaD_ILS.J14SPA9Tc593b
 ISAM8PpNmsRO3Ofp871yHXeXQCyn4Xbg3kWy.puw8z4LJ5SCsMG8_2Djweq.lGlsgJLnp286lhKn
 _pgDfKQSKjLvT6SuPoAzRXuzl0PeDc.4IqO1gSDMvNT5huDkj5y8aqKI4T2KUDhHWnQSw3kAa1an
 hVPioToq47KXV8PcArkP3SGVYssyJj6ZKCErIYcJi8MuVt5JXnwtqNeuhonJ0OsmJvBc.Na8QUYM
 M0nU3PvP8Ir4uL.q0IT6mO5FvDPpQ7lWQjZgzjESEZxN2OZ4K38GFG3f8CbJNDav7GpvwnrTuHch
 N9PqOId4ex8mCHaKtzyv5BHRMMEqXR6GWZs8vKi6dMNFt8tT1h08tkXk_ls.A5F.Ajz.wd_uLyBH
 HPT4vuLA77aJPjQMBSRK6QxaJJ.upZ_B1Ah51X2KRqU.3EU0KkF1qDccpUdF1RkktQX12c.Ctfjd
 V_J1MMP9.H19prN7169UOvCh6dk1Y2LZegpL4klhHHCsbNGcPIjG.CG1PUv1sayv2tIW0AjF3edw
 Rj3glSGWg0pCYQC4ZEn1RdKjgQI1NIjjLXexwfeHMJDYgpIEuTn15qdwC789ooB12fAtTGdj5Wh2
 LGE8b3x1NuIAuk7CN8.AOhhZPqe9S7iW4Bu.915Q14qqBGX8IkXv5ojb.q.5zJKSNdm3Y84eVH0n
 Cklhf8Z9orhk0KDYWQHbyle_SrcASkl7yUNj0yq2R19PyquvPsxX90Qu8554n7klaqB8OsNDblgJ
 bSM51Gk.qT.MYjPXv4_O4LprTS5ep2dR6gpgS1xSbLQT9Z_ew65tkExbeLC5Osv6A5HSXhqS_lZW
 l4Tlh4cmiE4DaY.P0Q55MbH.yJV8XoN7NIm2QvC88oljwqKWmPmNFdNfPI5zrnn.gHpOwW_NOHgE
 KT6e_7LU1Dp6rpIeJ15UO2CkJ3Rco0YWoU5xGHoGDI9VbNomEQ2YYlTlVYT2DwGFOKFuEnGz1P4X
 pnMXiA9eLS0doyG2sBJo51axW3Bs2znsnGpCy65tIU.E6SQjUcqOqPuJXm8ECzDYpxgC63vUKWD7
 EQohl6yHouMns4dOeipvkQtjfkrPwR1MuuRTrebTazV9OiWWuuXVB0R9jMS4X3pttJbkLtj9eT6D
 1vjc1Lyrw0_MCZAuQtv4j8ugkZkqGp2P8i7UGgmJgpNoofu4EvKbRUV1WUzNaAtsYVVLVZm0EkfP
 NrVOLwoyCbd3KRA8KNQjRZfGc64dYJeeYOREW.1ejPX.6tCWpBz.B2TDr1gv540CPDnO28aEu.DP
 WIdyDK03Ih3p8UaY1BBHa4n_mTF7ww__ggN5vLbeyv.KQf1LZd4Ga.WfylmN3316pcaIFLcoW7qQ
 yKFSIrBVkwv0Ipqf40Vww8Z5rEetfG8J.4kzHQqEz0JnSrsk8LsIWvKB9p59nd5GeMNLphLCTp_A
 uy9EqcMqTQ3eaNxD5PBYgR5FoFum94rBpFPkkxnK1th1Orz44xeM50aJGlZ6VdjdXkjPiCf63502
 4oAwrYL..C0QTaLhQ75Tr6Oy0eiT0JbKual2cg_oq2D7ls2b5kyjX9hbllARZPAxm7MTk6PAwtDL
 kfzK6qqM6BqK1IR8upEC9m0ZBT_4Kdw2C1_o_S4UBcWaBDLaOSk8DKUpHlDIXm5LTZVbug6kkv5a
 8mjZrWvm_rkC9.SuWlEcKA5bzGdMFNar.aw--
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: ab70c891-c758-4cb7-abaf-8092e0093e86
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic317.consmr.mail.gq1.yahoo.com with HTTP; Thu, 9 Jul 2026 05:09:19 +0000
Received: by hermes--production-ne1-7568ccb994-mqdhs (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID da73cafa7d25cff72b3b6899257e7b9a; 
 Thu, 09 Jul 2026 05:09:13 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 1/3] xen/igd: get PCH info from host sysfs
Date: Thu,  9 Jul 2026 01:09:08 -0400
Message-ID: <20260709050910.8217-2-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709050910.8217-1-brchuckz@aol.com>
References: <20260709050910.8217-1-brchuckz@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=98.137.66.148; envelope-from=brchuckz@aol.com;
 helo=sonic317-22.consmr.mail.gq1.yahoo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

The igd_combo_id_infos[] data is more than 10 years
out of date with many Intel IGD devices missing from
igd_combo_id_infos[]. This means that many devices
that could be supported will not work with the
current implementation.

For newer devices not listed in igd_combo_id_infos[],
get infos from the host sysfs to enable support for the
newer devices not listed in igd_combo_id_infos[].

Introduce the helper function xen_pt_get_host_pch_info
to facilitate getting the necessary information from
sysfs.

Also, use errp in xen_igd_passthrough_isa_bridge_create
to propagate errors from xen_pt_get_host_pch_info.

Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
---
 hw/xen/xen_pt.c          |  2 +-
 hw/xen/xen_pt_graphics.c | 82 ++++++++++++++++++++++++++++++++++++++--
 include/hw/xen/xen_igd.h |  3 +-
 3 files changed, 82 insertions(+), 5 deletions(-)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 0fe9c0a..474606e 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -867,7 +867,7 @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
         }
 
         /* Register ISA bridge for passthrough GFX. */
-        xen_igd_passthrough_isa_bridge_create(s, &s->real_device);
+        xen_igd_passthrough_isa_bridge_create(s, &s->real_device, errp);
     }
 
     /* Handle real device's MMIO/PIO BARs */
diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
index 7df9344..54f0d54 100644
--- a/hw/xen/xen_pt_graphics.c
+++ b/hw/xen/xen_pt_graphics.c
@@ -376,8 +376,75 @@ static void pt_graphics_register_types(void)
 }
 type_init(pt_graphics_register_types)
 
+static void xen_pt_get_host_pch_info(PCIDevice *dev, uint16_t *pch_dev_id,
+                                 uint8_t *pch_rev_id, Error **errp)
+{
+    FILE *fp1, *fp2;
+    char *endptr;
+    char device_id[7], rev[5];
+    size_t len;
+    const char *device = "/sys/bus/pci/devices/0000:00:1f.0/device";
+    const char *revision = "/sys/bus/pci/devices/0000:00:1f.0/revision";
+    unsigned long val;
+
+    fp1 = fopen(device, "r");
+    if (fp1 == NULL) {
+        error_setg_errno(errp, errno, "Cannot open %s", device);
+        return;
+    }
+    fp2 = fopen(revision, "r");
+    if (fp2 == NULL) {
+        error_setg_errno(errp, errno, "Cannot open %s", revision);
+        fclose(fp1);
+        return;
+    }
+
+    len = fread(device_id, 1, 7, fp1);
+    if (!len) {
+        error_setg(errp, "Cannot read %s", device);
+        fclose(fp1);
+        fclose(fp2);
+        return;
+    }
+    len = fread(rev, 1, 5, fp2);
+    if (!len) {
+        error_setg(errp, "Cannot read %s", revision);
+        fclose(fp1);
+        fclose(fp2);
+        return;
+    }
+    fclose(fp1);
+    fclose(fp2);
+
+    val = strtoul(device_id, &endptr, 16);
+    if (val > 0xffff) {
+        error_setg(errp, "PCH device id is out of range: 0x%lx", val);
+        return;
+    }
+    if ((endptr > device_id) && (errno != ERANGE) &&
+        (errno != EINVAL)) {
+        *pch_dev_id = (uint16_t)val;
+    } else {
+        error_setg_errno(errp, errno, "device id strtoul "
+                                      "conversion failed");
+        return;
+    }
+    val = strtoul(rev, &endptr, 16);
+    if (val > 0xff) {
+        error_setg(errp, "PCH revision is out of range: 0x%lx", val);
+        return;
+    }
+    if ((endptr > rev) && (errno != ERANGE) && (errno != EINVAL)) {
+        *pch_rev_id = (uint8_t)val;
+    } else {
+        error_setg_errno(errp, errno, "revision strtoul "
+                                      "conversion failed");
+    }
+}
+
 void xen_igd_passthrough_isa_bridge_create(XenPCIPassthroughState *s,
-                                           XenHostPCIDevice *dev)
+                                           XenHostPCIDevice *dev,
+                                           Error **errp)
 {
     PCIBus *bus = pci_get_bus(&s->dev);
     struct PCIDevice *bridge_dev;
@@ -394,7 +461,16 @@ void xen_igd_passthrough_isa_bridge_create(XenPCIPassthroughState *s,
         }
     }
 
-    if (pch_dev_id == 0xffff) {
+    /* Newer devices get PCH infos from host sysfs */
+    if ((pch_dev_id == 0xffff) || !pch_rev_id) {
+        xen_pt_get_host_pch_info(&s->dev, &pch_dev_id, &pch_rev_id, errp);
+    }
+
+    XEN_PT_LOG(&s->dev, "PCH device id: 0x%x\n", pch_dev_id);
+    XEN_PT_LOG(&s->dev, "PCH revision: 0x%x\n", pch_rev_id);
+
+    if ((pch_dev_id == 0xffff) || !pch_rev_id) {
+        error_setg(errp, "failed to get PCH device id or revision");
         return;
     }
 
@@ -406,7 +482,7 @@ void xen_igd_passthrough_isa_bridge_create(XenPCIPassthroughState *s,
      * Note that vendor id is always PCI_VENDOR_ID_INTEL.
      */
     if (!bridge_dev) {
-        fprintf(stderr, "set igd-passthrough-isa-bridge failed!\n");
+        error_setg(errp, "set igd-passthrough-isa-bridge failed!");
         return;
     }
     pci_config_set_device_id(bridge_dev->config, pch_dev_id);
diff --git a/include/hw/xen/xen_igd.h b/include/hw/xen/xen_igd.h
index 7ffca06..da51f09 100644
--- a/include/hw/xen/xen_igd.h
+++ b/include/hw/xen/xen_igd.h
@@ -22,7 +22,8 @@ uint32_t igd_read_opregion(XenPCIPassthroughState *s);
 void xen_igd_reserve_slot(PCIBus *pci_bus);
 void igd_write_opregion(XenPCIPassthroughState *s, uint32_t val);
 void xen_igd_passthrough_isa_bridge_create(XenPCIPassthroughState *s,
-                                           XenHostPCIDevice *dev);
+                                           XenHostPCIDevice *dev,
+                                           Error **errp);
 
 static inline bool is_igd_vga_passthrough(XenHostPCIDevice *dev)
 {
-- 
2.52.0



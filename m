Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3B3CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhbN-0000iP-Ke; Fri, 16 Oct 2026 09:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHf9x-0005nQ-Jj; Fri, 16 Oct 2026 06:27:37 -0400
Received: from out203-205-221-239.mail.qq.com ([203.205.221.239])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHf9u-0003nt-4A; Fri, 16 Oct 2026 06:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792146445; bh=HJBSNhy30ysWNl8lFPWtNESXuXw0iirx7WNezPjoAwU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=qI0p5ky7EVtzl4bqpFOYH0UDUQvYiL70P+yy/fmJ16lxJINJFmgvzXzl7PcQ7d5Gn
 ZdBxB0AOF5jI59CavwMXlKQijDsGuuFha3wj0xGvTWd2aG3MDlGKwiGPaY4AyIbRBT
 LbCUGHfYRWjL9H3gZwJkoy/cl1V06e2h97maJdCk=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
 id 6D696459; Fri, 16 Oct 2026 18:27:22 +0800
X-QQ-mid: xmsmtpt1792146442tvnvsqu9n
Message-ID: <tencent_A847C7182BCA69DC138B882EB70852E13308@qq.com>
X-QQ-XMAILINFO: M84Ob7gbJGBW758zOf2+QdbF/xGFXbc91ouTVNx+etWcPwedY34Nc3dtgO/IjC
 8Lo0zwHhZeGnucfWWztGb3I/tQUVDr1UqiAChm7fD57RRHbU2qeECOnLbbvMh2NRcPKEueJtsBRt
 YWcjvYYUCzWWAFpHo+3kS8GejOdkzAUNzrv3cOZEdpODYamAq4Sh0nyV6pu8F3FIkjeSNI2/CiHW
 NfSQxzyub25Lbqn36BFCcJXSWlFGjjiGOZiB1TV/NvMRGzei5IcECK7PiXpppdkKj2EYLUxOHT+L
 /QJ5FbLtDlTGgnonAq8czIz52+70RX5Q3/KP+N2bq6HGaKlxIcPwTf41zdSKpmkHC8r2qpYyjTnk
 n1N/e174rao2uVDPKjzHljCES9V+b6E0ErriwoM1ay76b64Zfiaaf/lj3vGl4m5lwTvFJBG4/NZX
 n3XhxafbN14cTWQruWERNpaFItuYyVVlsBk8JBlq2VFyZ8xraRr5vzNoZD6nmhGRNBWsjFP6wL0X
 3ESBcMRtNxZ6Yv4PDFOjflhypiXMMeC8rgWKnFs4NVIrcoMvytJsDAYuqRD5DvVcVmwxvc0RBKr5
 Y0MmmvGASdRkZPomrfqYnugjezj0d/artqzoe6MRGEIElYt0z5Vvq+tILofMP0UyHQCTx/anIW9D
 y+AcDzD/tPNsUtu4Q+kEpazTbLNocbuSaELQYVkkY1lZ4xauwDWB29zavCdp+4rubVjf5ugoNE+p
 FXW9A2CPtR+ui9T4UHi/reEIMlCccdLUgrN1jJv12UcBIdo9FmxSHZgRoq4XuxNODseghTerTDk4
 NHLFMktOzW7jvOyE4Ybirruu2/FzWd+07roKeZ3GC9DjIa+34kG70xOS1TERZHOjRjCxiY9tGqrS
 941n2nZzaDiuQuVvB/xf1Dn6A3klqzt0SdIOgcX/aUToPpJF8dZYNkWNPapTI0tHdDEE00C3dJG2
 Gf/nqV+yOsETfSlrgJ2Wu83rsw747cliRujvA7T8N3/eaR/aw2PWPZzj+CYPYL/F2VWrAGdvhfYu
 EuvNUyzr7ZoKEa5PYUm0ZU3n7GwHSa5SlVvG1deTl9zujNilXjdusLLRcgjeW3oWHj6NkBrFpcJR
 fW2dVa
X-QQ-XMRINFO: MFuljud3PUW4Hy49K308V+nvGr8SioTB3Q==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 31/37] hw/arm/mpam: Add device reset and power-on state
 initialisation
Date: Fri, 16 Oct 2026 18:10:51 +0800
X-OQ-MSGID: <20261016101058.1900808-17-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016101058.1900808-1-2118537295@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.239; envelope-from=2118537295@qq.com;
 helo=out203-205-221-239.mail.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:45 -0400
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

Move the power-on initialisation out of realize into
mpam_msc_state_init() (shared with the new legacy reset callback):
selection state and ECR/ESR cleared, per-RIS partition and monitor
storage zeroed, the PARTID narrowing map identity-wrapped so the
indirection is always in range before the driver programs it, and
MBW_MAX reset to 0xffff (full bandwidth) -- an unprogrammed PARTID
must not read as zero bandwidth.

Also fix the realize error message for num-partid == 0, which
repeated the num-ris text.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/mpam.c | 78 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 60 insertions(+), 18 deletions(-)

diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
index fe78adb..c4a7567 100644
--- a/hw/arm/mpam.c
+++ b/hw/arm/mpam.c
@@ -1041,6 +1041,63 @@ static const MemoryRegionOps mpam_msc_ops = {
     },
 };
 
+
+/*
+ * Power-on state of the MSC, shared between realize and reset: ID narrowing
+ * map identity-wrapped, partition config at reset values, monitors off.
+ */
+static void mpam_msc_state_init(MPAMMSCState *s)
+{
+    int i;
+
+    s->ris = 0;
+    s->part_sel = 0;
+    s->internal_part_sel = false;
+    s->mon_sel = 0;
+    s->ecr = 0;
+    s->esr = 0;
+
+    for (i = 0; i < s->num_ris; i++) {
+        Mpamf *mpamf = &s->mpamf[i];
+        int p;
+
+        mpamf->ecr = 0;
+        mpamf->esr = 0;
+        memset(mpamf->per_nrw_id, 0,
+               sizeof(MpamfPerNrwId) * s->num_int_partid);
+        memset(mpamf->cfg_intpartid, 0,
+               sizeof(uint32_t) * s->num_partid);
+        memset(mpamf->mbwu_mons, 0,
+               sizeof(MpamMbwuMon) * s->num_mbwu_mon);
+        memset(mpamf->csu_mons, 0, sizeof(MpamCsuMon) * s->num_csu_mon);
+
+        /*
+         * Until resctrl programs the map, wrap each request PARTID onto an
+         * internal PARTID so the narrowing indirection is always in range.
+         */
+        for (p = 0; p < s->num_partid; p++) {
+            mpamf->cfg_intpartid[p] = p % s->num_int_partid;
+        }
+        /*
+         * per_nrw_id is indexed by INTERNAL PARTID: it has
+         * num_int_partid entries, not num_partid.  Writing it with the
+         * request-PARTID count overflowed the allocation by 224 entries
+         * (malloc(): corrupted top size once the struct grew).
+         */
+        for (p = 0; p < s->num_int_partid; p++) {
+            /* MBW_MAX resets to full bandwidth on real hardware */
+            mpamf->per_nrw_id[p].cfg_mbw_max = 0xffff;
+        }
+    }
+}
+
+static void mpam_msc_reset(DeviceState *dev)
+{
+    MPAMMSCState *s = MPAM_MSC_DEVICE(dev);
+
+    mpam_msc_state_init(s);
+}
+
 static void mpam_msc_realize(DeviceState *dev, Error **errp)
 {
     MPAMMSCState *s = MPAM_MSC_DEVICE(dev);
@@ -1052,7 +1109,7 @@ static void mpam_msc_realize(DeviceState *dev, Error **errp)
         return;
     }
     if (s->num_partid == 0) {
-        error_setg(errp, "num-ris must be <= 16");
+        error_setg(errp, "num-partid must be nonzero");
         return;
     }
     if (s->num_int_partid == 0) {
@@ -1061,28 +1118,12 @@ static void mpam_msc_realize(DeviceState *dev, Error **errp)
 
     s->mpamf = g_new0(Mpamf, s->num_ris);
     for (i = 0; i < s->num_ris; i++) {
-        int p;
-
         s->mpamf[i].per_nrw_id = g_new0(MpamfPerNrwId, s->num_int_partid);
         s->mpamf[i].cfg_intpartid = g_new0(uint32_t, s->num_partid);
         s->mpamf[i].mbwu_mons = g_new0(MpamMbwuMon, s->num_mbwu_mon);
         s->mpamf[i].csu_mons = g_new0(MpamCsuMon, s->num_csu_mon);
-        /*
-         * Until resctrl programs the map, wrap each request PARTID onto an
-         * internal PARTID so the narrowing indirection is always in range.
-         */
-        for (p = 0; p < s->num_partid; p++) {
-            s->mpamf[i].cfg_intpartid[p] = p % s->num_int_partid;
-        }
-        /*
-         * per_nrw_id is indexed by INTERNAL PARTID: it has num_int_partid
-         * entries, not num_partid.
-         */
-        for (p = 0; p < s->num_int_partid; p++) {
-            /* MBW_MAX resets to full bandwidth on real hardware */
-            s->mpamf[i].per_nrw_id[p].cfg_mbw_max = 0xffff;
-        }
     }
+    mpam_msc_state_init(s);
 
     memory_region_init_io(&s->mr, OBJECT(s), &mpam_msc_ops, s, "mpam_msc",
                           MPAM_SIZE);
@@ -1301,6 +1342,7 @@ static void mpam_msc_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_props(dc, mpam_msc_props);
+    device_class_set_legacy_reset(dc, mpam_msc_reset);
 }
 
 static void mpam_msc_mem_init(ObjectClass *klass, const void *data)
-- 
2.43.0



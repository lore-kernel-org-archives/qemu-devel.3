Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E52FCCF2C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhaN-0007eg-O3; Fri, 16 Oct 2026 09:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHf6y-0004x7-HR; Fri, 16 Oct 2026 06:24:28 -0400
Received: from out203-205-221-155.mail.qq.com ([203.205.221.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHf6v-0003FR-4p; Fri, 16 Oct 2026 06:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792146261; bh=rDp79DioD8mPAcJkEzO0Z8e3MQ/4i7VYX3lWbxivnV8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AFIVt4uhRzCc/QnjTkQ9edFYEHVB/taCORQGnLJGVt/CGxvfocc7L/khZtqXoYujL
 Ry8hX/ktxb+fM98J4XkIo1Y9iHngUvD0cHSnEfwTVReEDXLCLSEmll9Eo2IZVYYbhW
 A4MANWqtLIYOMRDalEqkyOJX4sbyCRIr83T0Id58=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
 id 6129AC57; Fri, 16 Oct 2026 18:24:18 +0800
X-QQ-mid: xmsmtpt1792146258tdukgaghi
Message-ID: <tencent_AC3DAD6EC21E11ED96534A7C86F518684505@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3JunKES9qXhP8bm1PIEm8RG3WZ+NwU+RjUbNDeLCeOKJSQ3bgfQVX
 kIJeGxRLHS3oJw+xUou/tJ7h2mciZS+rojq1gzS2X6rGMLtRSNGttDBJ7NJT7bECYGXIxJOVXdAx
 f+bCG4aTGVyHc3IqmHTQWkGg1EgH8dchqTq4EGo2YyzmAt2MsUzyW13/zrE+qMWyrHP3FnsXk6Pt
 JZ6lv/6WQpVI74Imco4VhHrN0pWRkBv7tbt6LOH/yNmmcDr5YU8582Dd0ZyK0Sjd79SWB24N+8NV
 SDRdijXc9XV5VRCYdxo8XOyLYI31EU7d/mVbhUvZJKMLkOL84SVBrWWxUF2vMDarBpc4Jkcer6Ut
 rRN12M/9TV5NNMPU1nUCWFmmV/GjQ4ytyfAS/xu/WqQFS+gxnRIP+PrF16oPhk5ZCDWdD2IyXhN5
 4iZh1czstAGjULgzwaHSM7R3tPOlnYmGe1nuKrsD7s9Fr9SZ6g6pRhnmTrWzlVnAMg35Rjb7La1H
 6TyAAE6yxGV/fuHos+pzrKX25G/06xef2KlohBKFlF52QqxYUf9DSOjroZNDfI10u+tEJzaYdDnH
 SqEi5biCwVOfNFfMdu9uMpFkidonAHXJezjZfEzCWAqnt8m3FxmLESrkL0ZKFfBD6zJ6TFzbB1dK
 Ciuoi4PbE36Ax4CFgKxY5Dz6GDqSiEo4fnfJeUksddqVA/deXS7z0mStapV8u9b9CfSQX29LkeOd
 +TC2rWelbF6tPotLdUu0p9Pxp9ZoT4KuzdPo8CExUH75IQ+rF6hzHPNklyeFGLV2z9Lmez5GzRyz
 DXJVUutxN7ICRV8Hp5n0PQwykZ7h9r+Jg3T99V9YCAqT3LIBlzodOfHau1BSO12quGABIPJKU3Fs
 WWrgsOwEe4F+kRXT7tnUxP0GuAGJ5o85RZLYQ/CNfgcSBQHloPmAiE08eGsqg8QJodNTRLFlnxhq
 hrLricKR4C+gT5v7N5+NQAWKez7+Mr3mr64uBVgz9LLEIdFSl3Ystfl2LgOdI8w1GBSN9c+GlAMO
 ovNKwRZbhmFzT3lFje7Mok2sjH+kTiWzdrQxgBARkoICVvEyQTyOLNWAhlom+NGcrGqXE7K10T0R
 KfWFCp
X-QQ-XMRINFO: Mgo7HCA7/T7wIX0t4ApVT043Ha8Jni9z/A==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 28/37] hw/arm/mpam: Emulate CSU cache-usage monitoring
Date: Fri, 16 Oct 2026 18:10:48 +0800
X-OQ-MSGID: <20261016101058.1900808-14-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016101058.1900808-1-2118537295@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.155; envelope-from=2118537295@qq.com;
 helo=out203-205-221-155.mail.qq.com
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

Add the CSU monitor: MSMON_CFG_CSU_FLT/CTL window configuration
(replacing the unimplemented-monitor placeholder), the MSMON_CSU
and MSMON_CSU_CAPTURE reads, and the per-RIS monitor array with
the num-csu-mon and csu-capacity-bytes properties.  Occupancy is
modelled as a snapshot: csu-capacity-bytes scaled by the CPBM
portion fraction of the filtered PARTID, so cache-usage readings
track the configured CBM.  Writes to the CSU counters are ignored
(they probe NRDY; the snapshot is always ready) and CSU
monitoring is advertised in MSMON_IDR/CSUMON_IDR on the cache
subtype, which lets the driver pick QOS_L2/L3_OCCUP
(llc_occupancy).

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/mpam.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 97 insertions(+), 2 deletions(-)

diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
index 50c8a8e..6c93ead 100644
--- a/hw/arm/mpam.c
+++ b/hw/arm/mpam.c
@@ -11,6 +11,7 @@
 #include "qemu/timer.h"
 #include "qemu/host-utils.h"
 #include "qemu/bitops.h"
+#include "qemu/units.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/registerfields.h"
@@ -139,8 +140,20 @@ REG32(MSMON_MBWU_L, 0x0880)         /* 64-bit counter */
 REG32(MSMON_MBWU_CAPTURE, 0x0868)
 REG32(MSMON_MBWU_CAPTURE_L, 0x0890)
 REG32(MSMON_CAPT_EVNT, 0x0808)
+
 REG32(MSMON_CFG_CSU_FLT, 0x0810)
+    FIELD(MSMON_CFG_CSU_FLT, PARTID, 0, 16)
+    FIELD(MSMON_CFG_CSU_FLT, PMG, 16, 8)
+    FIELD(MSMON_CFG_CSU_FLT, XCL, 31, 1)
+
 REG32(MSMON_CFG_CSU_CTL, 0x0818)
+    FIELD(MSMON_CFG_CSU_CTL, TYPE, 0, 8)
+    FIELD(MSMON_CFG_CSU_CTL, MATCH_PARTID, 16, 1)
+    FIELD(MSMON_CFG_CSU_CTL, MATCH_PMG, 17, 1)
+    FIELD(MSMON_CFG_CSU_CTL, EN, 31, 1)
+
+REG32(MSMON_CSU, 0x0840)             /* 31-bit value, bit31 NRDY */
+REG32(MSMON_CSU_CAPTURE, 0x0848)
 
 REG32(MPAMF_ERR_MSI_MPAM, 0x00dc)
 REG32(MPAMF_ERR_MSI_ADDR_L, 0x00e0)
@@ -282,6 +295,16 @@ typedef struct MpamMbwuMon {
     bool oflow;
 } MpamMbwuMon;
 
+/*
+ * One CSU monitor instance.  Occupancy is modelled as a snapshot: the
+ * cache capacity scaled by the CPBM portion fraction of the filtered
+ * PARTID, so cache-usage readings track the configured CBM.
+ */
+typedef struct MpamCsuMon {
+    uint32_t flt;
+    uint32_t ctl;
+} MpamCsuMon;
+
 typedef struct Mpamf {
     uint64_t idr;
     uint32_t iidr;
@@ -308,6 +331,7 @@ typedef struct Mpamf {
     MpamfPerNrwId *per_nrw_id;
 
     MpamMbwuMon *mbwu_mons;
+    MpamCsuMon *csu_mons;
 
 } Mpamf;
 
@@ -326,6 +350,8 @@ typedef struct MPAMMSCState {
     uint8_t num_ris;
     uint32_t num_mbwu_mon;
     uint64_t bw_nominal_bps;
+    uint32_t num_csu_mon;
+    uint64_t csu_capacity;
 
     /*
      * Wired-interrupt GSIVs the board assigned (INTID = SPI + 32).  Zero
@@ -468,6 +494,36 @@ static uint64_t mpam_mbwu_value(MPAMMSCState *s, Mpamf *mf, MpamMbwuMon *m)
     return v;
 }
 
+static MpamCsuMon *mpam_csu_mon(MPAMMSCState *s, Mpamf *mf)
+{
+    unsigned mon = FIELD_EX32(s->mon_sel, MSMON_CFG_MON_SEL, MON_SEL);
+
+    if (mon >= s->num_csu_mon) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "MPAM: MON_SEL %d out of range (num-csu-mon %d)\n",
+                      mon, s->num_csu_mon);
+        mon = 0;
+    }
+    return &mf->csu_mons[mon];
+}
+
+/*
+ * Snapshot occupancy: the cache capacity scaled by the fraction of CPBM
+ * portions the filtered PARTID is allowed to occupy.
+ */
+static uint32_t mpam_csu_value(MPAMMSCState *s, Mpamf *mf, MpamCsuMon *m)
+{
+    if (FIELD_EX32(m->ctl, MSMON_CFG_CSU_CTL, EN) &&
+        FIELD_EX32(m->ctl, MSMON_CFG_CSU_CTL, MATCH_PARTID)) {
+        uint32_t partid = FIELD_EX32(m->flt, MSMON_CFG_CSU_FLT, PARTID);
+        uint32_t nrw = mpam_nrw_id_for(s, mf, partid);
+        uint32_t cpbm = mf->per_nrw_id[nrw].cfg_cpbm[0];
+
+        return muldiv64(s->csu_capacity, ctpop32(cpbm), MPAM_CACHE_PART);
+    }
+    return 0;
+}
+
 typedef struct MPAMMSCMemState {
     MPAMMSCState parent;
 } MPAMMSCMemState;
@@ -563,6 +619,21 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
         return mpamf->mbwumon_idr;
     case A_MSMON_CFG_MON_SEL:
         return s->mon_sel;
+    case A_MSMON_CFG_CSU_FLT:
+        return mpam_csu_mon(s, mpam_mon_ris(s))->flt;
+    case A_MSMON_CFG_CSU_CTL:
+        return mpam_csu_mon(s, mpam_mon_ris(s))->ctl;
+    case A_MSMON_CSU ... (A_MSMON_CSU + 3):
+    case A_MSMON_CSU_CAPTURE ... (A_MSMON_CSU_CAPTURE + 3):
+    {
+        uint32_t v = mpam_csu_value(s, mpam_mon_ris(s),
+                                    mpam_csu_mon(s, mpam_mon_ris(s)));
+        hwaddr off = (offset >= A_MSMON_CSU_CAPTURE) ?
+                     offset - A_MSMON_CSU_CAPTURE : offset - A_MSMON_CSU;
+
+        /* NRDY (bit 31) is never set: the snapshot is always ready */
+        return extract32(v, off * 8, 32 - off * 8);
+    }
     case A_MSMON_CFG_MBWU_FLT:
         return mpam_mbwu_mon(s, mpam_mon_ris(s))->flt;
     case A_MSMON_CFG_MBWU_CTL:
@@ -879,11 +950,23 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
         m->t0 = qemu_clock_get_ns(QEMU_CLOCK_HOST);
         return;
     }
-    case A_MSMON_CAPT_EVNT:
     case A_MSMON_CFG_CSU_FLT:
+        mpam_csu_mon(s, mpam_mon_ris(s))->flt = value;
+        return;
     case A_MSMON_CFG_CSU_CTL:
+        mpam_csu_mon(s, mpam_mon_ris(s))->ctl = value;
+        return;
+    case A_MSMON_CSU:
+    case A_MSMON_CSU_CAPTURE:
+        /*
+         * The driver pokes these with MSMON___NRDY to probe whether the
+         * counter needs polling.  Ignoring the write leaves the snapshot
+         * permanently ready, which is what the emulation models.
+         */
+        return;
+    case A_MSMON_CAPT_EVNT:
         qemu_log_mask(LOG_UNIMP,
-                      "MPAM: cache-usage monitoring not implemented (write %lx)\n",
+                      "MPAM: capture events not implemented (write %lx)\n",
                       offset);
         return;
     case A_MPAMF_ECR:
@@ -941,6 +1024,7 @@ static void mpam_msc_realize(DeviceState *dev, Error **errp)
         s->mpamf[i].per_nrw_id = g_new0(MpamfPerNrwId, s->num_int_partid);
         s->mpamf[i].cfg_intpartid = g_new0(uint32_t, s->num_partid);
         s->mpamf[i].mbwu_mons = g_new0(MpamMbwuMon, s->num_mbwu_mon);
+        s->mpamf[i].csu_mons = g_new0(MpamCsuMon, s->num_csu_mon);
         /*
          * Until resctrl programs the map, wrap each request PARTID onto an
          * internal PARTID so the narrowing indirection is always in range.
@@ -1088,6 +1172,14 @@ static void mpam_msc_cache_realize(DeviceState *dev, Error **errp)
         mpamf->mbwumon_idr = FIELD_DP32(mpamf->mbwumon_idr,
                                         MPAMF_MBWUMON_IDR, HAS_RWBW, 1);
 
+        if (s->num_csu_mon) {
+            mpamf->msmon_idr = FIELD_DP32(mpamf->msmon_idr,
+                                          MPAMF_MSMON_IDR, MSMON_CSU, 1);
+            mpamf->csumon_idr = FIELD_DP32(mpamf->csumon_idr,
+                                           MPAMF_CSUMON_IDR, NUM_MON,
+                                           s->num_csu_mon);
+        }
+
         /* Cache specific bit */
         mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_CPOR_PART, 1);
         mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART, 1);
@@ -1148,6 +1240,9 @@ static const Property mpam_msc_props[] = {
     DEFINE_PROP_UINT32("num-mbwu-mon", MPAMMSCState, num_mbwu_mon, 8),
     DEFINE_PROP_UINT64("bw-nominal-bps", MPAMMSCState, bw_nominal_bps,
                        10000000000ULL),  /* 10 GB/s default bandwidth */
+    DEFINE_PROP_UINT32("num-csu-mon", MPAMMSCState, num_csu_mon, 4),
+    DEFINE_PROP_UINT64("csu-capacity-bytes", MPAMMSCState, csu_capacity,
+                       32 * MiB),
     DEFINE_PROP_UINT32("err-gsiv", MPAMMSCState, err_gsiv, 0),
     DEFINE_PROP_UINT32("oflow-gsiv", MPAMMSCState, oflow_gsiv, 0),
     DEFINE_PROP_UINT16("node", MPAMMSCState, node, UINT16_MAX),
-- 
2.43.0



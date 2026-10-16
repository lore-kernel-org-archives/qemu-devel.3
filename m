Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CBACCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhb2-0008F1-6P; Fri, 16 Oct 2026 09:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHf33-0003xp-3p; Fri, 16 Oct 2026 06:20:28 -0400
Received: from out162-62-57-210.mail.qq.com ([162.62.57.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHf2y-0002pT-Ko; Fri, 16 Oct 2026 06:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792146016; bh=hasM4qISt0I505+dv42KMRg8udNIIEWtAwOtD3ndGHQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=rIEFzwLEuz5YQSwgFb45djI84/XSejK983O4A4vxaLVvHI45tix4lHEul4U06AM9X
 V6dsYUSvzCG1eVD+NgFXTJYLMS63k8IvspG0Rp/4r/D8W/lZ52L/C4QDeRLkI58SgV
 +TjPzfIW75ySOh+aInXvQuQ2XV9YFBqV6zAOdfos=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id 50D12A89; Fri, 16 Oct 2026 18:20:13 +0800
X-QQ-mid: xmsmtpt1792146013ti4q2y21z
Message-ID: <tencent_A8F7986545254D664209D1EB165DCA754605@qq.com>
X-QQ-XMAILINFO: M84Ob7gbJGBWMc0Oew/NOfDYraViwqM6gGgHKlr8jJdskabr/3ShCjHTKK2yvD
 arEq6bNtdBz2Q/f5//VUprLZpBrKdqBUux8d3D9/W+ZRBZTN8hRZLM8UDbkFvK9xLYrR9pjhnngH
 fJKi62IATlEw4nejusoHKy1liPFgzcT7QBngqBbYBZOZ+GnjYY2Pky/Fn7rnNvn8O2LcBerGk1f6
 9vmk6QAm3BAK6TKkoJJRDJQQiVUIPhrrimBuS4efYk232l2aWBaJJjXz6LK5W8nJPCAnX2uFLYNU
 SKZ9BSZYN2iLDFBLVGvFGb+kPRhbVeKz7HgnI/k2234BvYfewYJBhPGXjVAnvm9ZBYpkKz9SLqsc
 QYOJLvsauzWs9WOZmgNL+IM8rBgpqxeikYUGZNLO9T0UmxZ7IJgfthFl71fxG8EefFNrv257qLfS
 OUUdjISNol/qY9m9PLjxQIeKOVBHuFv2qk2G3qTxw1S9QKy9+TxFirngzVfmNBtXINUwMGQ8j/EO
 h4l7zPhtKFCCanxRINviJ5mEblfnQvEs/vliE8YpTed99isH9IAN/jxYreP3EQBx6kSmA/ZlvgYr
 ld6V30OSRmP016IKURLDxcTSR+2V4atJF0WLHIkakEQSXwFiV4FGG9NpatYGAibd90MdE77kglU5
 3J5G5065g5ld7ZY4jn5IFesdnkJ5FFWfbybyTyYXXzQnecjDY5LvCNdxutltadu4lo3GNAJOwtGd
 KzzgtPFc5GK+rvNno0qv6jZ7VgXhzy7e/GIyuhXTv3+oKPqCVUC6wzNvEZNx1l2uSmkqZCxiUSZo
 bri0+byqMXqG2kuMIhrLaI68sEORSqW5XodP478HG8KigykruqWXsQQ+lhFjCbRxLw1W8pL7pdcS
 0LS64gxwNfdouYr7CaeEzfnIHgqtw2czGTGy1mx0y02zQyxLXRF4uTvcIO9qgMrcMTjIUy+bwT40
 kIKkl2UVJnoGmp5qr0txxPSszdgeXyknUsQQFD3Be5XSEZ4n6JmpLbdiG1S23+o41WfaxySDGSi2
 mO2723y4y7gZ88EVwbw7phZSqrbOUEFPbZsm80W0VEiLm1goPLnqQH1YQQc7z0bGXed/lFiqCsuG
 P0kLYkVc4KUQy+hi8=
X-QQ-XMRINFO: NV153Ut7BKVGEBPxNGBppa2DJCr1urzIPw==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 24/37] hw/arm/mpam: Add MSMON monitor selection and window
 configuration
Date: Fri, 16 Oct 2026 18:10:44 +0800
X-OQ-MSGID: <20261016101058.1900808-10-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016101058.1900808-1-2118537295@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.57.210; envelope-from=2118537295@qq.com;
 helo=out162-62-57-210.mail.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:44 -0400
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

Add the monitor-side plumbing shared by the monitor types: the
MSMON register definitions (MON_SEL, MBWU_FLT/CTL), the per-RIS
monitor instance array with the num-mbwu-mon and bw-nominal-bps
properties, and the read/write handling of the selection and
window registers (monitor/RIS selection with range clamping,
filter and control storage, write-one-to-clear overflow status).

The monitor selection resolves a (RIS, monitor) pair through
mpam_mon_ris()/mpam_mbwu_mon(), and mpam_nrw_id_for() maps a
filter PARTID onto the internal PARTID whose configuration
governs it.  No monitor type is advertised yet; the MBWU counter
model arrives with the next patch.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/mpam.c | 134 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
index b484509..77e0277 100644
--- a/hw/arm/mpam.c
+++ b/hw/arm/mpam.c
@@ -109,6 +109,36 @@ REG32(MPAMF_MBWUMON_IDR, 0x0090)
     FIELD(MPAMF_MBWUMON_IDR, HAS_LONG, 30, 1)
     FIELD(MPAMF_MBWUMON_IDR, HAS_CAPTURE, 31, 1)
 
+REG32(MSMON_CFG_MON_SEL, 0x0800)
+    FIELD(MSMON_CFG_MON_SEL, MON_SEL, 0, 8)
+    FIELD(MSMON_CFG_MON_SEL, RIS, 24, 4)
+
+REG32(MSMON_CFG_MBWU_FLT, 0x0820)
+    FIELD(MSMON_CFG_MBWU_FLT, PARTID, 0, 16)
+    FIELD(MSMON_CFG_MBWU_FLT, PMG, 16, 8)
+    FIELD(MSMON_CFG_MBWU_FLT, RWBW, 30, 2)
+
+REG32(MSMON_CFG_MBWU_CTL, 0x0828)
+    FIELD(MSMON_CFG_MBWU_CTL, TYPE, 0, 8)
+    FIELD(MSMON_CFG_MBWU_CTL, MATCH_PARTID, 16, 1)
+    FIELD(MSMON_CFG_MBWU_CTL, MATCH_PMG, 17, 1)
+    FIELD(MSMON_CFG_MBWU_CTL, SCLEN, 19, 1)
+    FIELD(MSMON_CFG_MBWU_CTL, SUBTYPE, 20, 4)
+    FIELD(MSMON_CFG_MBWU_CTL, OFLOW_FRZ, 24, 1)
+    FIELD(MSMON_CFG_MBWU_CTL, OFLOW_INTR, 25, 1)
+    FIELD(MSMON_CFG_MBWU_CTL, OFLOW_STATUS, 26, 1)
+    FIELD(MSMON_CFG_MBWU_CTL, CAPT_RESET, 27, 1)
+    FIELD(MSMON_CFG_MBWU_CTL, CAPT_EVNT, 28, 3)
+    FIELD(MSMON_CFG_MBWU_CTL, EN, 31, 1)
+
+REG32(MSMON_MBWU, 0x0860)           /* 31-bit counter, bit31 NRDY */
+REG32(MSMON_MBWU_L, 0x0880)         /* 64-bit counter */
+REG32(MSMON_MBWU_CAPTURE, 0x0868)
+REG32(MSMON_MBWU_CAPTURE_L, 0x0890)
+REG32(MSMON_CAPT_EVNT, 0x0808)
+REG32(MSMON_CFG_CSU_FLT, 0x0810)
+REG32(MSMON_CFG_CSU_CTL, 0x0818)
+
 REG32(MPAMF_ERR_MSI_MPAM, 0x00dc)
 REG32(MPAMF_ERR_MSI_ADDR_L, 0x00e0)
 REG32(MPAMF_ERR_MSI_ADDR_H, 0x00e4)
@@ -232,6 +262,21 @@ typedef struct MpamfPerNrwId {
         uint32_t cfg_mbw_prop;
 } MpamfPerNrwId;
 
+/*
+ * One MBWU monitor instance.  The counter is lazily advanced on
+ * access: value = base + rate x (now - t0), where rate is the
+ * nominal bandwidth scaled by the MBW_MAX fraction of the filtered
+ * PARTID.  Monitoring therefore reads back values that track the
+ * configured bandwidth control.
+ */
+typedef struct MpamMbwuMon {
+    uint32_t flt;
+    uint32_t ctl;
+    uint64_t base;
+    int64_t t0;
+    bool oflow;
+} MpamMbwuMon;
+
 typedef struct Mpamf {
     uint64_t idr;
     uint32_t iidr;
@@ -257,6 +302,8 @@ typedef struct Mpamf {
 
     MpamfPerNrwId *per_nrw_id;
 
+    MpamMbwuMon *mbwu_mons;
+
 } Mpamf;
 
 typedef struct MPAMMSCState {
@@ -267,10 +314,13 @@ typedef struct MPAMMSCState {
     uint8_t ris;
     uint16_t part_sel; /* Technically per ris, but in same reg */
     bool internal_part_sel;
+    uint32_t mon_sel;
     struct MemoryRegion mr;
     uint32_t num_partid;
     uint32_t num_int_partid;
     uint8_t num_ris;
+    uint32_t num_mbwu_mon;
+    uint64_t bw_nominal_bps;
 
     /*
      * Wired-interrupt GSIVs the board assigned (INTID = SPI + 32).  Zero
@@ -312,6 +362,48 @@ static uint32_t mpam_get_nrw_id(MPAMMSCState *s)
     return intpartid % s->num_int_partid;
 }
 
+/*
+ * Resolve a request PARTID from a monitor filter onto the internal
+ * PARTID whose configuration governs it.
+ */
+static uint32_t mpam_nrw_id_for(MPAMMSCState *s, Mpamf *mf, uint32_t partid)
+{
+    uint32_t intpartid;
+
+    if (!FIELD_EX32(mf->idr, MPAMF_IDR, HAS_PARTID_NRW)) {
+        return partid;
+    }
+
+    intpartid = mf->cfg_intpartid[partid % s->num_partid];
+    return intpartid % s->num_int_partid;
+}
+
+static Mpamf *mpam_mon_ris(MPAMMSCState *s)
+{
+    unsigned ris = FIELD_EX32(s->mon_sel, MSMON_CFG_MON_SEL, RIS);
+
+    if (ris >= s->num_ris) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "MPAM: MON_SEL RIS %d out of range (num-ris %d)\n",
+                      ris, s->num_ris);
+        ris = 0;
+    }
+    return &s->mpamf[ris];
+}
+
+static MpamMbwuMon *mpam_mbwu_mon(MPAMMSCState *s, Mpamf *mf)
+{
+    unsigned mon = FIELD_EX32(s->mon_sel, MSMON_CFG_MON_SEL, MON_SEL);
+
+    if (mon >= s->num_mbwu_mon) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "MPAM: MON_SEL %d out of range (num-mbwu-mon %d)\n",
+                      mon, s->num_mbwu_mon);
+        mon = 0;
+    }
+    return &mf->mbwu_mons[mon];
+}
+
 typedef struct MPAMMSCMemState {
     MPAMMSCState parent;
 } MPAMMSCMemState;
@@ -405,6 +497,20 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
         return mpamf->csumon_idr;
     case A_MPAMF_MBWUMON_IDR:
         return mpamf->mbwumon_idr;
+    case A_MSMON_CFG_MON_SEL:
+        return s->mon_sel;
+    case A_MSMON_CFG_MBWU_FLT:
+        return mpam_mbwu_mon(s, mpam_mon_ris(s))->flt;
+    case A_MSMON_CFG_MBWU_CTL:
+    {
+        MpamMbwuMon *m = mpam_mbwu_mon(s, mpam_mon_ris(s));
+        uint32_t ctl = m->ctl;
+
+        if (m->oflow) {
+            ctl |= R_MSMON_CFG_MBWU_CTL_OFLOW_STATUS_MASK;
+        }
+        return ctl;
+    }
     case A_MPAMF_ERR_MSI_MPAM:
         return mpamf->err_msi_mpam;
     case A_MPAMF_ERR_MSI_ADDR_L:
@@ -623,6 +729,30 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
         mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_pbm[array_offset] = value;
         return;
     }
+    case A_MSMON_CFG_MON_SEL:
+        s->mon_sel = value & (R_MSMON_CFG_MON_SEL_MON_SEL_MASK |
+                              R_MSMON_CFG_MON_SEL_RIS_MASK);
+        return;
+    case A_MSMON_CFG_MBWU_FLT:
+        mpam_mbwu_mon(s, mpam_mon_ris(s))->flt = value;
+        return;
+    case A_MSMON_CFG_MBWU_CTL:
+    {
+        MpamMbwuMon *m = mpam_mbwu_mon(s, mpam_mon_ris(s));
+
+        m->ctl = value;
+        if (value & R_MSMON_CFG_MBWU_CTL_OFLOW_STATUS_MASK) {
+            m->oflow = false;               /* write-one-to-clear */
+        }
+        return;
+    }
+    case A_MSMON_CAPT_EVNT:
+    case A_MSMON_CFG_CSU_FLT:
+    case A_MSMON_CFG_CSU_CTL:
+        qemu_log_mask(LOG_UNIMP,
+                      "MPAM: cache-usage monitoring not implemented (write %lx)\n",
+                      offset);
+        return;
     case A_MPAMF_ECR:
         if (value & ~MPAMF_ECR_WRITE_MASK) {
             qemu_log_mask(LOG_UNIMP,
@@ -677,6 +807,7 @@ static void mpam_msc_realize(DeviceState *dev, Error **errp)
 
         s->mpamf[i].per_nrw_id = g_new0(MpamfPerNrwId, s->num_int_partid);
         s->mpamf[i].cfg_intpartid = g_new0(uint32_t, s->num_partid);
+        s->mpamf[i].mbwu_mons = g_new0(MpamMbwuMon, s->num_mbwu_mon);
         /*
          * Until resctrl programs the map, wrap each request PARTID onto an
          * internal PARTID so the narrowing indirection is always in range.
@@ -845,6 +976,9 @@ static const Property mpam_msc_props[] = {
     DEFINE_PROP_UINT8("num-ris", MPAMMSCState, num_ris, 1),
     DEFINE_PROP_UINT32("num-partid", MPAMMSCState, num_partid, 1),
     DEFINE_PROP_UINT32("num-int-partid", MPAMMSCState, num_int_partid, 0),
+    DEFINE_PROP_UINT32("num-mbwu-mon", MPAMMSCState, num_mbwu_mon, 8),
+    DEFINE_PROP_UINT64("bw-nominal-bps", MPAMMSCState, bw_nominal_bps,
+                       10000000000ULL),  /* 10 GB/s default bandwidth */
     DEFINE_PROP_UINT32("err-gsiv", MPAMMSCState, err_gsiv, 0),
     DEFINE_PROP_UINT32("oflow-gsiv", MPAMMSCState, oflow_gsiv, 0),
     DEFINE_PROP_UINT16("node", MPAMMSCState, node, UINT16_MAX),
-- 
2.43.0



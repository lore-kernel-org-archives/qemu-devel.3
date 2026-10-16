Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D686CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhbM-0000eU-Ox; Fri, 16 Oct 2026 09:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHfC4-000690-Hf; Fri, 16 Oct 2026 06:29:44 -0400
Received: from out203-205-221-149.mail.qq.com ([203.205.221.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHfBt-0004C0-Ur; Fri, 16 Oct 2026 06:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792146568; bh=NprCINAvEv1kGydi+3KzShtA3Mww2kHBA6eRZIHfsJQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZuZiBCNZOABAQr6rNAQXZbxR6BvKmBKo5R8jfX8Y4r5sv8uG2zg7CUKjGvQProX8p
 mYTdKJIz9QH+jdjsLYh/ObFfGTpzxpMosQ5aQS/et3kLdymLCTeE9w2sUBze9La3Aj
 FW7J5qZheFrLmwlX4q2H1bvjQt6W91ZHK9nBrIAI=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
 id 759BE211; Fri, 16 Oct 2026 18:29:25 +0800
X-QQ-mid: xmsmtpt1792146565tqui7ikx3
Message-ID: <tencent_C971CBCA581AEB8403E2D1ED9854FE0CD406@qq.com>
X-QQ-XMAILINFO: M84Ob7gbJGBWafGCZMybf9RUKxtUfa3PjbGWBxNlKrKwKizLTgwWC4ksITqL33
 RT+kfa7sYZ5M1KyYXzZc3ZQ5PIjDmjYBtyB5SR7MH3Ys6y19I8zl8dXPL7ApJ0XTSjs1WX1e4I+1
 X6OWVHPcjZreYRKSMD2sbvQ8ULyksHTxtATu6bJMd+5Z8IeJv79aLSyBuzkAsfifTJCyKrc/cg/i
 ji+qP79YiUK8ZpZ3WEkMkT7vb0cUjE6VBK1QNLD/K+Fslcixwnv6XiNbzs7f8l+amoyBjdeNAs5V
 2tnRhgO93t4+UuDvmbEjGuX/se300iaGchUDrprJZiOEBclFPvpkuFpWSnuSd+P4pXpY5IxC0LTQ
 AMGS4bJSCGN6bOngmQ+dxqttjMzrvxE5LtjuQNcq8PkOpFdF1AGQVfg7JF1xkyjLc+wte4f3eIts
 8ZLFMFfVV1Nty7jksBUdwPIItOAOitZphhpArZsNQrpchEX+jc9ibzKou2o/3iTd8wlULYSpY2jA
 IhnFVfnauRlxS2djJs/Q86c69ciUp/SR4jl2IJzPibmWvmR0xntUv5mj64iV/2b2kuARZcaf/JnX
 EzkcqZkK/9oQaB1+LwL5v64OTN76UE2+NYPL0HJ4i/AhmKmWTS2hLuERhBmwnKU8RnzfBVReH6Un
 RJyy0bIByVjTGwkCTsrcnNeqWKt61ustDbkVW6gSzzteuz2LdRvtAfTB2/sfBalW/02f1uwWKmjG
 uWgRUNnUvGd3YhtTnxkJbogovm24sJYU2sQh0462rB1W2sMu4MEXvo5Hq/yrCC8vSZy2nGESzUqh
 ZOZIZtT6uMuYa35GYvuFMaxpPORWfK5X9041pz15wkgPE/hmDkp/Aj10jSVdwq3Xe8MAbeH6IK85
 7f2yCY/QUjXKRWwuzEnKasWI8j3lpGLHRzkiU141vAzLvFx6NTcENgPoN116ulB4ARkbdoD+wJ19
 2Jlr/sECulu1eacS0PMbvE2fNY8+MdoefOyM7nPxZ3/4OGDM3jlq2Sxxjjbm2r7tsec35TDrwZb+
 MX5qU/AXrcLtuvY5kr+ul0ymccJ7k9ZqMN6/xkVc71vTEwZOrWaGH296v0zlJyVy4XglN4d7+xnn
 pKmcyd
X-QQ-XMRINFO: MFuljud3PUW4Hy49K308V+nvGr8SioTB3Q==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 33/37] hw/arm/mpam: Record errors and reject invalid
 configuration writes
Date: Fri, 16 Oct 2026 18:10:53 +0800
X-OQ-MSGID: <20261016101058.1900808-19-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016101058.1900808-1-2118537295@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.149; envelope-from=2118537295@qq.com;
 helo=out203-205-221-149.mail.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:46 -0400
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

Add MPAMF_ESR error recording with the IHI 0099 Table 7-1
encodings this model can raise, injected on the check-and-reject
write paths: Undefined_RIS_PART_SEL / Undefined_RIS_MON_SEL on
out-of-range selector RIS (the range check also subsumes nonzero
RIS on an MSC without RIS support), intPARTID_Range on INTERNAL=0
or out-of-range intPARTID, Monitor_Range on MON_SEL beyond every
monitor type, and MSMONCFG_ID_RANGE on out-of-range filter PARTID.
All are paths the kernel driver never hits; normal boot raises
nothing (verified).  A recorded error overwrites PARTID_MON/PMG/RIS
and sets OVRWR if a previous error was still latched.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/mpam.c | 124 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 117 insertions(+), 7 deletions(-)

diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
index 0389dad..6c43e3e 100644
--- a/hw/arm/mpam.c
+++ b/hw/arm/mpam.c
@@ -173,6 +173,14 @@ REG64(MPAMF_ESR, 0x00f8)
     FIELD(MPAMF_ESR, OVRWR, 31, 1)
     FIELD(MPAMF_ESR, RIS, 32, 4)
 
+/* IHI 0099 Table 7-1: MPAMF_ESR.ERR_CODE encodings this model can raise */
+#define MPAM_ERRCODE_PARTID_SEL_RANGE    1
+#define MPAM_ERRCODE_MSMONCFG_ID_RANGE   3
+#define MPAM_ERRCODE_MONITOR_RANGE       5
+#define MPAM_ERRCODE_INTPARTID_RANGE     6
+#define MPAM_ERRCODE_UNDEF_RIS_PART_SEL  8
+#define MPAM_ERRCODE_UNDEF_RIS_MON_SEL  10
+
 REG32(MPAMF_CFG_PART_SEL, 0x0100)
     FIELD(MPAMF_CFG_PART_SEL, PARTID_SEL, 0, 16)
     FIELD(MPAMF_CFG_PART_SEL, INTERNAL, 16, 1)
@@ -448,6 +456,33 @@ static void mpam_msc_update_err_irq(MPAMMSCState *s)
     qemu_set_irq(s->err_irq, int_en && active);
 }
 
+/*
+ * Record an error in MPAMF_ESR and raise the error interrupt if enabled.
+ * PARTID_MON also carries a selector value (e.g. MON_SEL) for the errors
+ * where Table 7-1 lists "MON_SEL and RIS" as the fields in effect.
+ */
+static void mpam_msc_inject_error(MPAMMSCState *s, uint32_t errcode,
+                                  uint16_t partid_mon, uint8_t pmg,
+                                  uint8_t ris)
+{
+    uint64_t esr = 0;
+
+    if (FIELD_EX64(s->esr, MPAMF_ESR, ERR_CODE)) {
+        esr = FIELD_DP64(esr, MPAMF_ESR, OVRWR, 1);
+    }
+    esr = FIELD_DP64(esr, MPAMF_ESR, PARID_MON, partid_mon);
+    esr = FIELD_DP64(esr, MPAMF_ESR, PMG, pmg);
+    esr = FIELD_DP64(esr, MPAMF_ESR, ERR_CODE, errcode);
+    esr = FIELD_DP64(esr, MPAMF_ESR, RIS, ris);
+    s->esr = esr;
+    mpam_msc_sync_esr_ecr(s);
+
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "MPAM: error 0x%x partid/mon %u pmg %u ris %u\n",
+                  errcode, partid_mon, pmg, ris);
+    mpam_msc_update_err_irq(s);
+}
+
 /*
  * IHI 0099 8.3: the overflow interrupt is signalled while any monitor has
  * latched OFLOW_STATUS with OFLOW_INTR set; clearing OFLOW_STATUS of all
@@ -852,18 +887,21 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
                           "MPAM: Unexpected write to CFG_PART_SEL Mask=%x Value=%lx\n",
                           MPAMF_CFG_PART_SEL_WRITE_MASK, value);
         }
-        /* Field matches for all RIS */
-        if (!FIELD_EX64(mpamf->idr, MPAMF_IDR, HAS_RIS) &&
-            FIELD_EX32(value, MPAMF_CFG_PART_SEL, RIS) != 0) {
-            qemu_log_mask(LOG_UNIMP,
-                          "MPAM: Unexpected write of non 0 RIS on MSC with !HAS_RIS\n");
-            return;
-        }
+        /*
+         * Field matches for all RIS. The range check subsumes the !HAS_RIS
+         * case: such an MSC implements only RIS 0, so any nonzero RIS is
+         * undefined (IHI 0099 Table 7-1: Undefined_RIS_PART_SEL).
+         */
         if (FIELD_EX32(value, MPAMF_CFG_PART_SEL, RIS) >= s->num_ris) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "MPAM: RIS %d out of range (num-ris %d)\n",
                           FIELD_EX32(value, MPAMF_CFG_PART_SEL, RIS),
                           s->num_ris);
+            mpam_msc_inject_error(s, MPAM_ERRCODE_UNDEF_RIS_PART_SEL,
+                                  FIELD_EX32(value, MPAMF_CFG_PART_SEL,
+                                             PARTID_SEL),
+                                  0,
+                                  FIELD_EX32(value, MPAMF_CFG_PART_SEL, RIS));
             return;
         }
         {
@@ -894,6 +932,23 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
                           "MPAM: Unexpected write to INTPARTID when !HAS_PARTID_NRW\n");
             return;
         }
+        /*
+         * Table 7-1: writing INTERNAL as zero, or an out-of-range
+         * intPARTID, raises intPARTID_Range and is not written.
+         */
+        if (!FIELD_EX32(value, MPAMF_MPAMCFG_INTPARTID, INTERNAL) ||
+            FIELD_EX32(value, MPAMF_MPAMCFG_INTPARTID, INTPARTID) >=
+                s->num_int_partid) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "MPAM: INTPARTID write invalid (value %x, max %d)\n",
+                          FIELD_EX32(value, MPAMF_MPAMCFG_INTPARTID, INTPARTID),
+                          s->num_int_partid - 1);
+            mpam_msc_inject_error(s, MPAM_ERRCODE_INTPARTID_RANGE,
+                                  FIELD_EX32(value, MPAMF_MPAMCFG_INTPARTID,
+                                             INTPARTID),
+                                  0, s->ris);
+            return;
+        }
 
         mpamf->cfg_intpartid[s->part_sel] =
             FIELD_EX32(value, MPAMF_MPAMCFG_INTPARTID, INTPARTID);
@@ -996,12 +1051,53 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
         return;
     }
     case A_MSMON_CFG_MON_SEL:
+    {
+        uint32_t mon = FIELD_EX32(value, MSMON_CFG_MON_SEL, MON_SEL);
+        uint32_t ris = FIELD_EX32(value, MSMON_CFG_MON_SEL, RIS);
+        uint32_t num_mon = MAX(s->num_csu_mon, s->num_mbwu_mon);
+
+        /*
+         * Check-and-reject (IHI 0099 7.2.9): RIS selects a nonexistent
+         * resource instance or MON_SEL exceeds every monitor type this
+         * MSC implements.
+         */
+        if (ris >= s->num_ris) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "MPAM: MON_SEL RIS %d out of range (num-ris %d)\n",
+                          ris, s->num_ris);
+            mpam_msc_inject_error(s, MPAM_ERRCODE_UNDEF_RIS_MON_SEL,
+                                  mon, 0, ris);
+            return;
+        }
+        if (mon >= num_mon) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "MPAM: MON_SEL %d out of range (max %d)\n",
+                          mon, num_mon - 1);
+            mpam_msc_inject_error(s, MPAM_ERRCODE_MONITOR_RANGE,
+                                  mon, 0, ris);
+            return;
+        }
         s->mon_sel = value & (R_MSMON_CFG_MON_SEL_MON_SEL_MASK |
                               R_MSMON_CFG_MON_SEL_RIS_MASK);
         return;
+    }
     case A_MSMON_CFG_MBWU_FLT:
+    {
+        uint32_t partid = FIELD_EX32(value, MSMON_CFG_MBWU_FLT, PARTID);
+
+        if (partid >= s->num_partid) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "MPAM: MBWU_FLT PARTID %d out of range\n", partid);
+            mpam_msc_inject_error(s, MPAM_ERRCODE_MSMONCFG_ID_RANGE,
+                                  partid,
+                                  FIELD_EX32(value, MSMON_CFG_MBWU_FLT, PMG),
+                                  FIELD_EX32(s->mon_sel, MSMON_CFG_MON_SEL,
+                                             RIS));
+            return;
+        }
         mpam_mbwu_mon(s, mpam_mon_ris(s))->flt = value;
         return;
+    }
     case A_MSMON_CFG_MBWU_CTL:
     {
         MpamMbwuMon *m = mpam_mbwu_mon(s, mpam_mon_ris(s));
@@ -1025,8 +1121,22 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
         return;
     }
     case A_MSMON_CFG_CSU_FLT:
+    {
+        uint32_t partid = FIELD_EX32(value, MSMON_CFG_CSU_FLT, PARTID);
+
+        if (partid >= s->num_partid) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "MPAM: CSU_FLT PARTID %d out of range\n", partid);
+            mpam_msc_inject_error(s, MPAM_ERRCODE_MSMONCFG_ID_RANGE,
+                                  partid,
+                                  FIELD_EX32(value, MSMON_CFG_CSU_FLT, PMG),
+                                  FIELD_EX32(s->mon_sel, MSMON_CFG_MON_SEL,
+                                             RIS));
+            return;
+        }
         mpam_csu_mon(s, mpam_mon_ris(s))->flt = value;
         return;
+    }
     case A_MSMON_CFG_CSU_CTL:
         mpam_csu_mon(s, mpam_mon_ris(s))->ctl = value;
         return;
-- 
2.43.0



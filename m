Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7D0CCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhak-0007pa-AT; Fri, 16 Oct 2026 09:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHf8x-0005M9-Le; Fri, 16 Oct 2026 06:26:31 -0400
Received: from out203-205-221-209.mail.qq.com ([203.205.221.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHf8v-0003ij-9A; Fri, 16 Oct 2026 06:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792146384; bh=1GpgKwB0bmpbKNIFXlk8Nx7covMNDnoFypQxv4WefDM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eE0kekHI09bll6jeFWRz0mEEi1VOAXBX25gVsr5SykVIzbVShW/2EaUF9FhdrTBR1
 73OLvkqIA+KHrK8UkGucpaP77cg88GozhsSsR6mZU//P4b3fv/zl5nrV+xdosiPM1z
 Q8Agu26gDkJhHLYl4LcJi9wifSdhkCUrbF5a1oyE=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
 id 695804A3; Fri, 16 Oct 2026 18:26:21 +0800
X-QQ-mid: xmsmtpt1792146381t42u9d0z1
Message-ID: <tencent_091C67ACF8A6E14D582142DD224A35CCC80A@qq.com>
X-QQ-XMAILINFO: MKFQA+k1yb/2+U2gT5C+lywAmskh+mPtHqAbT+VwO4j8zYBf0p6ixW66x9wAv/
 M/EiNpGODctEh1LTa0dlgWx/g7wKdAicjrsvaaE4Nx0fbcoS3i7bZl6U3SoJx9O3EsirhzDk4a+E
 az1cHVegUBk/l9DjtotNFtVyS7mo9/aM8CGiiZQCdXO3jFnOWT5ylwQ1KljZFjkr52bJ1gyhCIVT
 Ba0OdhX3lbvUz402Ghy9+YJRi8gtesWza8axrZoqUgYhCOe01SVIPSk9v9bllF03fn+H/sTSk7xM
 VIAXQvhkxEGalEw30I63j3MLxmYqcMXzf0aPRc/UsTbNLC8Jk17zw26tSJ1AcFYeSixqMB+sedUm
 ehQJk/PsbkLoFuONVGCvLW5RL4MQv6bEM+a8PowYw6DcAwPbI9Szocr8XY/KAReImrbvof34NcnV
 VuyymW9vVEgn+jF6y5G5PLAiVTe6sfPC3peYwc/VMarm0fipeKsyvAbw7CsIwPTD24GtiTG2lWUp
 gxdxvAa2AFp34grieagNkD0XfUD5h/qSqD0xq5rPGmbnd4ImLbftNOXhJdP0uYcyfUJg6uAnLp65
 gxKm+VwGZRt8fxMRqCn5vpc7sdU8XcLw785tWOOc5q2WMA7jlOSk+LZiiMj9wVss3QPthIatbXfu
 hG/M/NUiNEvGzLY0EW0Ic3Kg1yfsJKcTJ6fLhOJ65V/co09ZcCZUo6Y8lmkyyGm9TuBnEP8kuv+d
 pcdLSM/sXwCSzTrsWS77Oky3RgwelrEOlE4rOH2letfYpXTyAHiBe2E2NDQE2oe4GwGPGKk1H/O2
 fWvCd+RjJFHhimeBmBeHxgMSWDMP3JakAJV83RXASpMwPGn3P4OMjAh+zFQh8v5dL0gINf8BNWhs
 IrzWHcn2+0NoWo4pL+OmtYTtY/r5a8dPyy51ZrqbRIKOYBbs8rdvNIoqO916vLrk4nzUf8G303VG
 jRIqb7fa/TFLNO76jUofDW3EdWL+QbxQP4bJiuicJkipwfvOV1J1YKy06HRyXc4vCZ5C6BQA2lFF
 35gUMoAcblEuQXtGCdSDxAn3hUZRqf4aXhR9uayDFgMCVPApJVgjBY27p2rjMCxknUWg/89A==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 30/37] hw/arm/mpam: Handle ECR/ESR as MSC-global registers
Date: Fri, 16 Oct 2026 18:10:50 +0800
X-OQ-MSGID: <20261016101058.1900808-16-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016101058.1900808-1-2118537295@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.209; envelope-from=2118537295@qq.com;
 helo=out203-205-221-209.mail.qq.com
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

MPAMF_ECR and MPAMF_ESR are single per-MSC registers (IHI 0099
4.3), independent of the RIS selection, but the model stored them
per RIS.  Move the live copy to MSC level: ECR/ESR reads and the
extended ESR upper half (guarded on MPAMF_IDR.EXT) come from the
MSC-global view, ECR writes store masked and ESR writes deposit
into either half, and mpam_msc_sync_esr_ecr() keeps the per-RIS
export copies (used by the QMP introspection) in sync.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/mpam.c | 48 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
index 6c93ead..fe78adb 100644
--- a/hw/arm/mpam.c
+++ b/hw/arm/mpam.c
@@ -353,6 +353,14 @@ typedef struct MPAMMSCState {
     uint32_t num_csu_mon;
     uint64_t csu_capacity;
 
+    /*
+     * MPAMF_ECR / MPAMF_ESR are single per-MSC registers (IHI 0099 4.3),
+     * independent of the RIS selection.  The 64-bit ESR records the RIS
+     * the error was detected against in its top half.
+     */
+    uint32_t ecr;
+    uint64_t esr;
+
     /*
      * Wired-interrupt GSIVs the board assigned (INTID = SPI + 32).  Zero
      * means "no wired interrupt"; the ACPI MPAM table reports them as-is.
@@ -409,6 +417,20 @@ static uint32_t mpam_nrw_id_for(MPAMMSCState *s, Mpamf *mf, uint32_t partid)
     return intpartid % s->num_int_partid;
 }
 
+/*
+ * Keep the per-RIS copies in Mpamf (exported through the QMP/PPTT path)
+ * in sync with the MSC-level ECR/ESR view the MMIO handlers use.
+ */
+static void mpam_msc_sync_esr_ecr(MPAMMSCState *s)
+{
+    int i;
+
+    for (i = 0; i < s->num_ris; i++) {
+        s->mpamf[i].ecr = s->ecr;
+        s->mpamf[i].esr = (uint32_t)s->esr;
+    }
+}
+
 static Mpamf *mpam_mon_ris(MPAMMSCState *s)
 {
     unsigned ris = FIELD_EX32(s->mon_sel, MSMON_CFG_MON_SEL, RIS);
@@ -685,9 +707,16 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
     case A_MPAMF_ERR_MSI_ATTR:
         return mpamf->err_msi_attr;
     case A_MPAMF_ECR:
-        return mpamf->ecr;
+        return s->ecr;
     case A_MPAMF_ESR:
-        return mpamf->esr;
+        return s->esr;
+    case A_MPAMF_ESR + 0x4:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, EXT)) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected read of extended ESR\n");
+            return 0;
+        }
+        return s->esr >> 32;
     case A_MPAMF_CFG_PART_SEL:
         return mpamf->cfg_part_sel;
     case A_MPAMF_MPAMCFG_INTPARTID: {
@@ -975,7 +1004,20 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
                           "MPAM: Unexpected write to ECR Mask=%x Value=%lx\n",
                           MPAMF_ECR_WRITE_MASK, value);
         }
-        mpamf->ecr = value;
+        s->ecr = value & MPAMF_ECR_WRITE_MASK;
+        mpam_msc_sync_esr_ecr(s);
+        return;
+    case A_MPAMF_ESR:
+        /*
+         * Software clears an error by writing ERRCODE as zero; writing a
+         * non-zero ERRCODE activates the level error interrupt (8.2).
+         */
+        s->esr = deposit64(s->esr, 0, 32, value);
+        mpam_msc_sync_esr_ecr(s);
+        return;
+    case A_MPAMF_ESR + 0x4:
+        s->esr = deposit64(s->esr, 32, 32, value);
+        mpam_msc_sync_esr_ecr(s);
         return;
     default:
         qemu_log_mask(LOG_UNIMP,
-- 
2.43.0



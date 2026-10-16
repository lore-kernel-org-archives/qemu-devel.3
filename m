Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB35FCCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhaE-0007O7-GE; Fri, 16 Oct 2026 09:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>) id 1xHeXy-00066W-Nw
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:48:18 -0400
Received: from out162-62-57-49.mail.qq.com ([162.62.57.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>) id 1xHeXw-0007lE-1h
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792144088; bh=3CnT9kdTlSHd++88hWxgxba4/tcTn0GXZXLU8Jlv2O4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XSyUW2SpdX0rLxNGDjQnBhoLqTXNdhcaEQmf+QLs52ZjGlPzotOtS+Ux2B1uOOT6Y
 md/KI337fmtT1AuN3b6mKEKnEteprXLS7fUZgNqFkDswLmBgoncZw1P+4jcqSs/0/w
 NdS/SsgpxyeEYM/frfw5aIAEvTnX3Mreh3slEoMA=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id BF4A1837; Fri, 16 Oct 2026 17:47:52 +0800
X-QQ-mid: xmsmtpt1792144086tbe93o6yk
Message-ID: <tencent_9549CC801F23AD64A5614E042356DD964B0A@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNznS+EJIUUkXFuQYzhvkFBVNbVgcyZpjflCp2c/AsmbIzNWSPWX+d
 yFK6QHQYUN5JuySH2pHsuQCleU9eQY5qeJxCJ+bn09JFN8sJdwlA8ViFssmfro3KXnLrp4RNbBrx
 PZjjqdwJyOisAg3cmwqPV6mHubh8+g6R5ZK/94BbYWKftDUaYo4CdquwfM2OOc//GL9peKzQFAJp
 IOcOAwVtgTV59dnGn4lUx06v4iSVDHd+NmIAhAwW2sjYBt9s5aUY5Kdf4EsXzQNSHcsNDyeSWGb8
 07Y0/NCvXGCIWVKFCqE6xSx6KSeRGUZSkXxLNtod4L51WQJRbJ7jpzSezqwQR/Bv7Cgg/neKng+/
 SDXz3LDzj3UVIRrMM9rhLSRmqCmJYI1ulA6YVIcPkpqeogSX8TCvNBEqMkxFTv0ubk5epQknUOE0
 mgT12R2KJbhaPMfbNQoejdJ57XtNr5KYOlZdufRarDvc/sUGl+3mZH0AafCwIw5FLTxzP4LAHKcp
 +ha/S3VW1ZCpZpBHdFKAv5phkIYktzeWICVTHcRbSYB/Ejo5wVgdq/NTh+Qc0KeLh1M63i1Gpiv/
 l4EW6pvERyr5z+gmlKdkCiLBTq44/FFM+OgKyVAM5Y5r9zIjlLukBElJYOe2VPL6PykohkQHsIdu
 d/I+9QmyKbtQWjJTiayDAao79tPjHJSh2ciKJceWLyEIi2fmNXuyl3ob2P7rNLHP7VGk5GGZJz1S
 jVlsV4sZnlM9gj3TpIjtDQP2zux+EZPB9JLIslulbM2FLRebLUPLIS/oaz4xwtWeFsUnMFATmuZG
 wVa5r0BPrEjb88DNmzVHL+DgMIINTlWs5MoncKDGb0RDuUOa5nO+GITtLrxRh1MEIF9tWXFH2lU2
 Z7Dfhi5rs/eF+7GGWEk6eF4SJaIiZD+/6m+t3NA1W3r+hRrvJyzCF8Xi/K0wwT10djEQ5kl64xlg
 9ciAIsnEdc75kqTZ4pQsmdaevyuq9wyFk60DgjwG5rm0ZBk0ayG31mBLaegIaiHgii2Gcyd5hUnd
 FkBzx3zX0SfnuknVDzCTRkvAhMIGs9Wh4/vAMmtqHvk0ffySm3
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 12/37] hw/arm/mpam: Implement MBW bandwidth partitioning
Date: Fri, 16 Oct 2026 17:47:06 +0800
X-OQ-MSGID: <20261016094733.1898485-13-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016094733.1898485-1-2118537295@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.57.49; envelope-from=2118537295@qq.com;
 helo=out162-62-57-49.mail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:35 -0400
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

Add the memory-bandwidth controls: MPAMF_MBW_IDR (16-bit BWA_WD
fraction, MIN/MAX/PBM/PROP support, BWPBM_WD = MPAM_MBW_PART)
with HAS_MBW_PART on the memory subtype, and read/write handling
for MBW_MIN, MBW_MAX, MBW_PROP and the MBW_PBM bitmap per
selected internal PARTID.

Note the MBW_MIN write mask check references the CMIN mask --
a leftover fixed later by the CMIN/CASSOC patch.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/mpam.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
index 2b1401e..7c33ec4 100644
--- a/hw/arm/mpam.c
+++ b/hw/arm/mpam.c
@@ -363,6 +363,8 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
             return 0;
         }
         return mpamf->cpor_idr;
+    case A_MPAMF_MBW_IDR:
+        return mpamf->mbw_idr;
     case A_MPAMF_PARTID_NRW_IDR: {
         return mpamf->partid_nrw_idr;
     }
@@ -374,6 +376,12 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
         return mpamf->mbwumon_idr;
     case A_MPAMF_CFG_PART_SEL:
         return mpamf->cfg_part_sel;
+    case A_MPAMF_MPAMCFG_MBW_MIN:
+        return mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_min;
+    case A_MPAMF_MPAMCFG_MBW_MAX:
+        return mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_max;
+    case A_MPAMF_MPAMCFG_MBW_PROP:
+        return mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_prop;
     case A_MPAMF_MPAMCFG_CPBM0...
         (A_MPAMF_MPAMCFG_CPBM0 + ((MPAM_CACHE_PART + 31) / 32 - 1) * 4):
     {
@@ -387,6 +395,19 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
         array_offset = (offset - A_MPAMF_MPAMCFG_CPBM0) / sizeof(uint32_t);
         return mpamf->per_nrw_id[nrw_part_sel].cfg_cpbm[array_offset];
     }
+    case A_MPAMF_MPAMCFG_MBW_PBM0...
+            (A_MPAMF_MPAMCFG_MBW_PBM0 + ((MPAM_MBW_PART + 31) / 32 - 1) * 4):
+    {
+        uint32_t array_offset;
+
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MBW_PART)) {
+            qemu_log_mask(LOG_UNIMP,
+                "MPAM: Unexpected read of MBW_PBM with no MBW_PART support\n");
+            return 0;
+        }
+        array_offset = (offset - A_MPAMF_MPAMCFG_MBW_PBM0) / sizeof(uint32_t);
+        return mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_pbm[array_offset];
+    }
     default:
         qemu_log_mask(LOG_UNIMP,
                       "MPAM: Unexpected read of %lx\n", offset);
@@ -430,6 +451,30 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
         mpamf = &s->mpamf[s->ris];
         mpamf->cfg_part_sel = value;
         return;
+    case A_MPAMF_MPAMCFG_MBW_MIN:
+        if (value & ~MPAMF_MPAMCFG_CMIN_WRITE_MASK) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to CMAX Mask=%x Value=%lx\n",
+                          MPAMF_MPAMCFG_CMIN_WRITE_MASK, value);
+        }
+        mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_min = value;
+        return;
+    case A_MPAMF_MPAMCFG_MBW_MAX:
+        if (value & ~MPAMF_MPAMCFG_MBW_MAX_WRITE_MASK) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to MBW_MAX Mask=%x Value=%lx\n",
+                          MPAMF_MPAMCFG_MBW_MAX_WRITE_MASK, value);
+        }
+        mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_max = value;
+        return;
+    case A_MPAMF_MPAMCFG_MBW_PROP:
+        if (value & ~MPAMF_MPAMCFG_MBW_PROP_WRITE_MASK) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to MBW_PROP Mask=%x Value=%lx\n",
+                          MPAMF_MPAMCFG_MBW_MAX_WRITE_MASK, value);
+        }
+        mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_prop = value;
+        return;
     case A_MPAMF_MPAMCFG_CPBM0...
         (A_MPAMF_MPAMCFG_CPBM0 + ((MPAM_CACHE_PART + 31) / 32 - 1) * 4):
     {
@@ -445,6 +490,22 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
         mpamf->per_nrw_id[nrw_part_sel].cfg_cpbm[array_offset] = value;
         return;
     }
+    case A_MPAMF_MPAMCFG_MBW_PBM0...
+        (A_MPAMF_MPAMCFG_MBW_PBM0 + ((MPAM_MBW_PART + 31) / 32 - 1) * 4):
+    {
+        uint32_t array_offset;
+
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MBW_PART)) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to MBW_PBM when !HAS_MBW_PART\n");
+            return;
+        }
+        /* TODO: Figure out write mask to check this stays in write bits */
+        array_offset = (offset - A_MPAMF_MPAMCFG_MBW_PBM0) / sizeof(uint32_t);
+
+        mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_pbm[array_offset] = value;
+        return;
+    }
     default:
         qemu_log_mask(LOG_UNIMP,
                       "MPAM: Write to unexpected register Addr %lx Value=%lx\n",
@@ -522,6 +583,8 @@ static void mpam_msc_mem_realize(DeviceState *dev, Error **errp)
         /* We won't implement any implementation specific stuff */
         mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, NO_IMPL_PART, 1);
         mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, NO_IMPL_MSMON, 1);
+        /* Memory specific bit */
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_MBW_PART, 1);
 
         mpamf->iidr = FIELD_DP64(mpamf->iidr, MPAMF_IIDR, IMPLEMENTER,
                                  MPAM_IIDR_IMPLEMENTER);
@@ -533,6 +596,16 @@ static void mpam_msc_mem_realize(DeviceState *dev, Error **errp)
         mpamf->aidr = FIELD_DP64(mpamf->aidr, MPAMF_AIDR, ARCH_MINOR_REV, 1);
         mpamf->aidr = FIELD_DP64(mpamf->aidr, MPAMF_AIDR, ARCH_MAJOR_REV, 1);
 
+        mpamf->mbw_idr = FIELD_DP32(mpamf->mbw_idr, MPAMF_MBW_IDR, BWA_WD, 16);
+        mpamf->mbw_idr = FIELD_DP32(mpamf->mbw_idr, MPAMF_MBW_IDR, HAS_MIN, 1);
+        mpamf->mbw_idr = FIELD_DP32(mpamf->mbw_idr, MPAMF_MBW_IDR, HAS_MAX, 1);
+        mpamf->mbw_idr = FIELD_DP32(mpamf->mbw_idr, MPAMF_MBW_IDR, HAS_PBM, 1);
+        mpamf->mbw_idr = FIELD_DP32(mpamf->mbw_idr, MPAMF_MBW_IDR, HAS_PROP, 1);
+
+        mpamf->mbw_idr = FIELD_DP32(mpamf->mbw_idr, MPAMF_MBW_IDR, WINDWR, 0);
+        mpamf->mbw_idr = FIELD_DP32(mpamf->mbw_idr, MPAMF_MBW_IDR,
+                                    BWPBM_WD, MPAM_MBW_PART);
+
         if (s->num_int_partid < s->num_partid) {
             mpamf->partid_nrw_idr = FIELD_DP32(mpamf->partid_nrw_idr,
                                                MPAMF_PARTID_NRW_IDR,
-- 
2.43.0



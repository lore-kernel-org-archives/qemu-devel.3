Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D6ACCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhaG-0007SV-3r; Fri, 16 Oct 2026 09:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>) id 1xHeXx-00065p-Cc
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:48:17 -0400
Received: from out203-205-221-209.mail.qq.com ([203.205.221.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>) id 1xHeXv-0007lR-0G
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792144089; bh=XMLWzmJb/VELiyr9yAs14OIoFKaAF5VKvBCXpEgo478=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gm8mmPp3i7tgzgJD7fayVDUKsShw0tzRfqaAqbZxLziWDbQaFlQiBgi5o7wMP0IJB
 XMK1FPPlDrG2Gz7gxgaVwwr8f0Ef1jzj5Wdnlls0CMSVNvyP9Ry5kZAvh3U07Os7Rp
 KmXAjWSy3mkRWgCg+cJJBhY0ahuJRVaz5IaCcISY=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id BF4A1837; Fri, 16 Oct 2026 17:47:52 +0800
X-QQ-mid: xmsmtpt1792144087t0c4az0uj
Message-ID: <tencent_22716EE5A5A467448FFD5664D320278E1109@qq.com>
X-QQ-XMAILINFO: OATpkVjS499uRbsdK0rqHNxbIkuN45Ww2+o1yojN8nxiGBLG1WDBQ3w0cMHCw6
 P7YFYj5ZBHEkekEshf2IsKyQCEvLV5w+9yuSXRJuR9sOC3uLo+8qrZ2bC2oRGTrJhTK+XR54Gt4k
 kTQySHzJyZQSL4Gp7A8EcBFGoS1bNHICbrYnma5nIFgA7xZFty9ekHFFHXGmTymqKP/HDqnXQxdI
 TC0BEen9S486OEmaSi8L6mLOWLFN9bfNBgE3G3Ep34EAMkcONWJpIl4wLXSW99wykGd/whnWE7V6
 +SjuJXUKqMwNiY0XX0NddQ3c4fay8j0nNnDtJXSu2szwFpWLEcCpXCHTl8pPp3RoD+BwC4uZ0Utk
 VpB+63fJUPrB+IgSsnehN1ItrlJmsuzAwNp0HYQHRRSQMuT3ZkLJRL9tgSjH6FPRuygMrbFxij7w
 u2AfYJnq/gw4ZpHBayNqxcpetwPASR6GuDtX/fG9ZW8ch6iD2J2MFEgHyZZZSeJinEmQinPJCuau
 3H3ZjGfRpXZaSPbTBKnRVTNYUI/Z8j9LI0hh92dQE0YdwqdfyzOBpfG2hPYuMe9RnWPE0N7x2xwV
 DNAdrE1Ybtbq2niFcYXMhu9ZuiIV9tOXoiaqxMv1cX7Eb2sTzmjSCpcbGE/ZlLqnILasHpWlS8hb
 bAk1W3VCD+K7xu9ML2MQmfDhvSPtE0i17fX6pkVfSRIJqb3HmpdYhtOaF+SMcZqWoIniA4/3i6Nh
 o4aHIxpTCVU/V2qwKovDmxGOWEiQ/Zb8fcvuhI4J8joNjLHiwst+onRLMl1gpLU8jyiPrbXdslAT
 kFYiZZIBgHwqzvtZvGSk5/rwSinPsSHg5plxyu+rST/dMbEGP2tOUhkOUwpacxng/l9wd+CDLEYf
 iY9g5ffuBQEquoS1iO/tVO6k77IwIDgysN+W1o49pZvvOb51sNp5uLT2DFGR9emJkGV3OE1dVj6T
 Asae9jZtYc7Crk9GbIi4cSvtLI+inDUdBtRtxySvzYJMlzyFA8ucydkz9LM5QNavJOXM8ZmtGCfj
 +hu5MYaP4mLTJwU8a+/VMO1tNlRE42m3NAWuLrMGlz+iFDMmH99g6vlW2UxlPLgrllDOJJCQ==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 13/37] hw/arm/mpam: Implement PRI priority partitioning
Date: Fri, 16 Oct 2026 17:47:07 +0800
X-OQ-MSGID: <20261016094733.1898485-14-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016094733.1898485-1-2118537295@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
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
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:33 -0400
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

Add the priority controls: MPAMF_PRI_IDR advertises a 2-bit
INTPRI (0 = low) with no DSPRI, HAS_PRI_PART is set on the cache
subtype, and MPAMCFG_PRI is readable and writable per selected
internal PARTID, logging writes of DSPRI/INTPRI fields the IDR
does not implement.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/mpam.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
index 7c33ec4..94e517b 100644
--- a/hw/arm/mpam.c
+++ b/hw/arm/mpam.c
@@ -365,6 +365,13 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
         return mpamf->cpor_idr;
     case A_MPAMF_MBW_IDR:
         return mpamf->mbw_idr;
+    case A_MPAMF_PRI_IDR:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_PRI_PART)) {
+            qemu_log_mask(LOG_UNIMP,
+                "MPAM: Unexpected read of PRI_IDR with no PRI PART support\n");
+            return 0;
+        }
+        return mpamf->pri_idr;
     case A_MPAMF_PARTID_NRW_IDR: {
         return mpamf->partid_nrw_idr;
     }
@@ -380,6 +387,8 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
         return mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_min;
     case A_MPAMF_MPAMCFG_MBW_MAX:
         return mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_max;
+    case A_MPAMF_MPAMCFG_PRI:
+        return mpamf->per_nrw_id[nrw_part_sel].cfg_pri;
     case A_MPAMF_MPAMCFG_MBW_PROP:
         return mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_prop;
     case A_MPAMF_MPAMCFG_CPBM0...
@@ -467,6 +476,24 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
         }
         mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_max = value;
         return;
+    case A_MPAMF_MPAMCFG_PRI:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_PRI_PART)) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to CFG_PRI when !HAS_PRI_PART\n");
+        } else {
+            if (!FIELD_EX32(mpamf->pri_idr, MPAMF_PRI_IDR, HAS_DSPRI) &&
+                FIELD_EX32(value, MPAMF_MPAMCFG_PRI, DSPRI)) {
+                qemu_log_mask(LOG_UNIMP,
+                              "MPAM: Unexpected write to CFGP_PRI DSPRI when !HAS_DSPRI\n");
+            }
+            if (!FIELD_EX32(mpamf->pri_idr, MPAMF_PRI_IDR, HAS_INTPRI) &&
+                FIELD_EX32(value, MPAMF_MPAMCFG_PRI, INTPRI)) {
+                qemu_log_mask(LOG_UNIMP,
+                              "MPAM: Unexpected write to CFGP_PRI INTPRI when !HAS_INTPRI\n");
+            }
+        }
+        mpamf->per_nrw_id[nrw_part_sel].cfg_pri = value;
+        return;
     case A_MPAMF_MPAMCFG_MBW_PROP:
         if (value & ~MPAMF_MPAMCFG_MBW_PROP_WRITE_MASK) {
             qemu_log_mask(LOG_UNIMP,
@@ -648,6 +675,7 @@ static void mpam_msc_cache_realize(DeviceState *dev, Error **errp)
 
         /* Cache specific bit */
         mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_CPOR_PART, 1);
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_PRI_PART, 1);
         mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_PARTID_NRW,
                                 s->num_int_partid < s->num_partid);
 
@@ -665,6 +693,14 @@ static void mpam_msc_cache_realize(DeviceState *dev, Error **errp)
         mpamf->cpor_idr = FIELD_DP32(mpamf->cpor_idr, MPAMF_CPOR_IDR, CPBM_WD,
                                      MPAM_CACHE_PART);
 
+        /* Priority */
+        mpamf->pri_idr = FIELD_DP32(mpamf->pri_idr, MPAMF_PRI_IDR,
+                                    HAS_INTPRI, 1);
+        mpamf->pri_idr = FIELD_DP32(mpamf->pri_idr, MPAMF_PRI_IDR,
+                                    INTPRI_0_IS_LOW, 1);
+        mpamf->pri_idr = FIELD_DP32(mpamf->pri_idr, MPAMF_PRI_IDR,
+                                    INTPRI_WD, 2);
+
         if (s->num_int_partid < s->num_partid) {
             mpamf->partid_nrw_idr = FIELD_DP32(mpamf->partid_nrw_idr,
                                                MPAMF_PARTID_NRW_IDR,
-- 
2.43.0



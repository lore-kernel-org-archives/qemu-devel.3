Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A617CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhb1-0008Ci-Ed; Fri, 16 Oct 2026 09:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHf45-0004IP-W4; Fri, 16 Oct 2026 06:21:30 -0400
Received: from out162-62-57-137.mail.qq.com ([162.62.57.137])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHf42-0002u5-7T; Fri, 16 Oct 2026 06:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792146077; bh=RtkL6YEY12RdvEo3e18aXy7KhJJTC8uWBeG3mPS7ZXI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=uRTkw9aTAdC7X+O/xhvq1iuJIBGRAcKO9oK2hG4Ezev1NSuRhil8KrsmlkO26bWfu
 Twtfz4oMhBRmINHJrUHUxOIvN1Tomt+yyKLPFNie3rNHhhAD6/Ts7mx8OHi09i3Ujp
 zHfUVfzRz9sMDKUfajx9XeI3c8W5OuVgTU43x8Vk=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
 id 54EB0C9E; Fri, 16 Oct 2026 18:21:14 +0800
X-QQ-mid: xmsmtpt1792146074t5h5bnr16
Message-ID: <tencent_289D63BC15D4B4B4096744A65B7929B41907@qq.com>
X-QQ-XMAILINFO: MyzM/wvJS/656++GEj0F+2WCuEqf6u+Ne/sEwdfiEr9FieJvyjcODQMgqbtx5U
 TnhxTXOuV6/GDAe9zFV0ddJPfePZRYm26xDpO3H1/Mn0zp6WHs3oOjsaIaUhhrVI0mDvJ75BR5Gt
 W/loa56lvd38qIsOfHgEc2GuCwFsG97QK28TzDAdEXK3uUQSa7GCw7uKk19B9B/yF/vXq0+I1j8I
 Pp9CvPGMS1NA3SbejMVMnbHy7uDmHPrp5ltzfKh9q3YlhJT5ilWMYYR1uW/JKpfXYyi4OjoSpAP0
 vaXrUW4e5nKvejz7OtywfEmSyz4KUmvEI7iCZb0MSxI2ihd5wRzqFgpoTq9G9ikuhRCp9fNtJm4Y
 WoVGq9kVeDp/eJ4bFHpP8JotxNLTtMtRuT/fwEh6VP7SHX8c5jAUzrK/GNSY42cUzhfUfmoIWZRk
 A+xd3Osd/4zJXi5LzBsE9z286ze6h3Fjcj6aFHfp0JrYbXR5vCpVW/n3oqbEXCGpYPUrwD0BgEBw
 VwvLkZbaDU8QryDkPvTiRDQGrvJoOeIE/DdSYrqj/GSpYlNWOQXIQmNSM81684iqSSvSnVBoxGoL
 3VkvB2ozK3iUScQyIRWWLvmV5aiGo4HYSoID7wlVDR+sQ9Y4o9Frns8I4GT8uj4/+T39BzoWCStj
 Q7Hnzw2T0FGk7Vh0MkPmIpBzJ0SXVtwJ7OQKoEWTKxXotklzGPXwLNs/cKNHNy3kZqjOu/6Ip8XH
 OAixBRrR0eLkw1rfpX3xhdd2XDgGTs+rT4yqEex3Mvyc422VSr9LLx0fub88USS+4XKkAZTVLmea
 Lz7tMPl44zgrBWrv2P26W9OoAZtxvVnHtLoezmAIVAn3bQWcqheS2v3nr9zUAqdnN20gRbVvSQ1O
 li8IFwwIPp4AZXDnqKKQKg+Qh67BgyBfGVDCQnrFSgumWuTzGK5vTmypkPraahKfH5ggLhBR+pAb
 SrlgvDm0lXPLkYoOhq1KDynGnweHNEObOE3Eo9ccVwtY5zPXtxIgLjg7BXY/ovAeo/gMDGMl5nNE
 EALHCHmB4Chn/u8aCbtRZFnIVFlC2j9Ux29cgOanlzIcwkgbc7ItR+CoDM9T0g27IwWa2wcIoBh+
 QaK4Us
X-QQ-XMRINFO: MFuljud3PUW4Hy49K308V+nvGr8SioTB3Q==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 25/37] hw/arm/mpam: Emulate MBWU bandwidth monitoring
Date: Fri, 16 Oct 2026 18:10:45 +0800
X-OQ-MSGID: <20261016101058.1900808-11-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016101058.1900808-1-2118537295@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.57.137; envelope-from=2118537295@qq.com;
 helo=out162-62-57-137.mail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add the MBWU monitor: per monitor a lazily accumulated 64-bit
counter (value = base + rate x elapsed), where the rate is the
nominal bandwidth scaled by the bandwidth fraction of the filtered
PARTID.  The fraction follows whichever control the guest drives:
MBW_MAX, or the MBW_PBM bitmap (popcount over its width) that the
openEuler MBA resource programs instead, so monitor readings track
the configured bandwidth control.  The counter wraps at 48 bits,
latching the overflow status, and writing any counter register
resets it.

MSMON_IDR/MBWUMON_IDR now advertise the feature (num-mbwu-mon
monitors, 64-bit counters with read/write bandwidth) and
MPAMF_IDR reports HAS_MSMON on both subtypes, which lets resctrl
mount the MBM counters.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/mpam.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 127 insertions(+), 2 deletions(-)

diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
index 77e0277..610ae88 100644
--- a/hw/arm/mpam.c
+++ b/hw/arm/mpam.c
@@ -8,6 +8,9 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
+#include "qemu/timer.h"
+#include "qemu/host-utils.h"
+#include "qemu/bitops.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/registerfields.h"
@@ -404,6 +407,65 @@ static MpamMbwuMon *mpam_mbwu_mon(MPAMMSCState *s, Mpamf *mf)
     return &mf->mbwu_mons[mon];
 }
 
+/*
+ * Lazily advance the monitor's counter.  While enabled it accumulates
+ * the nominal bandwidth scaled by the MBW_MAX fraction of the PARTID
+ * the filter selects, so monitor readings track the configured
+ * bandwidth control.
+ */
+static uint64_t mpam_mbwu_value(MPAMMSCState *s, Mpamf *mf, MpamMbwuMon *m)
+{
+    uint64_t v = m->base;
+    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_HOST);
+    int64_t delta;
+
+    if (m->t0 == 0) {
+        m->t0 = now;
+    }
+    delta = now - m->t0;
+
+    if (FIELD_EX32(m->ctl, MSMON_CFG_MBWU_CTL, EN) && delta > 0) {
+        /* bw_nominal_bps is bytes/s; MBWU is modelled in bytes. */
+        uint64_t rate_mbs = s->bw_nominal_bps / 1000000;
+
+        if (FIELD_EX32(m->ctl, MSMON_CFG_MBWU_CTL, MATCH_PARTID)) {
+            uint32_t partid = FIELD_EX32(m->flt, MSMON_CFG_MBWU_FLT,
+                                         PARTID);
+            uint32_t nrw = mpam_nrw_id_for(s, mf, partid);
+            MpamfPerNrwId *cfg = &mf->per_nrw_id[nrw];
+            uint64_t frac_num, frac_den;
+
+            /*
+             * The kernel drives bandwidth through either MBW_MAX or,
+             * on classes that advertise MBW_PBM, the PBM bitmap
+             * (popcount of the programmed bits over its width).
+             */
+            if (cfg->cfg_mbw_pbm[0]) {
+                frac_num = __builtin_popcount(cfg->cfg_mbw_pbm[0] &
+                                     ((1u << MPAM_MBW_PART) - 1));
+                frac_den = MPAM_MBW_PART;
+            } else {
+                /* MBW_MAX is a 16-bit fraction; 0xffff = full bandwidth. */
+                frac_num = cfg->cfg_mbw_max & 0xffff;
+                frac_den = 0xffff;
+            }
+            rate_mbs = muldiv64(rate_mbs, frac_num, frac_den);
+        }
+
+        /* rate_mbs is MB/s; delta is ns, so /1000 yields bytes. */
+        v += muldiv64(delta, rate_mbs, 1000);
+        /* 48-bit counter wraps (MSMON_MBWU_L is 48 bits of value). */
+        if (v > (1ULL << 48)) {
+            m->oflow = true;
+            v &= (1ULL << 48) - 1;
+        }
+    }
+    m->base = v;
+    m->t0 = now;
+
+    return v;
+}
+
 typedef struct MPAMMSCMemState {
     MPAMMSCState parent;
 } MPAMMSCMemState;
@@ -511,6 +573,34 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
         }
         return ctl;
     }
+    case A_MSMON_MBWU ... (A_MSMON_MBWU + 3):
+    {
+        uint64_t v = mpam_mbwu_value(s, mpam_mon_ris(s),
+                                     mpam_mbwu_mon(s, mpam_mon_ris(s)));
+
+        return extract64(v, (offset - A_MSMON_MBWU) * 8, 32);
+    }
+    case A_MSMON_MBWU_L ... (A_MSMON_MBWU_L + 7):
+    {
+        uint64_t v = mpam_mbwu_value(s, mpam_mon_ris(s),
+                                     mpam_mbwu_mon(s, mpam_mon_ris(s)));
+
+        return extract64(v, (offset - A_MSMON_MBWU_L) * 8, 32);
+    }
+    case A_MSMON_MBWU_CAPTURE ... (A_MSMON_MBWU_CAPTURE + 3):
+    {
+        uint64_t v = mpam_mbwu_value(s, mpam_mon_ris(s),
+                                     mpam_mbwu_mon(s, mpam_mon_ris(s)));
+
+        return (uint32_t)v;
+    }
+    case A_MSMON_MBWU_CAPTURE_L ... (A_MSMON_MBWU_CAPTURE_L + 7):
+    {
+        uint64_t v = mpam_mbwu_value(s, mpam_mon_ris(s),
+                                     mpam_mbwu_mon(s, mpam_mon_ris(s)));
+
+        return extract64(v, (offset - A_MSMON_MBWU_CAPTURE_L) * 8, 32);
+    }
     case A_MPAMF_ERR_MSI_MPAM:
         return mpamf->err_msi_mpam;
     case A_MPAMF_ERR_MSI_ADDR_L:
@@ -746,6 +836,17 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
         }
         return;
     }
+    case A_MSMON_MBWU:
+    case A_MSMON_MBWU_L:
+    case A_MSMON_MBWU_CAPTURE:
+    case A_MSMON_MBWU_CAPTURE_L:
+    {
+        MpamMbwuMon *m = mpam_mbwu_mon(s, mpam_mon_ris(s));
+
+        m->base = 0;
+        m->t0 = qemu_clock_get_ns(QEMU_CLOCK_HOST);
+        return;
+    }
     case A_MSMON_CAPT_EVNT:
     case A_MSMON_CFG_CSU_FLT:
     case A_MSMON_CFG_CSU_CTL:
@@ -855,10 +956,22 @@ static void mpam_msc_mem_realize(DeviceState *dev, Error **errp)
 
         /* We won't implement any implementation specific stuff */
         mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, NO_IMPL_PART, 1);
-        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, NO_IMPL_MSMON, 1);
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_MSMON, 1);
         /* Memory specific bit */
         mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_MBW_PART, 1);
 
+        mpamf->msmon_idr = FIELD_DP32(mpamf->msmon_idr,
+                                      MPAMF_MSMON_IDR, MSMON_MBWU, 1);
+        mpamf->msmon_idr = FIELD_DP32(mpamf->msmon_idr,
+                                      MPAMF_MSMON_IDR, HAS_OFLOW_SR, 1);
+        mpamf->mbwumon_idr = FIELD_DP32(mpamf->mbwumon_idr,
+                                        MPAMF_MBWUMON_IDR, NUM_MON,
+                                        s->num_mbwu_mon);
+        mpamf->mbwumon_idr = FIELD_DP32(mpamf->mbwumon_idr,
+                                        MPAMF_MBWUMON_IDR, HAS_LONG, 1);
+        mpamf->mbwumon_idr = FIELD_DP32(mpamf->mbwumon_idr,
+                                        MPAMF_MBWUMON_IDR, HAS_RWBW, 1);
+
         mpamf->iidr = FIELD_DP64(mpamf->iidr, MPAMF_IIDR, IMPLEMENTER,
                                  MPAM_IIDR_IMPLEMENTER);
         mpamf->iidr = FIELD_DP64(mpamf->iidr, MPAMF_IIDR, REVISION, 0);
@@ -914,11 +1027,23 @@ static void mpam_msc_cache_realize(DeviceState *dev, Error **errp)
 
         /* We won't implement any implementation specific stuff */
         mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, NO_IMPL_PART, 1);
-        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, NO_IMPL_MSMON, 1);
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_MSMON, 1);
 
         /* Need to implement for RME */
         mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, SP4, 0);
 
+        mpamf->msmon_idr = FIELD_DP32(mpamf->msmon_idr,
+                                      MPAMF_MSMON_IDR, MSMON_MBWU, 1);
+        mpamf->msmon_idr = FIELD_DP32(mpamf->msmon_idr,
+                                      MPAMF_MSMON_IDR, HAS_OFLOW_SR, 1);
+        mpamf->mbwumon_idr = FIELD_DP32(mpamf->mbwumon_idr,
+                                        MPAMF_MBWUMON_IDR, NUM_MON,
+                                        s->num_mbwu_mon);
+        mpamf->mbwumon_idr = FIELD_DP32(mpamf->mbwumon_idr,
+                                        MPAMF_MBWUMON_IDR, HAS_LONG, 1);
+        mpamf->mbwumon_idr = FIELD_DP32(mpamf->mbwumon_idr,
+                                        MPAMF_MBWUMON_IDR, HAS_RWBW, 1);
+
         /* Cache specific bit */
         mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_CPOR_PART, 1);
         mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART, 1);
-- 
2.43.0



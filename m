Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2139CCF2C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhbK-0000aP-OL; Fri, 16 Oct 2026 09:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>) id 1xHeXy-00066k-Qg
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:48:19 -0400
Received: from out162-62-57-49.mail.qq.com ([162.62.57.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>) id 1xHeXw-0007ll-6h
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792144090; bh=3vYhGAIKKYn5YofW8KolAqXQsn7SxRlVZelFtJY0UFI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KWCCDJdg2xHPgygebWJsSVyGrEjXnJrJ3lhvFNU2+3MrwMDiLxz35YR0dijV3vY0+
 Z+8TB59lgaU5yWK1dpyOgygyClMq97ArKGTMJUzi8G+GtzXrAu1snZyAU6z81+bYmq
 Jswj9kzyEmcIT+xPOpnuOBwUfbx3Yw2GoK0OhHes=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id BF4A1837; Fri, 16 Oct 2026 17:47:52 +0800
X-QQ-mid: xmsmtpt1792144088t1c6ayxko
Message-ID: <tencent_BD96274E101F6E25A4DA661A8FB55764D209@qq.com>
X-QQ-XMAILINFO: OFArnyxfXusvJV/Rzv92LdpYiFfL5ZqrdnYccoVmwikk62Tjl1bgImInW6IdyP
 mxx6VIZ5kYbtOQ784/BrmWxmQ+fFiaclkJUF+bWFJdkeABzcXqZBEcaKWyOWlZm/DwJ420ZFz3VW
 A8huht3B8t5MT70hIcz9ogQOaD0h79ugZWmamJSum2da08vZuxx0/8Z8HSVMnJy1MK7zr6pQgjFo
 JklEhSdoheWITps+4CLmW+5hb5oONYS+FFh5VZB15RhvYpNapC8qq8mf4Xr432QXIyZu5ef1c8cc
 LPuhJ8SIab5gIhZsLqYGqS3Ptax3kR224GafhcHd5ZlLLQVBQ/VSBrRsIIbacF5XN4bQZmrF12Ro
 +jciTwRE2+WXC4RrcP5ouldGdZQBiMa3rYjG+cet6nQ1B8YGkSZesvE7Mdx2JX/5x4oVt7G3LxjU
 IEsCMaKfP3N351kyPAeSbjqM4TsD0nGWwRh3qu3rak7glM2WbRhVQIXJFma2dZi+TJhTVzZgCdT2
 d9sXAll8nY/vZNcQiy9gdkt4jd+JFEztjlWXAOc3ANhAszBFvwYVav2UE5menf4q+MCId4pZS82U
 dk2meWLCOy2T4irQXahKWShscjxfYF7qGywsf0y4ywys06u2wVct22jXtAXs0ICt6BUHPUSIbaEc
 0aeRN/HF21NY6LPFhW7ts/NhJpeE79ZxEIX9W4ai3Nvw4OKM7cqmqvqSsvy05RnshAJsFb9ssbam
 EWcwg+Ctghig+PjZuzisWSeEJnWoyk0cDdNw1J9TuJDxjKXdmdAGXwOJp2y/GvG9n5d74J167hh+
 WvikMkifKI/eO3hNAbUvr/ASQN0brWpkpCFNAyhwX/WKhfiX/KjSLu32QQ8chmAr6oJeUvMngZ3V
 kXZtZ0mrCAYs5Q/H/m0NcAXgFVTruMUrDDEFWlYW8ppuVfIQmd8LZzOHbFfMULud7EoWaUBWmUTY
 PdcJ0MeARfSeFwQoI745b69SQoGIdJE9xWJIZIRTZxswxgbm9YyMPJ3of1Mg4SR9MX4ea243WsOq
 M8i+d2JVHLQycfSsgFpOFjg7wU+iazFkAYqZXhMr71g1Pvt+0Jgqdthi0BgQNw8tzzMp2a+rZfzr
 xfvzJXZ+x09WpOo5JD0DmS8zcTyw==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 14/37] hw/arm/mpam: Implement CCAP capacity partitioning
Date: Fri, 16 Oct 2026 17:47:08 +0800
X-OQ-MSGID: <20261016094733.1898485-15-2118537295@qq.com>
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
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:37 -0400
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

Add the cache-capacity controls: MPAMF_CCAP_IDR (4-bit CMAX/CASSOC
band widths, HAS_CMIN/HAS_CASSOC advertised ahead of their storage,
CMAX soft-limit support) with HAS_CCAP_PART on the cache subtype,
and read/write handling for MPAMCFG_CMAX per selected internal
PARTID, guarded on CCAP support.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/mpam.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
index 94e517b..fafe74f 100644
--- a/hw/arm/mpam.c
+++ b/hw/arm/mpam.c
@@ -363,6 +363,13 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
             return 0;
         }
         return mpamf->cpor_idr;
+    case A_MPAMF_CCAP_IDR:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART)) {
+            qemu_log_mask(LOG_UNIMP,
+                "MPAM: Unexpected read of CCAP_IDR with no CCAP support\n");
+            return 0;
+        }
+        return mpamf->ccap_idr;
     case A_MPAMF_MBW_IDR:
         return mpamf->mbw_idr;
     case A_MPAMF_PRI_IDR:
@@ -383,6 +390,13 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
         return mpamf->mbwumon_idr;
     case A_MPAMF_CFG_PART_SEL:
         return mpamf->cfg_part_sel;
+    case A_MPAMF_MPAMCFG_CMAX:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART)) {
+            qemu_log_mask(LOG_UNIMP,
+                "MPAM: Unexpected read of CMAX with no CCAP support\n");
+            return 0;
+        }
+        return mpamf->per_nrw_id[nrw_part_sel].cfg_cmax;
     case A_MPAMF_MPAMCFG_MBW_MIN:
         return mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_min;
     case A_MPAMF_MPAMCFG_MBW_MAX:
@@ -460,6 +474,14 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
         mpamf = &s->mpamf[s->ris];
         mpamf->cfg_part_sel = value;
         return;
+    case A_MPAMF_MPAMCFG_CMAX:
+        if (value & ~MPAMF_MPAMCFG_CMAX_WRITE_MASK) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to CMAX Mask=%x Value=%lx\n",
+                          MPAMF_MPAMCFG_CMAX_WRITE_MASK, value);
+        }
+        mpamf->per_nrw_id[nrw_part_sel].cfg_cmax = value;
+        return;
     case A_MPAMF_MPAMCFG_MBW_MIN:
         if (value & ~MPAMF_MPAMCFG_CMIN_WRITE_MASK) {
             qemu_log_mask(LOG_UNIMP,
@@ -675,6 +697,7 @@ static void mpam_msc_cache_realize(DeviceState *dev, Error **errp)
 
         /* Cache specific bit */
         mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_CPOR_PART, 1);
+        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART, 1);
         mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_PRI_PART, 1);
         mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_PARTID_NRW,
                                 s->num_int_partid < s->num_partid);
@@ -701,6 +724,20 @@ static void mpam_msc_cache_realize(DeviceState *dev, Error **errp)
         mpamf->pri_idr = FIELD_DP32(mpamf->pri_idr, MPAMF_PRI_IDR,
                                     INTPRI_WD, 2);
 
+        /* Capacity Partitioning */
+        mpamf->ccap_idr = FIELD_DP32(mpamf->ccap_idr, MPAMF_CCAP_IDR,
+                                     HAS_CMAX_SOFTLIM, 1);
+        mpamf->ccap_idr = FIELD_DP32(mpamf->ccap_idr, MPAMF_CCAP_IDR,
+                                     NO_CMAX, 0);
+        mpamf->ccap_idr = FIELD_DP32(mpamf->ccap_idr, MPAMF_CCAP_IDR,
+                                     HAS_CMIN, 1);
+        mpamf->ccap_idr = FIELD_DP32(mpamf->ccap_idr, MPAMF_CCAP_IDR,
+                                     HAS_CASSOC, 1);
+        mpamf->ccap_idr = FIELD_DP32(mpamf->ccap_idr, MPAMF_CCAP_IDR,
+                                     CASSOC_WD, 4); /* Not much flex on this */
+        mpamf->ccap_idr = FIELD_DP32(mpamf->ccap_idr, MPAMF_CCAP_IDR,
+                                     CMAX_WD, 4);
+
         if (s->num_int_partid < s->num_partid) {
             mpamf->partid_nrw_idr = FIELD_DP32(mpamf->partid_nrw_idr,
                                                MPAMF_PARTID_NRW_IDR,
-- 
2.43.0



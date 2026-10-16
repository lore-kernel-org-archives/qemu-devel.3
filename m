Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAE1CCF2C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhbI-0000XY-Lk; Fri, 16 Oct 2026 09:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHf50-0004ft-Sf; Fri, 16 Oct 2026 06:22:26 -0400
Received: from out203-205-221-149.mail.qq.com ([203.205.221.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHf4y-00033c-4m; Fri, 16 Oct 2026 06:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792146139; bh=y/RBAlSCh9zMEN28g7qg1jlC0rjSzUH/G7Hw96xdDRs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dVumTicQ4Uq5tW70uhfel5vsl6OTa2xmed/UqE+e++/Idx0hVWRRJkLtjwn6+eQxB
 4FaiRQ89gmx010cDeMhRDd3VcMSZr52nTTWznzP6i0QVAJEo94MRknEHaIGTYw0zGk
 Q4qxhDvfHBhNF13Z72Q0O0uC+HVbR5fiZQpc7N10=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
 id 5902369E; Fri, 16 Oct 2026 18:22:16 +0800
X-QQ-mid: xmsmtpt1792146136twqecr64s
Message-ID: <tencent_F831FACA6B5AD20402E2C3ED9594C28CD806@qq.com>
X-QQ-XMAILINFO: OXZEp4Z5NI29ihMuTY6xOYMu/8lQAzXlTwUxEVy+cJQvQa57Iayp7LP94K+ODU
 8u53urp3da8976D5JM0tBfHazbRqIrMFHFsUcF/pXOPjvajOLOTH8MuMT5BNHUcY7VbXpLYm8rfg
 UgEZhr2t76/cV9wAa3NIjjfOnEOEboOQF0T5kRfUzX9THJgMzyrBLCjU453XL8BwSTRQY5qrPaYW
 MO6gKZqOulbXbFUDm6FRUOFE3h7CP4o4glziUq6f8GwPxDlhDhYmO4XW9fpZELctX9oxOvG5XI6l
 yzmYwHHC3itH38GvtzaFG5auH/tB01ZoNh1K67r3fDep8zR17YPWDYUp76clWAGsH5QVj6r2NTss
 XMoFY3/ZsQDpRQlO8soAsDEhwdNNCDPlPCVyeBed1oOOk0OYgnpYMrjz//J+UnxERc0AeAB0UStV
 PPfKoW1xfQIIzf78Kb4P9C0X8dCav2iYzBzcf0bVr+f5uAQWTvTjIIjq1t11H1gUlKpc7SkTL9Cm
 Oe1Yl005au1CzhX+P067Q2IaaCssB4bzv6jenwZSu1drzbj63UX8EqFeBraz1T2h8E1Dz32cKnyf
 aJG7I4+UDYDLeqhqcpYQHzCiPyRxx1y5BzsPDVYzdJGamkzK20y03kqd6AawugYEkG7WUl1oOJFl
 EFxIqxQsteQJJFxHXkFseyTCtHCc7uvahSqIycxGztmPyVMsHkhMfP5lIBYVv92+jUEIWSiDFfZ4
 6D7V5bx7ZpTKrjeXR/HixsMSqax36ztHXaQ9cTYKrCUoMWHJue3F3mUyVAe0+IjW+9SYbEESVlKl
 P7b11KJ4ehrpheQhgCLyLpn99TZAe2qfgkBApx91IO7Is/xLVy4utWOSe6pWLpq0l/fLsPKliaog
 Jjhu20A1OJ6imuBiAZzfq3lRKf5xnsOZmUYy8JqwKaeEG03oyyX/awubfkkPtKJAIFQZYUk+myuo
 +g2U+ISsCXIzxzlVyfq5lQ3RxfmPf9QhLbYZIPwvV729pu4FWGN6U4xXzwGvg4DzInAjwAdbHn08
 eC5KGjNz9MRM2w/3SrvvCLVPdayFLpdR13Nyqic07zmMZB2Ivnzj+FBk86kSeAMCL83CElDQ==
X-QQ-XMRINFO: MFuljud3PUW4Hy49K308V+nvGr8SioTB3Q==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 26/37] hw/arm/mpam: Implement CMIN/CASSOC storage
Date: Fri, 16 Oct 2026 18:10:46 +0800
X-OQ-MSGID: <20261016101058.1900808-12-2118537295@qq.com>
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

MPAMF_CCAP_IDR advertised HAS_CMIN/HAS_CASSOC (since the CCAP
patch) but the MPAMCFG_CMIN and MPAMCFG_CASSOC registers had no
storage or read/write cases, so L2MIN/L3MIN schemata values were
dropped and read back as 0.  Add the per-internal-PARTID storage
and read/write handling, both guarded on CCAP support.

Also fix the MBW_MIN write mask check, which referenced the CMIN
mask (and logged it as "CMAX") since the device model was
introduced.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/mpam.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
index 610ae88..1bd76ba 100644
--- a/hw/arm/mpam.c
+++ b/hw/arm/mpam.c
@@ -260,6 +260,8 @@ typedef struct MpamfPerNrwId {
         uint32_t cfg_mbw_pbm[(MPAM_MBW_PART + 31) / 32];
         uint32_t cfg_pri;
         uint32_t cfg_cmax;
+        uint32_t cfg_cmin;
+        uint32_t cfg_cassoc;
         uint32_t cfg_mbw_min;
         uint32_t cfg_mbw_max;
         uint32_t cfg_mbw_prop;
@@ -635,6 +637,20 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
             return 0;
         }
         return mpamf->per_nrw_id[nrw_part_sel].cfg_cmax;
+    case A_MPAMF_MPAMCFG_CMIN:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART)) {
+            qemu_log_mask(LOG_UNIMP,
+                "MPAM: Unexpected read of CMIN with no CCAP support\n");
+            return 0;
+        }
+        return mpamf->per_nrw_id[nrw_part_sel].cfg_cmin;
+    case A_MPAMF_MPAMCFG_CASSOC:
+        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART)) {
+            qemu_log_mask(LOG_UNIMP,
+                "MPAM: Unexpected read of CASSOC with no CCAP support\n");
+            return 0;
+        }
+        return mpamf->per_nrw_id[nrw_part_sel].cfg_cassoc;
     case A_MPAMF_MPAMCFG_MBW_MIN:
         return mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_min;
     case A_MPAMF_MPAMCFG_MBW_MAX:
@@ -746,12 +762,28 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
         }
         mpamf->per_nrw_id[nrw_part_sel].cfg_cmax = value;
         return;
-    case A_MPAMF_MPAMCFG_MBW_MIN:
+    case A_MPAMF_MPAMCFG_CMIN:
         if (value & ~MPAMF_MPAMCFG_CMIN_WRITE_MASK) {
             qemu_log_mask(LOG_UNIMP,
-                          "MPAM: Unexpected write to CMAX Mask=%x Value=%lx\n",
+                          "MPAM: Unexpected write to CMIN Mask=%x Value=%lx\n",
                           MPAMF_MPAMCFG_CMIN_WRITE_MASK, value);
         }
+        mpamf->per_nrw_id[nrw_part_sel].cfg_cmin = value;
+        return;
+    case A_MPAMF_MPAMCFG_CASSOC:
+        if (value & ~MPAMF_MPAMCFG_CASSOC_WRITE_MASK) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to CASSOC Mask=%x Value=%lx\n",
+                          MPAMF_MPAMCFG_CASSOC_WRITE_MASK, value);
+        }
+        mpamf->per_nrw_id[nrw_part_sel].cfg_cassoc = value;
+        return;
+    case A_MPAMF_MPAMCFG_MBW_MIN:
+        if (value & ~MPAMF_MPAMCFG_MBW_MIN_WRITE_MASK) {
+            qemu_log_mask(LOG_UNIMP,
+                          "MPAM: Unexpected write to MBW_MIN Mask=%x Value=%lx\n",
+                          MPAMF_MPAMCFG_MBW_MIN_WRITE_MASK, value);
+        }
         mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_min = value;
         return;
     case A_MPAMF_MPAMCFG_MBW_MAX:
-- 
2.43.0



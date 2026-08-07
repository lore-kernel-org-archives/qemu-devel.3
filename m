Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1C4C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 12:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsJPa-0007DZ-Fj; Fri, 07 Aug 2026 08:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sesame_h@qq.com>)
 id 1wsGlg-0002pX-UP; Fri, 07 Aug 2026 05:21:33 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sesame_h@qq.com>)
 id 1wsGlb-0004sn-SB; Fri, 07 Aug 2026 05:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1786094477; bh=/V9XKLdZoAqVa9Z+dLVGe8pdE0XqgbtmdETvCkf9dJM=;
 h=From:To:Cc:Subject:Date;
 b=LHuouiMq7X3z3V6eQINT9IwmfsLREceKF3shp9pcn+l1hAVxCMCyH2798dKg0wXBf
 Fi2Bv15cqJHj44nLww6MLCvxm1RIlQKgul27M3DllC7vbfsnFp3g41AollHGZbEH3t
 nMVXfMyrggSwPC6SAZ+Lyr6Alsvp4RopXksHwTGM=
Received: from minhang-zhang-KVM.. ([116.128.244.169])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id 46D84CF3; Fri, 07 Aug 2026 17:17:45 +0800
X-QQ-mid: xmsmtpt1786094265tl09zp79k
Message-ID: <tencent_8A3172131A5ED2AD86D441389EB32CF67809@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLakVX+Cr8LghSKDRbV81B8r7D2V0SJzKfjqJ2V/csIAQ8jpDDPH
 WsrDPCuijsyoSHwqReFj0a3+GYq9qvpDpRFRUAwDcj5SZMExyH8Oat8x5SemSyMq8TKx2NYBAYUd
 wjAn/KgcoOaoqTZnUfpRLbnl5RHuo4ypx47bPZajYq10iFTc6c1248+t1TP5mzqgiT7wDsZtaDQp
 nSxTaoq+bIievYi1peTPVeNVEoGXv4UN4JWpavzzDBCYHopXR2KARBVH35y4b8h5ijaI8Vx+kps3
 cFcgJRb97ZBGfEKEZlR4USfwi//gjqHTQzNRLhaW5cm7f+VQinS2uVwnO/unSZRPL3O4t3bLMZdW
 GsYYjYsbSzAW+QCxmlVc/sBdd+krnUzLxl1wRN+/xQ7gh6ZyTXqFHUagCdr1mdNGckysVrlPN2Lg
 bcyXzYOA8b9zM1d1gCk1ABRgZKFhuGKtXNm+hrJzaYXYye+9YgnfbLpeG+A14uD8LtfxlAcjz3xb
 8B/KHuaCyEnO7IEjO0QYXGvbnyI9OlwdF/QJiRX9sK37+LIEMpyO8AiMG/R+wY/U+IUY/3kmjRCh
 Rd6+r9SvPOSVt/orzHF5URX86NftoFx1xGL66fGRCeQVNwCG52heqSIlVLlz/J3c1qb8n57qZ7ZD
 POQrJ26Fa+j4uxPA9j6XR6zZmgB+/NKXfpKqtiNGlJ2Nui2O3iwCVyEBZpw7CRUkP5Elpyut4Qu1
 xwdkTx5EKS5Qgvvnl9teV8P+3nUQel+vz3LYJho9M1vLNKSXJUciSQxYe4plJdP4CQGyssxnPQZP
 WdtdKAwpTsNXQ5qrd59jP6fHd+KAtIM4uMVb6Gq9fPm9E2bgD5PVPv6JmV1IwT633N6w4yWTcNXo
 kXlgo69xvqjf7pkVuCEEqCcZOL6Z7WNmRjSQZ+wxTg45KXFKFaYtu/O2GlSChbfZgt7rmyxFMuge
 iMHTrTk4+O7MKzW/bKnJ7IJDyoEvZ98p5pE8qN3KQomx1BxPYbJ/jvcF/S4BSXckrmHnNaDF8=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: sesame_h@qq.com
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, harshpb@linux.ibm.com, rathc@linux.ibm.com,
 Minhang Zhang <zhangminhang@kylinos.cn>
Subject: [PATCH] target/ppc: Validate HTABMASK and reserved bits in SDR1 for
 32-bit mode
Date: Fri,  7 Aug 2026 17:17:35 +0800
X-OQ-MSGID: <20260807091735.17019-1-sesame_h@qq.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.50; envelope-from=sesame_h@qq.com;
 helo=xmbghk7.mail.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 07 Aug 2026 08:10:51 -0400
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

From: Minhang Zhang <zhangminhang@kylinos.cn>

ppc_store_sdr1() had validation for 64-bit SDR1 values but lacked
corresponding checks for the 32-bit case.  According to the Power ISA,
in 32-bit mode SDR1 bits 16-22 are reserved (must be zero) and
HTABMASK (bits 23-31) must consist of a consecutive string of
1-bits starting from the LSB, i.e., be of the form 2^n-1.

Add checks to reject invalid HTABMASK values and log a guest error
for non-zero reserved bits, following the same pattern used by the
existing 64-bit validation.

Signed-off-by: Minhang Zhang <zhangminhang@kylinos.cn>
---
 target/ppc/mmu_common.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 2499e61..59e8324 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -57,9 +57,23 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
                      " stored in SDR1", htabsize);
             return;
         }
-    }
+    } else
 #endif /* defined(TARGET_PPC64) */
-    /* FIXME: Should check for valid HTABMASK values in 32-bit case */
+    {
+        target_ulong htabmask = value & SDR_32_HTABMASK;
+        if (value & 0x007F0000UL) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Invalid SDR1: reserved bits 0x" TARGET_FMT_lx
+                          " set\n", value & 0x007F0000UL);
+            value &= ~0x007F0000UL;
+        }
+        if ((htabmask & (htabmask + 1)) != 0) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Invalid HTABMASK 0x" TARGET_FMT_lx
+                          " in SDR1 (must be of form 2^n-1)\n", htabmask);
+            return;
+        }
+    }
     env->spr[SPR_SDR1] = value;
 }
 
-- 
2.43.0



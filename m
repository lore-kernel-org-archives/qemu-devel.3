Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB350C5B572
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 09:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuoCk-0003Hl-4W; Fri, 14 Aug 2026 05:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sesame_h@qq.com>)
 id 1wuoCh-0003Gr-DE; Fri, 14 Aug 2026 05:27:56 -0400
Received: from out162-62-58-216.mail.qq.com ([162.62.58.216])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sesame_h@qq.com>)
 id 1wuoCe-0003rR-Eq; Fri, 14 Aug 2026 05:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1786699662; bh=O0lDOfouMdo8i2BuxKzy9r8LJlvLyh+vzzzpsTcJAD4=;
 h=From:To:Cc:Subject:Date;
 b=Skc1vH+SGQ0Dv1OMSUS8S0T5/GqMRBIkFCLcbTIMkNxrpyH0e40QDbRUd7Lgowkqx
 1AKzn+ktEuDeuCWZ9iEgDaN4xPtT+63LIm9WSqARIE/o8O5E9xOnwPbpLY9Up6GC+B
 VKIPkqPk6KmzT3D/+IeJo/AaFtFZGwdDVWg81yFQ=
Received: from minhang-zhang-KVM.. ([116.128.244.169])
 by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
 id 6D616A0C; Fri, 14 Aug 2026 17:27:22 +0800
X-QQ-mid: xmsmtpt1786699642tviz1w3mr
Message-ID: <tencent_8388D4B38DC5172F5EEE70436D3AD6D02006@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GxvR7LcNe/OOOrsJ9xoLCObJZ6vdAfRcMKMpNyzh2DnyS8xcCM3
 b9omLIUad0anYxWUA4QRFCS4NWOf7elFsLDx/HrflW2TR8PaZQ5YG9OSIlcMCsYI8kS4vCJB71Sv
 sOfsJKiFgOoQSgC3rhN7wIjIvLdKGU+Fyw5DWO41Og9iklxbri6h8/1x4G7BHUth+5RKjf1aSiSt
 cRl34rtP80tYTaidWNpInSGIYy1jdH/gAjBpjX2ts/Z4sDUBNhzrEJpY9t7PFlmUWR0SKCQxUJ4A
 ZNX0MZsSUHIE7hPL+BuIUd5YxJteYmJLEGdNAgXyXkKJOqMDmIGYqC11suYeJjPWUjtQmfGGZ6jy
 41by7fRl7r1cSlBcSQNtTNZDMIRBFQdZw7iNaGyTJ9GIcYpyhJp34Da07etInXYPAxEnRVuDng/T
 Rv0NgnWQy7WgsrsvMjb0MrrQjLKixkz/pz3LcB++WWpjZ7JKGSKD6bZ1dxesy/jji4/YJgPJmDgu
 FUrXtNk9KJxe0bYHIbg/5dvYl2inj8odyMNcJbB6VzCoC7h3mJmce6qqkwYAnn4ot5z/NbW0QVdJ
 PP73v++y4WLRscGxLmPvIrPbFfYcNXEH2g/jzHuYbwLb0GdxSHydmNDNpbrja+ZwVPf3o9sopio4
 gPjsyh1tf1op8Da+KMESJPkiv8XLcIgZymVIbxtl+yYNO1G/toTPRQ3NDuZBbNtU227aLz9vbkLk
 3tUB/zQGS8q9xkoLwuuHRd3per6LLU+RbSeN6aQC9IvKGEcywqneyavt2bTV9x4FuyFxuB7kzc63
 xVtgCtKZrXsJ43bWB8u9Jbs+tu5hTXjevyJ/cMDkTt4U+VwC7o9+u+XcJvsdUgDt+2V9r8jlHnbT
 R/SHi4FarvkOyoN3utCX6di6uO6JcYZw3qeG3oSRXZv6329SFeiSKTRPzI1UJkyBWVxVWRgdZa3G
 idmkEdMmOBov/Bo9DWzGCG6vVruNB/Bz4SAtXi1IWWV1EPnJ+ATD/7TDvuY4+WiW6GbIewxnqW+d
 hed/+JgVe4HLVuClFNUDkqbd01ZEyh8G+vgAVViks/54OAzl7f2l9MPcUBcds=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: sesame_h@qq.com
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Cc: npiggin@gmail.com, adityag@linux.ibm.com, milesg@linux.vnet.ibm.com,
 harshpb@linux.ibm.com, Minhang Zhang <zhangminhang@kylinos.cn>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v4] target/ppc: Validate HTABMASK and reserved bits in SDR1
 for 32-bit mode
Date: Fri, 14 Aug 2026 17:26:32 +0800
X-OQ-MSGID: <20260814092632.48390-1-sesame_h@qq.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.58.216; envelope-from=sesame_h@qq.com;
 helo=out162-62-58-216.mail.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HELO_STATIC_HOST=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
Signed-off-by: Minhang Zhang <zhangminhang@kylinos.cn>
---
 target/ppc/mmu_common.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 2499e61..2a36817 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -42,24 +42,39 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
     PowerPCCPU *cpu = env_archcpu(env);
     qemu_log_mask(CPU_LOG_MMU, "%s: " TARGET_FMT_lx "\n", __func__, value);
     assert(!cpu->env.has_hv_mode || !cpu->vhyp);
-#if defined(TARGET_PPC64)
     if (mmu_is_64bit(env->mmu_model)) {
+#if defined(TARGET_PPC64)
         target_ulong sdr_mask = SDR_64_HTABORG | SDR_64_HTABSIZE;
         target_ulong htabsize = value & SDR_64_HTABSIZE;
 
         if (value & ~sdr_mask) {
             qemu_log_mask(LOG_GUEST_ERROR, "Invalid bits 0x"TARGET_FMT_lx
-                     " set in SDR1", value & ~sdr_mask);
+                     " set in SDR1\n", value & ~sdr_mask);
             value &= sdr_mask;
         }
         if (htabsize > 28) {
             qemu_log_mask(LOG_GUEST_ERROR, "Invalid HTABSIZE 0x" TARGET_FMT_lx
-                     " stored in SDR1", htabsize);
+                     " stored in SDR1\n", htabsize);
             return;
         }
-    }
 #endif /* defined(TARGET_PPC64) */
-    /* FIXME: Should check for valid HTABMASK values in 32-bit case */
+    } else {
+        target_ulong sdr_mask = SDR_32_HTABORG | SDR_32_HTABMASK;
+        target_ulong htabmask = value & SDR_32_HTABMASK;
+
+        if (value & ~sdr_mask) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Invalid bits 0x" TARGET_FMT_lx
+                          " set in SDR1\n", value & ~sdr_mask);
+            value &= sdr_mask;
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



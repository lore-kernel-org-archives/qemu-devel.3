Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F108C5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 03:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuiOp-0002HH-67; Thu, 13 Aug 2026 23:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sesame_h@qq.com>)
 id 1wuiOk-0002Gf-TG; Thu, 13 Aug 2026 23:15:59 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sesame_h@qq.com>)
 id 1wuiOh-0001Bt-OF; Thu, 13 Aug 2026 23:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1786677334; bh=ZvqiNnhJLzVfV4ZDQ//KWrQGj+NR+ZoObKuFv8dT4ww=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KiThw1MTa20VVMDiOYh51zixV/v/V+Mwbqa8/V9zpYjO5/+9keResBygMxmAO+Q+G
 ExzyswmEMTbL/GLkjdVnExPlEXrm5oQDojikfxXQkEW2uoK07GY88EjknM/KWL+BfW
 hRZi+17KDLT3mf0Ba+3qVklB+64km6VKeHFlJx0c=
Received: from minhang-zhang-KVM.. ([116.128.244.169])
 by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
 id 1B614215; Fri, 14 Aug 2026 11:06:54 +0800
X-QQ-mid: xmsmtpt1786676814tz73bneu8
Message-ID: <tencent_1240029E1F2CBA785372451BC8D2A7869409@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLVMEIrSeVwEM8ASXUoApwbsluxKtw9jqI5lgvi2oGUb7meWTtmQ
 WdW6xTSkmtdQswq1/CetjysOQU5MUrJd6e+1CKs8+I1dZexEw5BvS4+a0c1pqBOTEWU7QpmQW6g7
 ut8ORA32gyEl31GUzDtJOnVq1ljZUin/muZJe7z40fHbpS705dj9IigjhqwORZ9SBvr2wi4yFefl
 xVD/3VpFFqGbp6Cn1dEOlZHHBI0CfHg1BsD4lTxkdzfscw/Q8Q9pOgFP8+rqYCPmWiRMPO79d4Mh
 aOPD8zpHaxmLylAQIHkPMDEiokR4tRSMTobDwBmb25BE4u/kcv0RozLWtnXabxyVhxpYrTszPkTR
 9WwWVDONpTT7sxum6eUgN2r28t9j/ZQThvYezak+l5eDTxCUY6NpqdyO9PU8UGkcij7scpvuneOj
 8tKUhbPRkzx+G3UvRPcXvOHLv3PNaP5yd+gfHdHD50ttfBNo7sdOPbnYs/hObn6RN98alhDYbmi7
 7Aci4ItzJYipsoBCDvSIRXYbgB91YfXQOnKtEvqEgSJyekSQ8/5EgAyJZkVCOcRZJRXK6ZFrEZJE
 tJDcwxf7W06jLh/16hvG0CsbXlKoYkYrntKRhDv+wbaZM3ZiiD6UH4p1sIk2xQHzHmEJFF7zuooo
 7uFXbBv3XtXbyYyW8f8cI54fuHqUOYTNTvSTCxC5QqMTpfkuSgEyyNbynHcvQbb1XEj/ImZ+Uy0j
 SnIoLnfs7oJQd81JTRqiKG6BSRCb1LmC2ohhcA/B/VsFVy95j0F9v2SeH1RSzlrpPXiwAO8SJ7ca
 duWnkO5/QpinPT4llSj7s4w9+5QX4iWL0+M4MoYF+IsVcA6LAh2sTlpO5olnAMy5ehq17TmiXjOD
 bvfoVpJxSyurrTTY/icyYeamXxc1QZ1iQVHteMI+pYIJkjWDp22vuB9BqkKmyFc5aF+KBgh3QzRz
 TV25nRx43RCQS/7Agi7/h97WPgiqmSivJzz47Sg/2MG+8h7lqE+vwvBJ1pPyV0
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: sesame_h@qq.com
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Cc: npiggin@gmail.com, adityag@linux.ibm.com, milesg@linux.vnet.ibm.com,
 harshpb@linux.ibm.com, Minhang Zhang <zhangminhang@kylinos.cn>
Subject: [PATCH] target/ppc: Validate HTABMASK and reserved bits in SDR1 for
 32-bit mode
Date: Fri, 14 Aug 2026 11:06:33 +0800
X-OQ-MSGID: <20260814030633.18523-1-sesame_h@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8611cad6-bfc9-4d3d-9fe2-322fdb34e1ca@linux.ibm.com>
References: <8611cad6-bfc9-4d3d-9fe2-322fdb34e1ca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.49; envelope-from=sesame_h@qq.com;
 helo=xmbghk7.mail.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Minhang Zhang <zhangminhang@kylinos.cn>

Hi Chinmay,

Thanks a lot for your careful review and pointing out these issues.

You are absolutely right, I messed up the reserved-bits mask. I misread
the Power ISA bit numbering: the correct reserved-bits mask should be
0x0000FE00, not 0x007F0000.

I also agree with your suggestion to avoid hard-coded magic numbers, so
I constructed the mask using the existing SDR_32_HTABORG and
SDR_32_HTABMASK macros from mmu-hash32.h, following the same pattern as
the 64-bit implementation in ppc_store_sdr1().

Both issues are fixed in the v2 patch below.

Regards,
Minhang Zhang
---
 target/ppc/mmu_common.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 2499e61..31a221d 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -57,9 +57,25 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
                      " stored in SDR1", htabsize);
             return;
         }
-    }
+    } else
 #endif /* defined(TARGET_PPC64) */
-    /* FIXME: Should check for valid HTABMASK values in 32-bit case */
+    {
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



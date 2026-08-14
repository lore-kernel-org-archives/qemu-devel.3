Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD4DC5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 09:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wunoO-0003f0-U9; Fri, 14 Aug 2026 05:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sesame_h@qq.com>)
 id 1wunoM-0003ec-U9; Fri, 14 Aug 2026 05:02:46 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sesame_h@qq.com>)
 id 1wunoJ-0006Ag-Iu; Fri, 14 Aug 2026 05:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1786698150; bh=RnprryDjsysWbbaFRT+bZ1ijYoE4WIVK7ZNib9cToyU=;
 h=From:To:Cc:Subject:Date;
 b=bMigEFdZLNxN7HFeP9f+HJef/eqnljJejWL03qIc9nzof45K+Nk0pWypNKFNN8cbu
 7VLT3xeKjOpJHSKoBC1U4OhPuK6W1WjE6ykz/IaXA2IKVWNtt2kS6YVkevC2JOo2S8
 CyFRf+/Em9BrY0m0hgcvfF0NjrVOxjU7O8zjV38c=
Received: from minhang-zhang-KVM.. ([116.128.244.169])
 by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
 id EB622EDD; Fri, 14 Aug 2026 16:58:54 +0800
X-QQ-mid: xmsmtpt1786697934td01uwij4
Message-ID: <tencent_6A02E5163538A46B0CE182183D6F5858F20A@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9XNitMpjcgcqCt0grMvz4OTQOqt5bzBS826mwL7tKgFXMve9orVI
 J9Wgrny9rRJOy1cdPc3KXVyrQfbEDTdyRO3jBQaZ5rloWmTZuTrhZBaolE0qlIOKG4dX/xhgsQU5
 HMwC/Mj1j/XlgbiNNZPv8QrXX6nQ0SINnm5Uq/Su87bDTKsbsCwHnnwVzWUPxJVIO/bKiHzwlr9X
 /XhDenN0dxq0brtnAvNI8CoRmtY8YzzR/+vY2XxIhMYlaNqH03CBXApj1LwIc76L8tNfYnJe3cJn
 zhQvSCx0rXSzJrCLDptd6hyidw9mgIkh4qbJLY/IWK3tQNn1FOGkMvuNFI8bA82A+BSECZAMyCRy
 lPNLjczJbi/xMxUkdb0Ywh3hRI/KfJ3jtmhkOaRIwe2cOuNWFdGBMsA1d6jbW6QxOtRsZDxQvWht
 socfSnqnjiAMZnXWFj+yD0W4zWD/dKBM+sadHZf9OUdeVg/q6/m/kGuLlxrlyOAelobSAzOrxCPr
 OhTth9RBQSkcAVKxx1/sZMBo5ORBZeRCi43cihwl3+P7rz+DzAcS1aI4VOCZZH9BYeAlr3ZIL9Tl
 7GdolwrK6VePCxVI2OQMjOL9lSgollJ0L6+auyGeAL7fzdQa5X5/fj2Yu8g+THuo4eiWi34uPz62
 Anw6d6CWyDi8fEdv8kpOAMVaYOwx+MWkgnAiJQvvqjrwnik5C9G9+Hbt89ycUvEpdaHpJQ/UKt1e
 PzadrwOt6Af1enCfX+enmIb8WuVbBTA/6hJgf0x/T7XnCwpqUOBpv0NGSBr5wM0D/0Cejoaw2QiE
 8SbOKNVGrnhSjqIzjvYyisk0uRtMKrvfMsmyTwEnRgZq3AmFTlntY5I69GlPaIfz7gVgv+QRM06q
 J9uvV9XxbeGCjh3a7VmPC2v86SBrnmU6x6OcYOEjVApMgaYHklizLui53cHjuggZ70MFIKqOEVBg
 P6I/HwxCmvJscG+/2mg0mTNxbLbkViNaTDVyFtFxsJnPUtA9se2iHcxkYkZaPl8a/1lJipY2Q=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: sesame_h@qq.com
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Cc: npiggin@gmail.com, adityag@linux.ibm.com, milesg@linux.vnet.ibm.com,
 harshpb@linux.ibm.com, Minhang Zhang <zhangminhang@kylinos.cn>
Subject: [PATCH v3] target/ppc: Validate HTABMASK and reserved bits in SDR1
 for 32-bit mode
Date: Fri, 14 Aug 2026 16:56:11 +0800
X-OQ-MSGID: <20260814085611.45403-1-sesame_h@qq.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.44; envelope-from=sesame_h@qq.com;
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



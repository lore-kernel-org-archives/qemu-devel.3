Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA15108E1E5
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 10:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Ax1-0007n0-75; Thu, 19 Mar 2026 06:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3Awx-0007mO-FN
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 06:50:00 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3Awv-0007lZ-0m
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 06:49:58 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-439b97a8a8cso731798f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 03:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773917393; x=1774522193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1WuJ8cIrDIUnWuKhAxHO+QKMXAxnZymxjtmAQMSq6pk=;
 b=I9Q3zf5Y8mNYk+vs4iLfodP/n1SE7+Rk3bM6O3SJTHgUG8NS8l7bMPqkkubb1lNdaS
 mhAb+aaKH5YQcSzA8c4FrifkAYnlbZpV/f1K9KNKsYCvoA/xf3JgmDQM/P76vkv5SyPV
 3m8ws/Pb8tbvgeKZfq9P/GsVOOTKNDm9U5U+hvyc8sVpMe9hvu1PfCHNCg7MvMufHGKp
 wR1WXcKAv6AFGTvrvIIRaJbtWuM15HFbP/ckD5b+CCuVa8KYf7AsWNv60kDPQ8vaiykJ
 wYs4dNEfKeXsNeql00HPH6xZak10Rg5VQGVn0HTJYLT8CUUaS7UcugErxzKw2Hhc3nfg
 nCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773917393; x=1774522193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1WuJ8cIrDIUnWuKhAxHO+QKMXAxnZymxjtmAQMSq6pk=;
 b=lf+uRo914r6ZmqTwh2/ankU7/Ndzyp+d+kuzLtd4KSUCFlnS3eYpQLv+7XjQyaR01N
 cA5HvSN8TmYM8NqrFl798BExD4+iKEhOHM9jRSo92AisGAxq153D6diF4UUnyM2VgOZk
 ZIK9FaRmOOdSH3POHgA21u1BoTBrERKMj7mdaVZAeSDxwx9nRbV1/vFJnqCBOlcHmFyD
 c5IOg/ySVFftNALOFnWRkraOmKAXuhfisU2XP5kH7mSdFiJ8FN+Fe0lPwtM2YBVDJQ77
 H8EOen+L+P8fnHY0+zq1Def7Vq9NOj1FGrDrHaJdj8yEqdmu4V+aMYCbB02AkzjdoTTq
 ph/w==
X-Gm-Message-State: AOJu0Yw+mGKfwPchJyyuAcAEBoCHMue89vLAv5vxzS+NTVR0i+KYxOFK
 NskJR8Nakd8GJ1g/pLvetQVRA5O1P3W4CDyLwaVFqK0f761qtpa/0LAVgSHvv/FpJjaBJEJA5zb
 G5hbxERE=
X-Gm-Gg: ATEYQzxVftOiQrkfnrqy5X85kfesfJRaWYy6Gtq5NwQ+FfSOzWOxJPubiWSw75zMazP
 cyBqvfug51t7+K0J0A49NWM4qoiGO7jIxRcmG5HZWNmmBNeL64QmUTwS5D8DVEIu/eHd8CifQwm
 6tKZACq37fZyYhIdRMsSiI4vYjsUW1V12MIqkU6YiTeXE20ABfjp7X6CLERRXlTTflupACguqkn
 E5ckbDM4yoJ7wo8A2ceGaOaBZsOHQkSMliL9X31MJbMQdvz1UGT6MQezhM+EWB3R4mp3uzqOqGy
 wm2wJSn52+vHCHnrFH24BiZbvwnDGN90j4qdHq6lq2dGzQTOFo4PkgagNF4M7GqZwGZbCovn6J1
 +f9Dl1hd+WT8ufKwZPGy1O2k2SP0WEpuxEIYgiy0kvBfeJ+cBz+RwAJJvqAlfAcf8F3sitcLzYW
 x1zWl0KJ96hT7rSysO11ARBWOobUkoxuEIPSBu0OJPOqfEZtd2adwG/2wF0pgI7vn8F4ToO/8V
X-Received: by 2002:a05:6000:1a8e:b0:439:abcd:b305 with SMTP id
 ffacd0b85a97d-43b527aa79bmr11943332f8f.13.1773917393345; 
 Thu, 19 Mar 2026 03:49:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b5189221dsm15247046f8f.23.2026.03.19.03.49.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Mar 2026 03:49:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Anton Johansson <anjo@rev.ng>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] target/loongarch: Replace legacy ldq_le_phys() ->
 address_space_ldq_le()
Date: Thu, 19 Mar 2026 11:49:43 +0100
Message-ID: <20260319104944.66690-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319104944.66690-1-philmd@linaro.org>
References: <20260319104944.66690-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Prefer the address_space_ld/st API over the legacy ld/st_phys()
because it allow checking for bus access fault (although the
modified code doesn't check that). There is no logical change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/cpu_helper.c     | 13 +++++++++----
 target/loongarch/tcg/tlb_helper.c | 10 +++++++---
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 60441687667..4b7743c4f28 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -7,6 +7,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "system/memory.h"
 #include "system/tcg.h"
 #include "cpu.h"
 #include "accel/tcg/cpu-mmu-index.h"
@@ -145,6 +146,7 @@ static MemTxResult loongarch_cmpxchg_phys(CPUState *cs, hwaddr phys,
 TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
                      int access_type, int mmu_idx, int debug)
 {
+    const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     CPUState *cs = env_cpu(env);
     hwaddr index = 0, phys = 0;
     uint64_t palen_mask = loongarch_palen_mask(env);
@@ -174,7 +176,7 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
         /* get next level page directory */
         index = (address >> dir_base) & ((1 << dir_width) - 1);
         phys = base | index << 3;
-        base = ldq_le_phys(cs->as, phys);
+        base = address_space_ldq_le(cs->as, phys, attrs, NULL);
         if (level) {
             if (FIELD_EX64(base, TLBENTRY, HUGE)) {
                 /* base is a huge pte */
@@ -204,10 +206,13 @@ restart:
         context->pte_buddy[1 - index] = base + BIT_ULL(dir_base);
         base += (BIT_ULL(dir_base) & address);
     } else if (cpu_has_ptw(env)) {
+        uint64_t val;
+
         index &= 1;
         context->pte_buddy[index] = base;
-        context->pte_buddy[1 - index] = ldq_le_phys(cs->as,
-                                                    phys + 8 * (1 - 2 * index));
+        val = address_space_ldq_le(cs->as, phys + 8 * (1 - 2 * index),
+                                   attrs, NULL);
+        context->pte_buddy[1 - index] = val;
     }
 
     context->ps = dir_base;
@@ -239,7 +244,7 @@ restart:
         ret1 = loongarch_cmpxchg_phys(cs, phys, pte, base);
         /* PTE updated by other CPU, reload PTE entry */
         if (ret1 == MEMTX_DECODE_ERROR) {
-            base = ldq_le_phys(cs->as, phys);
+            base = address_space_ldq_le(cs->as, phys, attrs, NULL);
             goto restart;
         }
 
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index c0fd8527fe9..892e0eb4738 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -20,6 +20,7 @@
 #include "exec/log.h"
 #include "cpu-csr.h"
 #include "tcg/tcg_loongarch.h"
+#include "system/memory.h"
 
 typedef bool (*tlb_match)(bool global, int asid, int tlb_asid);
 
@@ -709,7 +710,7 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
     hwaddr index, phys;
     uint64_t palen_mask = loongarch_palen_mask(env);
     uint64_t dir_base, dir_width;
-
+    uint64_t val;
 
     if (unlikely((level == 0) || (level > 4))) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -736,7 +737,9 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
     get_dir_base_width(env, &dir_base, &dir_width, level);
     index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
     phys = base | index << 3;
-    return ldq_le_phys(cs->as, phys) & palen_mask;
+    val = address_space_ldq_le(cs->as, phys, MEMTXATTRS_UNSPECIFIED, NULL);
+
+    return val & palen_mask;
 }
 
 void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
@@ -802,7 +805,8 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
         ptoffset0 = ptindex << 3;
         ptoffset1 = (ptindex + 1) << 3;
         phys = base | (odd ? ptoffset1 : ptoffset0);
-        pte_raw = ldq_le_phys(cs->as, phys);
+        pte_raw = address_space_ldq_le(cs->as, phys,
+                                       MEMTXATTRS_UNSPECIFIED, NULL);
         tmp0 = loongarch_sanitize_hw_pte(env, pte_raw);
         ps = ptbase;
     }
-- 
2.53.0



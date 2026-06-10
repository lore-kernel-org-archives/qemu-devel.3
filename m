Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06ED2CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLXJ-0007Zz-Am; Wed, 10 Jun 2026 12:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXG-0007Yc-I3
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:10 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXE-0005Qh-LB
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:10 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-45ef4223be7so3859771f8f.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107927; x=1781712727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YRUWTkmUsOJ/21M3+Jj97QsUtiTOkACivxwWggVCxTk=;
 b=hclHFTh/3HQA4/1b+Z3cD8TiCIk00Bkxnux3fl8D1rRDwK44uUi1m0Yc0oIeBy+WRe
 4fchYzqtoNEYV8dERGH+c66/ViCfYqZy/536+Ni6iwixFyC6mxLi+71NtWmUbtdgjDnE
 iPCsHKh5QCr4uffi9WtDYBgfofR55Mniu6fmlxTvROb/Ea1r4nU7O3CcCquHfOPDIiXZ
 NU4n7U37rom9oMJBRlEZTEkBmyK5F7txMvNFQtLv/q5XjaDCo1XzPvDjIXHKaVpabBge
 0Bz/tCbHoN108eahjReYQ80TxlhdY49gSr70Yna/3ouMKe+I4KuUbY4aVd3Tl0ofTAzE
 ftjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107927; x=1781712727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YRUWTkmUsOJ/21M3+Jj97QsUtiTOkACivxwWggVCxTk=;
 b=ouxqGxhHvfsh1ZyAowELG25AKENl6Y4h6UZoLS8hEYzm0VV5LI/VvyXxxi+pc6pMT4
 kLDiMYQ42ZV4/VkYDtr2iFZ+oglFE5MyJ6r/udhyjRNwn6flcSws3R2TKXxazhMfVIgF
 iVU/GwScmkw5MmVqU5CtQOoyrJJrUsWWb51A6He9F1eK1L2mMt3Ptu2DJiK0rcQO9jBP
 pGWk7O1vrQRFd1JrcsQzhr8rUkeZfFFc9iyjc/t1ygi93WyeqwfDUAQ64cUJy2p0BVcN
 1QzQ1bCHBjhNSvD0wQ++sogLw6GGn4VzxpjccK2IHgFzaNSSXqR60KJiRgTdGmeF/SZE
 9Ilg==
X-Gm-Message-State: AOJu0YwmWqItmppFqXCl5+iT7y5/GzIwuF3e5WBZAnGHcP8GR6+898I1
 PpMihdK8A1eTozaWvHTeqniaLSpAwiBS8g9/aqALrcKzT8zowOWCPy4/S9V07qaJO7sjbLkQ3Pw
 ywBob
X-Gm-Gg: Acq92OFC+2TAjwlDHpPeiGFU2VwW6/XQ+FSTvzLP9xsxNGLdcb9/tnTLp1tz7o+3Bg5
 vUj8DKhh3KHsYEmL9RZxCGySRK0BOt7I0mAWpWCPSoPCdD8OMFTRufe6bCSfYBBTGPJYijKbNt6
 C3wJjxaSybAgvufmQJen3M+0pbtoINwui0JG03UAqjTQtQH9ty1fbO6L9DkkIpipL0yIUid50o1
 8vI/NGT8tgPOerPT5eHm1mUKONZyVLxjkuPrdB6Sc9bI5vmQIsslXtNcGhCrp3V8EQ/5iiwUzUV
 YfUpKFyj4/WoQeDdRDo6RFOtMZN1IvpS4A9SxrduetoUx5jtINWe0ZMhqlxDcqCYKUhKQbG6dbA
 YDoZzkpAylhlrARi4odhScdHf1li6dzR5I94PO0rcERixBeKaj47bqKQ43K466iEvEaC4aeSOpe
 x7QadJbTgUcSIrdIAL581qT1yWZSU5KA+GNbklpC9C5Q2hcJYFP+miYpTaYHiNS17enKIqgSVfs
 cHZqEjgWa32FJjJES5HZUNeEIpl4OukaEjzldb98r0=
X-Received: by 2002:a05:6000:41e9:b0:454:a12c:6cdb with SMTP id
 ffacd0b85a97d-460566810famr10980830f8f.2.1781107926805; 
 Wed, 10 Jun 2026 09:12:06 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/71] target/arm: implement MTE_PERM
Date: Wed, 10 Jun 2026 17:10:53 +0100
Message-ID: <20260610161202.2235298-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Gabriel Brookman <brookmangabriel@gmail.com>

Introduces a new stage 2 memory attribute, NoTagAccess, that raises a
stage 2 data abort on a tag check, tag read, or tag write.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260529-feat-mte4-v7-1-ccbd3c14eb3c@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h   |  5 +++++
 target/arm/ptw.c            | 25 +++++++++++++++++++++---
 target/arm/tcg/mte_helper.c | 38 +++++++++++++++++++++++++++++++++++--
 3 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 38a695ded7..83897365ad 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1191,6 +1191,11 @@ static inline bool isar_feature_aa64_mte3(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR1, MTE) >= 3;
 }
 
+static inline bool isar_feature_aa64_mteperm(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTEPERM) >= 1;
+}
+
 static inline bool isar_feature_aa64_sme(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR1, SME) != 0;
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 0a5201763a..6cb0fe5645 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3415,7 +3415,7 @@ static ARMCacheAttrs combine_cacheattrs(uint64_t hcr,
                                         ARMCacheAttrs s1, ARMCacheAttrs s2)
 {
     ARMCacheAttrs ret;
-    bool tagged = false;
+    bool tagged = false, notagaccess = false;
 
     assert(!s1.is_s2_format);
     ret.is_s2_format = false;
@@ -3425,6 +3425,18 @@ static ARMCacheAttrs combine_cacheattrs(uint64_t hcr,
         s1.attrs = 0xff;
     }
 
+    if (hcr & HCR_FWB) {
+        if (s2.attrs >= 0xe) {
+            notagaccess = true;
+            s2.attrs = 0x7;
+        }
+    } else {
+        if (s2.attrs == 0x4) {
+            notagaccess = true;
+            s2.attrs = 0xf;
+        }
+    }
+
     /* Combine shareability attributes (table D4-43) */
     if (s1.shareability == 2 || s2.shareability == 2) {
         /* if either are outer-shareable, the result is outer-shareable */
@@ -3456,9 +3468,16 @@ static ARMCacheAttrs combine_cacheattrs(uint64_t hcr,
         ret.shareability = 2;
     }
 
-    /* TODO: CombineS1S2Desc does not consider transient, only WB, RWA. */
+    /*
+     * The attr encoding 0xe0 corresponds to Tagged NoTagAccess and is only
+     * valid with FEAT_MTE_PERM (otherwise RESERVED, constrained
+     * unpredictable)). The presence of this feature is checked in
+     * allocation_tag_mem_probe, where Tagged NoTagAccess has its effect. See
+     * J1.3.5.2 EncodePARAttrs.
+     * TODO: CombineS1S2Desc does not consider transient, only WB, RWA.
+     */
     if (tagged && ret.attrs == 0xff) {
-        ret.attrs = 0xf0;
+        ret.attrs = notagaccess ? 0xe0 : 0xf0;
     }
 
     return ret;
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index a9fb979f63..bf35dc10ce 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -58,6 +58,27 @@ static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
     return tag;
 }
 
+#ifndef CONFIG_USER_ONLY
+/*
+ * Constructs S2 Permission Fault as described in ARM ARM "Stage 2 Memory
+ * Tagging Attributes".
+ */
+static void mte_perm_check_fail(CPUARMState *env, uint64_t dirty_ptr,
+                                uintptr_t ra, bool is_write)
+{
+    uint64_t syn;
+
+    env->exception.vaddress = dirty_ptr;
+
+    syn = syn_data_abort_no_iss(0, 0, 0, 0, 0, is_write, 0);
+
+    syn |= BIT_ULL(41); /* TagAccess is bit 41 */
+
+    raise_exception_ra(env, EXCP_DATA_ABORT, syn, 2, ra);
+    g_assert_not_reached();
+}
+#endif
+
 uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
                                   uint64_t ptr, MMUAccessType ptr_access,
                                   int ptr_size, MMUAccessType tag_access,
@@ -117,8 +138,21 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
     }
     assert(!(flags & TLB_INVALID_MASK));
 
-    /* If the virtual page MemAttr != Tagged, access unchecked. */
-    if (full->extra.arm.pte_attrs != 0xf0) {
+    switch (full->extra.arm.pte_attrs) {
+    case 0xf0: /* Tagged */
+        break;
+
+    case 0xe0: /* NoTagAccess */
+        if (cpu_isar_feature(aa64_mteperm, env_archcpu(env))) {
+            if (probe) {
+                return NULL;
+            }
+            assert(ra);
+            mte_perm_check_fail(env, ptr, ra, tag_access == MMU_DATA_STORE);
+        }
+        /* fall through */
+
+    default: /* Not Tagged */
         return NULL;
     }
 
-- 
2.43.0



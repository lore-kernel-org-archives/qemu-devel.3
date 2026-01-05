Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19305C79FAF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 18:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcp7b-0001Bg-GZ; Mon, 05 Jan 2026 13:16:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vcp7P-00015Y-6P
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 13:15:51 -0500
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vcp76-00034D-0Q
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 13:15:35 -0500
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-88a3b9ddd40so1187996d6.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 10:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767636927; x=1768241727; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B+Hv/Pd2LCKw/PSMs7i5uhg6AdBJ5kEZzn6b+5/2FjM=;
 b=juFdlLis4zgB/5xn+zxQeORrVjeiLKPYdjG822FSKZxiRxI1/eMgN1h9rjHAwqFNl+
 y8FmtPo+yxJMGOewRVjE90g7nR3wYALJDLDw33kPcblyWN0lbPOSPGi67SuEjIJtVrU/
 zMCbVvHxsWMRVC7KSv+x/Lr23eUVbuKzlnRyzEZbWu+GkayuXRLOA7EI1yOHzinD8mht
 2UWigWvwMfN7EK9F1lmeDJksX5OlFubYa99fG+ZK0kM91sYYRrXVe6VFFVQPIhdnYkH+
 tHJGVHlM+GJ3LHyFry53NJQ8iTeP6eQP0h72tWX2HkyiGjlpTliASKi2cpyEJ7kLr7zQ
 IWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767636927; x=1768241727;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=B+Hv/Pd2LCKw/PSMs7i5uhg6AdBJ5kEZzn6b+5/2FjM=;
 b=mFDt3IhgU4xkJ+GXYM2v/YdmAOlSIrMVZoTcaxi7WIJq+dPfCJng8lbNd2exCWOUr6
 b4dqwfRsm9+BCPieFVaro7PmKKpAo6IqE1OpHWVuKww5HUzE+gzr9I1OmNC0/WNyqp1q
 XrJ+RdkSQxy54+YBv1kyTpoElV1rj7OCHvUO8k2syuFWGQ4//v8OKxdbHtenWvAbDGjU
 oQ/0qWh20EcgI0lOceLPrg/uJRlOUEY9Sa5cAoJ6M5n9VQDAfm5+UfqER5ZOR/sPhjgg
 H/D3n6fYFrzooKPwBMeYntkObkEKU1SQTcXWx1fRK1Q+slcPx/rQeig8G0qoBxPNzruS
 JuRA==
X-Gm-Message-State: AOJu0YwkUqFbPLFnc0Yn2BlR6KNWGr4Fv8cLCPzIp7AlXQy/4ehvrIt4
 aj57FfUtzueJnQoTQtJauLjhOQJcNKSwV+6Sun1MJNRCSapdX6yiv4dg
X-Gm-Gg: AY/fxX5Hp4csgPrUvtXHMHTnKL4qmP65Yd+1l8pvvACsJj9J/a5EzeGdUHxIqGkef76
 8alRz8Mg+LghYKyTLqukqL2gj/oH4A9O4Wv7dBxj4X7V+5avIfb/I8eq27UlSb1AZO14hWSk7uP
 Rba+hbgpdqsk+v3q80rUpeacoumOrlZ2pGfR4FfYn3pm6MLst4gXoBq3djcL/Kszd5OQxhm2+eq
 eM7YH6TgcBt4/QSXC/jYOltJeFbwhrDpmkFhRBiFDfl0BTU4X6kOQPCDdnigFL/Fef0OAhjdncy
 0C1GWZc6TcvHAbLk385YjHfVQZ+Dcg5rSZVlKe6UPImMJMu7fDaB+wjAACbsG6V6UB82BjWZKCe
 nVb2pv4+qxLrLu5SyStd74KU2bQiOqFcBYQKnvOb0w7APevHtdphZegVYnyM4K9rmsjF7IXjoYS
 IlqwfoUYCDU4kfuu7YkBtt3mVC
X-Google-Smtp-Source: AGHT+IHYdP20i1E7axKMbgwKe0aKHUb/bZzfMFwriKu5QlYEyH4TDqPUEvh7RcaA5iabb9jxFF7QAg==
X-Received: by 2002:a05:6214:ca5:b0:88a:2841:bb11 with SMTP id
 6a1803df08f44-89075e7d88dmr8395466d6.27.1767636927168; 
 Mon, 05 Jan 2026 10:15:27 -0800 (PST)
Received: from [192.168.1.204] ([185.213.193.254])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8907540e24csm3855706d6.25.2026.01.05.10.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 10:15:26 -0800 (PST)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 05 Jan 2026 11:14:50 -0700
Subject: [PATCH RFC v3 01/12] target/arm: implement MTE_PERM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-feat-mte4-v3-1-86a0d99ef2e4@gmail.com>
References: <20260105-feat-mte4-v3-0-86a0d99ef2e4@gmail.com>
In-Reply-To: <20260105-feat-mte4-v3-0-86a0d99ef2e4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767636923; l=4132;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=mE5nY5j9NmtdHiwmNlYtPNB/QFvmyHnfw0X1To8yh9E=;
 b=fw7lNXQ/lCpLWby01FFEWy68Mi+AUEDEqfPihX3PZu8BCygZ+db6AYEfyVp7YeKmNm0UeQKIf
 A06vc40EN3wDWDDr5JdsohyfMknbpaToP0qySQSAUU+yBfhSYfYHQ/z
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qv1-xf2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Introduces a new stage 2 memory attribute, NoTagAccess, that raises a
stage 2 data abort on a tag check, tag read, or tag write.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
---
 target/arm/cpu-features.h   |  5 +++++
 target/arm/ptw.c            | 17 ++++++++++++++++-
 target/arm/tcg/mte_helper.c | 31 +++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index c86a4e667d..48009b5a66 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1139,6 +1139,11 @@ static inline bool isar_feature_aa64_mte3(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR1, MTE) >= 3;
 }
 
+static inline bool isar_feature_aa64_mteperm(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTEPERM) == 1;
+}
+
 static inline bool isar_feature_aa64_sme(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR1, SME) != 0;
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 2e6b149b2d..9f864fe837 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3393,7 +3393,7 @@ static ARMCacheAttrs combine_cacheattrs(uint64_t hcr,
                                         ARMCacheAttrs s1, ARMCacheAttrs s2)
 {
     ARMCacheAttrs ret;
-    bool tagged = false;
+    bool tagged, notagaccess = false;
 
     assert(!s1.is_s2_format);
     ret.is_s2_format = false;
@@ -3403,6 +3403,18 @@ static ARMCacheAttrs combine_cacheattrs(uint64_t hcr,
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
@@ -3437,6 +3449,9 @@ static ARMCacheAttrs combine_cacheattrs(uint64_t hcr,
     /* TODO: CombineS1S2Desc does not consider transient, only WB, RWA. */
     if (tagged && ret.attrs == 0xff) {
         ret.attrs = 0xf0;
+        if (notagaccess) {
+            ret.attrs = 0xe0;
+        }
     }
 
     return ret;
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index bb48fe359b..942bd4103d 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -57,6 +57,28 @@ static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
     return tag;
 }
 
+#ifdef CONFIG_USER_ONLY
+#else
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
+    syn |= BIT_ULL(42); /* TnD is bit 42 */
+
+    raise_exception_ra(env, EXCP_DATA_ABORT, syn, 2, ra);
+    g_assert_not_reached();
+}
+#endif
+
 uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
                                   uint64_t ptr, MMUAccessType ptr_access,
                                   int ptr_size, MMUAccessType tag_access,
@@ -116,6 +138,15 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
     }
     assert(!(flags & TLB_INVALID_MASK));
 
+    /*
+     * If the virtual page MemAttr == Tagged NoTagAccess, throw S2 permission
+     * fault (conditional on mteperm being implemented and RA != 0).
+     */
+    if (ra && cpu_isar_feature(aa64_mteperm, env_archcpu(env))
+        && full->extra.arm.pte_attrs == 0xe0) {
+        mte_perm_check_fail(env, ptr, ra, tag_access == 1);
+    }
+
     /* If the virtual page MemAttr != Tagged, access unchecked. */
     if (full->extra.arm.pte_attrs != 0xf0) {
         return NULL;

-- 
2.52.0



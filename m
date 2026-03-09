Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120C3FCA198
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 22:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzies-00038V-Kx; Mon, 09 Mar 2026 18:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vzieg-00031K-M7
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:00:51 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vziee-0004Wm-JO
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:00:50 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-79853c0f5b9so99759697b3.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 15:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773093647; x=1773698447; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ujPltNFffjQeUE4ux4AuUGJOXMAqpw9+nvQB2HyqhjQ=;
 b=k6LnQdGio4NC8W0voli9gj+KpPpVBrIxPvWlY3emjTHodxF35GyvfRmfapyU2Qaqfp
 J1fkJp/RneOSf0x9haMWEmRYe+RqSF5AW4qE8aWZInM+MnsA297rOtl31ueFtsGCrlpd
 ipf+HFZGtKLCpf5VTisBWmHlM/qsTAV+idpVZRUA1oTDfmAY44oLUjyihauqE2X+wtA2
 TTs2HcVeMjQWfnaf/jneyUoBMkkKLz/zUCICMyegOG2DvVwVTHWD2vmd5ZqK1/fc++qO
 ZzEHLLa2yliYWxyVTWFuaMdYLo0x8IafxjxVlEWExvXvimw50nOiRdR8Ws8zVhsQ4PLb
 GuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773093647; x=1773698447;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ujPltNFffjQeUE4ux4AuUGJOXMAqpw9+nvQB2HyqhjQ=;
 b=QC89cCXbEK05JIo8b+DYMXNmf6rbCkbrKgvoGItjfmcppyrJi0qUtwnZcSlZD2Prkr
 A9/N8SkRJ3yc5Y5pQztyJ5s3D3MVpm9cOP/ltTI7QDv5Xn7JjYtXJGgjX//wWf9B5jed
 sxc2Un1myj3KV242xwD7l/60HVAOOJXV7CuC8t642clHZALOq564PuqpR2BHKzg01Mab
 /yfXynbRp0VW2xm7jSJYdTvmdbK/lxJB3//G4rwZe/BqEfaxbzHBGs+MsxCy+QQXNzlV
 Mu31plxI5s2yTHL+axLAEZbBQxDFxX2jGV6j9/ZeBBoErTVrFSDLlSIpb4BR+fN1ariX
 zmow==
X-Gm-Message-State: AOJu0Yx6c4ZvvqVsDXaLOyJlspVhgbUCFiDeofcA+qbyrWQCB5ZBeRQU
 fdjEbUNuQUgs6CYeGuWKcVTArUXS74anWKO9iXa1JM08WnHHjEtV2UKR8nTdW2Nh
X-Gm-Gg: ATEYQzx5BCkPdLtCNV0Q/23OlbWt2OxywtFnlFu0fgt0VxEopVyJT19Fal+7HXHXE27
 DFQ6yDa0XI89jVKw0wRJXGwQdO4itou6sZ/DCwHOGCoB0NaUxGhugkH1Nrkj+FcmabcYts7tlnD
 GI1r+VcgTJjKjc/un4QF7UAfsIIUtxDEzj3JHxkVUTrDPiDNkn9zm3twnJed0i23NTetcOt1tsb
 zoUrlaAhJtO0lG27vopZJTnr2RSps96hs5/J8y+l8fSBIAkV+WJ/ExXlv7q1JRvLAulCXO2WLzF
 bEDk84/GpbzKGsNw0uTLuEfTsMHCJOvRYNrsYwWWIGRNQbcdbnjFAk75t5GL66dAKwUmgQ2sfEP
 I5rtYAMM9ZP1/WdsKJdFlfE1WUh6C28HTvaw++SZCPqzxCcc3ErhqaJYRVFsHSDpVLqPrza/3W5
 2KfYOavacBAmO5k7tbMhnOorI8tT8+icG0HJs=
X-Received: by 2002:a05:690c:f08:b0:798:3efa:6036 with SMTP id
 00721157ae682-798dd756691mr124504177b3.35.1773093647236; 
 Mon, 09 Mar 2026 15:00:47 -0700 (PDT)
Received: from [172.26.74.149] ([185.213.193.97])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7990a54ba7csm5218437b3.19.2026.03.09.15.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 15:00:46 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 09 Mar 2026 17:59:36 -0400
Subject: [PATCH v4 04/13] linux-user: add MTE_STORE_ONLY to prctl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-feat-mte4-v4-4-daaf0375620d@gmail.com>
References: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
In-Reply-To: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773093641; l=4879;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=qTNWWgwzs5nbevga6YuVxpSCsqyxLBjC/93+JoZ5eqE=;
 b=pTRRZ1zMhCwnPviuv/voAtwnOrr/ocMKDgUpE7eus7qnYAhtYHsGLKq7gqLyk8fE0bqfdP39X
 lmymNrTqq3yDPyQsOnshX9TpJ4eLXXVphm4kIzQHsFoKcuyIl9eBE2P
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=brookmangabriel@gmail.com; helo=mail-yw1-x112a.google.com
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

Linux-user processes can now control whether MTE_STORE_ONLY is enabled
using the prctl syscall.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
---
 linux-user/aarch64/mte_user_helper.c | 11 ++++++++++-
 linux-user/aarch64/mte_user_helper.h | 14 +++++++++-----
 linux-user/aarch64/target_prctl.h    |  6 +++++-
 target/arm/gdbstub64.c               |  2 +-
 tests/tcg/aarch64/mte.h              |  3 +++
 5 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/linux-user/aarch64/mte_user_helper.c b/linux-user/aarch64/mte_user_helper.c
index a5b1c8503b..b5c4dafcda 100644
--- a/linux-user/aarch64/mte_user_helper.c
+++ b/linux-user/aarch64/mte_user_helper.c
@@ -10,7 +10,7 @@
 #include "qemu.h"
 #include "mte_user_helper.h"
 
-void arm_set_mte_tcf0(CPUArchState *env, abi_long value)
+void arm_set_tagged_addr_ctrl(CPUArchState *env, abi_long value)
 {
     /*
      * Write PR_MTE_TCF to SCTLR_EL1[TCF0].
@@ -32,4 +32,13 @@ void arm_set_mte_tcf0(CPUArchState *env, abi_long value)
         tcf = 2;
     }
     env->cp15.sctlr_el[1] = deposit64(env->cp15.sctlr_el[1], 38, 2, tcf);
+
+    /*
+     * If MTE_STORE_ONLY is enabled, set the corresponding sctlr_el1 bit
+     */
+    if (value & PR_MTE_STORE_ONLY) {
+        env->cp15.sctlr_el[1] |= SCTLR_TCSO0;
+    } else {
+        env->cp15.sctlr_el[1] &= ~SCTLR_TCSO0;
+    }
 }
diff --git a/linux-user/aarch64/mte_user_helper.h b/linux-user/aarch64/mte_user_helper.h
index 0c53abda22..8a46f743f4 100644
--- a/linux-user/aarch64/mte_user_helper.h
+++ b/linux-user/aarch64/mte_user_helper.h
@@ -20,15 +20,19 @@
 # define PR_MTE_TAG_SHIFT       3
 # define PR_MTE_TAG_MASK        (0xffffUL << PR_MTE_TAG_SHIFT)
 #endif
+#ifndef PR_MTE_STORE_ONLY
+# define PR_MTE_STORE_ONLY      (1UL << 19)
+#endif
 
 /**
- * arm_set_mte_tcf0 - Set TCF0 field in SCTLR_EL1 register
+ * arm_set_tagged_addr_ctrl - Set TCF0 and TCSO0 fields in SCTLR_EL1 register
  * @env: The CPU environment
- * @value: The value to be set for the Tag Check Fault in EL0 field.
+ * @value: The value to be set for the Tag Check Fault and Tag Check Store Only
+ * in EL0 field.
  *
- * Only SYNC and ASYNC modes can be selected. If ASYMM mode is given, the SYNC
- * mode is selected instead. So, there is no way to set the ASYMM mode.
+ * Only SYNC and ASYNC modes can be selected for TCF0. If ASYMM mode is given,
+ * the SYNC mode is selected instead. So, there is no way to set the ASYMM mode.
  */
-void arm_set_mte_tcf0(CPUArchState *env, abi_long value);
+void arm_set_tagged_addr_ctrl(CPUArchState *env, abi_long value);
 
 #endif /* AARCH64_MTE_USER_HELPER_H */
diff --git a/linux-user/aarch64/target_prctl.h b/linux-user/aarch64/target_prctl.h
index 621be5727f..d91e75d60d 100644
--- a/linux-user/aarch64/target_prctl.h
+++ b/linux-user/aarch64/target_prctl.h
@@ -168,6 +168,9 @@ static abi_long do_prctl_set_tagged_addr_ctrl(CPUArchState *env, abi_long arg2)
     if (cpu_isar_feature(aa64_mte, cpu)) {
         valid_mask |= PR_MTE_TCF_MASK;
         valid_mask |= PR_MTE_TAG_MASK;
+        if (cpu_isar_feature(aa64_mte_store_only, cpu)) {
+            valid_mask |= PR_MTE_STORE_ONLY;
+        }
     }
 
     if (arg2 & ~valid_mask) {
@@ -176,7 +179,7 @@ static abi_long do_prctl_set_tagged_addr_ctrl(CPUArchState *env, abi_long arg2)
     env->tagged_addr_enable = arg2 & PR_TAGGED_ADDR_ENABLE;
 
     if (cpu_isar_feature(aa64_mte, cpu)) {
-        arm_set_mte_tcf0(env, arg2);
+        arm_set_tagged_addr_ctrl(env, arg2);
 
         /*
          * Write PR_MTE_TAG to GCR_EL1[Exclude].
@@ -185,6 +188,7 @@ static abi_long do_prctl_set_tagged_addr_ctrl(CPUArchState *env, abi_long arg2)
          */
         env->cp15.gcr_el1 =
             deposit64(env->cp15.gcr_el1, 0, 16, ~arg2 >> PR_MTE_TAG_SHIFT);
+
         arm_rebuild_hflags(env);
     }
     return 0;
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index b71666c3a1..3d24c09ccc 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -684,7 +684,7 @@ int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg)
      * expose options regarding the type of MTE fault that can be controlled at
      * runtime.
      */
-    arm_set_mte_tcf0(env, tcf);
+    arm_set_tagged_addr_ctrl(env, tcf);
 
     return 1;
 #else
diff --git a/tests/tcg/aarch64/mte.h b/tests/tcg/aarch64/mte.h
index 0805676b11..17b932f3f1 100644
--- a/tests/tcg/aarch64/mte.h
+++ b/tests/tcg/aarch64/mte.h
@@ -20,6 +20,9 @@
 #ifndef PR_TAGGED_ADDR_ENABLE
 # define PR_TAGGED_ADDR_ENABLE    (1UL << 0)
 #endif
+#ifndef PR_MTE_STORE_ONLY
+# define PR_MTE_STORE_ONLY        (1UL << 19)
+#endif
 #ifndef PR_MTE_TCF_SHIFT
 # define PR_MTE_TCF_SHIFT         1
 # define PR_MTE_TCF_NONE          (0UL << PR_MTE_TCF_SHIFT)

-- 
2.52.0



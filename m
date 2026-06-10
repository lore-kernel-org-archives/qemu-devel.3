Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8A6CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLXM-0007aR-Uw; Wed, 10 Jun 2026 12:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXK-0007aA-UV
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:14 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXJ-0005Si-4n
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:14 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4600cbb06deso13662f8f.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107931; x=1781712731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LfgEtjEofemnb9oUGlzyFUFatDRuSkVWaWombKIzix0=;
 b=CWngeCRUipOlycukfzuobU7W7eIt6N81BBjnGjNtbUPDY5FJh2Mz+sMJtuRsK3L8tR
 pdeUEXqhkOJv4N5aIJBJpOx5cfDAhqrAY/9EMWnsmm/bzkbEzcbTdrByDV6Au/d37Q/a
 6D292GleYVQE2KIVAgDyiOtuwN354r6dM9lrw9EE5C1zJkobx56+ZtPbeM/y4C7YpS/x
 XwpCk5a3Ax/EvEy9nToJTSZJ5yHKk1LnFBpI73ze2HobrYKqy706UHhcv+0Jid/LYcZx
 VfbwE0x7p1Px37Ngd3pcVFwaBNAUMpIK0kmfRNdOPcyW4u5xzX3RWXb76vDAwAFOJRYb
 Qtuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107931; x=1781712731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LfgEtjEofemnb9oUGlzyFUFatDRuSkVWaWombKIzix0=;
 b=KOCkt3rMguKKFA/nsDMDsWY1QggO6OWLSpSycD8gdjWc/YPi7iCSv8y1ZgEotWIB7E
 pghakHYv2ntZBb6nYiGdaMNLmhCEVuVwSyBivDL+ASDxYtNeBVPGPaKnb1SQcdANRbvG
 fUaF+lSH8cq/6/y/2+7rqUuHTDwDJlT6E89Api7HD1OeUMDhp9/r8N1T4KRlh3unODup
 8hDMk8Q9QnMsHhBXXFvv6JVKxHqUOg9FUSmvIEPTTDviY7EucW4Ns0a6QEK9N5rlH0tU
 qmUJb6PbW7uYPEqTVdX+q2+/FtcdjvtItI18jEkYYXAFEoEsZgRV9aELPYgTL2Vxi4Wr
 VLog==
X-Gm-Message-State: AOJu0Yyu7AIqo0Jxh1pPMvnCLzAUJgpXjh6A8Mou0UJzGp3aY2/Hk5eq
 izgAmejikCFnMqEZAn5QthvW8XOzQC7ELU9lg4Q8vk8WANIiMtTZvMvWRVVBxN+clsQTRsEeO35
 xDoe7
X-Gm-Gg: Acq92OHcf0UnBshcD4ihcru3RhqYWs+Gzm4yUv4j5LMFoVrc13BUKp39HnQOJyhroBm
 JCA41zA34K9G0KNYt+oQCIuYtJKshkcI4ZRKTs4X+ymg5moTdwa8/bwXX34KdFp3LTHyc3FgXGw
 wPdhvbKHbEYktrv5trKJqxs265jlS7vJlsLg7wiRhOqF7nY4kTmc3eDMPOQ0ahloZbvCv/XkX4t
 zGF9RCdUZCtd26coXuVVCfIjMSRp/DFeqHa2WUq685mKRjNgFl4RWeee51BOBJVMtZjRMI946nd
 U1YYwS0Aykav6huYsKrZJaCQBAjKEl+pJucV/9XdCMsO0pqSRZnuWILZHdL3YxI/fOVzoU69smf
 dVreMIa5VjT1c2Y05+2woaIFc0nT6wRum1XXQSfyJ6eBn30Lh8gy/H9D5YyMa+SMvKdDDmbV4Lg
 1mNEybxjH0adTiL0GD6CAVS1T20Jk1un1b1CBt7q7BBIU7wSQhCAaVYFpbpNTGsVVbftF/BgDgl
 Ncq+QDhMiwPo/fdsFtOzOTToJbi/1l4Ws+hnQe0rYo=
X-Received: by 2002:a05:6000:400d:b0:45e:dd32:92fa with SMTP id
 ffacd0b85a97d-46032b81e04mr38155673f8f.12.1781107930880; 
 Wed, 10 Jun 2026 09:12:10 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/71] linux-user: add MTE_STORE_ONLY to prctl
Date: Wed, 10 Jun 2026 17:10:56 +0100
Message-ID: <20260610161202.2235298-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

Linux-user processes can now control whether MTE_STORE_ONLY is enabled
using the prctl syscall.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260529-feat-mte4-v7-4-ccbd3c14eb3c@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
index a4fa740caf..0c3e5b30bd 100644
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
2.43.0



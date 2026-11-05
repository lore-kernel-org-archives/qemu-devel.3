Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016EF606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nOwCFp/b
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP2lZ-0004wZ-NN; Thu, 05 Nov 2026 14:04:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP2kn-0004qz-U4
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:04:06 -0500
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP2kk-0003ki-Sh
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:04:05 -0500
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so3736856c88.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 11:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793905441; x=1794510241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bkzwqMJPNAcV6xuA38vl9g5vvmf0U7gVJCHn4dto4HA=;
 b=nOwCFp/bNkgcNuRwzkQLN/y0YcJDvkbM0mnTr+sSV5epcMIYQf5OzS0P//z5cE6KEK
 s4zc8ka0ZaZSYf4KWRcpOwCEJMbQDbqzUw2JfPEDp/blv+19qonS5/Kwz19u31LSRGeG
 p9Z1s/a87o/60j9HWw08v5iuFB+JhxmhyAHlSqCgP/TqMKHrHoKE1hxhPdT+yequ07kv
 vycXTqT8PZJJiXE9ZH1plyhALq4Y+555zKNiMoTMt+S4oNUFLP20APQ8f8kpSKvpivoE
 SKFB/nBAzhykee1ptValEQm7n5mYWpgcKC8KCmCEbj9Hl8gHLsOvoPONYzRYg1WIIEyf
 mTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793905441; x=1794510241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bkzwqMJPNAcV6xuA38vl9g5vvmf0U7gVJCHn4dto4HA=;
 b=Mw+rzLCcD7h48CaAnx9rOk2f2fKiRX9bMvm9afAwLH6pwV3oLwj4d7OByPmdBS6Z7C
 AtOi3yQBpOG0yZXcY+1eORBzJXyJ7NHRzMfm7rwjiIbxopX2gZTZEZORGlPPhjiTung+
 GbHq+lD19VSouIUJNep/vp4YnZSrdB0EUygRRJ+PKq5zQ4k4kt9YsPog8ne0qoCB1QHB
 11Pg6DtSnvH2FZFln1SZh47axLJt1KmQ+763v/gKHVvYvy5v+7xRRoZpn6wXdOjrTlMX
 zixFJlnMoUmSAkRiM4LGJ1S+aKqzkrWgr4bd3kAoXAGOZLN2jamj8Jr+iBlqirFwJbBq
 v40w==
X-Gm-Message-State: APuU4Z/ByZb+slYkJ4lc6gMrE6r+EmWNJ1PjRfpMGSlb3hrvk8gozovJ
 dQR7FTL71Ea1KSBoUjVBLsOni/maDELF9fIgNWVwXiYjUphiCx+U55VzBYQ3nc8dR3I=
X-Gm-Gg: AYBFou36iGQETF7pTRdyntFrpuawUL0RkAf1bR+G2MU1abycjMlNKRuwE+5Qzx32vo5
 N3xcHobgOTWBylSHpJVSQ/mSfPTd9u0eKEAtbHY6gy8Bn0GyIQRHQirqMjQMAxYsxX95OfQtM22
 GOhaK4J60EnpByDnp2H+fr8LlFQ2Q9TA6yJA8hMWuWErVQm9YlGN7EjUz2UeCbYBLxr/RX/DdbN
 AklSlMaI4ufFDRBpCmCSEVBlILWY6J2JE9vCee9D+qsYbxb6RoPiE+XI8riXgVXYS+XwHgVx22Z
 GHXMp2wHNu9Zu3mBDu1oXjBsYqRxeKSJE+1WBOKvDJXL9WcqZykXGunmHLoVjaW7fKHn4cYsioi
 xiqIY3PDJkc/H9qtQt9ZqJM+BtqwCctWy7WBgCPgha4XuBAAex/AJ4W1Dk6QqFF443ra494iTer
 XgxJ8e6kEmBywF2/h4/PdRV7Qn67c6+iUgTYZ/NlLzapFRqawq7C1mpGF0vkpsEIijftVgAqLlC
 jI+6A63Q9sm+MgTpfyeUgfp8sPYUhTRwOF0Zv+6wzWfMDJvMJSC9ITrVWr+inA8yPGN5UdKpohU
 oFe38B+jVRVisbF5jYZVcIPaUqr95+QjbkxLTHRkHWMOrYvt
X-Received: by 2002:a05:701b:21db:b0:1b1:251f:d732 with SMTP id
 a92af1059eb24-1b23f20d4b8mr12520251c88.31.1793905441068; 
 Thu, 05 Nov 2026 11:04:01 -0800 (PST)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1b245c4706bsm22924284c88.15.2026.11.05.11.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 11:04:00 -0800 (PST)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>
Subject: [PATCH 2/5] target-info: add target_mask_selected()
Date: Fri,  6 Nov 2026 03:03:43 +0800
Message-ID: <20261105190346.1539-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261105190346.1539-1-luoyonggang@gmail.com>
References: <20261105190346.1539-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1235;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1235.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Return the QEMU_ARCH_* mask of the selected target. System mode
returns QEMU_ARCH_ALL until a target is selected. User mode returns
that target's bit. Tools return 0.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/target-info-init.h | 15 ++++++++++-----
 include/qemu/target-info.h      |  9 +++++++++
 stubs/meson.build               |  1 +
 stubs/target-mask-selected.c    | 13 +++++++++++++
 target-info-def.c               |  3 +++
 target-info-qom.c               | 10 ++++++++++
 6 files changed, 46 insertions(+), 5 deletions(-)
 create mode 100644 stubs/target-mask-selected.c

diff --git a/include/qemu/target-info-init.h b/include/qemu/target-info-init.h
index b7024c9fae..8492986832 100644
--- a/include/qemu/target-info-init.h
+++ b/include/qemu/target-info-init.h
@@ -24,12 +24,17 @@ module_init(do_qemu_init_target_info, MODULE_INIT_TARGET_INFO)
 
 /*
  * User mode does not support multiple targets in the same binary, so just
- * define target_info().
+ * define target_info() and target_mask_selected(). The target is always
+ * selected.
  */
-#define target_info_init(ti_var)        \
-const TargetInfo *target_info(void)     \
-{                                       \
-    return &ti_var;                     \
+#define target_info_init(ti_var)                           \
+const TargetInfo *target_info(void)                        \
+{                                                          \
+    return &ti_var;                                        \
+}                                                          \
+uint64_t target_mask_selected(void)                        \
+{                                                          \
+    return QEMU_ARCH_BIT((ti_var).target_arch);            \
 }
 
 #else /* CONFIG_USER_ONLY */
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 2cd4cc5671..5673d10eba 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -134,4 +134,13 @@ bool target_base_riscv(void);
  */
 bool target_riscv64(void);
 
+/**
+ * target_mask_selected:
+ *
+ * Returns the QEMU_ARCH_* mask of the selected target. System mode
+ * returns QEMU_ARCH_ALL until a target is selected. User mode returns
+ * that target's bit. Tools return 0.
+ */
+uint64_t target_mask_selected(void);
+
 #endif
diff --git a/stubs/meson.build b/stubs/meson.build
index 744fb759a2..49cede8582 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -12,6 +12,7 @@ stub_ss.add(files('monitor-hmp.c'))
 stub_ss.add(files('qapi-event-emit.c'))
 stub_ss.add(files('replay-mode.c'))
 stub_ss.add(files('trace-control.c'))
+stub_ss.add(files('target-mask-selected.c'))
 
 if have_block
   stub_ss.add(files('bdrv-next-monitor-owned.c'))
diff --git a/stubs/target-mask-selected.c b/stubs/target-mask-selected.c
new file mode 100644
index 0000000000..510a515851
--- /dev/null
+++ b/stubs/target-mask-selected.c
@@ -0,0 +1,13 @@
+/*
+ * Tools have no selected target.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target-info.h"
+
+uint64_t target_mask_selected(void)
+{
+    return 0;
+}
diff --git a/target-info-def.c b/target-info-def.c
index bcf9cfe1e4..a992019626 100644
--- a/target-info-def.c
+++ b/target-info-def.c
@@ -9,6 +9,9 @@
 #include "qemu/osdep.h"
 #include "qemu/target-info.h"
 #include "qemu/target-info-def.h"
+#ifdef CONFIG_USER_ONLY
+#include "qemu/base-arch-defs.h"
+#endif
 #include "qemu/target-info-init.h"
 #include "hw/core/boards.h"
 #include "cpu.h"
diff --git a/target-info-qom.c b/target-info-qom.c
index aeeedb7e81..fb4c9835e5 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -9,6 +9,8 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qom/object.h"
+#include "qemu/base-arch-defs.h"
+#include "qemu/target-info.h"
 #include "qemu/target-info-def.h"
 #include "qemu/target-info-init.h"
 #include "qemu/target-info-qom.h"
@@ -40,6 +42,14 @@ const TargetInfo *target_info(void)
     return target_info_ptr;
 }
 
+uint64_t target_mask_selected(void)
+{
+    if (!target_info_ptr) {
+        return QEMU_ARCH_ALL;
+    }
+    return QEMU_ARCH_BIT(target_info_ptr->target_arch);
+}
+
 void target_info_qom_set_target(void)
 {
     g_autoptr(GSList) targets = object_class_get_list(TYPE_TARGET_INFO, false);
-- 
2.55.0.windows.3



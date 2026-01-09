Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB58D26D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFiY-0004kp-LM; Fri, 09 Jan 2026 11:52:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFiK-0004bd-3K
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:51:52 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFiH-0007NJ-Mz
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:51:51 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso41094355e9.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767977508; x=1768582308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dS6ULwpsmYr0/KCFFP8vPbPri0ao4vYOP2/RIiLLaB0=;
 b=XT907BzTOuCkcjDtKGLB2DMrH6ekP7iOm8Q86WLldFc4K/WF7tRcap9dNatc4Hxn23
 r6VVKlfw/XChloqLPMlOiVZ+uyEA9VGlCRtw2cgXwalD8zyNU8ffE8rFo5wmcx1gL9D5
 tBkUdbQtSC9HQE3lRt6qAWq+fSPBMm97ZvPkDsdNuz4PhtaKHVmcoDI4SVHbk/bdI5xp
 h585gNzwBdn73rUpDx/WB6+Ov6DnFpA6aYlW9o2gtRsiFfppN5vzwj3TEr88TnuxQSdS
 iCT4fSc0KvlPZgEb1XfQMf0TW07mamAAqq11x0qDS3Y5TuohovoXQjy8KgMTBM+1mmrH
 NVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767977508; x=1768582308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dS6ULwpsmYr0/KCFFP8vPbPri0ao4vYOP2/RIiLLaB0=;
 b=ZpVJJKxmvVRisOVkjs9Fya+F5QhmdW1TMrG8aRcXH9t+i4ksVxsv2q3I5w51eJpxA1
 /xwWzpaSw42FIcPALWOEzjEtsLKtaAbbuJxTCBE0z3XgvUKe5CkM2vJjdSaaYmvJl3dQ
 BSzIK3ynuhQ/V7jvtFaOWmNq5GaBZeeWGKNXvVnvmk3AkUE/wPGKFnnaqxrFzrhoTqst
 W158iPLvG1uZWQeC4lOLUVymOwgTlKNPdBgz+AuWQLDj3Q8Y9TxOFULrr/JYJHLvvD8E
 Z17TZb8y5tMzwvAg/RrBDpChUYlwqZDjFdLXtyxfiZZi8F4JHefxMBgY7MMQWfhPRshe
 o8UQ==
X-Gm-Message-State: AOJu0YzJrRT1Dx2gfWxqCvAXc6/vFiiKMaRFdY9bfYrjB7L+u6MSkcFQ
 LElIEqrhZWx1N2I/lxPhCo55VWjuwtpSuVZI9yoYpsYDsaOeXNr/9Nrru2VSKDZ+04+uiS0hPfJ
 3Y1RiQ6o=
X-Gm-Gg: AY/fxX6mFM+3Cv4DezXw8m6oZa9wgDs347DcjAg574fxB9PjRwznC9J8f5ft5x4NK9j
 qVzLOeACSp+MPMnPRcMrgxpFqgF2qm1OM7GMw8ZAWe4yy12v98FX5ATHhFS6290KYTDWpH81ppg
 j4JpZ5Q4CWcBXQdXdI3bzqUXu1ZzvhTmvzeiuOmboyhVn8EVi245yxR2uTh4MTjnmVwH5qagJQ8
 mNovHARXNMD48eXLPquWrNRFrbswQF0H+RYXKCt0B3otO9bj0ZxmNrdaql9XsSTrjp2bSMcY7vF
 dLYyfhJNaqPsQy2D4bSbshss8gjKc3lzyLwsr8xlFlFFPhKPAfneVIYvK/IWzWEQt3LcXageXz+
 ZGp6U0D3Wd4kuMhXixVu7M6XaLTOrzGKKHONJ28V64T/FeUHcTGtww6mpMChm24f2GKgfRIP9nY
 c1MEJXR/fYMbi21C6F50DpXaUcx+MLgkQmFuTiHteo26eUGQ7IpY7lN35v6rez
X-Google-Smtp-Source: AGHT+IHYMgkVbg/C7L02tykiHUOk2w0Fjda7YJqP93rRZyN9WMwUzExpfExa8geXCQyLfyMC+qz3hA==
X-Received: by 2002:a05:600c:3b28:b0:477:9b4a:a82 with SMTP id
 5b1f17b1804b1-47d84b41152mr118475255e9.35.1767977507556; 
 Fri, 09 Jan 2026 08:51:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f703a8csm214509905e9.13.2026.01.09.08.51.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:51:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v5 07/22] system/memory: Define address_space_ldst[W] endian
 variants via template
Date: Fri,  9 Jan 2026 17:50:43 +0100
Message-ID: <20260109165058.59144-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109165058.59144-1-philmd@linaro.org>
References: <20260109165058.59144-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Like we do for other LD/ST APIs, use one template to declare and
define all endianness variants of the address_space_ldst[W] methods.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS                                  |  1 +
 include/system/memory_ldst.h.inc             | 21 ++++----
 include/system/memory_ldst_endian.h.inc      | 25 +++++++++
 include/system/memory_ldst_phys.h.inc        | 45 ++++------------
 include/system/memory_ldst_phys_endian.h.inc | 37 ++++++++++++++
 system/memory_ldst.c.inc                     | 54 +++++---------------
 system/memory_ldst_endian.c.inc              | 42 +++++++++++++++
 7 files changed, 135 insertions(+), 90 deletions(-)
 create mode 100644 include/system/memory_ldst_endian.h.inc
 create mode 100644 include/system/memory_ldst_phys_endian.h.inc
 create mode 100644 system/memory_ldst_endian.c.inc

diff --git a/MAINTAINERS b/MAINTAINERS
index ad1de7c0478..2c928f5b38a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3270,6 +3270,7 @@ F: system/ioport.c
 F: system/memory.c
 F: system/memory_mapping.c
 F: system/physmem.c
+F: system/memory_ldst*
 F: system/memory-internal.h
 F: system/ram-block-attributes.c
 F: scripts/coccinelle/memory-region-housekeeping.cocci
diff --git a/include/system/memory_ldst.h.inc b/include/system/memory_ldst.h.inc
index 173164fee3a..73c0366a247 100644
--- a/include/system/memory_ldst.h.inc
+++ b/include/system/memory_ldst.h.inc
@@ -19,24 +19,16 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-uint16_t glue(address_space_lduw, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
 uint32_t glue(address_space_ldl, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
 uint64_t glue(address_space_ldq, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-void glue(address_space_stw, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint16_t val, MemTxAttrs attrs, MemTxResult *result);
 void glue(address_space_stl, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
 void glue(address_space_stq, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
 uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-uint16_t glue(address_space_lduw_le, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-uint16_t glue(address_space_lduw_be, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
 uint32_t glue(address_space_ldl_le, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
 uint32_t glue(address_space_ldl_be, SUFFIX)(ARG1_DECL,
@@ -47,10 +39,6 @@ uint64_t glue(address_space_ldq_be, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
 void glue(address_space_stb, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint8_t val, MemTxAttrs attrs, MemTxResult *result);
-void glue(address_space_stw_le, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint16_t val, MemTxAttrs attrs, MemTxResult *result);
-void glue(address_space_stw_be, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint16_t val, MemTxAttrs attrs, MemTxResult *result);
 void glue(address_space_stl_le, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
 void glue(address_space_stl_be, SUFFIX)(ARG1_DECL,
@@ -60,6 +48,15 @@ void glue(address_space_stq_le, SUFFIX)(ARG1_DECL,
 void glue(address_space_stq_be, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
 
+#define ENDIANNESS
+#include "system/memory_ldst_endian.h.inc"
+
+#define ENDIANNESS              _le
+#include "system/memory_ldst_endian.h.inc"
+
+#define ENDIANNESS              _be
+#include "system/memory_ldst_endian.h.inc"
+
 #undef ARG1_DECL
 #undef ARG1
 #undef SUFFIX
diff --git a/include/system/memory_ldst_endian.h.inc b/include/system/memory_ldst_endian.h.inc
new file mode 100644
index 00000000000..3f216197663
--- /dev/null
+++ b/include/system/memory_ldst_endian.h.inc
@@ -0,0 +1,25 @@
+/*
+ *  Physical memory access endian templates
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *  Copyright (c) 2015 Linaro, Inc.
+ *  Copyright (c) 2016 Red Hat, Inc.
+ *  Copyright (c) 2025 Linaro Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define ADDRESS_SPACE_LD(size) \
+    glue(glue(address_space_ld, size), glue(ENDIANNESS, SUFFIX))
+#define ADDRESS_SPACE_ST(size) \
+    glue(glue(address_space_st, size), glue(ENDIANNESS, SUFFIX))
+
+uint16_t ADDRESS_SPACE_LD(uw)(ARG1_DECL, hwaddr addr,
+                              MemTxAttrs attrs, MemTxResult *result);
+void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,
+                         MemTxAttrs attrs, MemTxResult *result);
+
+#undef ADDRESS_SPACE_LD
+#undef ADDRESS_SPACE_ST
+
+#undef ENDIANNESS
diff --git a/include/system/memory_ldst_phys.h.inc b/include/system/memory_ldst_phys.h.inc
index db67de75251..71c2e64ff0f 100644
--- a/include/system/memory_ldst_phys.h.inc
+++ b/include/system/memory_ldst_phys.h.inc
@@ -19,12 +19,6 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-static inline uint16_t glue(lduw_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_lduw, SUFFIX)(ARG1, addr,
-                                            MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 static inline uint32_t glue(ldl_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
 {
     return glue(address_space_ldl, SUFFIX)(ARG1, addr,
@@ -37,12 +31,6 @@ static inline uint64_t glue(ldq_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
                                            MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
-static inline void glue(stw_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint16_t val)
-{
-    glue(address_space_stw, SUFFIX)(ARG1, addr, val,
-                                    MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 static inline void glue(stl_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
 {
     glue(address_space_stl, SUFFIX)(ARG1, addr, val,
@@ -61,18 +49,6 @@ static inline uint8_t glue(ldub_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
                                             MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
-static inline uint16_t glue(lduw_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_lduw_le, SUFFIX)(ARG1, addr,
-                                               MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-static inline uint16_t glue(lduw_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_lduw_be, SUFFIX)(ARG1, addr,
-                                               MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 static inline uint32_t glue(ldl_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
 {
     return glue(address_space_ldl_le, SUFFIX)(ARG1, addr,
@@ -103,18 +79,6 @@ static inline void glue(stb_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val)
                                     MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
-static inline void glue(stw_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint16_t val)
-{
-    glue(address_space_stw_le, SUFFIX)(ARG1, addr, val,
-                                       MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-static inline void glue(stw_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint16_t val)
-{
-    glue(address_space_stw_be, SUFFIX)(ARG1, addr, val,
-                                       MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 static inline void glue(stl_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint32_t val)
 {
     glue(address_space_stl_le, SUFFIX)(ARG1, addr, val,
@@ -139,6 +103,15 @@ static inline void glue(stq_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t va
                                        MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
+#define ENDIANNESS
+#include "system/memory_ldst_phys_endian.h.inc"
+
+#define ENDIANNESS  _le
+#include "system/memory_ldst_phys_endian.h.inc"
+
+#define ENDIANNESS  _be
+#include "system/memory_ldst_phys_endian.h.inc"
+
 #undef ARG1_DECL
 #undef ARG1
 #undef SUFFIX
diff --git a/include/system/memory_ldst_phys_endian.h.inc b/include/system/memory_ldst_phys_endian.h.inc
new file mode 100644
index 00000000000..25ab52a88d9
--- /dev/null
+++ b/include/system/memory_ldst_phys_endian.h.inc
@@ -0,0 +1,37 @@
+/*
+ *  Physical memory access endian templates
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *  Copyright (c) 2015 Linaro, Inc.
+ *  Copyright (c) 2016 Red Hat, Inc.
+ *  Copyright (c) 2025 Linaro Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define LD_PHYS(size) \
+    glue(glue(ld, size), glue(ENDIANNESS, glue(_phys, SUFFIX)))
+#define ADDRESS_SPACE_LD(size) \
+    glue(glue(address_space_ld, size), glue(ENDIANNESS, SUFFIX))
+
+#define ST_PHYS(size) \
+    glue(glue(st, size), glue(ENDIANNESS, glue(_phys, SUFFIX)))
+#define ADDRESS_SPACE_ST(size) \
+    glue(glue(address_space_st, size), glue(ENDIANNESS, SUFFIX))
+
+static inline uint16_t LD_PHYS(uw)(ARG1_DECL, hwaddr addr)
+{
+    return ADDRESS_SPACE_LD(uw)(ARG1, addr, MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+static inline void ST_PHYS(w)(ARG1_DECL, hwaddr addr, uint16_t val)
+{
+    ADDRESS_SPACE_ST(w)(ARG1, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
+#undef LD_PHYS
+#undef ST_PHYS
+#undef ADDRESS_SPACE_LD
+#undef ADDRESS_SPACE_ST
+
+#undef ENDIANNESS
diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index d5776678edf..c37a07b4f4a 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -240,27 +240,6 @@ static inline uint16_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
     return val;
 }
 
-uint16_t glue(address_space_lduw, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_lduw_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                                     DEVICE_NATIVE_ENDIAN);
-}
-
-uint16_t glue(address_space_lduw_le, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_lduw_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                                     DEVICE_LITTLE_ENDIAN);
-}
-
-uint16_t glue(address_space_lduw_be, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_lduw_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                       DEVICE_BIG_ENDIAN);
-}
-
 /* warning: addr must be aligned */
 static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs,
@@ -401,27 +380,6 @@ static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
     RCU_READ_UNLOCK();
 }
 
-void glue(address_space_stw, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint16_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stw_internal, SUFFIX)(ARG1, addr, val, attrs, result,
-                                             DEVICE_NATIVE_ENDIAN);
-}
-
-void glue(address_space_stw_le, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint16_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stw_internal, SUFFIX)(ARG1, addr, val, attrs, result,
-                                             DEVICE_LITTLE_ENDIAN);
-}
-
-void glue(address_space_stw_be, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint16_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stw_internal, SUFFIX)(ARG1, addr, val, attrs, result,
-                               DEVICE_BIG_ENDIAN);
-}
-
 static inline void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs,
     MemTxResult *result, enum device_endian endian)
@@ -486,6 +444,18 @@ void glue(address_space_stq_be, SUFFIX)(ARG1_DECL,
                                              DEVICE_BIG_ENDIAN);
 }
 
+#define ENDIANNESS
+#define DEVICE_ENDIANNESS       DEVICE_NATIVE_ENDIAN
+#include "memory_ldst_endian.c.inc"
+
+#define ENDIANNESS              _le
+#define DEVICE_ENDIANNESS       DEVICE_LITTLE_ENDIAN
+#include "memory_ldst_endian.c.inc"
+
+#define ENDIANNESS              _be
+#define DEVICE_ENDIANNESS       DEVICE_BIG_ENDIAN
+#include "memory_ldst_endian.c.inc"
+
 #undef ARG1_DECL
 #undef ARG1
 #undef SUFFIX
diff --git a/system/memory_ldst_endian.c.inc b/system/memory_ldst_endian.c.inc
new file mode 100644
index 00000000000..e1ae44ca232
--- /dev/null
+++ b/system/memory_ldst_endian.c.inc
@@ -0,0 +1,42 @@
+/*
+ *  Physical memory access endian templates
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *  Copyright (c) 2015 Linaro, Inc.
+ *  Copyright (c) 2016 Red Hat, Inc.
+ *  Copyright (c) 2025 Linaro Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define ADDRESS_SPACE_LD(size) \
+    glue(glue(address_space_ld, size), glue(ENDIANNESS, SUFFIX))
+#define ADDRESS_SPACE_LD_INTERNAL(size) \
+    glue(glue(address_space_ld, size), glue(_internal, SUFFIX))
+
+#define ADDRESS_SPACE_ST(size) \
+    glue(glue(address_space_st, size), glue(ENDIANNESS, SUFFIX))
+#define ADDRESS_SPACE_ST_INTERNAL(size) \
+    glue(glue(address_space_st, size), glue(_internal, SUFFIX))
+
+uint16_t ADDRESS_SPACE_LD(uw)(ARG1_DECL, hwaddr addr,
+                              MemTxAttrs attrs, MemTxResult *result)
+{
+    return ADDRESS_SPACE_LD_INTERNAL(uw)(ARG1, addr, attrs, result,
+                                         DEVICE_ENDIANNESS);
+}
+
+void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,
+                         MemTxAttrs attrs, MemTxResult *result)
+{
+    ADDRESS_SPACE_ST_INTERNAL(w)(ARG1, addr, val, attrs, result,
+                                 DEVICE_ENDIANNESS);
+}
+
+#undef ADDRESS_SPACE_LD
+#undef ADDRESS_SPACE_LD_INTERNAL
+#undef ADDRESS_SPACE_ST
+#undef ADDRESS_SPACE_ST_INTERNAL
+
+#undef ENDIANNESS
+#undef DEVICE_ENDIANNESS
-- 
2.52.0



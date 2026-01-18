Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE77EC98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 19:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhYZS-00069W-Rn; Sun, 18 Jan 2026 14:36:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYYz-0005qm-S2
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:35:53 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYYw-0006fN-0B
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:35:53 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42fb5810d39so2860881f8f.2
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 11:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768764946; x=1769369746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/7rQibL1Ys0LV+Qe1gOPgNRuzLQkR+Ce7UdPV5JDgms=;
 b=a/3tscmxbWwh1WjLuC0oU19Cpkc3RIh/Ea+76RlXk2nPPq8Cmcn0Oy0oOp2nIc3etb
 MC7/+O/y86y6V36yPuNuODulK2GDSWmRAlDvfWOb4H2BVRdt4k53eyV9RysC60Ckz3+X
 uEStLxvu+PhtZCUe/uL2tHcfr1r4+Fb2ZJVDipf/KwyaMZQiAbibK7IHunwUuBHJ+2SN
 ORCHNl4rZRL1icCL35VVhmP8VY8/eFXadJ3BpxsXpzoakrXsVGwv3O4LyON85Lh0BHwH
 E8pMdnOfGiaq2jnk6ffv4NR+ldyOXNTfZ5zA4Hk2y0XzWgjpnJCNtzlmiVAnOxr5RYVS
 HGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768764946; x=1769369746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/7rQibL1Ys0LV+Qe1gOPgNRuzLQkR+Ce7UdPV5JDgms=;
 b=Gt7jjqg37Si1NJLuFJM+/ShTkbm0gcd/oT/MVu46PJLFSets6sb6R+wVeHgz20Qn8n
 EQyNft9HiKB29WRuxHTY9rNWI62sLZ+5K4dkesWNgSsah1FSjHQ80I/tmvA6q7wiCBvx
 33LHGA7es0Xeqy2yL0xzZOR9jjs8ewm5s/sSe2Wmh5e5hFPfAp7ipv3yzjGNHfEGOX5S
 fRtAf6pjep1lfcB1jTHh4ssLNUhHZkbu9HnvpoKaBUls2n78gYdpzw//xwuXqFeGCsY6
 mxAdoCDbM1EuhnhoYTUfeXSSfVFHtrVAXcQKQ1ukltY948w+OdwbVNvz9VVwF5ISynGd
 62oA==
X-Gm-Message-State: AOJu0Yx2Aq9AO9s1TzN8T1cdFa4Xk9/CtHXw2W0FNVN2zQSdInFFZO3T
 mdlFjHsvLDHe9sn6j80gDtrrDj9tdIWQslYDQZFLVBX9aa2lle5aBhy8v7soCD4ipE7Z4pOq6NN
 /hH+dXqk=
X-Gm-Gg: AY/fxX75Hw/wSHNI8JsSpifAMAxzpgSX4LOI9OSWND2aGg4FB6ASVXvROJ20cl/a+VD
 YRhF261Yc/5GGByoqNhMRJ6OqMZkcGgY4y1KDj4hba+4t5tmzYp3Td1KjS+5kUkItDG1V00SMYh
 XliCe6sNIEJX68+p3ZjD5OXmE9qfqrkfGTQP0BLYq6zRW8ZTKK+XCpyKzFEnkw2hUwz8dEPtaPg
 CcmRIPEJSkvUl4Wxcgw0ladCwYER3jRbt9JJx1S92AiU/gYr6YG13imQ7Hz3XgEiV0wycn/2eI3
 AlvAzhM7rYo+PufihE3NaEpyzEZpJdxm24HdjExvdkgXf1KiZ9Vum6S3QOHpXkqGHg/dOY9jdZj
 AmOErcDKo0B4QAtwWoO2VCQx6c7oDBxZ/bMRFtsWVaR6Z2b3l+xYiaoxxjEY6gN+WtOz9GFj24S
 Tx2C6YmSBrnZGJ8AamLSz6idA1lZsfi7Uu103pE566bwhJ/UjlVAwGKVziJ7c9
X-Received: by 2002:a5d:5886:0:b0:430:ff0c:35fb with SMTP id
 ffacd0b85a97d-4356a05c404mr11709911f8f.52.1768764946092; 
 Sun, 18 Jan 2026 11:35:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992201csm19056835f8f.2.2026.01.18.11.35.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Jan 2026 11:35:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 05/18] system/memory: Define address_space_ldst[W] endian
 variants via template
Date: Sun, 18 Jan 2026 20:34:55 +0100
Message-ID: <20260118193509.42923-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260118193509.42923-1-philmd@linaro.org>
References: <20260118193509.42923-1-philmd@linaro.org>
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
index de8246c3ffd..a99a629d722 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3296,6 +3296,7 @@ F: system/ioport.c
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



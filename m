Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD06D715EE
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 18:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjiOB-0004NX-4w; Sat, 24 Jan 2026 13:29:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjiO9-0004Mg-SZ
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 13:29:37 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjiO8-0003hj-2T
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 13:29:37 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-81ecbdfdcebso1730873b3a.1
 for <qemu-devel@nongnu.org>; Sat, 24 Jan 2026 10:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769279374; x=1769884174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yGgLGlFAGuY8onq4gi0buc3E93WA2jrqRIHzedx5bAc=;
 b=ZNlPE13o2/hyZzWaAMSIx3Q/ezwlmhOwZj21QyG2yXpkfeS/c/MDqacvgnxnANf2Gq
 nP8uHq1pkGoEde7k4MhzfwhW1D0yuhJeNCBYYWcQW0xXZjvnkErtQrrpMxLlYAXq+NTl
 zlDvnIJ/CTZuogDRuWvnMY4E3y3+A1gfHrkIc4FhAk5VwPa4yvSTBYoqLvK6u9USg5CX
 AdGCzIW7AhZRYP0vOVz70e/mCnCmCsTTMKuHpfBj6VNU3Ma4CWcgDuMu9Y7g8PAzRIHH
 fLf5Wib8URLWuQoP6lTrNUZisb2vkkWPa6KDDq5K8sFAXUs1alCAW2TNBe4ksf/zguO2
 SwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769279374; x=1769884174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yGgLGlFAGuY8onq4gi0buc3E93WA2jrqRIHzedx5bAc=;
 b=XlWBE+iTGGAym9wWPo8EkMeC2S6f1JVsw0IZUwGAmjsi8IizC0QND7mMWGM5qw/6sB
 4B2XguaRN+T1vLRAgxZiqkRIPri2p3S8ASpZVzUNPz+cSI8gPSPhMZiJodFtxjWUGapJ
 p+Vuys8XqupFEiJWwwEAuHHAOaUm7r9A0C+7pOfbEctXrfhmMM4Jd/zrzxe5ijTiX5hm
 01OF7g5WdIA6u9BUfW2ILTz8wYyo4LSBMp8EuQM6NFsQ4NYrf0RVSMpmTCYgPiFHBopu
 NFeVi2UYz3ixUa4zS5cqzWRmNYsODkuBmlV5jhi6bEBVuFcS3zyuqFr/9HpC9MVgsp5y
 Qafg==
X-Gm-Message-State: AOJu0YzieehsCpsCJYE4gMwWsU90623MfiR90DuIYtE/DIIBQyF3FMor
 EvMFI4fYF9uje/jr7GoQJJbVlGN2KMtb3d0h0WAu90O81VGUFJHbU3DxSUneqdGzeyO/iVXnBJB
 lVjbmqgc=
X-Gm-Gg: AZuq6aKPI+dUPF10nZPxch1aI+Num6stxAzLWyEDun02NJIdYlX/8q8/oVJvXh73g1z
 w0IgsHnj4mPQf2Iw5szt8KHNdmDi9Mekhk7Vh6tDf8o4lKK+NfFSuCSxxx7rf5XVX+xMFj+/rIw
 Y4IwyvXQDwVSCQ0iBSwFsf3cBM/Gewokn/mml34xmuVZjzglD6cLXaz7AaWa2HSbWEggmDzF+dG
 NovhyMVNSntjOfttSQ42wYyGM3nt/doXuD/97IIyFHSqIdXMirdZGvcrc3gABXeviBfGpizm7jR
 cbQCOfix7htJYG33aTakFVw3ndzuN3LMs1ZNU/GvtFtH4qxgus8qdt9Dcma0jq4NUN8g3wpC1lY
 XJUIDyIwJSsFaV/0/Rr0Cibs1WrAvE6ahloNB9mQcH9nW2DySsoCB1Gu9fFoJOgBCO/Ada6a8jy
 HdIpqjnUoPsyCK0Xa5WJUP3MYdNRO1pjSS4mAhG0naDAoAxPJ+8rBOlX1+sQ4b9MBB
X-Received: by 2002:a05:6a00:14c8:b0:81f:9b97:5e4f with SMTP id
 d2e1a72fcca58-82317e6b4b3mr5738221b3a.47.1769279374332; 
 Sat, 24 Jan 2026 10:29:34 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8231871d432sm5296485b3a.42.2026.01.24.10.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Jan 2026 10:29:33 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v4 05/11] tests/tcg/plugins/mem.c: remove dependency on qemu
 headers
Date: Sat, 24 Jan 2026 10:29:15 -0800
Message-ID: <20260124182921.531562-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
References: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

This plugin uses endianness conversion primitives from QEMU headers. As
next commit will strongly isolate plugins code from those headers, those
primitives can't be used anymore.

glib.h provides such primitives:
https://docs.gtk.org/glib/conversion-macros.html#byte-order-conversion

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/plugins/mem.c | 59 ++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 36 deletions(-)

diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
index 9649bce99ca..7d64e7018f2 100644
--- a/tests/tcg/plugins/mem.c
+++ b/tests/tcg/plugins/mem.c
@@ -12,16 +12,7 @@
 #include <stdio.h>
 #include <glib.h>
 
-/*
- * plugins should not include anything from QEMU aside from the
- * API header. However as this is a test plugin to exercise the
- * internals of QEMU and we want to avoid needless code duplication we
- * do so here. bswap.h is pretty self-contained although it needs a
- * few things provided by compiler.h.
- */
-#include <compiler.h>
 #include <stdbool.h>
-#include <bswap.h>
 #include <qemu-plugin.h>
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
@@ -152,56 +143,52 @@ static void update_region_info(uint64_t region, uint64_t offset,
         ri->reads++;
     }
 
+    void *ri_data = &ri->data[offset];
     switch (value.type) {
     case QEMU_PLUGIN_MEM_VALUE_U8:
+    {
+        uint8_t val = value.data.u8;
+        uint8_t *p = ri_data;
         if (is_store) {
-            ri->data[offset] = value.data.u8;
-        } else if (ri->data[offset] != value.data.u8) {
-            unseen_data = true;
+            *p = val;
+        } else {
+            unseen_data = *p != val;
         }
         break;
+    }
     case QEMU_PLUGIN_MEM_VALUE_U16:
     {
-        uint16_t *p = (uint16_t *) &ri->data[offset];
+        uint16_t val = be ? GUINT16_FROM_BE(value.data.u16) :
+                            GUINT16_FROM_LE(value.data.u16);
+        uint16_t *p = ri_data;
         if (is_store) {
-            if (be) {
-                stw_be_p(p, value.data.u16);
-            } else {
-                stw_le_p(p, value.data.u16);
-            }
+            *p = val;
         } else {
-            uint16_t val = be ? lduw_be_p(p) : lduw_le_p(p);
-            unseen_data = val != value.data.u16;
+            unseen_data = *p != val;
         }
         break;
     }
     case QEMU_PLUGIN_MEM_VALUE_U32:
     {
-        uint32_t *p = (uint32_t *) &ri->data[offset];
+        uint32_t val = be ? GUINT32_FROM_BE(value.data.u32) :
+                            GUINT32_FROM_LE(value.data.u32);
+        uint32_t *p = ri_data;
         if (is_store) {
-            if (be) {
-                stl_be_p(p, value.data.u32);
-            } else {
-                stl_le_p(p, value.data.u32);
-            }
+            *p = val;
         } else {
-            uint32_t val = be ? ldl_be_p(p) : ldl_le_p(p);
-            unseen_data = val != value.data.u32;
+            unseen_data = *p != val;
         }
         break;
     }
     case QEMU_PLUGIN_MEM_VALUE_U64:
     {
-        uint64_t *p = (uint64_t *) &ri->data[offset];
+        uint64_t val = be ? GUINT64_FROM_BE(value.data.u64) :
+                            GUINT64_FROM_LE(value.data.u64);
+        uint64_t *p = ri_data;
         if (is_store) {
-            if (be) {
-                stq_be_p(p, value.data.u64);
-            } else {
-                stq_le_p(p, value.data.u64);
-            }
+            *p = val;
         } else {
-            uint64_t val = be ? ldq_be_p(p) : ldq_le_p(p);
-            unseen_data = val != value.data.u64;
+            unseen_data = *p != val;
         }
         break;
     }
-- 
2.47.3



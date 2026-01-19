Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292DFCCF2DE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 19:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhufN-0006q1-Ri; Mon, 19 Jan 2026 14:11:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhufJ-0006n1-OB
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:11:54 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhufH-0001U0-LB
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:11:53 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a09d981507so34932025ad.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 11:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768849910; x=1769454710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yGgLGlFAGuY8onq4gi0buc3E93WA2jrqRIHzedx5bAc=;
 b=y1DBe5wPVwa3sJyhqxWw3dBujgbsJuVIAPuwbu55jR7G29n7ZrIbEQ7Z01jM8jAXRF
 1mqly2rjMBkZYkqKNQe7Z+7uP5ngCnncMERPcFUNxBOYE7EB7drV1RnFYqzghaUwQJgj
 +sGExEB5mnLbdk3jPiIHzzbzZSLF386Ju7XuBPBe7XJl83f4Qi/JBPszIN7gl8qUW0T7
 Kbl1fjQkcqD1m3VDiFF/hfWibCuuQXBXkW6q5RgRKqyW05kOwBPvojVSi89F+gfyStw2
 ZoawKU9Bjmtj2lwoev6jMsoLRb8DD06Y1acxyQaXSE9OLlYz4O08d2qX3HwaNES9nVIe
 vvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768849910; x=1769454710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yGgLGlFAGuY8onq4gi0buc3E93WA2jrqRIHzedx5bAc=;
 b=ngu4XJ9IojGufUSXsfQhtfew3JtE+P/hp9O6/oLmR9pCq6JUsrAgD8qT7iMfOU5KXX
 RZIk/RMYdW8kx7eKULC8Xe0Mf1b1dWmTU6bvbrcrAwWzOjXV3tx8aK7ZayAY1rSYh+7B
 du4D1pOfTMsRl09A0ByIfqXYyWoKXKRuDh8Fo/X970IjrgJN/wf6PmDA704/4lExwgLm
 g3NfPg2paBEyJuJ7ghonCMxkuL9w3BQ+v9WSvSJFhX8BbjgOnkgvrZlPV53vwv89e764
 YZj2lmtC1eSU6Iqpxwi7tcRU+rJKgWu3+lN9JoksMxyIAn0x970F7kCYdS1hfyurv9hR
 shaw==
X-Gm-Message-State: AOJu0Yx0W6FxqbjuTDucUH50SuLrDyXz8W4x2p7qukfibjvxVjYN5uLL
 qP5OVbcwpsj/QYvmPQJUyjMbFGMOhfvH9DEnzBJsEcLicokOGdUPVZRowIIwsNc9PaGV3C28RzQ
 H4EAn
X-Gm-Gg: AZuq6aJSOGR5CBLQloCYbO5KeOeV2R90kDOiVK/I0XhNREAvS7WBVBULgeyX9aNM0ie
 fsccQ6F8xl2FJoXJ0XnOrFlfaD3LkVjQIjoethAsSs0kqflBXwxLAKFLjFxQGexfdYKUI0/MkxJ
 +f+wmJ7x2STWjHyk1RhIbKugO3ixSTMfJWJAYH7BeFIZfSYz2mu4rLvv/a9+y3aRFlP4vRUja1q
 cP+qUA81kykQ8inEbdB+0VVyg2qq6UT5U2dg3Kq5NrK5Wnpdl0UBpEf2vQzXG1AUt9AfRUcZ6fu
 dofvuN1NqPvAc7ImvNTYY3GmRWFeHzNG5g8jWDjBXePioBSkv1Qn7BnHk1orHpqTbi+bpuXdGQP
 wRi8VunULvQvIJ6GJ5l5chhFc5C75hZdJQ0RBvOpscX2NALNZrishKxBwOCG7GvQ3P7zLCyqHpk
 rAFDD+nNGZrgoo9aooLMk7VSmFVFc1WBEcIEMa8GkJbxi8QKwos+ahcx7incULu7YS
X-Received: by 2002:a17:902:c407:b0:2a0:99f7:67b4 with SMTP id
 d9443c01a7336-2a71756c272mr119357085ad.8.1768849909834; 
 Mon, 19 Jan 2026 11:11:49 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a719415f0asm47011795ad.89.2026.01.19.11.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 11:11:49 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 05/11] tests/tcg/plugins/mem.c: remove dependency on qemu
 headers
Date: Mon, 19 Jan 2026 11:11:31 -0800
Message-ID: <20260119191138.811069-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260119191138.811069-1-pierrick.bouvier@linaro.org>
References: <20260119191138.811069-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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



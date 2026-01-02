Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7C9FA3755
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 21:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbn0e-0006ml-Kg; Fri, 02 Jan 2026 16:48:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbmzi-0006fw-Ny
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 16:47:44 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbmzg-0000Jb-SH
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 16:47:38 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-34c7d0c5ddaso134155a91.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 13:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767390455; x=1767995255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JDaUMXNl3FZj4WBz+kjiCzD7DUw0YTyswTIoriwfuY8=;
 b=M3eo6WKNwfJ96eWcRcHQx3TUNiLxhpg4C8PT5qT2qDllqhOBftFem8UDBLFwujaIGH
 Vzv84uhC9A2MurfFc2PsAw/bWENGY7mpEj3wbHCr34zpT1LtZgSLPfSh6AJirmPOZV8Y
 6tFg4W3Yv33bH8KjRa+oBWghIpLNft3xcopDoVa6+8o9JiyAYoLPDOjkNYg7urHxWIta
 bj7ChkTY8xr/F0tXhpkUdSSNG4Y0MiWDEALo8ZUvz2W6iDkV0otlq4TBUCEkKh7g7VF5
 Pgs+0gFgsQ5ZOATe6Y1PjPtixmLD0ya0EmaSpHAaGbW8fJANJrkkzTCEk97ugUqoD//d
 gC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767390455; x=1767995255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JDaUMXNl3FZj4WBz+kjiCzD7DUw0YTyswTIoriwfuY8=;
 b=BFtKxwuMXLlXg6dTW+cFUQ5Y+IDcUg7G2j+XRUeRThUktui79eaK9AbTZ+mftIVFBn
 gHqXJCLKiYzUo1x2f2REq6NBIiJwlcc4FPzGq2KhdSKDQyZrz4Qnv7W3gB5Cy4drxZDL
 jM9w4oCZwTWxp11tli7qJO6OV5JJUTmnNxs39Mcf5kN47R4VuDXchrCCVyMHQIrH95zZ
 VVyMF6sBnJlSf6HKfVcKnLGAQ/FF3HgC+JtS+uTs9MTlHbzTPLYdVxXDzgtwwkXnCA8w
 IWX2uZNHuKxvQeTHELyarj9shSFIt3ysYOMdodK03uq4tQxFIULqH+lEXC1y/0/iy5Q0
 A5gg==
X-Gm-Message-State: AOJu0YzDMO10lI2qcrS1gcBmSDgt83jgPh7STpTVvr7jsx/t+sMd5wv9
 QNxNFx/3Ge0yurBWC/Lcu+CbpXuMGKLvboUeLWKMQD4X99oB4LGkVjsml2DG5DxAptFS4jhdCbO
 pzUsN
X-Gm-Gg: AY/fxX7Hlhcc8wwnnuzQbCI54Bl2stj9j5uyts3wLAf7NEo4QB3I8oO749n/beffOQS
 G4jjCq6jTk2QpF7F8fWdxAvw7M4tcRx9CeekqnnptFfguz8aDYNGaKveRLJ+eaHfw6RGnM4Hx8N
 Kz2RNLSxoHtkjoiw38Avn2tX8nYtb2yHlTS5+xUykUZKVii30QNFg/q3GaaDpnxvqVO+oDu0wCz
 gb2MhZf0RJ6mfzJbfyYG39aAvKua0v9i9OKPfcdBO7PVfBAwu9Y68K2p1//IYutJbRTcW4qouS2
 x5bbY9X0JE1h9L/nu6OrOtzY4OMhN3cIaFoYS0V8WXS931V0rhTyreBxOqwlxrB746ZFbt68Ept
 BMQ0SHTlu0kO6CbTUsqOMvBkS61SxRwFQz8lay92khp2DqvksQWJOALvh89O29a4wpwDRLhYS0t
 tCPKlUErpQhNFXnttu+ylphGQeDyj0ksYeNioRDg7MwvFkLAtPpK3H6HBkC83n79ZT
X-Google-Smtp-Source: AGHT+IG/xSh91TxI0VCaXOESTfemCoMwAoINTDHrQBTpUzWJE3NcUqg56/BXMs0ELuXg32Poffk6rQ==
X-Received: by 2002:a17:90b:5867:b0:34e:6e7d:7e73 with SMTP id
 98e67ed59e1d1-34f453c9e48mr732515a91.11.1767390454765; 
 Fri, 02 Jan 2026 13:47:34 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f476f8f3fsm62925a91.5.2026.01.02.13.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 13:47:34 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 05/11] tests/tcg/plugins/mem.c: remove dependency on qemu
 headers
Date: Fri,  2 Jan 2026 13:47:18 -0800
Message-ID: <20260102214724.4128196-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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

This plugin uses endianness conversion primitives from QEMU headers. As
next commit will strongly isolate plugins code from those headers, those
primitives can't be used anymore.

glib.h provides such primitives:
https://docs.gtk.org/glib/conversion-macros.html#byte-order-conversion

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



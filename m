Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE63D46BF0
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 01:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlGtI-0000AE-2X; Wed, 28 Jan 2026 20:32:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGt6-0008Sj-KY
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:32:04 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGt3-000397-E8
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:32:00 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-bc274b8b15bso246848a12.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 17:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769650316; x=1770255116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yGgLGlFAGuY8onq4gi0buc3E93WA2jrqRIHzedx5bAc=;
 b=AV9hH9kUMpXAxD/2wp6Mh9VPTkuRiZui+Sbr4JLE35wvpJjT4b/NGhIvB3L/kvmiS8
 2lLI3/BoaRd2N9iEr2y6b6tiUbM5sHXGwGuh1Fvq02uuP1agrVg0GaoE8976YWC45pSi
 2NM5JcnIxMSZE4j4McM8iMnHWJU0K6y72yQUvc/8ShE2iKhYWtAb4ZsunvihuHNKvw9y
 8IHOXBX/OcwAKcBfGA4TBQBOh/gUZdUKhSx+JZBHw9W7jOn1DxdUBDTFsBWxQ9AqEFFr
 9xt/m/1kPwqDR6JeG3D/uTIn+SzB3xi060oDf+etMC9EK4/yETzpaCNtC/3WGnw8BYrU
 bP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769650316; x=1770255116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yGgLGlFAGuY8onq4gi0buc3E93WA2jrqRIHzedx5bAc=;
 b=ZMi8Gld7BKa97Rkx8RpI43KPjbhoxRUnRTtAzdIODUkNamtm9MpGMmXuPfr/voZhHF
 AbcNSuBLsdL+6Th2Mc5don0i22HC4dg9liMR/ZAbANeuIaXSI6vFouiaD+PtdGthEghO
 Y2mkkB3dOFFHEOCTFFz0hd5uyEhacN5gyJQUM12B3ubXV0JgeRAU0I3SkCoL0yIjSX8z
 gxYiqenFpw55CeRaGi87B/PFulYKM++XQm20W16lKcMvytl3uHAp+qHxjCjWs/JywDui
 reLtAOqH+ywGTrYyudIrdzw/dq1q3YIH1UKX0meT+ZA75EiB+QIdaSIwq7ti7zk7ZVyq
 N8/w==
X-Gm-Message-State: AOJu0Yyfr7XzaBLYrre0j2eGaNzKqVsjWVzDi27X+ND1zBHyD2IUVF09
 DdMRSNbfu1WdccK7jlDXVPW/eNdvtdEqLFTTKV0tZpvDvsxd9r1D+ukvCP0ME6u3wbJNRgNj4Ca
 sRT8v
X-Gm-Gg: AZuq6aKyl925zg2dhazPK6uGol5hD1d2o3vTdpOBni1ZtYj3cZ2+FB51BXjnEEYvh3w
 O/MN91i6DMkBzehSDj7lPHZHP/1S7HNiZKELTFX4IZQjbFMfF0LtotZHWZUhpu8SysEmGTTHAey
 ecWAlAD7NAyEeDuYbUSQAoAPFoN3tf9Hu6LdaSadyLdzBg48ZwuTgunmBuACGUG+npswHrCix87
 n7vYWwtPXfXpxAYIihsm5AaUrV86mhdBRN+7qBkvNpfRx0X2inu8Do+gOAF4CiHWWcLATXp9c8t
 HKR2vreIjSQK8k6nDDZutN2YQUcMHKEFMvxXKoQMUgw3lQq0m3/ovlRpz8+7/A+bnzd+eRDg/kq
 qUWVuT/eaLffsHXgsEAqqHL1kwjxis3UkosUAurP4l5cACsmJCDXZjRiFDnT1mvS6q51HjhbepP
 4gmchTI8+OJDall5vkvsf4k8T9COmOeOyFcYCI/BiVDNOon/LX+x+XxBtgHxI8zQ3t
X-Received: by 2002:a17:90b:560f:b0:347:5ddd:b2d1 with SMTP id
 98e67ed59e1d1-353feda7677mr6623842a91.27.1769650315803; 
 Wed, 28 Jan 2026 17:31:55 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f61e0007sm6627143a91.12.2026.01.28.17.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:31:55 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/20] tests/tcg/plugins/mem.c: remove dependency on qemu
 headers
Date: Wed, 28 Jan 2026 17:31:27 -0800
Message-ID: <20260129013134.3956938-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
References: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
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



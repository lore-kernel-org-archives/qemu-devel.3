Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FC5F30951
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 12:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy7OU-0005c4-8p; Thu, 05 Mar 2026 07:01:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy7OG-0005ad-2P
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 07:01:18 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy7OA-00068P-Cv
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 07:01:15 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48336a6e932so49686045e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 04:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772712066; x=1773316866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=El3/8uv1vuMwhH9zANUH1aO7uY2F8T5dU06KVqby91o=;
 b=phK/nA/N3ol34ebVJjIk9Je+8PECF38DtCd2Uwu81Kz3rredtEEyKSrDWVfULO4qL8
 Be2huHThpq9oDGnpbKaiBq0CRgHh4En99ccfM0HExyRyVeKZtrNOk30RLOND3WPTb5RC
 8FK80DfaN49QvlPp1joETXgkNtKvB8ajI1XpDbQiz5h4g4HKPaKXazGPHzj1yXlYlqc8
 ah93bMlcQAfLmQlv1QWXkpkLbznf5MvN/X5viDGHUt22/3zoXk4Ct/rpwjU/uCFBcJWV
 K3Pm0X1ZBoJonR0qLJh6qLE8qvBAFWkx8KU81rLLQcGsMvQJsqEbC3bOMhRpilDURhRP
 G5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772712066; x=1773316866;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=El3/8uv1vuMwhH9zANUH1aO7uY2F8T5dU06KVqby91o=;
 b=ZHtYFouXQAgyRDl7ED4IMKNahmF+YMbxX4vmxv3L5ateQpTtcGJ2sqM7QKRhgF1bux
 Tb5L6FlgB0V8gfliXxMKNWZ+owdreeVUu+WPKEJIIKN8fWO2R5yiTtix4wYK9O7YJTiq
 9ByyexiQgR0YD0H53vPwjnHG+AsCKsN8XJiGeaTxzi3jirRyJQjU70MWxd69/5tHp/pc
 zo/jhHGysnbKlxfWucr8CxlnqfcKMz20YlCW8JVjXn8WdH83w8xG0u2lzeM2/VH/xsPO
 X6Y/bD5f28u2h26pi0B3re/lxhN4tpyYiVz0/E005syrAh6A1X1zlzsz4Wwygq04fMDv
 nKUg==
X-Gm-Message-State: AOJu0Ywx6/StFkRxEI1pcMJirHVw7WwxFDqcsX4fJhNolikg8kRXJqkg
 B1TIB2Xvtde7K7J4AcSHG3RtHui8ZSHRbFiAbf9werRwhoXlC7SbwDxhXgZqBtNwXhDLraWLSG4
 N83sV
X-Gm-Gg: ATEYQzzBYiKAjloOVh7EB7plVieqkyO5tRdy9jawiPmS3kgBhT6e5A2oANOluV/Wc46
 s9neMOdme5WGve5T6vCRWDGrLLSee2aIvBxC3uurqv3PKab8GDdzK8oliux8GF74nrSG/RyYYKt
 VpdBtPctnMDWqI4LYnjD2ToimTZlCsY5EL0KENkiGER0p0pKtddvdyEy71fxCM4TSYAC+B6jfap
 L3jKuDDi7JkC/G/1iZXaTmzHoikmHljReSMuWYZELJTuKBqL04xeC1W8kYrcQPR+p1ToytO0Ubn
 Zh9Ia5F2Stf5OHWhIrEU0f/x4jHyfgzIEkXpsJIRSdIQ1yD404U7oIL9Icuvkok7Z+cxavE7Eqq
 Jcc0OAcVSZ790M+LNoLAq8T4khkDu/LyYgmgytihoR5zQ8xol3xmQyfw/UvR3W2CSys0FZ+mpTg
 Elx/h/Kl/fXI5l27CdlgSuksXsP4PU/JK6AFxHsa+xCy4U/Yg96nbGLIEgS3R76A5PJOkcdXmoK
 /+HPCsIOGfc9bKWhFFln35I91QRL5U=
X-Received: by 2002:a05:600c:4f8b:b0:483:71f7:2797 with SMTP id
 5b1f17b1804b1-485198516bamr87976925e9.14.1772712066119; 
 Thu, 05 Mar 2026 04:01:06 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fb33815sm73409455e9.12.2026.03.05.04.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 04:01:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH] tests/plugins/tcg/mem: Don't access unaligned memory
Date: Thu,  5 Mar 2026 12:01:04 +0000
Message-ID: <20260305120104.1254578-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

In commit eb3f69cac62670 we removed the dependency of this
mem plugin on the QEMU headers, but in doing that we introduced
undefined behaviour when the plugin accesses unaligned memory.
This shows up if you build with the gcc or clang address
sanitizer and run 'make check-tcg', in numerous warnings like:

../../tests/tcg/plugins/mem.c:167:27: runtime error: load of misaligned address 0x7f1f300354b1 for type 'uint16_t' (aka 'unsigned short'), which requires 2 byte alignment
0x7f1f300354b1: note: pointer points here
 00 00 00  00 01 02 03 04 05 06 07  08 09 0a 0b 0c 0d 0e 0f  10 11 12 13 14 15 16 17  18 19 1a 1b 1c
              ^
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../tests/tcg/plugins/mem.c:167:27

Fix this by rearranging the data reads and writes to use
memcpy() instead.

Fixes: eb3f69cac62670 ("tests/tcg/plugins/mem.c: remove dependency on qemu headers")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/plugins/mem.c | 71 +++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 41 deletions(-)

diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
index 7d64e7018f..f3992abc8f 100644
--- a/tests/tcg/plugins/mem.c
+++ b/tests/tcg/plugins/mem.c
@@ -123,6 +123,9 @@ static void update_region_info(uint64_t region, uint64_t offset,
     bool is_store = qemu_plugin_mem_is_store(meminfo);
     RegionInfo *ri;
     bool unseen_data = false;
+    void *val_ptr;
+    unsigned int val_size;
+    qemu_plugin_mem_value swapped_value;
 
     g_assert(offset + size <= region_size);
 
@@ -144,61 +147,46 @@ static void update_region_info(uint64_t region, uint64_t offset,
     }
 
     void *ri_data = &ri->data[offset];
+
+    swapped_value.type = value.type;
     switch (value.type) {
     case QEMU_PLUGIN_MEM_VALUE_U8:
-    {
-        uint8_t val = value.data.u8;
-        uint8_t *p = ri_data;
-        if (is_store) {
-            *p = val;
-        } else {
-            unseen_data = *p != val;
-        }
+        swapped_value.data.u8 = value.data.u8;
+        val_ptr = &swapped_value.data.u8;
+        val_size = 1;
         break;
-    }
     case QEMU_PLUGIN_MEM_VALUE_U16:
-    {
-        uint16_t val = be ? GUINT16_FROM_BE(value.data.u16) :
-                            GUINT16_FROM_LE(value.data.u16);
-        uint16_t *p = ri_data;
-        if (is_store) {
-            *p = val;
-        } else {
-            unseen_data = *p != val;
-        }
+        swapped_value.data.u16 = be ? GUINT16_FROM_BE(value.data.u16) :
+            GUINT16_FROM_LE(value.data.u16);
+        val_ptr = &swapped_value.data.u16;
+        val_size = 2;
         break;
-    }
     case QEMU_PLUGIN_MEM_VALUE_U32:
-    {
-        uint32_t val = be ? GUINT32_FROM_BE(value.data.u32) :
-                            GUINT32_FROM_LE(value.data.u32);
-        uint32_t *p = ri_data;
-        if (is_store) {
-            *p = val;
-        } else {
-            unseen_data = *p != val;
-        }
+        swapped_value.data.u32 = be ? GUINT32_FROM_BE(value.data.u32) :
+            GUINT32_FROM_LE(value.data.u32);
+        val_ptr = &swapped_value.data.u32;
+        val_size = 4;
         break;
-    }
     case QEMU_PLUGIN_MEM_VALUE_U64:
-    {
-        uint64_t val = be ? GUINT64_FROM_BE(value.data.u64) :
-                            GUINT64_FROM_LE(value.data.u64);
-        uint64_t *p = ri_data;
-        if (is_store) {
-            *p = val;
-        } else {
-            unseen_data = *p != val;
-        }
+        swapped_value.data.u64 = be ? GUINT64_FROM_BE(value.data.u64) :
+            GUINT64_FROM_LE(value.data.u64);
+        val_ptr = &swapped_value.data.u64;
+        val_size = 8;
         break;
-    }
     case QEMU_PLUGIN_MEM_VALUE_U128:
-        /* non in test so skip */
-        break;
+        /* none in test so skip */
+        goto done;
     default:
         g_assert_not_reached();
     }
 
+    /* ri_data may not be aligned, so we use memcpy/memcmp */
+    if (is_store) {
+        memcpy(ri_data, val_ptr, val_size);
+    } else {
+        unseen_data = memcmp(ri_data, val_ptr, val_size) != 0;
+    }
+
     /*
      * This is expected for regions initialised by QEMU (.text etc) but we
      * expect to see all data read and written to the test_data region
@@ -213,6 +201,7 @@ static void update_region_info(uint64_t region, uint64_t offset,
         ri->seen_all = false;
     }
 
+done:
     g_mutex_unlock(&lock);
 }
 
-- 
2.43.0



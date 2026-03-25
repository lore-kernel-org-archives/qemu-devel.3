Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50635109E520
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5W9S-0000wV-4Y; Wed, 25 Mar 2026 17:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5W9Q-0000vW-Py
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:52:32 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5W9P-000341-1j
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:52:32 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-35a02f3b8feso136800a91.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 14:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774475549; x=1775080349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fbUGtCfoCGCVolSue1QmNHvxDOUS5kWpaU84SjRz1q8=;
 b=U6aIz36UABLnsY3/rozXdIdcSFOU5ApkFspDNfqml9ZbFcptvqstLZAvOaRlFUAonW
 kZo3tm3vvpzmFUoXeZoXdm/fq5m79ekJw5uLLGQNhbFAeV7oK8v+uv3OD3ZxqwBbHD4A
 VkALTg9XoaNPUCfFyYH1na/i0++XHdl50LoEvUpfW9guMg0JNxSeYir0fjolzWDHkQ+z
 Ja50uCSLNg+bF96CmMpbMEUYrxXGYlNOBxzHPCjnwpjcVg2GlQHJfnFpLUWpivIBRviL
 qWk/fZo4avx8AjnJmsesyvQzCuinDwBRz6wBMnYRK6elm0w6jda0EVXULxTYDIqFLW8O
 l/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774475549; x=1775080349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fbUGtCfoCGCVolSue1QmNHvxDOUS5kWpaU84SjRz1q8=;
 b=EwNrmwSuJdWOaasJfRUqxT9M/NLR76YK4Tu/dY2n+5PIGxwRReNTem+gJC4PE7zeys
 peY1iuzwdD5+wdG1sADKhBbOtvc06WfxAy/skJ1uO1xOZ9+SU2pnmZZKEx05e8TUxSz5
 uOmB01NS4TPhQKTFFyj3nXs+zO/japPBebjPvukhOdlTtub5gDPeh4bawHH07uhRjuS5
 LOXsHi0F4r85QK7T7S2Ko0O2qB9BGuY9Zo8L/oR37GHs4m+iLCBD1H/gqSKZNgpRRfaC
 7tadEtLFu39FgsMQZLIhgGmv+zUjLGG6Xpe8W4wb+kVzhyQbCD30KQ3dfwXlZfLvwnls
 MS0w==
X-Gm-Message-State: AOJu0Yz39Jhd4epNFvNnFWLUyRyKPaRanGiZdNSwbfh1rdzZC/tSiBJR
 ztas5sp2X290xKOZZO+ASm3nieUiUSZ9MP3HM35bJXMxds8aCAIEFb2x/YbP5t76evedo/0ri9Z
 3dC+Vkw4=
X-Gm-Gg: ATEYQzwCrAo4kxL7E3WX6Mm1QhF5RUB2e5p73mNouRyGb0OlAI6yFqaR1IJQPWQ+vE+
 lA/P98WYGzEes1Rze35IYQwOZC1I7zV844VR4VNQHT91mJKQ1494/Itf/q12Ovc1UzuE3qxw4L8
 x9MjGz19TlM2ocdGItTqzt9c03cOfZyXRnJ8XI0PtAoXjfQ4QT8jG2kxtsD8rPE9HXzwe6eg4Ot
 QMVYSsKlhVR9+LITrNyvZm3NqRYTuOJwIkyAm3XNBtnR2NfKJXbaZza9b7Y/WWnOTdQ3gzFDu2+
 gY5lzDjJ0R+An+YL6XOfptpUEROMgpTKrPUJsvV0uh7dC6a0dEZ3ZCEOWLVoFThiCzZweb8dFL8
 k4Re4TdBqGdV20ZPetpibMF9HExaPAvrNsv5cN8XhlN11+EWNRgRgwbgr/f8sucrmxZKfbVuluO
 8MatGTq7kSYdlRWMJIRjqO7Am15c7SqQ3QhZ7GLZCpPpR3GX0tkBBo0gyx1ebG4iqazXcp7AItO
 YQ4
X-Received: by 2002:a17:90a:d408:b0:35b:a8cf:7969 with SMTP id
 98e67ed59e1d1-35c0dd0d076mr4250175a91.11.1774475549442; 
 Wed, 25 Mar 2026 14:52:29 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c0313eedasm6402987a91.5.2026.03.25.14.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 14:52:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 1/3] tcg: Pass host-endian values to plugin_gen_mem_callbacks_*
Date: Wed, 25 Mar 2026 14:52:20 -0700
Message-ID: <20260325215222.3678982-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325215222.3678982-1-pierrick.bouvier@linaro.org>
References: <20260325215222.3678982-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

If the host does not support swapped-endian loads and stores,
then we emulate those within the tcg expanders with explicit
bswap operations.

However, we were passing values to the plugin interface in
the middle of those bswap operations, which meant that we
would pass values of the wrong endianness to plugins when
running on hosts without swapped-endian loads and stores.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3351
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260325024252.3369186-2-pierrick.bouvier@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tcg/tcg-op-ldst.c | 52 ++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 354d9968f92..22211ccb452 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -262,9 +262,6 @@ static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, TCGTemp *addr,
     addr_new = tci_extend_addr(addr);
     copy_addr = plugin_maybe_preserve_addr(addr);
     gen_ldst1(INDEX_op_qemu_ld, TCG_TYPE_I32, tcgv_i32_temp(val), addr_new, oi);
-    plugin_gen_mem_callbacks_i32(val, copy_addr, addr, orig_oi,
-                                 QEMU_PLUGIN_MEM_R);
-    maybe_free_addr(addr, addr_new);
 
     if ((orig_memop ^ memop) & MO_BSWAP) {
         switch (orig_memop & MO_SIZE) {
@@ -280,6 +277,10 @@ static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, TCGTemp *addr,
             g_assert_not_reached();
         }
     }
+
+    plugin_gen_mem_callbacks_i32(val, copy_addr, addr, orig_oi,
+                                 QEMU_PLUGIN_MEM_R);
+    maybe_free_addr(addr, addr_new);
 }
 
 void tcg_gen_qemu_ld_i32_chk(TCGv_i32 val, TCGTemp *addr, TCGArg idx,
@@ -290,10 +291,10 @@ void tcg_gen_qemu_ld_i32_chk(TCGv_i32 val, TCGTemp *addr, TCGArg idx,
     tcg_gen_qemu_ld_i32_int(val, addr, idx, memop);
 }
 
-static void tcg_gen_qemu_st_i32_int(TCGv_i32 val, TCGTemp *addr,
+static void tcg_gen_qemu_st_i32_int(TCGv_i32 orig_val, TCGTemp *addr,
                                     TCGArg idx, MemOp memop)
 {
-    TCGv_i32 swap = NULL;
+    TCGv_i32 val = orig_val;
     MemOpIdx orig_oi, oi;
     TCGTemp *addr_new;
 
@@ -302,29 +303,29 @@ static void tcg_gen_qemu_st_i32_int(TCGv_i32 val, TCGTemp *addr,
     orig_oi = oi = make_memop_idx(memop, idx);
 
     if ((memop & MO_BSWAP) && !tcg_target_has_memory_bswap(memop)) {
-        swap = tcg_temp_ebb_new_i32();
+        val = tcg_temp_ebb_new_i32();
         switch (memop & MO_SIZE) {
         case MO_16:
-            tcg_gen_bswap16_i32(swap, val, 0);
+            tcg_gen_bswap16_i32(val, orig_val, 0);
             break;
         case MO_32:
-            tcg_gen_bswap32_i32(swap, val);
+            tcg_gen_bswap32_i32(val, orig_val);
             break;
         default:
             g_assert_not_reached();
         }
-        val = swap;
         memop &= ~MO_BSWAP;
         oi = make_memop_idx(memop, idx);
     }
 
     addr_new = tci_extend_addr(addr);
     gen_ldst1(INDEX_op_qemu_st, TCG_TYPE_I32, tcgv_i32_temp(val), addr_new, oi);
-    plugin_gen_mem_callbacks_i32(val, NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
+    plugin_gen_mem_callbacks_i32(orig_val, NULL, addr, orig_oi,
+                                 QEMU_PLUGIN_MEM_W);
     maybe_free_addr(addr, addr_new);
 
-    if (swap) {
-        tcg_temp_free_i32(swap);
+    if (val != orig_val) {
+        tcg_temp_free_i32(val);
     }
 }
 
@@ -360,9 +361,6 @@ static void tcg_gen_qemu_ld_i64_int(TCGv_i64 val, TCGTemp *addr,
     addr_new = tci_extend_addr(addr);
     copy_addr = plugin_maybe_preserve_addr(addr);
     gen_ld_i64(val, addr_new, oi);
-    plugin_gen_mem_callbacks_i64(val, copy_addr, addr, orig_oi,
-                                 QEMU_PLUGIN_MEM_R);
-    maybe_free_addr(addr, addr_new);
 
     if ((orig_memop ^ memop) & MO_BSWAP) {
         int flags = (orig_memop & MO_SIGN
@@ -382,6 +380,10 @@ static void tcg_gen_qemu_ld_i64_int(TCGv_i64 val, TCGTemp *addr,
             g_assert_not_reached();
         }
     }
+
+    plugin_gen_mem_callbacks_i64(val, copy_addr, addr, orig_oi,
+                                 QEMU_PLUGIN_MEM_R);
+    maybe_free_addr(addr, addr_new);
 }
 
 void tcg_gen_qemu_ld_i64_chk(TCGv_i64 val, TCGTemp *addr, TCGArg idx,
@@ -392,10 +394,10 @@ void tcg_gen_qemu_ld_i64_chk(TCGv_i64 val, TCGTemp *addr, TCGArg idx,
     tcg_gen_qemu_ld_i64_int(val, addr, idx, memop);
 }
 
-static void tcg_gen_qemu_st_i64_int(TCGv_i64 val, TCGTemp *addr,
+static void tcg_gen_qemu_st_i64_int(TCGv_i64 orig_val, TCGTemp *addr,
                                     TCGArg idx, MemOp memop)
 {
-    TCGv_i64 swap = NULL;
+    TCGv_i64 val = orig_val;
     MemOpIdx orig_oi, oi;
     TCGTemp *addr_new;
 
@@ -404,32 +406,32 @@ static void tcg_gen_qemu_st_i64_int(TCGv_i64 val, TCGTemp *addr,
     orig_oi = oi = make_memop_idx(memop, idx);
 
     if ((memop & MO_BSWAP) && !tcg_target_has_memory_bswap(memop)) {
-        swap = tcg_temp_ebb_new_i64();
+        val = tcg_temp_ebb_new_i64();
         switch (memop & MO_SIZE) {
         case MO_16:
-            tcg_gen_bswap16_i64(swap, val, 0);
+            tcg_gen_bswap16_i64(val, orig_val, 0);
             break;
         case MO_32:
-            tcg_gen_bswap32_i64(swap, val, 0);
+            tcg_gen_bswap32_i64(val, orig_val, 0);
             break;
         case MO_64:
-            tcg_gen_bswap64_i64(swap, val);
+            tcg_gen_bswap64_i64(val, orig_val);
             break;
         default:
             g_assert_not_reached();
         }
-        val = swap;
         memop &= ~MO_BSWAP;
         oi = make_memop_idx(memop, idx);
     }
 
     addr_new = tci_extend_addr(addr);
     gen_st_i64(val, addr_new, oi);
-    plugin_gen_mem_callbacks_i64(val, NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
+    plugin_gen_mem_callbacks_i64(orig_val, NULL, addr, orig_oi,
+                                 QEMU_PLUGIN_MEM_W);
     maybe_free_addr(addr, addr_new);
 
-    if (swap) {
-        tcg_temp_free_i64(swap);
+    if (val != orig_val) {
+        tcg_temp_free_i64(val);
     }
 }
 
-- 
2.47.3



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B033FC72DF
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 00:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5CJ2-0002XK-3e; Tue, 24 Mar 2026 20:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5CJ0-0002X2-6X
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 20:41:06 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5CIw-00074i-P6
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 20:41:05 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-35691a231a7so1157559a91.3
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 17:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774399260; x=1775004060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HDshtx+/Cv9MisFd7fSyd+2O4yxqRK4BKvfnLHyGW04=;
 b=BYFbw5HBNqvokt4L1cr41WyCtK0tPX1j0PgVN7MPHK3KyZ167U1+VIWCmGi5uxuyLs
 3HX4msy9VaXpHA+G1WTSBcXjiy13VGQjfyLt2jKq1gq5/IrMqVQTclBcFatauoPb0zsr
 JXIumPINSQchc0o+xbY2S4GzlB+VISQ94GqjA63GJH1cEj7YEmiBK6qZvgFA9o45wFMa
 zqPYwfXBegCU81saO8GFACBFA74nWq06XGp3LybXGmleV1t6zsD5KnKAa+DYo5opQipJ
 YtwJ4kcr50EZi0ShOAE4m6yUpRaJVhqxxKvHniZ9j5sCnuxA/7OHLXPex4Tride32+PY
 io4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774399260; x=1775004060;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HDshtx+/Cv9MisFd7fSyd+2O4yxqRK4BKvfnLHyGW04=;
 b=m1nkrVAXghq9PAYRKJ+OANR/9QcQWsvOiOC9uUxILMEaWbLKsIlT/vBmH+0/dSG9Ug
 cep5wahzFpNE3zPzXBvUyrZmNBrmAZ7gRK3pd4xnub1FSeosbNExKS2kyEiS8ZgqaVVe
 i5iZmv30uv7TtZi8Fi+WaJm9MKDw2ssxzwZR/4zp645qPDExXWMHnmYdY9/eQsU/xCNi
 e4pVwvK/aSZl99npxy+Urq8U6TBL/v2NIi2bkzSVDGe+sb3or3Vx1Jr4+EWW0Rj5CrYN
 kSlbfQh7UlithpLsmErRSg8c5cm45lTru0q1mec2PmvoA7KzbYxLajUI7t/DSYyh4g9i
 XqZg==
X-Gm-Message-State: AOJu0Yz9Vf6ctio8xlxiLGAgN/7rTMzRdjc5fBFALFFLVJs095oV/+8Q
 BHHn7YdjNVtJ8HIz55t59YL3mPUv1jzwvkGXnwCUVctJzEH5eev4VqVOngFw9Xe1+t/i+AnCwdB
 UdZxT6No=
X-Gm-Gg: ATEYQzwUIXCCPIQC8fcHQ2cwenJAP3uqrMsmim6IsCXxAqEPzt7ZXYi0YPnFx6xFS6H
 ClhPIL0HIZcDtSwF61HFNnThFvscX3pb6xuK4DtX4CyWTP78h9pgTfR1pgQ79nOaNNUNuPdhXS+
 9KJpIC2zeBCv1UCxYm2VfrRCCPk1Ymi/ud7voXv5hC+hfQZHAEdcX1i9FrRrn8K5tycToHzPXW6
 e2r2mR84c7JSOtA4h38M2PPFauvNZqaZ+KXDy77TH1j3GUQjENHJzkN7GYeRD4Sgl1tqpoDB5yQ
 ziLzXeVm/9UwdWGLUaKk0gFd+UGvZIhGw89vWokJ11+ofbzXoBHcsfbtTQqokc0vawuUa0+xG43
 PQepeYicErqZ3mc7Z2XD7P3xXcDm3OgIG3GgkP+bo1339UMO8+ApXNTZx/viWmEn5mtX62ms0yX
 VkmcINeQKVQf6DkTy4IQXoYU5Pmy+8z2tT0czMYAQTjw==
X-Received: by 2002:a17:90a:e705:b0:35a:24f3:2c8e with SMTP id
 98e67ed59e1d1-35c0dd01ee3mr1263512a91.9.1774399260282; 
 Tue, 24 Mar 2026 17:41:00 -0700 (PDT)
Received: from stoup.. ([103.100.225.140]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c0e7452d8sm547064a91.11.2026.03.24.17.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 17:40:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
Subject: [PATCH for-11.0] tcg: Pass host-endian values to
 plugin_gen_mem_callbacks_*
Date: Wed, 25 Mar 2026 10:40:52 +1000
Message-ID: <20260325004052.1026892-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

If the host does not support swapped-endian loads and stores,
then we emulate those within the tcg expanders with explicit
bswap operations.

However, we were passing values to the plugin interface in
the middle of those bswap operations, which meant that we
would pass values of the wrong endianness to plugins when
running on hosts without swapped-endian loads and stores.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3351
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Hi Pierrick,

On IRC I expressed the opinion that there was an additional
big-endian bug with how we treat neg.plugin_mem_value_low,
but I now see that isn't true, because of how we adjust the
store address in plugin_gen_mem_callbacks_i32.


r~
---
 tcg/tcg-op-ldst.c | 52 ++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 354d9968f9..22211ccb45 100644
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
2.43.0



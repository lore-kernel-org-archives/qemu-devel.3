Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40E6103A9A1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5ED5-0003FA-C6; Tue, 24 Mar 2026 22:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5ED2-0003DF-K5
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 22:43:04 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5ED0-0002hH-Lw
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 22:43:04 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-82ae379000fso239334b3a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 19:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774406579; x=1775011379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wLUO20s9fc0WSyu9nkSPfkpNGOICK40fTp3wqsAJMak=;
 b=IcB4jh031t79DQLkuQb0BNWY8KMcPmLoemX4GYIHPpvnshomqFroociPAfImEDmwdp
 MyB3321zLeQBX9uNmayETm7zvQc3nqGA4U3gAIqZpzuA4+cD1xwE2HdrAUt/xms+vZZ0
 Sn4kdgDMRC+mE8uWAc+52CC5nSzfKpd99DWnup9nuZr1SknOf4faBF7r7dLiEAMQVIuM
 aRnFHwmp39v9HGmL1TBfIaZHUzgNKHu9JO1Jill8r2UQaNifm3+w5mh25Hu0XbVPFuwO
 9EZWLdFFVnMjnrMhKUgAOJ61NgJ/sYgngbyllx3r10Pp/RMkM6RZAq5zSo7rV9JmV/Gb
 VfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774406579; x=1775011379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wLUO20s9fc0WSyu9nkSPfkpNGOICK40fTp3wqsAJMak=;
 b=CA4SBZuJJiYsTujOH23rWah3UojCCifnUTFENz7YI9q0g6OgQTD6TnE9ZnfNWtwT4g
 JBo/ibANGYCkdojLUhyK9OLAgmQAdqP1md5BqRHEWAv+U1na4pM7sSx5V3D65i+FnV8P
 fAX9PV6ZwftasDStRBC6xpAj53cjtOOuqI5sYcQh3UCus7VcbwKZPnO+R3CSEjB2yPcq
 KZS2AmgFLlg985poMT4j14OYq7pbFXvREvWOtGk/NEQG3BvZznv4oF8v+/R1EjCESl/T
 YrBPeKG/Vc5amKB3YcC2ynEJYOp5li08GraIycPjLstc07j9fdik6/QVG493iFXugHV9
 +YQA==
X-Gm-Message-State: AOJu0YwfCp6oGyRC64YPKWkn4dsVmHaQ9nLtpUBSABPf1vIxoUZLgHv0
 Vii66PG5piE2snAO1q+Rgenb+Q3FidVTEXizNvO5bgnBjfzEc9NCZMUXWGrNQ3dzhy7MVnn/phd
 r/iFySOQ=
X-Gm-Gg: ATEYQzx41+W9yyJt6Kp2CljZslZfiQ9oxYRtSVWRFGbOaXMKhkPS2HLgXHPHS9pIMxR
 Uu5EEde5ByMr2EmiEXsulgoiYWBN/0p40wP53s0tPFX+ixGaS6Wnh+KlXj7f0OMwA/Ebj2FKlw/
 dGAeK+76/NkGZLT9+UpGL70/JC8o/hY/4U96G8ld6cqbo4NqefA2I3fTtvwUuyruqk2siozaGcy
 3jajzXzz/CvWtlVmThgtn+uCzCurDLyZ3ruGeaXEqDa2PM+YEL3fhGW87jghiurBitrnITKymbI
 hQzDOwgvFJmCKs+cnBg5AGvtPtIXnHuHABcBeJbNEh29iagqvJp//7loTtsa9XrgAAR6h2TYTf3
 vfm64fioM8XHT0yeFugEZ2DhpYVnkgu1YG7Tva47YHf+r6lkTg+g4A+MaknOLzuCUtUHUYTxEyE
 aHxNdKkUD4NazIqRH4xHH9tNP7KJjDxqxBAJn5J6+q/5EVw9WlQxUjeEOGnGQq8wpC0z/98vGIP
 clqfb3+mDOHIec=
X-Received: by 2002:a05:6a00:2c95:b0:824:3d5b:3cd3 with SMTP id
 d2e1a72fcca58-82c6d4e1df4mr1823738b3a.0.1774406579484; 
 Tue, 24 Mar 2026 19:42:59 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b04222f42sm16762716b3a.61.2026.03.24.19.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:42:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 1/3] tcg: Pass host-endian values to plugin_gen_mem_callbacks_*
Date: Tue, 24 Mar 2026 19:42:50 -0700
Message-ID: <20260325024252.3369186-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325024252.3369186-1-pierrick.bouvier@linaro.org>
References: <20260325024252.3369186-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AFFC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 01:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOS2c-0005SB-Q7; Mon, 01 Jul 2024 21:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOS2N-0005Pj-Ex
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 21:10:27 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOS2K-0002AD-TI
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 21:10:27 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70699b6afddso2327861b3a.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 18:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719882623; x=1720487423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+uOK153DyUSUd29q8p0lc894A904pRYCTbUBrjTr8eI=;
 b=l3l//Hy6+LDjhwqet/KZ+W8+0Hh9wPC2VWseHIwekZSbxBN4ETMG+fJS5IREOcDXGb
 +7C6qUt9CcF6FR3eh0Zl9U4eo5Tb2xqgiqcxrlSGOY6cGgY7kkOPBb/idIkfaCVpo16M
 mWRPfMNMGfN7QoLZ80twTUM7QhHk9656dPTiMjuqQ5lnfxDeOX2HV/t/AfXUNjGLMnhu
 MpKIGn79+R4jt7X7Rm9iQ4w6c7V5LqJI2cy3lgQ1Qshtbyb8FpiYJwV9ZwSE+DpB+nad
 GT4qFaRaRtUsI87WyX9gkRm7CDZuBbZzvdl9eciLEF+nhG9+4HmBrDsvxClphGx8xxZu
 En9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719882623; x=1720487423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+uOK153DyUSUd29q8p0lc894A904pRYCTbUBrjTr8eI=;
 b=ITeGRdQgY6V0ZVLSD6LMthhqUuHOdNsM9otUDrJ5Mv7PHKp6Ek5kcytEg9H2GPhXS0
 pavXfxqVqDuPwy1gyHzRshDX/jgAg/J6Hha8Q0UqdUttXyQrNYMyap7rI5hV56yn3XIa
 iy34wKsYoUQqH6cykCCwdMi0pMbHlGIjAsitzGbYDKWmn0rlwi0+GZtQ5rwo5V8bHF1w
 hLEDSdvIHBimbyk//KFogIiSuvImUTAVVYe3LYV2Y/eA0DV4x8WnD9K8h8nN8pznKY64
 cdskBZmZTM017CbC/lMVA36CU3Vi8cgvHiKF0Frb0fJKfXe253w9Sy2/3v6B8mmxiKfg
 DIew==
X-Gm-Message-State: AOJu0YwctrhS4b1qrKYCpqAgwc+pdNDudR6C7MvOKe05bOzT8+RBnASv
 SAU5JDtIBuyO1PI0q/ZOg0alnAs58m7pZQEsoXVa+t2kww4rFBMnYeX108iD/HgMhS6Af/FraAB
 z
X-Google-Smtp-Source: AGHT+IGb6ybeh14Nsar9xn49EB9OvpQ3JeNV5VkPNsJp7bWNbEwVGFZEIa8/xBF3WIN98sc/0dsvxw==
X-Received: by 2002:a05:6a20:7349:b0:1be:c63c:f7b3 with SMTP id
 adf61e73a8af0-1bef6198801mr6287364637.31.1719882622537; 
 Mon, 01 Jul 2024 18:10:22 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91ce1f198sm7480317a91.2.2024.07.01.18.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 18:10:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v3 2/7] plugins: save value during memory accesses
Date: Mon,  1 Jul 2024 18:10:10 -0700
Message-Id: <20240702011015.325609-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240702011015.325609-1-pierrick.bouvier@linaro.org>
References: <20240702011015.325609-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

Different code paths handle memory accesses:
- tcg generated code
- load/store helpers
- atomic helpers

This value is saved in cpu->plugin_state.

Atomic operations are doing read/write at the same time, so we generate
two memory callbacks instead of one, to allow plugins to access distinct
values.

For now, we can have access only up to 128 bits, thus split this in two
64 bits words. When QEMU will support wider operations, we'll be able to
reconsider this.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/tcg/atomic_template.h   | 66 ++++++++++++++++++++++++++++----
 include/qemu/plugin.h         |  8 ++++
 plugins/core.c                |  7 ++++
 tcg/tcg-op-ldst.c             | 72 +++++++++++++++++++++++++++++++----
 accel/tcg/atomic_common.c.inc | 13 ++++++-
 accel/tcg/ldst_common.c.inc   | 38 +++++++++++-------
 6 files changed, 173 insertions(+), 31 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index 1dc2151dafd..89593b2502f 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -53,6 +53,14 @@
 # error unsupported data size
 #endif
 
+#if DATA_SIZE == 16
+# define VALUE_LOW(val) int128_getlo(val)
+# define VALUE_HIGH(val) int128_gethi(val)
+#else
+# define VALUE_LOW(val) val
+# define VALUE_HIGH(val) 0
+#endif
+
 #if DATA_SIZE >= 4
 # define ABI_TYPE  DATA_TYPE
 #else
@@ -83,7 +91,12 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, abi_ptr addr,
     ret = qatomic_cmpxchg__nocheck(haddr, cmpv, newv);
 #endif
     ATOMIC_MMU_CLEANUP;
-    atomic_trace_rmw_post(env, addr, oi);
+    atomic_trace_rmw_post(env, addr,
+                          VALUE_LOW(ret),
+                          VALUE_HIGH(ret),
+                          VALUE_LOW(newv),
+                          VALUE_HIGH(newv),
+                          oi);
     return ret;
 }
 
@@ -97,7 +110,12 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, abi_ptr addr, ABI_TYPE val,
 
     ret = qatomic_xchg__nocheck(haddr, val);
     ATOMIC_MMU_CLEANUP;
-    atomic_trace_rmw_post(env, addr, oi);
+    atomic_trace_rmw_post(env, addr,
+                          VALUE_LOW(ret),
+                          VALUE_HIGH(ret),
+                          VALUE_LOW(val),
+                          VALUE_HIGH(val),
+                          oi);
     return ret;
 }
 
@@ -109,7 +127,12 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, abi_ptr addr,            \
     haddr = atomic_mmu_lookup(env_cpu(env), addr, oi, DATA_SIZE, retaddr);   \
     ret = qatomic_##X(haddr, val);                                  \
     ATOMIC_MMU_CLEANUP;                                             \
-    atomic_trace_rmw_post(env, addr, oi);                           \
+    atomic_trace_rmw_post(env, addr,                                \
+                          VALUE_LOW(ret),                           \
+                          VALUE_HIGH(ret),                          \
+                          VALUE_LOW(val),                           \
+                          VALUE_HIGH(val),                          \
+                          oi);                                      \
     return ret;                                                     \
 }
 
@@ -145,7 +168,12 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, abi_ptr addr,            \
         cmp = qatomic_cmpxchg__nocheck(haddr, old, new);            \
     } while (cmp != old);                                           \
     ATOMIC_MMU_CLEANUP;                                             \
-    atomic_trace_rmw_post(env, addr, oi);                           \
+    atomic_trace_rmw_post(env, addr,                                \
+                          VALUE_LOW(old),                           \
+                          VALUE_HIGH(old),                          \
+                          VALUE_LOW(xval),                          \
+                          VALUE_HIGH(xval),                         \
+                          oi);                                      \
     return RET;                                                     \
 }
 
@@ -188,7 +216,12 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, abi_ptr addr,
     ret = qatomic_cmpxchg__nocheck(haddr, BSWAP(cmpv), BSWAP(newv));
 #endif
     ATOMIC_MMU_CLEANUP;
-    atomic_trace_rmw_post(env, addr, oi);
+    atomic_trace_rmw_post(env, addr,
+                          VALUE_LOW(ret),
+                          VALUE_HIGH(ret),
+                          VALUE_LOW(newv),
+                          VALUE_HIGH(newv),
+                          oi);
     return BSWAP(ret);
 }
 
@@ -202,7 +235,12 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, abi_ptr addr, ABI_TYPE val,
 
     ret = qatomic_xchg__nocheck(haddr, BSWAP(val));
     ATOMIC_MMU_CLEANUP;
-    atomic_trace_rmw_post(env, addr, oi);
+    atomic_trace_rmw_post(env, addr,
+                          VALUE_LOW(ret),
+                          VALUE_HIGH(ret),
+                          VALUE_LOW(val),
+                          VALUE_HIGH(val),
+                          oi);
     return BSWAP(ret);
 }
 
@@ -214,7 +252,12 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, abi_ptr addr,            \
     haddr = atomic_mmu_lookup(env_cpu(env), addr, oi, DATA_SIZE, retaddr);   \
     ret = qatomic_##X(haddr, BSWAP(val));                           \
     ATOMIC_MMU_CLEANUP;                                             \
-    atomic_trace_rmw_post(env, addr, oi);                           \
+    atomic_trace_rmw_post(env, addr,                                \
+                          VALUE_LOW(ret),                           \
+                          VALUE_HIGH(ret),                          \
+                          VALUE_LOW(val),                           \
+                          VALUE_HIGH(val),                          \
+                          oi);                                      \
     return BSWAP(ret);                                              \
 }
 
@@ -247,7 +290,12 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, abi_ptr addr,            \
         ldn = qatomic_cmpxchg__nocheck(haddr, ldo, BSWAP(new));     \
     } while (ldo != ldn);                                           \
     ATOMIC_MMU_CLEANUP;                                             \
-    atomic_trace_rmw_post(env, addr, oi);                           \
+    atomic_trace_rmw_post(env, addr,                                \
+                          VALUE_LOW(old),                           \
+                          VALUE_HIGH(old),                          \
+                          VALUE_LOW(xval),                          \
+                          VALUE_HIGH(xval),                         \
+                          oi);                                      \
     return RET;                                                     \
 }
 
@@ -281,3 +329,5 @@ GEN_ATOMIC_HELPER_FN(add_fetch, ADD, DATA_TYPE, new)
 #undef SUFFIX
 #undef DATA_SIZE
 #undef SHIFT
+#undef VALUE_LOW
+#undef VALUE_HIGH
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index bc5aef979e7..5dc10c5ef65 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -142,9 +142,13 @@ struct qemu_plugin_tb {
 /**
  * struct CPUPluginState - per-CPU state for plugins
  * @event_mask: plugin event bitmap. Modified only via async work.
+ * @mem_value_low: 64 lower bits of latest accessed mem value.
+ * @mem_value_high: 64 higher bits of latest accessed mem value.
  */
 struct CPUPluginState {
     DECLARE_BITMAP(event_mask, QEMU_PLUGIN_EV_MAX);
+    uint64_t mem_value_low;
+    uint64_t mem_value_high;
 };
 
 /**
@@ -164,6 +168,8 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1,
 void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret);
 
 void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
+                             uint64_t value_low,
+                             uint64_t value_high,
                              MemOpIdx oi, enum qemu_plugin_mem_rw rw);
 
 void qemu_plugin_flush_cb(void);
@@ -248,6 +254,8 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
 { }
 
 static inline void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
+                                           uint64_t value_high,
+                                           uint64_t value_low,
                                            MemOpIdx oi,
                                            enum qemu_plugin_mem_rw rw)
 { }
diff --git a/plugins/core.c b/plugins/core.c
index 9d737d82787..a899eaf37af 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -575,14 +575,21 @@ void exec_inline_op(enum plugin_dyn_cb_type type,
 }
 
 void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
+                             uint64_t value_low,
+                             uint64_t value_high,
                              MemOpIdx oi, enum qemu_plugin_mem_rw rw)
 {
     GArray *arr = cpu->neg.plugin_mem_cbs;
+    CPUPluginState *plugin_state = cpu->plugin_state;
     size_t i;
 
     if (arr == NULL) {
         return;
     }
+
+    plugin_state->mem_value_low = value_low;
+    plugin_state->mem_value_high = value_high;
+
     for (i = 0; i < arr->len; i++) {
         struct qemu_plugin_dyn_cb *cb =
             &g_array_index(arr, struct qemu_plugin_dyn_cb, i);
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 85101602581..ea7f4fa8ded 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -148,14 +148,24 @@ static TCGv_i64 plugin_maybe_preserve_addr(TCGTemp *addr)
     return NULL;
 }
 
+#ifdef CONFIG_PLUGIN
 static void
-plugin_gen_mem_callbacks(TCGv_i64 copy_addr, TCGTemp *orig_addr, MemOpIdx oi,
+plugin_gen_mem_callbacks(TCGv_i64 value_low, TCGv_i64 value_high,
+                         TCGv_i64 copy_addr, TCGTemp *orig_addr, MemOpIdx oi,
                          enum qemu_plugin_mem_rw rw)
 {
-#ifdef CONFIG_PLUGIN
     if (tcg_ctx->plugin_insn != NULL) {
         qemu_plugin_meminfo_t info = make_plugin_meminfo(oi, rw);
 
+        TCGv_ptr plugin_state = tcg_temp_ebb_new_ptr();
+        tcg_gen_ld_ptr(plugin_state, tcg_env,
+                       offsetof(CPUState, plugin_state) - sizeof(CPUState));
+        tcg_gen_st_i64(value_low, plugin_state,
+                       offsetof(CPUPluginState, mem_value_low));
+        tcg_gen_st_i64(value_high, plugin_state,
+                       offsetof(CPUPluginState, mem_value_high));
+        tcg_temp_free_ptr(plugin_state);
+
         if (tcg_ctx->addr_type == TCG_TYPE_I32) {
             if (!copy_addr) {
                 copy_addr = tcg_temp_ebb_new_i64();
@@ -172,6 +182,48 @@ plugin_gen_mem_callbacks(TCGv_i64 copy_addr, TCGTemp *orig_addr, MemOpIdx oi,
             }
         }
     }
+}
+#endif
+
+static void
+plugin_gen_mem_callbacks_i32(TCGv_i32 val,
+                             TCGv_i64 copy_addr, TCGTemp *orig_addr,
+                             MemOpIdx oi, enum qemu_plugin_mem_rw rw)
+{
+#ifdef CONFIG_PLUGIN
+    if (tcg_ctx->plugin_insn != NULL) {
+        TCGv_i64 ext_val = tcg_temp_ebb_new_i64();
+        tcg_gen_extu_i32_i64(ext_val, val);
+        plugin_gen_mem_callbacks(ext_val, tcg_constant_i64(0),
+                                 copy_addr, orig_addr, oi, rw);
+        tcg_temp_free_i64(ext_val);
+    }
+#endif
+}
+
+static void
+plugin_gen_mem_callbacks_i64(TCGv_i64 val,
+                             TCGv_i64 copy_addr, TCGTemp *orig_addr,
+                             MemOpIdx oi, enum qemu_plugin_mem_rw rw)
+{
+#ifdef CONFIG_PLUGIN
+    if (tcg_ctx->plugin_insn != NULL) {
+        plugin_gen_mem_callbacks(val, tcg_constant_i64(0),
+                                 copy_addr, orig_addr, oi, rw);
+    }
+#endif
+}
+
+static void
+plugin_gen_mem_callbacks_i128(TCGv_i128 val,
+                             TCGv_i64 copy_addr, TCGTemp *orig_addr,
+                             MemOpIdx oi, enum qemu_plugin_mem_rw rw)
+{
+#ifdef CONFIG_PLUGIN
+    if (tcg_ctx->plugin_insn != NULL) {
+        plugin_gen_mem_callbacks(TCGV128_LOW(val), TCGV128_HIGH(val),
+                                 copy_addr, orig_addr, oi, rw);
+    }
 #endif
 }
 
@@ -203,7 +255,8 @@ static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, TCGTemp *addr,
         opc = INDEX_op_qemu_ld_a64_i32;
     }
     gen_ldst(opc, tcgv_i32_temp(val), NULL, addr, oi);
-    plugin_gen_mem_callbacks(copy_addr, addr, orig_oi, QEMU_PLUGIN_MEM_R);
+    plugin_gen_mem_callbacks_i32(val, copy_addr, addr, orig_oi,
+                                 QEMU_PLUGIN_MEM_R);
 
     if ((orig_memop ^ memop) & MO_BSWAP) {
         switch (orig_memop & MO_SIZE) {
@@ -271,7 +324,7 @@ static void tcg_gen_qemu_st_i32_int(TCGv_i32 val, TCGTemp *addr,
         }
     }
     gen_ldst(opc, tcgv_i32_temp(val), NULL, addr, oi);
-    plugin_gen_mem_callbacks(NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
+    plugin_gen_mem_callbacks_i32(val, NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
 
     if (swap) {
         tcg_temp_free_i32(swap);
@@ -324,7 +377,8 @@ static void tcg_gen_qemu_ld_i64_int(TCGv_i64 val, TCGTemp *addr,
         opc = INDEX_op_qemu_ld_a64_i64;
     }
     gen_ldst_i64(opc, val, addr, oi);
-    plugin_gen_mem_callbacks(copy_addr, addr, orig_oi, QEMU_PLUGIN_MEM_R);
+    plugin_gen_mem_callbacks_i64(val, copy_addr, addr, orig_oi,
+                                 QEMU_PLUGIN_MEM_R);
 
     if ((orig_memop ^ memop) & MO_BSWAP) {
         int flags = (orig_memop & MO_SIGN
@@ -396,7 +450,7 @@ static void tcg_gen_qemu_st_i64_int(TCGv_i64 val, TCGTemp *addr,
         opc = INDEX_op_qemu_st_a64_i64;
     }
     gen_ldst_i64(opc, val, addr, oi);
-    plugin_gen_mem_callbacks(NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
+    plugin_gen_mem_callbacks_i64(val, NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
 
     if (swap) {
         tcg_temp_free_i64(swap);
@@ -606,7 +660,8 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
                            tcg_constant_i32(orig_oi));
     }
 
-    plugin_gen_mem_callbacks(ext_addr, addr, orig_oi, QEMU_PLUGIN_MEM_R);
+    plugin_gen_mem_callbacks_i128(val, ext_addr, addr, orig_oi,
+                                  QEMU_PLUGIN_MEM_R);
 }
 
 void tcg_gen_qemu_ld_i128_chk(TCGv_i128 val, TCGTemp *addr, TCGArg idx,
@@ -722,7 +777,8 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
                            tcg_constant_i32(orig_oi));
     }
 
-    plugin_gen_mem_callbacks(ext_addr, addr, orig_oi, QEMU_PLUGIN_MEM_W);
+    plugin_gen_mem_callbacks_i128(val, ext_addr, addr, orig_oi,
+                                  QEMU_PLUGIN_MEM_W);
 }
 
 void tcg_gen_qemu_st_i128_chk(TCGv_i128 val, TCGTemp *addr, TCGArg idx,
diff --git a/accel/tcg/atomic_common.c.inc b/accel/tcg/atomic_common.c.inc
index 95a5c5ff12d..6056598c23d 100644
--- a/accel/tcg/atomic_common.c.inc
+++ b/accel/tcg/atomic_common.c.inc
@@ -14,9 +14,20 @@
  */
 
 static void atomic_trace_rmw_post(CPUArchState *env, uint64_t addr,
+                                  uint64_t read_value_low,
+                                  uint64_t read_value_high,
+                                  uint64_t write_value_low,
+                                  uint64_t write_value_high,
                                   MemOpIdx oi)
 {
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_RW);
+    if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
+        qemu_plugin_vcpu_mem_cb(env_cpu(env), addr,
+                                read_value_low, read_value_high,
+                                oi, QEMU_PLUGIN_MEM_R);
+        qemu_plugin_vcpu_mem_cb(env_cpu(env), addr,
+                                write_value_low, write_value_high,
+                                oi, QEMU_PLUGIN_MEM_W);
+    }
 }
 
 /*
diff --git a/accel/tcg/ldst_common.c.inc b/accel/tcg/ldst_common.c.inc
index 87ceb954873..ebbf380d767 100644
--- a/accel/tcg/ldst_common.c.inc
+++ b/accel/tcg/ldst_common.c.inc
@@ -123,10 +123,15 @@ void helper_st_i128(CPUArchState *env, uint64_t addr, Int128 val, MemOpIdx oi)
  * Load helpers for cpu_ldst.h
  */
 
-static void plugin_load_cb(CPUArchState *env, abi_ptr addr, MemOpIdx oi)
+static void plugin_load_cb(CPUArchState *env, abi_ptr addr,
+                           uint64_t value_low,
+                           uint64_t value_high,
+                           MemOpIdx oi)
 {
     if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
-        qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_R);
+        qemu_plugin_vcpu_mem_cb(env_cpu(env), addr,
+                                value_low, value_high,
+                                oi, QEMU_PLUGIN_MEM_R);
     }
 }
 
@@ -136,7 +141,7 @@ uint8_t cpu_ldb_mmu(CPUArchState *env, abi_ptr addr, MemOpIdx oi, uintptr_t ra)
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_UB);
     ret = do_ld1_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-    plugin_load_cb(env, addr, oi);
+    plugin_load_cb(env, addr, ret, 0, oi);
     return ret;
 }
 
@@ -147,7 +152,7 @@ uint16_t cpu_ldw_mmu(CPUArchState *env, abi_ptr addr,
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
     ret = do_ld2_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-    plugin_load_cb(env, addr, oi);
+    plugin_load_cb(env, addr, ret, 0, oi);
     return ret;
 }
 
@@ -158,7 +163,7 @@ uint32_t cpu_ldl_mmu(CPUArchState *env, abi_ptr addr,
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
     ret = do_ld4_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-    plugin_load_cb(env, addr, oi);
+    plugin_load_cb(env, addr, ret, 0, oi);
     return ret;
 }
 
@@ -169,7 +174,7 @@ uint64_t cpu_ldq_mmu(CPUArchState *env, abi_ptr addr,
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
     ret = do_ld8_mmu(env_cpu(env), addr, oi, ra, MMU_DATA_LOAD);
-    plugin_load_cb(env, addr, oi);
+    plugin_load_cb(env, addr, ret, 0, oi);
     return ret;
 }
 
@@ -180,7 +185,7 @@ Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr,
 
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
     ret = do_ld16_mmu(env_cpu(env), addr, oi, ra);
-    plugin_load_cb(env, addr, oi);
+    plugin_load_cb(env, addr, int128_getlo(ret), int128_gethi(ret), oi);
     return ret;
 }
 
@@ -188,10 +193,15 @@ Int128 cpu_ld16_mmu(CPUArchState *env, abi_ptr addr,
  * Store helpers for cpu_ldst.h
  */
 
-static void plugin_store_cb(CPUArchState *env, abi_ptr addr, MemOpIdx oi)
+static void plugin_store_cb(CPUArchState *env, abi_ptr addr,
+                            uint64_t value_low,
+                            uint64_t value_high,
+                            MemOpIdx oi)
 {
     if (cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
-        qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, oi, QEMU_PLUGIN_MEM_W);
+        qemu_plugin_vcpu_mem_cb(env_cpu(env), addr,
+                                value_low, value_high,
+                                oi, QEMU_PLUGIN_MEM_W);
     }
 }
 
@@ -199,7 +209,7 @@ void cpu_stb_mmu(CPUArchState *env, abi_ptr addr, uint8_t val,
                  MemOpIdx oi, uintptr_t retaddr)
 {
     helper_stb_mmu(env, addr, val, oi, retaddr);
-    plugin_store_cb(env, addr, oi);
+    plugin_store_cb(env, addr, val, 0, oi);
 }
 
 void cpu_stw_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
@@ -207,7 +217,7 @@ void cpu_stw_mmu(CPUArchState *env, abi_ptr addr, uint16_t val,
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_16);
     do_st2_mmu(env_cpu(env), addr, val, oi, retaddr);
-    plugin_store_cb(env, addr, oi);
+    plugin_store_cb(env, addr, val, 0, oi);
 }
 
 void cpu_stl_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
@@ -215,7 +225,7 @@ void cpu_stl_mmu(CPUArchState *env, abi_ptr addr, uint32_t val,
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_32);
     do_st4_mmu(env_cpu(env), addr, val, oi, retaddr);
-    plugin_store_cb(env, addr, oi);
+    plugin_store_cb(env, addr, val, 0, oi);
 }
 
 void cpu_stq_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
@@ -223,7 +233,7 @@ void cpu_stq_mmu(CPUArchState *env, abi_ptr addr, uint64_t val,
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_64);
     do_st8_mmu(env_cpu(env), addr, val, oi, retaddr);
-    plugin_store_cb(env, addr, oi);
+    plugin_store_cb(env, addr, val, 0, oi);
 }
 
 void cpu_st16_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
@@ -231,7 +241,7 @@ void cpu_st16_mmu(CPUArchState *env, abi_ptr addr, Int128 val,
 {
     tcg_debug_assert((get_memop(oi) & MO_SIZE) == MO_128);
     do_st16_mmu(env_cpu(env), addr, val, oi, retaddr);
-    plugin_store_cb(env, addr, oi);
+    plugin_store_cb(env, addr, int128_getlo(val), int128_gethi(val), oi);
 }
 
 /*
-- 
2.39.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA9CC88E5C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 07:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkGtC-00055t-Iq; Mon, 26 Jan 2026 02:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGfu-00035S-M2
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:06:21 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGfm-0004Us-Rc
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:06:11 -0500
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-8230c33f477so1707754b3a.2
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 23:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769411164; x=1770015964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kRijlfK2AhaCQITdyGLgCjetEZy1TZO2LBKInu/R++E=;
 b=hEpFiElAcXQFDBLTk5FdNTplszmgD/mqQysy3M45wJFgAz+acYGRrZHq4Bh4+BS+5m
 3wsaH1dPLScgCnUme7Y5cwCbBmmIm0HyYunb+4493L1iS76G4zvvySWc1QKPXHIyCbxh
 fU9/KdjAfA4gr0LM21mKHCYrn/23FUr5nCDjMfpU5/eYKOmiqgwjAFgEJznaoWz1CZsJ
 Z0x3HLth0C5VBo4sACBdT0c/JXpdl7kVLz8xaK1ek786tDT1dZvjiwr0brpx9ygtrSss
 Y2iiWjto4QDrQHfRWAjjVssMGjk+H8yUaN5gQ0X4rZxyiDzqgj6yDb5lIQ36bl/JAavA
 LmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769411164; x=1770015964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kRijlfK2AhaCQITdyGLgCjetEZy1TZO2LBKInu/R++E=;
 b=FGaW0whcPOT6zLz/r+ylpZ6t4oHQpB7SzupRhFL4+DXD2J2ObFiY8Ne/Bgq+l9PriX
 A3ig4P2w1WB/xQzvoWtGNmBUGc5YYyPeOC6cHpskElSFPkrFw9L5OkbAKWm9vOsdqwMh
 yCSlEuiBq0ZdTJa45mAR1NsQEhN0H5o5kEHKkPEXWB0FOHm+Ta2GpTaUc15OAstMaTR9
 LztD8UCXj+Di+3w41DmVtrxvP4MwxUCf78sJo6ZlDBdIt/j7EaVajyBOzyulfBlSXZw4
 dXvgPwBkTerxRMkeT4dJieA8PMjsTvC7TJc5TyOfWkETAEkjpIzkGlhTUWbR+/26yHGh
 EODA==
X-Gm-Message-State: AOJu0YzMZ4G33N2TcmTTpYOT2yfRIb1wNcnQAqJwhL7hZ+ShATDDADmo
 Yt1hy2zM7ytoO7vA+3ysnzpsA/14pmN4BEU5gBIvP0Mu4KbglyeoV7Epec85iedqfHI=
X-Gm-Gg: AZuq6aKvelkNHecAXMy0JhER8FpEewy7/BgFsacKBDmBRwrYonoMHzS4wpDHKgczVlr
 LDqQZpX8NtQGa6jFS2R7iO3bTAATxU1OI8ioSOxZSbLJOXcafAtJhM85jYqBEOoO6SutVMGB8Rb
 ZL7vmPKonFjOTO49uQG7hASn7qWGt6dcuhqmblEhVKxo3rswMuj0N5a8iUTL1jX+0BE3CpTeVtY
 +FO+MOhhLP1NrFZaJG0V/2mY5MEQWi4aoxsbklKKBcOkh0GFZqFqYlggzWJ23h0hYqFE1MWBh+I
 JnlqAglYJWVH/E/sB8evGoYZgzpSne7YJKCiEMjDlYVWDsdr09fGpVXaP+33qoDZrT3k3irh9QC
 gne1+lKulG1mMwBX4QZ7o8vInAoJFXhu3QdKio2TFcQ+jYIpN1yecw0PZBpzDLqLjrd6GaB6qIF
 Y7y4heuyEOtNqugpZJDoVm4Vb7fVL4VnOwg7yY8/QVLw==
X-Received: by 2002:a05:6a00:808d:b0:81f:9f14:ecc8 with SMTP id
 d2e1a72fcca58-823412491b8mr2793425b3a.27.1769411164172; 
 Sun, 25 Jan 2026 23:06:04 -0800 (PST)
Received: from brahms.. (fp93c00990.tkyc601.ap.nuro.jp. [147.192.9.144])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-823187716ebsm8661487b3a.66.2026.01.25.23.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 23:06:03 -0800 (PST)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 26/33] tcg/wasm64: Enable instantiation of TBs executed
 many times
Date: Mon, 26 Jan 2026 07:03:39 +0000
Message-ID: <69e8725f30a790dd000be9deaf97e222f392a157.1769407033.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769407033.git.ktokunaga.mail@gmail.com>
References: <cover.1769407033.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x441.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This commit enables the instantiation and execution of TBs in wasm64.c. As
in TCI, the tcg_qemu_tb_exec function serves as the entrypoint for the TB
execution, handling both instantiation and invocation of the Wasm
module. Since browsers cause out of memory error if too many Wasm instances
are created, this commit restricts instantiation to TBs that are called many
times.

This commit adds a counter (or its array if there are multiple threads) to
the TB. Each time a TB is executed on TCI, the counter on TB is
incremented. If it reaches to a threshold, that TB is instantiated as Wasm
via instantiate_wasm.

The total number of instances are tracked by the instances_global variable
and its maximum number is limited by MAX_INSTANCES. When a Wasm module is
instantiated, instances_global is incremented and the instance's function
pointer is recorded to an array of WasmInstanceInfo.

Each TB refers to the WasmInstanceInfo entry via WasmTBHeader's info_ptr (or
its array if there are multiple threads). This allows tcg_qemu_tb_exec to
resolve the instance's function pointer from the TB.

When a new instantiation would exceed the limit, the Wasm backend doesn't
perform instantiation (i.e. TB continues execution on TCI). Instead, it
triggers the removal of older Wasm instances using Emscripten's
removeFunction function. Once the removal is completed and detected via
FinalizationRegistry API[1], instances_global is decremented, allowing new
modules to be instantiated.

[1] https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/FinalizationRegistry

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm64.c                | 244 +++++++++++++++++++++++++++++++++++-
 tcg/wasm64.h                |  45 +++++++
 tcg/wasm64/tcg-target.c.inc |  21 ++++
 3 files changed, 307 insertions(+), 3 deletions(-)

diff --git a/tcg/wasm64.c b/tcg/wasm64.c
index 7ae976d9eb..b947be3aa9 100644
--- a/tcg/wasm64.c
+++ b/tcg/wasm64.c
@@ -24,6 +24,10 @@
 #include "tcg/helper-info.h"
 #include <ffi.h>
 #include <emscripten.h>
+#include "wasm64.h"
+
+/* TBs executed more than this value will be compiled to wasm */
+#define INSTANTIATE_NUM 1500
 
 #define EM_JS_PRE(ret, name, args, body...) EM_JS(ret, name, args, body)
 
@@ -60,6 +64,8 @@ EM_JS_PRE(void*, instantiate_wasm, (void *wasm_begin,
             "helper" : helper,
     });
 
+    Module.__wasm_tb.inst_gc_registry.register(inst, "tbinstance");
+
     return ENC_PTR(addFunction(inst.exports.start, 'ii'));
 });
 
@@ -287,9 +293,53 @@ static void tci_qemu_st(CPUArchState *env, uint64_t taddr, uint64_t val,
     }
 }
 
-static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
+static __thread int thread_idx;
+
+static inline int32_t get_counter_local(void *tb_ptr)
+{
+    return get_counter(tb_ptr, thread_idx);
+}
+
+static inline void set_counter_local(void *tb_ptr, int v)
+{
+    set_counter(tb_ptr, thread_idx, v);
+}
+
+static inline struct WasmInstanceInfo *get_info_local(void *tb_ptr)
+{
+    return get_info(tb_ptr, thread_idx);
+}
+
+static inline void set_info_local(void *tb_ptr, struct WasmInstanceInfo *info)
+{
+    set_info(tb_ptr, thread_idx, info);
+}
+
+/*
+ * inc_counter increments the execution counter in the specified TB.
+ * If the counter reaches the limit, it returns true otherwise returns false.
+ */
+static inline bool inc_counter(void *tb_ptr)
 {
-    const uint32_t *tb_ptr = v_tb_ptr;
+    int32_t counter = get_counter_local(tb_ptr);
+    if ((counter >= 0) && (counter < INSTANTIATE_NUM)) {
+        set_counter_local(tb_ptr, counter + 1);
+    } else {
+        return true; /* enter to wasm TB */
+    }
+    return false;
+}
+
+static __thread struct WasmContext ctx = {
+    .tb_ptr = 0,
+    .stack = NULL,
+    .do_init = 1,
+    .buf128 = NULL,
+};
+
+static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env)
+{
+    uint32_t *tb_ptr = get_tci_ptr(ctx.tb_ptr);
     tcg_target_ulong regs[TCG_TARGET_NB_REGS];
     uint64_t stack[(TCG_STATIC_CALL_ARGS_SIZE + TCG_STATIC_FRAME_SIZE)
                    / sizeof(uint64_t)];
@@ -578,18 +628,32 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
             break;
         case INDEX_op_exit_tb:
             tci_args_l(insn, tb_ptr, &ptr);
+            ctx.tb_ptr = 0;
             return (uintptr_t)ptr;
         case INDEX_op_goto_tb:
             tci_args_l(insn, tb_ptr, &ptr);
-            tb_ptr = *(void **)ptr;
+            if (tb_ptr != *(void **)ptr) {
+                tb_ptr = *(void **)ptr;
+                ctx.tb_ptr = tb_ptr;
+                if (inc_counter(tb_ptr)) {
+                    return 0; /* enter to wasm TB */
+                }
+                tb_ptr = get_tci_ptr(tb_ptr);
+            }
             break;
         case INDEX_op_goto_ptr:
             tci_args_r(insn, &r0);
             ptr = (void *)regs[r0];
             if (!ptr) {
+                ctx.tb_ptr = 0;
                 return 0;
             }
             tb_ptr = ptr;
+            ctx.tb_ptr = tb_ptr;
+            if (inc_counter(tb_ptr)) {
+                return 0; /* enter to wasm TB */
+            }
+            tb_ptr = get_tci_ptr(tb_ptr);
             break;
         case INDEX_op_qemu_ld:
             tci_args_rrm(insn, &r0, &r1, &oi);
@@ -621,3 +685,177 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
         }
     }
 }
+
+/*
+ * The maximum number of instances that can exist simultaneously
+ *
+ * If this limit is reached and a new instance is required, older instances are
+ * removed to allow creation of new ones without exceeding the browser's limit.
+ */
+#define MAX_INSTANCES 12000
+
+static int instances_global;
+
+/* Avoid overwrapping of begin/end pointers */
+#define INSTANCES_BUF_MAX (MAX_INSTANCES + 1)
+
+static __thread struct WasmInstanceInfo instances[INSTANCES_BUF_MAX];
+static __thread int instances_begin;
+static __thread int instances_end;
+
+static void add_instance(wasm_tb_func tb_func, void *tb_ptr)
+{
+    instances[instances_end].tb_func = tb_func;
+    instances[instances_end].tb_ptr = tb_ptr;
+    set_info_local(tb_ptr, &(instances[instances_end]));
+    instances_end  = (instances_end + 1) % INSTANCES_BUF_MAX;
+
+    qatomic_inc(&instances_global);
+}
+
+static __thread int instance_pending_gc;
+static __thread int instance_done_gc;
+
+static void remove_old_instances(void)
+{
+    int num;
+    if (instance_pending_gc > 0) {
+        return;
+    }
+    if (instances_begin <= instances_end) {
+        num = instances_end - instances_begin;
+    } else {
+        num = instances_end + (INSTANCES_BUF_MAX - instances_begin);
+    }
+    /* removes the half of the oldest instances in the buffer */
+    num /= 2;
+    for (int i = 0; i < num; i++) {
+        EM_ASM({ removeFunction($0); }, instances[instances_begin].tb_func);
+        instances[instances_begin].tb_ptr = NULL;
+        instances_begin = (instances_begin + 1) % INSTANCES_BUF_MAX;
+    }
+    instance_pending_gc += num;
+}
+
+static bool can_add_instance(void)
+{
+    return qatomic_read(&instances_global) < MAX_INSTANCES;
+}
+
+static wasm_tb_func get_instance_from_tb(void *tb_ptr)
+{
+    struct WasmInstanceInfo *elm = get_info_local(tb_ptr);
+    if (elm == NULL) {
+        return NULL;
+    }
+    if (elm->tb_ptr != tb_ptr) {
+        /*
+         * This TB was instantiated before, but has been removed. Set counter to
+         * the max value so that this will be instantiated.
+         */
+        set_counter_local(tb_ptr, INSTANTIATE_NUM);
+        set_info_local(tb_ptr, NULL);
+        return NULL;
+    }
+    return elm->tb_func;
+}
+
+static void check_gc_completion(void)
+{
+    if (instance_done_gc > 0) {
+        qatomic_sub(&instances_global, instance_done_gc);
+        instance_pending_gc -= instance_done_gc;
+        instance_done_gc = 0;
+    }
+}
+
+EM_JS_PRE(void, init_wasm_js, (void *instance_done_gc),
+{
+    Module.__wasm_tb = {
+        inst_gc_registry: new FinalizationRegistry((i) => {
+            if (i == "tbinstance") {
+                const memory_v = new DataView(HEAP8.buffer);
+                let v = memory_v.getInt32(DEC_PTR(instance_done_gc), true);
+                memory_v.setInt32(DEC_PTR(instance_done_gc), v + 1, true);
+            }
+        })
+    };
+});
+
+#define MAX_EXEC_NUM 50000
+static __thread int exec_cnt = MAX_EXEC_NUM;
+static inline void trysleep(void)
+{
+    /*
+     * Even during running TBs continuously, try to return the control
+     * to the browser periodically and allow browsers doing tasks.
+     */
+    if (--exec_cnt == 0) {
+        if (!can_add_instance()) {
+            emscripten_sleep(0);
+            check_gc_completion();
+        }
+        exec_cnt = MAX_EXEC_NUM;
+    }
+}
+
+static int thread_idx_max;
+
+static void init_wasm(void)
+{
+    thread_idx = qatomic_fetch_inc(&thread_idx_max);
+    ctx.stack = g_malloc(TCG_STATIC_CALL_ARGS_SIZE + TCG_STATIC_FRAME_SIZE);
+    ctx.buf128 = g_malloc(16);
+    ctx.tci_tb_ptr = (uint32_t *)&tci_tb_ptr;
+    init_wasm_js(&instance_done_gc);
+}
+
+static __thread bool initdone;
+
+uintptr_t tcg_qemu_tb_exec(CPUArchState *env, const void *v_tb_ptr)
+{
+    if (!initdone) {
+        init_wasm();
+        initdone = true;
+    }
+    ctx.env = env;
+    ctx.tb_ptr = (void *)v_tb_ptr;
+    while (true) {
+        trysleep();
+        uintptr_t res;
+        wasm_tb_func tb_func = get_instance_from_tb(ctx.tb_ptr);
+        if (tb_func) {
+            /*
+             * Call the Wasm instance
+             */
+            res = call_wasm_tb(tb_func, &ctx);
+        } else if (!inc_counter(ctx.tb_ptr)) {
+            /*
+             * Run it on TCI because the counter value is small
+             */
+            res = tcg_qemu_tb_exec_tci(env);
+        } else if (!can_add_instance()) {
+            /*
+             * Too many instances has been created, try removing older
+             * instances and keep running this TB on TCI
+             */
+            remove_old_instances();
+            check_gc_completion();
+            res = tcg_qemu_tb_exec_tci(env);
+        } else {
+            /*
+             * Instantiate and run the Wasm module
+             */
+            struct WasmTBHeader *header = (struct WasmTBHeader *)ctx.tb_ptr;
+            tb_func = (wasm_tb_func)instantiate_wasm(header->wasm_ptr,
+                                                     header->wasm_size,
+                                                     header->import_ptr,
+                                                     header->import_size);
+            add_instance(tb_func, ctx.tb_ptr);
+            res = call_wasm_tb(tb_func, &ctx);
+        }
+        if (!ctx.tb_ptr) {
+            return res;
+        }
+    }
+}
diff --git a/tcg/wasm64.h b/tcg/wasm64.h
index fdde908557..88163c28df 100644
--- a/tcg/wasm64.h
+++ b/tcg/wasm64.h
@@ -46,6 +46,14 @@ static inline uintptr_t call_wasm_tb(wasm_tb_func f, struct WasmContext *ctx)
     return f(ctx);
 }
 
+/*
+ * WasmInstanceInfo holds the relationship between TB and Wasm instance.
+ */
+struct WasmInstanceInfo {
+    void *tb_ptr;
+    wasm_tb_func tb_func;
+};
+
 /*
  * A TB of the Wasm backend starts from a header which contains pointers for
  * each data stored in the following region in the TB.
@@ -67,6 +75,43 @@ struct WasmTBHeader {
      */
     void *import_ptr;
     int import_size;
+
+    /*
+     * Counter holds how many times the TB is executed before the instantiation
+     * for each thread.
+     */
+    int32_t *counter_ptr;
+
+    /*
+     * Pointer to the instance information on each thread.
+     */
+    struct WasmInstanceInfo **info_ptr;
 };
 
+static inline void *get_tci_ptr(void *tb_ptr)
+{
+    return ((struct WasmTBHeader *)tb_ptr)->tci_ptr;
+}
+
+static inline int32_t get_counter(void *tb_ptr, int idx)
+{
+    return ((struct WasmTBHeader *)tb_ptr)->counter_ptr[idx];
+}
+
+static inline void set_counter(void *tb_ptr, int idx, int v)
+{
+    ((struct WasmTBHeader *)tb_ptr)->counter_ptr[idx] = v;
+}
+
+static inline struct WasmInstanceInfo *get_info(void *tb_ptr, int idx)
+{
+    return ((struct WasmTBHeader *)tb_ptr)->info_ptr[idx];
+}
+
+static inline void set_info(void *tb_ptr, int idx,
+                            struct WasmInstanceInfo *info)
+{
+    ((struct WasmTBHeader *)tb_ptr)->info_ptr[idx] = info;
+}
+
 #endif
diff --git a/tcg/wasm64/tcg-target.c.inc b/tcg/wasm64/tcg-target.c.inc
index ad9e5a43b5..8e62f6a237 100644
--- a/tcg/wasm64/tcg-target.c.inc
+++ b/tcg/wasm64/tcg-target.c.inc
@@ -28,6 +28,9 @@
 #include "qemu/queue.h"
 #include "../wasm64.h"
 
+/* This is included to get the number of threads via tcg_max_ctxs. */
+#include "../tcg-internal.h"
+
 /* Used for function call generation. */
 #define TCG_TARGET_CALL_STACK_OFFSET 0
 #define TCG_TARGET_STACK_ALIGN       8
@@ -2305,6 +2308,11 @@ static void tcg_out_set_carry(TCGContext *s)
     g_assert_not_reached();
 }
 
+/* Generate global QEMU prologue and epilogue code. */
+static inline void tcg_target_qemu_prologue(TCGContext *s)
+{
+}
+
 static const uint8_t mod_1[] = {
     0x0, 0x61, 0x73, 0x6d, /* magic */
     0x01, 0x0, 0x0, 0x0,   /* version */
@@ -2453,6 +2461,7 @@ static int write_mod_code(TCGContext *s)
 
 static void tcg_out_tb_start(TCGContext *s)
 {
+    int size;
     intptr_t ofs;
     struct WasmTBHeader *h;
 
@@ -2467,6 +2476,18 @@ static void tcg_out_tb_start(TCGContext *s)
     h = (struct WasmTBHeader *)(s->code_ptr);
     s->code_ptr += sizeof(struct WasmTBHeader);
 
+    /* locate counters */
+    h->counter_ptr = (int32_t *)s->code_ptr;
+    size = tcg_max_ctxs * sizeof(int32_t);
+    memset(s->code_ptr, 0, size);
+    s->code_ptr += size;
+
+    /* locate the instance information */
+    h->info_ptr = (struct WasmInstanceInfo **)s->code_ptr;
+    size = tcg_max_ctxs * sizeof(void *);
+    memset(s->code_ptr, 0, size);
+    s->code_ptr += size;
+
     /* Followed by TCI code */
     h->tci_ptr = s->code_ptr;
 
-- 
2.43.0



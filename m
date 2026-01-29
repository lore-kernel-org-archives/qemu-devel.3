Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD82D46BED
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 01:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlGtA-0008Se-Fu; Wed, 28 Jan 2026 20:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGt1-0008QM-33
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:31:55 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGsy-000388-Cl
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:31:54 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c634c20be90so155763a12.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 17:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769650311; x=1770255111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=giR0lEAONEiMMiYkdCiOQARrib58HlslRi8PTS8rJEc=;
 b=XuzqdhpvodNNH7Q3yn6uG+sqEvHxz2qx23U8wA8Dd9bEhiIjZu0sGCLEYLtehDmWZg
 t0qdARkvtoxqz76ZLcTZ48Knak2ff1G1oQG+88ewso3DDFPkCc/Tzb8XgmLX9jv/1q8K
 UfxsY8IrOtz6FpSfrHzVd6nkFVWBeJfpdI8QlS3//sCtsZYg8wX7gfPbQeUGD3t6FZk+
 xTpqc7PRx7g60A3H+1tB/Mka7g7PNHvb9eiN8IKIjcC4PXaKWi5eveHAbUrfSYAdRmhs
 OqzmqwV1qeGYzIpm1hqhicQfPYb9zbXaocX1D443MisjFvd1/GEC6M9w5QGl6rY6RStU
 kGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769650311; x=1770255111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=giR0lEAONEiMMiYkdCiOQARrib58HlslRi8PTS8rJEc=;
 b=cgzp/d7Gr8V/xh3fSF+ipTLz/5z/iOV47WHpB4VenMJIbMHn6Z2pN5RKxEFJBiEW38
 Viag5xRXquCqM2tQXgbsNLl7t6Hb8QL+IyM+i8uCwKuiGqraAyhRggmM9wkIrYIMJOfg
 yAiv40Eg/W1c6YRHrNNYvBuswtX8H0+AR7cxaB7dGkxfTx21zClXClXY63bKt7BVhIsK
 shA/wgjo//tQoJBvN0j3umtpCvj6/3mrh9k0nRHQ3/yGBwteMhT+69iUrUv5XFkrNv1z
 gjhezAzkQtgeAPgIrKJuX2fN9IohG2Ca4gqj8KE302Bm4GYJjjtDczeYD7b0y6p53tx1
 +vTg==
X-Gm-Message-State: AOJu0Yy7gNI14omQ3n2JZ6iNhPw31yc573IwSbZ4AaepeNsSKj9JeBa7
 oq7uU0s/AQagPViD/1vphF6uClCiLvWrDpUg2PUaQ4wpSDjNEUTzdDnpo7bA34wfU3GMsncLJgF
 k/AK1
X-Gm-Gg: AZuq6aLxa0cv9JvaUEbVd/H3aO/GHjyPgFs0r4ImcxDcQYgffcI0T5N95+/RlvYRcmP
 ieVCHXaX7tEgKp9rYz8pWEqEPXGVFXtiuUagfZXvgNoXBXLzqFyIBDVLDye8eXsXsmo4GG8V8De
 QxnSnf+LOn8iYQECcLSQHNk3qCjdGKzeLACcSHadZauD+pHV3R3lPMtZoH7DyMhyAE01KxKktRU
 waoVxOc/56vOTC+vnII3xZ5kdU1ir1E6ksAuwfWhSIA1kzMHEWLohNEJ7NKZ5PZxTi9eLOi3fPu
 huwDgkMzPtX8n60lpY15AAmvJmCifOew+s1smpePehoqovYdQfpWjHPCmuE1Qzg5yppv/9FK+XK
 Bh2MRFQBfP1bbRpQRS6dvm7cs0Fwf2FNDZV94MyiAd2GeprkTyHTyNRwHYQDgKZgtdsOjEI4BVV
 OtvUmfnVxyUEBGicq4L2tUZU4KlFS+PhgAk4o5rzKPEgQ0Sw7rcQjqgvF839H5dNYx
X-Received: by 2002:a17:90b:528c:b0:340:ec6f:5ac5 with SMTP id
 98e67ed59e1d1-353fecc689emr5606690a91.2.1769650310654; 
 Wed, 28 Jan 2026 17:31:50 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f61e0007sm6627143a91.12.2026.01.28.17.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:31:50 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ziyang Zhang <functioner@sjtu.edu.cn>, Mingyuan Xia <xiamy@ultrarisc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 06/20] linux-user: add plugin API to filter syscalls
Date: Wed, 28 Jan 2026 17:31:20 -0800
Message-ID: <20260129013134.3956938-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
References: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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

From: Ziyang Zhang <functioner@sjtu.edu.cn>

This commit adds a syscall filter API to the TCG plugin API set.
Plugins can register a filter callback to QEMU to decide whether
to intercept a syscall, process it and bypass the QEMU syscall
handler.

Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/plugin-event.h  |  1 +
 include/qemu/plugin.h        | 33 +++++++++++++++++++++++---------
 include/qemu/qemu-plugin.h   | 32 +++++++++++++++++++++++++++++++
 include/user/syscall-trace.h | 17 +++++++++++++++++
 linux-user/syscall.c         |  7 +++++--
 plugins/api.c                |  7 +++++++
 plugins/core.c               | 37 ++++++++++++++++++++++++++++++++++++
 7 files changed, 123 insertions(+), 11 deletions(-)

diff --git a/include/qemu/plugin-event.h b/include/qemu/plugin-event.h
index 1100dae2123..7f3c5927f1f 100644
--- a/include/qemu/plugin-event.h
+++ b/include/qemu/plugin-event.h
@@ -23,6 +23,7 @@ enum qemu_plugin_event {
     QEMU_PLUGIN_EV_VCPU_INTERRUPT,
     QEMU_PLUGIN_EV_VCPU_EXCEPTION,
     QEMU_PLUGIN_EV_VCPU_HOSTCALL,
+    QEMU_PLUGIN_EV_VCPU_SYSCALL_FILTER,
     QEMU_PLUGIN_EV_MAX, /* total number of plugin events we support */
 };
 
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index cea0a68858b..91df1e78d2c 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -55,15 +55,16 @@ void qemu_plugin_opt_parse(const char *optstr, QemuPluginList *head);
 int qemu_plugin_load_list(QemuPluginList *head, Error **errp);
 
 union qemu_plugin_cb_sig {
-    qemu_plugin_simple_cb_t          simple;
-    qemu_plugin_udata_cb_t           udata;
-    qemu_plugin_vcpu_simple_cb_t     vcpu_simple;
-    qemu_plugin_vcpu_udata_cb_t      vcpu_udata;
-    qemu_plugin_vcpu_discon_cb_t     vcpu_discon;
-    qemu_plugin_vcpu_tb_trans_cb_t   vcpu_tb_trans;
-    qemu_plugin_vcpu_mem_cb_t        vcpu_mem;
-    qemu_plugin_vcpu_syscall_cb_t    vcpu_syscall;
-    qemu_plugin_vcpu_syscall_ret_cb_t vcpu_syscall_ret;
+    qemu_plugin_simple_cb_t              simple;
+    qemu_plugin_udata_cb_t               udata;
+    qemu_plugin_vcpu_simple_cb_t         vcpu_simple;
+    qemu_plugin_vcpu_udata_cb_t          vcpu_udata;
+    qemu_plugin_vcpu_discon_cb_t         vcpu_discon;
+    qemu_plugin_vcpu_tb_trans_cb_t       vcpu_tb_trans;
+    qemu_plugin_vcpu_mem_cb_t            vcpu_mem;
+    qemu_plugin_vcpu_syscall_cb_t        vcpu_syscall;
+    qemu_plugin_vcpu_syscall_ret_cb_t    vcpu_syscall_ret;
+    qemu_plugin_vcpu_syscall_filter_cb_t vcpu_syscall_filter;
     void *generic;
 };
 
@@ -169,6 +170,11 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1,
                          uint64_t a2, uint64_t a3, uint64_t a4, uint64_t a5,
                          uint64_t a6, uint64_t a7, uint64_t a8);
 void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret);
+bool
+qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
+                                uint64_t a2, uint64_t a3, uint64_t a4,
+                                uint64_t a5, uint64_t a6, uint64_t a7,
+                                uint64_t a8, uint64_t *ret);
 
 void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                              uint64_t value_low,
@@ -280,6 +286,15 @@ static inline
 void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
 { }
 
+static inline bool
+qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
+                                uint64_t a2, uint64_t a3, uint64_t a4,
+                                uint64_t a5, uint64_t a6, uint64_t a7,
+                                uint64_t a8, uint64_t *ret)
+{
+    return false;
+}
+
 static inline void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                                            uint64_t value_low,
                                            uint64_t value_high,
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 60de4fdd3fa..84976fd67dd 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -798,6 +798,33 @@ typedef void
                                  uint64_t a3, uint64_t a4, uint64_t a5,
                                  uint64_t a6, uint64_t a7, uint64_t a8);
 
+/**
+ * typedef qemu_plugin_vcpu_syscall_filter_cb_t - vCPU syscall filter callback
+ * function type
+ * @id: plugin id
+ * @vcpu_index: the executing vCPU
+ * @num: the syscall number
+ * @a1: the 1st syscall argument
+ * @a2: the 2nd syscall argument
+ * @a3: the 3rd syscall argument
+ * @a4: the 4th syscall argument
+ * @a5: the 5th syscall argument
+ * @a6: the 6th syscall argument
+ * @a7: the 7th syscall argument
+ * @a8: the 8th syscall argument
+ * @sysret: reference of the syscall return value, must set this if filtered
+ *
+ * Returns true if you want to filter this syscall (i.e. stop it being
+ * handled further), otherwise returns false.
+ */
+typedef bool
+(*qemu_plugin_vcpu_syscall_filter_cb_t)(qemu_plugin_id_t id,
+                                        unsigned int vcpu_index,
+                                        int64_t num, uint64_t a1, uint64_t a2,
+                                        uint64_t a3, uint64_t a4, uint64_t a5,
+                                        uint64_t a6, uint64_t a7, uint64_t a8,
+                                        uint64_t *sysret);
+
 QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
                                           qemu_plugin_vcpu_syscall_cb_t cb);
@@ -811,6 +838,11 @@ void
 qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
                                          qemu_plugin_vcpu_syscall_ret_cb_t cb);
 
+QEMU_PLUGIN_API
+void
+qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin_id_t id,
+                                            qemu_plugin_vcpu_syscall_filter_cb_t cb);
+
 
 /**
  * qemu_plugin_insn_disas() - return disassembly string for instruction
diff --git a/include/user/syscall-trace.h b/include/user/syscall-trace.h
index 9bd7ca19c84..4ee6c4e5134 100644
--- a/include/user/syscall-trace.h
+++ b/include/user/syscall-trace.h
@@ -39,5 +39,22 @@ static inline void record_syscall_return(CPUState *cpu, int num, abi_long ret)
     gdb_syscall_return(cpu, num);
 }
 
+static bool send_through_syscall_filters(CPUState *cpu, int num,
+                                         abi_long arg1, abi_long arg2,
+                                         abi_long arg3, abi_long arg4,
+                                         abi_long arg5, abi_long arg6,
+                                         abi_long arg7, abi_long arg8,
+                                         abi_long *sysret)
+{
+    uint64_t sysret64 = 0;
+    bool filtered = qemu_plugin_vcpu_syscall_filter(cpu, num, arg1, arg2,
+                                                    arg3, arg4, arg5, arg6,
+                                                    arg7, arg8, &sysret64);
+    if (filtered) {
+        *sysret = sysret64;
+    }
+    return filtered;
+}
+
 
 #endif /* SYSCALL_TRACE_H */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3944004568f..c904febd9bb 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -14368,8 +14368,11 @@ abi_long do_syscall(CPUArchState *cpu_env, int num, abi_long arg1,
         print_syscall(cpu_env, num, arg1, arg2, arg3, arg4, arg5, arg6);
     }
 
-    ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
-                      arg5, arg6, arg7, arg8);
+    if (!send_through_syscall_filters(cpu, num, arg1, arg2, arg3, arg4, arg5,
+                                      arg6, arg7, arg8, &ret)) {
+        ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
+                          arg5, arg6, arg7, arg8);
+    }
 
     if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
         print_syscall_ret(cpu_env, num, ret, arg1, arg2,
diff --git a/plugins/api.c b/plugins/api.c
index eac04cc1f6b..478d0c88890 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -208,6 +208,13 @@ qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
     plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_SYSCALL_RET, cb);
 }
 
+void
+qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin_id_t id,
+                                            qemu_plugin_vcpu_syscall_filter_cb_t cb)
+{
+    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_SYSCALL_FILTER, cb);
+}
+
 /*
  * Plugin Queries
  *
diff --git a/plugins/core.c b/plugins/core.c
index b4b783008f7..85fabf9ec81 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -564,6 +564,43 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
     }
 }
 
+/*
+ * Disable CFI checks.
+ * The callback function has been loaded from an external library so we do not
+ * have type information
+ */
+QEMU_DISABLE_CFI
+bool
+qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
+                                uint64_t a2, uint64_t a3, uint64_t a4,
+                                uint64_t a5, uint64_t a6, uint64_t a7,
+                                uint64_t a8, uint64_t *sysret)
+{
+    struct qemu_plugin_cb *cb, *next;
+    enum qemu_plugin_event ev = QEMU_PLUGIN_EV_VCPU_SYSCALL_FILTER;
+    bool filtered = false;
+
+    if (!test_bit(ev, cpu->plugin_state->event_mask)) {
+        return false;
+    }
+
+    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+
+    QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
+        qemu_plugin_vcpu_syscall_filter_cb_t func = cb->f.vcpu_syscall_filter;
+
+        if (func(cb->ctx->id, cpu->cpu_index, num, a1, a2, a3, a4,
+                 a5, a6, a7, a8, sysret)) {
+            filtered = true;
+            break;
+        }
+    }
+
+    qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
+
+    return filtered;
+}
+
 void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
 {
     /* idle and resume cb may be called before init, ignore in this case */
-- 
2.47.3



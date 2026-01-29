Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1EED73E81
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 17:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlVyO-0004ag-Qa; Thu, 29 Jan 2026 12:38:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyN-0004Ws-HN
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:27 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyK-0000eF-UR
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:27 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3541fd9dacdso587394a91.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 09:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769708303; x=1770313103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AhJDAaYUhDrqX/q/1jMneEFS4p0nFap0+VJEN+IJhGk=;
 b=jd8omEiBbZh469d7Q9qXas4DkO4lezMuZ7eJB/yklbOeI+DvEtnI64fnuYvWEYE+yu
 NhzUq+SMtlPOlDQu78lslFwMv7U7YxgodnsMmHocAK8lYY77x4yhl9pS/Gc/V4YOgnpT
 q6uhbbNxkYEJHXJhRKa7yO2iiPeRfzPUNqdSZqpWw7LlJZtzgqKS8hI44c6DnS+IIx+0
 Py3HcbL2ACZgRk39y1Z+hJdjYaHcNMTmvvNgQ71iPM9jKINoDWN4XJT74Whl5bm7S0CZ
 WnN6moDY55u0jgtRGFogs9YdFHKPBcIuyeeGU1TWP4HHgGc8o72heHH1nZ361LimjoLT
 Fa0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769708303; x=1770313103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AhJDAaYUhDrqX/q/1jMneEFS4p0nFap0+VJEN+IJhGk=;
 b=X0iuWRNaAKyUhAya4NuGfqksG/U65/eYAW0tsATVrsU+CpA7ef9mAANrYfSU6kwOyz
 n2w7Dfbi4a+SpOtkE26bTxgsZavbffL2mee6oEAIqYYsWNj7ij2NdIR49X5/AnL/fTmX
 Dh4zdqVjnJVnAB4cR046bHOsLKGySCQEYi9JJlrwJMeq8+5PCFF8hLwCEN4KAn7T5v1B
 CUnB8sInFUSVpiwW+CGfF17/CTS/l0gvtDp8cLn7s+pjCCqtcXfA1Btyl2sNIUHG5CHH
 92/38Egi4n7DgnAU1EAHIMFEtiEkATcnpm6KumRPomUWH9lZRleZ8a6BVacMdYXFmEE+
 7DSw==
X-Gm-Message-State: AOJu0YwwbdCSyN3VHerNK1i7CsKNkiSr6Qc9V0sD2rxjRBJZyAGrwfaJ
 F2afdh1f9Ml1dg2MgPSlUuAuZ0Uick9Hf1W69X9fEyiYWy0W4II/vOUCsKktsuIfoNuzvZCxhHR
 Fj37m
X-Gm-Gg: AZuq6aLrEYi/Qm6SNINbBjOiiptQ2VZcbn1a2HgirDHw4+4FBhA+TSIiyjoUY4fe1OM
 XtTl/z8zOQYS3iOEn73BI3X+1eQkvKeM/bF/U8fi4mZdybnCh5Ka8KjCJF5FwcPZF+PTF3X+1y4
 +5QVUJ8AQIiQpi5gsdiy3dPUt4uJgfCiKBfIc7GmklEnuJidcKVGMto7HS5VLBXMZwx3d8RKNTN
 a5YqVFI35gjkEcvvz3DQ+cuEa89nmy/caJ2Cqf1RX5ah2H8X15aETjsqZY3eM2F47B71+1Ah6xE
 lZbFC2qBnabMOUw12kRdmCi1DPje7Sgyr04q+GO0/Mf+II0xNGwSiSB1w8s7Ej/Cjj9HEg5/G8J
 VhPWuA+fYhsgRoTNnxanvBqG9REIQ5XoDiCuBUlqLhFyd5dLuSqjkbYFSNFuoL8voIdDzWNdTJ4
 kvt1QXp3saO0Wq46WmXBlkZuONkiUUPz2HjfsJIpjpPU89zCvdzgCn1gnLpRboNq0J2blF1BnQG
 d0=
X-Received: by 2002:a17:90a:f944:b0:352:d933:5574 with SMTP id
 98e67ed59e1d1-35429ac7f79mr3397518a91.9.1769708303160; 
 Thu, 29 Jan 2026 09:38:23 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b222f1sm6706246b3a.7.2026.01.29.09.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:38:22 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ziyang Zhang <functioner@sjtu.edu.cn>, Mingyuan Xia <xiamy@ultrarisc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 07/21] linux-user: add plugin API to filter syscalls
Date: Thu, 29 Jan 2026 09:37:53 -0800
Message-ID: <20260129173811.138036-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
References: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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
[Pierrick - move send_through_syscall_filters to linux-user/syscall.c]
Link: https://lore.kernel.org/qemu-devel/20251214144620.179282-2-functioner@sjtu.edu.cn
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/plugin-event.h |  1 +
 include/qemu/plugin.h       | 33 ++++++++++++++++++++++++---------
 include/qemu/qemu-plugin.h  | 32 ++++++++++++++++++++++++++++++++
 linux-user/syscall.c        | 24 ++++++++++++++++++++++--
 plugins/api.c               |  7 +++++++
 plugins/core.c              | 37 +++++++++++++++++++++++++++++++++++++
 6 files changed, 123 insertions(+), 11 deletions(-)

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
index cea0a68858b..b74a7d0811b 100644
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
+                                uint64_t a8, uint64_t *sysret);
 
 void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                              uint64_t value_low,
@@ -280,6 +286,15 @@ static inline
 void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
 { }
 
+static inline bool
+qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
+                                uint64_t a2, uint64_t a3, uint64_t a4,
+                                uint64_t a5, uint64_t a6, uint64_t a7,
+                                uint64_t a8, uint64_t *sysret)
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
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b4b551ad148..3e6a56aa0f6 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -14352,6 +14352,23 @@ static void record_syscall_return(CPUState *cpu, int num, abi_long ret)
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
 abi_long do_syscall(CPUArchState *cpu_env, int num, abi_long arg1,
                     abi_long arg2, abi_long arg3, abi_long arg4,
                     abi_long arg5, abi_long arg6, abi_long arg7,
@@ -14386,8 +14403,11 @@ abi_long do_syscall(CPUArchState *cpu_env, int num, abi_long arg1,
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



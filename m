Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E48D73E81
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 17:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlVyS-0004pB-8N; Thu, 29 Jan 2026 12:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyO-0004Zz-Hg
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:28 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyM-0000eq-8q
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:28 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c05d66dbab2so810327a12.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 09:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769708305; x=1770313105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jRW4en1n4D1kiZQqnRmRGh7FNpXXpDUSpvCX7m51XUg=;
 b=WlOtzjp7EVaGPzCMOKdvv0Ha4TCD18i3tLvLt8yGotc9LlnD1CQQ8u/SxA//SteKjQ
 eFehD8eHOGMU+JuK4HDf3Jz5mad8ghPoS654m32u9kpqWu8c1yuCO7JQquIwUVF1ziXx
 +wyCSb10xL5Et5bsgLp0ZcyYe/FezumsipEXUR0s3KyoLLgNSZ75JQpKX8yoPhzwd8Ib
 zsik97zC1+TZmpBf3s0FGH6K0EFnYabY5E7UJ7y0hfLkugrq/wXQNTzPNZEHpn4Qvtao
 vxYalNps5+2F4ITagK1ntSWrGzWO39+/EiQwW+OICUaz3uBoWfm/A3jrRvcu1iLT+W4N
 rTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769708305; x=1770313105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jRW4en1n4D1kiZQqnRmRGh7FNpXXpDUSpvCX7m51XUg=;
 b=XJCxekrsD/J5cfRKPchIu594Nl422up1gTPsUoHPXH8GMYafUtjbvxlq4XtnUmTOkx
 uApzPWENmbqerOG7Kgd9Uot5bw+Wdej02r+5CFdUNbVmHbBG9k0vtzTd7OIZ5VQ9XGoT
 mBCiTCXH0h1AO4+oOdDrNQ0/Kd00U5y2Swx7nVvKZIAcOTpyGNefxmvvyqaYAKx7qokQ
 2G4slRLpojd8Hx8m2zvK83jUedjxW+zkUOQlJX0g0z29y1CqjpjbmfnELLXDx8x0aq6D
 ExYST9sa+vKeeOhWT6fH1s9qM9XqNiFm35nqFn8Mm9s8jmGMaBWKloSznFPHP3c2rMLu
 KZng==
X-Gm-Message-State: AOJu0YwMCV+UUvQXTkfi66Hg5vEvwb3awDrtboRabSpuadrCB7n9f9Ee
 ZO3DgD47PwJuWXMWpxqGZnHMviswaJ/JMzxXNssog50L3DFdNC4AYA4WDTxCjiICFhTBarBau9w
 Gg+/g
X-Gm-Gg: AZuq6aK/sHzsxsgQf8NNR0V5ElFvhIWcdru62lHIhI6orS8JcOngm1BMq+jvLJSfcfU
 x7Eg0o7hrLh4u+3HZqZaoBMEtg3S7sNxiEccaCmC8TiVz5zGFkyHS/M6piiHOGE1INecOJdyd+W
 9Kz6k6N/b4cAo1SXMfIhtbShFr6F7J6ytm4oYWcp93712S2C40FfvdBKztcqf8qWaN2T3uMrrjY
 enHkM28r+hbsYTRAeqkL5GvgYi+Lf+dDrLpwonnhHPK2/LCeVOd3JAhpxE4Jcc+vsI/lH3iPzjI
 wM96VdGjERFZ4h70tYSU/v4WUSlL1pdJfKJP0jc3l6jLH9oieuZO6ymKDRCvbuGXQ/IQNkvhosX
 ozgkABS02h0/va9dU4upa0eJ+9nuXs4pVMaEgXMOh9kEfcsyaoCchBrkDeITNPRZJyg8EH48Qzb
 qCCXaZJz03i1/RqXekBi163oZBKrYQDzEJwtDoK6KTqkFqQFFfKUXIkWn45Sj0S4PF
X-Received: by 2002:a17:90b:2dc1:b0:338:3789:2e7b with SMTP id
 98e67ed59e1d1-3543b31af54mr262295a91.13.1769708304667; 
 Thu, 29 Jan 2026 09:38:24 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b222f1sm6706246b3a.7.2026.01.29.09.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:38:24 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 09/21] plugins: return bool from register r/w API
Date: Thu, 29 Jan 2026 09:37:55 -0800
Message-ID: <20260129173811.138036-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
References: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
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

From: Florian Hofhammer <florian.hofhammer@fhofhammer.de>

The qemu_plugin_{read,write} register API previously was inconsistent
with regard to its docstring (where a return value of both -1 and 0
would indicate an error) and to the memory read/write APIs, which
already return a boolean value to indicate success or failure.
Returning the number of bytes read or written is superfluous, as the
GByteArray* passed to the API functions already encodes the length.
See the linked thread for more details.

This patch moves from returning an int (number of bytes read/written) to
returning a bool from the register read/write API, bumps the plugin API
version, and adjusts plugins and tests accordingly.

Signed-off-by: Florian Hofhammer <florian.hofhammer@fhofhammer.de>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/f877dd79-1285-4752-811e-f0d430ff27fe@fhofhammer.de
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/qemu-plugin.h | 19 +++++++++++--------
 contrib/plugins/execlog.c  | 14 ++++++++------
 contrib/plugins/uftrace.c  |  8 ++++----
 plugins/api.c              | 29 +++++++++++++++--------------
 tests/tcg/plugins/insn.c   |  4 ++--
 5 files changed, 40 insertions(+), 34 deletions(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 84976fd67dd..eb6179ab1ab 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -72,11 +72,14 @@ typedef uint64_t qemu_plugin_id_t;
  * - added qemu_plugin_write_memory_hwaddr
  * - added qemu_plugin_write_register
  * - added qemu_plugin_translate_vaddr
+ *
+ * version 6:
+ * - changed return value of qemu_plugin_{read,write}_register from int to bool
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
-#define QEMU_PLUGIN_VERSION 5
+#define QEMU_PLUGIN_VERSION 6
 
 /**
  * struct qemu_info_t - system information for plugins
@@ -1004,12 +1007,12 @@ GArray *qemu_plugin_get_registers(void);
  * qemu_plugin_register_vcpu_init_cb(), except for callbacks registered with
  * qemu_plugin_register_atexit_cb() and qemu_plugin_register_flush_cb().
  *
- * Returns the size of the read register. The content of @buf is in target byte
- * order. On failure returns -1.
+ * Returns true on success, false on failure. The content of @buf is in target
+ * byte order.
  */
 QEMU_PLUGIN_API
-int qemu_plugin_read_register(struct qemu_plugin_register *handle,
-                              GByteArray *buf);
+bool qemu_plugin_read_register(struct qemu_plugin_register *handle,
+                               GByteArray *buf);
 
 /**
  * qemu_plugin_write_register() - write register for current vCPU
@@ -1029,11 +1032,11 @@ int qemu_plugin_read_register(struct qemu_plugin_register *handle,
  * Attempting to write a register with @buf smaller than the register size
  * will result in a crash or other undesired behavior.
  *
- * Returns the number of bytes written. On failure returns 0.
+ * Returns true on sucess, false on failure.
  */
 QEMU_PLUGIN_API
-int qemu_plugin_write_register(struct qemu_plugin_register *handle,
-                              GByteArray *buf);
+bool qemu_plugin_write_register(struct qemu_plugin_register *handle,
+                                GByteArray *buf);
 
 /**
  * qemu_plugin_read_memory_vaddr() - read from memory using a virtual address
diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index 811f3203199..d00d9c4ff39 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -91,11 +91,13 @@ static void insn_check_regs(CPU *cpu)
 {
     for (int n = 0; n < cpu->registers->len; n++) {
         Register *reg = cpu->registers->pdata[n];
-        int sz;
+        bool success = false;
+        int sz = 0;
 
         g_byte_array_set_size(reg->new, 0);
-        sz = qemu_plugin_read_register(reg->handle, reg->new);
-        g_assert(sz > 0);
+        success = qemu_plugin_read_register(reg->handle, reg->new);
+        g_assert(success);
+        sz = reg->new->len;
         g_assert(sz == reg->last->len);
 
         if (memcmp(reg->last->data, reg->new->data, sz)) {
@@ -303,7 +305,7 @@ static Register *init_vcpu_register(qemu_plugin_reg_descriptor *desc)
 {
     Register *reg = g_new0(Register, 1);
     g_autofree gchar *lower = g_utf8_strdown(desc->name, -1);
-    int r;
+    bool success = false;
 
     reg->handle = desc->handle;
     reg->name = g_intern_string(lower);
@@ -311,8 +313,8 @@ static Register *init_vcpu_register(qemu_plugin_reg_descriptor *desc)
     reg->new = g_byte_array_new();
 
     /* read the initial value */
-    r = qemu_plugin_read_register(reg->handle, reg->last);
-    g_assert(r > 0);
+    success = qemu_plugin_read_register(reg->handle, reg->last);
+    g_assert(success);
     return reg;
 }
 
diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index b7d6124d2f5..a7e21b5b87a 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -403,8 +403,8 @@ static uint64_t cpu_read_register64(Cpu *cpu, struct qemu_plugin_register *reg)
 {
     GByteArray *buf = cpu->buf;
     g_byte_array_set_size(buf, 0);
-    size_t sz = qemu_plugin_read_register(reg, buf);
-    g_assert(sz == 8);
+    bool success = qemu_plugin_read_register(reg, buf);
+    g_assert(success);
     g_assert(buf->len == 8);
     return *((uint64_t *) buf->data);
 }
@@ -413,8 +413,8 @@ static uint32_t cpu_read_register32(Cpu *cpu, struct qemu_plugin_register *reg)
 {
     GByteArray *buf = cpu->buf;
     g_byte_array_set_size(buf, 0);
-    size_t sz = qemu_plugin_read_register(reg, buf);
-    g_assert(sz == 4);
+    bool success = qemu_plugin_read_register(reg, buf);
+    g_assert(success);
     g_assert(buf->len == 4);
     return *((uint32_t *) buf->data);
 }
diff --git a/plugins/api.c b/plugins/api.c
index 478d0c88890..04ca7da7f18 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -441,27 +441,28 @@ GArray *qemu_plugin_get_registers(void)
     return create_register_handles(regs);
 }
 
-int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
-{
-    g_assert(current_cpu);
-
-    if (qemu_plugin_get_cb_flags() == QEMU_PLUGIN_CB_NO_REGS) {
-        return -1;
-    }
-
-    return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1);
-}
-
-int qemu_plugin_write_register(struct qemu_plugin_register *reg,
+bool qemu_plugin_read_register(struct qemu_plugin_register *reg,
                                GByteArray *buf)
 {
     g_assert(current_cpu);
 
+    if (qemu_plugin_get_cb_flags() == QEMU_PLUGIN_CB_NO_REGS) {
+        return false;
+    }
+
+    return (gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1) > 0);
+}
+
+bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
+                                GByteArray *buf)
+{
+    g_assert(current_cpu);
+
     if (buf->len == 0 || qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS) {
-        return -1;
+        return false;
     }
 
-    return gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1);
+    return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1) > 0);
 }
 
 bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
index 0c723cb9ed8..e6c5207cd69 100644
--- a/tests/tcg/plugins/insn.c
+++ b/tests/tcg/plugins/insn.c
@@ -93,8 +93,8 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
         for (int i = 0; i < reg_list->len; i++) {
             qemu_plugin_reg_descriptor *rd = &g_array_index(
                 reg_list, qemu_plugin_reg_descriptor, i);
-            int count = qemu_plugin_read_register(rd->handle, reg_value);
-            g_assert(count > 0);
+            bool success = qemu_plugin_read_register(rd->handle, reg_value);
+            g_assert(success);
         }
     }
 }
-- 
2.47.3



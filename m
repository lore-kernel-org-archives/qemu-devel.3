Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7797AD46BED
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 01:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlGtJ-0000CB-CU; Wed, 28 Jan 2026 20:32:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGt4-0008S1-R4
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:32:00 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGt0-00038R-Rp
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:31:57 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-35334ea1f98so163938a91.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 17:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769650312; x=1770255112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3x33sGUogc98J6/q8zrZmHmk+T7es1uYQnijvAf3eXY=;
 b=U7BxIe2aH53aADn0Zi0vChZUowXEFaNRXjTKXEHdiomQWIMEhYnopOOgXWao+axDxj
 TbO2du5b+roA0qSB5D7jaheb7ZS+srNzjxE8lcRRuWStBbT72T6DT5vBbRli3nVA2lRy
 GAdmjnMkNRL+6jC2j7CKhcwlRKnptkiN0WK838D+wbBNt/wNTVoMbP09Yi1hLjgMVlbZ
 IDqmqcHglrqxotPtSrukiEwGSxZM5t6ktY6IyQAaVPpa9PpXLHpvoSZ7ansu3sUDSM7T
 KcolkGcywcwldo6bQjNSf6uAsuUWM9acbmUyy35/poSqOFKis3pJtW7Jc+BZx6BTnI7C
 vB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769650312; x=1770255112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3x33sGUogc98J6/q8zrZmHmk+T7es1uYQnijvAf3eXY=;
 b=UMaNkLKwUwRO3S4xkwurdoprUDYRJbe8BsnU3yNg7EefhcbT5V0sRaFGTC5qJrzk2A
 ZL9Rp2TmIOf+gk3+kB9IZ4xDlPZ9ogWMeW/2NniJBJUlGmrn94HhyHizd1U3bS4OiL7J
 V45DvkUayy1qdROTYpKq7VULaNwkcG22LLe1fpKMCZCDq9HJLvZytKR1mpaISU9+x6QW
 hKUjsYbzeVawj58fiQK95XNil11H7/O1er2V5ZpAlWd8lYpR9uVmT8WK+qPac0FC+DZ0
 L8r3+PhErK6clEL4f0MQxh/s6Y7BV+K1BZ+alJQ9c9rDTD/wV2tkxL8cFbcvn4Cd6dSg
 aFNQ==
X-Gm-Message-State: AOJu0Yy1rfyXmVr0rbfZ1onq5JWWF959OMoMwwpCAgTQuiVVpEXPrymI
 t3796OBpGicN+KWXjBkv7yFVHayiwM+43pMZuIJTsBbC9DxnjrLGe9qXODDVpR58tOYeSH5Bw8/
 qHgva
X-Gm-Gg: AZuq6aLZHcQp9/y08QU9rCNYNQHefO20fdC3gGTU4n/rRwKxb7yVpUen3n+P330iLQp
 cM+PkHKuMibZozlTQ2287vp3jHOip5sFQ06Xi6kj1njTAfVvHZsD5XNtOVZFLrCL+gDL3yEvlve
 tVjBuEDWK7P6znl5mzq45rNdUm2R/uWldjG2m4NUoCVb3g5NzH9s8fZCAEXalTPLoc4aACOv4Ow
 DlVDKqPW+A4bOo/+Ogdx5xeeJSvri2jYgTmqg8gbGAdlTLHdnNNOQDv+XfOU5tWJH7xXHbcqaXF
 ADXKG8VH0UYnGgzIejCAp3Ll1+fWc6xqn5I/YQpMfUG3NW0D3Ru4qkvq+uEbQbrT6Q2owkwLofB
 U2405d9MQ5U0wwJ9FMiuF3DAaf6CrIfEHE014VZJCtn9Cr8qdkl6MN3jlXT/xikNT/v7nN1o6FU
 lBmqWjZ+DKhaPQHUHM3nUNxXuqiUPgp3uH2dSv91KYyrH8r0mEBkRAQr9aAfFpOZxP
X-Received: by 2002:a17:90b:37ce:b0:34c:2db6:57a7 with SMTP id
 98e67ed59e1d1-353feccb22bmr6137348a91.8.1769650312250; 
 Wed, 28 Jan 2026 17:31:52 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f61e0007sm6627143a91.12.2026.01.28.17.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:31:51 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 08/20] plugins: return bool from register r/w API
Date: Wed, 28 Jan 2026 17:31:22 -0800
Message-ID: <20260129013134.3956938-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
References: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
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

Link: https://lore.kernel.org/qemu-devel/60089475-3891-4448-bfe0-8dd698cd2435@epfl.ch/
Signed-off-by: Florian Hofhammer <florian.hofhammer@fhofhammer.de>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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



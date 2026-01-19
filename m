Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE8ED29C2A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 14:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhq23-0003QT-Ir; Mon, 19 Jan 2026 09:15:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@fhofhammer.de>)
 id 1vhp98-0000lP-Nc
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 08:18:18 -0500
Received: from mwd01m.fhofhammer.de ([2a02:c207:3002:3725::1])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@fhofhammer.de>)
 id 1vhp96-0004oX-Fr
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 08:18:18 -0500
Message-ID: <f877dd79-1285-4752-811e-f0d430ff27fe@fhofhammer.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fhofhammer.de;
 s=2023; t=1768828693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
 bh=+zvffJgGv3ouUsYkA0vKSbqYjNB5VVO1dcPMheaIZdo=;
 b=zJBdWFl2qovILoddCoPktI97b4QhxYeTqdYJ5RmkMIPQiQXJTH2mP+kf0I7XRfL5PhI6GM
 k0KCcecpBQZfHrz8XNXywzaTzuPGqpKRp6qxTmLv2Rd7JSffo0zUBrQBgs3/49kHnkLtSX
 pIxBsyCWprBks6eGQB2y4TDSLdKVTAm1eoOrH1UnyXccY9f6x/sJ+NO0EDbGUYfdrQEk7S
 mI3HCtaQJIqn6e6XyxlsrQJ3XdIBzBVBv/6FN8ic1+K28yeUBpFbD9/wAqBtxkPbpESsAQ
 qtDpp8sPL0XU2N5FSjgp+wVqgOMiR11QdLcfrydebath8tp5kzLmbxlt2rrdzj/+UgFsML
 0qe3IitZvLdCTQZbTK8c4kA7f9EUEtIieCCpvwPS2RhX0AqU879kcy/1SDNY7yLte2X2/U
 HlbxIvQ6vwBns0NosyswKj9t9/wP2fuhgg5IMoa6Bb6Yint2YaEpiOVHzWtMem7Iv4BS5k
 rq7J5wvCF7sA+Fzlj0JY/JK3N0WoTZY0FzsT+wUvUFzmsEwSdFQpUE+sLuNcYPfiLCFFo0
 GhXBuWTpp0kl66DGBvPwSefmciz6IzT86JJMMnzcAt87j7K+wCSHEDIYSMOHC9XtPePLtw
 LGFKC9pGJI8YO2LTAZcrpflvYhNj4Zq9Vp8T+rLAPN6TlHxR9KEYo=
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=florian.hofhammer@fhofhammer.de
 smtp.mailfrom=florian.hofhammer@fhofhammer.de
Date: Mon, 19 Jan 2026 14:18:12 +0100
MIME-Version: 1.0
From: Florian Hofhammer <florian.hofhammer@fhofhammer.de>
Subject: [PATCH] plugins: return bool from register r/w API
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=florian.hofhammer@fhofhammer.de; keydata=
 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
 /zEc5hMMZIzTI4AtIcgA3xe4Ew==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:c207:3002:3725::1;
 envelope-from=florian.hofhammer@fhofhammer.de; helo=mwd01m.fhofhammer.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 19 Jan 2026 09:14:03 -0500
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
---
 contrib/plugins/execlog.c  | 14 ++++++++------
 contrib/plugins/uftrace.c  |  8 ++++----
 include/qemu/qemu-plugin.h | 19 +++++++++++--------
 plugins/api.c              | 15 ++++++++-------
 tests/tcg/plugins/insn.c   |  4 ++--
 5 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index 811f320319..d00d9c4ff3 100644
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
index b7d6124d2f..a7e21b5b87 100644
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
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 60de4fdd3f..c3b0532619 100644
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
@@ -972,12 +975,12 @@ GArray *qemu_plugin_get_registers(void);
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
@@ -997,11 +1000,11 @@ int qemu_plugin_read_register(struct qemu_plugin_register *handle,
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
diff --git a/plugins/api.c b/plugins/api.c
index eac04cc1f6..d8846b4773 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -434,27 +434,28 @@ GArray *qemu_plugin_get_registers(void)
     return create_register_handles(regs);
 }
 
-int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
+bool qemu_plugin_read_register(struct qemu_plugin_register *reg,
+                               GByteArray *buf)
 {
     g_assert(current_cpu);
 
     if (qemu_plugin_get_cb_flags() == QEMU_PLUGIN_CB_NO_REGS) {
-        return -1;
+        return false;
     }
 
-    return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1);
+    return (gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1) > 0);
 }
 
-int qemu_plugin_write_register(struct qemu_plugin_register *reg,
-                               GByteArray *buf)
+bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
+                                GByteArray *buf)
 {
     g_assert(current_cpu);
 
     if (buf->len == 0 || qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS) {
-        return -1;
+        return false;
     }
 
-    return gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1);
+    return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1) > 0);
 }
 
 bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
index 0c723cb9ed..e6c5207cd6 100644
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

base-commit: c1c58cee16380f81f88fbde6b12f247b376839e2
-- 
2.51.0



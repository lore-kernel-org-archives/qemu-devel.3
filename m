Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76032C61CE7
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Jun 2025 23:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOP7r-0005sD-JX; Sun, 08 Jun 2025 19:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOP7p-0005rI-Ib
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 19:08:25 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOP7n-0004b4-Jq
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 19:08:25 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-234fcadde3eso44409565ad.0
 for <qemu-devel@nongnu.org>; Sun, 08 Jun 2025 16:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749424102; x=1750028902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DkzAOT9KPhbXdwiYkwrjtSXHJRVHCh65cjh/wF+xrzM=;
 b=JGrAFyYFgm1ogavrwMUzG0GtZc4o0wjKOZm5Rn4DVWUA1a10yeQlPLk7IA3VnU0NK7
 r39xzkQsR/LCJfFfR0EYmcpTGHjcqmGcKAw2NgUD2phuG0kd3PFBaJ9zwUQP3tHT1iWY
 rD5qyhLNngqWf3BUfDQbiN6l6q8a8JyUOdy+2sBs5zMgzni7xIrI7hYyJwWJHySUMdND
 a6j6vu0ofkDRP6BXAkIbUvr7WntoOYp0nNLRD+HFSx6Eypem0ZSBHk+/MrXp8u3hcHpV
 GEs75ujL6Vz/j09JdRjjNIQn+aD4rOZfvr3N0ix3RMHVHJuEqyD/VJtbex4JVth1hIlW
 /zwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749424102; x=1750028902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DkzAOT9KPhbXdwiYkwrjtSXHJRVHCh65cjh/wF+xrzM=;
 b=K5aG6wIycsSCkgHHxWq7C8B/PfhD5vQGQCtAy76tmnKiZYK9D3/21KwQCK3FMBTCIB
 QwilA1/YmjYJ0baOEp40Hnh+NAXxeGEqTEnCCLVF2lHnDV67oKH1j+6lOQFXYR/w5Jqb
 vPjuyOR3vfBZ56P+LAKzdvEljySgt47fcHxcSgv9vFEEX97Nyl/1kAlpKcZoT8WfJqON
 vAps3oUHtHtkWwmGK2WWEKC3bg79bTAyq2qTSpMnSR6id1BH4tjRreSCG5HaD4/Ldaya
 1V5uri5xw3C3XG0zjsk6FmyB1fpeFC6eUmH/9Fq7joGfx+YLfyqd1s/OycPUfTdR1MNY
 6qXw==
X-Gm-Message-State: AOJu0Ywd3oi+IXibrMXh5COnH46KM6CsnJ6QpnzBiyRR8ZSzBLCkgrI4
 8lAK8xxUfmZeWgpQATZtst3wieUsoPs90L7wakGTlQtQwVwI/wmjvHf4A7R8x7ff124=
X-Gm-Gg: ASbGncuDkzTlICtQ4J54+y/57HO7a9RAzXfMZ8IOPInvUTh6dq5vdFa447ZKIezUPvp
 g4FyHTlbSsvwEEzJ3YfJ5BQtCIqmnY9rrFus5oJtk300FApajQ4aQM+PPzDq9+XHpf7Zt05B56m
 VYlkHqv1iJsnWiExcJwja/T5Z4D0aBbzLrmhSa9T6rtKtoxf51qfT28L4VgzW6O5jORQP2fboPT
 lhMcrTJei8xGeareVjITiUhQYiJ4E5NzEMW+43Vt6+R6VnzZkxI+MvzBKuiuDRQ1U6oxNHlCHVh
 8go9WZjCsnx123MBQCFfhKJxFkfBLGz6sWtb3xrxLQ8RdfpoAcDTUEBKn7PCnciQQ6heXfgn
X-Google-Smtp-Source: AGHT+IEheX2Fp9FZywqsb8bH58DN86KZm4henjHJ5caNvhka0FiYhHc2GYbIiAfbdY8rPeplP9W1QA==
X-Received: by 2002:a17:902:c94c:b0:234:9094:3fb1 with SMTP id
 d9443c01a7336-23601dc01b4mr159858505ad.35.1749424102011; 
 Sun, 08 Jun 2025 16:08:22 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23603504f09sm43421325ad.223.2025.06.08.16.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jun 2025 16:08:21 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, novafacing <rowanbhart@gmail.com>
Subject: [PATCH v9 2/9] plugins: Add register write API
Date: Sun,  8 Jun 2025 16:08:12 -0700
Message-ID: <20250608230819.3382527-3-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608230819.3382527-1-rowanbhart@gmail.com>
References: <20250608230819.3382527-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=rowanbhart@gmail.com; helo=mail-pl1-x62a.google.com
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

From: novafacing <rowanbhart@gmail.com>

This patch adds a function to the plugins API to allow plugins to write
register contents. It also moves the qemu_plugin_read_register function
so all the register-related functions are grouped together in the file.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 include/qemu/qemu-plugin.h | 54 ++++++++++++++++++++++++++------------
 plugins/api.c              | 26 +++++++++++++-----
 2 files changed, 56 insertions(+), 24 deletions(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 3a850aa216..cfe1692ecb 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -871,7 +871,8 @@ struct qemu_plugin_register;
 /**
  * typedef qemu_plugin_reg_descriptor - register descriptions
  *
- * @handle: opaque handle for retrieving value with qemu_plugin_read_register
+ * @handle: opaque handle for retrieving value with qemu_plugin_read_register or
+ *          writing value with qemu_plugin_write_register
  * @name: register name
  * @feature: optional feature descriptor, can be NULL
  */
@@ -893,6 +894,41 @@ typedef struct {
 QEMU_PLUGIN_API
 GArray *qemu_plugin_get_registers(void);
 
+/**
+ * qemu_plugin_read_register() - read register for current vCPU
+ *
+ * @handle: a @qemu_plugin_reg_handle handle
+ * @buf: A GByteArray for the data owned by the plugin
+ *
+ * This function is only available in a context that register read access is
+ * explicitly requested via the QEMU_PLUGIN_CB_R_REGS flag.
+ *
+ * Returns the size of the read register. The content of @buf is in target byte
+ * order. On failure returns -1.
+ */
+QEMU_PLUGIN_API
+int qemu_plugin_read_register(struct qemu_plugin_register *handle,
+                              GByteArray *buf);
+
+/**
+ * qemu_plugin_write_register() - write register for current vCPU
+ *
+ * @handle: a @qemu_plugin_reg_handle handle
+ * @buf: A GByteArray for the data owned by the plugin
+ *
+ * This function is only available in a context that register write access is
+ * explicitly requested via the QEMU_PLUGIN_CB_RW_REGS flag.
+ *
+ * The size of @buf must be at least the size of the requested register.
+ * Attempting to write a register with @buf smaller than the register size
+ * will result in a crash or other undesired behavior.
+ *
+ * Returns the number of bytes written. On failure returns 0.
+ */
+QEMU_PLUGIN_API
+int qemu_plugin_write_register(struct qemu_plugin_register *handle,
+                              GByteArray *buf);
+
 /**
  * qemu_plugin_read_memory_vaddr() - read from memory using a virtual address
  *
@@ -915,22 +951,6 @@ QEMU_PLUGIN_API
 bool qemu_plugin_read_memory_vaddr(uint64_t addr,
                                    GByteArray *data, size_t len);
 
-/**
- * qemu_plugin_read_register() - read register for current vCPU
- *
- * @handle: a @qemu_plugin_reg_handle handle
- * @buf: A GByteArray for the data owned by the plugin
- *
- * This function is only available in a context that register read access is
- * explicitly requested via the QEMU_PLUGIN_CB_R_REGS flag.
- *
- * Returns the size of the read register. The content of @buf is in target byte
- * order. On failure returns -1.
- */
-QEMU_PLUGIN_API
-int qemu_plugin_read_register(struct qemu_plugin_register *handle,
-                              GByteArray *buf);
-
 /**
  * qemu_plugin_scoreboard_new() - alloc a new scoreboard
  *
diff --git a/plugins/api.c b/plugins/api.c
index 3c9d4832e9..6514f2c76a 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -433,6 +433,25 @@ GArray *qemu_plugin_get_registers(void)
     return create_register_handles(regs);
 }
 
+int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
+{
+    g_assert(current_cpu);
+
+    return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1);
+}
+
+int qemu_plugin_write_register(struct qemu_plugin_register *reg,
+                               GByteArray *buf)
+{
+    g_assert(current_cpu);
+
+    if (buf->len == 0 || qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS) {
+        return -1;
+    }
+
+    return gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1);
+}
+
 bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
 {
     g_assert(current_cpu);
@@ -453,13 +472,6 @@ bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
     return true;
 }
 
-int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
-{
-    g_assert(current_cpu);
-
-    return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1);
-}
-
 struct qemu_plugin_scoreboard *qemu_plugin_scoreboard_new(size_t element_size)
 {
     return plugin_scoreboard_new(element_size);
-- 
2.49.0



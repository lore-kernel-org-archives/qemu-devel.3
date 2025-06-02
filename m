Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9E4C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 19:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMBHY-0004Jx-0D; Mon, 02 Jun 2025 15:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uMBHW-0004JM-4Z
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 15:57:14 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uMBHT-0004qe-VT
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 15:57:13 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-747fba9f962so236493b3a.0
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 12:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748894229; x=1749499029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aqxP8ZgJ7noi3lMEAacRDOFW/VcuOx7kghvrFQ7pIuU=;
 b=nrL6NgyVKBc4UaiIoeIzcf4cQc2bfngHr9Q+/yROGNLvH5dZ9gIisz7K8CmCmVo7BN
 Onruyf5K2aA8hah1TrUuyi3SeYhQkkfrgqTHzPBji9TpNcuXwVf5hbEVTbjOveWgthgN
 wEA2qdK5Bp4JI6MREYvgFaxa9el6/n0K/AtcTC80LGdxdn8mk8APggEq+ZnZf5BHmzin
 9rwhr80I763rc13j7tSzT588E6FyY+Xfx8izKqlKhrALOw7e8XM+AaqKO3t7y6xg3/yk
 Jo4WuTmScp4kOIfzViXT2TgLWx/dCnaNB/az5mkOpNxfotRFCvrAulFYZ3nmz2Zs2HkY
 Xkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748894229; x=1749499029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aqxP8ZgJ7noi3lMEAacRDOFW/VcuOx7kghvrFQ7pIuU=;
 b=hnW+FeouQoUvZxfQSRCoo7a+2jFpd6gVs1iWB3jRf5BN8z8Gaf8ro7xrVVLwNHX9s5
 usxRyAtFSjYfoKrEHDyjPObLgRUpVVENOdONxXoPOP1iA1Lr2ShZRcbu4ItYbz3eDQYn
 gMHjjUoO4UgwGESPqz7q1EGpol/XUTavUU9Wq7bFwDENNiNxGijq48rOnLAbqD1eCB4m
 0hZl63PtIV4RiYCqr2u/lbKFSutgndnXpuPJFnsY51R0goy6hQlDzUfo/t2pFp0L14C5
 RztKKwjTzFTldcUWbiHexh2UIY33+m3bDh0LJckkgcPwDqP4ydDrqGRqZ+im3RG7Dgge
 APqA==
X-Gm-Message-State: AOJu0YxD2xm23eJjjiZRjYQ8R6QHypKb3LfHiB1YJmxG6opLsse8qjlb
 FfXI4K2YHMqaCLqMqy504fu1/W5/lkj7aCbvL7hCkyVJilgxDRVSyTw3qBaeZ9oxGXg=
X-Gm-Gg: ASbGncu7pIRmlfZFZl8AzsT1RepWrx71nGH/NJLlRdLbeiSiyswuR0oZyjF0JXRu7ag
 P6RDISAJC5YrcUp+D4uTwhY3Gxh5UkO78KcwKgL1Lu08Wk9DwzMlAcH2q3MD7hmkJMf6uilJ3tP
 y2XHGxoy8CZCmZfUvypKIsEPm1VT+sXHCTBCIP140bNoGb6Oi9nVW+1Tf+J+HKai37MO/T+h6U0
 6uGPnFqGfUf9n2PW90eH3IhMFZ/S29Z7v6F37o4Ge+k357qFIrKhYQDFtUP96deJV8/8gcCud+8
 aY9yW4AwQuZEbY/u6jZEtEgGf3JBR3v2KIj9Yvk9MgXNcmrVfMdjw+iEPu979g==
X-Google-Smtp-Source: AGHT+IGG++WHSmHBbgaI3Y/kFLRBzUXbkfVT+SbypMGAmiJiycroG4Ah/we2EgqYLVt0dUm3C3b8Ew==
X-Received: by 2002:a05:6a00:240d:b0:746:2ae9:fc49 with SMTP id
 d2e1a72fcca58-747fbc5b212mr774782b3a.9.1748894229256; 
 Mon, 02 Jun 2025 12:57:09 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afeab820sm8244575b3a.60.2025.06.02.12.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 12:57:08 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, novafacing <rowanbhart@gmail.com>
Subject: [PATCH v7 2/9] plugins: Add register write API
Date: Mon,  2 Jun 2025 12:56:59 -0700
Message-ID: <20250602195706.1043662-3-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602195706.1043662-1-rowanbhart@gmail.com>
References: <20250602195706.1043662-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x42f.google.com
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

Signed-off-by: novafacing <rowanbhart@gmail.com>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 include/qemu/qemu-plugin.h | 54 ++++++++++++++++++++++++++------------
 plugins/api.c              | 22 +++++++++++-----
 2 files changed, 52 insertions(+), 24 deletions(-)

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
index 3c9d4832e9..3a7add50d2 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -433,6 +433,21 @@ GArray *qemu_plugin_get_registers(void)
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
+    return gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1);
+}
+
 bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
 {
     g_assert(current_cpu);
@@ -453,13 +468,6 @@ bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
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



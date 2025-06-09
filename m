Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E1CC61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 19:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOiKX-0007DR-T3; Mon, 09 Jun 2025 15:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOiKW-0007Ch-FI
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:38:48 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOiKU-0004D2-9v
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:38:48 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-73bf5aa95e7so3526781b3a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 12:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749497924; x=1750102724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DkzAOT9KPhbXdwiYkwrjtSXHJRVHCh65cjh/wF+xrzM=;
 b=ZcD08pHw5L8TgrQ3UMNznbh7L84ATtGnART7P4wD8xDzB9koOHYb1WY/KFV02IJeLR
 juJT7crOWWB4eujFo5hNcZns+b/Px4hQofFYr4wn08/iZbhNpthob/yTadcbYCRVCzlL
 gcljIv91t+Ggkbqj++TFy/2KGgdAz2WgL7LtIU+nKrup/UfIQSG2CvFKchqVqIydzuJ8
 ibR5k8YcLr/iPYIGeE58f3TEnbW4K4rEnRGuJKMA95nOFZnwfNmfX14RDDfC7Ch5wCES
 vJfQ6+IQua44BlNSOi4RDl3/gDHFP8SAq/dPEdH191IjfCUCGcdwub7QDxWtvbYljV5I
 v8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749497924; x=1750102724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DkzAOT9KPhbXdwiYkwrjtSXHJRVHCh65cjh/wF+xrzM=;
 b=aE+seHjV3mbTc6hoIncmVkSP3R1HgoLeOqnHx/ehQMNMPKv7mnDViVk50M7QJibqdf
 l+3sX3MVsDBl8+1k3pTkBDW4DqvFJJvoptrQnUjg/icuIEF146O70W5efahT/hILJo2+
 b07XxMPnaEo6mN19q5LOFH+qj23bZLZBJG1R70cZtnfaOHQViud/vSt7n93k3ei02V65
 HvMJwjVJyeD5/33Omiv2AEbp0UL4YEi1EAt/mnow4L31kK/lpYDg3f7vp9QbesrLlczU
 YWbYeUTqXmfq5G9tsqlF/Jalrcez0QnXdWAnj/MHbTXuJossrtr/pFmgq+ctyaY8J3Rb
 0HpA==
X-Gm-Message-State: AOJu0YwqHO0IHsAlbWvYaTIE0shGuihaiI3RaS6qxe2L/EgT6aibJAqz
 v+i/cxBXbwGXJ7tD5LR/NUJXvVqEbE0qLWnPde7sV4M0bQYidFHW8qfRkxZp5CeL
X-Gm-Gg: ASbGncsC4Y+7qvFWkUB30O5/aFzRk5o7t1RdfCYu6Chli/qhrOwXzuxlf2h0sfchQ7A
 VliUR627pgVXEkgfyvwm4JtGoaiUQx0obLRTGdJhBLMGNuYQalFgtSP9raaoYTjndUkq6/1/NdT
 NxJbaBKLRnP15r4SFzgk31DUKP4C/8yVI0tk5N2pnPSXUwX+/qFoIoDkLSID8UHaxkeymEeC+V1
 WeQCSPN4aJqBiuaFetEAPhCPThRhMuCCS+/BulQFiMNseDsI9QrjjFDbgUFUQK2Tmxm6Sto9GVM
 4UeUNJg8dbixpzML4olbnEA4VqD3p5V+0euu16/XmX5eGggeA5tsv8D8y/Z/bQ==
X-Google-Smtp-Source: AGHT+IEMPqZK/MvBEesY2maPebq7AsTTyWZpgXvbF/1Z1XPbLIma9zkcJU/kGGJE9aVXKcWGO2l/qA==
X-Received: by 2002:a05:6a00:22d1:b0:742:3cc1:9485 with SMTP id
 d2e1a72fcca58-74827e9c914mr17710660b3a.12.1749497923885; 
 Mon, 09 Jun 2025 12:38:43 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b083b03sm6095725b3a.83.2025.06.09.12.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 12:38:43 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>,
 novafacing <rowanbhart@gmail.com>
Subject: [PATCH v11 2/8] plugins: Add register write API
Date: Mon,  9 Jun 2025 12:38:35 -0700
Message-ID: <20250609193841.348076-3-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609193841.348076-1-rowanbhart@gmail.com>
References: <20250609193841.348076-1-rowanbhart@gmail.com>
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



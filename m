Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4F0C71135
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 23:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPUns-0007Yo-MA; Wed, 11 Jun 2025 19:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uPUnp-0007Y1-27
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 19:24:17 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uPUnm-0001jQ-ES
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 19:24:16 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-234b9dfb842so4173555ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 16:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749684253; x=1750289053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DkzAOT9KPhbXdwiYkwrjtSXHJRVHCh65cjh/wF+xrzM=;
 b=Bqz0wkD0xJQ6BWN7WYI4Q1q07APtT3/wAFlBn7Oq9HCH3K3Vr/jLbih1tnIxX8Q5A/
 KNiynsZMJY8FFlfoPwiaxldW4RQ8hipD3CX0ELDWUFOYET+eAeIXYCAv4k0AEfAcRWOX
 qYU3dNMWdvoPNeg4URGRCcNf+ilYFKBI6cARfWpB8yYjclmNMSSs2aObL8SVxT9/1eew
 OlixNWFsY2MCJoFhdlfkps4Tp1dm2/vq+5nuPNTLEZAZ48XziSYYkBvEuKcq1TGYIrRD
 Y+Ori0PnFmwSlKQjKAo/FT0nCCNNp7r/C1ftlL9RE0/VC2FZbtf6B5EVZiYDpJyAtOWB
 seYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749684253; x=1750289053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DkzAOT9KPhbXdwiYkwrjtSXHJRVHCh65cjh/wF+xrzM=;
 b=CluzlGBRQGK3BlW/aidM+OoEwuDSgVNuleIJkvPba/BbheiEdxO03wG5ywAgj+bvRn
 RWD41Y0D3FhJNU1c86tWilDo6zUEjo6mXVAb9UjBiVso+/LjXHZTIAiaDWKykrJAYAx9
 cYWWIKzgT33Y2npA6JQ1xaLx9OcDw/Mv6v1fA+B9aWZxTQ0LXK4UGH1k8Gd/ex0tArYQ
 QCAeDAA4mZ6KWCORv6Ahv3pYxLUFz3q0RPoQio2dhRzmfAZoO6yfiEJ5WIdMSlFbL//L
 aAjMWEIEZ1LdPqch/0NCgEqhLEiYAxB2lwN92dEYlhN1OpfecTUse0I2E++KXVWknJG7
 r99g==
X-Gm-Message-State: AOJu0YyrTtLTKYZUomJvfR3J600hHdxhBqzk12jZUroHfJv4Xn43/cwl
 kOHQWmmGUhXPA+M9LU8CO0m2rxTcYqk6sV5lvhRba0MuMEMu5R90uOutR89EShlD
X-Gm-Gg: ASbGncuel0s32MTwbD+i73VBUnVy0DIRCROM7JNEls7Jf8OfLudRk9ct4xjCU90kX7b
 ZdIH4AFcfT2C7jBjLG2+sP6VuCnPeuBiteyJY/TlsWR0/F+b7mMWzC8IlqM4VVWgHJHeTrWrlyP
 h4s5exSIqEO4Qvf6FjYelyBFVN75D8EwN1nzA5/62GQRYwsXisjQ244pb80O2LWcXV39DSmMqeM
 2bA4UeMKTECIXW27OZQdS8u7PVtTNIMElg952tkBlcuckXoA0gddvqflkbQBY745wbW5KqSWSsf
 Xk9Pq3k/gfy8DW2zitqf6MoNGw6Gbhvpyacs0XEgsgKeFkWY0s8QGUnTivxiJA==
X-Google-Smtp-Source: AGHT+IG/ruFk8WPUr0TcBLwWkqN2yd/f0WFG4fT6vd3vF8HOjvWzzPHQB9gphYHh7A/iHHX54WfkpQ==
X-Received: by 2002:a17:902:cccf:b0:234:c2e7:a102 with SMTP id
 d9443c01a7336-2364d8f09e0mr15256735ad.43.1749684252648; 
 Wed, 11 Jun 2025 16:24:12 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2364e6d9c86sm1220295ad.101.2025.06.11.16.24.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 16:24:12 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, novafacing <rowanbhart@gmail.com>
Subject: [PATCH v12 2/7] plugins: Add register write API
Date: Wed, 11 Jun 2025 16:24:04 -0700
Message-ID: <20250611232409.2936521-3-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611232409.2936521-1-rowanbhart@gmail.com>
References: <20250611232409.2936521-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=rowanbhart@gmail.com; helo=mail-pl1-x62c.google.com
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



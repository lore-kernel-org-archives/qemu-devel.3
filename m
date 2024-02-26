Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B85C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 09:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reX55-0004IH-6R; Mon, 26 Feb 2024 04:15:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1reX50-00040J-Bg
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:15:22 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1reX4y-0005Bs-KS
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:15:22 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33d6f26ff33so1989923f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 01:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708938918; x=1709543718; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HgTl20rCSJYbUu3H7bqnk8bx/uKJfuAIG49cFMEfy7s=;
 b=UG4prCl3ubyr7SIGfLItQxpg+qmenGLWDqjU5fDxkKUpunNvFm08isf4FlYo16mZWN
 BKvYZQzoqdugS6aKAkkTML4pRjYv4FqRUuaGula25Z1XLy1/b9UPP561+OjJNRnQxEYm
 I8+LUc4xdge/4m3o14kUD4SKgUvjeOWkLNeamlWiy0tjKvjR9nC4D42/vYiFkVm9KNKI
 Y/I3au7yEoxX9dFUf0yBzwlHWYmQMUgSd0M7u1YVbTby0CTOUG8Pzo3Rr7eB/qUM/+Kj
 9hDDmOxhjHIZp9/tiqkaow4m+LXw7MqVa2WX3xmT0Z5wk6AR45FdOaP1yr7uNF1vuhcw
 p4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708938918; x=1709543718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HgTl20rCSJYbUu3H7bqnk8bx/uKJfuAIG49cFMEfy7s=;
 b=EeI3ENsoGL3DDFog4hFpi/gxZjpsCgzsfsmmxCFma1DBG4w9cTDcTD0s2sOC+UK/1V
 o1SKFVMzeMjC8x3OchsfxrlZbJy7bZcTz7qcznlXIH2JaSxInlPXeqo+/O25zXnUeM04
 J5K7RanNwF5vUSoDLwFi7g6IWhWW2a5b6AspOeyxNcDUFyBilGTAMYG7LScCNYdz/Nir
 QLyrD8B89JRqV3mzVRMT083RihPJBQVVohZ6o54hGjOwInHTMoUdX7FIsojIrBPP6sUq
 yN0agDXVY19qbor1pVWCyS4KF9dvcYhOblHzq3kl5nyXJWVDtsJusURrxe8d+t6hLzeX
 Mk3A==
X-Gm-Message-State: AOJu0YzXSs47Oj5KlcKuf3Dv4pbVgPxOk1JKdSV4U9oBTZdCSbiQyBkZ
 Yleazfium5fYURGs1ysXIixgV0nXAt4InTK6hRypJsmQj6VQ4lr5iYEWQocy8TyrP/nK5J5oKkE
 I95OXxg==
X-Google-Smtp-Source: AGHT+IGgaaYMvNMgVeBX23Mxbf8y0ULfBFRRTLiX9K6xU/QZLtws4ylBWPsE9MdlG1gFK5PFlLre9w==
X-Received: by 2002:a5d:4a88:0:b0:33d:4fca:a47f with SMTP id
 o8-20020a5d4a88000000b0033d4fcaa47fmr5084130wrq.18.1708938918435; 
 Mon, 26 Feb 2024 01:15:18 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 g7-20020adfe407000000b0033d2ae84fafsm7578814wrm.52.2024.02.26.01.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 01:15:18 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v5 06/12] tests/plugin/mem: migrate to new per_vcpu API
Date: Mon, 26 Feb 2024 13:14:38 +0400
Message-ID: <20240226091446.479436-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
References: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/plugin/mem.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
index 44e91065ba7..d4729f5e015 100644
--- a/tests/plugin/mem.c
+++ b/tests/plugin/mem.c
@@ -16,9 +16,14 @@
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
-static uint64_t inline_mem_count;
-static uint64_t cb_mem_count;
-static uint64_t io_count;
+typedef struct {
+    uint64_t mem_count;
+    uint64_t io_count;
+} CPUCount;
+
+static struct qemu_plugin_scoreboard *counts;
+static qemu_plugin_u64 mem_count;
+static qemu_plugin_u64 io_count;
 static bool do_inline, do_callback;
 static bool do_haddr;
 static enum qemu_plugin_mem_rw rw = QEMU_PLUGIN_MEM_RW;
@@ -27,16 +32,16 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
     g_autoptr(GString) out = g_string_new("");
 
-    if (do_inline) {
-        g_string_printf(out, "inline mem accesses: %" PRIu64 "\n", inline_mem_count);
-    }
-    if (do_callback) {
-        g_string_append_printf(out, "callback mem accesses: %" PRIu64 "\n", cb_mem_count);
+    if (do_inline || do_callback) {
+        g_string_printf(out, "mem accesses: %" PRIu64 "\n",
+                        qemu_plugin_u64_sum(mem_count));
     }
     if (do_haddr) {
-        g_string_append_printf(out, "io accesses: %" PRIu64 "\n", io_count);
+        g_string_append_printf(out, "io accesses: %" PRIu64 "\n",
+                               qemu_plugin_u64_sum(io_count));
     }
     qemu_plugin_outs(out->str);
+    qemu_plugin_scoreboard_free(counts);
 }
 
 static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
@@ -46,12 +51,12 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
         struct qemu_plugin_hwaddr *hwaddr;
         hwaddr = qemu_plugin_get_hwaddr(meminfo, vaddr);
         if (qemu_plugin_hwaddr_is_io(hwaddr)) {
-            io_count++;
+            qemu_plugin_u64_add(io_count, cpu_index, 1);
         } else {
-            cb_mem_count++;
+            qemu_plugin_u64_add(mem_count, cpu_index, 1);
         }
     } else {
-        cb_mem_count++;
+        qemu_plugin_u64_add(mem_count, cpu_index, 1);
     }
 }
 
@@ -64,9 +69,10 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
 
         if (do_inline) {
-            qemu_plugin_register_vcpu_mem_inline(insn, rw,
-                                                 QEMU_PLUGIN_INLINE_ADD_U64,
-                                                 &inline_mem_count, 1);
+            qemu_plugin_register_vcpu_mem_inline_per_vcpu(
+                insn, rw,
+                QEMU_PLUGIN_INLINE_ADD_U64,
+                mem_count, 1);
         }
         if (do_callback) {
             qemu_plugin_register_vcpu_mem_cb(insn, vcpu_mem,
@@ -117,6 +123,10 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         }
     }
 
+    counts = qemu_plugin_scoreboard_new(sizeof(CPUCount));
+    mem_count = qemu_plugin_scoreboard_u64_in_struct(
+        counts, CPUCount, mem_count);
+    io_count = qemu_plugin_scoreboard_u64_in_struct(counts, CPUCount, io_count);
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
-- 
2.43.0



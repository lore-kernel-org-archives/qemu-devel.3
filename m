Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9221BC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 13:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh7wk-0001UM-54; Mon, 04 Mar 2024 08:01:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rh7wf-0001QE-Rw
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:01:29 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rh7we-0000kL-3w
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:01:29 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5672afabb86so1060524a12.3
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 05:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709557286; x=1710162086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xiOObjDOjJNjZGxJCgrtuhokUTENERk5siLta4aMo8Q=;
 b=yXhVfvZe/7OT/PQCt5J+xK4PP5reXprOXCBydqa1oMANgiSZJDTQEMWG6AAhvWjruk
 SknE91LsiX8dRlLRbzjTjoFhkgWuH/s8qhZauFw06rKmGJHODlAzDgD/UEh3f2YKADBE
 Ze5AV58NaG+BFVWjdThD6uyxbzIeiaMV9udPt80AnCziP8l3P705hZqdFOWPeKmGXKmu
 Dk5eywUmWO7zgX6mG6pTdEdZNceXGuPJ+PVKxVp7+N9p2w4o4K/nrXAW2L9m6zZHXq8d
 J8Y2JnAPHhyM3Wf2hXEXtNMlb0ZxY1Rz9czmcpJ+RcRBr6P9SYvp9YFi5UPIyBEZfWB5
 8Nxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709557286; x=1710162086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xiOObjDOjJNjZGxJCgrtuhokUTENERk5siLta4aMo8Q=;
 b=KkB9bl756aYVzwbAGWcXjDWlYAXnevqcEr6iHSOTpScVI2kBBTW27rqDqdg1Fw7q+Z
 INn7NsQhb0naxYJ159dGgaAtsHxF0Aocw5uWv3iywYllEI8HiNcbeq/VkBy8UtMm93EU
 r5FrthQ41oMt3+40FwQykCy0vjURiUc52kYchzXmNX6x5vxKV24Ey99yn/prjLk17ktO
 43Jp39uDS6pOU6JceRvvfQWTv08RFykh5c0x+X4DHp/849hxBY4urhjZVfLNmsLidVRL
 bfFvfpcfWKRI5Img+Xni6xKA0hezLe5gayFK6UMfLjcuDmuTsnEA45baZmj6dTMYKa/j
 jG2g==
X-Gm-Message-State: AOJu0YxKe1YZwLH4Wq4UPiMGzP9r3JHIPhlT6J+Ud7/h9BW/jLSdOiWL
 oplwREGEZuYqd9e8BGMf/mpwOtQRX9k/52qtxlokFmr+QdSgPldGmb7rq5o0bcSERkDHyhgKg6v
 Y9DE=
X-Google-Smtp-Source: AGHT+IGht6lxgG12ndrb+ocwHnt0avVj8Xl6zU2aqnvCpc+Gug9cIZrrmuanBFt8wJog3usJDVXexQ==
X-Received: by 2002:a17:906:e96:b0:a3f:3470:6055 with SMTP id
 p22-20020a1709060e9600b00a3f34706055mr5138553ejf.37.1709557286470; 
 Mon, 04 Mar 2024 05:01:26 -0800 (PST)
Received: from debian.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 tj7-20020a170907c24700b00a413d1eda4bsm4806136ejc.87.2024.03.04.05.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 05:01:26 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@amd.com>
Subject: [PATCH v7 06/12] tests/plugin/mem: migrate to new per_vcpu API
Date: Mon,  4 Mar 2024 17:00:30 +0400
Message-Id: <20240304130036.124418-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240304130036.124418-1-pierrick.bouvier@linaro.org>
References: <20240304130036.124418-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-ed1-x52d.google.com
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

Reviewed-by: Luc Michel <luc.michel@amd.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/plugin/mem.c        | 46 ++++++++++++++++++++++++++-------------
 tests/tcg/Makefile.target |  2 +-
 2 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
index 44e91065ba7..b650dddcce1 100644
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
@@ -117,6 +123,16 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         }
     }
 
+    if (do_inline && do_callback) {
+        fprintf(stderr,
+                "can't enable inline and callback counting at the same time\n");
+        return -1;
+    }
+
+    counts = qemu_plugin_scoreboard_new(sizeof(CPUCount));
+    mem_count = qemu_plugin_scoreboard_u64_in_struct(
+        counts, CPUCount, mem_count);
+    io_count = qemu_plugin_scoreboard_u64_in_struct(counts, CPUCount, io_count);
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index a4c25908fb7..f21be50d3b2 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -168,7 +168,7 @@ RUN_TESTS+=$(EXTRA_RUNS)
 
 # Some plugins need additional arguments above the default to fully
 # exercise things. We can define them on a per-test basis here.
-run-plugin-%-with-libmem.so: PLUGIN_ARGS=$(COMMA)inline=true$(COMMA)callback=true
+run-plugin-%-with-libmem.so: PLUGIN_ARGS=$(COMMA)inline=true
 
 ifeq ($(filter %-softmmu, $(TARGET)),)
 run-%: %
-- 
2.39.2



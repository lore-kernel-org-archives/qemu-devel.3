Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5C3C4829F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 09:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZpHz-0001PX-7n; Tue, 13 Feb 2024 04:41:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpHx-0001Ov-1u
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:41:17 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpHr-0000Ga-8p
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:41:16 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33b29b5ea96so1953189f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 01:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707817269; x=1708422069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HgTl20rCSJYbUu3H7bqnk8bx/uKJfuAIG49cFMEfy7s=;
 b=aC41rDzvfaKdtNPFeel2IuZ6nQiAkzoGL+BmSEw7P3aJSQAlnUV1/hH7uKZJtiU7sZ
 sAdWxvdsjCoZQpQjCPNjv//7Ueyf8XFKQ3RsL8K6Rku08K+p0BvGUthxnLT3GdrSqOyP
 GHrPaVfHhnRmEdt2XSvi7yCPJ7uSy1Xt/9mUMNLYZnl9CC7VLw+AWiPjgStz3AKpKjjS
 sI4xTnoI0zZgyb8qQRizBkHjW6O5lk+MX6874w06PYiEacx6mbMwpToGM9a5loiWs+4F
 ch21IMyVVAs3SR9xhRf+TyFdBtu313RJrxad4lHTe2fWXXqM/oeg1Q0GMgcIxEN7TUdC
 7TUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707817269; x=1708422069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HgTl20rCSJYbUu3H7bqnk8bx/uKJfuAIG49cFMEfy7s=;
 b=nG2DBTRuY1Q6XcV249Y3PgTsk9hr31dqZyKXc245ln97JRXYDESLofXUJVEu8+3+43
 +lvZMVuhaqVu6yZlgxhzgZtCXqppt57TjbbVSUa5/pfmsw02UvVE3GVZVY4oUeHqnKiV
 uADWi1CQGEnHV39t1rYopGJ7Zwq8ukHk4uaoITAWwkRVuTOx5SyJKuu64gP07cbA5ceF
 HMoIyuqG12Yj+nNrd1UirL/GwsEfJbTuLI9S7NDM4opkaVyQIPjqNStl+100PcGqNop/
 sB0yj4GkM5BhmWj/iQL9VTag//Quo+jeJqnwjRx2C6+buasLpb0NFm9QFRGWdOf2B6ms
 N33Q==
X-Gm-Message-State: AOJu0YwPc2Lje73OAlrOe+8VvjYPyDzpPdvCTJGUlSVes100xpjY2i9d
 Pld6qYX2CFchz48zYZUm36PrbsoRgmjuZoOIhYOHHvE7sDnCFMnfBmdee5nXLZE480Bu2eXbAXx
 4
X-Google-Smtp-Source: AGHT+IF+JDwGR1FLOPL0PilfcAyYC2bBLBz4urm7RjqkUBdMDYfUaXs2fOra88Momt/iAbXTDwbI9Q==
X-Received: by 2002:a05:6000:a05:b0:33c:df0f:1b4e with SMTP id
 co5-20020a0560000a0500b0033cdf0f1b4emr680345wrb.20.1707817269770; 
 Tue, 13 Feb 2024 01:41:09 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUjuRW6ars5OSynMcaYQtReqIdolCtjcKmklgqFA+nIOXlX74cPMI8hHHRtmwygaxXVrLFRINMleQfSujXduAFiZcBTbqRkiSS9ER/Tuoxyy74y3YxSX/6NLHcc+K8PAv9PUnVQydOwGZaSEh8xhtbFSlaGBD1Jass5SpD+D5lxypzNSTxc11RmYa0G21OPbmhz0aontcB2OvMH+wI3bTRnl7hfBLd3YR1WvSH4yqS/ncATQHHu6eEDn9TvIQwszWT/4nA5OUMtOHWMHvzKMkyyuHQoLLT3AIR4a9zE4YtvbT/+2qIZdS0D/mTZYjWDeOOL6C1Du8+H18VH96G41KmO0WqfjQ==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 cc19-20020a5d5c13000000b0033b728190c1sm8550261wrb.79.2024.02.13.01.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 01:41:09 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 11/18] tests/plugin/mem: migrate to new per_vcpu API
Date: Tue, 13 Feb 2024 13:40:01 +0400
Message-ID: <20240213094009.150349-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
References: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x429.google.com
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



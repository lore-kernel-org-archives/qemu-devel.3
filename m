Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F07C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 09:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXHhg-0004xR-08; Tue, 06 Feb 2024 04:25:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXHha-0004rN-0I
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:25:14 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXHhY-0004xw-64
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:25:13 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40fe6c66c3fso2001095e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 01:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707211509; x=1707816309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HgTl20rCSJYbUu3H7bqnk8bx/uKJfuAIG49cFMEfy7s=;
 b=QNf3aFXACLNwrO8xs8mW3pgvkcVnXsxaJM4k+bnbzUQRWaHjYsiKJEpiu2el1J/L2i
 ZQmo7wnshoX7qQX1uy5Y/6avfQG1RynID6c8vEPXjcwtj11wZt0mMmRxIWp6uCkXZbRT
 2LU2Y0OdIR+kguqiHGLwpwGBv/oCFiUs0/89LVa0DVjqaMzanKAO2o6+DbMiKpthYH+J
 GWp5WkPBSEZf0k9E0E1BeZKoO0JrDLq9QKvej+AWUftrYL3BvMz7hIQnfWDJ51kozPad
 HAB/bWY3G2XPyjbHrRj/jvu3ADnMmbEeHYDftwYtcVX5VO8NzPSNk4MdxrWXPbmGtAJq
 MXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707211509; x=1707816309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HgTl20rCSJYbUu3H7bqnk8bx/uKJfuAIG49cFMEfy7s=;
 b=LHtZJ+msmx3LycJiRDTRLx2erQ7pmXZ1ahUSbUMCaMhNEDFSCi7Z/tHih5d8Xkf/Fh
 84rxfnEd1rrw4Wf6wPMcHAJjTBSsNXHOwBvl3GfHISOfn3brPH/XmQDuVqoGGLRF1Tk5
 9UI5TzTPAFGc0gCWBQrnKptBJ7/2/fVnNnGYdRr2arDTVi/WPjXAmVxLXfZy4CBiJ2Nn
 Kb/yzfYnG8W7xPjPGjxW8slUgIVGKNbgxMfRM+VupA+ncFIbRPQZpoCmgwh+kUU8Hj8X
 JaswNxGfUA591LwVtAgZ3vQWfoI3WNHIJvGzxS9HJ8lOpJCEiQEakXAbHo0r4xCwbe17
 TI5g==
X-Gm-Message-State: AOJu0YxUQKyNVJBs4+ai6RdhCQ6wDjutDKq8cmvCPmuZjlqjfmRgSlH5
 vOoEXY0uv8hFQXSkK9GYTJx6BQaJxwRTHO432d16+cSJukfCEH+dEM9daJnnIsmCPV320UUeAqD
 NcSM=
X-Google-Smtp-Source: AGHT+IH2k1AJL9jMn/j4al6rq5fhyUpKh8w3Q5k6ATBWAwxqjhP7710gp20IUJLqo6JuhoTvqVT6lA==
X-Received: by 2002:a05:600c:1551:b0:40e:f626:483d with SMTP id
 f17-20020a05600c155100b0040ef626483dmr1111760wmg.13.1707211509281; 
 Tue, 06 Feb 2024 01:25:09 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXvxRllywUspVpYBmmU355BN8xDwFZHEB3DADkV4LFearbp5gSsJLNr21mt2pbLgp0STeO/2GkxehadlxIsUxSV1zsqbmnnrsaqnD8eFcPemSlbOnmUn/hVQbWdZ3n/0Vn35DKf2iUAdDnqLMIAm+D8o7eRAR4F5LtfWZRVAvwiioZzdBK7xOUm9Uo9qvDK2gb/e2HwtokIt+8QS1j4CIGAHcKxFVK8aKyEEMYzSVTj98tub+/KvwatcoVXOGdBZh/k+O+WgYFQP2rLI6cUVPYfi9jhrO4C2oLDPDmoq6yHVfUSo+TtNJpRUkgOogrGTUwfuyWI0lIytDbS6yXX0E9XRgIuBAfu0w==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c211100b0040fc5460109sm1312756wml.35.2024.02.06.01.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 01:25:09 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 10/17] tests/plugin/mem: migrate to new per_vcpu API
Date: Tue,  6 Feb 2024 13:24:15 +0400
Message-ID: <20240206092423.3005995-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
References: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32c.google.com
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399A9C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 18:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOiVL-0005Ox-5e; Tue, 02 Jul 2024 14:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOiVC-0005Nq-DV
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:45:18 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOiV7-0008Jd-Fg
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:45:16 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2c901185d73so4014969a91.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 11:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719945911; x=1720550711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQGGwWjGBzDeoWSZMlw/pE8YwbdHKTdXx63bixAfqp0=;
 b=tVU8TEF4LhdVyboTUP9MA4eh+l6adyXYeI8LTlqr16k9L7PtoiNfuRYf/mc8Z9yATU
 gGmwJJPHvC2jP+MlKkO2F9y8u7LZeQRWyzIGptdfb4qKXeNO45x48BV4+ap8LQVcz6a6
 gP2hLa0+iYkjYwHvUTjowDlsBIQrSGAptJnBG66ZvtlFGyB28euGuXy71qNTQUMqbXXo
 hhyuwiz0RgiqS8yBdWbEfa3pAdPjyD9EUFID5M2doomUAmVqRBbI/3wtJ/cXoNQjGdwk
 1+k3wYTgypLbhSKf+/dzFVnoEHhe4nljOppUngjVSHLbaHOvfBdx8eQCNaf2yK8uPRry
 JN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719945911; x=1720550711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KQGGwWjGBzDeoWSZMlw/pE8YwbdHKTdXx63bixAfqp0=;
 b=dXNe3Vo2Ste9zfEjHtLlTSvzU1/wYbSieY6lssCKvGTAOrdeF9JMNdmibsrg8lt5hu
 hsTSDaRb2GAojDLdtGfbd4yV3xC1e7/P+Td+dMkko2ENkKmxxzauGUGPo+nzEIvKnZO8
 SOShnGOUTll/P3tTJQFaJAboNujrctX8Saw0mfmekmL4L4ciJDFdBu+ykBk2Q7xFtWDU
 SwIhgY44M6r5KB2ge+I9RKTDHwTWldL4uRPnt7NqdKlLXqEaCS86za5Rfuhg2vrB8rtb
 qo2aL2TYRz5X/XUU0mr30ZBpTqoYWaZT4a7TJPMtiKUCLymWFMS1JwqNgAJQy2Q0NrYc
 DA/Q==
X-Gm-Message-State: AOJu0Yx2azxqqvchuLA1E/8xjz0LngliuqgmPrrQKA4s0PC0v9BpZiBM
 1N3pUZ1VfLRulyL1G53IUUXOy51bf5sbkCaGKkHONNo4DTJMXyWTB6aENZuB3Sv9JecU8YqZ5bJ
 x
X-Google-Smtp-Source: AGHT+IEME9vuP/4gZYTqao1QzFhm+EkO2OX28IZC9H1WYOet6Fj75Lbu620de/EHaXaVJFxO4XtKfw==
X-Received: by 2002:a17:90a:9515:b0:2c9:62c2:69a1 with SMTP id
 98e67ed59e1d1-2c962c26d37mr2721842a91.24.1719945911220; 
 Tue, 02 Jul 2024 11:45:11 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3e8196sm9257394a91.49.2024.07.02.11.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 11:45:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v4 6/7] tests/plugin/mem: add option to print memory accesses
Date: Tue,  2 Jul 2024 11:44:47 -0700
Message-Id: <20240702184448.551705-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240702184448.551705-1-pierrick.bouvier@linaro.org>
References: <20240702184448.551705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

By using "print-accesses=true" option, mem plugin will now print every
value accessed, with associated size, type (store vs load), symbol,
instruction address and phys/virt address accessed.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/plugin/mem.c | 69 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
index b650dddcce1..aecbad8e68d 100644
--- a/tests/plugin/mem.c
+++ b/tests/plugin/mem.c
@@ -21,10 +21,15 @@ typedef struct {
     uint64_t io_count;
 } CPUCount;
 
+typedef struct {
+    uint64_t vaddr;
+    const char *sym;
+} InsnInfo;
+
 static struct qemu_plugin_scoreboard *counts;
 static qemu_plugin_u64 mem_count;
 static qemu_plugin_u64 io_count;
-static bool do_inline, do_callback;
+static bool do_inline, do_callback, do_print_accesses;
 static bool do_haddr;
 static enum qemu_plugin_mem_rw rw = QEMU_PLUGIN_MEM_RW;
 
@@ -60,6 +65,44 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
     }
 }
 
+static void print_access(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
+                         uint64_t vaddr, void *udata)
+{
+    InsnInfo *insn_info = udata;
+    unsigned size = 8 << qemu_plugin_mem_size_shift(meminfo);
+    const char *type = qemu_plugin_mem_is_store(meminfo) ? "store" : "load";
+    qemu_plugin_mem_value value = qemu_plugin_mem_get_value(meminfo);
+    uint64_t hwaddr =
+        qemu_plugin_hwaddr_phys_addr(qemu_plugin_get_hwaddr(meminfo, vaddr));
+    g_autoptr(GString) out = g_string_new("");
+    g_string_printf(out,
+                    "0x%"PRIx64",%s,0x%"PRIx64",0x%"PRIx64",%d,%s,",
+                    insn_info->vaddr, insn_info->sym,
+                    vaddr, hwaddr, size, type);
+    switch (value.type) {
+    case QEMU_PLUGIN_MEM_VALUE_U8:
+        g_string_append_printf(out, "0x%"PRIx8, value.data.u8);
+        break;
+    case QEMU_PLUGIN_MEM_VALUE_U16:
+        g_string_append_printf(out, "0x%"PRIx16, value.data.u16);
+        break;
+    case QEMU_PLUGIN_MEM_VALUE_U32:
+        g_string_append_printf(out, "0x%"PRIx32, value.data.u32);
+        break;
+    case QEMU_PLUGIN_MEM_VALUE_U64:
+        g_string_append_printf(out, "0x%"PRIx64, value.data.u64);
+        break;
+    case QEMU_PLUGIN_MEM_VALUE_U128:
+        g_string_append_printf(out, "0x%.0"PRIx64"%"PRIx64,
+                               value.data.u128.high, value.data.u128.low);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    g_string_append_printf(out, "\n");
+    qemu_plugin_outs(out->str);
+}
+
 static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 {
     size_t n = qemu_plugin_tb_n_insns(tb);
@@ -79,6 +122,16 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
                                              QEMU_PLUGIN_CB_NO_REGS,
                                              rw, NULL);
         }
+        if (do_print_accesses) {
+            /* we leak this pointer, to avoid locking to keep track of it */
+            InsnInfo *insn_info = g_malloc(sizeof(InsnInfo));
+            const char *sym = qemu_plugin_insn_symbol(insn);
+            insn_info->sym = sym ? sym : "";
+            insn_info->vaddr = qemu_plugin_insn_vaddr(insn);
+            qemu_plugin_register_vcpu_mem_cb(insn, print_access,
+                                             QEMU_PLUGIN_CB_NO_REGS,
+                                             rw, (void *) insn_info);
+        }
     }
 }
 
@@ -117,6 +170,12 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                 fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
                 return -1;
             }
+        } else if (g_strcmp0(tokens[0], "print-accesses") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1],
+                                        &do_print_accesses)) {
+                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
+                return -1;
+            }
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
             return -1;
@@ -129,6 +188,14 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         return -1;
     }
 
+    if (do_print_accesses) {
+        g_autoptr(GString) out = g_string_new("");
+        g_string_printf(out,
+                "insn_vaddr,insn_symbol,mem_vaddr,mem_hwaddr,"
+                "access_size,access_type,mem_value\n");
+        qemu_plugin_outs(out->str);
+    }
+
     counts = qemu_plugin_scoreboard_new(sizeof(CPUCount));
     mem_count = qemu_plugin_scoreboard_u64_in_struct(
         counts, CPUCount, mem_count);
-- 
2.39.2



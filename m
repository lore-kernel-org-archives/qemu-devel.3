Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC0BC2BD09
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 19:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQAr6-0002Dt-6z; Sat, 06 Jul 2024 15:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sQAr4-0002De-N7
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 15:13:54 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sQAr2-00045V-VK
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 15:13:54 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70b09c2ade6so1272512b3a.3
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2024 12:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720293230; x=1720898030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q3v41GFzb0/piPBsIvskwb3RVBKxsZFvBfDW4N/dtnI=;
 b=Gyb52TU+XeUqFj8bI07cQmSlLXhMeL2l1kRnwAIE/KdPVuJB3T78bwVoXnypNVLZ4W
 jTzwHzUlfUM8DMBNYoroFp3S1PKpV0Je0ce5ZetwuHJN8HTc/vAB+FPjTU7hj/QjWjHM
 YA88XSCdT0fbSq0jQY/w+FyztOWEhRwyTb0mLxUZ/I6QCXS2lzW1W3Enyl5/WIGi0AxK
 86XeKey6I7xwQ90zaimsWAwcuvUfI9XhFjc27BizgCzqpMzszGGmDPRrY+RISWTsuLDb
 BeaL1ISMWhVnWJa+VMMfN8SvexR6Czwk2QVKBTtYSj68MSa/pgELTao3TmPE9BYIfLcz
 8pHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720293230; x=1720898030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q3v41GFzb0/piPBsIvskwb3RVBKxsZFvBfDW4N/dtnI=;
 b=uOY2HZT4UmBBarQBH2uYg4Yn4IiTuhplXjK+JunZV1orKMK6ZNVYss32uaUg6Hgwow
 UyvrphaWqqF02GZGuIG1qGYD43EgVJo/7CisQyZOCyzP7zb9505tpozFY6I7es+r1JPX
 ORtdoPrh2BJl/rOQ+GGcK6mhHr38worITiKiwHnyQpZ3XwqQmQQXobVyAlXBcW4fOQJA
 2iKzEqUyJqv2KKhnBY+9y9kHNzrH+j22i3OnEc2znF/IQmqxJ/zSHg03qXwdGqIxW/le
 W/1bsmMGrvviDkrkGkQ2HMWLIJJfAJ+Vmfriz/uEg4YwGn2gDKQ0lhS31KBYZR0Uhh1S
 Ww7A==
X-Gm-Message-State: AOJu0Yy/uZ0lx/4xvM49ikLnCQ/XQEsR4YcLA8ycipmb4DF8W4OgDA6M
 kbTN/Dd0ZVsIhbu9pYUNaaSV8CZbQA7FyBwvbmc+m4N4YU/F0aCdz+Jjh9GFv7mh9AeBi8aX31g
 YmYA=
X-Google-Smtp-Source: AGHT+IH3cUfK1ZFgoDPsjU+AiaIoqxW2X+lQ1IASALADGHtINzjjSjq9YBRZEtj6BEx9gV8auTxg4Q==
X-Received: by 2002:a05:6a20:9186:b0:1c0:ef24:4125 with SMTP id
 adf61e73a8af0-1c0ef24b42amr341721637.26.1720293230225; 
 Sat, 06 Jul 2024 12:13:50 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb6153cb3bsm17304305ad.129.2024.07.06.12.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jul 2024 12:13:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v6 6/7] tests/plugin/mem: add option to print memory accesses
Date: Sat,  6 Jul 2024 12:13:34 -0700
Message-Id: <20240706191335.878142-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240706191335.878142-1-pierrick.bouvier@linaro.org>
References: <20240706191335.878142-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/plugin/mem.c | 69 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
index b650dddcce1..086e6f5bdfc 100644
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
+        g_string_append_printf(out, "0x%02"PRIx8, value.data.u8);
+        break;
+    case QEMU_PLUGIN_MEM_VALUE_U16:
+        g_string_append_printf(out, "0x%04"PRIx16, value.data.u16);
+        break;
+    case QEMU_PLUGIN_MEM_VALUE_U32:
+        g_string_append_printf(out, "0x%08"PRIx32, value.data.u32);
+        break;
+    case QEMU_PLUGIN_MEM_VALUE_U64:
+        g_string_append_printf(out, "0x%016"PRIx64, value.data.u64);
+        break;
+    case QEMU_PLUGIN_MEM_VALUE_U128:
+        g_string_append_printf(out, "0x%016"PRIx64"%016"PRIx64,
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



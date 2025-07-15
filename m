Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADA0C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 20:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubloj-0001zl-Ha; Tue, 15 Jul 2025 15:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublbV-0003Be-3n
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:46:25 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublbR-0002jk-1z
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:46:15 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-454ac069223so1182605e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 12:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752608770; x=1753213570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Re3potAxZUBbGkfQYWK+Po/V36iY8dmjZb5MVeIPr/Q=;
 b=WXzX5Ak4mCPK6O5eWTIbRYM5XjOES6vqs/iO9iYPYZe2y5OwW5FYvf65gQJanEDon6
 duNLAQwOJMTQlMohlJMEjgOIK6nD30+cEtygf5Sjt6S1Rayju8YBLADKL0KKAQ8ZkRYB
 KvctFGKFf7iczTLD2fdXmex/879di+5dyuyyaEvYseTV6dN2Nw/mH0vLc7dphajgzy8V
 c/oiXKqJCixnUsUFyjf+B316zR3m6C7IOJ6KqHJebmbcDc8GqBJDwjOp3NmFA6/y4DJe
 VoSqcQvnHqOraCpN3eLFEKeiASciDULgp7z0vyrHZ2U8xq0ZKkw2IrLLFKoS8zT7wiOX
 yC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752608770; x=1753213570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Re3potAxZUBbGkfQYWK+Po/V36iY8dmjZb5MVeIPr/Q=;
 b=fMvEl8b8PD9RPaTZNAPCmiIiLx7Bg2E5H89BbYfjBwMOVx0L1Hs4rH9Ku+NH6NO4zd
 R3KHVcjtW8/BdH2CXRToqAq7RMXWQUCfdz/tQVHAUtcv6LNwtIcyJXF/r+Vd61Xb9ceR
 Xv8n9JGnQfwGCHmkz+uyniPpTScFQsRXYr2ETrBgamOr4d+el1jNmy1zffpzkLf62PtA
 6BrEpsAIGBYQAV4OU8MPTR6mq4VX1wp5q5u/NmsOrpE2FL9kqAGwcBlU3OFQyMsRt+iH
 6fiTe+yTWjNj6A7KBWRTWS41ZqJAUFNDVWEwNKyuRlh0ji98+fwydxMMTr9VTFwYq901
 ub/w==
X-Gm-Message-State: AOJu0YyO/5iqzvH+D5BkyydYYpGMAhZctk8N0JD5nHmapTmOzcMuA80i
 POyVRw27KorqZz0lH/zlg9duazjpQbgYLE/0iENU6atau8CGYy55RP8JZ30PtVeahbzoCJry/qW
 piA7V
X-Gm-Gg: ASbGncsaQl5en9B/PJOpTFZi9LotxWrbiZ0/wRrU5nw1zTdOJxp6ZAZ7SL8d3Lv4KT/
 OX6ADms64zt308VVjCViAht1WifMSB/MUj8R3Ar1TtbyDbw0SpRCBzXjdx1CdzZOHkA6po1L3lF
 zvLqF3L8pY14if4PS8X36XsHggKOadVBbeBJUGipk6B0E3tz3P2cOSijYjb+dMQbRddML0Zz0Ps
 92N6lNzfuxo5Y3onuCLhDsCNNUZgLrizk3yRc0VaXbAr1uS37JylkeXUKCbccXrnXLf0NOdtUzr
 CnHaCt8SfYT1YjusepgIdCqAKE+r8tvE9FP8YfyQtxyqLUEVPcadBUd3ob4HMp40vQ6q0YjYpqC
 VIlVw0AZQCn4L/e8eQ9PMSnvxseGcqFQo8cmDYF6pq+mvafIgDp9XUz5hCEjSIjABSZvxzt44gc
 Og1w==
X-Google-Smtp-Source: AGHT+IHYQMFg8KPDg8ggcZyqDdFVo+16NEEbRIVOo/Uhfygh7OO4w0bju47/ShuW6sCd7D388AXIBA==
X-Received: by 2002:a05:6000:2481:b0:3b5:f8ea:28ff with SMTP id
 ffacd0b85a97d-3b609520124mr3359245f8f.6.1752608769732; 
 Tue, 15 Jul 2025 12:46:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d587sm15617278f8f.46.2025.07.15.12.46.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 12:46:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/17] accel/tcg: Extract statistic related code to tcg-stats.c
Date: Tue, 15 Jul 2025 21:45:09 +0200
Message-ID: <20250715194516.91722-11-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715194516.91722-1-philmd@linaro.org>
References: <20250715194516.91722-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Statistic code is not specific to system emulation (except
cross-page checks) and can be used to analyze user-mode binaries.
Extract statistic related code to its own file: tcg-stats.c,
keeping the original LGPL-2.1-or-later license tag.
Note, this code is not yet reachable by user-mode.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250715140048.84942-3-philmd@linaro.org>
---
 accel/tcg/monitor.c   | 201 ---------------------------------------
 accel/tcg/tcg-stats.c | 215 ++++++++++++++++++++++++++++++++++++++++++
 accel/tcg/meson.build |   1 +
 3 files changed, 216 insertions(+), 201 deletions(-)
 create mode 100644 accel/tcg/tcg-stats.c

diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index 778b12613f4..adb9de5a1c6 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -7,213 +7,12 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/accel.h"
-#include "qemu/qht.h"
 #include "qapi/error.h"
 #include "qapi/type-helpers.h"
 #include "qapi/qapi-commands-machine.h"
 #include "monitor/monitor.h"
-#include "system/cpu-timers.h"
-#include "exec/icount.h"
 #include "system/tcg.h"
-#include "tcg/tcg.h"
 #include "internal-common.h"
-#include "tb-context.h"
-#include <math.h>
-
-static void dump_drift_info(GString *buf)
-{
-    if (!icount_enabled()) {
-        return;
-    }
-
-    g_string_append_printf(buf, "Host - Guest clock  %"PRIi64" ms\n",
-                           (cpu_get_clock() - icount_get()) / SCALE_MS);
-    if (icount_align_option) {
-        g_string_append_printf(buf, "Max guest delay     %"PRIi64" ms\n",
-                               -max_delay / SCALE_MS);
-        g_string_append_printf(buf, "Max guest advance   %"PRIi64" ms\n",
-                               max_advance / SCALE_MS);
-    } else {
-        g_string_append_printf(buf, "Max guest delay     NA\n");
-        g_string_append_printf(buf, "Max guest advance   NA\n");
-    }
-}
-
-static void dump_accel_info(GString *buf)
-{
-    AccelState *accel = current_accel();
-    bool one_insn_per_tb = object_property_get_bool(OBJECT(accel),
-                                                    "one-insn-per-tb",
-                                                    &error_fatal);
-
-    g_string_append_printf(buf, "Accelerator settings:\n");
-    g_string_append_printf(buf, "one-insn-per-tb: %s\n\n",
-                           one_insn_per_tb ? "on" : "off");
-}
-
-static void print_qht_statistics(struct qht_stats hst, GString *buf)
-{
-    uint32_t hgram_opts;
-    size_t hgram_bins;
-    char *hgram;
-    double avg;
-
-    if (!hst.head_buckets) {
-        return;
-    }
-    g_string_append_printf(buf, "TB hash buckets     %zu/%zu "
-                           "(%0.2f%% head buckets used)\n",
-                           hst.used_head_buckets, hst.head_buckets,
-                           (double)hst.used_head_buckets /
-                           hst.head_buckets * 100);
-
-    hgram_opts =  QDIST_PR_BORDER | QDIST_PR_LABELS;
-    hgram_opts |= QDIST_PR_100X   | QDIST_PR_PERCENT;
-    if (qdist_xmax(&hst.occupancy) - qdist_xmin(&hst.occupancy) == 1) {
-        hgram_opts |= QDIST_PR_NODECIMAL;
-    }
-    hgram = qdist_pr(&hst.occupancy, 10, hgram_opts);
-    avg = qdist_avg(&hst.occupancy);
-    if (!isnan(avg)) {
-        g_string_append_printf(buf, "TB hash occupancy   "
-                                    "%0.2f%% avg chain occ. "
-                                    "Histogram: %s\n",
-                               avg * 100, hgram);
-    }
-    g_free(hgram);
-
-    hgram_opts = QDIST_PR_BORDER | QDIST_PR_LABELS;
-    hgram_bins = qdist_xmax(&hst.chain) - qdist_xmin(&hst.chain);
-    if (hgram_bins > 10) {
-        hgram_bins = 10;
-    } else {
-        hgram_bins = 0;
-        hgram_opts |= QDIST_PR_NODECIMAL | QDIST_PR_NOBINRANGE;
-    }
-    hgram = qdist_pr(&hst.chain, hgram_bins, hgram_opts);
-    avg = qdist_avg(&hst.chain);
-    if (!isnan(avg)) {
-        g_string_append_printf(buf, "TB hash avg chain   %0.3f buckets. "
-                                    "Histogram: %s\n",
-                               avg, hgram);
-    }
-    g_free(hgram);
-}
-
-struct tb_tree_stats {
-    size_t nb_tbs;
-    size_t host_size;
-    size_t target_size;
-    size_t max_target_size;
-    size_t direct_jmp_count;
-    size_t direct_jmp2_count;
-    size_t cross_page;
-};
-
-static gboolean tb_tree_stats_iter(gpointer key, gpointer value, gpointer data)
-{
-    const TranslationBlock *tb = value;
-    struct tb_tree_stats *tst = data;
-
-    tst->nb_tbs++;
-    tst->host_size += tb->tc.size;
-    tst->target_size += tb->size;
-    if (tb->size > tst->max_target_size) {
-        tst->max_target_size = tb->size;
-    }
-    if (tb->page_addr[1] != -1) {
-        tst->cross_page++;
-    }
-    if (tb->jmp_reset_offset[0] != TB_JMP_OFFSET_INVALID) {
-        tst->direct_jmp_count++;
-        if (tb->jmp_reset_offset[1] != TB_JMP_OFFSET_INVALID) {
-            tst->direct_jmp2_count++;
-        }
-    }
-    return false;
-}
-
-static void tlb_flush_counts(size_t *pfull, size_t *ppart, size_t *pelide)
-{
-    CPUState *cpu;
-    size_t full = 0, part = 0, elide = 0;
-
-    CPU_FOREACH(cpu) {
-        full += qatomic_read(&cpu->neg.tlb.c.full_flush_count);
-        part += qatomic_read(&cpu->neg.tlb.c.part_flush_count);
-        elide += qatomic_read(&cpu->neg.tlb.c.elide_flush_count);
-    }
-    *pfull = full;
-    *ppart = part;
-    *pelide = elide;
-}
-
-static void tcg_dump_flush_info(GString *buf)
-{
-    size_t flush_full, flush_part, flush_elide;
-
-    g_string_append_printf(buf, "TB flush count      %u\n",
-                           qatomic_read(&tb_ctx.tb_flush_count));
-    g_string_append_printf(buf, "TB invalidate count %u\n",
-                           qatomic_read(&tb_ctx.tb_phys_invalidate_count));
-
-    tlb_flush_counts(&flush_full, &flush_part, &flush_elide);
-    g_string_append_printf(buf, "TLB full flushes    %zu\n", flush_full);
-    g_string_append_printf(buf, "TLB partial flushes %zu\n", flush_part);
-    g_string_append_printf(buf, "TLB elided flushes  %zu\n", flush_elide);
-}
-
-static void dump_exec_info(GString *buf)
-{
-    struct tb_tree_stats tst = {};
-    struct qht_stats hst;
-    size_t nb_tbs;
-
-    tcg_tb_foreach(tb_tree_stats_iter, &tst);
-    nb_tbs = tst.nb_tbs;
-    /* XXX: avoid using doubles ? */
-    g_string_append_printf(buf, "Translation buffer state:\n");
-    /*
-     * Report total code size including the padding and TB structs;
-     * otherwise users might think "-accel tcg,tb-size" is not honoured.
-     * For avg host size we use the precise numbers from tb_tree_stats though.
-     */
-    g_string_append_printf(buf, "gen code size       %zu/%zu\n",
-                           tcg_code_size(), tcg_code_capacity());
-    g_string_append_printf(buf, "TB count            %zu\n", nb_tbs);
-    g_string_append_printf(buf, "TB avg target size  %zu max=%zu bytes\n",
-                           nb_tbs ? tst.target_size / nb_tbs : 0,
-                           tst.max_target_size);
-    g_string_append_printf(buf, "TB avg host size    %zu bytes "
-                           "(expansion ratio: %0.1f)\n",
-                           nb_tbs ? tst.host_size / nb_tbs : 0,
-                           tst.target_size ?
-                           (double)tst.host_size / tst.target_size : 0);
-    g_string_append_printf(buf, "cross page TB count %zu (%zu%%)\n",
-                           tst.cross_page,
-                           nb_tbs ? (tst.cross_page * 100) / nb_tbs : 0);
-    g_string_append_printf(buf, "direct jump count   %zu (%zu%%) "
-                           "(2 jumps=%zu %zu%%)\n",
-                           tst.direct_jmp_count,
-                           nb_tbs ? (tst.direct_jmp_count * 100) / nb_tbs : 0,
-                           tst.direct_jmp2_count,
-                           nb_tbs ? (tst.direct_jmp2_count * 100) / nb_tbs : 0);
-
-    qht_statistics_init(&tb_ctx.htable, &hst);
-    print_qht_statistics(hst, buf);
-    qht_statistics_destroy(&hst);
-
-    g_string_append_printf(buf, "\nStatistics:\n");
-    tcg_dump_flush_info(buf);
-}
-
-void tcg_dump_stats(GString *buf)
-{
-    dump_accel_info(buf);
-    dump_exec_info(buf);
-    dump_drift_info(buf);
-}
 
 HumanReadableText *qmp_x_query_jit(Error **errp)
 {
diff --git a/accel/tcg/tcg-stats.c b/accel/tcg/tcg-stats.c
new file mode 100644
index 00000000000..eb6e20ae985
--- /dev/null
+++ b/accel/tcg/tcg-stats.c
@@ -0,0 +1,215 @@
+/*
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ *
+ *  QEMU TCG statistics
+ *
+ *  Copyright (c) 2003-2005 Fabrice Bellard
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/accel.h"
+#include "qemu/qht.h"
+#include "qapi/error.h"
+#include "system/cpu-timers.h"
+#include "exec/icount.h"
+#include "hw/core/cpu.h"
+#include "tcg/tcg.h"
+#include "internal-common.h"
+#include "tb-context.h"
+#include <math.h>
+
+static void dump_drift_info(GString *buf)
+{
+    if (!icount_enabled()) {
+        return;
+    }
+
+    g_string_append_printf(buf, "Host - Guest clock  %"PRIi64" ms\n",
+                           (cpu_get_clock() - icount_get()) / SCALE_MS);
+    if (icount_align_option) {
+        g_string_append_printf(buf, "Max guest delay     %"PRIi64" ms\n",
+                               -max_delay / SCALE_MS);
+        g_string_append_printf(buf, "Max guest advance   %"PRIi64" ms\n",
+                               max_advance / SCALE_MS);
+    } else {
+        g_string_append_printf(buf, "Max guest delay     NA\n");
+        g_string_append_printf(buf, "Max guest advance   NA\n");
+    }
+}
+
+static void dump_accel_info(GString *buf)
+{
+    AccelState *accel = current_accel();
+    bool one_insn_per_tb = object_property_get_bool(OBJECT(accel),
+                                                    "one-insn-per-tb",
+                                                    &error_fatal);
+
+    g_string_append_printf(buf, "Accelerator settings:\n");
+    g_string_append_printf(buf, "one-insn-per-tb: %s\n\n",
+                           one_insn_per_tb ? "on" : "off");
+}
+
+static void print_qht_statistics(struct qht_stats hst, GString *buf)
+{
+    uint32_t hgram_opts;
+    size_t hgram_bins;
+    char *hgram;
+    double avg;
+
+    if (!hst.head_buckets) {
+        return;
+    }
+    g_string_append_printf(buf, "TB hash buckets     %zu/%zu "
+                           "(%0.2f%% head buckets used)\n",
+                           hst.used_head_buckets, hst.head_buckets,
+                           (double)hst.used_head_buckets /
+                           hst.head_buckets * 100);
+
+    hgram_opts =  QDIST_PR_BORDER | QDIST_PR_LABELS;
+    hgram_opts |= QDIST_PR_100X   | QDIST_PR_PERCENT;
+    if (qdist_xmax(&hst.occupancy) - qdist_xmin(&hst.occupancy) == 1) {
+        hgram_opts |= QDIST_PR_NODECIMAL;
+    }
+    hgram = qdist_pr(&hst.occupancy, 10, hgram_opts);
+    avg = qdist_avg(&hst.occupancy);
+    if (!isnan(avg)) {
+        g_string_append_printf(buf, "TB hash occupancy   "
+                                    "%0.2f%% avg chain occ. "
+                                    "Histogram: %s\n",
+                               avg * 100, hgram);
+    }
+    g_free(hgram);
+
+    hgram_opts = QDIST_PR_BORDER | QDIST_PR_LABELS;
+    hgram_bins = qdist_xmax(&hst.chain) - qdist_xmin(&hst.chain);
+    if (hgram_bins > 10) {
+        hgram_bins = 10;
+    } else {
+        hgram_bins = 0;
+        hgram_opts |= QDIST_PR_NODECIMAL | QDIST_PR_NOBINRANGE;
+    }
+    hgram = qdist_pr(&hst.chain, hgram_bins, hgram_opts);
+    avg = qdist_avg(&hst.chain);
+    if (!isnan(avg)) {
+        g_string_append_printf(buf, "TB hash avg chain   %0.3f buckets. "
+                               "Histogram: %s\n",
+                               avg, hgram);
+    }
+    g_free(hgram);
+}
+
+struct tb_tree_stats {
+    size_t nb_tbs;
+    size_t host_size;
+    size_t target_size;
+    size_t max_target_size;
+    size_t direct_jmp_count;
+    size_t direct_jmp2_count;
+    size_t cross_page;
+};
+
+static gboolean tb_tree_stats_iter(gpointer key, gpointer value, gpointer data)
+{
+    const TranslationBlock *tb = value;
+    struct tb_tree_stats *tst = data;
+
+    tst->nb_tbs++;
+    tst->host_size += tb->tc.size;
+    tst->target_size += tb->size;
+    if (tb->size > tst->max_target_size) {
+        tst->max_target_size = tb->size;
+    }
+#ifndef CONFIG_USER_ONLY
+    if (tb->page_addr[1] != -1) {
+        tst->cross_page++;
+    }
+#endif
+    if (tb->jmp_reset_offset[0] != TB_JMP_OFFSET_INVALID) {
+        tst->direct_jmp_count++;
+        if (tb->jmp_reset_offset[1] != TB_JMP_OFFSET_INVALID) {
+            tst->direct_jmp2_count++;
+        }
+    }
+    return false;
+}
+
+static void tlb_flush_counts(size_t *pfull, size_t *ppart, size_t *pelide)
+{
+    CPUState *cpu;
+    size_t full = 0, part = 0, elide = 0;
+
+    CPU_FOREACH(cpu) {
+        full += qatomic_read(&cpu->neg.tlb.c.full_flush_count);
+        part += qatomic_read(&cpu->neg.tlb.c.part_flush_count);
+        elide += qatomic_read(&cpu->neg.tlb.c.elide_flush_count);
+    }
+    *pfull = full;
+    *ppart = part;
+    *pelide = elide;
+}
+
+static void tcg_dump_flush_info(GString *buf)
+{
+    size_t flush_full, flush_part, flush_elide;
+
+    g_string_append_printf(buf, "TB flush count      %u\n",
+                           qatomic_read(&tb_ctx.tb_flush_count));
+    g_string_append_printf(buf, "TB invalidate count %u\n",
+                           qatomic_read(&tb_ctx.tb_phys_invalidate_count));
+
+    tlb_flush_counts(&flush_full, &flush_part, &flush_elide);
+    g_string_append_printf(buf, "TLB full flushes    %zu\n", flush_full);
+    g_string_append_printf(buf, "TLB partial flushes %zu\n", flush_part);
+    g_string_append_printf(buf, "TLB elided flushes  %zu\n", flush_elide);
+}
+
+static void dump_exec_info(GString *buf)
+{
+    struct tb_tree_stats tst = {};
+    struct qht_stats hst;
+    size_t nb_tbs;
+
+    tcg_tb_foreach(tb_tree_stats_iter, &tst);
+    nb_tbs = tst.nb_tbs;
+    /* XXX: avoid using doubles ? */
+    g_string_append_printf(buf, "Translation buffer state:\n");
+    /*
+     * Report total code size including the padding and TB structs;
+     * otherwise users might think "-accel tcg,tb-size" is not honoured.
+     * For avg host size we use the precise numbers from tb_tree_stats though.
+     */
+    g_string_append_printf(buf, "gen code size       %zu/%zu\n",
+                           tcg_code_size(), tcg_code_capacity());
+    g_string_append_printf(buf, "TB count            %zu\n", nb_tbs);
+    g_string_append_printf(buf, "TB avg target size  %zu max=%zu bytes\n",
+                           nb_tbs ? tst.target_size / nb_tbs : 0,
+                           tst.max_target_size);
+    g_string_append_printf(buf, "TB avg host size    %zu bytes "
+                           "(expansion ratio: %0.1f)\n",
+                           nb_tbs ? tst.host_size / nb_tbs : 0,
+                           tst.target_size ?
+                           (double)tst.host_size / tst.target_size : 0);
+    g_string_append_printf(buf, "cross page TB count %zu (%zu%%)\n",
+                           tst.cross_page,
+                           nb_tbs ? (tst.cross_page * 100) / nb_tbs : 0);
+    g_string_append_printf(buf, "direct jump count   %zu (%zu%%) "
+                           "(2 jumps=%zu %zu%%)\n",
+                           tst.direct_jmp_count,
+                           nb_tbs ? (tst.direct_jmp_count * 100) / nb_tbs : 0,
+                           tst.direct_jmp2_count,
+                           nb_tbs ? (tst.direct_jmp2_count * 100) / nb_tbs : 0);
+
+    qht_statistics_init(&tb_ctx.htable, &hst);
+    print_qht_statistics(hst, buf);
+    qht_statistics_destroy(&hst);
+
+    g_string_append_printf(buf, "\nStatistics:\n");
+    tcg_dump_flush_info(buf);
+}
+
+void tcg_dump_stats(GString *buf)
+{
+    dump_accel_info(buf);
+    dump_exec_info(buf);
+    dump_drift_info(buf);
+}
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 575e92bb9e8..002aa8f4588 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -11,6 +11,7 @@ tcg_ss.add(files(
   'tcg-runtime-gvec.c',
   'tb-maint.c',
   'tcg-all.c',
+  'tcg-stats.c',
   'translate-all.c',
   'translator.c',
 ))
-- 
2.49.0



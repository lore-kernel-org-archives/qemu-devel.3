Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6968AC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 22:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7jTX-0006o9-2x; Thu, 16 May 2024 18:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s7jTN-0006f2-GN
 for qemu-devel@nongnu.org; Thu, 16 May 2024 18:21:14 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s7jTL-0003CH-8H
 for qemu-devel@nongnu.org; Thu, 16 May 2024 18:21:13 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6f4e59191a1so727342b3a.1
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 15:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715898069; x=1716502869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a9mfgVW6aKcKwSz1phkXMBstK1m6Ri0Rr6frZF0Wh5I=;
 b=WEQ4CcCnDBNgXA9Og31IcQfcLC4oskZrp+XOJYldKj4bj439OkQPq4d0hE5Yf+WEP8
 OBbU97E60MHPdX4h/1GeX8w383xMf4KSNF4uRXbrc0C0CFZ1d3IlGrtztaYzVfeOeOuY
 2YV9hXt2tS9ud2S4Vp5hv7JTmPHKJkwzBIVybfZ7B7IS6PWURtAHQpo4mp6+nmOIZ23G
 u5rKjyA1TDR39129gaIXxoE4sX7z7csgWCrh7HEymXLm/DwNK5MCbspgTZi/5HZnuNXL
 Aq4FsBeCxFjymduRuJPS/SuffImOayeRT8KsGG382er7NSfmdU+I3uVAspSf2SVryneT
 /+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715898069; x=1716502869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a9mfgVW6aKcKwSz1phkXMBstK1m6Ri0Rr6frZF0Wh5I=;
 b=dxjYf7KLsKloHmwmzoibEcpAO+JykyPuJfAFN7NKxYd8OimgC4yj5jqfp81bo8/Ra/
 RiyOvgbbNRFhWE11cCCw0md22vzxGj7m8ZffG5cwAndeeW1Q4X0ehmfrAFpQteVDwyF3
 1PZWKa8CjyeOksSqS/zszr0LCuXnKvNSa4HHewJpD21UrH8if7z39umtDk3/aOQxFIs2
 5+CPEtdPFVnABqwTiv6R6iqf2xvepm4a2ce1U/ZWHNWhbbkKeRUnQ+0QyN4KbK5N0LuA
 XWe8EJFt0zpPRwcSVO1SeeQWvsAic7J/GSjPfYXttL0/MkE1oy2ibPiLcLxE5J8Z0U+n
 fOJA==
X-Gm-Message-State: AOJu0Yztw6AYB/blNh/tEAhOd+ouKAvgFPqAsoqSJj2JBZLmOgroVU1T
 GfTxTZ9X4AZnlyy5vrs4gdsLOPtzWzOONLlyzO7TriJ603kz7WqJj2qQQG2+KPT8YN8dhj0FtBQ
 Goic=
X-Google-Smtp-Source: AGHT+IFXJ5bWk77oCn/iVPCD17NDt8ehBko02XXMPhyvJvrTWIMdtyBMJNjI17PPVNm0oUiEdNZJrA==
X-Received: by 2002:a05:6a20:2d26:b0:1b0:14ee:3b29 with SMTP id
 adf61e73a8af0-1b014ee3b88mr8875271637.10.1715898069046; 
 Thu, 16 May 2024 15:21:09 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a66476sm13589219b3a.28.2024.05.16.15.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 15:21:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5/5] contrib/plugins: add ips plugin example for cost modeling
Date: Thu, 16 May 2024 15:20:47 -0700
Message-Id: <20240516222047.1853459-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240516222047.1853459-1-pierrick.bouvier@linaro.org>
References: <20240516222047.1853459-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

This plugin uses the new time control interface to make decisions
about the state of time during the emulation. The algorithm is
currently very simple. The user specifies an ips rate which applies
per core. If the core runs ahead of its allocated execution time the
plugin sleeps for a bit to let real time catch up. Either way time is
updated for the emulation as a function of total executed instructions
with some adjustments for cores that idle.

Examples
--------

Slow down execution of /bin/true:
$ num_insn=$(./build/qemu-x86_64 -plugin ./build/tests/plugin/libinsn.so -d plugin /bin/true |& grep total | sed -e 's/.*: //')
$ time ./build/qemu-x86_64 -plugin ./build/contrib/plugins/libips.so,ips=$(($num_insn/4)) /bin/true
real 4.000s

Boot a Linux kernel simulating a 250MHz cpu:
$ /build/qemu-system-x86_64 -kernel /boot/vmlinuz-6.1.0-21-amd64 -append "console=ttyS0" -plugin ./build/contrib/plugins/libips.so,ips=$((250*1000*1000)) -smp 1 -m 512
check time until kernel panic on serial0

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/ips.c    | 239 +++++++++++++++++++++++++++++++++++++++
 contrib/plugins/Makefile |   1 +
 2 files changed, 240 insertions(+)
 create mode 100644 contrib/plugins/ips.c

diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
new file mode 100644
index 00000000000..cf3159df391
--- /dev/null
+++ b/contrib/plugins/ips.c
@@ -0,0 +1,239 @@
+/*
+ * ips rate limiting plugin.
+ *
+ * This plugin can be used to restrict the execution of a system to a
+ * particular number of Instructions Per Second (ips). This controls
+ * time as seen by the guest so while wall-clock time may be longer
+ * from the guests point of view time will pass at the normal rate.
+ *
+ * This uses the new plugin API which allows the plugin to control
+ * system time.
+ *
+ * Copyright (c) 2023 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdio.h>
+#include <glib.h>
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+/* how many times do we update time per sec */
+#define NUM_TIME_UPDATE_PER_SEC 10
+#define NSEC_IN_ONE_SEC (1000 * 1000 * 1000)
+
+static GMutex global_state_lock;
+
+static uint64_t insn_per_second = 1000 * 1000; /* ips per core, per second */
+static uint64_t insn_quantum; /* trap every N instructions */
+static bool precise_execution; /* count every instruction */
+static int64_t start_time_ns; /* time (ns since epoch) first vCPU started */
+static int64_t virtual_time_ns; /* last set virtual time */
+
+static const void *time_handle;
+
+typedef enum {
+    UNKNOWN = 0,
+    EXECUTING,
+    IDLE,
+    FINISHED
+} vCPUState;
+
+typedef struct {
+    uint64_t counter;
+    uint64_t track_insn;
+    vCPUState state;
+    /* timestamp when vCPU entered state */
+    int64_t last_state_time;
+} vCPUTime;
+
+struct qemu_plugin_scoreboard *vcpus;
+
+/* return epoch time in ns */
+static int64_t now_ns(void)
+{
+    return g_get_real_time() * 1000;
+}
+
+static uint64_t num_insn_during(int64_t elapsed_ns)
+{
+    double num_secs = elapsed_ns / (double) NSEC_IN_ONE_SEC;
+    return num_secs * (double) insn_per_second;
+}
+
+static int64_t time_for_insn(uint64_t num_insn)
+{
+    double num_secs = (double) num_insn / (double) insn_per_second;
+    return num_secs * (double) NSEC_IN_ONE_SEC;
+}
+
+static int64_t uptime_ns(void)
+{
+    int64_t now = now_ns();
+    g_assert(now >= start_time_ns);
+    return now - start_time_ns;
+}
+
+static void vcpu_set_state(vCPUTime *vcpu, vCPUState new_state)
+{
+    vcpu->last_state_time = now_ns();
+    vcpu->state = new_state;
+}
+
+static void update_system_time(vCPUTime *vcpu)
+{
+    /* flush remaining instructions */
+    vcpu->counter += vcpu->track_insn;
+    vcpu->track_insn = 0;
+
+    int64_t uptime = uptime_ns();
+    uint64_t expected_insn = num_insn_during(uptime);
+
+    if (vcpu->counter >= expected_insn) {
+        /* this vcpu ran faster than expected, so it has to sleep */
+        uint64_t insn_advance = vcpu->counter - expected_insn;
+        uint64_t time_advance_ns = time_for_insn(insn_advance);
+        int64_t sleep_us = time_advance_ns / 1000;
+        g_usleep(sleep_us);
+    }
+
+    /* based on number of instructions, what should be the new time? */
+    int64_t new_virtual_time = time_for_insn(vcpu->counter);
+
+    g_mutex_lock(&global_state_lock);
+
+    /* Time only moves forward. Another vcpu might have updated it already. */
+    if (new_virtual_time > virtual_time_ns) {
+        qemu_plugin_update_ns(time_handle, new_virtual_time);
+        virtual_time_ns = new_virtual_time;
+    }
+
+    g_mutex_unlock(&global_state_lock);
+}
+
+static void set_start_time()
+{
+    g_mutex_lock(&global_state_lock);
+    if (!start_time_ns) {
+        start_time_ns = now_ns();
+    }
+    g_mutex_unlock(&global_state_lock);
+}
+
+static void vcpu_init(qemu_plugin_id_t id, unsigned int cpu_index)
+{
+    vCPUTime *vcpu = qemu_plugin_scoreboard_find(vcpus, cpu_index);
+    /* ensure start time is set first */
+    set_start_time();
+    /* start counter from absolute time reference */
+    vcpu->counter = num_insn_during(uptime_ns());
+    vcpu_set_state(vcpu, EXECUTING);
+}
+
+static void vcpu_idle(qemu_plugin_id_t id, unsigned int cpu_index)
+{
+    vCPUTime *vcpu = qemu_plugin_scoreboard_find(vcpus, cpu_index);
+    vcpu_set_state(vcpu, IDLE);
+}
+
+static void vcpu_resume(qemu_plugin_id_t id, unsigned int cpu_index)
+{
+    vCPUTime *vcpu = qemu_plugin_scoreboard_find(vcpus, cpu_index);
+    g_assert(vcpu->state == IDLE);
+    int64_t idle_time = now_ns() - vcpu->last_state_time;
+    /* accumulate expected number of instructions */
+    vcpu->counter += num_insn_during(idle_time);
+    vcpu_set_state(vcpu, EXECUTING);
+}
+
+static void vcpu_exit(qemu_plugin_id_t id, unsigned int cpu_index)
+{
+    vCPUTime *vcpu = qemu_plugin_scoreboard_find(vcpus, cpu_index);
+    vcpu_set_state(vcpu, FINISHED);
+    update_system_time(vcpu);
+    vcpu->counter = 0;
+}
+
+static void every_insn_quantum(unsigned int cpu_index, void *udata)
+{
+    vCPUTime *vcpu = qemu_plugin_scoreboard_find(vcpus, cpu_index);
+    g_assert(vcpu->track_insn >= insn_quantum);
+    update_system_time(vcpu);
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    size_t n_insns = qemu_plugin_tb_n_insns(tb);
+    qemu_plugin_u64 track_insn =
+        qemu_plugin_scoreboard_u64_in_struct(vcpus, vCPUTime, track_insn);
+    if (precise_execution) {
+        /* count (and eventually trap) on every instruction */
+        for (int idx = 0; idx < qemu_plugin_tb_n_insns(tb); ++idx) {
+            struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, idx);
+            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+                insn, QEMU_PLUGIN_INLINE_ADD_U64, track_insn, 1);
+            qemu_plugin_register_vcpu_insn_exec_cond_cb(
+                insn, every_insn_quantum,
+                QEMU_PLUGIN_CB_NO_REGS, QEMU_PLUGIN_COND_GE,
+                track_insn, insn_quantum, NULL);
+        }
+    } else {
+        /* count (and eventually trap) once per tb */
+        qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+            tb, QEMU_PLUGIN_INLINE_ADD_U64, track_insn, n_insns);
+        qemu_plugin_register_vcpu_tb_exec_cond_cb(
+            tb, every_insn_quantum,
+            QEMU_PLUGIN_CB_NO_REGS, QEMU_PLUGIN_COND_GE,
+            track_insn, insn_quantum, NULL);
+    }
+}
+
+static void plugin_exit(qemu_plugin_id_t id, void *udata)
+{
+    qemu_plugin_scoreboard_free(vcpus);
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info, int argc,
+                                           char **argv)
+{
+    for (int i = 0; i < argc; i++) {
+        char *opt = argv[i];
+        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
+        if (g_strcmp0(tokens[0], "ips") == 0) {
+            insn_per_second = g_ascii_strtoull(tokens[1], NULL, 10);
+            if (!insn_per_second && errno) {
+                fprintf(stderr, "%s: couldn't parse %s (%s)\n",
+                        __func__, tokens[1], g_strerror(errno));
+                return -1;
+            }
+
+        } else if (g_strcmp0(tokens[0], "precise") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1],
+                                        &precise_execution)) {
+                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
+                return -1;
+            }
+        } else {
+            fprintf(stderr, "option parsing failed: %s\n", opt);
+            return -1;
+        }
+    }
+
+    vcpus = qemu_plugin_scoreboard_new(sizeof(vCPUTime));
+    insn_quantum = insn_per_second / NUM_TIME_UPDATE_PER_SEC;
+
+    time_handle = qemu_plugin_request_time_control();
+    g_assert(time_handle);
+
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
+    qemu_plugin_register_vcpu_idle_cb(id, vcpu_idle);
+    qemu_plugin_register_vcpu_resume_cb(id, vcpu_resume);
+    qemu_plugin_register_vcpu_exit_cb(id, vcpu_exit);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+
+    return 0;
+}
diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index 0b64d2c1e3a..449ead11305 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -27,6 +27,7 @@ endif
 NAMES += hwprofile
 NAMES += cache
 NAMES += drcov
+NAMES += ips
 
 ifeq ($(CONFIG_WIN32),y)
 SO_SUFFIX := .dll
-- 
2.39.2



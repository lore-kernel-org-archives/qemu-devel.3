Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0238BC25B7E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 17:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCjud-0003tS-6b; Thu, 30 May 2024 13:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCjua-0003sw-9J
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:50:00 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCjuY-0002T7-8h
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:50:00 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f62fae8c1aso2114755ad.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 10:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717091396; x=1717696196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a9mfgVW6aKcKwSz1phkXMBstK1m6Ri0Rr6frZF0Wh5I=;
 b=voN+CQJqije/81pB0luWr/2dAU8KrBIB1eEk5qrDk3LkClzbTh/q8iaKAAfiagoT2M
 EYcAhTcGG8ssaQJsXFtnQne79/GmGjIFwirkfSKl4urykeUcDJ6Whkt9Zr/cisBgooQK
 uCxS3lJsvTl3YFVsDpFTSBVFVGnJGRXSQVXeMQJ86oF58UwuuzJx5VwUbXz4mpNDbjBf
 xYaZYAohelHvyuA+NGkyTjke6/tcY5KW47Yt3UYIMEb++QdadDC3ggAdqx/q6/nSWbz+
 p/bfud2JbI/pTTleHqzALRqOJttjQeXiomDpLfrtvWt35/977mUlrbP5Hzc0aCrCT9zc
 V6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717091396; x=1717696196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a9mfgVW6aKcKwSz1phkXMBstK1m6Ri0Rr6frZF0Wh5I=;
 b=Daifze0QdHxCmOUIbwOBnYXOA8SnN58uGnWJ7MH79mDyWZOqRSH1UwZA2jK+k622Ky
 VJanc8otdpfz6i/YEVLpdGUp1+Lc13qZII/+SD0Rkz/JUH0x01JjpTXWrcUgcPzCAZnL
 wWITbo8j/k7ZoRSOiHiMk4Y/ZWLmYQbm5xEF7TdVm+Dwyi+x69jw3iNKA+syOfi915f5
 9JEqZyXFDR+r/N9VVr2u9En1fwsUVd4sZU7bA72Z6kGTl0oykzc5B/y3Kkq0OyfIvmA4
 5i6WG61BXQq8xA2XxZT38R1SpSoLeey8tTVbrtl+8OgK6n1NDORPfE5+41IL8XvSRY8F
 NjoQ==
X-Gm-Message-State: AOJu0YwoI9tr97FyL45Pi4wC78DrqKD5POYWLcYjcpzWFKvWor6/n+u6
 ryX3I9/GoE4BKbRVT8eKhelPfHjYx6NNfv23KCoKj73gkAwW+jG7RI3p7oaVQeqj7yTMdj70DPK
 RH/U=
X-Google-Smtp-Source: AGHT+IHmqD8oKpXGiZ5yfj8l+uqnP81xtf3pC2ybaGHSvKTZqP9/u5cc0JLkGHy1ZjbisYBm30j5eg==
X-Received: by 2002:a17:902:e549:b0:1f4:5fe5:74c9 with SMTP id
 d9443c01a7336-1f61a4e4e8emr38818015ad.69.1717091396339; 
 Thu, 30 May 2024 10:49:56 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323deb38sm590405ad.124.2024.05.30.10.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 10:49:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 6/6] contrib/plugins: add ips plugin example for cost
 modeling
Date: Thu, 30 May 2024 10:49:39 -0700
Message-Id: <20240530174939.749163-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240530174939.749163-1-pierrick.bouvier@linaro.org>
References: <20240530174939.749163-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44751CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 07:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utLnT-00079O-EI; Tue, 02 Sep 2025 03:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1utLnF-000748-OQ
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 03:51:06 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1utLnB-0001uv-FJ
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 03:51:05 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7725fb32e1bso1662428b3a.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 00:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756799460; x=1757404260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GSfyk/HqfC8n0v5Y6ucX/C1jK6jRJAOoqt5Ytsqhg8I=;
 b=hIj2zzeqoztzjoH6De5HCvwOmM8gKx6oE3l71L9QYPgHCK3NZx6alJZTLlfArBt4aF
 mNES1aNfNzDJT9I+423aMYovkVEnHLUelrC0DpFQQEqjCqeOQFmb4wSVt2QQNaHEKfNv
 6noI2T0ve35N+EwoQYTiyM1fft16GkkHzVXWdTSysMlDUFG4IovSlWTG69kfEPQL9env
 tpeB4LM5wtigjlRNfPb4FW6QTNl+TYRbNofKxKtzUwIsQ+SF2leiwC/GyJcCwg9v6uGX
 SeOmmfIw2Inqf9fuw3X/f/JsLP1KbhSI4csWabrqCcCDE1NqaSX0FKH/v/YROsPZCId1
 4bOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756799460; x=1757404260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GSfyk/HqfC8n0v5Y6ucX/C1jK6jRJAOoqt5Ytsqhg8I=;
 b=Y2njTo8s8CjPIk9/2sIcxK3LVFJ+WTom603Sk4cTZIdSJLXd8ZeC0BwMMNwiB5c4vP
 b0vVugL//sOw5hLCnxeezXPM0ehMNYPdlITaNMdcsAofYWyp++E7qjkh2N0UCvUdmtMV
 qHcQbuCZrQ7fq8+M2ALSRviUUg038K+EVlEgyMU7ffUSPe2Yd9BVIbL53CNwcySboN5e
 HvzXhQH4WRvYr6yZokSUXboiUt/JqrLZDJhFiQA+/BdiWcfrEltXIdApSaaNSAqgCnUR
 1xn3oIaYu8v7GJbyfN46EghE1ohdVUrheoqX0NTlj00YT9uoqMUPA/OSB7vt0ym2pHU5
 g7vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+w2iI6TQPCMctcLpAGo1r12R+09U3Zlw8CR2y2luvJt+dymzLs9OZH86ROyz45kSV1F6S3N7RnXLy@nongnu.org
X-Gm-Message-State: AOJu0YyZfi4jFQUTF22t+UtX+ZI4/W3D10c0mCPVA/QcR6GB1rZbVQ1B
 Fc2rx8l5P/AN60D7o3g+l0xzLRMKfhtJ5raAjxiCSNWbDfAI25zXyevDgOB6mDls0Qc=
X-Gm-Gg: ASbGncsDkTOl3jLzi8soV4ZdbB4SThj8eGgmHrzAD4muaXm26wUvVXpaDU50SR06sS3
 nlh03GE87xSG0tKwkDvqP79+RI82pglmZ8cYSFMHggVDDzkyKM371e8ZDI5zhXHc1o1Q6x8Qxbc
 ZletQZZosCK4GkmvjZKDrp/JZAYYwRs/aszlkePMU56rU2B/FpXZw2JbFUMQq6tcki69du66A7v
 /NFEiJqAdbh41pcpE+DEgSdWGS/zfu++9QfXJzHf8hGf6YLhOwGPgQ57zaOp6RDoePOWJmTqmxo
 3b5TY3pcz4I+O4y71di90JTvFP6RmZtU7AEwDnsOLVlLHf9/l3AUnRUfdI3nRojMt39AQF3gtOd
 VatSkCpv0pMlCNO0g/cM8o8tElC2eRigL3g4Arvt4TzP3QnET9I8DGg==
X-Google-Smtp-Source: AGHT+IHVgHvKowN7epw1lJQIRwVAyrPE2dXskSXU0sXIDANUX0/5LF+Kp5EdXHxPwV/MQzN5DQSYYg==
X-Received: by 2002:a05:6a00:2e08:b0:76b:f8ee:4eaa with SMTP id
 d2e1a72fcca58-7723e24ff0cmr12199348b3a.9.1756799459811; 
 Tue, 02 Sep 2025 00:50:59 -0700 (PDT)
Received: from pc.taild8403c.ts.net ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7723d79fcfesm9642766b3a.16.2025.09.02.00.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 00:50:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: pierrick.bouvier@linaro.org,
	qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v7 4/9] contrib/plugins/uftrace: implement tracing
Date: Tue,  2 Sep 2025 00:50:37 -0700
Message-ID: <20250902075042.223990-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250902075042.223990-1-pierrick.bouvier@linaro.org>
References: <20250902075042.223990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

We implement tracing, following uftrace format.
Trace is flushed every 32 MB, so file operations don't impact
performance at runtime.

A different trace is generated per cpu, and we ensure they have a unique
name, based on vcpu_index, while keeping room for privilege level coming
in next commit.

Uftrace format is not officially documented, but it can be found here:
https://github.com/namhyung/uftrace/blob/v0.18/libmcount/record.c#L909

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace.c | 152 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 151 insertions(+), 1 deletion(-)

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index bb775916270..b9dcd531987 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -12,6 +12,15 @@
 #include <qemu-plugin.h>
 #include <glib.h>
 #include <stdio.h>
+#include <sys/stat.h>
+#include <sys/time.h>
+#include <time.h>
+#include <unistd.h>
+
+#define MiB     (INT64_C(1) << 20)
+#define NANOSECONDS_PER_SECOND 1000000000LL
+#define TRACE_FLUSH_SIZE (32 * MiB)
+#define TRACE_ID_SCALE 100
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
@@ -24,6 +33,13 @@ typedef struct {
     uint64_t frame_pointer;
 } CallstackEntry;
 
+typedef struct {
+    GArray *t;
+    GString *path;
+    GString *name;
+    uint32_t id;
+} Trace;
+
 typedef struct Cpu Cpu;
 
 typedef struct {
@@ -34,6 +50,7 @@ typedef struct {
 } CpuOps;
 
 typedef struct Cpu {
+    Trace *trace;
     Callstack *cs;
     GByteArray *buf;
     CpuOps ops;
@@ -44,9 +61,41 @@ typedef struct {
     struct qemu_plugin_register *reg_fp;
 } Aarch64Cpu;
 
+typedef struct {
+    uint64_t timestamp;
+    uint64_t data;
+} UftraceEntry;
+
+typedef enum {
+    UFTRACE_ENTRY,
+    UFTRACE_EXIT,
+    UFTRACE_LOST,
+    UFTRACE_EVENT,
+} UftraceRecordType;
+
 static struct qemu_plugin_scoreboard *score;
 static CpuOps arch_ops;
 
+static uint64_t gettime_ns(void)
+{
+#ifdef _WIN32
+    /*
+     * On Windows, timespec_get is available only with UCRT, but not with
+     * MinGW64 environment. Simplify by using only gettimeofday on this
+     * platform. This may result in a precision loss.
+     */
+    struct timeval tv;
+    gettimeofday(&tv, NULL);
+    uint64_t now_ns = tv.tv_sec * NANOSECONDS_PER_SECOND + tv.tv_usec * 1000;
+#else
+    /* We need nanosecond precision for short lived functions. */
+    struct timespec ts;
+    timespec_get(&ts, TIME_UTC);
+    uint64_t now_ns = ts.tv_sec * NANOSECONDS_PER_SECOND + ts.tv_nsec;
+#endif
+    return now_ns;
+}
+
 static Callstack *callstack_new(void)
 {
     Callstack *cs = g_new0(Callstack, 1);
@@ -112,6 +161,86 @@ static CallstackEntry callstack_pop(Callstack *cs)
     return e;
 }
 
+static Trace *trace_new(uint32_t id, GString *name)
+{
+    Trace *t = g_new0(Trace, 1);
+    t->t = g_array_new(false, false, sizeof(UftraceEntry));
+    t->path = g_string_new(NULL);
+    g_string_append_printf(t->path, "./uftrace.data/%"PRIu32".dat", id);
+    t->name = g_string_new(name->str);
+    t->id = id;
+    return t;
+}
+
+static void trace_free(Trace *t)
+{
+    g_assert(t->t->len == 0);
+    g_array_free(t->t, true);
+    t->t = NULL;
+    g_string_free(t->path, true);
+    t->path = NULL;
+    g_string_free(t->name, true);
+    t->name = NULL;
+    g_free(t);
+}
+
+static void trace_flush(Trace *t, bool append)
+{
+    int create_dir = g_mkdir_with_parents("./uftrace.data",
+                                          S_IRWXU | S_IRWXG | S_IRWXO);
+    g_assert(create_dir == 0);
+    FILE *dat = fopen(t->path->str, append ? "a" : "w");
+    g_assert(dat);
+    GArray *data = t->t;
+    if (data->len) {
+        size_t wrote = fwrite(data->data, sizeof(UftraceEntry), data->len, dat);
+        g_assert(wrote == data->len);
+    }
+    fclose(dat);
+    g_array_set_size(data, 0);
+}
+
+static void trace_add_entry(Trace *t, uint64_t timestamp, uint64_t pc,
+                            size_t depth, UftraceRecordType type)
+{
+    /* https://github.com/namhyung/uftrace/blob/v0.18/libmcount/record.c#L909 */
+    const uint64_t record_magic = 0x5;
+    uint64_t data = type | (record_magic << 3);
+    data += depth << 6;
+    data += pc << 16;
+    UftraceEntry e = {.timestamp = timestamp, .data = data};
+    g_array_append_val(t->t, e);
+    if (t->t->len * sizeof(UftraceEntry) > TRACE_FLUSH_SIZE) {
+        trace_flush(t, true);
+    }
+}
+
+static void trace_enter_function(Trace *t, uint64_t timestamp,
+                                 uint64_t pc, size_t depth)
+{
+    trace_add_entry(t, timestamp, pc, depth, UFTRACE_ENTRY);
+}
+
+static void trace_exit_function(Trace *t, uint64_t timestamp,
+                                uint64_t pc, size_t depth)
+{
+    trace_add_entry(t, timestamp, pc, depth, UFTRACE_EXIT);
+}
+
+static void trace_enter_stack(Trace *t, Callstack *cs, uint64_t timestamp)
+{
+    for (size_t depth = 1; depth <= callstack_depth(cs); ++depth) {
+        trace_enter_function(t, timestamp, callstack_at(cs, depth)->pc, depth);
+    }
+}
+
+static void trace_exit_stack(Trace *t, Callstack *cs, uint64_t timestamp)
+{
+    for (size_t depth = callstack_depth(cs); depth > 0; --depth) {
+        trace_exit_function(t, timestamp, callstack_at(cs, depth)->pc, depth);
+    }
+}
+
 static uint64_t cpu_read_register64(Cpu *cpu, struct qemu_plugin_register *reg)
 {
     GByteArray *buf = cpu->buf;
@@ -223,7 +352,9 @@ static void track_callstack(unsigned int cpu_index, void *udata)
 {
     uint64_t pc = (uintptr_t) udata;
     Cpu *cpu = qemu_plugin_scoreboard_find(score, cpu_index);
+    uint64_t timestamp = gettime_ns();
     Callstack *cs = cpu->cs;
+    Trace *t = cpu->trace;
 
     uint64_t fp = cpu->ops.get_frame_pointer(cpu);
     if (!fp && callstack_empty(cs)) {
@@ -232,6 +363,7 @@ static void track_callstack(unsigned int cpu_index, void *udata)
          * long as a proper call does not happen.
          */
         callstack_push(cs, (CallstackEntry){.frame_pointer = fp, .pc = pc});
+        trace_enter_function(t, timestamp, pc, callstack_depth(cs));
         return;
     }
 
@@ -244,7 +376,8 @@ static void track_callstack(unsigned int cpu_index, void *udata)
     CallstackEntry caller = callstack_caller(cs);
     if (fp == caller.frame_pointer) {
         /* return */
-        callstack_pop(cs);
+        CallstackEntry e = callstack_pop(cs);
+        trace_exit_function(t, timestamp, e.pc, callstack_depth(cs));
         return;
     }
 
@@ -252,12 +385,16 @@ static void track_callstack(unsigned int cpu_index, void *udata)
     if (caller_fp == top.frame_pointer) {
         /* call */
         callstack_push(cs, (CallstackEntry){.frame_pointer = fp, .pc = pc});
+        trace_enter_function(t, timestamp, pc, callstack_depth(cs));
         return;
     }
 
     /* discontinuity, exit current stack and unwind new one */
+    trace_exit_stack(t, cs, timestamp);
     callstack_clear(cs);
+
     cpu_unwind_stack(cpu, fp, pc);
+    trace_enter_stack(t, cs, timestamp);
 }
 
 static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
@@ -297,6 +434,16 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
     cpu->ops.init(cpu);
     cpu->buf = g_byte_array_new();
 
+    g_assert(vcpu_index < UINT32_MAX / TRACE_ID_SCALE);
+    /* trace_id is: cpu_number * TRACE_ID_SCALE */
+    uint32_t trace_id = (vcpu_index + 1) * TRACE_ID_SCALE;
+
+    g_autoptr(GString) trace_name = g_string_new(NULL);
+    g_string_append_printf(trace_name, "cpu%u", vcpu_index);
+    cpu->trace = trace_new(trace_id, trace_name);
+    /* create/truncate trace file */
+    trace_flush(cpu->trace, false);
+
     cpu->cs = callstack_new();
 }
 
@@ -305,6 +452,7 @@ static void vcpu_end(unsigned int vcpu_index)
     Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
     g_byte_array_free(cpu->buf, true);
 
+    trace_free(cpu->trace);
     callstack_free(cpu->cs);
     memset(cpu, 0, sizeof(Cpu));
 }
@@ -312,6 +460,8 @@ static void vcpu_end(unsigned int vcpu_index)
 static void at_exit(qemu_plugin_id_t id, void *data)
 {
     for (size_t i = 0; i < qemu_plugin_num_vcpus(); ++i) {
+        Cpu *cpu = qemu_plugin_scoreboard_find(score, i);
+        trace_flush(cpu->trace, true);
         vcpu_end(i);
     }
 
-- 
2.47.2



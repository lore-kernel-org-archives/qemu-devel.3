Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46048C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 09:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukJLh-0008K4-5v; Fri, 08 Aug 2025 05:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukJLe-0008Hd-6f
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 05:25:14 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukJLZ-0000mG-Gy
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 05:25:13 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3b7825e2775so1732075f8f.2
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 02:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754645106; x=1755249906; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CD6doN0sFxkv4ZCTCd0h8mJCRQs9TvtS+dZz1Pb2zq8=;
 b=NVSiWQ5yxyHHgljF2857FYfcE90+ny8cL9QOVz5NdqSLYgZHMaL1ce8wd5+/wgXWcS
 Jp/lEaYI+vAgibhapmil3R+YuHYIAqKlR8G+9gFZFxgQm+HOH8w58jJU8bfBP7FaZZ65
 Dac1VwoO7O1y6dlyzMemIvBWsOZnr5aRsC4bq26IAX7VLRyKtI0mQkLqo1bdS40MN75T
 w0iVgWtoAQpxPhicjjlVTvvYgBIeD0F/kMWTNWglsc6dTXRB/bDFRb93YqsrjsF+7oZA
 bog3JSJrTaFwmbDHo8+fF7O90GNonQFI7cxLZ2BuDqeza+JDLphZPpb07H7rwooPTfzi
 F6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754645106; x=1755249906;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CD6doN0sFxkv4ZCTCd0h8mJCRQs9TvtS+dZz1Pb2zq8=;
 b=E9vObiL1vvx8E+tAn4xrZbDEFQUcLOS1yEHeyXYqrUDkQduQvUMWq3IMkWPI+ZXX+n
 ShQlnpTkVdb8RIj7vDOSX2yN7nZ5IYtxs1fHb8vxZvN1J3u3osKpdqMPXY7Ozr2kz8pv
 t/mfeQQ1fnKu3GD2csvEu86yHOAXcPMcuGUWWMwfLF7/eAHFIw7VrJL2CcDDFF9lUdAM
 KQWK9PZa16s1w8q2TlLOkbXxLL3SKE1XMWVl73p4fSh5fT0dsxUBFgrCrafDa0G5cWwX
 3JdlNrZskvOfSgvH0Prw1gzSjkNh2GgTT6PLC7ncfQ/vS6z7pa+aW0JFbcwc1AVOI7c0
 vkTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgCD0VjCFH4dNwJrQ9Tk7EcRZYlpvI/J4ukor3mOF578dCTwzDM7zooJNEA9WoEYJYi/wnVLM5j2R0@nongnu.org
X-Gm-Message-State: AOJu0Yxr0aqoWx7iGSIrv7YFkTF4WcoVHluX3hJ/i8sWyJXv5mZLwneE
 JZcbEWZwSm1t1pHScfqiAF/WMHyxZVTRfTJcGTqoxp4ezEMjPD2pYWyCDY8h9YqkeIfijEMh5At
 sCnbN9Uw=
X-Gm-Gg: ASbGncuJBQTtW8gZgUEOWt+Gc60AlCxVGtC8uVHwKs5WWPC8vFlVdzXSwZak+01H8YX
 JAIYHmmGo8Zi/Wo8dkDQsIUhldcE2PsuCvjrE9wToPoaVtCco9U+APY23zlUFWXNa9Zw560t2Lj
 3YEV/49OSEyeTK7BvUm/KJzE9No6rg0w5tfgHy8jevxtKUjRLFG66Oyoo8FaYqo01IKyrIQLU0V
 5v7qp5i5p5QMulQ2KcCSXGNidgxmyAO8QYA82Ee1jbh7HPm85VGidVppEEko1aWsQiRm0PHRJM0
 TKHmE2CfwWv1z3sgxQcEKbC5FrRStult0WhbkJka8MtwjVKAUYP0lYvvkyWJ0zDBQ6877cXDJb2
 DsKcyypMWhfXt8EMDIEM8TY6T54bEbAj68TU7VyIjThlsOcT7opm8IhImvQCUiEBcenjDPBla
X-Google-Smtp-Source: AGHT+IGZIoCfQUs4HCsZVteHM0N/MqTsLmclRVnlTzoYVgJ9jPEmc7qhgfS0uesri6P9wf5B0QSZ6w==
X-Received: by 2002:a05:6000:288c:b0:3b8:ff5e:f3cf with SMTP id
 ffacd0b85a97d-3b900b72c91mr1892867f8f.32.1754645106427; 
 Fri, 08 Aug 2025 02:25:06 -0700 (PDT)
Received: from meli-email.org (athedsl-4440194.home.otenet.gr.
 [79.129.176.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e6867193sm123710605e9.6.2025.08.08.02.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 02:25:05 -0700 (PDT)
Date: Fri, 08 Aug 2025 12:11:06 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 4/9] contrib/plugins/uftrace: implement tracing
User-Agent: meli/0.8.12
References: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
 <20250808020702.410109-5-pierrick.bouvier@linaro.org>
In-Reply-To: <20250808020702.410109-5-pierrick.bouvier@linaro.org>
Message-ID: <t0o4ts.nym46t847yx5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x431.google.com
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

On Fri, 08 Aug 2025 05:06, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>We implement tracing, following uftrace format.
>Trace is flushed every 32 MB, so file operations don't impact
>performance at runtime.
>
>A different trace is generated per cpu, and we ensure they have a unique
>name, based on vcpu_index, while keeping room for privilege level coming
>in next commit.

Suggestion (not a request): put some kind of documentation about the 
format this patch implements, maybe a commit sha & URL to a header file 
from upstream uftrace.

>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>---
> contrib/plugins/uftrace.c | 149 +++++++++++++++++++++++++++++++++++++-
> 1 file changed, 148 insertions(+), 1 deletion(-)
>
>diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
>index d51faceb344..402a242433e 100644
>--- a/contrib/plugins/uftrace.c
>+++ b/contrib/plugins/uftrace.c
>@@ -12,6 +12,13 @@
> #include <qemu-plugin.h>
> #include <glib.h>
> #include <stdio.h>
>+#include <sys/stat.h>
>+#include <sys/time.h>
>+#include <time.h>
>+#include <unistd.h>
>+
>+#define MiB     (INT64_C(1) << 20)
>+#define NANOSECONDS_PER_SECOND 1000000000LL
> 
> QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
> 
>@@ -24,6 +31,13 @@ typedef struct {
>     uint64_t frame_pointer;
> } CallstackEntry;
> 
>+typedef struct {
>+    GArray *t;
>+    GString *path;
>+    GString *name;
>+    uint32_t id;
>+} Trace;
>+
> typedef struct Cpu Cpu;
> 
> typedef struct {
>@@ -34,6 +48,7 @@ typedef struct {
> } CpuOps;
> 
> typedef struct Cpu {
>+    Trace *trace;
>     Callstack *cs;
>     GByteArray *buf;
>     CpuOps ops;
>@@ -44,9 +59,41 @@ typedef struct {
>     struct qemu_plugin_register *reg_fp;
> } Aarch64Cpu;
> 
>+typedef struct {
>+    uint64_t timestamp;
>+    uint64_t data;
>+} UftraceEntry;
>+
>+typedef enum {
>+    UFTRACE_ENTRY,
>+    UFTRACE_EXIT,
>+    UFTRACE_LOST,
>+    UFTRACE_EVENT
>+} UftraceRecordType;
>+
> static struct qemu_plugin_scoreboard *score;
> static CpuOps arch_ops;
> 
>+static uint64_t gettime_ns(void)
>+{
>+#ifdef _WIN32
>+    /*
>+     * On Windows, timespec_get is available only with UCRT, but not with
>+     * MinGW64 environment. Simplify by using only gettimeofday on this
>+     * platform. This may result in a precision loss.
>+     */
>+    struct timeval tv;
>+    gettimeofday(&tv, NULL);
>+    uint64_t now_ns = tv.tv_sec * NANOSECONDS_PER_SECOND + tv.tv_usec * 1000;
>+#else
>+    /* We need nanosecond precision for short lived functions. */
>+    struct timespec ts;
>+    timespec_get(&ts, TIME_UTC);
>+    uint64_t now_ns = ts.tv_sec * NANOSECONDS_PER_SECOND + ts.tv_nsec;
>+#endif
>+    return now_ns;
>+}
>+
> static Callstack *callstack_new(void)
> {
>     Callstack *cs = g_new0(Callstack, 1);
>@@ -112,6 +159,85 @@ static CallstackEntry callstack_pop(Callstack *cs)
>     return e;
> }
> 
>+static Trace *trace_new(uint32_t id, GString *name)
>+{
>+    Trace *t = g_new0(Trace, 1);
>+    t->t = g_array_new(false, false, sizeof(UftraceEntry));
>+    t->path = g_string_new(NULL);
>+    g_string_append_printf(t->path, "./uftrace.data/%"PRIu32".dat", id);
>+    t->name = g_string_new(name->str);
>+    t->id = id;
>+    return t;
>+}
>+
>+static void trace_free(Trace *t)
>+{
>+    g_assert(t->t->len == 0);
>+    g_array_free(t->t, true);
>+    t->t = NULL;
>+    g_string_free(t->path, true);
>+    t->path = NULL;
>+    g_string_free(t->name, true);
>+    t->name = NULL;
>+    g_free(t);
>+}
>+
>+static void trace_flush(Trace *t, bool append)
>+{
>+    int create_dir = g_mkdir_with_parents("./uftrace.data",
>+                                          S_IRWXU | S_IRWXG | S_IRWXO);
>+    g_assert(create_dir == 0);
>+    FILE *dat = fopen(t->path->str, append ? "a" : "w");
>+    g_assert(dat);
>+    GArray *data = t->t;
>+    if (data->len) {
>+        fwrite(data->data, data->len, sizeof(UftraceEntry), dat);

fwrite might not write all bytes, how about using the 
g_file_set_contents() wrapper?

>+    }
>+    fclose(dat);
>+    g_array_set_size(data, 0);
>+}
>+
>+static void trace_add_entry(Trace *t, uint64_t timestamp, uint64_t pc,
>+                            size_t depth, UftraceRecordType type)
>+{
>+    /* libmcount/record.c:record_event */
>+    const uint64_t record_magic = 0x5;
>+    uint64_t data = type | record_magic << 3;
>+    data += depth << 6;
>+    data += pc << 16;
>+    UftraceEntry e = {.timestamp = timestamp, .data = data};
>+    g_array_append_val(t->t, e);
>+    if (t->t->len * sizeof(UftraceEntry) > 32 * MiB) {
>+        trace_flush(t, true);
>+    }
>+}
>+
>+static void trace_enter_function(Trace *t, uint64_t timestamp,
>+                                 uint64_t pc, size_t depth)
>+{
>+    trace_add_entry(t, timestamp, pc, depth, UFTRACE_ENTRY);
>+}
>+
>+static void trace_exit_function(Trace *t, uint64_t timestamp,
>+                                uint64_t pc, size_t depth)
>+{
>+    trace_add_entry(t, timestamp, pc, depth, UFTRACE_EXIT);
>+}
>+
>+static void trace_enter_stack(Trace *t, Callstack *cs, uint64_t timestamp)
>+{
>+    for (size_t depth = 1; depth <= callstack_depth(cs); ++depth) {
>+        trace_enter_function(t, timestamp, callstack_at(cs, depth)->pc, depth);
>+    }
>+}
>+
>+static void trace_exit_stack(Trace *t, Callstack *cs, uint64_t timestamp)
>+{
>+    for (size_t depth = callstack_depth(cs); depth > 0; --depth) {
>+        trace_exit_function(t, timestamp, callstack_at(cs, depth)->pc, depth);
>+    }
>+}
>+
> static uint64_t cpu_read_register64(Cpu *cpu, struct qemu_plugin_register *reg)
> {
>     GByteArray *buf = cpu->buf;
>@@ -223,7 +349,9 @@ static void track_callstack(unsigned int cpu_index, void *udata)
> {
>     uint64_t pc = (uintptr_t) udata;
>     Cpu *cpu = qemu_plugin_scoreboard_find(score, cpu_index);
>+    uint64_t timestamp = gettime_ns();
>     Callstack *cs = cpu->cs;
>+    Trace *t = cpu->trace;
> 
>     uint64_t fp = cpu->ops.get_frame_pointer(cpu);
>     if (!fp && callstack_empty(cs)) {
>@@ -232,6 +360,7 @@ static void track_callstack(unsigned int cpu_index, void *udata)
>          * long as a proper call does not happen.
>          */
>         callstack_push(cs, (CallstackEntry){.frame_pointer = fp, .pc = pc});
>+        trace_enter_function(t, timestamp, pc, callstack_depth(cs));
>         return;
>     }
> 
>@@ -244,7 +373,8 @@ static void track_callstack(unsigned int cpu_index, void *udata)
>     CallstackEntry caller = callstack_caller(cs);
>     if (fp == caller.frame_pointer) {
>         /* return */
>-        callstack_pop(cs);
>+        CallstackEntry e = callstack_pop(cs);
>+        trace_exit_function(t, timestamp, e.pc, callstack_depth(cs));
>         return;
>     }
> 
>@@ -252,12 +382,16 @@ static void track_callstack(unsigned int cpu_index, void *udata)
>     if (caller_fp == top.frame_pointer) {
>         /* call */
>         callstack_push(cs, (CallstackEntry){.frame_pointer = fp, .pc = pc});
>+        trace_enter_function(t, timestamp, pc, callstack_depth(cs));
>         return;
>     }
> 
>     /* discontinuity, exit current stack and unwind new one */
>+    trace_exit_stack(t, cs, timestamp);
>     callstack_clear(cs);
>+
>     cpu_unwind_stack(cpu, fp, pc);
>+    trace_enter_stack(t, cs, timestamp);
> }
> 
> static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>@@ -296,6 +430,16 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
>     cpu->ops.init(cpu);
>     cpu->buf = g_byte_array_new();
> 
>+    g_assert(vcpu_index < UINT32_MAX / 100);
>+    /* trace_id is: cpu_number * 100 */
>+    uint32_t trace_id = (vcpu_index + 1) * 100;
>+
>+    g_autoptr(GString) trace_name = g_string_new(NULL);
>+    g_string_append_printf(trace_name, "cpu%u", vcpu_index);
>+    cpu->trace = trace_new(trace_id, trace_name);
>+    /* create/truncate trace file */
>+    trace_flush(cpu->trace, false);
>+
>     cpu->cs = callstack_new();
> }
> 
>@@ -304,6 +448,7 @@ static void vcpu_end(unsigned int vcpu_index)
>     Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
>     g_byte_array_free(cpu->buf, true);
> 
>+    trace_free(cpu->trace);
>     callstack_free(cpu->cs);
>     memset(cpu, 0, sizeof(Cpu));
> }
>@@ -311,6 +456,8 @@ static void vcpu_end(unsigned int vcpu_index)
> static void at_exit(qemu_plugin_id_t id, void *data)
> {
>     for (size_t i = 0; i < qemu_plugin_num_vcpus(); ++i) {
>+        Cpu *cpu = qemu_plugin_scoreboard_find(score, i);
>+        trace_flush(cpu->trace, true);
>         vcpu_end(i);
>     }
> 
>-- 
>2.47.2
>

Looks good overall.


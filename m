Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A37C982C1
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Zrz-0001JZ-6u; Tue, 15 Sep 2026 16:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6Zrx-0001Iq-Ev
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:35:09 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6Zrv-0005bU-GK
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:35:09 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4843c3ee4cfso68924f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 13:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789504506; x=1790109306; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9U6r6zduGROyZttH41usMCNKKJFsk0T5lUOSw3Zwo2M=;
 b=d5f6scyDt6YmTKhIB4dYOlTlM+MLYuuWhIu3xO3zzs8QEFgKSsWPu+hxsZRj0/9VP5
 3n8SgMLPU76QSfni4rsIkXFsi9ksDEKBX557Mg+TCmylhEYbsN50n6tJEjNDALnp0t/V
 QpdhZoPVj+XMFJNF54/Jbx2yHQVUGiK/c+7TU3IEQMT0ZiBcPW7PApAtPT2mv8rWiPZA
 wkBJSMQK45qSsT9EfIEkk77yZJcGwZ5n7IVTMaKmkR+YiSuoUkaamFLoRV3SWOvAQNSt
 jysTy6uXpQYvGZakfC0d/O4hrmzlm/tMrgVhFO65fXlAfaXBZM5o1V/yjPxneKF5e/Oy
 GGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789504506; x=1790109306;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9U6r6zduGROyZttH41usMCNKKJFsk0T5lUOSw3Zwo2M=;
 b=DWnsEE8z7STE1ue3whroBlEQgFfZDfoHcxKmrqIJqrViqnx3hinkJLXmBWkxt87lON
 lFelSDW8bq5rucarQJoNQxeox1iIlN5ZNAeITaKPcRrvPyvG5ngy3NCP80DPAJ1Ryjep
 haQfR7/XceTYM3NyfORZv8GBoNdJv8ooEFU0T9riDmpsldgWSsjpUrOesF0ZNiMPTA+j
 KZ1SrG0QOte4PS698etwE2Zh48p9mPNsKfNXu5/l9C/LZWUbjvyBuA6lA8cCKK8L1MwB
 1hq61t0dsxfiNbqbWDhKC73qAVx2t5QKwsgvsc1Fb6MBDpO+7HBZTpS5RZPeB6j11Lo5
 XbsA==
X-Gm-Message-State: AFuF++nfP4QTkYs3JZiN2mXNjiKn/QLDmj6OUH0jZI3tzai2mFVwues8
 mx4OxbQ5pDt/zwffvco9666heCYGB+wjgrMcelE6WRLI5r3giobhNsz7Di4SDavZMazW8hfjvQL
 quVWp
X-Gm-Gg: AYBFou1Uo0//B3ClOhWTfk902B2Ay6oWHyKkZ8weNieBzU/8jCn00aw2Zlm+DkTwlVM
 krsE/QYpbheGb+dWoEeHCJ3MzwLek3JI08AShecZGzzBryk8x9PkB1pzI+1nFnBBQeuyP7UBVXR
 gnS2j0czwdusCqsIMVNyEqfXVlN8XpgstVMVITiRPCndPCt3qPGjVQTyk/YsifVpjX1B31ChWJ0
 Mmvowk38Xal9gL5Zoa1URLKYWH6+bq4xs9VqAgsroQoaGQLUMFMW3A+EFAw6OXn+PJ12hiykVWw
 ywxIvC+ezxA9FnPc1wKMTrtzioVT7yTBFRX0cWfrn/3uQfW31kOqVQDEHaEUtkQAhTAPeHZiJaP
 w9zsJGVhgDfWYKlJT+MdV+PvZFOAkjT5u2VncjR7K1X+5sZU74wMdwsPYziNMB58D3P8SLylOLA
 MEqwYl5JIP1g1ijEEA4Gd1kgi2GPUznZUxYX21FxFEc2FNJ/Ku/1Obr+KOZzYkN0V2ImwL
X-Received: by 2002:a05:6000:644:b0:487:4ba:97f2 with SMTP id
 ffacd0b85a97d-4870cf27ad0mr155723f8f.3.1789504506078; 
 Tue, 15 Sep 2026 13:35:06 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:f0fe:c7ed:403d:e487])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf37e69sm1504073f8f.29.2026.09.15.13.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:35:04 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 04/10] oslib: report kernel stacks in qemu_thread_states()
Date: Tue, 15 Sep 2026 22:34:48 +0200
Message-ID: <20260915203455.580999-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915203455.580999-1-den@openvz.org>
References: <20260915203455.580999-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=den@openvz.org; helo=mail-wr2-x10.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Denis V. Lunev <den@openvz.org>

A wait channel names the primitive a thread is parked on but not the
path that got it there, and for a thread wedged in a syscall that path
is the answer.

Read /proc/tid/stack when the report is built, and keep the wait
channel for when it cannot be. The file is restricted to CAP_SYS_ADMIN
in the init namespace, so ask once rather than failing per thread, and
say why the report came back thinner. Skip a running thread, which has
no settled stack to unwind, and cap the frames, because the deep end of
a stack is rarely the part that explains the hang.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Cc: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 include/qemu/osdep.h |  4 ++--
 util/oslib-posix.c   | 52 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 8039bf91b8..c15ffd7880 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -672,8 +672,8 @@ bool qemu_debugger_attached(void);
  *
  * Returns a newly allocated, newline terminated description of every thread
  * in this process apart from the caller: its id, name, scheduler state and
- * the wait channel it is parked on, or NULL on a host that cannot report any
- * of that.
+ * kernel stack, or NULL on a host that cannot report any of that. Where the
+ * kernel stack is privileged the description falls back to a wait channel.
  */
 char *qemu_thread_states(void);
 
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 79887d370c..6a683b849e 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -145,13 +145,39 @@ static char *read_task_file(const char *tid, const char *name)
     return buf;
 }
 
+#define THREAD_STACK_FRAMES 12
+
+/*
+ * /proc/tid/stack is restricted to CAP_SYS_ADMIN in the init namespace, so
+ * ask once instead of failing per thread, and say why the report is thinner.
+ */
+static bool thread_stacks_readable(void)
+{
+    static int readable = -1;
+    g_autofree char *path = NULL;
+    g_autofree char *buf = NULL;
+
+    if (readable >= 0) {
+        return readable;
+    }
+    path = g_strdup_printf("/proc/self/task/%d/stack", qemu_get_thread_id());
+    readable = g_file_get_contents(path, &buf, NULL, NULL);
+    if (!readable) {
+        warn_report("kernel stacks need CAP_SYS_ADMIN, falling back to wchan");
+    }
+    return readable;
+}
+
 static void append_thread_state(GString *out, const char *tid)
 {
     g_autofree char *comm = read_task_file(tid, "comm");
     g_autofree char *stat = NULL;
+    g_autofree char *stack = NULL;
     g_autofree char *wchan = NULL;
+    g_auto(GStrv) lines = NULL;
     char state = '?';
     char *rparen;
+    int i;
 
     if (!comm) {
         return;
@@ -168,9 +194,26 @@ static void append_thread_state(GString *out, const char *tid)
     }
     g_string_append_printf(out, "  %-7s %-16s %c\n", tid, comm, state);
 
-    wchan = read_task_file(tid, "wchan");
-    if (wchan && wchan[0]) {
-        g_string_append_printf(out, "      wchan %s\n", wchan);
+    /* A running thread has no settled kernel stack to unwind */
+    if (state != 'R' && thread_stacks_readable()) {
+        stack = read_task_file(tid, "stack");
+    }
+    if (!stack) {
+        wchan = read_task_file(tid, "wchan");
+        if (wchan && wchan[0]) {
+            g_string_append_printf(out, "      wchan %s\n", wchan);
+        }
+        return;
+    }
+
+    lines = g_strsplit(stack, "\n", 0);
+    for (i = 0; i < THREAD_STACK_FRAMES && lines[i]; i++) {
+        if (lines[i][0]) {
+            g_string_append_printf(out, "      %s\n", lines[i]);
+        }
+    }
+    if (lines[i]) {
+        g_string_append(out, "      ...\n");
     }
 }
 
@@ -183,6 +226,9 @@ char *qemu_thread_states(void)
     if (!dir) {
         return NULL;
     }
+    /* Emit the permission notice ahead of the listing, not inside it */
+    thread_stacks_readable();
+
     out = g_string_new(NULL);
     while ((tid = g_dir_read_name(dir))) {
         if (atoi(tid) != qemu_get_thread_id()) {
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B731CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzxQ-0001lQ-WC; Fri, 15 May 2026 17:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxO-0001dS-F4
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:30 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxM-00031c-J3
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:30 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7de44ed7a11so383342a34.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880027; x=1779484827;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5nC4k4a0OZgulCg4sth3HQUSa5b3mq9IfQPexGkN1x4=;
 b=iLRI9APrHrY45pz25xE6EK1E17P5dZGjkwZylQcN7636gQ8KDhUUG3svVOCKs9VGIK
 sB7Ujq87tZ+P+jluw5w+rWisCb5CF7zR7LCWAh54zPt4pl+Qb1eWqQTAWZAtTJxjMQw5
 2nf1+Q2D7Uh2vwlQXW/tQXPvVSyAax8DTFTmkJbeRWzKQCrICrQ8SyDwD4R15kH6h5+j
 XxGiR+MROYVoBWBrdzSxIgtQx+kpu9+C1r44phzVRF4P2HrkEAFqVcN+iLxF0LuAOLUo
 GAgPwDZuslS9pTNi/eduDq8hSaFHyTgqF3IIdZdc821FsnDbJ7gubTRIQobLmFx1kExK
 8sHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880027; x=1779484827;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5nC4k4a0OZgulCg4sth3HQUSa5b3mq9IfQPexGkN1x4=;
 b=Gxb+2i7hoi8gXw8WpYtoByIFGrUgXO3Q66EqB/ma++yEnNWulcXrbBRl2r0hT83GP5
 CANz1kTVEHz/WejJjpuoGsUmbrbf2cj0bVHskLQuKT3qLEV1d/EYa+biWVngwNnEu0RT
 vkwfGMBbaUl/T9zpYxVL1bC0TIwNiD8j4QayJdbi9Kgrj24KtN+kaOVruTd7O3eYjPHy
 JFNlGbSgYOMgxZwyaAC6g4YFLnpWoTSFeFhojW5+0WjSMsvzzTwzv7r5bjcW9NAyCWqo
 2smMN4KHa6mS4vr+B/a+/W3C0IeTJCGb72O7eWtu95jSdRGeZa+nmQgjJyFKH0be547p
 vJtQ==
X-Gm-Message-State: AOJu0YxCFXWxSgzcjyxjZpiF9CE+G7GcCXb5eURTyjTji6LNjF+Txub7
 hmUQZG04UtSYslg6tt4nfCQtw3hCZSozMozwQzkPk55FlN9eFBrDeMrWnO1VQ3iM5Ag=
X-Gm-Gg: Acq92OETlAGE6QhbIRsbtDs++CrNq2ol9TQmZsJsC/hcsa6JGxycoDLLbua3/x8FvX4
 pkx/Fq0CY5acVzaeXHe7dnAbhQeTVUeqGHV30o0WcR2SO8yG40pyXBbKnPzS9zS+LRp2cjpPnqI
 B2QX8LGTG2/1iQAEpAHYUN9jJbxkhHK+U3pXOZeG+S4zuS0Hm2xq6wKdkN69Pzt+BUVh63QDvNQ
 rhT5PsoVAI/gstClt4C8Ej9l5Midip7Xe0n0iQ2ijtn/4bDtsQPcjGoVNHBu6j4vZPXl3c3v1Mb
 D7YZNF4U2vX8lvI847L9xl6KYq2kWy7MXjxSfkeRTInPaF2b5tbdQSDal0CRcF6sKxFa/SckYL7
 AN+aSa6BBKYxLXU26M2nJhBKmYY1ky1iqN4mj+Aj5lAsGonsC0HAbCGa3rkwm2XjfdkdnTbe9C/
 myRf6TN5wqKU2PjN8Ci2pk
X-Received: by 2002:a05:6830:82b6:b0:7dc:cb67:cb67 with SMTP id
 46e09a7af769-7e4ea04cc70mr4179072a34.5.1778880027499; 
 Fri, 15 May 2026 14:20:27 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:27 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:24 -0600
Subject: [PATCH 25/66] bsd-user: Add cpu_copy and make init_task_state
 non-static
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-25-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2949; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=zAas4XPKJk5ZjTPrSwO0wWkCzVH0W2AWkE5I1mEiKz8=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43k/W5DaNHkDb/MsZRwrtuv/wsTLJzK/nv12
 J2I/EWAICKJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5AAKCRBsHNEofbAR
 ALTyD/9aNj4SU4srcg/MBWBe05Y338t0AHC5dWRYCaPeQUuqPXl8MM9t1HIBFRtFRQP4kKHujge
 jQs8hL0h1tphPz77+G8ocf8JklARh/cV55VWQFP331GlFcsimtqwhsvzsaSEZqvw5xRPQr7tD8N
 kFI4P61y77Xe2iFkzH45dIL03YwP8vNyw/jPH+07Q1diVRQYqYPK0kEzkn6WNrNVD2capCenL2I
 1o/wTjpkNbd6zPIiPycfbajAjVpWGmHCqA2YGdOtc3qI7ctGKFex5mWEjmYM48iUU2j++n607uo
 D2gv8c3PqlzFPN1KXETF7rfNckyEIMxgFeDsOoSeTR8/sGS/R2WfCOhWhn8Ypa8PvqUrHv5O8kL
 TWwqFaBdgofebrk0TxGNbzLsafq9qHQobPDApaA5ViHbjxvqhjxjfcRaONc28r+FixrdAT1j+Ep
 7qvlA/SsQwXA4HcOf0qeRXi+6mP9N5aYyxDOamG5ilsZlpLrptizkDz+hOkTBIWiGvP35HeaDtF
 oVX6uvvrtofcGTQlXUWzHGv9O2+NLelq3xlr8h6SgpIrSeZOFC3wha/d2uiqlz0lEC/1TIUOdlE
 QeexLM3c7mAFikmL1+ta3Rr2o0XSTqFOHHA8GsP4CGcbwZSBfPRSy2bibotu/xuGok6LKbIFmn7
 9ZLzsP+nl2ix7AA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::334;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x334.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add cpu_copy() function for thread creation support and make
init_task_state() non-static so it can be called from os-thread.c.
Move cpu_type to file scope so cpu_copy() can access it.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/main.c | 37 +++++++++++++++++++++++++++++++++++--
 bsd-user/qemu.h |  1 +
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 73aae8c327..415852d88a 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -49,6 +49,7 @@
 #include "qemu/guest-random.h"
 #include "gdbstub/user.h"
 #include "exec/page-vary.h"
+#include "exec/watchpoint.h"
 
 #include "host-os.h"
 #include "target_arch_cpu.h"
@@ -215,7 +216,7 @@ bool qemu_cpu_is_self(CPUState *cpu)
 }
 
 /* Assumes contents are already zeroed.  */
-static void init_task_state(TaskState *ts)
+void init_task_state(TaskState *ts)
 {
     ts->sigaltstack_used = (struct target_sigaltstack) {
         .ss_sp = 0,
@@ -224,6 +225,39 @@ static void init_task_state(TaskState *ts)
     };
 }
 
+static const char *cpu_type;
+
+CPUArchState *cpu_copy(CPUArchState *env)
+{
+    CPUState *cpu = env_cpu(env);
+    CPUState *new_cpu = cpu_create(cpu_type);
+    CPUArchState *new_env = cpu_env(new_cpu);
+    CPUBreakpoint *bp;
+    CPUWatchpoint *wp;
+
+    /* Reset non arch specific state */
+    cpu_reset(new_cpu);
+
+    new_cpu->tcg_cflags = cpu->tcg_cflags;
+    memcpy(new_env, env, sizeof(CPUArchState));
+
+    /*
+     * Clone all break/watchpoints.
+     * Note: Once we support ptrace with hw-debug register access, make sure
+     * BP_CPU break/watchpoints are handled correctly on clone.
+     */
+    QTAILQ_INIT(&cpu->breakpoints);
+    QTAILQ_INIT(&cpu->watchpoints);
+    QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
+        cpu_breakpoint_insert(new_cpu, bp->pc, bp->flags, NULL);
+    }
+    QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
+        cpu_watchpoint_insert(new_cpu, wp->vaddr, wp->len, wp->flags, NULL);
+    }
+
+    return new_env;
+}
+
 static QemuPluginList plugins = QTAILQ_HEAD_INITIALIZER(plugins);
 
 void gemu_log(const char *fmt, ...)
@@ -256,7 +290,6 @@ int main(int argc, char **argv)
 {
     const char *filename;
     const char *cpu_model;
-    const char *cpu_type;
     const char *log_file = NULL;
     const char *log_mask = NULL;
     const char *seed_optarg = NULL;
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 069baa7011..d2dd8c2ee8 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -122,6 +122,7 @@ struct TaskState {
     struct target_sigaltstack sigaltstack_used;
 } __attribute__((aligned(16)));
 
+void init_task_state(TaskState *ts);
 void stop_all_tasks(void);
 extern const char *interp_prefix;
 extern const char *qemu_uname_release;

-- 
2.52.0



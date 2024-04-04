Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438F9CD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 19:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsT4U-0006YB-7s; Thu, 04 Apr 2024 15:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsT4R-0006Xp-QG
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 15:48:24 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsT4O-0000K9-PQ
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 15:48:22 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2d094bc2244so14731261fa.1
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 12:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712260098; x=1712864898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KWGr/pVGop5k8ihIK6m+XFrYPybC/J9z+nBHWQ3TWxc=;
 b=dyrASMkKpaNbnYIPK66FFfz4w0qE8KFVd4afCNaF5lxfPeHcsMJHIUodLXA8d147fD
 w1e8Dlio/9oq+pfaR05NgSu0CuX4lPlcRKrjlgnVWDS7HevGUD+6sC3XGB0K/R9cTH2X
 ewC4j5Rgebcsjs9YxTRLIBNxvxsyC1HT9TH+4OfS4F0xFeFcHKcOrQMcrrqlaQ4mfvqP
 vwDBEWhTzZdYdMiyaMdfUo1Da1z71xrkcBGVM2KwIMGsacMmwkAPWyPm4dHgLOQRas6z
 meb7qSzarjut9WKAixVeTtllW/+5olXUQnPxSgBtCEXjQeBBWSxVXiKJM7wbwGmbLIqu
 VBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712260098; x=1712864898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KWGr/pVGop5k8ihIK6m+XFrYPybC/J9z+nBHWQ3TWxc=;
 b=pwOyCjgvoN3bqNvcbQXns+iB3p07rmVTqgMqhg0Z7RYyoul5gfsrUrouaLPwR5Gc0D
 sMG2NuPLediuHMzZUS/GP/u2DQsRKBoHxOFoy55NqZPK0LMpKcwt3YtZBdOi88RExk/U
 XUsiikDhgJqUSO2EVOe0m9jIl405xeY+wNoyqiHj5a+s5HugFHGXCB8SuabU17iOn6ZU
 SP2YDgjVTilWTLvPwTQnVg0ThViClDmVGsbF97m9gFr/9KqFLlhDO3dUZtn+yeQTNQFJ
 d6W/prWOpcbJJF3vuW/xjfj3/eKBpO02PfZBA7v+qGQcvXfREamOgRVhG/rWcgr1H+j+
 lQUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2nGpK/+Vbs2W0RSXOuoz6jD1TWJGvwGy9KM8plI0ZjR+70tWf+DuP2kzxLFdQ160PivJyXr96432OCErD9a9jitzBt+w=
X-Gm-Message-State: AOJu0Yw1JlnN2nfMOtO/NZi2xX+Nh9uj2RbkZiPXiMrtUMThbKgCH83J
 /biOBGmIOx4cSSF6e8p5Ra+6YKZueupZjhO1DwyLqGSvVFR1JIFX6XRqL+TJv6E=
X-Google-Smtp-Source: AGHT+IHzMWMi1KznhGLPn6i21HeMbwPw3oZBDTNnM4bNZfJjp9kAgM+B0XU4NgGgLB2oPt5Vrnxzxg==
X-Received: by 2002:a2e:9f44:0:b0:2d8:34ec:54e6 with SMTP id
 v4-20020a2e9f44000000b002d834ec54e6mr218442ljk.33.1712260098101; 
 Thu, 04 Apr 2024 12:48:18 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.216.111])
 by smtp.gmail.com with ESMTPSA id
 fs20-20020a05600c3f9400b0041628f694dfsm240457wmb.23.2024.04.04.12.48.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 04 Apr 2024 12:48:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH-for-9.1 3/7] monitor: Rework stubs to simplify user emulation
 linking
Date: Thu,  4 Apr 2024 21:47:53 +0200
Message-ID: <20240404194757.9343-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240404194757.9343-1-philmd@linaro.org>
References: <20240404194757.9343-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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

Currently monitor stubs are scattered in 3 files.

Merge these stubs in 2 files, a generic one (monitor-core)
included in all builds (in particular user emulation), and
a less generic one to be included by tools and system emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 stubs/fdset.c        | 17 -----------------
 stubs/monitor-core.c | 20 +++++++++++++++-----
 stubs/monitor.c      |  8 ++++++--
 stubs/meson.build    |  5 +++--
 4 files changed, 24 insertions(+), 26 deletions(-)
 delete mode 100644 stubs/fdset.c

diff --git a/stubs/fdset.c b/stubs/fdset.c
deleted file mode 100644
index 56b3663d58..0000000000
--- a/stubs/fdset.c
+++ /dev/null
@@ -1,17 +0,0 @@
-#include "qemu/osdep.h"
-#include "monitor/monitor.h"
-
-int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags)
-{
-    errno = ENOSYS;
-    return -1;
-}
-
-int64_t monitor_fdset_dup_fd_find(int dup_fd)
-{
-    return -1;
-}
-
-void monitor_fdset_dup_fd_remove(int dupfd)
-{
-}
diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
index afa477aae6..72e40bcc15 100644
--- a/stubs/monitor-core.c
+++ b/stubs/monitor-core.c
@@ -1,6 +1,7 @@
+/* Monitor stub required for user emulation */
 #include "qemu/osdep.h"
 #include "monitor/monitor.h"
-#include "qapi/qapi-emit-events.h"
+#include "../monitor/monitor-internal.h"
 
 Monitor *monitor_cur(void)
 {
@@ -12,11 +13,22 @@ Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
     return NULL;
 }
 
-void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
+int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags)
+{
+    errno = ENOSYS;
+    return -1;
+}
+
+int64_t monitor_fdset_dup_fd_find(int dup_fd)
+{
+    return -1;
+}
+
+void monitor_fdset_dup_fd_remove(int dupfd)
 {
 }
 
-void qapi_event_emit(QAPIEvent event, QDict *qdict)
+void monitor_fdsets_cleanup(void)
 {
 }
 
@@ -24,5 +36,3 @@ int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
 {
     abort();
 }
-
-
diff --git a/stubs/monitor.c b/stubs/monitor.c
index 20786ac4ff..2fc4dc1493 100644
--- a/stubs/monitor.c
+++ b/stubs/monitor.c
@@ -1,7 +1,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-emit-events.h"
 #include "monitor/monitor.h"
-#include "../monitor/monitor-internal.h"
 
 int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
 {
@@ -13,6 +13,10 @@ void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
 {
 }
 
-void monitor_fdsets_cleanup(void)
+void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
+{
+}
+
+void qapi_event_emit(QAPIEvent event, QDict *qdict)
 {
 }
diff --git a/stubs/meson.build b/stubs/meson.build
index 0bf25e6ca5..ca1bc07d30 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -10,7 +10,6 @@ stub_ss.add(files('qemu-timer-notify-cb.c'))
 stub_ss.add(files('icount.c'))
 stub_ss.add(files('dump.c'))
 stub_ss.add(files('error-printf.c'))
-stub_ss.add(files('fdset.c'))
 stub_ss.add(files('gdbstub.c'))
 stub_ss.add(files('get-vm-name.c'))
 stub_ss.add(files('graph-lock.c'))
@@ -28,7 +27,9 @@ if libaio.found()
 endif
 stub_ss.add(files('migr-blocker.c'))
 stub_ss.add(files('module-opts.c'))
-stub_ss.add(files('monitor.c'))
+if have_system or have_tools
+  stub_ss.add(files('monitor.c'))
+endif
 stub_ss.add(files('monitor-core.c'))
 stub_ss.add(files('physmem.c'))
 stub_ss.add(files('qemu-timer-notify-cb.c'))
-- 
2.41.0



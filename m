Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C02BEE6B43
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQDF-0008RL-H8; Fri, 06 Feb 2026 13:05:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1voQCu-0007zk-1U
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:05:28 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1voQCs-0001SH-Ga
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:05:27 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b883787268fso149155266b.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 10:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770401125; x=1771005925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qwXkUMwHAuqjDWUozerEk2bUCL3Vv3f1bbvZHeOQq6U=;
 b=yK+V51caqeXUIUNLtbLMK2xdnCj/LWZ0D3miERSZ7oItp9glqLZ1Dqc1+tuHh+6gQs
 nG9g4iK/rEA9DwSamxQl+QpCK80EnNkvSWuLpzgRkCx7y/20/UgVQBZFkjda9Co9hGY6
 xgioqjznVMEM2SFA4Jeqg0C+Q0uZpFTWkL/zIaEe1DcXcIGxXIjDTM8ScRwgE4Q2zjuM
 MTrb+fYALzzz+T/IhnvFzRhh3rAgjca2rSRPA4LIntiV/97koCl4DJqqc6KeG6G0LsyG
 6aMVCwjcOOkIGsu3eaiEHXnMiq76mDXXtdDIANIo1A8wvSlefH5D4VlRw9rmYa/hTyk9
 Nl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770401125; x=1771005925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qwXkUMwHAuqjDWUozerEk2bUCL3Vv3f1bbvZHeOQq6U=;
 b=CWG2BY0eghJIM7FdJH4NXEuf6LcIAqOQ0oNvXt3eeQg5mSmfk9i5Ukx0JwhcN2Bky2
 zqln03lI+1FhTSY6d+b3vDwuwc38V8+QbB3PB1bF+znPon8jmiWxQ9HKpioQtTYq9NOy
 Z37ohvEhh4NtMUScaL9vkpKK+EPoTO3qkO/4d39avZQ2C56y8aFs4xeXLN27rjNounib
 D/tAyZ4prhdKQfjSIkdhCPcjATxqUbj5JRLiF2aWjEVRNGsjrw549qUuAjv1cNAuVpUW
 tTJrpTi7hOrjjg100yyqHzJZJy7D7sTdnayKn8IbFSDo3xP68/5UjAHHtCwq9oCiw4vu
 uJiA==
X-Gm-Message-State: AOJu0YwV58d2ic41qYRScd0szVxboSvcTZhq7KH2sqoTibNC/eW2pied
 rMZ3V3QefpwB8krxa62Hc3C/eSGjddYfc3uC/a7WfctpnK+F+Zyk8/urZWf/resmnP6FBUGf9tK
 1I4jfmW4=
X-Gm-Gg: AZuq6aJoEJnJB6WNaIIwGH49aE+xlk1W5uZCML/+Z6kpXBZMozv/oGzRQmksYyKCvqi
 haPbXldJKPrgu3IUMEJ5rnBD5BOSNIm963ubhLdkBOgKxGayNevnAdA5p/o5tnXWS+phHNkXVia
 x/sZAWZNHP2ZauUilGlMPTOyCndpSNY1wnvyy7cgrS9WG7hYFf1Cf2RYwXlapDRrGHuM4tl8P/R
 FB45WOr+BDE7eBxoZQ+sGzEc7jw1n1iCksIDvKihm5kZtBy4Qz25OE2hjTN9siSFxFlWdWdsHtG
 fwtzCQz8i0hHNVQJFJesQFXmvpBTS7RbaGV0DZx7B0jvv/JSjMo+PHebEDz1lUaRgXPL1fb+RS/
 qAMoHKIku50KCAJ9YX19JcMnnEEeDtaIDqqT1bzQbXnOoYC6nmUh9ZvhlXcYd5i3Y2Wbma6G2FG
 T8/MhV0kPJigs=
X-Received: by 2002:a17:907:e110:b0:b88:48ba:cdd with SMTP id
 a640c23a62f3a-b8edf33e446mr147145966b.43.1770401124674; 
 Fri, 06 Feb 2026 10:05:24 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8edae3ae99sm102879666b.60.2026.02.06.10.05.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 10:05:21 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AC8EE60804;
 Fri, 06 Feb 2026 18:05:18 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/10] gdbstub/user: rename and use bool for running_state
Date: Fri,  6 Feb 2026 18:05:17 +0000
Message-ID: <20260206180517.1335861-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206180517.1335861-1-alex.bennee@linaro.org>
References: <20260206180517.1335861-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

This is just a clean-up to document what we using the running variable
for in user-mode.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260203115201.2387721-12-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/gdbstub/user.c b/gdbstub/user.c
index a16f37616b1..97eb13e796a 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -87,7 +87,11 @@ enum GDBForkMessage {
 typedef struct {
     int fd;
     char *socket_path;
-    int running_state;
+    /*
+     * running state of the guest, when we process a packet that restarts
+     * the guest we set this to true.
+     */
+    bool running;
     /*
      * Store syscalls mask without memory allocation in order to avoid
      * implementing synchronization.
@@ -241,8 +245,8 @@ int gdb_handlesig(CPUState *cpu, int sig, const char *reason, void *siginfo,
 
     sig = 0;
     gdbserver_state.state = RS_IDLE;
-    gdbserver_user_state.running_state = 0;
-    while (gdbserver_user_state.running_state == 0) {
+    gdbserver_user_state.running = false;
+    while (!gdbserver_user_state.running) {
         char buf[256];
         int n = read(gdbserver_user_state.fd, buf, 256);
         if (n > 0) {
@@ -611,11 +615,11 @@ void gdbserver_fork_end(CPUState *cpu, pid_t pid)
 
     gdbserver_state.state = RS_IDLE;
     gdbserver_state.allow_stop_reply = false;
-    gdbserver_user_state.running_state = 0;
+    gdbserver_user_state.running = false;
     for (;;) {
         switch (gdbserver_user_state.fork_state) {
         case GDB_FORK_ENABLED:
-            if (gdbserver_user_state.running_state) {
+            if (gdbserver_user_state.running) {
                 close(fd);
                 return;
             }
@@ -728,7 +732,7 @@ void gdb_handle_query_attached(GArray *params, void *user_ctx)
 
 void gdb_continue(void)
 {
-    gdbserver_user_state.running_state = 1;
+    gdbserver_user_state.running = true;
     trace_gdbstub_op_continue();
 }
 
@@ -750,7 +754,7 @@ int gdb_continue_partial(char *newstates)
             cpu_single_step(cpu, gdbserver_state.sstep_flags);
         }
     }
-    gdbserver_user_state.running_state = 1;
+    gdbserver_user_state.running = true;
     return res;
 }
 
-- 
2.47.3



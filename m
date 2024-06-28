Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43AAFC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 05:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN430-0003JR-70; Fri, 28 Jun 2024 01:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sN42z-0003J9-4g
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 01:21:21 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sN42x-0008F3-CZ
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 01:21:20 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-706b539fcaeso962959b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 22:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719552077; x=1720156877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XGUVEgkOZ1Z9CgRBWiCr397XSqS24XQydg1qjtX54Dk=;
 b=XojL8uT9AorwwpFZt46x1rmnnQFHbdKTwt91GJnfO0SGAbpDzRbvrdESZzVjgVM5XH
 hMZ8MzdK26LRBDNfZgnKkHQ3rWFxAx5XvtAogqRai5DwVnDQJQf5aOUtarH+QxsApM6d
 CyDq4UQse9VUgodORjdX1cDAVH4BvVQYAgtr5yoLgjTRzSxvWt9dBX0fdzbUSkCvKcww
 ozjNlGx+ngkHsp/Lr49KfsfhrCkBWSsbFKj73LH+ItZQC+VIg0yWH5qH8GChgGKyEpwW
 pv+lWi7LlBBbKaiz9Xb4mXcbkrWIBJocKS9mN1aW3+0lH95xirq1Xnqj59UwRXlLGoxh
 TEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719552077; x=1720156877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XGUVEgkOZ1Z9CgRBWiCr397XSqS24XQydg1qjtX54Dk=;
 b=wWFlH5+KfDSmxpmoavNk2oVsBeaIUlNVTpVcRzpvceppjLnrFG2SkSOp/QfDiD9V72
 iQH999MiJXMMRcTZjHPum75wDodmRnWFJrEBWA37ZUnNSU2saOQdBllvdqehj84CvFli
 icqtnRWbOw/8TEaeLjSKuBD+TlsCVlxeXYj3LXT6k8qlTJN7OSIqKLnPl1HWBgqO3NeZ
 zDjyZe3wi282kG6vE3IkaszfKFiKf6XMFeNcsQY/3h4SSYnaFgAGxAs8jUwBXquLXiAa
 Et7fSAwg4wiQubBPCQv8rOGg7HVdHr5bakV11URj7jV1yrNQyLf6JmqyPqnuUU8rA36a
 mTmQ==
X-Gm-Message-State: AOJu0Yxy+m6vvrELqF6IRQCIUXFGSUOyFHQJC4/70hjGT6sjanwUMfD7
 cLxeVD0CIg+BGH5MxQlgi7QFicO2Ep1Jk6KnRsGKAnnq9rBXQzBniSt8dIKzAgWQNbvWkwriAAR
 d
X-Google-Smtp-Source: AGHT+IFZULnETnfSGnOWwoTK+dDuN0O484NOA+L2o9juqbeAB07d9F52kVpPr7R5az1JXc3+tfgAtg==
X-Received: by 2002:a05:6a20:3d89:b0:1bd:2aaf:4764 with SMTP id
 adf61e73a8af0-1bee47d4c9fmr1396826637.0.1719552077307; 
 Thu, 27 Jun 2024 22:21:17 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:391e:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72c6b2a16cdsm423932a12.46.2024.06.27.22.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 22:21:16 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Cc: peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v6 08/11] gdbstub: Pass CPU context to command handler
Date: Fri, 28 Jun 2024 05:08:47 +0000
Message-Id: <20240628050850.536447-9-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628050850.536447-1-gustavo.romero@linaro.org>
References: <20240628050850.536447-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x435.google.com
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

Allow passing the current CPU context to command handlers via user_ctx
when the handler requires it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 gdbstub/gdbstub.c          | 7 ++++++-
 include/gdbstub/commands.h | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index b1ca253f97..5c1612ed2a 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -938,6 +938,7 @@ static bool process_string_cmd(const char *data,
 
     for (i = 0; i < num_cmds; i++) {
         const GdbCmdParseEntry *cmd = &cmds[i];
+        void *user_ctx = NULL;
         g_assert(cmd->handler && cmd->cmd);
 
         if ((cmd->cmd_startswith && !startswith(data, cmd->cmd)) ||
@@ -952,8 +953,12 @@ static bool process_string_cmd(const char *data,
             }
         }
 
+        if (cmd->need_cpu_context) {
+            user_ctx = (void *)gdbserver_state.g_cpu;
+        }
+
         gdbserver_state.allow_stop_reply = cmd->allow_stop_reply;
-        cmd->handler(params, NULL);
+        cmd->handler(params, user_ctx);
         return true;
     }
 
diff --git a/include/gdbstub/commands.h b/include/gdbstub/commands.h
index e51f276b40..f3058f9dda 100644
--- a/include/gdbstub/commands.h
+++ b/include/gdbstub/commands.h
@@ -54,6 +54,8 @@ typedef union GdbCmdVariant {
  * "stop reply" packet. The list of commands that accept such response is
  * defined at the GDB Remote Serial Protocol documentation. See:
  * https://sourceware.org/gdb/onlinedocs/gdb/Stop-Reply-Packets.html#Stop-Reply-Packets.
+ *
+ * @need_cpu_context: Pass current CPU context to command handler via user_ctx.
  */
 typedef struct GdbCmdParseEntry {
     GdbCmdHandler handler;
@@ -61,6 +63,7 @@ typedef struct GdbCmdParseEntry {
     bool cmd_startswith;
     const char *schema;
     bool allow_stop_reply;
+    bool need_cpu_context;
 } GdbCmdParseEntry;
 
 /**
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9D0C4829E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 19:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYWre-0006qp-Fh; Fri, 09 Feb 2024 14:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rYWqi-0005Y7-GK
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 14:47:49 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rYWqc-0005Bn-LJ
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 14:47:45 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40fd2f7ef55so14305385e9.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 11:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707508061; x=1708112861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wtk9GiV3W2xXFlYcJpJzbgDy4P/9SBqVnzDNRkRcVpY=;
 b=ayRKH+ZYMpOf+Q2W/eQr7tot9IviVxXXcO1gKOimc8oZq9sL98l5D5kSExgf7RMSxz
 uPfIQYqAY01Uk0o52ozJnHwI1xLdcieGJp28p96dhpxceTtyKNJfEK9V51Z7wxpOraEN
 G/jK9XgwAyF9l01FQZkR6p6FDkcjgQSRN2li7QiVOCwDmClg0dcu23hZc6dRRBT+5zIi
 4oeYPG3LSGYcGlA81iezOwuZBCWVSvsDrEEFYV5E1jkMIKAIQHW8qmiws5t/3mKM9dyH
 672uTiBQKnzR/hw2rRBaS/u0edgK+CMSO97tWUyoLQBoQQNQQqjeAVRd1S5IcwK5tjZ4
 90+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707508061; x=1708112861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wtk9GiV3W2xXFlYcJpJzbgDy4P/9SBqVnzDNRkRcVpY=;
 b=juUgfvsxtyG+BmoPelCuEUt74A4Jzady1yswM3VBhDUuAP10cQUY4uTjPwkHosfDf9
 Zsu4F2deJEdFkqnmnvBSCsqKXSVum65tdbvzRKUwoMaQkI9f7JvJFn3d0crem4Ot+0hs
 hm3RJUQsThhhcM9AJB8yf9XMt8fgqmQYtduWzZVjbaYBYK+7jndDZ4kvHH66CTx84YBR
 v9FL1ecz06w6/X1YbC9Dm4XiEiEhSa+BsPydhoDQb9u+titp5sYTsoNA9/0qqkws+QeS
 yAdn3JA+rR8iHMfSicO4LIBddgxYIDqiX1wQXzGWt/v9aLgAoro+wGo2Qi6ZDAERLRLD
 VIVw==
X-Gm-Message-State: AOJu0YxB6hRnEVnebXORRxWPwko6/w/rDGukqRLFcV5CaRwkYUAURcnH
 1RWfLs2iZCkQHpmQAgQ6/NbF2AUpmyZJ807mAkBirq1HrFUlzFJNPiM3uTwCjYI=
X-Google-Smtp-Source: AGHT+IEtelt3B1a88RvJNO3og77wZnPg33Wflo41xWbY+TXVM9jCLSjceWWaAFkKaNqIYTlFF+6NVw==
X-Received: by 2002:a5d:67cf:0:b0:33a:eb4b:c702 with SMTP id
 n15-20020a5d67cf000000b0033aeb4bc702mr1881597wrw.3.1707508061055; 
 Fri, 09 Feb 2024 11:47:41 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV5oQwO/y1n7kDtfr4IPMQ/fwVunD2t7OHpvyurlz+5oPtWUULUQOVQikRRUXeW5j0P0j3WOAG4ypOw6tR8XHaVTWnVp8G24tDmXdKc4wWIAuRd9Ct+Fh4b4BJfHaldFq75mXQXPqaenCC4j/jb
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bq26-20020a5d5a1a000000b0033b4335dce5sm43840wrb.85.2024.02.09.11.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 11:47:37 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 755835F7D7;
 Fri,  9 Feb 2024 19:47:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>
Subject: [PULL 08/10] gdbstub: Add syscall entry/return hooks
Date: Fri,  9 Feb 2024 19:47:32 +0000
Message-Id: <20240209194734.3424785-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240209194734.3424785-1-alex.bennee@linaro.org>
References: <20240209194734.3424785-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

The upcoming syscall catchpoint support needs to get control on syscall
entry and return. Provide the necessary hooks for that, which are
no-ops for now.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240202152506.279476-4-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240207163812.3231697-13-alex.bennee@linaro.org>

diff --git a/include/gdbstub/user.h b/include/gdbstub/user.h
index 1fc43e04af5..68b6534130c 100644
--- a/include/gdbstub/user.h
+++ b/include/gdbstub/user.h
@@ -51,5 +51,18 @@ void gdb_signalled(CPUArchState *as, int sig);
  */
 void gdbserver_fork(CPUState *cs);
 
+/**
+ * gdb_syscall_entry() - inform gdb of syscall entry and yield control to it
+ * @cs: CPU
+ * @num: syscall number
+ */
+void gdb_syscall_entry(CPUState *cs, int num);
+
+/**
+ * gdb_syscall_entry() - inform gdb of syscall return and yield control to it
+ * @cs: CPU
+ * @num: syscall number
+ */
+void gdb_syscall_return(CPUState *cs, int num);
 
 #endif /* GDBSTUB_USER_H */
diff --git a/include/user/syscall-trace.h b/include/user/syscall-trace.h
index 557f881a79b..b48b2b2d0ae 100644
--- a/include/user/syscall-trace.h
+++ b/include/user/syscall-trace.h
@@ -11,6 +11,7 @@
 #define SYSCALL_TRACE_H
 
 #include "exec/user/abitypes.h"
+#include "gdbstub/user.h"
 #include "qemu/plugin.h"
 #include "trace/trace-root.h"
 
@@ -20,7 +21,7 @@
  * could potentially unify the -strace code here as well.
  */
 
-static inline void record_syscall_start(void *cpu, int num,
+static inline void record_syscall_start(CPUState *cpu, int num,
                                         abi_long arg1, abi_long arg2,
                                         abi_long arg3, abi_long arg4,
                                         abi_long arg5, abi_long arg6,
@@ -29,11 +30,13 @@ static inline void record_syscall_start(void *cpu, int num,
     qemu_plugin_vcpu_syscall(cpu, num,
                              arg1, arg2, arg3, arg4,
                              arg5, arg6, arg7, arg8);
+    gdb_syscall_entry(cpu, num);
 }
 
-static inline void record_syscall_return(void *cpu, int num, abi_long ret)
+static inline void record_syscall_return(CPUState *cpu, int num, abi_long ret)
 {
     qemu_plugin_vcpu_syscall_ret(cpu, num, ret);
+    gdb_syscall_return(cpu, num);
 }
 
 
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 63edca131ab..2ba01c17faf 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -502,3 +502,11 @@ void gdb_syscall_handling(const char *syscall_packet)
     gdb_put_packet(syscall_packet);
     gdb_handlesig(gdbserver_state.c_cpu, 0);
 }
+
+void gdb_syscall_entry(CPUState *cs, int num)
+{
+}
+
+void gdb_syscall_return(CPUState *cs, int num)
+{
+}
-- 
2.39.2



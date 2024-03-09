Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FECC5475B
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 03:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rin6f-0000tv-4Y; Fri, 08 Mar 2024 22:10:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rin6V-0000tE-VO
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 22:10:32 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rin6T-00046q-9l
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 22:10:30 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dca3951ad9so21694695ad.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 19:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709953825; x=1710558625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8tpJAfxQcRF8joD00NGmo1iAef1vo78TLl0CoONZU1s=;
 b=E9zdb/F5RetjM7U0NsLcedWnsTjdgUyqUgzVQenfdFymRscTerk46t8argR1XzRHuK
 MZNxkRSiNeSyqArjGZv+GdDrWz2QLoSv8XG48gLRgckuFyOWdUptGS1nOi/N2TAhNYml
 DUEqk4KzXH6LONL00cZPw8Cy0G6wy9daui6xcxE6ZZlD5eDlAuVa+s2GS3y6/hNk7CKo
 OLI6n6kfxf92M07y7obgt587/OXCWILmskDz+wAEMrmc049LVwWW7jhNxqvaOL5dt2cR
 prQG9f4FS6oZEWIp513GY2FpXoD9/6GBdUQHJKdYfQvr+R8Y4sIH75SDvt1MU0+BUlNf
 w2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709953825; x=1710558625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8tpJAfxQcRF8joD00NGmo1iAef1vo78TLl0CoONZU1s=;
 b=eTtYLYjqV1W6cPvk0jcyKU/tra0Sexm7Pj5W6oWR1aq/eOgjUgRHQk4qhrkZCsd7YB
 StsS6tFcafq957H27arZZGtpIU5xZIEQeGa+QN30qLv78DwDl52BH0ypaqpqs0NMQjzH
 lTumzpC/YlY5f/NwB72amUm7OGuuR01AVvFG0DIlwv6cGo9oClWK2HD5CrWW7RBykaIE
 y9Ot+o3cGf11Y9kyPxy1Yhv40FyWvQSK1ikTai4Ly8RLVPm3AVVsavm/M89SP4x+eScm
 8yv3myJ+36XDXH1Fn9+ilMXUI678QlMJDCH8Dndq4Ayo8ySSIRvswKzU5B9Wl6uj7mC1
 Qt6A==
X-Gm-Message-State: AOJu0YyWCqRgF8yWvNLrh4fGm/RAYa77SDUHgbEXY3lRzHAiBREd/9S1
 /vIyFHyqwfKsI+4SfvHpVFUNdow0+ekpEgs9AxWS0XZclw25vb2ladb8PBrlScSdseaLIW/JA+S
 0cKc=
X-Google-Smtp-Source: AGHT+IEAFXsghp1vEOf+FwX6nOK9Lbe8K8cHjH0cW/3eD8l9d4I36KOtpLHplye1KfiGRdxBpYpF/g==
X-Received: by 2002:a17:903:244b:b0:1dd:4cf3:5771 with SMTP id
 l11-20020a170903244b00b001dd4cf35771mr541487pls.60.1709953825429; 
 Fri, 08 Mar 2024 19:10:25 -0800 (PST)
Received: from amd.. ([2804:7f0:b401:7e8e:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 w13-20020a170902d3cd00b001dd707d5fe6sm349566plb.158.2024.03.08.19.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 19:10:24 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu,
 philmd@linaro.org, gustavo.romero@linaro.org
Subject: [PATCH v3 1/5] gdbstub: Rename back gdb_handlesig
Date: Sat,  9 Mar 2024 03:08:57 +0000
Message-Id: <20240309030901.1726211-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240309030901.1726211-1-gustavo.romero@linaro.org>
References: <20240309030901.1726211-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x632.google.com
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

Rename gdb_handlesig_reason back to gdb_handlesig. There is no need to
add a wrapper for gdb_handlesig and rename it when a new parameter is
added.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 gdbstub/user.c         |  8 ++++----
 include/gdbstub/user.h | 15 ++-------------
 linux-user/main.c      |  2 +-
 linux-user/signal.c    |  2 +-
 4 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/gdbstub/user.c b/gdbstub/user.c
index 14918d1a21..a157e67f95 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -131,7 +131,7 @@ void gdb_qemu_exit(int code)
     exit(code);
 }
 
-int gdb_handlesig_reason(CPUState *cpu, int sig, const char *reason)
+int gdb_handlesig(CPUState *cpu, int sig, const char *reason)
 {
     char buf[256];
     int n;
@@ -510,7 +510,7 @@ void gdb_breakpoint_remove_all(CPUState *cs)
 void gdb_syscall_handling(const char *syscall_packet)
 {
     gdb_put_packet(syscall_packet);
-    gdb_handlesig(gdbserver_state.c_cpu, 0);
+    gdb_handlesig(gdbserver_state.c_cpu, 0, NULL);
 }
 
 static bool should_catch_syscall(int num)
@@ -528,7 +528,7 @@ void gdb_syscall_entry(CPUState *cs, int num)
 {
     if (should_catch_syscall(num)) {
         g_autofree char *reason = g_strdup_printf("syscall_entry:%x;", num);
-        gdb_handlesig_reason(cs, gdb_target_sigtrap(), reason);
+        gdb_handlesig(cs, gdb_target_sigtrap(), reason);
     }
 }
 
@@ -536,7 +536,7 @@ void gdb_syscall_return(CPUState *cs, int num)
 {
     if (should_catch_syscall(num)) {
         g_autofree char *reason = g_strdup_printf("syscall_return:%x;", num);
-        gdb_handlesig_reason(cs, gdb_target_sigtrap(), reason);
+        gdb_handlesig(cs, gdb_target_sigtrap(), reason);
     }
 }
 
diff --git a/include/gdbstub/user.h b/include/gdbstub/user.h
index 68b6534130..6647af2123 100644
--- a/include/gdbstub/user.h
+++ b/include/gdbstub/user.h
@@ -10,7 +10,7 @@
 #define GDBSTUB_USER_H
 
 /**
- * gdb_handlesig_reason() - yield control to gdb
+ * gdb_handlesig() - yield control to gdb
  * @cpu: CPU
  * @sig: if non-zero, the signal number which caused us to stop
  * @reason: stop reason for stop reply packet or NULL
@@ -25,18 +25,7 @@
  * or 0 if no signal should be delivered, ie the signal that caused
  * us to stop should be ignored.
  */
-int gdb_handlesig_reason(CPUState *, int, const char *);
-
-/**
- * gdb_handlesig() - yield control to gdb
- * @cpu CPU
- * @sig: if non-zero, the signal number which caused us to stop
- * @see gdb_handlesig_reason()
- */
-static inline int gdb_handlesig(CPUState *cpu, int sig)
-{
-    return gdb_handlesig_reason(cpu, sig, NULL);
-}
+int gdb_handlesig(CPUState *, int, const char *);
 
 /**
  * gdb_signalled() - inform remote gdb of sig exit
diff --git a/linux-user/main.c b/linux-user/main.c
index 551acf1661..049fd85a2a 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -1014,7 +1014,7 @@ int main(int argc, char **argv, char **envp)
                     gdbstub);
             exit(EXIT_FAILURE);
         }
-        gdb_handlesig(cpu, 0);
+        gdb_handlesig(cpu, 0, NULL);
     }
 
 #ifdef CONFIG_SEMIHOSTING
diff --git a/linux-user/signal.c b/linux-user/signal.c
index d3e62ab030..a57c45de35 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -1180,7 +1180,7 @@ static void handle_pending_signal(CPUArchState *cpu_env, int sig,
     /* dequeue signal */
     k->pending = 0;
 
-    sig = gdb_handlesig(cpu, sig);
+    sig = gdb_handlesig(cpu, sig, NULL);
     if (!sig) {
         sa = NULL;
         handler = TARGET_SIG_IGN;
-- 
2.34.1



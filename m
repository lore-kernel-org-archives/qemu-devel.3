Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4311EE6B46
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQCy-0007zt-Qq; Fri, 06 Feb 2026 13:05:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1voQCs-0007yK-4Q
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:05:26 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1voQCq-0001RW-FP
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:05:25 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6594382a264so1808334a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 10:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770401123; x=1771005923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NuV/X2y2s0J4/FJ/QeduaBNSaM5K7IHFrxAFMtHcJQo=;
 b=XHEDjN6AVvQql75bUXCZOK6X641sgZWwdEArmI/M3pNZmM+UDZ9eaGJIH6qHu9herr
 hIzusw5jI4l/e2YYR9kcT8dYDTC3HTKxmXO015IHyrsAzO6N4PUp9kTEXXeWhEAgL8Mx
 07Xxs6hAUpUc/0V18lIsjooRuiZU/+QvSf+y+UhRitSh4B0dIR6tMO7fvOUwIAYS7q3Q
 vf24nYutBlNJpbNOWk3iRAoJ/wNEp4U1AYogwEB+8LJH6c85iev8n/wBBr5DQvF+sJAY
 ec3zUWVPkHLt7auq9wLODif84mhQAc5Jcc+2OX6S19Wvfxb4E7lmRenXtoqsrls3Iq5k
 jvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770401123; x=1771005923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NuV/X2y2s0J4/FJ/QeduaBNSaM5K7IHFrxAFMtHcJQo=;
 b=c/G3J5V3VsM+12ACspeGdNXoCo9gm0+LDkLiJhCgrL8dp+9ERKFZ461LLAY231253z
 2TyPikF8VDQsgwjGNQhG0x9ku/Pq/G0nSGY4vS8OHnqNbf3d+oGaCwf1NoBb9U/4sORF
 avifFXH01H+wT3uJzGw3EMreWTum4VmeLy6MN7FMbZAT3Rcla4+IiOsYqE9SW/gHT7Lb
 SwtA9PG/1RCemhMhxfOW2B1Ra2GHxnZA3zmodkBxk5z1qE+093w3zY6IVqPOr090b9R0
 OLqW7jmKNKYm4gFCQ3QoRfIErXl5Sf74NLuEnVRBEd0T6R4p6p3cYOSos2Uai5PVUpyk
 yxZg==
X-Gm-Message-State: AOJu0Yx/iyHigEtTu6yPj0ShubRjEWTMn2R8tGInJxWCePWFywbQIB+9
 egp2M+ILYwA6MQZyvRJN6JxUo9NHh/22UH4nOZsfd1XXrozjPl5IgpPkxSnntw9fzPM=
X-Gm-Gg: AZuq6aL1HG2PV5O2z5D6aL0Fgx0UPZS+cTmcTvMv76FzBGi7PHlUrLlJGRvsO62nrJN
 Zvh5tGq6n7epI1VFs7ekCURPwANEY2cm8v0O5Q6CTWzq+Xq6axt6JpM1gHRrCqqVHWTvOeecBFP
 ILWPZuq4TNFVDVyxorE8A4qwnveAL7bsDhBgAktUMdv1iPDIn/inaOuk6UwwkloE4qK9Jbi0fjr
 VrS+rd822EEebveY/oL1aqHhBwsLhF7Y9VqRSkluvBJDG2TwePGOfAyI/8l2EVB66tj+/8RmlLF
 9iwGCrxJ0I3V3l8ICNO7Gk9LrnyOj3LUM0Wff71eZxiWwvrrKHdxhSy3uKyaeVwkSQmzCh5Whd3
 WZFdb4oqeqXesQpEhSrejZfWV7Q3myBtmfnDhvzxxR7M4oBi8kRNCsin5c8iFc2vpch1pKrxvA0
 ZWIgI5V4ySgbc=
X-Received: by 2002:a05:6402:1e8e:b0:658:316c:c71a with SMTP id
 4fb4d7f45d1cf-65984191cd5mr1911284a12.30.1770401122770; 
 Fri, 06 Feb 2026 10:05:22 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65983eaa458sm799179a12.6.2026.02.06.10.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 10:05:21 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 81CB5607EC;
 Fri, 06 Feb 2026 18:05:18 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yodel Eldar <yodel.eldar@yodel.dev>,
 Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 08/10] gdbstub/user-target: Convert host errno to GDB File-I/O
 errno
Date: Fri,  6 Feb 2026 18:05:15 +0000
Message-ID: <20260206180517.1335861-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206180517.1335861-1-alex.bennee@linaro.org>
References: <20260206180517.1335861-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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

From: Yodel Eldar <yodel.eldar@yodel.dev>

Use host_to_gdb_errno to convert host-supplied errnos to their GDB
File-I/O remote protocol values, and use them in F reply packets.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2751
Reported-by: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260116014612.226183-4-yodel.eldar@yodel.dev>
Message-ID: <20260203115201.2387721-10-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
index 43231e695e8..7ef0282f70e 100644
--- a/gdbstub/user-target.c
+++ b/gdbstub/user-target.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/commands.h"
+#include "gdbstub/syscalls.h"
 #include "qemu.h"
 #include "internals.h"
 #ifdef CONFIG_LINUX
@@ -315,7 +316,8 @@ void gdb_handle_v_file_open(GArray *params, void *user_ctx)
     int fd = open(filename, flags, mode);
 #endif
     if (fd < 0) {
-        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
+        int gdb_errno = host_to_gdb_errno(errno);
+        g_string_printf(gdbserver_state.str_buf, "F-1,%x", gdb_errno);
     } else {
         g_string_printf(gdbserver_state.str_buf, "F%x", fd);
     }
@@ -327,7 +329,8 @@ void gdb_handle_v_file_close(GArray *params, void *user_ctx)
     int fd = gdb_get_cmd_param(params, 0)->val_ul;
 
     if (close(fd) == -1) {
-        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
+        int gdb_errno = host_to_gdb_errno(errno);
+        g_string_printf(gdbserver_state.str_buf, "F-1,%x", gdb_errno);
         gdb_put_strbuf();
         return;
     }
@@ -350,7 +353,8 @@ void gdb_handle_v_file_pread(GArray *params, void *user_ctx)
 
     ssize_t n = pread(fd, buf, bufsiz, offset);
     if (n < 0) {
-        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
+        int gdb_errno = host_to_gdb_errno(errno);
+        g_string_printf(gdbserver_state.str_buf, "F-1,%x", gdb_errno);
         gdb_put_strbuf();
         return;
     }
@@ -373,7 +377,8 @@ void gdb_handle_v_file_readlink(GArray *params, void *user_ctx)
     ssize_t n = readlink(filename, buf, BUFSIZ);
 #endif
     if (n < 0) {
-        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
+        int gdb_errno = host_to_gdb_errno(errno);
+        g_string_printf(gdbserver_state.str_buf, "F-1,%x", gdb_errno);
         gdb_put_strbuf();
         return;
     }
-- 
2.47.3



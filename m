Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7A4EE6B43
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQCs-0007yu-Jo; Fri, 06 Feb 2026 13:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1voQCr-0007x1-7r
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:05:25 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1voQCp-0001RJ-Bq
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:05:24 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b8e9c8ada38so375540366b.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 10:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770401122; x=1771005922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ejrh02Mk/KLMeodWKeL7ZGQn7Gm+puDkYZVo16Fx7oo=;
 b=SOX9IzE+yTj+7znl1NrnYkF6IYH1OweLl1DzqCfaLHIo1KVXv9nomjBA/jM53mdoL2
 yPwMDSAoeNbs6ZohoIPlMC1OftrgZ5FCWEwd5d14A8RMpSAQ3Qazy/rG2r5iO9o0c/2/
 ik4/ELs5cevQFGrPNPVkXphzVMWR5jQ5dCJ8+5jqhjNlU3ndoU0IdRgipLF2LsfLvz9e
 9W7SeUR1qIidzJpNREDxValrCKGcFOWO266M5tZJgcPyjkoTj2Ib1DUQIwYcTDYwP8Cj
 BUJpkHM96UBiLKE4PasYf8qPvF6cFnc0ddjut6NZspJ/dRT0sNIQM3Ci2TuLhwUsSB2X
 n1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770401122; x=1771005922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ejrh02Mk/KLMeodWKeL7ZGQn7Gm+puDkYZVo16Fx7oo=;
 b=SfECP+AKShiStdRu2CvqKonjHIzVxqDxmI3WUex2s8z5fDSuBE70o6O+HwY2/vr5xy
 tIbs6rka4pYxsc01Guom64ZbnyrdZGNEvPUl6kFwMuRGkrtT5968ackhjrFsdQzGv3W2
 cOCHVd9k4RD3XJ1M1txnI6mRP8sr+UO3qR4XY1YtEi4FDLrd2/LOnvrr6hkQ8Ry/jOnU
 ThTY7UotiQEYMPdnEKeoeLDqgkLZtC8zkbhJ2VWf1TjOlKFKh/pm4/YPmpG1c3pEFI/A
 EzY9fLl9srs4HY84Kcv0V7YZ7TYypXXB6I/SQtEsau11votdZQxv7VoF/+/c9tOAsR1A
 MT6A==
X-Gm-Message-State: AOJu0YzDdbZSzc6a7JldSNihq561GegVQi+arOlYc8Yjag5YLpgfkzB7
 gQ5D/5AB8rBHIBCJ55zVP1ZgVw8OMUB5tbXYwqat1yBUwmAGaHqh7x2vnLkW9GhFQ0s=
X-Gm-Gg: AZuq6aJ/xUVpJy2rrxiFhp131/VGuo6JnMokdN/ZIKAWXW3QXlBo/3KHcUcSXI7u/uR
 muVIvNUN/D9YqyQ3Oh7G/KWA2V540QIwgSr9V0ts9LlUj6zDVwFGWFOYnvKmDTzSxhZo8ly6WJ/
 EhEVtjeimx5NX7EGoBQeEN95HxFFZJ1bP7+dtWJHQghhm5QyjS6y3h+z4aAyQjzrZL0YbuvMlxt
 HvHgBLmpvkVko+NOABkQdHH6OEoESsGRod6g6v68Xo27Z0DEz8lUPRgh40497R5sTAV84lbUlVj
 S1THcG9Jeo+Fv+bOd9jy3CpbebbwlFE+F5WnQQ22sIp74JjEBlNx5UJyrQAjtbA7z/a1NqhRkAM
 kDiMPBJngVCFdAj6Uf8BBkqPK8NI6U5K2BlcdgCONIa6pFEf3lQo9wX0ulN+IjHUjYBYL7yl+kb
 uM8fxqi5yv4Pw=
X-Received: by 2002:a17:907:1c9e:b0:b87:bb45:bd5c with SMTP id
 a640c23a62f3a-b8edf42c682mr234686366b.58.1770401121727; 
 Fri, 06 Feb 2026 10:05:21 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8eda7a3372sm102786666b.20.2026.02.06.10.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 10:05:19 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 24D25607BE;
 Fri, 06 Feb 2026 18:05:18 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/10] gdbstub: extract stop reply message construction
Date: Fri,  6 Feb 2026 18:05:11 +0000
Message-ID: <20260206180517.1335861-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206180517.1335861-1-alex.bennee@linaro.org>
References: <20260206180517.1335861-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

The stop reply message we send can include a lot of extra information
and a bunch is mode dependant. Extract the construction into a helper
and add specialised versions for system and user mode.

The correct response for system mode should be of the form:

  T05core:N;

Where N is the core ID. We pass GString to gdb_build_stop_packet as
other functions we are going to clean-up work variously with their own
dynamically allocated GStrings or with the common shared buffer.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260203115201.2387721-5-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 92466b28c18..9b25bf58b8e 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -237,4 +237,14 @@ void gdb_breakpoint_remove_all(CPUState *cs);
 int gdb_target_memory_rw_debug(CPUState *cs, hwaddr addr,
                                uint8_t *buf, int len, bool is_write);
 
+/**
+ * gdb_build_stop_packet() - craft the stop packet
+ * @buf: GString buffer for building the packet
+ * @cs: CPUState
+ *
+ * Craft the Stop/Reply packet when we halt.
+ */
+
+void gdb_build_stop_packet(GString *buf, CPUState *cs);
+
 #endif /* GDBSTUB_INTERNALS_H */
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index aeff467fdd6..b45eb7c7b2b 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1432,9 +1432,7 @@ static void handle_v_attach(GArray *params, void *user_ctx)
         gdbserver_state.c_cpu = cpu;
 
         if (gdbserver_state.allow_stop_reply) {
-            g_string_printf(gdbserver_state.str_buf, "T%02xthread:", GDB_SIGNAL_TRAP);
-            gdb_append_thread_id(cpu, gdbserver_state.str_buf);
-            g_string_append_c(gdbserver_state.str_buf, ';');
+            gdb_build_stop_packet(gdbserver_state.str_buf, cpu);
             gdbserver_state.allow_stop_reply = false;
         }
     }
@@ -2038,11 +2036,9 @@ static void handle_gen_set(GArray *params, void *user_ctx)
 static void handle_target_halt(GArray *params, void *user_ctx)
 {
     if (gdbserver_state.allow_stop_reply) {
-        g_string_printf(gdbserver_state.str_buf, "T%02xthread:", GDB_SIGNAL_TRAP);
-        gdb_append_thread_id(gdbserver_state.c_cpu, gdbserver_state.str_buf);
-        g_string_append_c(gdbserver_state.str_buf, ';');
-        gdb_put_strbuf();
+        gdb_build_stop_packet(gdbserver_state.str_buf, gdbserver_state.c_cpu);
         gdbserver_state.allow_stop_reply = false;
+        gdb_put_strbuf();
     }
     /*
      * Remove all the breakpoints when this query is issued,
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 79f80256e3a..8ec8b7ea336 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -662,3 +662,14 @@ void gdb_breakpoint_remove_all(CPUState *cs)
         ops->remove_all_breakpoints(cs);
     }
 }
+
+/*
+ * The minimal system-mode stop reply packet is:
+ *   T05core:{id};
+ */
+
+void gdb_build_stop_packet(GString *buf, CPUState *cs)
+{
+    g_string_printf(buf,
+                    "T%02xcore:%02x;", GDB_SIGNAL_TRAP, gdb_get_cpu_index(cs));
+}
diff --git a/gdbstub/user.c b/gdbstub/user.c
index a2327c61352..14369b9ce5e 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -974,3 +974,15 @@ void gdb_handle_query_xfer_siginfo(GArray *params, void *user_ctx)
     gdb_put_packet_binary(gdbserver_state.str_buf->str,
                           gdbserver_state.str_buf->len, true);
 }
+
+/*
+ * The minimal user-mode stop reply packet is:
+ *   T05thread:{id};
+ */
+
+void gdb_build_stop_packet(GString *buf, CPUState *cs)
+{
+    g_string_printf(buf, "T%02xthread:", GDB_SIGNAL_TRAP);
+    gdb_append_thread_id(cs, buf);
+    g_string_append_c(buf, ';');
+}
-- 
2.47.3



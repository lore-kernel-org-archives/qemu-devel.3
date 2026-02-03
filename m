Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53159E7C712
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 11:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnExH-00084M-H7; Tue, 03 Feb 2026 06:52:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vnEx4-0007xg-44
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 06:52:14 -0500
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vnEx0-0005A0-Bb
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 06:52:13 -0500
Received: by mail-ej1-x641.google.com with SMTP id
 a640c23a62f3a-b87677a8abeso833060866b.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 03:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770119529; x=1770724329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3rnOG7bwrBNwvdTMzR0X6nqTtCuNrtf+RkzdzcDauu4=;
 b=u7X0/Zcjt6hImDuEKVy6/J9RRSjC5NQwmuHhPFDoH8l4HyOES4nXQORVU1Ab2nMXnB
 SW6B9mlKbHYsbTVtSny0YZxcKKRFvjg7I4Lxzb/kRd63isG8x+quJw9+UhTjnrko5W3m
 SIiMzOCNUmph+ljG8dKtGxmd2ugj4iO65gexr4NPaHF+o73mETnBz04yhUn7FmAHqIXO
 CIqYZvj25YVnUciX0gxbU0/yb0yVtxtYYHFN8ij/yAMnJg2y0rGnGZxWMNa58PPqD6ry
 WuluYTKdOVi/6/dpfDq/7o9pxVpdXxHDNTRgUF7dV8ip1Btik9pZsPBtoUH7IREySg5/
 KJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770119529; x=1770724329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3rnOG7bwrBNwvdTMzR0X6nqTtCuNrtf+RkzdzcDauu4=;
 b=DFBdceiLjKKETT0fYlMW4nUqdCiyrwZhTirxl8i6lgZFvtHsJxDBAyy3zaJ9UMZ/XX
 ZF3AGYV0iQmFPaKkAbpkUpjPpaBIf25ojKHbpttkIt9OGbofhHjwthjCOwHDyNUagZmN
 9oLPHAgSz8F0v0BG59grdRaJ4iI6Vkq+43nM4TwT+ZQ4cXc9s5SWTVpUuqtHmN5y4e+j
 1FUFd3aJNi3LYD1aT3eZilsk2q5eqn7hVmqrks0jKHlbSO1yynK2b9NciZ++ynKGj2vD
 Ckr1Vdtf8aC1wdKa7SHKj4YcnJ3NG102RJJ0MS+H8q4q1rv9nsQY5Dah0vm7BOEwY8s+
 X5Bg==
X-Gm-Message-State: AOJu0YxRl+cnpQyk1eK2ACeS6WS8SzTwhCgV/E9+TP/Y73ON7VUYV/MU
 RrPXPJiORTZ8LG2hCt48f5HkCmAqzmSnoIN/E48kZMBGE39FZaMEhEA2I/rSr4Wgu3I=
X-Gm-Gg: AZuq6aLJGCgVF8pFPl7bLOPnJWpWlliocCQPtOpT/Krah7tjIiM1i74ug9CtbaSpdUZ
 pghjCw/ilkR8mmfOlhSQNT1wA4BZfQEPN8ovvvS389TgmY1f1blf1xH+sYrhvPNmsLFOZNFjt7E
 97kM6H7eihJe5yx8prTOpuLjKCWnqblMH+HKu0VlAvo8JhABtLUb6B1yEtCC8JZ6zUut9XarKHY
 KTuoIriKMzHVElU2w5M8CZlLo95paxGQti9AxbOaGdHq4yE6fyjGPCyJrm8TpyF6AIAIm1NeBFx
 HP5JYSHaQsul+joq8K1gw55oo7xez+TprHYo0FtQq3FoS0rXt1+jBw0J5bAaJgZNRXNEGjbDfQ5
 5+BP7Q1+Nur4tDrD7A79C5F69TW+KxtlfLht9MggJXmgPo/UPtDhyPEEEkvvyDo1y0JfcTq4GWO
 MGyA9ukPMVQjbMl5w1lmKnDA==
X-Received: by 2002:a17:907:1b03:b0:b87:35fc:ae6e with SMTP id
 a640c23a62f3a-b8dff69d99bmr912611866b.46.1770119528628; 
 Tue, 03 Feb 2026 03:52:08 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8dbeffedd3sm998692766b.29.2026.02.03.03.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 03:52:07 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9CB2B60231;
 Tue, 03 Feb 2026 11:52:02 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 06/11] gdbstub: pass GString to gdb_build_stop_packet
Date: Tue,  3 Feb 2026 11:51:56 +0000
Message-ID: <20260203115201.2387721-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203115201.2387721-1-alex.bennee@linaro.org>
References: <20260203115201.2387721-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x641.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The other functions we are going to clean-up work variously with there
own dynamically allocated GStrings or with the common shared buffer.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub/internals.h | 5 ++++-
 gdbstub/gdbstub.c   | 4 ++--
 gdbstub/system.c    | 4 ++--
 gdbstub/user.c      | 8 ++++----
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 3134a6e8eb2..9b25bf58b8e 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -239,9 +239,12 @@ int gdb_target_memory_rw_debug(CPUState *cs, hwaddr addr,
 
 /**
  * gdb_build_stop_packet() - craft the stop packet
+ * @buf: GString buffer for building the packet
  * @cs: CPUState
+ *
+ * Craft the Stop/Reply packet when we halt.
  */
 
-void gdb_build_stop_packet(CPUState *cs);
+void gdb_build_stop_packet(GString *buf, CPUState *cs);
 
 #endif /* GDBSTUB_INTERNALS_H */
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index c82fb5ad324..b45eb7c7b2b 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1432,7 +1432,7 @@ static void handle_v_attach(GArray *params, void *user_ctx)
         gdbserver_state.c_cpu = cpu;
 
         if (gdbserver_state.allow_stop_reply) {
-            gdb_build_stop_packet(cpu);
+            gdb_build_stop_packet(gdbserver_state.str_buf, cpu);
             gdbserver_state.allow_stop_reply = false;
         }
     }
@@ -2036,7 +2036,7 @@ static void handle_gen_set(GArray *params, void *user_ctx)
 static void handle_target_halt(GArray *params, void *user_ctx)
 {
     if (gdbserver_state.allow_stop_reply) {
-        gdb_build_stop_packet(gdbserver_state.c_cpu);
+        gdb_build_stop_packet(gdbserver_state.str_buf, gdbserver_state.c_cpu);
         gdbserver_state.allow_stop_reply = false;
         gdb_put_strbuf();
     }
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 6963c930b01..8ec8b7ea336 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -668,8 +668,8 @@ void gdb_breakpoint_remove_all(CPUState *cs)
  *   T05core:{id};
  */
 
-void gdb_build_stop_packet(CPUState *cs)
+void gdb_build_stop_packet(GString *buf, CPUState *cs)
 {
-    g_string_printf(gdbserver_state.str_buf,
+    g_string_printf(buf,
                     "T%02xcore:%02x;", GDB_SIGNAL_TRAP, gdb_get_cpu_index(cs));
 }
diff --git a/gdbstub/user.c b/gdbstub/user.c
index c7a3ef947ed..a16f37616b1 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -976,9 +976,9 @@ void gdb_handle_query_xfer_siginfo(GArray *params, void *user_ctx)
  *   T05thread:{id};
  */
 
-void gdb_build_stop_packet(CPUState *cs)
+void gdb_build_stop_packet(GString *buf, CPUState *cs)
 {
-    g_string_printf(gdbserver_state.str_buf, "T%02xthread:", GDB_SIGNAL_TRAP);
-    gdb_append_thread_id(cs, gdbserver_state.str_buf);
-    g_string_append_c(gdbserver_state.str_buf, ';');
+    g_string_printf(buf, "T%02xthread:", GDB_SIGNAL_TRAP);
+    gdb_append_thread_id(cs, buf);
+    g_string_append_c(buf, ';');
 }
-- 
2.47.3



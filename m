Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5642D374A9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 15:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1SZf-000186-N1; Thu, 17 Oct 2024 11:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3WC8RZwYKCjsolnrbedlldib.Zljnbjr-absbiklkdkr.lod@flex--roqueh.bounces.google.com>)
 id 1t1SZf-00017x-2g
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:38:03 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3WC8RZwYKCjsolnrbedlldib.Zljnbjr-absbiklkdkr.lod@flex--roqueh.bounces.google.com>)
 id 1t1SZd-00040x-IT
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:38:02 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-e2974759f5fso1263688276.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 08:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1729179480; x=1729784280; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=S+2ZXkQ0LYwfL6luLg/39hG+1Q0aCrDxY1HPUr03Alc=;
 b=L8JVvZgkOYsNOVBHzhQQkp0iVAs4d+a+JefKEsLVGrXmJDFqasPSfJ2vL713oaD+Qg
 +hgaRdMyH5vLLOBDMWKb9OgNpp4K64rtWQlqOnPX/jUoXJG+fybOkzPR/Y4YffNQHbb/
 BiDpvEvTc38EdLktAUL0msP/haqWIhTpWBLerNvjrqoCXOi/AFxDlqte2dhuA0Jxi899
 LTmxx9yid9CCxGqd8FKlLvEDigCLo/WpXdLcvrBvqzNbvAdvdmsicdne4bZ/HeUuXeSg
 JuYGKI8HoT7YwTWpggKcRs8lJTg2x+okeE1BtC67LaZBkI+8s8RnnOMLyk3eEKWOLed7
 kFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729179480; x=1729784280;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S+2ZXkQ0LYwfL6luLg/39hG+1Q0aCrDxY1HPUr03Alc=;
 b=WkFk/a/qVDqQmriS9QIYMwdnk9MzW/qE4slJzbZ7W1jgQSg+NQCX3F15WdewoX1DUU
 erdkKjQGiFXtfYXWbCFrKtqUgqQtmFQSluk1EPHIauHxqwSAxJDuaRyiclEViLdx+iwQ
 fF97Mm3gawOhROlZlyNrJTDLqLa5vOBH4ZA4J23XkFWtvpDBRn5U3HJgaR7djJMdhRxk
 ZC+cVUsj1T5KgdhXt1vW7Tm8XeF8NZcxNZuk0HdwgkZr5dBJVh8RumHHBrZtyfJf6Cnr
 yqBeanm8EqepHZzpzSLuo0vdOCmhBCWCgOI6dBtQ9TGNqDEJa44aOpLuCw+2tZqPANfT
 bEXw==
X-Gm-Message-State: AOJu0Yw7Ifhk8Mkj+FJFHQZyHFTde2Nt1g888gGCKnGjszmjD0SyEP3d
 zdG5hD9wDzibANIY+xYy5ZLdhAftFnICNwPc/HBvY5HNfQJ+wT2qFojwJeE95+5UB/Lbya3dRso
 zJg==
X-Google-Smtp-Source: AGHT+IE8ZmIvehVmTdQ6Nn/Yfl5g8brQXze4ezSwqu5inp0XhT1qRKiCMlqrYhM7SSLsirDWuVsRCqTbuyE=
X-Received: from roqueh-desktop.svl.corp.google.com
 ([2a00:79e0:2e5b:9:1adf:42eb:8cf9:56e9])
 (user=roqueh job=sendgmr) by 2002:a25:aa84:0:b0:e29:6b0b:5c85 with SMTP id
 3f1490d57ef6-e2b9cddf4d3mr7280276.1.1729179480097; Thu, 17 Oct 2024 08:38:00
 -0700 (PDT)
Date: Thu, 17 Oct 2024 08:37:44 -0700
In-Reply-To: <20241017153745.509978-1-roqueh@google.com>
Mime-Version: 1.0
References: <20241017153745.509978-1-roqueh@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241017153745.509978-2-roqueh@google.com>
Subject: [PATCH v2 1/2] gdbstub: Fix wrong CPUState pointer in breakpoint
 functions
From: Roque Arcudia Hernandez <roqueh@google.com>
To: richard.henderson@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org, 
 philmd@linaro.org, slongfield@google.com, komlodi@google.com
Cc: qemu-devel@nongnu.org, Roque Arcudia Hernandez <roqueh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3WC8RZwYKCjsolnrbedlldib.Zljnbjr-absbiklkdkr.lod@flex--roqueh.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

In the context of using the remote gdb with multiple
processes/inferiors (multiple cluster machine) a given breakpoint
will target an specific inferior. If needed the remote protocol will
use the packet 'H op thread-id' with op = 'g' to change focus to the
inferior we want to insert/remove the breakpoint to, for instance
'Hgp3.3' and not 'Hcp3.3'.

This is supported by the documentation of the H packets:

 > 'H op thread-id'
 > Set thread for subsequent operations ('m', 'M', 'g', 'G',
 > et.al.). Depending on the operation to be performed, op should be
 > 'c' for step and continue operations (note that this is
 > deprecated, supporting the 'vCont' command is a better option),
 > and 'g' for other operations.

This can also be verified in the GDB source code file gdb/remote.c.
Functions remote_target::insert_breakpoint and
remote_target::remove_breakpoint will eventually call
remote_target::set_general_thread if it needs to change the process
focus and not remote_target::set_continue_thread.

This can be seen around a comment that says:

      /* Make sure the remote is pointing at the right process, if
         necessary.  */

Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
---
 gdbstub/gdbstub.c   |  4 ++--
 gdbstub/internals.h | 13 +++++++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index b1def7e71d..64ad81e53f 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1148,7 +1148,7 @@ static void handle_insert_bp(GArray *params, void *user_ctx)
         return;
     }
 
-    res = gdb_breakpoint_insert(gdbserver_state.c_cpu,
+    res = gdb_breakpoint_insert(gdbserver_state.g_cpu,
                                 gdb_get_cmd_param(params, 0)->val_ul,
                                 gdb_get_cmd_param(params, 1)->val_ull,
                                 gdb_get_cmd_param(params, 2)->val_ull);
@@ -1172,7 +1172,7 @@ static void handle_remove_bp(GArray *params, void *user_ctx)
         return;
     }
 
-    res = gdb_breakpoint_remove(gdbserver_state.c_cpu,
+    res = gdb_breakpoint_remove(gdbserver_state.g_cpu,
                                 gdb_get_cmd_param(params, 0)->val_ul,
                                 gdb_get_cmd_param(params, 1)->val_ull,
                                 gdb_get_cmd_param(params, 2)->val_ull);
diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index bf5a5c6302..e67fb6fe37 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -48,8 +48,17 @@ enum RSState {
 
 typedef struct GDBState {
     bool init;       /* have we been initialised? */
-    CPUState *c_cpu; /* current CPU for step/continue ops */
-    CPUState *g_cpu; /* current CPU for other ops */
+    /*
+     * Current CPU for step/continue ops. Updated by the remote packet
+     * 'Hc thread-id'
+     */
+    CPUState *c_cpu;
+    /*
+     * Current CPU for other ops such as memory accesses ('m'/'M'), general
+     * register accesses ('g'/'G'), breakpoint management ('z'/'Z'), etc.
+     * Updated by the remote packet 'Hg thread-id'
+     */
+    CPUState *g_cpu;
     CPUState *query_cpu; /* for q{f|s}ThreadInfo */
     enum RSState state; /* parsing state */
     char line_buf[MAX_PACKET_LENGTH];
-- 
2.47.0.rc1.288.g06298d1525-goog



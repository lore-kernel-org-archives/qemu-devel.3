Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B76C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 22:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD9zX-0001tQ-Pr; Thu, 08 May 2025 18:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3_jMdaAwKCiMM9AHGDRSDE9MFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--nabihestefan.bounces.google.com>)
 id 1uD9zV-0001sd-Mr
 for qemu-devel@nongnu.org; Thu, 08 May 2025 18:45:21 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3_jMdaAwKCiMM9AHGDRSDE9MFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--nabihestefan.bounces.google.com>)
 id 1uD9zT-00060X-W1
 for qemu-devel@nongnu.org; Thu, 08 May 2025 18:45:21 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-22e68e50f80so10922805ad.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 15:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1746744318; x=1747349118; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=WqQUcthWsBTODpzySEvt/823KavTQHBdgj/sb5cOiaU=;
 b=JyhdZ3qrE7/faJlKaIAvtuBt24T/CpY3QqnsKpSPB440bFX2IMcvtyFjRQJEpvkoED
 LdTbZ+QvEt8tuoTx/jxyz4y58kg++jK/ue3ilWPxnD6OP9qGdaKLQH7D7vqHIwbNxvgz
 16Du4q417Si/JPYk98r6wSwxsEW9QWYtksJtkfa8oC0eqsYokPzXZp1yQiTQ1o+TPcVa
 WAJ8KbINyjObJHBonrboXiLjgIPjtDSVB2VgQgS/vpt5L9ciMwk6MqwA9F4O8s/8SSO8
 xPMYFbvGLRMcgAetRH2J7c74/FKqfUGJT+o1d+byZgHh+VOfsaiZkFVJxfdo06fwoHRk
 ZTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746744318; x=1747349118;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WqQUcthWsBTODpzySEvt/823KavTQHBdgj/sb5cOiaU=;
 b=O6QHgTcAcPFb+D6c86/oBbj24rOQI9bg9M4EXkqEjJs7FkEETuz+ozL297IGwmKL6v
 X/isRQLsKAw61sMln7AeWRn5PFWvSSiKnBOVFtiU9yn9lj9Pns0uR08GOKUPZv9naz8b
 09s0cbRj6IEcphKZ7AhFX67QoVvccaCbBQkz3ckJhUMH7vrE2rkmRcFT/IwxecnlRdc/
 1bpmANkM4DZduBSjUT0UXu85qD8TjO+uQidjD7D3i4BIQ1GOfz4DnF801Gn+UNIdeLlD
 P+CUPRaCWuMHf75/iPekwqyy4P6Vrv972eLwGPPmWdEqY8Ah5/GneDqvGnQ7PJk+UQXP
 IW7w==
X-Gm-Message-State: AOJu0Yz3HFCNS74j/51KPrEaiWWj6fIsziQazVIs38URS66Xq3dwf6uK
 DBZan29ARW5x+4IEpffRr1RbWjjfwoyKln/WwwTvll/YEpVAl0uEzClaNyQ63l5LDsaRMExQa76
 6vL3AgNoPtfsEm58MnDpvlgQQsV1vn1qBrYefksCUnXO7uwccBfm3p14rdURaiAvBicdcoY6WER
 rEuJWMyj+AN1sl+JiKEQbHJ/+FztNy40BvD0lTfSh2gWA3iuYKvw2AkIHdwUv83JY=
X-Google-Smtp-Source: AGHT+IFQ5U4DRq8mxVwOX3SvIC3Dx4upPvPr3zWp5+/H2Zw5iiEJH1As1E8S2QueRyEEsOxlkklC/PMX64GHME5FaBQ=
X-Received: from plnu12.prod.google.com ([2002:a17:903:1a4c:b0:223:3ab:e4a0])
 (user=nabihestefan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d4cc:b0:21f:4649:fd49 with SMTP id
 d9443c01a7336-22fc918c219mr16055905ad.49.1746744318087; 
 Thu, 08 May 2025 15:45:18 -0700 (PDT)
Date: Thu,  8 May 2025 22:45:13 +0000
In-Reply-To: <20250508224514.805456-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20250508224514.805456-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250508224514.805456-2-nabihestefan@google.com>
Subject: [PATCH 1/2] gdbstub: Fix wrong CPUState pointer in breakpoint
 functions
From: Nabih Estefan <nabihestefan@google.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org, 
 philmd@linaro.org, Roque Arcudia Hernandez <roqueh@google.com>, 
 Nabih Estefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3_jMdaAwKCiMM9AHGDRSDE9MFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--nabihestefan.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
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

From: Roque Arcudia Hernandez <roqueh@google.com>

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
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
---
 gdbstub/gdbstub.c   |  4 ++--
 gdbstub/internals.h | 13 +++++++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 565f6b33a9..0e2e10fbaa 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1160,7 +1160,7 @@ static void handle_insert_bp(GArray *params, void *user_ctx)
         return;
     }
 
-    res = gdb_breakpoint_insert(gdbserver_state.c_cpu,
+    res = gdb_breakpoint_insert(gdbserver_state.g_cpu,
                                 gdb_get_cmd_param(params, 0)->val_ul,
                                 gdb_get_cmd_param(params, 1)->val_ull,
                                 gdb_get_cmd_param(params, 2)->val_ull);
@@ -1184,7 +1184,7 @@ static void handle_remove_bp(GArray *params, void *user_ctx)
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
2.49.0.1015.ga840276032-goog



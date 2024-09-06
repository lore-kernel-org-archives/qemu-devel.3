Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E17E6FE4D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 22:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smhr8-0006jT-Ot; Fri, 06 Sep 2024 18:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3RIjbZgYKCgEsprvfihpphmf.dpnrfnv-efwfmopohov.psh@flex--roqueh.bounces.google.com>)
 id 1smhr6-0006b4-KA
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 18:55:04 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3RIjbZgYKCgEsprvfihpphmf.dpnrfnv-efwfmopohov.psh@flex--roqueh.bounces.google.com>)
 id 1smhr4-0005UH-Sf
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 18:55:04 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-6d7124939beso83220707b3.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 15:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1725663300; x=1726268100; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ykg6BmtRsT6Cx1jWmwUwUzJLj8O9xsEBVsjdsaDi0vE=;
 b=xQUQ/BSBeJJFgkNZ7ddXubrgZxgcpcbj8NydCi6L0P+wbZI7cM1so0Z0Nud9qS4EsD
 2/VUeRE4fL6sk0un0RomykcMOOgY2OaQ8QSGbd6+Egaunc0glUtKGfhJWOPZgIWXeYU5
 04T18TAfuivEuz0RcJM2VbXb3trD7NFHmbq/3oOmbTXDs4eTtmsZLInR8gXAYkej0ueR
 fTi8tQTESSuH3onARZUmGOa4ec7RbDjFRgPVy271c/GQFD3spzn2Rhn2R4dFfBMRf3qK
 ahPkHgX27IClJN9pG1EKMgyeq8s/EoyZdoGDkjuPDZCp4G3H6a1vYkOcDErpj65Fl/YT
 G0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725663300; x=1726268100;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ykg6BmtRsT6Cx1jWmwUwUzJLj8O9xsEBVsjdsaDi0vE=;
 b=FgfXMp9bL/Mzwul1tCEv8RhPhl/Z9nT159XLlbTE4ngSOWG+sfVN1tW/TdDslEugCQ
 gumAgNPIhN4D6WcrYvVQsPCoizCwdyarLiZSQvpCKogESJSmT/kHNyFm3cDUu5ez2+T5
 iulaSe23+jDtwStlb30gQ4dMSi+lX60NIok1zMSDwrGI8LHX9CF5gh4JeFrXyp+br5oJ
 IA05szz98n8Wkh/bpqw5afD47RYvs+CtwQ852DgfZxFVZwAd5i30mg+m3f4E4FNMhyFD
 6gYeVasu06aAzxvZVF6ONfBHaJ6Ktv5XxU9Wq6v6RnB73ubTSIr/S9GeOrqSezjQnlF1
 sAXg==
X-Gm-Message-State: AOJu0YwAlLjjaTEZTFf7RwjyVt1HcgzfaULy5s7LJve2F6Pah/KpoC3E
 LW0SdbAgPuDjSEGstHJ7AeETl6RowSjI/rl+edXiRyy6Wh5wklpvyG+WgNCR94YIgRdvG1vHagr
 +1w==
X-Google-Smtp-Source: AGHT+IHA1vmtUfE9IH8wEtKZ+5T/G7ccOcXvmDKxMc3TAwaRZEDHYTCitYuMBipBn31m8NhhDXnF0eA4DTQ=
X-Received: from roqueh-desktop.svl.corp.google.com
 ([2620:15c:2a3:200:81f3:7a35:4574:5dc])
 (user=roqueh job=sendgmr) by 2002:a25:944:0:b0:e1d:2043:da46 with SMTP id
 3f1490d57ef6-e1d348911ddmr38374276.3.1725663300214; Fri, 06 Sep 2024 15:55:00
 -0700 (PDT)
Date: Fri,  6 Sep 2024 15:54:50 -0700
In-Reply-To: <20240906225451.1039718-1-roqueh@google.com>
Mime-Version: 1.0
References: <20240906225451.1039718-1-roqueh@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240906225451.1039718-2-roqueh@google.com>
Subject: [PATCH 1/2] gdbstub: Fix wrong CPUState pointer in breakpoint
 functions
From: Roque Arcudia Hernandez <roqueh@google.com>
To: richard.henderson@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org, 
 philmd@linaro.org, slongfield@google.com, komlodi@google.com
Cc: qemu-devel@nongnu.org, Roque Arcudia Hernandez <roqueh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3RIjbZgYKCgEsprvfihpphmf.dpnrfnv-efwfmopohov.psh@flex--roqueh.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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

Google-Bug-Id: 355027002
Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
---
 gdbstub/gdbstub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index d08568cea0..98574eba68 100644
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
-- 
2.46.0.469.g59c65b2a67-goog



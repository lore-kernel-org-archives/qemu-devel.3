Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C2ACAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 21:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Ay0-0006IE-SR; Tue, 23 Sep 2025 17:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Axz-0006HK-D6
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 17:54:31 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Axx-0003i5-Aw
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 17:54:31 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-27d3540a43fso14420055ad.3
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 14:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758664467; x=1759269267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tkajwB0LkhYnqCNRGrXzrsBCk6tFlVZCMEBA7S1wExk=;
 b=JhDSt0f8eBFqqStdB35fEZ5T+mfDmbtS2GeENRHs8ek9woPzLYvpDW4v9dQ0o17Tb/
 I+l43R91nAHbMn7hwPBeYRYWh/TOx912K1t2BX2+OY6QksFbKqNLZrY+dQpHCwbDknzs
 CYRWS/XaoIhoryL1hpd5B2YRU2+AE9DpKEtpXkVBL3Zm7t7urmCU3YikjU1fkGjPlofj
 w9KTtZ8BS1S4YQ3cslzyCiUqnx2Ltxnm106+LmlAdTPvomTEqyQhAr6w6XqOeavYaCde
 qQcWHkLyRCuBZldIz3sX8Gsv8H03ZHk3hmgG+r/WsyX55zfOBwjIjHfdpN7PTJti2m+E
 nL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758664467; x=1759269267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tkajwB0LkhYnqCNRGrXzrsBCk6tFlVZCMEBA7S1wExk=;
 b=Ql67K1SQrOkSDqG6e3tvOqjaHHp8xLlWtdQPsGhB83dX87c5egiyeQ9G5bYH/T5K2H
 l6/mOqp+UbcMMgJNe0onzR3VbHCXPTZ641j1//Rq5k5mRQNR2lWo7rDHo2jBwEMDisEd
 Lm1ECrD/I7vMgtG8aHbdx7ml7LdlOUZCQBoiae8Oo7WFk+duDPbvARLKDadTkJC1WgtA
 oIuiKvmPU4+4mzfwbp89HIMBrqgCqYzqqIpnIw1/rLzw4Oq3HL5VLXQOT3qxrqt2CCn/
 zwPQeRNn/Z2sTWk571vG8thmpTI0QYGiJR++Ve7dtEPtvQyWl6GzLXrsmWJ1SlisE6Sx
 08TQ==
X-Gm-Message-State: AOJu0YzLqvtT83ESUFy4/ZA6Ljazk7i5p9MtBvcvMbKtYVplRhkof/Qp
 qYASuyMSIz5bEFolcxou78GRfUwCMfpJqv5OowcFTJ6uT1ofRXYqNcbKlUMtKgpZ/EKQaZl6SiX
 9JduB
X-Gm-Gg: ASbGncup0Rqzjr5jz1sQH1GDDzf9TxSBJjIxrEr+/NlIaHqgYliMMgr5RKbxWeLqZNa
 ZvTJ3ZEsJZ/2FezDfaLchBFAtWwmZMQfq5qSvPRWIZHI+zbOQbFSG4tdgZSlOL879phq9H+uIuL
 K47uEMPAEYYADkzz1e4E1lstmnXdy+VU1FBElj3XP7y5/f6L1NEDKLAX3DjxtCGKqbErJsKF3q0
 BN8RETwZErekAM0zHPYa6BN4raMvkt3fUfKIjEHAgngRcohqzJb1VZyHU4OwfJ3jdwJTRfZPVgF
 lyV1sWRYKVZc222EjxTyQWAXj5SfzyTTJlV8GSPfCzNEF3U5E8E6Uzb/xgXngC3AUMqZR0FvpJd
 2ySSuYJhxR4TQ7/GgN1G2ju38vqMI
X-Google-Smtp-Source: AGHT+IF4e25HHdHJP6TzFOqjb9YsyfUad9ing6qbxJI5i0wA8W92TtkHxS17NU2WHQK+hZ+H7XXcew==
X-Received: by 2002:a17:902:e951:b0:25c:76f1:b024 with SMTP id
 d9443c01a7336-27cc24e015cmr45815735ad.25.1758664467465; 
 Tue, 23 Sep 2025 14:54:27 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-269802e14f1sm168294035ad.71.2025.09.23.14.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 14:54:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 01/10] gdbstub: Remove tb_flush uses
Date: Tue, 23 Sep 2025 14:54:15 -0700
Message-ID: <20250923215425.3685950-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923215425.3685950-1-richard.henderson@linaro.org>
References: <20250923215425.3685950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

This hasn't been needed since d828b92b8a6
("accel/tcg: Introduce CF_BP_PAGE").

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 gdbstub/system.c | 5 -----
 gdbstub/user.c   | 3 ---
 2 files changed, 8 deletions(-)

diff --git a/gdbstub/system.c b/gdbstub/system.c
index 5be0d3c58c..5221c579d9 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -18,13 +18,11 @@
 #include "gdbstub/syscalls.h"
 #include "gdbstub/commands.h"
 #include "exec/hwaddr.h"
-#include "exec/tb-flush.h"
 #include "accel/accel-ops.h"
 #include "accel/accel-cpu-ops.h"
 #include "system/cpus.h"
 #include "system/runstate.h"
 #include "system/replay.h"
-#include "system/tcg.h"
 #include "hw/core/cpu.h"
 #include "hw/cpu/cluster.h"
 #include "hw/boards.h"
@@ -174,9 +172,6 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
         } else {
             trace_gdbstub_hit_break();
         }
-        if (tcg_enabled()) {
-            tb_flush(cpu);
-        }
         ret = GDB_SIGNAL_TRAP;
         break;
     case RUN_STATE_PAUSED:
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 67403e5a25..2e14ded3f0 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -15,7 +15,6 @@
 #include "qemu/sockets.h"
 #include "qapi/error.h"
 #include "exec/hwaddr.h"
-#include "exec/tb-flush.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/commands.h"
 #include "gdbstub/syscalls.h"
@@ -220,7 +219,6 @@ int gdb_handlesig(CPUState *cpu, int sig, const char *reason, void *siginfo,
 
     /* disable single step if it was enabled */
     cpu_single_step(cpu, 0);
-    tb_flush(cpu);
 
     if (sig != 0) {
         gdb_set_stop_cpu(cpu);
@@ -539,7 +537,6 @@ static void disable_gdbstub(CPUState *thread_cpu)
         /* no cpu_watchpoint_remove_all for user-mode */
         cpu_single_step(cpu, 0);
     }
-    tb_flush(thread_cpu);
 }
 
 void gdbserver_fork_end(CPUState *cpu, pid_t pid)
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A39C25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 09:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8GQc-0006Q1-62; Sat, 18 May 2024 05:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8GQU-0006Mb-1l; Sat, 18 May 2024 05:32:26 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8GQO-0005nO-3O; Sat, 18 May 2024 05:32:24 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ee42b97b32so32110515ad.2; 
 Sat, 18 May 2024 02:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716024738; x=1716629538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=usId0Lc202jfAnfSqLrsahzDXKSkcKXOT0TjzknQTYs=;
 b=R+gYyilghIYJlyrxpsa+GtBSuAPsZslTDvI/kqDqn1O4cubpF6yU25o3EL/gTmegUu
 FJXr8TB0NhMXU3/pfnzaBe0v6oQJSR0CFpBA22ZHHgy+gmFWJVt7yfwpfQ6AN92nDd1V
 JiDRZ2iVvmPNRyxuZ2MIa7FqiHxOYvq2OSSL6RPNK2qmVAsxa/oBgIPoe1JAFP4SrghJ
 t3f2EDtoP3tOI+0IhV/bfp0Gf0+ja/f5A0dbt0IA4YV/lz1T4XhUIVtCmWtLJFpvdn2X
 HCK0HjogjS12KiVab1Fqg65+BBCYyu2B+zL+qmD2rlvO+LQTsLkwoBXrlYDwdmKjdNRE
 YacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716024738; x=1716629538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=usId0Lc202jfAnfSqLrsahzDXKSkcKXOT0TjzknQTYs=;
 b=FtvKH3GbdQhHTx+hQj3YYjvcasphIbGSJz+nZHJgA24noxJHfuSFmZ4blHVAZN1cGk
 cFvo4iTJkrcaHc7BsDVaNJEeb3bA6g80z6IFNrc3+wiB1jSM6sHMz1mPjW0TYJ0djCJi
 Ljtp20gSJhmwnL9fx1G/XEPf0LYrcUbq8NdlLxIc7IeaYHhMms1cn0K/skVAVE+rp1q7
 MgZ8i81JwTFI10BRdYtQuIsgliR1/4o48PVyrrEGW+glie3aeAENFuJILycKvI9DKlkm
 G6Rr4qRtj4X4GUTiT4RVJkYvdsJyMCYSt4FlkO2gv4vodONO+XsVkkIY1crtu7tmC7xw
 4KzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSY/M237tffIO+ZX3ZPeu08VOy87Nl9UshNZQibO1ABJbGknjBJcOwUds8pQNyEJFexYxSJP0Y+QJ46iH4Oyc+JNBehqU=
X-Gm-Message-State: AOJu0YyjJWlJlX1he9QC9HgFOWwazrJb6UFPctYjV4bizpLm/uaqNQU7
 LjXF/FgaxHSe1VVLLdgueLR0QrivZyooTV+5Yr9+GP30KDM9oD9zR2DhDA==
X-Google-Smtp-Source: AGHT+IG4gBQf3huoEGmX0EjI343YhBArR7mukcvm6haRtMGnZnQ9FFmjLMe+XZnF2SH5GrP9HDp81g==
X-Received: by 2002:a17:90b:696:b0:29b:b5a4:c040 with SMTP id
 98e67ed59e1d1-2b6cd1f0510mr20912068a91.46.1716024738149; 
 Sat, 18 May 2024 02:32:18 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b628ea6a05sm18518901a91.52.2024.05.18.02.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 May 2024 02:32:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PATCH 03/14] target/ppc: Make checkstop actually stop the system
Date: Sat, 18 May 2024 19:31:45 +1000
Message-ID: <20240518093157.407144-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240518093157.407144-1-npiggin@gmail.com>
References: <20240518093157.407144-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

checkstop state does not halt the system, interrupts continue to be
serviced, and other CPUs run. Make it stop the machine with
qemu_system_guest_panicked.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 2e3f36a3ef..fd00c044b5 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -19,6 +19,8 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "qemu/log.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "internal.h"
@@ -425,6 +427,8 @@ static void powerpc_set_excp_state(PowerPCCPU *cpu, target_ulong vector,
 
 static void powerpc_mcheck_checkstop(CPUPPCState *env)
 {
+    /* KVM guests always have MSR[ME] enabled */
+#ifdef CONFIG_TCG
     CPUState *cs = env_cpu(env);
 
     if (FIELD_EX64(env->msr, MSR, ME)) {
@@ -437,9 +441,15 @@ static void powerpc_mcheck_checkstop(CPUPPCState *env)
     if (qemu_log_separate()) {
         qemu_log("Machine check while not allowed. "
                  "Entering checkstop state\n");
-    }
-    cs->halted = 1;
-    cpu_interrupt_exittb(cs);
+
+    /*
+     * This stops the machine and logs CPU state without killing QEMU
+     * (like cpu_abort()) so the machine can still be debugged (because
+     * it is often a guest error).
+     */
+    qemu_system_guest_panicked(NULL);
+    cpu_loop_exit_noexc(cs);
+#endif
 }
 
 static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
-- 
2.43.0



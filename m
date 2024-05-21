Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F643C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 01:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ELD-0007h7-4l; Mon, 20 May 2024 21:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9EL2-0007eP-9R; Mon, 20 May 2024 21:30:52 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9EKy-0005J1-SG; Mon, 20 May 2024 21:30:46 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1ec486198b6so86363015ad.1; 
 Mon, 20 May 2024 18:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716255042; x=1716859842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8bJqKySc80avuNyu9z8N9jqGjQygsej/MCRmpsZm7nw=;
 b=Htww+7+9K++kAwkWI2NOwwvbwaGhpNNgLoeEQKe/HJMHPvNqLoZ/a4B0J27vqJFfKC
 f0TsIdmi+OzWimoWff5Wsj2R1cTHECFpxOhmYvhrBSDCK7dAig3K/Mo5aOFfmuODC/0y
 e4uxHyk9H8MKj9GhbnvBp0Pjg31aqypZvHOM2pXwq/fCvc/wRRnANkjwKi20PNFY1RBD
 bYIwevwtrWy2f2tQOp8zdRT7BMdgprVnKF2oIsonBIzJweYhGl2pVpfjBwJaMHzesv8a
 YCJ1ZjfgspJudidCIzE4GBF/+uY5RMh43b9+rdss0KhbMD2bmiM6nhWpT6LcW+S1zlju
 VrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716255042; x=1716859842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8bJqKySc80avuNyu9z8N9jqGjQygsej/MCRmpsZm7nw=;
 b=ChVhEthPKGxoCiZmD9BGnABz+IPZ06e9FAyKHL0XQ16uppGg5SzuZq5Z2vadkHGSCu
 gfKEpnfluzor34NfqP106x7zbauq1BzNteRpukDzd/eecYm6oA+EY/i1sPTzVMVgij8C
 zw10yyZeOIeKv9i2An8sV7TL0xQNjd5rqwgYneA2MjS1InIMe5aY2dnl2r5I68NVUw0v
 qX+Bguut1ew4vkkTXsuilPtikB1HnvKP9MAj8OKj9tYt8clnhkhxkAWob8ygZD1+oOct
 5fDCVqCD5ket5svg3E5WlDj9z5KfH5VcrCEiekAvsMe+Qn6iSmfUVaGNGVjJle75YMNx
 AxMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZdwK9g0FstDYXQeV4jKjCPSdCxQvSqN0o2I8ohLraYtAxcog/I0Yy4CX+zhshGxtJ2o1kjxJqXFrY4F6OtxO/43WAqs0=
X-Gm-Message-State: AOJu0Yw86l3K8x36J9mjCva+JstROhpDMfCo3t5SMQ2HctTMHkcgMpOj
 zZcVV1hmqF5LKjP7WYevWa4250KdytaUWGgAyuOC9+Ss08kJumce5zvfkw==
X-Google-Smtp-Source: AGHT+IFXDbjSukV5fQmIxhDS/57UrdTeRZfX0Ut0fkv2FwETnFN87p+/u6KefoSiiuJPO1q/r/o4fg==
X-Received: by 2002:a05:6a21:3408:b0:1af:b311:6a70 with SMTP id
 adf61e73a8af0-1afde1159damr27485624637.27.1716255041964; 
 Mon, 20 May 2024 18:30:41 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bd7f0cd400sm2514953a91.31.2024.05.20.18.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 May 2024 18:30:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 01/12] target/ppc: Make checkstop actually stop the system
Date: Tue, 21 May 2024 11:30:17 +1000
Message-ID: <20240521013029.30082-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240521013029.30082-1-npiggin@gmail.com>
References: <20240521013029.30082-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

checkstop state does not halt the system, interrupts continue to be
serviced, and other CPUs run. Make it stop the machine with
qemu_system_guest_panicked.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 3be086d10b..b2b51537b7 100644
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



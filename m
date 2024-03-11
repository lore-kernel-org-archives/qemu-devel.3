Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CB2C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjfl-0005X1-Ay; Mon, 11 Mar 2024 13:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjjfg-0005Cq-Fx; Mon, 11 Mar 2024 13:42:44 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjjfe-0007VU-Da; Mon, 11 Mar 2024 13:42:44 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6da202aa138so2990027b3a.2; 
 Mon, 11 Mar 2024 10:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710178960; x=1710783760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+gGhZ4pjanpiywqqalSDcdpCIXre6mE3lC/dQog4JF4=;
 b=SFe1KojstCtfTIF8cNIyZSLX3o7CuCySBqintVPwfvynw3ReiQMHWcKqxBHs1O8ZAO
 TS1D3JajvQs+P/TjDQHkkxSPS2H6glMpkMVip1EaoPLTE9dlOO+nIKqfBYzTma6Tqeek
 xkFoH7GegiVxPWndi2UZxOw/84elTnEaEXN9e1TIYjgUsDm6muhbs2pY+a0SqjEkzJYF
 12plJMqwbOzZdMWxaOaWf64T7DJKibv1XVowJ4B99QZ4ps1P5UPQgj3kCH93xG7ECRPW
 4d/P6qUo2rh39Xl5nsgEo/09jxnxFlAPhDEB+Zf5U3yZKZnFvd9sEpZkm8SbpYXkYjLS
 1scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710178960; x=1710783760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+gGhZ4pjanpiywqqalSDcdpCIXre6mE3lC/dQog4JF4=;
 b=CYa8UegP4KyktNbvmE2lLD4X1LjTyXrv4js+YGF8IVluYr5+j1R9sBa3VqVktcM0gl
 dagaaVhw/YJhPSpK4SCXEmwLaeFGjHrXamPUHM0HwrnulWYGTxCcodpVocLg/yL1LFIQ
 UHUmJJxEOPtWVV5EFGoSYUsDBuh+BKcn1c97Kp4Xadwue9pZASt8NFYcLLE/MpXNO83K
 p0JKf+Wly2a3f2Hr8rDJC3nKvVNfnjzFPvqf3U43risdLwR0ZSGKSJH0bc7o7wVqin9e
 e9XP9pMluwVlyfUoEWS97aa4SlJfH8wto7Scs2S36kN9vabbVK7YbT59YUmzvtpoWeiY
 o7pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0DbxxwTQJKFmSIxLnFida4zSkf3nW5ymAEvlbGe5VLg1H/JBQGFMxrQICxXsvzVRQ1s4x5y3+3qTZXK+osfrMXqRZ
X-Gm-Message-State: AOJu0Yy2xw53fA3s34bxVTLGSLJV74PWtEO009VXxn7GQnCKBjBk63XX
 j3Gx67FkbCS831FeChcjXUm6RXo2EWr5TwEvBDwBiqt0KKakyG0BoFPna0y5RkE=
X-Google-Smtp-Source: AGHT+IFXpF4I/OuGKg9bdj1uNNtQuY5XO0v1eM0+8uA0NMFwCIaow87hNqPWip66hzVEjuJrbOVthA==
X-Received: by 2002:a05:6a20:258f:b0:1a0:f5b9:bd88 with SMTP id
 k15-20020a056a20258f00b001a0f5b9bd88mr10137112pzd.55.1710178960293; 
 Mon, 11 Mar 2024 10:42:40 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a62d412000000b006e67b4d7b74sm4593187pfh.197.2024.03.11.10.42.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 10:42:40 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-ppc@nongnu.org
Subject: [PATCH v4 23/24] spapr: Fix vpa dispatch count for record-replay
Date: Tue, 12 Mar 2024 03:40:25 +1000
Message-ID: <20240311174026.2177152-24-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311174026.2177152-1-npiggin@gmail.com>
References: <20240311174026.2177152-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The dispatch count is a field in guest memory that the hypervisor
increments when preempting and dispatching the guest. This was not
being done deterministically with respect to icount, because tcg
exec exit is not deterministic (e.g., an async event could cause it).

Change vpa dispatch count increment to keep track of whether the
vCPU is considered dispatched or not, and only consider it preempted
when calling cede / confer / join / stop-self / etc.

Cc: qemu-ppc@nongnu.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/spapr_cpu_core.h |  3 +++
 hw/ppc/spapr.c                  | 36 ++-------------------------------
 hw/ppc/spapr_hcall.c            | 33 ++++++++++++++++++++++++++++++
 hw/ppc/spapr_rtas.c             |  1 +
 4 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
index 69a52e39b8..5feb0ecc2a 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -47,6 +47,7 @@ typedef struct SpaprCpuState {
     uint64_t vpa_addr;
     uint64_t slb_shadow_addr, slb_shadow_size;
     uint64_t dtl_addr, dtl_size;
+    bool dispatched; /* for vpa dispatch counter tracking */
     bool prod; /* not migrated, only used to improve dispatch latencies */
     struct ICPState *icp;
     struct XiveTCTX *tctx;
@@ -61,4 +62,6 @@ static inline SpaprCpuState *spapr_cpu_state(PowerPCCPU *cpu)
     return (SpaprCpuState *)cpu->machine_data;
 }
 
+void vpa_dispatch(CPUState *cs, SpaprCpuState *spapr_cpu, bool dispatch);
+
 #endif
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 55263f0815..28ce5f263a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4572,47 +4572,15 @@ static void spapr_cpu_exec_enter(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)
 {
     SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
 
-    /* These are only called by TCG, KVM maintains dispatch state */
-
     spapr_cpu->prod = false;
-    if (spapr_cpu->vpa_addr) {
+    if (!spapr_cpu->dispatched) {
         CPUState *cs = CPU(cpu);
-        uint32_t dispatch;
-
-        dispatch = ldl_be_phys(cs->as,
-                               spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER);
-        dispatch++;
-        if ((dispatch & 1) != 0) {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "VPA: incorrect dispatch counter value for "
-                          "dispatched partition %u, correcting.\n", dispatch);
-            dispatch++;
-        }
-        stl_be_phys(cs->as,
-                    spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER, dispatch);
+        vpa_dispatch(cs, spapr_cpu, true);
     }
 }
 
 static void spapr_cpu_exec_exit(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)
 {
-    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
-
-    if (spapr_cpu->vpa_addr) {
-        CPUState *cs = CPU(cpu);
-        uint32_t dispatch;
-
-        dispatch = ldl_be_phys(cs->as,
-                               spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER);
-        dispatch++;
-        if ((dispatch & 1) != 1) {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "VPA: incorrect dispatch counter value for "
-                          "preempted partition %u, correcting.\n", dispatch);
-            dispatch++;
-        }
-        stl_be_phys(cs->as,
-                    spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER, dispatch);
-    }
 }
 
 static void spapr_machine_class_init(ObjectClass *oc, void *data)
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 75c2d12978..5f68c02739 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -487,6 +487,36 @@ static target_ulong h_register_vpa(PowerPCCPU *cpu, SpaprMachineState *spapr,
     return ret;
 }
 
+void vpa_dispatch(CPUState *cs, SpaprCpuState *spapr_cpu, bool dispatch)
+{
+    uint32_t counter;
+
+    if (!dispatch) {
+        assert(spapr_cpu->dispatched);
+    } else {
+        assert(!spapr_cpu->dispatched);
+    }
+    spapr_cpu->dispatched = dispatch;
+
+    return;
+
+    if (!spapr_cpu->vpa_addr) {
+        return;
+    }
+
+    /* These are only called by TCG, KVM maintains dispatch state */
+    counter = ldl_be_phys(cs->as, spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER);
+    counter++;
+    if ((counter & 1) != dispatch) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "VPA: incorrect dispatch counter value for "
+                      "%s partition %u, correcting.\n",
+                      dispatch ? "preempted" : "running", counter);
+        counter++;
+    }
+    stl_be_phys(cs->as, spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER, counter);
+}
+
 static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
@@ -505,6 +535,7 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
 
     if (!cpu_has_work(cs)) {
         cs->halted = 1;
+        vpa_dispatch(cs, spapr_cpu, false);
         cs->exception_index = EXCP_HLT;
         cs->exit_request = 1;
         ppc_maybe_interrupt(env);
@@ -531,6 +562,8 @@ static target_ulong h_confer_self(PowerPCCPU *cpu)
     cs->exit_request = 1;
     ppc_maybe_interrupt(&cpu->env);
 
+    vpa_dispatch(cs, spapr_cpu, false);
+
     return H_SUCCESS;
 }
 
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index f329693c55..8ce4230223 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -216,6 +216,7 @@ static void rtas_stop_self(PowerPCCPU *cpu, SpaprMachineState *spapr,
      */
     env->spr[SPR_PSSCR] |= PSSCR_EC;
     cs->halted = 1;
+    vpa_dispatch(cs, spapr_cpu_state(cpu), false);
     ppc_store_lpcr(cpu, env->spr[SPR_LPCR] & ~pcc->lpcr_pm);
     kvmppc_set_reg_ppc_online(cpu, 0);
     qemu_cpu_kick(cs);
-- 
2.42.0



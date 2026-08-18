Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB1BC5DF80
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 02:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww9U2-0007WG-7S; Mon, 17 Aug 2026 22:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1ww9U1-0007Vs-0H
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 22:23:21 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1ww9Tx-0008Lo-Vs
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 22:23:20 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2ceab75934dso49854465ad.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 19:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787019796; x=1787624596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q/KWBh97lxNNolqPEZ3B0lZqp0Q3PZSRmsAh+Ol8ZPc=;
 b=SgRtXVPsAAoMQD3BQJhHncxpiQZkoQ/bfPepYW+lYhftzuKQd3fE8PpmXqhZ6Lw59a
 HXr4RWxUIpZFkP9J4/zIuWWqFrd/pMaZWG1xc/98HD24R7cn+GKNBO8n0WpZPw9Kdsg+
 bT+UsDH7Dt5Bj0mIxeBPSNDuAxG6+KAOwEApXyNz3mkWK2lJs444ryprGu0YG4zI0Ax7
 hEVcfnEnQKO+iY0FInCGzbi3SoE+1nQZSe0DgZAUnUn7UaPN/m8xfI04RikdrQ2mJJYU
 /f0uuSIxtY8UBszKFkhQlDSL+L1sb/mJd4elqjgtrtJelGdrtJAZQoJnSDEQSopI+lBI
 zjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787019796; x=1787624596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q/KWBh97lxNNolqPEZ3B0lZqp0Q3PZSRmsAh+Ol8ZPc=;
 b=nkFCU4z0/bURGR2WVUrNjbI3O7lUDLLbUxlSV9g80ElwCSXuHC8Iku5elUb8sbwaGQ
 8Gv8ygBtJSupJv13wY4B89OrPlrVMduvYXFaTJ8UjGT4IY46h5b59AgxICy0+T71joE8
 Znzubf/6vxXWFdrFrVpaIBf3WZvv8+rW/AZERJNspbUBvMG1XVcqBusL9to/R7nGO7Mb
 sRrqjMGy38B3CZxkyPBVBbTdw/5mAyi26PnW9Ke2TZP91dittScXx+eJUUFT0/hGHkY0
 mU03XmomhaksRm1a+VVLGeGyT6X3Nv4/s9bryIWp1B/fDsMKxHpVSdAWxEh8XM+k5xQS
 xRYw==
X-Gm-Message-State: AOJu0YwIcm1yQEhIXSoDs0bHvUXNv3RZlRMjlUVOtAmEm2fxGSZufk07
 kqqG/pDHrMInlbvB/8d6Valf1tJaxkrTrkN1Uw7Fho4w3ggrm0M2n+u/c2gfAw==
X-Gm-Gg: AR+sD12EPIXfzuZJNeSHbhKGjREaytTtTw7ZI+3a53xIujVkEJG+RMHnxEHyJXo78uG
 LP3Jaleg18VJMXHxvTvR4C7U7ZXevVDVYnEfdmot19KuSv3+0atdaiH4gMswSirk3gLRaxrVO5W
 0D4XtFwYlsRDf3gtm/eZVPsm1xtYDbcqgcl/j19VTbXTkjiAHnklz4KthavxgO7E+P2W3/U0iyb
 hHnjx2ZLO19YXCbtHSDU/+FoZtnYVrqfXqIptnFM/r6Oswp8lWBhRTZlrsGDFzLroXq77SgcNNP
 /VmB4RJgpK6mUkgaL9nNG9SaUICy6cpu2J2mtMFTm+it3euBligbk/Z+IkLwLDwazFSHXz9fSRU
 cYzvKZCzbsREWveXsU5JFw2mYNz88l5pZnHOp/5EVmxx4Ln1ei8dIz+0WkvAtFyBGxmeaPve44/
 i1QBIT3q6ELrba24LrBfwrD05csgL6LLNLleQ3z89EMK0E9kSTyl8zsqa50pRF0t2NIOG2PRlK7
 1kj
X-Received: by 2002:a17:903:46c3:b0:2ce:9c48:22d3 with SMTP id
 d9443c01a7336-2d3b0e4384amr353363885ad.11.1787019796364; 
 Mon, 17 Aug 2026 19:23:16 -0700 (PDT)
Received: from newsled.lan ([76.133.142.170]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c389363sm10897816eec.23.2026.08.17.19.23.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Aug 2026 19:23:16 -0700 (PDT)
From: 54weasels <54weasels@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	54weasels <54weasels@gmail.com>
Subject: [PATCH v4 6/6] target/m68k: Implement Physical Bus Error and Stack
Date: Mon, 17 Aug 2026 19:22:22 -0700
Message-ID: <20260818022225.31801-7-54weasels@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260818022225.31801-1-54weasels@gmail.com>
References: <20260818022225.31801-1-54weasels@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=54weasels@gmail.com; helo=mail-pl1-x636.google.com
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

High level description:
Physical memory timeouts (e.g., probing unpopulated memory locations) must generate a Bus Error exception, resulting in Format 0xA or 0xB stack frames on the 68020. The Sun-3 PROM probes memory sizes by intentionally causing bus errors and analyzing the Special Status Word (SSW) on the stack frame. This patch implements hardware-injected EXCP_ACCESS cycle generation and the corresponding 84-byte long stack frame teardown.

Impact on existing functionality:
Accurately populates the 68020 84-byte SSW stack frames. Older architectures (like 68000) safely ignore the hook and gracefully exit without generating the advanced frames.

Context: This patch was originally submitted as part of the monolithic Sun-3 Machine Emulation series (https://patchew.org/QEMU/20260503015756.99176-1-54weasels@gmail.com/) and has been split into atomic components.
---
 target/m68k/helper.c    |   1 +
 target/m68k/op_helper.c | 161 +++++++++++++++++++++++++++-------------
 2 files changed, 109 insertions(+), 53 deletions(-)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 1eef6dcaaf..abfbcead69 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -29,6 +29,7 @@
 #include "system/memory.h"
 #include "gdbstub/helpers.h"
 #include "fpu/softfloat.h"
+#include "qemu/log.h"
 #include "qemu/qemu-print.h"
 
 #define SIGNBIT (1u << 31)
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 30af4a2631..1d4b244416 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -26,6 +26,7 @@
 #include "qemu/plugin.h"
 
 #if !defined(CONFIG_USER_ONLY)
+#include "system/runstate.h"
 
 static void cf_rte(CPUM68KState *env)
 {
@@ -74,6 +75,12 @@ throwaway:
         case 7:
             sp += 52;
             break;
+        case 0xa: /* Short Bus Cycle Fault (Format 0xA) */
+            sp += 32 - 8; /* 32 bytes total - 8 bytes header = 24 bytes */
+            break;
+        case 0xb: /* Long Bus Cycle Fault (Format 0xB) */
+            sp += 92 - 8; /* 92 bytes total - 8 bytes header = 84 bytes */
+            break;
         }
     }
     env->aregs[7] = sp;
@@ -343,56 +350,80 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
     switch (cs->exception_index) {
     case EXCP_ACCESS:
         if (env->mmu.fault) {
-            cpu_abort(cs, "DOUBLE MMU FAULT\n");
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "M68K: Double MMU Fault. Halting CPU and requesting reset.\n");
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+            cs->halted = 1;
+            cs->exception_index = EXCP_HLT;
+            cpu_loop_exit(cs);
         }
         env->mmu.fault = true;
-        /* push data 3 */
-        sp -= 4;
-        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
-        /* push data 2 */
-        sp -= 4;
-        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
-        /* push data 1 */
-        sp -= 4;
-        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
-        /* write back 1 / push data 0 */
-        sp -= 4;
-        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
-        /* write back 1 address */
-        sp -= 4;
-        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
-        /* write back 2 data */
-        sp -= 4;
-        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
-        /* write back 2 address */
-        sp -= 4;
-        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
-        /* write back 3 data */
-        sp -= 4;
-        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
-        /* write back 3 address */
-        sp -= 4;
-        cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
-        /* fault address */
-        sp -= 4;
-        cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
-        /* write back 1 status */
-        sp -= 2;
-        cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
-        /* write back 2 status */
-        sp -= 2;
-        cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
-        /* write back 3 status */
-        sp -= 2;
-        cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
-        /* special status word */
-        sp -= 2;
-        cpu_stw_be_mmuidx_ra(env, sp, env->mmu.ssw, MMU_KERNEL_IDX, 0);
-        /* effective address */
-        sp -= 4;
-        cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
-
-        do_stack_frame(env, &sp, 7, oldsr, 0, env->pc);
+
+        if (m68k_feature(env, M68K_FEATURE_M68040)) {
+            /* push data 3 */
+            sp -= 4;
+            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+            /* push data 2 */
+            sp -= 4;
+            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+            /* push data 1 */
+            sp -= 4;
+            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+            /* write back 1 / push data 0 */
+            sp -= 4;
+            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+            /* write back 1 address */
+            sp -= 4;
+            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+            /* write back 2 data */
+            sp -= 4;
+            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+            /* write back 2 address */
+            sp -= 4;
+            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+            /* write back 3 data */
+            sp -= 4;
+            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+            /* write back 3 address */
+            sp -= 4;
+            cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
+            /* fault address */
+            sp -= 4;
+            cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
+            /* write back 1 status */
+            sp -= 2;
+            cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+            /* write back 2 status */
+            sp -= 2;
+            cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+            /* write back 3 status */
+            sp -= 2;
+            cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
+            /* special status word */
+            sp -= 2;
+            cpu_stw_be_mmuidx_ra(env, sp, env->mmu.ssw, MMU_KERNEL_IDX, 0);
+            /* effective address */
+            sp -= 4;
+            cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
+
+            do_stack_frame(env, &sp, 7, oldsr, 0, env->pc);
+        } else {
+            /* M68020 Long Bus Cycle Fault (Format 0xB) */
+            /*
+             * 84 bytes of internal state are pushed before the generic
+             * 8-byte header
+             */
+            sp -= 84;
+            for (int i = 0; i < 84; i += 4) {
+                cpu_stl_be_mmuidx_ra(env, sp + i, 0, MMU_KERNEL_IDX, 0);
+            }
+            /* Offset 0x02 from internal frame: SSW */
+            cpu_stw_be_mmuidx_ra(env, sp + 2, env->mmu.ssw, MMU_KERNEL_IDX, 0);
+            /* Offset 0x08 from internal frame: Fault Address */
+            cpu_stl_be_mmuidx_ra(env, sp + 8, env->mmu.ar, MMU_KERNEL_IDX, 0);
+
+            do_stack_frame(env, &sp, 0xb, oldsr, 0, env->pc);
+        }
         env->mmu.fault = false;
         if (qemu_loglevel_mask(CPU_LOG_INT)) {
             qemu_log("            "
@@ -438,7 +469,9 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
 
     env->aregs[7] = sp;
     /* Jump to vector.  */
+    env->mmu.fault = true;
     env->pc = cpu_ldl_be_mmuidx_ra(env, env->vbr + vector, MMU_KERNEL_IDX, 0);
+    env->mmu.fault = false;
 
     do_plugin_vcpu_interrupt_cb(cs, last_pc);
 }
@@ -510,12 +543,34 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
         if (access_type != MMU_DATA_STORE) {
             env->mmu.ssw |= M68K_RW_040;
         }
-
-        env->mmu.ar = addr;
-
-        cs->exception_index = EXCP_ACCESS;
-        cpu_loop_exit(cs);
+    } else if (m68k_feature(env, M68K_FEATURE_M68020)) {
+        /*
+         * M68020 Long Bus Cycle Fault (Format 0xB).
+         * The Motorola 68020 hardware intrinsically generates a physical
+         * Bus Error exception whenever the system bus flags a transaction
+         * timeout or failure (e.g., attempting to read an unpopulated bus
+         * address). This natively injects the EXCP_ACCESS cycle to build
+         * the generic 84-byte exception stack frame.
+         */
+        env->mmu.ssw = 0;
+        if (access_type == MMU_INST_FETCH) {
+            env->mmu.ssw |= 0x1000;
+        } else if (access_type == MMU_DATA_STORE) {
+            env->mmu.ssw |= 0x0040;
+        } else {
+            env->mmu.ssw |= 0x0080;
+        }
+    } else {
+        /*
+         * Older architectures (e.g. 68000) do not currently support
+         * hardware-injected transaction failures in QEMU.
+         */
+        return;
     }
+
+    env->mmu.ar = addr;
+    cs->exception_index = EXCP_ACCESS;
+    cpu_loop_exit(cs);
 }
 
 bool m68k_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
-- 
2.50.1 (Apple Git-155)



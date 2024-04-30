Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D01BC19F53
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 14:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1o2g-0002eW-W1; Tue, 30 Apr 2024 10:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1o2U-0002Yv-7u
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:01:05 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1o2O-0002uI-MS
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:00:54 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2d858501412so73687181fa.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 07:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714485649; x=1715090449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pdw4e1T+XOnjRYbe6abw8/6ufHXzK4jmHY6mtjifRb8=;
 b=COx0NkUKj6lNJihspMIjN8j+xzj7zsugmcVCAO++jt7IcUNHfCUBJDIkQHBJ512o/B
 oIZRL33quWqdEwO6FQf+gp6yV9am0IwyucIedOefLzxzTZGKcc5iXQMDwGQoULYfN6OX
 OTWkvuBBQBzUYs/7w/ye/ytXk2fl2vN9hq5ts10qRcqUPqmHIVKSsH61vxNxWb3PM9hx
 cSS83+/t/H6RfheAaoHw+dfYinfJlxJtfAjnNI6AMVhyxm2NDErdYkYuILCfzOhuR5gq
 HREh2J8+BlOLTM48TS6r8m3BVXVJ/0VGgn2VwgzJnmjKMuRSzuzO+8Qeo/EwdicxGxdS
 YCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714485649; x=1715090449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pdw4e1T+XOnjRYbe6abw8/6ufHXzK4jmHY6mtjifRb8=;
 b=cRTfF2pJWg+Qsm2DHA1LRfy7pBvBDr9ZnRIMeVNpsELkL32IFS1Q9zzZoDM7yz4d8J
 N3YjIUDP5wtJ7qn3tNCMwTvrEHIC1q/vCaTPEWSvB9JMXK1OBlurJb1Z3AML9xoiYrJN
 gvbmteO+1mo8T+ORCnrCrpvGdms3tNEZ7uHtJvRLxRXTZrpXSVHpmrFOyl5Jlbtfk7/R
 l9UxL97SOqsKfiSUi8sCQV5R71F2Ka7aX7SM9cSwKyLVNWMcVivadqfHDpkjxlRzGPtS
 hsZ+UATafShlGIhLtloqXdMVPlpKr2Vr1+ttVVwnmsqdgIvBa/07lbuOhn/qaM2ktChh
 h+Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAZpl/uI26GybRENxmE/C1cw6Do2lpc+xcAc0W4BQO/n5nbI4LOocVnrdAf5jS6/CzsCQRRv8RG0Alc/s6etjrNIzdlsw=
X-Gm-Message-State: AOJu0YwvCA2fxVARhSr+QN4DJpCW8x1IRhT/x8EGYg00HnRp0bH2CR5Y
 T5vUt/NXxaRO2Xjfr6ju/E0Jj06dQe+7isDkuz4fW/A7UdYnboiE9qNsRKWln2s=
X-Google-Smtp-Source: AGHT+IEsTGmMapbltK7kkGYZNFd1bpQf4P7h2Jf6zSs3cOqpuxYS8Rya8Gr+z5du5uXvZHlzLK4fOg==
X-Received: by 2002:a2e:8750:0:b0:2de:25e2:6187 with SMTP id
 q16-20020a2e8750000000b002de25e26187mr1967189ljj.23.1714485639231; 
 Tue, 30 Apr 2024 07:00:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a05600c470a00b0041bfa349cadsm11062705wmo.16.2024.04.30.07.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 07:00:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/2] accel/tcg: Make TCGCPUOps::cpu_exec_halt return bool for
 whether to halt
Date: Tue, 30 Apr 2024 15:00:34 +0100
Message-Id: <20240430140035.3889879-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430140035.3889879-1-peter.maydell@linaro.org>
References: <20240430140035.3889879-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22c.google.com
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

The TCGCPUOps::cpu_exec_halt method is called from cpu_handle_halt()
when the CPU is halted, so that a target CPU emulation can do
anything target-specific it needs to do.  (At the moment we only use
this on i386.)

The current specification of the method doesn't allow the target
specific code to do something different if the CPU is about to come
out of the halt state, because cpu_handle_halt() only determines this
after the method has returned.  (If the method called cpu_has_work()
itself this would introduce a potential race if an interrupt arrived
between the target's method implementation checking and
cpu_handle_halt() repeating the check.)

Change the definition of the method so that it returns a bool to
tell cpu_handle_halt() whether to stay in halt or not.

We will want this for the Arm target, where FEAT_WFxT wants to do
some work only for the case where the CPU is in halt but about to
leave it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/core/tcg-cpu-ops.h       | 11 +++++++++--
 target/i386/tcg/helper-tcg.h        |  2 +-
 accel/tcg/cpu-exec.c                |  7 +++++--
 target/i386/tcg/sysemu/seg_helper.c |  3 ++-
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index dc1f16a9777..f3ac76e6f6d 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -111,8 +111,15 @@ struct TCGCPUOps {
     void (*do_interrupt)(CPUState *cpu);
     /** @cpu_exec_interrupt: Callback for processing interrupts in cpu_exec */
     bool (*cpu_exec_interrupt)(CPUState *cpu, int interrupt_request);
-    /** @cpu_exec_halt: Callback for handling halt in cpu_exec */
-    void (*cpu_exec_halt)(CPUState *cpu);
+    /**
+     * @cpu_exec_halt: Callback for handling halt in cpu_exec.
+     *
+     * Return true to indicate that the CPU should now leave halt, false
+     * if it should remain in the halted state.
+     * If this method is not provided, the default is to leave halt
+     * if cpu_has_work() returns true.
+     */
+    bool (*cpu_exec_halt)(CPUState *cpu);
     /**
      * @tlb_fill: Handle a softmmu tlb miss
      *
diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index effc2c1c984..85957943bf3 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -39,7 +39,7 @@ QEMU_BUILD_BUG_ON(TCG_PHYS_ADDR_BITS > TARGET_PHYS_ADDR_SPACE_BITS);
  */
 void x86_cpu_do_interrupt(CPUState *cpu);
 #ifndef CONFIG_USER_ONLY
-void x86_cpu_exec_halt(CPUState *cpu);
+bool x86_cpu_exec_halt(CPUState *cpu);
 bool x86_need_replay_interrupt(int interrupt_request);
 bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
 #endif
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 5c70748060a..550f93b19ce 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -669,11 +669,14 @@ static inline bool cpu_handle_halt(CPUState *cpu)
 #ifndef CONFIG_USER_ONLY
     if (cpu->halted) {
         const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
+        bool leave_halt;
 
         if (tcg_ops->cpu_exec_halt) {
-            tcg_ops->cpu_exec_halt(cpu);
+            leave_halt = tcg_ops->cpu_exec_halt(cpu);
+        } else {
+            leave_halt = cpu_has_work(cpu);
         }
-        if (!cpu_has_work(cpu)) {
+        if (!leave_halt) {
             return true;
         }
 
diff --git a/target/i386/tcg/sysemu/seg_helper.c b/target/i386/tcg/sysemu/seg_helper.c
index 2db8083748e..9ba94deb3aa 100644
--- a/target/i386/tcg/sysemu/seg_helper.c
+++ b/target/i386/tcg/sysemu/seg_helper.c
@@ -128,7 +128,7 @@ void x86_cpu_do_interrupt(CPUState *cs)
     }
 }
 
-void x86_cpu_exec_halt(CPUState *cpu)
+bool x86_cpu_exec_halt(CPUState *cpu)
 {
     if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
         X86CPU *x86_cpu = X86_CPU(cpu);
@@ -138,6 +138,7 @@ void x86_cpu_exec_halt(CPUState *cpu)
         cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
         bql_unlock();
     }
+    return cpu_has_work(cpu);
 }
 
 bool x86_need_replay_interrupt(int interrupt_request)
-- 
2.34.1



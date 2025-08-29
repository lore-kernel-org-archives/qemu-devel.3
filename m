Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A01DCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNOe-0004Bj-5n; Sat, 30 Aug 2025 11:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us152-0001tD-4s
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us14y-0000YM-0Z
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756481507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ri8tfaP+olN7gHTTVouP5IWTFfLQvvzUr0uPOKLPHA=;
 b=jJg8H034XAx16Du2bB0OMsawkxjA3uPM+mJazS/MuDtWmRuPMsj6rIQDTzA4BPt6fkHicw
 RzGN3YObuUcN5TRtx56oZuKSIg+pWPTfJBb7hcNo7rQqHnfZt/BvhS9RNpDAFhC1MN35mW
 Ak0dtrqGe4m5/mQDtyFKAylnwEhd9Rk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-RkCHi1CYPRezFAKjQhBlUQ-1; Fri, 29 Aug 2025 11:31:43 -0400
X-MC-Unique: RkCHi1CYPRezFAKjQhBlUQ-1
X-Mimecast-MFC-AGG-ID: RkCHi1CYPRezFAKjQhBlUQ_1756481501
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45b7c01a6d3so8352335e9.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 08:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756481500; x=1757086300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ri8tfaP+olN7gHTTVouP5IWTFfLQvvzUr0uPOKLPHA=;
 b=FPvKnI9yxNzDtOc9moMAnd1rCX2IIOdIrWnpNMOTjBmcydhUiDOS1GZ+S9j2rz5H70
 +Y6IppUuO4JENmDCxvTFZvbDTQNyyDMjoZ+B6fB24DcMtHd5CjvtdncAVRk6Cci2cKAl
 9FxU+1fFboc1US05YQMnDzOkhR24D1UCY9AfEouaS1YYDouDHjYmDr23YQMk/8fyJibO
 XXYyS9wY1eB9VA6iMG9witMsdmZw328HrVaUQF5EaoRKrw1Kw/qz1VUDklmZ5xWpFgjD
 CHfMAlw3qB1OdtTKNFeTQ+itYJ1Bm1HSMnkNJuUECvXAr8ckv4aUdiqDpaYqe4cjRDwn
 LZyA==
X-Gm-Message-State: AOJu0YzqIxcbKFAYJKHrN+XTrF1iBfw5CB0+OXonVlt89eS1cakM/4+y
 NVIUU/zxFYy4w/1RTjsuFjYIAonmT6un62iV8IYP4GwNZcSZOb4lzhY50jkAupP7hIk3w62OiEq
 xzouOwJtXNuSiY11Xel2U1DZ/onXuSbAMnCWT/eltfXuTIjIbZt0gmdXxmZ3mVC8OR5R0PWLwMx
 Y7QhNshDN2VY7lF9ymWJPOAjK8I2jiW6rqYXFtYB9P
X-Gm-Gg: ASbGnctgqfJJR2mgvD22Mjxi40VMS5JS844guGfa6Q9VFQnBb41S/NRtlHxFPU5APoy
 DN+3Dta9+1VxtNPg46g/5XhIUQsxgcGI9dOXcaHJ+DLsN21M/y/fgBGFv8fTvGj4+idwC4YpC2l
 tj1Tzw+YKsgeWudPL0RRWDityt1qGeKndCMgt3/3k9GDZgl+NcQvNhbPUddAbAd58ly7LAemdY1
 DA3Ks2KzlamnN4CVrr8xhvRGzLNnoEIrrmxCzDvXfbPwPwfOfq99Xp6+N+OBRIr3mbJt9VS7pDg
 ur47mqrdSeb2cZt1/pdSBwTIfJozgO4xWKwhwTEfVH28Xu+xnEqpysUpGp2LDngqZUkZVmTy1Pw
 aGgiuPfpWuHMHBpbMRoPwDnRFnDw14gWMkuX6mhLV43w=
X-Received: by 2002:a05:6000:18ad:b0:3b7:8892:ed8d with SMTP id
 ffacd0b85a97d-3c5da54ed40mr20282501f8f.6.1756481500368; 
 Fri, 29 Aug 2025 08:31:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqqFrN01uzVzHLVl+FpqXWr4R4+yjYC6EtMpsdmOlp3W0ighiG6+zV3Icr2auqVGBgMDbOjQ==
X-Received: by 2002:a05:6000:18ad:b0:3b7:8892:ed8d with SMTP id
 ffacd0b85a97d-3c5da54ed40mr20282469f8f.6.1756481499736; 
 Fri, 29 Aug 2025 08:31:39 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33add7f2sm4063344f8f.32.2025.08.29.08.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 08:31:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	richard.henderson@linaro.org,
	imammedo@redhat.com
Subject: [PATCH 11/18] accel/tcg: create a thread-kick function for TCG
Date: Fri, 29 Aug 2025 17:31:08 +0200
Message-ID: <20250829153115.1590048-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829152909.1589668-1-pbonzini@redhat.com>
References: <20250829152909.1589668-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Round-robin TCG is calling into cpu_exit() directly.  In preparation
for making cpu_exit() usable from all accelerators, define a generic
thread-kick function for TCG which is used directly in the multi-threaded
case, and through CPU_FOREACH in the round-robin case.

Use it also for user-mode emulation, and take the occasion to move
the implementation to accel/tcg/user-exec.c.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/tcg-icount.rst       | 2 +-
 accel/tcg/tcg-accel-ops-mttcg.h | 3 ---
 accel/tcg/tcg-accel-ops.h       | 1 +
 accel/tcg/cpu-exec.c            | 6 ++++++
 accel/tcg/tcg-accel-ops-mttcg.c | 5 -----
 accel/tcg/tcg-accel-ops-rr.c    | 2 +-
 accel/tcg/tcg-accel-ops.c       | 2 +-
 accel/tcg/user-exec.c           | 6 ++++++
 bsd-user/main.c                 | 5 -----
 linux-user/main.c               | 5 -----
 10 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/docs/devel/tcg-icount.rst b/docs/devel/tcg-icount.rst
index 7df883446a7..a1dcd79e0fd 100644
--- a/docs/devel/tcg-icount.rst
+++ b/docs/devel/tcg-icount.rst
@@ -37,7 +37,7 @@ translator starts by allocating a budget of instructions to be
 executed. The budget of instructions is limited by how long it will be
 until the next timer will expire. We store this budget as part of a
 vCPU icount_decr field which shared with the machinery for handling
-cpu_exit(). The whole field is checked at the start of every
+qemu_cpu_kick(). The whole field is checked at the start of every
 translated block and will cause a return to the outer loop to deal
 with whatever caused the exit.
 
diff --git a/accel/tcg/tcg-accel-ops-mttcg.h b/accel/tcg/tcg-accel-ops-mttcg.h
index 8ffa7a9a9fe..5c145cc8595 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.h
+++ b/accel/tcg/tcg-accel-ops-mttcg.h
@@ -10,9 +10,6 @@
 #ifndef TCG_ACCEL_OPS_MTTCG_H
 #define TCG_ACCEL_OPS_MTTCG_H
 
-/* kick MTTCG vCPU thread */
-void mttcg_kick_vcpu_thread(CPUState *cpu);
-
 /* start an mttcg vCPU thread */
 void mttcg_start_vcpu_thread(CPUState *cpu);
 
diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/tcg-accel-ops.h
index 6feeb3f3e9b..aecce605d7b 100644
--- a/accel/tcg/tcg-accel-ops.h
+++ b/accel/tcg/tcg-accel-ops.h
@@ -18,5 +18,6 @@ void tcg_cpu_destroy(CPUState *cpu);
 int tcg_cpu_exec(CPUState *cpu);
 void tcg_handle_interrupt(CPUState *cpu, int mask);
 void tcg_cpu_init_cflags(CPUState *cpu, bool parallel);
+void tcg_kick_vcpu_thread(CPUState *cpu);
 
 #endif /* TCG_ACCEL_OPS_H */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index f838535d111..9241bcadb5f 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -40,6 +40,7 @@
 #include "exec/replay-core.h"
 #include "system/tcg.h"
 #include "exec/helper-proto-common.h"
+#include "tcg-accel-ops.h"
 #include "tb-jmp-cache.h"
 #include "tb-hash.h"
 #include "tb-context.h"
@@ -748,6 +749,11 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
     return false;
 }
 
+void tcg_kick_vcpu_thread(CPUState *cpu)
+{
+    cpu_exit(cpu);
+}
+
 static inline bool icount_exit_request(CPUState *cpu)
 {
     if (!icount_enabled()) {
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index b12b7a36b5d..1148ebcaae5 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -123,11 +123,6 @@ static void *mttcg_cpu_thread_fn(void *arg)
     return NULL;
 }
 
-void mttcg_kick_vcpu_thread(CPUState *cpu)
-{
-    cpu_exit(cpu);
-}
-
 void mttcg_start_vcpu_thread(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index c2468d15d4f..610292d3bac 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -43,7 +43,7 @@ void rr_kick_vcpu_thread(CPUState *unused)
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
-        cpu_exit(cpu);
+        tcg_kick_vcpu_thread(cpu);
     };
 }
 
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 9c37266c1e0..1f662a9c745 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -206,7 +206,7 @@ static void tcg_accel_ops_init(AccelClass *ac)
 
     if (qemu_tcg_mttcg_enabled()) {
         ops->create_vcpu_thread = mttcg_start_vcpu_thread;
-        ops->kick_vcpu_thread = mttcg_kick_vcpu_thread;
+        ops->kick_vcpu_thread = tcg_kick_vcpu_thread;
         ops->handle_interrupt = tcg_handle_interrupt;
     } else {
         ops->create_vcpu_thread = rr_start_vcpu_thread;
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 66c25fba7dd..3c072fd868f 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -38,6 +38,7 @@
 #include "qemu/int128.h"
 #include "trace.h"
 #include "tcg/tcg-ldst.h"
+#include "tcg-accel-ops.h"
 #include "backend-ldst.h"
 #include "internal-common.h"
 #include "tb-internal.h"
@@ -46,6 +47,11 @@ __thread uintptr_t helper_retaddr;
 
 //#define DEBUG_SIGNAL
 
+void qemu_cpu_kick(CPUState *cpu)
+{
+    tcg_kick_vcpu_thread(cpu);
+}
+
 /*
  * Adjust the pc to pass to cpu_restore_state; return the memop type.
  */
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 7e5d4bbce09..fc33e4d4880 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -214,11 +214,6 @@ bool qemu_cpu_is_self(CPUState *cpu)
     return thread_cpu == cpu;
 }
 
-void qemu_cpu_kick(CPUState *cpu)
-{
-    cpu_exit(cpu);
-}
-
 /* Assumes contents are already zeroed.  */
 static void init_task_state(TaskState *ts)
 {
diff --git a/linux-user/main.c b/linux-user/main.c
index 6edeeecef38..2ba073eb830 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -189,11 +189,6 @@ bool qemu_cpu_is_self(CPUState *cpu)
     return thread_cpu == cpu;
 }
 
-void qemu_cpu_kick(CPUState *cpu)
-{
-    cpu_exit(cpu);
-}
-
 void task_settid(TaskState *ts)
 {
     if (ts->ts_tid == 0) {
-- 
2.51.0



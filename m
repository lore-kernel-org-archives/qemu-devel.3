Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0C1CA1013
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYt3-0002HU-Ow; Mon, 08 Sep 2025 06:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYsZ-0001ul-RE
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYsO-00010d-21
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757326406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MLX+lf73T+hkI0mv5GU16nOIJm0KC0+gPanOvDHIci0=;
 b=S1KRk4vnxqajG21dLpOJ8h2sTt3Pzko7mITTBEKbagSLkGMuihB0iOzWOEuChB9h0SsFa7
 E3EMqw/t1Ln7efzoDa/oku5Uu7sU1osGN/ZeicVNVf2XgCAqGPklIORU4GHdeoXpYFbpQM
 yyJRvGW/ZiTBMOJYOPSlWPoAEciKBZ4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-ZXHBkzBxNwGgIBuGLPxqgA-1; Mon, 08 Sep 2025 06:13:25 -0400
X-MC-Unique: ZXHBkzBxNwGgIBuGLPxqgA-1
X-Mimecast-MFC-AGG-ID: ZXHBkzBxNwGgIBuGLPxqgA_1757326404
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45de5fdda1aso3359045e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757326403; x=1757931203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MLX+lf73T+hkI0mv5GU16nOIJm0KC0+gPanOvDHIci0=;
 b=cIGJAqyGo005s5PHFFHSLXaq582ieBkNRZerwXCd0rcZ9KVZY1psm1drbHaIfqkMiY
 5PYHPYZfx/OarShBifDypGmH2CT7m2qzyjxT4IAHpLKiEizeU6ngg3MXg41eHscemJXm
 YDp/b+/djkfPj9FppM7qyR/AyJem49Xwggfm+cJBUdJS9HX5PLm7H9lKmNUMDj2JMyCk
 Vlgs6RJYyEK1WfpRGRhlARnhMwZAxp8g34xDCe14abh5ru0DjJ2oUzMURML32crkY59u
 Kij2vGFUVgW+B0SEi8OG9FhC0Zem0WGmGJWySPB10yV/Hoa/RaCZQiAQTnNEPSAgPfYr
 caxQ==
X-Gm-Message-State: AOJu0YxUVTZpS3Z3Hbu5d9uBUIIvmdPDBW1sQgjb0ib2ZJ3Z+brmsTRj
 SjsOTnjniuhwtclJRtSMDa8nvrzR9HxT328gJzFZc9UiFo9bN6H+nlFdmG7DEXfVizw6mKHD7k4
 3ZRlVT5GX27MS0I70t7S/UaK7/ErsEyfM0bszDqmz+MvYI/lYw3NbVGCfs4yn+WCeHPvFiUlWzn
 TpUX4tWojFZD8DkHkGJ7wuCbkuQPd6avMfEohpKpIG
X-Gm-Gg: ASbGnctJjIXtNIaWOKwc0Q2xr+FPqJn9CSI2i9VgfLQInUJy/6UUuGNtoBBPsMDsygS
 w7WzrPnmobnM3JF6j2kFEUyHMKfmWuiojyFnZzjlxcv5rBvO+kvNnjQAoZuEhBLMuAvVEpp7eiR
 z6lCHKds5zo8Y6W2uaDMQ9GBnDYnpAuO8vHIzsgwLyukHQAtplQ8Iu9Sc/c+oEpucxczI/7rs8t
 booyCmhaaFDpT1H3y5XI/t2Fsyiq9z8u58Vlcq0aJlAyoNCTCOfgWsdTSp8rTG/q6827rnU7l98
 UhAEs4Bdb16ydeNwTk8QyU6ioH4qn+cmaOGKoA73IcOddE7hx/Mg/HQ8Uc/vXJ4uelXGQw4eAJm
 sqA3+oKhtRaf85w1b86DUs/IP0TyvE9RHFJHFoeJeC2g=
X-Received: by 2002:a05:600c:4e14:b0:45b:86ee:415f with SMTP id
 5b1f17b1804b1-45ddde8a741mr70633085e9.6.1757326403415; 
 Mon, 08 Sep 2025 03:13:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz0I3vcYp8tMHrTHMmnr/HiIfuhKgszsHhDfHrWJWUdBUpJHffo1GTJAhyOXDEMVMPZjwNeQ==
X-Received: by 2002:a05:600c:4e14:b0:45b:86ee:415f with SMTP id
 5b1f17b1804b1-45ddde8a741mr70632755e9.6.1757326402909; 
 Mon, 08 Sep 2025 03:13:22 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45ddd47b6easm103837175e9.18.2025.09.08.03.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:13:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 16/19] bsd-user, linux-user: introduce qemu_process_cpu_events
Date: Mon,  8 Sep 2025 12:12:38 +0200
Message-ID: <20250908101241.2110068-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908101241.2110068-1-pbonzini@redhat.com>
References: <20250908101241.2110068-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Add a user-mode emulation version of the function.  More will be
added later, for now it is just process_queued_cpu_work.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 bsd-user/aarch64/target_arch_cpu.h | 2 +-
 bsd-user/arm/target_arch_cpu.h     | 2 +-
 bsd-user/i386/target_arch_cpu.h    | 2 +-
 bsd-user/riscv/target_arch_cpu.h   | 2 +-
 bsd-user/x86_64/target_arch_cpu.h  | 2 +-
 include/hw/core/cpu.h              | 9 +++++++++
 include/system/cpus.h              | 1 -
 accel/tcg/user-exec.c              | 5 +++++
 linux-user/aarch64/cpu_loop.c      | 2 +-
 linux-user/alpha/cpu_loop.c        | 2 +-
 linux-user/arm/cpu_loop.c          | 2 +-
 linux-user/hexagon/cpu_loop.c      | 2 +-
 linux-user/hppa/cpu_loop.c         | 2 +-
 linux-user/i386/cpu_loop.c         | 2 +-
 linux-user/loongarch64/cpu_loop.c  | 2 +-
 linux-user/m68k/cpu_loop.c         | 2 +-
 linux-user/microblaze/cpu_loop.c   | 2 +-
 linux-user/mips/cpu_loop.c         | 2 +-
 linux-user/openrisc/cpu_loop.c     | 2 +-
 linux-user/ppc/cpu_loop.c          | 2 +-
 linux-user/riscv/cpu_loop.c        | 2 +-
 linux-user/s390x/cpu_loop.c        | 2 +-
 linux-user/sh4/cpu_loop.c          | 2 +-
 linux-user/sparc/cpu_loop.c        | 2 +-
 linux-user/xtensa/cpu_loop.c       | 2 +-
 25 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/bsd-user/aarch64/target_arch_cpu.h b/bsd-user/aarch64/target_arch_cpu.h
index 87fbf6d6775..15df84fda21 100644
--- a/bsd-user/aarch64/target_arch_cpu.h
+++ b/bsd-user/aarch64/target_arch_cpu.h
@@ -54,7 +54,7 @@ static inline G_NORETURN void target_cpu_loop(CPUARMState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_process_cpu_events(cs);
 
         switch (trapnr) {
         case EXCP_SWI:
diff --git a/bsd-user/arm/target_arch_cpu.h b/bsd-user/arm/target_arch_cpu.h
index bc2eaa0bf4e..9a952ef0ff7 100644
--- a/bsd-user/arm/target_arch_cpu.h
+++ b/bsd-user/arm/target_arch_cpu.h
@@ -46,7 +46,7 @@ static inline G_NORETURN void target_cpu_loop(CPUARMState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_process_cpu_events(cs);
         switch (trapnr) {
         case EXCP_UDEF:
         case EXCP_NOCP:
diff --git a/bsd-user/i386/target_arch_cpu.h b/bsd-user/i386/target_arch_cpu.h
index 5d4c931decd..f147d5b6f85 100644
--- a/bsd-user/i386/target_arch_cpu.h
+++ b/bsd-user/i386/target_arch_cpu.h
@@ -113,7 +113,7 @@ static inline G_NORETURN void target_cpu_loop(CPUX86State *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_process_cpu_events(cs);
 
         switch (trapnr) {
         case 0x80: {
diff --git a/bsd-user/riscv/target_arch_cpu.h b/bsd-user/riscv/target_arch_cpu.h
index ef92f004803..ad428d0263d 100644
--- a/bsd-user/riscv/target_arch_cpu.h
+++ b/bsd-user/riscv/target_arch_cpu.h
@@ -49,7 +49,7 @@ static inline G_NORETURN void target_cpu_loop(CPURISCVState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_process_cpu_events(cs);
 
         signo = 0;
 
diff --git a/bsd-user/x86_64/target_arch_cpu.h b/bsd-user/x86_64/target_arch_cpu.h
index f82042e30af..1fa71d87f12 100644
--- a/bsd-user/x86_64/target_arch_cpu.h
+++ b/bsd-user/x86_64/target_arch_cpu.h
@@ -121,7 +121,7 @@ static inline G_NORETURN void target_cpu_loop(CPUX86State *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_process_cpu_events(cs);
 
         switch (trapnr) {
         case EXCP_SYSCALL:
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 6075be0b59f..fb788ca1107 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1145,6 +1145,15 @@ AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx);
 G_NORETURN void cpu_abort(CPUState *cpu, const char *fmt, ...)
     G_GNUC_PRINTF(2, 3);
 
+/**
+ * qemu_process_cpu_events:
+ * @cpu: CPU that left the execution loop
+ *
+ * Perform accelerator-independent work after the CPU has left
+ * the inner execution loop.
+ */
+void qemu_process_cpu_events(CPUState *cpu);
+
 /* $(top_srcdir)/cpu.c */
 void cpu_class_init_props(DeviceClass *dc);
 void cpu_exec_class_post_init(CPUClass *cc);
diff --git a/include/system/cpus.h b/include/system/cpus.h
index 4aebec48705..508444ccf1c 100644
--- a/include/system/cpus.h
+++ b/include/system/cpus.h
@@ -18,7 +18,6 @@ bool cpu_thread_is_idle(CPUState *cpu);
 bool all_cpu_threads_idle(void);
 bool cpu_can_run(CPUState *cpu);
 void qemu_process_cpu_events_common(CPUState *cpu);
-void qemu_process_cpu_events(CPUState *cpu);
 void cpu_thread_signal_created(CPUState *cpu);
 void cpu_thread_signal_destroyed(CPUState *cpu);
 void cpu_handle_guest_debug(CPUState *cpu);
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 3c072fd868f..65f5da6c506 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -52,6 +52,11 @@ void qemu_cpu_kick(CPUState *cpu)
     tcg_kick_vcpu_thread(cpu);
 }
 
+void qemu_process_cpu_events(CPUState *cpu)
+{
+    process_queued_cpu_work(cpu);
+}
+
 /*
  * Adjust the pc to pass to cpu_restore_state; return the memop type.
  */
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 4c4921152e8..f6b498c6c43 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -38,7 +38,7 @@ void cpu_loop(CPUARMState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_process_cpu_events(cs);
 
         switch (trapnr) {
         case EXCP_SWI:
diff --git a/linux-user/alpha/cpu_loop.c b/linux-user/alpha/cpu_loop.c
index 728b64906d9..bb8346b5094 100644
--- a/linux-user/alpha/cpu_loop.c
+++ b/linux-user/alpha/cpu_loop.c
@@ -35,7 +35,7 @@ void cpu_loop(CPUAlphaState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_process_cpu_events(cs);
 
         switch (trapnr) {
         case EXCP_RESET:
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 9aeb9b0087f..cd89b7d6f5e 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -295,7 +295,7 @@ void cpu_loop(CPUARMState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_process_cpu_events(cs);
 
         switch(trapnr) {
         case EXCP_UDEF:
diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
index 25c97edcaef..1941f4c9c16 100644
--- a/linux-user/hexagon/cpu_loop.c
+++ b/linux-user/hexagon/cpu_loop.c
@@ -36,7 +36,7 @@ void cpu_loop(CPUHexagonState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_process_cpu_events(cs);
 
         switch (trapnr) {
         case EXCP_INTERRUPT:
diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index 3af50653bb7..356cb48acc3 100644
--- a/linux-user/hppa/cpu_loop.c
+++ b/linux-user/hppa/cpu_loop.c
@@ -119,7 +119,7 @@ void cpu_loop(CPUHPPAState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_process_cpu_events(cs);
 
         switch (trapnr) {
         case EXCP_SYSCALL:
diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index 7b2d8b03d84..f3f58576af5 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -214,7 +214,7 @@ void cpu_loop(CPUX86State *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_process_cpu_events(cs);
 
         switch(trapnr) {
         case 0x80:
diff --git a/linux-user/loongarch64/cpu_loop.c b/linux-user/loongarch64/cpu_loop.c
index a0a4cbb7cc3..26a5ce3a936 100644
--- a/linux-user/loongarch64/cpu_loop.c
+++ b/linux-user/loongarch64/cpu_loop.c
@@ -27,7 +27,7 @@ void cpu_loop(CPULoongArchState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_process_cpu_events(cs);
 
         switch (trapnr) {
         case EXCP_INTERRUPT:
diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
index aca0bf23dc6..2c9f628241f 100644
--- a/linux-user/m68k/cpu_loop.c
+++ b/linux-user/m68k/cpu_loop.c
@@ -33,7 +33,7 @@ void cpu_loop(CPUM68KState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_process_cpu_events(cs);
 
         switch(trapnr) {
         case EXCP_ILLEGAL:
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_loop.c
index d8277961c73..78506ab23d9 100644
--- a/linux-user/microblaze/cpu_loop.c
+++ b/linux-user/microblaze/cpu_loop.c
@@ -32,7 +32,7 @@ void cpu_loop(CPUMBState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_process_cpu_events(cs);
 
         switch (trapnr) {
         case EXCP_INTERRUPT:
diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index e67b8a2e463..2365de1de1a 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -74,7 +74,7 @@ void cpu_loop(CPUMIPSState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_process_cpu_events(cs);
 
         switch(trapnr) {
         case EXCP_SYSCALL:
diff --git a/linux-user/openrisc/cpu_loop.c b/linux-user/openrisc/cpu_loop.c
index 8c72347a99a..2167d880d55 100644
--- a/linux-user/openrisc/cpu_loop.c
+++ b/linux-user/openrisc/cpu_loop.c
@@ -33,7 +33,7 @@ void cpu_loop(CPUOpenRISCState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_process_cpu_events(cs);
 
         switch (trapnr) {
         case EXCP_SYSCALL:
diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
index 22885ffd906..b0b0cb14b41 100644
--- a/linux-user/ppc/cpu_loop.c
+++ b/linux-user/ppc/cpu_loop.c
@@ -77,7 +77,7 @@ void cpu_loop(CPUPPCState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_process_cpu_events(cs);
 
         arch_interrupt = true;
         switch (trapnr) {
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index b3162815320..ce542540c28 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -36,7 +36,7 @@ void cpu_loop(CPURISCVState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_process_cpu_events(cs);
 
         switch (trapnr) {
         case EXCP_INTERRUPT:
diff --git a/linux-user/s390x/cpu_loop.c b/linux-user/s390x/cpu_loop.c
index 49e44548f85..4929b32e1fc 100644
--- a/linux-user/s390x/cpu_loop.c
+++ b/linux-user/s390x/cpu_loop.c
@@ -64,7 +64,7 @@ void cpu_loop(CPUS390XState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_process_cpu_events(cs);
 
         switch (trapnr) {
         case EXCP_INTERRUPT:
diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
index 259ea1cc8bb..0c9d7e9c46b 100644
--- a/linux-user/sh4/cpu_loop.c
+++ b/linux-user/sh4/cpu_loop.c
@@ -34,7 +34,7 @@ void cpu_loop(CPUSH4State *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_process_cpu_events(cs);
 
         switch (trapnr) {
         case 0x160:
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 7d30cd1ff22..7391e2add8d 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -220,7 +220,7 @@ void cpu_loop (CPUSPARCState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_process_cpu_events(cs);
 
         switch (trapnr) {
         case TARGET_TT_SYSCALL:
diff --git a/linux-user/xtensa/cpu_loop.c b/linux-user/xtensa/cpu_loop.c
index 43a194fc4a4..a0ff10eff82 100644
--- a/linux-user/xtensa/cpu_loop.c
+++ b/linux-user/xtensa/cpu_loop.c
@@ -133,7 +133,7 @@ void cpu_loop(CPUXtensaState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_process_cpu_events(cs);
 
         env->sregs[PS] &= ~PS_EXCM;
         switch (trapnr) {
-- 
2.51.0



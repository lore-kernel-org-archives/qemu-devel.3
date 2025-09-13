Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DFCCAC58E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLLD-0005sJ-0J; Sat, 13 Sep 2025 04:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLLB-0005rq-E9
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:10:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLL9-0004xP-4f
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MLX+lf73T+hkI0mv5GU16nOIJm0KC0+gPanOvDHIci0=;
 b=CP2YqLsvmS5QMHDZEhALr91kONxnpDTvaXWq7QJT2BdfFvtKA2KCN3ckSjK6ARpo3vcs78
 M+QVnxRui2tTFhLfIIIJwMoeKdJGKWjLfTRbStGbfIRcZT6j2BwXjJb1DdC3z8aYjFwQPi
 clPKj18cIZN0RfRqGMwvt4aVKrodVCQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-5D2cHpTBMFG-VH-eF6Uo8Q-1; Sat, 13 Sep 2025 04:10:31 -0400
X-MC-Unique: 5D2cHpTBMFG-VH-eF6Uo8Q-1
X-Mimecast-MFC-AGG-ID: 5D2cHpTBMFG-VH-eF6Uo8Q_1757751030
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45d6c770066so12714115e9.0
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751029; x=1758355829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MLX+lf73T+hkI0mv5GU16nOIJm0KC0+gPanOvDHIci0=;
 b=WwxG30FBXKo707Gb+aW3LOvK+CWGlcSS3J38SGe+kpleSe2NBCZqFZ7kHjYLWYJwup
 xBxKj7ZfweGn15ZIlNSX+IHQyfEiqFUXvNZRuR6Foz7YF8LUn9+WyD8kK+6pMg1hdfqQ
 z5PsnABeGCyzbHgMvSDrHcSrCtKIT6QuSzqrm+ETgRcLyf8Ht7Vs7QG78Sbyo6XGBGRb
 2GwBInbsddfbB/8+0e1TCDLzPJKhcwh9ghovAls0lJM91zbALO2xinnGYSIJGCNWvFod
 jdWyICbLNLbAUXW8dD86a4uxQbEG8NcDMUY72YRXuiwrjXDDtrGUj3tuRckh+PdWIufB
 10vg==
X-Gm-Message-State: AOJu0YwAdMFfL/HhbHpLRqgU+RZsEBfYRzzI5NS0YUbIe3RcF5PHHifT
 RdFbOqpMbk0gM4Eu1VAAAiFq1zi/hed4Q2AZ+qpFEI1KIcKpLjqWml39EvTxvSGT8JK/m0AbgK6
 r0fHPC0xDoNx7GNGmzTrwxlNDfVR/1iVENUduCrWbgyZdQkylOHVWfjAFrTZNwS5xwSmV0+OEol
 pfH/GkIqRvWH2OdCiwteu2j0ziyCWGVN1QMrGkc8L9
X-Gm-Gg: ASbGncvuz1X2T0kg+SCcEi4PMJXvIzV4X3sgJuxSDO5FcQmH7rqZUVitThN2KqMAUop
 C3q+WDpVY7/TLz9KzFBwsO6F3YUkXFIiFH7+WB7PsTnHznro2ZQ//dwKV7mApSYXPzqkUmYbYbg
 0wDcp+PXHvB54wNbe/xa4Q26gBa+niKsg6kZ9HvkGv6wt4kpqwiwc6zPO9ogm5zYFHBhc4Et9C3
 rwqDjzKsDgfhc8qQ7lo25ig7OiDsAlOk/Fjw1jwV6zuqMeVBJec5E7FUpzDYq/d6feh5Eltxh7i
 070CkGSY4409Y1yLPVTMKAQk/huVmibgQZCv3ThxqYEjBJy29fI641VNUX6hfIrARj7sYqGrf2M
 8xn3IEhxbLYtwO042B5JgC0qr+fi81wAAqXv5TxpwRvU=
X-Received: by 2002:a05:600c:468a:b0:458:be62:dcd3 with SMTP id
 5b1f17b1804b1-45f211f2eb5mr70454305e9.17.1757751028879; 
 Sat, 13 Sep 2025 01:10:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5lRvbmHINZdN4BrwG3+en7M5SR2O2IlDBVXYmW8eAxRctyKLYwQuDgnyrOlNEpgOanOvuRg==
X-Received: by 2002:a05:600c:468a:b0:458:be62:dcd3 with SMTP id
 5b1f17b1804b1-45f211f2eb5mr70453885e9.17.1757751028280; 
 Sat, 13 Sep 2025 01:10:28 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e91b2519d9sm188587f8f.22.2025.09.13.01.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:10:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 16/61] bsd-user, linux-user: introduce qemu_process_cpu_events
Date: Sat, 13 Sep 2025 10:08:57 +0200
Message-ID: <20250913080943.11710-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



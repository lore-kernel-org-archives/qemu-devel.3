Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671F3CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNOf-0004Ht-Tt; Sat, 30 Aug 2025 11:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us159-0001we-9K
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:32:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us156-0000aC-Eh
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756481518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mZd6LcPXZdEGsNumQwGYHNC9F7djFaIPp8BsfVJR/SE=;
 b=DcCbsy45+HfpEwQesm+T0+W+t0efDL6vMG/MfEF8mp5bIHvcYQ3dicCmLyEP1bekXCsMkY
 VAzGjN+YQr4g95bVy6WCkXqmU33fhIgf+UVE9bjpx2v3M/1qngylTpBpiNBT9RnBmXorRy
 tAD1Qw4n1llsYrfrdVCZaoDtwiJN97g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-7ELIpv2pPjyvXbwKTPMWeA-1; Fri, 29 Aug 2025 11:31:55 -0400
X-MC-Unique: 7ELIpv2pPjyvXbwKTPMWeA-1
X-Mimecast-MFC-AGG-ID: 7ELIpv2pPjyvXbwKTPMWeA_1756481514
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3d17731acb6so108986f8f.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 08:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756481513; x=1757086313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mZd6LcPXZdEGsNumQwGYHNC9F7djFaIPp8BsfVJR/SE=;
 b=rpTLClKXmO76K8XXObSTJCFzyohgnB/MtfTw3hbh97hR0IndE2NXcvWy48e1sMmCe1
 JY/iG2tC1qU0u0TuWc4W7qH1d6sF0rsf8dAUy6azUYh+t/UES4VHZWrEewKIF6PRvbY4
 yszBLPWznj7gIEDOP0qAmGJbxN6OS93adt6Qo3Dg13qbvPk8nh0kcldU0Pe7Ew0lAixT
 yD1LS2QR5201Rx6mtIG7lwIKXY7ADFfSMSAnNwQJ2DJKmYujmKDhJu3cK8Jdu8YGzms6
 wZ5OArOuRaar2qIsRyLOp+O9vgtRnxoGrb1Dl1zgCht3tlecKqfPgjsYTul301oA4L7w
 UCrw==
X-Gm-Message-State: AOJu0YwP0WcL5dSLAnZSMpDdB4YrxXzDRJ81taOWhhZrVs2VIYgbuJxf
 /7BVd5YGDfsV5u0Rl/nCDrv+KLPKZCSMfdUsjJiL03gLm3eiTpryi423j6f2peDnHOQSs3t8UP6
 P4uzWzkCI3dC5xOnVHusuqxfArCVAVt9FicCsLTWDgRE0jQGMKxzzocW2nRlJzMnM+l3V7Fewxs
 F2UgdFhrw7ub/1Bao+4S8DxRLBzChtizx8CElNr3df
X-Gm-Gg: ASbGncviDQw4nowMIdKYBA3RcHGM99WeorCjx1JitoKBVxcCjFLHA8pfaJ6Znxec9eh
 0bNLVwLLR0QBebWSonYlqmpuSn+9c27rlZrYGp4LLem3u1dSzRdC9dPPUJyevsJYdgUPkbmZZ6m
 Seljup/ET+Pe47ZsP0zBmaotvcvtXgdjDjbKnYKFDm3PA4MNIN/CS5yfq/H5FUxJ5l6qW8INBhl
 J5DueFocFhRZApvjw4LHkYTC5nMDITcZeP/QRQFjrEFsw7B2V4yJ9h7fmJsP+zmUvEmO+FGT1n8
 HRpeAItBTOb1F8m5wv3W4Vhz0xIbkIfjUykHY/dnmoguNPyAc8IJa5i/Z1xkfyDXYHZ91bLvd5u
 +PkZMNeam8KipBpX/dFrNELeDz4gE/FDaOjL6uwLdeYo=
X-Received: by 2002:a05:6000:26cf:b0:3d0:affe:ed78 with SMTP id
 ffacd0b85a97d-3d0affef23dmr1781203f8f.48.1756481512510; 
 Fri, 29 Aug 2025 08:31:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpjxQoiKkiNhPX7y4x/G4G1LOYrqQ3UlvdwDnJLH0wNDNWd0TcF6xq1w9zp6zHqqvxRgAeSQ==
X-Received: by 2002:a05:6000:26cf:b0:3d0:affe:ed78 with SMTP id
 ffacd0b85a97d-3d0affef23dmr1781171f8f.48.1756481511986; 
 Fri, 29 Aug 2025 08:31:51 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf270fc3fasm3808697f8f.5.2025.08.29.08.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 08:31:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	richard.henderson@linaro.org,
	imammedo@redhat.com
Subject: [PATCH 15/18] bsd-user, linux-user: introduce qemu_wait_io_event
Date: Fri, 29 Aug 2025 17:31:12 +0200
Message-ID: <20250829153115.1590048-11-pbonzini@redhat.com>
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

Add a user-mode emulation version of the function.  More will be
added later, for now it is just process_queued_cpu_work.

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
index 87fbf6d6775..4407f35fb97 100644
--- a/bsd-user/aarch64/target_arch_cpu.h
+++ b/bsd-user/aarch64/target_arch_cpu.h
@@ -54,7 +54,7 @@ static inline G_NORETURN void target_cpu_loop(CPUARMState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_wait_io_event(cs);
 
         switch (trapnr) {
         case EXCP_SWI:
diff --git a/bsd-user/arm/target_arch_cpu.h b/bsd-user/arm/target_arch_cpu.h
index bc2eaa0bf4e..a79ecf15f8f 100644
--- a/bsd-user/arm/target_arch_cpu.h
+++ b/bsd-user/arm/target_arch_cpu.h
@@ -46,7 +46,7 @@ static inline G_NORETURN void target_cpu_loop(CPUARMState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_wait_io_event(cs);
         switch (trapnr) {
         case EXCP_UDEF:
         case EXCP_NOCP:
diff --git a/bsd-user/i386/target_arch_cpu.h b/bsd-user/i386/target_arch_cpu.h
index 5d4c931decd..592702a8a1e 100644
--- a/bsd-user/i386/target_arch_cpu.h
+++ b/bsd-user/i386/target_arch_cpu.h
@@ -113,7 +113,7 @@ static inline G_NORETURN void target_cpu_loop(CPUX86State *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_wait_io_event(cs);
 
         switch (trapnr) {
         case 0x80: {
diff --git a/bsd-user/riscv/target_arch_cpu.h b/bsd-user/riscv/target_arch_cpu.h
index ef92f004803..dbe7c7231f5 100644
--- a/bsd-user/riscv/target_arch_cpu.h
+++ b/bsd-user/riscv/target_arch_cpu.h
@@ -49,7 +49,7 @@ static inline G_NORETURN void target_cpu_loop(CPURISCVState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_wait_io_event(cs);
 
         signo = 0;
 
diff --git a/bsd-user/x86_64/target_arch_cpu.h b/bsd-user/x86_64/target_arch_cpu.h
index f82042e30af..f298fbc9808 100644
--- a/bsd-user/x86_64/target_arch_cpu.h
+++ b/bsd-user/x86_64/target_arch_cpu.h
@@ -121,7 +121,7 @@ static inline G_NORETURN void target_cpu_loop(CPUX86State *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_wait_io_event(cs);
 
         switch (trapnr) {
         case EXCP_SYSCALL:
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 338757e5254..ffa553b2318 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1145,6 +1145,15 @@ AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx);
 G_NORETURN void cpu_abort(CPUState *cpu, const char *fmt, ...)
     G_GNUC_PRINTF(2, 3);
 
+/**
+ * qemu_wait_io_event:
+ * @cpu: CPU that left the execution loop
+ *
+ * Perform accelerator-independent work after the CPU has left
+ * the inner execution loop.
+ */
+void qemu_wait_io_event(CPUState *cpu);
+
 /* $(top_srcdir)/cpu.c */
 void cpu_class_init_props(DeviceClass *dc);
 void cpu_exec_class_post_init(CPUClass *cc);
diff --git a/include/system/cpus.h b/include/system/cpus.h
index 69be6a77a75..e6864861c0b 100644
--- a/include/system/cpus.h
+++ b/include/system/cpus.h
@@ -18,7 +18,6 @@ bool cpu_thread_is_idle(CPUState *cpu);
 bool all_cpu_threads_idle(void);
 bool cpu_can_run(CPUState *cpu);
 void qemu_wait_io_event_common(CPUState *cpu);
-void qemu_wait_io_event(CPUState *cpu);
 void cpu_thread_signal_created(CPUState *cpu);
 void cpu_thread_signal_destroyed(CPUState *cpu);
 void cpu_handle_guest_debug(CPUState *cpu);
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 3c072fd868f..81906d2e033 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -52,6 +52,11 @@ void qemu_cpu_kick(CPUState *cpu)
     tcg_kick_vcpu_thread(cpu);
 }
 
+void qemu_wait_io_event(CPUState *cpu)
+{
+    process_queued_cpu_work(cpu);
+}
+
 /*
  * Adjust the pc to pass to cpu_restore_state; return the memop type.
  */
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 4c4921152e8..9d0f09c3a13 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -38,7 +38,7 @@ void cpu_loop(CPUARMState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_wait_io_event(cs);
 
         switch (trapnr) {
         case EXCP_SWI:
diff --git a/linux-user/alpha/cpu_loop.c b/linux-user/alpha/cpu_loop.c
index 728b64906d9..1f2d1c5565f 100644
--- a/linux-user/alpha/cpu_loop.c
+++ b/linux-user/alpha/cpu_loop.c
@@ -35,7 +35,7 @@ void cpu_loop(CPUAlphaState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_wait_io_event(cs);
 
         switch (trapnr) {
         case EXCP_RESET:
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 9aeb9b0087f..026a189b884 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -295,7 +295,7 @@ void cpu_loop(CPUARMState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_wait_io_event(cs);
 
         switch(trapnr) {
         case EXCP_UDEF:
diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
index 25c97edcaef..675c157a3de 100644
--- a/linux-user/hexagon/cpu_loop.c
+++ b/linux-user/hexagon/cpu_loop.c
@@ -36,7 +36,7 @@ void cpu_loop(CPUHexagonState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_wait_io_event(cs);
 
         switch (trapnr) {
         case EXCP_INTERRUPT:
diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index 3af50653bb7..a8e715cb59b 100644
--- a/linux-user/hppa/cpu_loop.c
+++ b/linux-user/hppa/cpu_loop.c
@@ -119,7 +119,7 @@ void cpu_loop(CPUHPPAState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_wait_io_event(cs);
 
         switch (trapnr) {
         case EXCP_SYSCALL:
diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index 7b2d8b03d84..7af476c9d44 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -214,7 +214,7 @@ void cpu_loop(CPUX86State *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_wait_io_event(cs);
 
         switch(trapnr) {
         case 0x80:
diff --git a/linux-user/loongarch64/cpu_loop.c b/linux-user/loongarch64/cpu_loop.c
index a0a4cbb7cc3..dc83118e389 100644
--- a/linux-user/loongarch64/cpu_loop.c
+++ b/linux-user/loongarch64/cpu_loop.c
@@ -27,7 +27,7 @@ void cpu_loop(CPULoongArchState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_wait_io_event(cs);
 
         switch (trapnr) {
         case EXCP_INTERRUPT:
diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
index aca0bf23dc6..5b62260212d 100644
--- a/linux-user/m68k/cpu_loop.c
+++ b/linux-user/m68k/cpu_loop.c
@@ -33,7 +33,7 @@ void cpu_loop(CPUM68KState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_wait_io_event(cs);
 
         switch(trapnr) {
         case EXCP_ILLEGAL:
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_loop.c
index d8277961c73..a7f3f0e6a68 100644
--- a/linux-user/microblaze/cpu_loop.c
+++ b/linux-user/microblaze/cpu_loop.c
@@ -32,7 +32,7 @@ void cpu_loop(CPUMBState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_wait_io_event(cs);
 
         switch (trapnr) {
         case EXCP_INTERRUPT:
diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index e67b8a2e463..9ac4af6ae52 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -74,7 +74,7 @@ void cpu_loop(CPUMIPSState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_wait_io_event(cs);
 
         switch(trapnr) {
         case EXCP_SYSCALL:
diff --git a/linux-user/openrisc/cpu_loop.c b/linux-user/openrisc/cpu_loop.c
index 8c72347a99a..9512e34e2af 100644
--- a/linux-user/openrisc/cpu_loop.c
+++ b/linux-user/openrisc/cpu_loop.c
@@ -33,7 +33,7 @@ void cpu_loop(CPUOpenRISCState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_wait_io_event(cs);
 
         switch (trapnr) {
         case EXCP_SYSCALL:
diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
index 22885ffd906..3b5d775a49f 100644
--- a/linux-user/ppc/cpu_loop.c
+++ b/linux-user/ppc/cpu_loop.c
@@ -77,7 +77,7 @@ void cpu_loop(CPUPPCState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_wait_io_event(cs);
 
         arch_interrupt = true;
         switch (trapnr) {
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index b3162815320..940fd67f7b3 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -36,7 +36,7 @@ void cpu_loop(CPURISCVState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_wait_io_event(cs);
 
         switch (trapnr) {
         case EXCP_INTERRUPT:
diff --git a/linux-user/s390x/cpu_loop.c b/linux-user/s390x/cpu_loop.c
index 49e44548f85..be179a073f6 100644
--- a/linux-user/s390x/cpu_loop.c
+++ b/linux-user/s390x/cpu_loop.c
@@ -64,7 +64,7 @@ void cpu_loop(CPUS390XState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_wait_io_event(cs);
 
         switch (trapnr) {
         case EXCP_INTERRUPT:
diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
index 259ea1cc8bb..a7edd52e37c 100644
--- a/linux-user/sh4/cpu_loop.c
+++ b/linux-user/sh4/cpu_loop.c
@@ -34,7 +34,7 @@ void cpu_loop(CPUSH4State *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_wait_io_event(cs);
 
         switch (trapnr) {
         case 0x160:
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 7d30cd1ff22..b9228708bf4 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -220,7 +220,7 @@ void cpu_loop (CPUSPARCState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_wait_io_event(cs);
 
         switch (trapnr) {
         case TARGET_TT_SYSCALL:
diff --git a/linux-user/xtensa/cpu_loop.c b/linux-user/xtensa/cpu_loop.c
index 43a194fc4a4..bf19377dc29 100644
--- a/linux-user/xtensa/cpu_loop.c
+++ b/linux-user/xtensa/cpu_loop.c
@@ -133,7 +133,7 @@ void cpu_loop(CPUXtensaState *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        qemu_wait_io_event(cs);
 
         env->sregs[PS] &= ~PS_EXCM;
         switch (trapnr) {
-- 
2.51.0



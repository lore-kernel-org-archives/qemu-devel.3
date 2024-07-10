Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DD0C38150
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 06:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRQpZ-00082S-V2; Wed, 10 Jul 2024 02:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRQpY-00081q-7H
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:29:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRQpT-0000tr-N7
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720592966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JAI2qzPvFnodYjLIbHURJn4hOXJ8XKtBl1/AVO2/UqU=;
 b=RunNP0St6KlN3ZdIwIIiMgKeFYhesZ2KcvnAAt6TAVu/KBsp06xBjQd0TSZtnwSrnikAQu
 epYNy/kBw6FjNdshEPT39znCo4nKlEOYX2YGNj26otng/9oJnjpHohP8/cFdu19p3UFydi
 tVnhNEqsamhGyNnojyjajPV1I0DOsEA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-3FpmkPNyPFCeG_6RRJXJgQ-1; Wed, 10 Jul 2024 02:29:25 -0400
X-MC-Unique: 3FpmkPNyPFCeG_6RRJXJgQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-36795e2ce86so3444476f8f.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 23:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720592963; x=1721197763;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JAI2qzPvFnodYjLIbHURJn4hOXJ8XKtBl1/AVO2/UqU=;
 b=HBWV/vI/s0Ze6uxOPyTmDtg2ktMy7NSo+r7vmdv69M43Z3jvZmd+AAQt3QrSV9dnTx
 fg3426Tsg1B4qdIVLmaMZo33aU55SnvZZNENKs1vimJffypadsZlJn/p5ZvzM5+XSzTR
 fOPGW2bjVSMWIY7STKsCoFv0txTiz0uz73J/T2biOqoLefGZ2O+r8WbFeJ8YS35DNq7E
 kI6hJo3noFFuMNYfvTwSuWy1RSHDjRG+h3rPqpMLuv+lqNMLVTc2AFpkzvwmAuCZd+w6
 C9kwGi3PZLsxxO897QzJPzP4VfMxaCe4B1H5QLFqS8zN0Efp+Mbe0BIN2V2QLOs/1TRx
 5hLQ==
X-Gm-Message-State: AOJu0Yyk3JwXiv9hyN6wL1HLyBpN1REEkS2KO1ovjl1qRN1QRAR/PlsS
 252/6vT/5WLxQhHCgGbLeIzptZgg4JFiq3Dao3RscThOYIkHukJecB0M4Lhu7GCuclv0qSy959U
 KjTkNWQO+wWIolrtVNff5CST+cdes/BWuOUfF4WIIYfBfFoeDg+EgwPmpSFwIsTn0WQmvZRqElu
 uaRXMLUEARED/SPqbnIfPZ4ydmVEhYZSsQAvgS
X-Received: by 2002:adf:a31c:0:b0:367:8383:62f3 with SMTP id
 ffacd0b85a97d-367cea73e8emr3416620f8f.28.1720592962829; 
 Tue, 09 Jul 2024 23:29:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmWoIKohUSIP4uEcAzaG4RWpm5B4LiGstPdvzuElQj8nDa5mObAYqH1mYeBmDVsBiL9GfhRg==
X-Received: by 2002:adf:a31c:0:b0:367:8383:62f3 with SMTP id
 ffacd0b85a97d-367cea73e8emr3416609f8f.28.1720592962417; 
 Tue, 09 Jul 2024 23:29:22 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde7df48sm4411397f8f.1.2024.07.09.23.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 23:29:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: rrh.henry@gmail.com,
	richard.henderson@linaro.org
Subject: [PATCH 00/10] target/i386/tcg: fixes for seg_helper.c
Date: Wed, 10 Jul 2024 08:29:10 +0200
Message-ID: <20240710062920.73063-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This includes bugfixes:
- allowing IRET from user mode to user mode with SMAP (do not use implicit
  kernel accesses, which break if the stack is in userspace)

- use DPL-level accesses for interrupts and call gates

- various fixes for task switching

And two related cleanups: computing MMU index once for far calls and returns
(including task switches), and using X86Access for TSS access.

Tested with a really ugly patch to kvm-unit-tests, included after signature.

Paolo Bonzini (7):
  target/i386/tcg: Allow IRET from user mode to user mode with SMAP
  target/i386/tcg: use PUSHL/PUSHW for error code
  target/i386/tcg: Compute MMU index once
  target/i386/tcg: Use DPL-level accesses for interrupts and call gates
  target/i386/tcg: check for correct busy state before switching to a
    new task
  target/i386/tcg: use X86Access for TSS access
  target/i386/tcg: save current task state before loading new one

Richard Henderson (3):
  target/i386/tcg: Remove SEG_ADDL
  target/i386/tcg: Reorg push/pop within seg_helper.c
  target/i386/tcg: Introduce x86_mmu_index_{kernel_,}pl

 target/i386/cpu.h            |  11 +-
 target/i386/cpu.c            |  27 +-
 target/i386/tcg/seg_helper.c | 606 +++++++++++++++++++----------------
 3 files changed, 354 insertions(+), 290 deletions(-)

-- 
2.45.2

diff --git a/lib/x86/usermode.c b/lib/x86/usermode.c
index c3ec0ad7..0bf40c6d 100644
--- a/lib/x86/usermode.c
+++ b/lib/x86/usermode.c
@@ -5,13 +5,15 @@
 #include "x86/desc.h"
 #include "x86/isr.h"
 #include "alloc.h"
+#include "alloc_page.h"
 #include "setjmp.h"
 #include "usermode.h"
 
 #include "libcflat.h"
 #include <stdint.h>
 
-#define USERMODE_STACK_SIZE	0x2000
+#define USERMODE_STACK_ORDER	1 /* 8k */
+#define USERMODE_STACK_SIZE	(1 << (12 + USERMODE_STACK_ORDER))
 #define RET_TO_KERNEL_IRQ	0x20
 
 static jmp_buf jmpbuf;
@@ -37,9 +39,14 @@ uint64_t run_in_user(usermode_func func, unsigned int fault_vector,
 {
 	extern char ret_to_kernel;
 	volatile uint64_t rax = 0;
-	static unsigned char user_stack[USERMODE_STACK_SIZE];
+	static unsigned char *user_stack;
 	handler old_ex;
 
+	if (!user_stack) {
+		user_stack = alloc_pages(USERMODE_STACK_ORDER);
+		printf("%p\n", user_stack);
+	}
+
 	*raised_vector = 0;
 	set_idt_entry(RET_TO_KERNEL_IRQ, &ret_to_kernel, 3);
 	old_ex = handle_exception(fault_vector,
@@ -51,6 +58,8 @@ uint64_t run_in_user(usermode_func func, unsigned int fault_vector,
 		return 0;
 	}
 
+	memcpy(user_stack + USERMODE_STACK_SIZE - 8, &func, 8);
+
 	asm volatile (
 			/* Prepare kernel SP for exception handlers */
 			"mov %%rsp, %[rsp0]\n\t"
@@ -63,12 +72,13 @@ uint64_t run_in_user(usermode_func func, unsigned int fault_vector,
 			"pushq %[user_stack_top]\n\t"
 			"pushfq\n\t"
 			"pushq %[user_cs]\n\t"
-			"lea user_mode(%%rip), %%rax\n\t"
+			"lea user_mode+0x800000(%%rip), %%rax\n\t" // smap.flat places usermode addresses at 8MB-16MB
 			"pushq %%rax\n\t"
 			"iretq\n"
 
 			"user_mode:\n\t"
 			/* Back up volatile registers before invoking func */
+			"pop %%rax\n\t"
 			"push %%rcx\n\t"
 			"push %%rdx\n\t"
 			"push %%rdi\n\t"
@@ -78,11 +88,12 @@ uint64_t run_in_user(usermode_func func, unsigned int fault_vector,
 			"push %%r10\n\t"
 			"push %%r11\n\t"
 			/* Call user mode function */
+			"add $0x800000,%%rbp\n\t"
 			"mov %[arg1], %%rdi\n\t"
 			"mov %[arg2], %%rsi\n\t"
 			"mov %[arg3], %%rdx\n\t"
 			"mov %[arg4], %%rcx\n\t"
-			"call *%[func]\n\t"
+			"call *%%rax\n\t"
 			/* Restore registers */
 			"pop %%r11\n\t"
 			"pop %%r10\n\t"
@@ -112,12 +123,11 @@ uint64_t run_in_user(usermode_func func, unsigned int fault_vector,
 			[arg2]"m"(arg2),
 			[arg3]"m"(arg3),
 			[arg4]"m"(arg4),
-			[func]"m"(func),
 			[user_ds]"i"(USER_DS),
 			[user_cs]"i"(USER_CS),
 			[kernel_ds]"rm"(KERNEL_DS),
 			[user_stack_top]"r"(user_stack +
-					sizeof(user_stack)),
+					USERMODE_STACK_SIZE - 8),
 			[kernel_entry_vector]"i"(RET_TO_KERNEL_IRQ));
 
 	handle_exception(fault_vector, old_ex);
diff --git a/x86/smap.c b/x86/smap.c
index 9a823a55..65119442 100644
--- a/x86/smap.c
+++ b/x86/smap.c
@@ -2,6 +2,7 @@
 #include <alloc_page.h>
 #include "x86/desc.h"
 #include "x86/processor.h"
+#include "x86/usermode.h"
 #include "x86/vm.h"
 
 volatile int pf_count = 0;
@@ -89,6 +90,31 @@ static void check_smap_nowp(void)
 	write_cr3(read_cr3());
 }
 
+#ifdef __x86_64__
+static void iret(void)
+{
+	asm volatile(
+	    "mov %%rsp, %%rcx;"
+	    "movl %%ss, %%ebx; pushq %%rbx; pushq %%rcx;"
+	    "pushf;"
+	    "movl %%cs, %%ebx; pushq %%rbx; "
+	    "lea 1f(%%rip), %%rbx; pushq %%rbx; iretq; 1:"
+
+		: : : "ebx", "ecx", "cc"); /* RPL=0 */
+}
+
+static void test_user_iret(void)
+{
+	bool raised_vector;
+	uintptr_t user_iret = (uintptr_t)iret + USER_BASE;
+
+	run_in_user((usermode_func)user_iret, PF_VECTOR, 0, 0, 0, 0,
+		    &raised_vector);
+
+	report(!raised_vector, "No #PF on CPL=3 DPL=3 iret");
+}
+#endif
+
 int main(int ac, char **av)
 {
 	unsigned long i;
@@ -196,7 +222,9 @@ int main(int ac, char **av)
 
 	check_smap_nowp();
 
-	// TODO: implicit kernel access from ring 3 (e.g. int)
+#ifdef __x86_64__
+	test_user_iret();
+#endif
 
 	return report_summary();
 }





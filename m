Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDA3D216AD
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iNu-0008Lx-2X; Tue, 15 Oct 2024 10:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iNh-0007gU-VI
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:18:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iNa-0003Nu-B0
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729001909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OYQ70JFBQ0ncTVmPjLYfygopz5A4fwPgOHvHyL+yuPc=;
 b=GwZXgPj5oIAvjyBA+qX0ZPmJxMsuvGjSs/ZIINgpaqUQ/INm0IjckKMlwA/aP9vRbGwE5V
 j0h6VHbD1BoBEZK4HCT4hn7xofh9k97tZEjRU27GUCT3m5WJNPxiA4ncE4GYfTjS8CaKeJ
 tEbWj5hDR7PQMnsM3TZN4JU4lSKwTYU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-RTKSN3R_Oe6aRPkrxTMaUA-1; Tue, 15 Oct 2024 10:18:27 -0400
X-MC-Unique: RTKSN3R_Oe6aRPkrxTMaUA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d589138a9so1876006f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001905; x=1729606705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OYQ70JFBQ0ncTVmPjLYfygopz5A4fwPgOHvHyL+yuPc=;
 b=LQ19ZCu8VBqGZEDyorxxfbgxoLwP2Yf8PrNiLZMSJoyMVutUIP7aSddEBur+b9c36L
 03JDFDMkSp45zyrWnW8pdhmxLsj//3Ubk7WFNTn/PSQAhV5qBKf1LXAx3JyqXaYNSdhi
 x6Q+JSZb6b3De1WNlw+lnhrcAGIN3KAmuhcjOW+EysRp40THBmRtpcNSOtkUJhwF/zyV
 1arg3vi/vy3E0SBd4KAZq1ivOhWuTzau+pi131ezIDw4ShndZprWUSdKqONuwUR/ds1I
 0doOn7ff6rQ0Yvjj6sTKGX2+p+1WXV24lCiT5cv6th6fxJaEoAZ7gFl/AFX8zXlP3Oi2
 bBdQ==
X-Gm-Message-State: AOJu0YzL2pKxKMPCRSwf3Cm1ZOp7/UQGQp+2b3I/YrCOZ/Ucidzq9oZR
 qYDKDF6QQAsyyIE9l28sXquN5Dbel2P6bjYuIq1kBiCJDRz7PnUvTc6nNIlCxMW0yfDE+AppA68
 JYbq6zCnKLRW9zddtnRaj3ncb9W9Xa31GX88sR5eDFKK9i9fedqe5hqPIIVwsgXY36Yi9/baQve
 97crpyWR4KHlx3DaGK+zIZUbsxOwiQz+WO0Sv4KC4=
X-Received: by 2002:adf:f547:0:b0:37d:4894:6895 with SMTP id
 ffacd0b85a97d-37d86bd4276mr451238f8f.15.1729001905065; 
 Tue, 15 Oct 2024 07:18:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOnxPVAgTrj6gK6rDXZkJUb2hXbZ4XI6kaRC5CS0ncJvwgSxdNEzF1Qwi8/1L85Zz7GbmHKQ==
X-Received: by 2002:adf:f547:0:b0:37d:4894:6895 with SMTP id
 ffacd0b85a97d-37d86bd4276mr451214f8f.15.1729001904574; 
 Tue, 15 Oct 2024 07:18:24 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f569933sm19467235e9.13.2024.10.15.07.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:18:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Robert R. Henry" <rrh.henry@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 21/25] target/i386/tcg: Use DPL-level accesses for interrupts
 and call gates
Date: Tue, 15 Oct 2024 16:17:07 +0200
Message-ID: <20241015141711.528342-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015141711.528342-1-pbonzini@redhat.com>
References: <20241015141711.528342-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Stack accesses should be explicit and use the privilege level of the
target stack.  This ensures that SMAP is not applied when the target
stack is in ring 3.

This fixes a bug wherein i386/tcg assumed that an interrupt return, or a
far call using the CALL or JMP instruction, was always going from kernel
or user mode to kernel mode when using a call gate. This assumption is
violated if the call gate has a DPL that is greater than 0.

Analyzed-by: Robert R. Henry <rrh.henry@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/249
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 3b8fd827e1f..02ae6a0d1fc 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -695,7 +695,6 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
 
     sa.env = env;
     sa.ra = 0;
-    sa.mmu_index = cpu_mmu_index_kernel(env);
 
     if (type == 5) {
         /* task gate */
@@ -705,7 +704,9 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
         }
         shift = switch_tss(env, intno * 8, e1, e2, SWITCH_TSS_CALL, old_eip);
         if (has_error_code) {
-            /* push the error code */
+            /* push the error code on the destination stack */
+            cpl = env->hflags & HF_CPL_MASK;
+            sa.mmu_index = x86_mmu_index_pl(env, cpl);
             if (env->segs[R_SS].flags & DESC_B_MASK) {
                 sa.sp_mask = 0xffffffff;
             } else {
@@ -750,6 +751,7 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
     if (e2 & DESC_C_MASK) {
         dpl = cpl;
     }
+    sa.mmu_index = x86_mmu_index_pl(env, dpl);
     if (dpl < cpl) {
         /* to inner privilege */
         uint32_t esp;
@@ -1001,7 +1003,7 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
 
     sa.env = env;
     sa.ra = 0;
-    sa.mmu_index = cpu_mmu_index_kernel(env);
+    sa.mmu_index = x86_mmu_index_pl(env, dpl);
     sa.sp_mask = -1;
     sa.ss_base = 0;
     if (dpl < cpl || ist != 0) {
@@ -1135,7 +1137,7 @@ static void do_interrupt_real(CPUX86State *env, int intno, int is_int,
     sa.sp = env->regs[R_ESP];
     sa.sp_mask = 0xffff;
     sa.ss_base = env->segs[R_SS].base;
-    sa.mmu_index = cpu_mmu_index_kernel(env);
+    sa.mmu_index = x86_mmu_index_pl(env, 0);
 
     if (is_int) {
         old_eip = next_eip;
@@ -1599,7 +1601,7 @@ void helper_lcall_real(CPUX86State *env, uint32_t new_cs, uint32_t new_eip,
     sa.sp = env->regs[R_ESP];
     sa.sp_mask = get_sp_mask(env->segs[R_SS].flags);
     sa.ss_base = env->segs[R_SS].base;
-    sa.mmu_index = cpu_mmu_index_kernel(env);
+    sa.mmu_index = x86_mmu_index_pl(env, 0);
 
     if (shift) {
         pushl(&sa, env->segs[R_CS].selector);
@@ -1639,9 +1641,9 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
 
     sa.env = env;
     sa.ra = GETPC();
-    sa.mmu_index = cpu_mmu_index_kernel(env);
 
     if (e2 & DESC_S_MASK) {
+        /* "normal" far call, no stack switch possible */
         if (!(e2 & DESC_CS_MASK)) {
             raise_exception_err_ra(env, EXCP0D_GPF, new_cs & 0xfffc, GETPC());
         }
@@ -1665,6 +1667,7 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
             raise_exception_err_ra(env, EXCP0B_NOSEG, new_cs & 0xfffc, GETPC());
         }
 
+        sa.mmu_index = x86_mmu_index_pl(env, cpl);
 #ifdef TARGET_X86_64
         /* XXX: check 16/32 bit cases in long mode */
         if (shift == 2) {
@@ -1792,6 +1795,7 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
 
         if (!(e2 & DESC_C_MASK) && dpl < cpl) {
             /* to inner privilege */
+            sa.mmu_index = x86_mmu_index_pl(env, dpl);
 #ifdef TARGET_X86_64
             if (shift == 2) {
                 ss = dpl;  /* SS = NULL selector with RPL = new CPL */
@@ -1870,6 +1874,7 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
             new_stack = 1;
         } else {
             /* to same privilege */
+            sa.mmu_index = x86_mmu_index_pl(env, cpl);
             sa.sp = env->regs[R_ESP];
             sa.sp_mask = get_sp_mask(env->segs[R_SS].flags);
             sa.ss_base = env->segs[R_SS].base;
-- 
2.46.2



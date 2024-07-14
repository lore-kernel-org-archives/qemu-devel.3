Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB2EC3DA49
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2024 11:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSx8R-0005Wh-2X; Sun, 14 Jul 2024 07:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sSx8N-0005Mf-ME
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 07:11:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sSx8K-00028J-PA
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 07:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720955472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JRUePkyI4BlsyZF8K6wIcJjT0NtE/ENQZ85bsJ3I+qY=;
 b=QeNpA6tPdSYv6n9MG/wMmm7PLy/8+CD7Jk52CYbqNgYByrcSVEi6e6TlNDdu12Xb4UHA4m
 WnyZJsNSCK5mJGSkS7qlBOw6uHJc0owVULyNNmNzdXvo90eP3SM7g08FdQ2l1RhjqBCoLl
 pbNbUL9JZgCJ2NFGxZsvoiyQ1pXi7y8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-vj7s4lZiN3yvuWqRjbk2eg-1; Sun, 14 Jul 2024 07:11:10 -0400
X-MC-Unique: vj7s4lZiN3yvuWqRjbk2eg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ee9b383ffbso35145641fa.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 04:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720955468; x=1721560268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JRUePkyI4BlsyZF8K6wIcJjT0NtE/ENQZ85bsJ3I+qY=;
 b=Otj5rN4/tbH1Eo+hH9gb7126MfqgrqpU4goYuqv7gBUlMgVzIsNe16reC4gx5tzl8I
 PgQ7Zm9A002ULDOENi66bwZ7jR3DDNArRADpuIIR7N/to5oEcRFhxrNLcoYBeGf3wIcJ
 Iv01cz9NGnjh0ashwuEqwGDxW0FEKADlY/dCHagLb9vYrEWAccXoavzLb5/Cx8xzUBiw
 AM7AjDWLf8FnrpF5u8DJjeneCr0ZXnUrNueb1KKf6T4djy9kPkeIxwP0pBMTZ5FLWqpm
 56fwhlnLC0z5nH4Ur67jtecYGF7l0opfdP5C9zgMZwnuDzvcXHKCUtLTiXqgBKKB0iBZ
 S9Ew==
X-Gm-Message-State: AOJu0YxkrzdfVlqPanpHp9v6mUUA12z5dW+vrnmfxKP4hOpzAp+7bxjc
 Z9ItiLh+bEMJu4Sh5+grstpIWSOtSymzo9L+v6YI/A5b7dsCSSE6KomPqBCZa9qzdHSTIG+I47i
 8vd9h7cOeOxY2HTcn22bl9GKsyA0TS8pVaaJDdyXQr4Xer5Q04pL+/yknw+gcbq4GRafsIpjvKR
 absjoyPk6+iiy5Nlp8ZZxJ/UwmiPzYIp9Dw6s6
X-Received: by 2002:a2e:9cda:0:b0:2ee:bc9a:9d7d with SMTP id
 38308e7fff4ca-2eebc9a9f96mr89874011fa.37.1720955468103; 
 Sun, 14 Jul 2024 04:11:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXESsiL/VEFgleDlYMWMRSQvwN02yq7M4Wjq6WuD357p31QnRtj22MfEVs2NEzbONELQI9Vw==
X-Received: by 2002:a2e:9cda:0:b0:2ee:bc9a:9d7d with SMTP id
 38308e7fff4ca-2eebc9a9f96mr89873851fa.37.1720955467677; 
 Sun, 14 Jul 2024 04:11:07 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dabef75sm3612351f8f.36.2024.07.14.04.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jul 2024 04:11:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Robert R . Henry" <rrh.henry@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/13] target/i386/tcg: Use DPL-level accesses for interrupts
 and call gates
Date: Sun, 14 Jul 2024 13:10:38 +0200
Message-ID: <20240714111043.14132-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240714111043.14132-1-pbonzini@redhat.com>
References: <20240714111043.14132-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

This fixes a bug wherein i386/tcg assumed an interrupt return using
the CALL or JMP instructions were always going from kernel or user mode to
kernel mode, when using a call gate. This assumption is violated if
the call gate has a DPL that is greater than 0.

In addition, the stack accesses should count as explicit, not implicit
("kernel" in QEMU code), so that SMAP is not applied if DPL=3.

Analyzed-by: Robert R. Henry <rrh.henry@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/249
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 8a6d92b3583..809ee3d9833 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -678,7 +678,7 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
 
     sa.env = env;
     sa.ra = 0;
-    sa.mmu_index = cpu_mmu_index_kernel(env);
+    sa.mmu_index = x86_mmu_index_pl(env, dpl);
 
     if (type == 5) {
         /* task gate */
@@ -984,7 +984,7 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
 
     sa.env = env;
     sa.ra = 0;
-    sa.mmu_index = cpu_mmu_index_kernel(env);
+    sa.mmu_index = x86_mmu_index_pl(env, dpl);
     sa.sp_mask = -1;
     sa.ss_base = 0;
     if (dpl < cpl || ist != 0) {
@@ -1119,7 +1119,7 @@ static void do_interrupt_real(CPUX86State *env, int intno, int is_int,
     sa.sp = env->regs[R_ESP];
     sa.sp_mask = 0xffff;
     sa.ss_base = env->segs[R_SS].base;
-    sa.mmu_index = cpu_mmu_index_kernel(env);
+    sa.mmu_index = x86_mmu_index_pl(env, 0);
 
     if (is_int) {
         old_eip = next_eip;
@@ -1583,7 +1583,7 @@ void helper_lcall_real(CPUX86State *env, uint32_t new_cs, uint32_t new_eip,
     sa.sp = env->regs[R_ESP];
     sa.sp_mask = get_sp_mask(env->segs[R_SS].flags);
     sa.ss_base = env->segs[R_SS].base;
-    sa.mmu_index = cpu_mmu_index_kernel(env);
+    sa.mmu_index = x86_mmu_index_pl(env, 0);
 
     if (shift) {
         pushl(&sa, env->segs[R_CS].selector);
@@ -1619,17 +1619,17 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
         raise_exception_err_ra(env, EXCP0D_GPF, new_cs & 0xfffc, GETPC());
     }
     cpl = env->hflags & HF_CPL_MASK;
+    dpl = (e2 >> DESC_DPL_SHIFT) & 3;
     LOG_PCALL("desc=%08x:%08x\n", e1, e2);
 
     sa.env = env;
     sa.ra = GETPC();
-    sa.mmu_index = cpu_mmu_index_kernel(env);
+    sa.mmu_index = x86_mmu_index_pl(env, dpl);
 
     if (e2 & DESC_S_MASK) {
         if (!(e2 & DESC_CS_MASK)) {
             raise_exception_err_ra(env, EXCP0D_GPF, new_cs & 0xfffc, GETPC());
         }
-        dpl = (e2 >> DESC_DPL_SHIFT) & 3;
         if (e2 & DESC_C_MASK) {
             /* conforming code segment */
             if (dpl > cpl) {
@@ -1691,7 +1691,6 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
     } else {
         /* check gate type */
         type = (e2 >> DESC_TYPE_SHIFT) & 0x1f;
-        dpl = (e2 >> DESC_DPL_SHIFT) & 3;
         rpl = new_cs & 3;
 
 #ifdef TARGET_X86_64
-- 
2.45.2



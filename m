Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89635C27C55
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrXG-0000Yb-Ee; Sat, 08 Jun 2024 04:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXF-0000YB-6J
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:34:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXD-0008J1-H5
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aHLLmdM1T47s1VBxMQynaNLfQGaY0mg7XaNcdIi3/jE=;
 b=KKqyPSopXZhtkrSFVoz04yBSmQLQOC9uXFvAhM7bFLDzEo3jXZ6ufBFKbto/WRFsjAVC8E
 ZPkhpv1NrspycczmPp9i3RjHoBE7jTqj5tuXnHLwE1qq8740QfM07v/STqTBTWn7nyokSx
 KXNcr/XbKvgJwkAiJI5lOqYRhRFJEHg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-SmEdl57AMpaC5dxcuGdTHQ-1; Sat, 08 Jun 2024 04:34:45 -0400
X-MC-Unique: SmEdl57AMpaC5dxcuGdTHQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6ef6ac6e0aso46459866b.0
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835683; x=1718440483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aHLLmdM1T47s1VBxMQynaNLfQGaY0mg7XaNcdIi3/jE=;
 b=BG9c78Zs8YTaSivTASwvDI4McVp83pGigUW4YQpyIxT2WwtwWIyzGPkpIdJYjeu67H
 gEndgJQBxDTSHX73VFEuPzguvEIhTqYNtYJAsj3yY/jr3x6iAtXoVjBzP6vGRt+EwGyO
 EaQvnyt3aMABey+89h7mp08vRBoPC7O+ASmI4IT5XUwyTVbiyGoxwYVxN0BVYRCImHNQ
 VerS+k1Hxub4MWIVd8JUqMN8KaPdwhhUk59kSExk8Ccrm8UuP7gKosZe6pg5aT9IJl4k
 EEu0YNzjg2vvGdCXHPSe4+nUe6gVGenD6r4HHHlryglgYmuvG7c2uTKZIvPgwTII3tNz
 tC6Q==
X-Gm-Message-State: AOJu0YyNOa9csCA20AkhD6KwASPbEQalgQ+fyRDXAxZdy4swVUNzBSnT
 i1/PeasOqLVnlAp7kjErHiDBfcW9xUBOlwf/T39lUG9xgfUwZbBcM0PwXvOgBCOKgEealpVus3b
 TFgz1tbtVyoIjT+BfjDlH6ObKbYhDGYNtkijj3MgHjSeVSaJ6ae7nXu2F11Cy9qRAcR+C9/v+ia
 UB4JSx9AgDA/dMlmWxkyTdCMmrw6Y7tBhpUz1c
X-Received: by 2002:a17:907:1ca1:b0:a6e:337:1428 with SMTP id
 a640c23a62f3a-a6e03372a85mr259602566b.57.1717835683497; 
 Sat, 08 Jun 2024 01:34:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMwQrD4T6AOMsqfMR3wFfYilitp1VeGT1DCER+3DCMINCHqSoasDBYb///sgWSW/UgYRdreQ==
X-Received: by 2002:a17:907:1ca1:b0:a6e:337:1428 with SMTP id
 a640c23a62f3a-a6e03372a85mr259585166b.57.1717835676597; 
 Sat, 08 Jun 2024 01:34:36 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f0a5989basm34791766b.219.2024.06.08.01.34.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:34:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/42] target/i386: disable/enable breakpoints on vmentry/vmexit
Date: Sat,  8 Jun 2024 10:33:39 +0200
Message-ID: <20240608083415.2769160-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

If the required DR7 (either from the VMCB or from the host save
area) disables a breakpoint that was enabled prior to vmentry
or vmexit, it is left enabled and will trigger EXCP_DEBUG.
This causes a spurious #DB on the next crossing of the breakpoint.

To disable it, vmentry/vmexit must use cpu_x86_update_dr7
to load DR7.

Because cpu_x86_update_dr7 takes a 32-bit argument, check
reserved bits prior to calling cpu_x86_update_dr7, and do the
same for DR6 as well for consistency.

This scenario is tested by the "host_rflags" test in kvm-unit-tests.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/sysemu/svm_helper.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/target/i386/tcg/sysemu/svm_helper.c b/target/i386/tcg/sysemu/svm_helper.c
index 5d6de2294fa..922d8964f8e 100644
--- a/target/i386/tcg/sysemu/svm_helper.c
+++ b/target/i386/tcg/sysemu/svm_helper.c
@@ -163,6 +163,8 @@ void helper_vmrun(CPUX86State *env, int aflag, int next_eip_addend)
     uint64_t new_cr0;
     uint64_t new_cr3;
     uint64_t new_cr4;
+    uint64_t new_dr6;
+    uint64_t new_dr7;
 
     if (aflag == 2) {
         addr = env->regs[R_EAX];
@@ -361,20 +363,22 @@ void helper_vmrun(CPUX86State *env, int aflag, int next_eip_addend)
                                 env->vm_vmcb + offsetof(struct vmcb, save.rsp));
     env->regs[R_EAX] = x86_ldq_phys(cs,
                                 env->vm_vmcb + offsetof(struct vmcb, save.rax));
-    env->dr[7] = x86_ldq_phys(cs,
-                          env->vm_vmcb + offsetof(struct vmcb, save.dr7));
-    env->dr[6] = x86_ldq_phys(cs,
-                          env->vm_vmcb + offsetof(struct vmcb, save.dr6));
+
+    new_dr7 = x86_ldq_phys(cs, env->vm_vmcb + offsetof(struct vmcb, save.dr7));
+    new_dr6 = x86_ldq_phys(cs, env->vm_vmcb + offsetof(struct vmcb, save.dr6));
 
 #ifdef TARGET_X86_64
-    if (env->dr[6] & DR_RESERVED_MASK) {
+    if (new_dr7 & DR_RESERVED_MASK) {
         cpu_vmexit(env, SVM_EXIT_ERR, 0, GETPC());
     }
-    if (env->dr[7] & DR_RESERVED_MASK) {
+    if (new_dr6 & DR_RESERVED_MASK) {
         cpu_vmexit(env, SVM_EXIT_ERR, 0, GETPC());
     }
 #endif
 
+    cpu_x86_update_dr7(env, new_dr7);
+    env->dr[6] = new_dr6;
+
     if (is_efer_invalid_state(env)) {
         cpu_vmexit(env, SVM_EXIT_ERR, 0, GETPC());
     }
@@ -864,8 +868,11 @@ void do_vmexit(CPUX86State *env)
 
     env->dr[6] = x86_ldq_phys(cs,
                           env->vm_hsave + offsetof(struct vmcb, save.dr6));
-    env->dr[7] = x86_ldq_phys(cs,
-                          env->vm_hsave + offsetof(struct vmcb, save.dr7));
+
+    /* Disables all breakpoints in the host DR7 register. */
+    cpu_x86_update_dr7(env,
+             x86_ldq_phys(cs,
+                          env->vm_hsave + offsetof(struct vmcb, save.dr7)) & ~0xff);
 
     /* other setups */
     x86_stl_phys(cs,
@@ -891,8 +898,6 @@ void do_vmexit(CPUX86State *env)
        from the page table indicated the host's CR3. If the PDPEs contain
        illegal state, the processor causes a shutdown. */
 
-    /* Disables all breakpoints in the host DR7 register. */
-
     /* Checks the reloaded host state for consistency. */
 
     /* If the host's rIP reloaded by #VMEXIT is outside the limit of the
-- 
2.45.1



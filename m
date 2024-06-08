Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EA6C27C55
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrXK-0000Zu-UW; Sat, 08 Jun 2024 04:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXG-0000Ya-CC
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:34:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXE-0008J6-Ap
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JE1l3mnnViu2bSu14FqFVuNS+di8GAj9jPlWPGLObPQ=;
 b=i5Ah6Ailm2eFK3+7R4QXvNo9Om/xQwfQh4E4imHi3Gdjsy1b1TK6WlDK6O/Artdg619llT
 C2HaHU7sOZusvxmwx7VqKbQY/cp7IBqThfW/ZIoW5wwwqkDksSg6LuUfh10EciKjBQpDaQ
 My7ySWDRIuy2cIp3p46R/zBD9mhjckk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-7ePzo6xOPZGqGpS51nTd1A-1; Sat, 08 Jun 2024 04:34:45 -0400
X-MC-Unique: 7ePzo6xOPZGqGpS51nTd1A-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6efac81377so29294966b.2
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835683; x=1718440483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JE1l3mnnViu2bSu14FqFVuNS+di8GAj9jPlWPGLObPQ=;
 b=AlZLD/f5JyfKYDAMJghwKrJwNsAXhX67hd57+SlZjCS7RsyICjl7/1qpYKq8t/8nD4
 JylKJhPnraqzrJOEJqsiJyHtUySOwJ8BfhNu4+x9SeV4LLSuD42qkWhSw8wb30ZVlHpu
 g9Rwdn3aVC7JOVs+NduMNmYxFF8DVCG7y1yryIW5GAucUPR4WHG900dkSAkMSwkOgpT0
 j2GDOEl6VGRXK9SeujFNXywK74sypaC+BzHVMmY9RkMK18bvasDW0fP4NV3nYitn6Fro
 a9+aJ/ZP5ufkl0iV4uTlpgnSq4dhrrVHwvT5GmGTISI98DvXAbsoXEkHMFRdwijuH3I+
 Fxsw==
X-Gm-Message-State: AOJu0YwOqYMWsVtSxE6p+3eglE2Dv3qPXWb/l1g962ynsrgEGG+3/V/U
 iJelMgLZo99vnqXVNTU/j2DP6QQGQYunoEE4zCZOxbAq2oRQP2f2omdj6NcVcSNtYOr7zGPf5Jz
 wyiVK/jj6mvwjTjRWBcYKkLF/Cuybz4cPhNBMs/JBgFjUpDa/HIl0pwlxwyauJysaU/VrwdQQy1
 zWivtEZz54vlajH/aH3LKE+uOcMjdBKgCLiAli
X-Received: by 2002:a17:906:f5a9:b0:a6f:2c2:9e98 with SMTP id
 a640c23a62f3a-a6f02c2a0demr81619066b.12.1717835683496; 
 Sat, 08 Jun 2024 01:34:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx6qcKV/fspAlFFotHRSBQv3y5tyl/j9n9WpvReQoYBLRuxdozhPqC9x5OQDTR59AZsUrcFA==
X-Received: by 2002:a17:906:f5a9:b0:a6f:2c2:9e98 with SMTP id
 a640c23a62f3a-a6f02c2a0demr81618166b.12.1717835683090; 
 Sat, 08 Jun 2024 01:34:43 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6ef64a75b7sm131819166b.191.2024.06.08.01.34.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:34:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/42] target/i386: fix TF/RF handling for HLT
Date: Sat,  8 Jun 2024 10:33:42 +0200
Message-ID: <20240608083415.2769160-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
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

HLT uses DISAS_NORETURN because the corresponding helper calls
cpu_loop_exit().  However, while gen_eob() clears HF_RF_MASK and
synthesizes a #DB exception if single-step is active, none of this is
done by HLT.  Note that the single-step trap is generated after the halt
is finished.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/sysemu/misc_helper.c |  2 +-
 target/i386/tcg/sysemu/seg_helper.c  | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/sysemu/misc_helper.c b/target/i386/tcg/sysemu/misc_helper.c
index 093cc2d0f90..7fa0c5a06de 100644
--- a/target/i386/tcg/sysemu/misc_helper.c
+++ b/target/i386/tcg/sysemu/misc_helper.c
@@ -520,7 +520,7 @@ G_NORETURN void helper_hlt(CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
 
-    env->hflags &= ~HF_INHIBIT_IRQ_MASK; /* needed if sti is just before */
+    do_end_instruction(env);
     cs->halted = 1;
     cs->exception_index = EXCP_HLT;
     cpu_loop_exit(cs);
diff --git a/target/i386/tcg/sysemu/seg_helper.c b/target/i386/tcg/sysemu/seg_helper.c
index 9ba94deb3aa..05174a79e73 100644
--- a/target/i386/tcg/sysemu/seg_helper.c
+++ b/target/i386/tcg/sysemu/seg_helper.c
@@ -130,15 +130,26 @@ void x86_cpu_do_interrupt(CPUState *cs)
 
 bool x86_cpu_exec_halt(CPUState *cpu)
 {
-    if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
-        X86CPU *x86_cpu = X86_CPU(cpu);
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
 
+    if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
         bql_lock();
         apic_poll_irq(x86_cpu->apic_state);
         cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
         bql_unlock();
     }
-    return cpu_has_work(cpu);
+
+    if (!cpu_has_work(cpu)) {
+        return false;
+    }
+
+    /* Complete HLT instruction.  */
+    if (env->eflags & TF_MASK) {
+        env->dr[6] |= DR6_BS;
+        do_interrupt_all(x86_cpu, EXCP01_DB, 0, 0, env->eip, 0);
+    }
+    return true;
 }
 
 bool x86_need_replay_interrupt(int interrupt_request)
-- 
2.45.1



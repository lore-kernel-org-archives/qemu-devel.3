Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A44CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 14:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqvTQ-0001BE-Is; Wed, 18 Sep 2024 10:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sqvTM-000191-NH
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 10:16:02 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sqvTK-0004TI-Og
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 10:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=vKqpOD15e1VclfTK3L5CXdjgHocRd3YUXBcZAVPIbgQ=; b=A8tttI3UgYTmNTnC
 7FBZXDhrytouCgiv42cVm25aHR6gwxm/8CxE9zeK5hZ2mU82sfD5DAHTDfQGTMTz4AMDaOHisHtlh
 3zehWCim2BUqfSKG6b+lqvgbhum8bboG99OU8Ix26MYztDjHDhxZ82EHgYkuLhxV5kxKFEfUsJTjU
 yDMiyjYowTucAxEb+vvPwTD3JbSmKXBdw8c5JT6B5+Pld6MHWVHZGmK30O3xTYE+mor3SlyDCu5WG
 LQpj6lebZ24yaFIvQ7ZpUolC4JPOij21p0lMgHueAnT1/Xru1OW5+qU1aywwHDg+P+XyHzbStOSuP
 t58cfmgowu1kRojFZQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1sqvTG-006Itt-1x;
 Wed, 18 Sep 2024 14:15:54 +0000
From: dave@treblig.org
To: richard.henderson@linaro.org,
	laurent@vivier.eu
Cc: qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] linux-user: Remove unused handle_vm86_fault
Date: Wed, 18 Sep 2024 15:15:53 +0100
Message-ID: <20240918141553.149521-1-dave@treblig.org>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

handle_vm86_fault has been unused since:
  1ade5b2fed ("linux-user/i386: Split out maybe_handle_vm86_trap")

Remove it, and it's local macros.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 linux-user/user-internals.h |   1 -
 linux-user/vm86.c           | 136 ------------------------------------
 2 files changed, 137 deletions(-)

diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index 5c7f173ceb..46ffc093f4 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -102,7 +102,6 @@ int host_to_target_waitstatus(int status);
 /* vm86.c */
 void save_v86_state(CPUX86State *env);
 void handle_vm86_trap(CPUX86State *env, int trapno);
-void handle_vm86_fault(CPUX86State *env);
 int do_vm86(CPUX86State *env, long subfunction, abi_ulong v86_addr);
 #elif defined(TARGET_SPARC64)
 void sparc64_set_context(CPUSPARCState *env);
diff --git a/linux-user/vm86.c b/linux-user/vm86.c
index 9f512a2242..31a2d707cf 100644
--- a/linux-user/vm86.c
+++ b/linux-user/vm86.c
@@ -255,142 +255,6 @@ void handle_vm86_trap(CPUX86State *env, int trapno)
     }
 }
 
-#define CHECK_IF_IN_TRAP() \
-      if ((ts->vm86plus.vm86plus.flags & TARGET_vm86dbg_active) && \
-          (ts->vm86plus.vm86plus.flags & TARGET_vm86dbg_TFpendig)) \
-                newflags |= TF_MASK
-
-#define VM86_FAULT_RETURN \
-        if ((ts->vm86plus.vm86plus.flags & TARGET_force_return_for_pic) && \
-            (ts->v86flags & (IF_MASK | VIF_MASK))) \
-            return_to_32bit(env, TARGET_VM86_PICRETURN); \
-        return
-
-void handle_vm86_fault(CPUX86State *env)
-{
-    CPUState *cs = env_cpu(env);
-    TaskState *ts = get_task_state(cs);
-    uint32_t csp, ssp;
-    unsigned int ip, sp, newflags, newip, newcs, opcode, intno;
-    int data32, pref_done;
-
-    csp = env->segs[R_CS].selector << 4;
-    ip = env->eip & 0xffff;
-
-    ssp = env->segs[R_SS].selector << 4;
-    sp = env->regs[R_ESP] & 0xffff;
-
-    LOG_VM86("VM86 exception %04x:%08x\n",
-             env->segs[R_CS].selector, env->eip);
-
-    data32 = 0;
-    pref_done = 0;
-    do {
-        opcode = vm_getb(env, csp, ip);
-        ADD16(ip, 1);
-        switch (opcode) {
-        case 0x66:      /* 32-bit data */     data32=1; break;
-        case 0x67:      /* 32-bit address */  break;
-        case 0x2e:      /* CS */              break;
-        case 0x3e:      /* DS */              break;
-        case 0x26:      /* ES */              break;
-        case 0x36:      /* SS */              break;
-        case 0x65:      /* GS */              break;
-        case 0x64:      /* FS */              break;
-        case 0xf2:      /* repnz */	      break;
-        case 0xf3:      /* rep */             break;
-        default: pref_done = 1;
-        }
-    } while (!pref_done);
-
-    /* VM86 mode */
-    switch(opcode) {
-    case 0x9c: /* pushf */
-        if (data32) {
-            vm_putl(env, ssp, sp - 4, get_vflags(env));
-            ADD16(env->regs[R_ESP], -4);
-        } else {
-            vm_putw(env, ssp, sp - 2, get_vflags(env));
-            ADD16(env->regs[R_ESP], -2);
-        }
-        env->eip = ip;
-        VM86_FAULT_RETURN;
-
-    case 0x9d: /* popf */
-        if (data32) {
-            newflags = vm_getl(env, ssp, sp);
-            ADD16(env->regs[R_ESP], 4);
-        } else {
-            newflags = vm_getw(env, ssp, sp);
-            ADD16(env->regs[R_ESP], 2);
-        }
-        env->eip = ip;
-        CHECK_IF_IN_TRAP();
-        if (data32) {
-            if (set_vflags_long(newflags, env))
-                return;
-        } else {
-            if (set_vflags_short(newflags, env))
-                return;
-        }
-        VM86_FAULT_RETURN;
-
-    case 0xcd: /* int */
-        intno = vm_getb(env, csp, ip);
-        ADD16(ip, 1);
-        env->eip = ip;
-        if (ts->vm86plus.vm86plus.flags & TARGET_vm86dbg_active) {
-            if ( (ts->vm86plus.vm86plus.vm86dbg_intxxtab[intno >> 3] >>
-                  (intno &7)) & 1) {
-                return_to_32bit(env, TARGET_VM86_INTx + (intno << 8));
-                return;
-            }
-        }
-        do_int(env, intno);
-        break;
-
-    case 0xcf: /* iret */
-        if (data32) {
-            newip = vm_getl(env, ssp, sp) & 0xffff;
-            newcs = vm_getl(env, ssp, sp + 4) & 0xffff;
-            newflags = vm_getl(env, ssp, sp + 8);
-            ADD16(env->regs[R_ESP], 12);
-        } else {
-            newip = vm_getw(env, ssp, sp);
-            newcs = vm_getw(env, ssp, sp + 2);
-            newflags = vm_getw(env, ssp, sp + 4);
-            ADD16(env->regs[R_ESP], 6);
-        }
-        env->eip = newip;
-        cpu_x86_load_seg(env, R_CS, newcs);
-        CHECK_IF_IN_TRAP();
-        if (data32) {
-            if (set_vflags_long(newflags, env))
-                return;
-        } else {
-            if (set_vflags_short(newflags, env))
-                return;
-        }
-        VM86_FAULT_RETURN;
-
-    case 0xfa: /* cli */
-        env->eip = ip;
-        clear_IF(env);
-        VM86_FAULT_RETURN;
-
-    case 0xfb: /* sti */
-        env->eip = ip;
-        if (set_IF(env))
-            return;
-        VM86_FAULT_RETURN;
-
-    default:
-        /* real VM86 GPF exception */
-        return_to_32bit(env, TARGET_VM86_UNKNOWN);
-        break;
-    }
-}
-
 int do_vm86(CPUX86State *env, long subfunction, abi_ulong vm86_addr)
 {
     CPUState *cs = env_cpu(env);
-- 
2.46.0



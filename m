Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAE5C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 06:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRQpl-0008NJ-SS; Wed, 10 Jul 2024 02:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRQpi-0008D2-FW
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:29:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRQpf-0000ua-9K
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720592978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VWTL4VrbXgQj1vr1wUg5bw0Yrmv3ueLbi/7PMgwKSwc=;
 b=jLmN10JlyMhbEs8WTd9s/RA7TOPw5VuTYUbnVGoWHU3cyqBy6UHN+hHVhFi4GKS/TLV04w
 QwpSCIvmQZ30YkDo4qmL1al6ZJGEup2G5Xh1GDiBP75bTj0z+23j4RMx2JWqu8/zJxBpM8
 3jnXuRfe68wH5ViuOFXok56eMuJ2dhg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-YZ5es4LDPPanEf0pFZm9NA-1; Wed, 10 Jul 2024 02:29:36 -0400
X-MC-Unique: YZ5es4LDPPanEf0pFZm9NA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42668699453so27364785e9.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 23:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720592974; x=1721197774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VWTL4VrbXgQj1vr1wUg5bw0Yrmv3ueLbi/7PMgwKSwc=;
 b=mwlWuO78YVCYgRYyIMBUs02VF1QdVIh6KRP4RiZDTkLHD+rPQ1Jv5ms9zlxTQL6mbH
 D4DDokg5HL2r5DLjzNNJ7H6pyRMu2aF8ry40sfjhc7WJrZHqWVWIvRyighcwhPnDJkfQ
 IVqRp0YUgnHQdD9OD5N/M5kh1TyqdBZOA5FyLFFBaVewGNxsjX9eaUPtwodrCu+oeJmi
 q+WSEeM69vm2JBLAw9GwioYMbqp3qWfihl4im30tPk+U5YbMwi8gYu/J/plMeQL7euTW
 Ok/TNscYaigeuWt2CGS43wLA6CUmzK74fPnwja2/32gyFQifsok1mK8TR13jkhT0r1C8
 LbwA==
X-Gm-Message-State: AOJu0YwmEBkgybpvN8yloWEi8eI/GDTbrW4uIjwrMwKVwUUafnOqhaZ7
 G3nq7RnPk02vv6+WFa6Dx0IueuZmw+TeMWMblfYqPb/z0WhGPhDgsXFbML5KXW374Plk+YL4vSk
 NpXFDMCwRKeEmvt7yvYBoUQ5B1hFVfQfZtIiYAuBtCxw5MALedOCBI9yA3jeURlddIEY9u60SNC
 ApzvLhS98t/r5rA9ouKnikNSPtwbw2pU1iD5HQ
X-Received: by 2002:a05:600c:2109:b0:426:58cb:8ca4 with SMTP id
 5b1f17b1804b1-426708f1d36mr35077515e9.37.1720592973996; 
 Tue, 09 Jul 2024 23:29:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKyE8wWern4fIr7F0IWs/THSK8nmSng0k67+PpbTMDzHzmPssX5qnknnqSeczqOa3p1cdjcg==
X-Received: by 2002:a05:600c:2109:b0:426:58cb:8ca4 with SMTP id
 5b1f17b1804b1-426708f1d36mr35077305e9.37.1720592973298; 
 Tue, 09 Jul 2024 23:29:33 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfab753sm4321191f8f.107.2024.07.09.23.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 23:29:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: rrh.henry@gmail.com,
	richard.henderson@linaro.org
Subject: [PATCH 04/10] target/i386/tcg: Reorg push/pop within seg_helper.c
Date: Wed, 10 Jul 2024 08:29:14 +0200
Message-ID: <20240710062920.73063-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710062920.73063-1-pbonzini@redhat.com>
References: <20240710062920.73063-1-pbonzini@redhat.com>
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

From: Richard Henderson <richard.henderson@linaro.org>

Interrupts and call gates should use accesses with the DPL as
the privilege level.  While computing the applicable MMU index
is easy, the harder thing is how to plumb it in the code.

One possibility could be to add a single argument to the PUSH* macros
for the privilege level, but this is repetitive and risks confusion
between the involved privilege levels.

Another possibility is to pass both CPL and DPL, and adjusting both
PUSH* and POP* to use specific privilege levels (instead of using
cpu_{ld,st}*_data). This makes the code more symmetric.

However, a more complicated but much nicer approach is to use a structure
to contain the stack parameters, env, unwind return address, and rewrite
the macros into functions.  The struct provides an easy home for the MMU
index as well.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20240617161210.4639-4-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 439 +++++++++++++++++++----------------
 1 file changed, 238 insertions(+), 201 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 0653bc10936..6b3de7a2be4 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -579,35 +579,47 @@ int exception_has_error_code(int intno)
     } while (0)
 #endif
 
-/* XXX: add a is_user flag to have proper security support */
-#define PUSHW_RA(ssp, sp, sp_mask, val, ra)                      \
-    {                                                            \
-        sp -= 2;                                                 \
-        cpu_stw_kernel_ra(env, (ssp) + (sp & (sp_mask)), (val), ra); \
-    }
+/* XXX: use mmu_index to have proper DPL support */
+typedef struct StackAccess
+{
+    CPUX86State *env;
+    uintptr_t ra;
+    target_ulong ss_base;
+    target_ulong sp;
+    target_ulong sp_mask;
+} StackAccess;
 
-#define PUSHL_RA(ssp, sp, sp_mask, val, ra)                             \
-    {                                                                   \
-        sp -= 4;                                                        \
-        cpu_stl_kernel_ra(env, (ssp) + (sp & (sp_mask)), (val), ra); \
-    }
+static void pushw(StackAccess *sa, uint16_t val)
+{
+    sa->sp -= 2;
+    cpu_stw_kernel_ra(sa->env, sa->ss_base + (sa->sp & sa->sp_mask),
+                      val, sa->ra);
+}
 
-#define POPW_RA(ssp, sp, sp_mask, val, ra)                       \
-    {                                                            \
-        val = cpu_lduw_data_ra(env, (ssp) + (sp & (sp_mask)), ra); \
-        sp += 2;                                                 \
-    }
+static void pushl(StackAccess *sa, uint32_t val)
+{
+    sa->sp -= 4;
+    cpu_stl_kernel_ra(sa->env, sa->ss_base + (sa->sp & sa->sp_mask),
+                      val, sa->ra);
+}
 
-#define POPL_RA(ssp, sp, sp_mask, val, ra)                              \
-    {                                                                   \
-        val = (uint32_t)cpu_ldl_data_ra(env, (ssp) + (sp & (sp_mask)), ra); \
-        sp += 4;                                                        \
-    }
+static uint16_t popw(StackAccess *sa)
+{
+    uint16_t ret = cpu_lduw_data_ra(sa->env,
+                                    sa->ss_base + (sa->sp & sa->sp_mask),
+                                    sa->ra);
+    sa->sp += 2;
+    return ret;
+}
 
-#define PUSHW(ssp, sp, sp_mask, val) PUSHW_RA(ssp, sp, sp_mask, val, 0)
-#define PUSHL(ssp, sp, sp_mask, val) PUSHL_RA(ssp, sp, sp_mask, val, 0)
-#define POPW(ssp, sp, sp_mask, val) POPW_RA(ssp, sp, sp_mask, val, 0)
-#define POPL(ssp, sp, sp_mask, val) POPL_RA(ssp, sp, sp_mask, val, 0)
+static uint32_t popl(StackAccess *sa)
+{
+    uint32_t ret = cpu_ldl_data_ra(sa->env,
+                                   sa->ss_base + (sa->sp & sa->sp_mask),
+                                   sa->ra);
+    sa->sp += 4;
+    return ret;
+}
 
 /* protected mode interrupt */
 static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
@@ -615,12 +627,13 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
                                    int is_hw)
 {
     SegmentCache *dt;
-    target_ulong ptr, ssp;
+    target_ulong ptr;
     int type, dpl, selector, ss_dpl, cpl;
     int has_error_code, new_stack, shift;
-    uint32_t e1, e2, offset, ss = 0, esp, ss_e1 = 0, ss_e2 = 0;
-    uint32_t old_eip, sp_mask, eflags;
+    uint32_t e1, e2, offset, ss = 0, ss_e1 = 0, ss_e2 = 0;
+    uint32_t old_eip, eflags;
     int vm86 = env->eflags & VM_MASK;
+    StackAccess sa;
     bool set_rf;
 
     has_error_code = 0;
@@ -662,6 +675,9 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
         raise_exception_err(env, EXCP0D_GPF, intno * 8 + 2);
     }
 
+    sa.env = env;
+    sa.ra = 0;
+
     if (type == 5) {
         /* task gate */
         /* must do that check here to return the correct error code */
@@ -672,18 +688,18 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
         if (has_error_code) {
             /* push the error code */
             if (env->segs[R_SS].flags & DESC_B_MASK) {
-                sp_mask = 0xffffffff;
+                sa.sp_mask = 0xffffffff;
             } else {
-                sp_mask = 0xffff;
+                sa.sp_mask = 0xffff;
             }
-            esp = env->regs[R_ESP];
-            ssp = env->segs[R_SS].base;
+            sa.sp = env->regs[R_ESP];
+            sa.ss_base = env->segs[R_SS].base;
             if (shift) {
-                PUSHL(ssp, esp, sp_mask, error_code);
+                pushl(&sa, error_code);
             } else {
-                PUSHW(ssp, esp, sp_mask, error_code);
+                pushw(&sa, error_code);
             }
-            SET_ESP(esp, sp_mask);
+            SET_ESP(sa.sp, sa.sp_mask);
         }
         return;
     }
@@ -717,6 +733,7 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
     }
     if (dpl < cpl) {
         /* to inner privilege */
+        uint32_t esp;
         get_ss_esp_from_tss(env, &ss, &esp, dpl, 0);
         if ((ss & 0xfffc) == 0) {
             raise_exception_err(env, EXCP0A_TSS, ss & 0xfffc);
@@ -740,17 +757,18 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
             raise_exception_err(env, EXCP0A_TSS, ss & 0xfffc);
         }
         new_stack = 1;
-        sp_mask = get_sp_mask(ss_e2);
-        ssp = get_seg_base(ss_e1, ss_e2);
+        sa.sp = esp;
+        sa.sp_mask = get_sp_mask(ss_e2);
+        sa.ss_base = get_seg_base(ss_e1, ss_e2);
     } else  {
         /* to same privilege */
         if (vm86) {
             raise_exception_err(env, EXCP0D_GPF, selector & 0xfffc);
         }
         new_stack = 0;
-        sp_mask = get_sp_mask(env->segs[R_SS].flags);
-        ssp = env->segs[R_SS].base;
-        esp = env->regs[R_ESP];
+        sa.sp = env->regs[R_ESP];
+        sa.sp_mask = get_sp_mask(env->segs[R_SS].flags);
+        sa.ss_base = env->segs[R_SS].base;
     }
 
     shift = type >> 3;
@@ -775,36 +793,36 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
     if (shift == 1) {
         if (new_stack) {
             if (vm86) {
-                PUSHL(ssp, esp, sp_mask, env->segs[R_GS].selector);
-                PUSHL(ssp, esp, sp_mask, env->segs[R_FS].selector);
-                PUSHL(ssp, esp, sp_mask, env->segs[R_DS].selector);
-                PUSHL(ssp, esp, sp_mask, env->segs[R_ES].selector);
+                pushl(&sa, env->segs[R_GS].selector);
+                pushl(&sa, env->segs[R_FS].selector);
+                pushl(&sa, env->segs[R_DS].selector);
+                pushl(&sa, env->segs[R_ES].selector);
             }
-            PUSHL(ssp, esp, sp_mask, env->segs[R_SS].selector);
-            PUSHL(ssp, esp, sp_mask, env->regs[R_ESP]);
+            pushl(&sa, env->segs[R_SS].selector);
+            pushl(&sa, env->regs[R_ESP]);
         }
-        PUSHL(ssp, esp, sp_mask, eflags);
-        PUSHL(ssp, esp, sp_mask, env->segs[R_CS].selector);
-        PUSHL(ssp, esp, sp_mask, old_eip);
+        pushl(&sa, eflags);
+        pushl(&sa, env->segs[R_CS].selector);
+        pushl(&sa, old_eip);
         if (has_error_code) {
-            PUSHL(ssp, esp, sp_mask, error_code);
+            pushl(&sa, error_code);
         }
     } else {
         if (new_stack) {
             if (vm86) {
-                PUSHW(ssp, esp, sp_mask, env->segs[R_GS].selector);
-                PUSHW(ssp, esp, sp_mask, env->segs[R_FS].selector);
-                PUSHW(ssp, esp, sp_mask, env->segs[R_DS].selector);
-                PUSHW(ssp, esp, sp_mask, env->segs[R_ES].selector);
+                pushw(&sa, env->segs[R_GS].selector);
+                pushw(&sa, env->segs[R_FS].selector);
+                pushw(&sa, env->segs[R_DS].selector);
+                pushw(&sa, env->segs[R_ES].selector);
             }
-            PUSHW(ssp, esp, sp_mask, env->segs[R_SS].selector);
-            PUSHW(ssp, esp, sp_mask, env->regs[R_ESP]);
+            pushw(&sa, env->segs[R_SS].selector);
+            pushw(&sa, env->regs[R_ESP]);
         }
-        PUSHW(ssp, esp, sp_mask, eflags);
-        PUSHW(ssp, esp, sp_mask, env->segs[R_CS].selector);
-        PUSHW(ssp, esp, sp_mask, old_eip);
+        pushw(&sa, eflags);
+        pushw(&sa, env->segs[R_CS].selector);
+        pushw(&sa, old_eip);
         if (has_error_code) {
-            PUSHW(ssp, esp, sp_mask, error_code);
+            pushw(&sa, error_code);
         }
     }
 
@@ -822,10 +840,10 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
             cpu_x86_load_seg_cache(env, R_GS, 0, 0, 0, 0);
         }
         ss = (ss & ~3) | dpl;
-        cpu_x86_load_seg_cache(env, R_SS, ss,
-                               ssp, get_seg_limit(ss_e1, ss_e2), ss_e2);
+        cpu_x86_load_seg_cache(env, R_SS, ss, sa.ss_base,
+                               get_seg_limit(ss_e1, ss_e2), ss_e2);
     }
-    SET_ESP(esp, sp_mask);
+    SET_ESP(sa.sp, sa.sp_mask);
 
     selector = (selector & ~3) | dpl;
     cpu_x86_load_seg_cache(env, R_CS, selector,
@@ -837,20 +855,18 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
 
 #ifdef TARGET_X86_64
 
-#define PUSHQ_RA(sp, val, ra)                   \
-    {                                           \
-        sp -= 8;                                \
-        cpu_stq_kernel_ra(env, sp, (val), ra);  \
-    }
+static void pushq(StackAccess *sa, uint64_t val)
+{
+    sa->sp -= 8;
+    cpu_stq_kernel_ra(sa->env, sa->sp, val, sa->ra);
+}
 
-#define POPQ_RA(sp, val, ra)                    \
-    {                                           \
-        val = cpu_ldq_data_ra(env, sp, ra);   \
-        sp += 8;                                \
-    }
-
-#define PUSHQ(sp, val) PUSHQ_RA(sp, val, 0)
-#define POPQ(sp, val) POPQ_RA(sp, val, 0)
+static uint64_t popq(StackAccess *sa)
+{
+    uint64_t ret = cpu_ldq_data_ra(sa->env, sa->sp, sa->ra);
+    sa->sp += 8;
+    return ret;
+}
 
 static inline target_ulong get_rsp_from_tss(CPUX86State *env, int level)
 {
@@ -893,8 +909,9 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
     int type, dpl, selector, cpl, ist;
     int has_error_code, new_stack;
     uint32_t e1, e2, e3, ss, eflags;
-    target_ulong old_eip, esp, offset;
+    target_ulong old_eip, offset;
     bool set_rf;
+    StackAccess sa;
 
     has_error_code = 0;
     if (!is_int && !is_hw) {
@@ -962,10 +979,15 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
     if (e2 & DESC_C_MASK) {
         dpl = cpl;
     }
+
+    sa.env = env;
+    sa.ra = 0;
+    sa.sp_mask = -1;
+    sa.ss_base = 0;
     if (dpl < cpl || ist != 0) {
         /* to inner privilege */
         new_stack = 1;
-        esp = get_rsp_from_tss(env, ist != 0 ? ist + 3 : dpl);
+        sa.sp = get_rsp_from_tss(env, ist != 0 ? ist + 3 : dpl);
         ss = 0;
     } else {
         /* to same privilege */
@@ -973,9 +995,9 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
             raise_exception_err(env, EXCP0D_GPF, selector & 0xfffc);
         }
         new_stack = 0;
-        esp = env->regs[R_ESP];
+        sa.sp = env->regs[R_ESP];
     }
-    esp &= ~0xfLL; /* align stack */
+    sa.sp &= ~0xfLL; /* align stack */
 
     /* See do_interrupt_protected.  */
     eflags = cpu_compute_eflags(env);
@@ -983,13 +1005,13 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
         eflags |= RF_MASK;
     }
 
-    PUSHQ(esp, env->segs[R_SS].selector);
-    PUSHQ(esp, env->regs[R_ESP]);
-    PUSHQ(esp, eflags);
-    PUSHQ(esp, env->segs[R_CS].selector);
-    PUSHQ(esp, old_eip);
+    pushq(&sa, env->segs[R_SS].selector);
+    pushq(&sa, env->regs[R_ESP]);
+    pushq(&sa, eflags);
+    pushq(&sa, env->segs[R_CS].selector);
+    pushq(&sa, old_eip);
     if (has_error_code) {
-        PUSHQ(esp, error_code);
+        pushq(&sa, error_code);
     }
 
     /* interrupt gate clear IF mask */
@@ -1002,7 +1024,7 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
         ss = 0 | dpl;
         cpu_x86_load_seg_cache(env, R_SS, ss, 0, 0, dpl << DESC_DPL_SHIFT);
     }
-    env->regs[R_ESP] = esp;
+    env->regs[R_ESP] = sa.sp;
 
     selector = (selector & ~3) | dpl;
     cpu_x86_load_seg_cache(env, R_CS, selector,
@@ -1074,10 +1096,11 @@ static void do_interrupt_real(CPUX86State *env, int intno, int is_int,
                               int error_code, unsigned int next_eip)
 {
     SegmentCache *dt;
-    target_ulong ptr, ssp;
+    target_ulong ptr;
     int selector;
-    uint32_t offset, esp;
+    uint32_t offset;
     uint32_t old_cs, old_eip;
+    StackAccess sa;
 
     /* real mode (simpler!) */
     dt = &env->idt;
@@ -1087,8 +1110,13 @@ static void do_interrupt_real(CPUX86State *env, int intno, int is_int,
     ptr = dt->base + intno * 4;
     offset = cpu_lduw_kernel(env, ptr);
     selector = cpu_lduw_kernel(env, ptr + 2);
-    esp = env->regs[R_ESP];
-    ssp = env->segs[R_SS].base;
+
+    sa.env = env;
+    sa.ra = 0;
+    sa.sp = env->regs[R_ESP];
+    sa.sp_mask = 0xffff;
+    sa.ss_base = env->segs[R_SS].base;
+
     if (is_int) {
         old_eip = next_eip;
     } else {
@@ -1096,12 +1124,12 @@ static void do_interrupt_real(CPUX86State *env, int intno, int is_int,
     }
     old_cs = env->segs[R_CS].selector;
     /* XXX: use SS segment size? */
-    PUSHW(ssp, esp, 0xffff, cpu_compute_eflags(env));
-    PUSHW(ssp, esp, 0xffff, old_cs);
-    PUSHW(ssp, esp, 0xffff, old_eip);
+    pushw(&sa, cpu_compute_eflags(env));
+    pushw(&sa, old_cs);
+    pushw(&sa, old_eip);
 
     /* update processor state */
-    env->regs[R_ESP] = (env->regs[R_ESP] & ~0xffff) | (esp & 0xffff);
+    SET_ESP(sa.sp, sa.sp_mask);
     env->eip = offset;
     env->segs[R_CS].selector = selector;
     env->segs[R_CS].base = (selector << 4);
@@ -1544,21 +1572,23 @@ void helper_ljmp_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
 void helper_lcall_real(CPUX86State *env, uint32_t new_cs, uint32_t new_eip,
                        int shift, uint32_t next_eip)
 {
-    uint32_t esp, esp_mask;
-    target_ulong ssp;
+    StackAccess sa;
+
+    sa.env = env;
+    sa.ra = GETPC();
+    sa.sp = env->regs[R_ESP];
+    sa.sp_mask = get_sp_mask(env->segs[R_SS].flags);
+    sa.ss_base = env->segs[R_SS].base;
 
-    esp = env->regs[R_ESP];
-    esp_mask = get_sp_mask(env->segs[R_SS].flags);
-    ssp = env->segs[R_SS].base;
     if (shift) {
-        PUSHL_RA(ssp, esp, esp_mask, env->segs[R_CS].selector, GETPC());
-        PUSHL_RA(ssp, esp, esp_mask, next_eip, GETPC());
+        pushl(&sa, env->segs[R_CS].selector);
+        pushl(&sa, next_eip);
     } else {
-        PUSHW_RA(ssp, esp, esp_mask, env->segs[R_CS].selector, GETPC());
-        PUSHW_RA(ssp, esp, esp_mask, next_eip, GETPC());
+        pushw(&sa, env->segs[R_CS].selector);
+        pushw(&sa, next_eip);
     }
 
-    SET_ESP(esp, esp_mask);
+    SET_ESP(sa.sp, sa.sp_mask);
     env->eip = new_eip;
     env->segs[R_CS].selector = new_cs;
     env->segs[R_CS].base = (new_cs << 4);
@@ -1570,9 +1600,10 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
 {
     int new_stack, i;
     uint32_t e1, e2, cpl, dpl, rpl, selector, param_count;
-    uint32_t ss = 0, ss_e1 = 0, ss_e2 = 0, type, ss_dpl, sp_mask;
+    uint32_t ss = 0, ss_e1 = 0, ss_e2 = 0, type, ss_dpl;
     uint32_t val, limit, old_sp_mask;
-    target_ulong ssp, old_ssp, offset, sp;
+    target_ulong old_ssp, offset;
+    StackAccess sa;
 
     LOG_PCALL("lcall %04x:" TARGET_FMT_lx " s=%d\n", new_cs, new_eip, shift);
     LOG_PCALL_STATE(env_cpu(env));
@@ -1584,6 +1615,10 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
     }
     cpl = env->hflags & HF_CPL_MASK;
     LOG_PCALL("desc=%08x:%08x\n", e1, e2);
+
+    sa.env = env;
+    sa.ra = GETPC();
+
     if (e2 & DESC_S_MASK) {
         if (!(e2 & DESC_CS_MASK)) {
             raise_exception_err_ra(env, EXCP0D_GPF, new_cs & 0xfffc, GETPC());
@@ -1611,14 +1646,14 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
 #ifdef TARGET_X86_64
         /* XXX: check 16/32 bit cases in long mode */
         if (shift == 2) {
-            target_ulong rsp;
-
             /* 64 bit case */
-            rsp = env->regs[R_ESP];
-            PUSHQ_RA(rsp, env->segs[R_CS].selector, GETPC());
-            PUSHQ_RA(rsp, next_eip, GETPC());
+            sa.sp = env->regs[R_ESP];
+            sa.sp_mask = -1;
+            sa.ss_base = 0;
+            pushq(&sa, env->segs[R_CS].selector);
+            pushq(&sa, next_eip);
             /* from this point, not restartable */
-            env->regs[R_ESP] = rsp;
+            env->regs[R_ESP] = sa.sp;
             cpu_x86_load_seg_cache(env, R_CS, (new_cs & 0xfffc) | cpl,
                                    get_seg_base(e1, e2),
                                    get_seg_limit(e1, e2), e2);
@@ -1626,15 +1661,15 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
         } else
 #endif
         {
-            sp = env->regs[R_ESP];
-            sp_mask = get_sp_mask(env->segs[R_SS].flags);
-            ssp = env->segs[R_SS].base;
+            sa.sp = env->regs[R_ESP];
+            sa.sp_mask = get_sp_mask(env->segs[R_SS].flags);
+            sa.ss_base = env->segs[R_SS].base;
             if (shift) {
-                PUSHL_RA(ssp, sp, sp_mask, env->segs[R_CS].selector, GETPC());
-                PUSHL_RA(ssp, sp, sp_mask, next_eip, GETPC());
+                pushl(&sa, env->segs[R_CS].selector);
+                pushl(&sa, next_eip);
             } else {
-                PUSHW_RA(ssp, sp, sp_mask, env->segs[R_CS].selector, GETPC());
-                PUSHW_RA(ssp, sp, sp_mask, next_eip, GETPC());
+                pushw(&sa, env->segs[R_CS].selector);
+                pushw(&sa, next_eip);
             }
 
             limit = get_seg_limit(e1, e2);
@@ -1642,7 +1677,7 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
                 raise_exception_err_ra(env, EXCP0D_GPF, new_cs & 0xfffc, GETPC());
             }
             /* from this point, not restartable */
-            SET_ESP(sp, sp_mask);
+            SET_ESP(sa.sp, sa.sp_mask);
             cpu_x86_load_seg_cache(env, R_CS, (new_cs & 0xfffc) | cpl,
                                    get_seg_base(e1, e2), limit, e2);
             env->eip = new_eip;
@@ -1737,13 +1772,13 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
             /* to inner privilege */
 #ifdef TARGET_X86_64
             if (shift == 2) {
-                sp = get_rsp_from_tss(env, dpl);
                 ss = dpl;  /* SS = NULL selector with RPL = new CPL */
                 new_stack = 1;
-                sp_mask = 0;
-                ssp = 0;  /* SS base is always zero in IA-32e mode */
+                sa.sp = get_rsp_from_tss(env, dpl);
+                sa.sp_mask = -1;
+                sa.ss_base = 0;  /* SS base is always zero in IA-32e mode */
                 LOG_PCALL("new ss:rsp=%04x:%016llx env->regs[R_ESP]="
-                          TARGET_FMT_lx "\n", ss, sp, env->regs[R_ESP]);
+                          TARGET_FMT_lx "\n", ss, sa.sp, env->regs[R_ESP]);
             } else
 #endif
             {
@@ -1752,7 +1787,6 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
                 LOG_PCALL("new ss:esp=%04x:%08x param_count=%d env->regs[R_ESP]="
                           TARGET_FMT_lx "\n", ss, sp32, param_count,
                           env->regs[R_ESP]);
-                sp = sp32;
                 if ((ss & 0xfffc) == 0) {
                     raise_exception_err_ra(env, EXCP0A_TSS, ss & 0xfffc, GETPC());
                 }
@@ -1775,63 +1809,64 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
                     raise_exception_err_ra(env, EXCP0A_TSS, ss & 0xfffc, GETPC());
                 }
 
-                sp_mask = get_sp_mask(ss_e2);
-                ssp = get_seg_base(ss_e1, ss_e2);
+                sa.sp = sp32;
+                sa.sp_mask = get_sp_mask(ss_e2);
+                sa.ss_base = get_seg_base(ss_e1, ss_e2);
             }
 
             /* push_size = ((param_count * 2) + 8) << shift; */
-
             old_sp_mask = get_sp_mask(env->segs[R_SS].flags);
             old_ssp = env->segs[R_SS].base;
+
 #ifdef TARGET_X86_64
             if (shift == 2) {
                 /* XXX: verify if new stack address is canonical */
-                PUSHQ_RA(sp, env->segs[R_SS].selector, GETPC());
-                PUSHQ_RA(sp, env->regs[R_ESP], GETPC());
+                pushq(&sa, env->segs[R_SS].selector);
+                pushq(&sa, env->regs[R_ESP]);
                 /* parameters aren't supported for 64-bit call gates */
             } else
 #endif
             if (shift == 1) {
-                PUSHL_RA(ssp, sp, sp_mask, env->segs[R_SS].selector, GETPC());
-                PUSHL_RA(ssp, sp, sp_mask, env->regs[R_ESP], GETPC());
+                pushl(&sa, env->segs[R_SS].selector);
+                pushl(&sa, env->regs[R_ESP]);
                 for (i = param_count - 1; i >= 0; i--) {
                     val = cpu_ldl_data_ra(env,
-					  old_ssp + ((env->regs[R_ESP] + i * 4) & old_sp_mask),
-					  GETPC());
-                    PUSHL_RA(ssp, sp, sp_mask, val, GETPC());
+                                          old_ssp + ((env->regs[R_ESP] + i * 4) & old_sp_mask),
+                                          GETPC());
+                    pushl(&sa, val);
                 }
             } else {
-                PUSHW_RA(ssp, sp, sp_mask, env->segs[R_SS].selector, GETPC());
-                PUSHW_RA(ssp, sp, sp_mask, env->regs[R_ESP], GETPC());
+                pushw(&sa, env->segs[R_SS].selector);
+                pushw(&sa, env->regs[R_ESP]);
                 for (i = param_count - 1; i >= 0; i--) {
                     val = cpu_lduw_data_ra(env,
-					   old_ssp + ((env->regs[R_ESP] + i * 2) & old_sp_mask),
-					   GETPC());
-                    PUSHW_RA(ssp, sp, sp_mask, val, GETPC());
+                                           old_ssp + ((env->regs[R_ESP] + i * 2) & old_sp_mask),
+                                           GETPC());
+                    pushw(&sa, val);
                 }
             }
             new_stack = 1;
         } else {
             /* to same privilege */
-            sp = env->regs[R_ESP];
-            sp_mask = get_sp_mask(env->segs[R_SS].flags);
-            ssp = env->segs[R_SS].base;
+            sa.sp = env->regs[R_ESP];
+            sa.sp_mask = get_sp_mask(env->segs[R_SS].flags);
+            sa.ss_base = env->segs[R_SS].base;
             /* push_size = (4 << shift); */
             new_stack = 0;
         }
 
 #ifdef TARGET_X86_64
         if (shift == 2) {
-            PUSHQ_RA(sp, env->segs[R_CS].selector, GETPC());
-            PUSHQ_RA(sp, next_eip, GETPC());
+            pushq(&sa, env->segs[R_CS].selector);
+            pushq(&sa, next_eip);
         } else
 #endif
         if (shift == 1) {
-            PUSHL_RA(ssp, sp, sp_mask, env->segs[R_CS].selector, GETPC());
-            PUSHL_RA(ssp, sp, sp_mask, next_eip, GETPC());
+            pushl(&sa, env->segs[R_CS].selector);
+            pushl(&sa, next_eip);
         } else {
-            PUSHW_RA(ssp, sp, sp_mask, env->segs[R_CS].selector, GETPC());
-            PUSHW_RA(ssp, sp, sp_mask, next_eip, GETPC());
+            pushw(&sa, env->segs[R_CS].selector);
+            pushw(&sa, next_eip);
         }
 
         /* from this point, not restartable */
@@ -1845,7 +1880,7 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
             {
                 ss = (ss & ~3) | dpl;
                 cpu_x86_load_seg_cache(env, R_SS, ss,
-                                       ssp,
+                                       sa.ss_base,
                                        get_seg_limit(ss_e1, ss_e2),
                                        ss_e2);
             }
@@ -1856,7 +1891,7 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
                        get_seg_base(e1, e2),
                        get_seg_limit(e1, e2),
                        e2);
-        SET_ESP(sp, sp_mask);
+        SET_ESP(sa.sp, sa.sp_mask);
         env->eip = offset;
     }
 }
@@ -1864,26 +1899,28 @@ void helper_lcall_protected(CPUX86State *env, int new_cs, target_ulong new_eip,
 /* real and vm86 mode iret */
 void helper_iret_real(CPUX86State *env, int shift)
 {
-    uint32_t sp, new_cs, new_eip, new_eflags, sp_mask;
-    target_ulong ssp;
+    uint32_t new_cs, new_eip, new_eflags;
     int eflags_mask;
+    StackAccess sa;
+
+    sa.env = env;
+    sa.ra = GETPC();
+    sa.sp_mask = 0xffff; /* XXXX: use SS segment size? */
+    sa.sp = env->regs[R_ESP];
+    sa.ss_base = env->segs[R_SS].base;
 
-    sp_mask = 0xffff; /* XXXX: use SS segment size? */
-    sp = env->regs[R_ESP];
-    ssp = env->segs[R_SS].base;
     if (shift == 1) {
         /* 32 bits */
-        POPL_RA(ssp, sp, sp_mask, new_eip, GETPC());
-        POPL_RA(ssp, sp, sp_mask, new_cs, GETPC());
-        new_cs &= 0xffff;
-        POPL_RA(ssp, sp, sp_mask, new_eflags, GETPC());
+        new_eip = popl(&sa);
+        new_cs = popl(&sa) & 0xffff;
+        new_eflags = popl(&sa);
     } else {
         /* 16 bits */
-        POPW_RA(ssp, sp, sp_mask, new_eip, GETPC());
-        POPW_RA(ssp, sp, sp_mask, new_cs, GETPC());
-        POPW_RA(ssp, sp, sp_mask, new_eflags, GETPC());
+        new_eip = popw(&sa);
+        new_cs = popw(&sa);
+        new_eflags = popw(&sa);
     }
-    env->regs[R_ESP] = (env->regs[R_ESP] & ~sp_mask) | (sp & sp_mask);
+    SET_ESP(sa.sp, sa.sp_mask);
     env->segs[R_CS].selector = new_cs;
     env->segs[R_CS].base = (new_cs << 4);
     env->eip = new_eip;
@@ -1936,47 +1973,49 @@ static inline void helper_ret_protected(CPUX86State *env, int shift,
     uint32_t new_es, new_ds, new_fs, new_gs;
     uint32_t e1, e2, ss_e1, ss_e2;
     int cpl, dpl, rpl, eflags_mask, iopl;
-    target_ulong ssp, sp, new_eip, new_esp, sp_mask;
+    target_ulong new_eip, new_esp;
+    StackAccess sa;
+
+    sa.env = env;
+    sa.ra = retaddr;
 
 #ifdef TARGET_X86_64
     if (shift == 2) {
-        sp_mask = -1;
+        sa.sp_mask = -1;
     } else
 #endif
     {
-        sp_mask = get_sp_mask(env->segs[R_SS].flags);
+        sa.sp_mask = get_sp_mask(env->segs[R_SS].flags);
     }
-    sp = env->regs[R_ESP];
-    ssp = env->segs[R_SS].base;
+    sa.sp = env->regs[R_ESP];
+    sa.ss_base = env->segs[R_SS].base;
     new_eflags = 0; /* avoid warning */
 #ifdef TARGET_X86_64
     if (shift == 2) {
-        POPQ_RA(sp, new_eip, retaddr);
-        POPQ_RA(sp, new_cs, retaddr);
-        new_cs &= 0xffff;
+        new_eip = popq(&sa);
+        new_cs = popq(&sa) & 0xffff;
         if (is_iret) {
-            POPQ_RA(sp, new_eflags, retaddr);
+            new_eflags = popq(&sa);
         }
     } else
 #endif
     {
         if (shift == 1) {
             /* 32 bits */
-            POPL_RA(ssp, sp, sp_mask, new_eip, retaddr);
-            POPL_RA(ssp, sp, sp_mask, new_cs, retaddr);
-            new_cs &= 0xffff;
+            new_eip = popl(&sa);
+            new_cs = popl(&sa) & 0xffff;
             if (is_iret) {
-                POPL_RA(ssp, sp, sp_mask, new_eflags, retaddr);
+                new_eflags = popl(&sa);
                 if (new_eflags & VM_MASK) {
                     goto return_to_vm86;
                 }
             }
         } else {
             /* 16 bits */
-            POPW_RA(ssp, sp, sp_mask, new_eip, retaddr);
-            POPW_RA(ssp, sp, sp_mask, new_cs, retaddr);
+            new_eip = popw(&sa);
+            new_cs = popw(&sa);
             if (is_iret) {
-                POPW_RA(ssp, sp, sp_mask, new_eflags, retaddr);
+                new_eflags = popw(&sa);
             }
         }
     }
@@ -2012,7 +2051,7 @@ static inline void helper_ret_protected(CPUX86State *env, int shift,
         raise_exception_err_ra(env, EXCP0B_NOSEG, new_cs & 0xfffc, retaddr);
     }
 
-    sp += addend;
+    sa.sp += addend;
     if (rpl == cpl && (!(env->hflags & HF_CS64_MASK) ||
                        ((env->hflags & HF_CS64_MASK) && !is_iret))) {
         /* return to same privilege level */
@@ -2024,21 +2063,19 @@ static inline void helper_ret_protected(CPUX86State *env, int shift,
         /* return to different privilege level */
 #ifdef TARGET_X86_64
         if (shift == 2) {
-            POPQ_RA(sp, new_esp, retaddr);
-            POPQ_RA(sp, new_ss, retaddr);
-            new_ss &= 0xffff;
+            new_esp = popq(&sa);
+            new_ss = popq(&sa) & 0xffff;
         } else
 #endif
         {
             if (shift == 1) {
                 /* 32 bits */
-                POPL_RA(ssp, sp, sp_mask, new_esp, retaddr);
-                POPL_RA(ssp, sp, sp_mask, new_ss, retaddr);
-                new_ss &= 0xffff;
+                new_esp = popl(&sa);
+                new_ss = popl(&sa) & 0xffff;
             } else {
                 /* 16 bits */
-                POPW_RA(ssp, sp, sp_mask, new_esp, retaddr);
-                POPW_RA(ssp, sp, sp_mask, new_ss, retaddr);
+                new_esp = popw(&sa);
+                new_ss = popw(&sa);
             }
         }
         LOG_PCALL("new ss:esp=%04x:" TARGET_FMT_lx "\n",
@@ -2088,14 +2125,14 @@ static inline void helper_ret_protected(CPUX86State *env, int shift,
                        get_seg_base(e1, e2),
                        get_seg_limit(e1, e2),
                        e2);
-        sp = new_esp;
+        sa.sp = new_esp;
 #ifdef TARGET_X86_64
         if (env->hflags & HF_CS64_MASK) {
-            sp_mask = -1;
+            sa.sp_mask = -1;
         } else
 #endif
         {
-            sp_mask = get_sp_mask(ss_e2);
+            sa.sp_mask = get_sp_mask(ss_e2);
         }
 
         /* validate data segments */
@@ -2104,9 +2141,9 @@ static inline void helper_ret_protected(CPUX86State *env, int shift,
         validate_seg(env, R_FS, rpl);
         validate_seg(env, R_GS, rpl);
 
-        sp += addend;
+        sa.sp += addend;
     }
-    SET_ESP(sp, sp_mask);
+    SET_ESP(sa.sp, sa.sp_mask);
     env->eip = new_eip;
     if (is_iret) {
         /* NOTE: 'cpl' is the _old_ CPL */
@@ -2126,12 +2163,12 @@ static inline void helper_ret_protected(CPUX86State *env, int shift,
     return;
 
  return_to_vm86:
-    POPL_RA(ssp, sp, sp_mask, new_esp, retaddr);
-    POPL_RA(ssp, sp, sp_mask, new_ss, retaddr);
-    POPL_RA(ssp, sp, sp_mask, new_es, retaddr);
-    POPL_RA(ssp, sp, sp_mask, new_ds, retaddr);
-    POPL_RA(ssp, sp, sp_mask, new_fs, retaddr);
-    POPL_RA(ssp, sp, sp_mask, new_gs, retaddr);
+    new_esp = popl(&sa);
+    new_ss = popl(&sa);
+    new_es = popl(&sa);
+    new_ds = popl(&sa);
+    new_fs = popl(&sa);
+    new_gs = popl(&sa);
 
     /* modify processor state */
     cpu_load_eflags(env, new_eflags, TF_MASK | AC_MASK | ID_MASK |
-- 
2.45.2



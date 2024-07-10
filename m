Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53085C3DA45
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 06:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRQpz-0000uP-2d; Wed, 10 Jul 2024 02:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRQpx-0000ox-NJ
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:29:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRQpv-0000vh-QC
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 02:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720592995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LOknd05sKwCruykEoyDotoa/EwDe53WiDHzzrB4cdNA=;
 b=ayk1tOdQzOEOHkStinlkmuGYyY9epuJfCIjpiKxPrOkCwzXceaOVMBghgZBm/YlgYuhOGm
 5LJjzOR2ILgcU8C/7Fi2hbqAH+7sOdJFuOAO7sNcDrVRr1Zu10QK8n2HteOnl05u6UQj8a
 osUAVzqLYAjqK+AoruuIPkJunaMuGWQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-mAlj_skAPoaWJHNAbW251Q-1; Wed, 10 Jul 2024 02:29:51 -0400
X-MC-Unique: mAlj_skAPoaWJHNAbW251Q-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ee87e69b53so63941811fa.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 23:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720592988; x=1721197788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LOknd05sKwCruykEoyDotoa/EwDe53WiDHzzrB4cdNA=;
 b=AmP9fUin8jVoxxBl9Ap30hjU2sELm35jGtXUL9Rw8cgKHVXvL1RKRah1GDhwoa1Otl
 lmr6hlcb04KRcjrtFVvojEJdWHtNowoyXwJxPvHbcQZvPgdWkY+jMAsBJHOy12tUvzYW
 4Eou7y1Ftz73FCXqlP80U+p1a/LtvyP3rpdwBt1PggpRlSLz2hC7UrwjBjMZPJvk7iuP
 u6ovWWcluhICtbzbwgJ9KptZLDX2gR0AereWxRH8cwBsxZ0ngAuBNlgFv+aEmF/SDnuy
 Dxl1ItftRLB4/DlkJr2BxsWnnqrKbhz8Lmm7v+X4EwETZDEvEx1qzNjjVPSjlATYJYef
 RlwA==
X-Gm-Message-State: AOJu0Yz8tSTDhUsFBD4Ui3UGGtxl4fzu5Chyw3mFz13onN2Qc4DOcLVn
 57fb6EVwIncGyMzx9IlEDfQJDoErrI/lprHUjQuRa30saC9Y4iWsvL2ha5ik9i5Q2g4ZomuusUM
 bT4LtMomWej90TBpUDgCSN9JUSUWvUeFhReqKKoNTKx9N8R8UIGGr6kq31wbAk0IqMSC3vsb2cK
 y6Zru3qtGWd444nzA13Lj17VAEANnNnt7lkQSq
X-Received: by 2002:a2e:9ec6:0:b0:2ec:4b00:a746 with SMTP id
 38308e7fff4ca-2eeb30bb394mr32864501fa.9.1720592987897; 
 Tue, 09 Jul 2024 23:29:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+t/t9GMGIFZlnMR7HkdoSAWDKWRhJI5tPtWszk1pfiPppcFT6eQyztgrDnuiOvpewNJNIqQ==
X-Received: by 2002:a2e:9ec6:0:b0:2ec:4b00:a746 with SMTP id
 38308e7fff4ca-2eeb30bb394mr32864341fa.9.1720592987419; 
 Tue, 09 Jul 2024 23:29:47 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfb228csm4325189f8f.114.2024.07.09.23.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 23:29:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: rrh.henry@gmail.com,
	richard.henderson@linaro.org
Subject: [PATCH 09/10] target/i386/tcg: use X86Access for TSS access
Date: Wed, 10 Jul 2024 08:29:19 +0200
Message-ID: <20240710062920.73063-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710062920.73063-1-pbonzini@redhat.com>
References: <20240710062920.73063-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

This takes care of probing the vaddr range in advance, and is also faster
because it avoids repeated TLB lookups.  It also matches the Intel manual
better, as it says "Checks that the current (old) TSS, new TSS, and all
segment descriptors used in the task switch are paged into system memory";
note however that it's not clear how the processor checks for segment
descriptors, and this check is not included in the AMD manual.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 101 ++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 50 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 25af9d4a4ec..77f2c65c3cf 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -27,6 +27,7 @@
 #include "exec/log.h"
 #include "helper-tcg.h"
 #include "seg_helper.h"
+#include "access.h"
 
 int get_pg_mode(CPUX86State *env)
 {
@@ -250,7 +251,7 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
                          uint32_t e1, uint32_t e2, int source,
                          uint32_t next_eip, uintptr_t retaddr)
 {
-    int tss_limit, tss_limit_max, type, old_tss_limit_max, old_type, v1, v2, i;
+    int tss_limit, tss_limit_max, type, old_tss_limit_max, old_type, i;
     target_ulong tss_base;
     uint32_t new_regs[8], new_segs[6];
     uint32_t new_eflags, new_eip, new_cr3, new_ldt, new_trap;
@@ -258,6 +259,7 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
     SegmentCache *dt;
     int index;
     target_ulong ptr;
+    X86Access old, new;
 
     type = (e2 >> DESC_TYPE_SHIFT) & 0xf;
     LOG_PCALL("switch_tss: sel=0x%04x type=%d src=%d\n", tss_selector, type,
@@ -311,35 +313,44 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
         raise_exception_err_ra(env, EXCP0A_TSS, tss_selector & 0xfffc, retaddr);
     }
 
+    /* X86Access avoids memory exceptions during the task switch */
+    access_prepare_mmu(&old, env, env->tr.base, old_tss_limit_max,
+		       MMU_DATA_STORE, cpu_mmu_index_kernel(env), retaddr);
+
+    if (source == SWITCH_TSS_CALL) {
+        /* Probe for future write of parent task */
+        probe_access(env, tss_base, 2, MMU_DATA_STORE,
+		     cpu_mmu_index_kernel(env), retaddr);
+    }
+    access_prepare_mmu(&new, env, tss_base, tss_limit,
+		       MMU_DATA_LOAD, cpu_mmu_index_kernel(env), retaddr);
+
     /* read all the registers from the new TSS */
     if (type & 8) {
         /* 32 bit */
-        new_cr3 = cpu_ldl_kernel_ra(env, tss_base + 0x1c, retaddr);
-        new_eip = cpu_ldl_kernel_ra(env, tss_base + 0x20, retaddr);
-        new_eflags = cpu_ldl_kernel_ra(env, tss_base + 0x24, retaddr);
+        new_cr3 = access_ldl(&new, tss_base + 0x1c);
+        new_eip = access_ldl(&new, tss_base + 0x20);
+        new_eflags = access_ldl(&new, tss_base + 0x24);
         for (i = 0; i < 8; i++) {
-            new_regs[i] = cpu_ldl_kernel_ra(env, tss_base + (0x28 + i * 4),
-                                            retaddr);
+            new_regs[i] = access_ldl(&new, tss_base + (0x28 + i * 4));
         }
         for (i = 0; i < 6; i++) {
-            new_segs[i] = cpu_lduw_kernel_ra(env, tss_base + (0x48 + i * 4),
-                                             retaddr);
+            new_segs[i] = access_ldw(&new, tss_base + (0x48 + i * 4));
         }
-        new_ldt = cpu_lduw_kernel_ra(env, tss_base + 0x60, retaddr);
-        new_trap = cpu_ldl_kernel_ra(env, tss_base + 0x64, retaddr);
+        new_ldt = access_ldw(&new, tss_base + 0x60);
+        new_trap = access_ldl(&new, tss_base + 0x64);
     } else {
         /* 16 bit */
         new_cr3 = 0;
-        new_eip = cpu_lduw_kernel_ra(env, tss_base + 0x0e, retaddr);
-        new_eflags = cpu_lduw_kernel_ra(env, tss_base + 0x10, retaddr);
+        new_eip = access_ldw(&new, tss_base + 0x0e);
+        new_eflags = access_ldw(&new, tss_base + 0x10);
         for (i = 0; i < 8; i++) {
-            new_regs[i] = cpu_lduw_kernel_ra(env, tss_base + (0x12 + i * 2), retaddr);
+            new_regs[i] = access_ldw(&new, tss_base + (0x12 + i * 2));
         }
         for (i = 0; i < 4; i++) {
-            new_segs[i] = cpu_lduw_kernel_ra(env, tss_base + (0x22 + i * 2),
-                                             retaddr);
+            new_segs[i] = access_ldw(&new, tss_base + (0x22 + i * 2));
         }
-        new_ldt = cpu_lduw_kernel_ra(env, tss_base + 0x2a, retaddr);
+        new_ldt = access_ldw(&new, tss_base + 0x2a);
         new_segs[R_FS] = 0;
         new_segs[R_GS] = 0;
         new_trap = 0;
@@ -349,16 +360,6 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
      chapters 12.2.5 and 13.2.4 on how to implement TSS Trap bit */
     (void)new_trap;
 
-    /* NOTE: we must avoid memory exceptions during the task switch,
-       so we make dummy accesses before */
-    /* XXX: it can still fail in some cases, so a bigger hack is
-       necessary to valid the TLB after having done the accesses */
-
-    v1 = cpu_ldub_kernel_ra(env, env->tr.base, retaddr);
-    v2 = cpu_ldub_kernel_ra(env, env->tr.base + old_tss_limit_max, retaddr);
-    cpu_stb_kernel_ra(env, env->tr.base, v1, retaddr);
-    cpu_stb_kernel_ra(env, env->tr.base + old_tss_limit_max, v2, retaddr);
-
     /* clear busy bit (it is restartable) */
     if (source == SWITCH_TSS_JMP || source == SWITCH_TSS_IRET) {
         tss_set_busy(env, env->tr.selector, 0, retaddr);
@@ -371,35 +372,35 @@ static int switch_tss_ra(CPUX86State *env, int tss_selector,
     /* save the current state in the old TSS */
     if (old_type & 8) {
         /* 32 bit */
-        cpu_stl_kernel_ra(env, env->tr.base + 0x20, next_eip, retaddr);
-        cpu_stl_kernel_ra(env, env->tr.base + 0x24, old_eflags, retaddr);
-        cpu_stl_kernel_ra(env, env->tr.base + (0x28 + 0 * 4), env->regs[R_EAX], retaddr);
-        cpu_stl_kernel_ra(env, env->tr.base + (0x28 + 1 * 4), env->regs[R_ECX], retaddr);
-        cpu_stl_kernel_ra(env, env->tr.base + (0x28 + 2 * 4), env->regs[R_EDX], retaddr);
-        cpu_stl_kernel_ra(env, env->tr.base + (0x28 + 3 * 4), env->regs[R_EBX], retaddr);
-        cpu_stl_kernel_ra(env, env->tr.base + (0x28 + 4 * 4), env->regs[R_ESP], retaddr);
-        cpu_stl_kernel_ra(env, env->tr.base + (0x28 + 5 * 4), env->regs[R_EBP], retaddr);
-        cpu_stl_kernel_ra(env, env->tr.base + (0x28 + 6 * 4), env->regs[R_ESI], retaddr);
-        cpu_stl_kernel_ra(env, env->tr.base + (0x28 + 7 * 4), env->regs[R_EDI], retaddr);
+        access_stl(&old, env->tr.base + 0x20, next_eip);
+        access_stl(&old, env->tr.base + 0x24, old_eflags);
+        access_stl(&old, env->tr.base + (0x28 + 0 * 4), env->regs[R_EAX]);
+        access_stl(&old, env->tr.base + (0x28 + 1 * 4), env->regs[R_ECX]);
+        access_stl(&old, env->tr.base + (0x28 + 2 * 4), env->regs[R_EDX]);
+        access_stl(&old, env->tr.base + (0x28 + 3 * 4), env->regs[R_EBX]);
+        access_stl(&old, env->tr.base + (0x28 + 4 * 4), env->regs[R_ESP]);
+        access_stl(&old, env->tr.base + (0x28 + 5 * 4), env->regs[R_EBP]);
+        access_stl(&old, env->tr.base + (0x28 + 6 * 4), env->regs[R_ESI]);
+        access_stl(&old, env->tr.base + (0x28 + 7 * 4), env->regs[R_EDI]);
         for (i = 0; i < 6; i++) {
-            cpu_stw_kernel_ra(env, env->tr.base + (0x48 + i * 4),
-                              env->segs[i].selector, retaddr);
+            access_stw(&old, env->tr.base + (0x48 + i * 4),
+                       env->segs[i].selector);
         }
     } else {
         /* 16 bit */
-        cpu_stw_kernel_ra(env, env->tr.base + 0x0e, next_eip, retaddr);
-        cpu_stw_kernel_ra(env, env->tr.base + 0x10, old_eflags, retaddr);
-        cpu_stw_kernel_ra(env, env->tr.base + (0x12 + 0 * 2), env->regs[R_EAX], retaddr);
-        cpu_stw_kernel_ra(env, env->tr.base + (0x12 + 1 * 2), env->regs[R_ECX], retaddr);
-        cpu_stw_kernel_ra(env, env->tr.base + (0x12 + 2 * 2), env->regs[R_EDX], retaddr);
-        cpu_stw_kernel_ra(env, env->tr.base + (0x12 + 3 * 2), env->regs[R_EBX], retaddr);
-        cpu_stw_kernel_ra(env, env->tr.base + (0x12 + 4 * 2), env->regs[R_ESP], retaddr);
-        cpu_stw_kernel_ra(env, env->tr.base + (0x12 + 5 * 2), env->regs[R_EBP], retaddr);
-        cpu_stw_kernel_ra(env, env->tr.base + (0x12 + 6 * 2), env->regs[R_ESI], retaddr);
-        cpu_stw_kernel_ra(env, env->tr.base + (0x12 + 7 * 2), env->regs[R_EDI], retaddr);
+        access_stw(&old, env->tr.base + 0x0e, next_eip);
+        access_stw(&old, env->tr.base + 0x10, old_eflags);
+        access_stw(&old, env->tr.base + (0x12 + 0 * 2), env->regs[R_EAX]);
+        access_stw(&old, env->tr.base + (0x12 + 1 * 2), env->regs[R_ECX]);
+        access_stw(&old, env->tr.base + (0x12 + 2 * 2), env->regs[R_EDX]);
+        access_stw(&old, env->tr.base + (0x12 + 3 * 2), env->regs[R_EBX]);
+        access_stw(&old, env->tr.base + (0x12 + 4 * 2), env->regs[R_ESP]);
+        access_stw(&old, env->tr.base + (0x12 + 5 * 2), env->regs[R_EBP]);
+        access_stw(&old, env->tr.base + (0x12 + 6 * 2), env->regs[R_ESI]);
+        access_stw(&old, env->tr.base + (0x12 + 7 * 2), env->regs[R_EDI]);
         for (i = 0; i < 4; i++) {
-            cpu_stw_kernel_ra(env, env->tr.base + (0x22 + i * 2),
-                              env->segs[i].selector, retaddr);
+            access_stw(&old, env->tr.base + (0x22 + i * 2),
+                       env->segs[i].selector);
         }
     }
 
-- 
2.45.2



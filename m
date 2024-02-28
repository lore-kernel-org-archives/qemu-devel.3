Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6E8C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 08:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfEyP-0001eB-2u; Wed, 28 Feb 2024 03:07:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfEyL-0001Wv-I2
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:07:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfEyF-0000Wh-CU
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709107638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M0RmU9OngKg8RcV23aPNFS80c5Wg/erIimeHGgM+2Pk=;
 b=gDioRmbFPDKa7ZKp3LpPgOvOBRGT4ESS5iDhnrc1Hic5WmOVZQVijnTyB3zNInv/jfaGwd
 jNKcbSkcQjUu9drBjukxTTmYWxQAZGRgVqM1cc+WWjiUwGWXSHPgQAFucO4v7F3/MTflvR
 KI5mTy8eB7pdBV/UlTK7h6qUJnopRjM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-Qa32GwcwONivaVPhdJgS5w-1; Wed, 28 Feb 2024 03:07:17 -0500
X-MC-Unique: Qa32GwcwONivaVPhdJgS5w-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a43f3f8d7d8so26433766b.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 00:07:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709107635; x=1709712435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M0RmU9OngKg8RcV23aPNFS80c5Wg/erIimeHGgM+2Pk=;
 b=NgpZ1fiRPMbrxRRvJWO9xs4OiYBy5A/1tcyM80KNL1mL7MLeOosFwpuKOA7uXE2gM1
 Zxm8F/AaLizCZkEKn686jPTQWurPNPf3noRNO20ctkSU+uYgxB6CfMIAeTVyFfo6tEPj
 1Wd/FHMxdV7U+ISDKkzfY130SpR5BzkSIy8PYYK7GkJg/+165WIK3tR6nQhMCQi7WEQs
 1hder6TRtQaLARnOSd0ZKwQ8xhw3v5vxytA4wYWIk+D9q0dCD71uPqvl0wGK4wkXLnKT
 5Vo9J0nsP4LXYFMUZ2cikL0E1iTSujSlbeTlnTCFdB+eXoL+csa5HKwHhtsUq6YsxEEJ
 Y5xw==
X-Gm-Message-State: AOJu0YxCVEBUXJrZaBSlDbEKZ3lKzFTeo2LqWBgW/IQGQuQJ+41Hh1Qe
 AM1UKqDwGCTpn9G4Q2bAZ++1LLbORS35ZgblKEE79h904PzovL6XwaizqkeYoBNwUemD1ugMCxl
 tmvv0T/CIxT+ch44RDqMHcx1RZceH2EyF9VZbJQkJH6TO7SDt9ledotQixSZO35I+bb7XmaUOZE
 mSa4uJ8oIWUgctXBed6S2m+TWwIPcVlTC9a6sX
X-Received: by 2002:a17:906:2b11:b0:a43:a731:956 with SMTP id
 a17-20020a1709062b1100b00a43a7310956mr3088434ejg.28.1709107635496; 
 Wed, 28 Feb 2024 00:07:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+D+tvMU3RQXHe8cpoApgkWmnNVnD9I1LxTAJLUb9GBNkqNXcb64r/v31y/05XeZlDB5ZIdg==
X-Received: by 2002:a17:906:2b11:b0:a43:a731:956 with SMTP id
 a17-20020a1709062b1100b00a43a7310956mr3088413ejg.28.1709107635150; 
 Wed, 28 Feb 2024 00:07:15 -0800 (PST)
Received: from [192.168.10.118] ([93.56.170.180])
 by smtp.gmail.com with ESMTPSA id
 tj6-20020a170907c24600b00a43a3139b2dsm1526035ejc.225.2024.02.28.00.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 00:07:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Brown <mcb30@ipxe.org>
Subject: [PULL 06/10] target/i386: Fix physical address truncation
Date: Wed, 28 Feb 2024 09:06:42 +0100
Message-ID: <20240228080646.261365-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228080646.261365-1-pbonzini@redhat.com>
References: <20240228080646.261365-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

The address translation logic in get_physical_address() will currently
truncate physical addresses to 32 bits unless long mode is enabled.
This is incorrect when using physical address extensions (PAE) outside
of long mode, with the result that a 32-bit operating system using PAE
to access memory above 4G will experience undefined behaviour.

The truncation code was originally introduced in commit 33dfdb5 ("x86:
only allow real mode to access 32bit without LMA"), where it applied
only to translations performed while paging is disabled (and so cannot
affect guests using PAE).

Commit 9828198 ("target/i386: Add MMU_PHYS_IDX and MMU_NESTED_IDX")
rearranged the code such that the truncation also applied to the use
of MMU_PHYS_IDX and MMU_NESTED_IDX.  Commit 4a1e9d4 ("target/i386: Use
atomic operations for pte updates") brought this truncation into scope
for page table entry accesses, and is the first commit for which a
Windows 10 32-bit guest will reliably fail to boot if memory above 4G
is present.

The truncation code however is not completely redundant.  Even though the
maximum address size for any executed instruction is 32 bits, helpers for
operations such as BOUND, FSAVE or XSAVE may ask get_physical_address()
to translate an address outside of the 32-bit range, if invoked with an
argument that is close to the 4G boundary.  Likewise for processor
accesses, for example TSS or IDT accesses, when EFER.LMA==0.

So, move the address truncation in get_physical_address() so that it
applies to 32-bit MMU indexes, but not to MMU_PHYS_IDX and MMU_NESTED_IDX.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2040
Fixes: 4a1e9d4d11c ("target/i386: Use atomic operations for pte updates", 2022-10-18)
Cc: qemu-stable@nongnu.org
Co-developed-by: Michael Brown <mcb30@ipxe.org>
Signed-off-by: Michael Brown <mcb30@ipxe.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h                    |  6 ++++++
 target/i386/cpu.c                    |  2 +-
 target/i386/tcg/sysemu/excp_helper.c | 12 +++++-------
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ee4ad372021..952174bb6f5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2326,6 +2326,12 @@ static inline bool is_mmu_index_user(int mmu_index)
     return (mmu_index & ~1) == MMU_USER64_IDX;
 }
 
+static inline bool is_mmu_index_32(int mmu_index)
+{
+    assert(mmu_index < MMU_PHYS_IDX);
+    return mmu_index & 1;
+}
+
 static inline int cpu_mmu_index_kernel(CPUX86State *env)
 {
     int mmu_index_32 = (env->hflags & HF_LMA_MASK) ? 1 : 0;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 647371198c7..ba6d7b80a7f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7732,7 +7732,7 @@ static bool x86_cpu_has_work(CPUState *cs)
     return x86_cpu_pending_interrupt(cs, cs->interrupt_request) != 0;
 }
 
-static int x86_cpu_mmu_index(CPUState *env, bool ifetch)
+static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
     CPUX86State *env = cpu_env(cs);
     int mmu_index_32 = (env->hflags & HF_CS64_MASK) ? 1 : 0;
diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index b2c525e1a92..8bcdd2906d5 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -558,6 +558,10 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
         break;
 
     default:
+        if (is_mmu_index_32(mmu_idx)) {
+            addr = (uint32_t)addr;
+        }
+
         if (likely(env->cr[0] & CR0_PG_MASK)) {
             in.cr3 = env->cr[3];
             in.mmu_idx = mmu_idx;
@@ -581,14 +585,8 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
         break;
     }
 
-    /* Translation disabled. */
+    /* No translation needed. */
     out->paddr = addr & x86_get_a20_mask(env);
-#ifdef TARGET_X86_64
-    if (!(env->hflags & HF_LMA_MASK)) {
-        /* Without long mode we can only address 32bits in real mode */
-        out->paddr = (uint32_t)out->paddr;
-    }
-#endif
     out->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
     out->page_size = TARGET_PAGE_SIZE;
     return true;
-- 
2.43.2



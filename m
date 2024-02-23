Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D10C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 13:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdVLw-00043m-24; Fri, 23 Feb 2024 08:12:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdVJh-0002ZK-FG
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 08:10:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdVJa-0000Sd-Sx
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 08:10:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708693810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rlda6XwcDQJrf12BMlgrMph+T4UHCrQVFO7h7UgOQjY=;
 b=RCrCgGNEcPR0Ae/2RHYwhW83g4Ubm3GPE6nECQE0N6gCjJZm/rH8AwOLMtPE0ZrhiC3mI4
 AadGFXnXS2tPN1Yh2WsV4FSSvyuFnUeJXGAuthmgBxa5q3QquJWdUZxJcieKofnROB0wpA
 ktZGvte/TGdpxmCw1W5PFZ2WPN6s5i4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-RedgWTXyN7a5EVwwaicyQw-1; Fri, 23 Feb 2024 08:10:08 -0500
X-MC-Unique: RedgWTXyN7a5EVwwaicyQw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-512bdd07758so691163e87.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 05:10:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708693805; x=1709298605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rlda6XwcDQJrf12BMlgrMph+T4UHCrQVFO7h7UgOQjY=;
 b=hvn0aI9D7plmBcNYpTDOFM9plEeoppmlhlZZEEl5heJG07V0owCks1S9flUZN6pGXe
 Ksv9/WS9xGNmnQ5BxtXFUXgCICXMAV21n4ce0q/hwG5PGPqYGihQ4CO0xoFdFlvPtsMJ
 7gyqlvQAfD7qfYPict5auSxh0mpI2RgNk1Z0ABtWkZYbv885YDvPXxTxXMxdcMmEUkF+
 TfCHuaLV6tSkqSspWyZEcUVzLOqY5ieQMPSVOPbc+N9TE+lE/wGT6C4H6HBKUAxHuTsN
 ysHpXeLqy/BRtRrvbj9NAlc4V5lYddx0p2dSQzRMDSZkVwTQi/Cwhou52lI+aZhIblTM
 652w==
X-Gm-Message-State: AOJu0YwElYVkAzS7sGSXCZUdUQnHuIC7NoI2NE9FCnM54ibTSvcJwrKz
 aL55cu28hr+V4Fthitg2FGsS+1OCS95Quq064k76Cc3/lviVTeaM5yxEdxYl/cjw6xVSEXX3evp
 GxSZZlIYikE00sCzJXzVDllKCpnWYXOcwj1unu206+ApHaQdmf+JcnyXwJZKDjMDoJ3phHG169b
 AwobHdXge2xgJOYhh7psrSa/+WyBAf+CyRCcHX
X-Received: by 2002:a19:4304:0:b0:512:bdd3:150d with SMTP id
 q4-20020a194304000000b00512bdd3150dmr1214914lfa.52.1708693805578; 
 Fri, 23 Feb 2024 05:10:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIJqa1kCDqzvcX+AZfKIMGR9z8LAdaWECreorePR5UXPeClDga9RvcymOWIITASeL46Arw0w==
X-Received: by 2002:a19:4304:0:b0:512:bdd3:150d with SMTP id
 q4-20020a194304000000b00512bdd3150dmr1214901lfa.52.1708693805139; 
 Fri, 23 Feb 2024 05:10:05 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 g21-20020a19ee15000000b00512ec8f4840sm49625lfb.48.2024.02.23.05.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 05:10:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	mcb30@ipxe.org
Subject: [PATCH v2 5/7] target/i386: Fix physical address truncation
Date: Fri, 23 Feb 2024 14:09:46 +0100
Message-ID: <20240223130948.237186-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223130948.237186-1-pbonzini@redhat.com>
References: <20240223130948.237186-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
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
Co-developed-by: Michael Brown <mcb30@ipxe.org>
Signed-off-by: Michael Brown <mcb30@ipxe.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h                    |  6 ++++++
 target/i386/cpu.c                    |  2 +-
 target/i386/tcg/sysemu/excp_helper.c | 12 +++++-------
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ee4ad372021..8a165889de6 100644
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
2.43.0



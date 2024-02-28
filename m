Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89B7C54E41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 08:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfEyL-0001XA-TS; Wed, 28 Feb 2024 03:07:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfEyK-0001Vy-5X
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:07:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfEyD-0000WP-1m
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 03:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709107636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S/Q8c4npc2nOjD6fpmMrOfyZKvHziSh6p17Z9qCoc8w=;
 b=dkA70K6qNasVukJSS8wi3tCOkyqlVs+SEiH1yRSPmCGmWcE69KzeeoKZjuqKIK/JwLhSkP
 hqZGi8v3zstLZEeTktvzQFtb6hixKSmlKg3dxRefb2z+S4WW+fGyT3RJTg5md+p9vHF1s5
 Bj5qnafC01DEgQZbHWdV28UIzXUS9nc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-rM7LAW0pOeaWZ60iRJWbWw-1; Wed, 28 Feb 2024 03:07:14 -0500
X-MC-Unique: rM7LAW0pOeaWZ60iRJWbWw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-56451e5801dso2476837a12.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 00:07:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709107633; x=1709712433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S/Q8c4npc2nOjD6fpmMrOfyZKvHziSh6p17Z9qCoc8w=;
 b=UwKUi75KLgxlww0lfbv24cjGZCk4IUnTRnlf0pgrU9f5AmmZNFQbrQY2tjUDeesbtg
 IabZprUzsAMtc4jrKVNGMiUhU1OFeO6Oz0S6BEqzpnSfUYsIlnMkSN16UZQdUMSNICUE
 22T1FYiNmiIrzxRDtqZ+tERWZtl3OnIAXYPDV047gLG7vSEE9dc0QuMSON1RyYKvBQ42
 6MNKMSOtKwi8HsFQQuey7zzX6SbRKQMs8fSFF3GHvcd1yj0fU0UJg1/vVP8XGB1JsHeH
 jmo47AST54Ex0BL4y9EOxuIhPPnx8U1Mm9gt2xJIu7xzXrTWl7BdWJaE6pDX6nH72ijP
 nEhA==
X-Gm-Message-State: AOJu0YzGODCwmNXeAwkkH0XCJGfDRrDhwOOrVHwaE2BrG7AIMIPpFkfa
 3Xv8VZstkqVV6Iv9MuJ3oGDB1ZnI5P60MkiYWa/BdS+vZ64T2vckSgKKZYG36L0uXLT2c9O2GpZ
 VsqyTXRvVRX/HAGzGxTHcK5kSF8MyHNvSRLBNyRsSeqZR/0ziFRiV29vG6EKQ0H6AehjZpgI8gT
 nCSHbMEkKVU5wAL6YdsMs7beKy7zn+J3JSgKFz
X-Received: by 2002:a05:6402:713:b0:566:348:fc4a with SMTP id
 w19-20020a056402071300b005660348fc4amr5072180edx.32.1709107632783; 
 Wed, 28 Feb 2024 00:07:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtNxyecOQn8+QzP+khnduSvVcUXo8KLTi58N0a+Vuyd9EhjCEbYWQr4OdOMY/4U8rKUyR54Q==
X-Received: by 2002:a05:6402:713:b0:566:348:fc4a with SMTP id
 w19-20020a056402071300b005660348fc4amr5072160edx.32.1709107632447; 
 Wed, 28 Feb 2024 00:07:12 -0800 (PST)
Received: from [192.168.10.118] ([93.56.170.180])
 by smtp.gmail.com with ESMTPSA id
 s21-20020aa7cb15000000b005645961ad39sm1535566edt.47.2024.02.28.00.07.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 00:07:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/10] target/i386: use separate MMU indexes for 32-bit accesses
Date: Wed, 28 Feb 2024 09:06:41 +0100
Message-ID: <20240228080646.261365-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228080646.261365-1-pbonzini@redhat.com>
References: <20240228080646.261365-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Accesses from a 32-bit environment (32-bit code segment for instruction
accesses, EFER.LMA==0 for processor accesses) have to mask away the
upper 32 bits of the address.  While a bit wasteful, the easiest way
to do so is to use separate MMU indexes.  These days, QEMU anyway is
compiled with a fixed value for NB_MMU_MODES.  Split MMU_USER_IDX,
MMU_KSMAP_IDX and MMU_KNOSMAP_IDX in two.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h                    | 34 ++++++++++++++++++++--------
 target/i386/cpu.c                    | 11 +++++----
 target/i386/tcg/sysemu/excp_helper.c |  3 ++-
 3 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8c271ca62e5..ee4ad372021 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2299,27 +2299,41 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 #define cpu_list x86_cpu_list
 
 /* MMU modes definitions */
-#define MMU_KSMAP_IDX   0
-#define MMU_USER_IDX    1
-#define MMU_KNOSMAP_IDX 2
-#define MMU_NESTED_IDX  3
-#define MMU_PHYS_IDX    4
+#define MMU_KSMAP64_IDX    0
+#define MMU_KSMAP32_IDX    1
+#define MMU_USER64_IDX     2
+#define MMU_USER32_IDX     3
+#define MMU_KNOSMAP64_IDX  4
+#define MMU_KNOSMAP32_IDX  5
+#define MMU_PHYS_IDX       6
+#define MMU_NESTED_IDX     7
+
+#ifdef CONFIG_USER_ONLY
+#ifdef TARGET_X86_64
+#define MMU_USER_IDX MMU_USER64_IDX
+#else
+#define MMU_USER_IDX MMU_USER32_IDX
+#endif
+#endif
 
 static inline bool is_mmu_index_smap(int mmu_index)
 {
-    return mmu_index == MMU_KSMAP_IDX;
+    return (mmu_index & ~1) == MMU_KSMAP64_IDX;
 }
 
 static inline bool is_mmu_index_user(int mmu_index)
 {
-    return mmu_index == MMU_USER_IDX;
+    return (mmu_index & ~1) == MMU_USER64_IDX;
 }
 
 static inline int cpu_mmu_index_kernel(CPUX86State *env)
 {
-    return !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP_IDX :
-        ((env->hflags & HF_CPL_MASK) < 3 && (env->eflags & AC_MASK))
-        ? MMU_KNOSMAP_IDX : MMU_KSMAP_IDX;
+    int mmu_index_32 = (env->hflags & HF_LMA_MASK) ? 1 : 0;
+    int mmu_index_base =
+        !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
+        ((env->hflags & HF_CPL_MASK) < 3 && (env->eflags & AC_MASK)) ? MMU_KNOSMAP64_IDX : MMU_KSMAP64_IDX;
+
+    return mmu_index_base + mmu_index_32;
 }
 
 #define CC_DST  (env->cc_dst)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7f908236767..647371198c7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7732,13 +7732,16 @@ static bool x86_cpu_has_work(CPUState *cs)
     return x86_cpu_pending_interrupt(cs, cs->interrupt_request) != 0;
 }
 
-static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
+static int x86_cpu_mmu_index(CPUState *env, bool ifetch)
 {
     CPUX86State *env = cpu_env(cs);
+    int mmu_index_32 = (env->hflags & HF_CS64_MASK) ? 1 : 0;
+    int mmu_index_base =
+        (env->hflags & HF_CPL_MASK) == 3 ? MMU_USER64_IDX :
+        !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
+        (env->eflags & AC_MASK) ? MMU_KNOSMAP64_IDX : MMU_KSMAP64_IDX;
 
-    return (env->hflags & HF_CPL_MASK) == 3 ? MMU_USER_IDX :
-        (!(env->hflags & HF_SMAP_MASK) || (env->eflags & AC_MASK))
-        ? MMU_KNOSMAP_IDX : MMU_KSMAP_IDX;
+    return mmu_index_base + mmu_index_32;
 }
 
 static void x86_disas_set_info(CPUState *cs, disassemble_info *info)
diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index a0d5ce39300..b2c525e1a92 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -545,7 +545,8 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
         if (likely(use_stage2)) {
             in.cr3 = env->nested_cr3;
             in.pg_mode = env->nested_pg_mode;
-            in.mmu_idx = MMU_USER_IDX;
+            in.mmu_idx =
+                env->nested_pg_mode & PG_MODE_LMA ? MMU_USER64_IDX : MMU_USER32_IDX;
             in.ptw_idx = MMU_PHYS_IDX;
 
             if (!mmu_translate(env, &in, out, err)) {
-- 
2.43.2



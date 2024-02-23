Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5325C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 13:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdVNd-0005V5-Su; Fri, 23 Feb 2024 08:14:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdVJZ-0002YM-2E
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 08:10:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdVJX-0000S0-5u
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 08:10:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708693806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IAP6k7a7KD7cA1kLn+K+ZlS1jEOLhqfbzH2yPUv60PA=;
 b=isFUVvGqwnO235MDy4bke0noH3kwk+zkSDtS1Z+jnKzTcgHpEjQ22rvBiwTxfPaVDvy392
 HpevyfDm6/h8uzAGIBJNs71mIn85Q6BfrGBO9ak/48URXv3XjlhSI4tDtSsmi3Fe5rgLjU
 dMKHJAZXYhX3pki7OSoOe21xlE3R4k8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-Hhiso-0WPu6VCWxM0Ux6sQ-1; Fri, 23 Feb 2024 08:10:05 -0500
X-MC-Unique: Hhiso-0WPu6VCWxM0Ux6sQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-512aa50323cso946749e87.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 05:10:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708693803; x=1709298603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IAP6k7a7KD7cA1kLn+K+ZlS1jEOLhqfbzH2yPUv60PA=;
 b=Bkg1jHvhL/KxPd2asiM4BDLT/LsdaNRQ2/Z2WKgZ3Rm1GqMD8sfoloFYPlPjwoE6qh
 +8IzNtKye98DxDA3uAl3iKfnCViirW+6GvEj8Jg/v5ZS1w1LgcDtqWWBQ7Xw+tmmW7fd
 FCwTVV91ndXF2zUqfSyrFRnS+7dqDZtJFEHfx93aChStAI6sWkktH76yEyI8rRGfkOFo
 l0G3jpwnvGbBNoomvYhH5GnH3b4sN1sHPVs0qKdy0iTsvVdaZkK91rn/5ofLONDI9QP4
 e3uh8q3fs2w1a5+EXM67DhuD0/uog7IGAtiB+tZK4PvzTJXQcC55V3v8Y5EKPHEt89Nb
 SHUQ==
X-Gm-Message-State: AOJu0YxyNuVYdL/WbjBy1V1OCtG2B7TK5id9j4aboOakG1ETi8AeFJfT
 t406L2Jn/xR8A4h/pdGgGZtBmfng+7ZlcutWNumiN59TAhOAO2LjA0Ku7Rw4ozOjboEHY1BubFX
 oLKGJCsP0h2Hqq1XdZloxd081bndBhoAWC3t6kgnnfnBWOFt4VTDS6+S3wopp6tzgCSWmVDzUHu
 Uk+4/6QGs0HHtfpZWMhj3EirpWXLIzwR1u7XV4
X-Received: by 2002:ac2:484f:0:b0:512:d91f:95ce with SMTP id
 15-20020ac2484f000000b00512d91f95cemr1255461lfy.65.1708693802974; 
 Fri, 23 Feb 2024 05:10:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRgR/uJZHjMvnfc8TeK/IA48ymX6CSy2Ilr69bnEh/lJB5w8jWwgMOWQr2ePbdyg3hETSMyg==
X-Received: by 2002:ac2:484f:0:b0:512:d91f:95ce with SMTP id
 15-20020ac2484f000000b00512d91f95cemr1255447lfy.65.1708693802650; 
 Fri, 23 Feb 2024 05:10:02 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 bi3-20020a0565120e8300b00512e5a40534sm260869lfb.214.2024.02.23.05.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 05:10:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	mcb30@ipxe.org
Subject: [PATCH v2 4/7] target/i386: use separate MMU indexes for 32-bit
 accesses
Date: Fri, 23 Feb 2024 14:09:45 +0100
Message-ID: <20240223130948.237186-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223130948.237186-1-pbonzini@redhat.com>
References: <20240223130948.237186-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
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
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93A7CF34D5
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 23:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swVTO-0007cp-SW; Thu, 03 Oct 2024 19:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swVTL-0007bl-Uo
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 19:43:04 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swVTI-0003gE-LY
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 19:43:03 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cbe624c59so13243745e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 16:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727998979; x=1728603779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6qnwMrWTHFiNsTxZGqtBDRAo1PQucjQVvtPnnXw/k2I=;
 b=cN/u9plqYzfLKqVfsKlhynRjDwdnjRY5z1Hla5vYcdEMhCF7h3amPgomAfROloxmms
 vi/LdmyvbQ3NZOC0IA0jPJag2MnQOz3hpChgd9KgoX9jXB35pYqQBS5VjS1xEpoMLe7L
 8yC8HVG7S5b0C2pWUMoTOLoxtkzbw9Pl9FHfDZav+nwKJbZZlV3pmwSIivv/NRV29HQp
 3vwOLB3Uejzv0NT7IpvejiVN/v40gFIcBpkhI7BtHeHaPCH4m5PgG4Zd34tg0JucIYz7
 myhFlJjlwiWEquHe8OuEZsV52DuzeQKFFHfNek5jA5zsh7zLHWlewcLtlZ7OluIgC8aL
 n56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727998979; x=1728603779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6qnwMrWTHFiNsTxZGqtBDRAo1PQucjQVvtPnnXw/k2I=;
 b=EIIRIe1U8BZyDVrMMytx3majG4GcfWFnKqyPy1/lP5K/ntNQRjuh/k+dnvGH18UhZr
 YhLDN/kY76tEBGp7v35C7Qo8QZ9Tm7Butad+EHjUMYR4B7kWokQ9tnMexOfvDtiBrRvx
 qx0NuHG1iUyKSwWxiRBXWkj0Sk8WC+2uVTWDlSPiX9YA8hi+6CUu6x2FrylLWsZWNaFq
 rCvTg5arWnn1WCku5sKnsbFtOCRutN0Wf82qkPIF9saRVW1XEmVenpZV9VHW1sr4zyFC
 qZGBsWzdWMvEauQ9YNPj67gEJ82agx8IaaWDCd3O6F2Kr2DbcN2nR7ZHq/ZQvT0G6b9m
 VKyg==
X-Gm-Message-State: AOJu0Yyr9HnjlknRiDUlwv+fpPXlZGd5mQdridDx8ie3INIcgE5vy5uz
 Vx4ndKub2NBHkuJSACclPb+SQmEoa5jd/4d8poVZsTZb3rHvqdYKlbglQ6gj5uZkaU/cbOS25M0
 X5eM=
X-Google-Smtp-Source: AGHT+IFPMKUpDl4SlWzKYz3NVXTgTjyNjXg3hotBpjxVN+Tf+5JVaWghpCTsqfaELviVa4viaZZFrg==
X-Received: by 2002:a05:600c:1ca4:b0:42c:ba0d:c766 with SMTP id
 5b1f17b1804b1-42f85aa32aamr3255165e9.6.1727998978630; 
 Thu, 03 Oct 2024 16:42:58 -0700 (PDT)
Received: from localhost.localdomain (45.red-88-29-191.dynamicip.rima-tde.net.
 [88.29.191.45]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86b1d930sm1307955e9.22.2024.10.03.16.42.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Oct 2024 16:42:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Song Gao <gaosong@loongson.cn>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 05/16] target/i386: Use explicit little-endian LD/ST API
Date: Fri,  4 Oct 2024 01:42:00 +0200
Message-ID: <20241003234211.53644-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003234211.53644-1-philmd@linaro.org>
References: <20241003234211.53644-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The x86 architecture uses little endianness. Directly use
the little-endian LD/ST API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/gdbstub.c                | 26 +++++++++++-----------
 target/i386/tcg/sysemu/excp_helper.c |  4 ++--
 target/i386/xsave_helper.c           | 32 ++++++++++++++--------------
 3 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index 4acf485879e..40c8cb6dc46 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -89,10 +89,10 @@ static int gdb_read_reg_cs64(uint32_t hflags, GByteArray *buf, target_ulong val)
 static int gdb_write_reg_cs64(uint32_t hflags, uint8_t *buf, target_ulong *val)
 {
     if (hflags & HF_CS64_MASK) {
-        *val = ldq_p(buf);
+        *val = ldq_le_p(buf);
         return 8;
     }
-    *val = ldl_p(buf);
+    *val = ldl_le_p(buf);
     return 4;
 }
 
@@ -221,7 +221,7 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 static int x86_cpu_gdb_load_seg(X86CPU *cpu, X86Seg sreg, uint8_t *mem_buf)
 {
     CPUX86State *env = &cpu->env;
-    uint16_t selector = ldl_p(mem_buf);
+    uint16_t selector = ldl_le_p(mem_buf);
 
     if (selector != env->segs[sreg].selector) {
 #if defined(CONFIG_USER_ONLY)
@@ -270,7 +270,7 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         } else if (n < CPU_NB_REGS32) {
             n = gpr_map32[n];
             env->regs[n] &= ~0xffffffffUL;
-            env->regs[n] |= (uint32_t)ldl_p(mem_buf);
+            env->regs[n] |= (uint32_t)ldl_le_p(mem_buf);
             return 4;
         }
     } else if (n >= IDX_FP_REGS && n < IDX_FP_REGS + 8) {
@@ -281,8 +281,8 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     } else if (n >= IDX_XMM_REGS && n < IDX_XMM_REGS + CPU_NB_REGS) {
         n -= IDX_XMM_REGS;
         if (n < CPU_NB_REGS32 || TARGET_LONG_BITS == 64) {
-            env->xmm_regs[n].ZMM_Q(0) = ldq_p(mem_buf);
-            env->xmm_regs[n].ZMM_Q(1) = ldq_p(mem_buf + 8);
+            env->xmm_regs[n].ZMM_Q(0) = ldq_le_p(mem_buf);
+            env->xmm_regs[n].ZMM_Q(1) = ldq_le_p(mem_buf + 8);
             return 16;
         }
     } else {
@@ -290,18 +290,18 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         case IDX_IP_REG:
             if (TARGET_LONG_BITS == 64) {
                 if (env->hflags & HF_CS64_MASK) {
-                    env->eip = ldq_p(mem_buf);
+                    env->eip = ldq_le_p(mem_buf);
                 } else {
-                    env->eip = ldq_p(mem_buf) & 0xffffffffUL;
+                    env->eip = ldq_le_p(mem_buf) & 0xffffffffUL;
                 }
                 return 8;
             } else {
                 env->eip &= ~0xffffffffUL;
-                env->eip |= (uint32_t)ldl_p(mem_buf);
+                env->eip |= (uint32_t)ldl_le_p(mem_buf);
                 return 4;
             }
         case IDX_FLAGS_REG:
-            env->eflags = ldl_p(mem_buf);
+            env->eflags = ldl_le_p(mem_buf);
             return 4;
 
         case IDX_SEG_REGS:
@@ -327,10 +327,10 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
             return 4;
 
         case IDX_FP_REGS + 8:
-            cpu_set_fpuc(env, ldl_p(mem_buf));
+            cpu_set_fpuc(env, ldl_le_p(mem_buf));
             return 4;
         case IDX_FP_REGS + 9:
-            tmp = ldl_p(mem_buf);
+            tmp = ldl_le_p(mem_buf);
             env->fpstt = (tmp >> 11) & 7;
             env->fpus = tmp & ~0x3800;
             return 4;
@@ -348,7 +348,7 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
             return 4;
 
         case IDX_MXCSR_REG:
-            cpu_set_mxcsr(env, ldl_p(mem_buf));
+            cpu_set_mxcsr(env, ldl_le_p(mem_buf));
             return 4;
 
         case IDX_CTL_CR0_REG:
diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 8fb05b1f531..de6765099f3 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -86,7 +86,7 @@ static bool ptw_translate(PTETranslate *inout, hwaddr addr, uint64_t ra)
 static inline uint32_t ptw_ldl(const PTETranslate *in, uint64_t ra)
 {
     if (likely(in->haddr)) {
-        return ldl_p(in->haddr);
+        return ldl_le_p(in->haddr);
     }
     return cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, ra);
 }
@@ -94,7 +94,7 @@ static inline uint32_t ptw_ldl(const PTETranslate *in, uint64_t ra)
 static inline uint64_t ptw_ldq(const PTETranslate *in, uint64_t ra)
 {
     if (likely(in->haddr)) {
-        return ldq_p(in->haddr);
+        return ldq_le_p(in->haddr);
     }
     return cpu_ldq_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, ra);
 }
diff --git a/target/i386/xsave_helper.c b/target/i386/xsave_helper.c
index 996e9f3bfef..fc10bfa6718 100644
--- a/target/i386/xsave_helper.c
+++ b/target/i386/xsave_helper.c
@@ -43,8 +43,8 @@ void x86_cpu_xsave_all_areas(X86CPU *cpu, void *buf, uint32_t buflen)
     for (i = 0; i < CPU_NB_REGS; i++) {
         uint8_t *xmm = legacy->xmm_regs[i];
 
-        stq_p(xmm,     env->xmm_regs[i].ZMM_Q(0));
-        stq_p(xmm + 8, env->xmm_regs[i].ZMM_Q(1));
+        stq_le_p(xmm,     env->xmm_regs[i].ZMM_Q(0));
+        stq_le_p(xmm + 8, env->xmm_regs[i].ZMM_Q(1));
     }
 
     header->xstate_bv = env->xstate_bv;
@@ -58,8 +58,8 @@ void x86_cpu_xsave_all_areas(X86CPU *cpu, void *buf, uint32_t buflen)
         for (i = 0; i < CPU_NB_REGS; i++) {
             uint8_t *ymmh = avx->ymmh[i];
 
-            stq_p(ymmh,     env->xmm_regs[i].ZMM_Q(2));
-            stq_p(ymmh + 8, env->xmm_regs[i].ZMM_Q(3));
+            stq_le_p(ymmh,     env->xmm_regs[i].ZMM_Q(2));
+            stq_le_p(ymmh + 8, env->xmm_regs[i].ZMM_Q(3));
         }
     }
 
@@ -101,10 +101,10 @@ void x86_cpu_xsave_all_areas(X86CPU *cpu, void *buf, uint32_t buflen)
         for (i = 0; i < CPU_NB_REGS; i++) {
             uint8_t *zmmh = zmm_hi256->zmm_hi256[i];
 
-            stq_p(zmmh,      env->xmm_regs[i].ZMM_Q(4));
-            stq_p(zmmh + 8,  env->xmm_regs[i].ZMM_Q(5));
-            stq_p(zmmh + 16, env->xmm_regs[i].ZMM_Q(6));
-            stq_p(zmmh + 24, env->xmm_regs[i].ZMM_Q(7));
+            stq_le_p(zmmh,      env->xmm_regs[i].ZMM_Q(4));
+            stq_le_p(zmmh + 8,  env->xmm_regs[i].ZMM_Q(5));
+            stq_le_p(zmmh + 16, env->xmm_regs[i].ZMM_Q(6));
+            stq_le_p(zmmh + 24, env->xmm_regs[i].ZMM_Q(7));
         }
 
 #ifdef TARGET_X86_64
@@ -177,8 +177,8 @@ void x86_cpu_xrstor_all_areas(X86CPU *cpu, const void *buf, uint32_t buflen)
     for (i = 0; i < CPU_NB_REGS; i++) {
         const uint8_t *xmm = legacy->xmm_regs[i];
 
-        env->xmm_regs[i].ZMM_Q(0) = ldq_p(xmm);
-        env->xmm_regs[i].ZMM_Q(1) = ldq_p(xmm + 8);
+        env->xmm_regs[i].ZMM_Q(0) = ldq_le_p(xmm);
+        env->xmm_regs[i].ZMM_Q(1) = ldq_le_p(xmm + 8);
     }
 
     env->xstate_bv = header->xstate_bv;
@@ -191,8 +191,8 @@ void x86_cpu_xrstor_all_areas(X86CPU *cpu, const void *buf, uint32_t buflen)
         for (i = 0; i < CPU_NB_REGS; i++) {
             const uint8_t *ymmh = avx->ymmh[i];
 
-            env->xmm_regs[i].ZMM_Q(2) = ldq_p(ymmh);
-            env->xmm_regs[i].ZMM_Q(3) = ldq_p(ymmh + 8);
+            env->xmm_regs[i].ZMM_Q(2) = ldq_le_p(ymmh);
+            env->xmm_regs[i].ZMM_Q(3) = ldq_le_p(ymmh + 8);
         }
     }
 
@@ -241,10 +241,10 @@ void x86_cpu_xrstor_all_areas(X86CPU *cpu, const void *buf, uint32_t buflen)
         for (i = 0; i < CPU_NB_REGS; i++) {
             const uint8_t *zmmh = zmm_hi256->zmm_hi256[i];
 
-            env->xmm_regs[i].ZMM_Q(4) = ldq_p(zmmh);
-            env->xmm_regs[i].ZMM_Q(5) = ldq_p(zmmh + 8);
-            env->xmm_regs[i].ZMM_Q(6) = ldq_p(zmmh + 16);
-            env->xmm_regs[i].ZMM_Q(7) = ldq_p(zmmh + 24);
+            env->xmm_regs[i].ZMM_Q(4) = ldq_le_p(zmmh);
+            env->xmm_regs[i].ZMM_Q(5) = ldq_le_p(zmmh + 8);
+            env->xmm_regs[i].ZMM_Q(6) = ldq_le_p(zmmh + 16);
+            env->xmm_regs[i].ZMM_Q(7) = ldq_le_p(zmmh + 24);
         }
 
 #ifdef TARGET_X86_64
-- 
2.45.2



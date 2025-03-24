Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C92C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 10:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twewq-00032u-Ep; Mon, 24 Mar 2025 06:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1twewU-0002lo-3d
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:22:06 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1twewL-00072g-Sq
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:22:01 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-abbb12bea54so509651966b.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 03:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742811710; x=1743416510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sKRs4BLeOk1m6YkwKmGBAfW8cTZegbhEme+UuM3G2r8=;
 b=QlOQ6ezo1HY7o6LBqUFj1DNwDE5Mgzx6KjAMYGbpUyHeC4IPSCoZro6UmLB2sge2g8
 QnGmHcq2nBH1nbgnnOY4+DyG4AbVUKaA4EVVt+R9UA9CYnNzDWcUDntUPSnbiPq8I/VL
 ybyrcY9FGnI43SVB/ZBrsZyU/Ln6wO+1VG+TbMoa82H2swZtUEi1qM+NVrIy4s8qscW3
 9cDOb8fD1w3Qqf0hhi4uh68w2+mzb/oYa0m+zbbP0ho3NIYqtUb8Fkx84eRLkTEZAblo
 jcPavX9Zgzqi9KsHLHatwLx2HGfNft1Ml14lsexxDjH98f5FMfMq9z3aDgM86vRUHRov
 8Xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742811710; x=1743416510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sKRs4BLeOk1m6YkwKmGBAfW8cTZegbhEme+UuM3G2r8=;
 b=bJq94al3cacib28KeFjQ19pxRtZoeNdTTqiV1nwGh18j4hEncFfj2GQOd2BxcuXxSk
 eEvfadgjUg+UMB7CrHh6tqs+HhPs/qnm4kwRrmnMb6Hwh7W+mT2DewZjCbSyJjEBlbSl
 NFzuqB5SGpA4FnV12Sk+I25sJ7Tah9ckjKCnfigzjt7nPVhLy2pc0aUPyfs6kICRraxp
 hmGElbWxoHmHgAZW/9p9GG89nAJpbVSxdfC1QPAHEsscNnqlFl/BPr0k6R1SNDAheZst
 2hHEWgO+v1kqJwmAvCm94KFBzO8157LqpcD/D27Snf2LkUGq3v0Viut3asiup0MHsFwt
 b5Mg==
X-Gm-Message-State: AOJu0YyDpf8meuH/dCGnJ7F9hp3g52Gpaz01BHbo9qAA7ZqxjTU8ABpu
 olwNDIGgtZodVkReXtkWzh3ALxpdYVsL3xS5NMwTv6Kl64RYmd1SQTGBp3uUQt0=
X-Gm-Gg: ASbGnct/MHzbSZFFx1ASY0i8RecFaQPTiaq9ugV3jXGValvnxnJkB515FdBy9ie/5lx
 zsMpPpEsWi2fpjGzaS33cuWDxRo4+RNpHkF23qiz8TtPxSoCfB+RRaWv6X4keAzA9OTadE0s6fW
 o724mD2EaI28kXZhz6u0MNdh6nvTAU8S1rcDbl8Tz7nUICyCSflJ2eW8xPRPIT4uhMa+G4qUiA+
 P4UOtFhroYxEMhNUnE6LeVPGRx/Kr58eEyWbujhbt9CC1aVnCsM9C1WzMoEwNfj22lGnWFrbdiV
 6g1gtQ5NLjAXf5jd35JbCgl8eVuPNnUZ8jS3RDjW4RN4RPE=
X-Google-Smtp-Source: AGHT+IEd1ubeA6VqHngadLwmANX9ge6i6Mz02m9+49Zlw0aFd38rf0JaBY4Z476t3W2qbHGeY8IWDg==
X-Received: by 2002:a17:907:1b1e:b0:ac3:c7bd:e436 with SMTP id
 a640c23a62f3a-ac3f252f763mr1248300266b.51.1742811710381; 
 Mon, 24 Mar 2025 03:21:50 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3ef8d3f17sm652319266b.63.2025.03.24.03.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 03:21:46 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 70E845FD7E;
 Mon, 24 Mar 2025 10:21:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 09/11] target/ppc: convert gdbstub to new helpers
Date: Mon, 24 Mar 2025 10:21:40 +0000
Message-Id: <20250324102142.67022-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250324102142.67022-1-alex.bennee@linaro.org>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

By passing the explicit state of LE/BE via the memop we can avoid the
messing about we do with ppc_maybe_bswap_register() at least for
supplying register values to gdbstub.

The fact we still need the helper for setting the values probably
indicates we could do with a reverse helper, possibly to setting env
vars directly? This is complicated by aliasing though.

We also have to deal with heavy usage of target_ulong so we copy some
macro stuff from the old helpers.h and add a gdb_get_regl_value()
helper.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - use new helpers
  - fix bunch of target_ulong cases
---
 target/ppc/gdbstub.c | 195 ++++++++++++++++++++++++-------------------
 1 file changed, 111 insertions(+), 84 deletions(-)

diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index c09e93abaf..b96c3ac5b8 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/gdbstub.h"
-#include "gdbstub/helpers.h"
+#include "gdbstub/registers.h"
 #include "internal.h"
 
 static int ppc_gdb_register_len_apple(int n)
@@ -74,12 +74,12 @@ static int ppc_gdb_register_len(int n)
 }
 
 /*
- * We need to present the registers to gdb in the "current" memory
- * ordering.  For user-only mode we get this for free;
- * TARGET_BIG_ENDIAN is set to the proper ordering for the
- * binary, and cannot be changed.  For system mode,
- * TARGET_BIG_ENDIAN is always set, and we must check the current
- * mode of the chip to see if we're running in little-endian.
+ * We need to map the target endian registers from gdb in the
+ * "current" memory ordering. For user-only mode we get this for free;
+ * TARGET_BIG_ENDIAN is set to the proper ordering for the binary, and
+ * cannot be changed. For system mode, TARGET_BIG_ENDIAN is always
+ * set, and we must check the current mode of the chip to see if we're
+ * running in little-endian.
  */
 static void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len)
 {
@@ -98,6 +98,41 @@ static void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len
 #endif
 }
 
+/*
+ * We need to present the registers to gdb in the "current" memory
+ * ordering. For user-only mode this is hardwired by TARGET_BIG_ENDIAN
+ * and cannot be changed. For system mode we must check the current
+ * mode of the chip to see if we're running in little-endian.
+ */
+static MemOp ppc_gdb_memop(CPUPPCState *env, int len)
+{
+#ifndef CONFIG_USER_ONLY
+    MemOp end = FIELD_EX64(env->msr, MSR, LE) ? MO_LE : MO_BE;
+#else
+    #ifdef TARGET_BIG_ENDIAN
+    MemOp end = MO_BE;
+    #else
+    MemOp end = MO_LE;
+    #endif
+#endif
+
+    return size_memop(len) | end;
+}
+
+/*
+ * Helpers copied from helpers.h just for handling target_ulong values
+ * from gdbstub's GByteArray based on what the build config is. This
+ * will need fixing for single-binary.
+ */
+
+#if TARGET_LONG_BITS == 64
+#define ldtul_p(addr) ldq_p(addr)
+#define gdb_get_regl_value(m, b, v) gdb_get_reg64_value(m, b, v)
+#else
+#define ldtul_p(addr) ldl_p(addr)
+#define gdb_get_regl_value(m, b, v) gdb_get_reg32_value(m, b, v)
+#endif
+
 /*
  * Old gdb always expects FP registers.  Newer (xml-aware) gdb only
  * expects whatever the target description contains.  Due to a
@@ -109,51 +144,50 @@ static void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len
 int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
 {
     CPUPPCState *env = cpu_env(cs);
-    uint8_t *mem_buf;
     int r = ppc_gdb_register_len(n);
+    MemOp mo;
 
     if (!r) {
         return r;
     }
 
+    mo = ppc_gdb_memop(env, r);
+
     if (n < 32) {
         /* gprs */
-        gdb_get_regl(buf, env->gpr[n]);
+        return gdb_get_regl_value(mo, buf, &env->gpr[n]);
     } else {
         switch (n) {
         case 64:
-            gdb_get_regl(buf, env->nip);
-            break;
+            return gdb_get_regl_value(mo, buf, &env->nip);
         case 65:
-            gdb_get_regl(buf, env->msr);
-            break;
+            return gdb_get_regl_value(mo, buf, &env->msr);
         case 66:
             {
                 uint32_t cr = ppc_get_cr(env);
-                gdb_get_reg32(buf, cr);
-                break;
+                return gdb_get_register_value(ppc_gdb_memop(env, 4), buf, &cr);
             }
         case 67:
-            gdb_get_regl(buf, env->lr);
+            return gdb_get_regl_value(mo, buf, &env->lr);
             break;
         case 68:
-            gdb_get_regl(buf, env->ctr);
+            return gdb_get_regl_value(mo, buf, &env->ctr);
             break;
         case 69:
-            gdb_get_reg32(buf, cpu_read_xer(env));
-            break;
+            uint32_t val = cpu_read_xer(env);
+            return gdb_get_register_value(ppc_gdb_memop(env, 4), buf, &val);
         }
     }
-    mem_buf = buf->data + buf->len - r;
-    ppc_maybe_bswap_register(env, mem_buf, r);
-    return r;
+
+    return 0;
 }
 
 int ppc_cpu_gdb_read_register_apple(CPUState *cs, GByteArray *buf, int n)
 {
     CPUPPCState *env = cpu_env(cs);
-    uint8_t *mem_buf;
     int r = ppc_gdb_register_len_apple(n);
+    MemOp mo = ppc_gdb_memop(env, r);
+    int actual = 0;
 
     if (!r) {
         return r;
@@ -161,44 +195,48 @@ int ppc_cpu_gdb_read_register_apple(CPUState *cs, GByteArray *buf, int n)
 
     if (n < 32) {
         /* gprs */
-        gdb_get_reg64(buf, env->gpr[n]);
+        actual = gdb_get_regl_value(mo, buf, &env->gpr[n]);
     } else if (n < 64) {
         /* fprs */
-        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n - 32));
+        actual = gdb_get_reg64_value(mo, buf, cpu_fpr_ptr(env, n - 32));
     } else if (n < 96) {
-        /* Altivec */
-        gdb_get_reg64(buf, n - 64);
-        gdb_get_reg64(buf, 0);
+        /* Altivec - where are they? ppc_vsr_t vsr[64]? */
+        uint64_t empty = 0;
+        actual = gdb_get_reg64_value(mo, buf, &empty);
+        actual = gdb_get_reg64_value(mo, buf, &empty);
     } else {
         switch (n) {
         case 64 + 32:
-            gdb_get_reg64(buf, env->nip);
+            actual = gdb_get_regl_value(mo, buf, &env->nip);
             break;
         case 65 + 32:
-            gdb_get_reg64(buf, env->msr);
+            actual = gdb_get_regl_value(mo, buf, &env->msr);
             break;
         case 66 + 32:
-            {
-                uint32_t cr = ppc_get_cr(env);
-                gdb_get_reg32(buf, cr);
-                break;
-            }
+        {
+            uint32_t cr = ppc_get_cr(env);
+            actual = gdb_get_reg32_value(mo, buf, &cr);
+            break;
+        }
         case 67 + 32:
-            gdb_get_reg64(buf, env->lr);
+            actual = gdb_get_regl_value(mo, buf, &env->lr);
             break;
         case 68 + 32:
-            gdb_get_reg64(buf, env->ctr);
+            actual = gdb_get_regl_value(mo, buf, &env->ctr);
             break;
         case 69 + 32:
-            gdb_get_reg32(buf, cpu_read_xer(env));
+        {
+            uint32_t xer = cpu_read_xer(env);
+            actual = gdb_get_reg32_value(mo, buf, &xer);
             break;
+        }
         case 70 + 32:
-            gdb_get_reg64(buf, env->fpscr);
+            actual = gdb_get_regl_value(mo, buf, &env->fpscr);
             break;
         }
     }
-    mem_buf = buf->data + buf->len - r;
-    ppc_maybe_bswap_register(env, mem_buf, r);
+
+    g_assert(r == actual);
     return r;
 }
 
@@ -210,6 +248,9 @@ int ppc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     if (!r) {
         return r;
     }
+
+    g_assert(r == n);
+    
     ppc_maybe_bswap_register(env, mem_buf, r);
     if (n < 32) {
         /* gprs */
@@ -367,18 +408,16 @@ static int gdb_get_spr_reg(CPUState *cs, GByteArray *buf, int n)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
+    MemOp mo = ppc_gdb_memop(env, TARGET_LONG_SIZE);
+    target_ulong val;
     int reg;
-    int len;
 
     reg = gdb_find_spr_idx(env, n);
     if (reg < 0) {
         return 0;
     }
 
-    len = TARGET_LONG_SIZE;
-
     /* Handle those SPRs that are not part of the env->spr[] array */
-    target_ulong val;
     switch (reg) {
 #if defined(TARGET_PPC64)
     case SPR_CFAR:
@@ -400,10 +439,7 @@ static int gdb_get_spr_reg(CPUState *cs, GByteArray *buf, int n)
     default:
         val = env->spr[reg];
     }
-    gdb_get_regl(buf, val);
-
-    ppc_maybe_bswap_register(env, gdb_get_reg_ptr(buf, len), len);
-    return len;
+    return gdb_get_regl_value(mo, buf, &val);
 }
 
 static int gdb_set_spr_reg(CPUState *cs, uint8_t *mem_buf, int n)
@@ -441,18 +477,14 @@ static int gdb_get_float_reg(CPUState *cs, GByteArray *buf, int n)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
-    uint8_t *mem_buf;
+    MemOp mo;
     if (n < 32) {
-        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n));
-        mem_buf = gdb_get_reg_ptr(buf, 8);
-        ppc_maybe_bswap_register(env, mem_buf, 8);
-        return 8;
+        mo = ppc_gdb_memop(env, 8);
+        return gdb_get_reg64_value(mo, buf, cpu_fpr_ptr(env, n));
     }
     if (n == 32) {
-        gdb_get_reg32(buf, env->fpscr);
-        mem_buf = gdb_get_reg_ptr(buf, 4);
-        ppc_maybe_bswap_register(env, mem_buf, 4);
-        return 4;
+        mo = ppc_gdb_memop(env, TARGET_LONG_SIZE);
+        return gdb_get_regl_value(mo, buf, &env->fpscr);
     }
     return 0;
 }
@@ -479,26 +511,21 @@ static int gdb_get_avr_reg(CPUState *cs, GByteArray *buf, int n)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
-    uint8_t *mem_buf;
+    MemOp mo;
 
     if (n < 32) {
         ppc_avr_t *avr = cpu_avr_ptr(env, n);
-        gdb_get_reg128(buf, avr->VsrD(0), avr->VsrD(1));
-        mem_buf = gdb_get_reg_ptr(buf, 16);
-        ppc_maybe_bswap_register(env, mem_buf, 16);
-        return 16;
+        mo = ppc_gdb_memop(env, 16);
+        return gdb_get_register_value(mo, buf, avr);
     }
     if (n == 32) {
-        gdb_get_reg32(buf, ppc_get_vscr(env));
-        mem_buf = gdb_get_reg_ptr(buf, 4);
-        ppc_maybe_bswap_register(env, mem_buf, 4);
-        return 4;
+        uint32_t vscr = ppc_get_vscr(env);
+        mo = ppc_gdb_memop(env, 4);
+        return gdb_get_reg32_value(mo, buf, &vscr);
     }
     if (n == 33) {
-        gdb_get_reg32(buf, (uint32_t)env->spr[SPR_VRSAVE]);
-        mem_buf = gdb_get_reg_ptr(buf, 4);
-        ppc_maybe_bswap_register(env, mem_buf, 4);
-        return 4;
+        mo = ppc_gdb_memop(env, TARGET_LONG_SIZE);
+        return gdb_get_regl_value(mo, buf, &env->spr[SPR_VRSAVE]);
     }
     return 0;
 }
@@ -532,25 +559,25 @@ static int gdb_get_spe_reg(CPUState *cs, GByteArray *buf, int n)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
+    MemOp mo;
 
     if (n < 32) {
 #if defined(TARGET_PPC64)
-        gdb_get_reg32(buf, env->gpr[n] >> 32);
-        ppc_maybe_bswap_register(env, gdb_get_reg_ptr(buf, 4), 4);
+        uint32_t low = env->gpr[n] >> 32;
+        mo = ppc_gdb_memop(env, 4);
+        return gdb_get_reg32_value(mo, buf, &low);
 #else
-        gdb_get_reg32(buf, env->gprh[n]);
+        mo = ppc_gdb_memop(env, 4);
+        return gdb_get_reg32_value(mo, buf, &env->gprh[n]);
 #endif
-        return 4;
     }
     if (n == 32) {
-        gdb_get_reg64(buf, env->spe_acc);
-        ppc_maybe_bswap_register(env, gdb_get_reg_ptr(buf, 8), 8);
-        return 8;
+        mo = ppc_gdb_memop(env, 8);
+        return gdb_get_reg64_value(mo, buf, &env->spe_acc);
     }
     if (n == 33) {
-        gdb_get_reg32(buf, env->spe_fscr);
-        ppc_maybe_bswap_register(env, gdb_get_reg_ptr(buf, 4), 4);
-        return 4;
+        mo = ppc_gdb_memop(env, 4);
+        return gdb_get_reg32_value(mo, buf, &env->spe_fscr);
     }
     return 0;
 }
@@ -593,9 +620,9 @@ static int gdb_get_vsx_reg(CPUState *cs, GByteArray *buf, int n)
     CPUPPCState *env = &cpu->env;
 
     if (n < 32) {
-        gdb_get_reg64(buf, *cpu_vsrl_ptr(env, n));
-        ppc_maybe_bswap_register(env, gdb_get_reg_ptr(buf, 8), 8);
-        return 8;
+        return gdb_get_reg64_value(ppc_gdb_memop(env, 8),
+                                   buf,
+                                   cpu_vsrl_ptr(env, n));
     }
     return 0;
 }
-- 
2.39.5



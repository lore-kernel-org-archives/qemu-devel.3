Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D202C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 03:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9cuN-0003Ul-F2; Tue, 21 May 2024 23:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9cuK-0003SE-BP
 for qemu-devel@nongnu.org; Tue, 21 May 2024 23:44:52 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9cuG-0004A9-HR
 for qemu-devel@nongnu.org; Tue, 21 May 2024 23:44:51 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2454154e53aso2686439fac.3
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 20:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716349486; x=1716954286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x2wkzB9GtMTSuOUWMWtp1POxPGIbKlhGRu9DTuWffok=;
 b=vqEI/6eKfaAgF8Y7s1meh36GtgXDYyuGZckgDpsP23B12BaoWWt7lc6u5NjKMI8L+O
 SDLGbVLB2dCvRr8A7wz0ADH0JTI/IytlGFeuv3KFo/RZqwWYC80KgLU4wMr7zBUdU545
 0t83BOmh90sU2L8+OCCQHg+HblsLYl21yBMzT6cZDq8E2rgOkKlTzcJknHL4gRmJDXhP
 bm8/aDVtUHi+Q++N2KnmMdM6YH21N2as7TYhx+wuoOcRUchuXFpI5eb2AxvkgPN7ilJe
 sRmNC2jNQ443p/SuHfBVuYRQViletmNTAOVkg3XNn/bOyI2Fxsb2ly3CnzXdGTqxX7fe
 4e9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716349486; x=1716954286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x2wkzB9GtMTSuOUWMWtp1POxPGIbKlhGRu9DTuWffok=;
 b=v85zYGsSfIKcMkzIk0Mkj3AisRnyWGz2KaiuQ768T5uJn6oOOGdFcCWCuLUYHGWXAc
 MGn2C58w0S4V6hMo/SjqyxR0L+7EXElKa794hc0uHvDiNiGQYnNr+EcZnJKtJk+drSuT
 KIZkZwgnika4gIou5a2RKI9QTq7ADaLoUB6ZnzTkyOvTLef0QPpkpQe8BqPNoUXm7XTO
 F9Aqlh0JTYgp4vXgzhsSH/3MumWuOc48z6ZQ97bRtpn2ysQlwpcclCLwh48DnMcCnEbX
 z235uWeJfNiXAouwrfCKk4IX2lC5A1/1kO+Ra0Uk6T5sw9LARZ7m+yaDr2wLnFmzDv6r
 k9pg==
X-Gm-Message-State: AOJu0YxTlypEpunAwVxA+uckwvyHW9QGGMgxlsE3vUe6YfcIea3iHe48
 gZ7hHj36jtrDnGvKCvIhx/LarJm0NK2U0TdCs/1rbZKTNdW86Kzp5ZNKWXgvZ9PfzzF0ZjHltyd
 B
X-Google-Smtp-Source: AGHT+IE3pGSUDM1e2F0t8jtgJ6fUuS11xFbJ1WTKOSX7QVY52VPdEDiaRad8sLsNHylpHuLLzShEqA==
X-Received: by 2002:a05:6870:eca5:b0:23f:ba88:d5ac with SMTP id
 586e51a60fabf-24c68d77dbfmr1026573fac.53.1716349486280; 
 Tue, 21 May 2024 20:44:46 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2af2bafsm21416617b3a.162.2024.05.21.20.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 20:44:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	mark.cave-ayland@ilande.co.uk
Subject: [PATCH RISU v2 3/8] Introduce host_context_t
Date: Tue, 21 May 2024 20:44:37 -0700
Message-Id: <20240522034442.140293-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522034442.140293-1-richard.henderson@linaro.org>
References: <20240522034442.140293-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Most hosts pass ucontext_t as the third parameter of signal handlers.

In one existing usage, loongarch64 is using the kernel's
struct ucontext instead of libc's ucontext_t.  This is probably a
simple mistake that could be fixed, but the structure member names
differ, so the change would not be completely mechanical.

However, due to a sequence of historical mistakes, sparc64 linux
does not pass any kind of ucontext_t to the signal handler, but
uses struct sigcontext instead.

Prepare for that by adding a new indirection typedef.
This allows us to clean up existing usage with void*.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.h                     | 16 ++++++++--------
 risu_reginfo_aarch64.h     |  2 ++
 risu_reginfo_arm.h         |  2 ++
 risu_reginfo_i386.h        |  2 ++
 risu_reginfo_loongarch64.h |  3 +++
 risu_reginfo_m68k.h        |  2 ++
 risu_reginfo_ppc64.h       |  2 ++
 risu_reginfo_s390x.h       |  2 ++
 risu_aarch64.c             |  6 ++----
 risu_arm.c                 |  7 ++-----
 risu_i386.c                |  7 ++-----
 risu_loongarch64.c         |  6 ++----
 risu_m68k.c                |  6 ++----
 risu_ppc64.c               |  6 ++----
 risu_reginfo_loongarch64.c |  3 +--
 risu_s390x.c               |  5 ++---
 16 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/risu.h b/risu.h
index 4203178..0ac7d1e 100644
--- a/risu.h
+++ b/risu.h
@@ -68,7 +68,7 @@ typedef enum {
 
 /* This is the data structure we pass over the socket for OP_COMPARE
  * and OP_TESTEND. It is a simplified and reduced subset of what can
- * be obtained with a ucontext_t*, and is architecture specific
+ * be obtained with a ucontext_t, and is architecture specific
  * (defined in risu_reginfo_*.h).
  */
 struct reginfo;
@@ -93,14 +93,14 @@ void send_response_byte(int sock, int resp);
 
 /* Interface provided by CPU-specific code: */
 
-/* Move the PC past this faulting insn by adjusting ucontext. */
-void advance_pc(void *uc);
+/* Move the PC past this faulting insn by adjusting signal context. */
+void advance_pc(host_context_t *hc);
 
-/* Set the parameter register in a ucontext_t to the specified value.
+/*
+ * Set the parameter register in a host_context_t to the specified value.
  * (32-bit targets can ignore high 32 bits.)
- * vuc is a ucontext_t* cast to void*.
  */
-void set_ucontext_paramreg(void *vuc, uint64_t value);
+void set_ucontext_paramreg(host_context_t *hc, uint64_t value);
 
 /* Return the value of the parameter register from a reginfo. */
 uint64_t get_reginfo_paramreg(struct reginfo *ri);
@@ -114,8 +114,8 @@ RisuOp get_risuop(struct reginfo *ri);
 /* Return the PC from a reginfo */
 uintptr_t get_pc(struct reginfo *ri);
 
-/* initialize structure from a ucontext */
-void reginfo_init(struct reginfo *ri, ucontext_t *uc, void *siaddr);
+/* initialize structure from a host_context_t. */
+void reginfo_init(struct reginfo *ri, host_context_t *hc, void *siaddr);
 
 /* return true if structs are equal, false otherwise. */
 bool reginfo_is_eq(struct reginfo *r1, struct reginfo *r2);
diff --git a/risu_reginfo_aarch64.h b/risu_reginfo_aarch64.h
index 097b7ad..bc3a661 100644
--- a/risu_reginfo_aarch64.h
+++ b/risu_reginfo_aarch64.h
@@ -15,6 +15,8 @@
 
 #include <signal.h>
 
+typedef ucontext_t host_context_t;
+
 /* The kernel headers set this based on future arch extensions.
    The current arch maximum is 16.  Save space below.  */
 #undef SVE_VQ_MAX
diff --git a/risu_reginfo_arm.h b/risu_reginfo_arm.h
index 60754a9..1937e46 100644
--- a/risu_reginfo_arm.h
+++ b/risu_reginfo_arm.h
@@ -13,6 +13,8 @@
 #ifndef RISU_REGINFO_ARM_H
 #define RISU_REGINFO_ARM_H
 
+typedef ucontext_t host_context_t;
+
 struct reginfo {
     uint64_t fpregs[32];
     uint32_t faulting_insn;
diff --git a/risu_reginfo_i386.h b/risu_reginfo_i386.h
index b468f79..abbfbe1 100644
--- a/risu_reginfo_i386.h
+++ b/risu_reginfo_i386.h
@@ -12,6 +12,8 @@
 #ifndef RISU_REGINFO_I386_H
 #define RISU_REGINFO_I386_H
 
+typedef ucontext_t host_context_t;
+
 struct avx512_reg {
     uint64_t q[8];
 };
diff --git a/risu_reginfo_loongarch64.h b/risu_reginfo_loongarch64.h
index 892b477..6c85951 100644
--- a/risu_reginfo_loongarch64.h
+++ b/risu_reginfo_loongarch64.h
@@ -12,6 +12,9 @@
 #ifndef RISU_REGINFO_LOONGARCH64_H
 #define RISU_REGINFO_LOONGARCH64_H
 
+/* From kernel <asm/ucontext.h> not libc <ucontext.h>. */
+typedef struct ucontext host_context_t;
+
 struct reginfo {
     uint64_t regs[32];
     uint64_t pc;
diff --git a/risu_reginfo_m68k.h b/risu_reginfo_m68k.h
index c1c9fe6..233f901 100644
--- a/risu_reginfo_m68k.h
+++ b/risu_reginfo_m68k.h
@@ -9,6 +9,8 @@
 #ifndef RISU_REGINFO_M68K_H
 #define RISU_REGINFO_M68K_H
 
+typedef ucontext_t host_context_t;
+
 struct reginfo {
     uint32_t faulting_insn;
     uint32_t pc;
diff --git a/risu_reginfo_ppc64.h b/risu_reginfo_ppc64.h
index 4b1d8bd..424fd02 100644
--- a/risu_reginfo_ppc64.h
+++ b/risu_reginfo_ppc64.h
@@ -14,6 +14,8 @@
 #ifndef RISU_REGINFO_PPC64LE_H
 #define RISU_REGINFO_PPC64LE_H
 
+typedef ucontext_t host_context_t;
+
 struct reginfo {
     uint32_t faulting_insn;
     uint32_t prev_insn;
diff --git a/risu_reginfo_s390x.h b/risu_reginfo_s390x.h
index c65fff7..5126fd5 100644
--- a/risu_reginfo_s390x.h
+++ b/risu_reginfo_s390x.h
@@ -12,6 +12,8 @@
 #ifndef RISU_REGINFO_S390X_H
 #define RISU_REGINFO_S390X_H
 
+typedef ucontext_t host_context_t;
+
 struct reginfo {
     uint64_t psw_mask;
     uint64_t pc_offset;
diff --git a/risu_aarch64.c b/risu_aarch64.c
index f8a8412..af94539 100644
--- a/risu_aarch64.c
+++ b/risu_aarch64.c
@@ -12,15 +12,13 @@
 
 #include "risu.h"
 
-void advance_pc(void *vuc)
+void advance_pc(ucontext_t *uc)
 {
-    ucontext_t *uc = vuc;
     uc->uc_mcontext.pc += 4;
 }
 
-void set_ucontext_paramreg(void *vuc, uint64_t value)
+void set_ucontext_paramreg(ucontext_t *uc, uint64_t value)
 {
-    ucontext_t *uc = vuc;
     uc->uc_mcontext.regs[0] = value;
 }
 
diff --git a/risu_arm.c b/risu_arm.c
index a20bf73..0e72fba 100644
--- a/risu_arm.c
+++ b/risu_arm.c
@@ -38,16 +38,13 @@ int insnsize(ucontext_t *uc)
     return 4;
 }
 
-void advance_pc(void *vuc)
+void advance_pc(ucontext_t *uc)
 {
-    ucontext_t *uc = vuc;
     uc->uc_mcontext.arm_pc += insnsize(uc);
 }
 
-
-void set_ucontext_paramreg(void *vuc, uint64_t value)
+void set_ucontext_paramreg(ucontext_t *uc, uint64_t value)
 {
-    ucontext_t *uc = vuc;
     uc->uc_mcontext.arm_r0 = value;
 }
 
diff --git a/risu_i386.c b/risu_i386.c
index 127e816..5d3b8aa 100644
--- a/risu_i386.c
+++ b/risu_i386.c
@@ -16,10 +16,8 @@
 #include "risu.h"
 #include "risu_reginfo_i386.h"
 
-void advance_pc(void *vuc)
+void advance_pc(ucontext_t *uc)
 {
-    ucontext_t *uc = (ucontext_t *) vuc;
-
     /*
      * We assume that this is UD1 as per get_risuop below.
      * This would need tweaking if we want to test expected undefs.
@@ -27,9 +25,8 @@ void advance_pc(void *vuc)
     uc->uc_mcontext.gregs[REG_E(IP)] += 3;
 }
 
-void set_ucontext_paramreg(void *vuc, uint64_t value)
+void set_ucontext_paramreg(ucontext_t *uc, uint64_t value)
 {
-    ucontext_t *uc = (ucontext_t *) vuc;
     uc->uc_mcontext.gregs[REG_E(AX)] = value;
 }
 
diff --git a/risu_loongarch64.c b/risu_loongarch64.c
index b6c59cf..921a031 100644
--- a/risu_loongarch64.c
+++ b/risu_loongarch64.c
@@ -15,15 +15,13 @@
 
 #include "risu.h"
 
-void advance_pc(void *vuc)
+void advance_pc(host_context_t *uc)
 {
-    struct ucontext *uc = vuc;
     uc->uc_mcontext.sc_pc += 4;
 }
 
-void set_ucontext_paramreg(void *vuc, uint64_t value)
+void set_ucontext_paramreg(host_context_t *uc, uint64_t value)
 {
-    struct ucontext *uc = vuc;
     uc->uc_mcontext.sc_regs[4] = value;
 }
 
diff --git a/risu_m68k.c b/risu_m68k.c
index acdd57a..bd6bece 100644
--- a/risu_m68k.c
+++ b/risu_m68k.c
@@ -8,15 +8,13 @@
 
 #include "risu.h"
 
-void advance_pc(void *vuc)
+void advance_pc(ucontext_t *uc)
 {
-    ucontext_t *uc = (ucontext_t *) vuc;
     uc->uc_mcontext.gregs[R_PC] += 4;
 }
 
-void set_ucontext_paramreg(void *vuc, uint64_t value)
+void set_ucontext_paramreg(ucontext_t *uc, uint64_t value)
 {
-    ucontext_t *uc = vuc;
     uc->uc_mcontext.gregs[R_A0] = value;
 }
 
diff --git a/risu_ppc64.c b/risu_ppc64.c
index 62cf6aa..06cb8a8 100644
--- a/risu_ppc64.c
+++ b/risu_ppc64.c
@@ -14,15 +14,13 @@
 #include "risu.h"
 #include <sys/user.h>
 
-void advance_pc(void *vuc)
+void advance_pc(ucontext_t *uc)
 {
-    ucontext_t *uc = (ucontext_t *) vuc;
     uc->uc_mcontext.regs->nip += 4;
 }
 
-void set_ucontext_paramreg(void *vuc, uint64_t value)
+void set_ucontext_paramreg(ucontext_t *uc, uint64_t value)
 {
-    ucontext_t *uc = vuc;
     uc->uc_mcontext.gp_regs[0] = value;
 }
 
diff --git a/risu_reginfo_loongarch64.c b/risu_reginfo_loongarch64.c
index 6150a40..0719e8b 100644
--- a/risu_reginfo_loongarch64.c
+++ b/risu_reginfo_loongarch64.c
@@ -97,10 +97,9 @@ static int parse_extcontext(struct sigcontext *sc, struct extctx_layout *extctx)
 }
 
 /* reginfo_init: initialize with a ucontext */
-void reginfo_init(struct reginfo *ri, ucontext_t *context, void *siaddr)
+void reginfo_init(struct reginfo *ri, host_context_t *uc, void *siaddr)
 {
     int i;
-    struct ucontext *uc = (struct ucontext *)context;
     struct extctx_layout extctx;
 
     memset(&extctx, 0, sizeof(struct extctx_layout));
diff --git a/risu_s390x.c b/risu_s390x.c
index cf9c72c..906766e 100644
--- a/risu_s390x.c
+++ b/risu_s390x.c
@@ -13,7 +13,7 @@
 
 #include "risu.h"
 
-void advance_pc(void *vuc)
+void advance_pc(ucontext_t *uc)
 {
     /*
      * Note: The PSW address already points to the next instruction
@@ -21,9 +21,8 @@ void advance_pc(void *vuc)
      */
 }
 
-void set_ucontext_paramreg(void *vuc, uint64_t value)
+void set_ucontext_paramreg(ucontext_t *uc, uint64_t value)
 {
-    ucontext_t *uc = vuc;
     uc->uc_mcontext.gregs[0] = value;
 }
 
-- 
2.34.1



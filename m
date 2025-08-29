Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B775BCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNlF-0004PO-Oi; Sat, 30 Aug 2025 11:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bQ-0004Rw-Eo
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:48 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bO-0003dN-Ix
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:48 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-32326e20aadso2799751a91.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506585; x=1757111385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QqPfbNKA06t+UTNS9gbkWsyk9nvfuwNoDjToDAtDRNI=;
 b=cfH1/YNnM7ueY9b6kmxrTMqijaEdkuiGOjTTo19357L2BGvYNd5K1SJ3lmvk37Dg0u
 PEGhaiFhsK/S7iHCmFW3cDiR37x7x8bH+nCXoJL6tmFhuZYAzbwo5zEaziuFNQ9gvO/T
 EBOyMu7sbFWbOwwX8Z4vAvgq6Jtz4bq5r+MciA9Oobs7b9nRtqd37WP+roEt93kD2b8E
 IKyeroVnD6HTFdLANHF/OJDqEY9InBCOq0iXvlyathlsXXvzlgxkKpkNDyuXUDX0jXc4
 7AZtjBe87ZtbY0EepTUodMw0jHOl9lHYtIGwoL0Uz7cLbo3KsqIf7ZyH6xxlKV7YTbY+
 WY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506585; x=1757111385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QqPfbNKA06t+UTNS9gbkWsyk9nvfuwNoDjToDAtDRNI=;
 b=TtWWc1oE8gxxsG71LR0deh3XKonu55kWLeyPldJOWK+1XPYvFz0c73fJNYg1dRel4J
 jI73VcXT95ZCnyz3N1gFKtVqLOOiJqEIPTphEjbe3BHGJ/BSC7b3J+Knax0/zNRBloSb
 5KlM6dHtkKVXEsuhPeXpu+qhdGdxi+M6jKHgkRHuxwbSA88BB7LZTyUX9AgkNCkWacl2
 gVleFgT17GhxAUvofkh/nuhtACL4yvhvzcaEqKwrTY7xAEbpJPoSZaaA6AhWTWJYJdP3
 +tx0fzHjbQZoXgGwW9xn0PZGaNhmjBaZVLYHas2S4ra5D11w24FtRv12jkUPC2HnysHK
 O2nQ==
X-Gm-Message-State: AOJu0YxdYkVVOKNiJCRT790Rj62tHeew4KyZzY7XjNj2nPVvgcox9IFb
 +DaTf54gi2L9Gc29rnPLkPcwNg0PTwR6ApVZNDe6B5fQpj9WT1UvEwTKVWBUEQFOWNiTSU0yjuH
 c/vAc/24=
X-Gm-Gg: ASbGncsoeCn0prO7BO30sPfgTJYigXG5Qhw0wXzEWmyRZcFc34Z0pLFmmXxYa6l47Gh
 r1dfIHHxu70RJQPn55GMJNzWw0PYflDZ71FLMkQE+bi/HzwLb6s0jZcCj70YZtIHpO9cCc5bwsV
 lt7FgiTFETRmMD+FXHSEeVR36OIVvMHNGOLxlBhgN1+YcPG+dz2rTENhRQqXtnc/ov6lEFep9EG
 pRmQhcguo+7aIZNsfMyOa8g8okB3Ys0ximDXI9Etnrxnj67BOAyW1Bi2S+4LfSZ7lHmNjNea7NI
 4W5Zaft2oUdywwU75z3cvJxQY7h97lRQRrSS1oMCTJycv86x0YODOHGnRnG2d0gCx/Y/Rv2duly
 t7g1v9prnjvGW+Ey4tfXXxP4GUi1pm8qhCKhv6NwZVGSJEEa5iA6wT2wW3wqoqdMNlzGYf1Y+qg
 ==
X-Google-Smtp-Source: AGHT+IGjufkwQUUanUyORsttC84G+hr8V9R7SW4SGGrxSxe5gNtjBygtE4g9RHTKqS1VPXNI2NS5jg==
X-Received: by 2002:a17:90a:d606:b0:327:dcab:d4f0 with SMTP id
 98e67ed59e1d1-328156bac20mr335354a91.19.1756506584872; 
 Fri, 29 Aug 2025 15:29:44 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:29:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 54/91] linux-user/ppc: Expand target_elf_gregset_t
Date: Sat, 30 Aug 2025 08:23:50 +1000
Message-ID: <20250829222427.289668-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Make use of the fact that target_elf_gregset_t is a proper structure.
Drop ELF_NREG, target_elf_greg_t, and tswapreg.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/ppc/target_elf.h | 16 +++++++++++-----
 linux-user/ppc/elfload.c    | 23 ++++++++---------------
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/linux-user/ppc/target_elf.h b/linux-user/ppc/target_elf.h
index 72615553ea..2a61cd2896 100644
--- a/linux-user/ppc/target_elf.h
+++ b/linux-user/ppc/target_elf.h
@@ -8,16 +8,22 @@
 #ifndef PPC_TARGET_ELF_H
 #define PPC_TARGET_ELF_H
 
+#include "target_ptrace.h"
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_HWCAP2         1
 #define HAVE_ELF_CORE_DUMP      1
 
-typedef abi_ulong target_elf_greg_t;
-
-/* See linux kernel: arch/powerpc/include/asm/elf.h.  */
-#define ELF_NREG                48
+/*
+ * The size of 48 words is set in arch/powerpc/include/uapi/asm/elf.h.
+ * However PPC_ELF_CORE_COPY_REGS in arch/powerpc/include/asm/elf.h
+ * open-codes a memcpy from struct pt_regs, then zeros the rest.
+ */
 typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
+    union {
+        struct target_pt_regs pt;
+        abi_ulong reserved[48];
+    };
 } target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/ppc/elfload.c b/linux-user/ppc/elfload.c
index 114e40a358..0d54da9803 100644
--- a/linux-user/ppc/elfload.c
+++ b/linux-user/ppc/elfload.c
@@ -131,23 +131,16 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     return features;
 }
 
-#define tswapreg(ptr)   tswapal(ptr)
-
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUPPCState *env)
 {
-    int i;
-    target_ulong ccr = 0;
-
-    for (i = 0; i < ARRAY_SIZE(env->gpr); i++) {
-        r->regs[i] = tswapreg(env->gpr[i]);
+    for (int i = 0; i < ARRAY_SIZE(env->gpr); i++) {
+        r->pt.gpr[i] = tswapal(env->gpr[i]);
     }
 
-    r->regs[32] = tswapreg(env->nip);
-    r->regs[33] = tswapreg(env->msr);
-    r->regs[35] = tswapreg(env->ctr);
-    r->regs[36] = tswapreg(env->lr);
-    r->regs[37] = tswapreg(cpu_read_xer(env));
-
-    ccr = ppc_get_cr(env);
-    r->regs[38] = tswapreg(ccr);
+    r->pt.nip = tswapal(env->nip);
+    r->pt.msr = tswapal(env->msr);
+    r->pt.ctr = tswapal(env->ctr);
+    r->pt.link = tswapal(env->lr);
+    r->pt.xer = tswapal(cpu_read_xer(env));
+    r->pt.ccr = tswapal(ppc_get_cr(env));
 }
-- 
2.43.0



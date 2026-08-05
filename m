Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8F6C55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 17:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrfDB-00046V-VR; Wed, 05 Aug 2026 13:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wrfD5-00044y-0n
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 13:15:19 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wrfD3-0006G0-LO
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 13:15:18 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-6689402c7bfso1416920d50.1
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 10:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785950116; x=1786554916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=En9VZrt5WidxCbXa12EB2/sVueTRr51wVYQkq+wEzuY=;
 b=ItNXQLocqyjqCXgzHugqJuTKNba4/TgSIP0HcD90nrDBzvW7nKce1SVyX4D50HrGhC
 FInm4Gh/i/Ihrko29RZeB9mwYUDDmKcwNaPtqN7qmaB4AikOUlkRwniOxzGnKTqULe6P
 RsuOOxgXpC+OCfyZh2JQ7Y58fbaQz7aH4v8ac9d+yrgrhah+2R8Jt7yYqP4tYDexiojY
 Gow5RlOO3lrePpUsia5nR11lNYEbbTLIXCgrJnEypvtvwXced4dnkswQuYCD80su5bfZ
 uiI3b4EQMhsNYSUdV+7VzKggLmMqsEHhTgrnNAAe33xiDrM8oYEYAQ1ybqu01mHdwcqQ
 sX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785950116; x=1786554916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=En9VZrt5WidxCbXa12EB2/sVueTRr51wVYQkq+wEzuY=;
 b=MrLoCkBVDB73kqZszbBPfpQI/w1OdEsyx/XXQkO6O8JjmIMmHtl9kYjPlhGiqsDC7e
 Tn3qNWmnjl+tccxZdoviUxlnNRKrakYDmMiZyZonYmZlYMqakWRn+wLb+w31vuHEVG3j
 DGDomdyGOdIspcjJcp+1kEdvqu5DtRCA6vh5VBcSXk/O6El0XGZzCa+B47MgBX4fgVPA
 D3qkt9CrooKAtUUA3QCYcou91Ca9oWpK92PPDYOmLPYep741k+LGtuad75yOhpqA0Ke4
 fvJc7mqiDU54cIzp+aqwn5Tgh1/vlandnDzcpDpRZI/uCy+0v7j0AD0yrlAKbSLFCVxV
 lSaQ==
X-Gm-Message-State: AOJu0Yy39G+zJYzxFbP3JjUOQYCyUCj1Xr5jEOp4fchgso5Ngt/kBhBJ
 4vnEMn4NGaD9ZavcKo3qQ1NwUrwpS4+dblAndTmNXDSyMBlAQikNL4itzSiK3a1SwSs=
X-Gm-Gg: AR+sD132lH7NWMyTT024jMzh7+7mvIZLpc/VOL8gUHq7YoJfW2pNIm2ClmENXYOhA8m
 kasA0gWEDe427+wGTEjfisI7HB+X8nW8SChLPw70G0WVDHh3xiuDp4wRAOw+XSjLLkhMIUWCcP+
 P/nd6SiMSRaFtOs/3+KmfGRrYTIPQgEvMiphxhy2a9M2qpP3Fs99hAAxXY1m9DYo/YPBJn2JIhK
 aLI5+6oiyvu6aFVY5dlUq7HVpGXjaqZA9UG79aClUpJ3WZU06tL/Ef3HDn+5yrs/i12DK4gIi2u
 JTa/kcGMOONsvqibewhdyVDPXSKt6vmGYq0CHiCLx1QRaVGigesf4Fmo14J0LTm32t7ysSovMZA
 zyvOxTCFIm2V4AV/ZrlHavmiE0sEaVcCN4ZMmOo321O/63uH+YWRbM9mqZIra0DMaXFeMKHGwez
 z2AulrHwBIgirWv/ucx9vBTPJspgjQker+gq0IHlSosOGtBkl9idZPhsJDaNnP
X-Received: by 2002:a53:a4c3:0:b0:664:be82:2b6c with SMTP id
 956f58d0204a3-6699abc0a64mr3658888d50.54.1785950116411; 
 Wed, 05 Aug 2026 10:15:16 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-669913cc2efsm3617818d50.8.2026.08.05.10.15.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 10:15:15 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 4/5] linux-user/riscv: write the floating-point registers to a
 core dump
Date: Wed,  5 Aug 2026 13:15:06 -0400
Message-ID: <20260805171507.3119442-4-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805171507.3119442-1-mattst88@gmail.com>
References: <20260805171507.3119442-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb135.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Write an NT_FPREGSET note for RISC-V, matching struct __riscv_d_ext_state
from uapi/asm/ptrace.h: f0-f31 as 64-bit values followed by fcsr.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 linux-user/riscv/elfload.c    |  9 +++++++++
 linux-user/riscv/target_elf.h | 11 +++++++++++
 2 files changed, 20 insertions(+)

diff --git ./linux-user/riscv/elfload.c ./linux-user/riscv/elfload.c
index afe103a631..1bc8beacb1 100644
--- ./linux-user/riscv/elfload.c
+++ ./linux-user/riscv/elfload.c
@@ -11,6 +11,15 @@ const char *get_elf_cpu_model(uint32_t eflags)
     return "max";
 }
 
+void elf_core_copy_fpregs(target_elf_fpregset_t *r, const CPURISCVState *env)
+{
+    for (int i = 0; i < 32; i++) {
+        r->fpr[i] = tswap64(env->fpr[i]);
+    }
+    r->fcsr = tswap32(((uint32_t)env->frm << FSR_RD_SHIFT) |
+                      (riscv_cpu_get_fflags((CPURISCVState *)env) << FSR_AEXC_SHIFT));
+}
+
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPURISCVState *env)
 {
     r->pc = tswapal(env->pc);
diff --git ./linux-user/riscv/target_elf.h ./linux-user/riscv/target_elf.h
index 859f726578..185b81a2db 100644
--- ./linux-user/riscv/target_elf.h
+++ ./linux-user/riscv/target_elf.h
@@ -27,4 +27,15 @@ typedef struct target_elf_gregset_t {
     abi_ulong regs[31];
 } target_elf_gregset_t;
 
+#define HAVE_ELF_CORE_FPREGS    1
+
+/*
+ * Matches struct __riscv_d_ext_state from uapi/asm/ptrace.h:
+ *   f0-f31 as 64-bit values followed by fcsr.
+ */
+typedef struct target_elf_fpregset_t {
+    uint64_t fpr[32];
+    uint32_t fcsr;
+} target_elf_fpregset_t;
+
 #endif
-- 
2.54.0



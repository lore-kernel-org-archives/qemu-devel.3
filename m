Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A61C25B7D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 00:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBOZQ-0007L3-Ly; Sun, 26 May 2024 20:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZJ-0007Ct-AP
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:29 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZ9-0003fd-47
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:25 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6f8ef894ecdso172469a34.1
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 17:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716771017; x=1717375817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+kCzCPFmRVWagKLDLCR1Cq5shqRDzyNhJ9IIrqSVUo=;
 b=YI6mF0Lhy66Q/lM7wIu/McvIbDz7GFS6AcMi3f5vfBWo/NyS8nBdGILnN4A86iP3uw
 cSntUTRb0OAIkjb8UimiveLYgHtV2DC4hdhEnMESp8XrO65o+EUuurT1kX13tu16H4+O
 4IiZRhBblH/SZ/VEsXlWsPOQjyzQo5PGivZMqyHIBEzrp/1q5gmR9zOEy7kGEgUE5y74
 6GDbwnzEeFvjwV9yoME8CVFeYccoeeNfvOgjxeVIpB+1IekXPjL9zxvBA4x9haJiD4wd
 NWij7zwaHSXglpLCOfwp8FuD+XIZv4qjW4yRCMiXDhMmJdqUQ3IpbT8ny3hAKtvDemyo
 XWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716771017; x=1717375817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d+kCzCPFmRVWagKLDLCR1Cq5shqRDzyNhJ9IIrqSVUo=;
 b=dAnszFa1c4bZiidSN1X9Pv33W1WgLVFSunnFUpdP22gE50ruiNAyAmk6pOMEL/zRvF
 /aEVMZglJhiyVfLlnLm8j9gu7R6fPPaifF37xctK7LFw2kzdkKChS3SLeF2aKwkVcqi3
 kMwLD+IDANELIZLROc33jt+T1s4mgUkN1wskIHixiBlHVbtlq7ezqDiIlNDIMqtezUAk
 0oYfUEyNEK1VHzyIyY7vQfiMYEAzO6x8eWPFIwX0Uxv0EqzjKrka3rXzuYh1D/syZaTJ
 wZlL+KmoDGiAt7Et0CjhuqiLn5Dfm8R9Dp4cwM5yVusOgMONgrMi6pJ+IO/iyZf+Qqyj
 eKUQ==
X-Gm-Message-State: AOJu0Ywb4Qr1//aMtSK9xtHkcVzzx7TDeyHwr1Zv1kcIDustXOsHeAxf
 nyEs5MrOoSVIIGYGKHZ3i8cWvFZTbwjzh2ngyaMTdhG/R0NMPA5FEe1kQzZog2/Hbw4XEg7DtvJ
 N
X-Google-Smtp-Source: AGHT+IGpG6c8HjqWJyN/DtBnzI+un+8eUkzh4n0P9dTTnAGeECAWjDy9TDD0qk1AISoBmWQOlqdZWQ==
X-Received: by 2002:a05:6870:14c8:b0:24c:4c82:4f15 with SMTP id
 586e51a60fabf-24ca12903a7mr8620136fac.24.1716771016869; 
 Sun, 26 May 2024 17:50:16 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd6d7598sm3942958b3a.220.2024.05.26.17.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 17:50:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 18/28] linux-user/i386: Split out struct target_fregs_state
Date: Sun, 26 May 2024 17:49:51 -0700
Message-Id: <20240527005001.642825-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527005001.642825-1-richard.henderson@linaro.org>
References: <20240527005001.642825-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/signal.c | 43 +++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index 5b1c570bff..3271ebd333 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -34,6 +34,23 @@ struct target_fpreg {
     uint16_t exponent;
 };
 
+/* Legacy x87 fpu state format for FSAVE/FRESTOR. */
+struct target_fregs_state {
+    uint32_t cwd;
+    uint32_t swd;
+    uint32_t twd;
+    uint32_t fip;
+    uint32_t fcs;
+    uint32_t foo;
+    uint32_t fos;
+    struct target_fpreg st[8];
+
+    /* Software status information [not touched by FSAVE]. */
+    uint16_t status;
+    uint16_t magic;   /* 0xffff: FPU data only, 0x0000: FXSR FPU data */
+};
+QEMU_BUILD_BUG_ON(sizeof(struct target_fregs_state) != 32 + 80);
+
 struct target_fpx_sw_bytes {
     uint32_t magic1;
     uint32_t extended_size;
@@ -44,29 +61,19 @@ struct target_fpx_sw_bytes {
 QEMU_BUILD_BUG_ON(sizeof(struct target_fpx_sw_bytes) != 12*4);
 
 struct target_fpstate_32 {
-    /* Regular FPU environment */
-    uint32_t cw;
-    uint32_t sw;
-    uint32_t tag;
-    uint32_t ipoff;
-    uint32_t cssel;
-    uint32_t dataoff;
-    uint32_t datasel;
-    struct target_fpreg st[8];
-    uint16_t  status;
-    uint16_t  magic;          /* 0xffff = regular FPU data only */
-    X86LegacyXSaveArea fxsave;
+    struct target_fregs_state fpstate;
+    X86LegacyXSaveArea fxstate;
 };
 
 /*
  * For simplicity, setup_frame aligns struct target_fpstate_32 to
  * 16 bytes, so ensure that the FXSAVE area is also aligned.
  */
-QEMU_BUILD_BUG_ON(offsetof(struct target_fpstate_32, fxsave) & 15);
+QEMU_BUILD_BUG_ON(offsetof(struct target_fpstate_32, fxstate) & 15);
 
 #ifndef TARGET_X86_64
 # define target_fpstate target_fpstate_32
-# define TARGET_FPSTATE_FXSAVE_OFFSET offsetof(struct target_fpstate_32, fxsave)
+# define TARGET_FPSTATE_FXSAVE_OFFSET offsetof(struct target_fpstate_32, fxstate)
 #else
 # define target_fpstate X86LegacyXSaveArea
 # define TARGET_FPSTATE_FXSAVE_OFFSET 0
@@ -279,15 +286,15 @@ static void setup_sigcontext(struct target_sigcontext *sc,
     __put_user(env->segs[R_SS].selector, (unsigned int *)&sc->ss);
 
     cpu_x86_fsave(env, fpstate_addr, 1);
-    fpstate->status = fpstate->sw;
+    fpstate->fpstate.status = fpstate->fpstate.swd;
     if (!(env->features[FEAT_1_EDX] & CPUID_FXSR)) {
         magic = 0xffff;
     } else {
-        xsave_sigcontext(env, &fpstate->fxsave,
+        xsave_sigcontext(env, &fpstate->fxstate,
                          fpstate_addr + TARGET_FPSTATE_FXSAVE_OFFSET);
         magic = 0;
     }
-    __put_user(magic, &fpstate->magic);
+    __put_user(magic, &fpstate->fpstate.magic);
 #else
     __put_user(env->regs[R_EDI], &sc->rdi);
     __put_user(env->regs[R_ESI], &sc->rsi);
@@ -623,7 +630,7 @@ restore_sigcontext(CPUX86State *env, struct target_sigcontext *sc)
             cpu_x86_frstor(env, fpstate_addr, 1);
             err = 0;
         } else {
-            err = xrstor_sigcontext(env, &fpstate->fxsave,
+            err = xrstor_sigcontext(env, &fpstate->fxstate,
                                     fpstate_addr + TARGET_FPSTATE_FXSAVE_OFFSET);
         }
 #else
-- 
2.34.1



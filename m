Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27E7C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 00:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBOZU-0007O3-BE; Sun, 26 May 2024 20:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZO-0007J4-W0
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:35 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZJ-0003hy-0S
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:34 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-24c9f91242dso1435287fac.2
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 17:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716771023; x=1717375823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AI7rkjN7jKkGsGrZZgvFmIRDSXmmUvcz3SoDTGqstLM=;
 b=nRCqcQgLlgM56jfQb+Lu9xkcfy5ZxlvFXE/oumjmU+oDZjg1l7/d61zHuzrbYGwvqw
 8ud5O7E8q/3YtvpQgPlFAqO4u07ggr5ZQAOJvEbtjVOCCT8uZhlifJVx3Y2IUvOECO0A
 ykscQ0qX6AOcoo27/c4P94O7w4g8vVtbFfpxfdiAWHSCMJaL410OzI8SRLTfainaSQHO
 A71Y5KMgav8r4ld5A1SbVFhvzY8y2WdXg6fwu4P+tktR5fvvyts+75l8RBO1PoravpWH
 o9julVcIg7eOitcrEgdd2D/NXm+zSve/w90FD63MCq01PiNBOWJMS2vRNGbMr2/lhVLb
 LdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716771023; x=1717375823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AI7rkjN7jKkGsGrZZgvFmIRDSXmmUvcz3SoDTGqstLM=;
 b=gD4A3A4Y/fnSfnkR7357v/acyu9prtkEvJpz6Ocxr0OHcgyjbbPZrR0s9H6zMpKTVQ
 LHfU9gMPTztexoWf/g5iREWjMbx9QPOELrdwTKSlUvzzziM7yhQdb82vbRvvT/693w65
 fyHuyDwU+dsqB2iZtnbUppmQUPLp6FVfyl3mx/0bKwU9GHr3kBjGFqWNGHSAv6l4WC+K
 xmoIhnEb69+q+WM7ao5LB5JZSmBmcs1XoA6F37He0Y8b9af1TgBSrNaY5d9x3lMUqbgr
 048gcIuxdHwxb32OJpaX8tlmpcd+Q2dOl+RRpt352zFiSHh5oNxAarXjbbAkOz6/7l5+
 ft+g==
X-Gm-Message-State: AOJu0Yxo1+4yP4CPh8/6hgfM4JBKH4GzDTZan1643Hb1UiWu1rKGJQe4
 k3jZn4FA7X51exkCuQtKj85tz0j+I/c62+2Ll9wh26k6FTcN/pAb7fZfAnaQrdcPiYBiNTD1HP8
 g
X-Google-Smtp-Source: AGHT+IG4h+VLQtYUatDtrPe70LxttKnxmagA5gf22F/fopOgjJWtIlq3ME79TmB9zCucgvQqxqup1A==
X-Received: by 2002:a05:6870:718b:b0:24f:e0d2:7ee7 with SMTP id
 586e51a60fabf-24fe0d27f78mr4301383fac.15.1716771023741; 
 Sun, 26 May 2024 17:50:23 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd6d7598sm3942958b3a.220.2024.05.26.17.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 17:50:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 26/28] target/i386: Pass host pointer and size to
 cpu_x86_{fsave, frstor}
Date: Sun, 26 May 2024 17:49:59 -0700
Message-Id: <20240527005001.642825-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527005001.642825-1-richard.henderson@linaro.org>
References: <20240527005001.642825-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

We have already validated the memory region in the course of
validating the signal frame.  No need to do it again within
the helper function.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h            | 10 ++++++----
 linux-user/i386/signal.c     |  4 ++--
 target/i386/tcg/fpu_helper.c | 26 ++++++++++++++++----------
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index fdd318963a..f6020e0b6b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2266,11 +2266,13 @@ int cpu_x86_get_descr_debug(CPUX86State *env, unsigned int selector,
 /* used for debug or cpu save/restore */
 
 /* cpu-exec.c */
-/* the following helpers are only usable in user mode simulation as
-   they can trigger unexpected exceptions */
+/*
+ * The following helpers are only usable in user mode simulation.
+ * The host pointers should come from lock_user().
+ */
 void cpu_x86_load_seg(CPUX86State *s, X86Seg seg_reg, int selector);
-void cpu_x86_fsave(CPUX86State *s, target_ulong ptr, int data32);
-void cpu_x86_frstor(CPUX86State *s, target_ulong ptr, int data32);
+void cpu_x86_fsave(CPUX86State *s, void *host, size_t len);
+void cpu_x86_frstor(CPUX86State *s, void *host, size_t len);
 void cpu_x86_fxsave(CPUX86State *s, target_ulong ptr);
 void cpu_x86_fxrstor(CPUX86State *s, target_ulong ptr);
 void cpu_x86_xsave(CPUX86State *s, target_ulong ptr, uint64_t rbfm);
diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index ab760db5ea..dfbb811b56 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -373,7 +373,7 @@ static void setup_sigcontext(CPUX86State *env,
     __put_user(env->regs[R_ESP], &sc->esp_at_signal);
     __put_user(env->segs[R_SS].selector, (uint32_t *)&sc->ss);
 
-    cpu_x86_fsave(env, fpstate_addr, 1);
+    cpu_x86_fsave(env, fpstate, sizeof(*fpstate));
     fpstate->status = fpstate->swd;
     magic = (fpkind == FPSTATE_FSAVE ? 0 : 0xffff);
     __put_user(magic, &fpstate->magic);
@@ -702,7 +702,7 @@ static bool frstor_sigcontext(CPUX86State *env, FPStateKind fpkind,
      * the merge within ENV by loading XSTATE/FXSTATE first, then
      * overriding with the FSTATE afterward.
      */
-    cpu_x86_frstor(env, fpstate_addr, 1);
+    cpu_x86_frstor(env, fpstate, sizeof(*fpstate));
     return true;
 }
 #endif
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 1ac61c5d7d..05db16a152 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -3017,22 +3017,28 @@ void helper_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 }
 
 #if defined(CONFIG_USER_ONLY)
-void cpu_x86_fsave(CPUX86State *env, target_ulong ptr, int data32)
+void cpu_x86_fsave(CPUX86State *env, void *host, size_t len)
 {
-    int size = (14 << data32) + 80;
-    X86Access ac;
+    X86Access ac = {
+        .haddr1 = host,
+        .size = 4 * 7 + 8 * 10,
+        .env = env,
+    };
 
-    access_prepare(&ac, env, ptr, size, MMU_DATA_STORE, 0);
-    do_fsave(&ac, ptr, data32);
+    assert(ac.size <= len);
+    do_fsave(&ac, 0, true);
 }
 
-void cpu_x86_frstor(CPUX86State *env, target_ulong ptr, int data32)
+void cpu_x86_frstor(CPUX86State *env, void *host, size_t len)
 {
-    int size = (14 << data32) + 80;
-    X86Access ac;
+    X86Access ac = {
+        .haddr1 = host,
+        .size = 4 * 7 + 8 * 10,
+        .env = env,
+    };
 
-    access_prepare(&ac, env, ptr, size, MMU_DATA_LOAD, 0);
-    do_frstor(&ac, ptr, data32);
+    assert(ac.size <= len);
+    do_frstor(&ac, 0, true);
 }
 
 void cpu_x86_fxsave(CPUX86State *env, target_ulong ptr)
-- 
2.34.1



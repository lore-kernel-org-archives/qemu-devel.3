Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F83CC0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 10:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcMLl-0003NW-UC; Mon, 27 Jan 2025 05:28:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcMLC-0002VO-44
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:27:40 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcML7-00024D-AJ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:27:36 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43618283d48so29486115e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 02:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737973649; x=1738578449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DziHxjFtaWw6LQuGBR2OgXCBJZegMMFFhC3XNs3OJ50=;
 b=ko6XedffYoaF1CMp/8PFm0Th38xAEqsLFMWn3oanPf2RqU+OoKJO5iA+Yh3nOOLE0Y
 ItnKumSjeJXHsF4gn8n2CkbfxUr/fytxpmr3DuPHuDmE//WE1uG21TljIqIkfcZXZ1Nc
 zamNBvqGXgkfVdUBXS2Wxrsy+I+3+vzePjEjowaqqT/q6iLP1VF5uUEBaVr4qPrnzNU2
 /lYEWZYXewD0FhQKa/5TBCRZbgsLKifMqZ+iOjHWg4xAaQuOQNgNkzi6ao+dn76/S2jZ
 NN7uec9UzLVmJpy5obixSksWvVDzQUPyfqa64X5ME6Q4cSfdZxlVwyNHNUBBkye2kToE
 pWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737973649; x=1738578449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DziHxjFtaWw6LQuGBR2OgXCBJZegMMFFhC3XNs3OJ50=;
 b=nJablT1dWD7HajuG1GqKs6gQymuWoNCyIj2raKH5zfv0roG3XM28NEkjfwG9YsyJsM
 bdjDac/95oo3FRKj08vXc0Hrt9oQZc6usC/lnk0oofjwM6cQMSlxz+AY8LzYd9oZimt/
 CkovmrBwe6NEGhJmOxymlQJx5OW9vNnwVDtNjfA9BpP+JM9pHAQosx2MuT/MRGIj7Adq
 pbEQq7xLrd43WM91Vgkm6+W5BK74DBah9sD+tpYDG+9dWZrN8Tyud353CoOD4DbIgt2F
 FG28AY1WYb2bD0sApNqOP/nhO8CdX3N/LMugo46OSeNJvgmk8yPwpJNh3sHt/172kibl
 aIow==
X-Gm-Message-State: AOJu0YzJlX3dYFbn4r6XxI4EQAXJZ5JPtUSI9FuVTSDpxWLxocsR4hbD
 mMXpagnhAfEyH2esQ6GVauBzP+sBCPqmzez30FCrZDXRzaJQTamFsHIfsLJhdbOhhoSm8C1NVkk
 WWhE=
X-Gm-Gg: ASbGncvoMIStbrteLVbCouPLEwmiH8vuu+xshXiaB/CAuVWx/jKXo/4VDCIPWst1iVt
 XkThbAb6Tn7q0+o9nKCbvTabYYPIPauKIENqyH3dZpObkqKLb0XHwaFPPY1o8Vs8XPsBaTtyhoJ
 7oekjd44ragTO6NFHHjrJZV+AA6ucIE3WbDbu4E4WGS6ORCVJqw3z+pBQk5yvQV8mq9lHEEJGbj
 TsTrp1JNpOW8eR06p4nbvH7Zp66wuHdv+y2qejbrGqvhDpcP+fQ8bdQZKjoO9tEtcq3n74AmH6T
 kCkkonB2nK4crgT9+rznHKKOfmTaP6/cjK4HNSwbHodJkSZQhg1p0iI=
X-Google-Smtp-Source: AGHT+IHF/8w3vcM1V531fDV7IfRlssuRfuU15hB98A7mtBoAB0UPRYl1BZbPvaCck6JinkXvjB6l3Q==
X-Received: by 2002:a05:600c:8719:b0:434:9499:9e87 with SMTP id
 5b1f17b1804b1-43891437217mr325610735e9.25.1737973648654; 
 Mon, 27 Jan 2025 02:27:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd50184dsm124699235e9.10.2025.01.27.02.27.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jan 2025 02:27:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 14/15] target/ppc: Restrict ATTN / SCV / PMINSN helpers to
 TCG
Date: Mon, 27 Jan 2025 11:26:18 +0100
Message-ID: <20250127102620.39159-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127102620.39159-1-philmd@linaro.org>
References: <20250127102620.39159-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Move helper_attn(), helper_scv() and helper_pminsn() to
tcg-excp_helper.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/excp_helper.c     | 45 ------------------------------------
 target/ppc/tcg-excp_helper.c | 39 +++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 45 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index f0e734e1412..2deed155987 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -400,21 +400,6 @@ static void powerpc_set_excp_state(PowerPCCPU *cpu, target_ulong vector,
     env->reserve_addr = -1;
 }
 
-#ifdef CONFIG_TCG
-#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
-void helper_attn(CPUPPCState *env)
-{
-    /* POWER attn is unprivileged when enabled by HID, otherwise illegal */
-    if ((*env->check_attn)(env)) {
-        powerpc_checkstop(env, "host executed attn");
-    } else {
-        raise_exception_err(env, POWERPC_EXCP_HV_EMU,
-                            POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_INVAL);
-    }
-}
-#endif
-#endif /* CONFIG_TCG */
-
 static void powerpc_mcheck_checkstop(CPUPPCState *env)
 {
     /* KVM guests always have MSR[ME] enabled */
@@ -2445,36 +2430,6 @@ void helper_ppc_maybe_interrupt(CPUPPCState *env)
     ppc_maybe_interrupt(env);
 }
 
-#ifdef TARGET_PPC64
-void helper_scv(CPUPPCState *env, uint32_t lev)
-{
-    if (env->spr[SPR_FSCR] & (1ull << FSCR_SCV)) {
-        raise_exception_err(env, POWERPC_EXCP_SYSCALL_VECTORED, lev);
-    } else {
-        raise_exception_err(env, POWERPC_EXCP_FU, FSCR_IC_SCV);
-    }
-}
-
-void helper_pminsn(CPUPPCState *env, uint32_t insn)
-{
-    CPUState *cs = env_cpu(env);
-
-    cs->halted = 1;
-
-    /* Condition for waking up at 0x100 */
-    env->resume_as_sreset = (insn != PPC_PM_STOP) ||
-        (env->spr[SPR_PSSCR] & PSSCR_EC);
-
-    /* HDECR is not to wake from PM state, it may have already fired */
-    if (env->resume_as_sreset) {
-        PowerPCCPU *cpu = env_archcpu(env);
-        ppc_set_irq(cpu, PPC_INTERRUPT_HDECR, 0);
-    }
-
-    ppc_maybe_interrupt(env);
-}
-#endif /* TARGET_PPC64 */
-
 static void do_rfi(CPUPPCState *env, target_ulong nip, target_ulong msr)
 {
     /* MSR:POW cannot be set by any form of rfi */
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 5ad39cacc92..4517b458b79 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -499,6 +499,45 @@ void ppc_tcg_hv_emu(CPUPPCState *env, target_ulong *new_msr,
     *new_msr |= env->msr & ((target_ulong)1 << MSR_RI);
 }
 
+void helper_attn(CPUPPCState *env)
+{
+    /* POWER attn is unprivileged when enabled by HID, otherwise illegal */
+    if ((*env->check_attn)(env)) {
+        powerpc_checkstop(env, "host executed attn");
+    } else {
+        raise_exception_err(env, POWERPC_EXCP_HV_EMU,
+                            POWERPC_EXCP_INVAL | POWERPC_EXCP_INVAL_INVAL);
+    }
+}
+
+void helper_scv(CPUPPCState *env, uint32_t lev)
+{
+    if (env->spr[SPR_FSCR] & (1ull << FSCR_SCV)) {
+        raise_exception_err(env, POWERPC_EXCP_SYSCALL_VECTORED, lev);
+    } else {
+        raise_exception_err(env, POWERPC_EXCP_FU, FSCR_IC_SCV);
+    }
+}
+
+void helper_pminsn(CPUPPCState *env, uint32_t insn)
+{
+    CPUState *cs = env_cpu(env);
+
+    cs->halted = 1;
+
+    /* Condition for waking up at 0x100 */
+    env->resume_as_sreset = (insn != PPC_PM_STOP) ||
+        (env->spr[SPR_PSSCR] & PSSCR_EC);
+
+    /* HDECR is not to wake from PM state, it may have already fired */
+    if (env->resume_as_sreset) {
+        PowerPCCPU *cpu = env_archcpu(env);
+        ppc_set_irq(cpu, PPC_INTERRUPT_HDECR, 0);
+    }
+
+    ppc_maybe_interrupt(env);
+}
+
 #endif /* TARGET_PPC64 */
 
 #endif /* !CONFIG_USER_ONLY */
-- 
2.47.1



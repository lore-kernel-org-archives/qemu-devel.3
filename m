Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641B4C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QPC-0002mP-4g; Mon, 13 May 2024 03:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QP6-0002js-Ut
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:25 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QP4-0001JS-0l
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:24 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-420104e5336so8096025e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586440; x=1716191240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eUEXDe4PCMsFe4DA4mYg1FIK58I7QokH1/RCklBXYEQ=;
 b=pLH1zIaDc9P8rE9vv0YKAjGi5YiH15l2aAvqnOSu/Ltm5F6r7kRka6idvNPuPb3mSy
 ebO4CjKSVgUJkNPpKOpCyLFHWAwy8rouSZEvBC2/j1zlVSMGjE/Xbi3eOsF55mKAXPAd
 Gx1VS6FGMmHg3+ecWyq9sX2vKO8lUGUVc/gjm6S6Mvn6VVp/hq5Mr7+Usmb/OzsX8Hz0
 Uy4Y8Hv2dOGXXRD1u/I0Z3BQ34z8ynGmr5NvMjNn2z3CKOaz/SvpzZXuEamyhE6tabNE
 FUytLZmj6DaIoz1a+sLpDRaRFcg5n8uoeuV7rl60wJwHPjGZBXRITmNwLK5JHfLqS2Xp
 P5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586440; x=1716191240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eUEXDe4PCMsFe4DA4mYg1FIK58I7QokH1/RCklBXYEQ=;
 b=SQ8BrwCvaVzsk48BC/v4wvMZM42Sehv3dIB71zyYsFFXqjxVMoxfVia/9OOrGoB2Cx
 7YtcnDvSDk44o47uiv2R1aEdvtqC38CgyWTbY+BRgSmlKXUJ4AvssJEAFMVX0gIe1OE+
 FzD4eORECobxYjYX4rIRvbKTGeH5RLEnU9B5tPFtw2RdWcxGOHqC1F6rwfBoZ2+IAgu0
 suTcJPDMsb0M9rtK4wNrBHdW86/9Zsm5gYwdEBGGDnRWPd+C5WVGLcub2cntaEnkZ+kh
 j9Alnb5QabB+zdy/8A6rDGHAF1H4jC0arY6GVquiohIsVQKs/LwnSXWG4BEeOH4XY7en
 Bksg==
X-Gm-Message-State: AOJu0YzowRNdkh43BV/bzeR25XATJjUkDLn5eMQYavplp8bu2fzs5tUN
 TA5NmcKpiFrBAH6gmPZtVXzLkq5ae9bCjA2598nPAg2fFxjVb2R+laTDyK+SDdQBf7UcemN8EoW
 MqmI=
X-Google-Smtp-Source: AGHT+IEZLzEwwa9i3/2iW6KJtd9IJTESLn48CFGTWL22gABI2u1nauODrPeuy5s9SM91ITrdtUq9kg==
X-Received: by 2002:a05:600c:3c83:b0:41b:8041:53c2 with SMTP id
 5b1f17b1804b1-41feac51e04mr88420345e9.15.1715586439836; 
 Mon, 13 May 2024 00:47:19 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 01/45] target/hppa: Move cpu_get_tb_cpu_state out of line
Date: Mon, 13 May 2024 09:46:33 +0200
Message-Id: <20240513074717.130949-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h | 43 ++-----------------------------------------
 target/hppa/cpu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 41 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index fb2e4c4a98..61f1353133 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -314,47 +314,8 @@ hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr);
 #define TB_FLAG_PRIV_SHIFT  8
 #define TB_FLAG_UNALIGN     0x400
 
-static inline void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *pflags)
-{
-    uint32_t flags = env->psw_n * PSW_N;
-
-    /* TB lookup assumes that PC contains the complete virtual address.
-       If we leave space+offset separate, we'll get ITLB misses to an
-       incomplete virtual address.  This also means that we must separate
-       out current cpu privilege from the low bits of IAOQ_F.  */
-#ifdef CONFIG_USER_ONLY
-    *pc = env->iaoq_f & -4;
-    *cs_base = env->iaoq_b & -4;
-    flags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
-#else
-    /* ??? E, T, H, L, B bits need to be here, when implemented.  */
-    flags |= env->psw & (PSW_W | PSW_C | PSW_D | PSW_P);
-    flags |= (env->iaoq_f & 3) << TB_FLAG_PRIV_SHIFT;
-
-    *pc = hppa_form_gva_psw(env->psw, (env->psw & PSW_C ? env->iasq_f : 0),
-                            env->iaoq_f & -4);
-    *cs_base = env->iasq_f;
-
-    /* Insert a difference between IAOQ_B and IAOQ_F within the otherwise zero
-       low 32-bits of CS_BASE.  This will succeed for all direct branches,
-       which is the primary case we care about -- using goto_tb within a page.
-       Failure is indicated by a zero difference.  */
-    if (env->iasq_f == env->iasq_b) {
-        target_long diff = env->iaoq_b - env->iaoq_f;
-        if (diff == (int32_t)diff) {
-            *cs_base |= (uint32_t)diff;
-        }
-    }
-    if ((env->sr[4] == env->sr[5])
-        & (env->sr[4] == env->sr[6])
-        & (env->sr[4] == env->sr[7])) {
-        flags |= TB_FLAG_SR_SAME;
-    }
-#endif
-
-    *pflags = flags;
-}
+void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *pflags);
 
 target_ulong cpu_hppa_get_psw(CPUHPPAState *env);
 void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong);
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 393a81988d..582036b31e 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -43,6 +43,48 @@ static vaddr hppa_cpu_get_pc(CPUState *cs)
     return cpu->env.iaoq_f;
 }
 
+void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *pflags)
+{
+    uint32_t flags = env->psw_n * PSW_N;
+
+    /* TB lookup assumes that PC contains the complete virtual address.
+       If we leave space+offset separate, we'll get ITLB misses to an
+       incomplete virtual address.  This also means that we must separate
+       out current cpu privilege from the low bits of IAOQ_F.  */
+#ifdef CONFIG_USER_ONLY
+    *pc = env->iaoq_f & -4;
+    *cs_base = env->iaoq_b & -4;
+    flags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
+#else
+    /* ??? E, T, H, L, B bits need to be here, when implemented.  */
+    flags |= env->psw & (PSW_W | PSW_C | PSW_D | PSW_P);
+    flags |= (env->iaoq_f & 3) << TB_FLAG_PRIV_SHIFT;
+
+    *pc = hppa_form_gva_psw(env->psw, (env->psw & PSW_C ? env->iasq_f : 0),
+                            env->iaoq_f & -4);
+    *cs_base = env->iasq_f;
+
+    /* Insert a difference between IAOQ_B and IAOQ_F within the otherwise zero
+       low 32-bits of CS_BASE.  This will succeed for all direct branches,
+       which is the primary case we care about -- using goto_tb within a page.
+       Failure is indicated by a zero difference.  */
+    if (env->iasq_f == env->iasq_b) {
+        target_long diff = env->iaoq_b - env->iaoq_f;
+        if (diff == (int32_t)diff) {
+            *cs_base |= (uint32_t)diff;
+        }
+    }
+    if ((env->sr[4] == env->sr[5])
+        & (env->sr[4] == env->sr[6])
+        & (env->sr[4] == env->sr[7])) {
+        flags |= TB_FLAG_SR_SAME;
+    }
+#endif
+
+    *pflags = flags;
+}
+
 static void hppa_cpu_synchronize_from_tb(CPUState *cs,
                                          const TranslationBlock *tb)
 {
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A929C47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUoL-0005gX-R7; Mon, 29 Jan 2024 11:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUn5-00009p-3q
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:47:28 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUn1-0004Ay-2g
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:47:22 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e5afc18f5so34956315e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706546836; x=1707151636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a+WHgRt8aoFwU9PH4yyhsDxrOBo9TuwHJWddMcT5sv4=;
 b=PSiux/CnR2ucLc4rXWhKj7NH0VoLrYvuHpWajN4yWMJWzM0/IKYr2psYdM7V+1+5K8
 lF4GQzoSeXMJSLcALNb73RgtKH4BpD2DTmf7bcSaLSWjfUv+gPiPCaToqfHi+TRzPabb
 TrA8ZnObYxiG7L/GGW6Ux4rWg8h/4NHj/3f7W7R7IDuYSOZpTwN/SndwnHDuHFwPkTFe
 mGS8/LxWdsa7NzejwU2ZZYtZ4xz2znITLZIic7+TvJDt5VQA3QrGeZzwkI26DO8yrpjm
 XkZsl+s47tX8AoVhYQyCkmccZxkqVkYwTs9/SFaI+pMaJD21iGJChpsTX+sp5Kw8DXCG
 7luA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706546836; x=1707151636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a+WHgRt8aoFwU9PH4yyhsDxrOBo9TuwHJWddMcT5sv4=;
 b=Dc5eSotOxYpPCkcVRjGHvilcxbfP39WEx4LILieYLsXi7AmXFnSLgtn4ib3ku9BV4u
 Lm7Iy6Ob0fqiULX7ZHpS3iFNu7xab4wDduJkQZyt/xf1zDK/1+Td+/DYYkFf0uQ11mqG
 O/HpnDVI5h5ijKodn07FFgZTuqmhjt+n7vlgM0E8YELJkkdm77ff2T0io9jPhmRBLgso
 Ue5pUEdr4mKz9Px/9lLLxu8LeBWvFWdd2Bjokrrte4ufJ7TEhsE3w19Nm4zfUn1x1hkU
 cMVTEYPUaomN7+tUjr8N62pdGLdlYZMnverJdkIW66CLZ9NNTTVRXKPkGwNdI6W0NbOn
 nHKA==
X-Gm-Message-State: AOJu0Yz4t6+hE0zirrzeDOtOVOJKdn/SkM6Mw3LltlNX+0jVM6rqMtKM
 Dk+9GQyvJEy+IFhEKWrrGTe6t311eUmIFxr2x8HE/WXP4QYEvi+t57qpfsr8Fl9CU2UZreTYnp2
 a
X-Google-Smtp-Source: AGHT+IGYhnGe776oZg8Nf+XW6qyKWUfG5CSd+AahADH4rgW9WuZbEKC9nCTJSkL02Ck+OeTkF8tuTg==
X-Received: by 2002:a05:600c:4689:b0:40d:5575:a197 with SMTP id
 p9-20020a05600c468900b0040d5575a197mr5396356wmo.12.1706546836062; 
 Mon, 29 Jan 2024 08:47:16 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 l29-20020a05600c1d1d00b0040ef8aa4822sm2704220wms.38.2024.01.29.08.47.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 08:47:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>
Subject: [PATCH v3 19/29] target/nios2: Prefer fast cpu_env() over slower CPU
 QOM cast macro
Date: Mon, 29 Jan 2024 17:45:01 +0100
Message-ID: <20240129164514.73104-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129164514.73104-1-philmd@linaro.org>
References: <20240129164514.73104-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Mechanical patch produced running the command documented
in scripts/coccinelle/cpu_env.cocci_template header.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/nios2/cpu.c        | 15 +++------------
 target/nios2/helper.c     |  3 +--
 target/nios2/nios2-semi.c |  6 ++----
 target/nios2/translate.c  |  3 +--
 4 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index 09b122e24d..b5b3773fb8 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -28,28 +28,19 @@
 
 static void nios2_cpu_set_pc(CPUState *cs, vaddr value)
 {
-    Nios2CPU *cpu = NIOS2_CPU(cs);
-    CPUNios2State *env = &cpu->env;
-
-    env->pc = value;
+    cpu_env(cs)->pc = value;
 }
 
 static vaddr nios2_cpu_get_pc(CPUState *cs)
 {
-    Nios2CPU *cpu = NIOS2_CPU(cs);
-    CPUNios2State *env = &cpu->env;
-
-    return env->pc;
+    return cpu_env(cs)->pc;
 }
 
 static void nios2_restore_state_to_opc(CPUState *cs,
                                        const TranslationBlock *tb,
                                        const uint64_t *data)
 {
-    Nios2CPU *cpu = NIOS2_CPU(cs);
-    CPUNios2State *env = &cpu->env;
-
-    env->pc = data[0];
+    cpu_env(cs)->pc = data[0];
 }
 
 static bool nios2_cpu_has_work(CPUState *cs)
diff --git a/target/nios2/helper.c b/target/nios2/helper.c
index bb3b09e5a7..ac57121afc 100644
--- a/target/nios2/helper.c
+++ b/target/nios2/helper.c
@@ -287,8 +287,7 @@ void nios2_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                    MMUAccessType access_type,
                                    int mmu_idx, uintptr_t retaddr)
 {
-    Nios2CPU *cpu = NIOS2_CPU(cs);
-    CPUNios2State *env = &cpu->env;
+    CPUNios2State *env = cpu_env(cs);
 
     env->ctrl[CR_BADADDR] = addr;
     cs->exception_index = EXCP_UNALIGN;
diff --git a/target/nios2/nios2-semi.c b/target/nios2/nios2-semi.c
index 0b84fcb6b6..420702e293 100644
--- a/target/nios2/nios2-semi.c
+++ b/target/nios2/nios2-semi.c
@@ -75,8 +75,7 @@ static int host_to_gdb_errno(int err)
 
 static void nios2_semi_u32_cb(CPUState *cs, uint64_t ret, int err)
 {
-    Nios2CPU *cpu = NIOS2_CPU(cs);
-    CPUNios2State *env = &cpu->env;
+    CPUNios2State *env = cpu_env(cs);
     target_ulong args = env->regs[R_ARG1];
 
     if (put_user_u32(ret, args) ||
@@ -93,8 +92,7 @@ static void nios2_semi_u32_cb(CPUState *cs, uint64_t ret, int err)
 
 static void nios2_semi_u64_cb(CPUState *cs, uint64_t ret, int err)
 {
-    Nios2CPU *cpu = NIOS2_CPU(cs);
-    CPUNios2State *env = &cpu->env;
+    CPUNios2State *env = cpu_env(cs);
     target_ulong args = env->regs[R_ARG1];
 
     if (put_user_u32(ret >> 32, args) ||
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index e806623594..30beb303f9 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -970,7 +970,6 @@ static void nios2_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 static void nios2_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    CPUNios2State *env = cpu_env(cs);
     const Nios2Instruction *instr;
     uint32_t code, pc;
     uint8_t op;
@@ -980,7 +979,7 @@ static void nios2_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     dc->base.pc_next = pc + 4;
 
     /* Decode an instruction */
-    code = cpu_ldl_code(env, pc);
+    code = cpu_ldl_code(cpu_env(cs), pc);
     op = get_opcode(code);
 
     if (unlikely(op >= ARRAY_SIZE(i_type_instructions))) {
-- 
2.41.0



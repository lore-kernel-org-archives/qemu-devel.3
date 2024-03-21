Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1521FC54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 15:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnKgC-0006wv-5Y; Thu, 21 Mar 2024 11:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKg9-0006uB-E5
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:50:05 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKg5-0001WM-Io
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:50:04 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-414689ba80eso9363545e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 08:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711036200; x=1711641000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QNyIdceODiq/qXWOadWFMGnL31bcMZmdSI8jHE35wz0=;
 b=Smq9a7zfKTqK+KhZXshSHRabhcw0GtHOyVn4Z/GJUMC/E+Qckk4GtJ8g7cTvQXwmSI
 BxwLKPD5NDmBzCJgXgStUdjEM/UeWsT2jSwYHkXsMIeEYTnr9/tGvJqvLHZPIaWrlOQK
 twgLZAUbzroHkMLG+Qv6uwNV7q5AQL58sZ7OY8IHsNkpAIqujiiDaqkhIkI1Uyy4K8OO
 iZBAcJfQQspILjhhQr3bdG8/AegAxO5egpoxDlEP1kJBkNVzhZKlOspCWund8PBW+ZXT
 stTUpYc5usgkzAZW+Sfw9qodR56lqCHW0mMQgjHZKs12AQyCePnWL50KpRwSjFRD/+yS
 Ibsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711036200; x=1711641000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QNyIdceODiq/qXWOadWFMGnL31bcMZmdSI8jHE35wz0=;
 b=IrWLXTrECYDREiZWUG1phDpm0r1cvUGI0HnCPGrkWZXYmTfqnZV2APuk9BlJ2RzBtx
 FLILgTxqKsgE5vWVY+wauChFesihH+oTQBAEYF9ijTqVWEK0Xp8SGlwrgRbd6jU3n9pp
 PmHDJCD6TQOIBsb8YwdTkmSEt2UqCfBbqNxxs1xJmz304oqxgLOeLyYE9rxbe4M6HuB3
 v84fenbTkSxuM7mliCNo+zEd6hXMaVviipuuma3MmZlWI0fTs3YzAopij4fRow6FvGcm
 nCNVSitoVR/UUGD+4KHTNNwWG7RMsAjCO0v5f/BrfY4nch2Ayqwd9d7Z5kJw8c63cN8h
 jg1A==
X-Gm-Message-State: AOJu0YwXUVMPeCnHDf7l0eYNUrS8SJkHaFPfusEVbJj3VC9obpMjkfi7
 NOfTIW0CKaPBv5r1quFhFIQ2g0g6ILv9sLeLBkvRFpWkPCsKPnK02cAufFiT4Mqtp8c/FUKh0wh
 tn6Q=
X-Google-Smtp-Source: AGHT+IEMfDVBlpRWNTf5ioGsw32dNSEF5qiU+jNIsLxuEbzb2sWtRQFXvQmOZ7B5T6Oil1bdznnKXQ==
X-Received: by 2002:a05:600c:3b90:b0:413:2f8e:dd0b with SMTP id
 n16-20020a05600c3b9000b004132f8edd0bmr4127988wms.26.1711036199798; 
 Thu, 21 Mar 2024 08:49:59 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.222])
 by smtp.gmail.com with ESMTPSA id
 q18-20020adff792000000b0033ec9b26b7asm17495211wrp.25.2024.03.21.08.49.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 21 Mar 2024 08:49:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Chris Wulff <crwulff@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marek Vasut <marex@denx.de>, Max Filippov <jcmvbkbc@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 10/21] target/nios2: Prefix MMU API with 'nios2_'
Date: Thu, 21 Mar 2024 16:48:26 +0100
Message-ID: <20240321154838.95771-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240321154838.95771-1-philmd@linaro.org>
References: <20240321154838.95771-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Nios2 MMU API is exposed in "mmu.h". In order to avoid
name clashing with other targets, prefix the API with
'nios2_'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/nios2/mmu.h    | 11 +++++------
 target/nios2/cpu.c    |  2 +-
 target/nios2/helper.c |  4 ++--
 target/nios2/mmu.c    |  7 +++----
 4 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/target/nios2/mmu.h b/target/nios2/mmu.h
index 5b085900fb..5b16a5facf 100644
--- a/target/nios2/mmu.h
+++ b/target/nios2/mmu.h
@@ -42,11 +42,10 @@ typedef struct Nios2MMULookup {
     int prot;
 } Nios2MMULookup;
 
-void mmu_flip_um(CPUNios2State *env, unsigned int um);
-unsigned int mmu_translate(CPUNios2State *env,
-                           Nios2MMULookup *lu,
-                           target_ulong vaddr, int rw, int mmu_idx);
-void mmu_write(CPUNios2State *env, uint32_t rn, uint32_t v);
-void mmu_init(CPUNios2State *env);
+void nios2_mmu_flip_um(CPUNios2State *env, unsigned int um);
+unsigned int nios2_mmu_translate(CPUNios2State *env, Nios2MMULookup *lu,
+                                 target_ulong vaddr, int rw, int mmu_idx);
+void nios2_mmu_write(CPUNios2State *env, uint32_t rn, uint32_t v);
+void nios2_mmu_init(CPUNios2State *env);
 
 #endif /* NIOS2_MMU_H */
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index 679aff5730..d2a9a0d4f1 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -113,7 +113,7 @@ static void nios2_cpu_initfn(Object *obj)
 #if !defined(CONFIG_USER_ONLY)
     Nios2CPU *cpu = NIOS2_CPU(obj);
 
-    mmu_init(&cpu->env);
+    nios2_mmu_init(&cpu->env);
 #endif
 }
 
diff --git a/target/nios2/helper.c b/target/nios2/helper.c
index ac57121afc..2b6bdfbc55 100644
--- a/target/nios2/helper.c
+++ b/target/nios2/helper.c
@@ -268,7 +268,7 @@ hwaddr nios2_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     unsigned int hit;
 
     if (cpu->mmu_present && (addr < 0xC0000000)) {
-        hit = mmu_translate(env, &lu, addr, 0, 0);
+        hit = nios2_mmu_translate(env, &lu, addr, 0, 0);
         if (hit) {
             vaddr = addr & TARGET_PAGE_MASK;
             paddr = lu.paddr + vaddr - lu.vaddr;
@@ -335,7 +335,7 @@ bool nios2_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     }
 
     /* Virtual page.  */
-    hit = mmu_translate(env, &lu, address, access_type, mmu_idx);
+    hit = nios2_mmu_translate(env, &lu, address, access_type, mmu_idx);
     if (hit) {
         vaddr = address & TARGET_PAGE_MASK;
         paddr = lu.paddr + vaddr - lu.vaddr;
diff --git a/target/nios2/mmu.c b/target/nios2/mmu.c
index d9b690b78e..272bd9fc6a 100644
--- a/target/nios2/mmu.c
+++ b/target/nios2/mmu.c
@@ -28,9 +28,8 @@
 
 
 /* rw - 0 = read, 1 = write, 2 = fetch.  */
-unsigned int mmu_translate(CPUNios2State *env,
-                           Nios2MMULookup *lu,
-                           target_ulong vaddr, int rw, int mmu_idx)
+unsigned int nios2_mmu_translate(CPUNios2State *env, Nios2MMULookup *lu,
+                                 target_ulong vaddr, int rw, int mmu_idx)
 {
     Nios2CPU *cpu = env_archcpu(env);
     int pid = FIELD_EX32(env->mmu.tlbmisc_wr, CR_TLBMISC, PID);
@@ -180,7 +179,7 @@ void helper_mmu_write_pteaddr(CPUNios2State *env, uint32_t v)
     env->mmu.pteaddr_wr = v;
 }
 
-void mmu_init(CPUNios2State *env)
+void nios2_mmu_init(CPUNios2State *env)
 {
     Nios2CPU *cpu = env_archcpu(env);
     Nios2MMU *mmu = &env->mmu;
-- 
2.41.0



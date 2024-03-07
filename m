Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A77C54E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 18:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riISZ-0001Cr-BY; Thu, 07 Mar 2024 13:27:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1riISX-0001CJ-1C
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:27:13 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1riISU-0000bG-UZ
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:27:12 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dc96f64c10so9845585ad.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 10:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709836029; x=1710440829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HVPjMYWRfzew5Tu6uPDgk6Hue0SFV++AwAN6XVkbF9k=;
 b=qubZzwsmTsQO043NwHUNI/MPAjC2BBL/uPqZE1o11NcTQccaaNWXBfJ+kBfVzIjqnM
 3iExoA1/S+5SnDkAAbTrBIwr/zbFMuQc5rlwRZ91c+LIGJdMQGkLJcNwOxlbzYHRoLC4
 lwe6bppeSJqbiCs6Upq+9FqHyZ/yI9SLiveOoGuNokgjCaA5l20EPpKA/vxAWsr+X4XG
 ex+STI1t6xFmzSAcVqFfUMOx01lhOIFIwZr/MV/x0THpwXxDsI1JKpfmLieoAqUK6eb/
 CTxCjpOmK4IclAYGT1bPMNT+8G8yX2aa+3r5xTpKFJrvT6bS5ZbX19WTyavKN9HAUFj+
 m4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709836029; x=1710440829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HVPjMYWRfzew5Tu6uPDgk6Hue0SFV++AwAN6XVkbF9k=;
 b=U8EigriV3dq6a7nM/RLx+e1tL/ZtlHTLjDDJlm/3P/h14KLrfZ9YcEwyotFFTSSyIA
 cNCCkxKpMYpIYlKeTX5dmP5Kzg9rnubzW8DVo3ws+bgvFkqQF0ChGaReSUnvz2XyAbex
 gwf7yTLHlGGV6YxtEp1m/+1XROWpt1DlKlb9wVo7rRIdPSXLCZqjwlVeYUVTTkvKXRcd
 d9vIo9uexfI9Gy04RUE5nHpZsmNq0tqm645BtC9osGP3G35E1NSznWm/s+xtu6OUToRc
 JPjcE+jm9Nov8n0EQJmwKz725qkyjfsvnZn6oV5W6EWOteqy/Le1wNeQj2s5UNxIOBPh
 K3zg==
X-Gm-Message-State: AOJu0Yz5DmhVm+/hX4Rar69TQx8SA7IFhh5NgxFixUYTN4PypEUYtzlu
 6NT6FDv6w8VASdTyxkNa+4+cDBro56c3HjpFbgelj1aSCy0+HT8z+6tI+DYzOyr7mSWQQE0mQPU
 yNrQ=
X-Google-Smtp-Source: AGHT+IHujx2rukv7yHV773TBhD0IVe3papSh8rSBnJ2IezEi7goCqnyla238O+aiSZ7ErD8vtYrQ+g==
X-Received: by 2002:a17:902:cecb:b0:1db:ab9e:8f90 with SMTP id
 d11-20020a170902cecb00b001dbab9e8f90mr10411110plg.37.1709836028647; 
 Thu, 07 Mar 2024 10:27:08 -0800 (PST)
Received: from amd.. ([2804:7f0:b401:120f:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 mm12-20020a1709030a0c00b001dc96d1a662sm14939068plb.197.2024.03.07.10.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 10:27:08 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu,
 philmd@linaro.org, gustavo.romero@linaro.org
Subject: [PATCH v2 2/5] linux-user: Move tswap_siginfo out of target code
Date: Thu,  7 Mar 2024 18:26:20 +0000
Message-Id: <20240307182623.1450717-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307182623.1450717-1-gustavo.romero@linaro.org>
References: <20240307182623.1450717-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x632.google.com
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

Move tswap_siginfo from target code to handle_pending_signal. This will
allow some cleanups and having the siginfo ready to be used in gdbstub.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/signal.c     |  2 +-
 linux-user/alpha/signal.c       |  2 +-
 linux-user/arm/signal.c         |  2 +-
 linux-user/hexagon/signal.c     |  2 +-
 linux-user/hppa/signal.c        |  2 +-
 linux-user/i386/signal.c        |  6 +++---
 linux-user/loongarch64/signal.c |  2 +-
 linux-user/m68k/signal.c        |  4 ++--
 linux-user/microblaze/signal.c  |  2 +-
 linux-user/mips/signal.c        |  4 ++--
 linux-user/nios2/signal.c       |  2 +-
 linux-user/openrisc/signal.c    |  2 +-
 linux-user/ppc/signal.c         |  4 ++--
 linux-user/riscv/signal.c       |  2 +-
 linux-user/s390x/signal.c       |  2 +-
 linux-user/sh4/signal.c         |  2 +-
 linux-user/signal-common.h      |  2 --
 linux-user/signal.c             | 10 ++++++++--
 linux-user/sparc/signal.c       |  2 +-
 linux-user/xtensa/signal.c      |  2 +-
 20 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index a1e22d526d..bc7a13800d 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -670,7 +670,7 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
     aarch64_set_svcr(env, 0, R_SVCR_SM_MASK | R_SVCR_ZA_MASK);
 
     if (info) {
-        tswap_siginfo(&frame->info, info);
+        frame->info = *info;
         env->xregs[1] = frame_addr + offsetof(struct target_rt_sigframe, info);
         env->xregs[2] = frame_addr + offsetof(struct target_rt_sigframe, uc);
     }
diff --git a/linux-user/alpha/signal.c b/linux-user/alpha/signal.c
index 4ec42994d4..896c2c148a 100644
--- a/linux-user/alpha/signal.c
+++ b/linux-user/alpha/signal.c
@@ -173,7 +173,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
         goto give_sigsegv;
     }
 
-    tswap_siginfo(&frame->info, info);
+    frame->info = *info;
 
     __put_user(0, &frame->uc.tuc_flags);
     __put_user(0, &frame->uc.tuc_link);
diff --git a/linux-user/arm/signal.c b/linux-user/arm/signal.c
index f77f692c63..420fc04cfa 100644
--- a/linux-user/arm/signal.c
+++ b/linux-user/arm/signal.c
@@ -357,7 +357,7 @@ void setup_rt_frame(int usig, struct target_sigaction *ka,
 
     info_addr = frame_addr + offsetof(struct rt_sigframe, info);
     uc_addr = frame_addr + offsetof(struct rt_sigframe, sig.uc);
-    tswap_siginfo(&frame->info, info);
+    frame->info = *info;
 
     setup_sigframe(&frame->sig.uc, set, env);
 
diff --git a/linux-user/hexagon/signal.c b/linux-user/hexagon/signal.c
index 60fa7e1bce..492b51f155 100644
--- a/linux-user/hexagon/signal.c
+++ b/linux-user/hexagon/signal.c
@@ -162,7 +162,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     }
 
     setup_ucontext(&frame->uc, env, set);
-    tswap_siginfo(&frame->info, info);
+    frame->info = *info;
     /*
      * The on-stack signal trampoline is no longer executed;
      * however, the libgcc signal frame unwinding code checks
diff --git a/linux-user/hppa/signal.c b/linux-user/hppa/signal.c
index d08a97dae6..8960175da3 100644
--- a/linux-user/hppa/signal.c
+++ b/linux-user/hppa/signal.c
@@ -127,7 +127,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
         goto give_sigsegv;
     }
 
-    tswap_siginfo(&frame->info, info);
+    frame->info = *info;
     frame->uc.tuc_flags = 0;
     frame->uc.tuc_link = 0;
 
diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index bc5d45302e..cfe70fc5cf 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -430,7 +430,7 @@ void setup_frame(int sig, struct target_sigaction *ka,
     setup_sigcontext(&frame->sc, &frame->fpstate, env, set->sig[0],
             frame_addr + offsetof(struct sigframe, fpstate));
 
-    for(i = 1; i < TARGET_NSIG_WORDS; i++) {
+    for (i = 1; i < TARGET_NSIG_WORDS; i++) {
         __put_user(set->sig[i], &frame->extramask[i - 1]);
     }
 
@@ -490,7 +490,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     __put_user(addr, &frame->puc);
 #endif
     if (ka->sa_flags & TARGET_SA_SIGINFO) {
-        tswap_siginfo(&frame->info, info);
+        frame->info = *info;
     }
 
     /* Create the ucontext.  */
@@ -504,7 +504,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     setup_sigcontext(&frame->uc.tuc_mcontext, &frame->fpstate, env,
             set->sig[0], frame_addr + offsetof(struct rt_sigframe, fpstate));
 
-    for(i = 0; i < TARGET_NSIG_WORDS; i++) {
+    for (i = 0; i < TARGET_NSIG_WORDS; i++) {
         __put_user(set->sig[i], &frame->uc.tuc_sigmask.sig[i]);
     }
 
diff --git a/linux-user/loongarch64/signal.c b/linux-user/loongarch64/signal.c
index 39ea82c814..1a322f9697 100644
--- a/linux-user/loongarch64/signal.c
+++ b/linux-user/loongarch64/signal.c
@@ -376,7 +376,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
         extctx.end.haddr = (void *)frame + (extctx.end.gaddr - frame_addr);
     }
 
-    tswap_siginfo(&frame->rs_info, info);
+    frame->rs_info = *info;
 
     __put_user(0, &frame->rs_uc.tuc_flags);
     __put_user(0, &frame->rs_uc.tuc_link);
diff --git a/linux-user/m68k/signal.c b/linux-user/m68k/signal.c
index 5f35354487..77555781aa 100644
--- a/linux-user/m68k/signal.c
+++ b/linux-user/m68k/signal.c
@@ -295,7 +295,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     uc_addr = frame_addr + offsetof(struct target_rt_sigframe, uc);
     __put_user(uc_addr, &frame->puc);
 
-    tswap_siginfo(&frame->info, info);
+    frame->info = *info;
 
     /* Create the ucontext */
 
@@ -307,7 +307,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     if (err)
         goto give_sigsegv;
 
-    for(i = 0; i < TARGET_NSIG_WORDS; i++) {
+    for (i = 0; i < TARGET_NSIG_WORDS; i++) {
         __put_user(set->sig[i], &frame->uc.tuc_sigmask.sig[i]);
     }
 
diff --git a/linux-user/microblaze/signal.c b/linux-user/microblaze/signal.c
index 5188d74025..f6d47d76ff 100644
--- a/linux-user/microblaze/signal.c
+++ b/linux-user/microblaze/signal.c
@@ -147,7 +147,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
         return;
     }
 
-    tswap_siginfo(&frame->info, info);
+    frame->info = *info;
 
     __put_user(0, &frame->uc.tuc_flags);
     __put_user(0, &frame->uc.tuc_link);
diff --git a/linux-user/mips/signal.c b/linux-user/mips/signal.c
index 58a9d7a8a3..d69a5d73dd 100644
--- a/linux-user/mips/signal.c
+++ b/linux-user/mips/signal.c
@@ -303,7 +303,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
         goto give_sigsegv;
     }
 
-    tswap_siginfo(&frame->rs_info, info);
+    frame->rs_info = *info;
 
     __put_user(0, &frame->rs_uc.tuc_flags);
     __put_user(0, &frame->rs_uc.tuc_link);
@@ -311,7 +311,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
 
     setup_sigcontext(env, &frame->rs_uc.tuc_mcontext);
 
-    for(i = 0; i < TARGET_NSIG_WORDS; i++) {
+    for (i = 0; i < TARGET_NSIG_WORDS; i++) {
         __put_user(set->sig[i], &frame->rs_uc.tuc_sigmask.sig[i]);
     }
 
diff --git a/linux-user/nios2/signal.c b/linux-user/nios2/signal.c
index 32b3dc99c6..64c345f409 100644
--- a/linux-user/nios2/signal.c
+++ b/linux-user/nios2/signal.c
@@ -157,7 +157,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
         return;
     }
 
-    tswap_siginfo(&frame->info, info);
+    frame->info = *info;
 
     /* Create the ucontext.  */
     __put_user(0, &frame->uc.tuc_flags);
diff --git a/linux-user/openrisc/signal.c b/linux-user/openrisc/signal.c
index be8b68784a..cb74a9fe5e 100644
--- a/linux-user/openrisc/signal.c
+++ b/linux-user/openrisc/signal.c
@@ -103,7 +103,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     }
 
     if (ka->sa_flags & SA_SIGINFO) {
-        tswap_siginfo(&frame->info, info);
+        frame->info = *info;
     }
 
     __put_user(0, &frame->uc.tuc_flags);
diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
index 7e7302823b..0ebfc0b26b 100644
--- a/linux-user/ppc/signal.c
+++ b/linux-user/ppc/signal.c
@@ -493,7 +493,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     if (!lock_user_struct(VERIFY_WRITE, rt_sf, rt_sf_addr, 1))
         goto sigsegv;
 
-    tswap_siginfo(&rt_sf->info, info);
+    rt_sf->info = *info;
 
     __put_user(0, &rt_sf->uc.tuc_flags);
     __put_user(0, &rt_sf->uc.tuc_link);
@@ -502,7 +502,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     __put_user(h2g (&rt_sf->uc.tuc_mcontext),
                &rt_sf->uc.tuc_regs);
 #endif
-    for(i = 0; i < TARGET_NSIG_WORDS; i++) {
+    for (i = 0; i < TARGET_NSIG_WORDS; i++) {
         __put_user(set->sig[i], &rt_sf->uc.tuc_sigmask.sig[i]);
     }
 
diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
index 941eadce87..358fa1d82d 100644
--- a/linux-user/riscv/signal.c
+++ b/linux-user/riscv/signal.c
@@ -125,7 +125,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     }
 
     setup_ucontext(&frame->uc, env, set);
-    tswap_siginfo(&frame->info, info);
+    frame->info = *info;
 
     env->pc = ka->_sa_handler;
     env->gpr[xSP] = frame_addr;
diff --git a/linux-user/s390x/signal.c b/linux-user/s390x/signal.c
index b40f738a70..df49c24708 100644
--- a/linux-user/s390x/signal.c
+++ b/linux-user/s390x/signal.c
@@ -267,7 +267,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     }
 
     /* Create siginfo on the signal stack. */
-    tswap_siginfo(&frame->info, info);
+    frame->info = *info;
 
     /* Create ucontext on the signal stack. */
     uc_flags = 0;
diff --git a/linux-user/sh4/signal.c b/linux-user/sh4/signal.c
index c16c2c2d57..9ecc026fae 100644
--- a/linux-user/sh4/signal.c
+++ b/linux-user/sh4/signal.c
@@ -233,7 +233,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
         goto give_sigsegv;
     }
 
-    tswap_siginfo(&frame->info, info);
+    frame->info = *info;
 
     /* Create the ucontext.  */
     __put_user(0, &frame->uc.tuc_flags);
diff --git a/linux-user/signal-common.h b/linux-user/signal-common.h
index 3e2dc604c2..f02d2b6b64 100644
--- a/linux-user/signal-common.h
+++ b/linux-user/signal-common.h
@@ -43,8 +43,6 @@ void host_to_target_sigset_internal(target_sigset_t *d,
                                     const sigset_t *s);
 void target_to_host_sigset_internal(sigset_t *d,
                                     const target_sigset_t *s);
-void tswap_siginfo(target_siginfo_t *tinfo,
-                   const target_siginfo_t *info);
 void set_sigmask(const sigset_t *set);
 void force_sig(int sig);
 void force_sigsegv(int oldsig);
diff --git a/linux-user/signal.c b/linux-user/signal.c
index a57c45de35..7a4c8e416e 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -409,8 +409,8 @@ static inline void host_to_target_siginfo_noswap(target_siginfo_t *tinfo,
     tinfo->si_code = deposit32(si_code, 16, 16, si_type);
 }
 
-void tswap_siginfo(target_siginfo_t *tinfo,
-                   const target_siginfo_t *info)
+static void tswap_siginfo(target_siginfo_t *tinfo,
+                          const target_siginfo_t *info)
 {
     int si_type = extract32(info->si_code, 16, 16);
     int si_code = sextract32(info->si_code, 0, 16);
@@ -1180,6 +1180,12 @@ static void handle_pending_signal(CPUArchState *cpu_env, int sig,
     /* dequeue signal */
     k->pending = 0;
 
+    /*
+     * Writes out siginfo values byteswapped, accordingly to the target. It also
+     * cleans the si_type from si_code making it correct for the target.
+     */
+    tswap_siginfo(&k->info, &k->info);
+
     sig = gdb_handlesig(cpu, sig, NULL);
     if (!sig) {
         sa = NULL;
diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index c2dc1000e2..f164b74032 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -333,7 +333,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
 
     __put_user(0, &sf->rwin_save);  /* TODO: save_rwin_state */
 
-    tswap_siginfo(&sf->info, info);
+    sf->info = *info;
     tswap_sigset(&sf->mask, set);
     target_save_altstack(&sf->stack, env);
 
diff --git a/linux-user/xtensa/signal.c b/linux-user/xtensa/signal.c
index 32dcfa5229..11e60c3c82 100644
--- a/linux-user/xtensa/signal.c
+++ b/linux-user/xtensa/signal.c
@@ -184,7 +184,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     }
 
     if (ka->sa_flags & SA_SIGINFO) {
-        tswap_siginfo(&frame->info, info);
+        frame->info = *info;
     }
 
     __put_user(0, &frame->uc.tuc_flags);
-- 
2.34.1



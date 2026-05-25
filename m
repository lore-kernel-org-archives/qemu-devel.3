Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0A0CD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRXAR-00059V-On; Mon, 25 May 2026 11:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRXAQ-00058o-DH
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:24:34 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRXAO-0005E9-Oz
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:24:34 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-7c58e6eb3edso89447967b3.2
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779722671; x=1780327471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ksOvl/ewr6dXPnhJyxWvDLQ6m0eOKL1ME5QF1eL20+A=;
 b=Vq2n1ih/IJhLUvOpJAKWTIM5fr2ZlPMNqIGzRetO/SGhGfJGF4/Xlh+xysm4S49sCl
 sHx1FoDLNenNki1Eq/VqWKXnwc8wfC60zRco1jkRL5LS7Y8WR3yO5a/K7zOX9qDAatjU
 ORmfTHPyY2XvqZalSuZRTHK3YkvQJVhliyH7bYzni8NsJPV/6Y2wjjhs3DFaQ6t1bVcf
 DNP/HFdHIz+cITJ7CWtQj1AuQqujkirDeCvwhFitOO+isN/yNePCerHdHeJU39B5bcD4
 EQHjw+/Wv8p0XxDmtm+6comGrPCqI0K0pcYnB+sZ3hXQHssT1hNn6SYYyeXk4RQqhz1h
 ovwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722671; x=1780327471;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ksOvl/ewr6dXPnhJyxWvDLQ6m0eOKL1ME5QF1eL20+A=;
 b=SQ+8fy8cnfK6Q/lNhwkWjJ+3x9rHU8VRMMnKnkQi1hN/5FAcy9tvwpKcqbexv+6EoM
 4qECCSE+L7o8a6vJ3vzJhI7HDhnZqffVnzxNTxLg4Bfio68fvP7glKeMknH42xOIaFrG
 M0KXluXyw5LACKawgMnLJq+0uuVIIXKaPALXMCxxNTmcSp7BELq1eavDv2JiAKtPycz8
 kZWIFqAIkO27Xpbte+IhDeTWgjrz3aM9S7qrb+Ty8bKPKmhNN286H3MEaJBFfYKJRxBq
 6OG3CoC71Ppv8st4hn0E8A9FNCMvXF54M/TfY2KvxLkGHVE+09g0PPi/T0qslUEqm5XS
 F5ag==
X-Gm-Message-State: AOJu0Ywo8r2JBzFjbsZf3bC09KCKqSVTTlRfos6NcDNH623jE2yHBeqL
 WR1vPE/Jo50hIRbhHDv6dFtTRcoyNLX7AR0Ldr1gQpEa1TU3Cj35/ssMLhkrla9w
X-Gm-Gg: Acq92OElgZd8L/k2mHNiOl9FQvaOhLq5pSNX2xE90QGypkU1lYOdvXOn+4uZ1m/rjPh
 GFkrqtNPTgCNHrSVCFwNgkpoeSwD6/JiJJHshO1qXwEX32E/8sQ7wR5WOMm0qs/YHvEPrxD1nRz
 JNGBEUePo7X0pwtjG53pMgEjanF2m+HlBYH43kCWYg1dL4hNTsYxwTOLMP0v40L4CT5x2Wwq1Wa
 961daL2ktJ2I/HYDkrzF2H3w1GsknY/Yfc5ougtgeOvuPt2dqNdHNMpiFWPJRi3gt/r7SzNUJJs
 mwf8itDGlVus82MMxHuPbJn16EfaTtwuWxfmDo5/x7cW4QJc56CnSuFU2jN0vwjd8Li/SAoyFKq
 t+qmnRJ5LaWcghXNSjpVjd5G82tgpms1z3PP+B/SFhFImnr9LWllXrbVPr6SGOTKAAKyaXYxcZQ
 WSXSvMaHYVMGGYy9GGL5debJMFyzzxDfy1ZJZFfw9WA9X1ulqttlRs/X3F9JdHpYB+4rnwXMHx3
 CU=
X-Received: by 2002:a05:690c:c22e:b0:7bd:a50c:454d with SMTP id
 00721157ae682-7d33868107fmr171135817b3.13.1779722671502; 
 Mon, 25 May 2026 08:24:31 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7d38be313c9sm47545467b3.30.2026.05.25.08.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 08:24:30 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Matt Turner <mattst88@gmail.com>,
 qemu-stable@nongnu.org
Subject: [PATCH] linux-user/mips: save/restore FCSR across signal delivery
Date: Mon, 25 May 2026 11:24:27 -0400
Message-ID: <20260525152427.4120785-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x1130.google.com
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

QEMU keeps the MIPS FPU control/status register (FCSR, fcr31) in
env->active_fpu.fcr31.  The rounding mode, flush-to-zero (FS), and
NaN-2008 mode bits in fcr31 are reflected into the derived
env->active_fpu.fp_status via set_float_rounding_mode() and friends;
every architectural write to FCSR goes through helper_ctc1() which
calls restore_fp_status() to keep the two in sync.

Both target_sigcontext variants (O32 and N32/N64) have an sc_fpc_csr
field that holds FCSR, but setup_sigcontext() never wrote it and
restore_sigcontext() never read it.  As a result:

  - The signal frame always delivered sc_fpc_csr == 0 to the handler,
    so sigaction(SA_SIGINFO) handlers that inspect the interrupted
    context see the wrong FCSR.

  - On sigreturn, active_fpu.fcr31 retained whatever value the signal
    handler last installed (if any), and active_fpu.fp_status was
    never resynced.  Interrupted code resumed with the wrong rounding
    mode, FS flag, and NaN-2008 semantics.

Fix setup_sigcontext() to save fcr31 into sc_fpc_csr.  Fix
restore_sigcontext() to read it back (masked to fcr31_rw_bitmask as
the kernel does) and call cpu_mips_restore_fp_status() to resync
fp_status from the restored fcr31.

Add cpu_mips_restore_fp_status() in target/mips/fpu.c (which already
defines ieee_rm and includes fpu_helper.h), and declare it in cpu.h.

Fixes: 084d0497a0 ("mips-linux-user: Save and restore fpu and dsp from sigcontext")
Cc: qemu-stable@nongnu.org
---
 linux-user/mips/signal.c | 7 +++++++
 target/mips/cpu.h        | 3 +++
 target/mips/fpu.c        | 5 +++++
 3 files changed, 15 insertions(+)

diff --git ./linux-user/mips/signal.c ./linux-user/mips/signal.c
index d69a5d73dd..1b10012726 100644
--- ./linux-user/mips/signal.c
+++ ./linux-user/mips/signal.c
@@ -134,6 +134,7 @@ static inline void setup_sigcontext(CPUMIPSState *regs,
     for (i = 0; i < 32; ++i) {
         __put_user(regs->active_fpu.fpr[i].d, &sc->sc_fpregs[i]);
     }
+    __put_user(regs->active_fpu.fcr31, &sc->sc_fpc_csr);
 }
 
 static inline void
@@ -165,6 +166,12 @@ restore_sigcontext(CPUMIPSState *regs, struct target_sigcontext *sc)
     for (i = 0; i < 32; ++i) {
         __get_user(regs->active_fpu.fpr[i].d, &sc->sc_fpregs[i]);
     }
+    {
+        uint32_t fcr31;
+        __get_user(fcr31, &sc->sc_fpc_csr);
+        regs->active_fpu.fcr31 = fcr31 & regs->active_fpu.fcr31_rw_bitmask;
+        cpu_mips_restore_fp_status(regs);
+    }
 }
 
 /*
diff --git ./target/mips/cpu.h ./target/mips/cpu.h
index 346713705a..392406aff8 100644
--- ./target/mips/cpu.h
+++ ./target/mips/cpu.h
@@ -1384,6 +1384,9 @@ void cpu_mips_clock_init(MIPSCPU *cpu);
 /* helper.c */
 target_ulong exception_resume_pc(CPUMIPSState *env);
 
+/* fpu.c */
+void cpu_mips_restore_fp_status(CPUMIPSState *env);
+
 /**
  * mips_cpu_create_with_clock:
  * @typename: a MIPS CPU type.
diff --git ./target/mips/fpu.c ./target/mips/fpu.c
index c7c487c1f9..8b661865ca 100644
--- ./target/mips/fpu.c
+++ ./target/mips/fpu.c
@@ -17,6 +17,11 @@ const FloatRoundMode ieee_rm[4] = {
     float_round_down
 };
 
+void cpu_mips_restore_fp_status(CPUMIPSState *env)
+{
+    restore_fp_status(env);
+}
+
 const char fregnames[32][4] = {
     "f0",  "f1",  "f2",  "f3",  "f4",  "f5",  "f6",  "f7",
     "f8",  "f9",  "f10", "f11", "f12", "f13", "f14", "f15",
-- 
2.53.0



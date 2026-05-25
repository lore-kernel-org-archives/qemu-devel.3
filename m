Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B96CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRXCi-00060m-NQ; Mon, 25 May 2026 11:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRXCh-000605-Aa
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:26:55 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRXCf-00073l-ND
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:26:55 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-7c58e6eb3edso89464167b3.2
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779722812; x=1780327612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K6xC6HwAyIDIIh2a629TrTPE4Vd7Vo8E6LwxOtnWSDs=;
 b=hRhbzyswFx+AZ64l5h5l1wUxyqGq6bEl5lNsX+L2zatYmcZ6RJ9edYMR1WyTEewK6r
 bXPOuA9+RE4CCH0uyzGBpip7YtNv1wmDnKOJehxyBkG/+aR+QV2iDyAuGi0NHgl2a5zG
 KQq56bno2IT2n8LHrwYqKjPhS7iZDmCfrjnybLE9CZVixty7RcNDXVpJRLI2lQ7IDMbn
 cOK1s4hYap4Ur9wj/jkC+H0i/zbjwR8H3HC1S2rU7GxCNgbwQxXqEsmp/lgjW4MCN7Dj
 HqJiewviHmHQvlBrRicKu91hGyQki62DCIdyDdzQyVJ5WHIgYotTxeixJd5lQknDOjN5
 2Q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722812; x=1780327612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K6xC6HwAyIDIIh2a629TrTPE4Vd7Vo8E6LwxOtnWSDs=;
 b=indcajamfEHmxhlVGa6lbSGXoZkV59qDRwRyqb8IqmHCURVoAtZRJcqJCFDPb+QVzg
 WUAZJRnSH1hQMlDcJkIW4b8s1qktMrD3HGcWYAv5DXXAXDaxVTJND9q2PoK4PMLHAfaZ
 PlxRcGQXTYzOYZl29xfqlduP0KtNqEy55jTPs5KhCv2jQ0ov+zNtOmmaFBfw0zOM4bK7
 iLHIIoZYt84kU0hGLRMJo1tGbfs2b3emZ1Hd6ZDlflwr0IN/13DkK3pm2uYNuWCFi0EL
 mE/5vuPEee+JU9UMMB5zFQ0wORBDLbPCL4pN/RmQs12tKsf1hA3aEhvX3qtXy3tUOTLm
 l8dQ==
X-Gm-Message-State: AOJu0YxYhnmk+QdC2XCvKEomBhcJLfS9u7CDO+Cv3cNwi/6mFX5Rxhmc
 P4XzGHIBOex7KsJOnBJKRpXlClPXDb8QujXjCkqQJ5+eiwVXpxafMcahqSz3pYMN
X-Gm-Gg: Acq92OGuVP/oPVrBHT5Mn4nxtB0lrCDN85jt8PE1ssVUohorQ1NLgSjhHqj491iWTds
 Ts1x58kEiUk/agsMObKGMjMjtE4ZH9tHNtWyupdSmflHbZD3Duv2SpuGiifLSkgLePHvMGt7rY5
 escBt3muwPaqMFsDZyyB1Q/72tsF5XXAXRAHAPnNqFgtYlwPo3JkQBfBM1ZMiTQ3QddQGX0IilK
 KxmpbHCWso1jqFta6A92dlmvn3RXW9a7pVP9IFcaEPgcWfc/TZSdDA5AJMGobRPCDEJG9Lt6PlU
 W9kgGNp0HHsd/SBNl6M0cnRoVsemiwQ0bcc8PnIxqKxAaLnY7V9PCgjK6nYBGSv8QTGyWQTf1KU
 n7vCcLoHG6C4qrAQjDCqVXZO74EDGY5o/0BzcadYjLgZFEcZ69t1ceFVtueH0RaQ0us5Gk+rUdy
 d14/msk5dvJdhQ2XrJRci3Kfd/T9orOv5gS/8osRB18U3upYfcx7xi/FXqKsmAkmtY7dstaxhC2
 DhRWzstR9YlFg==
X-Received: by 2002:a05:690c:d83:b0:7ba:f3a2:553c with SMTP id
 00721157ae682-7d338496637mr167966727b3.11.1779722812516; 
 Mon, 25 May 2026 08:26:52 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7d389d176a9sm47832897b3.16.2026.05.25.08.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 08:26:51 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, qemu-stable@nongnu.org
Subject: [PATCH 2/3] linux-user/sh4: restore FP rounding mode on sigreturn
Date: Mon, 25 May 2026 11:26:41 -0400
Message-ID: <20260525152642.4121729-2-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260525152642.4121729-1-mattst88@gmail.com>
References: <20260525152642.4121729-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x1134.google.com
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

The SH4 FPSCR rounding-mode (RM) and denormal (DN) bits are not held
only in env->fpscr: they are also reflected into the derived
env->fp_status via set_float_rounding_mode()/set_flush_to_zero(). The
guest keeps the two in sync by routing every write to FPSCR through
helper_ld_fpscr().

restore_sigcontext() wrote the saved value straight into env->fpscr and
never touched env->fp_status, so on sigreturn the interrupted code
resumed with whatever FP rounding mode and flush-to-zero setting the
signal handler last installed. (regs->flags = 0 forces the FR/SZ/PR TB
flags to be recomputed, but fp_status is runtime float state, not a TB
flag, so it was left stale.) This is the FP analogue of the T/M/Q bit
problem just fixed for the integer status register.

Factor the FPSCR -> fp_status synchronisation out of helper_ld_fpscr()
into cpu_load_fpscr() and use it from restore_sigcontext() so the
rounding mode round-trips correctly across signal delivery.

Fixes: c3b5bc8ab3 ("SH4: Signal handling for the user space emulator, by Magnus Damm.")
Cc: qemu-stable@nongnu.org
---
 linux-user/sh4/signal.c | 7 ++++++-
 target/sh4/cpu.h        | 3 +++
 target/sh4/op_helper.c  | 7 ++++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git ./linux-user/sh4/signal.c ./linux-user/sh4/signal.c
index cc36425c49..00290d6e40 100644
--- ./linux-user/sh4/signal.c
+++ ./linux-user/sh4/signal.c
@@ -173,7 +173,12 @@ static void restore_sigcontext(CPUSH4State *regs, struct target_sigcontext *sc)
     for (i=0; i<16; i++) {
         __get_user(regs->fregs[i], &sc->sc_fpregs[i]);
     }
-    __get_user(regs->fpscr, &sc->sc_fpscr);
+    /* Resync the derived float_status state, not just env->fpscr. */
+    {
+        uint32_t fpscr;
+        __get_user(fpscr, &sc->sc_fpscr);
+        cpu_load_fpscr(regs, fpscr);
+    }
     __get_user(regs->fpul, &sc->sc_fpul);
 
     regs->tra = -1;         /* disable syscall checks */
diff --git ./target/sh4/cpu.h ./target/sh4/cpu.h
index 4b0f3f6d97..3302702376 100644
--- ./target/sh4/cpu.h
+++ ./target/sh4/cpu.h
@@ -379,4 +379,7 @@ static inline void cpu_write_sr(CPUSH4State *env, uint32_t sr)
     env->sr = sr & ~((1u << SR_M) | (1u << SR_Q) | (1u << SR_T));
 }
 
+/* Set FPSCR and the derived float_status rounding/flush-to-zero state. */
+void cpu_load_fpscr(CPUSH4State *env, uint32_t val);
+
 #endif /* SH4_CPU_H */
diff --git ./target/sh4/op_helper.c ./target/sh4/op_helper.c
index 669bc84cb6..cf0f80e4a5 100644
--- ./target/sh4/op_helper.c
+++ ./target/sh4/op_helper.c
@@ -204,7 +204,7 @@ void helper_macw(CPUSH4State *env, int32_t arg0, int32_t arg1)
     }
 }
 
-void helper_ld_fpscr(CPUSH4State *env, uint32_t val)
+void cpu_load_fpscr(CPUSH4State *env, uint32_t val)
 {
     env->fpscr = val & FPSCR_MASK;
     if ((val & FPSCR_RM_MASK) == FPSCR_RM_ZERO) {
@@ -215,6 +215,11 @@ void helper_ld_fpscr(CPUSH4State *env, uint32_t val)
     set_flush_to_zero((val & FPSCR_DN) != 0, &env->fp_status);
 }
 
+void helper_ld_fpscr(CPUSH4State *env, uint32_t val)
+{
+    cpu_load_fpscr(env, val);
+}
+
 static void update_fpscr(CPUSH4State *env, uintptr_t retaddr)
 {
     int xcpt, cause, enable;
-- 
2.53.0



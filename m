Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C79CD4851
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 16:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNZLs-0006pw-1U; Thu, 14 May 2026 12:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wNZLp-0006pR-MP
 for qemu-devel@nongnu.org; Thu, 14 May 2026 12:55:57 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wNZLn-0007B3-0U
 for qemu-devel@nongnu.org; Thu, 14 May 2026 12:55:57 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-65c7a459105so124023d50.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 09:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778777750; x=1779382550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GsP87cs4NWxbyyO8qtTk1YKVnT6FLk6X0KZveHRD3fs=;
 b=EBhwdy3iD3lRFzq+EZ2ZJ8H3WYGdE/BrZByPclEhR6F+BxrUK+rxBGM+unSpTbNbS9
 yHVC08i3c89UjnokDigCUVv6m6LTcV1W/4deW/fNqJl/jxJyDjmbievGsKLXuv7v8I6R
 xAluoovbmM7WMVVJXI6FZq4eQlf4JyeWJ8A3fJsujmAUqXEWZLP0r14smfxMAuEMPDEp
 4TPfBPYjZLJKxHI42GwNJBBrTvqX41dtIV34/Z82WbseAGtLP+xf2+ke33OPUkg1dOCe
 N6cKbJCCZGu4waItMqFUUWMQSdHtjw4JVP3ZFQGIVs06t4UnY0vAfmrdMJhq62zgVQYN
 YDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778777750; x=1779382550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GsP87cs4NWxbyyO8qtTk1YKVnT6FLk6X0KZveHRD3fs=;
 b=HEq5RKMJfpFwPFqm6DYYda3ctyIrlKxyuvFwTHW7Ik0qDuwkXzb9m4h8pMxAmJXCAt
 a7N25Ad03qt1SKVKak+5Qbd68qntXn9JRed08GgSgOq2cqubZACx9OuV87vZkG6XYMv8
 q1FLWquXs2UwWC8Q0Jb7NinqP54ewZPKBlhzPjlB4JJ5+V3LMXtHCz5gJ9w7tWbAobSM
 Nf99LSPMYpT4xNzv2w5ZorNF60wqZAoTLeSsrNAaYq1g9GkZhA0vfRJD8rA8Dd37i8kR
 kjUCEpQqshSL860DT4kFK9cl2AFgiAdmfVspZuoH5lRD7Lgb70MX/e+BnAsfB9uf5tgT
 a4SA==
X-Gm-Message-State: AOJu0YxAE+qvcohuOLB7MPBjBi+4ICqbREQCbbNOCi1Qe9BaVqmgJ9Uu
 78cvC3VzVRwKv7ixFpBLH6DwKlTzTx2S1zCazOITLqnXKQYN6y4otxjq3ro6+dPY
X-Gm-Gg: Acq92OEE8/AncrDuQrCN7w80VI3NfGYrFqbWgRdNCeBFpzwN+Qnbx69p/XGx2YIxv/0
 mRZOx8J56qv/r1wRr4NHETW4XN9FI2tOWTwbIvm/9NZGEvrzvcA0Os5V0l20i520pDmTPvPP6iq
 KyYZDhnXN7KgFMxqHPPZefMOD5fynjyyoKvRdPmlXBnfxaZfS9W5VO/KuE7KDYiiTKg3pVbrjCR
 nYkz1W0Qt5HOD/qV2iw+iUP/BK6Yyi8H/qyTZEaMpEWnfUBqFdvHYGFmax945tsM6UFyzYYKy6a
 ql6F7SHqg7BmDpEdKjjwT3z9GiZFoiYp08Y02pfE2bPXHPSUFJtbgNzEhOKB50BY0YfIH17ZwJP
 tnPxVgUAIK8wWZRaYKobz5hDUmLUf9ghqZo6FAScLKAClX9cP8JWYXH6G7VvU0DKJEA9Dk6NPQi
 7h71JHH5issxj0+F1vaVNyCuG/2qMbm6kPYYvMQVtB6dOcT1yy0/Hh9LLN6sGxL6rxDHGAkwXWH
 V5UrRDSzlrSMw==
X-Received: by 2002:a05:690e:134a:b0:65c:4a37:3975 with SMTP id
 956f58d0204a3-65e0a9ccc81mr3818422d50.0.1778777749504; 
 Thu, 14 May 2026 09:55:49 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with UTF8SMTPSA id
 956f58d0204a3-65e0db6f4f4sm1336480d50.15.2026.05.14.09.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 09:55:48 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Turner <mattst88@gmail.com>, qemu-stable@nongnu.org
Subject: [PATCH 2/2] linux-user/sh4: Fix setup_sigtramp to match Linux kernel
 trampoline pattern
Date: Thu, 14 May 2026 12:55:26 -0400
Message-ID: <20260514165526.1530386-2-mattst88@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260514165526.1530386-1-mattst88@gmail.com>
References: <20260514165526.1530386-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb136.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

QEMU used MOVW(2) (0x9300), which loads the syscall number from PC+4,
instead of the kernel's MOVW(7) (0x9305), which loads from PC+14.  The
kernel uses five "or r0,r0" nop pads between TRAP_NOARG and the syscall
number word to reach that offset.  libunwind's unw_is_signal_frame checks
for the exact kernel byte pattern 0xc3109305 at the frame PC, so QEMU's
compact layout was not detected, breaking unwinding through signal frames.

Expand each trampoline from 6 to 16 bytes matching the kernel layout
defined in arch/sh/kernel/signal_32.c:

  #define MOVW(n)    (0x9300|((n)-2))  /* Move mem word at PC+n to R3 */
  #define TRAP_NOARG 0xc310            /* Syscall w/no args (NR in R3) */
  #define OR_R0_R0   0x200b            /* or r0,r0 (insert to avoid hardware bug) */

  __put_user(MOVW(7),          &frame->retcode[0]);  /* 0x9305 */
  __put_user(TRAP_NOARG,       &frame->retcode[1]);  /* 0xc310 */
  __put_user(OR_R0_R0,         &frame->retcode[2]);  /* 0x200b */
  __put_user(OR_R0_R0,         &frame->retcode[3]);  /* 0x200b */
  __put_user(OR_R0_R0,         &frame->retcode[4]);  /* 0x200b */
  __put_user(OR_R0_R0,         &frame->retcode[5]);  /* 0x200b */
  __put_user(OR_R0_R0,         &frame->retcode[6]);  /* 0x200b */
  __put_user((__NR_sigreturn), &frame->retcode[7]);

The first two halfwords (MOVW(7) || TRAP_NOARG = 0xc3109305) form the
32-bit value libunwind checks at the frame PC, followed by two
OR_R0_R0 halfwords (0x200b200b) at PC+4.  The same layout applies to
the rt_sigreturn trampoline (lines 366-373 of signal_32.c).

Neither this fix nor the companion tuc_link fix is independently
sufficient: this fix makes signal frames detectable but register reads
remain garbage without the correct ucontext layout; that fix corrects the
ucontext layout but libunwind still cannot detect the frame without the
correct trampoline pattern.  Together they fix the following libunwind
tests on a 64-bit host:
  Gtest-sig-context, Gtest-trace, Ltest-init-local-signal,
  Ltest-sig-context, Ltest-trace

Signed-off-by: Matt Turner <mattst88@gmail.com>
Cc: qemu-stable@nongnu.org
---
 linux-user/sh4/signal.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git ./linux-user/sh4/signal.c ./linux-user/sh4/signal.c
index 20d2bc8b2c..d70be24c38 100644
--- ./linux-user/sh4/signal.c
+++ ./linux-user/sh4/signal.c
@@ -329,20 +329,42 @@ badframe:
     return -QEMU_ESIGRETURN;
 }
 
+/*
+ * "or r0,r0" nop used by the Linux kernel inline sigreturn trampolines to
+ * avoid a hardware bug (OR_R0_R0 in arch/sh/kernel/signal_32.c).  Five of
+ * these nops follow TRAP_NOARG, placing the syscall number word 14 bytes
+ * past the MOVW(7) instruction (at MOVW(7)'s load offset).  This yields the
+ * fixed 16-byte layout that libunwind's unw_is_signal_frame detects:
+ *   [MOVW(7), TRAP_NOARG, 5x NOP_OR, .word syscall_nr]
+ */
+#define NOP_OR 0x200b
+
 void setup_sigtramp(abi_ulong sigtramp_page)
 {
-    uint16_t *tramp = lock_user(VERIFY_WRITE, sigtramp_page, 2 * 6, 0);
+    uint16_t *tramp = lock_user(VERIFY_WRITE, sigtramp_page, 2 * 16, 0);
     assert(tramp != NULL);
 
+    /* sigreturn trampoline (non-RT) at offset 0 */
     default_sigreturn = sigtramp_page;
-    __put_user(MOVW(2), &tramp[0]);
+    __put_user(MOVW(7), &tramp[0]);
     __put_user(TRAP_NOARG, &tramp[1]);
-    __put_user(TARGET_NR_sigreturn, &tramp[2]);
+    __put_user(NOP_OR, &tramp[2]);
+    __put_user(NOP_OR, &tramp[3]);
+    __put_user(NOP_OR, &tramp[4]);
+    __put_user(NOP_OR, &tramp[5]);
+    __put_user(NOP_OR, &tramp[6]);
+    __put_user(TARGET_NR_sigreturn, &tramp[7]);
 
-    default_rt_sigreturn = sigtramp_page + 6;
-    __put_user(MOVW(2), &tramp[3]);
-    __put_user(TRAP_NOARG, &tramp[4]);
-    __put_user(TARGET_NR_rt_sigreturn, &tramp[5]);
+    /* rt_sigreturn trampoline at offset 16 */
+    default_rt_sigreturn = sigtramp_page + 16;
+    __put_user(MOVW(7), &tramp[8]);
+    __put_user(TRAP_NOARG, &tramp[9]);
+    __put_user(NOP_OR, &tramp[10]);
+    __put_user(NOP_OR, &tramp[11]);
+    __put_user(NOP_OR, &tramp[12]);
+    __put_user(NOP_OR, &tramp[13]);
+    __put_user(NOP_OR, &tramp[14]);
+    __put_user(TARGET_NR_rt_sigreturn, &tramp[15]);
 
-    unlock_user(tramp, sigtramp_page, 2 * 6);
+    unlock_user(tramp, sigtramp_page, 2 * 16);
 }
-- 
2.52.0



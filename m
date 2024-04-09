Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F1DC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 00:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtzRR-0001gI-4G; Mon, 08 Apr 2024 20:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtzRP-0001fY-My
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 20:34:23 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtzRJ-0004bx-TL
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 20:34:23 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1e3c9300c65so26844045ad.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 17:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712622855; x=1713227655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cKLjKBRBJQg84oS4OLgjoE2usIG97HzuqeLjYhoFQH8=;
 b=H+9ieD/kYmb6ZJjDsM2D0jwCS16wqRjnXJxb/WQjdC/n2qvOFpAzZJbvuNyPEA2frS
 aKgKfAqZ3+rmTp9bnOu07VMqbgEEHnzV+C48UF8BB7cPWWVrFnKSAAUlsr0VEqoO8kBV
 Jc/GjqypIWNW2fa8Iwbjnwx2ANaXr7P3Op8EmMRiA55gWovihCc9H0+Nti8tKoCNbNtZ
 sXLricp/VGlurqO7oH6i80JQFzqmTM3cmehobflJEan5f6EZ7i4ufKYbuHJTKif8N1e+
 cRjKpieIlfCaouGdtKMOjPqt6aJHP9DsdZmzz969KyPFfBl4DP7SygKK6AQggwSt6EFv
 WyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712622855; x=1713227655;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cKLjKBRBJQg84oS4OLgjoE2usIG97HzuqeLjYhoFQH8=;
 b=EbKEgKY4FG5Nw6ftaigQQCQxY0ebjX8LVnb/7G1ZM6Bax3ooVADNBbw+4bsNGb1Oi4
 P8BPR5W9z9lOMCeuciGSMLRxmjlqmT3g6pIxhXk0CI99c+Q+NQNOD4O/hLalUKfY8kk5
 yAYsxRapOTWZE2tkvnjN8bcZqDHLEulQFjnRN6dTXCtLL/7L+4vTVfd26RzjFFcCLma2
 3mHPuyFCr9hyffNto5Vrx8ZVoUZL8t1QHD6ZqFB/4tbdouSffzNeKrv+/YxU1uGqbZ39
 9y0L/szkSj13fEVciZwNxWdTHOXtJUP3SIJzgkm5rQzXfXmxgS1Mhw0mCvrsxBtGLjeK
 Hmgw==
X-Gm-Message-State: AOJu0YzED/e2k/5UuAD2El8VxReuc01575LsGElLGuYI4eTxX3MpwreE
 uUhqcAlHuZWkIzW9BYGPpiljsKEeSdyZIaAvXGy9RamvUjxGF4sfqayDj2WtyFPxY0ZJRgpWOW+
 u
X-Google-Smtp-Source: AGHT+IEi8c0i+MpulrDRBNFkgIaf997IIbwvbQJCJFXbuZX1tSX9R30s/QW5Wpo1Y3qFKZ6/zsxcaA==
X-Received: by 2002:a17:902:f64a:b0:1e3:e1c4:eaf3 with SMTP id
 m10-20020a170902f64a00b001e3e1c4eaf3mr6479306plg.43.1712622855088; 
 Mon, 08 Apr 2024 17:34:15 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a170903110400b001e45c0d6ce6sm1825290plh.306.2024.04.08.17.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 17:34:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH for-9.0] linux-user: Preserve unswapped siginfo_t for strace
Date: Mon,  8 Apr 2024 14:34:11 -1000
Message-Id: <20240409003411.1452196-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Passing the tswapped structure to strace means that
our internal si_type is also gone, which then aborts
in print_siginfo.

Fixes: 4d6d8a05a0a ("linux-user: Move tswap_siginfo out of target code")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/signal.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index a93148a4cb..05dc4afb52 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -1173,6 +1173,7 @@ static void handle_pending_signal(CPUArchState *cpu_env, int sig,
     CPUState *cpu = env_cpu(cpu_env);
     abi_ulong handler;
     sigset_t set;
+    target_siginfo_t unswapped;
     target_sigset_t target_old_set;
     struct target_sigaction *sa;
     TaskState *ts = get_task_state(cpu);
@@ -1182,9 +1183,14 @@ static void handle_pending_signal(CPUArchState *cpu_env, int sig,
     k->pending = 0;
 
     /*
-     * Writes out siginfo values byteswapped, accordingly to the target. It also
-     * cleans the si_type from si_code making it correct for the target.
+     * Writes out siginfo values byteswapped, accordingly to the target.
+     * It also cleans the si_type from si_code making it correct for
+     * the target.  We must hold on to the original unswapped copy for
+     * strace below, because si_type is still required there.
      */
+    if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
+        unswapped = k->info;
+    }
     tswap_siginfo(&k->info, &k->info);
 
     sig = gdb_handlesig(cpu, sig, NULL, &k->info, sizeof(k->info));
@@ -1197,7 +1203,7 @@ static void handle_pending_signal(CPUArchState *cpu_env, int sig,
     }
 
     if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
-        print_taken_signal(sig, &k->info);
+        print_taken_signal(sig, &unswapped);
     }
 
     if (handler == TARGET_SIG_DFL) {
-- 
2.34.1



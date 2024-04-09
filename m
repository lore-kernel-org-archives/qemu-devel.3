Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99FDCD128A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 19:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruHGr-0000iN-Fy; Tue, 09 Apr 2024 15:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGp-0000i5-IS
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:39 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGl-0004hs-UW
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:38 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e4149e7695so19670915ad.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 12:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712691395; x=1713296195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xpaONpZX7TzlKuP+L0GxHPWtvRjew/38IVUtIRwPa5c=;
 b=u32rTkWjDpvUVunMYXf5Bu2wHhCy/Usc1g7CLOneDWr3CvNZDldf77QLkTy7uJAJeF
 jKjwHAHVoz/J8x7SWlyw+Wg5NlDRFNJU7xlEi41cSeozDniZhExe5GwhufFh9tf+sTZR
 G22po88Kf69jRlOSzmOlyKjqnuxkJPJoFX+mTvO9FbKO/b5FH1tXTTMQF3/ZUbII/6/+
 n82dPxddUJ67AFHdtpCmQ+AmqgGcMfhGR7HYsHPjl2W074cdDyGgXWOBhO2GXOWvdHR9
 4EospU6vHMXGJA4gf9/lLZ5qE+0fx5zAcY9iE6lvHqc/jh5BgPmvHRS6Hf4iIVAbiBNl
 oYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712691395; x=1713296195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xpaONpZX7TzlKuP+L0GxHPWtvRjew/38IVUtIRwPa5c=;
 b=xC5teEQB+BvuuMILMXArzU9KZB0WOVSuJD2txact+Ber2zU2xUbnX9FRrALv7zchCd
 0NpNEF3ulfDzcLmmqKWjpXnoY4VrDWi5KX81ueoAaKgxY2tvpp+o7OCwaDzm0zB+gtqQ
 lm/kQj2UFRAj0ql03bXtGwawQH440fVrv18Jt+uQnyqVYSJZaYUBqlKiblWJAgShkn6A
 5wxjJI+RYX4U0FMY3hDv0qaujut9xvG8HVNaLXtuEXbP369VLZ4hSPO9xCq4M9GUk4NA
 UCkvWD6GrWRrKToIJYnsDawqLbuzKFtR+9k9Xr9Jw+plQGMRclPuDGf9qVPO6X2G0sZg
 CZQQ==
X-Gm-Message-State: AOJu0Yw9gIoxtngFHLH5xYLiramuvImzzngUwA3lxNmU1cuu/oCCMZb6
 3UH+W/q8SyzQKSBlxDsWMNi9mtUDrH9aLCwYnJHnfKEDmaOwiI/zqfaq0PcjzJDwJVndEiqW9s2
 /
X-Google-Smtp-Source: AGHT+IGgXoWFCythR4LhHHwMcwh7J2QSZKAKjS9aEPmSWjlhJR5TK+ocQmiypcZuwC4dj7NAaYQRLQ==
X-Received: by 2002:a17:902:eb8f:b0:1e0:a7cc:3750 with SMTP id
 q15-20020a170902eb8f00b001e0a7cc3750mr963465plg.3.1712691394748; 
 Tue, 09 Apr 2024 12:36:34 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a170902d49100b001e1071cf0bbsm6065843plg.302.2024.04.09.12.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 12:36:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 20/20] linux-user: Preserve unswapped siginfo_t for strace
Date: Tue,  9 Apr 2024 09:36:03 -1000
Message-Id: <20240409193603.1703216-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409193603.1703216-1-richard.henderson@linaro.org>
References: <20240409193603.1703216-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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



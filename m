Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A9DC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjeD-0002Uw-P2; Mon, 11 Mar 2024 13:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjje8-0002Sq-V4
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:41:09 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjje5-0007Js-Ni
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:41:08 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e56787e691so3755341b3a.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 10:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710178864; x=1710783664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eKpzpXj/rNwSAlMipdDJMEvIfQrihazLg7YHWN/oksU=;
 b=l+eDB8iExD5tDt3AUAn8FmP7dXnOVVDkh685Jz1fIyvEVHuifRD0fm4Lq7ZQCC5nWt
 8PmzRd0ijr1SJ8Hn0oTcPXR50ES1pAqBZawNY3Eu3JLcJRs54DUr6YU2+kX7egygrXmA
 gDtZzlBB7/+5e64Zk8A1chNAa8M3n1I+tFchlr37AmcfVT7XfO8+XX9IN5k3RE9n8WRP
 ags/YFRtCgX2YJ/p3PU0ZZgxnaXX9eNDtni3Z6e1u9fyXlL60kxDSl+9W3N9zHx5TDas
 bOg7pGr92K3qBdgOvGKEp5lQDJ5qV3hOtJYQIt6bL+o8Y99pQNv16dwKN9RX3MjtGeO2
 nm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710178864; x=1710783664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eKpzpXj/rNwSAlMipdDJMEvIfQrihazLg7YHWN/oksU=;
 b=D7+4ZQAjlhXGax92PDOLg8WNjqwZMLvmzS0XRETATQqcYkSBCphHNzLkWgZ5Yc8AAj
 R6+gt0avdkurBJxFVQ0omJ6aQ+sEwh9d0INrZjGLp+VvKJjWvZiWbqxpUTqIJKn9KKat
 i+5/h8aj1GKHjrAo5swzVl1EXSilASMgt9YdpWFM5lBN9lr8PcCUOQ1fW3Nib2LBTvLs
 i/Cfwsh32FLkU0FCeahS0Q+LR9jFoExVKLjHxJz7Rql/Rf0IFkUFWRet2mcEZpHIjkjc
 vBEYV04FfniRd02zl0FnHWfRrRVqoonAqlrIsDc8z3wpQCTzWuC6+RMpWXrKzu5Bwl5Y
 Xtbg==
X-Gm-Message-State: AOJu0Yz65DWEtKUSqT5FapzmHvrOQEqdl/kSbEQcbfsnOctvJs/Z8sUc
 SKyBHbYMjcEIZCm5446nh0JYU7oFuTRdjRMrZnV7H/iaBTOnbnxb1heNjqIR1gY=
X-Google-Smtp-Source: AGHT+IGVSkV4C9Krr6IAQhl1qIMVdGkJISfDIjhbkadkx6jRwjEaCeWdRRz/eAkmoGC3Zrc/WC4JFA==
X-Received: by 2002:a05:6a20:438b:b0:1a1:e41:3edb with SMTP id
 i11-20020a056a20438b00b001a10e413edbmr10109812pzl.11.1710178864007; 
 Mon, 11 Mar 2024 10:41:04 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a62d412000000b006e67b4d7b74sm4593187pfh.197.2024.03.11.10.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 10:41:03 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v4 05/24] Revert "replay: stop us hanging in rr_wait_io_event"
Date: Tue, 12 Mar 2024 03:40:07 +1000
Message-ID: <20240311174026.2177152-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311174026.2177152-1-npiggin@gmail.com>
References: <20240311174026.2177152-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This reverts commit 1f881ea4a444ef36a8b6907b0b82be4b3af253a2.

That commit causes reverse_debugging.py test failures, and does
not seem to solve the root cause of the problem x86-64 still
hangs in record/replay tests.

The problem with short-cutting the iowait that was taken during
record phase is that related events will not get consumed at the
same points (e.g., reading the clock).

A hang with zero icount always seems to be a symptom of an earlier
problem that has caused the recording to become out of synch with
the execution and consumption of events by replay.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/sysemu/replay.h      |  5 -----
 accel/tcg/tcg-accel-ops-rr.c |  2 +-
 replay/replay.c              | 21 ---------------------
 3 files changed, 1 insertion(+), 27 deletions(-)

diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index f229b2109c..8102fa54f0 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -73,11 +73,6 @@ int replay_get_instructions(void);
 /*! Updates instructions counter in replay mode. */
 void replay_account_executed_instructions(void);
 
-/**
- * replay_can_wait: check if we should pause for wait-io
- */
-bool replay_can_wait(void);
-
 /* Processing clocks and other time sources */
 
 /*! Save the specified clock */
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 894e73e52c..a942442a33 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -109,7 +109,7 @@ static void rr_wait_io_event(void)
 {
     CPUState *cpu;
 
-    while (all_cpu_threads_idle() && replay_can_wait()) {
+    while (all_cpu_threads_idle()) {
         rr_stop_kick_timer();
         qemu_cond_wait_bql(first_cpu->halt_cond);
     }
diff --git a/replay/replay.c b/replay/replay.c
index b8564a4813..895fa6b67a 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -451,27 +451,6 @@ void replay_start(void)
     replay_enable_events();
 }
 
-/*
- * For none/record the answer is yes.
- */
-bool replay_can_wait(void)
-{
-    if (replay_mode == REPLAY_MODE_PLAY) {
-        /*
-         * For playback we shouldn't ever be at a point we wait. If
-         * the instruction count has reached zero and we have an
-         * unconsumed event we should go around again and consume it.
-         */
-        if (replay_state.instruction_count == 0 && replay_state.has_unread_data) {
-            return false;
-        } else {
-            replay_sync_error("Playback shouldn't have to iowait");
-        }
-    }
-    return true;
-}
-
-
 void replay_finish(void)
 {
     if (replay_mode == REPLAY_MODE_NONE) {
-- 
2.42.0



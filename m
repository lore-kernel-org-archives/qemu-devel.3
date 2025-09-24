Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CE7CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 16:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Shm-0004WC-Lm; Wed, 24 Sep 2025 12:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1Shk-0004Vq-N5
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 12:50:57 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1Shd-0002wh-LM
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 12:50:56 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3f2cf786abeso62251f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 09:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758732641; x=1759337441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pw+M2AYHPvrJ27gcoTirTl22Hh+v62J22/lcmoHq2yw=;
 b=anwOZ2RVW16rbvi8KwPU3T+GmOcoUSrBxn2oN0m+4lUSgxuDNEmTi64k5/S8Hr6QPE
 /UyVrICYA+Uo2v3Q/FX8cqssOp3bMnACMZAEl8jPi3+Aqi3JOK7DkNBAxNDJXYmC+stu
 N1OZ8JBqmzTIvakfjrhoa/9bRc+D9eohkLiTg6ioZLfse0LrNZH5xXPT80A1PejGjWOn
 qH5swYG3xKvQ+DS5p/xB2ICSvNecwNoYRySyA9Vd+NDzIaVoLl+Fm2psA6XZLJpckchE
 iqIgB8awcunEYaEIXvCFX4uyikBYoneukFAhDHJmckAP3cbFCb9QBR/1KKmyAqTHHVTa
 2OTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758732641; x=1759337441;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pw+M2AYHPvrJ27gcoTirTl22Hh+v62J22/lcmoHq2yw=;
 b=D3sQ7pOPlMSI1uOZf3vMLM9baAhtwV/0aB29gAKLP4w0UP/NTj6y340tHu+bHW8iHe
 fLrALNGwvuYOgMdjQQkjp0VEorwWZQ2fKAfSHb60FIMSZgAWE2aAn9gp9Nr8L0odAbf7
 n751raDnNEY0kHSst+K1GTJn3Lt4lxSPTRzIM3gP6kU8UFBfD6x5Qq09oBjmk4F2q5SF
 rHlIXzWtHXMRHq5kmBoFuXIBhHefkHZlYFb7T4bHm1NXG3xQ1oE6ncO7JKfNvCey79Ny
 UKHpPGqXjcL2XPuotAqhMXpL9Dco9vzXpnBL+kc/If3uFLDZpg81kX69C2lJM7pRxY3N
 /Wsw==
X-Gm-Message-State: AOJu0Yyr5J3ja+LImvjfI6FThFKUMBi5DRB65ncmBgcghPG+fMsRnppe
 xZcjyORz7dug125Sj1x7S+mNl/Apr6mp83GFpt5Xs9pqFu4FGqk0EtGGCS8CEzifrXWmpArdUil
 khgioI0UFcw==
X-Gm-Gg: ASbGncuwpSxGw0G9r7cCZ5eBTm1FxaBYTgYoKBytXT6USKH6UPHhKJYqE7SfAeMkPXd
 QABcrm6+V64YdXwH5w7ZvM5HuCXwsIk6T9IKP1B/lCZmpx91lp7JnwBm8KBe0l+V0Cl4G8J3dxB
 v7gXFjel3rPm01WNCp8Cnsm+ETPEuVf/4WBGyQJnZnxsAo0Bq7Vv3gXgjbmfd/7Rj8jaKfNpPiW
 C4dof6FKtuRtcEbgoOvFsiyzy39pGGWbLIeDh2MkylV5Dds7IbfEzxiZh2QhI0iTO/+UVBwTo5q
 mUk1Q4dXq0iFgxDKyumTmV+Ksp/buyO7YBC66LrbeRbB9nY/NVLoFGJhn8QNCDp9XBIpZln0pT3
 Hha9O11To8p6NIBq5nI1Zdh6Ty6qJwGmaQOmsoizRtQu3Bl04Lg7fpvVJMqJO96SJlfwRBa8d
X-Google-Smtp-Source: AGHT+IEde5u165Yu7tlw952wiCAgfAZQs2TaQuDBEM9PzDughFrFQ/BwkKF+/EpUsXMC1Lpuo/BR7A==
X-Received: by 2002:a05:6000:3105:b0:3ee:15c6:9a60 with SMTP id
 ffacd0b85a97d-40e497c34a1mr568616f8f.6.1758732641410; 
 Wed, 24 Sep 2025 09:50:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2a9ac582sm41634155e9.9.2025.09.24.09.50.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 09:50:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] accel/tcg: Remove cpu_loop_exit_restore() stub
Date: Wed, 24 Sep 2025 18:50:39 +0200
Message-ID: <20250924165039.52250-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Not needed since commit 63e7af20352 ("hw/mips: Restrict ITU to TCG").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-common.h | 2 +-
 accel/stubs/tcg-stub.c    | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 9b658a3f48f..f373781ae07 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -221,9 +221,9 @@ static inline bool cpu_loop_exit_requested(CPUState *cpu)
 
 G_NORETURN void cpu_loop_exit_noexc(CPUState *cpu);
 G_NORETURN void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc);
+G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
 #endif /* CONFIG_TCG */
 G_NORETURN void cpu_loop_exit(CPUState *cpu);
-G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
 
 /* accel/tcg/cpu-exec.c */
 int cpu_exec(CPUState *cpu);
diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index 3b76b8b17c1..77055e39644 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -17,8 +17,3 @@ G_NORETURN void cpu_loop_exit(CPUState *cpu)
 {
     g_assert_not_reached();
 }
-
-G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc)
-{
-    g_assert_not_reached();
-}
-- 
2.51.0



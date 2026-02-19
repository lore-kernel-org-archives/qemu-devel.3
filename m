Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949D7E9A05A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9a2-0008Hd-Nh; Thu, 19 Feb 2026 14:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9a0-0008Gj-Ug
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:20:52 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9Zy-0007iZ-Hn
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:20:52 -0500
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-480706554beso14628165e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771528848; x=1772133648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2aXyOiL3BgGhv7hBsQYyGm7OySebeVhwm5vGLvWKK68=;
 b=QPNmLgMP9VFGJXNrVvmJy1ZZiA/ZT1JTcN3US5jh/8+nb7vXFbsH9x2ooLJX+5u2R8
 GiaZFcr83jGoAiLVxQVWKFxWzvwr06kkLI5JSXUvL4bulTc6MlfTChzNt/Xa23NrD7lC
 jdhdQdCjUIgZSWIeLhpVQxPb5EgWmwLvLIH7Whm6jFyuDHFGwhvcHiQqDlPmT1ABZjTf
 vr+Fqzk8GX2mOyLkkCyyGZuzr3xSHqKzlYnpjDndTto2YZlwtKttJ+Yz+Y5bOXRl4s/u
 1p26mHY5XKA9GWrWrdTXbbRWywd6OQd1n5fQDNkH8dAteH+ekTPamb8pjRdS0UrRARMe
 ywAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771528848; x=1772133648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2aXyOiL3BgGhv7hBsQYyGm7OySebeVhwm5vGLvWKK68=;
 b=qtFSH2UCNcdtICRGgh+Cr4LkWxFpZUps1Oi3PQ+n20b3LacTT9kq4K+fEWsdEsPRGG
 ZG5SsS44mA5u/EmqzOUNDZ91FSs+KxOijmmPORZFt0tVw+BjDTCfNSbhnLxCz2jeY5lD
 YRwrpyzh79T8DnNAWsASlkH7MQRrlowIZR+m9wjJT0BEwedXoiOzcR6eaBGC/WILIFYq
 irfi06QVya2mcFKEclkYDcso28mlJmSWzTYZkqsPZLPVr3TbB9yrYwGYKB85T3jmSlS2
 A361OE4liYpM/7JOSS1BQCkQALmCzRvELviLMOsIT1/AR6LkQWrTAV0HpGQbP1CoMpb6
 MfGA==
X-Gm-Message-State: AOJu0Yzd4FuQ77mTSnCUJzfjaUAZ+8DZ3gZmxqyIWpEohF3CseW8SWNh
 ERK+zlWAqgKju9SIihpU4HqBZC4yqtKeIzVF1aueHQqg6PBsuxlqszLrSHXxzhLx1V9lvubmpoY
 ZiKCf+ftzob3Y
X-Gm-Gg: AZuq6aK3VehLI83Sqm0WNsISF+tPwdw+ZbuHMVyS1aYfMn60ntolHF8TMSVfohWz9U3
 jlTGWCqlZyTP447kEGH4zrHn98cu5bKCMSA2qWGEA8lpjCMEEk+OASS3eGJNJskBTR7UTrViVA0
 xs7FakleFCmpJW2TH1u0KAzOZC2NirnyFYDUPEgVaIZM0tePoK1z7S5R7JUiCj3mmyjdcvKu8xt
 lVr4vokgvujXsq529xaeAAMffYETRDFn8z1r2kiMcLd0HmhBqtvlM6jtDX4v2TNHlj8XukpBdgP
 LQdNfD8nBF0TysrU5ZozQUjVogbes064pC/NhzdhNBH91ny5nUO+xxFIk91XFaUwEjJduew1BrQ
 g4XBBbzSdw/xynyyqgR5/kSBBd3rYptx6UGoSlOxnDPv/UD1pKGjpkawJoSygTcl6kN2D4+MoEU
 qDsPGGDcuSPNa/kFFf3EzcYCJmiJy0BypHuejDpv7tU7AJGCzSEi/CmGibANtY59j5Mx+qYCJr
X-Received: by 2002:a05:600c:83c6:b0:477:639d:bca2 with SMTP id
 5b1f17b1804b1-48379b93357mr275851755e9.4.1771528848455; 
 Thu, 19 Feb 2026 11:20:48 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac800esm53920119f8f.27.2026.02.19.11.20.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:20:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 07/50] target/ppc: Fix CPUClass::gdb_num_core_regs value
Date: Thu, 19 Feb 2026 20:19:09 +0100
Message-ID: <20260219191955.83815-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x342.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Only 70 registers are exposed from GDB XML file (for either
32 / 64-bit variants).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 gdbstub/gdbstub.c     | 2 ++
 target/ppc/cpu_init.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index b45eb7c7b2b..474f6712f8d 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -593,6 +593,8 @@ void gdb_init_cpu(CPUState *cpu)
         gdb_register_feature(cpu, 0,
                              cc->gdb_read_register, cc->gdb_write_register,
                              feature);
+        assert(!cc->gdb_num_core_regs
+               || cc->gdb_num_core_regs == feature->num_regs);
         cpu->gdb_num_regs = cpu->gdb_num_g_regs = feature->num_regs;
     }
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index c809c1f4d89..27de8d80204 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7553,7 +7553,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, const void *data)
                       PAGE_WRITE == 2 && PAGE_EXEC == 4);
 #endif
 
-    cc->gdb_num_core_regs = 71;
+    cc->gdb_num_core_regs = 70;
 #ifdef USE_APPLE_GDB
     cc->gdb_read_register = ppc_cpu_gdb_read_register_apple;
     cc->gdb_write_register = ppc_cpu_gdb_write_register_apple;
-- 
2.52.0



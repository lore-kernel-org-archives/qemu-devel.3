Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B793B10987A9
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3d43-0006GJ-V8; Fri, 20 Mar 2026 12:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3d42-0006FU-11
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:51:10 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3d40-0001rz-Ik
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:51:09 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-486fd27754bso13297055e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 09:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774025466; x=1774630266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PmtnWJ5PFHdyhRwq5dv+ae8r7zuhkOnXX82QXiYgiuw=;
 b=WXU00+xkx2xnE+6+7E7zspkRC8dUO/pTM93tczTAts3KRBhr0aBL4eZRniZifKkzV2
 9aJV/HoNLuKoxSaTVv8zvSYqjoc+fk5fD0oUbq/0skxqk6hWfCZv4qKZ2nr5Uz3HaeeK
 WNo9e0T1IflQQY+S5AD0usbiqFlf21AKbI0swyYSiYz2kQzZ7nLMLSiZip6vM2DuFkjU
 leGKNjMtdfZXyYWG/ipF7cYviMYsScE9gHRRgjG5PPts+D6+2ngR2bpEqh6eSeUm7lfq
 LXGboRAmWGiDVPhYmSQNwor4H/lfh+fi67bi5+T3Yvg0FpXH4sJAAZeuAp2i+OMxzoBF
 Jl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774025466; x=1774630266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PmtnWJ5PFHdyhRwq5dv+ae8r7zuhkOnXX82QXiYgiuw=;
 b=O1Ol/qLQN0fds8wKL+QzLx9yQIt5kOcYE1H3tU1zfNlky86labZ2UY2v4UJOfpmsOu
 ArW/W+USjnIDVZXSORSq8EjbMUGQpDzTqa7zcZwrixwS4ZWVhBbvs4uvSsLG50l0/XdY
 s+n78j1NFqO6Luhl5HffIpG2mRwSGNYMwQNZltqQuqSUDVpNk7KVOcytcjgx3M4ai8LY
 lFD41Y62pq3vajSqHIgZodXrm/pjHbl0ZmLd7e2IUwEO0BG8kbrFMPddKtnIFtn7JQN8
 AhI0gHy0glqnZ8KbrgjdxHX2V0IAkO72VsccvnvybJrA/90GwtDmN30fWqMoY11ZgdcW
 gpGA==
X-Gm-Message-State: AOJu0Yw7zwFqs2BqCWh7hbKVF9eM68KTUO5w1zKLmX77aIBRHVj+ZFcp
 qskCRCYzyiDF6xfDFcX38kc+DCQdc9EWmgv93NgLuZIQOl1PGPJS3TBmwXIyLoZFoKxpWM0my5I
 O3atvLzM=
X-Gm-Gg: ATEYQzxAY46Sn3Z9F/XF0wIhsbNurGjbWVfVidFBu4YzkczJgtEGl4q7i8ivHmPUqvs
 SegonO7O0WN9cGENd5scXal78edWfEUJ6nd7rTNl/1Vh6J9jCwEXZreCNTzGjgkDd+oQUa9ibxu
 dySFlflIV5dH6xvh4oXE3b2ItgLWOIHGuNuXDi77I2N43AC//jPNTdNoC5sYzAElFVQx5QCk45h
 hqkbZALLnYS2venPKqPutHIuooiz/3K0oFekl5w4Co+2zo6EVRxoR+yGqh/K1pHiOVNGmAXNvXV
 abqgFwNKbEAs94vQ1FVS07fpHOE46k/H3D8u8xyw6F5CGjihw8tbR9J6drDDr0QZhTCeTh8520z
 aMJvlDHj3wAY2FVbgGwuWMLA3SpuZl6QsZm4DhGmEmMEbvKaJ9US+c6rr7ixeDD8kofTAYy2tON
 +Gyv4i7IV0DwxSY45zDQOtz14/PTz1GD/Cg7iZouXy2AGkVWij4DWh1o4bLQ4BBSEmde9jslQj1
 nhERh1RQxU=
X-Received: by 2002:a05:600c:8b66:b0:486:f9d0:aac8 with SMTP id
 5b1f17b1804b1-486fee0f835mr53412435e9.18.1774025466464; 
 Fri, 20 Mar 2026 09:51:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff1ce0b9sm28082815e9.6.2026.03.20.09.51.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 09:51:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Anton Johansson <anjo@rev.ng>, Glenn Miles <milesg@linux.ibm.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, qemu-ppc@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 v2 6/7] target/ppc: Rename dump_mmu() ->
 ppc_monitor_dump_mmu()
Date: Fri, 20 Mar 2026 17:50:19 +0100
Message-ID: <20260320165021.39521-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320165021.39521-1-philmd@linaro.org>
References: <20260320165021.39521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Rename dump_mmu() to avoid a name clash with other targets:

  $ git grep -w dump_mmu master | fgrep .h
  target/m68k/cpu.h:610:void dump_mmu(CPUM68KState *env);
  target/ppc/cpu.h:3083:void dump_mmu(CPUPPCState *env);
  target/sparc/cpu.h:603:void dump_mmu(CPUSPARCState *env);
  target/xtensa/cpu.h:697:void dump_mmu(CPUXtensaState *env);

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu.h        | 2 +-
 target/ppc/mmu_common.c | 2 +-
 target/ppc/monitor.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index ba17ea83fa2..7fcafd590d4 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -3082,7 +3082,7 @@ static inline bool ppc_interrupts_little_endian(PowerPCCPU *cpu, bool hv)
 }
 #endif
 
-void dump_mmu(Monitor *mon, CPUPPCState *env);
+void ppc_monitor_dump_mmu(Monitor *mon, CPUPPCState *env);
 
 void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len);
 void ppc_store_vscr(CPUPPCState *env, uint32_t vscr);
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 5ea9b6d6773..00923c0b96e 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -547,7 +547,7 @@ static void mmu6xx_dump_mmu(Monitor *mon, CPUPPCState *env)
     }
 }
 
-void dump_mmu(Monitor *mon, CPUPPCState *env)
+void ppc_monitor_dump_mmu(Monitor *mon, CPUPPCState *env)
 {
     switch (env->mmu_model) {
     case POWERPC_MMU_BOOKE:
diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
index 41337d77a89..f95b1b44c2c 100644
--- a/target/ppc/monitor.c
+++ b/target/ppc/monitor.c
@@ -19,5 +19,5 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "No CPU available\n");
         return;
     }
-    dump_mmu(mon, env1);
+    ppc_monitor_dump_mmu(mon, env1);
 }
-- 
2.53.0



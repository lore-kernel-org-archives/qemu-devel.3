Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26453108E1E9
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 11:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3BQJ-0007gS-W4; Thu, 19 Mar 2026 07:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3BQ5-0007YV-BA
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:20:05 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3BPz-0004jh-QG
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:20:02 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48538c5956bso7110625e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 04:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773919195; x=1774523995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1EF35YN3CJ8u12H8BkNu2tiJ6lwUGD01EvYz7GmtlEg=;
 b=kKqbokV7hzT3WeeMCE2a2vowThXQK+07iJHsrc3htmqSCQYpW6yLqBf1anhUZTlBCb
 JfszmI80XpTtk9C2+qD7RjYMKUnLkeEBIUBp5QRHBqV1YJtgnQArwjn3VKIZaKMphBbL
 E04M9TKRxarFm+HC9bnuB9bhWsgJ24oz0gep58R1xVLr/GBiTBK6n80TewYC8sNiAV2q
 F8YJDdy9eDloXLHS4RO0LrLXIXHWD1HX2abfwaQxg0DT2mwnGzmVgytPDgcNv1fUrt9M
 3AUP20K88u2jXVWwPFmzeOQsdDvHBKGIqYnOhur9y+Xv4vs653OMv7584fC+xh+cN9l0
 fkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773919195; x=1774523995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1EF35YN3CJ8u12H8BkNu2tiJ6lwUGD01EvYz7GmtlEg=;
 b=SY2GaelnM1dqkgqzXUdGjFsfpJdh+C6lKLUerQpJ6R3wi4ZHWIxGWUdCOsQ7HiAMhG
 +Nz5YlTgoYEpvNXxxC6OTCT19CKjDoZDKQkXEfGWDENaxNo2uPrYvRx6C7B/5LWg3hF8
 Y7u1qnlc5mMfYnzQFGFDCfu2tGCgBJwUkKQiVqSdHexr4Cf+juGKfY5ka9ZEG7yFfhMv
 OG+1da0+SXUk8QFXzTWwfdOOuplCnaYZXhQEdjMr4jHHqXCSYAaSJZR7OnuWatRd/LQ5
 n/40Oz6535nDHF1VrodvheH8TMmRUwK14b4OnMR1ff502y97ga8QRMLol6tAwIYTyDRG
 2T+w==
X-Gm-Message-State: AOJu0YxwC0oMvfktdWXg/EfOGCNHIKaiCE74Md+nrJjZnz4M5y4N2j1b
 ycOkZ/9vu42S1hpbdKVe0WaY6zDGXrGqM+2O7YyHgEOEmWigdkU3BmMjs1LiTvWos3HA3eCVJP1
 /4udQ7Ek=
X-Gm-Gg: ATEYQzyYnNbYYJKFwZQPGl+0h5Cc5uhFHeuJ909j62nT7hcS3ogaqOBp6ouYYwy1DWD
 XwaEL7f6C/AyIi7vXhpRrjscr5fkcLEYjr0suc0y3tPs070uRoIk+C1tzkmZuTP5zcV0XRQ9E69
 2DtXp71IfXGJC2B6HcUJiTIHG+81l6yU/FaSp7CH+Yrh6AyGEetavfHDwAsg9HBUGqf6mvSPf/E
 ZZU+x57l7vv6PZcN+APnrqjcRLFUOrTL8rrcOPHc4XMDWxpLcq63kWWCCJyOlDdVI4aW3aqbm2c
 8w02/wDfHZRQBskHtk7vIRluxqgMn/SjFryPPvdnI9bV29KP/CoshQymZV0+Pge3j3iHSiW0mJV
 0lmjC0QHe3yVrWoEKJh7tsTQRxW8jyg7+2hgxxpjxzJ/uaF5N1SE26RPRS62kVgxqg8yR9C78Jv
 e9u/AC7OtiW4VNDf6BPXhZ9UTZKjuNRsRAs9m5jrSVv2VO8lnODjWCZII/07qZgXok5pB4pTbK
X-Received: by 2002:a05:600c:8b10:b0:486:f893:56c6 with SMTP id
 5b1f17b1804b1-486f8b46651mr48087815e9.10.1773919195014; 
 Thu, 19 Mar 2026 04:19:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8bd9d78sm19811235e9.5.2026.03.19.04.19.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Mar 2026 04:19:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/8] target/ppc: Factor common ppc_load_epr() helper out
Date: Thu, 19 Mar 2026 12:19:30 +0100
Message-ID: <20260319111936.68041-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319111936.68041-1-philmd@linaro.org>
References: <20260319111936.68041-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu.h         | 2 ++
 target/ppc/cpu.c         | 8 ++++++++
 target/ppc/excp_helper.c | 3 +--
 target/ppc/kvm.c         | 2 +-
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index d637a50798f..e3e4bce91b7 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2822,6 +2822,8 @@ enum {
 target_ulong cpu_read_xer(const CPUPPCState *env);
 void cpu_write_xer(CPUPPCState *env, target_ulong xer);
 
+uint64_t ppc_load_epr(CPUPPCState *env);
+
 /*
  * All 64-bit server processors compliant with arch 2.x, ie. 970 and newer,
  * have PPC_SEGMENT_64B.
diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index 4d8faaddee2..f24801a9731 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -26,6 +26,7 @@
 #include "fpu/softfloat-helpers.h"
 #include "mmu-hash64.h"
 #include "helper_regs.h"
+#include "system/memory.h"
 #include "system/tcg.h"
 
 target_ulong cpu_read_xer(const CPUPPCState *env)
@@ -105,6 +106,13 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val)
     ppc_maybe_interrupt(env);
 }
 
+uint64_t ppc_load_epr(CPUPPCState *env)
+{
+    CPUState *cs = env_cpu(env);
+
+    return ldl_phys(cs->as, env->mpic_iack);
+}
+
 #if defined(TARGET_PPC64)
 void ppc_update_ciabr(CPUPPCState *env)
 {
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 6d05b865058..3b476c145ab 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1166,9 +1166,8 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_EXTERNAL:  /* External input                           */
         if (env->mpic_proxy) {
-            CPUState *cs = env_cpu(env);
             /* IACK the IRQ on delivery */
-            env->spr[SPR_BOOKE_EPR] = ldl_phys(cs->as, env->mpic_iack);
+            env->spr[SPR_BOOKE_EPR] = ppc_load_epr(env);
         }
         break;
     case POWERPC_EXCP_ALIGN:     /* Alignment exception                      */
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 41bd03ec2a2..3bff75b7f54 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1692,7 +1692,7 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 #endif
     case KVM_EXIT_EPR:
         trace_kvm_handle_epr();
-        run->epr.epr = ldl_phys(cs->as, env->mpic_iack);
+        run->epr.epr = ppc_load_epr(env);
         ret = 0;
         break;
     case KVM_EXIT_WATCHDOG:
-- 
2.53.0



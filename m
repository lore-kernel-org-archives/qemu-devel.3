Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDB8606A326
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rNllw+F+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWCEq-0002Bd-3f; Wed, 25 Nov 2026 07:36:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.mehnert@gmail.com>)
 id 1xW8G2-0003kX-VR
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 03:21:38 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.mehnert@gmail.com>)
 id 1xW8G0-0003w6-Q8
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 03:21:38 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4bb61185057so35079355e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 00:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795594895; x=1796199695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=symwZBZ61XeKaeVFDmNwmXcdpmRLL/s8bbZFLFLU37A=;
 b=rNllw+F+KvNPzy46NgohPFSoFQOeU8tBjG/TqOG74QO6uHaTOwsqut6LTBzbp9OYWm
 v1ZO6nSaQFS3ReOyrzqI3UFHXpGMjkOb3SSqGsVkEbfDhCN9BuZQuTch58oHgrszryWG
 Mh52T9FNMGCVrJAfd19qTy29T2d/8Kt9S0/r5QOExmx1dbFcuB2tshiE32xoEgsLWPx/
 qbFixsgWvWsk9gXZeRnDNGJFGylVFl0cTeiswt4KxTPOn2PmFzvAFnac7CYzSLuqiE2L
 FY/a0La0b4EEbYsAyjNCobQ3MAQnXX8kmIa09XRrzXTBpeczMY5MFnoVg889mRHQaa2F
 k0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795594895; x=1796199695;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=symwZBZ61XeKaeVFDmNwmXcdpmRLL/s8bbZFLFLU37A=;
 b=1nbs+JtYJbDri1+7yrncvULx9Q8j/wQVWWfwrtKoVlk8VHTzxbjtzzOhV/Xu8H9Im4
 AlLaJivvg86YeoQYJEpwIyvAL/vmPKluxdZ1gLlifJHd9DGgc1StEz2ukTLb35Jl2KY9
 6jpo2saLqs7KItS69JkIeZk6fwdzNgJx3OfWA9hJEWlaX0nOHgIABTB8w4AVRsvh2shC
 Grc8jOhtfMcaqVJlolz0Y2jD9d/ZNbuO6tkAhxGoyY61R7WQuiujLcB674laBChFIfDE
 I+o35vo/lXErYNwGDQJho04f93DUUna0E/JTVDSontO+k4XNeZN2RLyycwUOQBdPjOJO
 hzEQ==
X-Gm-Message-State: APuU4Z+RBfh+GnkaqqoNEIp8LBoFqWeIjLDmK0xJwgB8BqCGpuW0Nhwm
 C3fZE/RzOYQC1tC7KPn/Jsrx+Z/Iw8VT0wykRFHR8BFf2w6WdbBktM954uLGzEZZ
X-Gm-Gg: AZFdTZeGiM8dBVG23TjsFLDxFVyVC3FvqdttGY2YltXRPYMiSueO73mERAyY7M47K1Z
 IJ9aGJilqI5bldkwNArj0PGvHKkWO1QRZFvRpnkuz47VqSJrEuvJAYblP0a8Ki6AkUI8CrjM8Rc
 GQRgscds/MAQ4A2S49zyJUH+qthFSwF8OH+6CDCpOSkVXAfqzGXadCON+BZPGuZr0m9L95UPD/a
 IJrl+F8XVHBmFhTWwR3bFXHC9FkKsWtG3Qe+1SY/DF9kGfmufSZF7IjfSY5pSQBpOYbcoztIWBg
 1GVxcS67AaydntwBH071FEwOFF4W14Zt1W4kgImWFxYKPlSx+j86aYaESp1yoxoGbnIIdON6wZu
 if9t4/YadntMJPBtIyeFgkX3V1/IkAA3L965RJQ/BVIeOkawtCKNP9+3DgT8fEA8Ja9gyiuc3mN
 RWx5c6Q8pPxqLzCFutQW//66tbu8bq/QaChx53OLrnT7FEEyv8IUPPCcMrAwAfQX/lLDxJJ5xNh
 rcPgLfls79qYllyodrLpbrGUy6JO6/9zENy5LbsFTCjnluPuD5sVG20gTEipq0WeP2ikGWy5HI7
 W6eHelyKycxOfba0EjgFlqS+xf7gPHRFiGDFZVCKs27RmTi86M7h40sgadymQIDqLse7OHuxF2p
 2rYeEkCMeAtTpDwfUie9u9vfcdEe1HBdZkwe/CmVh
X-Received: by 2002:a05:600c:64c9:b0:4bb:8701:bb14 with SMTP id
 5b1f17b1804b1-4bb88804d1cmr376845795e9.5.1795594894773; 
 Wed, 25 Nov 2026 00:21:34 -0800 (PST)
Received: from noys4.dd1.int.kernkonzept.com
 (ip-178-026-066-148.vkd85.pools.vodafone-ip.de. [178.26.66.148])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b7515sm688795785e9.13.2026.11.25.00.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 00:21:34 -0800 (PST)
From: Frank Mehnert <frank.mehnert@gmail.com>
X-Google-Original-From: Frank Mehnert <frank.mehnert@kernkonzept.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 Frank Mehnert <frank.mehnert@kernkonzept.com>
Subject: [PATCH for-11.2] target/arm: set the event register on a failed
 store-exclusive
Date: Wed, 25 Nov 2026 09:21:26 +0100
Message-ID: <20261125082126.49911-1-frank.mehnert@kernkonzept.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=frank.mehnert@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 25 Nov 2026 07:36:25 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since WFE may sleep on A-profile, a WFE executed outside an exclusive
region halts the vCPU until an event arrives. Lock code commonly
branches back to WFE after a failed store-exclusive, for example:

  1: wfe
     ldaxr  w1, [x0]
     cbnz   w1, 1b
     stxr   w2, w3, [x0]
     cbnz   w2, 1b

The store-exclusive clears exclusive_addr, so the following WFE sleeps.
On hardware, the store by another PE that made the store-exclusive fail
cleared the global monitor of this PE, and clearing the global monitor
sets the Event Register (Arm ARM D1.6.1, R_XRZRK). The WFE then
completes immediately. QEMU does not model this, so with interrupts
masked and no event stream the vCPU sleeps until another PE executes
SEV, which such lock code never does.

Set the Event Register when a store-exclusive fails, in both the
AArch64 and the AArch32 translator. A failure for another reason causes
a spurious wakeup, which the architecture permits.

Fixes: 01b223f895a7 ("target/arm: enable WFE sleeping for A-profile")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4938
Signed-off-by: Frank Mehnert <frank.mehnert@kernkonzept.com>
---
 target/arm/tcg/translate-a64.c | 7 ++++++-
 target/arm/tcg/translate.c     | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 49472f7d97..45f3b3df03 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3531,10 +3531,15 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
         tcg_gen_setcond_i64(TCG_COND_NE, tmp, tmp, cpu_exclusive_val);
     }
     tcg_gen_mov_i64(cpu_reg(s, rd), tmp);
-    tcg_gen_br(done_label);
+    tcg_gen_brcondi_i64(TCG_COND_EQ, tmp, 0, done_label);
 
     gen_set_label(fail_label);
     tcg_gen_movi_i64(cpu_reg(s, rd), 1);
+    /*
+     * A failing store-exclusive means the global monitor was cleared, which
+     * generates a WFE wakeup event.
+     */
+    gen_event_reg();
     gen_set_label(done_label);
     tcg_gen_movi_i64(cpu_exclusive_addr, -1);
 }
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 442c34ce84..2eef2ceef2 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -2137,10 +2137,15 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
         tcg_gen_setcond_i32(TCG_COND_NE, t0, t0, t2);
     }
     tcg_gen_mov_i32(cpu_R[rd], t0);
-    tcg_gen_br(done_label);
+    tcg_gen_brcondi_i32(TCG_COND_EQ, t0, 0, done_label);
 
     gen_set_label(fail_label);
     tcg_gen_movi_i32(cpu_R[rd], 1);
+    /*
+     * A failing store-exclusive means the global monitor was cleared, which
+     * generates a WFE wakeup event.
+     */
+    gen_event_reg();
     gen_set_label(done_label);
     tcg_gen_movi_i64(cpu_exclusive_addr, -1);
 }
-- 
2.55.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0714C369A2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 02:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2LXf-0000s0-8y; Tue, 08 Apr 2025 22:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u2LXd-0000rD-5V
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 22:51:53 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u2LXb-00018s-Ng
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 22:51:52 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-227aaa82fafso54092225ad.2
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 19:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744167110; x=1744771910; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yRx0l1L38CJZ6hR/oSAgykoMwro5gt/zxtwEU7Os2aE=;
 b=MOR3XBiTT8OYwkGHRJH/CkQEL46XzFWWbsGo05MuUNYRAChVAQrNRzwjSK25vkckCf
 SIetCPn8Mvdc+iw79o5C/1Vzx0+RMS5e7/4uK6G6CYRqJPrkEEfPjS/o6oFZaN5fwsSl
 oRT8lRkpDZCExMz4cvF7g2og0Hz385ij0D1hmUPYeq4ix5iWnYpoaYSuAU2vCsGdC0lX
 NveTHJRH3nLcIBhxh3eJGEPVn8eILmZC8B0t5iqNFBTxZ7lupzWj5M64U1EuaiEYiKH1
 itxP2oSepm4OsVnA8CGkW0GNQ1jc/d56LEteHRbCpEtJ2I7qrKWX/FzEEpdiftPIAiON
 JNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744167110; x=1744771910;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yRx0l1L38CJZ6hR/oSAgykoMwro5gt/zxtwEU7Os2aE=;
 b=d5oVS4RgboEproeLT8TFfs7aTcPYYip3HFIyTvOEAcbO+dZmBf/bxNRF1/x3hAzInx
 U86rzUOVGZvVKWVnU/ocjAS+CnY2ZaL5hYMbpxMKeaIRYchr8qqqlRSdK28JhA9188no
 tBW2Kl3js12PVUTTeHY6CZsdfeNJiWwENgPABZUO03cSjRzOwtcRpkVbn+4T7cuEu5vk
 R0ttjoLaZHMZJX/+LoVKTGVueth3zHC2jkPbUfcwDX7lYG1xEieIUQdOa84DBV2jUD8C
 ZOVNXhtblfjMujiE2WDYo5z7kp2krV1535S2qUkHasG+wUEZOGUKk7fb+CkCOC79Aqwa
 c4cA==
X-Gm-Message-State: AOJu0YyF2QWhqTvZ69L8kFa34nmkrvaSz9k4+3h0YaNvs9gY2XqEOOj5
 jLMHTpdMZjl3QhvDKu13CebLIZxktCA8kGh6KifEvimK0wKQJdq7TaryY+lnG2GNX7CRNouto3m
 zwEH9fAU/MbTXnwZo02GctWY3n+zTmO2poPj/Ooxr8mONGm8clo0CvubHZgMm/4AaaT7QMbFf48
 FLBIm20E2MPQ+xz8Md5m+TL/sPKX130quUDg==
X-Gm-Gg: ASbGnct01yMeH0Fs3aTefuekRUriBWeo+hBpf4bunIOuMtpoEgwK0ZQwzaJfdbd3JVG
 AVyyHyQ9YWBc62fMOUzhg4kmebhN0MuF5yAWPnAuIlu7Vj3AacXC8w2mAECcuTffa+y75ancYYy
 7xRDsMX7GiouBxsIT/MBwQtrR4ECfw5UEIQVUyyFOXYEm19LEhluKCy1ul7EQvIc707z3E/F34g
 lkNc+PxuvGTqEznJrFMowoSdtRvZoOKTQxk0BlW/1T1/nHtWtyDHPGxbAAxM2nh5CnG76bYeaYj
 rCgPua+JTkWTA89pTcGofjnmIqq6YUJ6M6L1waBNc9VB9mWxE6bhUOQY3SVcXGk8H2k=
X-Google-Smtp-Source: AGHT+IGRUXOuHV5k9iXh7SQCDO8A9xOvUc5azGqlveS/QbakTaTBbUMMC+pp/tmf3CftcI1EnyaiQw==
X-Received: by 2002:a17:902:ccc8:b0:227:e7c7:d451 with SMTP id
 d9443c01a7336-22ac3f9a8fcmr17212835ad.29.1744167109526; 
 Tue, 08 Apr 2025 19:51:49 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7cb5463sm665725ad.195.2025.04.08.19.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 19:51:49 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 1/4] target/riscv: Add the checking into stimecmp write
 function.
Date: Wed,  9 Apr 2025 10:51:28 +0800
Message-Id: <20250409025131.3670-2-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250409025131.3670-1-jim.shu@sifive.com>
References: <20250409025131.3670-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x636.google.com
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

Preparation commit to let aclint timer to use stimecmp write function.
Aclint timer doesn't call sstc() predicate so we need to check inside
the stimecmp write function.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/time_helper.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
index bc0d9a0c4c..aebf0798d0 100644
--- a/target/riscv/time_helper.c
+++ b/target/riscv/time_helper.c
@@ -46,8 +46,23 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
 {
     uint64_t diff, ns_diff, next;
     RISCVAclintMTimerState *mtimer = env->rdtime_fn_arg;
-    uint32_t timebase_freq = mtimer->timebase_freq;
-    uint64_t rtc_r = env->rdtime_fn(env->rdtime_fn_arg) + delta;
+    uint32_t timebase_freq;
+    uint64_t rtc_r;
+
+    if (!riscv_cpu_cfg(env)->ext_sstc || !env->rdtime_fn ||
+        !env->rdtime_fn_arg || !get_field(env->menvcfg, MENVCFG_STCE)) {
+        /* S/VS Timer IRQ depends on sstc extension, rdtime_fn(), and STCE. */
+        return;
+    }
+
+    if (timer_irq == MIP_VSTIP &&
+        (!riscv_has_ext(env, RVH) || !get_field(env->henvcfg, HENVCFG_STCE))) {
+        /* VS Timer IRQ also depends on RVH and henvcfg.STCE. */
+        return;
+    }
+
+    timebase_freq = mtimer->timebase_freq;
+    rtc_r = env->rdtime_fn(env->rdtime_fn_arg) + delta;
 
     if (timecmp <= rtc_r) {
         /*
-- 
2.17.1



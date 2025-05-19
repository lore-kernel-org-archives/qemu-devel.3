Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8F2C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 14:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH1ai-0001kB-2M; Mon, 19 May 2025 10:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1uH1ag-0001iE-O2
 for qemu-devel@nongnu.org; Mon, 19 May 2025 10:35:42 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1uH1ae-0007QM-OD
 for qemu-devel@nongnu.org; Mon, 19 May 2025 10:35:42 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-742c3d06de3so1838795b3a.0
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 07:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1747665338; x=1748270138; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yRx0l1L38CJZ6hR/oSAgykoMwro5gt/zxtwEU7Os2aE=;
 b=fhKQYKX+eayeDv0xnVm4QBnTUDkIQxG0jrR2OiugyRG/zic8/aJmGP5hV6yfoaIbjA
 NPjlqTjFTiTz6oOhu5dFdX8Gx7fpuxMBMpFFzdOmzbMPCo3brK7fCFKCj/IaaAU2Qn4d
 qgPO2nPpaYqmXAcz1YLnMZjmY1mQUgGrfBoKp/jDZMWXqfduumO1A3KoYLpbYGmHJQmR
 hW+4g8P5M+Hh8t6vWsLHUMxTMwWTL7KjC0Ky9St7gcjSCZzpdjXnR63VniiwvUIztUCR
 RQiHIVY8tv5oWIBl8qu8n9XPISUMOuohySaXaJ/KP8uRpPCILgel7OVhOOAV5/JESjrj
 blpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747665338; x=1748270138;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yRx0l1L38CJZ6hR/oSAgykoMwro5gt/zxtwEU7Os2aE=;
 b=bl2s/MCJmx6Yw040K37hye2YpCFlqEGyP0WtDDqV4zDNnRf+yE4+i8dt/pjJFhiyMf
 ewD0D3M81G6WAJzCrSc7FwnXqvb02a1GSiww840WYqfrdnqQAfj9/wqE5GiPM9UJ5cBC
 qiXZGV/slhXMtbZwwjkZtEqsdRaJz2llRWEMq1bxSi/5KuKi+M4Ox/nA6HG/mXZ/6wNI
 e2PhEQ/iPAFQ4NvqPLuWU/ScTRGVGXusEzzD98ok+np1O2kZV9Xf2kmxTQtGGoLJA1mS
 gWEZAlZhO4vQOVyl5BcgfHOrYUb7deY36oRqhWJ1BCkRA99zbblQMo/X9UzeHMfu1Juv
 xKwg==
X-Gm-Message-State: AOJu0Yxjc1oWKRyyrNDzJ+0S7bwP8xRWNYzSymbWo9S+/WHY6ufMPGQs
 VQq8nCm7nvhLpUApZHful0CUxL3YiMKh4ByOze6v8C3TQ4WWfkY9fDTKuJ2pwflCYVODB9lucQu
 Z2Ju8feeJFfv3U0w4YahxAKUiUEGTI8QMzN9R0G1vZYYjYYS623nC5bx7vPlDZGNhd+i2b92yTo
 dRJjLyiDI+TO9ZL+UyIrVgolhPKNUu1KE25gBQNw==
X-Gm-Gg: ASbGncvPcIPoJrA5f4LmBhGske5a1WqM1gvqMxgiUGqMOmKVxzzQjxDl66VsQLszRMM
 YYbzeGS5l0D82XXlt7Bcp7286UPELCB5ud9NbtewL/qU/myRvs1J5DND1ydi8rzdYdukjYHiwmP
 2vIPzXFWd1JlmDB8/Tg6mvyDWIwpY7TOkkFISnoRRrJrPe6npRYht6sGlsEQ4nuxSQL0u1MwPTr
 lwEPhXAJLEbEjsUjEVd8+Ep5Y/Hi1Ag/s3/vtYGTUDT2R5qL0Ux9Ra8RNf2PYAnXAMM95A2eiBU
 w1ed2KZrIBfC7UZAAdk7HAIeEVhQvNiV5aGfQSf62m85fXnLmIgp4naApnkjsXvgJpVKOqqBz2K
 xLqpATHnW
X-Google-Smtp-Source: AGHT+IFj0CtaR0gsxA+LzAcZUFHAdy8ieb+frcQlTqBqPJJG+qHyboqJgvidn+oYUTDxQx9ztejnoA==
X-Received: by 2002:a05:6a00:a81:b0:742:9f58:ccce with SMTP id
 d2e1a72fcca58-742acce364cmr16851293b3a.12.1747665337255; 
 Mon, 19 May 2025 07:35:37 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a98a32edsm6297683b3a.162.2025.05.19.07.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 07:35:36 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v3 1/4] target/riscv: Add the checking into stimecmp write
 function.
Date: Mon, 19 May 2025 22:35:15 +0800
Message-Id: <20250519143518.11086-2-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519143518.11086-1-jim.shu@sifive.com>
References: <20250519143518.11086-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x42a.google.com
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



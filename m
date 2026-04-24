Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12974FB44A9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 05:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8jC-0003vA-SG; Fri, 24 Apr 2026 01:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wG8jB-0003uH-5y
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 01:05:21 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wG8j9-0005pX-MZ
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 01:05:20 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-824c9da9928so3750399b3a.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 22:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777007118; x=1777611918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eggucli4qTqnT+0XjlTx/9JXPvjlpybl8ngBYSrfqOw=;
 b=koBfIg+Cxlttp5gmfxOnRtfI9UOVRP3ZP4eO5zeW+2sFKi+xohdiCEosmyzU9dtnMT
 hQwv9HYhq3MU6/I9LtWAPIUYUlO8i9ogJ9Ttmm4OOrlsa5Zjgfxut7Bi9rIkl9U29fsF
 QNTBdEGl32kQ9VqGBvYwaNNmKd8Qa7cFLNtSnUVn8X/DAjNenIEnBkVyJPnq0Ap+fn7l
 I8f0V4Zq1y6ZVjTJxvaUI4aR65PcC7A1mKme7JK/9GIaRfMg/Qh4wsuUowmiw3g3NBG6
 pa7hXsSVOn0BA0n95VZW9H5+z3NGJeTf4h6VjbnzghcNKcocmQtq65UF9HBAc+NXyq3Y
 IdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777007118; x=1777611918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Eggucli4qTqnT+0XjlTx/9JXPvjlpybl8ngBYSrfqOw=;
 b=GO7+VJAXFUoB9jZGmSm2OxdRleAJEAPrSy1ms/IrFx/5HXU17E42xtppHQgD6uOO4W
 uOJ1covNZ49nwe1w2/cFZQfC5yL3QY00qwnpP5DNssl/CW/e9aahIBJ4JqHyCR3sC8pf
 BlZ0rEDCeDkmuS3i5+XbmBDtcMwwyXv2txSYLjq1hinKlOr4FFzFgxYfKKmDKt2bhMDA
 /rvxrBD8BXX3rRXPcH6p81E1r7AA2azxGCBfarD1Lvm2W1TL99XavIjBiqon7xJJoUvT
 TqDhDRKHbY/72KF3m6N8FL7P7jK07h7UO/muY8a4FwfiA0ltBN4uc0Lr6nCg4viaOCGJ
 KkXg==
X-Gm-Message-State: AOJu0Yx6pjLIY4t+RpCU59ro7uXPAmLrXnITztt/2Lyb+kMWcK/sBDmm
 2pFGwDJ1/pVdXbFqF/PoIeFIOOjoP+4GA2GKT4Gw+nnKPscQ+Z9ouF6lDNaoIZIjbUqYoHJrI++
 txJlBT7RO5+SXdyqWdV3+1EySuPtXFmLjW5MS31xvWDV7u2xCSm4nkttUikSa7cgdZof9ccNrYF
 AWM+5l5dWsCwyd1Xd/LT4Jch/l+kaHRsAoUstKuy2m/uF4v6dX
X-Gm-Gg: AeBDievIVXx86MloM4r7Gu+SUwEAzMViCP4IbryOPpQR56AY558CYBvWe8JQm1/XpRS
 lNC0Gsoolw0UWuZG5K/XRdyLbnGNn5mMa+0sMump4u9ImmgH1hJmEz20DtGCl8s0kHnb2UJIIjc
 PIwDudh6tOcgUEP9S539oR/8xL++eN242c+fFdk+JF/ekbyBueKTEpg6MrefYSXtQQVhhUJ4Xol
 q9fGCcYnMn9rfoIEUwToEqAsYXgOd57Hkny5+QgUAuJIzki5NeM//dqtZBkyquhEkMwHs5FPbDP
 oSK+sey29TZJF6yoaOM5FSLkW0FKmIwDi1X1NwdxVjRz4GQzhJkAYxyjsjwqw+ndwp2HDLq1R1k
 CzIh3dIucRnD82Fogps2bRDnW5/IaBJJWBBp+TqEFIHZa3uzluAUbOSae/s5JH1HDLBxdEQ5U7K
 UC1Jcec2ZF47hSovoarTKzHIyunVuHujy1U/qBu/jVmzATbWj7JFvUnCichntX
X-Received: by 2002:a05:6a00:ab8c:b0:829:800b:9fe with SMTP id
 d2e1a72fcca58-82f8c99a9a3mr32737654b3a.39.1777007117407; 
 Thu, 23 Apr 2026 22:05:17 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e981992sm26698554b3a.7.2026.04.23.22.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 22:05:16 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v4 1/2] target/riscv: Update MISA.C for Zc* extensions
Date: Fri, 24 Apr 2026 13:05:08 +0800
Message-ID: <20260424050509.3935180-2-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424050509.3935180-1-frank.chang@sifive.com>
References: <20260424050509.3935180-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x433.google.com
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

From: Frank Chang <frank.chang@sifive.com>

MISA.C is set if the following extensions are selected:
  * Zca and not F.
  * Zca, Zcf and F (but not D) is specified (RV32 only).
  * Zca, Zcf and Zcd if D is specified (RV32 only).
  * Zca, Zcd if D is specified (RV64 only).

Therefore, MISA.C must be set according to the Zc* extension rules.

Warn the user if RVC is explicitly disabled but MISA.C is required by
the rules above.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/tcg/tcg-cpu.c | 39 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index f3f78088956..5db166c01e9 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1163,6 +1163,44 @@ static void riscv_cpu_enable_implied_rules(RISCVCPU *cpu)
     }
 }
 
+/*
+ * MISA.C is set if the following extensions are selected:
+ *   - Zca and not F.
+ *   - Zca, Zcf and F (but not D) is specified on RV32.
+ *   - Zca, Zcf and Zcd if D is specified on RV32.
+ *   - Zca, Zcd if D is specified on RV64.
+ */
+static void riscv_cpu_update_misa_c(RISCVCPU *cpu)
+{
+    CPURISCVState *env = &cpu->env;
+    bool set_misa_c = false;
+
+    if (riscv_has_ext(env, RVC)) {
+        return;
+    }
+
+    if (cpu->cfg.ext_zca && !riscv_has_ext(env, RVF)) {
+        set_misa_c = true;
+    } else if (riscv_cpu_mxl(env) == MXL_RV32 &&
+               cpu->cfg.ext_zca && cpu->cfg.ext_zcf &&
+               (riscv_has_ext(env, RVD) ? cpu->cfg.ext_zcd :
+                                          riscv_has_ext(env, RVF))) {
+        set_misa_c = true;
+    } else if (riscv_cpu_mxl(env) == MXL_RV64 &&
+               cpu->cfg.ext_zca && cpu->cfg.ext_zcd) {
+        set_misa_c = true;
+    }
+
+    if (set_misa_c) {
+        if (cpu_misa_ext_is_user_set(RVC)) {
+            warn_report("RVC mandated by Zca/Zcf/Zcd extensions");
+            return;
+        }
+
+        riscv_cpu_set_misa_ext(env, env->misa_ext | RVC);
+    }
+}
+
 void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 {
     CPURISCVState *env = &cpu->env;
@@ -1170,6 +1208,7 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 
     riscv_cpu_init_implied_exts_rules();
     riscv_cpu_enable_implied_rules(cpu);
+    riscv_cpu_update_misa_c(cpu);
 
     riscv_cpu_validate_misa_priv(env, &local_err);
     if (local_err != NULL) {
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E05C4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 10:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVqZc-0001Ny-R7; Fri, 02 Feb 2024 05:15:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rVqZa-0001N5-TO; Fri, 02 Feb 2024 05:15:03 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rVqZY-00044Q-5q; Fri, 02 Feb 2024 05:15:02 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a363961b96aso252869966b.3; 
 Fri, 02 Feb 2024 02:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706868898; x=1707473698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=35KlG4lxWGB+IVYTpJCq5bUQHasC5kF9tmsJR5Sh+eQ=;
 b=nk8s4k+JIZI8UOP4KKuo5jluznT22MSOTiWFskxzjK+l4c0FH4wa+FmL8Fg+D9CB0e
 nep1Avz31mtSNjZgnf1MQG0vZFp023W6+R5EnnyQd98UT5qxGnfyrvb6xlV+okBsxlqM
 4V5GLSDRBEKn4isLRwbrc17pbJt7Cy1g/uuHGZRa89APXJML6aDG+4xopn1DrhkXpMw7
 Y3bSguH3vG9DC1mPF1JpIvPk6gAE+z4evbb6HrYQXm+k69QD9xyTj8UT/h1mSAaRRH/U
 fB/V02VnoCBbgMCqXhEe8lvaA2t+m3lKrbSRQ1gnhugmhU4KAki8gFvKjNOm3RACAEWW
 qYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706868898; x=1707473698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=35KlG4lxWGB+IVYTpJCq5bUQHasC5kF9tmsJR5Sh+eQ=;
 b=YKJjw1UTubgyv0r6QwBV0jYSpu/Yu/ls9DDrgC5Hk54ak3w2fAnWRbnIphGfCZpQwQ
 lh5EiAbVNVwJeGh6kqMOh/ghisJ3mCxUqsRZY2uIwacJZgGOFwCzfmGEG+K31+M5T7Y4
 BWEuPstCsV2HveBVR42QlmF7NUCUdBK0AhDZc7dStOIH2jCG5qQNcjMLjkZjIZeMKG05
 WCgyw9U3lDXKdbWXW7uVCmTWTgZlBnBEOHsq5lrImVji6vBdbiF4WCIDPl4/AOasOB9/
 nJzpq8/gTdrXdH8WUuguvSdJTX54On8lQAsel8P50fmmoc9lDmCMnlG3njrG6oHLQ1/W
 tjeQ==
X-Gm-Message-State: AOJu0YzhLwVHAZ9HB+l3YRHEzys7FOXnhi60SKsCocQ8O7cqZBfUllXB
 qWiJklvKUZFTG/3olSbhuIFV/0x9MjCGjr2JrRhHO5DQJQhAzEmn
X-Google-Smtp-Source: AGHT+IE+nKCsGYzHY4F0kXl9Ylg6lsKe5K4MYxPc1EjpxHTYJIe4qTuVhRis2z34gOD15xorZiJU/w==
X-Received: by 2002:a17:906:4746:b0:a36:925b:cebc with SMTP id
 j6-20020a170906474600b00a36925bcebcmr5273142ejs.34.1706868898487; 
 Fri, 02 Feb 2024 02:14:58 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCV+ZoTVQtAYLyLLcSD0cuf8BnIDPdcAKwXTHRto2N5st1f3zAKqHgMB/9vfLEL8FhImuR5tyfqUs87BxPgA8kib77dljLV6dJBA5Fc2uNl1oSqWjFyenWKAuvh0/5AaNC1epL+bH1VzR5MdtVjbOtPyWxEEWwyrVz8VJeANru/ikrPu9usaAJjiZnMOt/Rpn1EHlvBrWUDjY3ZRiY9LXAMeSq8v8vl2X8ZGILcuTs89n4Rtm9uZxCTKDNgFKW5IuCwYJcANZZYTVqaP+d0p5WfHcI8IoYQxmb8kM6AKU8ZYqVGANxD34uBWst+zbKTzQgfAkfEnO+ADG51/xMmeUHCHTRiMevzpQQV/kn49fRxby4z84rTie8rO80k=
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 ll5-20020a170907190500b00a36fe6fe976sm579722ejc.190.2024.02.02.02.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 02:14:57 -0800 (PST)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v7 3/6] target/riscv: Add helper functions to calculate
 current number of masked bits for pointer masking
Date: Fri,  2 Feb 2024 10:14:36 +0000
Message-Id: <20240202101439.3714106-4-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202101439.3714106-1-me@deliversmonkey.space>
References: <20240202101439.3714106-1-me@deliversmonkey.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ej1-x635.google.com
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  4 +++
 target/riscv/cpu_helper.c | 58 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 4c0d7142a5..23a166a91f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -699,6 +699,10 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
 
 bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
+bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
+RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
+int riscv_pm_get_pmlen(RISCVPmPmm pmm);
+
 RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
                            target_ulong *ret_value,
                            target_ulong new_value, target_ulong write_mask);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index aedd5bef50..bef7917668 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -142,6 +142,64 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     *pflags = flags;
 }
 
+RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
+{
+    int pmm = 0;
+#ifndef CONFIG_USER_ONLY
+    int priv_mode = cpu_address_mode(env);
+    /* Get current PMM field */
+    switch (priv_mode) {
+    case PRV_M:
+        pmm = riscv_cpu_cfg(env)->ext_smmpm ?
+                  get_field(env->mseccfg, MSECCFG_PMM) : PMM_FIELD_DISABLED;
+        break;
+    case PRV_S:
+        pmm = riscv_cpu_cfg(env)->ext_smnpm ?
+                  get_field(env->menvcfg, MENVCFG_PMM) : PMM_FIELD_DISABLED;
+        break;
+    case PRV_U:
+        pmm = riscv_cpu_cfg(env)->ext_ssnpm ?
+                  get_field(env->senvcfg, SENVCFG_PMM) : PMM_FIELD_DISABLED;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+#endif
+    return pmm;
+}
+
+bool riscv_cpu_virt_mem_enabled(CPURISCVState *env)
+{
+    bool virt_mem_en = false;
+#ifndef CONFIG_USER_ONLY
+    int satp_mode = 0;
+    int priv_mode = cpu_address_mode(env);
+    /* Get current PMM field */
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        satp_mode = get_field(env->satp, SATP32_MODE);
+    } else {
+        satp_mode = get_field(env->satp, SATP64_MODE);
+    }
+    virt_mem_en = ((satp_mode != VM_1_10_MBARE) && (priv_mode != PRV_M));
+#endif
+    return virt_mem_en;
+}
+
+int riscv_pm_get_pmlen(RISCVPmPmm pmm)
+{
+    switch (pmm) {
+    case PMM_FIELD_DISABLED:
+        return 0;
+    case PMM_FIELD_PMLEN7:
+        return 7;
+    case PMM_FIELD_PMLEN16:
+        return 16;
+    default:
+        g_assert_not_reached();
+    }
+    return -1;
+}
+
 #ifndef CONFIG_USER_ONLY
 
 /*
-- 
2.34.1



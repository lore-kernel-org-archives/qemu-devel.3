Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB26C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 17:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmzap-0003EC-Ir; Wed, 20 Mar 2024 13:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rmzan-0003BF-Gh; Wed, 20 Mar 2024 13:19:09 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rmzak-0006dK-Pr; Wed, 20 Mar 2024 13:19:09 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-56bb5d61c5bso8265a12.3; 
 Wed, 20 Mar 2024 10:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710955145; x=1711559945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nSE+cP7Lt5Sq8d6PTtVQTI1qKeIysjk+nWyIdSqtTIQ=;
 b=B15JFonr5OxZPdKSTIXMOO4/ZV9xYmyCns758t8g4FRY4Tacs8rfre5iABvYQAdfuj
 XZUcBIDKhlxBbBI11nBetkM3dlDEpYUmXF52BxQvjQpHIls3PQ0jnqnttzrADBTd1eMB
 JZ04vOhJii55MethWn+3xhmWLo8PfiXhMnTHczNRVsMGW1zTKSRz5u3wUkp1UhgO5tZ9
 ZCtj+AGg7m8SLSdoK8C1HQUqX33ZaMM2swMobtX5SkkG08cGhAIYCzWvRGT8NEU7mIyg
 Dj7nwhtXhiZNKlHalhGgYm9Sl7gpGtRDQjk2aMzOnK7mrAwlmW+W0JnzPOzaTXl6KKD2
 F3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710955145; x=1711559945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nSE+cP7Lt5Sq8d6PTtVQTI1qKeIysjk+nWyIdSqtTIQ=;
 b=FIpmUEWsbSpjnBXrLohaw3yYR2WhUXJpzyQg+m7TrclPQfk1PuuCOQfqaDF8vBI7BV
 zBtp39dMqkgdCHwv7ESGAlj4zCzEM+Ax67WfBd+zB6dqwpOdFEa0n8wcMvdXdcnpKkUp
 OjU6Xd7O/Mfy9ouSQRE3UeutpSGR312fWhV2SVsAE02W1kLhpz6wntrU+OcpQlpfzkNz
 goMwebgFbvNNg1bN30w6VapQrvF2hQVxq8q72LINqeiggyVCFusvlFzris1bZLFjw4tF
 pUIbsJuQOUSJ/1WewbD8ImypwyGRes+GgfNQsuYhrIxzVCFJGHk2GSlq0N5MUBnhvawQ
 pX5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDXzsZsYamifE4A6WAdsYBeVtfiMEyzXZvicBcQlF2PeMF/tOllitCm1GNJKpdcTH05yuvf1/hZWtBJ+2jWd2uW2HewsBn6YOAtWYiFIlPVzuXglsRszyIb43ZHA==
X-Gm-Message-State: AOJu0YwP3ub/aNFEXY7AxQaJVhaR4rQpsT578TKJW/2FkFQa6eUVCb9+
 Usnf/iHalSRLFy04uvuzGOHWfCKMIvQ4v2iGymaAmJGzdfJYXNeg
X-Google-Smtp-Source: AGHT+IFIenEPHdDGHL4L+xANfAS8jS9IfYxYdqagoJPpZJ1CudU1wqAPf0K+ImqB/8gHMJbnYIAq4A==
X-Received: by 2002:a17:906:6bd0:b0:a46:f58c:33b1 with SMTP id
 t16-20020a1709066bd000b00a46f58c33b1mr1746758ejs.7.1710955144921; 
 Wed, 20 Mar 2024 10:19:04 -0700 (PDT)
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 pv27-20020a170907209b00b00a4576dd5a8csm7481639ejb.201.2024.03.20.10.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 10:19:04 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 space.monkey.delivers@gmail.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v8 3/6] target/riscv: Add helper functions to calculate
 current number of masked bits for pointer masking
Date: Wed, 20 Mar 2024 20:18:47 +0300
Message-Id: <20240320171850.1197824-4-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320171850.1197824-1-me@deliversmonkey.space>
References: <20240320171850.1197824-1-me@deliversmonkey.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ed1-x534.google.com
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

From: Alexey Baturo <space.monkey.delivers@gmail.com>

Signed-off-by: Alexey Baturo <space.monkey.delivers@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  4 +++
 target/riscv/cpu_helper.c | 58 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b694cc62bf..0112b568a0 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -700,6 +700,10 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
 
 bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
+bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
+RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
+int riscv_pm_get_pmlen(RISCVPmPmm pmm);
+
 RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
                            target_ulong *ret_value,
                            target_ulong new_value, target_ulong write_mask);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index d20bffdd5a..a563451c48 100644
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



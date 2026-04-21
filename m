Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E94F327BE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF60x-0005Hu-0b; Tue, 21 Apr 2026 03:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF60v-0005HW-Jt
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 03:59:21 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF60u-0007wL-52
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 03:59:21 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c7973f67f4dso1082143a12.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 00:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1776758358; x=1777363158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QEN+V6H/PD3ALJSA/+Yu9m43zcSAy8WYVYhAOTpu1zY=;
 b=BfOZDaOHr3nvQKtbQ9Zzp1CrEe3J1J/uFTHwuBvrSkPbG2F5EcMNVLcQOm3oAFuhEz
 styR8AIXbiJLeYJNZloo82g3lsnxgHStsnyASINz18HK94a2ZdlNWS9yy1+q5xQVDzor
 WZAIgZwfprx6VyuY4e+I5uyjxF6kBeMbyjJkl1rClFMfsyIUBvl+hJQs811HQpQ0L0wH
 uLdcBmjqhDPb6KQXqXNoyVFm6yoMcljotZKhMTPQHBr6dLckomvjb/+GKz+F0Pg21s3z
 koryPboCwxK4SPxMjiBjY8Xw3PM87PUdSSWBulKMewcuen5MIdYUM1Mmj2Q5C0NbtJGI
 bdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776758358; x=1777363158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QEN+V6H/PD3ALJSA/+Yu9m43zcSAy8WYVYhAOTpu1zY=;
 b=kIUYMjZEw6DSIxLozUMERhQJdbinAQGyJJyyADoZsytMajOVVEdWK2NvsOkBn251Kh
 aPVe7Y1KoAXsSkIiFPTvQOn4Zgd9mGFx2RODsHqFY0+f+Q5zoucVNIglAZP/V9ZrMuev
 jJL22e+kPtU300B1tlUFdPdE/xE8UgBK+mh6NiF28KsYx8+DQL8lOVmDuit6EynUOMXt
 ckRc8ee/7rdtEsupHjezZoKi+JNX4qES+yau11k3VJuu5H68JWSOIfaKkGTuIOminNf7
 meLfE9gj0agYTb03xqdnaNo+6oAQ9v0IwoJ3yXPuyqqnPdnzv/5m60K1ki5BmpfgD5c6
 2Dlw==
X-Gm-Message-State: AOJu0YzSOcSUYEqLnja/WptgURQAV+O9WLwO3nvD+HWBLx8wO8TBIbTG
 aywJAtdc9PUGCj47Ahj9HypFDeVP1gPHx73shDDuxSyTLWZne4KS2i3CupAGZbHXHwJnvxF46Jb
 Xe4BQ3KYW5T7QR9m6gYRq5et8WpAjD86THadbbV5nUaxjCAyyh876fC+UtWCR/fvFkDnjS+4y+o
 1X3aiNcYgucrL4nfOzzckHRDMdZAXwN0JCuciFJuOO5V5CC9QJ
X-Gm-Gg: AeBDiesNwP6dr5S1/2xt1PVops2sINLNU8aaXOPInlvNSbC/TbkMR3UkD8R0FJVkHQA
 ZF/rXyGZ0ot+sj162QHQBmDWWKF12bBQoqBxp52x5pGCK/PHyLwOTi/iAq03KbBwYi4CnjBfsNR
 YfIbpVmzM+siNe//a6M+klsHqGpV/fuRIOYLowetkQAgU7KKxsPK0QNDdcdtYtkcaVdpS8cFZSs
 aj3jBza61mblpZb6zvyUpA8ZCp2l7kGHjNF/2MqkRi9zJ2bZ3XZC6FaXbLm1cdEyujZsUfAPswM
 8hZelnTaPZqvI4SG8Lvdydp62ISsTUiIdPU1tzU58F4BFTNUylgUhzyeCgDbPCE10YDSdLHLMd2
 akgjoySRCFzrzpUKAzwdbv0rqWc3zNUrTW6zwinkQdo2BlT5Rr0h2l4p58qAdcTOPWT11fcsQxy
 zeyt4BdgjSU0BVx8GNI8RUp5gaMh6lGIPpFendWGomZlAhxO3g1isLeJ+qjeX1
X-Received: by 2002:a17:903:166e:b0:2b4:64cf:e8f8 with SMTP id
 d9443c01a7336-2b5f9dbcd22mr160355305ad.2.1776758358147; 
 Tue, 21 Apr 2026 00:59:18 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa9ff729sm155605695ad.15.2026.04.21.00.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 00:59:17 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 2/2] target/riscv: Update MISA.X for non-standard extensions
Date: Tue, 21 Apr 2026 15:59:06 +0800
Message-ID: <20260421075906.2928317-3-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421075906.2928317-1-frank.chang@sifive.com>
References: <20260421075906.2928317-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x531.google.com
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

MISA.X is set if there are any non-standard extensions.
We should set MISA.X when any of the vendor extensions is enabled.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.h         |  1 +
 target/riscv/tcg/tcg-cpu.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 4c0676ed53b..175e877f90a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -69,6 +69,7 @@ typedef struct CPUArchState CPURISCVState;
 #define RVH RV('H')
 #define RVG RV('G')
 #define RVB RV('B')
+#define RVX RV('X')
 
 extern const uint32_t misa_bits[];
 const char *riscv_get_misa_ext_name(uint32_t bit);
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 0f68560bac1..44d948b5dca 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1194,6 +1194,20 @@ static void riscv_cpu_update_misa_c(RISCVCPU *cpu)
     }
 }
 
+/* MISA.X is set when any of the non-standard extensions is enabled. */
+static void riscv_cpu_update_misa_x(RISCVCPU *cpu)
+{
+    CPURISCVState *env = &cpu->env;
+    const RISCVCPUMultiExtConfig *arr = riscv_cpu_vendor_exts;
+
+    for (int i = 0; arr[i].name != NULL; i++) {
+        if (isa_ext_is_enabled(cpu, arr[i].offset)) {
+            riscv_cpu_set_misa_ext(env, env->misa_ext | RVX);
+            break;
+        }
+    }
+}
+
 void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 {
     CPURISCVState *env = &cpu->env;
@@ -1202,6 +1216,7 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
     riscv_cpu_init_implied_exts_rules();
     riscv_cpu_enable_implied_rules(cpu);
     riscv_cpu_update_misa_c(cpu);
+    riscv_cpu_update_misa_x(cpu);
 
     riscv_cpu_validate_misa_priv(env, &local_err);
     if (local_err != NULL) {
-- 
2.43.0



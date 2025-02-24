Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A6FC021B5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 08:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmTls-0000Lf-6F; Mon, 24 Feb 2025 03:25:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tmTlp-0000Kg-TZ
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 03:24:57 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tmTln-0001D9-Ng
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 03:24:57 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-220d28c215eso60738285ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 00:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1740385494; x=1740990294; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=i6yarlSFGT+UKPKTiZcWyZV6IpwfiTEwTc/5lhIQVPQ=;
 b=kSFvly8Js8m5VB5v52rP4KDY6Wv219JulweWb5Z0Q6/vKFscEni4rUwXydJypskdGn
 NOcWQhdUfbQnmW2i49L/yi7lkSj+P+T6reL2GyV9d5cdkxs6x+BtOL1EOIA7n6LZ4BdE
 LsV+BlShdMJLlWXWjHYhbpYWPe3XBH3q44VPGQpjwF9dFAjAUW3HbP1XD25YD0ztB3hd
 so3d+K25J9Z1Rf5+9aNtzIvagr0YP4UeNodzRGKLuYrPdfWy+Vd3P+FWDmHBHkFuD9mA
 wcGfBdwrvRXM/lsHm2FkbYqV5jujnXSm1PF/KrTBr9aY1s1jEvHKrh2FL5vMEDRgsadH
 yz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740385494; x=1740990294;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i6yarlSFGT+UKPKTiZcWyZV6IpwfiTEwTc/5lhIQVPQ=;
 b=I/oR8VYbdKJiBAVjuJNimADtBOpK1E0GX1DJqKKgqO4hO3HYrs6cV/NlZeC03ctpi8
 1IWEJG7pI6Mk+7KCoqKCQYZlyMwHVZ+nMr1sALHGnRSw099QcOcEPitPuMn102YwbVTe
 HzzXjO/tPSEmlch7trpPTVK4tZg6suDOISkUP/nSsgdwPY255Rb2sH/yneIFvOgvJ2u1
 NvJUY3q8yVz6fX42Bd/MSV3YwIBEI+yYFYf67WRr9IlUWFXsEuOfr2EBQG7prQdosIAL
 zK7kPNM/cRlMc76aozZWSkSHkklXH0GF2iLs6i1KX5n2k88rqogVQ6FMGDpZbOQGYTdZ
 GnVg==
X-Gm-Message-State: AOJu0YzlPVXwj0uKVHcIwgqyIK9qb91bXStt5CSBEPC5ZJsi7SaC4p5p
 2LfDikWx7gAx5nJ8W+RvC0KPx4r8amVx6P0IQfsJfkZzLtw33gclU1gf7MwmodhHYhEDzztWAXz
 tE2Fqbw/iVWlQEflHDM7IJfmu8kkuES9gLwr+bU2YxLg5/sH8nJ6/sAxn1I9brY/deVHrZ38Neq
 BLXk46ppBtf9BUoTee/ndnUrCg5VtsCNWlqkiyf5w0dg==
X-Gm-Gg: ASbGnct56fjnNdYHlqAZFVb/67gdx2TSPTo+KSva10mZM8hoxjUx7PKEZZwhArDEP+U
 aVj0fZqQN5q4V5G+AvA6/JIBo3BRiW+BgzzKnm39w8y7wHD+vA0gfZ8KAi7ABfalj2oNAfsg1lK
 D4kdxdhEh5lW79I64iHg4w2Mv+xYtWIjzPK256MUZ6LkxBowYnH42ied5Jq9mgull9UfPKcxgcs
 LyhEEdX8xVohkMN6/sLEkq5lL9AqHdcLJlGKH0czoMd+OczLpHLMveEnpmu2eQKgokuGJfCBd8l
 n4e/OURxEBkdsw7WzRfdkFpwf7O6rCAgknEzXpcqovGSGIBIldE1gXch
X-Google-Smtp-Source: AGHT+IEN6WhuDVC1opB9Lv1QBgB440dTOjy2ZAWhTt5CWVs2Ah8MeYPEpOdsvQxQx2BmvPaFIjYnCQ==
X-Received: by 2002:a17:902:e552:b0:21f:3a7b:f4f1 with SMTP id
 d9443c01a7336-2219ffddf44mr222136295ad.32.1740385493680; 
 Mon, 24 Feb 2025 00:24:53 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7325c88d74esm17714914b3a.149.2025.02.24.00.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 00:24:53 -0800 (PST)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com,
 jim.shu@sifive.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/8] target/riscv/kvm: add CSR_SIREG and CSR_STOPEI
 emulation
Date: Mon, 24 Feb 2025 16:24:13 +0800
Message-Id: <20250224082417.31382-7-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250224082417.31382-1-yongxuan.wang@sifive.com>
References: <20250224082417.31382-1-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pl1-x629.google.com
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

Support user-space emulation of SIREG and STOPEI CSR with KVM
acceleration. For SIREG emulation, the SISELECT CSR value and iprio
array must be loaded before handling, and since the iprio array might
be modified, it must be written back after the emulation.

When running with KVM acceleration, the machine lacks M-mode CSRs and
does not report S-mode support in its environment configuration, even
though some S-mode CSRs are accessible. This patch adds kvm_enabled()
checks in relevant predicates to ensure proper handling and validation.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 target/riscv/csr.c         | 12 +++++++++---
 target/riscv/kvm/kvm-cpu.c | 27 +++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index a2830888d010..594df30c456a 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -27,6 +27,7 @@
 #include "exec/exec-all.h"
 #include "exec/tb-flush.h"
 #include "system/cpu-timers.h"
+#include "system/kvm.h"
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
 #include <stdbool.h>
@@ -42,6 +43,11 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops)
     csr_ops[csrno & (CSR_TABLE_SIZE - 1)] = *ops;
 }
 
+static bool riscv_has_ext_s(CPURISCVState *env)
+{
+    return riscv_has_ext(env, RVS) || kvm_enabled();
+}
+
 /* Predicates */
 #if !defined(CONFIG_USER_ONLY)
 RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit)
@@ -52,7 +58,7 @@ RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit)
         return RISCV_EXCP_NONE;
     }
 
-    if (!(env->mstateen[index] & bit)) {
+    if (!kvm_enabled() && !(env->mstateen[index] & bit)) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
@@ -66,7 +72,7 @@ RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit)
         }
     }
 
-    if (env->priv == PRV_U && riscv_has_ext(env, RVS)) {
+    if (env->priv == PRV_U && riscv_has_ext_s(env)) {
         if (!(env->sstateen[index] & bit)) {
             return RISCV_EXCP_ILLEGAL_INST;
         }
@@ -326,7 +332,7 @@ static RISCVException csrind_or_aia_any(CPURISCVState *env, int csrno)
 
 static RISCVException smode(CPURISCVState *env, int csrno)
 {
-    if (riscv_has_ext(env, RVS)) {
+    if (riscv_has_ext_s(env)) {
         return RISCV_EXCP_NONE;
     }
 
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index b088b947adae..50b0e7c9ff7d 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1627,6 +1627,31 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
 }
 
 /* User-space CSR emulation */
+static int kvm_riscv_emu_sireg_ctx_load(CPUState *cs)
+{
+    CPURISCVState *env = &RISCV_CPU(cs)->env;
+
+    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(siselect), env->siselect);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio1), env->siprio[0]);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio1h), env->siprio[8]);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio2), env->siprio[16]);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio2h), env->siprio[24]);
+
+    return 0;
+}
+
+static int kvm_riscv_emu_sireg_ctx_put(CPUState *cs)
+{
+    CPURISCVState *env = &RISCV_CPU(cs)->env;
+
+    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio1), env->siprio[0]);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio1h), env->siprio[8]);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio2), env->siprio[16]);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio2h), env->siprio[24]);
+
+    return 0;
+}
+
 struct kvm_riscv_emu_csr_data {
     target_ulong csr_num;
     int (*context_load)(CPUState *cs);
@@ -1635,6 +1660,8 @@ struct kvm_riscv_emu_csr_data {
 
 struct kvm_riscv_emu_csr_data kvm_riscv_emu_csr_data[] = {
     { CSR_SEED, NULL, NULL },
+    { CSR_SIREG, kvm_riscv_emu_sireg_ctx_load, kvm_riscv_emu_sireg_ctx_put },
+    { CSR_STOPEI, NULL, NULL },
 };
 
 static int kvm_riscv_handle_csr(CPUState *cs, struct kvm_run *run)
-- 
2.17.1



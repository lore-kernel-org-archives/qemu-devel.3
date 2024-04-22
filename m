Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E9AC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 13:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rytzr-0007XT-DH; Mon, 22 Apr 2024 09:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rytzl-0007JO-Kb
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 09:46:09 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rytzj-0000GC-Td
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 09:46:09 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-34782453ffdso4372791f8f.1
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 06:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1713793566; x=1714398366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tAPZ9edf4TI7D81b9AdMksyI8LjSYzU3sU/h7DSxoJk=;
 b=QuhB5I2y4HZWPQGhk62QVaAm6VQid4+r00zF31KNc9YqA/mnKB+DBqT50G40U8gm8/
 C5Mf9ZBqsKlnEs1rOujOWq3l5a8nOE8kUD3pVff3Mj9vbngKBqKLmPiUM2c/aqJrsAwF
 66c7ZsjHz7SJIdE+7I4viNhsC0ijNIXJSgs2LPv2SCxvAeurchzhF5hudAli1qwzhvXc
 twASTMQESPpw7UI+xctUeKEAgIAzvFqNwjpNLihdTF4B5u4e3N/RC0N7tbDyqaiS20TR
 5kHXJPY5x33jaWAkn5J57wHCeZNWKfee9SBUE8Gjb+WteCesRdMzc6Q2XyRdaCTmoiG2
 uBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713793566; x=1714398366;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tAPZ9edf4TI7D81b9AdMksyI8LjSYzU3sU/h7DSxoJk=;
 b=vKL3djj6c/lp0rbMBP8vNKp/PyhqSNJ9KewgFwvCAPiAmpNdteRgK+mFEhkZM/cH3Y
 x30npH8fiJkRY1ZRdl4pnt2ROmgywtTh3rs48cc/AwNl9AOqxJC+n7pqx8tGrQnKJ3kI
 J5+61qB/VLX8Cp14JHs5EBTZtFpRAzbKpDkMmzAVRzWuTHmXqDHf5nexBOa7GVLoEsh9
 37gOfE7vqBQoRHsO/QB5msTimhFMCUIUcYnPTipHed+ge+mJWGpimk8sIKhr80JWfFmD
 m2M6Q1bdEORVU/kdQWRm8XZex8E45T+c9ec+BzHu+UZvGJG+bite01HFLhvNctAGLBkw
 XgHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURgGc3BYaD0a2C3iT19fJewzV3tW7EgKoHF7967/nL/vjyMMHESyqff4E7+AX2USrcNxtq3n3GB6V7cTDmHtTZv37i5x0=
X-Gm-Message-State: AOJu0YzBfPS10uYZhVJf/tjD61K1pcbrx5tJQTXl2QFoSw9a0kh0pPRp
 XZo2MZgFvEl8wSPj7IORofDc0n1e2FSqtA5ful/RZGQ/awt0oGCm8jIn00dc5QE=
X-Google-Smtp-Source: AGHT+IFpP8swYuoMbq8zgc1WTO7dcQ3sQAf6y/9sfek82t463bps9kgeZ/Z7MTEtXTBQp8u1mTNXVA==
X-Received: by 2002:adf:f38f:0:b0:346:bc1b:4e7c with SMTP id
 m15-20020adff38f000000b00346bc1b4e7cmr7741631wro.35.1713793566462; 
 Mon, 22 Apr 2024 06:46:06 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 ig11-20020a1709072e0b00b00a525492801dsm5774128ejc.119.2024.04.22.06.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 06:46:06 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, kvm-riscv@lists.infradead.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, apatel@ventanamicro.com
Subject: [PATCH] target/riscv/kvm: Fix exposure of Zkr
Date: Mon, 22 Apr 2024 15:46:06 +0200
Message-ID: <20240422134605.534207-2-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x434.google.com
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

The Zkr extension may only be exposed to KVM guests if the VMM
implements the SEED CSR. Use the same implementation as TCG.

Without this patch, running with a KVM which does not forward the
SEED CSR access to QEMU will result in an ILL exception being
injected into the guest (this results in Linux guests crashing on
boot). And, when running with a KVM which does forward the access,
QEMU will crash, since QEMU doesn't know what to do with the exit.

Fixes: 3108e2f1c69d ("target/riscv/kvm: update KVM exts to Linux 6.8")
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.h         |  3 +++
 target/riscv/csr.c         | 18 ++++++++++++++----
 target/riscv/kvm/kvm-cpu.c | 25 +++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 3b1a02b9449a..52fb8c15d08f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -821,6 +821,9 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops);
 
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
 
+target_ulong riscv_new_csr_seed(target_ulong new_value,
+                                target_ulong write_mask);
+
 uint8_t satp_mode_max_from_map(uint32_t map);
 const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 726096444fae..829d8346ed4e 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -4267,10 +4267,8 @@ static RISCVException write_upmbase(CPURISCVState *env, int csrno,
 #endif
 
 /* Crypto Extension */
-static RISCVException rmw_seed(CPURISCVState *env, int csrno,
-                               target_ulong *ret_value,
-                               target_ulong new_value,
-                               target_ulong write_mask)
+target_ulong riscv_new_csr_seed(target_ulong new_value,
+                                target_ulong write_mask)
 {
     uint16_t random_v;
     Error *random_e = NULL;
@@ -4294,6 +4292,18 @@ static RISCVException rmw_seed(CPURISCVState *env, int csrno,
         rval = random_v | SEED_OPST_ES16;
     }
 
+    return rval;
+}
+
+static RISCVException rmw_seed(CPURISCVState *env, int csrno,
+                               target_ulong *ret_value,
+                               target_ulong new_value,
+                               target_ulong write_mask)
+{
+    target_ulong rval;
+
+    rval = riscv_new_csr_seed(new_value, write_mask);
+
     if (ret_value) {
         *ret_value = rval;
     }
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 6a6c6cae80f1..50bdbd24a878 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1418,6 +1418,28 @@ static int kvm_riscv_handle_sbi(CPUState *cs, struct kvm_run *run)
     return ret;
 }
 
+static int kvm_riscv_handle_csr(CPUState *cs, struct kvm_run *run)
+{
+    target_ulong csr_num = run->riscv_csr.csr_num;
+    target_ulong new_value = run->riscv_csr.new_value;
+    target_ulong write_mask = run->riscv_csr.write_mask;
+    int ret = 0;
+
+    switch (csr_num) {
+    case CSR_SEED:
+        run->riscv_csr.ret_value = riscv_new_csr_seed(new_value, write_mask);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: un-handled CSR EXIT for CSR %lx\n",
+                      __func__, csr_num);
+        ret = -1;
+        break;
+    }
+
+    return ret;
+}
+
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 {
     int ret = 0;
@@ -1425,6 +1447,9 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
     case KVM_EXIT_RISCV_SBI:
         ret = kvm_riscv_handle_sbi(cs, run);
         break;
+    case KVM_EXIT_RISCV_CSR:
+        ret = kvm_riscv_handle_csr(cs, run);
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
                       __func__, run->exit_reason);
-- 
2.44.0



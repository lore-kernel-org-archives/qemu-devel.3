Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B57C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5gl-0003V3-Ta; Mon, 03 Jun 2024 07:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5gY-0003Fq-Ag; Mon, 03 Jun 2024 07:17:11 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5gU-0006A4-7S; Mon, 03 Jun 2024 07:17:05 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f661450af5so11825095ad.3; 
 Mon, 03 Jun 2024 04:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717413420; x=1718018220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D8UK8uAVTnW82lBqc0PHDyOOwY4BUuAnWYWQniDrcpo=;
 b=dIONXo/MPyygUVBBdUZc0jGe2FSl4xWBTRyoe+8kzaqDmGc9W+rINqWwn5e/MdRNvW
 ygmy9Kl6gODcwLYW6jPNOCc9pgqWD8zms2VuPQ4PD5eWBUvvAF8GsgCvb0pN2blm0Dy5
 6N+2ZelwgwgNLicxWC9HVPCdHJ3yOWtUtPW61jxQJtx46jCoevI4E5LNG0LwJep8MDQR
 fwTtJnXUsDODuuDtKVh3Icoo5OzZeSIINFy81xLW0oxhbnwZnp2k4ju3j/qwUUCEwM1p
 yx4LT7InADs3mqy/BK6ILBCarPrvwITyPR18O7fVzTqxSUkps9k4ENn6grPeQGlBaen4
 8kOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717413420; x=1718018220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D8UK8uAVTnW82lBqc0PHDyOOwY4BUuAnWYWQniDrcpo=;
 b=VEMsa/XHQlTuCMOX9JE3AYtNpppdoVjsXKOpcuIhKneRSZcZfYPHnprlAQIAfnFZTP
 djktL/5eAobliaN7mzvwak73G3Tf/GvvEvlB3lJruQHz+b2oIRe8WleD1ZJwA37/cpga
 WU/N34oUt2NVbDuD0vK3YzF6RlcBMDj+cjjfy4bU0Dvd7LLANbI3QniDuwm8psosD86W
 kHWR4iA3/rVJl31cgHmBSmepYjsl9uXqibHOn0oDksNi6+ZVmerU3RRsrFgKQ1/nOlTl
 VX2aEdC8hxt01NCgwjYzSBswgKiHVFKoVj3UOl55I+Rl0vEYa78s9J2B6+6PQ1wGjEUM
 K4yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5hW3oVahghoQ2iN4pKA0gptxQOVOcSVg1hEJ35R5M+GsZD9J4RRX6TeTnOpAHqegl07kbiBUBKGTnznwzugjVg6AqNAH6
X-Gm-Message-State: AOJu0Yzx2Es30fc1Bcl3IvOMNjgZk7evpx6j5g10G1cvN+TmmuirJNm/
 ekX/9jg5v7C8+XemHQetcv8vp66nnjs+aJr2O8u7OJWaHgvL1AK3nWE82Q==
X-Google-Smtp-Source: AGHT+IEMqijZiWaLRZNjSfdKxl7igKi7G+sP2Bl2QPAekDn36KTtqEhJSbB9MuPlHmq6up2dIxWQeQ==
X-Received: by 2002:a17:903:41d1:b0:1f6:6426:8da8 with SMTP id
 d9443c01a7336-1f664269316mr61143105ad.9.1717413420026; 
 Mon, 03 Jun 2024 04:17:00 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323e18c7sm62375435ad.177.2024.06.03.04.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 04:16:59 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-stable <qemu-stable@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 02/27] target/riscv/kvm: Fix exposure of Zkr
Date: Mon,  3 Jun 2024 21:16:18 +1000
Message-ID: <20240603111643.258712-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603111643.258712-1-alistair.francis@wdc.com>
References: <20240603111643.258712-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Andrew Jones <ajones@ventanamicro.com>

The Zkr extension may only be exposed to KVM guests if the VMM
implements the SEED CSR. Use the same implementation as TCG.

Without this patch, running with a KVM which does not forward the
SEED CSR access to QEMU will result in an ILL exception being
injected into the guest (this results in Linux guests crashing on
boot). And, when running with a KVM which does forward the access,
QEMU will crash, since QEMU doesn't know what to do with the exit.

Fixes: 3108e2f1c69d ("target/riscv/kvm: update KVM exts to Linux 6.8")
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Message-ID: <20240422134605.534207-2-ajones@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         |  3 +++
 target/riscv/csr.c         | 18 ++++++++++++++----
 target/riscv/kvm/kvm-cpu.c | 25 +++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 2d0c02c35b..746efd099a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -819,6 +819,9 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops);
 
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
 
+target_ulong riscv_new_csr_seed(target_ulong new_value,
+                                target_ulong write_mask);
+
 uint8_t satp_mode_max_from_map(uint32_t map);
 const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 726096444f..829d8346ed 100644
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
index eaa36121c7..b8136c7ef8 100644
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
2.45.1



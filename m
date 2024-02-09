Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA67C4829E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOdD-0006wH-RX; Fri, 09 Feb 2024 06:01:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOcS-0005yQ-JM
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:34 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOcQ-0000hB-UC
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:32 -0500
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6ddf26eba3cso550994a34.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476426; x=1708081226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HVzQgRWXCCX7lfyvb6jihWHjmwcwemd07eMz6SasaLc=;
 b=CSYbfJS+QUfvT9cTW9zJy3Hil5xeGQ4t4+R4UBUA9MTT2RvAYT32+JYX6bga8te5Oy
 64RnGbTObnNnSZkyq5WkdERuxEt7nuzJAIMJM486YE+Nb6sN6OwbS1zwEzmXj9eKnCbt
 8uKi0+L76m6kGtHP8hP4c7N/sLoVP9f0rzeLpalRj3vwProMH7S60/YSepOxQqqAHpXd
 wAs3v97+n1L1ucrA4wIibtLN1iTN/1HmbD/d5hXBks2y8bg1i36nEoZh9fefPJTtZlac
 BS93umIjLZR1+uaB9Nc6DP+8Y6QxrdDw8tvy9IUq1rn7i+cyMxMoJb99gj/IvqNQ+u4R
 vFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476426; x=1708081226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HVzQgRWXCCX7lfyvb6jihWHjmwcwemd07eMz6SasaLc=;
 b=O9/vcAsxklngz7Hl2oHYQnvDYT8SOVQmgpjIbrwpu7ZXVs5rRn3rYDKdfR0FKhH5oR
 Ow9z9UH920Y6NEfEHkOQWqTq+laGhvOo2Zu2h18fmwwink/RewpjepyCsMT0dImfP5bm
 9Q6R1eM9MD2dm2WZmBq7doVXIBLoaUc/hSWJ11evegZYPur8LXewtTxFVaPpSnqYfuqL
 TGbffdXBsY119BPMiM8DQysc4qB8xu10bMY3hoyTTH7DjSQqEmFSgC1L9Agiqcu8ByEJ
 SQcqFnDT0wB+A8SaFPXe9+bCSDX6kuV2QUgfyT1yQGKhdoMm4CtPc4Ub1oVVWgM2nlUQ
 GE6w==
X-Gm-Message-State: AOJu0YzqwtJJNmUcQnPMjK6otWpHyG6NlMJN+u5+cqQxdD7ELr/rZqry
 iLa6qDzbhfjFiL6Vle6pwUK/3IBjhWmA/uN9SlT20n+V/lQ6Rfm4kIzfYmqYEswR0A==
X-Google-Smtp-Source: AGHT+IF/ROnwGeKgb/DBZ4X2IDxBBlaoTaDDJkEtdvtmUcMYVfbI9um2l2fbclk795pTVC8EvCOmFA==
X-Received: by 2002:a05:6358:41a1:b0:178:fce4:5f71 with SMTP id
 w33-20020a05635841a100b00178fce45f71mr1128442rwc.8.1707476426179; 
 Fri, 09 Feb 2024 03:00:26 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWFy7KStcXdGi+WbIvICw0xQYX8669I8i3FbQ+h8lf3HwDLXmpJ7xventY0B47gmRNkKSHmKg9WiR2lsBGTgx4lS0dVi0kMtItTyuUGZXQPqYMCnowwjmhuvbAuINIaaU2hvjg=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:00:25 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 37/61] target/riscv/kvm: get/set vector vregs[]
Date: Fri,  9 Feb 2024 20:57:49 +1000
Message-ID: <20240209105813.3590056-38-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x32f.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

vregs[] have variable size that depends on the current vlenb set by the
host, meaning we can't use our regular kvm_riscv_reg_id() to retrieve
it.

Create a generic kvm_encode_reg_size_id() helper to encode any given
size in bytes into a given kvm reg id. kvm_riscv_vector_reg_id() will
use it to encode vlenb into a given vreg ID.

kvm_riscv_(get|set)_vector() can then get/set all 32 vregs.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240123161714.160149-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 57 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 3812481971..a7881de7f9 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -86,6 +86,27 @@ static uint64_t kvm_riscv_reg_id_u64(uint64_t type, uint64_t idx)
     return KVM_REG_RISCV | KVM_REG_SIZE_U64 | type | idx;
 }
 
+static uint64_t kvm_encode_reg_size_id(uint64_t id, size_t size_b)
+{
+    uint64_t size_ctz = __builtin_ctz(size_b);
+
+    return id | (size_ctz << KVM_REG_SIZE_SHIFT);
+}
+
+static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
+                                        uint64_t idx)
+{
+    uint64_t id;
+    size_t size_b;
+
+    g_assert(idx < 32);
+
+    id = KVM_REG_RISCV | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(idx);
+    size_b = cpu->cfg.vlenb;
+
+    return kvm_encode_reg_size_id(id, size_b);
+}
+
 #define RISCV_CORE_REG(env, name) \
     kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE, \
                            KVM_REG_RISCV_CORE_REG(name))
@@ -694,7 +715,8 @@ static int kvm_riscv_get_regs_vector(CPUState *cs)
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     target_ulong reg;
-    int ret = 0;
+    uint64_t vreg_id;
+    int vreg_idx, ret = 0;
 
     if (!riscv_has_ext(env, RVV)) {
         return 0;
@@ -724,6 +746,21 @@ static int kvm_riscv_get_regs_vector(CPUState *cs)
             return ret;
         }
         cpu->cfg.vlenb = reg;
+
+        for (int i = 0; i < 32; i++) {
+            /*
+             * vreg[] is statically allocated using RV_VLEN_MAX.
+             * Use it instead of vlenb to calculate vreg_idx for
+             * simplicity.
+             */
+            vreg_idx = i * RV_VLEN_MAX / 64;
+            vreg_id = kvm_riscv_vector_reg_id(cpu, i);
+
+            ret = kvm_get_one_reg(cs, vreg_id, &env->vreg[vreg_idx]);
+            if (ret) {
+                return ret;
+            }
+        }
     }
 
     return 0;
@@ -734,7 +771,8 @@ static int kvm_riscv_put_regs_vector(CPUState *cs)
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     target_ulong reg;
-    int ret = 0;
+    uint64_t vreg_id;
+    int vreg_idx, ret = 0;
 
     if (!riscv_has_ext(env, RVV)) {
         return 0;
@@ -761,6 +799,21 @@ static int kvm_riscv_put_regs_vector(CPUState *cs)
     if (kvm_v_vlenb.supported) {
         reg = cpu->cfg.vlenb;
         ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vlenb), &reg);
+
+        for (int i = 0; i < 32; i++) {
+            /*
+             * vreg[] is statically allocated using RV_VLEN_MAX.
+             * Use it instead of vlenb to calculate vreg_idx for
+             * simplicity.
+             */
+            vreg_idx = i * RV_VLEN_MAX / 64;
+            vreg_id = kvm_riscv_vector_reg_id(cpu, i);
+
+            ret = kvm_set_one_reg(cs, vreg_id, &env->vreg[vreg_idx]);
+            if (ret) {
+                return ret;
+            }
+        }
     }
 
     return ret;
-- 
2.43.0



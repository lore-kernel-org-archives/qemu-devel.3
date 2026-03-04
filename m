Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2ECEF8FE2
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmEV-0006id-7H; Wed, 04 Mar 2026 08:25:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmEG-0006g9-TN
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:25:34 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmEC-00022y-Q5
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:25:31 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-8272c559597so6836394b3a.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772630727; x=1773235527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HbfG9wff+BbdIYqv2iaik+bFaKfk81Ym9QY7iatia+8=;
 b=HtFIlBZS4ncyvBZbPURaZVxIqxU2im2fUK5+5bO//+EQQgLzVTI72ZvYDBPMc3uMRB
 aXctOU+ZdhDzMfv+bBMODNu2eXfsh+Ni2BD6J1Mn6F766cn9+L6e0ECC6Si1vQjo2Olv
 Np+P8G9tKJmvmh6RHx1vVOMRRjjLQxWLO6aoPoIvI6iOj0fzUsYn0ydk+Y5rPz62Obx/
 a+8e5lxVoJ1SyD4Vc1iG77fDflH6X+9zDjFjZrOkza71s0ZBAVsaWBPBC7c2vcqgC8MQ
 lny3T7Mb4lsoJkd2UL1fMDTgSxmcdQknpzvTj7PUFE4uAyJaWq1axNigWaDn7qHgLSOf
 yTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772630727; x=1773235527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HbfG9wff+BbdIYqv2iaik+bFaKfk81Ym9QY7iatia+8=;
 b=OELaeygrsUJsLmHQmQpH5mNsoEnK6GWjgVCQxr8J4EILXZ2DTKZ4k0wUD4ZqxLtP6n
 8Zi7hi59Inu4rZmlCXyEZy8gghFfDTztJstAzmt+GqLZYaBYL/7t+tlnABNDsDiCNR2l
 GApvZGEoeT3MEGL7VLVU7KyesaDYlTu4Sumgcn0GyI/eOtvjHidcp2VI4FtpWeAMjD9Z
 b6dnz466PNsOkWoqtNDDak/kUwFtbHe+SmybdrMEdRCloGXoDZmqTAoSoIeYtBCwaXnn
 YdWuXB2iSWlMJFqNHCxk024LvHMM943gUDYqr4yNs8AOhrCHgyqpx+nOAPdqq1wfVqOH
 RclA==
X-Gm-Message-State: AOJu0YwYXBUxlrt5o0mKTb3k/kovLKz0qdhWfFSiaRpBax3iQeDJgF4N
 ogPR+bdzftcX/4w+F0MgkZGpV0lFxvhl5Eaiw09BaVY3epbSnoHrtUz5INot5YvFtm5CdUbY6bN
 BfimYu+TDShPuPoLtUMqPO1H0fviffSdo4FFig92yKqbH6dyivEZOKGKouXC9IofjK03FhkciCa
 d1l9a+HOvWlWniQxZVDZ1f0MizZC3Kwb0uNjLSpsvnog==
X-Gm-Gg: ATEYQzxC3fLdOBDGtoFo1mTfBbd0gyt/ckvw1zqXS6OPEYg0v7VNBOZ7mf2ZRnJmdCD
 ennjJXbF8/OVH37OLdzDwVKKeXef4BYnY1ClUaoS5rOlmsrwjY8CQR79SOHdcrlotAflhT4AOQA
 e7nnHh7IcofEY0EW2XXoqXv54ZY0TR1ZPzDCjAKXV6MnuSTlcOcGBx7/WzP5H0RUPtk5wURKMsO
 27ixpTIRpkEGL93+/MvPhIMMC8NxQQ1TUmf8Yu8bo4LL1EnzIQP8B1qMhzE9hHcqu3YqtdjvjNY
 +Bc3ZKQxIaFn5V7iGGOursjMgmX+rUpaXTw+Ea3K43kfzkIMNz3uiiXtISYogze8r05C80vPmTG
 Sar50PcAJt45UbGFznEkaDY1LmTnrb4gBXY2jLuaIY9fKfBYoVa3ajMnZxWAPbMmjchB/RTm4Gr
 /m2h6QJc20q9iZy7ouvTetbpq4JVdU+FYXt6D2oAR5kbf9/raO4WfwQuOCQzMMTL3gqVMt9+rM0
 dzTUDwTCQpeZuSw1IoSMB2XBSo=
X-Received: by 2002:a05:6a00:bd93:b0:824:a635:4181 with SMTP id
 d2e1a72fcca58-8297294017emr2080505b3a.15.1772630726889; 
 Wed, 04 Mar 2026 05:25:26 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739db1d6dsm16968505b3a.26.2026.03.04.05.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:25:26 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 3/9] target/riscv: rvv: Add new VTYPE CSR field - altfmt
Date: Wed,  4 Mar 2026 21:25:07 +0800
Message-ID: <20260304132514.2889449-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304132514.2889449-1-max.chou@sifive.com>
References: <20260304132514.2889449-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x433.google.com
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

According to the Zvfbfa ISA spec v0.1, the vtype CSR adds a new field:
altfmt for BF16 support.
This update changes the layout of the vtype CSR fields.

- Removed VEDIV field (bits 8-9) since EDIV extension is not planned to
  be part of the base V extension
- Added ALTFMT field at bit 8
- Changed RESERVED field to start from bit 9 instead of bit 10

When Zvfbfa is disabled, bits 8+ are treated as reserved (preserving
existing behavior for altfmt bit). When Zvfbfa is enabled, only bits 9+
are reserved.

Reference:
- https://github.com/riscvarchive/riscv-v-spec/blob/master/ediv.adoc

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.h           |  4 ++--
 target/riscv/vector_helper.c | 39 +++++++++++++++++++++++++++++++-----
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 35d1f6362c..962cc45073 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -191,8 +191,8 @@ FIELD(VTYPE, VLMUL, 0, 3)
 FIELD(VTYPE, VSEW, 3, 3)
 FIELD(VTYPE, VTA, 6, 1)
 FIELD(VTYPE, VMA, 7, 1)
-FIELD(VTYPE, VEDIV, 8, 2)
-FIELD(VTYPE, RESERVED, 10, sizeof(target_ulong) * 8 - 11)
+FIELD(VTYPE, ALTFMT, 8, 1)
+FIELD(VTYPE, RESERVED, 9, sizeof(target_ulong) * 8 - 10)
 
 typedef struct PMUCTRState {
     /* Current value of a counter */
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index caa8dd9c12..7575e24084 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -33,6 +33,22 @@
 #include "vector_internals.h"
 #include <math.h>
 
+static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
+{
+    int xlen = riscv_cpu_xlen(env);
+    target_ulong reserved = 0;
+
+    if (riscv_cpu_cfg(env)->ext_zvfbfa) {
+        reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
+                                           xlen - 1 - R_VTYPE_RESERVED_SHIFT);
+    } else {
+        reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_ALTFMT_SHIFT,
+                                           xlen - 1 - R_VTYPE_ALTFMT_SHIFT);
+    }
+
+    return reserved;
+}
+
 target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
                             target_ulong s2, target_ulong x0)
 {
@@ -41,12 +57,10 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     uint64_t vlmul = FIELD_EX64(s2, VTYPE, VLMUL);
     uint8_t vsew = FIELD_EX64(s2, VTYPE, VSEW);
     uint16_t sew = 8 << vsew;
-    uint8_t ediv = FIELD_EX64(s2, VTYPE, VEDIV);
+    uint8_t altfmt = FIELD_EX64(s2, VTYPE, ALTFMT);
+    bool ill_altfmt = true;
     int xlen = riscv_cpu_xlen(env);
     bool vill = (s2 >> (xlen - 1)) & 0x1;
-    target_ulong reserved = s2 &
-                            MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
-                                            xlen - 1 - R_VTYPE_RESERVED_SHIFT);
     uint16_t vlen = cpu->cfg.vlenb << 3;
     int8_t lmul;
 
@@ -63,7 +77,22 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
         }
     }
 
-    if ((sew > cpu->cfg.elen) || vill || (ediv != 0) || (reserved != 0)) {
+    switch (vsew) {
+    case MO_8:
+        ill_altfmt &= !(cpu->cfg.ext_zvfbfa);
+        break;
+    case MO_16:
+        ill_altfmt &= !(cpu->cfg.ext_zvfbfa);
+        break;
+    default:
+        break;
+    }
+
+    if (altfmt && ill_altfmt) {
+        vill = true;
+    }
+
+    if ((sew > cpu->cfg.elen) || vill || (vtype_reserved(env, s2) != 0)) {
         /* only set vill bit. */
         env->vill = 1;
         env->vtype = 0;
-- 
2.52.0



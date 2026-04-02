Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2736D3942E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 13:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8ILL-0008Tq-DL; Thu, 02 Apr 2026 09:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w8IL8-0005fW-W0
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 09:44:10 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w8HXZ-0008Nx-5y
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 08:52:55 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-35c238f1063so512664a91.1
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 05:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1775134368; x=1775739168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AMFr2FjbIltiKUqGzYVREKwK9/NwicfF881etftmddk=;
 b=aPt2qn2DCnt+P14hc9uizPamYiHU09cAaaAPhfZp+xJSTxmIS88jS8c0x4kF7XK5T9
 LhWyt+QQNqBsbuPg41y20mdkoPne1a6fBw+mq/mLMwdACQcPx1h4GQ10kjlbACHwYSyw
 E8Bo/cnYnrQcN9IRUoAn746um2ryPXYcMfbI8keh9t171dmPfozj00RHoZO4mYDgmviF
 3D0SxPr0M+WUPvDnSxzpoStiu9GoIA35gucM2MT2iSjAksK/Y2hUaDET6tU9kz3JFV4I
 j6uCSuqC6QWqWH04Jhk4EcEIZjtj/G4vyW5ycHDmefrEQh7F5I1xN7z3BZpf1WvrVVGU
 fZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775134368; x=1775739168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AMFr2FjbIltiKUqGzYVREKwK9/NwicfF881etftmddk=;
 b=XWYZtvASlm6W+3nl+3iXGuqnbrJgnCO22T1CCR1XO9kcBArWYiofJOrQVn+bfko+Z9
 iqNE1DYhRaAlWAgf4CasUGZzRZUEVWsWdcNm1L7l1aRzlRkM/2ectuyzeuL4ILnp2qNe
 rK5x/VLbyjdq+fwXeLQ8Fio9mf1nGTOWdN1U3wZomtOjlWJZfn43Or/AF2WXZWgT040s
 KBPzjKcTiZhxornY0vpkSqRq0qLPL5kpftoIClLMAdEKm/xMIMq/rfdrVp3RxWP/o8Rk
 aSOOB8cSCmU4bL5BNAe30U3IvLxvqBPlAil7cGqcJH9/mmD3DRGhFqLWFuDqccEXTgrE
 Ojwg==
X-Gm-Message-State: AOJu0YyoFuY6Q7WoM9DDUwDkaPu4Zqc+pep60Cemlg1nsNwcUuiBzzZi
 5QnP+EZw+Gjjd8jVOwTxK+mhearBmGKpoORKA7McsJEBeeY96ywL6YO+otTGF8vysMAxrwAYz4X
 3NiYUMPw6wNIS1hx7R2z4/dZcr1P9xm/sW3we89EeXI2o9K4QTUBllaOP10KGCp5hgZVGq2WnpV
 b26KmzufxYopAgJ+AHwcsgOVlk01RW3r4Gizf8nt0=
X-Gm-Gg: AeBDiesIPzlpsow2BShErHCFXjbj9/NbwWykMc2C2DIzdsBQN0vJ4togpKk4P5qZENX
 HoP5Zk4Gt0DSS3macP+YY3mTgEuXI1e+iMJVu6rGaZ88yCz6DT8aIqwoUKgOfN77sNOfn//DLHJ
 N/8F4xuYmQoC4u7uZOSeTmlDEqztRYoS3Q2XqF0yNz8P/VGYFz+0/I6Ol1mueGSdeLBTL3XpWzj
 X0VqwhbFEXVzLsjCpbIC2GwdW14c04c6SGgw+EWKpMiMMTQ8z3hLJnBnQ0s/ERqpNObkrb/RkuD
 vkT5+RJ1ERatogvV4uJ0UfHJeJidDAfKUo+p8x3RC8ImTaaezNzKKgbWmtzau6JnIO1MgXo8C+o
 4w04NSG8uBmID7JHww5+dcfvi5eEoqWeDBZdL3D1CGTlNaniTG+ybBTOw03a61eVyLmxDxJfSqv
 b3wJWiIMfQA+wOjGhucPWXl47ESw6epMf3Z9sQb7Rywh0H12KqblCGwciLjAjiv8GW6uiFazApi
 M/vuo06SGVczPpbXgUAhsuggPMzuVKukn3knw==
X-Received: by 2002:a17:90a:c110:b0:35b:9c97:3d18 with SMTP id
 98e67ed59e1d1-35dc6eae327mr6826664a91.12.1775134368339; 
 Thu, 02 Apr 2026 05:52:48 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dd35364edsm2730032a91.0.2026.04.02.05.52.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 05:52:48 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v6 3/9] target/riscv: rvv: Add new VTYPE CSR field - altfmt
Date: Thu,  2 Apr 2026 20:52:28 +0800
Message-ID: <20260402125234.1371897-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402125234.1371897-1-max.chou@sifive.com>
References: <20260402125234.1371897-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102c.google.com
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
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
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
index 83dd26314d..63ca6fe16b 100644
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



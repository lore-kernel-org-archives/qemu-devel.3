Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E545CF5140F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 07:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyPLG-00039u-Fv; Fri, 06 Mar 2026 02:11:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vyPLF-000398-B3
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:11:21 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vyPLD-0007hg-Hp
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:11:21 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c6dd5b01e14so3172542a12.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 23:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772781078; x=1773385878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4uQDhR6YrGNT0dyapo0lViV7ZIQm3Tf5D9l0mN7YNH0=;
 b=A3g3kqMPNWawPmu7E7cCSboWK5dY6Y667ctBGq8xV5AX45uGFpLSnMm+FqGOOEdd0k
 LhsyRh7rw0pFtvuJYsDs0t7RwPJt4TjMGKTFtzYnTwLZCROpq41roEdmX7dmroeABw3f
 2E8yhMJn4ekPw1UkcTrJiBo3DRgqsiqBfHKI33lpDuK8OMGQH8cnhnVY1t48DJxzX3Cg
 widGLUeoUo1KSS8CQlqcUY+Da1vYzmL1fVzNxHnYWYYBZ4RoPmC7/fsAEsl5HzOHRcd4
 uCdNm2ghqRb0ttwJDx7Fm1/kYLCVJ3QyDO6bY3xOOq9MZDtr7PqopqDMDpgSuxL7eiph
 yODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772781078; x=1773385878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4uQDhR6YrGNT0dyapo0lViV7ZIQm3Tf5D9l0mN7YNH0=;
 b=IIsBqxjbMDv3AogLaOSHScesMOrpoG4G0JMWoNa3R0PNfp+gchZyZkAEOq6FokVurr
 dc6PjbdhOc0VvnYmfnU0SyaF+NYEeBiyujELFyMSBQHNoALiQBCTgLgS0nqjo2rjhUpv
 PpZjXUKh3LSGD8Pa2c90BgJwmQLPfFG4udW8tpMobCsPzLVz8wO/qjzNZmO/NfpkGLqq
 RDc2cu10zPFRXlN5WhEB9ONiv1q8Tmu5NN67vknGmal8+uPLLfIoleF3fNmypyOsC4og
 WInaVmaQepsAavS0Mwh460+n6rk/V0BVCn+Mhl8w8spzgoixixy9fEcI1O/9Ks2AAD2+
 kOKg==
X-Gm-Message-State: AOJu0Yxu3kVbLFamIp/LYK7jmj8DIZpiP/kv8tu9uVVwtfd32gqezrvv
 VnowocweOGzIRfKxUadjE+lHzp9cfHPcdAlia1TfvD6zjTkNw4BA8wQ6pfyIyabk0UJeL+k0mkr
 QXX0eWWNppBvN1rSfnpbhha0UZA1rwqeM4e8Zd+BLwfGndvPBwiAaUYMSCb2327rPutxE2kqHGZ
 a+aFUV6jyXVufAk2Q1kW/K/xmPjMrNWkqTesX7xZUrLyEC
X-Gm-Gg: ATEYQzwin4xwHWx0J+EKaxnvjzRNQHu+jA4vCDLM1/ktE9BfpfGTYlhgOLhu84Rfhzw
 tvPE9YQCZWfYGJNcYvvvRGtjRigBGFQclLicPdtRDwG6z06CbqwoBCQe69P3INhO/QSoJ2akp8g
 RBH2VfSgPnsm7V0KR32HfrDxXUKDw/rTVGnZ4cM1zUJfOB0NE7PBlGLEj0ziZc4twrgY/0+xay1
 a+Nro9GXlZb7OVeewEAWU61r1BXQ9f6ABWrJaxVZxLcB8Mtd1IgsoHHHOa3v9sNKulz9pWtNZJr
 I83n/2H0Wmts20kpusIIHIfhszteMwzuy+nOyqNwyF6hEvTjXlRyw2mtLjpnPlijAIFf8a87Tiw
 sKR4kfKYdxKDNH3YqMpfU0gMgT6wKaV0C8dShtUXfwigEXBgxyZ2tLOaEPG0i5wfWs8I8FmBFmZ
 HEZzRwx2jlvS0Cikl+znzJSR1DVYuZZbrP+vDhRrUVFvUTiS4ArR13aOC6Fn8I/gNIZUIKFNmbf
 oyLJ/pTLuEJzEMziLY2zNaxOaI=
X-Received: by 2002:a05:6a21:700c:b0:398:4a20:cf90 with SMTP id
 adf61e73a8af0-398590ec6d3mr1466218637.68.1772781077877; 
 Thu, 05 Mar 2026 23:11:17 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-829a4636c74sm956093b3a.12.2026.03.05.23.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 23:11:17 -0800 (PST)
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
Subject: [PATCH v5 3/9] target/riscv: rvv: Add new VTYPE CSR field - altfmt
Date: Fri,  6 Mar 2026 15:10:58 +0800
Message-ID: <20260306071105.3328365-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306071105.3328365-1-max.chou@sifive.com>
References: <20260306071105.3328365-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x533.google.com
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



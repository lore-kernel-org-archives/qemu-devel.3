Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CC8D1951B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 01:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkY6m-000125-8n; Mon, 26 Jan 2026 20:43:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkY6e-0000wX-Do
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 20:43:00 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkY6c-0008CQ-5N
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 20:42:59 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-352e2c59264so3502209a91.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 17:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769478175; x=1770082975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K9tuNH0GIG9QMRuzBZRQlmu2VdYAe2paJMYHOeqOgYg=;
 b=l5tqqbS9ioihzvWo6Lxm/MSil9IAnX0mattW9v0YUQQIBnK8CD+MjV9Nzs1l5zBwLJ
 dTjU+JH2y8bgtobbQRDXpFp7Hmgzsr0iD7G9sAzg/yIVb1vU507Mp8iMgZe7VeKAFIb2
 1rohRRUubKQEdtcBBu5w2l8bjxn9ETJG/u5hMzsMJIe7w/aiF/vXuPqbd50JQOhrMEhr
 DEOxPRje1QAavq6bEQJ4kFaDBLjtoANy/vT6u02GAECDesukvbpdqy+seAwVRtNcXqjX
 FB5AWtbKEPf+wtRDxlLj836qsyv1UEqp8RLBuDUAoXlGL36NDviElXYsYTkgGgZl3Ymw
 lG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769478175; x=1770082975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K9tuNH0GIG9QMRuzBZRQlmu2VdYAe2paJMYHOeqOgYg=;
 b=VQh+RmLibWtWs3INOnJaljG3HMFaJWOzfE52yd4mDDvvHQmrbGSdvqZ57RPcCnhdAq
 OjAotS9bXxLXeRX3JrtMrV4UgJpTljzrKsITlYKChUMKCy3tDT7YQqkCTyc+vicALTGJ
 v3E4XdCTh/o2vVAiUIi+ckCxbCVUGpsLXVM9LBtnZus5mLlN/lzGBiwXamcpojpRD5JG
 C+SF1t8sJUhlmpSy1RXf1GYElMQYStHqxyhemq6UOlqF635/5b1krUK3m+qmnfG0fo4a
 koLJPvpqQiJCVbuh8WMtvVLmy7qvAHdg1kepIRtdc5dRN+jWeHar5sbAKrgRWjpCTDrQ
 poVA==
X-Gm-Message-State: AOJu0Yx4/6rWGQzcyoimqnFg70hhQtbVv9BaRad4vaUmaOaENYTzmrnw
 x0QNYDvlh1H7EdNk3YOjwlfGjR3XRcNCIu84nuqfiwn4cHdkwM2CC2o9WjiWzH6l7H6vIUGy8H9
 n7jyLLApXz8u9tcy1xphnPs6oKgFVkg4rur507mXBVTzGZah8aYrz2uhZGIBKAMTiAfa2pjtUdM
 yvQ5vVHVT5jmvUimABvuQzsJbl09NE+E8pC944tjCvaw==
X-Gm-Gg: AZuq6aKRJDSsVjFeL9Ft+lsBtrHBzX1n+i/pceWxKgfrTqTX5iIVkQ3OoiqK94/rgxg
 +br+eUxM68etnQOaUKfm1NM+IJTatOq7GBk0QVrPDtKkQLeNNQRh9Z0XnsxBWooxWBdUk3UiX6j
 0o61invzPtapcPjCJgpvdHkjHiQTGrkxxPh0V2L3HJcFN5ez3Y83zP+PICaWR6kYtRq8PeRnRPm
 sQUjFM8fRvDJTrk/d60inSgstFt/GeG79lrXl68HuDnusTdfx+iuJajn4NHKAop1v+vlxAbkQlD
 ggOrByp5xOmEUzMjn9BlAUSMrsNFO4EHPMpFtnKGYh5HT2MoE10geZtdJrwrC1AWz4cuh6nmNMM
 b2pnu8HduB6m6DQ5wplTiGFBagj/4yjLynSHcF3jP+LklwX4hB0u8Z3L1QtsYIvC0yy8gaI/hGc
 Hdi9ng8OksgtjiWntKKkuYbhW/A9RL542jOh4p5TrBBPvPgcX2RhA7gSFBBs1YxoLy1/nW0vKzH
 EZmcIrfyj5Mw5U=
X-Received: by 2002:a17:90b:1e51:b0:340:d578:f299 with SMTP id
 98e67ed59e1d1-353fecdd09dmr223896a91.3.1769478175276; 
 Mon, 26 Jan 2026 17:42:55 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f6129426sm660121a91.7.2026.01.26.17.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 17:42:54 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v3 3/9] target/riscv: rvv: Add new VTYPE CSR field - altfmt
Date: Tue, 27 Jan 2026 09:42:21 +0800
Message-ID: <20260127014227.406653-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127014227.406653-1-max.chou@sifive.com>
References: <20260127014227.406653-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1035.google.com
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
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.h           |  4 ++--
 target/riscv/vector_helper.c | 29 ++++++++++++++++++++++++-----
 2 files changed, 26 insertions(+), 7 deletions(-)

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
index 2de3358ee8..525a47bf66 100644
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
@@ -41,12 +57,9 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     uint64_t vlmul = FIELD_EX64(s2, VTYPE, VLMUL);
     uint8_t vsew = FIELD_EX64(s2, VTYPE, VSEW);
     uint16_t sew = 8 << vsew;
-    uint8_t ediv = FIELD_EX64(s2, VTYPE, VEDIV);
+    uint8_t altfmt = FIELD_EX64(s2, VTYPE, ALTFMT);
     int xlen = riscv_cpu_xlen(env);
     bool vill = (s2 >> (xlen - 1)) & 0x1;
-    target_ulong reserved = s2 &
-                            MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
-                                            xlen - 1 - R_VTYPE_RESERVED_SHIFT);
     uint16_t vlen = cpu->cfg.vlenb << 3;
     int8_t lmul;
 
@@ -63,7 +76,13 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
         }
     }
 
-    if ((sew > cpu->cfg.elen) || vill || (ediv != 0) || (reserved != 0)) {
+    if (cpu->cfg.ext_zvfbfa) {
+        if (altfmt == 1 && vsew >= MO_32) {
+            vill = true;
+        }
+    }
+
+    if ((sew > cpu->cfg.elen) || vill || (vtype_reserved(env, s2) != 0)) {
         /* only set vill bit. */
         env->vill = 1;
         env->vtype = 0;
-- 
2.52.0



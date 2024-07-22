Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC36C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 17:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVxBK-000438-Q9; Mon, 22 Jul 2024 13:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sVxBC-0003y7-6S
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 13:50:35 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sVxB7-0001wA-HV
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 13:50:32 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70d18112b60so1161432b3a.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 10:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1721670626; x=1722275426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iuE2zhO94ud85q0/GlYCCByRnpO9dMwp6MJra1x8GNs=;
 b=IapvfFOkk8q7Ma+xFZ0Xj0tCkbwW7FiONLQreNcNTV29OmMwtpI6fDc5pkaCWZF/65
 UtNaqpa4s/HQoUAA/q6NcE9npy/ey5nx3jHAEXHNmgO2iZPi8YCs9UzjZa9KfCWWEp1g
 8+4efXY2L+G54gtfDq2tcEIECNQ0ks6/ebVrrRPX+OCPt/434NUhL4IgV84usMinrQfy
 u5LbkoQv84eUqZB0icFeCq68ccOO+hGKoRVGzrQcJFPYfjDd98WpowAgGkKXVSR3BkO5
 rUpqwPbcRllbsDAH2+3I2WnAFkuG/91WBppnhAaJPvChhwr8nq3NvjVfJPQQHFrYQpPK
 0Jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721670626; x=1722275426;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iuE2zhO94ud85q0/GlYCCByRnpO9dMwp6MJra1x8GNs=;
 b=RUY21w7y3aOYdxcMOCFkNCub3v1oBU2pIXr+Q0sh6BBaIEXvZwbw9xPS9FKlNYxQMe
 JavZA1YiqQUSmKUCSaIKkOzpQR7edMeE/ZFy9qJROMbCqbXf8SWC/AzIBEMio+2JZFHf
 whzKdGG8vAOmLsdnTaHypfw2J62Sr9BGDzI+igjQhy3xXl5RYN0npIlvF7LedYzhkNqc
 uO2RJSOnSp8L94vqnk71EKQIScv3Qjs5yZERWSfCh6NscELf7JdgEDDBoQYXWYJRXoLe
 ttrOiSkbZjvOIwkFhYDcm1V9CQqkCnkNuCLglCsiDz9FsgdYZsEFUxjZlzE+L2ddQzV7
 384A==
X-Gm-Message-State: AOJu0YxRlGXZ4mknr/D5q3O7WXDMl95T3s53Q78H0qrmU9t0tg4zg1bJ
 rpcDEDVeTvkq9r8/n507HQ7o3HLahTj9dBF7Gx322Av0tMW6G60C2ZbjmEsKNOKJFmjMNjepX1i
 2zI7Z6M5mo0t8F9w0u3Bf/4/UtYbGIVRtwLrG6Wj/tU+/O8OKjqF8J+COGoYC+K48pCVohffIkX
 pUVNJWQZAGnJ5ThC14FXBMCS1Ok2+Ws+MaqpLuO/I=
X-Google-Smtp-Source: AGHT+IHkhWqG+hhzuFHl7wfK+y4D4eA97FM2SOOrLADgNRLgunbESvELT9hZglIr3l2zyrZ1hOOLyg==
X-Received: by 2002:a05:6a00:851:b0:70d:2fef:2ca0 with SMTP id
 d2e1a72fcca58-70d2fef2ec1mr3436167b3a.2.1721670625496; 
 Mon, 22 Jul 2024 10:50:25 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d26d98169sm2234850b3a.76.2024.07.22.10.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:50:24 -0700 (PDT)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jason Chien <jason.chien@sifive.com>
Subject: [PATCH] target/riscv: Add a property to set vl to ceil(AVL/2)
Date: Tue, 23 Jul 2024 01:50:04 +0800
Message-ID: <20240722175004.23666-1-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=jason.chien@sifive.com; helo=mail-pf1-x430.google.com
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

RVV spec allows implementations to set vl with values within
[ceil(AVL/2),VLMAX] when VLMAX < AVL < 2*VLMAX. This commit adds a
property "rvv_vl_half_avl" to enable setting vl = ceil(AVL/2). This
behavior helps identify compiler issues and bugs.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
---
 target/riscv/cpu.c           | 1 +
 target/riscv/cpu_cfg.h       | 1 +
 target/riscv/vector_helper.c | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a90808a3ba..8f21171ffa 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2687,6 +2687,7 @@ static Property riscv_cpu_properties[] = {
 
     DEFINE_PROP_BOOL("rvv_ta_all_1s", RISCVCPU, cfg.rvv_ta_all_1s, false),
     DEFINE_PROP_BOOL("rvv_ma_all_1s", RISCVCPU, cfg.rvv_ma_all_1s, false),
+    DEFINE_PROP_BOOL("rvv_vl_half_avl", RISCVCPU, cfg.rvv_vl_half_avl, false),
 
     /*
      * write_misa() is marked as experimental for now so mark
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 8b272fb826..96fe26d4ea 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -127,6 +127,7 @@ struct RISCVCPUConfig {
     bool ext_smepmp;
     bool rvv_ta_all_1s;
     bool rvv_ma_all_1s;
+    bool rvv_vl_half_avl;
 
     uint32_t mvendorid;
     uint64_t marchid;
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 1b4d5a8e37..825312552b 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -75,6 +75,8 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     vlmax = vext_get_vlmax(cpu->cfg.vlenb, vsew, lmul);
     if (s1 <= vlmax) {
         vl = s1;
+    } else if (s1 < 2 * vlmax && cpu->cfg.rvv_vl_half_avl) {
+        vl = (s1 + 1) >> 1;
     } else {
         vl = vlmax;
     }
-- 
2.43.2



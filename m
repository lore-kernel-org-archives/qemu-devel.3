Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C73BD1951B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 01:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkY6m-000124-8a; Mon, 26 Jan 2026 20:43:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkY6c-0000wN-Bz
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 20:43:00 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkY6Z-0008Bh-K4
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 20:42:56 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-34c718c5481so2875083a91.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 17:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769478173; x=1770082973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rb+UcWYhxMF127vuJPxlREmZWvUsJ38iB0zRbm2zWpk=;
 b=C4AWdlLfz3rwbnIcjV3aFd9PpdQ1weqDnkOITLis5kOwampua9zp7of8VYX3VxNaEk
 zoCiFr4t+DBU/SUZ1H9GvAGY30A57G/yvAwBvPJ23NA0GnK4J4+6N5kbQN/diIOn1bR1
 MpAGk32b+cs4xP8kmcpVpCacAfraAokp97d/2vHdVRj9mVdToj9nPgCAFixrSAQ0Ig+f
 aCVsvPyZ9a0NnUAHB2qwBYDEvfeV0m3vg+1zh6dr6M8Lq/40/tYrMXXI90QHt7H6LG6N
 3IfExZgGIeRSoK8G1FTHh++XdzUhqlsPbAPnDIk37A6iZ9TeL7fT5N3k8hzHNEQ8/kCu
 8jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769478173; x=1770082973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rb+UcWYhxMF127vuJPxlREmZWvUsJ38iB0zRbm2zWpk=;
 b=PU8HPLBUu6JQpypNn4dJeOCp3aaHT+aebhFaie2WWfsowDb8FG45ik07CWqBDsFmJI
 ACE8kL4kTr3SsooQktv41/yiotWOuCXBcyQlhqkWdmTPqN3/GVCy+m74wHCj+B1PUOlk
 elXO9WCoV1aOL6EFvjgHvlemk/JUvEMejZxB8oeVIrd+Ug38kK6PWGaxJzJsixMzGXmQ
 dmjZi3cQ0dAplB05vyL/In8opC2LlwJL+RDhuDiHagtXzZBMZYy8y7ITtbO+MhLNScUr
 6n7Lqdrw+xIx+oTVlNJhoA01j/Hfz+M8Zri6l7qMDfDDqg80Xe6nEBfWtMtcKVjqP/D4
 f3YA==
X-Gm-Message-State: AOJu0YzClGbexKdaw5QlNUK7aEPOqa1I51Pl4OgplClcNJH8QF+KA5Dz
 xK5fuWglOqG/kcZgOYXPzQbeYqDfIYSpxD0MjdQDmR+tIz5xvCBldECVrVBuQ1CL9zUWZmaGXm9
 XMGlOUe1IueoS2lZ/vUEUi1PTnSEPkn4OTaTiduQXdCXZVSeVpXxeFrHGOPeTr4kHB4hZ2W7Ujg
 RsnwudFC2lggOj50DmdRsEZo6jN7N+ITx4nZFp8YVDVA==
X-Gm-Gg: AZuq6aI9e2U3gGGHC7QiuYzZwTkg80uex2c9N2bf8g+ItwffHf3hm1ZZWK5P/5xQty0
 YtCVx6jXSPWg7kAhhYzigwKU8tkmp5iddhJ3LLDu5WOPoGGiEVWLFxF9pg0279Q7XZJKNmYMBWp
 MKwJcnHpCnlsFvQ90M5aq8FaiOUMZk5X4YOihF6ygYkXqFoymrtXw63hZodmNd+ilotVfLqwhpD
 FFLl7UxvwJMAkXgrr8EHJU+Ap8skyVH1b8c1H7moQyrq4J2GFqJhstcd+e/4PS2p+HnCIjbc7CD
 inB3bm9J/sCdL+vX6UxzqfVsM6WUZjhEjBDxO1KQFGkBOL8l85mH0OFFVj3EIg6ruJEXFlb8C5s
 JRIFJmekRfSJwXGSI+8ajKDZQOt4lrYjK4lpv8jcR27Tx2k1M3w73dSOf80vDE9rLxZFo5cUiix
 jEVNsq+nZ9vA8TTe7xngPStx5wDuSXRTdzdH+XIUZkKolTELXVg9ueBvUEMjXG6TpeULSB3C+As
 tlCiu5fOP91sXEWrGjbkseGsg==
X-Received: by 2002:a17:90b:288a:b0:34c:75d1:6f90 with SMTP id
 98e67ed59e1d1-353fed6ebf4mr229918a91.17.1769478173274; 
 Mon, 26 Jan 2026 17:42:53 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f6129426sm660121a91.7.2026.01.26.17.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 17:42:52 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v3 2/9] target/riscv: Add the Zvfbfa extension implied rule
Date: Tue, 27 Jan 2026 09:42:20 +0800
Message-ID: <20260127014227.406653-3-max.chou@sifive.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index cf237305c5..01cb62bde4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2618,6 +2618,15 @@ static RISCVCPUImpliedExtsRule SSCTR_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvfbfa),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32f), CPU_CFG_OFFSET(ext_zfbfmin),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
     &RVM_IMPLIED, &RVV_IMPLIED, NULL
@@ -2631,8 +2640,8 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZHINX_IMPLIED, &ZHINXMIN_IMPLIED, &ZICNTR_IMPLIED,
     &ZIHPM_IMPLIED, &ZK_IMPLIED, &ZKN_IMPLIED,
     &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
-    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED,
-    &ZVE64X_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
+    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED, &ZVE64X_IMPLIED,
+    &ZVFBFA_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
     &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
     &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
     &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
-- 
2.52.0



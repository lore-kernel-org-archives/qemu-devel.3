Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4309C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 13:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTMIe-0000yq-7g; Fri, 26 Jan 2024 08:31:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rTMIa-0000q9-6H
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 08:31:12 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rTMIY-0007cM-B2
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 08:31:11 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-55c1ac8d2f2so278821a12.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 05:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706275868; x=1706880668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/80PDTg3x6xAn5TJUsK9pPA95tqYtQVDFChFHkikpCo=;
 b=XYLYNAkYCadnHtyel0Z6HbNEBIoRLxXt9V6b8q05ydoRYAU7kPuMCBD/vxpdzstPsU
 VN0DV40R1rnjpFRQ/zGdp+1f1wSEdnHsYMlkGYGys5iS7E0QbkRjEa3qep5SxRmDYXvF
 SW9e4PMLgj8lV1/uSDuVqrMNFZD9e78mWnVp0+KnlXWUdnNF69uG/FQlPGi5bVUscYSs
 ZQxiZ4Y1aPFlptGeuAFfQlC/ePe2AN4BSooGw60Og1y4vDAVC95wZXnWCYWpX7VjfHf2
 8J32gcxqAY5ENWtx5CJtxjxZPbNwz9XlmiXOgBE8jIXMcaJnRh9JCNcsVJsM1G0OunPI
 s8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706275868; x=1706880668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/80PDTg3x6xAn5TJUsK9pPA95tqYtQVDFChFHkikpCo=;
 b=BtU4QDWRtPtntRE5k0rvkZCD0mhdNlOxO9wQXeKJLGR8vkYdbsVv5uTwYp2PQ84/gz
 mA0EMj23JAaNu8J8PtHDDoZpnHpyqQTaSuGMfcKyAbAxfFfElugVyytfgHOZP7Usyiog
 suQiJb9vLz2uKV1eFSF9AHv9ykdwSxoWlBAeTFE8vYOOd0QV7f7TJZyGZ65V8t/j9uHL
 3d6GebW47Qgugg3H6w4p+mWzUoK45EfZR6SrJFfD7AXjceATtBsBoizFiivlULOifQtx
 scv8kOjbu1fZTPykIKaL1aPQKGLAKuccXR5frELnF2ESzI9R03GRaIjNDwuLVG6694mw
 6+XA==
X-Gm-Message-State: AOJu0YzQ3osXvzdMgQvz6Tj81yMwp80edLSW5ORXOyf7Oql1duUVJqfG
 88t9xU93+/M5fK3Jrrxw6F+3mMmDPsCP6cGoj/cr25sQ/46qRgMKQMnDIMU5GJFUuqfWLEOaqhG
 s
X-Google-Smtp-Source: AGHT+IHcZhvt3gp6MF/UCzl1rRpqoqI+Pc8/LpTWj7CPnO0Roc/86vY+PDlVCslk27gI46aED/cirQ==
X-Received: by 2002:aa7:dacd:0:b0:55d:4047:52cc with SMTP id
 x13-20020aa7dacd000000b0055d404752ccmr354308eds.24.1706275868647; 
 Fri, 26 Jan 2024 05:31:08 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 fg14-20020a056402548e00b00558a1937dddsm593262edb.63.2024.01.26.05.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 05:31:08 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 dbarboza@ventanamicro.com
Subject: [PATCH v2 4/6] target/riscv: Reset henvcfg to zero
Date: Fri, 26 Jan 2024 14:31:06 +0100
Message-ID: <20240126133101.61344-12-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126133101.61344-8-ajones@ventanamicro.com>
References: <20240126133101.61344-8-ajones@ventanamicro.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The hypervisor should decide what it wants to enable. Zero all
configuration enable bits on reset.

Also, commit ed67d63798f2 ("target/riscv: Update CSR bits name for
svadu extension") missed one reference to 'hade'. Change it now.

Fixes: 0af3f115e68e ("target/riscv: Add *envcfg.HADE related check in address translation")
Fixes: ed67d63798f2 ("target/riscv: Update CSR bits name for svadu extension")
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c | 3 +--
 target/riscv/csr.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1ecd8a57ed02..7fd433daee74 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -961,8 +961,7 @@ static void riscv_cpu_reset_hold(Object *obj)
 
     env->menvcfg = (cpu->cfg.ext_svpbmt ? MENVCFG_PBMTE : 0) |
                    (cpu->cfg.ext_svadu ? MENVCFG_ADUE : 0);
-    env->henvcfg = (cpu->cfg.ext_svpbmt ? HENVCFG_PBMTE : 0) |
-                   (cpu->cfg.ext_svadu ? HENVCFG_ADUE : 0);
+    env->henvcfg = 0;
 
     /* Initialized default priorities of local interrupts. */
     for (i = 0; i < ARRAY_SIZE(env->miprio); i++) {
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index d9a010387f72..93f7bc2cb48f 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2115,7 +2115,7 @@ static RISCVException read_henvcfg(CPURISCVState *env, int csrno,
     /*
      * henvcfg.pbmte is read_only 0 when menvcfg.pbmte = 0
      * henvcfg.stce is read_only 0 when menvcfg.stce = 0
-     * henvcfg.hade is read_only 0 when menvcfg.hade = 0
+     * henvcfg.adue is read_only 0 when menvcfg.adue = 0
      */
     *val = env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE) |
                            env->menvcfg);
-- 
2.43.0



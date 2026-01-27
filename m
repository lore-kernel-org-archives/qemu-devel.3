Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC052D1951B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 01:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkY6m-000127-8v; Mon, 26 Jan 2026 20:43:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkY6Z-0000vu-Ry
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 20:42:56 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkY6X-0008BD-BD
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 20:42:55 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3530e7b3dc2so4282493a91.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 17:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769478171; x=1770082971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfD5m+b1NbLmonbNu22Gr4zImZtHTDj1Bu4S0wCIJVA=;
 b=L5Kf9Cv9ysuQCv5uqEM3Mo8B66E/l4O6ozK/LiY0YGUTXQwMXXzvsSaQbIuzq/Fdyn
 dMnwR1noBypxVeNjJIp9gygQgKYp0NfqsDzgv2t5n9ZTQ+vDfEQubpHNbYj3IpLUiz2i
 Mf5XiOmLy8kEQYLVgoaJY/gS1bVtlt8RphBc79MELYz5Cm8m2Xqdtze06WV0jG0wMOi2
 ld1DibUmEAEx0eqt570/PIG7hSDk7NkRBMVKDVT3er90u7p7oCO/tO9XJ8F9Bb8+JIs4
 34Qj5WQtX41K3SAAPlUdfwZQTqkZL23Mrnrp7PpAmeQctu8YMcSkAPlhEpgQW05T6Xgj
 c6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769478171; x=1770082971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vfD5m+b1NbLmonbNu22Gr4zImZtHTDj1Bu4S0wCIJVA=;
 b=g0ngumI0k5XPrtPesRQ1N9Z8uXxFTM42KbEXo3aDEoFe3XOsMwEVebJ2CV8R+XnQT4
 xHE3IS4GryMLo7OSw6WJmfpowQi7udixdRgTdpJyQnqrferC0uN19K4KDmpJJK+C17TI
 VyYZs6e2St7unWPm8hH7YHGT/aEHaZ5qivFXsCrqqUrC90rEFKRxhPuw3b4tWW76p+Ua
 2YX7hGGE2+vBmLwjH7ByoBM2hIEXUUGu0Cd0DMIKD15kse4c6o43TX3O0YLjOXIPwd6Q
 5n5AUuwas/KtKHhiGXWfmgPL6A8hHq4/5MT3o7mTlZvzhcF9Pb40+GV5nic1JTurBt9y
 XUjg==
X-Gm-Message-State: AOJu0YzRks/3532cO8YGx5eqXE2IunLEXnDMGCE+BvuMtCDl97aSLUn/
 V1EQErWw6F+2pwbDiXTsXlfwNvQfqIRS23vY7IbkDMME/HP5RFpDTJGri2QsOPIjxMYDr1mIcXu
 Cteu+8jb8CnXkXFDMk+8rEVmOHsgOZMZ5c7MFsRKZifyZY+U7T5QZ7n3HCu/ALK8PUOauRpX5h/
 u8Bq68ggK0Ln79NaVi5CRpn2Kc/0UbynT+NxvOgItpIw==
X-Gm-Gg: AZuq6aKPaDnCvBImy5HPpS+S9YL9ctE7KE+DklxWEnJ0737jDmStS3la4gS3GitRsrB
 Ptn4cj2wOPL5DgKaopKKl9deA3uYqa0S6i9WGMOnCBdeuOKX/Qiu6I3oDLgv/Hojqn82eLopt3r
 NG4H8whN1pruADB4LvvBi0DZu97IMnZCXc7orHWwD6s1/xqwDSSY4NZc+0v2A9hoMSjbVjYPc91
 zFOLbY0nHHwiwH3SDcXvv4V7yXWoUddWSYM33eeQyM3YGdnnz0fVnBTgNLTp/RbVm0YV3+lQdCT
 7VS9mSp759Xxf1Wp4JWsQddY9YieiDALhuOc/s6Jqn/ngGHcCsdrkiHJI+Y1Y3oECnX5L/TEz1a
 SovbK2SqzEzZt1Ois8c6PAA2t9bHHjJn6GRz+T7AtpYzK880bVS/kO1BdzCWJazWe6KKiCQ29Qb
 sfeEnnkEe83BW0BK8/L5HvNtODKXd2rjw5E2QRYF3ZtrIwMRjimnLCY2qcsrbRLBHZ+6m3k/aoc
 pnU571b1lsc94aGsIfuQASZ5g==
X-Received: by 2002:a17:90a:c2cb:b0:32b:c9c0:2a11 with SMTP id
 98e67ed59e1d1-353feccd1e4mr222809a91.4.1769478171353; 
 Mon, 26 Jan 2026 17:42:51 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f6129426sm660121a91.7.2026.01.26.17.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 17:42:51 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v3 1/9] target/riscv: Add cfg properities for Zvfbfa extensions
Date: Tue, 27 Jan 2026 09:42:19 +0800
Message-ID: <20260127014227.406653-2-max.chou@sifive.com>
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

The Zvfbfa extension adds more complete BF16 vector compute support
and requires the Zve32f and Zfbfmin extensions.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c                | 1 +
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 target/riscv/tcg/tcg-cpu.c        | 8 ++++++++
 3 files changed, 10 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fa7079d86e..cf237305c5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -189,6 +189,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zve64f, PRIV_VERSION_1_10_0, ext_zve64f),
     ISA_EXT_DATA_ENTRY(zve64d, PRIV_VERSION_1_10_0, ext_zve64d),
     ISA_EXT_DATA_ENTRY(zve64x, PRIV_VERSION_1_10_0, ext_zve64x),
+    ISA_EXT_DATA_ENTRY(zvfbfa, PRIV_VERSION_1_13_0, ext_zvfbfa),
     ISA_EXT_DATA_ENTRY(zvfbfmin, PRIV_VERSION_1_12_0, ext_zvfbfmin),
     ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
     ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 70ec650abf..3696f02ee0 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -99,6 +99,7 @@ BOOL_FIELD(ext_zvks)
 BOOL_FIELD(ext_zvksc)
 BOOL_FIELD(ext_zvksg)
 BOOL_FIELD(ext_zmmul)
+BOOL_FIELD(ext_zvfbfa)
 BOOL_FIELD(ext_zvfbfmin)
 BOOL_FIELD(ext_zvfbfwma)
 BOOL_FIELD(ext_zvfh)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 988b2d905f..720ff0c2a3 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -720,6 +720,14 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_zvfbfa) {
+        if (!cpu->cfg.ext_zve32f || !cpu->cfg.ext_zfbfmin) {
+            error_setg(errp, "Zvfbfa extension requires Zve32f extension "
+                             "and Zfbfmin extension");
+            return;
+        }
+    }
+
     if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
         error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
         return;
-- 
2.52.0



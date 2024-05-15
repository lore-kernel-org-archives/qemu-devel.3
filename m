Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB39C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79ZA-0002Aq-0Q; Wed, 15 May 2024 04:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s79Z7-0001y0-Us
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:00:46 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1s79Z3-0006Uv-GD
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:00:45 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ee0132a6f3so50041545ad.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 01:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1715760039; x=1716364839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7O3me2A3EyGgD+KWkf98RQrX1/WsA8xiG3u+UiJbo1c=;
 b=hcl1zckj+h28wxiYbH6r2EkGLjWYYYA1AFKh1bi4GVRqfUSHgNf/giOeI3vpmB/pdm
 AFGQYY0y1P57zu8bhJB0WDxJ1J4qzTgVVRiKl6c5dIZSKswsw8JJIoe1uyUgs/HCIX5r
 uMvqMCasY8pF/Ng2dEgt+X9Mwh6SLRJBEleSGVkDcu10O3hivIVpR1dVPxvcMDcdKZDe
 i4tetgo9g8JsKz8Ad15D8Fs7Cx7NJEz1yd1TgyQxTqAMH4noW+xtLzLtMtY/pKt2H1gU
 DqCn1JlCLXiU99yXhGX2f5fjYRnIfDZ8f3/adfn5C+SBi6WxoyzxpuG7494CMEjmaf2k
 mpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715760039; x=1716364839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7O3me2A3EyGgD+KWkf98RQrX1/WsA8xiG3u+UiJbo1c=;
 b=mzgTe480Su/dY1nsFXExJwtZ8+I2kI8AkrZaTK9hMVZG9AuuL8yBRCIRtkJ2Ml1+Tx
 y/2+RCIHa8lCZwHFK0SvgrrZmcWAq2I7/cp8WImp3aIjkpGc1ydU5B0doNpqVDL9Gm/a
 IQEsZqkL1qdo3bHdL/kKx8QgGy4/ot7CBP2c4uHQgt+oTvqWSTmPubu82QCZG5BaiQUG
 1FzIrMwmn269zDXF3T4HwedO+iDJaUo6bb16fjXivNhb65sdC0mceUuEjzrYSZIn0RXN
 SM0uGnREbgmWYewIwXEczqYAQ+W1ranb6h2SAlL4pEJFrAW3Ug0ZhIziwdpe39wI4Dp+
 aoaA==
X-Gm-Message-State: AOJu0YzqPsvv4zpEjHwnWvlDtZE6AgMISI9Qgk0eplDqU3l27xK0krOD
 Ofcvy3rNYzET35ldyCrxmXhy0pwRawmxoaglFoDQrEIYUIo0B46D4KrhAZJaSQxRb1Pcsv+9g7S
 Q07nHHeIGff8ZiB2heNra1bx3lV/g/QYCdT9ybtYGns/n8zYq5w1JCMAjG0b45zYAkaIa06ZoS8
 yZR+gaj6r1SjsWsZMV3uPJinGPiKKi8k+D0nY=
X-Google-Smtp-Source: AGHT+IFsF2SsjDxMWiE5pCrC83JDsiJQhsWJQQXkL6tbrZZwL759I3oHUiZsK3hX8mmHR1HYgRFCLA==
X-Received: by 2002:a17:903:2381:b0:1e2:6b5d:5b18 with SMTP id
 d9443c01a7336-1ef43f4cf98mr183634425ad.51.1715760039134; 
 Wed, 15 May 2024 01:00:39 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0b9d1642sm111418795ad.31.2024.05.15.01.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 01:00:38 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Jim Shu <jim.shu@sifive.com>, "Fea . Wang" <fea.wang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>, Max Chou <max.chou@sifive.com>
Subject: [RESEND PATCH v2 1/5] target/riscv: Reuse the conversion function of
 priv_spec
Date: Wed, 15 May 2024 16:05:58 +0800
Message-Id: <20240515080605.2675399-2-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515080605.2675399-1-fea.wang@sifive.com>
References: <20240515080605.2675399-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=fea.wang@sifive.com; helo=mail-pl1-x631.google.com
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

From: Jim Shu <jim.shu@sifive.com>

Public the conversion function of priv_spec in cpu.h, so that tcg-cpu.c
could also use it.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/riscv/cpu.c         |  2 +-
 target/riscv/cpu.h         |  1 +
 target/riscv/tcg/tcg-cpu.c | 13 ++++---------
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2946ac298a..6dd3d7f4a3 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1786,7 +1786,7 @@ static int priv_spec_from_str(const char *priv_spec_str)
     return priv_version;
 }
 
-static const char *priv_spec_to_str(int priv_version)
+const char *priv_spec_to_str(int priv_version)
 {
     switch (priv_version) {
     case PRIV_VERSION_1_10_0:
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 1501868008..140eb43fcb 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -833,4 +833,5 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 /* Implemented in th_csr.c */
 void th_register_custom_csrs(RISCVCPU *cpu);
 
+const char *priv_spec_to_str(int priv_version);
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index f59b5d7f2d..fa186093fb 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -76,16 +76,11 @@ static void riscv_cpu_write_misa_bit(RISCVCPU *cpu, uint32_t bit,
 
 static const char *cpu_priv_ver_to_str(int priv_ver)
 {
-    switch (priv_ver) {
-    case PRIV_VERSION_1_10_0:
-        return "v1.10.0";
-    case PRIV_VERSION_1_11_0:
-        return "v1.11.0";
-    case PRIV_VERSION_1_12_0:
-        return "v1.12.0";
-    }
+    const char *priv_spec_str = priv_spec_to_str(priv_ver);
 
-    g_assert_not_reached();
+    g_assert(priv_spec_str);
+
+    return priv_spec_str;
 }
 
 static void riscv_cpu_synchronize_from_tb(CPUState *cs,
-- 
2.34.1



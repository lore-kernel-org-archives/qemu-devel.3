Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7592D10F3A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 01:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCqO8-000188-KJ; Sun, 17 Nov 2024 20:17:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tCqO5-00016h-6e
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 20:17:09 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tCqO1-0006Sz-W4
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 20:17:08 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7eab7622b61so2771900a12.1
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2024 17:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731892624; x=1732497424;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yrPlHuJWuEh2kYh2wmPqEvV/twWv5OmoI09hlzoiKIo=;
 b=z0SmBjR8fbWh/uvUtxcorLiYrlFB6VrSze01w0Qo0xOTZcYQJCNijg96B9zsn5nra4
 Af5pwGtwnFm6AfiBOteAcuNJbISJNV51k7Pai0e/G3nxV4hLjGG3iFxaweV6sjGil0Uv
 hnO5SujT8FAPbpMiKc4KCJVU+Ay1HNxYYwdbR91xH61wgOi/11EEM7lvGpH5W66DmAg1
 vbdMCdTCHRU7Ni+XNW2IDoIUH9fESw2YS/IMts3JT1p/mxwKSW/7dt0ozl+y042GcQ0h
 UvOaU2ic4CkJ5XhJouAcAmM+ZSh3W61s8JuPLCaHwbKRLbwfyPPsO4BWZgqGTR/DnmTe
 OdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731892624; x=1732497424;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yrPlHuJWuEh2kYh2wmPqEvV/twWv5OmoI09hlzoiKIo=;
 b=cF02YXkaGTqffJzhOVOSCHUa5G2RER+9QTERYpK8hZ/Alguf1S9JUSiO5bgqBEEq2s
 dhXV8Z3B1Lli1esQonfibT6i5/H6EN10CFPF/Ui+JAq04x0UpisKkVpHEQgXJPGIt67X
 8YSJxgRONbPLvHtDR3Wewm+ISsWJL1O193x80jKxt+QFKMqYrCKuyoNRvb0109YSJ/oU
 fRDuC2DXX9ep89ApbqCMLTYftZOBaNW0mGBEy8GTIPxXB9k83JtHovmtBXUx7tqkmZXd
 4F54UT4nNMHVuqwP77lytA0qeCCm6NikgXZS0XvecmuR/REFO7IWhgBnvpRctDLYqiqp
 yFqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+MSU4dRys++dMLCFbZu6YY16wU2EWIO9FBv1C1L29Q5s7Qkcn/kx6Ca4pONMLQGgLjRkdt8rMVy7k@nongnu.org
X-Gm-Message-State: AOJu0Yyj9TjkB5MmymKFXhkJq2vK0truRTRow7FJwITz/69JK3stTvMQ
 GYk3791GmLy8h1nbb+jQZgKP0mrYnJB8fdZbOiwRukrNdyIi4qO0KN2Cl6LmoWv5a/fKWLwX53N
 7
X-Google-Smtp-Source: AGHT+IFyERO+IUJIVSzfZa8WYRSNfEUTdjWCNkqi7kcwkLxLeu7cg9FaBIjdgNDOuKXHmKJBtp9VVA==
X-Received: by 2002:a05:6a20:2449:b0:1d8:a29b:8f6f with SMTP id
 adf61e73a8af0-1dc90b1cc5emr14277789637.16.1731892624095; 
 Sun, 17 Nov 2024 17:17:04 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724771e8b75sm5134024b3a.147.2024.11.17.17.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2024 17:17:03 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Sun, 17 Nov 2024 17:15:58 -0800
Subject: [PATCH v3 10/11] target/riscv: Add implied rule for counter
 delegation extensions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241117-counter_delegation-v3-10-476d6f36e3c8@rivosinc.com>
References: <20241117-counter_delegation-v3-0-476d6f36e3c8@rivosinc.com>
In-Reply-To: <20241117-counter_delegation-v3-0-476d6f36e3c8@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=atishp@rivosinc.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The counter delegation/configuration extensions depend on the following
extensions.

1. Smcdeleg - To enable counter delegation from M to S
2. S[m|s]csrind - To enable indirect access CSRs

Add an implied rule so that these extensions are enabled by default
if the sscfg extension is enabled.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 82edd28e2e1d..410ca2e3a666 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2642,6 +2642,16 @@ static RISCVCPUImpliedExtsRule ZVKSG_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule SSCFG_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_ssccfg),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_smcsrind), CPU_CFG_OFFSET(ext_sscsrind),
+        CPU_CFG_OFFSET(ext_smcdeleg),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
     &RVM_IMPLIED, &RVV_IMPLIED, NULL
@@ -2659,7 +2669,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZVE64X_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
     &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
     &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
-    &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED,
+    &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
     NULL
 };
 

-- 
2.34.1



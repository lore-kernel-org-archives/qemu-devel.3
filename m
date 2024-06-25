Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F962C3065A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 11:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM4de-00082d-Ps; Tue, 25 Jun 2024 07:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sM4dY-00080f-Nu
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 07:47:01 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sM4dX-0000cX-2G
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 07:47:00 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f9e2affc8cso31860925ad.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 04:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1719316017; x=1719920817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qax+N6zJMlHLL8gC9AsPWc/LtF/KqpVZ6WmTr4ImBMo=;
 b=ata3nTlee/w3ir7ewnAl6cB7MnTzX++7mFYn1UnKqVHNhvBY4gPHSbhkIyfdTDTYmJ
 sMojYzhCNV6KJEG5x81DoNCTQulSuVbX4rBZIrcr5ReopHGc9eNXue92zn0Yy36k9lRp
 Zfd37+ne3bqrq5GOs/DGclfqaEDJnKaves1ztz/+D9NPcHKgC7z3VcxzEagFNQGax1BG
 BDEeUq3q5yKvM4BN5rt0sjwKmKxFVqRibVZdg4rM1TDsoguMQMAjvJ07xhNzeu/2ejVe
 b+6jkxo78N768HQZQsR22ygt72ENIxbui7IWmf/106SQiFQGX3F/1Mh8RpP5JfldjlKO
 c9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719316017; x=1719920817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qax+N6zJMlHLL8gC9AsPWc/LtF/KqpVZ6WmTr4ImBMo=;
 b=hVfBllkTfm48KsWxoks86u+aXjzpBCf5eOINotldNmidoYlVM4bGqP6Do4Um9KYeHV
 NIPk25VPU411JAjMglvecup8Smpz4PQeTfa5xaHDnYBiOZO3XaMJ855Jo8FGtIlyS3Bl
 xglFcEhfFYVouPYFiKLLtMGAhMUKCK0dHCX3dptUrATUlexLKpxUImSTdXla1vZt6yAH
 1qocxRyXXDUB21IE//w8FIjdXbTyu+jC0u481duZ/igbEf3sFKoYQQ8ud+/ikbv6on//
 TDKOOKGYjSxJsQW2zyFTuORFdp0aKDdsDk0JVYFLWrC/coTWeJOQYjGE6mJ85+oifrHl
 HHQg==
X-Gm-Message-State: AOJu0YxGRTogKu67ZTY3kdlTJ4BFJxAX02obSCkVsfKiYegn/wdFsowa
 mDE/B1AndgXwo4s8/egRh25btaX+JAaQ/PbQz3ntMwC58OahRbyLvGuagRCJ3Yhs3ZyKCclTRhS
 Ge4WLWB6R/QNewqdJPS0J2YD1tzZyJtFjh2ppuG628uL5uT8hfx1ABy0mkUmhjboNOLcTlHNqUC
 lF7UnBvkQjTEDv88S2nBt1wgwwRDl9aypMJy//79Pr7EBH
X-Google-Smtp-Source: AGHT+IGnQgMQ6ljR2JBrzMKmrdpD7zsaV/+e5VHw/izKEHqaMIH+GBFGZ3WcP7e+8tOrq6CB4YTdEQ==
X-Received: by 2002:a17:902:ccce:b0:1f3:2e31:f83a with SMTP id
 d9443c01a7336-1fa23f1d31fmr80113845ad.46.1719316016716; 
 Tue, 25 Jun 2024 04:46:56 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb321d4esm79472325ad.67.2024.06.25.04.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 04:46:56 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>,
 Jerry Zhang Jian <jerry.zhangjian@sifive.com>,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v3 3/6] target/riscv: Add MISA extension implied rules
Date: Tue, 25 Jun 2024 19:46:26 +0800
Message-ID: <20240625114629.27793-4-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240625114629.27793-1-frank.chang@sifive.com>
References: <20240625114629.27793-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62f.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Add MISA extension implied rules to enable the implied extensions
of MISA recursively.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
Tested-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 50 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7b071ade04..b463bd8370 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2250,8 +2250,56 @@ RISCVCPUProfile *riscv_profiles[] = {
     NULL,
 };
 
+static RISCVCPUImpliedExtsRule RVA_IMPLIED = {
+    .is_misa = true,
+    .ext = RVA,
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zalrsc), CPU_CFG_OFFSET(ext_zaamo),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule RVD_IMPLIED = {
+    .is_misa = true,
+    .ext = RVD,
+    .implied_misa_exts = RVF,
+    .implied_multi_exts = { RISCV_IMPLIED_EXTS_RULE_END },
+};
+
+static RISCVCPUImpliedExtsRule RVF_IMPLIED = {
+    .is_misa = true,
+    .ext = RVF,
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zicsr),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule RVM_IMPLIED = {
+    .is_misa = true,
+    .ext = RVM,
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zmmul),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule RVV_IMPLIED = {
+    .is_misa = true,
+    .ext = RVV,
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve64d),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
-    NULL
+    &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
+    &RVM_IMPLIED, &RVV_IMPLIED, NULL
 };
 
 RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
-- 
2.43.2



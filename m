Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865B4C27C53
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2024 02:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIfvL-0007Pn-Bg; Sat, 15 Jun 2024 22:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sIfvH-0007Ne-Dg
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 22:47:17 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sIfvF-0001hk-SY
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 22:47:15 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2c3050f4c50so2721544a91.0
 for <qemu-devel@nongnu.org>; Sat, 15 Jun 2024 19:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1718506032; x=1719110832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wqwE76CQo0Svp3wf95GRe/VgtMvrGF7qfdx6aXlVV2E=;
 b=Efh1i7C4cSBV4MPDdzwdG56GvezwwzE/fSFBV7obh5FpY6ZfLs5VXyFYFmgYnTSAnE
 uBKXzoIE/2RUYMD4QbH/0/NWHzY9LbR6GhK6jQ+gkMEjwMlgHKIy8K9ImFEAV3NZap7k
 C2LgPApF0ww/szZ8oaFZMVLZNrtr9nawCTTJKn+DH3axCIkDrePERBd7fg2+hwrjcRE4
 uoihCIV/wa/KwQTYyqfM6oNS6E8O+ki0AQPZ3fR717ZIZ8uFK6u9WOLdpyWIJsOLN4kl
 WbPyv0Y/xVAAH8byIWnoHRKV99IR2tIY+fkrjOCHths6vq709T389PI+NkSp2DEtiDji
 jldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718506032; x=1719110832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wqwE76CQo0Svp3wf95GRe/VgtMvrGF7qfdx6aXlVV2E=;
 b=jIWebJV3v3MeW/+VRcTua5Brcn33h7VBX39uNJYSBgUbivLUQCUutdmRma59cjNl4u
 o5FUF3X68t6yl5sYShv9hg3uwIk+ll8hibuWJw9AVnIatXG5bwLxSlUx1jqw/uovI0t6
 XqVrLPhPe92nCLts0rFplOR6O8AxrzHvhaPOUTWDqgzqCC6MPUC5kQU02n62epFX5A8L
 bkTmXyGCAE0dkS5XlgjLr/u/YtiWintM1pRKD3AqzmTDcYSngoJ9jYAhZ9w37G4Wn9CC
 oCzm6yzpgXwHK2TP6/eMmvBrPoapRQE2gYjDT9Ik1iUMR9GtQurFi5IXiTg1nl/RBoCL
 fptQ==
X-Gm-Message-State: AOJu0YxvyvQTroDLTTiz9MVQ/3wItVPbbOJi6Ne4a3siheAdnp9Wjs13
 Gg0i3yMWnXpc91RiTHAnFNB8os/L8aFnEG/RpPrbozJfbFs1+vnp7S6jy+D22GdkeKIt5fSUwqu
 31gznay3g0nobQ6HqFn3xZw1GilL6d+LICHnQHEWpYKu9FxZ6l6N+5Kjpf5kuHWnx83qUY053P9
 dF0Ae7/gntD41JTnNpRfWqMIlCnRjq+7nPRAdnayM=
X-Google-Smtp-Source: AGHT+IHXX137WNtDA7G1jtTkWSmPNDhh34VM5ttJo/6kxH2m14azQysbNIxhtDWcM7atKf4QUe+ocg==
X-Received: by 2002:a17:902:c94d:b0:1f7:1688:9e36 with SMTP id
 d9443c01a7336-1f86290073cmr72887745ad.48.1718506031945; 
 Sat, 15 Jun 2024 19:47:11 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e7ca78sm56258705ad.106.2024.06.15.19.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jun 2024 19:47:11 -0700 (PDT)
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
Subject: [PATCH v2 3/6] target/riscv: Add MISA implied rules
Date: Sun, 16 Jun 2024 10:46:54 +0800
Message-ID: <20240616024657.17948-4-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240616024657.17948-1-frank.chang@sifive.com>
References: <20240616024657.17948-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x102d.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Add MISA extension implied rules to enable the implied extensions
of MISA recursively.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
Tested-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 50 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index bacbb32120..d09b5e9e62 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2250,8 +2250,56 @@ RISCVCPUProfile *riscv_profiles[] = {
     NULL,
 };
 
+static RISCVCPUImpliedExtsRule RVA_IMPLIED = {
+    .is_misa = true,
+    .ext = RVA,
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zalrsc), CPU_CFG_OFFSET(ext_zaamo),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule RVD_IMPLIED = {
+    .is_misa = true,
+    .ext = RVD,
+    .implied_misas = RVF,
+    .implied_exts = { RISCV_IMPLIED_EXTS_RULE_END },
+};
+
+static RISCVCPUImpliedExtsRule RVF_IMPLIED = {
+    .is_misa = true,
+    .ext = RVF,
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zicsr),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule RVM_IMPLIED = {
+    .is_misa = true,
+    .ext = RVM,
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zmmul),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule RVV_IMPLIED = {
+    .is_misa = true,
+    .ext = RVV,
+    .implied_exts = {
+        CPU_CFG_OFFSET(ext_zve64d),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 RISCVCPUImpliedExtsRule *riscv_misa_implied_rules[] = {
-    NULL
+    &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
+    &RVM_IMPLIED, &RVV_IMPLIED, NULL
 };
 
 RISCVCPUImpliedExtsRule *riscv_ext_implied_rules[] = {
-- 
2.43.2



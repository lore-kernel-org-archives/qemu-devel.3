Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33545C3ABC5
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 04:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF3T3-00024f-Lr; Wed, 14 May 2025 00:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1uF3T1-0001zM-0S
 for qemu-devel@nongnu.org; Wed, 14 May 2025 00:11:39 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1uF3Sz-0001jG-2w
 for qemu-devel@nongnu.org; Wed, 14 May 2025 00:11:38 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-30820167b47so412620a91.0
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 21:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1747195895; x=1747800695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1A6Tdq+NlocQQr+dW43vTkDs6+pSgcMdXP/qV+lPTUo=;
 b=ilmsAxtmrG0uEHZnamDZTyxMGKuf3/EQxzIPMsuCpvHgBaZgDZsgz9szUFN/UNLsT3
 dJDcOxBcYIQHbYDmDSt+tST49ojNViR8JZR7ldLoykDOIY6qhKzrrecup5Fsz/dlWRV4
 K+0h3owIBoyfx4P3MoVkypNWD907ZvVvEXzcqG7m0hzvUPZV0gkBT3NwBhTorOr3Se80
 BC5VBG9pp3v7AXOJILAKmbtYQjY+8VUmBJ2JnEVAvEJlP7OiZBLLD7UdJbk0/SGqneTo
 W4CUYcgMrFYmcuRLPpJzpqQ6DE4sjBDoKfHIagtwjcTNZtRps1HZDMJmJV2dlO87ESbY
 THRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747195895; x=1747800695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1A6Tdq+NlocQQr+dW43vTkDs6+pSgcMdXP/qV+lPTUo=;
 b=KvYF5peQBl8uMBickH1V2P8aWC/kuEcQQ3V9fBg6CWn5UAXwjjhyv8fG+iAS3/ZhCM
 W7c60/1C/mL8mA6Feod7g6wDIo1TC3NchlbBwbPk37TRee0T8vEM7IjDD7l9eqP2atet
 jooycj6dZM1n+/s6OUyP1jNtpQpHGdYotGQIf8PjIys9HiVNOCLbNVTL3VZxsS9jCFRW
 sxkepABJbEwyHCeffkbZCThLp0X7tMLIU7uaW22pAz9hm5DOGY4beE6fw6vMD5dFizwn
 mj5cNKb4YeGKUdN/k/BYhJuyNcZ0W5XtuULBj/jhKkf2YJcnUZvMLF8PU3ZDRrxCBeMX
 muVw==
X-Gm-Message-State: AOJu0Yws1kn8U/sYgwum3YX/7YzevYhtKe5i4TWEaAPbi/0zsZe4gSQ3
 LAj4hG2ZFKpkY9Ycuah0+4+vBkE+vMHTeC32buoVvnbXwXYamNrC4N3XP4IMAXZwIW1vGFcMycg
 RGSvxXYHZKNAnaSPf64+MkKvj+1gyELpLmXba8Jvwn+kxaU0ZaXSg7RfSplTm+tn/mHiTeN/gKz
 +0pHay6v27zk/MTrIZ++lWfS9iEaOJ7WkbBbEwueYGzw==
X-Gm-Gg: ASbGnctCfXIFctvFHpUkh1Wwp25UDkhD+wyqv6ds/KavVOuLW3mDQnAo41V8oknOfU1
 HbdgBJL/EmglHv3ZEmqI/wt15S7UshfnVXdMCgFJ6rsBKnBi50yzUCynzndluNLva5jsR20E1ZL
 FXZ7NYR0QWakAw5k+ENdKnO1cHFaV1CbS9s5yh+45q4gPzl2lyYTn5asrorPaOiOhpQd+Il3PZ2
 tm7ZIi0/cwJwZHdP9iwgSfvvwk1kmJALRYqq3LMB36/HXgXYQAnEqUMAb9KKUooGsNOhVQ9KlKz
 +VgZ2LFBFoXVrsMPCyrutIdD+Kfi0ZrjzPnC2yYklAXAYu/aG+DcJ/5pxORu3Z8cBAiE3W9qSjZ
 7b4M=
X-Google-Smtp-Source: AGHT+IGbn8Wg/ANip1Vr5TSN3ZvLJF31+rLv1UOgk+0WGEUycv8aF2qmAOByzPeAvwLSWvnVQMdUTA==
X-Received: by 2002:a17:90b:51cf:b0:2fa:42f3:e3e4 with SMTP id
 98e67ed59e1d1-30e0daf5dd2mr8260370a91.3.1747195894836; 
 Tue, 13 May 2025 21:11:34 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30e3354b633sm533552a91.49.2025.05.13.21.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 21:11:34 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>,
 Jerry Zhang Jian <jerry.zhangjian@sifive.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 2/2] target/riscv: Add standard B extension implied rule
Date: Wed, 14 May 2025 12:11:18 +0800
Message-ID: <20250514041118.1614-2-frank.chang@sifive.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514041118.1614-1-frank.chang@sifive.com>
References: <20250514041118.1614-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1030.google.com
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

Add the missing implied rule for standard B extension.
Standard B extension implies Zba, Zbb, Zbs extensions.

RISC-V B spec: https://github.com/riscv/riscv-b

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
---
 target/riscv/cpu.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 27edd5af62..f737b703da 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2532,6 +2532,17 @@ static RISCVCPUImpliedExtsRule RVG_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule RVB_IMPLIED = {
+    .is_misa = true,
+    .ext = RVB,
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zba), CPU_CFG_OFFSET(ext_zbb),
+        CPU_CFG_OFFSET(ext_zbs),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 static RISCVCPUImpliedExtsRule ZCB_IMPLIED = {
     .ext = CPU_CFG_OFFSET(ext_zcb),
     .implied_multi_exts = {
@@ -2910,7 +2921,8 @@ static RISCVCPUImpliedExtsRule SSCTR_IMPLIED = {
 
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
-    &RVM_IMPLIED, &RVV_IMPLIED, &RVG_IMPLIED, NULL
+    &RVM_IMPLIED, &RVV_IMPLIED, &RVG_IMPLIED,
+    &RVB_IMPLIED, NULL
 };
 
 RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
-- 
2.49.0



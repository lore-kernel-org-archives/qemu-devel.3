Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BD0CD5BD1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 05:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSTVt-0000zH-Ss; Thu, 28 May 2026 01:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wSTVp-0000y1-Af
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:42:33 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wSTVn-0002Dq-JH
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:42:33 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2ba6485d219so95901865ad.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 22:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1779946950; x=1780551750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qrgn6fsAAhB+AN5e5tB2wnivr7mEESipyduN8RfVcu8=;
 b=dYJzcsDOqUHZSzD3kkJ7J7bGeIIxh8L4d4ZLlvAo82WSP4E1zlzzCWo2SdFHjoVc23
 8jg3a18Y8CYYqK8iqSSA6hRq3TyDs/y8kUGFL82e59AvIe86zzAWX9O+UVyB3q+BsUBe
 lrWX3lIeaVeGLX0ksHhLn6cxNA6jUzilvXoiovSN9m0LhrhjE/kOflBLBZ4xBHzYYCGG
 QdkmjJBU18vATJ9G1mLldjmGtb4N/0kNfnDSrBGF0fwNWbiynO+M87bGn2YyfXREctkA
 h7bJGfyHhW1lK6HSed7dFM7CQPJrPZ9967Hf36INJvz4CEpgpCQU5/dPhtQQT1wM1Nnt
 ykhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779946950; x=1780551750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qrgn6fsAAhB+AN5e5tB2wnivr7mEESipyduN8RfVcu8=;
 b=UV1vuQi0XHFGGrT2UkN79Ejbavd7QpJ/4fgyQl4UIwz05n2cbw4VzeX5N4evq5fRwh
 PVydCb+DSnm9P2pEGCsMMWw6qBXbBUOErXvAoGcKU9kIBjHjGvZQGWJLFLHV9achQq6/
 Lcpoe4Eun3fsUzu0eJ03VVZR6hEjlHtkqwBOaEHzT7Pr4x0vn01gVVQl9oBs6797bi8g
 XHwbFvzW0EQA1lfH6joql0267JkcQ6Chv604XZA9WN1hZc2zY4Ar8SToFzwonQz1/I9B
 45IUdaED7+3T9wFIXJEymkK1+gRRqB5Ewxvjzbb8tXYLQOKYF+r3EURwdy37EnfEZ0g1
 ZmOA==
X-Gm-Message-State: AOJu0YxHDLCfQSam+gewsqYG2tU0oUHTFzZkzN3pqyEPyMDZvvcqUDFr
 WLNGhpGw4X7x14LGwnbouCiBiEvaZ8HpVI6nfuiYuUjdxv/vi7am0rNFpnFA3d3HWON6RilO15x
 G17KtYFsu/PSFhFA1e6hueW8inEw0n0rl964vQMIN3YHXyIpBtkmhFMHuW+E9wMEWDtWTs2gTjS
 HvSqf6zUnKAB4lHTDgdkGSl9/xlLRoK50f2Hm53xbmQW3LesRA
X-Gm-Gg: Acq92OF1wL6j6hKpThtXSsK+kqSnXsldjCjU7i6iF+sY71wBz8fUJv6KISO76zsuM5K
 wZky79AMU6wBxoNS4EDsrnmnkcuaI4zyiVTc+GWzbSnqPFqVyZMxeEe6uyuDIunicyw0DhC09nm
 SE9WlJAwEjimbK01Ew+no33T9aaGSj15U+Klsec6xRTOoeyQzgtJp6ySx1KfQ0f8WZzlNgX0C/X
 jJnCJaSM/FZI+AWpzoT6KxfDK43etCpCg3+nXFuA+w9LP/TqlrF3/5019LgjxCUEGAvpq3oj3db
 FirzBnmmV12aeMmx+sov1FdbYipeo25NuH0QfXUoophq9ATp6bq5kBV6Xosk+dEt6TovgfXiz4A
 5zZpTSWAjDJXF96rUgnELXCTaDTDcYUJIetES+TQMXGVDhkmm00CCGmyKz04LCBVhtG5uqXuK3W
 y6BOYpQz6s39uLq6VUis167q/zq8Ch+cVqAYghOADGO/+Jl7yPW4k2OZG5156x
X-Received: by 2002:a17:903:28d:b0:2b9:f55e:1c1b with SMTP id
 d9443c01a7336-2beb036aa31mr276620225ad.5.1779946949588; 
 Wed, 27 May 2026 22:42:29 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beca535bc1sm122275815ad.56.2026.05.27.22.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 22:42:29 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>,
 Jerry Zhang Jian <jerry.zhangjian@sifive.com>,
 Jim Shu <jim.shu@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 2/2] target/riscv: Add standard B extension implied rule
Date: Thu, 28 May 2026 13:42:13 +0800
Message-ID: <20260528054213.678458-3-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528054213.678458-1-frank.chang@sifive.com>
References: <20260528054213.678458-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62b.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Add the missing implied rule for standard B extension.
Standard B extension implies Zba, Zbb, Zbs extensions.
We can also remove the auto-enables in riscv_cpu_validate_b()
as Zba, Zbb, Zbs extensions can be enabled by the implied rule.

RISC-V B spec: https://github.com/riscv/riscv-b

Reviewed-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Frank Chang <frank.chang@sifive.com>

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.c         | 14 +++++++++++++-
 target/riscv/tcg/tcg-cpu.c | 18 +++---------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4246fb87c64..d1452d91f2a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2106,6 +2106,17 @@ static RISCVCPUImpliedExtsRule RVG_IMPLIED = {
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
@@ -2513,7 +2524,8 @@ static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
 
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
-    &RVM_IMPLIED, &RVV_IMPLIED, &RVG_IMPLIED, NULL
+    &RVM_IMPLIED, &RVV_IMPLIED, &RVG_IMPLIED,
+    &RVB_IMPLIED, NULL
 };
 
 RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 66ac011c54d..d26d9001bd2 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -515,27 +515,15 @@ static void riscv_cpu_validate_b(RISCVCPU *cpu)
     const char *warn_msg = "RVB mandates disabled extension %s";
 
     if (!cpu->cfg.ext_zba) {
-        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zba))) {
-            cpu->cfg.ext_zba = true;
-        } else {
-            warn_report(warn_msg, "zba");
-        }
+        warn_report(warn_msg, "zba");
     }
 
     if (!cpu->cfg.ext_zbb) {
-        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zbb))) {
-            cpu->cfg.ext_zbb = true;
-        } else {
-            warn_report(warn_msg, "zbb");
-        }
+        warn_report(warn_msg, "zbb");
     }
 
     if (!cpu->cfg.ext_zbs) {
-        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zbs))) {
-            cpu->cfg.ext_zbs = true;
-        } else {
-            warn_report(warn_msg, "zbs");
-        }
+        warn_report(warn_msg, "zbs");
     }
 }
 
-- 
2.43.0



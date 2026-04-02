Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0316ED39429
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 13:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8ILK-0008RA-9Z; Thu, 02 Apr 2026 09:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w8IL8-0006PC-VD
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 09:44:10 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w8HXZ-0008NY-5y
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 08:52:55 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-35691a231a7so457972a91.3
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 05:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1775134366; x=1775739166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sHZMfLd721WymKv16yZIfjlFDLuoBChOk4Wra0IfBGI=;
 b=FWoCIxsuHv7lSd0ZTSVxVSaSS3NM/mATlwjDLVNGzjZ+5DIZfsXHgg8+PDVjVWwyqw
 FOZ68xyW7/igrBAH+AE1HuHyx0D3GKcUwD60Qra5WdoEAdCHHokjoU6gH/x6Hymwajtm
 ybZjPcEvnYBIBgeiS+ZLiwhO6j8S1KfI7FQuKCUfNL/ClpgpofC7WPcgDNDrOTBTbCvf
 5ridI4y7ByaYy/j4FDWM15OSJn39mk5jl8FKsqMXyBJZYp4OZGvL13KGJ22cJQOKf5TM
 xvGx745/JXBMS3JLE4aZlBrhIba06GY9zqyd5kBd4u+GGuc29Lk9U2GMuqpxDS2Q1nU/
 QQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775134366; x=1775739166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sHZMfLd721WymKv16yZIfjlFDLuoBChOk4Wra0IfBGI=;
 b=gaiBN4l5fCXLHW0wlsFTd9c4pzp2SBwg376Q4qidbNI0e0eQWpMl2ZY6y8yKJOL5z0
 tR0e3KHsVC0szQu/ywajwxHPt7fpQ+y7BCRiqO/4/uAo/6/cbieE1df6lqO5lBHrRYpq
 ayqPsi8t98KQWmqn33THsgMayo1FyA+9lPDOTDufrDkPQRKrukl5hy1FbIIBj4vByPH0
 /kOm5iZnOUsM8AlbNRPwXdrMiHHbEAEvdnuIBGXkSRMk7DXaEo/yO24Bq5yFiVi2EjNB
 /YRhGOqrPVZviSE057iAmVA7oQl/97X9cXRBE0hN1q155V4ATBd4FeLFGuQPUm6gPQ+h
 8Qcg==
X-Gm-Message-State: AOJu0YyOFv01Bn7iGNSymSZFj7foPSGojMQbW8VGAYRcPE5oRp2coC7B
 2iJSaX/hkmSXIMDnpLAC/MLe+2dR5AxTpXnCILB9/mlexGuAiNGzqtoengHkQAl99y5kHHiShFd
 fpgAxHXFFRFqCWP9F5G++xMo03AtgPKaN1Kqhh0T3hI2U4MfIbt4m8IA7a0sNXd8Zlaj2l0GnPV
 3TKDQxMaTXQIvylurgtSMoOmP1zjtimLO99F2tFKE=
X-Gm-Gg: AeBDieuDqdH8mHeItFjg2a1KjAjcYsz28ayX4WkN6JlTcpOpggdvJDfquCXb4N9aqwL
 xa3KJZYdyaTCQFvWd1jxZR4TFIJLEv5WgJ9VRJPd7Jqnm4sm6hFKvO+UAwUEbSwlvwkt6Za1SfX
 9bEyFldnRHyp2+kTeHK4eP2k0ocT/daGbYnO56FOFpSqULRxDfcJAOwq2M6rXA2LXtypCqWGg/o
 q5N1713YsIIQl9DLEeuOhojK0AF0Y+vr83aYX3gYRQdsvg3u3ILCWmUUDgty6cgsMrgOSqHnP2s
 YRRMnI4QeBDTIDk1vIdBtWf7qiNGq3CKh+nx1orWHiKaXxy6zaRvUDaEnRGSZVm8KaOdoD40gV4
 tjSjVMhVcN2sIiSUWQF9Y+S/KCNv0qLRJO4igCzUU9/K0nXGxJG9MTwY1qaPuMlWczWzB/fZpPW
 pZOyyANd8lOyJSvS3eXY1mc4ZAzMXcWY7CedXHG4WL2X1Ls0V5x5X43qVVp95sXkJ2cw/8ivSOK
 RLOqQqZf6+eaHmSrVjIXAbp7aw=
X-Received: by 2002:a17:90b:2892:b0:35b:ea35:c3d7 with SMTP id
 98e67ed59e1d1-35dc6d29cdbmr7300483a91.0.1775134365983; 
 Thu, 02 Apr 2026 05:52:45 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dd35364edsm2730032a91.0.2026.04.02.05.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 05:52:45 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v6 2/9] target/riscv: Add the Zvfbfa extension implied rule
Date: Thu,  2 Apr 2026 20:52:27 +0800
Message-ID: <20260402125234.1371897-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402125234.1371897-1-max.chou@sifive.com>
References: <20260402125234.1371897-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1033.google.com
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

According to the Zvfbfa isa spec:
The Zvfbfa extension requires the Zve32f and Zfbfmin extensions.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7c652dea78..bbab96385b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2622,6 +2622,15 @@ static RISCVCPUImpliedExtsRule SSCTR_IMPLIED = {
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
@@ -2635,8 +2644,8 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
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



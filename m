Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269BEC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 18:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLo8O-0002bH-NS; Mon, 24 Jun 2024 14:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLo8K-0002ag-22
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 14:09:40 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLo8I-0005WC-Bn
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 14:09:39 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7024d571d8eso3675261b3a.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 11:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719252576; x=1719857376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hk0VnpAGUhDWCzrPpaDYSlTmYSM3R8aHA3LLzBaPzwg=;
 b=JY454uKFkFUSq+VWApXkjoUIkAIlxduC/13sjEUzqOd7DrUl1tu0U8VXeTW4WL0j4K
 UKCizyltRPE5AsW+aiZylJb8UU9QYFJlAdy+Z6PyiTQgtMC3aQVUGs71XEtm/2+eoV5M
 1IsQQ9O2/sHh1s1kmsdUPoP7SOAx7Z3d9YhGP6uBkwJHno2/M1xS0Pcah0RxSLYm1+7P
 SO0DIghxiy+fYjNHjFjazjgS6abahlwLZBxwKV3iXKMsSVGHi/z/jkL7gJ63z9GWG+8A
 GGBhQGGinbbu7PcWprj8fnhIbwZGTmnhrgT0D/rS0Z4MUYPUkHI5RqSh5prcafbpyrWw
 ncQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719252576; x=1719857376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hk0VnpAGUhDWCzrPpaDYSlTmYSM3R8aHA3LLzBaPzwg=;
 b=QMZCdjmMr9E7l2aREzQg7XeQuJY6g+pUAd/IGxnIpRyB87WDt4ZFvFgRXAZ1CMU3EM
 tyPMje4sIP9Yg/y/hxM3HFOIfAXVK9T5LcLNMKDMtx7+BvM0lgWItF/9vvpAoQPccFJB
 KE0a93grgSfzu2cN22nhJghUJ7sCGPJogWD0zHuzrZrt2Etf3wcFmhuzNeNQrvra2ElN
 doiP+y8mmM3ABaBClejl5HGyp6yr8KtUEIrYPko58+iaDY2o3AzZCtk9Rl3GsBCHNtoT
 uI4UvtAVDmCh5kjULYUrQ//A5m4/zID0KmqTbN/qwfKYcauBqPLrxMCcWjQkcA4oXgku
 eQxg==
X-Gm-Message-State: AOJu0YxhukoNlOWq5N+z4ZT6AhtgbG3BYXIZ0zfMhlUDOAKd9PRMDvm0
 GaynTxJ/XZpDFrtCi73Jms4jDvuNFFw6NR0QozaEvuNng8w+tPGE6ssmS/06uEugic1BfzfbAWb
 n
X-Google-Smtp-Source: AGHT+IG+qSY7RpynGoUuG8yF2Voxbk32WBuoBpvCBu+iph77Jc5Atf8fvcx3DHi5U2jZXJhvA0MwIw==
X-Received: by 2002:a05:6a00:4fd4:b0:706:9030:8960 with SMTP id
 d2e1a72fcca58-70690308abbmr2098107b3a.4.1719252576182; 
 Mon, 24 Jun 2024 11:09:36 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:1758:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706666e9708sm4974942b3a.121.2024.06.24.11.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 11:09:35 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org
Cc: philmd@linaro.org,
	alex.bennee@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v3 3/3] target/arm: Enable FEAT_Debugv8p8 for -cpu max
Date: Mon, 24 Jun 2024 18:09:15 +0000
Message-Id: <20240624180915.4528-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624180915.4528-1-gustavo.romero@linaro.org>
References: <20240624180915.4528-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x431.google.com
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

Enable FEAT_Debugv8p8 for max CPU. This feature is out of scope for QEMU
since it concerns the external debug interface for JTAG, but is
mandatory in Armv8.8 implementations, hence it is reported as supported
in the ID registers.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu32.c        | 6 +++---
 target/arm/tcg/cpu64.c        | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 1a06a5feb6..3ab6e72667 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -41,6 +41,7 @@ the following architecture extensions:
 - FEAT_Debugv8p1 (Debug with VHE)
 - FEAT_Debugv8p2 (Debug changes for v8.2)
 - FEAT_Debugv8p4 (Debug changes for v8.4)
+- FEAT_Debugv8p8 (Debug changes for v8.8)
 - FEAT_DotProd (Advanced SIMD dot product instructions)
 - FEAT_DoubleFault (Double Fault Extension)
 - FEAT_E0PD (Preventing EL0 access to halves of address maps)
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 28a5c033bb..20c2737f17 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -82,8 +82,8 @@ void aa32_max_features(ARMCPU *cpu)
     cpu->isar.id_pfr2 = t;
 
     t = cpu->isar.id_dfr0;
-    t = FIELD_DP32(t, ID_DFR0, COPDBG, 9);        /* FEAT_Debugv8p4 */
-    t = FIELD_DP32(t, ID_DFR0, COPSDBG, 9);       /* FEAT_Debugv8p4 */
+    t = FIELD_DP32(t, ID_DFR0, COPDBG, 10);       /* FEAT_Debugv8p8 */
+    t = FIELD_DP32(t, ID_DFR0, COPSDBG, 10);      /* FEAT_Debugv8p8 */
     t = FIELD_DP32(t, ID_DFR0, PERFMON, 6);       /* FEAT_PMUv3p5 */
     cpu->isar.id_dfr0 = t;
 
@@ -93,7 +93,7 @@ void aa32_max_features(ARMCPU *cpu)
     t = 0x00008000;
     t = FIELD_DP32(t, DBGDIDR, SE_IMP, 1);
     t = FIELD_DP32(t, DBGDIDR, NSUHD_IMP, 1);
-    t = FIELD_DP32(t, DBGDIDR, VERSION, 6);       /* Armv8 debug */
+    t = FIELD_DP32(t, DBGDIDR, VERSION, 10);      /* FEAT_Debugv8p8 */
     t = FIELD_DP32(t, DBGDIDR, CTX_CMPS, 1);
     t = FIELD_DP32(t, DBGDIDR, BRPS, 5);
     t = FIELD_DP32(t, DBGDIDR, WRPS, 3);
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 71e1bfcd4e..fe232eb306 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1253,7 +1253,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     cpu->isar.id_aa64zfr0 = t;
 
     t = cpu->isar.id_aa64dfr0;
-    t = FIELD_DP64(t, ID_AA64DFR0, DEBUGVER, 9);  /* FEAT_Debugv8p4 */
+    t = FIELD_DP64(t, ID_AA64DFR0, DEBUGVER, 10); /* FEAT_Debugv8p8 */
     t = FIELD_DP64(t, ID_AA64DFR0, PMUVER, 6);    /* FEAT_PMUv3p5 */
     t = FIELD_DP64(t, ID_AA64DFR0, HPMN0, 1);     /* FEAT_HPMN0 */
     cpu->isar.id_aa64dfr0 = t;
-- 
2.34.1



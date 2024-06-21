Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9B0C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 14:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKfQY-0006qH-LI; Fri, 21 Jun 2024 10:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sKfQV-0006pn-F9
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:39:43 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sKfQT-0007yG-TF
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:39:43 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70661cd46d2so148007b3a.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 07:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718980780; x=1719585580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+1bsxXTyJYNTiYjX7+F9Hoal/1vE9r9yDkUQkjviuNk=;
 b=SD08RSKwB0AQc4UbyLAwuSvM/Gh4p7iO+ZDm9E04lT62HkgMzQDh7M49oO/fTV9R0a
 m2JD9xQF6iwbYSdrRimRngJ9kpncSAGlaAb5qRnKFkJLjU79Xs+eeCuG+LFjRMhx0TyX
 VrE1G58HuynNxbhqhmzS7oU8wnFhpT7juLyXTliSqxgaOq9yeKdYw+ZcgnM4nxq2SGsA
 BZ6zvzd6/OUOnWUx4kdSGjHFBBLWpxy3A5XuOadhD8UoDZWQfsPDkxL/9DA+BOb4tQ26
 8G7PxY/aGnT8UTwC15az8FQPxrRjfbq69DixB17Or8kVgl/jHXRrzEqdAfBlBVFc5aCQ
 sbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718980780; x=1719585580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+1bsxXTyJYNTiYjX7+F9Hoal/1vE9r9yDkUQkjviuNk=;
 b=RxL4eC9p0ZJ3OQz5bD/+B6agCXxWgg0dCDLgRU+i44zNNfwfD4pjsMq9V6He87SHqK
 q8g2ffEV/J6UloHwnmsuLnOfWL7k71SXmK7y88xxwRTHg8A3W3eaqZvcybZRs/mAHDiL
 wr4tklDm0PqpwHpQWFNpnPGYsc+RxLxC7D6GrSaBN4K9GUS8f0S+QSv0fA94AIzi+wWA
 7KmndmJDbu/UcMHQ9eJKtLHCRA7zKQmJs2s8w3zxrc0Vm4INpa2NV5/aNfgwr5WdxWHW
 ZWbGihYU27kcS17bmq2WzLbmp3D/fiHsK/wg8wfSiK5lSLTH3ioCjzsrdawvGBiKAT2N
 3QhQ==
X-Gm-Message-State: AOJu0Yzf8g2YAjVKdcBul8Tgm3pwz1fof36zT0LRixQo5UDgx/uXEHjs
 NlCrk3FAJTj6piUAUFk31ydhGRIPZGDm56ysHI4UdPxCZJTHmKic76twdQArv1XKoMvHzwlwqqV
 W7qI=
X-Google-Smtp-Source: AGHT+IH8BLxLJ54xeKY1YClhznEvR5IvrJ2TLCmTEZE+sUd/SfoBumF+gup9ZGdUgxUXz76aB6aTlw==
X-Received: by 2002:aa7:9294:0:b0:706:616d:2215 with SMTP id
 d2e1a72fcca58-706616d235bmr476590b3a.21.1718980779902; 
 Fri, 21 Jun 2024 07:39:39 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:1654:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7065130e8e2sm1466513b3a.215.2024.06.21.07.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 07:39:39 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: philmd@linaro.org,
	peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v2 2/2] target/arm: Enable FEAT_Debugv8p8 for -cpu max
Date: Fri, 21 Jun 2024 14:39:03 +0000
Message-Id: <20240621143903.3598230-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621143903.3598230-1-gustavo.romero@linaro.org>
References: <20240621143903.3598230-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x429.google.com
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
---
 target/arm/tcg/cpu32.c | 6 +++---
 target/arm/tcg/cpu64.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index b155a0136f..a1273a73a3 100644
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



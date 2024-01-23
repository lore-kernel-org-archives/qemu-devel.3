Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0095CC47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 16:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSJFW-0008Gt-BF; Tue, 23 Jan 2024 11:03:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rSJFU-0008GQ-F8
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 11:03:40 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rSJFQ-0004cg-2i
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 11:03:39 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40eb033c192so12229575e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 08:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706025814; x=1706630614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jTUUEUja40WbQS6wzJYDPCgMUCiS6GJwtB6HGzHkSGs=;
 b=c9RPmTpGldE8JL3AfanR+bxNnaEcRwp0X/T16FJsCPBOwO9t5TBiqz7xNMmHKcaa6T
 aa7npVhae417GYeJMxD8JWBMjQfPW4YREIu+AH+HkXctArsPyE4JhSeI0b1zY02kccoa
 VMhGAnkOa7suCYCzL4QUCLRpzt10saVWiC7zJz78zzzAk/GsbhZ+egDBT1mrGqMFtmB6
 flyZYPsQ1sv8pmxjaYuwUGZS3Hj+tumzsYlSR4jGDWZtMykxAYJcoDA90Byxa7n5aA8Y
 fxjkA1uPH5sANnmSijG9mf9GVCrST0C1Zsab0okEiNoGimezD88owSN7JoWvM6DDnzPK
 SA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706025814; x=1706630614;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jTUUEUja40WbQS6wzJYDPCgMUCiS6GJwtB6HGzHkSGs=;
 b=SYulwl79F6YFny+plE0KK6iN3rGM2IFhQbuyxDOEUVW6ko/mYVKQ0mlC5UC8tqk15C
 h/6INdO2ugaM31mBKRm+PImwAxzK63mvq35dZ/x1h8UCUg9Hu2tudBI6qnOyG86VBsuV
 64DGexeR2DM6l9o7bV7PodHG6kkOaM5c9zRkKVkhS65zz3SUhloNuQoy7sopuyllGedI
 2PhnVFevF7uHyWz9jkKWbyL1fmp6d6kKjuKiOLKh99EPG+mAmNM38D+So5yN2WjLhj3l
 POMDnh+rve1RDrlcfmMcduwES8R99vIHoSJPLycC5SHfAKAMgX/WgFtVYOgBokp1OB18
 soXA==
X-Gm-Message-State: AOJu0Yy+Uf3EBQCwXx8yxgFg9AyOAs4z0giET8VZRerlNg1KiGN/B8mJ
 JKnjjH67Gfd4P6dd1N3gRxloVT7gfB3ZVmMF/NFfXdYPf6ESx680CrE6DFpYOu8=
X-Google-Smtp-Source: AGHT+IGF/q32cHIYvJzRB0JqPkPeToJpBr9fuVZhWQaHWupt+vmI9RhjjKEpFO0nWnHQOyGigjJ1tQ==
X-Received: by 2002:a05:600c:1c23:b0:40e:4832:9fc3 with SMTP id
 j35-20020a05600c1c2300b0040e48329fc3mr299253wms.7.1706025814148; 
 Tue, 23 Jan 2024 08:03:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f13-20020a05600c4e8d00b0040eb6ce137asm2651539wmq.39.2024.01.23.08.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 08:03:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] target/arm: Fix incorrect aa64_tidcp1 feature check
Date: Tue, 23 Jan 2024 16:03:33 +0000
Message-Id: <20240123160333.958841-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

A typo in the implementation of isar_feature_aa64_tidcp1() means we
were checking the field in the wrong ID register, so we might have
provided the feature on CPUs that don't have it and not provided
it on CPUs that should have it. Correct this bug.

Cc: qemu-stable@nongnu.org
Fixes: 9cd0c0dec97be9 "target/arm: Implement FEAT_TIDCP1"
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2120
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 7a590c824cf..24525e36349 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -771,7 +771,7 @@ static inline bool isar_feature_aa64_hcx(const ARMISARegisters *id)
 
 static inline bool isar_feature_aa64_tidcp1(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR1, TIDCP1) != 0;
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, TIDCP1) != 0;
 }
 
 static inline bool isar_feature_aa64_hafs(const ARMISARegisters *id)
-- 
2.34.1



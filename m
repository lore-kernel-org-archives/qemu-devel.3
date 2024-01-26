Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CCAC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 19:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTRyX-0001XE-Bz; Fri, 26 Jan 2024 14:34:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTRyK-0001WC-As
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 14:34:42 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTRyG-0002ur-KC
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 14:34:38 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40e8d3b29f2so14933815e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 11:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706297674; x=1706902474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0TeAfcJDcGJDZye+r/25zW/L60aexsAJdtgh4QaVcLo=;
 b=RKr+0W2xM2CiSxZZc1M55Rq2RMCfGYsNBWunBMbAA+ZQSXCeavRleGZRlgKRZeVGqF
 NnowFL0GK4ntrYk0hLVvTBggVWotbRg1R811Ov4DGqSsD0mjquNj4azQPbwFw3UJesFP
 AAjXzlr5BIwDlr6Vegdrr96GeERDxltYrDlF+avIqtvr6KLtRCIEVAQxYSTAv4cr43YW
 G9TTF6kfRj5bVi3+MCRqzXSIY6zqLjHapqaowwM0YRP4QwaiGIgqnbg7hUZBQThHmxnB
 W2zTDw1l8cV+rnsECKPRWKiHfRTibyh2plvSh61TepBSiOVCbwlm8bVjgfnXF32T/N0U
 1pwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706297674; x=1706902474;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0TeAfcJDcGJDZye+r/25zW/L60aexsAJdtgh4QaVcLo=;
 b=N9IyNFx/1jhDXGNnCp2BRzgaJGfbdr600pLQUJU47obXSqBEFSffGL24aeTYgcnrpY
 aXWwARQF676l9mFZqfB6auhL5KEe3AEPt4QQkPd5f/yW7M/y8lcL+9mgksNhhKBwYamu
 BENLh53xaknx20hHBlnSDa9PFCNVRJ9FCINEWDKnfiOiRBGt0QSMKqfPsczCV0T2baYJ
 d+WZp7YtEwxUhatOu7YYbBwsIvRYez1DZZP5ZzQn6Q2+tNQzUT+Qk1O5CUKCwexLg+PI
 GE8VH1f1h6STzmjDkPsCGrejJ7bar0q5ig650N0T9WZqpnt4XTwZgjb/h0afVw0EX//M
 /NJw==
X-Gm-Message-State: AOJu0YxFgPPVw4OJ96Sfwe4LhqPjceEpCaHTFGf2ROS6v89nKhOt8CH7
 8X9Y/sGvQ25FY1mlff0dftmU4bSfNqnY6+jsEapLCzvM6MfxNXAO7B4LMx2bwsdmo+c1X1l9qAy
 T
X-Google-Smtp-Source: AGHT+IFriJxCjxF0KOk7wRmQV5FOfeolE1kP+T7EyFR8L418XSTknqHo6ntX/+K9eiXK6Wts4VqmCg==
X-Received: by 2002:a05:600c:ad4:b0:40e:44a9:c2be with SMTP id
 c20-20020a05600c0ad400b0040e44a9c2bemr164051wmr.201.1706297674529; 
 Fri, 26 Jan 2024 11:34:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 he9-20020a05600c540900b0040ed1df542bsm2676611wmb.20.2024.01.26.11.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 11:34:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] target/arm: Reinstate "vfp" property on AArch32 CPUs
Date: Fri, 26 Jan 2024 19:34:32 +0000
Message-Id: <20240126193432.2210558-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

In commit 4315f7c614743 we restructured the logic for creating the
VFP related properties to avoid testing the aa32_simd_r32 feature on
AArch64 CPUs.  However in the process we accidentally stopped
exposing the "vfp" QOM property on AArch32 TCG CPUs.

This mostly hasn't had any ill effects because not many people want
to disable VFP, but it wasn't intentional.  Reinstate the property.

Cc: qemu-stable@nongnu.org
Fixes: 4315f7c614743 ("target/arm: Restructure has_vfp_d32 test")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2098
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 593695b4247..2bed5987619 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1620,6 +1620,10 @@ void arm_cpu_post_init(Object *obj)
         }
     } else if (cpu_isar_feature(aa32_vfp, cpu)) {
         cpu->has_vfp = true;
+        if (tcg_enabled() || qtest_enabled()) {
+            qdev_property_add_static(DEVICE(obj),
+                                     &arm_cpu_has_vfp_property);
+        }
         if (cpu_isar_feature(aa32_simd_r32, cpu)) {
             cpu->has_vfp_d32 = true;
             /*
-- 
2.34.1



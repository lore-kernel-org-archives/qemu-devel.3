Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D1BC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whTjk-0003Sb-6K; Wed, 08 Jul 2026 10:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whTjg-0003Iu-TW
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:58:52 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whTjc-0002yu-OJ
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:58:52 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-47df43bfb07so124915f8f.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 07:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783522726; x=1784127526; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YLWWZH/p3+CLLy0H49sW+lXXXnEIwmUtSNrAUlJ4h80=;
 b=ddwO+ief38Haxp1d49IO3a6bhHT8mLy4I2Q7yW6SGxA7K4qOsUuhrcOVdjv7XCYyT5
 P5VIbsym5Eugg+EhbLGQCaWUAJKFHV6EQeTmXtLIWK5NTgDhbW3xHs7g202NvGKDVM8w
 Mqi0YVkoe53XthM53gRkDxJ2TBTIbmPo66cm0wvsdY4EGNscCrIAWVfVFmanFC5Gc7sj
 t0G1KGJ+Za7VKJJY/2Ft372NyujwkIKCVcBPIuJ+3jI+KPH50Te7BIhbWOQR8nzDGOE2
 Jx/uGQjxu7Ty5ed7syOD3qq7FbD5amiQA4c4vY5gNlZPMOvh0YZ++ueh4bA3kbkwty8K
 0g9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783522726; x=1784127526;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YLWWZH/p3+CLLy0H49sW+lXXXnEIwmUtSNrAUlJ4h80=;
 b=aZgZUJ1QeyecNwlpxOQ3NfCN/JdQD94unP9xCoJ3Tm5ah1hX/kYToZ/TsPfy6POAnp
 y7FiFUMqKSZfR6SLA3e8/S8xUJRkadcbiJR3uRCCSfB2pdPWuoOIYj8951zak9UkAWFY
 PGsOanySEgDHtf+Yg1dNzTrbwJZC5xIs+OTsTMbBVy6xbLxHoSle6XCiu4JzCwIBoYbD
 GykaOaJedY2l/rTqfFBubrQ3y8iGOEQrNEpTvD1IYScfs4TNVMmAvqf6kA38+xMfQvrg
 h6z3rNNqgOXpYsLnd2W/jFqzNji8hszZckdcOCb2LLO4UT1MsBdC6WT/tjY84qR1lNhC
 YXgw==
X-Gm-Message-State: AOJu0YzaZLTlXHVAikW63caj/ZQ8FPyMFRnAuRJuuCM9PVoLWPMVhr8h
 rUT85O7bj3iT0CYf1KEv1LrFDon/GBha5GCJGc7u201L2fLLOtUDkmHtoUVQ+xlTWos=
X-Gm-Gg: AfdE7cnE7gquw7BMPiU4hwgY9PIgFUccggfF4X0GYzdm6xtg2VwvxmrJCHOm1Bjpc8p
 l8sf5CoH95zjTBrl78lMRHmIpRrJR6V2WsVxdttevW/Cck1E7w57u7hrFJpE4b9MJmS9DNIDBUd
 JCpV0wwsOpw5o2jMW2wxLxyAjM443OJaVXGRtqotOTeMUu2SLt3t0JmTl8LFL18ZzpsQ7Lx8qfY
 E/3gSGqj7yFKrdb1IFN5JBfn4vbfwnMWUijLstDvmFygjs8Gn5r9itvypKHgtCD6oxroesGtU7O
 SaeCj4oX5yhTXKS4Fl0N7kZ5vDRyPweWZWZk9etDzFMh/VX01+GQQAf6OoX0oFNG+s9aMOrEEni
 9DEnj2IF7B7bkkyxFm24ACNk3ICiBybQ+omUrCWu81Zrn7r4Q0yP905ny9UKhB/3W/gheBSFkHA
 D4MCSZwjcVVTB7cvf0r0L2uWo=
X-Received: by 2002:a5d:5f54:0:b0:460:71e6:e3b with SMTP id
 ffacd0b85a97d-47df074cec1mr3343061f8f.27.1783522726115; 
 Wed, 08 Jul 2026 07:58:46 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d8410sm43987246f8f.15.2026.07.08.07.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 07:58:43 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3170360053;
 Wed, 08 Jul 2026 15:58:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 4/8] docs/system: document FEAT_MTE4
Date: Wed,  8 Jul 2026 15:58:37 +0100
Message-ID: <20260708145841.3032079-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708145841.3032079-1-alex.bennee@linaro.org>
References: <20260708145841.3032079-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

FEAT_MTE4 includes the sub-features: FEAT_MTE_CANONICAL_TAGS,
FEAT_MTE_TAGGED_FAR, FEAT_MTE_STORE_ONLY and FEAT_MTE_NO_ADDRESS_TAGS.

We have already implemented those so update the docs to include the
rolled up feature.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index b751646e10e..05e85d7a367 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -126,6 +126,7 @@ the following architecture extensions:
 - FEAT_MTE (Memory Tagging Extension)
 - FEAT_MTE2 (Memory Tagging Extension)
 - FEAT_MTE3 (MTE Asymmetric Fault Handling)
+- FEAT_MTE4 (Enhanced Memory Tagging Extension)
 - FEAT_MTE_ASYM_FAULT (Memory tagging asymmetric faults)
 - FEAT_MTE_ASYNC (Asynchronous reporting of Tag Check Fault)
 - FEAT_MTE_CANONICAL_TAGS (Canonical tag checking)
-- 
2.47.3



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6452EC5B549
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 12:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKzBh-00024l-4h; Fri, 30 May 2025 08:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKzBe-00022o-On
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:50:14 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKzBc-0001rE-Q6
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:50:14 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a3771c0f8cso1225202f8f.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 05:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748609411; x=1749214211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MP6Wll07I1WZbnFs7Ljs+jUw9xjgMdCj9BhU0+/Afhs=;
 b=Sm47r41ExHKmBCP4xhNURnZalTp75gWg1p6u0NcSm05G3dcmLBtGltEKUZty4nWCg5
 mJZrX0m57hQz3gJ0GmyhXCXsxhrxT3qwu0XATsiGPz79Kx5MxXtqipNAE4RKhF9Y11lP
 427xjAUXp0ucYNvfkUdQTaoC+7lPNuvLnD5zK7LtZYt0vxpf7ZuDM9A+HOKA4HknU0vn
 7CubusAd06OzSL3sEjglYDs+v8X/UAKnAd50VVc9nrlFsWD6oLV37IhegeUzrcs7X0Ty
 IGy0E76buHCBqVI7nFQZSNcrAaK+IoG3tukfePbusqD0cEsM0slOLYMNMPBRHAZkA/HU
 kCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748609411; x=1749214211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MP6Wll07I1WZbnFs7Ljs+jUw9xjgMdCj9BhU0+/Afhs=;
 b=BidDQwOiq9JJ5/a7/EMixigYrZ6wZJR2f+sJPwxXdP/sFYL0XxFh1kaEII212bDfnD
 X5yVJsQHqtbCqmczRSd4PmGbGachcNue3liWMPzoEAAdpoejOLNIHU8imp6Z3GoZIM8P
 /zx0FLFmijJcdUXET1oiu0+t9XKBz8hYyutlEO8LlPtMetJcI0ZnnBKGrJS/y0mU1wKd
 W3bU7RvkZ0alhn1cG0+1KEkgKiawPM66XFl9SMxFiZlfUXFNAmXcDD13C3+fFZlJc0SP
 FbbNIBGwOIinZ007H1a4fmfMsXp803VMBoKFrjH02aObOOFJMzFzXC8gzwOiXvjIZg8a
 P9tA==
X-Gm-Message-State: AOJu0Yx5KEfXGvAb/HBBnDBWxV/EYGZosFMmL79tJmpM9y+U7dAwh5W0
 mssi+amepCFB90I+rNBi5VbKdMxfh+b5UYnxOHXnzgCalc90eLLS5kQHwm23nseJwS49XUXgU9i
 YBPH/
X-Gm-Gg: ASbGncvanp0frchROEQ1zis1V1LFSMTwgcVoS6tRO6msBBZ5KpeslOeWvTSLF1uPv+A
 r+c1i+An1Vdl/L0fmtvthFIly4AQiCeRO86YO6kCS4QCaU/PZMPg4P9p5xcKgUi6wexGWym5rfs
 /mqiGiGUmqHQBOTwACozHx27EPQ52oJLNB0FXt32T65Og4cGNciD2AfIjazT5kwWWMrTfeEckq5
 di5bKenzWoLoscbz1K4NwDexyBZjbe25FvSyxZ9MpXMeG6I3pMiK0+o7vY7U9VoZbttmZjiBRqm
 AguMxg5BvxfRs3vDdDKtYRLVV5myuHlNPnKcFVb/nuLNKAaK63gqRUQCSBmKaC5CUEtT
X-Google-Smtp-Source: AGHT+IE5GRDutNLuqGXtpw9jQlWSjNemCaaybKoLXzRqxvSZJf4KflYIkNZyc5M0Ycs9ozJd9ZzLHQ==
X-Received: by 2002:a5d:5f56:0:b0:3a4:e423:4080 with SMTP id
 ffacd0b85a97d-3a4f89a5b17mr1884574f8f.4.1748609411144; 
 Fri, 30 May 2025 05:50:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb7dafsm17235195e9.25.2025.05.30.05.50.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 05:50:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/15] target/arm/cpu-features: Include missing 'cpu.h' header
Date: Fri, 30 May 2025 13:49:47 +0100
Message-ID: <20250530124953.383687-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530124953.383687-1-peter.maydell@linaro.org>
References: <20250530124953.383687-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

"target/arm/cpu-features.h" dereferences the ARMISARegisters
structure, which is defined in "cpu.h". Include the latter to
avoid when refactoring unrelated headers:

  In file included from target/arm/internals.h:33:
  target/arm/cpu-features.h:45:54: error: unknown type name 'ARMISARegisters'
     45 | static inline bool isar_feature_aa32_thumb_div(const ARMISARegisters *id)
        |                                                      ^
  target/arm/cpu-features.h:47:12: error: use of undeclared identifier 'R_ID_ISAR0_DIVIDE_SHIFT'
     47 |     return FIELD_EX32(id->id_isar0, ID_ISAR0, DIVIDE) != 0;
        |            ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250513173928.77376-7-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 525e4cee12f..4452e7c21e3 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -22,6 +22,7 @@
 
 #include "hw/registerfields.h"
 #include "qemu/host-utils.h"
+#include "cpu.h"
 
 /*
  * Naming convention for isar_feature functions:
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418BFC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 17:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVwrb-0000Nm-0y; Mon, 22 Jul 2024 13:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVwrX-00009y-Lg
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 13:30:15 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVwrP-0006OK-QY
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 13:30:15 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4279c10a40eso33449335e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 10:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721669401; x=1722274201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bf7ARIytQmQRzsKfx3SaAbLzTh/grrFtr44A30HzPU4=;
 b=SEf5FqNR1Kdi9mAFGhw0ttVr9xsmgCnV4h8F/5x2NiHuy37gME1nKEBiS1YMH+NXvh
 LPpjXwIcOXTIzgtuG+clshOdC1WxZMs+S5/l197iPSvX2Hu73T59VDV5T4CPEhFhjbsf
 Y/YA/IcV1tXGcK9aF/is/Gbv4D1Cdvzk+/I5+eecGcoDDWLpOPQxi61vxeVFxL9XDdI/
 S50gbxhzcAE5HsdEcJrqMixmb8LcWYpNhmBsi9hrQKXHBnp4tO7H0rRhYUUEHIOdO/Te
 XaNh5e8uqkLuiyfq8N+ENAw+DT9IWbYFn3pZcdOojXz/uCY2TbQz6q3RyU7et4cNzNvw
 pePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721669401; x=1722274201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bf7ARIytQmQRzsKfx3SaAbLzTh/grrFtr44A30HzPU4=;
 b=DxK/kF5adz5tWvRM/DFZBqvmwvEPrLFnOvehqXJJMbR+ftxA3wXsqdHxT/cbkReEZI
 oT3rYCk9fL3hruPT54yJTPoliNR5TTwLa9JEpLqp6ce5Wn0CyPA57YBqrOzSlY2Wjdp3
 3hGQh2f5O01QwRAOTk7asrS3t/MQ4GRxTXeWPdOlEShyffJFMAlpZfhIJwY3GInc0zFs
 eopEA4NN6QKlRGRMLSG+jjsgBO+wcsi9qqguqZUgVot6iPd4Upyeuap1DCeaZunSPf0T
 lGJBY2EWcHk4uHZ0s1BBI+GhMckYISMxZcsjP42W9O/9JrG7xVnB3ae2QWMKM2Er8UM6
 vJUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/Wnxc9XNaWee4fvy71w3FYASDkc8py3YIj5mVN0WAHRSTibxeHpUgPlezhJk7/pSbkFOaS3g4bYwJxkIwLcDoA1HjZUg=
X-Gm-Message-State: AOJu0Yym/Dm/54rlQc4GNvd3+npV2Kdmn8SCeUUy+xD157HV4/fx7u8A
 +Bmph64ywzNrwtSaWNFpRa/kf/KwBEI+DRearn1ZLUUTTDIy3vleLS6dnOeMtAs=
X-Google-Smtp-Source: AGHT+IEJGKPG9kmxwX0yIMsb0H4j3BHjvqG8H/6GM2GM0LnMLqSg4fijsXE0WM9PZrlMCFWBcbl1iQ==
X-Received: by 2002:a05:600c:1c27:b0:426:62c5:4741 with SMTP id
 5b1f17b1804b1-427dc515f90mr45072115e9.2.1721669401439; 
 Mon, 22 Jul 2024 10:30:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d68fa493sm138035665e9.10.2024.07.22.10.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:30:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH 4/4] target/arm: Ignore SMCR_EL2.LEN and SVCR_EL2.LEN if EL2
 is not enabled
Date: Mon, 22 Jul 2024 18:29:57 +0100
Message-Id: <20240722172957.1041231-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722172957.1041231-1-peter.maydell@linaro.org>
References: <20240722172957.1041231-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

When determining the current vector length, the SMCR_EL2.LEN and
SVCR_EL2.LEN settings should only be considered if EL2 is enabled
(compare the pseudocode CurrentSVL and CurrentNSVL which call
EL2Enabled()).

We were checking against ARM_FEATURE_EL2 rather than calling
arm_is_el2_enabled(), which meant that we would look at
SMCR_EL2/SVCR_EL2 when in Secure EL1 or Secure EL0 even if Secure EL2
was not enabled.

Use the correct check in sve_vqm1_for_el_sm().

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ce319572354..8fb4b474e83 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7232,7 +7232,7 @@ uint32_t sve_vqm1_for_el_sm(CPUARMState *env, int el, bool sm)
     if (el <= 1 && !el_is_in_host(env, el)) {
         len = MIN(len, 0xf & (uint32_t)cr[1]);
     }
-    if (el <= 2 && arm_feature(env, ARM_FEATURE_EL2)) {
+    if (el <= 2 && arm_is_el2_enabled(env)) {
         len = MIN(len, 0xf & (uint32_t)cr[2]);
     }
     if (arm_feature(env, ARM_FEATURE_EL3)) {
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889D0C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 16:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raeeD-0004rA-VI; Thu, 15 Feb 2024 11:31:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ijXOZQgKCmMBSEC+HJUHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--ardb.bounces.google.com>)
 id 1raeBq-0001aa-RQ
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 11:02:22 -0500
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ijXOZQgKCmMBSEC+HJUHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--ardb.bounces.google.com>)
 id 1raeBp-0001rs-0O
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 11:02:22 -0500
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-40e4478a3afso5192745e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 08:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1708012939; x=1708617739; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ZxJ82GKHsUgKCva8HlVuPOEU7TH3AeI5O3T89aBX7P0=;
 b=jz1OP7sIt8hbtsqIKGvG5du/+F7FfgDUqSOI0T7KTQRhp2iz1S6/kuArnVzm7AO8/f
 MKyACRpnaE3IvtHKzu9Eg7VBy/0W1BHJJUSsHSPmyIKUsYHqbyaGJx2FAR/ddcp9Du00
 Rs7xiKATHUXIMBp2MKltLSLnY0DmRjf3O7vw2IoGJ6CrHS392JQ2XxHwgOXSj+Iz+Yr+
 RtPegCs1H4WQXZq9N0R5BNgyZznf0M8cEM9AF6V6mN2dKicVu0ld4AQLL2+ibhJaO29i
 2qUT771MmG2hH6DKP+UWlaUkhcscyblKXHCHbFUcId0sxhLzGtvyI8cA1fQ1H7nJWJQn
 1/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708012939; x=1708617739;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZxJ82GKHsUgKCva8HlVuPOEU7TH3AeI5O3T89aBX7P0=;
 b=tvyL955v9OhWOTYWjEUXRuDaaef1p08odfD81/y5F3F977NOZDpNQKKoigxcI+6EY4
 B3iPlNksHKtkJnMzg3i28DBTpn35RtdMW647RtinGSUGv6Cl6nyrplq7FSPsnv7n2/qV
 Tt5UI5FVVWgJUYWhTu3J7mfK5BeSp12qRJAqcfEDrWkaIehQmQSH6+yTHlRMZNakiBRS
 Pt5p4QbmaQL7nO+Sv+qVNuP+sCU3vH4XWrMX/s7Svv2keC6V9gtwvtFhgP1beBHcc666
 5sWU277KS9pmDKczOJ5VFYgVbOoa7LOyWtXIhNszV3kXfqUuqW1+6XPu8/3lOM7/fTqu
 gD2Q==
X-Gm-Message-State: AOJu0Yx5QWGYqqn+CuUTBb+q557NjdJ6y5kc/mfEU5UHxfkRr0nc1+cI
 YQ5w/WzvfbznPvzfPJRP18Om6v+TrMl0vIxk7/X1On+aPL16jHIMYztaW6Sw+o/d2DP0xw==
X-Google-Smtp-Source: AGHT+IHfWRQI5qljQB+wLQldxtp0OWorCucnhkxogytIMI3RvYiUNnHcP4cyFuTqP2m3Q58t4vwykpvl
X-Received: from palermo.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:3512:b0:412:913:54c7 with SMTP id
 h18-20020a05600c351200b00412091354c7mr76803wmq.4.1708012938539; Thu, 15 Feb
 2024 08:02:18 -0800 (PST)
Date: Thu, 15 Feb 2024 17:02:02 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240215160202.2803452-1-ardb+git@google.com>
Subject: [PATCH] target/arm: Advertise Cortex-A53 erratum #843419 fix via
 REVIDR
From: Ard Biesheuvel <ardb+git@google.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@linaro.org, 
 richard.henderson@linaro.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=3ijXOZQgKCmMBSEC+HJUHPPHMF.DPNRFNV-EFWFMOPOHOV.PSH@flex--ardb.bounces.google.com;
 helo=mail-wm1-x34a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 15 Feb 2024 11:31:40 -0500
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

From: Ard Biesheuvel <ardb@kernel.org>

The Cortex-A53 r0p4 revision that QEMU emulates is affected by a CatA
erratum #843419 (i.e., the most severe), which requires workarounds in
the toolchain as well as the OS.

Since the emulation is obviously not affected in the same way, we can
indicate this via REVIDR bit #8, which on r0p4 has the meaning that no
workarounds for erratum #843419 are needed.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 target/arm/cpu64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 8e30a7993e..0f7a44a28f 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -663,7 +663,7 @@ static void aarch64_a53_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_PMU);
     cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A53;
     cpu->midr = 0x410fd034;
-    cpu->revidr = 0x00000000;
+    cpu->revidr = 0x00000100;
     cpu->reset_fpsid = 0x41034070;
     cpu->isar.mvfr0 = 0x10110222;
     cpu->isar.mvfr1 = 0x12111111;
-- 
2.43.0.687.g38aa6559b0-goog



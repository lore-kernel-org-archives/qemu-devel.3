Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44524CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtHD-00086Y-R9; Fri, 15 May 2026 10:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtHB-00080S-7K
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:12:29 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtH9-0004JH-C1
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:12:28 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so83647355e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778854345; x=1779459145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ElGFD+og27a+qig6P/7TdWyM3lA7CN7DxfP82EoGOvw=;
 b=SuPVXQxbBiodBKjsUCJWeQTydIKH4CjnIcGj7Xn1XAg3E8n1CWLRtOfHaZ62jtf/YP
 XWXAivU5rKkTi9lSj+PANLXi7JJPovIFKlStbqaMMjWF55bQz6Kqe2JyTzhGTGzLYEN9
 9qqCUfQr7CfrasjW/FjH9Xp8ZJM9q7NfrFw69hCLw7ozn9efp+gCA5Sx7/Lg9CowexW4
 x8RAITiNADIgiO//VpwhSeZQfAfOp5R4LwPYkE25d9ZWz2BzwjMEdY54Ko9ZvyY+15Wc
 EOxHuGDHKC05dx8BKENy4pwdO50P9NEXfh9okYrSkJvrcFOFJGTDA4HCikzjyHM8vAnU
 7pEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854345; x=1779459145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ElGFD+og27a+qig6P/7TdWyM3lA7CN7DxfP82EoGOvw=;
 b=eB41Mv1Q4J47UFmNqtK8KSP6myMtlsy1kGA7hzXOevXMN2YKUVJ3DGqH9loXkyE/ha
 S+cjtMRfreZVJnat0I5OtAsMvVZNWE+SOEjL4IX/8qqIt2SZvaDmj2+vtjf/tQhvpN3Q
 STbmnb0vamjEXjOKwz/D1mFSEusHBqPk47w2HV26GkvHtE/4PaA4QomisUrqSt6RK819
 mCST/ZINnT3gm7gfcTu5iq8ZlGj2/LdUBTWdAB7Wkkn5oKTImui0uymGCm54vTiChReg
 PfbK7K2Yx6bVjIbhrirn1yiicI/iRUc//bYLcRC/NomFaShuH/1qsp8DdIkKZNmX7znY
 PBaQ==
X-Gm-Message-State: AOJu0YwDcB0biQeIkpht+VJjFllFeq7m0aH0bfRKAoCFGwjIqhjipqM8
 Py7pJypB4AhyJ1uivSIo7BUlGmi0TLcwdRW4fm+skRhFgH87bCRUJJe5CW+2jsmnnI7cbxzB+zd
 QGAV0gMs=
X-Gm-Gg: Acq92OHeo8ATQJxSIrcO+zLIeR1ryFa/E4whsgCt5RrakcEiVDB+55z5MwVmReGwgy3
 7v/dOAH/qOxkFgxL7yZz/N1bFf84VdIniQVmrDzlobmNZG7AT8VYWM2iiNXBL9UM7F6LHXkIema
 di5GoTPOpTn39ym/YYVoY34OTGV87gtDBpM5jdD3aRdxh5F4zW14Tlkx2c2DY3jpGX5C8v40R5g
 qlN4pMCVsD6WES1UmCuy6hvDgieJyaMAQhZ75PwEeBFz5kC0xMXIwr3WQItpWfnpoJCbhCbFSrp
 zCxYPVcd5WHhH6YbZAs2kO5zKY6mDN/LwGoU+6k5Ib4SKBN3TS5NVZiEJOrh5orEpO/0iG/eS1W
 7gfT9xyrV26KvQsICD0q8VqUuO08kY7zwa/2kdxVK3KwRpOh556UTFup0lshN+V33pFhd6AsA1O
 bJlht74/mwiN3vEQfu7nrHLeeRFG52+XBpHYniJRLOiNFkirhvVfsmVKcCQRLxPkhp3lh2tAlP
X-Received: by 2002:a05:600c:1389:b0:48f:d1b8:9a9a with SMTP id
 5b1f17b1804b1-48fe60e515cmr56940105e9.5.1778854345206; 
 Fri, 15 May 2026 07:12:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c833fcsm61741655e9.2.2026.05.15.07.12.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 May 2026 07:12:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 15/20] target/arm: Only set %kvm_target when KVM is enabled
Date: Fri, 15 May 2026 16:10:26 +0200
Message-ID: <20260515141032.3271-16-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515141032.3271-1-philmd@linaro.org>
References: <20260515141032.3271-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index b38a78aac3f..7b2f09cf8ec 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -701,7 +701,9 @@ static void aarch64_a57_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_EL2);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
     set_feature(&cpu->env, ARM_FEATURE_PMU);
-    cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A57;
+    if (kvm_enabled()) {
+        cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A57;
+    }
     cpu->midr = 0x411fd070;
     cpu->revidr = 0x00000000;
     cpu->reset_fpsid = 0x41034070;
-- 
2.53.0



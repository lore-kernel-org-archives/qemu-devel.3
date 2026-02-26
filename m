Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208F8FD8FD1
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 15:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdig-0005VD-EY; Thu, 26 Feb 2026 10:56:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiW-0005P2-8d
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:56 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiT-0003ml-VY
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:56 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43990ea3fbcso709859f8f.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 07:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772121352; x=1772726152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sfrFs8pT9cgR7jMYX6r7NcDgV+dCxES7G4jHs+l6wU8=;
 b=kODA6LvawuTIiLzMw5RK2wQQkuvRF3g6zQnL9XCILQOhqqtt99wBzd0y+gz+YeVD2L
 uv7jMgbild4QXHvQT2YVwEhzyVL7auvSD6DJ6z4HqysSUhAPvC5giYjdkhjGPK6XJ9GW
 bemnE1Chf2vbIwD5ZDDPdA8q07po5oZws6vIYaEjia+Q9xrJs6f6XDj4YBE575sS3w4o
 UscPMCANmjvslAox4Rm3SUeOcatsWKrv9qrmGsKR9wk2UUrmw74Ji+4z3YOTQWKZ1zQf
 xwA4TtG7hWBz2J85ZjQVphiCjR09mjMYUFSQoiLV2EIL5DcFP0X93vW1otODDxi6WlOD
 yvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772121352; x=1772726152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sfrFs8pT9cgR7jMYX6r7NcDgV+dCxES7G4jHs+l6wU8=;
 b=YmxIXA6HtydLoNVQ1zQhVSg4+QsDaw5Ab+bxssWUu43IlqtrCKujy7rhngwchmJKb3
 2YBoR5FCHvbcf37PWLvvCRW2I0a835hvNhBmngizQK3i8FzJcpXo/j5Xs90UHchVXLrR
 6EhqHklxci/JvPhY0TZudWf49nZvhw1vz8MpdOOmX5E8CiVO7ofcxKwozMTuqRzonqrF
 wYcZuOHoUxAhvYMgdO7tP61lPsaf+fBww/1nHkp3+LcwUyoliACiB+D9s3XmS3lWzgG7
 TP6ujbNy4F57GdTFU9g00CrO/xx5V0HNGf5pA3Xk/RJ9yqcE6L3aQTVEnlbos1I+d2x4
 GJcw==
X-Gm-Message-State: AOJu0Ywj4alJT52FTUip5vbaV7h96aqfbu2KaCpBlPSQaAZ6r2w962iV
 STVJvPCwc/Yhz8mkgbqdZJfGeJaKXd11otWqEWux2SaKbPIlkwHDXbhrusGS/lFQWCOkAXSO0zm
 N81j6
X-Gm-Gg: ATEYQzzoGo4Bbz6EPTneCBR/0XrpkTbEUf7mgG8i0AARKcES4MgklEh3Dp4JgQLWPPX
 UBm8qZQFhHCMuz0/X7QBwR4rE05OeaJfUf1RS1xVsE+s+pFXuh7QIRzcl27qvajIcsGfrvviphq
 AGpWV/T1hQ+0phvGEAPE8LSBWGLuQATA15v9bqUCg+ckLHdFEaVRZib1vkQj3v8yZg8GjbupzjD
 455hb0fqW2kIZfYkkua9AZISHLsIrmTO7bqFJ/6UUjIPwNsSVS4DQhm2+YDpBrU5JrGLvphrf2P
 hwwboJw8qd+hguzMNpFfTfHHdB3NFiHtmHm9Wl8LSA6FESMj0jql3rDsGPxb6N9vf5QcjJBmWo4
 GjFsdZFf4xr/5J5JD6S7obZPzZHacbxd6aSWVrho/0DzlCXpVeq5IYkvq6UquwySHpd2djBPKxK
 Zf5iN1f6RagSTTynqfV0Q78dNFnOjxxfQ+ogVIo63ORsz7of8rVSaXe94p+Uc26Ax1/sA8/nWSX
 ZJ8uKeCWOr1qrcMcIMYmXBLY2kELHg=
X-Received: by 2002:a05:6000:2381:b0:439:936b:c006 with SMTP id
 ffacd0b85a97d-439971fc9f7mr5249725f8f.20.1772121352434; 
 Thu, 26 Feb 2026 07:55:52 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b8afsm407235f8f.23.2026.02.26.07.55.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 07:55:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/20] target/arm: Remove kvm test in arm_set_pmu
Date: Thu, 26 Feb 2026 15:55:30 +0000
Message-ID: <20260226155535.1171290-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226155535.1171290-1-peter.maydell@linaro.org>
References: <20260226155535.1171290-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

In kvm_arm_get_host_cpu_features, we only set ARM_FEATURE_PMU if
kvm_arm_pmu_supported.  In arm_cpu_post_init we only register the
"pmu" property if ARM_FEATURE_PMU.  Therefore, if kvm is enabled,
we can only arrive in arm_set_pmu if kvm_arm_pmu_supported.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260216034432.23912-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 60f391651d..7e3e84b4bb 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1224,10 +1224,6 @@ static void arm_set_pmu(Object *obj, bool value, Error **errp)
     ARMCPU *cpu = ARM_CPU(obj);
 
     if (value) {
-        if (kvm_enabled() && !kvm_arm_pmu_supported()) {
-            error_setg(errp, "'pmu' feature not supported by KVM on this host");
-            return;
-        }
         set_feature(&cpu->env, ARM_FEATURE_PMU);
     } else {
         unset_feature(&cpu->env, ARM_FEATURE_PMU);
-- 
2.43.0



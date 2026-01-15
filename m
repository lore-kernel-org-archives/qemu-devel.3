Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D4AD4660F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSW0-00025J-6c; Thu, 15 Jan 2026 13:56:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSVQ-0000jL-T0
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:41 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSVN-0005wa-VS
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:40 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42fbc305552so1033235f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768503330; x=1769108130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wA/nEsPqIhwLRmIhUu82koV0Ke+qsz79EcZMSFMqDbo=;
 b=CgYioMqs43yPq6+fZi1B6eABLGW2X/c8Hst7+81Sb3M6AuOt7SSr8w+txAOs+2mula
 8Dw2sKzmIfYY9JU6/KPgQnbWjFJA9udg366NvrGYCNugMOADZsZ/qtPceqAHxYEU4azo
 7gB68fUxXfuqSYSCeVJoHg05Mp64uMRhqtArHAItltzn2h1HUM/K0ie6CS6847vL8GST
 Rdq06aOopBiziPXkhk01zbjAY2ylc/CU/XxrnMH6I75s3mHrs2QIJrJ0lHiFJcBWXv7Y
 O07c0kn6mJPyC9zyI8hYPivgsO7Fm/Mgu2KhLYHH2TxhNISXSxQRq3EMHCDX3eKxkqJ4
 k9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503330; x=1769108130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wA/nEsPqIhwLRmIhUu82koV0Ke+qsz79EcZMSFMqDbo=;
 b=Z8M0nGxNQpkrfsJl7woTckN0TRbcmF69uYLskmy9Ke/c/EGPm5OJ6bZl9AIxd1kadc
 feHytCtRDqWuEF40ZYgOBFbByRL4TNNK3mHc1mxshrY5jdhkButD4/JEIbiJEJpWBuML
 MyAVJTxXPth4BILJpySD9qEOl/Zo+U9hmFnEoZ3PPi2mImYMmjr+tqwZZTEUkXQU8Hlp
 z4WeSV/i7zTMZsUfe2lp/MEn5kOiFx/RU303/fUvRY9kSDWrWuClI2PIakuooZxTWGp0
 j11RpW5QghtpcSQeWd12bTV9vBvXzgVsMHG2I5s5QcxddLhYGnLQzkT3HCfErztgkLaF
 C0kg==
X-Gm-Message-State: AOJu0YzPLb3ulniAPBzzz6P5G7yPIRiimrpWiLvNLBuIi8yzH1+kjCOC
 sK3tAAZZaZsyg6VHPO7WTQTlXR5LP2UMiPAT/YyrWb8qUAanT62HM6MUUx7jydqazIAaPxf3YkX
 aRjzE
X-Gm-Gg: AY/fxX6T7cV6P7UrR6tVG/wOKvG+S2bPrf6qaNGVgkUIbJwmUIbDoyahC+TTfTMxO+n
 dduti6xhr+2jHq0Yhqqip0tMLOGy76Mr4iAMZBsQb2S+iiyR9X/V5esGE2xwxq4w+Vb1c9J1+ez
 Zzhy+P993qDWiLKUNT7AJaCI0hVHkKuj4Kbi5RUH6qcfz09Imk9NQmHXLsoJW+edKGz4QzbK0IW
 lToyBlAoGzOtcXwQ4x81kf/cIfB+/gs7G+tCDpREqbL8E5RIfIq6AbF210ylmbOZvsfi3LXUKKH
 Hy+MKCloTDgNDM1vULeV+WtMxGvzxFI34m0ZoOC1AX2oN1+yx6QDFg9ajrzBMxGxfd5qvtQmTHk
 vVX/qnWh98mfrqK3HttDSPXz4nGRQkGirXqrNaGJSQjFKNZnAAs9uic/YDohldyJAo+wnwcV85U
 2qHO3iAS53ew1w/cb8OWXnl/szZLY+Obaavfg3HGwCwQcP8EPtL8ghOG/Qt9PJe/jks0tkcgHXc
 UyntKiNNQzyLYADRFgDK2fes7Syf/H73SahFcj76ZM59A==
X-Received: by 2002:a5d:5889:0:b0:430:ff81:2961 with SMTP id
 ffacd0b85a97d-4356a082ebfmr310433f8f.51.1768503329649; 
 Thu, 15 Jan 2026 10:55:29 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm514207f8f.26.2026.01.15.10.55.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:55:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/25] target/arm: Don't specify ID_PFR1 accessfn twice
Date: Thu, 15 Jan 2026 18:55:04 +0000
Message-ID: <20260115185508.786428-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115185508.786428-1-peter.maydell@linaro.org>
References: <20260115185508.786428-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

In the definition of ID_PFR1 we have an ifdef block; we specify the
accessfn once in the common part of the ifdef and once in the
not-user-only part, which is redundant but harmless.

The accessfn will always return success in user-only mode (because
we won't trap to EL2), so specify it only in the not-user-only
half of the ifdef, as was probably the intention.

This is only cc'd to stable to avoid a textual conflict with
the following patch, which is a bug fix.

Cc: qemu-stable@nongnu.org
Fixes: 0f150c8499e970bd ("target/arm: Constify ID_PFR1 on user emulation")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251231170858.254594-2-peter.maydell@linaro.org
---
 target/arm/helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1ee721ac7b..958e8edd34 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6312,7 +6312,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name = "ID_PFR1", .state = ARM_CP_STATE_BOTH,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 1, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_NO_RAW,
-              .accessfn = access_aa32_tid3,
 #ifdef CONFIG_USER_ONLY
               .type = ARM_CP_CONST,
               .resetvalue = GET_IDREG(isar, ID_PFR1),
-- 
2.47.3



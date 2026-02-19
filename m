Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A77DE9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1Mj-0007ME-SP; Thu, 19 Feb 2026 05:34:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MZ-0007AT-5t
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:27 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MV-00064w-2H
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:26 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4837634de51so3849345e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497260; x=1772102060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=idmqccAZl4RtO4Py9HrXUW9aAh/kXz8DSEMvWdQRhy4=;
 b=PGRZYbrL2yepq+NH3JxXYlerFjp5ZoY1kO7SDW5UhbYdu19QpTUpCmCXjHenDpW7Oa
 9VBYlNmv7Oz8HtIxjM93mmpvsI6dVttVW1xcf4I3p/1duqYa/0DY2xewswudMXKNTxM9
 aktVR/T4/8ytfiKMuUehQoXrJ7IkgjwFzUjUmMIVmQx5G6JfBKfBZKFCxwlL57q3YJPH
 yDmpU8V3B9No6RoE1tRMbBnya43WWjFJOYlBX5K+JB0o7ZwtGZaf08UIIKlTSjIdFh+y
 6XMNCrewvR+t2qMOOFPf2C3tgkJP7Sc5fcrVrUzwN2O541Wz37vMOS1OlkES9mi3xKJu
 X58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497260; x=1772102060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=idmqccAZl4RtO4Py9HrXUW9aAh/kXz8DSEMvWdQRhy4=;
 b=wLhrXaRoAgMp3TACY9Z8RvhNX1+UTss/a4cZ5rQ4utg4lGFoImhg3E/KllDkIlsLva
 2MEtSn/e1mihG2QDwXvHSJR0EtghDc+U22GqLXkksuRg83hihdko2D7fyIzQC+Sdyy9w
 ZEQ5b6v2nASpX1JJXAr8aKnqCzBoBB9Jv6c/dUCF8VljOPE801Hjibx39RhZrLBWRG8e
 7U6NglxoMiKisEKL7Kto3htyu7N8WnFLeiaV7VzwyWROX/AyStGW4tBd3+CKZe7tJAfl
 C4S6lJDMjc/qDE6XYAPxj6wHpq1txj4sXinr8NkW8Suq97oBpJmKAWd4bQFaRaIDIXnE
 Vtlg==
X-Gm-Message-State: AOJu0YxqXptHk3afTdenax8vd7TuzEZpsJiiwLh5K8TJp8ykop2ZZsEJ
 uepXGpHwP3DritW5sAuUzDq4mEoEqOSNvRKAbbYdk/KIsGOrVpldNGnB0m2ZexOCSJPyE118D42
 grEhc
X-Gm-Gg: AZuq6aJ8s2ir0/ClL3QY/O+qY0354TXcblVgCig+DGgZ2RRgCk6juhL9YXXHsdMXhxu
 9NU2YfuggEyDwVoJEz8q9Ud4VCr2xYcAR7dwT5NFxx686s/KUxOZeIxVsv/vj7gU3GckimVR/+O
 WmfmcgdVPiE19YxBpyybh2SkzbxuOfFxiN96vypuep/R1LfFsUrufsZ/YVSuh3jjKaWrBOwFd6l
 sE394aFsB/DyXjjD6FHlQPRPy4G27mOs2C16dnhruCET+XGplIQNLkKNXMN9mfbDRtzLqbs6A39
 8uETAymovzolSJr4TRsRBkg3cWpoVkCLXVeY5IPKDIZUzYnUmpQhhf65GbjN1gbz2xER/9CnjaW
 kyPPRXLUmhqvwdYXUdu569A2oSFDs9OepGuxEZCVSS1LXn/9m7oMZ58eP5dlVJCDwSZ7eQJ/ud2
 WM/s94ZDC1yEuknGhc0rxI1D3/n3DAyzU+zlsiaJ42Ygmg3kidNqiEhw5sDjoCOv9KTMcIxJbLS
 gbo1liU+8pV7nNp3uawry6sQtnaDdw=
X-Received: by 2002:a05:600c:314b:b0:482:eec4:772 with SMTP id
 5b1f17b1804b1-483710962c5mr280635165e9.32.1771497259969; 
 Thu, 19 Feb 2026 02:34:19 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/32] target/arm: Squash FEAT_SME_FA64 if FEAT_SVE is not
 present
Date: Thu, 19 Feb 2026 10:33:47 +0000
Message-ID: <20260219103405.3793357-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
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

FEAT_SME_FA64 allows Streaming SVE code to access the whole
SVE instruction set; it requires FEAT_SVE to be present. If
we have a CPU with SME but not SVE, squash the FA64 bit in
arm_cpu_sme_finalize().

This doesn't have any effect at the moment because we don't
let the user create an SME-without-SVE CPU, but we are about
to lift that restriction.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260202133353.2231685-15-peter.maydell@linaro.org
---
 target/arm/cpu64.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index b2be8c9fba..dec430c48b 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -388,6 +388,11 @@ void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
         /* SME2 or better */
         FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR1, SME, 2);
     }
+
+    if (!cpu_isar_feature(aa64_sve, cpu)) {
+        /* FEAT_SME_FA64 requires SVE, not just SME */
+        FIELD_DP64_IDREG(&cpu->isar, ID_AA64SMFR0, FA64, 0);
+    }
 }
 
 static bool cpu_arm_get_sme(Object *obj, Error **errp)
-- 
2.43.0



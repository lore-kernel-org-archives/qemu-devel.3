Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A4FE7FDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 22:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn2LL-0007xE-Ef; Mon, 02 Feb 2026 17:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn2LK-0007wZ-22
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:24:26 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn2LH-0005e4-IN
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:24:25 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4806d23e9f1so55289935e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 14:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770071061; x=1770675861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bPFR6g8HavYKktYDjPEU2UNFbYpGAVNrutPVXVv/Yzs=;
 b=b1iIW8FKaXmoKfWAl0N7c69Du4vQJJlj0iGiCThsJitG/OcN4if6VDl8/5P/uAsXcv
 9hTm5vzHKEhuvwsFbvzZcu8ejzAWtg8X5C1paxy6J9OsmKaIhaSZ7MFsYLOJqKUTOPtj
 WIliBnjtxyr1sJrMbtNEtv7WvCYKIt1TAEyEf6xH6O+T9wgApa7TTajl369EiOGc1Atf
 3IVkgHjBQMDBUu2sicJVCRqGn5FRKeDraE5PIyRMTOX3PhQgdLsr3fG1Q5u0nUWs7fxP
 3WaIW5iCyLBWFh2V8KPYRPQizhLIvnzeiGujPCDQzEuVrFCWg6PjceRMueIdeQRI2vfx
 hNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770071061; x=1770675861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bPFR6g8HavYKktYDjPEU2UNFbYpGAVNrutPVXVv/Yzs=;
 b=gMLOFcVt4BuUrD1d6hGGoAqiogc5tCdtF43x+dyyWXwoe7Hswuqskqpj/GSiC4wTzo
 gmGsutxwG/tNPbkhvExyKixlJMtR5hqb7G6gE2lxkztwKq8hF6syXWFdb5W4gu5KpXKN
 uhLVZwAx/6otmgPuulwPcna3oBAoB8QtD8vfxqH4oQx1AmEfbESG/RSt3TBlLLeVJafb
 /Fb08TpyUjRumsy3x0auyfYTGOS3oSpPBc+Vdppkt9we8NIyruZV20CkgpEdj62xLkFZ
 ZuJS11jscVt17MEjATQC2MrEV+4h1R1N+wsKzqmQSo8r0RUdaNJOFcnMtRc5M0LR3P/5
 mgRA==
X-Gm-Message-State: AOJu0Yw3R0+wLfwd6x2871mtN5GaaJrLG3Y+JV4PE8JDKclJ5eUblRN+
 pze52PUIYkzzS/QbJCSXNm2Wi8mSMdgrT3zDIQWae2eZs2jPHefjsFjG0C8TE2ZdbFbRPRm9eLT
 wq9L7QRY=
X-Gm-Gg: AZuq6aJx9ISVBDOehGrssbl/o5ihfddpobGc5OnXYlnKga4rgg3WWLPde74RFPM6s7t
 OufzBvoibCO/oPfUsd+qeGCyIqGdZYgx+WOYEmonc96dfNuV2fuXoe5XFtjpx0v8EOmPmIPyM3f
 ENG0w+d1OFIPQPHYQ0VFP374+2sUfOqg9UfSlvwdX0xy6p2EngUFrXGU+6yAzz5k+3Bd2v9EO7d
 A8TJs5cR7M1U1toicLpsayxQUZse9mlJ1brkCppLwONsS4yAdC5LNh7mzGJ0hnTSmerq8TjAGK0
 F4W5SbMWKaxbwg5i0M1qshJHfSpMq4IErc3R60IT/dhm11Gk5pH/hczFTvG208tdCUVvK3crY4A
 4Jr0LGSljDzc48wfDqZOEq2q65VBHCNegIBr4DUNcl2nLoHlo5QwD8qKQC00MfVh3gkRFLhG423
 qajgvnc2S0It6bA5rYEAVQtGhfDE/5tb293zoKdeWQVuQOtlFka5s/ORc2fjjf
X-Received: by 2002:a05:6000:2001:b0:435:97ab:1299 with SMTP id
 ffacd0b85a97d-435f3abc8f3mr20340954f8f.51.1770071061146; 
 Mon, 02 Feb 2026 14:24:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e474csm45795473f8f.2.2026.02.02.14.24.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 14:24:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 1/7] target/arm: Have arm_feature() take a const @env argument
Date: Mon,  2 Feb 2026 23:24:06 +0100
Message-ID: <20260202222412.24923-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202222412.24923-1-philmd@linaro.org>
References: <20260202222412.24923-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

arm_feature() only access @env read-only, make it const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 21fee5e840b..d4a146b4202 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2140,7 +2140,7 @@ enum arm_features {
     ARM_FEATURE_BACKCOMPAT_CNTFRQ, /* 62.5MHz timer default */
 };
 
-static inline int arm_feature(CPUARMState *env, int feature)
+static inline int arm_feature(const CPUARMState *env, int feature)
 {
     return (env->features & (1ULL << feature)) != 0;
 }
-- 
2.52.0



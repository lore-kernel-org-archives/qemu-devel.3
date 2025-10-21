Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CB6CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 11:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBAAR-0001ju-DQ; Tue, 21 Oct 2025 07:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBAAM-0001ih-Aj
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 07:04:34 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBAAK-0003GO-Di
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 07:04:34 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47114a40161so11605005e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 04:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761044669; x=1761649469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8vv9/PEKtlnIDMF7ULGPxN0cdBSG0BVV0CmxG/jvMKQ=;
 b=V03Yuj/T7OHMHX35yeb756wRfYv7vgDo411NgOYF0t0by4kd64oShefRulMFBo+o5D
 AfBR37eQcLUREMlmRvYRil5UhOCyuuav4IgPqbAevcu1b2uqHtHphoWDSzM214LhIQOh
 VW40/VrMrl2QByTPu9DjWHIYM52ILNS6Nmfhp844zM2ml3S7lfSL0+uDJ6xFvtA2+R/q
 3pAin5vqeui0MKZX3T1X9KQMC9GbsHxqLUQqYyG8i656l6V5RxKjBoyKYIIMit8JfHuH
 LrV8XaCHTBL8MJ9og16EuvyLzoncDChs6CNcHiTmAfInsT+3cudEjx0nJUQguzK5+jlF
 pf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761044669; x=1761649469;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8vv9/PEKtlnIDMF7ULGPxN0cdBSG0BVV0CmxG/jvMKQ=;
 b=xIzPFxYlbzNDbPmW1LmNtG1A+PaGPxIwLL3+QMUmZFFOWVrUjwwcn1iwelbLiILyQX
 Oxs95wU2iHgfL+dxUmHyfDQr4CEED6CIPemwlUsbMUeHnOZ9SvHIKi07ONTqP2AMTtJJ
 eVSh9SQRzdAeKZ2Kv7AhL5sUvTHxEhwcfy/RHbRKVC7yDXZN5FJ1wE11ccjiu5PwMbUC
 7ZsqQm49LfHrrUZozyz3NhuZtchh8Qw+PcmnfdAfssdFTwx+BJfycXxSo97KzcoXG2km
 J1AyDX9mzgHEk7RM1n8BHgNxng65bSp2g/7Tqgkbocvg1bI2gQC/z0mDGMZiu3m17djz
 4syQ==
X-Gm-Message-State: AOJu0YxFtzvaLlXtywmtOV5Fr9m+crcnBA5hZfdhAonxTbR+4yVeGXFt
 CZtGMpETdhk5Tzn4HL82Ld6qpKDZFAQgJ8D8Nn8fZw06Rh+U6Ag1Xud7sYMnQlgOJ/coPYdxUki
 bnRSylgY=
X-Gm-Gg: ASbGncsbJWlfIEg+E2JGQHEuYBf2g7VCJ4j4rW7sbNFI7V9b9aIqPp9u8+kqqVcT7cZ
 KC+e8C/GS0vsu8d7+9+1Jn1MjlH0wFGG4if7cXaQzmybcxaiOWxjhB2cd7w3aoS5hL/8okOfwgg
 pRagL9VL8q3u8d75cBcaLutjcFje4M8tAQl1yryw+nU4lGxyv+4M4W5MkimDTOZ7vlevKXY02mX
 Na4aHtufaF9odzVESLUS61aftX4x0xmT6ipQ9o6uCzyuBfOcNc5UBAcnGsJDWzEFG3/ju1iRbc+
 6umv5bnjW0YhRvAEhR8//IRHWLGMj8j6bjpUm2jjYKPEoY7b76oC4bVPOUOzHh5RaHuo2SJvgGH
 aQmDIq91llIO/A9JK8XNgvBHzuvGuo5Mz+byNhRlJQx1ma+G1PujxZq2jr5ZSn9vfJFGK7m5pCQ
 V1TDL8kZRU7LX3YIoaPEpTHSyYqPD7/mZIzrS9XCxrCU3p8K1BFA==
X-Google-Smtp-Source: AGHT+IGB+0YzsJHVRX/3U55NHWvcBKArwVcVnTolWAKZQazTpcc+LydtphPE38wdTc/ZbSViVDe04g==
X-Received: by 2002:a05:600d:420f:b0:471:131f:85b7 with SMTP id
 5b1f17b1804b1-4711787dcbdmr117863165e9.15.1761044669496; 
 Tue, 21 Oct 2025 04:04:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496d26affsm13793315e9.12.2025.10.21.04.04.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 04:04:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Troy Lee <leetroy@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/arm/aspeed: Remove ast2700fc self-aliasing
Date: Tue, 21 Oct 2025 13:04:27 +0200
Message-ID: <20251021110427.93991-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Remove pointless alias to the very same machine:

  $ qemu-system-aarch64 -M help | fgrep ast2700fc
  ast2700fc            ast2700 full core support (alias of ast2700fc)
  ast2700fc            ast2700 full core support

Fixes: a74faf35efc ("hw/arm: Introduce ASPEED AST2700 A1 full core machine")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/aspeed_ast27x0-fc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index a61ecff3909..463dd30cc5d 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -180,7 +180,6 @@ static void ast2700fc_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
-    mc->alias = "ast2700fc";
     mc->desc = "ast2700 full core support";
     mc->init = ast2700fc_init;
     mc->no_floppy = 1;
-- 
2.51.0



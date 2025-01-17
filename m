Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F13C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr23-00048H-BS; Fri, 17 Jan 2025 13:25:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1x-00044H-LC
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:17 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1t-0007rk-Ma
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:17 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2156e078563so33561555ad.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138311; x=1737743111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xG1IahTqt4vurDh2g5rpdRAk5d613TDMqAZ7ZMXQJB8=;
 b=BdCweNfnqSytFpu7NSiOvoWGkc65KP4fzI+vSIwUYe3TPxo6UmxjL0yKmD4v5YzxwI
 RzNb92PrIv8pHAT0hX8fC69KFNGKu1gw+7S8H6u9tTscQlJ6CNTugJFH7V2mWeLFlVuL
 avQn+UucC5gXhKAAOD+r5lVhYwUbvPoXrgeM6Od0GMyoiaFhtPAuvlG8xSQRxvEzVHag
 9enZ1cnFSlfzfMmZ0d6x1yAcp5+f7Dh0Raffvx+9/5fONOMIV4hi8yBh9X885Y/JdZIq
 hgpyWMoE3ijmnCm32bIk6FbMlBfmi8fZqkMzuHsqf8PO/jNARwt+sAjXKYc8hAoR4Hmy
 N3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138311; x=1737743111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xG1IahTqt4vurDh2g5rpdRAk5d613TDMqAZ7ZMXQJB8=;
 b=TlFXuj1kWeD3wREPh03EIVBGXswwqFSYDB3a3KPjHDYZd/+S3/T6PXHY7xA8aefbeN
 eby7Rywtq1mXqFehRPDnpf0lYHoXiQ1MrH8ApYI2hB172IiAdJBj9CVkYE+fypYLmpBe
 ELzpFcWcyvjYfCZMP34Py33kHBamaJJjXs0bj8syWgpIBVch/5cPaXA15COam5sl1nd8
 P1Tm1LyYSzeywYIS9fPWbGwTfbBcMpSBfL7PnCXUW7ensqCt4qrIyapCjUZaWaHyMPNJ
 iA8XrjivmMfLNgWLwhD+TT1j3eLKtdOOm4NJ78FNbH0hPsiIgDVSMYGsgmoJRt37v/7x
 jmmw==
X-Gm-Message-State: AOJu0YyKFO/lfSZYdLMc7v+4k39Wa0KJ8MnP9Z3a5QGRGrNoQmLycO9b
 YgtSqDpRtse8V4C/90TT1anUTmrPcKbrGoSgg2lTe9u6PKQDVjFVDm0nLHHCKFGKqOgEP04llVV
 I
X-Gm-Gg: ASbGncuRGRqnmeLOgIUsJa9hhLKTP41vMPIXJ1yak/tOLi5AO9XvIjLWkDt1GW0MTSK
 T0MVFw79fazRSCr0eG4fBHDIIjm0Nuf17FDdEtjoXnH8tsvNlTJHoVhVD6sYk6m8JjeOeNrSMH0
 2dBbWs9L8a3Hs8YfUSdu23ffmamrAGj6sLIiiZJMfE6B1uhqR2iSUm9Ip2Y3wXYNXA7UzqFkcl/
 cwDfK6d1C0L7YaYV1YhHF7HSkPMSH6sP1qnD+f4UIWNWs/L8LZMhtneH8nb/w4E2X79YJm46iRc
 j7V9t+srwwFuzSI=
X-Google-Smtp-Source: AGHT+IElFDpWJWM+nwAcsVZwzagfpouMcZU55uweILc7q9i5AmpF7HuUJINpo34+8+ln7efGFLx37w==
X-Received: by 2002:a17:903:32c1:b0:216:59ed:1ab0 with SMTP id
 d9443c01a7336-21c3555847amr44373925ad.27.1737138311393; 
 Fri, 17 Jan 2025 10:25:11 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/68] tcg/ppc: Remove TCGPowerISA enum
Date: Fri, 17 Jan 2025 10:24:07 -0800
Message-ID: <20250117182456.2077110-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

Left-over from commit 623d7e3551a ("util: Add cpuinfo-ppc.c").

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250108215156.8731-2-philmd@linaro.org>
---
 tcg/ppc/tcg-target.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 8291e0127d..4fa4a30de4 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -55,14 +55,6 @@ typedef enum {
     TCG_AREG0 = TCG_REG_R27
 } TCGReg;
 
-typedef enum {
-    tcg_isa_base,
-    tcg_isa_2_06,
-    tcg_isa_2_07,
-    tcg_isa_3_00,
-    tcg_isa_3_10,
-} TCGPowerISA;
-
 #define have_isa_2_06  (cpuinfo & CPUINFO_V2_06)
 #define have_isa_2_07  (cpuinfo & CPUINFO_V2_07)
 #define have_isa_3_00  (cpuinfo & CPUINFO_V3_0)
-- 
2.43.0



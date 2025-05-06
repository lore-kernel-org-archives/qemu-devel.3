Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2841EC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJXM-0002of-Hg; Tue, 06 May 2025 10:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJUz-0001Rh-QO
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:31 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJUx-00024S-9X
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:21 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-441d1ed827cso4603305e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542537; x=1747147337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O4yiiXtXUXViae7AovwnCxNdXlhh8r1+3qxtggxQ0u8=;
 b=eueKHSzwQlRyoAUoMWfineQ26z3BYfHkVsP4fqCHk2Ap8kvKtkS+J39Rj1TnHwhLjo
 qtG4bacSafF3pPOHBJtAUA7Ar2u3KXmNAMT51sLnyeKcLgah9pHtWQ3UNWM3eiaGyz8T
 XADfOo1g28qUJd5k+y77NNCPQavyJXTMONgYIWlFbNoJm1RIkREmU0mYsAG3jr+hIdMR
 WPj0BQjesjiAWAvqMJQvUrDk3BHQSSItvIaNeZa7zNyvl+N+N1WkAHkKybby93w7gSUI
 PDFe9R8N2q48tqunHIuUUuOfpqhPhQETKf5Y31ChAnYTIMEtHjf0HM+aqloKp8+FFPK+
 G9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542537; x=1747147337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O4yiiXtXUXViae7AovwnCxNdXlhh8r1+3qxtggxQ0u8=;
 b=WtcDP9bHTqQO0klbwz5vdjFyeLUsdVqBStUARcSF1Xj0z3MFJpYx9jP6YrgnhuWk52
 UhDEQMOxY/XVAM/3mK5WI3WUYz7g/gbqpl0hkJc4VyDj21lOp01XZuhy0SKpz78hf1IV
 i2PtN1mxBM8D29UOm+fqQjvQD/80deRtiPei6gOEuJAb8uHL6n4PWjTD4arh7kkl5JKq
 nRnniTud+X+SmxAXzQI6dKZ1cW4JE0d0d8UnEmQ8EmHTEG0rRV+a22PGHEcepCzregn8
 v/WHMcDo9ix+cOlsP2E3q6sXqAwjxpwwPfwwCyT5e0l8eWdTLKyFM8pX9kqGBgNo5L6c
 z1DQ==
X-Gm-Message-State: AOJu0YyLoZdLsKEXQrK0kTh+G24TmrRnSFm2wj4CPHRN9cYfu3bv/oI+
 hEC45f5QHtO4+lnzPScABV2J907D2xwvuswUGyHnWUshFdcI/PNb7AsnTudJiO1fIHpiJ50k+ND
 g
X-Gm-Gg: ASbGncuuljehzkgNTSZ27dcRGBnQ4F/C5ucJONAIlJhUqo48FT1cBJHsY/+PbIoxqXh
 cWUIXZihostfBRxUBr+EsRibs0QaDY+1sxeQUTSN0gXED303jl3m3/xOP8d8p0AP815B9etir1+
 m4GWeiy2mR8j1OLJRvmyBQKQpKU+C2bbTZ1i5DLuCxjrcmtWsQ1OsB4dRb97EdqZdbq2vd9SF1p
 /iNQwiscIjOr0iYG7hMSQSp7dLkSu4pjotyPV2HkeMzbdzxvR7Ni/CpgLtgGWga5lXerIY1ZFNc
 sg8yiwqSdSIlKfpXMcJDai0bDHQdVNNm2NryrfYd6TmEe7M=
X-Google-Smtp-Source: AGHT+IFv/TnmofbHah7TZNSOXccE+qnT59PZe4nMfTCNj9iIkEhghK7AQdRh8npGuXzK7pUYlr1mfw==
X-Received: by 2002:a05:600d:12:b0:43d:b85:1831 with SMTP id
 5b1f17b1804b1-441d0a31ec5mr33718785e9.0.1746542537471; 
 Tue, 06 May 2025 07:42:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/32] hw/arm/npcm8xx_boards: Correct valid_cpu_types setting
 of NPCM8XX SoC
Date: Tue,  6 May 2025 15:41:43 +0100
Message-ID: <20250506144214.1221450-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Tim Lee <timlee660101@gmail.com>

NPCM8XX SoC is the successor of the NPCM7XX. It features quad-core
Cortex-A35 (Armv8, 64-bit) CPUs and some additional peripherals.
Correct the `valid_cpu_types` setting to match the NPCM8XX SoC.

Cc: qemu-stable@nongnu.org
Fixes: 7e70eb3cad7c83 ("hw/arm: Add NPCM845 Evaluation board")
Signed-off-by: Tim Lee <timlee660101@gmail.com>
Message-id: 20250428022934.3081139-1-timlee660101@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/npcm8xx_boards.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
index 9d9f6d0c9a6..3bf3e1f8f16 100644
--- a/hw/arm/npcm8xx_boards.c
+++ b/hw/arm/npcm8xx_boards.c
@@ -213,7 +213,7 @@ static void npcm8xx_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     static const char * const valid_cpu_types[] = {
-        ARM_CPU_TYPE_NAME("cortex-a9"),
+        ARM_CPU_TYPE_NAME("cortex-a35"),
         NULL
     };
 
-- 
2.43.0



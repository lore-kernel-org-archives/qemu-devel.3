Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310EAC982F3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 19:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgp2A-0001MD-Pr; Fri, 16 Jan 2026 13:58:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vgp28-0001LM-DC
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 13:58:56 -0500
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vgp26-0000mR-7e
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 13:58:56 -0500
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-2b6bfb0004aso1593170eec.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 10:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768589932; x=1769194732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u5CoiFBlvwlDochbDx17D2JnG16QHyDmaOCgHopwzx4=;
 b=QrT5/RIp0o5npbeEtyF+6jrbIt+rpG3IoyNUt7Mx4Ek5dqK8syCfWvKakc2f58kcdW
 IM0cgrL5+Lrv7xPm1od/1BPWYQ4gX7Yr6/U7aJ1QD1ZzbiOEa0hy688JsETOf+THBRQj
 wFXDc9x+1H0RO8G3xuzVfeD9MHUcLSoFYlKZQonlNxFLSUNNtAS0iJYT9JQvDLLv3wIQ
 u/MgpI699iKH33kC1dmofQ6xNQE7ME92KL6807U9j+eft77tTT5FbIqMh08QUBlkKyEH
 u6KLZWVE9L2ye0xsBhovaWO2bAJIXc4u3ACLZNz7z2lXZj3jFmKBpRZzVyAbX9BvUyj7
 OrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768589932; x=1769194732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u5CoiFBlvwlDochbDx17D2JnG16QHyDmaOCgHopwzx4=;
 b=srxDDKo273/9Lm1BcWAHxoomXV1CJ7t5uSdrKNA98zh7vfpIPhlw6cWczKHKFW2m+J
 g6/0C5vXdNtyv3eTtwAm/mzXT8DFyJcd6PeHmfIjA3s7asxE/BRdL71xhUm5yRGFKm/V
 k2WZOG6HMczcXMA1xofbOU2grZ/Hzs/dI2t01mT7frJGWheRpAC2icSbKVABDUKmpLv3
 ObWsyaQywBWzeZE+SUb3tL9tnR/W5pVOm/BXt2VAxW+0N1SaLh9/WtJYDw1mUcYYmwEV
 8y3gbTybKoVM/79pgAPiiukCgD5nCaKCoKu8Qp5GAoSGWenlbmEYMpkfUqB4+81hnQQZ
 /pjw==
X-Gm-Message-State: AOJu0Yx7jd2uwd2pojcYL+MKzEykQw68LlVesBJxrxq94pNqfTGRWDcM
 d18KOKKgnc3BGesz8S8iDly7hAaSQ/qhB6/BtJNl/Oem35wy49U516X8hxt34MN8d71cGPISZKT
 fuQaW
X-Gm-Gg: AY/fxX4e6afddN+/g8e5/5Z94aTysLrM6SoDGACjnKzwKOHfKAgideBVLckfY6weFeh
 0e/NwM4KhvzCgkvb3LXjH7TOCfo3g5IiU12OreMi2Xl2rSsAetJPv0Y+RD+G9FBcg6hs7hWrMjw
 5NX1NYpMJVRRL3TqNPPPU1axlBKeWZh6xH1Z5qoiwYwLI3Iba9APFvJ8MpzbejVynhJ/RLb/ZAB
 lig5QuT7KrovCbiUx4NEMtfew8AlGNiaUr/Kmxwn2vMvDLVP3djhWnA40N71A/gJdkix8ikZOoR
 ItXRJ0L4rVs7BT5D+O7V40iwEY49j6MjGDtIcHLTsNkEEr8MebKkq+kEcKjICOLUF8QDaCamRzP
 ixoe2+ffOnxYU6CC2a404fI9KycYQRCjankKqFpLG94ZdsJ1MHI31mJHAiN3AMzkEFiMwkHGTBQ
 Vd+/XYreC+XVb6pQ==
X-Received: by 2002:a05:7300:a507:b0:2ae:5664:8110 with SMTP id
 5a478bee46e88-2b6b414aba3mr2680126eec.38.1768589931831; 
 Fri, 16 Jan 2026 10:58:51 -0800 (PST)
Received: from gromero0.. ([191.8.214.17]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b6c2de1f29sm1524126eec.15.2026.01.16.10.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:58:51 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, philmd@linaro.org, peter.maydell@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH v4 3/4] target/arm: Add a _MAX sentinel to ARMASIdx enum
Date: Fri, 16 Jan 2026 15:58:13 -0300
Message-Id: <20260116185814.108560-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116185814.108560-1-gustavo.romero@linaro.org>
References: <20260116185814.108560-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1333;
 envelope-from=gustavo.romero@linaro.org; helo=mail-dy1-x1333.google.com
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

Add a sentinel to the ARMASIdx enum so it can be used to compute the
total number of address spaces supported by the arch.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 target/arm/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9579d43ba3..31afd80854 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2336,6 +2336,7 @@ typedef enum ARMASIdx {
     ARMASIdx_S = 1,
     ARMASIdx_TagNS = 2,
     ARMASIdx_TagS = 3,
+    ARMASIdx_MAX = ARMASIdx_TagS
 } ARMASIdx;
 
 static inline ARMMMUIdx arm_space_to_phys(ARMSecuritySpace space)
-- 
2.34.1



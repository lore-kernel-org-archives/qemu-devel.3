Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F38C83F07
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNqw-00015O-3w; Thu, 03 Jul 2025 13:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNqh-0000ja-9v
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:35:51 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNqf-0001pZ-Cc
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:35:50 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a582e09144so40519f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564147; x=1752168947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/MC92E7FLkNQLrXWkop42r4qYRx+5dbFagdyAugyF5E=;
 b=uH12NyoandpNYYX4aMlCv583o0Qc/TIY4z5G691N5TLKJJKt7kUr2QAgGNoeTOORq1
 2e/qAkUed7r3kdUf52nUBufoOBssxe79BmeZ67Po/mKsv3bxx71pmGlvJAaPMIZQwK7k
 ArZwf4FJrWauuwUeqXkqwfOEjWJFj9L/6fnPYk4FWnDvHa6dZeTv1fVUKWJOk5bs5vTI
 DZj5+8jwbCTu3RsCud8oN1NDA0b4L8zHFjYWPJT0ZcfkYn+HNsVKGb9m/9brJphIO9qP
 0QRsb4qsjT27DH9ufizppbtaJkQ9qbKt8Ldk6bU9Th0MJ5AmkKip/7LsStrHQt0nkG3X
 9Lpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564147; x=1752168947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/MC92E7FLkNQLrXWkop42r4qYRx+5dbFagdyAugyF5E=;
 b=pznsow2RUiMCMgWCVAq1JR9lQ5SoTdD7CbVaTnHJd4qbE3Lr+AqM1woFsy1uOPIHtf
 Ah6dc0Z17wnZMeLQSkrP2NFWfP6lIDViosFzk5f41EWpXPAGhN61ZJHspNIJva1Ffvd7
 iGdhJkBMvvv/7tqIEEEClqyIhLjpW/Enx8ZJXEmQdqZq0QXBndA6HPJr4Sjm3zDsqB9i
 2NiHtwO8AwMyr3fIeQtcpi2JaBWafdYZvvfHRgvfWWTGFGq178RyTJdU+taX3P4biMru
 526b2WuhFyRbFTTWW2Wdp1VL43d/W/uH//+0ERDXOMbWXmrNQM5xMF8tP9ftJL5/eixS
 UQ3g==
X-Gm-Message-State: AOJu0YzGyF7HVvTJ+RTaDWXlWyQbLfUMFDe5tUWXIsleaSRErJPvwS5r
 FEr1Uyfdu3e9rXJNNlwf6lBIy3090d6/EgsBjNC84wB4MfoV4QERP6DvSmeQPVYLnh7ZrhXC19G
 wydiFGa8=
X-Gm-Gg: ASbGncsnKEdNaoJVFv8vWwAy45MUcenMthwMjYXynqC1DRbQexl1NyZVsB1JcFY0hVV
 obvXoShhdL6P4+hF93Gs3550+TcFjSSyHBe7aHW3lMQ00L7iuUR6fO8Vm/vb7kOcR1oLGixMk1i
 ev8/OTf/Fldfb0a3xgJ5dvsR3ZS7uLojJ8fbvw/dNnZfH0QfTlsN6J2pER9Jpja/7Xjpywc4pKi
 68Yh9++KuwG84urNq07TaPenlwJF73z+iJBKbq+dUsRvn90bmfrI2LGnGrhzjgy02YfKWao6Yg+
 pujACPhtCG17PF5IVgOIuC4/jHvl/K+PSqZvx05QaECSIzIzC43vrbyPld17SzYlkoP4HMofIXS
 PiI3kfwD886WZ+wXJFRVjqLV6k55XrBbOUGbBP/bR9p9PZfY=
X-Google-Smtp-Source: AGHT+IF++zcaURIEkhv3c911GkgiVo2i34p/sRCY262o8tkwpm8ymeUemtjV0/YYVdtuOeOmYnrO1Q==
X-Received: by 2002:a05:6000:4807:b0:3a6:d579:ec21 with SMTP id
 ffacd0b85a97d-3b1fe5beeeemr6738251f8f.12.1751564147347; 
 Thu, 03 Jul 2025 10:35:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453a85b3016sm66811045e9.0.2025.07.03.10.35.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:35:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 32/39] accel/tcg: Prefer local AccelState over global
 current_accel()
Date: Thu,  3 Jul 2025 19:32:38 +0200
Message-ID: <20250703173248.44995-33-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 7ae7d552d9e..969c50c87ea 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -82,7 +82,7 @@ bool one_insn_per_tb;
 
 static int tcg_init_machine(AccelState *as, MachineState *ms)
 {
-    TCGState *s = TCG_STATE(current_accel());
+    TCGState *s = TCG_STATE(as);
     unsigned max_threads = 1;
 
 #ifndef CONFIG_USER_ONLY
-- 
2.49.0



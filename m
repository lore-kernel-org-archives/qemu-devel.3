Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01484C3064D
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 19:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNzoD-0005YK-Po; Sun, 30 Jun 2024 15:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNznS-0004vJ-Oc
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:01:10 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNznN-0007Yc-8b
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:01:10 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5c21f1bb810so1174212eaf.3
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2024 12:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719774064; x=1720378864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z6AjjP28A+nmFWpUBGHe4AhBkZ8znn8UyBjn33WhQ6U=;
 b=GSacmnwAi5wSoQfFAnLrRk0kupM+HFm8l8LsXq4Mv/a5jzADMDnYSCvTQF2wiFgMqV
 +usYXB8qA+9MznddZD+gqh2fnHoqGEVgk80kLvV8Gkfpv/MmktKw/JEZY9qoAojTesOx
 /wiXDyQjp1CFdz3y3Cm6WsN7EzdrzgC15ULbljzznhBIn6U23aIPcSTsh7JpwBUsSJAJ
 Z6/ogCys3RQxbiu1KgbMxxGfCL/lh3BPB2rLI/09VQJaKxg50VsaOmPPiZL/k292Z+F1
 GBUcy2N9yofXvF5g6Z7vUyitcM1rNp9+rXhaCo4RZkzchsOJz7XxprsXEOmugTf5fxMM
 vhlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719774064; x=1720378864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z6AjjP28A+nmFWpUBGHe4AhBkZ8znn8UyBjn33WhQ6U=;
 b=JreR6kxKLiz+nztzVemPwMhjWDcG1Um/Ndv3E4ZAcKa9M3+eQAwGu+v4am3e50QY49
 VlaUhQ94JEMaLhwPQnA9yJ4KYEZLxd/oiB3Js58jtLRBGcWKdVEGguqLGXp62yVyfdvO
 IuT8JuCShCViVz8fQORkOwbVWZOfFLu3Lw6E1t/WN+Ek6oCpqJ7PrjywyNfRmFdKngnk
 MTAzJJI69VL/79a8fSwmDh61HW7Lkl7ihwpOgXjHHXoMd7z6d0ndjrchGEi1/VrpKpjE
 7dV7e8lBBDx/yBizqF0S+zqq8TYP08rbw8OZ/Ch/5u6D5AZs0xDWMsM+0eVUFSJIUBG6
 PnRg==
X-Gm-Message-State: AOJu0YzV20bwp1c9ZhtmA9Ik5rtmPARM8El2Ay12neDaAVCTanRoFHrd
 NMfOyRferEEzUi4G8b/3qFliEjLC8pl2LrfrnJnAsl9Z0RWJaJiQHSVgpK+oket8aQR0vCjcom+
 +
X-Google-Smtp-Source: AGHT+IEZqdtxlGnwVXN8pJTqay1KPgU6I77AvumxWecEDGBS+BHnRJ1bsngNFcAotBi3/eWXzTC86A==
X-Received: by 2002:a05:6358:910e:b0:1a1:d75e:9bd2 with SMTP id
 e5c5f4694b2df-1a6acef5f3fmr249892155d.30.1719774063571; 
 Sun, 30 Jun 2024 12:01:03 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3e7e4bsm5115641a91.52.2024.06.30.12.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 12:01:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com,
	alex.bennee@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH v4 12/14] tests/tcg/arm: Use -march and -mfpu for fcvt
Date: Sun, 30 Jun 2024 12:00:48 -0700
Message-Id: <20240630190050.160642-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240630190050.160642-1-richard.henderson@linaro.org>
References: <20240630190050.160642-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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

Clang requires the architecture to be set properly
in order to assemble the half-precision instructions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/arm/Makefile.target | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 95f891bf8c..8e287191af 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -29,8 +29,8 @@ test-arm-iwmmxt: test-arm-iwmmxt.S
 
 # Float-convert Tests
 ARM_TESTS += fcvt
-fcvt: LDFLAGS+=-lm
-# fcvt: CFLAGS+=-march=armv8.2-a+fp16 -mfpu=neon-fp-armv8
+fcvt: LDFLAGS += -lm
+fcvt: CFLAGS += -march=armv8.2-a+fp16 -mfpu=neon-fp-armv8
 run-fcvt: fcvt
 	$(call run-test,fcvt,$(QEMU) $<)
 	$(call diff-out,fcvt,$(ARM_SRC)/fcvt.ref)
-- 
2.34.1



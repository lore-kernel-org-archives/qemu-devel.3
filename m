Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8CFCAC58F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 16:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqapk-0002u2-8H; Tue, 17 Sep 2024 12:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqapi-0002t2-EM
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 12:13:42 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqapg-00058s-Pq
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 12:13:42 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42e5e758093so22443675e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 09:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726589619; x=1727194419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DXtzhQMzXPZEve28/UaAqCjf2VzfUHrh5WPlBaS6+B8=;
 b=A0lKXmhEmNAuHefngrdFrV7DWnU2wLPIdHJtwbAaUmmvXpArbRxYmi1vLtY9YnwZAr
 CBQ0Kp9TZLe23YPbwKm4eN974rB8OZM3btn702yooP5VLp+OPJOw2IxYUvn0K8b6MG/h
 uDrGnGpjQ8zgl4dgt2+Ey7DyIZcuTXk+uYukqOwqRExStAvLKNPn40Lv0MuTk98hJcBl
 Wb03anBCDrs80sG+XBWGr6vvZY/2IK4nDCmOFPYKmqNAx+gok0RBaoT4imHGoWmkxcPC
 nnRAG//fboh7ilMj96qapODBHnevZS2q7OuEjjpmpDvUmjV4JBRN9RNBygPd1Y2l1Hbk
 KOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726589619; x=1727194419;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DXtzhQMzXPZEve28/UaAqCjf2VzfUHrh5WPlBaS6+B8=;
 b=eFnGr+3FgApt6Q5AyWRfc9kZC4AZuCTfC5nMEJu34wArDpFYR/htw/oULmTKTIZ5Lm
 jRbyea/qhONURDy5L/9XDdYwc4V2RljbuAfhX0OgYIXvc04onCw2xCemFevcYoxIfizx
 DLusKnDj3/7S9BLiiqg9C424QN6s2SJ7vLlp/e5QM0WD4R9O+28Kw4bEdWwrlnjtb+ms
 0ULVA48y4B68AEsytdU+jnd/BJjlt8gYQ5Z26RRj914Fy0z1plIphbT2Ixm7TDBWgljH
 JMi4Dc7YCf9kDTtCvaMK/XZnWQaTVQVkoAxC8J4J4vFgqmi7AYIRJxsnwguPto2d0QAM
 kjYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzxxb/Rr9jK5678dPPGpe0d08LEc7/w4TZuJZ+xadElUTABwW/G+aLT+GaFfWluwyVA9t26GcYbMx4@nongnu.org
X-Gm-Message-State: AOJu0YxsaP/sJGJlA7fDXvwAgZ7Q7FlzcYePp9GyDmwmxf5LWEUmbOKD
 oBeJaTdevyVl48PK+otuCmrR+BLf1cfKNOCb0e832McEFRq/QXlFKTV8Mtw9OCEzSoFjgA4vI7S
 A
X-Google-Smtp-Source: AGHT+IGOYD1SMKzFNatlx75NXEPR3jE/Yq3Y3OTAhbtDaKYYm8zWFzkZy74EsaCfHUuY0NGF6aqXJQ==
X-Received: by 2002:a05:600c:1987:b0:42c:b22e:fbfa with SMTP id
 5b1f17b1804b1-42d9082a660mr101034345e9.21.1726589618704; 
 Tue, 17 Sep 2024 09:13:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42da22b8b5asm107810295e9.7.2024.09.17.09.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 09:13:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: [PATCH] target/arm: Correct ID_AA64ISAR1_EL1 value for neoverse-v1
Date: Tue, 17 Sep 2024 17:13:37 +0100
Message-Id: <20240917161337.3012188-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

The Neoverse-V1 TRM is a bit confused about the layout of the
ID_AA64ISAR1_EL1 register, and so its table 3-6 has the wrong value
for this ID register.  Trust instead section 3.2.74's list of which
fields are set.

This means that we stop incorrectly reporting FEAT_XS as present, and
now report the presence of FEAT_BF16.

Cc: qemu-stable@nongnu.org
Reported-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/cpu64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index b9f34f044d0..01689208286 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -677,7 +677,7 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     cpu->isar.id_aa64dfr0  = 0x000001f210305519ull;
     cpu->isar.id_aa64dfr1 = 0x00000000;
     cpu->isar.id_aa64isar0 = 0x1011111110212120ull; /* with FEAT_RNG */
-    cpu->isar.id_aa64isar1 = 0x0111000001211032ull;
+    cpu->isar.id_aa64isar1 = 0x0011100001211032ull;
     cpu->isar.id_aa64mmfr0 = 0x0000000000101125ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
     cpu->isar.id_aa64mmfr2 = 0x0220011102101011ull;
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DB8C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 17:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVwra-0000Jn-1x; Mon, 22 Jul 2024 13:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVwrY-0000Bu-5b
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 13:30:16 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVwrP-0006Nn-Pt
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 13:30:15 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4266ea6a488so39638185e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 10:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721669400; x=1722274200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q1fk3MZNeiAsw57LUWbslOnLlaVnbzI66YELvNijArk=;
 b=OUtE/lfyXE3J3ycU7iFQhZaPhFFW8BOvFUJgG4UMgljFJV8ZxW8NT60R2itPFMn9on
 YPxJeEiIL85/5OwiwxqIWeCY7J8AM2opk7jc6TP8D+o3hX0V2t6OY2zPJTaRcHJfe9/c
 gDmUveaZRehgQWKIxF/SGDaX1jiYOturEuoY9EGrgJ0vXR1C6UDB2xm8P2ygVfZqsQit
 oQusGH8NyGJY0fTN+akVqLOCGvciRKcYBbjyfwX4DoZzUtHDHYCGKKxKpggxDAGBnP1P
 N/DU6Q3IHBVdMigIpc+EyETV6I6t3eS8urhr+egK5Z5K8gqehfeviYOeohF3AAO+cgNO
 Bddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721669400; x=1722274200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q1fk3MZNeiAsw57LUWbslOnLlaVnbzI66YELvNijArk=;
 b=rRG+sUb/9PeXBzyD4WBChyyv532ajSKAi7mSa1NFHLccwxeTlMDORSUraolgrRIXLU
 5uRpL4BDKcRFLq7bvZLz4PpmN+lSoBVPHBWYbjQNo+ZebARpgvMdMBHtysWZuRulFMF+
 BpiRLZ5wBoDaRU9nnlwRh/A3CqyOZsTMnFx3eA59CrjoE7OYiU/TLZcir0U8sifEAQnN
 wfWChRiL6mw4HB5Qk6pP28ni/pij/6UExONq0DhJpLeu7iFC7YfuuNfLUZS6mheSjTZu
 pBnS9cngO0qIYkNWpsCQlU67x0g90Jiak3EPptoqDuKlP2pt/euP2VfmSYvHiVykrSGg
 NuTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyZDSBl+146Zz31Zg+hVrFcisKEzyooWxM+pzntZjkCZCANF+utECvP1hxZRBcB64l8YAft4q1qypT/FhPH69jEgMbwFQ=
X-Gm-Message-State: AOJu0YzLto9YX2dHXJt177/HH40Np/9eW0FYadKkw81xrxKDI2/wiIm4
 JaTM3DNZcZDDxngThSZuxev9xEBmQuw6lXJ9Zl1Z/SW8q6XCA06d4Vm28nG6IcE=
X-Google-Smtp-Source: AGHT+IERdPDDMw8FKthSXDy81Sq0hLsQtrN9IHHY3SbgVY2wTcneNg3HdWBjcl41bP6LjTipwvVsvg==
X-Received: by 2002:a05:600c:4452:b0:426:63f1:9a1b with SMTP id
 5b1f17b1804b1-427dc56b427mr49402815e9.33.1721669400337; 
 Mon, 22 Jul 2024 10:30:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d68fa493sm138035665e9.10.2024.07.22.10.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:30:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH 2/4] target/arm: Fix UMOPA/UMOPS of 16-bit values
Date: Mon, 22 Jul 2024 18:29:55 +0100
Message-Id: <20240722172957.1041231-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722172957.1041231-1-peter.maydell@linaro.org>
References: <20240722172957.1041231-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 THIS_AD=0.899 autolearn=no autolearn_force=no
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

The UMOPA/UMOPS instructions are supposed to multiply unsigned 8 or
16 bit elements and accumulate the products into a 64-bit element.
In the Arm ARM pseudocode, this is done with the usual
infinite-precision signed arithmetic.  However our implementation
doesn't quite get it right, because in the DEF_IMOP_64() macro we do:
  sum += (NTYPE)(n >> 0) * (MTYPE)(m >> 0);

where NTYPE and MTYPE are uint16_t or int16_t.  In the uint16_t case,
the C usual arithmetic conversions mean the values are converted to
"int" type and the multiply is done as a 32-bit multiply.  This means
that if the inputs are, for example, 0xffff and 0xffff then the
result is 0xFFFE0001 as an int, which is then promoted to uint64_t
for the accumulation into sum; this promotion incorrectly sign
extends the multiply.

Avoid the incorrect sign extension by casting to int64_t before
the multiply, so we do the multiply as 64-bit signed arithmetic,
which is a type large enough that the multiply can never
overflow into the sign bit.

(The equivalent 8-bit operations in DEF_IMOP_32() are fine, because
the 8-bit multiplies can never overflow into the sign bit of a
32-bit integer.)

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2372
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 5a6dd76489f..f9001f5213a 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1146,10 +1146,10 @@ static uint64_t NAME(uint64_t n, uint64_t m, uint64_t a, uint8_t p, bool neg) \
     uint64_t sum = 0;                                                       \
     /* Apply P to N as a mask, making the inactive elements 0. */           \
     n &= expand_pred_h(p);                                                  \
-    sum += (NTYPE)(n >> 0) * (MTYPE)(m >> 0);                               \
-    sum += (NTYPE)(n >> 16) * (MTYPE)(m >> 16);                             \
-    sum += (NTYPE)(n >> 32) * (MTYPE)(m >> 32);                             \
-    sum += (NTYPE)(n >> 48) * (MTYPE)(m >> 48);                             \
+    sum += (int64_t)(NTYPE)(n >> 0) * (MTYPE)(m >> 0);                      \
+    sum += (int64_t)(NTYPE)(n >> 16) * (MTYPE)(m >> 16);                    \
+    sum += (int64_t)(NTYPE)(n >> 32) * (MTYPE)(m >> 32);                    \
+    sum += (int64_t)(NTYPE)(n >> 48) * (MTYPE)(m >> 48);                    \
     return neg ? a - sum : a + sum;                                         \
 }
 
-- 
2.34.1



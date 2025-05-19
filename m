Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00825C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 14:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH1px-0000Rk-9j; Mon, 19 May 2025 10:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uH1pv-0000QH-3R
 for qemu-devel@nongnu.org; Mon, 19 May 2025 10:51:27 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uH1ps-00012m-A5
 for qemu-devel@nongnu.org; Mon, 19 May 2025 10:51:26 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so36153465e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 07:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747666281; x=1748271081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sv1uIzRpfIE5FbpULnDuS+CVfaDrnJOSP2gIW1vzay4=;
 b=qoRBavxqolwLArY0YFOLfHaVxKyebWMDogUALxNWl75i9tpMG/iNwpZ74KF8tLom4W
 RATfMcRoc07tawKWYiHsUU/0TEiutS/4+N0Nd99HdjRCUjmhpNDreMbTv4yLuOD9tVs+
 K5GeUFvkV+C0XsWYK1NxAOKqhUImt9XJmJl0RrWPHVV3h2fAO3CvNqbBFBkiwzbdtia+
 wTnOZb1rzX+b0C7O/XYczSyQ7eIDAEAdKt6bxV5N21+h+db67w+g+pEuqQH+9s2Q29ng
 hkEdaBm5Fw4INboI5JAyFqr2ruJ/JMDbXmcuyE2XAXGQbQMNKv+h19q4/XOo9jnbYkGd
 pIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747666281; x=1748271081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sv1uIzRpfIE5FbpULnDuS+CVfaDrnJOSP2gIW1vzay4=;
 b=hLyEiQzsLZQsvn6VTKpbFlL/om5bAKA+SILtqjdRuqaEY4ebKr9xyDe6coFJ/AqxtA
 DHSy9VV1vibLFZoioLd/c5Z9PgXvS6oLN1lBSSNlOmqt23GrXVcUJsuAhxotRiY7wDf7
 Wjy7UYdQ9fA+nmzDb0QbdUwMA0bfaEJLAA4GrhJ46h/CmXj1LxOjuKP5NfPx7/XbH1RQ
 xK8ayXKKmN8PGfpIIDJ2KeS7yA1DvfBpwiA2rRguUkaf4/5p+jtYAFJcchfgnwYjEETX
 sRTE21ytuoNH5HFPNiyx4qdwm9c9pcItEsGpwccG7xxjAsuZZpsBtn5Xa4V9/u4pZkyk
 HDzA==
X-Gm-Message-State: AOJu0YxJgygvNy6vic4R6vaz3/M1QwSemMYLlzQGAwrNUKzPbpFCyedu
 g3eavceXLVO/UU7uXHc3a6WsmSneEKOpOT503awS0HzkPCihZfuifFY90/9Kn7uSCKF/NO6MDQu
 Cth58
X-Gm-Gg: ASbGncvLGOzTOVcMg63EPCwrFUO8RNz487jSob2WJ7kRjAL2HErSI/7LRuU8N8USa6e
 UdPKDmFYu3BHjpIyHyHU/Q+Ne0nAzIc0u/7RU+c/7xVZwuxAb2e6p2eZFaIn/6g8bv4hRAOuYyF
 GL2LYnw6h8UDFM2KKGjoiCUbmyXoT5wFy8xTjk7JAlt7N3gvX2nl3+cmpHeixHzaoGWhUHmRGDw
 CVuxBdCN95nrA/jJsoPGXVe1lixrUbKMUg3/bvP3XiQxOKxONa3nnu+d2GLnI6uwUuQLo9kxZHU
 v6qtm3H8Ayr3c01/XT61tECM8In+eBVFQeHgr9iG3HBSnWgK9vB6qAVI8Q==
X-Google-Smtp-Source: AGHT+IGbUy3Gf11AY0KmYIbqQhhoeQ0sl38zQp0VYqeEUuEjiIDvegiODVDeVq9mwflmKG/RRJG/Uw==
X-Received: by 2002:a05:600c:4e0f:b0:43d:649:4e50 with SMTP id
 5b1f17b1804b1-442feff05c2mr117749165e9.13.1747666281344; 
 Mon, 19 May 2025 07:51:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442fd50b9b2sm145672035e9.12.2025.05.19.07.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 07:51:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 4/4] tests/tcg/x86_64/fma: add test for exact-denormal
 output
Date: Mon, 19 May 2025 15:51:14 +0100
Message-ID: <20250519145114.2786534-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250519145114.2786534-1-peter.maydell@linaro.org>
References: <20250519145114.2786534-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Add some fma test cases that check for correct handling of FTZ and
for the flag that indicates that the input denormal was consumed.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 tests/tcg/x86_64/fma.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/tcg/x86_64/fma.c b/tests/tcg/x86_64/fma.c
index 46f863005ed..34219614c0a 100644
--- a/tests/tcg/x86_64/fma.c
+++ b/tests/tcg/x86_64/fma.c
@@ -82,6 +82,18 @@ static testdata tests[] = {
      */
     { 0x3fdfffffffffffff, 0x001fffffffffffff, 0x801fffffffffffff, true,
       0x8010000000000000, 0x20 }, /* Enabling FTZ shouldn't change flags */
+    /*
+     * normal * 0 + a denormal. With FTZ disabled this gives an exact
+     * result (equal to the input denormal) that has consumed the denormal.
+     */
+    { 0x3cc8000000000000, 0x0000000000000000, 0x8008000000000000, false,
+      0x8008000000000000, 0x2 }, /* Denormal */
+    /*
+     * With FTZ enabled, this consumes the denormal, returns zero (because
+     * flushed) and indicates also Underflow and Precision.
+     */
+    { 0x3cc8000000000000, 0x0000000000000000, 0x8008000000000000, true,
+      0x8000000000000000, 0x32 }, /* Precision, Underflow, Denormal */
 };
 
 int main(void)
-- 
2.43.0



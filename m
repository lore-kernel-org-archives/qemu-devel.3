Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9212CCD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 17:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLOsK-0005aI-5j; Fri, 08 May 2026 13:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wLOsE-0005ZS-CY
 for qemu-devel@nongnu.org; Fri, 08 May 2026 13:20:27 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wLOs8-0002JH-Cd
 for qemu-devel@nongnu.org; Fri, 08 May 2026 13:20:25 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so35899075e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 10:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778260816; x=1778865616; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gxu9CDe8tl8fL9UnDjKbPxpxDM3hih4Q4GPE9e7VEC4=;
 b=l+t0DGIB+DGJEp1qaDO97CnASZ020uPR3WBm0uH7INb6lFtuqmA0UcEAFieocpa2XS
 Q7B3m2gM7AF/RLdUasi6VsJ/Y6+QGL4TZvuqFpOrCmZfPWs+VCG6OZhU34GBaLQzUEG4
 DByXiECQlJUvU5Xg8l5PWHihbS6x226vTjNotMA6KiMQeVFXIKHK3t0bpbTYeBkL1DOz
 sXq0VENReKWbiy3PFYt4QFr1Ka3hi21UyWi1X2YUHCcCZWpITTH4tVgnDYaTXkNDU7/8
 YKq8zWq9mb7nkj5z1A/g2RDvYHryJN0G92L1R9YUkrKJRAA8xNDl3MZCsEgOGzNQq48f
 Ggxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778260816; x=1778865616;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gxu9CDe8tl8fL9UnDjKbPxpxDM3hih4Q4GPE9e7VEC4=;
 b=W0BhEr6wyK7FDP/QOBSS/gKKNxiTE7GoI8s5kmYdMZXZwKFmQpqDdaUl8/hrhYk/0Y
 MGt8iAXRkmDUAqWSMBe3HuHJyiRxIcgnITtI0LjDbIqAko0LwhMG8g2v4GBZvAeBf4/i
 PojgJ/b3gpXpJErRYewP4Tp+QN36/RFwo5eRlxCNtVBki9CTWpJ8gDrZN08qqq6a2Xw6
 6HEX/gAoeqXKMu0ibCoI0acapp5CoO04SXdc5FLs6EDva3X0bAMEiBAfTocUXZF8ojfm
 a5w4XT5n/wQ1EMtPyHJRxrQHpSX2IOq9SBoWboAKPm3QVIosbgfgt3czZMyZupk95Ltd
 02ZQ==
X-Gm-Message-State: AOJu0Yym7dnNONr7QdAKJ8KkxmyAXE1Sqods0wOicTKrcn6O5WvyQuIJ
 vMvY+v4OC0pJ5oWUzc0kSTWCSjnmqTqX0pO6ccjrS/g/Cn3JrpXkr+zUysAnijs+dgasPYCfsCf
 HrO+T
X-Gm-Gg: AeBDieubE29vDdYP7NSsMJUmseJiZTC6Gw8vhEVPP/I21+ATZSyvdb/UCe3NZgYlC0k
 g0/YGGRC8soWUWGdr81kVTmluTQ6Yj/BVMBm+lfSn+V81yB6ME872/XCYH91DexQsR65GXi5U3Z
 1sk5h2Mkzcpe9qbU0XccjqvBn4zdJQBXU7NCJS8nQNnbzLvPQFoVvJYUN7fLSoc8JYA8HO4aCQg
 PiF90ZiaEzWoqjUxZ1Ge+sn4ElM2LrakuoGjjNy074jJSiMm+psRSsQbjLh/PTn1Jy+Fz6/OdOp
 cRkofs1gJrzXpAmOn3qdXFzBeNsXfI8SmfgU/MOau/XWbAH4wVHi8MqrK74dDkFVeKED/9uKqCy
 wPZ7T08HFUVZIffRSzolGC0enHCYu2Wkhl4+xqO0Yb8fP9y8N0fSZ01oYcKRfnJ5dzAscollTQE
 bpytT9rrPPJSrRIl35+2Cftz9Jz24=
X-Received: by 2002:a05:600c:47d3:b0:48d:c0a:3813 with SMTP id
 5b1f17b1804b1-48e51e0bb62mr138586055e9.3.1778260815906; 
 Fri, 08 May 2026 10:20:15 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:e47d:4cf0:1918:bbbd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6dd2c550sm9516965e9.3.2026.05.08.10.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 10:20:15 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Fri, 08 May 2026 18:20:12 +0100
Subject: [PATCH 1/3] boot.S: Allocate minimal space for granule protection
 tables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-jmac-gpctest-v1-1-e57e42c87e1e@linaro.org>
References: <20260508-jmac-gpctest-v1-0-e57e42c87e1e@linaro.org>
In-Reply-To: <20260508-jmac-gpctest-v1-0-e57e42c87e1e@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x333.google.com
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

Allocates the minimum required space for granule protection tables,
8 bytes for stage 0 and 512KB for stage 1.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 tests/tcg/aarch64/system/boot.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/tcg/aarch64/system/boot.S b/tests/tcg/aarch64/system/boot.S
index 8bfa4e4efc..ffcb9a2140 100644
--- a/tests/tcg/aarch64/system/boot.S
+++ b/tests/tcg/aarch64/system/boot.S
@@ -404,6 +404,16 @@ ttb_stage2:
 	.space	4096, 0
 
 	.align	12
+	.global realms_gpt0
+	/* GPT stage 0 table */
+realms_gpt0:
+	.space 4096, 0
+	.align 17
+	.global realms_gpt1
+	/* GPT stage 1 table, initialised to all 0xFF (full access) */
+realms_gpt1:
+	.space 524288, 0xFF
+	.align 12
 system_stack:
 	.space 4096, 0
 system_stack_end:

-- 
2.43.0



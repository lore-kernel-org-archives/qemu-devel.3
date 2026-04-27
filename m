Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E7FFF8862
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLQl-0002Wj-5f; Mon, 27 Apr 2026 08:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO4-0008BK-Q1
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:35 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNw-0005iu-JD
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:27 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so87216145e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294099; x=1777898899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JQoy/74+JPqjK/uUVejtPxwT3Exjei52SuJo0vtd7fU=;
 b=IAzFu4wYMgNRepkYbo/lSk/V/cciBzJ8iLWm/A6Wvrt1T7aNVQmcBLjkv3VBhUa9dC
 f4vr9D9Pl5JaV/tlUO1Xkkai2pBqXx1SszdZ4xOk4PlEkRaz09B3R+olw8E+kC4A7OMP
 YXNkTM1ZvGWu5RRhgSjwOYPO3bv7Jb+9QCXsY+OJhYzNPQIP0utgV4ALUOGrPCL/vfME
 6OGQwiixYWsJ2QPynaBuP+xF+/GEGN0zKCXBZ7MNmC3QUjWxUVWkrnCGAoskqjDih+p4
 NTCoZSGOduoVk0R/hOLZQFBRJe5FvaqZZuBL7IxuGR0S3NbP5O9fSIIf7NDvmIwHwNn3
 mi3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294099; x=1777898899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JQoy/74+JPqjK/uUVejtPxwT3Exjei52SuJo0vtd7fU=;
 b=YtEHiuph1uVPhf5vj4/SFZF6tdlEcdQ/f+O0UviwyqBgde6XtW88+mIJbVzU5yAZQ4
 WQqILPWPHcpNHbBJcXTXrpB1jERh+4O0PKhyKqSQUZXqVUMMrVkABkdBQqnrtkmV6a3y
 V6fmQVYjeGgeh4t/NAOG9ve2WzG0CEmBjbUrqC+e3gtkPdbn/3yaMHE2r5TEN+Q4UcCt
 uzCJE0WyLnaezuuScrJGACMGeF+g9rdAcZUAUv1t4SwoHuOGUbWeIINfDVSDRj88MrBg
 GHaGHTEm+GQnozkPpyi6M7s0jhAqQr8wuD1kqE6UninaoZMnLNhaBmz9rXIR6vpdw643
 Rm9g==
X-Gm-Message-State: AOJu0Ywm0mR0/Q1/ETzyza0O3HFoPN6JGaYJVV0b6a/z3k71y+tvEP+3
 iNxdEXBFcp+kIf6cksAfqhQWNsv0treRHMMU5dszt6l2XUa4Va06/42tE0BS5lE24lCAmJd5KTZ
 HkQJ2
X-Gm-Gg: AeBDietJu9/nd4XdRezsoj3qnHacMTCktGrob20oVpbmXPIfLJiBeFTK5VKXsiRndFu
 HFaplOXO7KkE+RjTS5Qw1Ul6vjhQmyIVFRHk/5UoZvU2bVgPsenbRP1JCAu5hG3wiYeueUf1e6d
 6Tv13bWmL5X6pWxVnynY61IDV0EPXCy/jutLCqsVZZfWCnVzTs1Bd4dcL4z/LAKjEYlPwA1STVb
 smtmmNbA3tK+GHKXgxs+rJtD19HL7LYAKdJzW9DiQ7S1d8trgWgcOS8oyJ4Tq9ZTsSOADjhRZxk
 v1ZaAYKDGqB1Dr6UbNd6WtEZ4FqaFtwUuXyNN0d+K/pDYhREwmxZrme+1Lkz86YrQ1nJ3sTl+Ig
 8cdasxgIuiq7AonT2VXFR0tWkzZmfPo3LgH/UizMOq+KgZ2T/IMtoobxNcz1hDixfHnUq1Raw5V
 XDGSEvpsbkmZn7HMmLT6DCNbgJ1kAlVgSGVSu4GWK/a7E2SGtGQjxF85YwDeqSuBkSiabX6SRJa
 TMXFzQ1CiTIY/+6Pz/k1tU+PI9tbiHYUK4dTgnvKSGZewZZrHXe
X-Received: by 2002:a05:600c:3423:b0:488:fd7e:1063 with SMTP id
 5b1f17b1804b1-488fd7e1253mr331897105e9.29.1777294099441; 
 Mon, 27 Apr 2026 05:48:19 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/63] target/arm: migrate FP/SIMD trap syndromes to
 registerfields
Date: Mon, 27 Apr 2026 13:47:17 +0100
Message-ID: <20260427124738.966578-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

The syn_simd_access trap was never used so remove it. We should only
see the COPROC encoding on v7 architectures.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260422125250.1303100-4-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/syndrome.h | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 29462aa103..72051443d5 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -337,21 +337,26 @@ static inline uint32_t syn_cp15_rrt_trap(int cv, int cond, int opc1, int crm,
     return res;
 }
 
+/*
+ * ISS encoding for an exception from an access to a register of
+ * instruction resulting from the FPEN or TFP traps.
+ */
+FIELD(FP_ISS, COPROC, 0, 4) /* ARMv7 only */
+FIELD(FP_ISS, COND, 20, 4)
+FIELD(FP_ISS, CV, 24, 1)
+
 static inline uint32_t syn_fp_access_trap(int cv, int cond, bool is_16bit,
                                           int coproc)
 {
     /* AArch32 FP trap or any AArch64 FP/SIMD trap: TA == 0 */
-    return (EC_ADVSIMDFPACCESSTRAP << ARM_EL_EC_SHIFT)
-        | (is_16bit ? 0 : ARM_EL_IL)
-        | (cv << 24) | (cond << 20) | coproc;
-}
+    uint32_t res = syn_set_ec(0, EC_ADVSIMDFPACCESSTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
 
-static inline uint32_t syn_simd_access_trap(int cv, int cond, bool is_16bit)
-{
-    /* AArch32 SIMD trap: TA == 1 coproc == 0 */
-    return (EC_ADVSIMDFPACCESSTRAP << ARM_EL_EC_SHIFT)
-        | (is_16bit ? 0 : ARM_EL_IL)
-        | (cv << 24) | (cond << 20) | (1 << 5);
+    res = FIELD_DP32(res, FP_ISS, CV, cv);
+    res = FIELD_DP32(res, FP_ISS, COND, cond);
+    res = FIELD_DP32(res, FP_ISS, COPROC, coproc);
+
+    return res;
 }
 
 static inline uint32_t syn_sve_access_trap(void)
-- 
2.43.0



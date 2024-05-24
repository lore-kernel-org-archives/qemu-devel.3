Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9FEC25B7A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeEA-0006RD-5f; Fri, 24 May 2024 19:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeE7-0006Of-5B
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:32 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeE5-0005hu-63
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:30 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-681907aebebso1037775a12.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716592888; x=1717197688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qjg0N9d1UiR78WeGkTTMqX2tHTL3eVpJWXsbVAhKPqc=;
 b=vEdndpfNXdSLolIRiwW8rs8U2X0QWDjmrZADLvwF9Enr2yqjJPjZAvsQQdFsHqTzKE
 TwuT9k8LlXgM3J5CZwmow6muZmRGUObcqpOIjDb6oChFk0jI+KNnAD+vLTwyclxLLlbZ
 xehqMDjHZu25gabmslehW+Pn2kMtUt2zs3N9QRleCFQHYaO5DnT9Wx1j8mI6cSeHVvjt
 jKwIWRambVj0kgs/cHzZkunMdArxDV3Oyr/7ZzCSqF642ijIAUjILHPUcYYWbLr1cblK
 d2713FnamlChCuJDM2L22RZNGVMnaqrB3h29tEB21p2k7M1q5Y+rQowZnwqpMiIf+mW2
 klIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716592888; x=1717197688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qjg0N9d1UiR78WeGkTTMqX2tHTL3eVpJWXsbVAhKPqc=;
 b=X89hC8Xxy3/5gZ14hgwjEzDHwOuKSzu28/+RDnZz7HboInX0TZ9IxY536SZ2F2h3o4
 lwHJ1crq4f4ydZoU6Q0N7r7bapUpxye8KgA8PVcxzh14oZVC1t/5UsdF/tws4o6ZwP1a
 U+Kt9oEnL+oAUSR5FnBIH5PaLy49Q5a2U1ddbS7vs/Vs6I5bHqNtCQrJgC0PQxNWbSXA
 JuotHc0elOt7Wws3FaYOG7UB1jz4/Ank7mdLNvy2eKNTJkm+7XD/Y+XLQKoaTtEvGch9
 IxpVVG0VGVGDEO8NPxSMchgpwRiWvoujsSdDnbKfM4W04wLKRGyGDDUWfHSNU+orQvWZ
 OYyQ==
X-Gm-Message-State: AOJu0YwmlAS5uiyrzQiB+X5Fg8vO1aHnVNaWJMRXi2RLW+WGogRBh5Xr
 k5piA4ZfvpdXMP/Hl0B8Cjrkd0NMXiEugJ//jaXlo2lyMTKiQh0Oui97Eylvbd5LVCH9NuFTA+w
 n
X-Google-Smtp-Source: AGHT+IEESw3lq3PynrbdWw9/HheQTe2VanrU7kf6L3edjSnT36ekIyMLUiRxMMy2TnhsRr3pArdObg==
X-Received: by 2002:a17:902:db11:b0:1f4:5c4b:dc6b with SMTP id
 d9443c01a7336-1f45c4be9d5mr24810025ad.47.1716592887707; 
 Fri, 24 May 2024 16:21:27 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c759ceesm19178305ad.10.2024.05.24.16.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:21:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 06/67] target/arm: Verify sz=0 for Advanced SIMD scalar
 pairwise (fp16)
Date: Fri, 24 May 2024 16:20:20 -0700
Message-Id: <20240524232121.284515-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

All of these insns have "if sz == '1' then UNDEFINED" in their pseudocode.
Fixes a RISU miscompare for invalid insn 0x5ef0c87a.

Fixes: 5c36d89567c ("arm/translate-a64: add all FP16 ops in simd_scalar_pairwise")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5455ae3685..0bdddb8517 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8006,7 +8006,7 @@ static void disas_simd_scalar_pairwise(DisasContext *s, uint32_t insn)
     case 0x2f: /* FMINP */
         /* FP op, size[0] is 32 or 64 bit*/
         if (!u) {
-            if (!dc_isar_feature(aa64_fp16, s)) {
+            if ((size & 1) || !dc_isar_feature(aa64_fp16, s)) {
                 unallocated_encoding(s);
                 return;
             } else {
-- 
2.34.1



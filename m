Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21224C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2ubI-0005nP-UR; Fri, 03 May 2024 11:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2ubE-0005js-9o
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:13:25 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2ubB-00075T-Im
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:13:24 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1e5c7d087e1so80051375ad.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714749200; x=1715354000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RPMJ9Fq7Hagw2E+aglC+ITwqURcRV1FccXRLb5FLQFU=;
 b=xqMN0+92TlmXuJGGogFlVfpExHPOiiw3S3BMIqq9X5Cw7mI4fC2To0ZbE59wVLIeZZ
 D9CbH1RNsHdVE9riIZFjjWyCR2/oTQ2iVkJKdm1+UXMsdULZZfVDtFn+Xy2Z6rMQ/cEv
 GwyLUBJFexZJvA/hdyIRCThcbGw9ReBFrLs3W7r9bC+xJLo9VtLc0J/5CqyjLeOKP2rW
 LQVY3H0SDUFgExEVHyySnVRPfk9BTFWsLgcIz62xB4ZEbPq0SWSbQEdeje3ybmvwtCwY
 glCz39W3x+1wY5xamsr/QAm1neov/B8f9O1G91I0LAt9KT8VuEj8X2KG3j2ZlJuQ958A
 WdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714749200; x=1715354000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RPMJ9Fq7Hagw2E+aglC+ITwqURcRV1FccXRLb5FLQFU=;
 b=itF0BiPxW1MkcuCP437HaGubivxisGew5XYsFlMZHGHRTnMa/EcS15XA2bbtZVT1lT
 FLjwFugmN3erVCu5IwxzJS/q9xSUH913Pa6dqZ+Wlx3Egdp9//rGuLBIGsy36s2s7s7M
 EJQaklrDLqihCeGhzSHD4viH2nnU+eHNW/p+7HdhDjtKcV8Xzl30FedVmiZCfly/pO0y
 ld8r+A8RERR0jhZ0c96f0EjAK0aOss1ufm+Xb0g9toRY1thWntV8YbyWauRCllWGdd8X
 mnIhmHwuwEXPZxxLa3kFJqn4Badaegzihjsn/peTJPQlGsEU9Jn1ZWMC9HA/D8ZQFvfy
 p9tA==
X-Gm-Message-State: AOJu0YwIkw5BVD0nkH59PZ/laHN66ToYWKPHMNgDHyHg7g93eCaSdVW1
 ct1VWuqL1MCPEn+bE+1b4ixg6rFEVP8qz0JP3C9eBiWtCL/9ljRHtq1uKnLCf8eyVRH8TyuNkTH
 s
X-Google-Smtp-Source: AGHT+IELNnEjz/zZNRaYVV4/ef0T9UqiTKF8aYggfcgL6a2obiYBio8TppBi2bT/luxzOQ4xlHy/7w==
X-Received: by 2002:a17:903:2b07:b0:1e4:c8b3:dbaf with SMTP id
 mc7-20020a1709032b0700b001e4c8b3dbafmr3106172plb.33.1714749200063; 
 Fri, 03 May 2024 08:13:20 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 p10-20020a170902c70a00b001e81c778784sm3366611plp.67.2024.05.03.08.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 08:13:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Monakov <amonakov@ispras.ru>,
 Mikhail Romanov <mmromanov@ispras.ru>
Subject: [PULL 04/10] util/bufferiszero: Remove useless prefetches
Date: Fri,  3 May 2024 08:13:08 -0700
Message-Id: <20240503151314.336357-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240503151314.336357-1-richard.henderson@linaro.org>
References: <20240503151314.336357-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

From: Alexander Monakov <amonakov@ispras.ru>

Use of prefetching in bufferiszero.c is quite questionable:

- prefetches are issued just a few CPU cycles before the corresponding
  line would be hit by demand loads;

- they are done for simple access patterns, i.e. where hardware
  prefetchers can perform better;

- they compete for load ports in loops that should be limited by load
  port throughput rather than ALU throughput.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Signed-off-by: Mikhail Romanov <mmromanov@ispras.ru>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240206204809.9859-5-amonakov@ispras.ru>
---
 util/bufferiszero.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 972f394cbd..00118d649e 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -50,7 +50,6 @@ static bool buffer_is_zero_integer(const void *buf, size_t len)
         const uint64_t *e = (uint64_t *)(((uintptr_t)buf + len) & -8);
 
         for (; p + 8 <= e; p += 8) {
-            __builtin_prefetch(p + 8);
             if (t) {
                 return false;
             }
@@ -80,7 +79,6 @@ buffer_zero_sse2(const void *buf, size_t len)
 
     /* Loop over 16-byte aligned blocks of 64.  */
     while (likely(p <= e)) {
-        __builtin_prefetch(p);
         t = _mm_cmpeq_epi8(t, zero);
         if (unlikely(_mm_movemask_epi8(t) != 0xFFFF)) {
             return false;
@@ -111,7 +109,6 @@ buffer_zero_avx2(const void *buf, size_t len)
 
     /* Loop over 32-byte aligned blocks of 128.  */
     while (p <= e) {
-        __builtin_prefetch(p);
         if (unlikely(!_mm256_testz_si256(t, t))) {
             return false;
         }
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717E5C44501
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 20:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whCs2-0004OU-Fo; Tue, 07 Jul 2026 16:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1whCry-0004MF-TW
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 16:58:18 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1whCrx-0003Td-CR
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 16:58:18 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2c6b67d5fa1so177935ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783457896; x=1784062696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yjtxehokH/ej11h4Z6W3EWTYi+9mWUSrSkuq/wcNtMg=;
 b=hCmL4fGhQ3Uly84wXlpLRo0Je3qft9PZZ6Bf3nQL1tk9YilcH4qFc5umbt0dCrKBba
 PDAni8Ca4/1rrXHjg20PV94LmhznnrwzFHghrq5wJYQY5U9XXdbgMi9HQdvR2SOXSISM
 MGk9bxq/CvSTpUprZV0R0q67OTP4+VV07Nn+N6TB76p4NcBKW7hrg1R9xJFQpdQQ8XX6
 EXwCpgUX/U9nyjpjja5Iddy3RKR7iv7voVHaFQrNVmW4PeoTYaenUQ535O7UGulJQIj7
 Vbo+ZlTP1FXpEH15BviuLBqnO94Rzkjd4gYJJP4/Ne1JzzCn26Zc9ZS20LKKa7ycKbjW
 mBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783457896; x=1784062696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yjtxehokH/ej11h4Z6W3EWTYi+9mWUSrSkuq/wcNtMg=;
 b=ZSbNGMiUKgzveL13HRhYLRnwf7zf4Sgxu+aYHPLPQjtyw2+BW5+zDXyqcdaYHbFJxE
 11MgsSCbJA/s796N33GGSYCGBIzbng0Jx0XtwsN4r5Gq0CTubWsUZu8lrWk5dmCNQdI6
 QuSIm5ypeKpekkNbODFG/jywtk+EebBCNmrWg5YCc4U5KpIAdf3fQXopAc2xkK4TxUYU
 Eq1JrBP3cANFjeaiaiOtkdYNjPXs30C2JftirzLwNahxEt6DJxRlxltMemK5Of1bNAhD
 TKFSmWdecjoG9I/cemLMXWXajvG7YLQooeW7JWPa+/+LEU5IzlaQUsO7+2UnC56XTYYC
 OCCg==
X-Gm-Message-State: AOJu0YwwXqfPrqeZfO9ZxdBxJINSLlWmDpCJHzIXfNPR4uM3DxkDDbxn
 e2GmggZsCHatF2oRyEHoH429chXHSNDcPqyL1Fz9EzLa5RXQkK2E5z4WdP0G8vYotEODMWCDkid
 HGIVD
X-Gm-Gg: AfdE7clkIM2IhcCtJ+JoPgDRM8FjWM38UxRHFR91Q8moKP8uYdJshNlyI5fMSZyHFwV
 xmA4o7Qp8d26R1XOKOkuvSb7kz0FgzmWqWUyD/vzM2OCgrbW56yySy8kgLD1DE7NeGROk7U0kIs
 l4q69d1Necz+g4Y1+54ZoluGI0t2TMsCKBl8m93VKXEDp7LqbM/X2u+olY3Dnzs5psModNe0X2F
 2AAF4FWfIK/yI8DYNGgudvjSZIXUyuXnMn67VUTJksAN59o3qPn+fYQTPOh8a5zswq3eRup/L2v
 KtXkHCDck/TUUZnKDw3gar6Eh2JfLquGsf5u5zvqGNewWnZwh37NhJg1uYZBXyvZ0CgivF70mpa
 0b9NYgBSUXDugJFxro3rbrklaDlciy3DrHiE5EoaAy1a02gYa7ZT6mEdZQJ90n9lWDkxPNSQgNm
 fxQKc9N4hAH1CqI82x13NjexRId+5EPosSkGFSAxPv0lM312I=
X-Received: by 2002:a17:903:3d0d:b0:2ca:53e9:1277 with SMTP id
 d9443c01a7336-2ccbe3fea24mr65683765ad.1.1783457895850; 
 Tue, 07 Jul 2026 13:58:15 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bc2asm17980575ad.69.2026.07.07.13.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 13:58:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 3/6] tests/tcg/multiarch: Improve mutator randomness
Date: Tue,  7 Jul 2026 13:58:07 -0700
Message-ID: <20260707205810.303376-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707205810.303376-1-richard.henderson@linaro.org>
References: <20260707205810.303376-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Currently mutators perform the same actions, because the RNG seed is
derived from the current time in seconds. Mix in thread ID.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260706165445.57418-3-iii@linux.ibm.com>
---
 tests/tcg/multiarch/vma-pthread.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/multiarch/vma-pthread.c b/tests/tcg/multiarch/vma-pthread.c
index 7045da08fc..0b8ce9751b 100644
--- a/tests/tcg/multiarch/vma-pthread.c
+++ b/tests/tcg/multiarch/vma-pthread.c
@@ -11,6 +11,7 @@
  * pages, which are guaranteed to have the respective protection bit set.
  * Two mutator threads change the non-fixed protection bits randomly.
  */
+#define _GNU_SOURCE
 #include <assert.h>
 #include <fcntl.h>
 #include <pthread.h>
@@ -121,7 +122,7 @@ static void *thread_mutate(void *arg)
     unsigned int seed;
     int prot, ret;
 
-    seed = (unsigned int)time(NULL);
+    seed = (unsigned int)time(NULL) + (unsigned int)gettid();
     for (i = 0; i < 10000; i++) {
         start_idx = rand_r(&seed) & PAGE_IDX_MASK;
         end_idx = rand_r(&seed) & PAGE_IDX_MASK;
-- 
2.43.0



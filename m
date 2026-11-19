Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24862606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zMPJiPkv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU66K-0003Gs-OC; Thu, 19 Nov 2026 12:39:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xU66I-0003GZ-5o
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 12:39:10 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xU66G-0006mX-5F
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 12:39:09 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3ae691283ecso747032a91.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 09:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795109946; x=1795714746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tLGOLZGzP2NNmhhET7Tc3wrwamnviEiQU1dJZzQdUDQ=;
 b=zMPJiPkvDTCUqGIXexF5Ni+rbLLQuNTrzVnWKO62GJrwPluzCjCzYzZDBAlHNnpyIi
 gX2LAjUa8qUjrANRGXhzkwuAP000kzzzA8Pe3LC1w26cpPM+2wWTV7y8hNHe7IIORl1/
 Lzcgup6L48YzHpdwpinHyCfBWCub3Gh1WY6ur3elghSv7H4jL5OB4c+i5qYVMjWKcSyS
 ++geCp0ndh/iHtfU7sicNoBw1HiooM/R4Cq/q4dqQi3pjaWtuCDCIKXTVSOasUrELwV1
 aG99tAWbkUozDDNsI8K32YePq/cFvY1Fco36Tl5LucmOz66Jm9Tc1pqjK7YqOUwxwnzF
 ieqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795109946; x=1795714746;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tLGOLZGzP2NNmhhET7Tc3wrwamnviEiQU1dJZzQdUDQ=;
 b=a2p79UpnLJHbHEN03C8JLfjqGlBadihr5Vx8O3MshrvOiXVRhtOdqEoY4MTeWu+Re9
 4cxG+gAsiQTLSf1zzA+sFKmC9cCx5m3pIuzpAIKs7rwj9QiDaLMj2/59zmaEE9rJQCov
 JgNJpJBzY6zy8AaDgVFCeUSjM2jDIJRYQKp6CT+QFkV1QFegMwY+xbH7ART0zXaHwdxz
 esshrg3pRp94pmgMd0HTaEbdk2INHrPWAU7r4+0N5b5npA5uc9I9YToDoF5QWysH3qic
 +42SIWwR0jPE1ylnzrGDyt71MpMunDObRfpJPAZ6TZDFVuL+PnNlQcQdSzhjxDWYM/YA
 UTnA==
X-Gm-Message-State: APuU4Z8Cjq5JEI91k2AwUBN142h/LxbJAsl2j/Af8v8lnuNXpgu0wQpa
 qZcu0PteuaTkzjbwLp1lv/FwoM3Ub7njflKycSqZvkkGCE4ORAa5NrylfJFBVWF78hICqtUEn1g
 GWE/o
X-Gm-Gg: AZFdTZdTHrono2x7FUuDU460ocTr7cU0strhKRWlZb4MbfVxvQoHtLJLlMmY7qmiq1R
 NT2x8yizykda6qO4T1PPcXwVaAuAeO59pRvvzP4hx3NLnjopRgkgQkzxpsQPsbwyaXkAcBj2gB1
 nT3im5+nUgwRzguv3KhM4UUtB8JRhSYTAri17qzzg8C+wLOzIqwKmEvHVZxD+DPuH0Bb++dhmT3
 L5RcIEuxH5abkQwIWee2CpOfghl4bgEXA977LSxYdUzV1KC34fn+v7E3EfFjNOh0cbbl8qEr04+
 GM3BS/o4PEWuZWvV5rvBQNkGg2knk1FhO8ZYV1plvep85Wn+5dl+1MyZiBDXEfl23TBEBI+dhbq
 EDlnnNjXDz6NSy81a7OOXW7rvCQBokEmOHKRo7h/hDCR+PGsPEay5yMRCfqt+oaX4yd9rwQK8ZI
 S3mUIR9EMaWBUwYu8t8B1b0MGx8jxKeHgwQNcrkJpHa2jyYjLpq9LMkUi4ZkrrKyKwDRsZ128AQ
 Z4fW4iX14Xgxw3C4HANCiYMmuwzBrtWjekMZl//2f0KtqHo5K5TauBivbnT/Np1OuRgiY48lwQ/
 YsDDqjwMVO4wI36JKLQoYxlNrXNjUIhxRk28nYqZx/a+b7S/jvrzKPRuK3OD
X-Received: by 2002:a17:90b:5407:b0:3ac:9ad9:6afe with SMTP id
 98e67ed59e1d1-3b41c961ed9mr42880a91.39.1795109945940; 
 Thu, 19 Nov 2026 09:39:05 -0800 (PST)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405d97356sm3392176a91.13.2026.11.19.09.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 09:39:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH] tests/tcg/i386: Add -msse to test-i386-blendv.c build
Date: Thu, 19 Nov 2026 09:39:04 -0800
Message-ID: <20261119173904.358593-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fixes: 0f9a4145bf5 ("target/i386/tcg: reject VEX encodings of PBLENDVB, BLENDVPS and BLENDVPD")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/i386/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
index d2ba841041..34fa9e4a94 100644
--- a/tests/tcg/i386/meson.build
+++ b/tests/tcg/i386/meson.build
@@ -10,7 +10,7 @@ tests += {
   },
   'test-aes.c': {'cflags': ['-O1', '-msse2', '-maes']},
   'test-i386-adcox.c': {'cflags': ['-O2']},
-  'test-i386-blendv.c': {},
+  'test-i386-blendv.c': {'cflags': ['-msse']},
   'test-i386-bmi2.c': {'cflags': ['-O2', '-fwrapv']},
   'test-i386-f2xm1.c': {},
   'test-i386-fbstp.c': {},
-- 
2.53.0



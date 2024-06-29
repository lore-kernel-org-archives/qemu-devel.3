Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341D4C27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 08:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNTt8-00074q-55; Sat, 29 Jun 2024 04:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNTt6-00074I-S3
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 04:56:52 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNTt5-0008Hc-EW
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 04:56:52 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70699b6afddso1039126b3a.1
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2024 01:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719651410; x=1720256210;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dvwHZtwHDPRaG3dVuQgy23JMNhHjLIMs4Cye8IEDdJM=;
 b=AQ19y02+Yh451Dan5H+gN+s3n4Xor0oI6ObrVObbCTORIxZ25FZbdKDShbmzMk95u0
 BnATpyexUP0bs/O8v6R0ocRRuZp7dzK8mTNJj+tSoQLZfFh3HUmPiQN2IaCtcPUB53+e
 qbs20s+ZVll1ATtVpKW+sm4VAP6UZcLD7PbcGnJguQjAhYkALeVpB0W3IuOlIFcuymFe
 uk3WADElV8ujhXEgsmUDiVhVRWH0p3IXTmOnvSUuzubzSWv3TJ4ffQlB0KsglqOt1JdB
 2QxEWbCg8Jf1SMrF3pCOCWAxE/4vUjOQAChieEWEptTzjGukgyQarRXyl9+IObzonFsw
 DHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719651410; x=1720256210;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dvwHZtwHDPRaG3dVuQgy23JMNhHjLIMs4Cye8IEDdJM=;
 b=ZOBz8RnrFQEXIrkP7eQKFFShTeLEwEuw7IcUcuqD6f2HIXq1xUNkHlxyoyvT1AYGV7
 bd8woH38pAF4fcoQ/C/9T7fUUj/N2Zvm9QA0tWclc+uGd/hok9cfE2HNCjGpYLeY8UXw
 Cf0jyal1REMlQvGN+h4Vx8IiLJUoTiB+IqBXc33wesO+PRXe91WyreW5PfHCeFZYiIxt
 GL9hUUfreFBKkmCCNB9o1jJaeCuzo0jemJGquImdM7NIAqC1/oH1X56Emdy/T1P161kT
 F1nebW4CiIuLrzTAtb5OclrQwvNKE+OOoCN7vik7Oz7QO4+0NCKoVt2Z5Lf8ALtfVmJg
 b68g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3ArL9lbKmXCgSOoMC3MRcZJsmL8pK/fRKwPOlcoX9vHQfp7yapFMspqPb6CfwlejbNPUEWPyhSE2301M4Ni8fer56ig0=
X-Gm-Message-State: AOJu0Yw4lf5ZIu8TwgU1pyGnrxKM2lnNi+aQ9ayn7gq5C0M2HhR3dX7v
 swAfVQVxa0e9DV45tzRq6WP1dxLETdoA70FPqVNYkDY5ZeEHU07r/8YDk2Wy2gDSVTIcX6wtQiN
 LrDw=
X-Google-Smtp-Source: AGHT+IFv7q4gHPpZqqjzCZecpmUzinT3eBEBuzr2MDEq59CyiqWjuLAat3tH5lcEzNQaVdEAsPdAfQ==
X-Received: by 2002:a05:6a20:258a:b0:1be:c3c1:7be8 with SMTP id
 adf61e73a8af0-1bef61407bbmr560357637.26.1719651409881; 
 Sat, 29 Jun 2024 01:56:49 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fac1549e59sm28757325ad.179.2024.06.29.01.56.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jun 2024 01:56:49 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 29 Jun 2024 17:56:31 +0900
Subject: [PATCH v3 5/7] tests/tcg/aarch64: Fix irg operand type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240629-tcg-v3-5-fa57918bdf09@daynix.com>
References: <20240629-tcg-v3-0-fa57918bdf09@daynix.com>
In-Reply-To: <20240629-tcg-v3-0-fa57918bdf09@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::433;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

irg expects 64-bit integers. Passing a 32-bit integer results in
compilation failure with clang version 18.1.6.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/mte-1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/aarch64/mte-1.c b/tests/tcg/aarch64/mte-1.c
index 88dcd617addc..146cad4a0499 100644
--- a/tests/tcg/aarch64/mte-1.c
+++ b/tests/tcg/aarch64/mte-1.c
@@ -15,7 +15,7 @@ int main(int ac, char **av)
     enable_mte(PR_MTE_TCF_NONE);
     p0 = alloc_mte_mem(sizeof(*p0));
 
-    asm("irg %0,%1,%2" : "=r"(p1) : "r"(p0), "r"(1));
+    asm("irg %0,%1,%2" : "=r"(p1) : "r"(p0), "r"(1l));
     assert(p1 != p0);
     asm("subp %0,%1,%2" : "=r"(c) : "r"(p0), "r"(p1));
     assert(c == 0);

-- 
2.45.2



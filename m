Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D6BCA5FE1
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhat8-0001V1-Av; Sun, 18 Jan 2026 17:04:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhat4-00011A-N3
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:04:46 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhat3-0000VD-8p
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:04:46 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-29f1bc40b35so38102975ad.2
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773884; x=1769378684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cwGPpfxzsG4LOsiRJ3NVV7jG3uJ4HK6BFewRFRnb1bM=;
 b=L68JrP6Ie+SOKS2bFMK18qD6m0VhVgwWvAs47ZSca1ieY3/2IN883v2Zu/04baHEYJ
 WCwyA1uZb8Il9cbnnz6DUr5fTai1SFLmQM0f/zaYXZPxe13roNva5OcvNVMl1o73YyLT
 bDa+kavzVQB4G1tXW0wnuwgQtZBNOoc8XpGKVSk+LZ3PCZ32XIb1j5tuWjQRuZy9gBka
 Mm7qgyQ2bvLBs17NJcrsgl6S88Lbp1FTo5CMEX18PC1SpFEJyWtVoH9QvPhKmz6iTZLy
 irK3wc5/IHF/K7bH8zlXsS4vNVQkE6o3BHlIudGrx+UM84m71nJ2tkXCj0pYAodtW2Xv
 hhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773884; x=1769378684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cwGPpfxzsG4LOsiRJ3NVV7jG3uJ4HK6BFewRFRnb1bM=;
 b=ZpWCkQcv7onP139jaa1XdcO1o8estTivQp5ClM51OLMPbvGhOIcHcl7NsX/v+DxWuM
 M0kaQSdWQhpfK7H18MOC5bORF4yQ3K/INGikyxciky9gC7ylQ6pFpYcm5PkV5w1kKIIS
 PAPqWCa2x3xtTPMEnSHLsoR1d8wqJKpQ5QvZKi4vWtkaowqFepkK5VEfe0ts2vupVVtd
 pPgG5xLE910fx3D3RJJIJ7iUVjbU1oPuA44zPLY1TRFGNkz7WsaWnp8henJeYUKq16nB
 xr0w0FK1kVpjlZ9igTIHbgUEBBFw79oZul1j6aotbz2vneqBYCXOYp3H54Qymu3FleT9
 FLqQ==
X-Gm-Message-State: AOJu0Yw4gkaOQ2ba+YzhAjWOfXAQA924WAQCrBKdwMZhxeQb/pJVyDe8
 MFUt129LwgyhPyC5Va3mKleVDGS47Hs6Ixh8ifGW8Z8LYvMJyvclGV9+4FrDwuiQdzZuImIrKeH
 IrVUEu5R3Kg==
X-Gm-Gg: AY/fxX5QmBNSNywghv2bGQvaySj5fRyPThPLjLN9d913gfxLYDBtLTg0S5IASaR4rp0
 gaIckilBxGD4WfS/+M2dt7lQzR+2K6UO2W6PlBmgf2BOYEm/42r3ToX599uu5tr5FAkyIcKa7iS
 0TZhp0wE1l1NMyuOT47SN01+626dz1FCN/cD8jL5BvHQV1GPeJ3Rl4+RShxRtNZaJtPJLqDiudy
 yTaYadu4p3tYy9k8sfO2mw5lBEIQl4+BWm+cwe/pYr6yK57lZtvqTL5gZXh/XHo2dOyvDJs1eQX
 1KWHT46698/oHOePMftGlexhhEbWDWnRvPF8hP0PhkQfV59UVz+hvk5jSKP9fAfVftdXbW9df+P
 PBc+F0/xmih9YiZ52cOSKkJ/VvzP2o32mAOv3LeTYKeU+DadN304lNbmPYelN41QZfzcQtpX17f
 tbVQKkGqSYIKRU9gJTaQ==
X-Received: by 2002:a17:902:ce0a:b0:2a3:e7b6:ab53 with SMTP id
 d9443c01a7336-2a717554c25mr93798745ad.22.1768773883744; 
 Sun, 18 Jan 2026 14:04:43 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb74sm74402865ad.56.2026.01.18.14.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:04:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 10/54] host/include/x86_64/bufferiszero: Remove no SSE2 fallback
Date: Mon, 19 Jan 2026 09:03:30 +1100
Message-ID: <20260118220414.8177-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Since x86_64 always has SSE2, we can remove the fallback
that was present for i686.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/x86_64/host/bufferiszero.c.inc | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/host/include/x86_64/host/bufferiszero.c.inc b/host/include/x86_64/host/bufferiszero.c.inc
index 74ae98580f..7e9d896a8d 100644
--- a/host/include/x86_64/host/bufferiszero.c.inc
+++ b/host/include/x86_64/host/bufferiszero.c.inc
@@ -3,7 +3,6 @@
  * buffer_is_zero acceleration, x86 version.
  */
 
-#if defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
 #include <immintrin.h>
 
 /* Helper for preventing the compiler from reassociating
@@ -119,7 +118,3 @@ static unsigned best_accel(void)
 #endif
     return info & CPUINFO_SSE2 ? 1 : 0;
 }
-
-#else
-# include "host/include/generic/host/bufferiszero.c.inc"
-#endif
-- 
2.43.0



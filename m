Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D2DE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBAz-0004Ib-4z; Tue, 24 Dec 2024 15:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBAH-00032U-4u
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:06:01 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBAF-0002eX-OG
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:06:00 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21683192bf9so61844775ad.3
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070758; x=1735675558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BQkzcdNzyFSe25Uj6LgRouwEG7p0lTXXdxR16Ve6oxQ=;
 b=NCkHWIK7DrSu01sUQ0JRCv9jgCZyJ6R3JUX5oJcIn1KB9US/EtDO8e2yYceI/xIYrY
 25QgfSxI3HYw3NYlQKE5upeKNTOCvSY1UeAvnj4WfvwDCLZyF8S9JYMOIy4T9YIMxP7d
 Owg1BV8Z/kWL4zTB9gw2dCUIf6cvc7qG8iBTQ/37tJZynFvfuk5GXXs2TxQ9/1C7g/Dp
 MVLwLYSxDoNa3pcEcSdRWPfnMuJHYoczLWrd6nlTM9rkVVnoi4gErJ6Vfru87JxhQ9bX
 FUfaS/rp3IojAvjL/XGNbhiH24MoeN3n1q5rZ5M7EDbCZXNMXwDpwOt5I8MQfUNALGko
 2TOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070758; x=1735675558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BQkzcdNzyFSe25Uj6LgRouwEG7p0lTXXdxR16Ve6oxQ=;
 b=emVvF1lp9NcmhV6Ste1wcg2g4467AsuQRwYf8ekSsAe8SoIwwWd8c0G+56+jBIjQjE
 f1EDcLSUDfgXQXagY4mxbhuurRVnp2l0FSSDtdq7cvqDYf9TLIC6AZK3UYfBZ/zjg2n5
 Iw+t8gccIB47R4ItUE15B1rlYLFxU5QY/E/pPMDx3W8O0VSLbqHE5FVLjkMG3I2byntt
 /8r3UdWefAlBYtGe6krSFLOljECsc8wpZNnZO5irz9gHOwcpwZ+7pUmKmEhHrM3mreAJ
 /5OxAunu4h0JBjNmaLWMW744bc6+S0XA/7acrzrLokV5APXl9jgnWzFL8JB3gRxF2Spg
 sLiw==
X-Gm-Message-State: AOJu0YznA2C6LWvJsYDCYuaoa3LdvJCYdc9/tI2orbEr2Uk0IhK9zo+O
 4B8F34XX7vC0G1IJaT0/rLIOJOAcKEEolQud1QpH2h8OZ3jGyh11bH+dvqHc4HzrjmQNBb7HqOl
 V51k=
X-Gm-Gg: ASbGnct6ODd9S2+pxrssoOJZr93fd9NTpErSVe7HckZW+93tOogK8Q+9PmXJ0h1OTFt
 A3zzJY9Lub8EhLe4Cwwc7rM3qJs//eFktU4DT1vJyYaw46fKt8vPXNZHtJoM9NLuUks6lBUaPdh
 qS8JVBCipQIcAzKvn96JRkyEJkZdUjUZulrPnkRLmVz0G6/dxOFH8DLIlPrJoN4bG2HVyKCayez
 KTKxVgQcKNWjzb5B+z8PabYCFG0/ATNMPd/l1+nCxDb/H+i4+mT4t7Ys2Yhe9q+UOqmPmmvcFbG
 hmZmbKqVrIc+AYuLk6dUnbZLvA==
X-Google-Smtp-Source: AGHT+IHi6Nekw9Mvn0n102hNVKNmVBp5yHj+vsvFvSSzJVY4TZ9z/AnUh+KsUrnwsurcfefBKOhI8A==
X-Received: by 2002:a05:6a00:35c9:b0:71e:6c3f:2fb6 with SMTP id
 d2e1a72fcca58-72abde65a60mr30910900b3a.8.1735070757848; 
 Tue, 24 Dec 2024 12:05:57 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 38/72] tcg/optimize: Use fold_masks_s in fold_negsetcond
Date: Tue, 24 Dec 2024 12:04:47 -0800
Message-ID: <20241224200521.310066-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Avoid the use of the OptContext slots.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 74be827f51..7e909791e1 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2387,8 +2387,7 @@ static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
     }
 
     /* Value is {0,-1} so all bits are repetitions of the sign. */
-    ctx->s_mask = -1;
-    return false;
+    return fold_masks_s(ctx, op, -1);
 }
 
 static bool fold_setcond2(OptContext *ctx, TCGOp *op)
-- 
2.43.0



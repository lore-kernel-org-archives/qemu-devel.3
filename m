Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A566E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOlv-0002vw-6S; Sun, 22 Dec 2024 11:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlQ-0002bB-6y
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:18 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlN-00039S-1B
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:06 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2164b1f05caso31193555ad.3
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884703; x=1735489503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cTlZDQEbmCnE/q3tfirQVkn/D4rnwzelc/2JDrq5zIA=;
 b=wCRZHSs4sGoaycnQSLFbLb8XDWKSGBmbGgfTdyU3/eKSOEQgh/i0jAk6/owa279hoa
 pK+gKXF4hxu3qZ4Bfej0sx+l5juiGxEnMUmU6mBgXJwlF732T4RTbnvR+P+Y+V3MuUi5
 7aR6TmG4c7Wvdyu6IzY5y5Y36ddKr8tjcN2NJAY1iMyDVqS7g9wO09ft+GlPZwlTP4Rh
 78aSSs9gNkcPw0k4HZrjbLxLc88aLmHC6pLPRTvpZw/MVbOtdEF6VAmXJ8xxPap4jCuq
 5ZpsypvQRJ8hYWyFEBXcjMI+jTZ2xC0ZFBQNwfpXr0D6+EAr0C5+1PRhmnVoCoPyoR0n
 ryPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884703; x=1735489503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cTlZDQEbmCnE/q3tfirQVkn/D4rnwzelc/2JDrq5zIA=;
 b=m+q5hWP3RaWQHDpvlXDGmfvO1n/JpX7CKAFH05jH3yI7UmVgh0hiSGp6TeJtOe26qu
 spc5f1uFjDRIznDZXl+aIX9mz6HnI512SU6Jb5CRx4kiVV7bHFlZoVssPTmX/K/OyRDj
 PO9iW4oDMYbQsek2Gq6Hw4Kc/WwCcCXKPIFszFmKCcLgL0ocwvcUWjwNflxFZJrCUj46
 UkQh0oY5H3rawPyaROcB2kT7ak6RjLVun2dfbzfQLJHesSWe29fQlQEgH2a11p/DQjdu
 x7uW9cw2G2RtMj5lciwh5krChNWOYaF1KqWylzqbfsU3l936rygjIKnMz3upTANr6J4M
 wiZQ==
X-Gm-Message-State: AOJu0YwhQeFOd2AYTFdoXDTRPietAWyag2lbqesDnWMp1XeJ/vFpqfns
 U+QAaIErwQu2VSLY5M8Aoky7w22PX4sYNGByAds5VPhv2+JK60+ev99BxI+BxCsIKHrpAyK5sAg
 huSQ=
X-Gm-Gg: ASbGncsOM1v+i5YQxU3Y54WU0W8e2Mc6BEJuLE5m1xsEOx9bmfxrI3GyEPxc789wkH2
 oKjGihsuOaXCBn9KG+YsAfl/tbZxCZnHsEvHX9fAz53Z2CbKVI/hgkU1aC2lVMdZSu1GLTqOyPU
 JZ2Nf/5UGEWmjuF6KWPS+FNLM4j/LGVtI91BcvbdUv+2lzFRH30IcUaAmOhONzysVQU2yDyhZWo
 WSpfe7dl1KzmsAryLmnIKqqEuJDQAqvu+lWXfFXyjlnYdXQhobSZDg8xW3G7lw=
X-Google-Smtp-Source: AGHT+IE+/7Mu2zjHIn5XmeswryAZYAbFX9ZPI8kCvnbhqJpPs2vVwo4p67FpbBuVcQqLQnF4Bx/uog==
X-Received: by 2002:a17:902:e806:b0:216:410d:4c53 with SMTP id
 d9443c01a7336-219e6f12d6emr142794875ad.41.1734884703435; 
 Sun, 22 Dec 2024 08:25:03 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:25:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 25/51] tcg/optimize: Use fold_masks_z in fold_neg_no_const
Date: Sun, 22 Dec 2024 08:24:20 -0800
Message-ID: <20241222162446.2415717-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
 tcg/optimize.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index c634c20ce7..98fc5e02a6 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2027,14 +2027,9 @@ static bool fold_neg_no_const(OptContext *ctx, TCGOp *op)
 {
     /* Set to 1 all bits to the left of the rightmost.  */
     uint64_t z_mask = arg_info(op->args[1])->z_mask;
-    ctx->z_mask = -(z_mask & -z_mask);
+    z_mask = -(z_mask & -z_mask);
 
-    /*
-     * Because of fold_sub_to_neg, we want to always return true,
-     * via finish_folding.
-     */
-    finish_folding(ctx, op);
-    return true;
+    return fold_masks_z(ctx, op, z_mask);
 }
 
 static bool fold_neg(OptContext *ctx, TCGOp *op)
-- 
2.43.0



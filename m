Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1F0CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwjZ-0004mB-T3; Thu, 23 Oct 2025 10:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjY-0004lK-5j
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:08 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjW-0005Z0-JD
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:08 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4711810948aso7187365e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761231365; x=1761836165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z1L1SfLTNWdWbkzFYvTuU0iUKvRMuxx46JXkz634BYw=;
 b=uDdynYgRXOA4pCreI0oQGJzs3D9QHSFGs9AIPLLQ9gujoLIVZogxkjyeDGBnbGSZ7s
 GwIG/Ozo92cH32H3D3G4+CLofSGXo7/cajF9h5CIuLiu1QLQqPf2cZI8quN99ExJ/eNC
 nvd8Hxn9/vE+IQf6RvOQDmHbVzt8p3cTQQkWtS0ec15OgQnz/KjF0OsYKTBO2o7yEsgv
 LvE2v+sP5jX2y6p20UAdHAh0+6gMaWrJ3BezZ+N4ZFL6HrilbndZ9jKZunEf30mWvtjJ
 cbS28Uo0GtKVHGqhR/xnaznMnod9/q8+LM86IibkWyOCl0N0zE+Itm+UScr+VQk8CSMF
 sbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761231365; x=1761836165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z1L1SfLTNWdWbkzFYvTuU0iUKvRMuxx46JXkz634BYw=;
 b=UoPCjfKoGN5c6IMGSNvTubeDz2SM93Tgun4AggbaCL+mqCRpz6vzbvFRm7MNhiV5QK
 CJ5I/b19xKf6mmIczKK9K1JTsWn9CcCRpJvuM2uM29jNBT/vEv3OtpOmTEnd3fAytzc2
 V7Fy5cP1G3SGD0Q9bs28JnKF4q4EWGx5GMnJJG2KUmIap/Tp83tpGYcBYnLjLDbn40Tt
 24qQ1yUyivsHre6e0Ulkr6FNx+6hUmmKis5yf8cUORwYEINtcseJTBeRlYD6YcqOL+YC
 3PVCpmNg/6Yn+a0zmBD1wI6ZGNPkTLQwn4Uub5/OVoPAlWcmjO3ua1VtNuu9QwXdiclG
 FAZw==
X-Gm-Message-State: AOJu0YzLIy+xCFGBgSQJ8YIWGQXEAnCE5floSE+uvBBM/D5wGjpE8eWZ
 s61migyU+3W8cUhzNsvWJqcjzj4HPm0kbX3g3rBSDVoajIfoBRdqpcEB8xSkGowzsE+PudaB/3H
 l+t8x
X-Gm-Gg: ASbGnctfPFo6ql0bai8x/bqxi9FiysNs2uiHQkenmrvVxstYMFz8oj1j5EAqevxQEdX
 1Rw1H/OiV8F4L4mqdi6AGHTHKBh75yvl/QjnYr+ttCLXMUlTxHpYrfSxFooCZJq2hvQskKJUoGn
 fgGpCIy/nzvLdX1I64VT7Pzi0XXUAOcH/IVAhcrCKYDld5vI+lg9BI6DGx5gpHg1uk0ukvayh04
 Cz+ZZfOKdsdnT7AZ7KcT4dnfU2JlIv+7hkjDzsfGbQ69KmwYfPyYJXe/6FaYt3G2pTP8YHQPEHl
 Xjs5H8oWZKiN+l0cbZZRWBEyLCuGUiSphqGr6EB4mgPuENXWEJIL+wtlwuZZuo9Vz2pQUA3Gfp+
 yw78FuB1XQMNY1A06Txs1lmAzGJ2Y70AyC5DhTbKWjPuYmstH30oS5L1Xjxl3MDFonMjVKkH7IM
 zVRGiGXoPv5PS5qErp
X-Google-Smtp-Source: AGHT+IGCXhEoN3THtZk5VB6SgulqaQM5LXRLoSu8mEMQEoMHNQJadtAL1jdfXaQNxMnhByncT5zQ8Q==
X-Received: by 2002:a05:600c:870b:b0:46e:3709:d88a with SMTP id
 5b1f17b1804b1-4711791cb7amr201866445e9.33.1761231364660; 
 Thu, 23 Oct 2025 07:56:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898acc63sm4398465f8f.27.2025.10.23.07.56.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 07:56:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/16] target/arm: Honor param.aie in get_phys_addr_lpae
Date: Thu, 23 Oct 2025 15:55:46 +0100
Message-ID: <20251023145554.2062752-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023145554.2062752-1-peter.maydell@linaro.org>
References: <20251023145554.2062752-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251014195017.421681-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 5fcf1042726..23f6616811a 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2319,7 +2319,9 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
 
         /* Index into MAIR registers for cache attributes */
         attrindx = extract32(attrs, 2, 3);
-        mair = env->cp15.mair_el[el];
+        mair = (param.aie && extract64(attrs, 59, 1)
+                ? env->cp15.mair2_el[el]
+                : env->cp15.mair_el[el]);
         result->cacheattrs.is_s2_format = false;
         result->cacheattrs.attrs = extract64(mair, attrindx * 8, 8);
 
-- 
2.43.0



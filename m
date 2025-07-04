Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01455C83F0C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjFP-0004KQ-Ce; Fri, 04 Jul 2025 12:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEp-0001Rh-8r
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:11 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEn-0006Ym-IS
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:10 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-453608ed113so12310875e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646368; x=1752251168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gBWbBw5ikLSU10dONtd+Ef3kpPK3iZWX0omb0JH+U5U=;
 b=f1fWn51yVo/3Q6DdUAHtg8qL/+atNfpKkP6kgaiwzWVf4AkTOVGVp5EVolycQolEK0
 Csh+EgUXCydn97za5GTEHIYclHtwtsJI4qBCMPU2y8u6AiqzMZdugBz8nSyXdboT39I2
 XGK6d98L+SjT7u1Qvk4cetIjCd68Swz4VYD/hhyTmxazigFuBe3Gi56i2EsILAytd66Z
 H9Canvsc6NSDE6SmeSEaz87QikRH3FmWExCBznKR21MQhaPeUap+N109ij8UJQgBE0Yf
 fACIi830GNAwXwIyg2IT0XqxUP2oHuHoNwsmL1pSGfT2936S0RmZLXEUfD6aYGhrTkVL
 H2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646368; x=1752251168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gBWbBw5ikLSU10dONtd+Ef3kpPK3iZWX0omb0JH+U5U=;
 b=Xgh8UAZ0pbh6Jlwx+JzSb1MBEDYDbOlx/nXEhgLZPaUnyxi/pgrJ0VNE5SBHxNAKp2
 Ej03musigkHSd8HVvbipALS5m1yWpvSEHgp3TVCig0+UbnGy/9ycKo+pvLQb4L4WG0my
 fh4oSGWzDBzxymjyCVG5ORkBRmNgOMUWCU9IvJYhSX6ipaKwtuJxZ1xWX1Luo9XgT+6w
 CwAzxyNFhya5EYWCe2q7w0+8Unq4KLIaULQ/Y3zliyVKQPGMCLiIjEQtPtFE6o1wsBsJ
 m9cCst20hQSNLbbNBFaR/nSWr2/mdtKP3P91BYRomMn2fkWuLMgId7Q6byLEImFD/Ald
 IqHQ==
X-Gm-Message-State: AOJu0YzZkqaXv27PVS0eKqOVnk9sDZtGTMmC4I3IQs55MKDrZ/ZSHkw8
 pXUO/24qvrlo8qs2a/z/0J5/KgVgeAWevRoOnVT4Xmdv+5aOXjB52lAO+ffUe1tHQCuIL2Ve0R7
 TKBgS
X-Gm-Gg: ASbGncsrUfCl9Xs4CqziB1ik1S+isn8e/dGwJs/llgvRX2BdVKppYLesucGUodDPwAd
 Sc5DtBp3CTYKiEFLB4yA7777inVetG7fCvqAp1GIn88QZ4H8+8jjnm6a2jbkKU2SuURnGDCCnPc
 /zjFbS4nzCJjaUdvi2Kei54ah7amQZvhtLwy+emLc27iX009Zn/iDMbqHaJ60df/5+uhyEHuQrz
 O1eLVHdW0857jpnICGlAanpgoZOOFDIKRZvrl5EzzfUIeq3QTJwW9uhQazPzsnocmC8rZnHuu0q
 iVTel9bNwiVd7EwTi35lBf2Y9nFxJbIJNbu+iXAHDAkUQM7nneNgjrDuJVO2EromQZCn
X-Google-Smtp-Source: AGHT+IFj/HUcEDxb8kuBNvw1X0RwYDv4jDK6crtPOosR9p0pW0PVGPmC0j++svg0ZzMA/1Mz5TQFgg==
X-Received: by 2002:a05:600c:c114:b0:453:5c30:a2c2 with SMTP id
 5b1f17b1804b1-454b5312c5dmr22125895e9.8.1751646368167; 
 Fri, 04 Jul 2025 09:26:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 069/119] target/arm: Introduce do_[us]sat_[bhs] macros
Date: Fri,  4 Jul 2025 17:24:09 +0100
Message-ID: <20250704162501.249138-70-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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

Inputs are a wider type of indeterminate sign.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-58-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/vec_internal.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index bbf76f63b18..a1c10c60a1c 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -223,6 +223,13 @@ int16_t do_sqrdmlah_h(int16_t, int16_t, int16_t, bool, bool, uint32_t *);
 int32_t do_sqrdmlah_s(int32_t, int32_t, int32_t, bool, bool, uint32_t *);
 int64_t do_sqrdmlah_d(int64_t, int64_t, int64_t, bool, bool);
 
+#define do_ssat_b(val)  MIN(MAX(val, INT8_MIN), INT8_MAX)
+#define do_ssat_h(val)  MIN(MAX(val, INT16_MIN), INT16_MAX)
+#define do_ssat_s(val)  MIN(MAX(val, INT32_MIN), INT32_MAX)
+#define do_usat_b(val)  MIN(MAX(val, 0), UINT8_MAX)
+#define do_usat_h(val)  MIN(MAX(val, 0), UINT16_MAX)
+#define do_usat_s(val)  MIN(MAX(val, 0), UINT32_MAX)
+
 /**
  * bfdotadd:
  * @sum: addend
-- 
2.43.0



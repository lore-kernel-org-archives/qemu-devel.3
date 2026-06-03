Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B42CD6E6B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 18:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUqIc-0000cl-BZ; Wed, 03 Jun 2026 14:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wUqIS-0000Y6-1q
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 14:26:34 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wUqIP-0003Yq-2V
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 14:26:31 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-490b43e2b95so12545565e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 11:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780511186; x=1781115986; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XHo+RgjT6TDt8H4pIyhVDsbRZWepv+aHkO1DZ26YbNU=;
 b=hFJpSN7JWmme86u/3pZEW1kqFTf2jsIOwO/oW9YVlDl5m6Bh3iDBh8LwQtDjioz4Du
 W9RsZc40S3W+KCEDm70h73TTfNHIxNy5iE9M+mMR2U2GRMTaapUT+MOnHAILT3aiQNeN
 UrWiQLBX7TLfvxa+GF3wWXLo8CpPQUpv6SXzSCV3WdH+I8r2f2mwhm3LJnu/FhXX8Z09
 AzZme/dMiGkCQcWIx2rB9lpfaTGe7HCvqT9INKZcyxHxic1cpfUcvNVQkzXpxQB25KT/
 F6Ol0vJH4NSvHJ0LZv7d73BiCu2Zxz3uKxpKaTw59e8vCwIDkoHiaai8X/e+80Mr/gUv
 G1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780511186; x=1781115986;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XHo+RgjT6TDt8H4pIyhVDsbRZWepv+aHkO1DZ26YbNU=;
 b=WffuTVb+IwAVCmNYsYdobqDCrV5w0hQ/HgGgQGmn3MzjuJFDazMpmWbO+LN0BVhrso
 RaxN22ngJdZQSP/3MhCKLrbonTT/cpV3yzCcedEk9RYm3mSn2IT+Uz2oAkxBLjKYfxG8
 2hSe7NeuuACeilSjcYJxXrtO1LVaKqMXngnHfmSbcunpDvsgF+AeOCv+9zLDM8RBG+jx
 A1Tb27NxkNwUq4PfUVUoQ3vOVg7+lpYhZ7q9cfJ2sy4HnEQ5cErN0AO5YVGzNcS37+K/
 k4wWjAewpOY002Lg3PQlaEJnnaJflwpixkwkj4TvcIwzTnejGO26Kzdea++PPs7tR4zJ
 8/aQ==
X-Gm-Message-State: AOJu0Yztid46KzHUsVjAuDILkA7/OTsXX5T47XisTuMvlQW4OKa+NMHW
 ua6K2WwViQq1qHVddB+NEL7672BUhoEhE7DW1qhTIfKWPIYe3miQfVuSHJl2E2XE18I5PLXO7aH
 tedPHhE4=
X-Gm-Gg: Acq92OFYHQPSQd+/4K5Z9zn7mqaUHn1+A4QfkW+kOVf0WI2NBwCclAGdxJbyA/v4WGz
 QaFPwSsHZ3xsSaDGg6vX9TGG3Tc/cDDlvur/h1aUlqkIb2b8/xydYLFtfApqS7Cdoc3WXt8oU1J
 QJaWr7c0povmYT1cwjWpG8LFFHlkySOZOCnG2ize33ZRFFLDqngB9ENhohY31qpU5fJmWjDLwhb
 bx+2nXEwWSIGV5L2b+TFjLk2ktlhqvGD8zDNwsx9H6l8oGrk4rLIEC02YO+5n7fblWqRE9K9aXD
 s95h7P8eRwW6lbaL83C4m6SML3Mxw7XhubJW0simQnbcJvTdYd7rnfxcTblkaA99NQjiVPeoONn
 87gfgpguSPjs57HU1b7h5koiV3zJNr8c7xBBlYFhPaZPqvYaKxsLDNQHF1beKLyc0BFlaZfpIrj
 fT7zLlqsGOEGW1I4YwMKeIjFk3cwhom5E3KknNZg==
X-Received: by 2002:a05:600c:64c5:b0:490:52c0:744c with SMTP id
 5b1f17b1804b1-490b5ed43cbmr74362175e9.20.1780511186589; 
 Wed, 03 Jun 2026 11:26:26 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:d530:6a6b:58a7:e220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2ed944sm9793127f8f.13.2026.06.03.11.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 11:26:26 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Wed, 03 Jun 2026 19:26:20 +0100
Subject: [PATCH v2 1/6] target/arm/tcg/cpu64.c: Extra test for GPC3.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-jmac-gpc3b-v2-1-115c51936962@linaro.org>
References: <20260603-jmac-gpc3b-v2-0-115c51936962@linaro.org>
In-Reply-To: <20260603-jmac-gpc3b-v2-0-115c51936962@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32f.google.com
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

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/cpu-features.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 38a695ded7..ad1b1ddc9b 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1148,6 +1148,11 @@ static inline bool isar_feature_aa64_rme_gpc2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR0, RME) >= 2;
 }
 
+static inline bool isar_feature_aa64_rme_gpc3(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR0, RME) >= 3;
+}
+
 static inline bool isar_feature_aa64_dit(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR0, DIT) != 0;

-- 
2.43.0



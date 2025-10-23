Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1AC3CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwjV-0004iz-KK; Thu, 23 Oct 2025 10:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjT-0004gO-1O
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:03 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjR-0005Xe-AU
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:02 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42421b1514fso665163f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761231359; x=1761836159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rKggUMTp2Py8H2Mu640NwLE70wGVNBBA8/YWOG7pk50=;
 b=SP6QEcIBXd29JYeSULpNEhCm1zfbgk02pvxJXIcbjCdyHm7At8bTZG1LMKHOa4ede4
 dduomW+QbHSC9EHJncpQbLvvVqeyEzG+uAp3kzks03xwlGJOvibRvBcBOL3GzxFlmEk4
 w3q8z6lHz0QLJSyNfToacUYUrZHYpZTbbXudkt1BNOspV5Xp7Virrbe2oWmSiKrP4vmA
 5emli+Czalt3kfJtwWh+bztMzOvEP80OMeKXNR6OlSoclOftA8qouz+gT9jYBrxUpf5M
 CtQsjWrxTVJ4O2EdBBgLPxKhJPk1IJ6T2SqUv3q5x/msYwrg2ib0x0Glg6neSJJwGF4i
 DHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761231359; x=1761836159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rKggUMTp2Py8H2Mu640NwLE70wGVNBBA8/YWOG7pk50=;
 b=hrfD2M1hDLvtzY0qr8fVzcDeNMrH5EG2BfajNH3KpoAST8PiTt9oTAMIIiAuE91lmE
 7akqdAHbAQoDW7IMv5FWpLaDduh8f4/7Ll4FFRZFz1w9B4RCRKw779cRPyoMaugk7O2G
 KoTVjQB2oktAJrUfTs7WPEY4DCY9b4yb6GStiuNKBUlkl/ctUuwnhiQ/H/QNgrubhV5B
 WdH+5YYksCYw5YxrbIUuqIr8yaHnrcrePUHrh8R3Ua7qooLfJchZ/wJwvuei+Zo8L+Gu
 N1s907v3zKjDR0oTgi3+WL2PxlRr8FvwgutE81NpSIV8wyrO85Vj+OjAoUxwytmUHeuS
 CLAA==
X-Gm-Message-State: AOJu0YzZq3+4bf5X3UjG2J/m5X47HqfTGcr/o9P6576ZOFkg272nucva
 FsiERNeCQaHEib/etPQedeyUASd4C+T119tr98iy+3oHZNZoqK5irmHD6M7ZF5w26bT0PaP5whU
 yiBnA
X-Gm-Gg: ASbGncviGIGCYJJEBp0HEHzo+rW2xkexFQvUmCKPItGSEdSwE7SMF1eeaOUgwHGPc8l
 Ip+7/evJkpcwlrlgNXA0BRoafk+I3BbMBfrqkEQyNlO7VaQ3wBB+8cl41a0KsS/MSZBrdB5zq1n
 wpnPmuKDw1OPusT+jZDg9uE76lP6vziZZfg4wTxWtfMN4vb3H86dMr1wNc+kZ5d6n9lLPEM4AIW
 q+/cLxQsaEXEJG6OwXBAr/dTO2qmS0Osc6EwS2/YRbwRGl3vdq5hW/2zcssunBFE95uTOt6IDpk
 rHHSkCUVae5mMOar/EBmOvv7awem+Fy2th7ljeI3IfQvi+3KLGoqvrtWiV+T8YKyQPkkHTXBKCt
 xoaB9dxkwj669Rjcbnem4fXIVh0FHcWkVKNXBQ2XQo9gP5ur4U3Dm9lC7I/vYxrD89OEEVchs8h
 Gqldsevw==
X-Google-Smtp-Source: AGHT+IEm+QqjzO5gtTQGBwLGKiyQs1iuQLEuVX0UUsWDBngrBv7HoJzeUirEpU9ji6vMGyabIk3pnA==
X-Received: by 2002:a05:6000:24c9:b0:426:d549:5861 with SMTP id
 ffacd0b85a97d-42704e029bcmr19155367f8f.42.1761231359632; 
 Thu, 23 Oct 2025 07:55:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898acc63sm4398465f8f.27.2025.10.23.07.55.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 07:55:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/16] target/arm: Add isar feature test for FEAT_AIE
Date: Thu, 23 Oct 2025 15:55:41 +0100
Message-ID: <20251023145554.2062752-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023145554.2062752-1-peter.maydell@linaro.org>
References: <20251023145554.2062752-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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
Message-id: 20251014195017.421681-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 37f1eca3af6..579fa8f8f42 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1364,6 +1364,11 @@ static inline bool isar_feature_aa64_s2pie(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, S2PIE) != 0;
 }
 
+static inline bool isar_feature_aa64_aie(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, AIE) != 0;
+}
+
 static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, MEC) != 0;
-- 
2.43.0



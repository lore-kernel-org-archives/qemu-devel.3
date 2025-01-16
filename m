Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0E0C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 21:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYXep-0005wG-KG; Thu, 16 Jan 2025 16:44:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYXen-0005w5-RB
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 16:44:05 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYXem-0007LQ-87
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 16:44:05 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so15123785e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 13:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737063842; x=1737668642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CX5TSXdMoun14dJ7IVnouq8LDBWvCnit0CgMnLfjyNo=;
 b=x6/xqN6qxoKMl7FDm3N2sVyiq+fxNHwpgsS4JJ07xV0i8FDnQxQDpgZXl3MiCfciTz
 +HeobdLhRAN+ITxo3E7GnpNMYopXnY2vXjSh06TIrUZhnx0TCt6FrxnNcLE12r6WwWPR
 n7DIfsa0WwliIaGkc6s1lhNhvPUO3DyJt3KWvmsLPLrC6As/elIIjcdaFMS7F8NQwUP0
 LwY+QLlWlCCfwD4Ku3bR6vI95rg5TA9goFxjgb17/EMPAD+YkOiFMdhkQ3HeOSI++4y5
 KMHOJVGJ2Riy2Ag0Yi+XuDdqpGfpQq7L6Xo29Gr5ZozWhF7meWTPAj2x+afegDAwpvtg
 OyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737063842; x=1737668642;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CX5TSXdMoun14dJ7IVnouq8LDBWvCnit0CgMnLfjyNo=;
 b=lmIfdTOx54oOm9GOZXuHyuYCKKC3oJuWpFmYrT9MmHKe4F53ej3zWAvf0ywlYtx4LZ
 aKfdjceatkSZByaEiy9dBGQnfPtfpH5YTxQcQeBE52JwxoMsFC1Vc2vyBq4VYR3x/obC
 Xyf64tPktkCJeWgDAF+plvxXOPmaHmVBfb/jasm32uRAcANGzG0FrUxwUP9mOwwavz2t
 //jcB4BUxfRRdGN5JXqWnUhnaHiVGwMBwyL3sofeYM9SKE70itu9YJ2bG285Fbc7heKM
 XdycvH4lwrCWZepE12By8Bf33/qBWzNQn1HcG4MYw7rprR5c9zCh78zQ7omZYxx36oaC
 2oTA==
X-Gm-Message-State: AOJu0YwVNlBBEAmnzqyJfdCehhWFgNOYS49ePIIamcXf9UUPBGtO5v28
 M+hBTjfgOa01g/q2KT/BBBMSQlSd6wLK7GGhTCnWrlsuoADpePIlbxFtnmLlvwU2UDvahmUE+LF
 DnAU=
X-Gm-Gg: ASbGnctgU1kS2P2WhJ9rY892VqqTOIM22T7NIxMzu83jaid8OgXnuIoz4TFbpWBhUJb
 KgqZ/pCOE8MscElx/qzz71WHid95C9Pr9r8Gd8gwt5w8iGZb5zRRcS2gIHPh7q94NftAaTjQ9KX
 zz42aCrbZ97H2t+LNPjZT/QLiiFd4M+E7pwgHB1stmqoH4J2QzBsBvJy3AMDVV1ra9jVvSSWCHM
 mg9Mro4etzGmwcYqAOEI7mH1zL1GchOETzdw8020JrqaAWJC0C4Pd3M8QRBVIx2IB0qmn/GHF/A
 u9sNqirAvWKBMGLxx54lvl8PDTpbhpI=
X-Google-Smtp-Source: AGHT+IGWJb3E2f/qXpEBBwkqE2KkzhY+XuYslTGG94cOGo/4mPiFXrm6SKA1w//tjo+kCQfEEf/IuQ==
X-Received: by 2002:a05:600c:3ba7:b0:435:172:5052 with SMTP id
 5b1f17b1804b1-438913becb8mr2079525e9.1.1737063842004; 
 Thu, 16 Jan 2025 13:44:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74c4f85sm73263865e9.18.2025.01.16.13.43.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jan 2025 13:44:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] softfloat: Constify helpers returning float_status field
Date: Thu, 16 Jan 2025 22:43:58 +0100
Message-ID: <20250116214359.67295-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

These helpers don't alter float_status. Make it const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/fpu/softfloat-helpers.h | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index dceee23c823..4cb30a48220 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -124,58 +124,61 @@ static inline void set_no_signaling_nans(bool val, float_status *status)
     status->no_signaling_nans = val;
 }
 
-static inline bool get_float_detect_tininess(float_status *status)
+static inline bool get_float_detect_tininess(const float_status *status)
 {
     return status->tininess_before_rounding;
 }
 
-static inline FloatRoundMode get_float_rounding_mode(float_status *status)
+static inline FloatRoundMode get_float_rounding_mode(const float_status *status)
 {
     return status->float_rounding_mode;
 }
 
-static inline int get_float_exception_flags(float_status *status)
+static inline int get_float_exception_flags(const float_status *status)
 {
     return status->float_exception_flags;
 }
 
 static inline FloatX80RoundPrec
-get_floatx80_rounding_precision(float_status *status)
+get_floatx80_rounding_precision(const float_status *status)
 {
     return status->floatx80_rounding_precision;
 }
 
-static inline Float2NaNPropRule get_float_2nan_prop_rule(float_status *status)
+static inline Float2NaNPropRule
+get_float_2nan_prop_rule(const float_status *status)
 {
     return status->float_2nan_prop_rule;
 }
 
-static inline Float3NaNPropRule get_float_3nan_prop_rule(float_status *status)
+static inline Float3NaNPropRule
+get_float_3nan_prop_rule(const float_status *status)
 {
     return status->float_3nan_prop_rule;
 }
 
-static inline FloatInfZeroNaNRule get_float_infzeronan_rule(float_status *status)
+static inline FloatInfZeroNaNRule
+get_float_infzeronan_rule(const float_status *status)
 {
     return status->float_infzeronan_rule;
 }
 
-static inline uint8_t get_float_default_nan_pattern(float_status *status)
+static inline uint8_t get_float_default_nan_pattern(const float_status *status)
 {
     return status->default_nan_pattern;
 }
 
-static inline bool get_flush_to_zero(float_status *status)
+static inline bool get_flush_to_zero(const float_status *status)
 {
     return status->flush_to_zero;
 }
 
-static inline bool get_flush_inputs_to_zero(float_status *status)
+static inline bool get_flush_inputs_to_zero(const float_status *status)
 {
     return status->flush_inputs_to_zero;
 }
 
-static inline bool get_default_nan_mode(float_status *status)
+static inline bool get_default_nan_mode(const float_status *status)
 {
     return status->default_nan_mode;
 }
-- 
2.47.1



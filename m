Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70947FD45FC
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvOAH-0007Fc-NS; Wed, 25 Feb 2026 18:19:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOA8-0007Aj-PK
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:19:26 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOA7-0003SD-A8
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:19:24 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so154418f8f.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061561; x=1772666361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lMJ2aUNCM5aUuy6BHxWLWg+FGSreU8pqwVtxyYC+Q9A=;
 b=Vfhw0j++lzmNvR/9QaWET/mC3lODwlQc9co8s42BJ1UjS/bIR4ePt7OHNl5Y76AMrD
 z96jseDIeLQvYkaOu8aDuJYZZZtLqeoFwV75jRnWZjhqu2QvRxo/OR875gC26VKFcvwJ
 9Bvsu9i/Lm4n59T3QYLPSpoiMouk9NRP0gQ/m+t0oYtPkBpwai80RPG2C48oI5jz1Fxk
 K5EkhJJE1Y6sYP+gAEawKXPfi2DSfz4lI/7iHZslrpsErJXona/cLFzq769RbL5WvNBd
 vA/g9rp/lLD7M74dOVf6NO2EX5XVafOz/d+CDnbHulqIhzu7tvvJtoYUZyqObO+OhrJ2
 560w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061561; x=1772666361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lMJ2aUNCM5aUuy6BHxWLWg+FGSreU8pqwVtxyYC+Q9A=;
 b=OQI+Au8P9W7rl8aXn3lx7fRJzyfIkhHj2jASVt1vL4h0EJZ36pjWTi2KXMB+ptV4jN
 JfMKo1e2Cs+W63dq40zCWKN1s48T0GhNefMkP2M2DIt6CCjLkLyDe+a/ce0AK06WPdeV
 gbn4WM3dmtUnW4mPPgJ853RTooDc6lbdiy5pEgRc8RQwjGcbyczEGBGfUKcj4QYSSeoJ
 i2Fkp3MrA8SA7l690pdbHq1ZX8N+SQVNvD4I5HIpA/crCFwgbHAa1376TPiH9+pwjWbK
 jEGI1DuygkKj+xX940G49z3swOKh2l+WFvfX4tegcH3hakGEVHELwdhPzG/R6ARQrAnf
 8PGg==
X-Gm-Message-State: AOJu0YwNzYX6bGUkrvx2igm9SWx2huc3q52VcYXMpSjNGkiUFQBHvz1h
 bVDNxpM2CbcLtktdz+JxCXLQfJ3ovVyukpZrr+ZXYKoEjPCYa8Ld9p/5Yk4L3HT0g4l5iFIzQ0c
 w6uF3Nm8=
X-Gm-Gg: ATEYQzxU5vWpenBp6rl+0AaUyAFku3cZrvT2Q+/ty2z05rNVp5rLyvwRP+A3a0O1zZK
 YGgoHjBZGqIfekxxvG49fynDLbDOspDZbGaCvRNSj0u+1MuCMVyx5x0i9nd6G3zS3mtF06yVufh
 dvDMRbXoTj69skn2tJYLxaD4t5GreulkEJ5c1i93uHON2m0fUr+TlmcslELuK/LIZUIBqlR5vh+
 0lqH2Ppwai7BHEmg0TLvzPaxejTnLFYBeXIxhrqEVkHUqkum41iXz4ihCPj1i1EKBJVVQSVPFb+
 lIC/6OCy5XoNOe9S15+eYs6mZmg69pobDtfpYq/GU1NmTSz8KhrSeso8huRafVALvZcqysDijt6
 yHuCl2Jmq5CCcq/vaLu49U8HBq2OREKWU6LePHLYy5GqielMM3QPmfprpAg3NKGdxF8pMx1o7uc
 pFPy2fuzOKdP5cJkofHXUxbFB2XjBtBqDX+zPqlO5SfmrlffskNitFNtcMXSZwa5RSdQ3Hwdfj
X-Received: by 2002:a05:6000:2508:b0:439:8f32:8668 with SMTP id
 ffacd0b85a97d-4398f32883amr8251675f8f.58.1772061561184; 
 Wed, 25 Feb 2026 15:19:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d3ff1csm35875932f8f.20.2026.02.25.15.19.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:19:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/70] gdbstub/helpers: Convert gdb_get_regl() macro to inlined
 helper
Date: Thu, 26 Feb 2026 00:13:45 +0100
Message-ID: <20260225231411.96482-46-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Rather than checking TARGET_LONG_BITS at build time,
check target_long_bits() at runtime.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-38-philmd@linaro.org>
---
 include/gdbstub/helpers.h | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
index 402514716d7..b2f41d6d280 100644
--- a/include/gdbstub/helpers.h
+++ b/include/gdbstub/helpers.h
@@ -88,6 +88,20 @@ static inline int gdb_get_zeroes(GByteArray *array, size_t len)
     return len;
 }
 
+/**
+ * gdb_get_regl: append @val in @buf using 32 or 64-bit, depending on target
+ *
+ * This function is legacy and deprecated, thus should not be used in new code.
+ */
+static inline int gdb_get_regl(GByteArray *buf, uint64_t val)
+{
+    if (target_long_bits() == 64) {
+        return gdb_get_reg64(buf, val);
+    } else {
+        return gdb_get_reg32(buf, val);
+    }
+}
+
 /**
  * gdb_get_reg_ptr: get pointer to start of last element
  * @len: length of element
@@ -101,12 +115,4 @@ static inline uint8_t *gdb_get_reg_ptr(GByteArray *buf, int len)
     return buf->data + buf->len - len;
 }
 
-#ifdef COMPILING_PER_TARGET
-#if TARGET_LONG_BITS == 64
-#define gdb_get_regl(buf, val) gdb_get_reg64(buf, val)
-#else
-#define gdb_get_regl(buf, val) gdb_get_reg32(buf, val)
-#endif
-#endif /* COMPILING_PER_TARGET */
-
 #endif /* _GDBSTUB_HELPERS_H_ */
-- 
2.52.0



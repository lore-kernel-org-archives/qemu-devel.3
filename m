Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D19EFB7F9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 05:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vulDv-0003o0-Ln; Tue, 24 Feb 2026 00:44:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vulDt-0003nS-Nu
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 00:44:41 -0500
Received: from mail-dy1-x1341.google.com ([2607:f8b0:4864:20::1341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vulDr-0002IH-O4
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 00:44:41 -0500
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-2b6b0500e06so6429872eec.1
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 21:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771911878; x=1772516678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WILaMGNYgo59ciXOv8fCSdPpQjQ/av9tdzjHB1/JF6I=;
 b=aUh1HkwY28hsC8iuk/eKF2nRzLix2GT/yw7E1q7D6i4frR+l1AJtJQXZiMsx3fXOcA
 FtHhtXFmFu1nIFekKqf8ft40jg9vwiOTjDz+Kf5ah5kFQtzo83k+DtGBU5+/uP+lidng
 /e1rmMTrHuLfGF8meby3wwbENUjGmqmT+vCypi+Pudiuy2LscQZYJDE1Adnqz8QSLq6w
 Kv4RjkRwhdattHbEbMBBMjSVSb2cq9xZeG5QHznvuhfAw64qBD1dLiyyKNPbpuyEPo1K
 PJbqX+RkLdR1Ntdg6uYGsn4JLKWCCfINRccgmh16xFZOjHWtJkV8o+FJdGP9FJcT4JDc
 +wGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771911878; x=1772516678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WILaMGNYgo59ciXOv8fCSdPpQjQ/av9tdzjHB1/JF6I=;
 b=CU5WXjM+i2Y+wnk2Qpg39Mc1TGr9KXPa0S9M7x6jffKQy3HfClTiwmzoqPcHFMIjHF
 VAtTjAn4PWDpMmz+8Ei9ller7VZa8ujZ72/by1pgAF8FU8+xlIPYoRQsx1U3NOKPhnEh
 7XgmdnjQVRfCEVQP+bM9PptcVXYpAx1NEEyUdYRhBMWHHoEBNV/7XFsDops9m79kK98r
 UeJB1RoP2Uo5SK8yPYCz4XPzHsHdkS4YNvF/aTYCG3HGqx/iGeW3jc41UDDiIKr7i2Lf
 NdlDltlZyFUqiHWadgrrH3N/FWXjM2OGsTjDqAm9GgIwnwwaf8eoV++PNvsym5r7z1Jb
 GHyg==
X-Gm-Message-State: AOJu0Yw3zERezMUOJkgWGW7jOpSxFC4u7d/ryMo+qZexsyjyc+zfHW2R
 zZpbGVy6ay0vR+h0Z9nc1jxvr0xRQlKJrRU/9kFxxJJhUv78Uyysm4w3E3gMYxi4ivrrlxJqUcw
 jtxxwzFzjDg==
X-Gm-Gg: ATEYQzzukXUFVC27RLC+3e8XHkPLukyXBPfd/ylVrGyuaS2nQ/3KJjCkUkV2471Vrpz
 2uGt6FjQ7dYI1edQAjzaGfc73PK6YzzofRh2nEyAm+WAwRsOUG6o00ivvgbtkyPdxffww/OKgQ/
 983TlTijK9j4ov3OzeaQWo2WtYF/yoF37QTuOFDeI0CBmgp8ETMy/zXOmxohkm9iWB2fkY0hVcR
 2ndPUU2cDOMCyYKXAMIhluteACR2L57e26oYHXd2r2VMUp8/5+8pqiVUCm1LEpMMN0pN33XmH9b
 SiHQi3imoCh0OcdxCTFRDSDRx10EN02q7K9oxZJneCtloCqNhV7ON8kDGTJZEmPPDuD04kv1LbE
 ZhN8H34ZSW3uTDYWZfRgEfD0m9RgvCmdYqjktPSF0foF43JiI29Dy+BMxWvAdVhpWbjoBBisQUR
 1LdVjFZFPXsW3okmPDAEKiDC0RXxgO4aTRODmoZlWN/b6sdLJFFt2P
X-Received: by 2002:a05:7300:e80e:b0:2ba:7a5f:9e5b with SMTP id
 5a478bee46e88-2bd7bd60186mr4088828eec.35.1771911878029; 
 Mon, 23 Feb 2026 21:44:38 -0800 (PST)
Received: from stoup.. ([172.56.177.223]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bd7daa37c7sm5958093eec.12.2026.02.23.21.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 21:44:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Chou <max.chou@sifive.com>,
	Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PULL 2/9] fpu/softfloat: Refactor floatx80 format NaN classification
 to share code
Date: Tue, 24 Feb 2026 16:44:10 +1100
Message-ID: <20260224054417.32430-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224054417.32430-1-richard.henderson@linaro.org>
References: <20260224054417.32430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1341;
 envelope-from=richard.henderson@linaro.org; helo=mail-dy1-x1341.google.com
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

From: Max Chou <max.chou@sifive.com>

The floatx80_is_[quiet|signaling]_nan functions contain duplicated
logic that should be shared.
This commit introduces floatx80_nan_is_snan helper function that
determine if a NaN is signaling and change the return type of
floatx80_is_[signaling|quiet]_nan to bool.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260204051756.667397-4-max.chou@sifive.com>
---
 include/fpu/softfloat.h        |  4 +--
 fpu/softfloat-specialize.c.inc | 53 ++++++++++++----------------------
 2 files changed, 21 insertions(+), 36 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 66b0c47b5e..69b9041ef0 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -978,8 +978,8 @@ floatx80 floatx80_rem(floatx80, floatx80, float_status *status);
 floatx80 floatx80_sqrt(floatx80, float_status *status);
 FloatRelation floatx80_compare(floatx80, floatx80, float_status *status);
 FloatRelation floatx80_compare_quiet(floatx80, floatx80, float_status *status);
-int floatx80_is_quiet_nan(floatx80, float_status *status);
-int floatx80_is_signaling_nan(floatx80, float_status *status);
+bool floatx80_is_quiet_nan(floatx80, float_status *status);
+bool floatx80_is_signaling_nan(floatx80, float_status *status);
 floatx80 floatx80_silence_nan(floatx80, float_status *status);
 floatx80 floatx80_scalbn(floatx80, int, float_status *status);
 
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 7d2515c1fa..9ed968c79b 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -357,53 +357,38 @@ bool float64_is_signaling_nan(float64 a_, float_status *status)
 }
 
 /*----------------------------------------------------------------------------
-| Returns 1 if the extended double-precision floating-point value `a' is a
-| quiet NaN; otherwise returns 0. This slightly differs from the same
-| function for other types as floatx80 has an explicit bit.
+| Determine if a floatx80 NaN is signaling NaN.
+| The MSB of frac differs from the same function for other types as floatx80
+| has an explicit bit.
 *----------------------------------------------------------------------------*/
 
-int floatx80_is_quiet_nan(floatx80 a, float_status *status)
+static bool floatx80_nan_is_snan(floatx80 a, float_status *status)
 {
     if (no_signaling_nans(status)) {
-        return floatx80_is_any_nan(a);
-    } else {
-        if (snan_bit_is_one(status)) {
-            uint64_t aLow;
-
-            aLow = a.low & ~0x4000000000000000ULL;
-            return ((a.high & 0x7FFF) == 0x7FFF)
-                && (aLow << 1)
-                && (a.low == aLow);
-        } else {
-            return ((a.high & 0x7FFF) == 0x7FFF)
-                && (UINT64_C(0x8000000000000000) <= ((uint64_t)(a.low << 1)));
-        }
+        return false;
     }
+    bool frac_msb_is_one = (a.low >> 62) & 1;
+    return frac_msb_is_one == snan_bit_is_one(status);
 }
 
 /*----------------------------------------------------------------------------
 | Returns 1 if the extended double-precision floating-point value `a' is a
-| signaling NaN; otherwise returns 0. This slightly differs from the same
-| function for other types as floatx80 has an explicit bit.
+| quiet NaN; otherwise returns 0.
 *----------------------------------------------------------------------------*/
 
-int floatx80_is_signaling_nan(floatx80 a, float_status *status)
+bool floatx80_is_quiet_nan(floatx80 a, float_status *status)
 {
-    if (no_signaling_nans(status)) {
-        return 0;
-    } else {
-        if (snan_bit_is_one(status)) {
-            return ((a.high & 0x7FFF) == 0x7FFF)
-                && ((a.low << 1) >= 0x8000000000000000ULL);
-        } else {
-            uint64_t aLow;
+    return floatx80_is_any_nan(a) && !floatx80_nan_is_snan(a, status);
+}
 
-            aLow = a.low & ~UINT64_C(0x4000000000000000);
-            return ((a.high & 0x7FFF) == 0x7FFF)
-                && (uint64_t)(aLow << 1)
-                && (a.low == aLow);
-        }
-    }
+/*----------------------------------------------------------------------------
+| Returns 1 if the extended double-precision floating-point value `a' is a
+| signaling NaN; otherwise returns 0.
+*----------------------------------------------------------------------------*/
+
+bool floatx80_is_signaling_nan(floatx80 a, float_status *status)
+{
+    return floatx80_is_any_nan(a) && floatx80_nan_is_snan(a, status);
 }
 
 /*----------------------------------------------------------------------------
-- 
2.43.0



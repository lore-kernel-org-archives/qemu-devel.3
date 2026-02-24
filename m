Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C5DEFB807
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 05:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vulF2-0004TB-8r; Tue, 24 Feb 2026 00:45:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vulEF-0003xE-Em
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 00:45:04 -0500
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vulE7-0002Il-3B
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 00:45:00 -0500
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-2bdb09bbedeso211916eec.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 21:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771911890; x=1772516690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X6XPtUSpRFE7xmawHfhRMeMmmluweS9VsVD+lHKg9p4=;
 b=siad2PnMZ9A3a74iiSPJ4yNiWHt1qe4WoxbfRgBNX0Xl1T2YNxm0Y5wZutNV+76vFQ
 kzzvUKYm/5pDIXlkkICxlXpxqweONekSbb2GtROzVMDfcE/H6xiAPfahZteTJHuc1AUw
 KpIXkpmMMXW2AwZpfmkQMH3SKbjUaoaxnmYMxFN8zqD0ZAzJknL/Q8Exl+xY8ZCpGhEP
 9Kh1AEyxMw+yTWMh5di2G1R0jOBsOCQLYKcSAuU5wXxoF9ekeuAdrEPQ7ja2njZpC/VE
 oiQyRivhI+oS8eK5RuGBpE85bGsVYLMsGIKwwIAlrS/pkAUasPjMpbdWpKleRvKlCsLv
 PLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771911890; x=1772516690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X6XPtUSpRFE7xmawHfhRMeMmmluweS9VsVD+lHKg9p4=;
 b=uYrLV+RhQfGmdqkL5RQtVOsiiLNMwGbGS65j91FZ+IUJyfWW/r95BNhewZECaU/GPs
 +dEvJjNaqn5afQFajSnXuzuE30bm18rY0L5gwwih5cH5cODcUI4pKRPoP15ZJIiVlo89
 uFGkanTgBiLX0dBLVaxVxKANq/ngWh0wi//PBKF6VWqCRbbNwEOu49GqTfFPfKtn9aDx
 UskToG5CmlZ9c5NkUlu/LKu8iOw1fRt3Kxk5OWnhViaPus/sUhCi+tsbx/mpmSPDO8ry
 xDbly/F0csied0L85i3FyNeCQDis7icj1+1zgjV5Jz8n5sqplkmuqu1q76sxI8Yb0UeO
 U7rg==
X-Gm-Message-State: AOJu0Ywp/Tr2oZBZ/jOBSNe+W2HmhNX+I82B2yJgAvto4Xecjf87zP7i
 0RgLr0uIRaebfzfzKBKewDa6iqKVECViZlSw6/eP4pEEUpI0nnWvnpRYb8bKBzycALm1hvln463
 Qcrzt9W0=
X-Gm-Gg: ATEYQzzyIkiWTShZFbBLtWsrPd6B4KronCZap18E56UUAOT3PHb9LyUnoITc9R5Plbt
 vj7FtlFxqpg5VIShnhT2AC1A7y7WZogoxiHVl9KwHEE7cV8GikTWjJ473jy6PO/stbM0SoyztYN
 aYVWzmMsVypCmS3Z2LNg3TMCbC2q1K4LGD1cGNgsr5M4f333/gzTCyJivTwBcH17vzHK3Mahn7P
 pUUFcYHOGkSJSSzoxviuSLquZzdCTZ0LQ8wKT0qB1o8qx5fZ7aeNQuuXovWPH4rPON8mMEQgNDw
 dS7YiJcwhXhLRy7yeUb0Hwli+BZtNXO8PeOS1RmuKucvfgc0Yx7pQSTZH1/1ykbfXudBlNISePA
 5c5+Gn+Hnzf5zBevnxG5V0mJRqpbv99PKBIrcu2jBsqxNwYGrWm4K39NJXUfP24v0bUMzvtZ5Gm
 7i1hxGEV+//6cuBXugzyyKYqFmOJDehFqnyBp0AlZEwuSxgWto6ltnXqD8bpvzPAc=
X-Received: by 2002:a05:7301:4443:b0:2ba:7046:b6b5 with SMTP id
 5a478bee46e88-2bd7b8b943bmr3777807eec.15.1771911889860; 
 Mon, 23 Feb 2026 21:44:49 -0800 (PST)
Received: from stoup.. ([172.56.177.223]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bd7daa37c7sm5958093eec.12.2026.02.23.21.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 21:44:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Chou <max.chou@sifive.com>,
	Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PULL 5/9] fpu: Add overflow_raises_invalid to FloatFmt
Date: Tue, 24 Feb 2026 16:44:13 +1100
Message-ID: <20260224054417.32430-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224054417.32430-1-richard.henderson@linaro.org>
References: <20260224054417.32430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1334;
 envelope-from=richard.henderson@linaro.org; helo=mail-dy1-x1334.google.com
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

ARM Alt HP raises different exceptions on overflow than is
standard for IEEE when saturating a value.  Add a flag to
control this effect.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
[rth: Split out of a larger patch]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 6 +++++-
 fpu/softfloat-parts.c.inc | 4 +++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 8d8e576757..9d06a1bb59 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -542,7 +542,9 @@ typedef enum __attribute__((__packed__)) {
  * The following optional modifiers are available:
  *   exp_max_kind: affects how exp == exp_max is interpreted
  *   has_explicit_bit: has an explicit integer bit; this affects whether
- *   the float_status floatx80_behaviour handling applies
+ *       the float_status floatx80_behaviour handling applies
+ *   overflow_raises_invalid: for float_expmax_normal, raise invalid
+ *       instead of overflow.
  */
 typedef struct {
     int exp_size;
@@ -553,6 +555,7 @@ typedef struct {
     int frac_shift;
     FloatFmtExpMaxKind exp_max_kind;
     bool has_explicit_bit;
+    bool overflow_raises_invalid;
     uint64_t round_mask;
 } FloatFmt;
 
@@ -576,6 +579,7 @@ static const FloatFmt float16_params = {
 static const FloatFmt float16_params_ahp = {
     FLOAT_PARAMS(5, 10),
     .exp_max_kind = float_expmax_normal,
+    .overflow_raises_invalid = true,
 };
 
 static const FloatFmt bfloat16_params = {
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 455bbf281e..4909ff7418 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -348,7 +348,9 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
             case float_expmax_normal:
                 if (unlikely(exp > exp_max)) {
                     /* Overflow.  Return the maximum normal.  */
-                    flags = float_flag_invalid;
+                    flags = (fmt->overflow_raises_invalid
+                             ? float_flag_invalid
+                             : float_flag_overflow | float_flag_inexact);
                     exp = exp_max;
                     frac_allones(p);
                     p->frac_lo &= ~round_mask;
-- 
2.43.0



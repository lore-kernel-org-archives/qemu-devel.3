Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53A1EC1E9E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 11:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnxMO-0004vX-6V; Thu, 05 Feb 2026 06:17:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnxLp-0004lT-6c
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 06:16:45 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnxLl-0003nw-FW
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 06:16:42 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a743050256so6078125ad.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 03:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770290200; x=1770895000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ElQpzIZEQeDmNN3cMImRewZNjsVx9FWnqqHOtfmVIkA=;
 b=WI7mEBTNSVD86gwAO6P/T5dZgK+NEiXBS0GuJJcEvYgHHjWN+2Xh8QwsfxVM7QIySI
 x2/epRp/y2U/lyuk7udQvB7a2eXys4eqneIDgK93U3s+SC7PpwOa2shUctf0h697x/1j
 8n8/UTkMsKdGGkOUvftdjaAfCvEBp6Qs86QH1qyiuT8wF1Kgxdd3ZwP3T6ZmBNtmEKYx
 m0qb/VLLWEnDxAYSXTOFxflbT4Ly+OUxxgpLN/6BVBVO0F9zRKc622ZXCsY7SlkOQhbz
 4yiYQ1CgejdlQ0lRaV60EeZjD3dKUEEmfx6XQkUrdsYmy8MXka9EGXcU0sfChzzTozTw
 vYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770290200; x=1770895000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ElQpzIZEQeDmNN3cMImRewZNjsVx9FWnqqHOtfmVIkA=;
 b=Ym948bGBNFHB/7xHFhIA0B8DjOi13JVbfMatiE0Q9rc7WxdOgkfJFExYfmTv3DtOr+
 38bct7snFiBzR/GG9wkl1EGnSZFlHBYiJERP/+ihjyUJDcnx3NLCd6EF02kU9I74c7Md
 QVnjrtzNKhkoPvNL8DnqsdYqiUvgSd+3ftn2c8uszkW54RsU4wbcG/A9yn9OelJ+wPAH
 Wvl5AyXNjw2SoSlVXAmeSbxHO+Stba09gFXnx1xWBKGtC9bqJOFEIdtF3jk4hkR7Fk7d
 iBg9eiu9J/UrL31hhJKb6vdINBN3hATGTPjyrG+YghW1GzqfxR95MlB4MSJUr9A8P8Ih
 ph/A==
X-Gm-Message-State: AOJu0YyD+ufik/sx9KQv1VuIKlDeZU6WzZpWlErscwwb9jAd4mn64kXQ
 jItfHjtJJsvIcDCYM5JLkXa5caVEX7JtMlQz4SUcAL5hJnw+YcBxHLoTK4eP5G9qpwZwn6dOMyB
 3+weuGqJ6eg==
X-Gm-Gg: AZuq6aJ6CTCimtWWWAAfb9vax/ewpQa832M8Gc03yp8yIQB9RvG5z8OOfnvUyeg9fQk
 ucClY26EVmOhUAtjiBHZ6yAsnzZxL5GMaHAW2QsMfNFO29W3rlBWWRE8nxrPX9S4OTaYMqa0qGa
 gQfi3fb0z/X0OshQsjS718faFiLUYsEPMtoeA6eBJ8aZxCnyY8+riMT2FSiClKFl54+A1EYUfZC
 tTpAHWDX2e5q2RW4twpuRv9Ktb1H4jExnEmQcqPo5eBB9EkcpwmB2/BLJ/Q1Whk0YILUGH74ynd
 kc3y1OJPWMzpASyTxxJvpJnaqzRxwyWxsac869JRlfOe5mvB6u5jI5eseaTrnCRXtuLRChE49b+
 HSRY6MTkss7nxjQ0Gj6OivrrtRBwWTL+G6P9+3CKU3K3wOfhDYMpCxe1mdxHPL3/dQAQHis7QAP
 kO0xOJYx/RWk5b8hW4Ne2WjooMHSmOVZg=
X-Received: by 2002:a17:902:e84e:b0:295:5da6:600c with SMTP id
 d9443c01a7336-2a933bca814mr67213015ad.2.1770290200015; 
 Thu, 05 Feb 2026 03:16:40 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:7515:513c:b646:18b8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a933851685sm51088435ad.13.2026.02.05.03.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 03:16:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com
Subject: [PATCH v4 5/9] fpu: Add overflow_raises_invalid to FloatFmt
Date: Thu,  5 Feb 2026 21:16:18 +1000
Message-ID: <20260205111622.461497-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205111622.461497-1-richard.henderson@linaro.org>
References: <20260205111622.461497-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Signed-off-by: Max Chou <max.chou@sifive.com>
[rth: Split out of a larger patch]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 6 +++++-
 fpu/softfloat-parts.c.inc | 4 +++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 18098c4cdd..209eb59b48 100644
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
index d3c9c7a913..eada83f7a4 100644
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



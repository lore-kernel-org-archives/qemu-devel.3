Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F78FC5903
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 07:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvVdx-0001Vm-F0; Thu, 26 Feb 2026 02:18:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vvVdm-0001Qs-3r
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 02:18:30 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vvVdi-0008OA-7l
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 02:18:28 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-8272ccb554fso498731b3a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 23:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772090305; x=1772695105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LWUYWc2ioRu39LM7Z31ifi7GdSN03Wne4cE5S8TPpZU=;
 b=Ty1jhBYDtHq8CNSEgySp/16m8QaljEvutLex7RhtzVfeWWP+uVV57UH/8r3bpCT2u4
 QJXB6LyMp5swVWzrgeykcLeEewRWeGmogEIMF2FS7Z+FgtANoOrY1+5cvZqbiiBUh7MJ
 uKqpT8hvtDsbb+X8y4HqXzvY84ZDYaaqQljPHb0xk2DxhrWOiVpal/IP4IBP3ANdCE62
 +uF2hXyDl6a5r3iZvF+5pMg0M/T94MZlVip9QgzS42afZ2YdkcO1X2pHvOKFaZKi85lQ
 TfbxqbXzYywkJh17Kgly1IpxjdEx8uy9F40VWMxa2cGgrB3PmexaM66OAfJFbxMY/FU1
 NgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772090305; x=1772695105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LWUYWc2ioRu39LM7Z31ifi7GdSN03Wne4cE5S8TPpZU=;
 b=v2GlqZGgsEHwXqj+NdRyOxXCa3/kBqJLivuIgK+ZhAd/8X7hIccIzbBrBMslS+JXMr
 eqv2lbjURfwRkKbc7lB6n2Y6yCyIphvHcuY8sfADEap8hRDbThcwwIAuAMdUCg0m2siK
 Bt2UCx53eWpL0AR/cR/2aLTGr2p70gTL5cUFcOGIk1PLoT6W61k4TE7U+mUaDjnb4PVN
 U82hwerCLk9OonrGJvZLw1EyjDv3EiW3d8Pavd+3VBwzr5ICXb/9tHzOcw7mrhQzPwoj
 slhGYPJWJ6vj8KsOz/aCLkFvHu225n0a0AfcTvh2lw0uVE2XScdBbWkJpuqhMAMdBMUW
 hBbg==
X-Gm-Message-State: AOJu0Yz9LmCEyO8gxQH0rmw7IcUmYjM9CKSdsohOWiYQiHZY+UMA4KO9
 m7i3UMUpPICcUHeb+Fja00eQQu/UEnKlfydf6xAj+3Zbo/Q2oxOpoH6Revu3e1okNyJIK19vFBq
 TWkJbdjTo86+cP36X9gM+1ok1rlamMI+GC5oKqu0xz374Lcp5K1XpJWysnFQHqvCOolxIaSmwKX
 lvH4xxJWOmg03RjlQo5Q9jGVbBHkfZ9D0zEnZoDvYvT2ML
X-Gm-Gg: ATEYQzztXR6yjRRK7cfxyKniOJpruh1Ze0+zpF5evlKP+JQVOmv2uo+9YBtDXdlsgDN
 X0a+WLax5iglnVBY50IRk4Xrfci3ligPGv660+CyFnvhSM39g6lwowS2r8wF8z6yq/ROuKrElM2
 UYm7MsCsGZzdvgbck3cplQYllmm7hWWKxSsYXYhUX2D8YRgRhgcrh4u2eVTK+z00KTcU0S0soAP
 V+4Tu3WGd54c3RYDcYIKfWOFLXnSWZ8Jk0Z+SWwklxim3L9rltHhqac7Te40+UZhz0y7Mcbgi8V
 oc5lSUABF6NO7jvTbjcsRhB7YmZPz503JAv1U2V9grXIlQtrVGWFStCp8nZBR3bI3V+A2iKNqFj
 u4pn5VjPcQOvZU8J3x8tEMBjRQLYX0GyqQ3cOI38S1WvH6YMnQhK8Cn+Na1wjOMCNWIcBqTjxPa
 XmJZkIqQNIfBxd/w2OYkUPu+Vh/Flx4NypiY7AwO9pVxhgisDC6wthuNKd3cfaK7/vKhfki9Wxu
 coEyexRupshrdVEJMnXXRCRFS4=
X-Received: by 2002:a05:6a00:44ce:b0:81e:e09d:2687 with SMTP id
 d2e1a72fcca58-826da8c0f33mr16778307b3a.1.1772090304514; 
 Wed, 25 Feb 2026 23:18:24 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739ff37f1sm1296179b3a.40.2026.02.25.23.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 23:18:24 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, Max Chou <max.chou@sifive.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH v2 1/2] fpu: Fix repacking issues in the uncanonical step for
 E4M3 overflow
Date: Thu, 26 Feb 2026 15:18:14 +0800
Message-ID: <20260226071817.1417875-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226071817.1417875-1-max.chou@sifive.com>
References: <20260226071817.1417875-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x435.google.com
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

In the uncanonical step, the input FloatParts will be repacked to the
target FloatFmt. This commit fixes following issues after calling
uncanon_e4m3_overflow in the uncanon/uncanon_normal functions.

- Add the local exp update after calling uncanon_e4m3_overflow in the
  parts_uncanon_normal function.
- Add the fraction shift after calling uncanon_e4m3_overflow in the
  parts_uncanon function.

Fixes: 27e989f99c ("fpu: Add conversion routines for OCP FP8 E4M3")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 fpu/softfloat-parts.c.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 61b07307bf..a738758aee 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -387,6 +387,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
             case float_expmax_e4m3:
                 if (exp > exp_max || p->frac_hi > E4M3_NORMAL_FRAC_MAX) {
                     partsN(uncanon_e4m3_overflow)(p, s, fmt, overflow_norm);
+                    exp = p->exp;
                 }
                 break;
 
@@ -496,6 +497,7 @@ static void partsN(uncanon)(FloatPartsN *p, float_status *s,
                 break;
             case float_expmax_e4m3:
                 partsN(uncanon_e4m3_overflow)(p, s, fmt, saturate);
+                frac_shr(p, fmt->frac_shift);
                 break;
             case float_expmax_normal:
             default:
-- 
2.52.0



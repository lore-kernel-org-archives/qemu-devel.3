Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB3EFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEvC-0007mT-Ta; Wed, 29 Apr 2026 20:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEv3-0007YP-O5
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:18 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEv1-0001pR-Vj
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:17 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-82cebbdbdccso224774b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507574; x=1778112374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Rzg+4hO4nAbZubUAP6kBF42CtlaKGG45/YI7C1MQn0=;
 b=AvbR1FddT6YoZE4EnOLAJY44h/2z2yHskzoof+VX1d0cHiirV6C2a3KClhtYNjvWEW
 c9FZktmnuyYyUAZ/zqiUsMoUKjGb7W2c+cEgJKSXhDsWuaJCiPbVTNrA6KeAL9PBgdaz
 5pvvLFQx3jXH/46fT+g0OhgI8j55a8SJkVSXhF0P7J9fkv604vT3EK3m0R1UfZDzO27l
 FYThrySx2wa2l1c80CEPZjmGM+qJMWeH4zfW69sWA70QmJ6jy4CAzB4X10wPr9baocZn
 IOR5bzJJ7Brgsx+jjdQ79hmblzN14ZFEc6xFsR5IodZ/Q58l91iXNMTR1y0BA/WHhmfe
 oroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507574; x=1778112374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0Rzg+4hO4nAbZubUAP6kBF42CtlaKGG45/YI7C1MQn0=;
 b=IID1tqcnDxkT9NEnnbhQ14bpnI6Jq+nDbfpF1fWdUPaE0wdLmy4PjEc2A0bmDZ3YkP
 vIjmFy6QEBDkGQ8QHuvqZElaXpoRI21VqJBWfjCqA0O4SSxrz2C+fZIGwJIL1GFGBES8
 12It80JJ8qKLpVIWB8bQzDsbm79dpi1iGnao9XhFmDVoyu5pi5705VTQFaZc7q72XBMi
 CoHOSZ/JEUA/exX3kbRnaN9hmIujP5HxEKIjmxeHkjf0ta00ja+PPVcCzuEi+LrV+gjS
 wgANA8NN7ppVCJNopJhfZkD15i5A7JoxdFmGAl6/0K2ovHE8/91mmfYyNzcPvSKwUAqV
 JDRQ==
X-Gm-Message-State: AOJu0YyflGjNiEONB5U/SyIm3TTWaeDsC+VhDJsLJK52QuX1+aWdvdKG
 +RbgV4FjLWQuCkt6KK76l7lSJYlgr30V2JZ4mbIZhj6ixWFq/JZIg3YqBKnBkkNWf5v4hK/vNls
 ZXxARI3k=
X-Gm-Gg: AeBDiesA/i6ChmE4MboenUF+vUaIpwcS7DHuWsAvb9l+nRptKDX+6vewb3Db56UtPWo
 917tWnopmwGnl3PFCWK7UFTi9tQAWMiPJ6BZ8FSyjmj+rmlfP26tL5XSToxEPw2Liux/8ajVcPx
 /XRaGVF3FBpS2bZ3wl9F7YLKetrBBUeCnw2mC2Gp8Dxbt36I6w+CCASBbyo2S2I5YWZVZ/BigrL
 NXZN7WjJ2ladCDA0Lks9VwMFjnnY+O7rhZrS+Fj1y45kEYPbyT2Rp0StLOJLBblSTZdmaw5SN4p
 gOyad9GuEIlFkoIekxTIPVBHbEdkkHdnrQ6E6Tvp83RDbluAtAN5zErLPFPwejalQ0vdqUyajZu
 SwhXEtaLlfILnAXyZfaB3kXtwncyRKFF5YEqOnYu+reRtHZoPHjHz2gWcGYdsXbgNyL4Y73gXRm
 SvNZB7ttMk/qZp7UkeaJq/BP8KmGPtWuB66s40dR9h
X-Received: by 2002:a05:6a00:3021:b0:81f:5acb:55fc with SMTP id
 d2e1a72fcca58-834fffc165cmr216071b3a.10.1777507574316; 
 Wed, 29 Apr 2026 17:06:14 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:06:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 20/40] fpu: Export default_nan, pick_nan,
 return_nan routines
Date: Thu, 30 Apr 2026 10:05:03 +1000
Message-ID: <20260430000524.56046-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-parts.h  | 15 +++++++++++++++
 fpu/softfloat-parts.c.inc      |  6 +++---
 fpu/softfloat-specialize.c.inc |  4 ++--
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
index 1329bc4d2f..8c3a94bbbc 100644
--- a/include/fpu/softfloat-parts.h
+++ b/include/fpu/softfloat-parts.h
@@ -163,6 +163,21 @@ float64 float64_round_pack_canonical(FloatParts64 *p, float_status *s);
 float128 float128_round_pack_canonical(FloatParts128 *p, float_status *s);
 floatx80 floatx80_round_pack_canonical(FloatParts128 *p, float_status *s);
 
+/*
+ * NaN handling
+ */
+
+FloatParts64 parts64_default_nan(float_status *status);
+FloatParts128 parts128_default_nan(float_status *status);
+
+FloatParts64 parts64_pick_nan(const FloatParts64 *, const FloatParts64 *,
+                              float_status *);
+FloatParts128 parts128_pick_nan(const FloatParts128 *, const FloatParts128 *,
+                                float_status *);
+
+FloatParts64 parts64_return_nan(const FloatParts64 *a, float_status *s);
+FloatParts128 parts128_return_nan(const FloatParts128 *a, float_status *s);
+
 /*
  * Operations
  */
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 1cd0df4159..7d4b40022b 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -15,7 +15,7 @@
  * indicated otherwise.
  */
 
-static FloatPartsN partsN(return_nan)(const FloatPartsN *a, float_status *s)
+FloatPartsN partsN(return_nan)(const FloatPartsN *a, float_status *s)
 {
     switch (a->cls) {
     case float_class_snan:
@@ -37,8 +37,8 @@ static FloatPartsN partsN(return_nan)(const FloatPartsN *a, float_status *s)
     return *a;
 }
 
-static FloatPartsN partsN(pick_nan)(const FloatPartsN *a, const FloatPartsN *b,
-                                    float_status *s)
+FloatPartsN partsN(pick_nan)(const FloatPartsN *a, const FloatPartsN *b,
+                             float_status *s)
 {
     bool have_snan = false;
     const FloatPartsN *ret;
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 2723bf5e61..485f082cf8 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -118,7 +118,7 @@ static bool parts_is_snan_frac(uint64_t frac, float_status *status)
 | The pattern for a default generated deconstructed floating-point NaN.
 *----------------------------------------------------------------------------*/
 
-static FloatParts64 parts64_default_nan(float_status *status)
+FloatParts64 parts64_default_nan(float_status *status)
 {
     bool sign = 0;
     uint64_t frac;
@@ -142,7 +142,7 @@ static FloatParts64 parts64_default_nan(float_status *status)
     };
 }
 
-static FloatParts128 parts128_default_nan(float_status *status)
+FloatParts128 parts128_default_nan(float_status *status)
 {
     /*
      * Extrapolate from the choices made by parts64_default_nan to fill
-- 
2.43.0



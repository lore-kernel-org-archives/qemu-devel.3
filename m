Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80726FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDLi-0000Jo-Du; Wed, 29 Apr 2026 18:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLa-0000FN-QY
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:35 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLY-0004t5-VS
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:34 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3614826eca4so214696a91.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501531; x=1778106331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5bEIML70BacSThny8hKO0eQqyV855mB1fb4MsnF2gNA=;
 b=UM+xqS097SxcJHKNi9wR3yntki1O+hdnzo2wjoLIcSofKuck58HFAORtPehyJG8qRy
 TYO6L/fEWIzP6QlcPYDmQ3RNpLw6VhoTrrINIpMr9/dy1GUoBDiPKZhmXOKk3L0lq0da
 ndunB9RQMpo6yT/Rcp/AZR3Xp/C5jMg8bGm6KNlbmdxjMaTpqv4uV1pw+K1akMw0yUGS
 nfcfM4NSY7tbI+tAHJ0iH4xc51fTMfvtWBbxGzDyV7ifzvIkUcFsPligXYkbDpucwK4l
 6rQE07o3XRQGTudHyVI3BjH5lIIbhPQ1EGjVKSUnTKyHwTBcxqXQFG5nydDkTxsKrapa
 NItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501531; x=1778106331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5bEIML70BacSThny8hKO0eQqyV855mB1fb4MsnF2gNA=;
 b=qIdFuc6W8pwQgciw/0IqTTXRQrTIYaFKu7+IIeQtSkhOMK60IDe9Wg0CpNU0yX4O5y
 ErGC8OxY/yIHNVABnvkFyLQ1fPO1lfI5DwQkhF7N3k0FPod3TYxBgMbfxGLwhsdYyGE+
 yGz1CNe09ZMNPUoAK/kv6rNg/weCPgoDIcnuHz41gy4d+u6RA/yWGFz+9QowebBdlaQ0
 dcZ9ooUPcVxBvTTU/hBllRZV13SxRzViydBZgILk6Mq12iyp5bCDmuJ0M+aIiITEY5le
 JIdE5Jndt0S7k4l/oTzD9k9Ch4ZZfe19EQLR+R5jJwM++RU0NFygSRLAcS4YmvHj+amW
 s3ag==
X-Gm-Message-State: AOJu0Yx5VVYhBLC7En9CibnLZSdsX7OUVjAeak9PDIoaF4I6/9wpa3Fm
 Wl2AFpJ7X9kD5Jkzp1AdedRRpaC3dyoDpbfRPxleITo0YrP1GwX6vS9mKIavZX4X4S2ZU5U+5dE
 pbqc3b9Y=
X-Gm-Gg: AeBDievFSGlzNEs7GRGivnOSksg0K0t8wC1CmMWZUFQtAhe7YMxuy1D7Dae9y2eEI7z
 3iwafBURmxmaSmI2kgUWVsGshMpWuMjJ1N6YDyVOm3nQGylu09igqK3QvxnGZtvNgBt04jF6P2O
 tAvJWdcnoZL4e/oMEznxd6nfvM59XqbXg4efYsTGbJKwWsftmkUC6Whd8mbT+8FgKWXyKlo/dsY
 /IpeRW7iefwvQzPlkr5GTfpIC1n7x1gd8FP51WeC+tot9iSsxWaJohc2NXVSFybc5SBHknH/Jpk
 CF1XodW+1zIJ8V2dgAoqxZjG42w0iP57Ea6WEb7B3up1WI6znJ4d3yoUatUSSyhHXPTyuxCyewZ
 4qoVFKZQF2SBZeXuqMona9r6qqRe2TabeOoSDYMPpJQP6ZmWC7agVkb+yMJFAIOjdAXaOn68x8g
 32B7aZ3hThjnzOoZTsa80QaUG55XV8YZ3HnkEEkjk0
X-Received: by 2002:a17:90b:3b4f:b0:361:423d:203d with SMTP id
 98e67ed59e1d1-364c301f2a1mr175762a91.8.1777501530156; 
 Wed, 29 Apr 2026 15:25:30 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:25:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/48] fpu: Drop parts_modrem
Date: Thu, 30 Apr 2026 08:24:12 +1000
Message-ID: <20260429222445.26301-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Use parts{64,128}_modrem at each call site.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b885eae629..91d8e48ce4 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,14 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static FloatParts64 *parts64_modrem(FloatParts64 *a, FloatParts64 *b,
-                                    uint64_t *mod_quot, float_status *s);
-static FloatParts128 *parts128_modrem(FloatParts128 *a, FloatParts128 *b,
-                                      uint64_t *mod_quot, float_status *s);
-
-#define parts_modrem(A, B, Q, S) \
-    PARTS_GENERIC_64_128(modrem, A)(A, B, Q, S)
-
 static void parts64_sqrt(FloatParts64 *a, float_status *s, const FloatFmt *f);
 static void parts128_sqrt(FloatParts128 *a, float_status *s, const FloatFmt *f);
 
@@ -2642,7 +2634,7 @@ float32 float32_rem(float32 a, float32 b, float_status *status)
 
     float32_unpack_canonical(&pa, a, status);
     float32_unpack_canonical(&pb, b, status);
-    pr = parts_modrem(&pa, &pb, NULL, status);
+    pr = parts64_modrem(&pa, &pb, NULL, status);
 
     return float32_round_pack_canonical(pr, status);
 }
@@ -2653,7 +2645,7 @@ float64 float64_rem(float64 a, float64 b, float_status *status)
 
     float64_unpack_canonical(&pa, a, status);
     float64_unpack_canonical(&pb, b, status);
-    pr = parts_modrem(&pa, &pb, NULL, status);
+    pr = parts64_modrem(&pa, &pb, NULL, status);
 
     return float64_round_pack_canonical(pr, status);
 }
@@ -2664,7 +2656,7 @@ float128 float128_rem(float128 a, float128 b, float_status *status)
 
     float128_unpack_canonical(&pa, a, status);
     float128_unpack_canonical(&pb, b, status);
-    pr = parts_modrem(&pa, &pb, NULL, status);
+    pr = parts128_modrem(&pa, &pb, NULL, status);
 
     return float128_round_pack_canonical(pr, status);
 }
@@ -2688,7 +2680,7 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
         !floatx80_unpack_canonical(&pb, b, status)) {
         return floatx80_default_nan(status);
     }
-    pr = parts_modrem(&pa, &pb, mod ? quotient : NULL, status);
+    pr = parts128_modrem(&pa, &pb, mod ? quotient : NULL, status);
 
     return floatx80_round_pack_canonical(pr, status);
 }
-- 
2.43.0



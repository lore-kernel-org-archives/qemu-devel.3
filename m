Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5EFEC1EA0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 11:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnxMV-00054V-Qx; Thu, 05 Feb 2026 06:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnxLg-0004gk-AW
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 06:16:43 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnxLe-0003nB-GT
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 06:16:36 -0500
Received: by mail-pg1-x542.google.com with SMTP id
 41be03b00d2f7-c698873a1deso376372a12.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 03:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770290193; x=1770894993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jYqIjIwuJjJ99LoW2+mJj8Co+SjC+NkMZqtAn40OcNI=;
 b=pDg3QuPCwPYzT4t7M7zJtIUED2dH4lbtmtPwXY4zYZyhmXneaYz02umqtdJr1bgPjH
 KV/Fv2DSIUhx3d3AmoXj1sTMvrjUDy25t9zSgTsTSwLIYJnNnmaOhsdGFZunpT9TvMUN
 +ZREVW6eM0AqpGj/HTHxXeN4UFI4hkWfdvadDRkcSAphSEopAaRHGuZSlxHZ2pzDJp7v
 tGxK1UGwMe5fVg0jRZ9L2OSMmqDnhOWctqopCM4uA6ofMyBQhi5wA8mXucF76MQBWTQZ
 ADUf0pb+5xRg0bDPPN9zeXDALl49hrCHjWLxyfr8B234EhmGkOfsSNmrb7bFGoOta3x7
 AOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770290193; x=1770894993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jYqIjIwuJjJ99LoW2+mJj8Co+SjC+NkMZqtAn40OcNI=;
 b=hgZK9DNECBE75wnQgnEDeUpm+NyXvBBZ2jOvv4QRo4ObOgt9GscQygYhlnEZ/8norV
 SMW7iUT/VbIZw6IguZ9ZYN/y0CvkC6PIXHLtupPB/6l+eZ6L1tdLkw+ITXmTU9KuRmAn
 Uw5CMnf7IRcFjb9HJD5KZlgQVgkH8uKPKasg+QqlPsovQcbJbxhiih+qm9jjqHGsUZDt
 E0/6WJCu5aJRceIsiHx/dp2NsYaEhXaJiDWNT0Ycwz17qVxZwODkgv5rTlzaSn8Kkdhy
 EZF25UgUOo5VrY9pboI71yGXuyrafUfLMSfU4qLmjCs1E3U0tk0zwW5snONWFGzoc2Tx
 jXgg==
X-Gm-Message-State: AOJu0YzBVM1Cb/qjzo3zqhetWNqI//4XI6T71X48DhFiHHscTh6YME4M
 iSNwEo7cqzQHvjdWuK7HgxkaO8WK9bHSdzQumqnUjz3Apvw7PeSu9vV8wS7Gn7jEEVKsc2UWuA6
 R9hJsvhVLHABA
X-Gm-Gg: AZuq6aJjWyLPC6UJBTNXKGsDcBAgHefv3Ixyt27eGyhPi9ASAK9a6DCJoGDj2gosgPE
 k0kJ0/lG4PXpNmToRmtGN2NByA6WeJfhi3Zc/h++8XeArT7DndIdCxOX12Xgx+lNzMgW3X8pxCv
 NHoU4KVBC2o551rid41JuacSNJ2BlvnNe8LsYM7uXjLyWUr+/7eixXzyb1yAwb3QKNzf5W7k/Y2
 M0M7COgrcoSq2nyHNbeZc2fceCh7EUsUJNKJw15A32BcCZr8a/onGZWfnQZvKCPoeLFVvO+kHlv
 G2K4mLh6yAdYgfhpf4u4q6KKarCdZYarGdBN9OelCOMDsevuQq2TDz4sO4W7MSTmfoYMxiv7feV
 +SpOCNOWtrPd+P9BlcojSY5/JhkPQCobGfGWjE/nmoCkLa85+qlrqFjEmmkzVtytO/s0CROJhDB
 4BgiA54FFcMgKaq3GeZvGg
X-Received: by 2002:a17:903:f85:b0:295:592f:94a3 with SMTP id
 d9443c01a7336-2a933fdd4edmr54397625ad.48.1770290192880; 
 Thu, 05 Feb 2026 03:16:32 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:7515:513c:b646:18b8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a933851685sm51088435ad.13.2026.02.05.03.16.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 03:16:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com,
	Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH v4 2/9] fpu/softfloat: Refactor floatx80 format NaN
 classification to share code
Date: Thu,  5 Feb 2026 21:16:15 +1000
Message-ID: <20260205111622.461497-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205111622.461497-1-richard.henderson@linaro.org>
References: <20260205111622.461497-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
index c18ab2cb60..ac6a392375 100644
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



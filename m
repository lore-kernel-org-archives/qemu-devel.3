Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6917CFF885D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzjK-0007Kk-H5; Sun, 26 Apr 2026 09:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzjH-0007Cx-G3
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:59 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzjF-0008Sf-E1
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:40:59 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2b299b3c739so42910915ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210856; x=1777815656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8WiBm4/XBu8RSNVnQd6I4REPIlrsOuCBeW72EivOcJA=;
 b=QD8CtH3nw9iJaotWYdtZ6hJxeIU4okyzvkgLhzP9/w16ZVQ3hRjqf5Lj8tzVAspQ5m
 cGrZJPzIePPnbUz7g32W7/dXLDCGA9/1OZwV6wfCAw7sROzl/R1B6IqVZYKlYoWEskHo
 kK7mu270TtTCXw6VUtGqzXZMCDfYSAp4bnZ1mhdB20O1NdglM4iD+pwZsege4P5QS51T
 tEtOphtOH3clCAQDtgnZbKiSxajkx8J1M/N4LfNhkSSP/3YrMkKBnS9KpySp1Ueeh4YZ
 ZpUnFR6dTMRhm34LH6I3OwYb7eEdp+Q+fl0e/FQNIJdqSOnicW5lqoPAS7uFleAHSZrd
 z2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210856; x=1777815656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8WiBm4/XBu8RSNVnQd6I4REPIlrsOuCBeW72EivOcJA=;
 b=obzskqN1r59Wcr8D4zcOj5wc9t2h7WxJstcCC+6CU+9gh6BbiRIrDXdav3oYpRVcR8
 2o52WpP5bOjOeAmFzbnGksqx8al5haUcNXfmraYlsuvD63Bs7cDvnVQuEkqAnajvnRPz
 42+BZoGOlt+J96TJy3OgCg5MAtgGaTz++Dli04aYsiDvhL/jT2xNKgyhb9LPqdScYbXN
 fXXKzNfYan1dj1RaBw0tpa59HqEh9dyidQzzbq35he5BZNT+FgchO+Hi9pNQsGXE6l5m
 Nc+nyXcxXqQerBL+vFNwYFCnmVDDavmW34o0PbHi1/fCzNmhRODQKo11SXCP0biw9zPj
 yAng==
X-Gm-Message-State: AOJu0YyxjcuC5xJ+FZ9+TZrrF0iFKP68q8uYtgLCpXRIU1JJPDFFIkm6
 Y7rTbANkDDVtrLBAT5zKGtemsFmnNeu2yx8feWBnAHFCPgqs+kWq2Nsn9HodXo5WVKAl7FAH6KK
 ATiXbXA4=
X-Gm-Gg: AeBDietr4Rz6c3IXGq0hPjxNCMUDXkaKybxpjCS+ks+U02fP2w9/PkHNdss7jETW5Oh
 uCB9UKe7Py9CAu54echJQoRGH5G/nmSZfGiFf0i0p0uDcjtDQlJ4qVhQIvJRhcY1auwiXpnVtHr
 KXKDAFc5qXIB9iuT1vDjUxHyN1AJ+yOPxG4soOfHVbi4jebnjm7cpiZYlo5NUoUQuyaMcy+Aw4S
 DIIHC4YWes56mOUuohmiZL2/hocrO/0hJZPDNY7EIuLQ5lMVcIT20sFFtjJJtaBfERy5cI7vXBh
 vfiDwEht0y3df/7VwIE22tySEwgCdaGDY4/vV1jbr9wTIzQDH+W9WSVfVS2L4B/7yCL/06m/WIG
 xg0Vwm9FcJDqWuVAR4SSfkc6IDjPfsx4RBrn4/I5ak5jPsLl9S6K0Uqf9ZebUWT2yCdVJW9o/eG
 f6aWZvxPdDmJ3L6n4DK5WLPzgKN/4AqJztpbDatP71S5pAAGi5rc0=
X-Received: by 2002:a17:902:f54d:b0:2b4:5b1a:d09c with SMTP id
 d9443c01a7336-2b5f9edb4cbmr406198335ad.15.1777210855865; 
 Sun, 26 Apr 2026 06:40:55 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:40:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 18/84] fpu: Drop parts_round_to_int
Date: Sun, 26 Apr 2026 23:38:55 +1000
Message-ID: <20260426134002.865628-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use parts{64,128}_round_to_int at each call site.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 1f03fcf687..e2341871bd 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,16 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static void parts64_round_to_int(FloatParts64 *a, FloatRoundMode rm,
-                                 int scale, float_status *s,
-                                 const FloatFmt *fmt);
-static void parts128_round_to_int(FloatParts128 *a, FloatRoundMode r,
-                                  int scale, float_status *s,
-                                  const FloatFmt *fmt);
-
-#define parts_round_to_int(A, R, C, S, F) \
-    PARTS_GENERIC_64_128(round_to_int, A)(A, R, C, S, F)
-
 static int64_t parts64_float_to_sint(FloatParts64 *p, FloatRoundMode rmode,
                                      int scale, int64_t min, int64_t max,
                                      float_status *s);
@@ -3128,7 +3118,7 @@ float16 float16_round_to_int(float16 a, float_status *s)
     FloatParts64 p;
 
     float16_unpack_canonical(&p, a, s);
-    parts_round_to_int(&p, s->float_rounding_mode, 0, s, &float16_params);
+    parts64_round_to_int(&p, s->float_rounding_mode, 0, s, &float16_params);
     return float16_round_pack_canonical(&p, s);
 }
 
@@ -3137,7 +3127,7 @@ float32 float32_round_to_int(float32 a, float_status *s)
     FloatParts64 p;
 
     float32_unpack_canonical(&p, a, s);
-    parts_round_to_int(&p, s->float_rounding_mode, 0, s, &float32_params);
+    parts64_round_to_int(&p, s->float_rounding_mode, 0, s, &float32_params);
     return float32_round_pack_canonical(&p, s);
 }
 
@@ -3146,7 +3136,7 @@ float64 float64_round_to_int(float64 a, float_status *s)
     FloatParts64 p;
 
     float64_unpack_canonical(&p, a, s);
-    parts_round_to_int(&p, s->float_rounding_mode, 0, s, &float64_params);
+    parts64_round_to_int(&p, s->float_rounding_mode, 0, s, &float64_params);
     return float64_round_pack_canonical(&p, s);
 }
 
@@ -3155,7 +3145,7 @@ bfloat16 bfloat16_round_to_int(bfloat16 a, float_status *s)
     FloatParts64 p;
 
     bfloat16_unpack_canonical(&p, a, s);
-    parts_round_to_int(&p, s->float_rounding_mode, 0, s, &bfloat16_params);
+    parts64_round_to_int(&p, s->float_rounding_mode, 0, s, &bfloat16_params);
     return bfloat16_round_pack_canonical(&p, s);
 }
 
@@ -3164,7 +3154,7 @@ float128 float128_round_to_int(float128 a, float_status *s)
     FloatParts128 p;
 
     float128_unpack_canonical(&p, a, s);
-    parts_round_to_int(&p, s->float_rounding_mode, 0, s, &float128_params);
+    parts128_round_to_int(&p, s->float_rounding_mode, 0, s, &float128_params);
     return float128_round_pack_canonical(&p, s);
 }
 
@@ -3176,7 +3166,7 @@ floatx80 floatx80_round_to_int(floatx80 a, float_status *status)
         return floatx80_default_nan(status);
     }
 
-    parts_round_to_int(&p, status->float_rounding_mode, 0, status,
+    parts128_round_to_int(&p, status->float_rounding_mode, 0, status,
                        &floatx80_params[status->floatx80_rounding_precision]);
     return floatx80_round_pack_canonical(&p, status);
 }
-- 
2.43.0



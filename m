Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB37FF885C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzkR-0000cm-0Q; Sun, 26 Apr 2026 09:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzjw-000073-N1
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:41 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzjv-0000KD-1j
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:41:40 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2b45cb89f7eso58476825ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777210898; x=1777815698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PMksPAG3r8+VLSRLaiSYmqjI0xhM/jgzuN3RWr1+Zpg=;
 b=mL6Lp/FXRdIbe6Dp7R/cL99R40N40c2qphu/LUMvmMq/aMnc5KgDntplGteauGDQVl
 f4x+Iw2eeDvo3F8DQgR5g8AN8gD5WaY2mbTCoJzmGxXiYr9qw2BDWu3moVDNBXyI0sAZ
 ymaMmDvtZJAqSDo2Kc16JEizUMUNUdUQTReTVj3tvflAhWz3moL9s0muqVLxp+EbgWZW
 Twzl9OuMZNEbWppUmmsg0fskzYJdt8/t6B+REVA5/EkP/1hqEoeLfB3iIOqSnXejj03I
 XHvliUasX0MUTVWSv0MUd4CU63AqAYnXgUfYIciIiaYHdXXOz3/qwz3N68r/94zXcVz9
 hnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777210898; x=1777815698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PMksPAG3r8+VLSRLaiSYmqjI0xhM/jgzuN3RWr1+Zpg=;
 b=PLSl60WbY8/8CWYvcsfNVf6GnYDTWFVlnHee1gSoKsXTfLy7gbq3mCClvfN0r7hlYe
 vuxfl6ZpMPsvbL863M+TLGNHkL+hLRT1t4odV2lkKmX7BAdYXbPPFNqjEw5/tL+Xvarw
 yK12fPNSS120NW60nyl+DUPdAxP3QLxAwj7VRyKLADL2kGzkvx8IlaZHi4Od/ujph3gM
 mgsH+UeW0fJ4dXMgD/hbIQBCXTeU83ydCiwEBQjD7jk8O8VR36wzjKKbRMoYWziCoYvD
 0LYi9Bh8u7VsNp5y12huSdlFm5lKk0Ox+OJLrsI4knwQiJ7sbvp3hu9cEC2+h04fQvHn
 5Hwg==
X-Gm-Message-State: AOJu0Yy5az5bn09y4C9N5mghTD/8Tlsap0FOItTA1t97fDaWYhnEZ703
 aaIv7UZ3g0kmNHvbJdFpy8SUDYRY+coViNi8lkSrpz7zKh26fXYlLOuzG0liAn1E1BL9njgso8Q
 NVp9VmXk=
X-Gm-Gg: AeBDieu0uCepuRD1MrJbWRYlo3/bQQvKfHPWLWkE+BwvLHtXUD2rUzqs3hPuMBat3Xg
 m0d89eP3oEICurVlL6FLZv3pXjBB9ggCt/GoCYImSyRYOQ0gQXrqK4hZJCKtelBVqPeIQ8T0UV5
 XE+tMLmBCYU4S67ppotrqmdFR4KZEsioST1vQzINXszGzFtK0E5hO//71JYAqdOOdrVRemZvEbb
 s+0bi26Oj0h0kG0Rawh90CBfxhmBqIR3Llzgu2mr0t4kT2YNg1C6T9Z9cHNXGUWxjJIjNVqF4vq
 h+gu8MPQ3ymtraiqJsdmEX776qMeWind2I1vgxCvQy7ThSrdhLQG/4X/jQ0/GAuuR9Sm8NpRDcY
 +pPguavsNJuTJYPsuFBYbububhbVgDD19mgY8HqTIhIL6+7Ll6GhSiqNVtGJUEfeCmV73oWjArr
 lso1xAM3EdE34n3e9tUBaKyCxn3UFgVSOL9ktnQirO
X-Received: by 2002:a17:902:bcc8:b0:2b7:af0e:5942 with SMTP id
 d9443c01a7336-2b7af0e8224mr102957755ad.26.1777210897505; 
 Sun, 26 Apr 2026 06:41:37 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm277940375ad.68.2026.04.26.06.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:41:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 34/84] fpu: Return struct from float8_e4m3_unpack_canonical
Date: Sun, 26 Apr 2026 23:39:11 +1000
Message-ID: <20260426134002.865628-35-richard.henderson@linaro.org>
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

Inline float8_e4m3_unpack_raw at the same time.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index c1d0140484..c1b03f30ab 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -646,11 +646,6 @@ static FloatParts64 unpack_raw64(const FloatFmt *fmt, uint64_t raw)
     };
 }
 
-static void QEMU_FLATTEN float8_e4m3_unpack_raw(FloatParts64 *p, float8_e4m3 f)
-{
-    *p = unpack_raw64(&float8_e4m3_params, f);
-}
-
 static void QEMU_FLATTEN float8_e5m2_unpack_raw(FloatParts64 *p, float8_e5m2 f)
 {
     *p = unpack_raw64(&float8_e5m2_params, f);
@@ -1475,11 +1470,11 @@ static FloatParts64 float4_e2m1_unpack_canonical(float4_e2m1 f, float_status *s)
     return p;
 }
 
-static void float8_e4m3_unpack_canonical(FloatParts64 *p, float8_e4m3 f,
-                                         float_status *s)
+static FloatParts64 float8_e4m3_unpack_canonical(float8_e4m3 f, float_status *s)
 {
-    float8_e4m3_unpack_raw(p, f);
-    parts64_canonicalize(p, s, &float8_e4m3_params);
+    FloatParts64 p = unpack_raw64(&float8_e4m3_params, f);
+    parts64_canonicalize(&p, s, &float8_e4m3_params);
+    return p;
 }
 
 static void float8_e5m2_unpack_canonical(FloatParts64 *p, float8_e5m2 f,
@@ -2701,9 +2696,7 @@ float8_e4m3 float4_e2m1_to_float8_e4m3(float4_e2m1 a, float_status *s)
 
 bfloat16 float8_e4m3_to_bfloat16(float8_e4m3 a, float_status *s)
 {
-    FloatParts64 p;
-
-    float8_e4m3_unpack_canonical(&p, a, s);
+    FloatParts64 p = float8_e4m3_unpack_canonical(a, s);
     parts64_float_to_float(&p, s);
     return bfloat16_round_pack_canonical(&p, s);
 }
-- 
2.43.0



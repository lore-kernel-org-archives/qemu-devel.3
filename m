Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99421FF8864
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzpb-0008UC-FG; Sun, 26 Apr 2026 09:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzoZ-00069y-Uw
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:46:29 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzoY-0001f1-3O
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:46:27 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-35d9f68d011so6121888a91.2
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211185; x=1777815985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oFscoPCXmC5wItps4ZK1oMdS8qcgvMlEJeB/ShmBOiI=;
 b=Z3z6DUAv/zR4iuLsTc5XJj0xSuEdNNqt54VQqQdV7iTvXod6fHd1qrpBbc7KXp65ZX
 ZsboBvItwCQ0i6YzOnBdbCVPtPkTjJO9rf9DrBhYywz0YJhm8yiAlgcVZ2rhb9tH9TdN
 VzRzssqW07spp9KxPNRLdz4Mt/gC3IJ2S23oNLZ2F7Z62Ouq0gsjKT+PfUMtzeqI7a+v
 YGuzvQeBEhlYkUxqm9IwpuwtJ2CVUZY36SfhWL7RlqwqZC5LZiSPR6l4buekazaGAQzC
 xuMNfi2vz5rr0Vvfm/ndtNyzzA15rA0694n4xs0t4NofhLyUvPU31ewIxJbU1r6RYyjT
 fw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211185; x=1777815985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oFscoPCXmC5wItps4ZK1oMdS8qcgvMlEJeB/ShmBOiI=;
 b=jRGnqPS69q+Zz1U34au/S+Kxs2uF8kXehfVHWYnBw4+GM3aHLt/4FZqG8Aq3QolgB2
 Y0WauKK9m0pohGVdRlPnLsUcdgciD+XqLA92680ebhi33IfEZve8NXdXLfC1HfCQGhKv
 uK1G5jjfuqaOyyw/0wlS0SdgEF/YV94pgm0EJSh7g5t4Gs/PK8vxaHC10lMuVMhaYk9j
 5pNI4/HMtJcj65VDLAhhvfDmKWnTLGjfX6xGLHaax4UdPhURGI//wnhiVenJLJPu4aW6
 oONTUB9xcFs6ujiDhcrrDi1HKa6lQihnLYRK7ziCJbrlXsBDqE9M62Jf0BcBSK0F/Z1D
 n2pw==
X-Gm-Message-State: AOJu0Yx+cwPhO4r8N4fkCidZT070Y1JKdnW9ZzeJJN6JciHrea4fZy8j
 qr5H/eIyxH3kh87F4/7lw1t8i28Hm/EQKjiO6Br1Sn4oS04fV1WF/Zbja2F19P7fkJfQzYwWqu9
 CeFWonSg=
X-Gm-Gg: AeBDiesG57ncXEHl/XXaMSE995z5CIpcXj64c7/pgOwde4NbJeQfmqkhlK6/xbZT909
 qKlga8VQBSEn/ZAssFMGbCwgRWTkGbJVuOQMw6gMOIWIZLV7auOFQyf24DsfIxmOL/Rw/mJPan3
 MXIpnuxxVd3UnvfPVK5q28x7H/hbNE8zjoaL8gHGQn7ULVMUPCHnoeqruI6sSs0PhzWLYwCIz2q
 AofO5Dk3SA9MmS4J8zcok64/MFrO/41tzQvaBHnEgm72w7hyDKCsw7RKbY+43t3b1jX8yBx9tO6
 ZENkiy479ikF6WG8irIJ5SxV+YaZUBl4b1PsPVs9uu1giufvtolhlNUASueqX1VszQtSDfiaf+t
 mkHdtnwGeKFIx6Cg2bTGvVjh9rtXCLNFCXjTq2SCB5LAUbbNZAwDOGi+0dw2wy9ULxe6k5uTT5V
 2Mln5x1exP2SmxaSE6qNlpPx4evnNX+llZ1VODp6wy
X-Received: by 2002:a17:902:bcc8:b0:2b7:af0e:5942 with SMTP id
 d9443c01a7336-2b7af0e8224mr103039985ad.26.1777211184735; 
 Sun, 26 Apr 2026 06:46:24 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa34ea7sm280544085ad.34.2026.04.26.06.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:46:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 72/84] fpu: Return struct from parts{64,128}_pick_nan_muladd
Date: Sun, 26 Apr 2026 23:39:49 +1000
Message-ID: <20260426134002.865628-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 87460306f4..5eaac357ec 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -114,13 +114,15 @@ FloatPartsN partsN(pick_nan)(const FloatPartsN *a, const FloatPartsN *b,
     return *ret;
 }
 
-static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
-                                            FloatPartsN *c, float_status *s,
-                                            int ab_mask, int abc_mask)
+static FloatPartsN partsN(pick_nan_muladd)(const FloatPartsN *a,
+                                           const FloatPartsN *b,
+                                           const FloatPartsN *c,
+                                           float_status *s,
+                                           int ab_mask, int abc_mask)
 {
     bool infzero = (ab_mask == float_cmask_infzero);
     bool have_snan = (abc_mask & float_cmask_snan);
-    FloatPartsN *ret;
+    const FloatPartsN *ret;
 
     if (unlikely(have_snan)) {
         float_raise(float_flag_invalid | float_flag_invalid_snan, s);
@@ -160,7 +162,7 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
         }
         ret = c;
     } else {
-        FloatPartsN *val[R_3NAN_1ST_MASK + 1] = { a, b, c };
+        const FloatPartsN *val[R_3NAN_1ST_MASK + 1] = { a, b, c };
         Float3NaNPropRule rule = s->float_3nan_prop_rule;
 
         assert(rule != float_3nan_prop_none);
@@ -179,13 +181,12 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
     }
 
     if (is_snan(ret->cls)) {
-        *ret = partsN(silence_nan)(ret, s);
+        return partsN(silence_nan)(ret, s);
     }
-    return ret;
+    return *ret;
 
  default_nan:
-    *a = partsN(default_nan)(s);
-    return a;
+    return partsN(default_nan)(s);
 }
 
 /*
@@ -698,7 +699,8 @@ static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
      * off to the target-specific pick-a-NaN routine.
      */
     if (unlikely(abc_mask & float_cmask_anynan)) {
-        return partsN(pick_nan_muladd)(a, b, c, s, ab_mask, abc_mask);
+        *a = partsN(pick_nan_muladd)(a, b, c, s, ab_mask, abc_mask);
+        return a;
     }
 
     if (flags & float_muladd_negate_c) {
-- 
2.43.0



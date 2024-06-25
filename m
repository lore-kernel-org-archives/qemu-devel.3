Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C55DC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 23:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMED6-0003uj-Bo; Tue, 25 Jun 2024 18:00:26 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMECm-0003sF-0G
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 18:00:03 -0400
Received: from [2607:f8b0:4864:20::331] (helo=mail-ot1-x331.google.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMEBt-00046X-E9
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 17:59:41 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7009b8113ebso2628414a34.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 14:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719352652; x=1719957452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mj7QlXoeP2V1pOBsxsghEG+3S3aDNGmpRLT6MqBN1Ws=;
 b=hFIni6GNtQE03mQNEVVb2gXCaYhWn0MkZUnLhAHNsJzE+AR9UJDPmKSakOnegPdAky
 xZWGx8szxLiArTEMYR0LFCxRChwYcFmD2WQ1amJaWtcXA88/yboIbg8xlYNA1FaKmAtp
 Zgh/sCGJXx9WrmTG11J4kPUn6DL87JpNTMZnEFcftKyZOm8QjzMXNM5Df/2QfV3SEUeA
 UnW8kzpUymYTL1H2DWRx4/0Ei4D1C3UMqlXSsSmVo/+3eyVFWAgDaXfD8Sk8H3bh4tnV
 HP14EWyD/UDzfvJbg1XYKc/fgPKaN8WVoD3YJKKs8d7DRdkMNwRaxmwdT+tqVfmJZAP8
 VHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719352652; x=1719957452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mj7QlXoeP2V1pOBsxsghEG+3S3aDNGmpRLT6MqBN1Ws=;
 b=QlP+W7tJutkouutacDDb7i3g8tVgD8bq50CnpOQMS0J4qzTS+OV12t250Shbr61oMW
 Go7gbRBPML8VDoMyqpwDwbe+5IMJ3XKXFxPrgCY6gmz+ak3CkagD5tNyzBCyfhaz130z
 LIeMcUAKDEPR02QvgKHmthpS80jKTrS3MdgC+/VYI8NUaD7yUZFgA6ziI6DGEWWvr5+Z
 C6Lard5KWufyGzo5uxlvuQ8czrMtjnN0rAa7UAKpgxVpL56jxDwi3F29ibfrtqi7SX8K
 4ldo7TIcP51pOaOpMMdZcWbNZK0MxyIQWmerdjyLkV8Ku0cJ+pa6Ke6+352d9FQWuZgH
 DNEQ==
X-Gm-Message-State: AOJu0YxDEAmMQ1i9jEfVzWG6a7a8tQfVXaAb8h0xLOiZMWvtIfpr6fWa
 R8KacOtv06gPDojC7jXclnvh5hEcar5LHraS5HoDcieK0Jx0reyRYuY9dmxorIut/iMHT8Y8v1i
 0
X-Google-Smtp-Source: AGHT+IGmRpKU3uisicIyQkWV9U+fNDMQdfLn9q2ukyi+z3KUtk5TQAzgrypIuxul2gUK+0Q1sCvmaw==
X-Received: by 2002:a17:902:bd07:b0:1f7:23d9:f530 with SMTP id
 d9443c01a7336-1fa23f8df23mr67334385ad.66.1719340539628; 
 Tue, 25 Jun 2024 11:35:39 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb3c6027sm84693235ad.133.2024.06.25.11.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 11:35:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-stable@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 02/13] target/arm: Fix SQDMULH (by element) with Q=0
Date: Tue, 25 Jun 2024 11:35:25 -0700
Message-Id: <20240625183536.1672454-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625183536.1672454-1-richard.henderson@linaro.org>
References: <20240625183536.1672454-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2607:f8b0:4864:20::331
 (deferred)
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, PDS_HP_HELO_NORDNS=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The inner loop, bounded by eltspersegment, must not be
larger than the outer loop, bounded by elements.

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_helper.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 7b34cc98af..d477479bb1 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -317,10 +317,12 @@ void HELPER(neon_sqdmulh_idx_h)(void *vd, void *vn, void *vm,
     intptr_t i, j, opr_sz = simd_oprsz(desc);
     int idx = simd_data(desc);
     int16_t *d = vd, *n = vn, *m = (int16_t *)vm + H2(idx);
+    intptr_t elements = opr_sz / 2;
+    intptr_t eltspersegment = MIN(16 / 2, elements);
 
-    for (i = 0; i < opr_sz / 2; i += 16 / 2) {
+    for (i = 0; i < elements; i += 16 / 2) {
         int16_t mm = m[i];
-        for (j = 0; j < 16 / 2; ++j) {
+        for (j = 0; j < eltspersegment; ++j) {
             d[i + j] = do_sqrdmlah_h(n[i + j], mm, 0, false, false, vq);
         }
     }
@@ -333,10 +335,12 @@ void HELPER(neon_sqrdmulh_idx_h)(void *vd, void *vn, void *vm,
     intptr_t i, j, opr_sz = simd_oprsz(desc);
     int idx = simd_data(desc);
     int16_t *d = vd, *n = vn, *m = (int16_t *)vm + H2(idx);
+    intptr_t elements = opr_sz / 2;
+    intptr_t eltspersegment = MIN(16 / 2, elements);
 
-    for (i = 0; i < opr_sz / 2; i += 16 / 2) {
+    for (i = 0; i < elements; i += 16 / 2) {
         int16_t mm = m[i];
-        for (j = 0; j < 16 / 2; ++j) {
+        for (j = 0; j < eltspersegment; ++j) {
             d[i + j] = do_sqrdmlah_h(n[i + j], mm, 0, false, true, vq);
         }
     }
@@ -512,10 +516,12 @@ void HELPER(neon_sqdmulh_idx_s)(void *vd, void *vn, void *vm,
     intptr_t i, j, opr_sz = simd_oprsz(desc);
     int idx = simd_data(desc);
     int32_t *d = vd, *n = vn, *m = (int32_t *)vm + H4(idx);
+    intptr_t elements = opr_sz / 4;
+    intptr_t eltspersegment = MIN(16 / 4, elements);
 
-    for (i = 0; i < opr_sz / 4; i += 16 / 4) {
+    for (i = 0; i < elements; i += 16 / 4) {
         int32_t mm = m[i];
-        for (j = 0; j < 16 / 4; ++j) {
+        for (j = 0; j < eltspersegment; ++j) {
             d[i + j] = do_sqrdmlah_s(n[i + j], mm, 0, false, false, vq);
         }
     }
@@ -528,10 +534,12 @@ void HELPER(neon_sqrdmulh_idx_s)(void *vd, void *vn, void *vm,
     intptr_t i, j, opr_sz = simd_oprsz(desc);
     int idx = simd_data(desc);
     int32_t *d = vd, *n = vn, *m = (int32_t *)vm + H4(idx);
+    intptr_t elements = opr_sz / 4;
+    intptr_t eltspersegment = MIN(16 / 4, elements);
 
-    for (i = 0; i < opr_sz / 4; i += 16 / 4) {
+    for (i = 0; i < elements; i += 16 / 4) {
         int32_t mm = m[i];
-        for (j = 0; j < 16 / 4; ++j) {
+        for (j = 0; j < eltspersegment; ++j) {
             d[i + j] = do_sqrdmlah_s(n[i + j], mm, 0, false, true, vq);
         }
     }
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EE5C30659
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 05:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLyPp-00015Y-QR; Tue, 25 Jun 2024 01:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLyPi-00012M-HV
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:08:20 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLyPf-0001VP-SY
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:08:18 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-6c4926bf9baso4202472a12.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 22:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719292094; x=1719896894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YQcO2r2IZyvd41q48Eu940ny4a3LvMma1E5P7T03ZrI=;
 b=A+8GtcjORd6IZ6YITkLKB5gbb5IvRbvOZkOOsJvOEjOt+vtaLG6JbSjOi+khxO6fTA
 Mmap4Lc4rAcNVI9DNqs1xYhvkp05hrk6SR2NZ6ryPggv6/NI0rJ+LZrRbDiPO7w/qMEW
 EK1Jprd3z9khkQCt5onENcR1Kyqe6ArAj3gAjNACGB1KooKzpxrl25N22xxSUs0eEaG+
 VEEd6xGM1RqN21tdBfffUUkVAvnn4nD1GVHn82wp2aC+wqnjWNwiz8MWiKl9bLnEmNLb
 Mk9UzvRiFsQbxeZyjndtaJUHIdARfWEmrxU3s4/dzQha/CQrW4//TzyRY24jRAPxIieC
 xGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719292094; x=1719896894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YQcO2r2IZyvd41q48Eu940ny4a3LvMma1E5P7T03ZrI=;
 b=TdHCu4HlVUTLpANS0yIWd19wsTMIXBbcdCHwvKQuv1ZOxYzEdotdqyncSjbRps998g
 jR6zO/Kj4GYtm7sPdEk5yvr2vkMOTy9LwuRXlo+9ckxAG9W3yCcPFDHZQrjB+I+Y5tz3
 oF5LGb97VEMJaHMXZ2XQ8yjKtUeT9YrNF1GlwWUCsexp49GSRw9c2qcaGnsEH3w6iEKC
 4VmTrMuIAFW3Cn4kYWtW0/T3iWwRv21ru6Jh5KIgYFLTqjIZNAlzbqp89zQd7VI7tXrL
 m/T4uehE+WfUG18XwmK+Pk3mkBEqNm8c1nDCOvLNwmRf7lzB7upOFyQjnpPTb5+t30zS
 4HJw==
X-Gm-Message-State: AOJu0Yz5R5pbDIBDVzLPuZZIkma6Ifce8xVlB/U4+2riZzG/3CZOmvqN
 YSxTIx6vPfbiH1dISbV0N8BLstLH/5dneqHebIkerE9pC8P/lNAttvNd1prrj3vVcTKoS0aZtDg
 V
X-Google-Smtp-Source: AGHT+IFS7llonFXHEW804uNLpkBm2l9kxGuA8TkGIPLfMDZomNWv/ota1UykzSaNAhGOJ7lS69Gr7Q==
X-Received: by 2002:a05:6a20:b313:b0:1bd:23f4:df70 with SMTP id
 adf61e73a8af0-1bd23f4e114mr17411637.52.1719292094215; 
 Mon, 24 Jun 2024 22:08:14 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9ebbc72e9sm70843865ad.296.2024.06.24.22.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 22:08:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-stable@nongnu.org
Subject: [PATCH 02/13] target/arm: Fix SQDMULH (by element) with Q=0
Date: Mon, 24 Jun 2024 22:07:59 -0700
Message-Id: <20240625050810.1475643-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625050810.1475643-1-richard.henderson@linaro.org>
References: <20240625050810.1475643-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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



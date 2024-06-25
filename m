Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6CDC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 18:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMB9l-00022Z-Ay; Tue, 25 Jun 2024 14:44:59 -0400
Received: from [209.51.188.92] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMB4Q-0000yt-PG
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 14:39:24 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMB3F-00065t-QQ
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 14:38:55 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f9ffd24262so29413655ad.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 11:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719340539; x=1719945339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1U9RNUfZ6ytehLhNDsOYxOlk3M9sl8ak/3adIT4lPPs=;
 b=FSaVAbvsbH86ywlHsxkot+XmbgYj06jzfUDfEK9meXlb42S7xGIySdDS1kLfUuqwZR
 jy19RRYe6ed5Y9FBg25wKhrqEEwllkWLhYq3RBCRi821zhodOdUWGprRyo8woQUHKOAG
 RCbQEjEhv0UE4qVKuk8gAwmfS9r3qS/7vw7QcxXrJysWN8fPHjXfINc/Eabva/H+tumC
 m1Ms+oxsaTLHV2FCX8pkzF4T/2SNSij3gdtWO1LhEfd1rm4TYRZ3PHiH+oLynHEfU9JC
 /MS8Jh0c6iYLcc/sfXDYiBEXtAGUozSgvb2loJqYb1VX76W3H0h6f/vn5N1urTSwCDSG
 ds5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719340539; x=1719945339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1U9RNUfZ6ytehLhNDsOYxOlk3M9sl8ak/3adIT4lPPs=;
 b=Ln7KixviXPsP0Uy7yeENaSj/9qx0di/Nsl7LMq5FBrAYCkXvRcALkNFZQjIUE9VSmr
 IoZEbJeJm8RtmaycQykUI0znMOzqGtE0Mwlnhagc6BfRvU1R8O2oIuwvTsCGnO0pT2ZP
 BV0mlwLSJLPeFl/cke39jz/+zuuTdu67wv3S8JtNMMepu1CeYp0p5m0mAQsbb7ktLtmB
 okgSQZuJq7Hhv4vbwLlhf17VvY0LJkWRhk5QAaLTv7777Axc57k0N2ftiJBBVrMgjCR2
 T+2hy8e+eZmtrEJchDzayfW3dBix7Vj4lHj7SKBO/zSS0jwxzMNF5v+06/r3O4ge7SxL
 zb8g==
X-Gm-Message-State: AOJu0Yy/xYjF0kgaOKwi6+SS9yS4yd69zblIGHI/bwaqkYSc5klvoQ2R
 rW1UdCSeEL87njb7/zuhgcTciGt6M8lq43sjRm1y00LIvQghCXGjJJiSzGoW7F1sDHQkSsF9L+J
 1
X-Google-Smtp-Source: AGHT+IGNyBXQLDqgE9brreM9lqFudZ5fw73YuRvu2DhUPtADq8ONoT+8VGzcWT5VvgrG6vkOuX8tdQ==
X-Received: by 2002:a17:903:22c3:b0:1f9:df92:d67a with SMTP id
 d9443c01a7336-1fa23f9e4aemr97804585ad.23.1719340538680; 
 Tue, 25 Jun 2024 11:35:38 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb3c6027sm84693235ad.133.2024.06.25.11.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 11:35:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-stable@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 01/13] target/arm: Fix VCMLA Dd, Dn, Dm[idx]
Date: Tue, 25 Jun 2024 11:35:24 -0700
Message-Id: <20240625183536.1672454-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625183536.1672454-1-richard.henderson@linaro.org>
References: <20240625183536.1672454-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
Fixes: 18fc2405781 ("target/arm: Implement SVE fp complex multiply add (indexed)")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2376
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index b05922b425..7b34cc98af 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -907,7 +907,7 @@ void HELPER(gvec_fcmlah_idx)(void *vd, void *vn, void *vm, void *va,
     intptr_t index = extract32(desc, SIMD_DATA_SHIFT + 2, 2);
     uint32_t neg_real = flip ^ neg_imag;
     intptr_t elements = opr_sz / sizeof(float16);
-    intptr_t eltspersegment = 16 / sizeof(float16);
+    intptr_t eltspersegment = MIN(16 / sizeof(float16), elements);
     intptr_t i, j;
 
     /* Shift boolean to the sign bit so we can xor to negate.  */
@@ -969,7 +969,7 @@ void HELPER(gvec_fcmlas_idx)(void *vd, void *vn, void *vm, void *va,
     intptr_t index = extract32(desc, SIMD_DATA_SHIFT + 2, 2);
     uint32_t neg_real = flip ^ neg_imag;
     intptr_t elements = opr_sz / sizeof(float32);
-    intptr_t eltspersegment = 16 / sizeof(float32);
+    intptr_t eltspersegment = MIN(16 / sizeof(float32), elements);
     intptr_t i, j;
 
     /* Shift boolean to the sign bit so we can xor to negate.  */
-- 
2.34.1



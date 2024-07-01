Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF16C3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJZp-00024l-RJ; Mon, 01 Jul 2024 12:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ5-0000fx-GM
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:41 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ1-0005Pv-6q
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:38 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ec5fad1984so44297841fa.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850053; x=1720454853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GhKst7WHN9ASn36oUshu4tgIXvUX+N4f2K/V8e/wSkQ=;
 b=d1xM7R2M+W+05gDqcDAGKx9xZMUi/baONBD8QTyXK52amGj0Nzq5+J+00tV3H64a5u
 WnLMBh0R7urrk11Os005oLG8fm2hZylveE4l8kzcAz7uCfYIuPAECFUzo48f9iE90oOt
 Me3VRpUt7v9VHWYYY6cS3opuaMPHcIdW7WJyxq3KbZj1vf3Ga02ZJgSWD7l2+u6kw+e4
 A14Xx6TK7b1wlEX9Vu+rWAb2H9J2i8rqoPBcl8FCSOP4v0zksH4QWvrERXwLS+KRpM99
 Smqmo/gqOMfO7fprWRZZwKDeBSTt/BafUZyySHmIUwSTnliCK0E8D+G7Uw2QywpNZR6W
 ommw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850053; x=1720454853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GhKst7WHN9ASn36oUshu4tgIXvUX+N4f2K/V8e/wSkQ=;
 b=nlg02bxDX1D+89MLaLmkrEco5+dOT4fWiWfsP5LK0O2JkOclLBSzA+GtA4Ac9tf+S1
 2RqnJuDaJDoYUdV4uu4l6iC7cPL3Ph1eBjqH13vyhhe5BapcQ3BJUDCF2ZDnnj06z6g+
 f4TgyXiKN3uNt5y5wl9dNsGoGnX8xPT1E2EtRuB10QaLL+yhmgBrsAglTCYc+QWh7xkx
 8WVb9gJJUaFXdkYJwlSNAjCtZ7Q3uGtJWdaM75fz5Jiy/1W1I6lINrEEHqtdd+4qNcUj
 BqXdvx6jguapMORmYuuC4AIhIjcQH24Yu+TXHDR4BfKDRYy0JuBO4jSCcV+p5KTJQM/d
 rgBg==
X-Gm-Message-State: AOJu0YxSgO9jpamGm/jGf6aNixeW1caBkIIsjQndilCMmxNbEzXn3g+i
 nbAvucFO/3rW+PARM51t2j1rzZY8Svc35UG8BTUokqekQ31vWJbmsxWl2fJuT2vVwQ/Ou0Glplt
 YRqY=
X-Google-Smtp-Source: AGHT+IEFyWPJBOu1k/R+9QCR5SpWkvAnAsfKylbIyponkj8lvrS2vKRv0Al9iS/48xfT8E0NXf/W+A==
X-Received: by 2002:a2e:bc04:0:b0:2eb:2e0b:72c with SMTP id
 38308e7fff4ca-2ee5e393e7emr52167731fa.16.1719850053546; 
 Mon, 01 Jul 2024 09:07:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/29] target/arm: Fix VCMLA Dd, Dn, Dm[idx]
Date: Mon,  1 Jul 2024 17:07:07 +0100
Message-Id: <20240701160729.1910763-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

The inner loop, bounded by eltspersegment, must not be
larger than the outer loop, bounded by elements.

Cc: qemu-stable@nongnu.org
Fixes: 18fc2405781 ("target/arm: Implement SVE fp complex multiply add (indexed)")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2376
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240625183536.1672454-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/vec_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index b05922b425f..7b34cc98afe 100644
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07118C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMjn-0002uU-Gg; Tue, 03 Jun 2025 04:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMjI-0002FJ-MP
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:10:46 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMjE-0005kx-B8
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:10:39 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ad891bb0957so936014266b.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748938234; x=1749543034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h/En86MJA4wGrPSUzTe8W/lAeFa1J49kbPISU8uT+6U=;
 b=O+s79kMLwAklvxfzZDNgoXAQPXA3t8W+QXRBYg1SlL+5Pva73Gg4WE+3fhgiwIKx+Z
 qb+03GMY4Hvt8vkHYiQEMbIWpWg1u08bQVjuNr9R9SmC1R8Sry8FOH3ptVS9fjmi98au
 E7Hsh45msmWP2FX7a0aoRw6w/XNqnrBjb8evgb3EKKRc35uPWnTnqKFxdav+c+PjpZf/
 lOl4aJ3hZeBGJ4xsJslTf6wN3eogAInLva341Uvw4pzbd6Sxx9rrS0CF3t3/S3vhjrQ7
 XTMue/Lb8trXGYXClE21JckJiX9pr9mmw8mPPkKY4eX3WVsorVTtfXqPVZDVGAV/TBsM
 W2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748938234; x=1749543034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h/En86MJA4wGrPSUzTe8W/lAeFa1J49kbPISU8uT+6U=;
 b=NPEqBBOtIBQWc4Wl5PmIUsvH+c25C7Zb8HnpStIIX3DHBMLXuZk2M4q7PEZCQwGjkf
 KDiDkF1BskwYjg7TzSg8wdUv/BIP7UKAZ8mdM0Af3ma4faqmCH0LPAsByHwc4+wmEhXg
 GnuCPyKl92HEnYltdP50AOGYd/xJ65kI8Dbnou58q7Frp4bOH+vlnvDx9/aYnu3U6maG
 L5rmK0HBZYcn9PfrFAbxY8uVTja5NQc11q4q77VwvEK+DvtPYn+m0EyPLIzxuYhxELD7
 47LdyoQpboMLmr5mAXxYVfOpQ9wdkTqlwDBB8//dNemqzR2rbn62NrF2dreDMVJ/dP89
 29Zg==
X-Gm-Message-State: AOJu0YzlU3WAGi2/2NEDw32BA0Qc1hbvzi2xsnMwRMotR35qEkpOsY53
 IXMPZxA4DJOx2hbE00nmxCDVIm3HKhg/Mmnn/78FUbKf6kGHyhhsJjsjWK44rpJ3eEbK1X6YsaT
 U6BI6Yzk=
X-Gm-Gg: ASbGncvGwtf2bsvC6M7KJi2LDCVziwlkd2m7Im6xafDirzTCFUkQV6L4DMtuQ41bsFy
 n9sifBLCuppaPpm/YI7J+Nwm2kZZz9Za+zfgeee2sLWwp4fJh2HBUpNhBMXY4ml7J9liMdsGswB
 W0tG8WGZuCwiBDaj8DXPPGpeBCWaUlU4Zijq0LXbLFSJsO88LYhPQT0/4bvgqAorJmRUAF2tTbq
 14ste3V8PzMM+R7CfWnG2tQARlQQ7VHVAjKTYc9+gCHkQSHcF5eF8IuJ+ghuDRzXVuIKXQivf8s
 s/1XgLVhQ26ahQZaB2ZuyZpzFkfoiJEzYWhuvQrOQfstxAEe38NtDR0QygR9qUBAxlHio27EjN1
 ISMaVHCREm5Ee
X-Google-Smtp-Source: AGHT+IEYyB5R7Js1OG3cleAqj6nbUgRrl8JH7NbDvU83YRhDG0usAzn+YjvnavjbA15iKE3n9Yc1iA==
X-Received: by 2002:a05:600c:a088:b0:442:f97f:8174 with SMTP id
 5b1f17b1804b1-450d6547524mr161838295e9.18.1748938223862; 
 Tue, 03 Jun 2025 01:10:23 -0700 (PDT)
Received: from stoup.lan (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009ff7asm17668852f8f.90.2025.06.03.01.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 01:10:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 10/27] tcg/optimize: Build and use one and affected bits in
 fold_or
Date: Tue,  3 Jun 2025 09:08:51 +0100
Message-ID: <20250603080908.559594-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603080908.559594-1-richard.henderson@linaro.org>
References: <20250603080908.559594-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index d22396f6d7..ce065d0e22 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2263,7 +2263,7 @@ static bool fold_not(OptContext *ctx, TCGOp *op)
 
 static bool fold_or(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask, s_mask;
+    uint64_t z_mask, o_mask, s_mask, a_mask;
     TempOptInfo *t1, *t2;
 
     if (fold_const2_commutative(ctx, op) ||
@@ -2274,9 +2274,15 @@ static bool fold_or(OptContext *ctx, TCGOp *op)
 
     t1 = arg_info(op->args[1]);
     t2 = arg_info(op->args[2]);
+
     z_mask = t1->z_mask | t2->z_mask;
+    o_mask = t1->o_mask | t2->o_mask;
     s_mask = t1->s_mask & t2->s_mask;
-    return fold_masks_zs(ctx, op, z_mask, s_mask);
+
+    /* Affected bits are those not known one, masked by those known zero. */
+    a_mask = ~t1->o_mask & t2->z_mask;
+
+    return fold_masks_zosa(ctx, op, z_mask, o_mask, s_mask, a_mask);
 }
 
 static bool fold_orc(OptContext *ctx, TCGOp *op)
-- 
2.43.0



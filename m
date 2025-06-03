Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB630C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMkp-000116-WC; Tue, 03 Jun 2025 04:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMkj-0000n0-KP
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:12:09 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMkh-0005vx-FH
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:12:09 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-451ebd3d149so921445e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748938324; x=1749543124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J2GrhITiUEId9uURHoQBm+QSLG5+mucUTsm7cNKS9ak=;
 b=SuVz+V2rwvo9LZbAfbsmdl/7RqYNDgE5avjMCe9LAzQnj1fUwB4D0h9C2o3OVpBCUX
 nn/dlBwiWu5CYkvPVPUqFXfp31T5o5lcZMWjMlLvtA9HJkw6lcfmSzUxHnREFDExOB/h
 uIcTTD7eFfs7Kt2yuZTmxgLIEThzqzpQ52+pp3w6/X5Yj+gi5nf0b23lGS4F5UKTo9UB
 ECakS5HTAlXigJ46vzziXCyuJWgR0pqdOjOttRAcM0Zf7bk/dEhI3hRYq/51ORPQsBlj
 obLTfI9U8tXxkXIV0qyyI8/ZMwUUDM8Mt8QPjt0Hj+jhtTPu3JC0IR32tbC70lZ0FuAy
 +ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748938324; x=1749543124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J2GrhITiUEId9uURHoQBm+QSLG5+mucUTsm7cNKS9ak=;
 b=Em81QcLi9dSlR2UT4HXR8OjjKmKxK0HNVTBeHjmwq9PoieXCztDrRHJ1vUZ6AWikef
 tAit3SY3W7cXojb8wxp7f8lAN1FEs1oCWKYhF6jOKwZYC/JZQn/9w0dH70k3o9VhNmbQ
 cjZ5T2dUVZDaZn9fopLZA173mQ5a0GggT6Yp9/DIinCFx5RMKplpIE58U/OD7C/898LT
 r9v5DOeJJwUHvzZyhFpHxDV5Crla0xm/Buly9mMBIdRV2BU3Nwl5h+UcMPqAUEVs5Br6
 bJvDwUjc3fRyleubmAOzF+1gjA5pJCL7cSGC53ui6KmyoY7Ane2/OMOcyiSDTZdMWkhz
 cLbA==
X-Gm-Message-State: AOJu0Yxd6iQuVyz6FfED7bIRk3Vf/O36L1mHy7jZFmbBOpH5cLlAFdZK
 /XapzeCgbXfJ+PNyXHaUbGxegA7SVyCmrKcRtxFpV8uoqqJp8G+1FCzv8o/hn85UwUOC4/7RKeY
 7+bWHjNg=
X-Gm-Gg: ASbGncs9ZDhxjeng77Vpt4iOYybMQbgpVdovjVVBBZ0hXDuP8PPUBtsoS3VhmiUNRHn
 5RkvMyjoD8eWBgp3ObZZsbYN+3DcXO/K+XZlv9XGN8Fq1FfAfTmJSyoEjLnGEQ1cTHbZ3plt0qj
 49+WsUFsISkgPM9Il8rqLR6Qbt9JRfpy2RoBvcclWMJc1jaSIomCxetyBDBiEq7vOd4pFpslOiM
 Igaz2L1CcWFrXH0A2GWoAU/mGWLsZ5Cg7dm9U0xBfOA8I2TxeDXLLGqt4s93++LxSm1omMW7TbV
 e07U+WKJAgvG+ELDJkkRbWnqsMNLAdw8+EnQpSLzbp4Nonm1OHc5OeW6NIExqfZxUZrbwdr7mOn
 1uKpjv5jC8+0C
X-Google-Smtp-Source: AGHT+IFc5D1Gyg/PvIHjXnj2ze3ElATJYynIrC3qxEg86pB9jCwwGRDILuuPXGmkWsy8y1TCDgUibw==
X-Received: by 2002:a05:6000:250e:b0:3a3:7cbd:39b1 with SMTP id
 ffacd0b85a97d-3a4fe17c35emr9371624f8f.24.1748938324630; 
 Tue, 03 Jun 2025 01:12:04 -0700 (PDT)
Received: from stoup.lan (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009ff7asm17668852f8f.90.2025.06.03.01.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 01:12:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 27/27] tcg/optimize: Simplify fold_eqv constant checks
Date: Tue,  3 Jun 2025 09:09:08 +0100
Message-ID: <20250603080908.559594-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603080908.559594-1-richard.henderson@linaro.org>
References: <20250603080908.559594-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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

Both cases are handled by fold_xor after conversion.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index a48ddd9171..62a128bc9b 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1948,9 +1948,7 @@ static bool fold_eqv(OptContext *ctx, TCGOp *op)
     uint64_t z_mask, o_mask, s_mask;
     TempOptInfo *t1, *t2;
 
-    if (fold_const2_commutative(ctx, op) ||
-        fold_xi_to_x(ctx, op, -1) ||
-        fold_xi_to_not(ctx, op, 0)) {
+    if (fold_const2_commutative(ctx, op)) {
         return true;
     }
 
-- 
2.43.0



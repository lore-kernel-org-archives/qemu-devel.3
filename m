Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A55606A322
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=M7kIE/Xc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXFT-0003db-L4; Wed, 21 Oct 2026 10:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDW-0001l9-Hz
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:58 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDV-0002Dw-57
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:58 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a1698ea378so5925765e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592575; x=1793197375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+vOeGvl68iVcHgbOnfaPlEP9zKP8Z64Jg5FVIJi3STM=;
 b=M7kIE/Xca4QOBB6lmK4/TSp9nsqXdeh1qDiyU/F0EmZi8+0dlXHphgwj31Jj1aVRE7
 1KQo9ZggpXCt9/yluSih6N1ZFMUhAPX0GP9DyuRK/CZpQagi9tzPeAHqIA9yobsLOPQu
 Ykh8LX4GAglyEERS5BPuTWv/IAb490GjJeCR76P9q8aPNcbx4RF8Gs/R5reLD0+V1DYn
 PiK3+CBKft3NBEGriqAUSgvKBtzYnCBuIXUX2qKeqTxzIp/7MC0LIOfzZAtL566zussc
 IORgUD4nOX0Q2HMdvX2YLe2jfd1qf9gkkM1Q9YNqq11zEJLhwaqSTBsFNi/rCT/rXUAp
 VMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592575; x=1793197375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+vOeGvl68iVcHgbOnfaPlEP9zKP8Z64Jg5FVIJi3STM=;
 b=bE4UmXY8Dm7Pc70Nppf7Z87LrLVoBexvkVglliXJEI41ExZRxz5UsdpLhFAAtguYkD
 JKfqag5g/eZvRA8MS574SR2J3VIDkfVCWdVnt57GmDHYJFUSeEvgEJJsJ/bWsI9xtMEE
 WQJxj4O8Cpv8PD4QQGQL+IAxdln66EuoXov9Je0+fJE2A+YOq2uFAmqCVEW1eg9e9RWJ
 CTE+zX02+aCVOObW/CfnTQVRGM0TCARSjS5fFwfgN6butALUJ1SdMpt4ZhX/OfNVw4Kg
 XMJmdQIlMltyaZ53QVMWaRkcdywJ9LPTLqVTtXtJgPYuumu85F7iFiGrcaBaYdfUDW0j
 0NuQ==
X-Gm-Message-State: AFq9FYIvdpwVyG09FbHNHaXQExnp238u7CToU+rnOsGH6ND09otgRxpe
 1zJIuZJTqy0ajImidS7heJhNnqwrcOs8YH7C3rPRLORKn1s8oPkQDZKOuczf9ls5260vBUcJKmN
 DQIzvOQM=
X-Gm-Gg: AYBFou2mASQVOqgdO3/85lBt66ndWlZ70Sw9P0wE7JV2IVcV6QPl85LfLD1yPDRhqXK
 gRHDvmVItdlN2/Jp7IDcxPaFuLh2+BQO3A+LCYApreakcbPJI+Bk3GzsoBi9r0I5O5TYVH9z63u
 Ofi3gBA9HZ5PRMPxT696s+dwGi5fH6k9V1/DkDUG9c4AVo7JLm68JYR4YkNs6qIHqIridClhdks
 oVpSziVO0tFi07HYjPhCVlUZyJvlMkphTL1kgFY9tLQ7cxJAxOBSzB7CMUkmdhtHf8OkHfaF5sD
 54YMiBIvyw1h0Egj4HFKXVgKNiHaE5y8ezLzbz5Md4961+pW4LM99hA4AEaSzbqgew0UHSxSRSN
 DQlFdxpDxBDIiwfwNef2tFEQ6HbheI2YhSF8gKKlyz/DXDffa4m9B4Fwxex/Ry2AbTXX4ZnYEo1
 w9ZxL+Di/VzzE3ABU82ccT1gDudA2dVMPBLlrvBFk6qMcfVKgdg+IAxbu+e5l2P61ntvD0P2qHN
 8KwKrczo/fILrL0r9D/KP7+9DN+/s414JzxqpySEbXbfDUO6HnbUEu4HlfhhPP9w4Ox+qb6tByI
 JqbqKmFkdy79tGgIuUOoGPUtfro=
X-Received: by 2002:a05:600c:46d3:b0:4a1:acaa:c355 with SMTP id
 5b1f17b1804b1-4a1fdd0b191mr49752045e9.10.1792592574608; 
 Wed, 21 Oct 2026 07:22:54 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 076/100] tcg: Use umax in ussub if available
Date: Wed, 21 Oct 2026 16:16:28 +0200
Message-ID: <20261021141652.363109-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c5329a8d95..f6cc56661d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1086,9 +1086,18 @@ void tcg_gen_ussub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
 
-    tcg_gen_sub(type, tmp, src1, src2);
-    tcg_gen_movcond(type, TCG_COND_LTU, dst, src1, src2,
-                    tcg_constant_internal(type, 0), tmp);
+    if (tcg_op_supported(INDEX_op_umax, type, 0)) {
+        tcg_gen_umax(type, tmp, src1, src2);
+        tcg_gen_sub(type, dst, tmp, src2);
+    } else {
+        /*
+         * While umax can be expanded with movcond, some hosts can
+         * perform movcond with a zero source in fewer insns.
+         */
+        tcg_gen_sub(type, tmp, src1, src2);
+        tcg_gen_movcond(type, TCG_COND_LTU, dst, src1, src2,
+                        tcg_constant_internal(type, 0), tmp);
+    }
 }
 
 void tcg_gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
-- 
2.53.0



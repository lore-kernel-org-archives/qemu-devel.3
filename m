Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5844BC3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 20:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC2QG-0006sm-0i; Mon, 05 May 2025 16:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Q5-0006li-Va
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:10 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Q2-0000PV-FN
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:09 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22e3b069f23so189715ad.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 13:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746476883; x=1747081683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sNMYKS7uUvU3t4vTOZEPR2i1hQCtUZDMO2z8Aojc6go=;
 b=oH4ipho1lhmeqnJAnuEt1VDW8fAtlP3EH8qRxWU50FNHE33WK1g7/e9+UgokeRppRX
 jFBiIfbK6GW4e7VckLCjdQIyePvbyAS4H5/vbLbFcRwBSuaYzGrLSS9bluGs85702eve
 ovxVgqXyrqs2UuCRDb2PdXySMNvPTnErGKEVwkM2zJq7Yd2/vkmoWPUOdZhidyXMwuf5
 6+klTFr+d8PIohda7/qGpFmTYRm0dAOHqSobqHIY7JI5apfKcCeuMbIpalmeuNLcybcB
 t7C7bOxYmPqm0qW2SBZ4wxKIJCDCORp1CAZYLao0TOj/kIamRPSJjsRg3qaAYhInmeGn
 gF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746476883; x=1747081683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sNMYKS7uUvU3t4vTOZEPR2i1hQCtUZDMO2z8Aojc6go=;
 b=nBqvrL99zFrnyf3NMfF1NNIEP7bEwy4/Qhv365EXhGZ75KcAeIdiFuc+KKSbARArmH
 Vld1dD+oHJURdvZznV5pSqpBKG+rb3w6J7+hujoqbILnML4g40FoYqZlJya/WQtvntrO
 ij1xKZubnWu84UF5j03fUNkpVlHSBDSTDmdN5JHQeib3Wa7h/3KVJx33QOZtfO6I7/XP
 7Tf+fSdielP3UlajpBUxvor6oMPqqlqYXo45zGCX8q0PNYXs56oQmim6JyELvjNcyeHS
 yY8/t5E5riuZ+yfvNosxwGGKCOGUn6/Cb+dKll01oxnKrs3jWmdshFCN8h2VCcCSK0mn
 ICtw==
X-Gm-Message-State: AOJu0YyBGT0NGu2+auGLL9S2dWpwrl73zB4zCo+J/fAH60X7TbBgSy2K
 C8MEZXydnoj9AarUOWFRlEc7GA0NRG8E7gRVtXtULQtQ1IPKEacsjZO3V3mwVprbZi3xIl9+W6L
 D
X-Gm-Gg: ASbGncuADrXGy03HF56hUl4fOd97VV8z5tO2YD70OdePLJiMH72iNzAjrkjcVhmgXUQ
 CazNv/5FrmlclTTYk+MBAEgLaJZst6MAIer+X0qsy2dQyCP3bqVctRvvfnxkj/tOUJIleK6Fg4o
 F24Vy2A/tfXBeOdhd0yRCkyvNsahlaeO8Zmt3S8BaveWU4kpDHtw65UqjHhdjBty/SrqHU1NGa1
 njAam2HKHfzTp8JcC6n1xrtBSgnZO/00IWJXQgs3D5y+U4XTLXCB11sL2a5td6vW2uFV4hmr4ep
 KMAROtBHNb3RoX3x3/j5Di13FDx8dJWdyoY/WeWBGpmay0tdjMhD6b1n5iNbPKwT3WZzo1rPdjB
 YJ0LDsKPGhA==
X-Google-Smtp-Source: AGHT+IE79c7ZxcUj2p/NQwy6H3SjNJXs76+T3MbgeB3cOpiUQBXcKypzd36Rp8i90luhwKwJ+9AnPg==
X-Received: by 2002:a17:903:1983:b0:224:de2:7fd6 with SMTP id
 d9443c01a7336-22e32ba5039mr11669495ad.25.1746476883707; 
 Mon, 05 May 2025 13:28:03 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059021067sm7516485b3a.107.2025.05.05.13.28.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 13:28:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/20] tcg/optimize: Build and use o_bits in fold_bswap
Date: Mon,  5 May 2025 13:27:43 -0700
Message-ID: <20250505202751.3510517-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505202751.3510517-1-richard.henderson@linaro.org>
References: <20250505202751.3510517-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
 tcg/optimize.c | 49 ++++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index a61c7ca376..2898a3f913 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1666,53 +1666,52 @@ static bool fold_brcond2(OptContext *ctx, TCGOp *op)
 
 static bool fold_bswap(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask, s_mask, sign;
+    uint64_t z_mask, o_mask, s_mask;
     TempOptInfo *t1 = arg_info(op->args[1]);
+    int flags = op->args[2];
 
     if (ti_is_const(t1)) {
         return tcg_opt_gen_movi(ctx, op, op->args[0],
                                 do_constant_folding(op->opc, ctx->type,
-                                                    ti_const_val(t1),
-                                                    op->args[2]));
+                                                    ti_const_val(t1), flags));
     }
 
     z_mask = t1->z_mask;
+    o_mask = t1->o_mask;
+    s_mask = 0;
+
     switch (op->opc) {
     case INDEX_op_bswap16:
         z_mask = bswap16(z_mask);
-        sign = INT16_MIN;
+        o_mask = bswap16(o_mask);
+        if (flags & TCG_BSWAP_OS) {
+            z_mask = (int16_t)z_mask;
+            o_mask = (int16_t)o_mask;
+            s_mask = INT16_MIN;
+        } else if (!(flags & TCG_BSWAP_OZ)) {
+            z_mask |= MAKE_64BIT_MASK(16, 48);
+        }
         break;
     case INDEX_op_bswap32:
         z_mask = bswap32(z_mask);
-        sign = INT32_MIN;
+        o_mask = bswap32(o_mask);
+        if (flags & TCG_BSWAP_OS) {
+            z_mask = (int32_t)z_mask;
+            o_mask = (int32_t)o_mask;
+            s_mask = INT32_MIN;
+        } else if (!(flags & TCG_BSWAP_OZ)) {
+            z_mask |= MAKE_64BIT_MASK(32, 32);
+        }
         break;
     case INDEX_op_bswap64:
         z_mask = bswap64(z_mask);
-        sign = INT64_MIN;
+        o_mask = bswap64(o_mask);
         break;
     default:
         g_assert_not_reached();
     }
 
-    s_mask = 0;
-    switch (op->args[2] & (TCG_BSWAP_OZ | TCG_BSWAP_OS)) {
-    case TCG_BSWAP_OZ:
-        break;
-    case TCG_BSWAP_OS:
-        /* If the sign bit may be 1, force all the bits above to 1. */
-        if (z_mask & sign) {
-            z_mask |= sign;
-        }
-        /* The value and therefore s_mask is explicitly sign-extended. */
-        s_mask = sign;
-        break;
-    default:
-        /* The high bits are undefined: force all bits above the sign to 1. */
-        z_mask |= sign << 1;
-        break;
-    }
-
-    return fold_masks_zs(ctx, op, z_mask, s_mask);
+    return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
 static bool fold_call(OptContext *ctx, TCGOp *op)
-- 
2.43.0



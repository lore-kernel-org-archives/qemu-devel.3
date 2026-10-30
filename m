Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE9D606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xzGxbr0G
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmTm-0005gR-37; Fri, 30 Oct 2026 09:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmT2-0002pP-Ly
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:29 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSz-0005Yg-Rm
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:23 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-47b47de8b4cso403611fac.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 06:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793366181; x=1793970981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iAMNDbHUNDI+apCmKSgDC28TQZ7cIrC7r+UwC/sNOys=;
 b=xzGxbr0GWvJgK46En1oRr7WJmOINMTWniHBh0n15SHmShd4e+lJCyyiGBO+emmT/ph
 /DEw9qEAVSKFUZTABpOwr9F++FOvsGtHmplcW40OZ1N20E1AA+KyCxqxVroR6rg3ow4J
 V92Yh8hDgXVGrbAG4KMRjiM3Fl1wy938a91/RuB4xzJIkb5qVBkneEeWyzMJMI6jyB52
 emA+aDr9n+GXoRk2tcJf1dHRGXQBJimu7w7vc352vzFy5U54IguTQAusRUIyBL6FjY1m
 rpSbR9wKHhxNbPABcGsw5IdpK9k9z0Ym/+fUDA0HdH1g3Qs/apuYGf5pGkT1MQgwZx1g
 z7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793366181; x=1793970981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iAMNDbHUNDI+apCmKSgDC28TQZ7cIrC7r+UwC/sNOys=;
 b=yMU+EFYwazSUNxFiEHqf+JJwNtrXS/HCtwFRYIyA/FeENwn9N1id8Cyzsyfa2ph7c4
 NtYBwMzqueLKcTukLKw2kfx6+KRE61NEazDv6s0FAuQ25D9oyCqGJxG6ycJv4ldc2ksG
 geXZaRvc3u1nF+nlSk7tBbHFZLElCtn0RN8iVcxnde9S/PtFWI4rRtBahQqear7nyX4z
 1YV8i4eCSMwMMUsQ9b0m61uys2w62wqh2Wg0Mkw5t4aAkOX5JU56DBuMmg3+SmWRj2cc
 ofAqZHzK27gfmxedXCldc23jG1jmU3viNVodCaXbBHog/tryIblIGeUIkuluWlFHcQNR
 DgnQ==
X-Gm-Message-State: AFq9FYKQ+zc+XpDNBfo1q0fe4wudnQOFNqDNQGVpV8khhzRA0SD2nwy7
 cfs4rKA+dLfajcWTKfVpaqKuJGt9hHS4Fz+i4lvUkRqkaNvm158s9jJ36ppAY3S26ug1d3cpYVN
 RIUIH
X-Gm-Gg: AYBFou0KjmuBjb8F3NTjyDPjkDgUuvJYGzNgAM2A6ROrESzNqfEFumM01QLlBHI/8J1
 w0ro79CnoXgWtB0AwbHCpt2H9y8UFKDHsJ58amNkMdHaCFgcSxsWvwR9xIIGRnqPqAJGXqQwDmk
 g5C+779hF43cMZJp2yyLMLGFw93t2sn8LYY8gp3zt2Xdif+3qO4lkrbJNkxXcB2CmZxuf/NaYdx
 AGjoOwtViC4rXfM6ntrhfzoM1pHeHEPiDZAP50cBF7wertFnBLuiylF0Spoh01LUpQKs4w8MRZ+
 S83utXJE2lmXmaszsF56GGPQ8qxTNcp4pGK4NnQrK5Bj3zytPGA2P00FQCQWlt3nZkqr6Eo1Cqc
 +ccScdzh63g4Gwn67z42J0I283MxFR4Zuw746dZsZpfOVM05YUze3ww/fCiDAXr5vRyMywMzs/3
 l1wR9ZPdD7F5yxVwn+BPF9kwZmp7j19JoFvyCVKMOgqrI0HfGOxCCVK1AdR0rBYARNZKxaUYbOW
 9CBjFCeKNhwpQxnXzeavwZdWDrH0ww0s24wpYxqmVfTMGuZR/Idv4VfdYmhNd3mmm/lmRolBf+O
 WySdByT67OT8uQeSjczCsEYHYkf7UAFx/Ysngg6jXNeuXA7B1gTO
X-Received: by 2002:a05:6870:82ac:b0:485:d31b:775c with SMTP id
 586e51a60fabf-4a9076e94b1mr1386919fac.26.1793366171149; 
 Fri, 30 Oct 2026 06:16:11 -0700 (PDT)
Received: from stoup ([50.233.235.3]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90ae4e6bcsm1796812fac.3.2026.10.30.06.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:16:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 16/19] tcg/loongarch64: Implement INDEX_op_lea
Date: Fri, 30 Oct 2026 08:15:51 -0500
Message-ID: <20261030131554.41208-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030131554.41208-1-richard.henderson@linaro.org>
References: <20261030131554.41208-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target-has.h |  4 ++--
 tcg/loongarch64/tcg-target.c.inc | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 31e6ea9632..53b7ca4057 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -54,7 +54,7 @@ tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
 }
 #define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
 
-#define TCG_TARGET_lea_sh_valid(type, sh)          0
-#define TCG_TARGET_lea_imm_valid(type, imm)        0
+#define TCG_TARGET_lea_sh_valid(type, sh)          ((sh) >= 1 && (sh) <= 4)
+#define TCG_TARGET_lea_imm_valid(type, imm)        ((imm) == 0)
 
 #endif
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 17784d8bbe..377cd9ec08 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2098,8 +2098,19 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static void tgen_lea(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                     TCGReg a2, unsigned sh, tcg_target_long imm)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_sladd_w(s, a0, a2, a1, sh - 1);
+    } else {
+        tcg_out_opc_sladd_d(s, a0, a2, a1, sh - 1);
+    }
+}
+
 static const TCGOutOpLea outop_lea = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out = tgen_lea,
 };
 
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
-- 
2.53.0



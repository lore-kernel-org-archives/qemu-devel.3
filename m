Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DC9606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Sc2zcGfO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmTp-00061k-96; Fri, 30 Oct 2026 09:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmT5-0002rY-7n
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:33 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmT3-0005Yx-6v
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:26 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-4a76f0cce5fso351075fac.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 06:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793366184; x=1793970984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IQ45TU92KrE3ygg0OK53jApJZRB54/B3zPueBnzjfQ4=;
 b=Sc2zcGfOEfYmdEJmvnJ2c/cfxLnFweiU/GK8tvkQ6uNOhjAI79czDWe9pJ1QQNeQI4
 jCF3JE0cHibHMOIRDIrw7EbG/u9agz54xazWBD86NqBBUs1efqIGVX5CPaTk2QTPEAox
 UH0aeC0+mw9d5iVDAz+xOHnCa0n6yUx7GSrGWmTiEAAbXvoQIMwspnyAD/cTnAB1JiCP
 ZT3DdUmGZJejWQkOppq65QAcxzueBwYeGe8ojL0Hz5/k7bbN8rtSRfMwV8GKJvnv4D8D
 AY60aBJWXj+zktXeV6mZJMoy+1p4+xXx0FEJWrJt3mGmPvMa8qYKBbnyavuXDRqUPNKh
 Oz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793366184; x=1793970984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IQ45TU92KrE3ygg0OK53jApJZRB54/B3zPueBnzjfQ4=;
 b=Obok2gcnwhvMeMaFS81s1JYJaPQZOgacpEE4t+6KeWLA4cI18cPL6l5yddo0FyEaTD
 QBEQ5oOeV4FNxnvS/nqwX88xszFzuK8H32Ldd/ruhy886wk89o3+sWYIxWG5xYMsrzLu
 ILWE9TG82UrboJ7UEnINrHp9sAl9M5UH1nn00zOVa16r5+DgYfAIBkhf+fgrTt4rwCHS
 zAj8J6Aa08xfAxQRefdW2Sbl/uxRhsRleV5MrkKAY+k61DeHF9Wwbz2cnb1ICMkqldLS
 xfXViD3XfW2zALg3AlVuR7lm/ywEsq2Md+Xt2npv3A0Xm73iZuABtEBLx5C6IkAtr5VL
 8nbg==
X-Gm-Message-State: AFq9FYJaEMSphLHHimIXikrDvZQZtbm8AdS8oORQ30C+N9MfVt/98Yl4
 d8I77vF1DBbjSZNKgjXNSroVZ7861xX56gyG+4YUnPq0kwIyC9TtEmyi9y34WSIilJAC2aX8vWv
 FebDE
X-Gm-Gg: AYBFou1QD9Qz4zOn/3yq0nCx2urlyErmJoljW/yL/cHWrTx+K0anH45G03yWzd4ub9o
 dbPIMRMEuUJfm/117hmfb9RBoV5WpKzkrPR1IgSCfrFVvHqOJOy2lZUXsMbYWdXyl2gcAKF8Vs2
 HCmvIgjghawQp0nOJxIEv9Ac3PgHeNhx2Th40u/NbJf4iB34yeVHWWzOvd+DM6HAzNgQnKVU4n+
 PNAtOqN51cWMAx8gD7eaUtnNcpNmSQTnSYgjhS7/ZwxNFVQNqrs+iG+36iw4/r9XQcbUXcoIuKx
 bAeHDelWPPBVNteGJxIyZb6ZXiV0Hm7Liw4bSG7nc6bGNRprlPxca88dofRjCNHx+Q5jjDzYOMR
 /dXXvAfWpBUbx0tYUYXaeCBaS0rJf4FDYJuPuuZ4Z4SzcC3rO8aSJFp59UNszSlVBkerQQrkrBs
 hGyMDQQKrNUjON/dgxn/dJMUzPuYGbGGh8qUsCncmUhBeX1BnGsuuxm8KlTghRBgr1nS54R5bVk
 y2da8WbVZsjvPvnOSiN9KWHit/HAv2g031LIP4IoqYGuQM7n6KczdZgxjscTi8PtRqVpIUsILr9
 DjIg+UylFXHEL1b+ZUwLmtwwnS8ltg==
X-Received: by 2002:a05:6871:7286:b0:49e:691c:1bdb with SMTP id
 586e51a60fabf-4a9076d9931mr1382395fac.32.1793366183822; 
 Fri, 30 Oct 2026 06:16:23 -0700 (PDT)
Received: from stoup ([50.233.235.3]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90ae4e6bcsm1796812fac.3.2026.10.30.06.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:16:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 19/19] tcg/s390x: Implement INDEX_op_lea
Date: Fri, 30 Oct 2026 08:15:54 -0500
Message-ID: <20261030131554.41208-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030131554.41208-1-richard.henderson@linaro.org>
References: <20261030131554.41208-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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
 tcg/s390x/tcg-target-has.h |  5 +++--
 tcg/s390x/tcg-target.c.inc | 13 ++++++++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 58e3afe526..33a3b72318 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -77,7 +77,8 @@ tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
 }
 #define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
 
-#define TCG_TARGET_lea_sh_valid(type, sh)          0
-#define TCG_TARGET_lea_imm_valid(type, imm)        0
+#define TCG_TARGET_lea_sh_valid(type, sh)          ((sh) == 0)
+#define TCG_TARGET_lea_imm_valid(type, imm)        \
+    ((imm) >= -0x80000 && (imm) < 0x80000)
 
 #endif
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 2fd7012d04..db3b2fc3c9 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3187,8 +3187,19 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static void tgen_lea(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                     TCGReg a2, unsigned sh, tcg_target_long imm)
+{
+    if (imm >= 0 && imm < 0x1000) {
+        tcg_out_insn(s, RX, LA, a0, a1, a2, imm);
+    } else {
+        tcg_out_insn(s, RXY, LAY, a0, a1, a2, imm);
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



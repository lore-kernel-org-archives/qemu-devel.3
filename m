Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759CA606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bOuBU6Dn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmTg-00056Q-Iy; Fri, 30 Oct 2026 09:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSs-0002kD-VO
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:18 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSq-0005WU-0B
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:14 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-5326cdde017so190978b6e.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 06:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793366169; x=1793970969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/s6kyHIPPO7wmb797pBUvtqZP0z9Faww+WNYejTokjM=;
 b=bOuBU6DnUSghDrdGsR/gXDEbE9ZFrHytkHDIJEDN+WOSY2iOQqKbVLYOlsH97miIW3
 D+qQMX7MOp2kaiI6Sfk+d9rdfug2Zhz8qMZO2FjytdS05pMaBQnYWg/mi+kTGtibocAl
 9f9w6gCVMTZJZGW5GEiNo91PIFpOFy33VZsOj0S+fWSh8arYQuDm11ubnY0y281e+QJM
 vE+/S/MVX476Ec7unbGqYJc04rUc9dT1aTIngLs/QlXtTN13OWsxcCzDPzaXCXQpJnVX
 /cHMeqO6d8Ao3/RQeqVX8j/uwvcb+jqANBmeBQf/BegptBPcIQg61GiZIG1FxrVBv/mS
 qKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793366169; x=1793970969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/s6kyHIPPO7wmb797pBUvtqZP0z9Faww+WNYejTokjM=;
 b=mF0UOwUJwccYk3vefFfuiAb4x70gBadBmNcfK7/aHxR5iPcyTrencexUg+669AzFWg
 MxqjrOcXwk6ibZR9YiWWR20ivawiZ7fS+kQIARSAfuk8lasc9izoWyvR95sCQ2OpisyG
 Kuxd15GLIJzEq3nGABFQHwxR1RsJzzg+6LYF3Q3Jcb1H8+RlrQJLD/JAqJvCnyuvaj7X
 HTACxu8X98wC4jri0nb9B6D4qwMCDR69yQ7T4RC2hw26b8o0GxIBw6YbO33cmhIrvMYc
 zAWnC9i3D0g/WK9Dp2jcHJ5r22x86B2D7QJkQk1px795WpNFZBMe1Tq2O2vuITYqWOnQ
 Yb1A==
X-Gm-Message-State: AFq9FYJBa1ZltBu6wZPl97XJ0z0V4OXUgpDUHSNO4ny7ZrDWgpT3OTDd
 sti6NjcDqviqvRnME7Rf34VSc05B/iDijXJQ5S0zqNVes8btjHjd0fkCDpaCtvONNem1pnMYVaj
 tIL/N
X-Gm-Gg: AYBFou38xu7n8oHAtqR+4Bh9TmwZM89+s+mTJ0DPFkVk19+Y27nz/WbZ0SiU+piJFEy
 jDO+h3PwHs+7z9kFMNg+cWBiZH5Rg9wVfSJfn5fIKAcFTKTAdZsCc6nGH1u9KrlxjznCMz1aDOF
 QmYUwc2PN4H4Sp7xQIl+MpRfeJqzuD9Ww/yUJExdzzTDniK/V2zOTZ4q1JvtCKnUWhc++XGgGcr
 HniaZfhSUcb69bVObSDlojGDZX5dBfRBMgD+tGSgadjIKS8ZTlPZ9UXFBmVGiWxMT6x/t+2qwdO
 8NPO5t/48qmJtDAo68EAA7Uv4+9LmzXFzUQpTud5ciRKJoihUMf22WjCcCQzKrzwrbFB5lFy4BH
 8cLNPhBw315xYVEMnLoPLL5n3dZBZtOgdZp/cjj4mhCELWW37PoOSsxXVR7wIEvPfaFA0oQDl3q
 SqpVz/X6x1a6pSznzzQ7i1TFLT/wmHw/81yYNQRprIXBqej/PfBFBR9hVu6BvP+n9C42atkmMhz
 2Ba8/j17g9dOrXIotOjPBnMh+EZFCTzU1AoWW7jGTPRjKEqNqTNAxWkEQG6GpWhT/fnHWfjDrMX
 rx88XK1GlfRIa2nLhL3AVFaUERJMQA==
X-Received: by 2002:a05:6809:1c:20b0:4fa:8d48:3a6a with SMTP id
 5614622812f47-5640dc2a78bmr1055051b6e.18.1793366169130; 
 Fri, 30 Oct 2026 06:16:09 -0700 (PDT)
Received: from stoup ([50.233.235.3]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90ae4e6bcsm1796812fac.3.2026.10.30.06.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:16:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 14/19] tcg/x86_64: Implement INDEX_op_lea
Date: Fri, 30 Oct 2026 08:15:49 -0500
Message-ID: <20261030131554.41208-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030131554.41208-1-richard.henderson@linaro.org>
References: <20261030131554.41208-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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
 tcg/x86_64/tcg-target-con-set.h |  1 +
 tcg/x86_64/tcg-target-has.h     |  4 ++--
 tcg/x86_64/tcg-target.h         |  2 ++
 tcg/x86_64/tcg-target.c.inc     | 11 ++++++++++-
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/tcg/x86_64/tcg-target-con-set.h b/tcg/x86_64/tcg-target-con-set.h
index 7df9bf4917..2529539f89 100644
--- a/tcg/x86_64/tcg-target-con-set.h
+++ b/tcg/x86_64/tcg-target-con-set.h
@@ -47,6 +47,7 @@ C_O1_I2(r, r, r)
 C_O1_I2(r, r, re)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, rO, re)
+C_O1_I2(r, rz, r)
 C_O1_I2(x, x, x)
 C_N1_I2(r, r, r)
 C_N1_I2(r, r, rW)
diff --git a/tcg/x86_64/tcg-target-has.h b/tcg/x86_64/tcg-target-has.h
index 6ffae51f92..f1d3d256ee 100644
--- a/tcg/x86_64/tcg-target-has.h
+++ b/tcg/x86_64/tcg-target-has.h
@@ -105,7 +105,7 @@ tcg_target_extract_valid(TCGType type, unsigned ofs, unsigned len)
 }
 #define TCG_TARGET_extract_valid  tcg_target_extract_valid
 
-#define TCG_TARGET_lea_sh_valid(type, sh)          0
-#define TCG_TARGET_lea_imm_valid(type, imm)        0
+#define TCG_TARGET_lea_sh_valid(type, sh)          ((sh) <= 3)
+#define TCG_TARGET_lea_imm_valid(type, imm)        ((imm) == (int32_t)(imm))
 
 #endif
diff --git a/tcg/x86_64/tcg-target.h b/tcg/x86_64/tcg-target.h
index 7109722f24..3444bcdca0 100644
--- a/tcg/x86_64/tcg-target.h
+++ b/tcg/x86_64/tcg-target.h
@@ -80,4 +80,6 @@ typedef enum {
     TCG_REG_CALL_STACK = TCG_REG_ESP
 } TCGReg;
 
+#define TCG_REG_ZERO  TCG_REG_NONE
+
 #endif
diff --git a/tcg/x86_64/tcg-target.c.inc b/tcg/x86_64/tcg-target.c.inc
index d85e95a32b..3fca0693e2 100644
--- a/tcg/x86_64/tcg-target.c.inc
+++ b/tcg/x86_64/tcg-target.c.inc
@@ -3361,8 +3361,17 @@ static const TCGOutOpStore outop_st = {
     .out_i = tgen_st_i,
 };
 
+static void tgen_lea(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                     TCGReg a2, unsigned sh, tcg_target_long imm)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tcg_out_modrm_sib_offset(s, OPC_LEA + rexw, a0, a1, a2, sh, imm);
+}
+
 static const TCGOutOpLea outop_lea = {
-    .base.static_constraint = C_NotImplemented,
+    /* Allow "lea imm(, a2, sh), a0" via TCG_REG_ZERO constraint */
+    .base.static_constraint = C_O1_I2(r, rz, r),
+    .out = tgen_lea,
 };
 
 static int const umin_insn[4] = {
-- 
2.53.0



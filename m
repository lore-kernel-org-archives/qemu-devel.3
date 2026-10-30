Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2CF606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=egLSZ8tU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmUS-0006fX-4L; Fri, 30 Oct 2026 09:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmTB-0002y5-Io
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:37 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmT7-0005ZL-OB
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:32 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-47b47de8b4cso403711fac.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 06:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793366188; x=1793970988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ib3WcmPpduqmQAQzGFLThrdz609C8UkaI8Pr5YC7zC8=;
 b=egLSZ8tUL4BbTaozQLjeLzjZIkhS7tHHSJJgCmXx9l5of5C4jGEYUr9fivBR0/fex/
 epL6zk8E2xMnD7Qpp6Iaf/6/JW4LkCogXcsLH/e6GvRgSoempigcVRACUN+kJ0Pv6x9z
 AXSlUWhZ4/L3QMMpR0TNJmBJJUxi0tcMwMqm0TUbyCOIPtQ3yvOdlDY4j+E8eHj17QHq
 7eLETCVroYaqJcd5aHws5X2KkL94FmA2PmugROldiqDAF6c6A/QwCHGQid7HPvE0ytKX
 mbIMMDUy8OwpsFmYmRpVZbS1WYDZzHErB5OaQDZeWmic/3ZnJCw5fE3bdHOM0O0wjq5K
 w92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793366188; x=1793970988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ib3WcmPpduqmQAQzGFLThrdz609C8UkaI8Pr5YC7zC8=;
 b=YJf3z/bagt6gv7zkQAQqTTeOf2QsT8Bt0tYyZkuGEwi4ahoXI9BmOTZVNss9tCjoAg
 O15UqUqHGHbZ89xchRtlOzsheBuB4aScxFHD4RghUwi5LKOovPBbYVju80K6AWR2sOIh
 78zk3fIWTnvrwJNFn/3fmOz3KDEodqDXkjSdM2t3779iJkmxVxyYX85bU4l0iSt6rxZA
 xTdQY2NddV20V00/hbU/dLFL/atoOtfgrgKn2tq4qcRND18/RqkmcvOJa5tZEVp5NrFc
 knNW5m3efs9lxEHd6YJlvOxY2rW5hjOsqNnWExyhG5KZIZ4dGsncwcTGrxRDGy1/ntZj
 LHeA==
X-Gm-Message-State: AFq9FYLrbA1eUn3Rt/Gq8NChosc+iZoJaJso7ujlNtfpfLkd6SKFcQoY
 z+HgseHDSgkuAHqcEJXMWwYuF635Iwu+yYOHxOjJmY5VXkYo6Rxu/0jkWR3aToy0m1IhQOT2pHE
 66Tkf
X-Gm-Gg: AYBFou3pALbJUZKDt+EXNh4vNGqSR+Hi0MUD9+wRor8ft46CdtLj8nODHLthNsiPJEL
 w6pi2bHWMuYHIWLYSVAZW8rMSOwuixOnn43cbZEvb95H5FVNf8+S/tAXixXarRY+Yox11kRPReS
 rLZ4EsSU3SIbjNx9zLqwayCOjDB3LRT7zH+K7u5SrqKG6ScQUla39IEG/d/TOkrk0GOqBHcc8vT
 9XFK1bhLO6r+YUCRGMxOjgw+5XnOnhTI6U1GVLrVtSSgeCDPQyry04Bmn5Uw2rPVOS9qTjK6Im9
 heyvy8n6PU+gb3ml85gIaeanlixaYlMHO9WmLu37tIHlta30xqGFQg1IKMWrjMnF4ohP6OQCVyI
 wfdwyO67SXlyMFdxJy93acgEYLwFtDtcYz9cdKgXl/+lBBqFQi8zNPCu7NYd8w+EfRBZKbMPTnz
 FXUNO5KOucpw2t0cU8mEDH6UFS2H7jXHBXfkLItR+/up4s4f7JRZ9cwMyo822yrUFqDMRKFXH6S
 ojHn9sIX0MvHvHD36uAOte1Jc/pcQ8yJ2JmDko6DtU3TlTgNmEMHHEMKoOGM1YCgRCz+GuzBdbq
 M5HLSrO/X4hGNWLnIemxW4/0OtoH8xo=
X-Received: by 2002:a05:6870:5ba2:b0:494:21ea:9805 with SMTP id
 586e51a60fabf-4a90771a635mr1360554fac.32.1793366182999; 
 Fri, 30 Oct 2026 06:16:22 -0700 (PDT)
Received: from stoup ([50.233.235.3]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90ae4e6bcsm1796812fac.3.2026.10.30.06.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:16:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 18/19] tcg/riscv64: Implement INDEX_op_lea
Date: Fri, 30 Oct 2026 08:15:53 -0500
Message-ID: <20261030131554.41208-19-richard.henderson@linaro.org>
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
 tcg/riscv64/tcg-target-has.h | 12 ++++++++++--
 tcg/riscv64/tcg-target.c.inc | 16 +++++++++++++++-
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/tcg/riscv64/tcg-target-has.h b/tcg/riscv64/tcg-target-has.h
index 93f8baad09..3cdeb5c390 100644
--- a/tcg/riscv64/tcg-target-has.h
+++ b/tcg/riscv64/tcg-target-has.h
@@ -69,7 +69,15 @@ tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
 
 #define TCG_TARGET_deposit_valid(type, ofs, len)  0
 
-#define TCG_TARGET_lea_sh_valid(type, sh)         0
-#define TCG_TARGET_lea_imm_valid(type, imm)       0
+/*
+ * The SH*ADD instructions only operate on full register width.
+ * To allow TCG_TYPE_I32, we'd need a subsequent extension,
+ * with the result no better than the separate shift+add insns.
+ */
+#define TCG_TARGET_lea_sh_valid(type, sh)         \
+    (cpuinfo & CPUINFO_ZBA &&                     \
+     (type) == TCG_TYPE_REG &&                    \
+     (sh) >= 1 && (sh) <= 3)
+#define TCG_TARGET_lea_imm_valid(type, imm)       ((imm) == 0)
 
 #endif
diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index ec0c8e1af0..6da52929a4 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -224,6 +224,7 @@ typedef enum {
 
     /* Zba: Bit manipulation extension, address generation */
     OPC_ADD_UW = 0x0800003b,
+    OPC_SHxADD = 0x20000033,  /* plus sh << 13 */
 
     /* Zbb: Bit manipulation extension, basic bit manipulation */
     OPC_ANDN   = 0x40007033,
@@ -2740,8 +2741,21 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static void tgen_lea(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                     TCGReg a2, unsigned sh, tcg_target_long imm)
+{
+    tcg_out32(s, encode_r(OPC_SHxADD, a0, a2, a1) | (sh << 13));
+}
+
+static TCGConstraintSetIndex cset_zba_rrr(TCGType type, unsigned flags)
+{
+    return cpuinfo & CPUINFO_ZBA ? C_O1_I2(r, r, r) : C_NotImplemented;
+}
+
 static const TCGOutOpLea outop_lea = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_zba_rrr,
+    .out = tgen_lea,
 };
 
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
-- 
2.53.0



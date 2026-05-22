Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A90CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQY0u-0005EC-Rz; Fri, 22 May 2026 18:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXy2-0007mV-8o
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:43 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxw-0008Mj-MV
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:39 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-36a35e4eefeso1935288a91.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487415; x=1780092215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xbs1tOdyRz8Grtev8uklZL57+yUz1abxxPTbGB35NXY=;
 b=YYu+si+l8K7xgNeUnl677d6JXSNc2uA+NI3CmbUy7t1iMlf7hfSPt0JRwS1JOPxP6T
 0k2WIUs1+nd4mup09n1QFFTyUArIrH7V16nW7I3hA+ABTCCoDbrOKFTqtuYstdfr+xPj
 NyN1tYuI0ce0+y7CLew9MTOHLH3hBLeFVlo8vrDBlDyFTlwaNzXtpHMBuJmtvk3AAgdM
 cAlRcCb0TpDB+NVy7/229B5X/0fjQ1hd0uZWVTeRqlKNnRjMAs+z/GJr7Egiz+ctqwQu
 NjXWoChX0+SV5XGGsZdBBlTefLBXtKbliHX+DISqRyvrGgT0ZHLlG4/hlrvZZMjLb7/8
 YZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487415; x=1780092215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xbs1tOdyRz8Grtev8uklZL57+yUz1abxxPTbGB35NXY=;
 b=B1JX5epz2x84mUY0EF1rpLqEmxQH4zrO9B1KPqEAqioUbYxsdexz+MmmnCWWds1RhC
 EulBGX8ID+LTjOoieHPWVzCJ34JQ0Z7q448aYwwBhlp4gRziS1aBC964N8xM6ztm9UPU
 KYqDq+JZO164gQlQ9TsD25GbHM0s7grBIXJpzZRWNomDWJVI6e9xqbZsCb0dq5CwF6F8
 L70wvwR3rnwDLoxN7hPlkZCxzo9HUxDJ/XS3kxj219vYPt6hgwr7mE1ObHeRawe8M6od
 078F3Nnh3dIc7kt6B3FaQrdYIaYIJ1eOCNuyOPhrzbUmLPu5u3ntuaUju1/c9ncQWYIi
 sBQw==
X-Gm-Message-State: AOJu0YzE7sZ09T+DJ2bS1GUuXP4TGVi8KGz/7JgXLB+psH+rS5y5RyX9
 P2h5KLKGqzOfMDp42c6Q8Z23SUnIVIM0NDbyziZbiuss4Te1M9QLjdK2JmTDn7WjSx5QN6q3UXJ
 CjdIE
X-Gm-Gg: Acq92OHjnkDzPs3irH+aNAVkC7XnOYYMKMFI80aTgGb9oRvyPi7d8bGjCd7DEiOatN6
 OPAG5ty3/eFAJS2mw6Ylx8dejbUcntt/xz+vDpCmAK19dT1IUjIm4z9R21aw/6gQ66aJghb24jT
 lxOh1mEnlSwntfhX5iGTNbccz4ZKDF7Sr132D/h8LMgryXOJ44mvx6QWYViw09vbjW+ClIq3vC5
 lYl0X0/48nM6cGMsnSXsNrSI56vgTorms9gR2wyaelbzuzuJlZ3jR+bhmkrVd2OWTe6l5gjZvo2
 x/sGobM8OY1Q6ZyAzWLlwqjsgwWgfpBuavrSPgwAuPCwYhdLPRDODeeqmei4+b/EfEE+Os4FBGw
 RiL6AFiBJP/FmGCtIE7c8h2zGU8URg4vnWniK6Eb6WtKoUOqKsHDDPfPc/RZRKu9bfk6URY34hh
 Zs4iwDN6KpovxIQx1QVupcZi+jb6HU
X-Received: by 2002:a17:90b:2243:b0:36a:b34:17e5 with SMTP id
 98e67ed59e1d1-36a674f5d27mr5359383a91.14.1779487415293; 
 Fri, 22 May 2026 15:03:35 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6772f486sm1726789a91.2.2026.05.22.15.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:03:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v7 28/64] target/arm: Rename SME BFCVT patterns to BFCVT_hs
Date: Fri, 22 May 2026 15:02:30 -0700
Message-ID: <20260522220306.235200-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The existing pattern is BFCVT (single-precision to BFloat16).
In preparation for introducing more insns of the same name,
append the operand sizes.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme-defs.h | 2 +-
 target/arm/tcg/sme_helper.c      | 2 +-
 target/arm/tcg/translate-sme.c   | 4 ++--
 target/arm/tcg/sme.decode        | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index c551797c6f..01aad4c231 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -250,7 +250,7 @@ DEF_HELPER_FLAGS_5(sme2_umlsll_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr,
 DEF_HELPER_FLAGS_5(sme2_usmlall_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sme2_sumlall_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_4(sme2_bfcvt, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sme2_bfcvt_hs, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_bfcvtn, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvt_n, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvtn, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 0055e97a2b..a0f03c4671 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1742,7 +1742,7 @@ DO_MLALL_IDX(sme2_sumlall_idx_s, uint32_t, int8_t, uint8_t, H4, H1, +)
 #undef DO_MLALL_IDX
 
 /* Convert and compress */
-void HELPER(sme2_bfcvt)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+void HELPER(sme2_bfcvt_hs)(void *vd, void *vs, float_status *fpst, uint32_t desc)
 {
     ARMVectorReg scratch;
     size_t oprsz = simd_oprsz(desc);
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index e2d17de165..88c1d78c40 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1448,8 +1448,8 @@ static bool do_zz_fpst(DisasContext *s, arg_zz_n *a, int data,
     return true;
 }
 
-TRANS_FEAT(BFCVT, aa64_sme2, do_zz_fpst, a, 0,
-           FPST_A64, gen_helper_sme2_bfcvt)
+TRANS_FEAT(BFCVT_hs, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_sme2_bfcvt_hs)
 TRANS_FEAT(BFCVTN, aa64_sme2, do_zz_fpst, a, 0,
            FPST_A64, gen_helper_sme2_bfcvtn)
 TRANS_FEAT(FCVT_n, aa64_sme2, do_zz_fpst, a, 0,
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index ee874be1a6..7a8e1abb59 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -789,7 +789,7 @@ SUB_aaz_d       11000001 111 000010 .. 111 ...00 11 ...     @az_4x4_o3
 @zz_4x2_n1      ........ ... ..... ...... .... . .....      \
                 &zz_n n=1 zd=%zd_ax4 zn=%zn_ax2
 
-BFCVT           11000001 011 00000 111000 ....0 .....       @zz_1x2
+BFCVT_hs        11000001 011 00000 111000 ....0 .....       @zz_1x2
 BFCVTN          11000001 011 00000 111000 ....1 .....       @zz_1x2
 
 FCVT_n          11000001 001 00000 111000 ....0 .....       @zz_1x2
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6ADAC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pJt-0001GX-Fl; Wed, 16 Sep 2026 09:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJg-00016C-6e
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:48 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJe-0000KP-Hc
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:47 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccda24a3so698747a91.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563885; x=1790168685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=O+YCLO2jpwn3gMUqHmlY3kGGdcEL1JHvmbKOcEmNGsc=;
 b=iGqUpEgtzZEpoMAqlVRxI8pgP71pRrkoK+yX2T1F0C9vE3g2nfD805gj9zk1PfYbBk
 DjNA5ZsvfCC+VljHeuvBQqsXz8TLl9OP5dBh2lnoslBepS6c2IeANSXJvRdivWuXC3U9
 jz7h6SknMdjXtk4MMhc51H4w8XgQ9wa5+cyxSeU/d+wzDXKkgYib/02Cq2gQLqi6q7Cp
 Z831Qz4bWvD6JSjQhdJQEQ26HXMtosq+WvdX3CDSxAQvJZH/Zw4lpyWMzCCaoUXsT17x
 /F+2imm30DHPge5UWXjmrt5CZ0/jJVuzv8aYSk7jnMf9VlN2gesyyPQjMEvTP5Qw3cIo
 Sphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563885; x=1790168685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=O+YCLO2jpwn3gMUqHmlY3kGGdcEL1JHvmbKOcEmNGsc=;
 b=ODPsgLvDa/n+k1fHohqgzna73gY/j05XR6swyNsmNsk83NtYC06eq+qAsBsd526+uH
 B3OYOih3MR/opTCGkyLJXIupDH9NWn3zPMxOtYnVJsAFJJsZraS8fGURhAl/Dly99ms5
 zQIYLvdXraKG6m4GLKL0KhpbzBGlA3jie6Ho+ck0kDlsgJYDuLwj+62sqvgwXMWh+rhy
 Y/ife1GZgz4IkGR7IjPuZA/tSd83TgAJWfslHNkOVRsT+5zRHc5OG/VAiBGMe+wg5QdF
 UXmzQbIQfzpm/2nscLQsCuD9BLPc3cMfltFLbCNyyCAkXLRBxn941mRz+JYwjYuIzWDB
 jSIQ==
X-Gm-Message-State: AFuF++mYM5uL4EqlirOI0n7eHRu6hrWwsP4XdRd2Qc9ejhenKGhipR3x
 pO1P9mEzciwEy8O3Mosw5J7hFzm72R6W6scuikjW8c7ijuzPSiEmngSI9SoWUlRCPnRNXPeLXXN
 IH2GP2Eo=
X-Gm-Gg: AYBFou0uOwojLyZh0zIQ714/BhcyyEPFYtPM24SzPtJ2hZR5QAEjuq3q0REuP9C19o5
 3Mla5XR/CNzQYK8hjm4rbI1Wh50OP6pUH3iapfGOtTP0306+g8OjJsQFtpJ6XfOdCiG3zeuzCMh
 pXD3pawy8UrxOKNBkrenDS9PMVrBmofLT4dcInyOBeeyVJY5dPyvGsbXieOG8Xrgm+VKMRXYMxI
 2BnuDjEKYslmSPSRgPsQsI2DZ35c2LY24bawHd7+h5PYfWraDyaqKR7DbkweSeg4Gc0S2jjZ87R
 ITSNes16HeANARaj0akgsfvOvyib1V1dY2ahFRKN0TRaDhKXg2tp08ZLHDz+jWDQjb/4+PUxm7w
 tEMjOgRs91x/6vKuwHJGuhnRx1DrbvPMdPbOz1WKJDgGdrDOuWFpg0QgVOdXDqSr1NWiLgK/cKj
 lbdutVRRO7oFtf/Qw6vpi8m5Kub8NY4s6ejpeB/YAZoRZu6cQlyg8nEeVI5BrExZJnqEtUs7tSZ
 fDeLvyN
X-Received: by 2002:a17:90a:d407:b0:39d:f720:c5a5 with SMTP id
 98e67ed59e1d1-39e1e4907cemr7223188a91.15.1789563884804; 
 Wed, 16 Sep 2026 06:04:44 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.04.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:04:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 21/92] tcg: Generic expansion of tcg_gen_mul_*
Date: Wed, 16 Sep 2026 03:02:56 -1000
Message-ID: <20260916130409.3382710-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index eff7bf11d6f..f45e5961a22 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
@@ -311,7 +310,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
 /* Size changing operations.  */
 
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 247d35bdc14..b318ddd74e2 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -6,6 +6,7 @@ DEF3(and, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
+DEF3(mul, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c7e95dba241..2d0e2c4b34a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -433,6 +433,11 @@ static void gen_movi(TCGType type, TCGTemp *dst, int64_t src)
     gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
 }
 
+static void gen_mul(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    gen_op_ttt(INDEX_op_mul, type, dst, src1, src2);
+}
+
 static void gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     gen_op_tt(INDEX_op_neg, type, dst, src);
@@ -635,11 +640,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_mul, ret, arg1, arg2);
-}
-
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     if (arg2 == 0) {
@@ -1527,11 +1527,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_mul, ret, arg1, arg2);
-}
-
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* Some cases can be optimized here.  */
-- 
2.53.0



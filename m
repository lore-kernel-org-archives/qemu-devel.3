Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE3CEA71A4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3Sb-0000UP-0F; Tue, 21 Apr 2026 01:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3Ro-0008AX-UB
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:57 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3Rm-0006eB-JC
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:56 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2b2589c26e3so34131405ad.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776748492; x=1777353292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=127uBHcVT1oBIbFF2ckf3+yTVZK3U9JgwdEZdx7lwQY=;
 b=S7ozD9QwUH74iZtHeA+yUZugKoSxsOONUBPzk99481OPi2tomcwF6VreZnrnFH6rE5
 GfwpKj5oW+Yw+yosRT8yRUXGwKG9sLfP8AITARwL28qGEhGLcCQKtMc6Rt+1mjdD3vdK
 8loLnswKhvRRvXXb53SQhD0rj1N2bUhILeaOdpPVCzyndxv3IX0S3D0VZyzBiZuwfDC5
 t89XolqkA+IK/L4edeYiquVtaqfHitZLWG3Bc37SlshEVUzkEB4vbtcXmzp7cZQoBnN8
 tRTZ2Flfpo5ZmhuHB7BFbzctCNj5b3O7pP4r0xeKSkpDzS382Xk27GULP7laaXRz/7As
 nZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748492; x=1777353292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=127uBHcVT1oBIbFF2ckf3+yTVZK3U9JgwdEZdx7lwQY=;
 b=Z0TW7ujOW3eRExZbm3NsyZfc0qbddgLPy+t5ZLMRBnKvF7VqoBJNgsUeuywvd1dmPh
 HaJ5PmKmB7xJHuNKJMCAvVn/vklu7q2e6v48araUfQaiwV01hpKh24D5oFiwlIewpBPP
 bA9A1SnTNomoZg/Y/9/r6/rv8WL4J0tmg0pwD8k8k3WD92FGBUbiDz1PxdqlxhdADoJO
 7+5BDVZX35hiLmJxV9vlhU1wb6S/sYOUA6+chS7eTVomhtaI4J3VLa1t9TK6ggfDaedi
 MGz2fhe61REUcAEAKd1wZsbSYH3X8IVVeO+bFZ8Q9iLjunhzMiXKnjy86r3FPY0aO82c
 DO3g==
X-Gm-Message-State: AOJu0Yx7sdcMeY44Qwj8s1IC/k3Y7CwLwdPY9gbKEwuxDPhteojWs6JF
 HI2Yyw/B1kWZBOmYqfvehryNivqf7EpQNrRp5doJoIdJuWnX4C+DQPsAmP9bM4KvTRubvlo4JlD
 tttDx8Bc=
X-Gm-Gg: AeBDieu/00B+vcUnuLP4Cvz9W24JVAovz6glfAO2jZXoqUauS0YXsyvbCStBgSDrxzR
 aAgfFqtuEHyJBof/QAfkt1k2ZmvS78fB1Msg5FMCamBINrnikqbTfwGzBSBgP11uj1wh+OZHsDL
 pgiE0nQFxMO+GdLxH9QBflNs1ePl0jypDIvmN8GM7o5D+aPUn7R9CRB0qyJKE0DMclwg9sFhDw3
 r3zdgmlgZ72nxbaAdONC2adihAtgDn0wuK4NzEkIQUoGIPtmH50cEghT7z42Lkvt2l7B7KwBpyK
 oEN5HFRS4o/eAxW++kPxI1SZ4MkJtKToooN/UqqP9yAd+hlvBPD3Ofb9y43ybePnlVVNikxB5A7
 p/2fUCCNgoHN5XHUedTa2pQ8x5ad8UurX+eJaxMqRwoZ9rHxOBTnA+oC8yuW6kaCKpD9JH4ZP9x
 WP7kj+lBIBApxJiskLrqXnp/l7BmWv2slfE0vRme3j
X-Received: by 2002:a17:902:7c0f:b0:2b2:b117:1e16 with SMTP id
 d9443c01a7336-2b5f9f7e95fmr123067035ad.20.1776748491520; 
 Mon, 20 Apr 2026 22:14:51 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cddfsm174631715ad.49.2026.04.20.22.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:14:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 25/37] target/arm: Rename SME BFCVT patterns to BFCVT_hs
Date: Tue, 21 Apr 2026 15:13:34 +1000
Message-ID: <20260421051346.41106-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421051346.41106-1-richard.henderson@linaro.org>
References: <20260421051346.41106-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

The existing pattern is BFCVT (BFloat16 to 8-bit floating-point).
In preparation for introducing more insns of the same name,
append the operand sizes.

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
index c6a8eec32c..1267d3e65f 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1447,8 +1447,8 @@ static bool do_zz_fpst(DisasContext *s, arg_zz_n *a, int data,
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



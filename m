Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F017CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZAh-0000AU-Tn; Tue, 16 Jun 2026 15:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8T-0004iK-WD
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:49 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8O-0001B4-77
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:45 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-490aaeabdb4so34649045e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636856; x=1782241656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mhyD5aUR+rlm/Tn1MIb7omoW4yLbGARIJaHm5kA7KoY=;
 b=j7i2pNBnIhdS5EbAfcI13sqnyR18zqGH2IGclCPKTnpdCK4/Fet/fM3WwfkpAHEAFR
 ZafZiPoneMSlMf4LKuKS1C14TTeYNeyrSDjMvNv2rDTYIzhKwA1qLIHxAk2xD8tIOUuD
 +uy/gOORCQ4XT6ch7nVfWcBeBD/455vvcVxsI617rJl61SyQTomkpaiVpKFuI9VD8muI
 hHvpknB4zyuhmFWL6hqk03w9l1prPm6Z+zA8F3/b0e+jdbVSeyenDglUIfuynugj36xh
 M4/4CDChfICvmoWJJEb1vlzRO4QLM6SNBv/5iGkxsU6K4dlPdiWP4WbFR2Owb5zdhe1a
 QCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636856; x=1782241656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mhyD5aUR+rlm/Tn1MIb7omoW4yLbGARIJaHm5kA7KoY=;
 b=PLiimICeKMm/I2XRHiEx0daMMxbaf3mxbHLM9K0+2yLT6/Fe4ZBiEkJ7v6dmNckGY+
 CL+KB5okScuTSIXjeUuXbnP43i1wIUn+BgJeMP77IVRd+gJFeEwWKJgAktUjfq+vXjr8
 nFvAIMOrwJ2gmuy6145GwwJqVnnfT0CTYbi/TS8PTOOTJgYEy9QV7RX5KpR/ASCjx4pS
 iWIW0OobtKZXQtUeWIPeyzgZw8LU7KbsRYYAgXd+TIjeU3eLmEXAA2cQItDnkbjL0d5V
 Vuh02P9kGLVwPa5xOi3YgRtewspjMLnLq6r5WyyNGMwv6yhk2VSLA8cN7jX4xvbOUd+9
 bp2g==
X-Gm-Message-State: AOJu0Yy7lVom/1L1MlhJ4ll3sp1StaVRkS7wNTy+MORAONiuS+Oyw4Op
 9yboFmShdH6jANXWjduK6rOjMgsT8CQFft6t0AFjJ18FRUKXjDu2MJzg59y++ZqUWsI/pLeRO8E
 NfTLE
X-Gm-Gg: Acq92OHt+Kvv4HSWS45tPFcFZS5yhh5WzAnd5lLrib3MMjLVZK47ozyUC+xYYi9Qq6k
 ZaWPpeAsFOpF0pD8gxvqoLa2xUzcLG2uoY5BSyY7aV3qSGXev6HtXBx3sQU5Kxd6Y2U5YHCTi23
 bkit2hNJtRDbXIdCe/8CTLkZKQDW9GL2Jg7yRNNLQ4OGLMCvPVZmB7Q0itwguZagqfx9p8p06BP
 7oTQZ6MzCfBIDRPGhFcgH7aoqCsNmL/xkeKyvGsmQtDPa31ZN5K+HbeN4TIOpSSrvtIqLDY6cWv
 fbnGYRpLRYWZ9nRhHIoFuzoV2MDQO+jtdTHLjfOoCWGBYUkB9V8eQgJHyB3H9+TYGikOUMHaKFv
 +VXiVToWUSAZFmxS/U4YQvjcgU+IfypgOd5U3x/eWQapsDwtqiRYtA9KX2RgiCPGhF2WoLbzjKz
 JslSGgQGBYN30Bc6AmQKnox8pF6I/WDIi/t6ZNLO0aLYhXZVSSW5SGOe+SBSCOKz8+84TM50luF
 m/iuwTDxgNE+AIyTVcIEZUIaFoI+Z/c
X-Received: by 2002:a05:600c:8283:b0:490:d38c:7836 with SMTP id
 5b1f17b1804b1-492333a1683mr12829605e9.3.1781636856314; 
 Tue, 16 Jun 2026 12:07:36 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 49/61] target/arm: Implement SVE bitwise unary operations
 (predicated, zeroing)
Date: Tue, 16 Jun 2026 20:06:26 +0100
Message-ID: <20260616190639.3462006-50-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

This includes CLS, CLZ, CNT, CNOT, NOT, FABS, FNEG.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260604234852.573178-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve.decode      |  8 ++++++++
 target/arm/tcg/translate-sve.c | 21 ++++++++++++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 31b65fab1b..e79b5e84c1 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -400,6 +400,14 @@ NOT_zpz_m       00000100 .. 011 110 101 ... ..... .....         @rd_pg_rn
 FABS_m          00000100 .. 011 100 101 ... ..... .....         @rd_pg_rn
 FNEG_m          00000100 .. 011 101 101 ... ..... .....         @rd_pg_rn
 
+CLS_z           00000100 .. 001 000 101 ... ..... .....         @rd_pg_rn
+CLZ_z           00000100 .. 001 001 101 ... ..... .....         @rd_pg_rn
+CNT_zpz_z       00000100 .. 001 010 101 ... ..... .....         @rd_pg_rn
+CNOT_z          00000100 .. 001 011 101 ... ..... .....         @rd_pg_rn
+NOT_zpz_z       00000100 .. 001 110 101 ... ..... .....         @rd_pg_rn
+FABS_z          00000100 .. 001 100 101 ... ..... .....         @rd_pg_rn
+FNEG_z          00000100 .. 001 101 101 ... ..... .....         @rd_pg_rn
+
 # SVE integer unary operations (predicated)
 # Note esz > original size for extensions.
 ABS_m           00000100 .. 010 110 101 ... ..... .....         @rd_pg_rn
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index afbed77ec3..d6a1683719 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -781,30 +781,41 @@ static gen_helper_gvec_3 * const sve_cls_fns[4] = {
     gen_helper_sve_cls_s, gen_helper_sve_cls_d,
 };
 TRANS_FEAT(CLS_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, sve_cls_fns[a->esz], a, 0)
+TRANS_FEAT(CLS_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz, sve_cls_fns[a->esz], a, 1)
 
 static gen_helper_gvec_3 * const sve_clz_fns[4] = {
     gen_helper_sve_clz_b, gen_helper_sve_clz_h,
     gen_helper_sve_clz_s, gen_helper_sve_clz_d,
 };
 TRANS_FEAT(CLZ_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, sve_clz_fns[a->esz], a, 0)
+TRANS_FEAT(CLZ_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz, sve_clz_fns[a->esz], a, 1)
 
 static gen_helper_gvec_3 * const sve_cnt_zpz_fns[4] = {
     gen_helper_sve_cnt_zpz_b, gen_helper_sve_cnt_zpz_h,
     gen_helper_sve_cnt_zpz_s, gen_helper_sve_cnt_zpz_d,
 };
-TRANS_FEAT(CNT_zpz_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, sve_cnt_zpz_fns[a->esz], a, 0)
+TRANS_FEAT(CNT_zpz_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
+           sve_cnt_zpz_fns[a->esz], a, 0)
+TRANS_FEAT(CNT_zpz_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz,
+           sve_cnt_zpz_fns[a->esz], a, 1)
 
 static gen_helper_gvec_3 * const sve_cnot_fns[4] = {
     gen_helper_sve_cnot_b, gen_helper_sve_cnot_h,
     gen_helper_sve_cnot_s, gen_helper_sve_cnot_d,
 };
-TRANS_FEAT(CNOT_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, sve_cnot_fns[a->esz], a, 0)
+TRANS_FEAT(CNOT_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
+           sve_cnot_fns[a->esz], a, 0)
+TRANS_FEAT(CNOT_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz,
+           sve_cnot_fns[a->esz], a, 1)
 
 static gen_helper_gvec_3 * const sve_not_zpz_fns[4] = {
     gen_helper_sve_not_zpz_b, gen_helper_sve_not_zpz_h,
     gen_helper_sve_not_zpz_s, gen_helper_sve_not_zpz_d,
 };
-TRANS_FEAT(NOT_zpz_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz, sve_not_zpz_fns[a->esz], a, 0)
+TRANS_FEAT(NOT_zpz_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
+           sve_not_zpz_fns[a->esz], a, 0)
+TRANS_FEAT(NOT_zpz_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz,
+           sve_not_zpz_fns[a->esz], a, 1)
 
 static gen_helper_gvec_3 * const sve_abs_fns[4] = {
     gen_helper_sve_abs_b, gen_helper_sve_abs_h,
@@ -857,6 +868,8 @@ static gen_helper_gvec_3 * const fabs_ah_fns[4] = {
 };
 TRANS_FEAT(FABS_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            s->fpcr_ah ? fabs_ah_fns[a->esz] : fabs_fns[a->esz], a, 0)
+TRANS_FEAT(FABS_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz,
+           s->fpcr_ah ? fabs_ah_fns[a->esz] : fabs_fns[a->esz], a, 1)
 
 static gen_helper_gvec_3 * const fneg_fns[4] = {
     NULL,                  gen_helper_sve_fneg_h,
@@ -868,6 +881,8 @@ static gen_helper_gvec_3 * const fneg_ah_fns[4] = {
 };
 TRANS_FEAT(FNEG_m, aa64_sme_or_sve, gen_gvec_ool_arg_zpz,
            s->fpcr_ah ? fneg_ah_fns[a->esz] : fneg_fns[a->esz], a, 0)
+TRANS_FEAT(FNEG_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz,
+           s->fpcr_ah ? fneg_ah_fns[a->esz] : fneg_fns[a->esz], a, 1)
 
 static gen_helper_gvec_3 * const sxtb_fns[4] = {
     NULL,                  gen_helper_sve_sxtb_h,
-- 
2.43.0



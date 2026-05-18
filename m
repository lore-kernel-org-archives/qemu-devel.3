Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61534CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 01:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOmSl-0003sJ-QR; Sun, 17 May 2026 21:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOmSN-0003Ws-Dp
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:07:50 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOmSJ-0007L4-S1
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:07:41 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-36608b2f2dcso816601a91.2
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 18:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779066458; x=1779671258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SfttRLEIZQOGp3sxDxlyo/zxtSg+H+d581YfAivT8/0=;
 b=Uw/Vxa2p3IN2UYsDi+W/USJ82n1xcO/J/i8r/pHvrwstjGSVusT2RNBfL/z6s6nZkR
 KBvNaDu4klinD1Elw//AaoFMefRLzpfIW4LyiCmrZxrRbQnlKV/0VjXwCQ4giWZcPEG7
 /vLLvflHqvk9iW7S0k658FUkxa8QPZ8SPahIDgrSGB7cCRn2e9djzb3LtBE9jNzBZXE8
 77PEPHpN/ix5yXLfTKTdrK0bSJzIlrRAyyru7sV8njE9HzFbJgAwQtyIOQwJ5HL/nW+N
 VWxNf96be+5xVmivMh3ctZQRqGUd5rLbbta80E83G8eTDEDhyBrxrPko8mhdwb74Dsl5
 AdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779066458; x=1779671258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SfttRLEIZQOGp3sxDxlyo/zxtSg+H+d581YfAivT8/0=;
 b=HbkGdw+FZdh4w1vq1lpgLpZotondEBV78chj6JekfoWGJyn7m8PzIP3qLCvhGPE59u
 R+UDQRjISshlxWydCr+OZpov44vfWEPlZXOmjpe6n09SJ2XbcTL3fhJLn2O9xqzxd8TB
 Us1Tql1CCYx6aR2uoXpehb9ccvB8MUMkjIDWDxPvYUyaRlcUSLzUiWbKD+hfy6A0b3vP
 ai6sn2/DXS49GMAOn85D8zgU1OyHVP/k9mEhWzl6wlJoS5W6m09R0i71FIQYP8YvlT1L
 yMtt5Cx9LX1eGAuHJYyRxiq4ob5bNawJI6c02pAbAhSM78eFnNwf9vrOvKby1cLsRn1U
 3QeA==
X-Gm-Message-State: AOJu0Yw+QaY3YwK1q6alan2YOf9BKL746bnBTWzR9de+dgIgyrjvgOTM
 sqIZRcbOQZILSyx9lqNgQhkG8GPe4vWclF1b9OC9GJjR3AmudN8f/G85tN7RewxbF5/GD44wg1K
 qapwC
X-Gm-Gg: Acq92OEFMBF5tIveBAAtSCo2TMm57jS/o9eEzNOmmgf5GpXsTGKhcha+pYWElRV8Bf6
 FvlprlvXYakipipMzLRB88GtONLOa3jVZeUUPwbSqpBfDKEes7wPlBuuOLEFuF4+/CFVUHWNG/U
 uvlkRhv4l77yoA9YFuu8LSB/V0R6PubdJBzlfk2YLTXrXOdilO4AchcU/4r/+BPy3wEfGT5aPjq
 PgI//O1yKL3BagCi47KJa9U3GwmIpdWNrFloZvAfC4QWViQD0j60pfxapBFw4xwSIGlOT25BESO
 HjvXGY6CSZR4NxYCN9NiB01VB8jF4fm2lhHk5r9bi9wxm5q8dLxLBhoP48MfFqd1r8ekn/hoXFm
 a7dAkUrSMrEp1Uv+bDf5V9FPTgvbno4WyU9ujSTr4hrBoxEsYa2Yh8TTiK7K1atOY7Z7yju7dHj
 JWpdvMYjNZsdFTirbd5FlLq+TSzzGuq+LhKG5Z60Q=
X-Received: by 2002:a17:90b:2e0b:b0:35f:c46f:2b0 with SMTP id
 98e67ed59e1d1-36951a6ce4emr12526677a91.14.1779066458280; 
 Sun, 17 May 2026 18:07:38 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36951584654sm9160939a91.7.2026.05.17.18.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 18:07:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: james.hilliard1@gmail.com,
	philmd@linaro.org
Subject: [PATCH v7.5 4/9] target/mips: add Octeon MTM instructions
Date: Sun, 17 May 2026 18:07:28 -0700
Message-ID: <20260518010733.502237-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518010733.502237-1-richard.henderson@linaro.org>
References: <20260518010733.502237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

From: James Hilliard <james.hilliard1@gmail.com>

Loads the Octeon3 multiplier operand pair from rs/rt into MPL[x]
and MPL[x+3], and clear the partial products.  For MPL0, also set
MPL[1] to zero for backward compatibility with Octeon2 VMULU.

Legacy single-source encodings have rt encoded as $zero, so the same
translator path also preserves the older Octeon behavior.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/tcg/octeon_translate.c | 32 ++++++++++++++++++++++++++++++
 target/mips/tcg/octeon.decode      |  7 +++++++
 2 files changed, 39 insertions(+)

diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index e1f52d444a..8ebda0ecb3 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -186,3 +186,35 @@ TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
 TRANS(LWX,  trans_lx, MO_SL);
 TRANS(LDX,  trans_lx, MO_UQ);
+
+static void octeon_zero_partial_product_state(void)
+{
+    for (int i = 0; i < OCTEON_MULTIPLIER_REGS; i++) {
+        tcg_gen_movi_i64(oct_p[i], 0);
+    }
+}
+
+static bool trans_mtm(DisasContext *ctx, arg_r2 *a, unsigned int index)
+{
+    /*
+     * Octeon3 two-source MTM forms load lane index from rs and lane
+     * index + 3 from rt.  Legacy one-source forms encode rt as $zero.
+     */
+    gen_load_gpr(oct_mpl[index], a->rs);
+    gen_load_gpr(oct_mpl[index + 3], a->rt);
+
+    /*
+     * Octeon3 clears P1 with P0 so that VMULU sequences remain
+     * backward compatible with Octeon2.
+     */
+    if (index == 0) {
+        tcg_gen_movi_i64(oct_mpl[1], 0);
+    }
+
+    octeon_zero_partial_product_state();
+    return true;
+}
+
+TRANS(MTM0, trans_mtm, 0);
+TRANS(MTM1, trans_mtm, 1);
+TRANS(MTM2, trans_mtm, 2);
diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 102a05860d..bbd48d1dc6 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -41,6 +41,13 @@ POP          011100 rs:5 00000 rd:5 00000 10110 dw:1
 SEQNE        011100 rs:5 rt:5 rd:5 00000 10101 ne:1
 SEQNEI       011100 rs:5 rt:5 imm:s10 10111 ne:1
 
+&r2          rs rt
+@r2          ...... rs:5 rt:5 ..... ..... ...... &r2
+
+MTM0         011100 ..... ..... 00000 00000 001000 @r2
+MTM1         011100 ..... ..... 00000 00000 001100 @r2
+MTM2         011100 ..... ..... 00000 00000 001101 @r2
+
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
 LWX          011111 ..... ..... ..... 00000 001010 @lx
-- 
2.43.0



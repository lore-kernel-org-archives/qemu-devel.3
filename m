Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5724FEA71A4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3Sd-0000XO-4u; Tue, 21 Apr 2026 01:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3SA-00005C-KN
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:15:28 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3S8-0006vm-O5
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:15:18 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2b299b3c739so17247565ad.3
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776748515; x=1777353315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=89Ve9V43x0EDfFcuX4z32PJFwEIHKLJcoTkwxamYsNA=;
 b=Fr3EHE6XIbiz3QMU3BHwOV5CTeIgS6VSV6Gy5hpfxSbc8l2sRkfJv0JijpbJgKJdTz
 iymClDR2JmBV6EBaHZmEn5JnXZixqnxkJYlz1w6mrIxIschBH1NkWPuU3Y9Etfi/ldjZ
 nNXZIo8p/jLNCYF7qmG7+rmtVbzrjAJ3RsRh/adc4UFr/OWCBSEqp08stSnPZJ6+wkNb
 50/W6gnHuPEhknbIFGOf59PCGMjNqzY41OJ2Eucteap09Er/yvwBvWe8H9bS0wAZjScV
 /epM3+V9EjD/aR5OkbJ/ve3i0kUk0wsSF0VTrgtTZkjl60nS+zaJ7KYlenNaKtO40syl
 0M6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748515; x=1777353315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=89Ve9V43x0EDfFcuX4z32PJFwEIHKLJcoTkwxamYsNA=;
 b=AI3DGDOf94e2edkqpiWbz+oRGTEjYv0hqR+CcstKXNxQSOzSuhDNNxQVXHnxOVMFx5
 kejDZAJ5BHgbhTZnemKpG/r9TrRyP7IFqd0D+xPP5TmgRmwkPQtU+xVPmDMe7+ZHcn9C
 i6WbXIFqE1KAAwYiHvfq7MvNhicaoAtYJdKesdHX/UWB95SR3ILa/+RhbwF+qUGHGJ2j
 7wYFIUMU8BmKsOJd38iEPU4FNsFYTaUvJ38gSMFqj4bIDeRBb8n/nXhDLRVYeDqhwbAR
 sOyggHedT7q0YlhBb7dkTjG/Vgo9Eo1S7hndJtkmV2onrvLYm2Ui6KH0KRgHnMlr8xop
 UzhQ==
X-Gm-Message-State: AOJu0YwdwK6JSNLHTdRSp+mS8UEh2VG9u0Mp8J+Nimydveg4YO9r9PXD
 VqsReZJVCn9LIZKUrmuGbES+MRA2kr307DMoXnKYfELD/BNM4bCwvvSXpqQEwV4lvHpNAlahNPg
 hL/QEjGE=
X-Gm-Gg: AeBDiesrMuyCkrWUSHMAk9sGiF+bezSYhalyR8BnOgB00DnQKsLn1zKfgwnLQeb6940
 CxsHBiVPe5HBnocNDQuqaava+59cav/G01NDEbxRffkvC7xb0bpxPG/5niDz++o7sLPEDHDy8x2
 OA6nlQadxtuGSTJ9oGvxfo6r/TyvbyURyh6chkGzTs2c+q+Sn7ADOgAxvZdKayzGLL6UTXZkai8
 HzaS4707zQbbwYDAt06fOjWj57lzzuTHqpHdcUhO2sYpJThfCox+/C1Rmm5OyQJpAlF71R8sw7a
 jIx6txemrqXZVFTqnnqzQ9Ux3rpBGZpXMTJkwsEnmFh2HSfaFXCf7/VRJWbIwVutdmUz+0Vr7YJ
 sSbbIsrNCzMqsq479Ug3oLse7h4q6rycIM94b4knfQV381r4Q1XCqAfxuCqROfmtF7hVOydLIrG
 jXZnvhqTHZLziTTviqtNiVdN0z1fVZKN/Jod/riBSJC7SjqQ4Jg+A=
X-Received: by 2002:a17:903:166e:b0:2b0:a957:304 with SMTP id
 d9443c01a7336-2b5f9e85b42mr178905355ad.6.1776748515180; 
 Mon, 20 Apr 2026 22:15:15 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cddfsm174631715ad.49.2026.04.20.22.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:15:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 35/37] target/arm: Implement FCVT (FP16 to FP8) for SME
Date: Tue, 21 Apr 2026 15:13:44 +1000
Message-ID: <20260421051346.41106-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421051346.41106-1-richard.henderson@linaro.org>
References: <20260421051346.41106-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 16 ++++++++++++++++
 target/arm/tcg/sme.decode      |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 29d116a57a..b112f16cd7 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1555,6 +1555,22 @@ TRANS_FEAT(BF2CVT, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_bfcvt_hb, 1)
 TRANS_FEAT(BF1CVTL, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_bfcvtl_hb, 0)
 TRANS_FEAT(BF2CVTL, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_bfcvtl_hb, 1)
 
+static bool trans_FCVT_bh(DisasContext *s, arg_zz_n *a)
+{
+    if (!dc_isar_feature(aa64_sme2_f8cvt, s)) {
+        return false;
+    }
+    if (fpmr_access_check(s) && sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->zd),
+                           vec_full_reg_offset(s, a->zn),
+                           vec_full_reg_offset(s, a->zn + 1),
+                           tcg_env, svl, svl,
+                           FPST_ZA << 2, gen_helper_gvec_fcvt_bh);
+    }
+    return true;
+}
+
 static bool do_zipuzp_4(DisasContext *s, arg_zz_e *a,
                         gen_helper_gvec_2 * const fn[5])
 {
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index d6192eb59d..a02bcc0e22 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -863,6 +863,8 @@ BF2CVT          11000001 111 00110 111000 ..... ....0       @zz_2x1
 BF1CVTL         11000001 011 00110 111000 ..... ....1       @zz_2x1
 BF2CVTL         11000001 111 00110 111000 ..... ....1       @zz_2x1
 
+FCVT_bh         11000001 001 00100 111000 ....0 .....       @zz_1x2
+
 ZIP_4           11000001 esz:2 1 10110 111000 ...00 ... 00   \
                 &zz_e zd=%zd_ax4 zn=%zn_ax4
 ZIP_4           11000001 001     10111 111000 ...00 ... 00   \
-- 
2.43.0



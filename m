Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14139CD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX28V-0004wx-Im; Tue, 09 Jun 2026 15:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX220-0003d3-Ua
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:43 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21q-00045A-Pv
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:32 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2bf237e1433so66139525ad.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781032885; x=1781637685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ti3Lzz7ZpcUNrArVEJRLWhneqvaOUMGJ0jgbnQ7/QBQ=;
 b=iNVVRQ1JhxcrlioiljvsXjpg9hKwpZnQ5SSMjIdfeD1XrKzHN48M4ZBksZAY1sPqoF
 GCc6iWvAGw9z7v8lyxCerKN6JdEAkCVj+TOnevQTyAJei1vIun9Pr6p1tcpWOKuJcLh9
 NoaP55Kg1zHnjibhjz5HluLaB36cfWP0fOZDTG1SfFu+H6KokciZXimTxaLJ5MUAnlOG
 0CpHYXMHF+TkSM3MQHHuggTs2n9wrvcYNYty51+Rs1YfSNCTPfIIKwcdl3Y7Kri5ZoD4
 wbg4HobJFlh8IfXa7uChm2nCa4Nl+teVqNX5vYfoI3Cdac+zNWmOp3xSUYAfUs7GmTHv
 inSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032885; x=1781637685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ti3Lzz7ZpcUNrArVEJRLWhneqvaOUMGJ0jgbnQ7/QBQ=;
 b=j18WLdqZDVvVZsvuIvV+h3YLsWpes8friL5lBiWenbQ2TsJJvw3yKcEmoQmfTTpj1o
 NG09xDXSQ7a2qnduvtcZUDR8W7axDxZKI3JcZoyMvCEvVA0kBa6p+i2I7MPp2xlJg3+r
 1iE+/jyTN73o/7LWSd2C+3DtkWRXmKiAP/UyGGDJocdBSq5NT9NDenGM4AXaALouY6iD
 K8hQi+JGeuupRZ/epjcxe3bCaYkWSnOp9oxIRAOh3lAqzAa7om5VqfCXkgLr6/qOjNlH
 LD+3vGkSCvhyy0joKKG33Ic7CrjhbS5QuiWe9v9oQkLzd9QqGRqQqro2DgyDDcn+x/Mn
 Sfbw==
X-Gm-Message-State: AOJu0YwMPGsyFnCF3z19ryMZ0ylRxwhqv00EkcFk21cyjhtRQNnjOstG
 p863/9a9o6OadqBzIvxpToOy1E5EgSRMZMCTfRhbaDorVfRFIutkXamvfR4I5BDMNrUnZ1zWzyh
 vhZ9xoKo=
X-Gm-Gg: Acq92OExXxztbmBYvVuOthB5CKCrn+KtlIFQLMZETizG3qe9O6LYvhBw4i/EXwOzGUT
 +xWZetinvfNdSTvma0W+3apKsLJR9pnp6VDcq8b2IFpyyB4eUS4wN9xGVU4clHDVdwefjtYYnSv
 CDpwMJ8411Csq2fAHkxj3PQLrhs9NnaszsM+QXADMi1x7pTbM/430w6dxqqHoX5CyoKdMTExbhu
 ugpUT9yRLlnSgrVYv78mWl7AyXHQp2CVB1j7eUGiQaByoXU3G5wmnYkSs2cm3wXxi68XxZEIKdg
 X1+St1RAKLItnzlQZ7LR0T6eWM+i7Loi1+Iw+PNIiAeDtooy2JwOjWq60lJ7Q1C7nQbdy1S5nLY
 XfRNXpwK3Xu9ca4OUxXHa1NC0vzogGlJ6u06L47QJp/PkyA1Kg8VURoc+8oglan7g0GtV2RUOyd
 8mkGy92QAH2oS5lw21FCp1fiY5UKGiknPx4kmj+Co=
X-Received: by 2002:a17:902:f711:b0:2c0:ab82:6ba7 with SMTP id
 d9443c01a7336-2c1e85ad8d7mr257081585ad.33.1781032885143; 
 Tue, 09 Jun 2026 12:21:25 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f88473sm240806095ad.25.2026.06.09.12.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:21:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v10 19/45] target/arm: Implement FCVT (FP16 to FP8) for SME
Date: Tue,  9 Jun 2026 12:20:43 -0700
Message-ID: <20260609192110.752384-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 16 ++++++++++++++++
 target/arm/tcg/sme.decode      |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index c0fe77242b..49eee95d88 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1556,6 +1556,22 @@ TRANS_FEAT(BF2CVT, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_bfcvt_hb, 1)
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



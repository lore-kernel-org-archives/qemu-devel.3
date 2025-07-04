Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD43C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEU-0000gJ-Am; Fri, 04 Jul 2025 12:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjER-0000a3-FD
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:47 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEP-0006H7-Pc
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:47 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so9790035e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646344; x=1752251144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q2DJT3TgBXEzDGrgAB3daciUL8MwUdJl88P2HVC3REk=;
 b=Rd63xoHpo5teFC4V8FK8xDkUdp95snrSfr13su6YRyHdHUXsFZIMcQ9DiMu1XTDeZd
 nfH8D2nCwmznQgLTlciREeGpP8jZJJndb3t70IhiijH10dMa+QlOUEVphdFN4bC1gytN
 rFpxgJao0yiyXVdvWyVSwVPmz0wmGUTV0lvn3jNvrOapWNtseCrpzGWYm7uHzxgqKGIg
 ib16+BOJrRW0CSSxaoD7OU19/CyiJr5X4MHLzqqS33VkMCD3YERBBY8xU8MKWf8mBdpr
 PFii1WVRO0dA90vTfiXpKVbp6yFXpTrqjtPu8XAOWCJr6K1Z8hutyk1rnGn0SqBBvtBG
 8qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646344; x=1752251144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q2DJT3TgBXEzDGrgAB3daciUL8MwUdJl88P2HVC3REk=;
 b=wwYn03glizaoN0udE+ffTR2gKvNC4bx9sJ00hQ5GmFDh02ZE+eW40ObTZ6Z1dOj0gK
 aKdE+8alpcqMyDror1QXbE+85HQy8aHcrB5LpgffaSkjxJUbjyQAf7hXuKXY9j0q3qUS
 SDepnHiuc0jcbwqVCF2or4agumzP3PvgTcW/B3EHVgFFpra3IQjeXAQJRe53bucuhHCV
 nPRrUxJeDz/MlK+D0H84FUw9fUPqERf+tgbSt52tMjGEOLPqV4qgObcP/BwnSmD1vfRZ
 WCK9RB8H4nnF9DKK/2XivaT0gzMeUGrBfpIiDocjSa0pAloZStnehicRqP4W361qv/2E
 vTsQ==
X-Gm-Message-State: AOJu0YyVfEVxwFMfkWlDIciX3Zyc/vJraoTzvS3/3ozmOQc4bxzYAAnp
 6HgNP6ANrADcY96poRh+mcByV1FtWrIpZqRAUJcPL6G60U/oajM1o3QRe1o2PsAMg9JjqBUfjhw
 VB6Ml
X-Gm-Gg: ASbGncvytARURriFSNpiSXt5iHjkHsm4vThAu3Dve/7g1kwN01MYrKP7kQj15X3bOPN
 FtJFX4W6yFkOO6vUpdxf6HakqYs/vGlNGIFbccR5tGQ2dRbtP+G3EHMchLhhqJcNC5fKaK+jq9h
 cMvtCgI0gVsNT8FoTY3/nJxeNt5Dg+pDwrWMHyt3YtG3EYcGEOVDDvBwgr5okiJVACT2iFBJO3K
 mhK+ECGD8M0TxDalAvw80/n5+tvpsPECFfipoY4TzhH6ztKh4r9Ue3h/g9yil6HeqszD0VofTLl
 p/N4is+RdMVZFIz4CUKTw1lw3Dzk3a9PmQ+bemZKmF0L3gtUjmXvRyRUz6uQ4ruh6+Ox
X-Google-Smtp-Source: AGHT+IF6nQN7ZSNFu8TqV3E5E/4vLBrDvdLvGRXx+qHZSqLD4zuE3XSeEkgwJ6TktsRHKiFYiNwMMA==
X-Received: by 2002:a5d:5f92:0:b0:3a4:d0ed:257b with SMTP id
 ffacd0b85a97d-3b497020597mr2267741f8f.22.1751646344279; 
 Fri, 04 Jul 2025 09:25:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 045/119] target/arm: Implement SME2 ADD/SUB (array results,
 multiple vectors)
Date: Fri,  4 Jul 2025 17:23:45 +0100
Message-ID: <20250704162501.249138-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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
List-Id: <qemu-devel.nongnu.org>
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-34-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme.decode      | 20 ++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 8b81c0a0ced..a6dee08661e 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -260,3 +260,23 @@ SUB_azz_n1_s    11000001 0010 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=2
 SUB_azz_n1_s    11000001 0011 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=4
 SUB_azz_n1_d    11000001 0110 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=2
 SUB_azz_n1_d    11000001 0111 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=4
+
+### SME2 Multi-vector Multiple Array Vectors
+
+%zn_ax2         6:4 !function=times_2
+%zn_ax4         7:3 !function=times_4
+
+@azz_2x2_o3     ........ ... ..... . .. ... ..... .. off:3  \
+                &azz_n n=2 rv=%mova_rv zn=%zn_ax2 zm=%zm_ax2
+@azz_4x4_o3     ........ ... ..... . .. ... ..... .. off:3  \
+                &azz_n n=4 rv=%mova_rv zn=%zn_ax4 zm=%zm_ax4
+
+ADD_azz_nn_s    11000001 101 ....0 0 .. 110 ....0 10 ...    @azz_2x2_o3
+ADD_azz_nn_s    11000001 101 ...01 0 .. 110 ...00 10 ...    @azz_4x4_o3
+ADD_azz_nn_d    11000001 111 ....0 0 .. 110 ....0 10 ...    @azz_2x2_o3
+ADD_azz_nn_d    11000001 111 ...01 0 .. 110 ...00 10 ...    @azz_4x4_o3
+
+SUB_azz_nn_s    11000001 101 ....0 0 .. 110 ....0 11 ...    @azz_2x2_o3
+SUB_azz_nn_s    11000001 101 ...01 0 .. 110 ...00 11 ...    @azz_4x4_o3
+SUB_azz_nn_d    11000001 111 ....0 0 .. 110 ....0 11 ...    @azz_2x2_o3
+SUB_azz_nn_d    11000001 111 ...01 0 .. 110 ...00 11 ...    @azz_4x4_o3
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 4bb880d9ef8..aabdb966751 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -775,3 +775,33 @@ TRANS_FEAT(ADD_azz_n1_s, aa64_sme2, do_azz_n1, a, MO_32, tcg_gen_gvec_add_var)
 TRANS_FEAT(SUB_azz_n1_s, aa64_sme2, do_azz_n1, a, MO_32, tcg_gen_gvec_sub_var)
 TRANS_FEAT(ADD_azz_n1_d, aa64_sme2_i16i64, do_azz_n1, a, MO_64, tcg_gen_gvec_add_var)
 TRANS_FEAT(SUB_azz_n1_d, aa64_sme2_i16i64, do_azz_n1, a, MO_64, tcg_gen_gvec_sub_var)
+
+/* Add/Sub each vector Z[m*N] to each Z[n*N] with result in ZA[d*N]. */
+static bool do_azz_nn(DisasContext *s, arg_azz_n *a, int esz,
+                      GVecGen3FnVar *fn)
+{
+    TCGv_ptr t_za;
+    int svl, n;
+
+    if (!sme_smza_enabled_check(s)) {
+        return true;
+    }
+
+    n = a->n;
+    t_za = get_zarray(s, a->rv, a->off, n, 1);
+    svl = streaming_vec_reg_size(s);
+
+    for (int i = 0; i < n; ++i) {
+        int o_za = (svl / n * sizeof(ARMVectorReg)) * i;
+        int o_zn = vec_full_reg_offset(s, a->zn + i);
+        int o_zm = vec_full_reg_offset(s, a->zm + i);
+
+        fn(esz, t_za, o_za, tcg_env, o_zn, tcg_env, o_zm, svl, svl);
+    }
+    return true;
+}
+
+TRANS_FEAT(ADD_azz_nn_s, aa64_sme2, do_azz_nn, a, MO_32, tcg_gen_gvec_add_var)
+TRANS_FEAT(SUB_azz_nn_s, aa64_sme2, do_azz_nn, a, MO_32, tcg_gen_gvec_sub_var)
+TRANS_FEAT(ADD_azz_nn_d, aa64_sme2_i16i64, do_azz_nn, a, MO_64, tcg_gen_gvec_add_var)
+TRANS_FEAT(SUB_azz_nn_d, aa64_sme2_i16i64, do_azz_nn, a, MO_64, tcg_gen_gvec_sub_var)
-- 
2.43.0



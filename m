Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE9EC25B7E
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJmR-0000xe-1u; Sun, 26 May 2024 15:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJmB-0000Oq-Dm
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:29 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJm7-0007la-FU
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:26 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f4a52d2688so584765ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752601; x=1717357401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lNo8B9DGkaJhGkOedZ7a2bnlQzU20oM7B1vBH25Gpp8=;
 b=oQT3OlghfluM4uzbuKk3HjkQRBpxzIkrvJWeL2sF7sv5Gzn2wdxondUGRRRPW7ZqEf
 NPML3jlw+Zoil2ALGI+LUJgm44DDb6t1zQbVtDwC0pnFfe0yevRwqnaatgAvvYE0rbRF
 ydRJ9vmGwAhTCALkyRVynxk+gwL3t0MqnjA72bA47T21CIfIn+t/+damXdLxRYXsWbCi
 t5c+0m0l62JrI0743KBMoN4u6VllwjBGk8b8CA9dTQ+hAFkoPjDx5XqmVVxpiBkzzJt4
 ag27Y9OpHcS0T413aoXb/ONAeDQhRQHuOuoDFBXq8uw/QmWSLKPUhBBzat2E4R55xaX9
 1xZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752601; x=1717357401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lNo8B9DGkaJhGkOedZ7a2bnlQzU20oM7B1vBH25Gpp8=;
 b=CB/u5iY3yCND4gWhrC+pqH+ygCj0I+AGu7JpgB/s0wIAuUrJrgOgIp7sZSpDkh7bVv
 Uz+ZFYxjwsmx8zBD0EqbduLO3KmIMJ2nLlxj8itc1+KfpReIfkjULdJbVvFEJcl6nR0Y
 vYn2ehwDiesXPn7Cc26rsd3w36wpqEt1XWjnx2+tmmn2O/DoiNluCynMojKJjj4eAppJ
 CRYlATMkgP03GDK5TbJZjydrnNhUjhzU4aX6RaV7SjjMajacWwwdMthG7fR5xAauxQki
 DvhhNsm8feOUEvMRYt8fnLm8RCBVxlvnaqGOr+xsRIT8Bd1LRfwKz9ubR3EEiHEziJ3j
 OKqw==
X-Gm-Message-State: AOJu0YzZMl25vDpvYWWXsZKPT7T4kGW0IMMiNwYSM4jB32gKEWN4IJxE
 AxkbBFR+VRkp1QocWieluuPSpoKd9u3ZA8wknhhHqZaVi5GhxRoyUFHRycztgynU/oanEU6/yWh
 Z
X-Google-Smtp-Source: AGHT+IF6pSdiu9Ew9ll2cJMHEGby5fzdMVF6gYxeoOZr92RMMyZf/CbkKtqTjXQivrxRkiqSmtQ3FQ==
X-Received: by 2002:a17:902:f546:b0:1f4:7ee6:af17 with SMTP id
 d9443c01a7336-1f47ee6b327mr62572395ad.64.1716752601413; 
 Sun, 26 May 2024 12:43:21 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:43:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 33/37] target/sparc: Implement FPMIN, FPMAX
Date: Sun, 26 May 2024 12:42:50 -0700
Message-Id: <20240526194254.459395-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode | 14 ++++++++++++++
 target/sparc/translate.c  | 14 ++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index be591171ad..2ebee5a1ca 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -524,6 +524,20 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     FPSUBUS8    10 ..... 110110 ..... 1 0101 0111 .....    @d_d_d
     FPSUBUS16   10 ..... 110110 ..... 1 0101 0011 .....    @d_d_d
 
+    FPMIN8      10 ..... 110110 ..... 1 0001 1010 .....    @d_d_d
+    FPMIN16     10 ..... 110110 ..... 1 0001 1011 .....    @d_d_d
+    FPMIN32     10 ..... 110110 ..... 1 0001 1100 .....    @d_d_d
+    FPMINU8     10 ..... 110110 ..... 1 0101 1010 .....    @d_d_d
+    FPMINU16    10 ..... 110110 ..... 1 0101 1011 .....    @d_d_d
+    FPMINU32    10 ..... 110110 ..... 1 0101 1100 .....    @d_d_d
+
+    FPMAX8      10 ..... 110110 ..... 1 0001 1101 .....    @d_d_d
+    FPMAX16     10 ..... 110110 ..... 1 0001 1110 .....    @d_d_d
+    FPMAX32     10 ..... 110110 ..... 1 0001 1111 .....    @d_d_d
+    FPMAXU8     10 ..... 110110 ..... 1 0101 1101 .....    @d_d_d
+    FPMAXU16    10 ..... 110110 ..... 1 0101 1110 .....    @d_d_d
+    FPMAXU32    10 ..... 110110 ..... 1 0101 1111 .....    @d_d_d
+
     FLCMPs      10 000 cc:2 110110 rs1:5 1 0101 0001 rs2:5
     FLCMPd      10 000 cc:2 110110 ..... 1 0101 0010 ..... \
                 rs1=%dfp_rs1 rs2=%dfp_rs2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index a952a990cc..242f483fd2 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5057,6 +5057,20 @@ TRANS(FSRL32, VIS3, do_gvec_ddd, a, MO_32, tcg_gen_gvec_shrv)
 TRANS(FSRA16, VIS3, do_gvec_ddd, a, MO_16, tcg_gen_gvec_sarv)
 TRANS(FSRA32, VIS3, do_gvec_ddd, a, MO_32, tcg_gen_gvec_sarv)
 
+TRANS(FPMIN8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_smin)
+TRANS(FPMIN16, VIS4, do_gvec_ddd, a, MO_16, tcg_gen_gvec_smin)
+TRANS(FPMIN32, VIS4, do_gvec_ddd, a, MO_32, tcg_gen_gvec_smin)
+TRANS(FPMINU8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_umin)
+TRANS(FPMINU16, VIS4, do_gvec_ddd, a, MO_16, tcg_gen_gvec_umin)
+TRANS(FPMINU32, VIS4, do_gvec_ddd, a, MO_32, tcg_gen_gvec_umin)
+
+TRANS(FPMAX8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_smax)
+TRANS(FPMAX16, VIS4, do_gvec_ddd, a, MO_16, tcg_gen_gvec_smax)
+TRANS(FPMAX32, VIS4, do_gvec_ddd, a, MO_32, tcg_gen_gvec_smax)
+TRANS(FPMAXU8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_umax)
+TRANS(FPMAXU16, VIS4, do_gvec_ddd, a, MO_16, tcg_gen_gvec_umax)
+TRANS(FPMAXU32, VIS4, do_gvec_ddd, a, MO_32, tcg_gen_gvec_umax)
+
 static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i64, TCGv_i64, TCGv_i64))
 {
-- 
2.34.1



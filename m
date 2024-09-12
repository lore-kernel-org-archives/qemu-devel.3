Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E64EE57FD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 02:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soZmm-0006kK-UK; Wed, 11 Sep 2024 22:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZm3-0003HD-Oi
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:35 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZm1-0004DG-RL
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:35 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-207397d1000so12570435ad.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 19:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726108892; x=1726713692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YSOEdaLeZCfPJbRKNmK3UxW2mNrgDyxy1eu96FTDCng=;
 b=qIjz3EFeOJleaipmATgNyYxcU5wx6Ce3hm5OoAyc/2TeWM80E536nH2il1I0XiQgpu
 EOQBbhvs7MnUmH5fOkEVg0JXmXaOpkYvF9soavuZJwLC0rCv3BKhW43tMIV3rQDgoJop
 MDt/sGmOows6SblQ4puKSbJB1g9C1JNTW2yz465E9fMVlthekEwCXjjaoP88E/DofBAm
 8vc5++Rq8fqqoiY7/7TLG01O436vBXK1Czur3y2jmdRoGynlSJJvaRn3tS7jTcBJvMUS
 8Bq8iKFCXvgqKDoVu2zCZbw2O/JG6kQYnTvkWH3wtbxpmQSRm3fSdyZaInZP2z+6mhb2
 e2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726108892; x=1726713692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YSOEdaLeZCfPJbRKNmK3UxW2mNrgDyxy1eu96FTDCng=;
 b=fySgnnPLyD2SDps76JLJCjIs8zYsO3RuS6ihgWNulZn0w7tLy6e4h2DMdXSfRiBABM
 /7Y/b7IdZv7TRDqxEHUs0tFa2lp/gQJQaGuzwFoP63kvM3D5vv9f+AUUJzXZq8dGSE7j
 QQ+O56wh8TrtLKzWOGoAO+tW/tiEt7BpTi14BbHpjI2v9ezK+TiBjWnHreUAbfZX0+iX
 7SIrZ7VkQ1VIe8DR3VUQzdSZYpPkKXanIsaYMxx2CH8sLyS0lfShqIOAlgM5GlbdUjIs
 yGt5unuLE8jgfzCN6sKNW8+QpMPF2MlGZFt65TqbbUKn2PqbjMSIeMtRtS5/wK421Kml
 8HmQ==
X-Gm-Message-State: AOJu0YykSr4oDTm+xuxO9WoN0AjDzYS1VxFQ0kyuG+FPQzFGiE/0X6Yz
 5ovhFL/JU7iOB5HNTr8Ahw2QMN9X8XKXyWB//pRENzNfC8k+pOWnptZbvBfIl/GZvxgfN6muxeL
 m
X-Google-Smtp-Source: AGHT+IH76nIjQ8WUnq02DrrnNsIW5kh1dzXt5iTLq2bBCGUbNHqZdh7YRO2BoWy7FkjiXEV0gRybig==
X-Received: by 2002:a17:902:d4ce:b0:1fd:96c7:24f5 with SMTP id
 d9443c01a7336-2074c5d2351mr91016755ad.5.1726108892444; 
 Wed, 11 Sep 2024 19:41:32 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076afe9c61sm5635915ad.231.2024.09.11.19.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 19:41:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 18/29] target/arm: Use {, s}extract in handle_vec_simd_wshli
Date: Wed, 11 Sep 2024 19:41:03 -0700
Message-ID: <20240912024114.1097832-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240912024114.1097832-1-richard.henderson@linaro.org>
References: <20240912024114.1097832-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Combine the right shift with the extension via
the tcg extract operations.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1225aac665..740620074a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10477,8 +10477,11 @@ static void handle_vec_simd_wshli(DisasContext *s, bool is_q, bool is_u,
     read_vec_element(s, tcg_rn, rn, is_q ? 1 : 0, MO_64);
 
     for (i = 0; i < elements; i++) {
-        tcg_gen_shri_i64(tcg_rd, tcg_rn, i * esize);
-        ext_and_shift_reg(tcg_rd, tcg_rd, size | (!is_u << 2), 0);
+        if (is_u) {
+            tcg_gen_extract_i64(tcg_rd, tcg_rn, i * esize, esize);
+        } else {
+            tcg_gen_sextract_i64(tcg_rd, tcg_rn, i * esize, esize);
+        }
         tcg_gen_shli_i64(tcg_rd, tcg_rd, shift);
         write_vec_element(s, tcg_rd, rd, i, size + 1);
     }
-- 
2.43.0



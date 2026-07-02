Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37FBC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 20:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfOG5-0006m3-F5; Thu, 02 Jul 2026 16:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOFx-0006hn-Op
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:43:33 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOFs-0000Ui-G7
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:43:33 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-8471013fac2so1972074b3a.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783025005; x=1783629805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=df4N35aTj6C9IHwYzsSxXrxhNKFg2xVClcAfKEMrLIM=;
 b=o8KuQ1x66Qp4sjjQA9D1PycCAGDzJs+FyaKndD0ZKTYf7lEAMcLmXNLePOZdN5LsoB
 OKpQhNV2e1U/7k+CPvbsADjtJM/i+kS22uvGw9XT6sgBG0KVLonXkDNm6MdJZhZa6JkZ
 lExpd9ikbjJzK1LPPToEs5WYMcfynE68MfBcplQOU6WYPIyiCYGBqm++YcPtVKHWTzyC
 npu+jPzZFyOHTJCopu5fFRV7qEP/gVXHbVDANQFCtNxesa06lANCV1owFZp0oqL25i4J
 9ymfNYRrSyKMtg5NGE/zliZPqRyNchAF29grgvwJ5nm6ZVupSYeUL6U5wTYu8NhntZtc
 5Hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783025005; x=1783629805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=df4N35aTj6C9IHwYzsSxXrxhNKFg2xVClcAfKEMrLIM=;
 b=bVjhjf9Pt0HClfnQC6mTsKvTzXd+AF7ils2QKKz8bYL2isMJzT+s89k1WB+KoXmcEv
 I0qtbixSJTIcoRcWXRO4KsdxUmyvjMswXh2y8kpyAqqi9bWqsAeCNgQQiQj/XclmE4gR
 +l8VATD7ZHtgYEjMdma9c2ucfNgKOUVZpAH5KO2/ohBle9M61d2T86nSX6pNVGZdTT8O
 P+jMyPtmQxk75yUdijGvCJRTZrD/4hwt+zg2AshK6GstjH6vDw6G2ZVh6xiNfsPO1THR
 sLHIjd+hMvy4BDAiLrSk3yU+SmBV9btseEO9KLFjukUdcMUCGxv2+UJPZydLV6MUR5oM
 aDPA==
X-Gm-Message-State: AOJu0YzWyHfSlx2tDcRyZfcanE6KPufn2swlvjlHRJLFUxG+Lz8e12ag
 d+SK7KMuRIhVmeLVkcod+fS7zUwlk2MbP5j0YU5mbrcROvg+bShSAB9jyAF5XCbjLmgJyQ9oJM2
 tb/w8
X-Gm-Gg: AfdE7ckT1bxKcaQx3qOuZb+soA8YDXK5Q2F+0ftstWk4u4YUKmDqQwAnRSiqYfk38X/
 EjiD/zNIIN6RKKGaJ8mc1/tJsTxjx5n7XOgOKpWi5xX4jvhgKEOE6huBBIk6nKtN1gR92+22GMZ
 Hf7U6RSDnQHYJxnX6zwOShEKHGJu3qxPVo3o2qT6PHGEKLOMr0avumjeIy96qlLiG1czCHSrk2y
 tu37pi9Wsw/ZyN7JdW2/hiWOQDWSGcC6n01aFipejovuO9L56rT7vjQHXSkgC5H3s8JNaJ6TPoX
 2as30V1ODXCtUL/zE14b3i009WyMnJNMPu3PbQDQeS/zMaLSIKlplwJnTMR4+KN/OgcU1QUQgqE
 7ZKSnKXvJNSVU/G/Q1KaFyOdP2QnjgRuVeRorSP8jTF6MOCvDfRLY2FT8hoFeSiUDlbgrUsRIun
 KTeQJ2UQrthX5N59WrPuivZavIJBV2PpUeVQwYJLeT9M97oALMbQ==
X-Received: by 2002:a05:6a00:ad84:b0:847:95a6:eb74 with SMTP id
 d2e1a72fcca58-847c073141dmr7716123b3a.23.1783025005408; 
 Thu, 02 Jul 2026 13:43:25 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9e921cd139sm1678941a12.23.2026.07.02.13.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 13:43:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 11/15] target/arm: Implement SUMOP4[AS]
Date: Thu,  2 Jul 2026 13:43:10 -0700
Message-ID: <20260702204314.79224-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702204314.79224-1-richard.henderson@linaro.org>
References: <20260702204314.79224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme-defs.h | 5 +++++
 target/arm/tcg/sme_helper.c      | 5 +++++
 target/arm/tcg/translate-sme.c   | 5 +++++
 target/arm/tcg/sme.decode        | 3 +++
 4 files changed, 18 insertions(+)

diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index 070a1a2c1d..3da40d9f33 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -386,3 +386,8 @@ DEF_HELPER_FLAGS_4(sme_smop4a_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_smop4s_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_smop4a_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sme_smop4s_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sme_sumop4a_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_sumop4s_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_sumop4a_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme_sumop4s_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 11d9d509ec..5a9e3b8398 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2972,4 +2972,9 @@ IMOP4_4WAY(smop4s_sb, -, int32_t, int8_t, int8_t)
 IMOP4_4WAY(smop4a_dh, +, int64_t, int16_t, int16_t)
 IMOP4_4WAY(smop4s_dh, -, int64_t, int16_t, int16_t)
 
+IMOP4_4WAY(sumop4a_sb, +, int32_t, int8_t, uint8_t)
+IMOP4_4WAY(sumop4s_sb, -, int32_t, int8_t, uint8_t)
+IMOP4_4WAY(sumop4a_dh, +, int64_t, int16_t, uint16_t)
+IMOP4_4WAY(sumop4s_dh, -, int64_t, int16_t, uint16_t)
+
 #undef IMOP4_4WAY
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 6f3806f4de..fce07b2565 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2114,3 +2114,8 @@ TRANS_FEAT(SMOP4_sb, aa64_sme_mop4, do_mop4_int, a, MO_32,
            a->s ? gen_helper_sme_smop4s_sb : gen_helper_sme_smop4a_sb)
 TRANS_FEAT(SMOP4_dh, aa64_sme_mop4_i16i64, do_mop4_int, a, MO_64,
            a->s ? gen_helper_sme_smop4s_dh : gen_helper_sme_smop4a_dh)
+
+TRANS_FEAT(SUMOP4_sb, aa64_sme_mop4, do_mop4_int, a, MO_32,
+           a->s ? gen_helper_sme_sumop4s_sb : gen_helper_sme_sumop4a_sb)
+TRANS_FEAT(SUMOP4_dh, aa64_sme_mop4_i16i64, do_mop4_int, a, MO_64,
+           a->s ? gen_helper_sme_sumop4s_dh : gen_helper_sme_sumop4a_dh)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 16f86a9d2d..aef3fae8db 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1120,3 +1120,6 @@ FMOP4A_hb       1000 0000 001. ...0 0000 00.. ..00 100.         @mop4_o1_s0
 SMOP4_sh        1000 0000 000. ...0 1000 00.. ..0. 10..         @mop4_o2
 SMOP4_sb        1000 0000 000. ...0 1000 00.. ..0. 00..         @mop4_o2
 SMOP4_dh        1010 0000 110. ...0 0000 00.. ..0. 1...         @mop4_o3
+
+SUMOP4_sb       1000 0000 001. ...0 1000 00.. ..0. 00..         @mop4_o2
+SUMOP4_dh       1010 0000 111. ...0 0000 00.. ..0. 1...         @mop4_o3
-- 
2.43.0



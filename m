Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26E3CD37A7
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8Oc-0000WL-8v; Thu, 07 May 2026 19:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OW-0000RG-1u
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:40 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OU-000173-BO
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:39 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7dcd9061b1aso1234065a34.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197477; x=1778802277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jLgm9UDQEHLrvYYVImCj/f7lgJUJBmTicj8qoBhaXM0=;
 b=beoR1ndnyA61Q4hfCRsqGVAHch3rRGHkR1Bd655GYBMMxFf3jA7ihl+PQGK9v/lr/Q
 qMW4YBEejnv9CC5rGFc+WJ/5DLj0OfgO1+5t/9rsIy5QjT41BccF+AnKb4G2ul3QMVzs
 Jk8Q1jFNbekcXDB3OMpS1y0+BwCYW0b1eSGlq3avF36R3pKwLlvmDdZz0q6xt4JhctU+
 ZJNh4VQxTiQLYu9iKGXLfsR+r8eucqc9mtcXwCC9SY4gNV9SQ4M4iI/U2D/rytAyIFyl
 gatQCqOEENDw5YdQOhLtxrHeA3LP7d0L3HW2giOmwOGjyAusk7z1peo/i1IvN4ohb6R0
 JNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197477; x=1778802277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jLgm9UDQEHLrvYYVImCj/f7lgJUJBmTicj8qoBhaXM0=;
 b=nNcZlKn6eiat9pT+CbyAZip7Tcqt1GMUlpQJBpGARTcOH3bmRwliX8FKbSEXsC9bmA
 EaLtq1OwwTm0fCg1hpSd3FO69MEv4mV7lVaiE4c2CWCEUCON/hP/jdfEQkrYwMMKDMmo
 IbRqPf9hgur5ZepKXFQBTLHPNwIPbjWDzEG6RoSvdl8uBKhnXP3hPZuQwLFmtQTDXOrx
 Bf1rRiamCuvzWFhL1cyUTIbOEDzgyDyJ4ULyTSZa4TjIk6k/y6dXoj9HJku31m5esz8b
 BnE+N6uj2YisvZKmVXxQ41zxbBmICvgDjZWrYHpNbHX57qrXVS+Ot1071o707U7PT2SW
 6WUg==
X-Gm-Message-State: AOJu0YyFC/vyiqRIYBtNyYcOXnac5BNJd+omqz++aDj734Fmqd5GLEJZ
 FSkDW7jPP0/HHZcgxJBDtnlaXZXKGrPWBr+ADk+UD+hA7+LYIGMBlb4PRydfUyKf+FWZczBfuqL
 Zn6Bo
X-Gm-Gg: AeBDiet1XaM7wvEn+dp4zJy3dZt6buu3zsb+LYU8FCUFCh8SLZ0y3I0kjyjHM2d0k84
 bO2znG0fkO5L/MVpInRtwHNDz6dCPTEj290V9wj9SUWwDF1hf6JXD6Fd8LU6vCZ8H4/hVF8dy1I
 FbTgFHTxRUnIvzEvCs+jYWZia3+PMDc7tldYwqMsOjH6xM1AGiMB+CgB/h3cwFWUOf8p2RMqEo5
 STyGr+iqfz/c62+u4FolNf0CqMoqr0fLQ7Sp4Xxr0rXycAdcP0HjN53CVoK31f4L2NiPT1Pf1Lm
 4L0KrpPemAaJI3y9/ztKMv2sBlti5ZXPhrKJpJHPaGbE77N3E2u8TS5BcNdSkmIxvJjVoCkEuTO
 XZPsYHNVJgZqKMMXupbS1dPVoMoD4gaMo0d+1aL4J3vyHUmGurLXcpTHHzQMxkMzSBjEQCDr7l2
 tC+taiq0rdSvWia+DiyqGR2jo0Sh2x9PC403mrQjbIPdVYQA==
X-Received: by 2002:a05:6830:d13:b0:7d7:bf59:16df with SMTP id
 46e09a7af769-7e1df0f5e22mr6697971a34.17.1778197477095; 
 Thu, 07 May 2026 16:44:37 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm84320a34.23.2026.05.07.16.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:44:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 24/60] target/arm: Rename SME BFCVT patterns to BFCVT_hs
Date: Thu,  7 May 2026 18:43:37 -0500
Message-ID: <20260507234413.643512-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

The existing pattern is BFCVT (single-precision to BFloat16).
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
index 7ef6f5d71b..30355662d9 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1726,7 +1726,7 @@ DO_MLALL_IDX(sme2_sumlall_idx_s, uint32_t, int8_t, uint8_t, H4, H1, +)
 #undef DO_MLALL_IDX
 
 /* Convert and compress */
-void HELPER(sme2_bfcvt)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+void HELPER(sme2_bfcvt_hs)(void *vd, void *vs, float_status *fpst, uint32_t desc)
 {
     ARMVectorReg scratch;
     size_t oprsz = simd_oprsz(desc);
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index e2d17de165..88c1d78c40 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1448,8 +1448,8 @@ static bool do_zz_fpst(DisasContext *s, arg_zz_n *a, int data,
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EFBC5CFEE
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7t2-0004Lc-M7; Wed, 12 Aug 2026 08:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7sy-0004B3-La
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:46 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7sv-0008V4-O5
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:44 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-480001972b8so325299f8f.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786537000; x=1787141800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FnEhw5l35Ojo4FkzasV2AQd6Y48VBPRwnwdLMQCdWGQ=;
 b=t5Z2L0splvjjiRBnAx+uo5SEOwTWxA6US9L2VogY3ihcwtGYt+KnBG6lgGNh52/7DA
 Ubhawn21a3z+VSPXOWoIENndhVFPr3HMtAYHSs8YDsEXBhDVvmPLx+lcjdLK6yKxZnmd
 zcR1kUF7KRguMTIujjLRissgFuigEpIW+OPV2W+yyFcc+2zB4Snv2F4ORyOM5LmQ5pX2
 rrObmhzL+DYt8jb578HLSW4+peQGgvoq9U/lIpQRBxiALmo+yhR66q4ILGpWZq6GX2S8
 qOquto4Mzh81tLZrcSoNIusC7OY1yOfpisp7cFYJBS8JGnrDslKaRmZVLahyJu64SKGh
 spug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537000; x=1787141800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FnEhw5l35Ojo4FkzasV2AQd6Y48VBPRwnwdLMQCdWGQ=;
 b=NPPpNl3AUW2gKO4Jer/n1LiH0pGHZUAfqY8XVlLXx54BbDK4Wk5XwFx1x4+/BmXSE8
 OAVNJEClWo6ysoX9imluLs2v2Q2ySViG+Uix2RzDR+LYVUUNKDC942/5xXIs9sJGwHbR
 rd+bhcbH7tyre9qQmWPOUMwwGN7x5Pn0jMU4Uqe6hW4DWEzMrwCeXXiXcpq9GJwT25Fk
 EV+vKFkE2wJvKWbxdlDyW5ders+N/tKqGjFXuNqYnKZTjTfMHYHnTfsPndkMFhCYJFVv
 AFQkDdb1SNcnMcFUTQvDyfZZKkWeR7h5f62kn9T+OToQzHIBzg7q2tPEVP/RZJWLOf/I
 YUbQ==
X-Gm-Message-State: AOJu0YzC6GVDV0if2XijZPHZTpF2P1SFFKPMm00V6RfBMYpvXCOxJEBo
 KdJsdY5Wax89pTggKj/aWufwPidCwaPLRCkwwzZHIQyINc0aTmZThNC9H2/cbQ/Lc8sjQtdleWd
 ZBfDU
X-Gm-Gg: AR+sD12H0fFhur/0DCd+VwNmixMMCeu7aSidoDWVKdQ3MlmRxkeFEAU1OQpf/pQsFRU
 TcbZv4YxoJQxo42oF9xWTVSfQm08a6mIb7IkD7tOWf48SdVT73+fc/m07N39Gq3lhY5eX7FD1sT
 a/xCf/ZZgN3XkeHxnUlXlPI2IlyQuC5isTvxZEphNVuB31nzHoKWCtxtMi4XuWV8CwLrdzIKGDr
 z5HPRhCKtv3Z96nBZ811oufmW+iKH/NkB5K3vpjou4W3XWJgTdgXwLHxIpVfVJa0SLfJL8hlJx3
 Rk9C2vbALPHB0S1UfGcmwCI3N5vYPxBO04NcVWKMYuRzx10VQrpLqQvTw7IONyeSkRIhp/Xp5ol
 rcJpxyrhytwN0cyZeHOYB/Xv6vVbld2z6gd1Auf6Xefb/2vWA8VpzLVsi06G1hLgmowHi+U1fx6
 HP61f3hDyKK6d+erqOiJJYU6/3106+Nym2H1723TJ8w7W4sK+klZgtYCmBXCtzjpu+4JO/rkJdd
 IhdjR3wHd426rwa5jm0tgO9fWGiltTE+OeMA7KBjcX6Qw4iZtusVHLJ0qXTvAoik05ubQ==
X-Received: by 2002:a05:600c:3ba6:b0:493:e451:a9e1 with SMTP id
 5b1f17b1804b1-4997c0e3812mr57261625e9.2.1786537000109; 
 Wed, 12 Aug 2026 05:16:40 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm36963805e9.3.2026.08.12.05.16.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:16:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/26] target/arm: Implement {S,SU,US,U}TMOPA (4-way)
Date: Wed, 12 Aug 2026 13:16:05 +0100
Message-ID: <20260812121622.649730-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812121622.649730-1-peter.maydell@linaro.org>
References: <20260812121622.649730-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260713230244.70174-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme-defs.h |  5 +++++
 target/arm/tcg/sme.decode        |  5 +++++
 target/arm/tcg/sme_helper.c      | 14 ++++++++++++++
 target/arm/tcg/translate-sme.c   |  9 +++++++++
 4 files changed, 33 insertions(+)

diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index 1de72b7472..b8cb643367 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -414,3 +414,8 @@ DEF_HELPER_FLAGS_6(sme_ftmopa_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env
 
 DEF_HELPER_FLAGS_5(sme_stmopa_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sme_utmopa_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sme_stmopa_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme_sutmopa_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme_utmopa_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sme_ustmopa_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 08036c60c0..e8176fffdb 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1154,3 +1154,8 @@ FTMOPA_sb       1000 0000 011 ..... 000 ... .... .. 00 ..       @tmop_o2
 
 STMOPA_sh       1000 0000 010 ..... 100 ... .... .. 10 ..       @tmop_o2
 UTMOPA_sh       1000 0001 010 ..... 100 ... .... .. 10 ..       @tmop_o2
+
+STMOPA_sb       1000 0000 010 ..... 100 ... .... .. 00 ..       @tmop_o2
+SUTMOPA_sb      1000 0000 011 ..... 100 ... .... .. 00 ..       @tmop_o2
+USTMOPA_sb      1000 0001 010 ..... 100 ... .... .. 00 ..       @tmop_o2
+UTMOPA_sb       1000 0001 011 ..... 100 ... .... .. 00 ..       @tmop_o2
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 951cbbf58e..9de95428d2 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -3168,3 +3168,17 @@ IMOP4_4WAY(usmop4a_dh, +, int64_t, uint16_t, int16_t)
 IMOP4_4WAY(usmop4s_dh, -, int64_t, uint16_t, int16_t)
 
 #undef IMOP4_4WAY
+
+#define ITMOP_4WAY(TNAME, MNAME)                                        \
+void HELPER(sme_##TNAME)(void *vza, void *vzn, void *vzm,               \
+                         void *vzk, uint32_t desc)                      \
+{                                                                       \
+    sme_tmop_4way_sb(vza, vzn, vzm, vzk, NULL, desc, inner_##MNAME);    \
+}
+
+ITMOP_4WAY(stmopa_sb, smop4a_sb)
+ITMOP_4WAY(utmopa_sb, umop4a_sb)
+ITMOP_4WAY(sutmopa_sb, sumop4a_sb)
+ITMOP_4WAY(ustmopa_sb, usmop4a_sb)
+
+#undef ITMOP_4WAY
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index abdf98a40c..768b76f01e 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2202,3 +2202,12 @@ TRANS_FEAT(STMOPA_sh, aa64_sme_tmop, do_tmop_int,
            a, MO_32, gen_helper_sme_stmopa_sh)
 TRANS_FEAT(UTMOPA_sh, aa64_sme_tmop, do_tmop_int,
            a, MO_32, gen_helper_sme_utmopa_sh)
+
+TRANS_FEAT(STMOPA_sb, aa64_sme_tmop, do_tmop_int,
+           a, MO_32, gen_helper_sme_stmopa_sb)
+TRANS_FEAT(SUTMOPA_sb, aa64_sme_tmop, do_tmop_int,
+           a, MO_32, gen_helper_sme_sutmopa_sb)
+TRANS_FEAT(USTMOPA_sb, aa64_sme_tmop, do_tmop_int,
+           a, MO_32, gen_helper_sme_ustmopa_sb)
+TRANS_FEAT(UTMOPA_sb, aa64_sme_tmop, do_tmop_int,
+           a, MO_32, gen_helper_sme_utmopa_sb)
-- 
2.43.0



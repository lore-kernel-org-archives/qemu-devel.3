Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89ED3C71157
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7z7-00057d-6k; Sat, 21 Jun 2025 19:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z4-00056M-H8
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:54 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z3-0004Tu-3m
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:54 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-748f5a4a423so1829312b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549852; x=1751154652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tyvKoN2K28yYY2BAVom/mjyQ4IAay4Sv47eAXtGmzGo=;
 b=bIlIUZGqds6j0XPjh7/Nr0wVTb7HcmrqxMDWaFAcncsbj7hLexH5TIcJCD5ROr0YMP
 YcNRxUf5jBi8pMqtp23hRB87DhA/hZSZdME4g0r/96Ow5i4KedUCnR25XLkrxlN+hs9Z
 PBInO8KgUlusoNjasHbAI/85NsAPiHGq42vKZv0pMq01wMz53BAgJJ+B4f/T1EiiHKRk
 JrJay1NjIVVevf2nHEcynitu4vsJDmaIzFAyUpwE+QAIgW3VhgE0J0v5ilIOwJ6tuZbV
 5Eaft5r9mKGzsxDurCK8k3Gky8PSe0glq5RCigUJcnOIDWBSnk/nXwMNvormmlziT/Hz
 q9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549852; x=1751154652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tyvKoN2K28yYY2BAVom/mjyQ4IAay4Sv47eAXtGmzGo=;
 b=q2hIWe5Dgsg6aYXWorkwrNwQvvi3uxyGnhpPLlfTUQZjE4fBTF67xKnqvDpvyGJpU4
 N+ll+MANHvb94HwOw6/jRJtIE74HoOhR/Q6BXe557yyd+OMSqsNjoUXZoqwfr6dvP4/T
 ZeN0rjvff0plALvY+ob/WogU24WPCdwxq6UYJlameMu9yP99eTasOyNe2Goh9Zy1TJWs
 ZjLEXOxRFJjpoSaEZ+lVgmd2S5XdUNKZIS8GdLr3LFmID+rNPVsIcwCPT4xpWELWhVpW
 1UPN/V1Wp8dyiIvbym7Z+0qYL6W5tUgfG25Vau29UmL/Gqd84OUD25U6XpCju8+XK16r
 ZVkA==
X-Gm-Message-State: AOJu0Yx5BE/YxjWgMH4Dobu3EOxCatCWGd2Ar8d53O7poHknIIOH1QLC
 xiqmjFbDuTm9QcZkmi06WwCvkIVKGdsZWjmZ7xK+L1bM7ABBwMXhoYh7yr1pxVrLOGrztEvqM6s
 pAyrv
X-Gm-Gg: ASbGnctuALTnPz04Xa5QC6D1IzKusGm/gocyq5OO/e6YpYe6Ij9hJUoZA7pxKzLuPip
 EFCJ6JRCM+L/ik5iaw/Pg86Y8grTAzQ8f3Q0TbtnKzCW5Wl3+TF51EyufqJIiLSEqtBzeCJRtko
 MosTgmBIQUdrzLFR/VgJyG/GnYGH1xnkg6UIN9szgFFdrNOPbOcg9eC6a2TGgP6YHmA4R0u+jUd
 nkXhbzaDtn+oRcBqqhfqr6YiWm9NVWGqcfPxiFmiqYzx2GFGsI6PtzCznelrVN+VUxGw4TCRmVs
 ROlqkdMhXVUxvkC7+pf1LJ5PY1mFBXAm72TmtFqpf0wlggKBQ8VMZnmvVu/H4waGM52Jq/caZ8y
 pl250vFqtuwekATBgXnEU
X-Google-Smtp-Source: AGHT+IHslgwlOjOvEN25CPun4sme0K4Ich6+4qVvpnIZWQfDiyYHUlfpw0ndFDBjKQCXg+tMd76MeA==
X-Received: by 2002:a05:6a00:2d06:b0:748:68dd:eb8c with SMTP id
 d2e1a72fcca58-7490d7a9aa3mr11034754b3a.23.1750549851794; 
 Sat, 21 Jun 2025 16:50:51 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:50:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 020/101] target/arm: Implement SME2 MOVT
Date: Sat, 21 Jun 2025 16:49:16 -0700
Message-ID: <20250621235037.74091-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 13 +++++++++++++
 target/arm/tcg/sme.decode      |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 8b0a33e2ae..13314c5cd7 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -210,6 +210,19 @@ static bool trans_MOVA(DisasContext *s, arg_MOVA *a)
     return true;
 }
 
+static bool do_movt(DisasContext *s, arg_MOVT_rzt *a,
+                    void (*func)(TCGv_i64, TCGv_ptr, tcg_target_long))
+{
+    if (sme2_zt0_enabled_check(s)) {
+        func(cpu_reg(s, a->rt), tcg_env,
+             offsetof(CPUARMState, za_state.zt0) + a->off * 8);
+    }
+    return true;
+}
+
+TRANS_FEAT(MOVT_rzt, aa64_sme2, do_movt, a, tcg_gen_ld_i64)
+TRANS_FEAT(MOVT_ztr, aa64_sme2, do_movt, a, tcg_gen_st_i64)
+
 static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
 {
     typedef void GenLdSt1(TCGv_env, TCGv_ptr, TCGv_ptr, TCGv, TCGv_i32);
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index cef49c3b29..83ca6a9104 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -39,6 +39,11 @@ MOVA            11000000 esz:2 00001 0 v:1 .. pg:3 0 za_imm:4 zr:5  \
 MOVA            11000000 11    00001 1 v:1 .. pg:3 0 za_imm:4 zr:5  \
                 &mova to_vec=1 rs=%mova_rs esz=4
 
+### SME Move into/from ZT0
+
+MOVT_rzt        1100 0000 0100 1100 0 off:3 00 11111 rt:5
+MOVT_ztr        1100 0000 0100 1110 0 off:3 00 11111 rt:5
+
 ### SME Memory
 
 &ldst           esz rs pg rn rm za_imm v:bool st:bool
-- 
2.43.0



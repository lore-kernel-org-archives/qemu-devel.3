Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC318C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAg3-00074K-Pc; Mon, 29 Jun 2026 08:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfa-0006tN-Qr
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:03 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfW-0007Ni-L8
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:00:58 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c0efc7ef797so547697566b.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734452; x=1783339252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=48xUmuMDbgW6dNJdf72dVSFWkDrrrMof6xbqGO1yWZA=;
 b=fc1qdO/rRhne6jyKcytZIBZji0yPJaWbv7VjjZ++BGQSmXSG/rb3TTw3EXhS4M/l8b
 TuGLXmIKVTfWcpffVPwf3SfZn7oC6utvS1qjWOdIxUpmM8dEy3BE4QC3DkxnQAa2Typ4
 FuVqg2L3ujyyVDSz8UW2kRjUFYfKnaidi75PpeetSZcpKKX+eGxea0ob4gvV17RMwTc6
 FwhJ/5MkymWOzoYe7jrEaMwh0Ns+exaB3LMkIi/RX05Brbd0k1LcZXK6w5ZdjeKMZOaS
 52/bAMRChb797x43IOUj2/Jhl8Wf/7e/qi3X5Kch6jiQXewzcLHicyRlVatDAeurPnkC
 UnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734452; x=1783339252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=48xUmuMDbgW6dNJdf72dVSFWkDrrrMof6xbqGO1yWZA=;
 b=g6s1iapHOJ39/Rt1bF9/bZmzouTeolXjMDso+xN+OLRbUkwlMXjTKp2re+XKuiyQEO
 TxdylUubFgwxTgK1nqVrgc3lTW+j3whC84EVaXbHeglXQN5Q7mnXZS4GBLzHGHc3Q5nN
 3MBSkpTskSo+zGMyFjtXtQblF5UcOdzzEfRVwZsB15V0BySDCYHTYzLbClHrrfHr2qW5
 Wfdh0FoCiHdFFPzlK1q0ewDmyiOJdDQXIb+5PX6AHGK17J+WMvtV++5/WMKcmzcj3iS7
 FOrFHMKKP5VNG0w40GaovHe5oG0l1pW0yUtKcJHz905RrzKvvtW4jnZkMU5Zu//ySuNJ
 Vxow==
X-Gm-Message-State: AOJu0Yy9q1+dPvD5qSkIZv3XxgIOtG8JFWd1TD2iWWHOaoSNmnVRQaBF
 hT8+rS8R+BOdqVTuOrd9nigq69H6d+BQyJAcVqrBDb4a4630Fke3pCQ4ok0QLRSmlEuMrU0gM1g
 rAHQd
X-Gm-Gg: AfdE7ck7ywY34seR81lpzX5/Dc6XSY1Eh+QVgAm60G4xixCYCYjBGN3ujzqBiuLsOCY
 HzNr9D/R73aVTS4JVtYrdBslCWnb3XoTqHuYdelrPJsKRnz+TCtCGEd9joX2S/hDk3SiW9X1Z4m
 Hh1TL9xYbwih/n+sjeeeKrBQj8nPOHik7+DzKqt3GYk6USchYiZxReoNclLJtKhElKGzCSlhKCr
 0ukA9k2XJyqJhUVmy0tihBJ0p1UUd3KQI4zSQ4IxThynJTqRIyW+6yLih6UZCTEpJyRzxRseHFE
 nJkqMNTLfAiy7OT61BdCAtvophBBy5g4f0ICpnp8E4+E04GlkJmJEXU7ButbwtajJttil0g4enb
 U0vVjjYVnJ+F2D5QesXnPh8hdxwDrmyDQ8BB6Pcix0B4EKVsc7vyEPLQYOCV2XexMFBP3i3HnFH
 pKOB8fc+b4ZE/MmIixx9DTQ1zuAtuSTqlQ5fn5OaPdNIhXV7tdnYEjGkmYTYoCtse0WnrDmX7tX
 bAK6TzvXa/VJHLeWCqH+w==
X-Received: by 2002:a17:906:f58a:b0:c12:34ec:ad25 with SMTP id
 a640c23a62f3a-c1234ecbf2bmr438866166b.65.1782734451267; 
 Mon, 29 Jun 2026 05:00:51 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.00.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:00:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/54] target/arm: Implement FDOT (multiple vector)
Date: Mon, 29 Jun 2026 12:59:54 +0100
Message-ID: <20260629120032.1645265-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
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
Message-id: 20260618041517.573469-8-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme.decode      | 3 +++
 target/arm/tcg/translate-sme.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 3c7caf8bdb..04dd0e6df0 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -575,6 +575,9 @@ FMLS_nn_d       11000001 111 ...01 0 .. 110 ...00 01 ...    @azz_4x4_o3
 FMLALL_nn_b     11000001 101 ....0 0 .. 000 ....1 0000 .    @azz_2x2_o1x4
 FMLALL_nn_b     11000001 101 ...01 0 .. 000 ...01 0000 .    @azz_4x4_o1x4
 
+FDOT_nn_sb      11000001 101 ....0 0 .. 100 ....1 10 ...    @azz_2x2_o3
+FDOT_nn_sb      11000001 101 ...01 0 .. 100 ...01 10 ...    @azz_4x4_o3
+
 &az_n           n off rv zm
 @az_2x2_o3      ........ ... ..... . .. ... ..... .. off:3  \
                 &az_n n=2 rv=%mova_rv zm=%zn_ax2
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 8fea451089..467b44e832 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1177,6 +1177,7 @@ static bool do_fdot_fp8(DisasContext *s, arg_azz_n *a, bool multi)
 }
 
 TRANS_FEAT(FDOT_n1_sb, aa64_sme_f8f32, do_fdot_fp8, a, false)
+TRANS_FEAT(FDOT_nn_sb, aa64_sme_f8f32, do_fdot_fp8, a, true)
 
 static bool do_fdot_nx(DisasContext *s, arg_azx_n *a)
 {
-- 
2.43.0



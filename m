Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7704F3C99B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 15:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuuZz-00084F-LW; Tue, 24 Feb 2026 10:44:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vuuZp-0007rm-40
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:43:58 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vuuZl-0006Ip-29
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:43:56 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b886fc047d5so906702066b.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 07:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771947831; x=1772552631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JgHcP//ADNE+xVgcxDYmX1XpBdXs4RC0Pe5Zc7Pw41U=;
 b=J9MQwxX9Bm3vKi6URbchJ0Q4iLEiHvzW6fImfQawvtksGZVi1+99WX04Pi5CCCzihw
 PpIFAT60XU96qcPXxRql+/x0MK6ZXNaOk5jQw/tDe37P0uQTGUd1eNKBc2kldgGp33zZ
 8FXo7rHdwenUsvIa7QdYB4VXgurF4mHWWdB2dE8AkL9XBFoJVVXNz8pfTB/N5lPU9KrX
 T1d5+vZp6cFcBhKpNnkxRFybp8HlYn4/1CjzZmygM3oulmHDPetOBq/82fizU+v0hxcK
 /BSGvePr+bBLUi6KOVD8iY1is8pH3NKM4YsHycnmF39e08B1Ls8aH0W0tTJ857yJ0sW1
 utaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771947831; x=1772552631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JgHcP//ADNE+xVgcxDYmX1XpBdXs4RC0Pe5Zc7Pw41U=;
 b=iRwm9ST6US4p04FhMa63wEIxTkq+LLcQJaQakeap18qz8Zplm/smerwIkfXl6S6yzQ
 G6ycDgcKh8JpCQENfUoNJEbSUSeNzd0z0uGIrKhpUYhLYBzyjaztMx3mQxwlgGWmm6hy
 Lfq2qq/wsr21+sho7Az6No26pWPrFph5AbyokQODm/2vbwH/1truogj3F2C4tbedlUgY
 094i3GdtevTQlBO79gtR/ZOTrnEaZ0XML/crBA4r0JCv7UpxANq+8qricpnatvvhxG0L
 Hmbi2ilkfqomSxRoiHsb6mmBS/NFY50fUfAs1btiDQzhrIGzst3hEG1K/GrOAXW9hvMS
 cEDQ==
X-Gm-Message-State: AOJu0Yy5CQ/NoNVxWR5TvWm9I6iTZpBoTaQyoi8ZhN7TMqAG9pG2bK1K
 efFzB+PQb7D9kejLWCgo/h2YsRLsNXZxc6cVwyQLbgZn4NXIKQHXX9FszbDAoEo8tNY=
X-Gm-Gg: AZuq6aJBk8xlo1b3YtAXNcnkkxdciRz1vy7A7PWf9C5r8o+j/sYvcRu2kmxrgwUdMUK
 fZw6j7x8gNs3uv8yq8icQgv9ifCKfdVPWC5XcbNduRM4yiHiCaC+n79MaHVetbBI2kz4SFeSv8e
 dRnTirGG4MQJZUEGvptoGtjDgzYWw/hWWWP92jU010x6/esbkUWtpJvqUNFbs6ySO3xxxvLUwIu
 5Js6bLsPtdethgO3Nng2NJWP/gdEE0exPfwQ04IMz6dlua2YEyTK3h1MT++gokWLT487ld+J3jZ
 w6Jo+eMFJ0temKo/MQDVwfotdT/nW7dQrn9bHhKyZY/sSVmFXRPtRU3lLJivmJQ1BneB8oJYmKG
 LS484OXKDlZfvSTzeB3sphUmzgargq0JHiszIF5BQrU7iNAhAJniOQv8ddyQFTGiHN1+8p4ZJW2
 zatpBYn+7q9/isythuOpBEImtNbut4gtVE3A==
X-Received: by 2002:a17:907:3d4f:b0:b8f:aa38:70bc with SMTP id
 a640c23a62f3a-b9081b3e5d4mr853668666b.38.1771947831400; 
 Tue, 24 Feb 2026 07:43:51 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9084c5c514sm434204066b.5.2026.02.24.07.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 07:43:49 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9121F5F8D0;
 Tue, 24 Feb 2026 15:43:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 4/4] target/arm: report register in WFIT syndromes
Date: Tue, 24 Feb 2026 15:43:46 +0000
Message-ID: <20260224154347.344219-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224154347.344219-1-alex.bennee@linaro.org>
References: <20260224154347.344219-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

Now we have the register number we can report it in the syndrome.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h      | 4 +++-
 target/arm/tcg/op_helper.c | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 86a2d5ea9d0..086ac76d7f1 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -359,12 +359,14 @@ FIELD(WFX_ISS, RN, 15, 5)
 FIELD(WFX_ISS, COND, 20, 4)
 FIELD(WFX_ISS, CV, 24, 1)
 
-static inline uint32_t syn_wfx(int cv, int cond, int ti, bool is_16bit)
+static inline uint32_t syn_wfx(int cv, int cond, int rn, int rv, int ti, bool is_16bit)
 {
     uint32_t res = (EC_WFX_TRAP << ARM_EL_EC_SHIFT);
 
     res = FIELD_DP32(res, WFX_ISS, CV, cv);
     res = FIELD_DP32(res, WFX_ISS, COND, cond);
+    res = FIELD_DP32(res, WFX_ISS, RN, rn);
+    res = FIELD_DP32(res, WFX_ISS, RV, rv);
     res = FIELD_DP32(res, WFX_ISS, TI, ti);
 
     if (!is_16bit) {
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 28a1c7243ad..a68cdf6de23 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -399,7 +399,7 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
             env->regs[15] -= insn_len;
         }
 
-        raise_exception(env, excp, syn_wfx(1, 0xe, 0, insn_len == 2),
+        raise_exception(env, excp, syn_wfx(1, 0xe, 0, 0, 0, insn_len == 2),
                         target_el);
     }
 
@@ -450,7 +450,7 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
 
     if (target_el) {
         env->pc -= 4;
-        raise_exception(env, excp, syn_wfx(1, 0xe, 2, false), target_el);
+        raise_exception(env, excp, syn_wfx(1, 0xe, rd, 1, 2, false), target_el);
     }
 
     if (uadd64_overflow(timeout, offset, &nexttick)) {
-- 
2.47.3



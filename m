Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEF4C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 23:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVgZe-0000lT-PL; Thu, 01 Feb 2024 18:34:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVgZc-0000kl-9L
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 18:34:24 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVgZZ-0004my-ND
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 18:34:24 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d70b0e521eso11059225ad.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 15:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706830459; x=1707435259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7kLWJMVV93f33/Zrptg7E4xAvMmXcgI7Lc6LIsCFv2c=;
 b=kVg3JMBm8s7regQCm3D+ZA+1CiQkbLXebgttlujddqMh5yB+m1W4KCnLahBdbjd10y
 RA+qOFQS2diIFYvZ8IUKscULZK9pN88kSCdlJAwcvyFQCEsTLKV4vE6/16ZqHVaQRrGS
 gEhQ6w/Am6DqaLS5FW91waK4skKfa/zxLrskcbcqIe9fgGM1+qAu1zMle2fzAbhVe+JB
 twWMaMJTw+xgOX/SW3L40y7cqEvV7X5GS6RJ1CtXf7DchssyEWTor9ewXRPc8I5MDcFk
 G6NTqU0kfXzyLrXak5QEObG4oRz4VDQADuFQkyuIsLdOK4u+PXBMwoTp1m1CB+ve/4nl
 akUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706830459; x=1707435259;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7kLWJMVV93f33/Zrptg7E4xAvMmXcgI7Lc6LIsCFv2c=;
 b=rMCqcJ9Xg50QUEBk43HmVTz6KZft+EOce6NiBfIfK2SPMcYCmEkyA5gZbJ4XIID4XL
 eqDq9USBJ4H/6jZ5PmhVCAULwvBdvcz8Lk03fxDR0O+SqnPci/dFuOJvi2MAREMOfBE5
 vrTjeoTE5122GxOP3ShoPAev+PVX9lNNXS9JansXOuUIOtAaja/vyfPp6X5PVExVZWQm
 TKOXxkyWq+/bFOFklV/VfLjxiNEVKai6X7jNXr8Bj4ji2zfaPdlK1x/nT6nTK+J6cuLa
 b6OZ/aNrDkRIUkMMQ3Fv/fBgV/R8cbPshYjhueBBiVHJ+RD+aK6LGd8HLxVFZj5jMuQY
 upig==
X-Gm-Message-State: AOJu0YxAlQwJTm5Oa7iIQ076Ayuk2eOgpiFCL3uRsdfz+NE6yAK10uKi
 M6wBL9cGurwPj8ghRXD+Z0c/S9idrMmdLUc6y8a4NodzYfMRR9SQ0vf9NNdivl5KzksWwzxkjGy
 GUDQ=
X-Google-Smtp-Source: AGHT+IHflniLOOtNTOVQKu9uDCajcsw5BAEXqnyRJtA4G1mxYS7Ovu2eu2UdcjhDzZ3Zh1ZYtaTkLA==
X-Received: by 2002:a17:902:7409:b0:1d7:41b7:332b with SMTP id
 g9-20020a170902740900b001d741b7332bmr602092pll.14.1706830459318; 
 Thu, 01 Feb 2024 15:34:19 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCX7xE0wnMtUiZfbJqED1djwDMcnDe+m11+EYx/psnpZHe/anhFgpBlif80SS/V/9NkW3KPeS2T7Eeig809/4vvUQHWFQHCA
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h14-20020a170902ac8e00b001d8fb137a57sm373560plr.12.2024.02.01.15.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 15:34:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: gaosong@loongson.cn,
	qemu-stable@nongnu.org
Subject: [PATCH] tcg/loongarch64: Set vector registers call clobbered
Date: Fri,  2 Feb 2024 09:34:14 +1000
Message-Id: <20240201233414.500588-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Because there are more call clobbered registers than
call saved registers, we begin with all registers as
call clobbered and then reset those that are saved.

This was missed when we introduced the LSX support.

Cc: qemu-stable@nongnu.org
Fixes: 16288ded944 ("tcg/loongarch64: Lower basic tcg vec ops to LSX")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2136
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index bab0a173a3..dcf0205458 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2327,7 +2327,7 @@ static void tcg_target_init(TCGContext *s)
     tcg_target_available_regs[TCG_TYPE_I32] = ALL_GENERAL_REGS;
     tcg_target_available_regs[TCG_TYPE_I64] = ALL_GENERAL_REGS;
 
-    tcg_target_call_clobber_regs = ALL_GENERAL_REGS;
+    tcg_target_call_clobber_regs = ALL_GENERAL_REGS | ALL_VECTOR_REGS;
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S0);
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S1);
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S2);
-- 
2.34.1



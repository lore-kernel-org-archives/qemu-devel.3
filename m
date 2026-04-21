Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A462EA71A4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3Rz-0008Iz-3l; Tue, 21 Apr 2026 01:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3R1-0007wD-4C
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:10 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3Qz-0006LL-FA
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:06 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2aae146b604so25350135ad.3
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776748444; x=1777353244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pfoV/MjdItCjEdTVv/LcepvEQT5a1+iPXWWZ97UB4oE=;
 b=yhP4hT/0AVwhIvRTl/mqQzbDat4sAu+d+CKiEGUSwXXXb+dNW3kmZvNAdskf3nz9ax
 Vv7CehCiGy1eyOUNogt/tgBni0TJx+xtF2K3ghqa8bYQMXyeuqLee/eAvu4Td6nnAC92
 a5e1Sw+gSwHVovUZ7AezaAUWcgsZr9Amu0YTQyxGWIg3Y0JajgZpx/wN5Pf/BOnm4id5
 fwhZfK2Q1llOK29QogQP+NHWjDJPVcKrAO6x9lZoqxPkyd5jk6gkxNUoLtzDPeizexxT
 uWpabXS7jiedH/5FJXaIggdKgUnR/CncmdZtyJUxKLoq2MWSDYHpfL9g9ohKzHNZIaXd
 +5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748444; x=1777353244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pfoV/MjdItCjEdTVv/LcepvEQT5a1+iPXWWZ97UB4oE=;
 b=VP9Z4LqQXBbmZYeYbTVDlsz6o6ixLvfZOGFYNotV5XyvIse/6hbZt2b9fjDPo83Pu6
 4nl56BwcWc+Lvwa9590Uf0zDEpW40jBb40oYEZ2p5ZffhTpULC4ipUwtKPhOq9KRaqpY
 h7jCki5gf62rE4GfevPoD7zw907E7Pt49HobvKW5aUeWPyjWbzUuaw4CpATBxfZPBX3A
 Xa0QfvzTBB5oW5tl3L89DqBqxNKHytWteUbr8GjEJtx9Nrk3bTsmBZVzErP1mzlipV/p
 FJ7F/u5p+JSI4W7BiVa082OhqeF0VS92BEQ6ctUCjNbc1GxT96kawRnmbi7LJPNiJoAr
 bB2A==
X-Gm-Message-State: AOJu0Yz4JGrmxi5QOL2aAb2Nk92hLinYMyari5F0oIq25d65m5JgUihb
 /7RyJ/VoZpq1U824O/ddLZauISp59uxQJkP4fGwHLLAsvCWy3D/rNwDBJjDMX2WKOQ6+9T8PBBS
 QDbs8MuU=
X-Gm-Gg: AeBDieuVkl1Gp0S6y5QYS6wlidwa/vApi8gi9vNLdScyeSuFqPq4L7ouy/tte2ocx4l
 lGPyGDVu7mbH/+kj4latZYW0IYLiVUsETnnDQ8XjJhpun0NLcUxQ+vTYLjqbOneuSBPqfmGFRBx
 9FX9e/FIWJLWES2sHsbsxu8mmf5Ro1dUzF7YXqVVelG2X0I2CwPHWVQpU8jI7vaUmapEh+69znp
 jifjfLSHsejlGuZ83Nvon3Voczd4+nvBVvP9aouhqv4NxXnbyEyMAvSvJxXh7FOfWF0tlBFTDGV
 yAdFunYgqbQWBH73KnD2IimQlPi0NjbQN4J/dF2JY581etAgKzfCI1gI0YLRQwQjKqoAavZKik5
 YYZ66MLM06rTx1COjJS0nQX/+CaieXW+uzt9ZyjcOJF1LmnDCk2g7tdCJDQUGiph6a6uGCJBrEJ
 RJSxeT9upt3pAVRmbzIr9aqFQZc/nWeLM7M5Os5FnE6OJMk8Wvh/0=
X-Received: by 2002:a17:903:1b45:b0:2b2:4d36:7aa with SMTP id
 d9443c01a7336-2b5f9fb36ccmr180524275ad.35.1776748443990; 
 Mon, 20 Apr 2026 22:14:03 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cddfsm174631715ad.49.2026.04.20.22.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:14:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 05/37] target/arm: Enable FEAT_FAMINMAX for -cpu max
Date: Tue, 21 Apr 2026 15:13:14 +1000
Message-ID: <20260421051346.41106-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421051346.41106-1-richard.henderson@linaro.org>
References: <20260421051346.41106-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 4 ++++
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 5 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 84857fb706..343536523a 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1256,6 +1256,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR2, ATS1A, 1);    /* FEAT_ATS1A */
     SET_IDREG(isar, ID_AA64ISAR2, t);
 
+    t = GET_IDREG(isar, ID_AA64ISAR3);
+    t = FIELD_DP64(t, ID_AA64ISAR3, FAMINMAX, 1); /* FEAT_FAMINMAX */
+    SET_IDREG(isar, ID_AA64ISAR3, t);
+
     t = GET_IDREG(isar, ID_AA64PFR0);
     t = FIELD_DP64(t, ID_AA64PFR0, FP, 1);        /* FEAT_FP16 */
     t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 1);   /* FEAT_FP16 */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 7787691853..579df4c47b 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -66,6 +66,7 @@ the following architecture extensions:
 - FEAT_EVT (Enhanced Virtualization Traps)
 - FEAT_F32MM (Single-precision Matrix Multiplication)
 - FEAT_F64MM (Double-precision Matrix Multiplication)
+- FEAT_FAMINMAX (Floating-point maximum and minimum absolute value instructions)
 - FEAT_FCMA (Floating-point complex number instructions)
 - FEAT_FGT (Fine-Grained Traps)
 - FEAT_FHM (Floating-point half-precision multiplication instructions)
-- 
2.43.0



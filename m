Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786B0C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 15:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdtKq-0005la-1S; Tue, 13 Aug 2024 11:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdtKc-0004sP-1w
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:21:07 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdtKW-0004ds-HC
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:21:03 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-428178fc07eso39044535e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 08:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723562457; x=1724167257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=k92uxQUphhX97lbQN89xDPP6Ys3FVrzqxypU/0YUiUo=;
 b=AQcdB/8zQmYQ9Pbvbq1mQyf1PJJ3zu3UCCihiMXFkCE0ZVfdcD+drJqAlQSnEq74Rn
 KXi4YFlMAr8dekzRPjyt+HOXUsV462ITgioSASQZXyxjYfjuQKTguu4mdIyM/fj3DUQ3
 DG3N7cJWM27veCxIqL9U4lC9zameU2tbZyBL6WLMhuVnkEeXoQ/7kHukx4VSbf7NMvpA
 wEOl36iBN2b7EtbKyX6Va45sChDB7YRzCd/t4uugxzpU5SgyMDvYuYFuMLPaNJIQj911
 q+Rza/cexpeuQRbO7lFkclfUFAY55KQUyW3xTKgPxMbkZ1KrVTsZqumbKoJFbmGsrFjX
 GrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723562457; x=1724167257;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k92uxQUphhX97lbQN89xDPP6Ys3FVrzqxypU/0YUiUo=;
 b=rjej5XXoineohJAzhZogsdq2DEi2bz04pgnWvrMyh1sl67+8JRYO2ANb/nJXJK96bC
 gcLzu+eCDLgOx3GCZGkW8UmaCTSHfxSJYlLrBOprv+1Z5AtrPAVpVUm9BTZoXn9d8CCI
 YPqLJiO8sjNzca1+iEdYXuBKqcufv96gtgOt09T7Csd50K8OCP15lbTVc7HwkjjZhxPR
 bzvRb9vid6mhi9cjMZ8h4XigpJBF7VSfQ4t2zVxL6wFV38fko5pUQKyX+dF4hV8yOJtT
 XUbbOaZaaDs3WtLCbAwCEk+/8sfD1yCni4mzn4izmSupVMdjC8c4k7gBl3OWFWczEiVx
 gLlA==
X-Gm-Message-State: AOJu0YymWpLQkiAfaV/VZWUOayPhzZ3o372OwIcwrooIq5veBZtII+xc
 LwHhHc+t0X03MxYKhp6TKs/edtX81TanRf3mQe1QG0FPWYzivmciV99EKmuYJXRDYTNTZaUkbtg
 v
X-Google-Smtp-Source: AGHT+IGYMGr++M8/yd4xkJLPfhb4lNFNTrtrTsvIT/ioPboT8+Ihw74ZbyAeGAl9FA9xXh8J4bIhFQ==
X-Received: by 2002:a5d:5f4a:0:b0:368:8007:e26c with SMTP id
 ffacd0b85a97d-3716ccfb977mr3139603f8f.29.1723562456851; 
 Tue, 13 Aug 2024 08:20:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4cfee676sm10654792f8f.49.2024.08.13.08.20.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 08:20:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] target-arm queue
Date: Tue, 13 Aug 2024 16:20:50 +0100
Message-Id: <20240813152054.2445099-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Three last bugfixes to sneak into rc2 if we can. The fix
for the EL3-is-AArch32-and-we-run-code-at-EL0 bug is the
most important one here I think (though also the most risky).

thanks
-- PMM

The following changes since commit 9eb51530c12ae645b91e308d16196c68563ea883:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2024-08-13 07:59:32 +1000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240813

for you to fetch changes up to 4c2c0474693229c1f533239bb983495c5427784d:

  target/arm: Fix usage of MMU indexes when EL3 is AArch32 (2024-08-13 11:44:53 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/misc/stm32l4x5_rcc: Add validation for MCOPRE and MCOSEL values
 * target/arm: Clear high SVE elements in handle_vec_simd_wshli
 * target/arm: Fix usage of MMU indexes when EL3 is AArch32

----------------------------------------------------------------
Peter Maydell (2):
      target/arm: Update translation regime comment for new features
      target/arm: Fix usage of MMU indexes when EL3 is AArch32

Richard Henderson (1):
      target/arm: Clear high SVE elements in handle_vec_simd_wshli

Zheyu Ma (1):
      hw/misc/stm32l4x5_rcc: Add validation for MCOPRE and MCOSEL values

 target/arm/cpu.h               | 50 +++++++++++++++++++++++++++---------------
 target/arm/internals.h         | 27 +++++++++++++++++++----
 target/arm/tcg/translate.h     |  2 ++
 hw/misc/stm32l4x5_rcc.c        | 28 ++++++++++++++++-------
 target/arm/helper.c            | 34 ++++++++++++++++++----------
 target/arm/ptw.c               |  6 ++++-
 target/arm/tcg/hflags.c        |  4 ++++
 target/arm/tcg/translate-a64.c |  3 ++-
 target/arm/tcg/translate.c     |  9 ++++----
 9 files changed, 116 insertions(+), 47 deletions(-)


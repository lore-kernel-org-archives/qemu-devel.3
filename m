Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B05C36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzX38-0001Cg-Ag; Tue, 01 Apr 2025 04:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzX31-00017A-BL
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:32:43 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzX2z-00011S-08
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:32:38 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39c1ef4ae3aso787525f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743496354; x=1744101154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JCd85PIHC2TJwpJShshwwS9Z8JEGUwjbCb+HV1MqV4I=;
 b=tGsEMQFkU/wc+4hBuQdfTjLMwIa1fbZaT0Hcf1aMlJdSguTdODW1Hyx0RN6OAVQ0He
 w57HBnPHld99oCT0MRlkesVQN/Q4A3HK87FonnGhc28kCfkw4MnO7E2j6bNbchXrl3nU
 B0CzcQQQ0bNpPSdhrHWeOsyv/s+G5lleGjyfYlHO8xtrNf2ov6fINReW7BZC51iRoIRF
 dMK32shl9A9xostikt5bTM/K5FQcnHXS7rhwn/2Cys3QZvf6tWuOUL6JunJR2fa3zdx3
 pafWc8eopdg9N7G4wICP31vF1rosDOFnS1SHbvGiA+SBdUT/go6oBMNXArh7SfcfzqW5
 z+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743496354; x=1744101154;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JCd85PIHC2TJwpJShshwwS9Z8JEGUwjbCb+HV1MqV4I=;
 b=Ph+FfI/vYlGteCYm6XzIkMvczyafDsVipfH7XPvM4GPuhyLOZlTFZdVBPWztSg+DOy
 vveE1a4zcqmpGwJQhloXIsV5mneSNvoa6lCPXq8tOt+FhAVtPOYL9V9KikRSBRKYJ3GI
 iXcLeY/JcwZzo1/xKUAWGSLxiFiBgunmGA3C0wfGm+QOn9xRu8NrltanAR2QttgljY+M
 FDICP6FQkVDUi7BD7h/0GWV3ZXXJg7pL4Z4qpgKiBgG4VR5XO8OLpq6rrpRq37kn14nv
 Ue1ld1fK75PCapg2xi3c2jJSaNpLlGXgLO4BBJ5phGTRXAjqWzbjGiptI4zStocMUd7B
 Tq1g==
X-Gm-Message-State: AOJu0YxCHLOYHbSUsdrX4gpwEqqjXL9IAT5V05dWZUqN3/fPxnqTPXSD
 em1L7babLWeRL3d1Oq5QvF5pAc5oaRovU1AyXN+GGImtSHf9Q2ypcfwgJTu7x+I1CZkWhoya1Tv
 g
X-Gm-Gg: ASbGncurXA9cxOOQjxzUv15d09BbUpfqZ7hd89V8cl2xOYFRFb2E0nuxZ1QQmXU3ZJu
 LYHPc2HVEJtXbNuxufon3XEpb8Ils8nSoOjmSqDGz7oylbXNlNei2tylWBj6ohiqTDr6ABCpyI7
 zYUEKJCC5YnQcwNECjZuO7QxlBk72vbPtMiyo+uZMQ4n88UjwyTOKthgScZPmq5Aq3uHreCxLRN
 fpVbS78VsSpc+od1+5FGmc/oMxTHiOSa6l5GeJXDvurxlPB5wOMyPwoG3Au/7BwJdr1LAj+jOK1
 qL8dqWAEv1lPGEOBYIgbkxRu1fb1HNKA4oPyOY2ABYFRIWKgB0gqlunLKWi3O3VNRHbQjCK/eON
 PT1x2Y/lw8ofUUeyyL1zmDL5v01o62A==
X-Google-Smtp-Source: AGHT+IEY3gcE9RwqwlsEtJyNmHg7gKDoR8VXBpTyIaKMn7nIE748jdPmU1sckTrtd4ptHpqybA6jsw==
X-Received: by 2002:a5d:59ac:0:b0:391:bc8:564a with SMTP id
 ffacd0b85a97d-39c0c1369b5mr14674481f8f.22.1743496353640; 
 Tue, 01 Apr 2025 01:32:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8ff02e84sm147981265e9.32.2025.04.01.01.32.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:32:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 0/3] exec: Restrict 'cpu.ldst*.h' headers to
 accel/tcg/
Date: Tue,  1 Apr 2025 10:32:29 +0200
Message-ID: <20250401083232.33773-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Move the TCG-specific cpu-ldst*.h headers to
the accel/tcg/ namespace.

Philippe Mathieu-Daudé (3):
  exec: Restrict 'cpu-ldst-common.h' to accel/tcg/
  exec: Restrict 'cpu_ldst.h' to accel/tcg/
  exec: Do not include 'accel/tcg/cpu-ldst.h' in 'exec-all.h'

 bsd-user/qemu.h                                   | 2 +-
 include/{exec => accel/tcg}/cpu-ldst-common.h     | 6 +++---
 include/{exec/cpu_ldst.h => accel/tcg/cpu-ldst.h} | 8 ++++----
 include/exec/exec-all.h                           | 3 ---
 linux-user/qemu.h                                 | 2 +-
 target/arm/tcg/sve_ldst_internal.h                | 2 +-
 accel/tcg/cpu-exec.c                              | 1 +
 accel/tcg/cputlb.c                                | 2 +-
 accel/tcg/translator.c                            | 2 +-
 accel/tcg/user-exec.c                             | 2 +-
 target/alpha/mem_helper.c                         | 2 +-
 target/arm/tcg/helper-a64.c                       | 2 +-
 target/arm/tcg/m_helper.c                         | 2 +-
 target/arm/tcg/mte_helper.c                       | 2 +-
 target/arm/tcg/mve_helper.c                       | 2 +-
 target/arm/tcg/op_helper.c                        | 2 +-
 target/arm/tcg/pauth_helper.c                     | 2 +-
 target/arm/tcg/sme_helper.c                       | 2 +-
 target/arm/tcg/sve_helper.c                       | 1 +
 target/avr/helper.c                               | 2 +-
 target/hexagon/op_helper.c                        | 2 +-
 target/hexagon/translate.c                        | 2 +-
 target/hppa/op_helper.c                           | 2 +-
 target/i386/tcg/access.c                          | 2 +-
 target/i386/tcg/fpu_helper.c                      | 2 +-
 target/i386/tcg/mem_helper.c                      | 2 +-
 target/i386/tcg/mpx_helper.c                      | 2 +-
 target/i386/tcg/seg_helper.c                      | 2 +-
 target/i386/tcg/system/excp_helper.c              | 2 +-
 target/i386/tcg/system/misc_helper.c              | 2 +-
 target/i386/tcg/system/seg_helper.c               | 2 +-
 target/i386/tcg/system/svm_helper.c               | 2 +-
 target/i386/tcg/user/seg_helper.c                 | 2 +-
 target/loongarch/cpu.c                            | 2 +-
 target/loongarch/tcg/csr_helper.c                 | 2 +-
 target/loongarch/tcg/fpu_helper.c                 | 2 +-
 target/loongarch/tcg/iocsr_helper.c               | 2 +-
 target/loongarch/tcg/op_helper.c                  | 2 +-
 target/loongarch/tcg/tlb_helper.c                 | 2 +-
 target/m68k/fpu_helper.c                          | 2 +-
 target/m68k/op_helper.c                           | 2 +-
 target/microblaze/cpu.c                           | 2 +-
 target/microblaze/op_helper.c                     | 2 +-
 target/microblaze/translate.c                     | 2 +-
 target/mips/tcg/ldst_helper.c                     | 2 +-
 target/mips/tcg/msa_helper.c                      | 2 +-
 target/mips/tcg/system/tlb_helper.c               | 2 +-
 target/ppc/mem_helper.c                           | 2 +-
 target/ppc/mmu_helper.c                           | 2 +-
 target/ppc/tcg-excp_helper.c                      | 2 +-
 target/riscv/op_helper.c                          | 2 +-
 target/riscv/vector_helper.c                      | 2 +-
 target/riscv/zce_helper.c                         | 2 +-
 target/rx/helper.c                                | 2 +-
 target/rx/op_helper.c                             | 2 +-
 target/s390x/tcg/crypto_helper.c                  | 2 +-
 target/s390x/tcg/int_helper.c                     | 2 +-
 target/s390x/tcg/mem_helper.c                     | 2 +-
 target/s390x/tcg/misc_helper.c                    | 2 +-
 target/s390x/tcg/vec_helper.c                     | 2 +-
 target/sh4/op_helper.c                            | 2 +-
 target/sparc/int32_helper.c                       | 2 +-
 target/sparc/ldst_helper.c                        | 2 +-
 target/tricore/op_helper.c                        | 2 +-
 target/tricore/translate.c                        | 2 +-
 65 files changed, 69 insertions(+), 70 deletions(-)
 rename include/{exec => accel/tcg}/cpu-ldst-common.h (97%)
 rename include/{exec/cpu_ldst.h => accel/tcg/cpu-ldst.h} (99%)

-- 
2.47.1



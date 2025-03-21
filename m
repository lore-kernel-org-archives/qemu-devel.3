Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800C9C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 15:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvemW-0000Wg-2c; Fri, 21 Mar 2025 11:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvemR-0000Qv-7R
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 11:59:32 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvemO-0004O3-Sp
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 11:59:30 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso19234185e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 08:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742572767; x=1743177567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=H17qtu9QeSM7DrXU5XPDYZf0J+U/leXiuY16LhzJY+E=;
 b=B157pXCkM7IA6eBzqOR6WlMUGyzfItP3CIMS8iEYdIySMqVH642FpOua42SXH1pVN0
 qMCHVjLax4HmgTiQTgXb1XmGDldmXnalBH8hTNN+r9sUB382FT8lxFVxLI1ogY3EIA4m
 gODoGJPnDI5e6UL1aiftlCHzcAKlIIjlHKxkb/5XmyizIhuqT++bZvWxzsJ13+JUnkel
 17wnIytXC2WH/bAe+hSiI3Hvqj6tMsiLf8D6PHZyppd1+TxYIM4eM9i/N2v7/bOMqR+M
 cYRGrdRQdA+/KEbZ7Wa7K0PzB002I2sDljVGNCX2Tn9z9qj1UbN3H8IMnTT4IXm2Jrar
 6JaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742572767; x=1743177567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H17qtu9QeSM7DrXU5XPDYZf0J+U/leXiuY16LhzJY+E=;
 b=QuUZ1+E3OoEI97OYJ/VBmio9pGqVkNgqjDnOhmKLVMTECIVn8J3Tr4AyHImgzLDGYK
 /pZh1umkfJf+TnwagcXtA2fuWiFUoDl3OVQ+tvvH8I9BR8yJVRg/OqrMbsVraqgu4Y3G
 X80m58Qjrg65tgz7QVwP5vMBpFRpsvOYZ2VoerNjIBPHMBkKZt4zaz5UpFNgqXAH98gJ
 1/GQpqJ/6uyfOwexVLqwukef8EfE2j7m6fz3bReLUKY+MO97UmwDe8XyJPl1FBCqDEyp
 NA2Og2wqJFx12u4UozWUf/EBWE7azaio/jUELAB5UDu309JPhoCn9gpRf6CvGsdHEHAQ
 +lsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbZj91r1NWCl5oakVxP9eXrFRgGXqv5UFyU+xPHPwxAERS/tUrfVVEhAGRtxpmVoi711YLkmS5bqQR@nongnu.org
X-Gm-Message-State: AOJu0Yw9vT+E1HY4TuiNYOJAYnD78vtm1HROTbT8A+U0VE9PVCg1tvrw
 dXxXReeUAPR+/RSiuH/QzBjlpz3tDB/CkMtCGJtqngO9Yyxe90w76iWVGyE0hXlgHphZpmtLJ8u
 A
X-Gm-Gg: ASbGncs7ZEUwVUvQCinDuSjHDs3qMBYhbcKfRETvaPTe3wEjqGlgg8xX7N8fUnqnH0T
 OmEsn6/Oq0OZ/Dic0b3wOmaC+ITGh2ip1e4lImzI8kocrCh+3p7AqegOuxl8f7BzWtRmZbthnQ5
 3QxflYQ3tfNR+xEZCvb9svcsh25WSaCBxMqpta+ck1CLtNXuruhAIFZ3ZtthJN5Lw9ImDrek7h2
 wVNy57gWopIxWW8pZWqL0Ns0uwxRlsUYJSaN6zG8bUldC7a7jtxy/NpxU0NzELxOwlf9HU5HCXX
 1zAdX1YGnFBXTc3Yml4sr5qu9edeI9+uRrXH1CHLfc4ex9303C7Ygc+6+2OBCte4HeZ18J2Y3nC
 ZL670jVejZYZUJlfZAxcll1aAvvwksg==
X-Google-Smtp-Source: AGHT+IG7TA43/BkN/ypWmdwHpL0Gv5NRDFRRAGlIOYjn/jhz5ECeqNyhGZYm6Ox/vUKMSDTFDp0Q2A==
X-Received: by 2002:a05:600c:1e0d:b0:43c:f689:88ce with SMTP id
 5b1f17b1804b1-43d50a1d1b4mr39174095e9.20.1742572766734; 
 Fri, 21 Mar 2025 08:59:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43d7c6a5sm82099065e9.0.2025.03.21.08.59.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Mar 2025 08:59:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 0/4] tcg: Convert TARGET_SUPPORTS_MTTCG to
 TCGCPUOps::mttcg_supported field
Date: Fri, 21 Mar 2025 16:59:20 +0100
Message-ID: <20250321155925.96626-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

In this series we replace the TARGET_SUPPORTS_MTTCG (Makefile)
definition by a 'mttcg_supported' field in TCGCPUOps.

Based-on: <20250321125737.72839-1-philmd@linaro.org>

Philippe Mathieu-Daudé (4):
  target/riscv: Restrict RV128 MTTCG check on system emulation
  tcg: Move qemu_tcg_mttcg_enabled() to 'system/tcg.h'
  tcg: Convert TCGState::mttcg_enabled to TriState
  tcg: Convert TARGET_SUPPORTS_MTTCG to TCGCPUOps::mttcg_supported field

 docs/devel/multi-thread-tcg.rst          |  2 +-
 configs/targets/aarch64-softmmu.mak      |  1 -
 configs/targets/alpha-softmmu.mak        |  1 -
 configs/targets/arm-softmmu.mak          |  1 -
 configs/targets/hppa-softmmu.mak         |  1 -
 configs/targets/i386-softmmu.mak         |  1 -
 configs/targets/loongarch64-softmmu.mak  |  1 -
 configs/targets/microblaze-softmmu.mak   |  1 -
 configs/targets/microblazeel-softmmu.mak |  1 -
 configs/targets/mips-softmmu.mak         |  1 -
 configs/targets/mipsel-softmmu.mak       |  1 -
 configs/targets/or1k-softmmu.mak         |  1 -
 configs/targets/ppc64-softmmu.mak        |  1 -
 configs/targets/riscv32-softmmu.mak      |  1 -
 configs/targets/riscv64-softmmu.mak      |  1 -
 configs/targets/s390x-softmmu.mak        |  1 -
 configs/targets/sparc-softmmu.mak        |  1 -
 configs/targets/sparc64-softmmu.mak      |  1 -
 configs/targets/x86_64-softmmu.mak       |  1 -
 configs/targets/xtensa-softmmu.mak       |  1 -
 configs/targets/xtensaeb-softmmu.mak     |  1 -
 include/accel/tcg/cpu-ops.h              |  8 +++
 include/exec/poison.h                    |  1 -
 include/hw/core/cpu.h                    |  9 ----
 include/system/tcg.h                     |  8 +++
 accel/tcg/tcg-all.c                      | 68 +++++++++++++-----------
 target/alpha/cpu.c                       |  1 +
 target/arm/cpu.c                         |  1 +
 target/arm/tcg/cpu-v7m.c                 |  1 +
 target/avr/cpu.c                         |  1 +
 target/hexagon/cpu.c                     |  1 +
 target/hppa/cpu.c                        |  1 +
 target/i386/tcg/tcg-cpu.c                |  1 +
 target/loongarch/cpu.c                   |  1 +
 target/m68k/cpu.c                        |  1 +
 target/microblaze/cpu.c                  |  1 +
 target/mips/cpu.c                        |  1 +
 target/openrisc/cpu.c                    |  1 +
 target/ppc/cpu_init.c                    |  1 +
 target/riscv/tcg/tcg-cpu.c               |  4 +-
 target/rx/cpu.c                          |  1 +
 target/s390x/cpu.c                       |  1 +
 target/sh4/cpu.c                         |  1 +
 target/sparc/cpu.c                       |  1 +
 target/tricore/cpu.c                     |  1 +
 target/xtensa/cpu.c                      |  1 +
 tcg/region.c                             |  4 +-
 47 files changed, 78 insertions(+), 65 deletions(-)

-- 
2.47.1



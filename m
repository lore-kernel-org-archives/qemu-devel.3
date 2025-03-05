Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F0EC282E5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 15:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpqqU-0008FM-J1; Wed, 05 Mar 2025 10:39:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqqP-0008Eg-0c
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:39:37 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqqL-0002E4-Sl
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:39:35 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38a8b17d7a7so4191557f8f.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 07:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741189171; x=1741793971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3qIz3Fh7hymORetdouKvxf1jyDgYWERdVUgc9gjrBsg=;
 b=tZOnfcgaX9jiz/30JvDPNwXxWVCOVENirYlRuHwtdae45/9SI6ARapYVN7Abz9kNxL
 H0PT1sSwYcq20cffq+0WFTkkV96BK7A27Elji+wxjJohGkAuhJv2bhZukSyvFWxoEask
 cPEVZytQbgMQmpAj8jTfJInpZSQD2gD+F5f6PpZcgZm1ejxFXovaOjp0QPNBf6ylE0Ma
 kAKoyASOzRQreLRDcBPiZ2WZNtmC4YySZF88dst2lNBa5JWv3iPf0TGSyDOoW4ligl/4
 x9n7zf4x+c9bZxmDQs+OGWxCsua2Pt17Zx4mZhD9TpIBP3IgxZzaHuUK6lkjd6RLDPCk
 ci1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741189171; x=1741793971;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3qIz3Fh7hymORetdouKvxf1jyDgYWERdVUgc9gjrBsg=;
 b=vntOfs9Lym/IwB9DL06xhOT8LDco7X2z5O2iSsZijsoh804g5euz0Ef2mEoTG3F3uB
 CQTWg9jljCtPvI1mXPTFvC0Rqffbe3eA5Wter2XwRRQ6Ayy2GYQax+bOW/Sr72vFtVVc
 yTzYqhHaESAqHT2IuIwMBfnBYwECmlEoXaiqMbV9+ofeF9mXZI4Ax0/IfDherDuquWfo
 ZnED1SPB91wnxQ9fmEk1vlL7+16tdJjWF15UrxAFxhDK9e88lQfeuwF1ICrmV213ZDWV
 JJtq9gyEEQyUILvTYi3oKdi81Y41tewlnYiHgcMebT/FAI/bfcygR8qVHuDYcHU2aMls
 uUeA==
X-Gm-Message-State: AOJu0YxFXTrt4xoL4s+zTwkykXUV0bmm8hQJReVBxRpEmTa5D6XVeD8v
 N5bFgYi1qj9N/oBXQT5PMidhOOL2CqCfekH7+tXL0A2BfbbHcWiKDXQdyv5czWElidTfw4yqTv8
 kjQI=
X-Gm-Gg: ASbGnctnOhq8ekJIUT1rKE2WHorIUGMZwUn4txXaLTTNcvsbxeHIOnsoN82pnSnT7mc
 4UQDp18OP7fiNpT0EJcWQRA4O511t1tXkkH78skIIzeKWAe2+7nDTffe4Va+ESz6CLmBuuk3kzQ
 zAQ3KfEbzUzbUI4ATM5l2jQOi0uUq5LKmDF29A7S0KCTEmyO8UG/j1Yqbapg96Bp4rQp+6x5oux
 srFKL7/dxxzVohBL6EIfCzlseht7+GPikhFG3IQEHNXjdnNoaSsUx9ddN63yWq86cGGtb9Vvvyw
 8J4XoiTfHwJwHxBS/9djOXwOl2oKJOpaJxIoSqnn/bRKkXHR2lB0wFCYaouslHS3yz4gEKj9Rx3
 r7wwqVoORnbrji9HnaPw=
X-Google-Smtp-Source: AGHT+IF2eIPe7c1UBR4u3yefzdQYKWbSyCrZiqzoREhBq3RpFZkP7mgU0lpq6wbCOGJYyR+/s5HzyQ==
X-Received: by 2002:a5d:64a9:0:b0:38f:2678:d790 with SMTP id
 ffacd0b85a97d-3911f770a3amr2747685f8f.33.1741189170968; 
 Wed, 05 Mar 2025 07:39:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b7cf2sm21785754f8f.59.2025.03.05.07.39.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Mar 2025 07:39:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 00/18] hw/microblaze: Quick single binary proof of concept
Date: Wed,  5 Mar 2025 16:39:10 +0100
Message-ID: <20250305153929.43687-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Introduce an API to get target-specific information
from our current binary names (considered legacy as
of today).

At this point, get endianness and target_long_bits,
just enough to build qemu-system-microblaze (default
to big endian) and its little-endian symlink:

 $ make qemu-system-microblaze{,el}

 $ ./qemu-system-microblaze -M help
 Supported machines are:
 none                 empty machine
 petalogix-ml605      PetaLogix linux refdesign for xilinx ml605 (big endian) (deprecated)
 petalogix-s3adsp1800 PetaLogix linux refdesign for xilinx Spartan 3ADSP1800 (big endian) (default)
 xlnx-zynqmp-pmu      Xilinx ZynqMP PMU machine (big endian) (deprecated)

 $ ./qemu-system-microblazeel -M help
 Supported machines are:
 none                 empty machine
 petalogix-ml605      PetaLogix linux refdesign for xilinx ml605 (big endian) (deprecated)
 petalogix-s3adsp1800 PetaLogix linux refdesign for xilinx Spartan 3ADSP1800 (little endian) (default)
 xlnx-zynqmp-pmu      Xilinx ZynqMP PMU machine (big endian) (deprecated)

Based-on: <20250305005225.95051-1-philmd@linaro.org>

Philippe Mathieu-Daudé (18):
  hw/xen/hvm: Fix Aarch64 typo
  hw/vfio/common: Get target page size using runtime helpers
  include: Poison TARGET_PHYS_ADDR_SPACE_BITS definition
  qemu: Introduce 'qemu/legacy_binary_info.h'
  qemu: Introduce legacy_binary_is_64bit() helper
  hw/mips/mipssim: Replace TARGET_MIPS64 by legacy_binary_is_64bit()
  hw/mips/malta: Replace TARGET_MIPS64 by legacy_binary_is_64bit()
  hw/i386: Inline TARGET_DEFAULT_CPU_TYPE definition
  hw/ppc/mac: Replace TARGET_PPC64 by legacy_binary_is_64bit()
  qemu: Introduce legacy_binary_is_big_endian() helper
  hw/mips/jazz: Replace TARGET_BIG_ENDIAN by legacy_binary_is_big_endian
  hw/mips/mipssim: Use legacy_binary_is_big_endian()
  hw/xtensa/sim: Replace TARGET_BIG_ENDIAN by
    legacy_binary_is_big_endian
  hw/xtensa/xtfpga: Check endianness via legacy_binary_is_big_endian()
  hw/microblaze/petalogix_ml605_mmu: Use legacy_binary_is_big_endian()
  hw/microblaze/petalogix_s3adsp1800_mmu: Use
    legacy_binary_is_big_endian
  meson: Allow symlinking system emulation binaries
  configs/targets: Merge qemu-system-microblaze{el} binaries

 configs/targets/microblazeel-softmmu.mak |   8 -
 meson.build                              |  18 +-
 include/exec/poison.h                    |   1 +
 include/hw/xen/arch_hvm.h                |   2 +-
 include/qemu/legacy_binary_info.h        |  25 +++
 target/i386/cpu.h                        |   6 -
 hw/i386/microvm.c                        |   5 +-
 hw/i386/pc.c                             |   5 +-
 hw/i386/xen/xen-pvh.c                    |   5 +-
 hw/microblaze/petalogix_ml605_mmu.c      |   4 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  13 +-
 hw/mips/jazz.c                           |  23 ++-
 hw/mips/malta.c                          |   8 +-
 hw/mips/mipssim.c                        |  36 ++--
 hw/ppc/mac_newworld.c                    |   9 +-
 hw/ppc/mac_oldworld.c                    |   5 +-
 hw/vfio/common.c                         |   9 +-
 hw/xtensa/sim.c                          |   4 +-
 hw/xtensa/xtfpga.c                       |  12 +-
 legacy_binary_info.c                     | 240 +++++++++++++++++++++++
 system/vl.c                              |   2 +
 21 files changed, 358 insertions(+), 82 deletions(-)
 delete mode 100644 configs/targets/microblazeel-softmmu.mak
 create mode 100644 include/qemu/legacy_binary_info.h
 create mode 100644 legacy_binary_info.c

-- 
2.47.1



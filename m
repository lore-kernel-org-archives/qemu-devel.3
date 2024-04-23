Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BD9C10F15
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzG0b-00057L-0B; Tue, 23 Apr 2024 09:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG0X-00056i-HG
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG0T-0001s9-70
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713878179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=e+O+W2i62FDGR13CKY50D1yVNwOkcbU/X4PHsRwARD4=;
 b=SgEWD0pZkplE1HIW5JSmt2JKDM2qkmVTrdjYwC5SMEfjfrq1evyHIhc5BzDAroqGBqix57
 3oNNz7347GXWJObq4LiF+lp4/34M1x1J84Sh3+m2hKo6GXonDTy75Tq6oM46E8ZwNAh4Ub
 MP5BO7XGoJrou/g56rUcIwKpRlIe38A=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-lTyHs_PiOwKWbhbSL0mv7A-1; Tue, 23 Apr 2024 09:16:17 -0400
X-MC-Unique: lTyHs_PiOwKWbhbSL0mv7A-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2dd05014390so33939941fa.3
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713878175; x=1714482975;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e+O+W2i62FDGR13CKY50D1yVNwOkcbU/X4PHsRwARD4=;
 b=h4blVPwCgyBUbosDhgepe3b3L32BK/Ro7pwC3e6FYhLc/Cg1s4BriTUYd04+04Pr5m
 nl1kM3phoaKlnq1eJdYuAguNVliDvk0wt+Hhy4H7dwItiElxxA0VZwuG42jzHVpMelr3
 KtIZdHVaYrjW7/nz2HlNMjgMH4KWQkcbIiRQC4U9/v3nrwxgHznk5x/L858DkMnFQ/Do
 9Atu3iYssEwCTpP3kMnh8+UzaLKL7pVvJttfp+VgG+ZsqbZsEXnqShxwokrq8XuADZce
 vc8z64mE5HW8d0rlriQDP21ZZo5AZfVEYv5mXMoVXkQR/USWAdL3DiZCZaZt7a9yG00S
 NV+A==
X-Gm-Message-State: AOJu0YyS+D/vimdpa7VGy0eAg8x83lBEiHuUfoknIx3BgXoeIqm9RSJs
 nM9ZZYO4P+bebkW+Y4Oer9PaGRZZo07/TY9g/sTJxGqEvA2GkxfkDEw9mWhYES03xApOiyu0Ys3
 d50PxYrACdlcQAkgpY2n88xWFLbRIDdb5SYj8aXTZNO+83LC7HHq/g0o+JPE6XAvsYZzGndtXIh
 p17l/9bby25+ejnLkTLgABnW/jlMYO+3hOQ9Zq
X-Received: by 2002:a05:651c:198c:b0:2dd:bd92:63a with SMTP id
 bx12-20020a05651c198c00b002ddbd92063amr3865158ljb.34.1713878175213; 
 Tue, 23 Apr 2024 06:16:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRtqCELcigiTgM4KNXKt8pqLpau1Eo/BfNA8eyiXjz5rLBziMSaFSMU+NIf9Xe+Tuh+FNIFQ==
X-Received: by 2002:a05:651c:198c:b0:2dd:bd92:63a with SMTP id
 bx12-20020a05651c198c00b002ddbd92063amr3865125ljb.34.1713878174685; 
 Tue, 23 Apr 2024 06:16:14 -0700 (PDT)
Received: from avogadro.local ([151.81.119.75])
 by smtp.gmail.com with ESMTPSA id
 ch15-20020a0564021bcf00b0056e34297cbasm6697011edb.80.2024.04.23.06.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 06:16:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	farosas@suse.de
Subject: [PATCH 00/22] configs: switch boards to "default y"
Date: Tue, 23 Apr 2024 15:15:50 +0200
Message-ID: <20240423131612.28362-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Some boards, notably ARM boards that use TCG, are already using
"default y".  This was done to remove TCG-only boards from
a KVM-only build in commit 29d9efca16 (2023-04-26).

This series converts all other boards to that, so that the requirements
of each board are clearer in the Kconfig files.

For now, the only such use is MIPS's 64-bit and endianness requirements.
In the future, it will be possible to enable/disable boards based
on the presence of required libraries, for example libfdt, or
their deprecation status.

There is an important difference in that Kconfig symbols for boards
have to be enabled in a --without-default-devices build, similar to
devices.

Paolo

Paolo Bonzini (22):
  configs: list "implied" device groups in the default configs
  alpha: switch boards to "default y"
  arm: switch boards to "default y"
  avr: switch boards to "default y"
  cris: switch boards to "default y"
  hppa: switch boards to "default y"
  i386: switch boards to "default y"
  loongarch: switch boards to "default y"
  m68k: switch boards to "default y"
  microblaze: switch boards to "default y"
  meson: make target endianneess available to Kconfig
  mips: switch boards to "default y"
  nios2: switch boards to "default y"
  openrisc: switch boards to "default y"
  ppc: switch boards to "default y"
  riscv: switch boards to "default y"
  rx: switch boards to "default y"
  s390x: switch boards to "default y"
  sh4: switch boards to "default y"
  sparc: switch boards to "default y"
  tricore: switch boards to "default y"
  xtensa: switch boards to "default y"

 configs/devices/alpha-softmmu/default.mak     |  5 ++--
 configs/devices/arm-softmmu/default.mak       |  5 +++-
 configs/devices/avr-softmmu/default.mak       |  5 ++--
 configs/devices/cris-softmmu/default.mak      |  5 ++--
 configs/devices/hppa-softmmu/default.mak      |  5 ++--
 configs/devices/i386-softmmu/default.mak      | 11 ++++---
 .../devices/loongarch64-softmmu/default.mak   |  6 +++-
 configs/devices/m68k-softmmu/default.mak      | 13 ++++----
 .../devices/microblaze-softmmu/default.mak    |  9 +++---
 configs/devices/mips-softmmu/common.mak       |  5 ++--
 configs/devices/mips64-softmmu/default.mak    |  4 ++-
 configs/devices/mips64el-softmmu/default.mak  | 10 ++++---
 configs/devices/nios2-softmmu/default.mak     |  7 ++---
 configs/devices/or1k-softmmu/default.mak      |  9 ++++--
 configs/devices/ppc-softmmu/default.mak       | 30 +++++++++++--------
 configs/devices/ppc64-softmmu/default.mak     |  8 ++---
 configs/devices/riscv32-softmmu/default.mak   | 17 +++++------
 configs/devices/riscv64-softmmu/default.mak   | 19 ++++++------
 configs/devices/rx-softmmu/default.mak        |  3 +-
 configs/devices/s390x-softmmu/default.mak     |  5 ++--
 configs/devices/sh4-softmmu/default.mak       |  7 ++---
 configs/devices/sparc-softmmu/default.mak     |  7 ++---
 configs/devices/sparc64-softmmu/default.mak   |  7 ++---
 configs/devices/tricore-softmmu/default.mak   |  7 +++--
 configs/devices/xtensa-softmmu/default.mak    | 11 ++++---
 meson.build                                   | 12 ++++----
 hw/alpha/Kconfig                              |  2 ++
 hw/arm/Kconfig                                |  2 ++
 hw/avr/Kconfig                                |  3 ++
 hw/cris/Kconfig                               |  2 ++
 hw/hppa/Kconfig                               |  2 ++
 hw/i386/Kconfig                               | 10 ++++++-
 hw/loongarch/Kconfig                          |  2 ++
 hw/m68k/Kconfig                               | 10 +++++++
 hw/microblaze/Kconfig                         |  6 ++++
 hw/mips/Kconfig                               | 12 ++++++++
 hw/nios2/Kconfig                              |  9 +++---
 hw/openrisc/Kconfig                           |  4 +++
 hw/ppc/Kconfig                                | 26 ++++++++++++++++
 hw/riscv/Kconfig                              | 14 +++++++++
 hw/rx/Kconfig                                 |  2 ++
 hw/s390x/Kconfig                              |  2 ++
 hw/sh4/Kconfig                                |  4 +++
 hw/sparc/Kconfig                              |  4 +++
 hw/sparc64/Kconfig                            |  4 +++
 hw/tricore/Kconfig                            |  4 +++
 hw/xtensa/Kconfig                             |  6 ++++
 target/Kconfig                                |  3 ++
 target/i386/Kconfig                           |  1 +
 target/ppc/Kconfig                            |  1 +
 50 files changed, 252 insertions(+), 115 deletions(-)

-- 
2.44.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26F4CD4F3C
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 01:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNKg6-0006pp-NV; Wed, 13 May 2026 21:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wNKg1-0006pB-2N
 for qemu-devel@nongnu.org; Wed, 13 May 2026 21:15:50 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wNKfy-0000q9-2c
 for qemu-devel@nongnu.org; Wed, 13 May 2026 21:15:47 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2bd2051167eso11214355ad.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 18:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778721344; x=1779326144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HAr2Zq/kW8JlJv20GUAvCugs87zljgPSid8+CoWqWG8=;
 b=hRvTubLK0lJhoavgJSpCLFIQNgGfocA8jn9AhlZFo1pHnyXgFDbswhmzfqDa7aix59
 lEa30G1+BnZw+6b3TT4BXj9RyBOp8wzFCb5MRtTF+dcI+1xRChWO4vTwDLZ75S/V+5pf
 2Sa2BCv6n+3G/pKVc6hRGPjy365YMkvY3gIQ41Q7346mQet5Qg3u64hRidGQSAmxaaT7
 o3PxfBLj4GPM/ZZ426ziegcIWdicTVhuYY64sW9bZ7a/izafJWaa4D1SBegXIX7VdQ+q
 Om9vSGHcg13zxavvbPBNsupzcMSWhdKwHjj09rRxUoEIpDO4cUpayZOViKb4g2hmwgyZ
 jvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778721344; x=1779326144;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HAr2Zq/kW8JlJv20GUAvCugs87zljgPSid8+CoWqWG8=;
 b=Rdo96Dffp1WKlWQFiM7N6++yzmSIn8/mbDzQ2htv0QwLQZA7Bggn1OVa0laYQAdnLn
 YKzbfn7onO28nXM5+x3SZqGwJ+/pDTDAD7Mk/Sax2lxdKcowQeExXHujzm6kODvHVi1f
 7CNzoioR5sqdvy9xtqnXrdYAYYAKkq3U7RkBk6Qj7vF1BkaKEs53XdCakdJ0xkcIUeBD
 cucRP+YjRcc+gi2w7dGDdWnTb+kWvYokrX01ns6FSrBhbo8N/oM0B0kS8uYuT64vCqr2
 k3UmBdduwSHFZyFWgcRpTXcOWkHhEnkE1SewXPUjQRI26ov2LXRdrb9gA3MwGDfmsN3s
 IUlA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8h/dHF3IwhdCCugTAN3I88kSAk1HMqBu11QW6cV7vs2t5/elSPpJvmaLivFx9H+HHnlbty8bOylseW@nongnu.org
X-Gm-Message-State: AOJu0YwiQ3vMS6JqMbnVZ6OzMEVbVQcLYlqA/QnBdk/0mwjhNppNRZmG
 j5PaK1yEtMkUsoqHIxmk5G20IFLHpdl6Lz9cm5ScNWkGjUPF3Y7YR4uL
X-Gm-Gg: Acq92OF3nXvQBLostk9QPAMwlU7uYcl+y8pfKqCh7G4LB6sa3r4n7Cf1tkbW10kaTvS
 17v2VMuEBLXqsn1x/Mk5QctGs2FhnxJehDo0xQNx3p37wcutgdFqRlL+6TRTqxLy/3IYEmh8nVk
 fzizOnpf2AE/8RgFfIaCUOWbiPfEZ7TijtPL+pqjGhABU3HAwzRfMGpXxHW6fJNer4D63RW4x7d
 di/B8L754S20O9tD05ECkWiXQ/GHNYZQVfRf0wNFXSC2dZLC9C0MCQ9GJRcFG/MC0cLSX/3mLUZ
 eE2dgoQmgQK7Id1o4KD25XifUR2egW6bhNR5fKsjNA4th/XbRcVx2QVeKKMtlpcGLe3jtkj/YtO
 O0RiHc0ubHb4sAwK4boHU7Bmv6GyedK9zuyQhLhN+rMIPSkowlGAMNkVdHPmkNxijJqOpZ+q5FB
 XHG/Jjd5DqOBJhE9q+RaOFA1Ugpm4o9ei5AfkC3J3a0rZU3Oq8t+2o3aGsfc9LwciZtPU9zE7Fp
 TzQRPyn7H0RlrCL4EH/fhUGt1roT98uRqs1a2iziupu
X-Received: by 2002:a17:902:f90e:b0:2b7:88d8:efde with SMTP id
 d9443c01a7336-2bd2f4cbbf2mr34805635ad.7.1778721343874; 
 Wed, 13 May 2026 18:15:43 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (54.109.81.34.bc.googleusercontent.com. [34.81.109.54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c0600c3sm4982575ad.29.2026.05.13.18.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 18:15:43 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: pbonzini@redhat.com, marcandre.lureau@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, christoph.muellner@vrull.eu, farosas@suse.de,
 lvivier@redhat.com
Cc: liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 0/6] hw/riscv: Add support for Milk-V Duo board
Date: Thu, 14 May 2026 01:15:22 +0000
Message-ID: <20260514011528.1263665-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=visitorckw@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add initial support for the Milk-V Duo board.

The Sophgo CV1800B SoC features T-Head C906 processing, standard PLIC
and CLINT controllers, a dw8250 uart, and basic clock control. Combined
with simple stubs for custom T-Head PMU CSRs, the current
implementation can successfully run OpenSBI and boot Linux v7.0 from an
SD card to the Linux shell.
---
Changes in v2:
- Added link for the custom T-Head PMU CSRs
- Added qtest to validate basic for the dw8250 and clock controller.
- Removed RFC tag.

Kuan-Wei Chiu (6):
  target/riscv: Add stubs for T-Head PMU CSRs
  hw/char: Add dw8250 UART
  hw/misc: Add Sophgo CV1800B clock controller
  hw/riscv: Add Sophgo CV1800B SoC support
  hw/riscv: Add Milk-V Duo board support
  tests/qtest: Add qtest for Milk-V Duo board

 MAINTAINERS                                 |  12 ++
 configs/devices/riscv64-softmmu/default.mak |   1 +
 hw/char/Kconfig                             |   4 +
 hw/char/dw8250.c                            | 118 ++++++++++++++
 hw/char/meson.build                         |   1 +
 hw/misc/Kconfig                             |   3 +
 hw/misc/cv1800b_clk.c                       |  89 +++++++++++
 hw/misc/meson.build                         |   1 +
 hw/riscv/Kconfig                            |  14 ++
 hw/riscv/cv1800b.c                          | 168 ++++++++++++++++++++
 hw/riscv/meson.build                        |   3 +
 hw/riscv/milkv_duo.c                        | 122 ++++++++++++++
 include/hw/char/dw8250.h                    |  27 ++++
 include/hw/misc/cv1800b_clk.h               |  24 +++
 include/hw/riscv/cv1800b.h                  |  52 ++++++
 target/riscv/th_csr.c                       |  30 ++++
 tests/qtest/meson.build                     |   3 +-
 tests/qtest/milkv-duo-test.c                |  70 ++++++++
 18 files changed, 741 insertions(+), 1 deletion(-)
 create mode 100644 hw/char/dw8250.c
 create mode 100644 hw/misc/cv1800b_clk.c
 create mode 100644 hw/riscv/cv1800b.c
 create mode 100644 hw/riscv/milkv_duo.c
 create mode 100644 include/hw/char/dw8250.h
 create mode 100644 include/hw/misc/cv1800b_clk.h
 create mode 100644 include/hw/riscv/cv1800b.h
 create mode 100644 tests/qtest/milkv-duo-test.c

-- 
2.54.0.563.g4f69b47b94-goog



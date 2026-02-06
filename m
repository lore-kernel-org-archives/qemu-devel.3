Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C4DE9129D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 04:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voDM4-0004IW-Ro; Thu, 05 Feb 2026 23:22:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voDM3-0004IG-SC
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 23:22:03 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voDM2-0003Pl-2j
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 23:22:03 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-81e821c3d4eso1457456b3a.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 20:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770351720; x=1770956520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GWiowObtYe31NsMaSO/9YqeYyqvmY74xvGzJVT9wiZ0=;
 b=D0H4Nj/Z4dkRPYt1ULbWHV7UdQFdIu/doumHnwNKetlCbigRyNiQpZyalshInQO9q0
 Ri6A4ZNq7TtVNzz+lJXsFFC14lOsLxcYNQfA+9SAJPkc9wJzTQ4FvL9CET58UMI+fijY
 UR4kin9J1yJnyzcztQw+gC/SjmyT9t4c0c8ZnE0GL1L6owS7QpaHONOfS5l48BVLZ7LH
 nVqVSeoQXyO1CoUCoK0ESHEsy1GZ22jPzkimjg9gmw26IHY67DOCha6Oz6E1npRF6RGC
 aVT3tcW5aBBbytmUtw8ouDG58TaIzv4foMILa/Zi0crcQxp2OXtAjWUjl/nD8yPDTs2p
 Y8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770351720; x=1770956520;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GWiowObtYe31NsMaSO/9YqeYyqvmY74xvGzJVT9wiZ0=;
 b=KVrDobHFdwy0TT58IOtu+7/iB7wdKfQOOM1m/ZvXmkC6O6nj+wop+Hek7rWEX6ocyf
 ZQQOUtbf7NxasDn7UhWaHCf7jkrC0YYpb5OZHDNqCzxNnaZUYh0p25bGNIK70n9vySQO
 4xvKmjJVb1AfKsDJxyng1SuuNTxtLQ5yzIEtKXTvpkftvMwPiHsUYntiemadqu8W6VRf
 IQ/4SMFbAvkFSo9Q+Ufo/6enU5639yQ0iKykYkcmY0Dg3fFVtB/nIYLNSKS7FENjhm8Z
 mFWs/t3z8D31kJwErAKiGZjUT2gjDlYsA0YtoOx8rzFq8PF9xf8lx/Kc78svqyPT4TFN
 H26Q==
X-Gm-Message-State: AOJu0Ywlu6QlJkVPz5EsuW3wvXPnb5QzFWPpnOvOSXxidLGoE6MoPFe1
 XDcuAn7/eVt6nACAfTCW+EaGJ8U2zd34ptj/nXw9s0EZN0yooRHdsM5HJ7oymPEaMCa74s3jELd
 VmjDY
X-Gm-Gg: AZuq6aLqA0Y59YBv8gOfFhV4v3Q8jUp06OP6rtw3AbB4TotAf5/qWtt13sUEFJ3+btA
 1vq4L2pr3AkuK7MuK5leilKeK3TthPJQM3x0gbdgGMyjWJkF49jMVOULEoo+WdVllvGg5sW5tVN
 Z0TXX5uOEDxcZFlfa/hvws5nJp8IGY53drjDZ+YFUzaM3KxJgrdXLxg4pv+SloX2wz+FYg+Q3qy
 mAZgSZMLJbWRIyudx9SWSoU4ybXGjNeNQ/lGqKk+0u6gQ60U/EL8yJKzCPAZv1ev0BRJk3MOdIn
 KSzZyeJ8jDjcBP2DZ7rk7Jv1V0ar4+YndsFisIYB/Mv/ynu9lH4kDclCJAFBRLAY+ixjYLo7Yqc
 cBWrdg4FhtyHw1SSYUdpT7YysXKJVqeY+UyxiUh4U/ND+E4qG6h42pUUipP4Zxbf3jLfjuG46id
 ZBxk4qT8dNuL/jqoEMLl/MJ2hAoQHvbMbxt3a2AsExYC//pCIADdBxN6cIoMJ4dMIN
X-Received: by 2002:a05:6a00:3997:b0:7e8:4433:8fb9 with SMTP id
 d2e1a72fcca58-82441773041mr1246675b3a.65.1770351720150; 
 Thu, 05 Feb 2026 20:22:00 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8244168fdf5sm926914b3a.17.2026.02.05.20.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 20:21:59 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Richard Henderson <richard.henderson@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 00/12] target/arm: single-binary
Date: Thu,  5 Feb 2026 20:21:38 -0800
Message-ID: <20260206042150.912578-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

This series continues cleaning target/arm, especially tcg folder.

For now, it contains some cleanups in headers, and it splits helpers per
category, thus removing several usage of TARGET_AARCH64.
First version was simply splitting 32 vs 64-bit helpers, and Richard asked
to split per sub category.

v2
--

- add missing kvm_enabled() in arm-qmp-cmds.c
- didn't extract arm_wfi for tcg/psci.c. If that's a hard requirement, I can do
  it in next version.
- restricted scope of series to helper headers, so we can validate things one
  step at a time. Series will keep on growing once all patches are reviewed.
- translate.h: use vaddr where appropriate, as asked by Richard.

Pierrick Bouvier (12):
  target/arm/arm-qmp-cmds.c: make compilation unit common
  target/arm: extract helper-mve.h from helper.h
  target/arm: extract helper-a64.h from helper.h
  target/arm: extract helper-sve.h from helper.h
  target/arm: extract helper-sme.h from helper.h
  target/arm/tcg: duplicate tcg/arith_helper.c and tcg/crypto_helper.c
    between user/system
  target/arm: move exec/helper-* plumbery to helper.h
  target/arm/tcg/psci.c: make compilation unit common
  target/arm/tcg/cpu-v7m.c: make compilation unit common
  target/arm/tcg/vec_helper.c: make compilation unit common
  target/arm/tcg/translate.h: replace target_ulong with vaddr
  target/arm/tcg/translate.h: replace target_long with int64_t

 target/arm/helper-a64.h                       |  14 ++
 target/arm/helper-mve.h                       |  14 ++
 target/arm/helper-sme.h                       |  14 ++
 target/arm/helper-sve.h                       |  14 ++
 target/arm/helper.h                           |  17 +-
 target/arm/kvm_arm.h                          |   3 +
 .../tcg/{helper-a64.h => helper-a64-defs.h}   |   0
 target/arm/tcg/{helper.h => helper-defs.h}    |   0
 .../tcg/{helper-mve.h => helper-mve-defs.h}   |   0
 .../tcg/{helper-sme.h => helper-sme-defs.h}   |   0
 .../tcg/{helper-sve.h => helper-sve-defs.h}   |   0
 target/arm/tcg/translate-a32.h                |   2 +-
 target/arm/tcg/translate.h                    |  22 +-
 target/arm/tcg/vec_internal.h                 |  49 ++++
 target/arm/arm-qmp-cmds.c                     |  27 +--
 target/arm/debug_helper.c                     |   4 +-
 target/arm/helper.c                           |   5 +-
 target/arm/kvm-stub.c                         |   5 +
 target/arm/kvm.c                              |  21 ++
 target/arm/tcg/arith_helper.c                 |   4 +-
 target/arm/tcg/crypto_helper.c                |   4 +-
 target/arm/tcg/gengvec64.c                    |   3 +-
 target/arm/tcg/helper-a64.c                   |   6 +-
 target/arm/tcg/hflags.c                       |   4 +-
 target/arm/tcg/m_helper.c                     |   2 +-
 target/arm/tcg/mte_helper.c                   |   3 +-
 target/arm/tcg/mve_helper.c                   |   6 +-
 target/arm/tcg/neon_helper.c                  |   4 +-
 target/arm/tcg/op_helper.c                    |   2 +-
 target/arm/tcg/pauth_helper.c                 |   3 +-
 target/arm/tcg/psci.c                         |   4 +-
 target/arm/tcg/sme_helper.c                   |   5 +-
 target/arm/tcg/sve_helper.c                   |   6 +-
 target/arm/tcg/tlb_helper.c                   |   4 +-
 target/arm/tcg/translate-a64.c                |   3 +
 target/arm/tcg/translate-mve.c                |   1 +
 target/arm/tcg/translate-sme.c                |   3 +
 target/arm/tcg/translate-sve.c                |   3 +
 target/arm/tcg/translate.c                    |  25 +-
 target/arm/tcg/vec_helper.c                   | 224 ++----------------
 target/arm/tcg/vec_helper64.c                 | 142 +++++++++++
 target/arm/tcg/vfp_helper.c                   |   4 +-
 target/arm/meson.build                        |   2 +-
 target/arm/tcg/meson.build                    |  21 +-
 44 files changed, 391 insertions(+), 308 deletions(-)
 create mode 100644 target/arm/helper-a64.h
 create mode 100644 target/arm/helper-mve.h
 create mode 100644 target/arm/helper-sme.h
 create mode 100644 target/arm/helper-sve.h
 rename target/arm/tcg/{helper-a64.h => helper-a64-defs.h} (100%)
 rename target/arm/tcg/{helper.h => helper-defs.h} (100%)
 rename target/arm/tcg/{helper-mve.h => helper-mve-defs.h} (100%)
 rename target/arm/tcg/{helper-sme.h => helper-sme-defs.h} (100%)
 rename target/arm/tcg/{helper-sve.h => helper-sve-defs.h} (100%)
 create mode 100644 target/arm/tcg/vec_helper64.c

-- 
2.47.3



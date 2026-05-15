Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE6ECD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtFW-0005JF-Ge; Fri, 15 May 2026 10:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtFQ-0005IP-Bu
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:10:43 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtFN-0003Wc-RQ
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:10:40 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso106321155e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778854235; x=1779459035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HjG9jXk9Y7xF/r7rXvbclYL1C1gwLdDpnd1wum19lhM=;
 b=zv+5ymd5OJ/MhJSeYoIUvL4q7wfpns667zl/Bnw23JK790uu8XCvcKKyeDGPcHZ5xN
 yzJv28akj5KiuWbRBUaibiPZ8Sc0zMCaoGJ1kL/q9NDD5/KDurf4up9ypBkDooJSsgtW
 mXXkl5Y4W2epMah/ic08vFDqLK9Cnrcc836jwxk7PbN2GrJuhG55Zwep5zcgRFpjPTVV
 QRY95K82Aa0rRZU8XO/23H6O+0JTUFochl6wpqS18I90p6TxM0tm0dgeup6B5V03dEBB
 rs/8SxOBKUe7Rzct7oPepzOElEM2F/DwHvx5eBuCeh9HyBgeVdM73iuFRaCwFqpOS+A0
 gkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854235; x=1779459035;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HjG9jXk9Y7xF/r7rXvbclYL1C1gwLdDpnd1wum19lhM=;
 b=YFThg6l1H7mduj3z7E6vu3nu2VLsYQo8tDWkTo2vd7+lZDGufM3ig8GclgjUb16csu
 tXvoZnZJd9zcGye6/H5VkYSic62c+EoBb5+JFbrOjrEmvUm5VCLf+anVfPlIuBYkr3wp
 n4eg8z8ZQzUAXVFlX6xDF3bydQkjvgyeM2xOcTDGI02vXofM03WX0c72P49t5UBeixSh
 lVL9d8d1K7MMzUggI+69odFM5itKgnabVFP4fOaRaPXqaOegpS4RoeBq2I+r+9v6+0h5
 1HNjWb7L8rd/q1qBr71LOGOKAZVux/Po4KeXacLLA3V7m8TwdAEyiDHqbeQPANkrYa8D
 FF8A==
X-Gm-Message-State: AOJu0YxRTy6lR1uyRCOx/hcE1n6D4RWy3Buz8tt38clO3NzeB9wgq6D0
 gperc8MnEHlnMFxJ3htNOldORYNKzaoamxbTYBl+ycwFUs4Jj6kW3viWUPWSziEYxHptp3mF3f7
 nzYPqT7E=
X-Gm-Gg: Acq92OGSahx3ZJn/QFd/CMQIPtpBh7pcoRLq7L3JWmYKbKWPz/NiLIe/6Eq3Fpgau2J
 Bx6dwuZom8O3G/nVA/nh+uGqwvZc80SwUxZRECglBYp4bOEdP2WKEV2QhRUgXak4rAazjPnrDQc
 auuAh79bw8KduA7r9TcGuGVTbC6vIZTdXOYKwBPNaRmU9D9z1a3m2TNpbPcvs0vdfXt0meExl+3
 CTLROIQYiD0UBZag+QJx4M0vwez55+vqIgNdOTC1ajEEeHxfAljSqXPduGe+s5pakxpkcO3cI1p
 5lPXCryJ7t4G+UoUdq0fFOBjTQUTEx9F4tVO0DWMIa+JrDM+xCsLJWtqPbdxbz9jkrUqGQBJvsp
 kiohlFBblV0IsrnaOaJoNzg3jN6F7Q6uVyk5ur4hQe+ME3+TBMgBkgDyBDPMs8FjBQHUArvfuvu
 hLHC+bpw3TUyCoG9wqtu+t1mLZqsa0L7jOG8V20FOX7Pnyf5zUhE2CNlnkegQvJHWnzI6Eu6du
X-Received: by 2002:a05:600c:4692:b0:483:7903:c3b1 with SMTP id
 5b1f17b1804b1-48fe6325978mr60010255e9.20.1778854235339; 
 Fri, 15 May 2026 07:10:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe53804aesm60695385e9.15.2026.05.15.07.10.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 May 2026 07:10:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 00/20] single-binary: Make hw/arm/ common
Date: Fri, 15 May 2026 16:10:11 +0200
Message-ID: <20260515141032.3271-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Since v5:
- Unify 'max' CPU type (rth, pm215)

Since v4:
- Add DEFINE_MACHINE_WITH_INTERFACES (Zoltan)
- Use GPtrArray for get_valid_cpu_type (Richard)
- Define InterfaceInfo[] arrays (Richard)
- Collect R-b tags

Since v3:
- QAPI structure renamed as QemuTargetInfo
- MachineClass::get_valid_cpu_types() runtime
- target_aarch64() checking SysEmuTarget value
- Remove CONFIG_TCG #ifdef'ry in hw/arm/

Since v2:
- More comments from Pierrick addressed
- Use GList to register valid CPUs list
- Remove all TARGET_AARCH64 uses in hw/arm/

Since v1:
- Dropped unrelated / irrelevant patches
- Addressed Pierrick comments
- Added R-b tag
- Only considering machines, not CPUs.

Available here, based on my pending patch queue:
https://gitlab.com/philmd/qemu/-/tags/single-binary-hw-arm-rfc-v5

Philippe Mathieu-Daudé (20):
  hw/arm: Build ARM/HVF GICv3 stub once
  hw/arm/raspi: Initialize 64-bit CPU types during DeviceRealize()
  hw/arm/raspi: Build objects once
  hw/arm/aspeed: Initialize 64-bit CPU types during DeviceRealize()
  hw/arm/aspeed: Build objects once
  hw/arm/meson: Remove now unused arm_ss[] source set
  target/arm: Introduce common system/user meson source set
  target/arm: Build gdbstub64.o as common object
  target/arm: Build cpu64.o as common object
  target/arm: Restrict IDAU interface to TCG namespace
  target/arm: Rename Aarch64-specific methods
  target/arm: Extract common code related to 'max' CPU
  target/arm: Use make_ccsidr(LEGACY) in 32 bit 'max' CPU type
  target/arm: Implement DBGDEVID* registers in max AArch32 CPU
  target/arm: Only set %kvm_target when KVM is enabled
  target/arm: Factor aarch64_aa32_a57_init() out
  target/arm: Re-use common aarch64_aa32_a57_init() helper
  target/arm: Define 'max' CPU type in cpu-max.c
  target/arm: Build cpu32-system.o as common object
  target/arm: Build cpu-max.c once

 include/hw/arm/armv7m.h                    |   2 +-
 include/hw/misc/tz-msc.h                   |   2 +-
 target/arm/internals.h                     |  10 +-
 target/arm/{ => tcg}/idau.h                |   4 +-
 hw/arm/armv7m.c                            |   2 +-
 hw/arm/aspeed_ast27x0.c                    |   7 +-
 hw/arm/bcm2836.c                           |  14 +-
 hw/arm/raspi.c                             |   4 -
 target/arm/cpu-max.c                       | 241 +++++++++++++++++++++
 target/arm/cpu.c                           |  10 +-
 target/arm/cpu32-stubs.c                   |   8 +-
 target/arm/cpu64.c                         |  92 +-------
 target/arm/ptw.c                           |   2 +-
 target/arm/tcg/cpu-v7m.c                   |  11 +
 target/arm/tcg/{cpu32.c => cpu32-system.c} | 191 +---------------
 target/arm/tcg/stubs32.c                   |  10 +
 hw/arm/meson.build                         |  15 +-
 hw/intc/meson.build                        |   2 +-
 target/arm/meson.build                     |  26 ++-
 target/arm/tcg/meson.build                 |  60 ++---
 20 files changed, 349 insertions(+), 364 deletions(-)
 rename target/arm/{ => tcg}/idau.h (97%)
 create mode 100644 target/arm/cpu-max.c
 rename target/arm/tcg/{cpu32.c => cpu32-system.c} (80%)

-- 
2.53.0



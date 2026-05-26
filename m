Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFCDCD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 20:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRyWp-0000XZ-1b; Tue, 26 May 2026 16:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyWm-0000Vi-CI
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:37:28 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyWk-0006lY-Ln
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:37:28 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49050bfe053so13120455e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 13:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779827845; x=1780432645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=exQJQiRJgHjeY8sH5JvI6CVNRRjB24243o2eBjSMOhc=;
 b=amXMUQr8m/ydSJPLTG5Bhx8QyrT7xlbzn28hFzZXJlGYb6aqnL65i1UymyIvhrM5gK
 x4LSSP/ZDMLMeUlhHvSZQvGebd5ap+7tXAeO3vY2sIBI+NAoMz5rL+hr43HnsQqFmRbj
 XQOsHP46RvVWZ/OYhoznEpAem0sxDrHcUepaxnrnCMBTuukEyKjpczAP8Uw5OnaBvfEg
 3Q7fs1Vt2EJWoRsaQLO34SV9BbJFIzwsY1bUGUUfBuhTvcBvvMRKd2+EM0wuADdnFSe4
 gpCrX+BE0m6+ggb3DV2j47b1K39IWJEo+W8zI8t1QFXxEHJNLn68D9PYPUrwv7FRPL5i
 vjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779827845; x=1780432645;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=exQJQiRJgHjeY8sH5JvI6CVNRRjB24243o2eBjSMOhc=;
 b=d+FNwlVaRDYpPeC1iu3Pdb5YoOGleSiARG+VSKBsSI90F3WgugZzjk2eYJpUAR9Nni
 SsaQdl/+Uf/OYf2dMadSPGSIQd+h0C4wP90o9sIcGLFdxeMa+qNyDCubS6fws/Yw8wJs
 1PngSykhFnyD5JCM6HU3H9k3r9as4osT0yGNVvfLIZJ2xyrKWqD8m4D1HNst7okfJBTi
 bkSeG599614c97y8BCxqnYtcghTgqmjvCc2jj2Kic66aF0XyCMoDbaP3kXqYM3+Y1fhy
 W5Gpo7Rbi9w89M7x4/jxmCwXUZNZgOdbgqIzaxvvOuMYCQqXgpLhiQZd9Ixx8VM9dV0O
 AXZg==
X-Gm-Message-State: AOJu0YwFejhdYhU/+1Ds53+79GBRwgLGQiRq5IxCoZXjW0P6qc1PpPzc
 JvswuoPjR6PgjZSY6JmcTbkuHoMJSqF4ttR3N9Cu9ncnk/5J6KIwFtxwEDRpcDUNO0KFvibldG/
 Aw4FCYG6nCw==
X-Gm-Gg: Acq92OEKi8qNvQqlcD9wyiblOocU6Own21rG5crGukRueiSOavRcQogNNj0Sr57xWyY
 AZzzkH0MC5anI1OEJFO15J5wdkgA9M9CMrZDGyTz+mbLZ8VGYm+xBJUvO2x5kCN/qfxCGMq4+On
 646UvCau6sImXb95WslKvthbEGGMWVvLAW3rlPVVBadZk0RL5CrmOpgIj5ilXHvz00L+QoC20UX
 VfNiyNqkVSt3XgI8DpPI+zjSHqGYK7Gvci9nE5CKrYgUlC90fZm0MVgPsODA0gK9OEaZ7giRn1Z
 cVZIA4zsUg0Jo6XgdxKqKsGo8jrKifNbanMSswgvcIOG94T6P18VMfW97VFzBhU75hRapU196qL
 bzWctBy3gc58nl0PxSowMHWrEmbg6njb1f7pu2iUCof+rKK0+PqsNSLwNHqoaNm6SUUKol95xzw
 Bc/rnuoWEs8koc5h98q/tRivELzHnacXq/rCnLpwMydh36KpBr5d8q+XkYwV50iZ+6MQ==
X-Received: by 2002:a05:600d:844f:20b0:48f:e230:d5ab with SMTP id
 5b1f17b1804b1-49042adef3bmr247079085e9.31.1779827844408; 
 Tue, 26 May 2026 13:37:24 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb557545sm884277f8f.12.2026.05.26.13.37.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 May 2026 13:37:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 00/17] single-binary: Make hw/arm/ common
Date: Tue, 26 May 2026 22:37:05 +0200
Message-ID: <20260526203722.79463-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Series fully reviewed.

Since v8:
- Rebased on top of e28b83116af ("Merge tag 'pull-aspeed-20260526')

Since v7:
- Rebased on top of 8d3e31c0d57 (IDAU interface)

Since v6:
- Do not initialize Aspeed CPU in SoC realize (cdrx)

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

Philippe Mathieu-Daudé (17):
  hw/arm/raspi: Initialize 64-bit CPU types during DeviceRealize()
  hw/arm/raspi: Build objects once
  hw/arm/aspeed: Do not realize 64-bit CPU types under QTest
  hw/arm/aspeed: Build objects once
  hw/arm/meson: Remove now unused arm_ss[] source set
  target/arm: Introduce common system/user meson source set
  target/arm: Build gdbstub64.o as common object
  target/arm: Build cpu64.o as common object
  target/arm: Extract common code related to 'max' CPU
  target/arm: Use make_ccsidr(LEGACY) in 32 bit 'max' CPU type
  target/arm: Implement DBGDEVID* registers in max AArch32 CPU
  target/arm: Only set %kvm_target when KVM is enabled
  target/arm: Factor aarch64_aa32_a57_init() out
  target/arm: Re-use common aarch64_aa32_a57_init() helper
  target/arm: Define 'max' CPU type in cpu-max.c
  target/arm: Build cpu32-system.o as common object
  target/arm: Build cpu-max.c once

 target/arm/internals.h                     |   2 +
 hw/arm/aspeed_ast27x0.c                    |  14 ++
 hw/arm/bcm2836.c                           |  14 +-
 hw/arm/raspi.c                             |   4 -
 target/arm/cpu-max.c                       | 241 +++++++++++++++++++++
 target/arm/cpu64.c                         |  80 +------
 target/arm/tcg/{cpu32.c => cpu32-system.c} | 174 +--------------
 target/arm/tcg/stubs32.c                   |  10 +
 hw/arm/meson.build                         |  15 +-
 target/arm/meson.build                     |  26 ++-
 target/arm/tcg/meson.build                 |  57 ++---
 11 files changed, 318 insertions(+), 319 deletions(-)
 create mode 100644 target/arm/cpu-max.c
 rename target/arm/tcg/{cpu32.c => cpu32-system.c} (81%)

-- 
2.53.0



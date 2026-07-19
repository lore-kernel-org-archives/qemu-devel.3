Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469DAC4451B
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 18:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlVrB-0006vA-IJ; Sun, 19 Jul 2026 14:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wlVr9-0006uz-NN
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 14:03:15 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wlVr8-0004h9-4g
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 14:03:15 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2cca0c5799eso69595645ad.0
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2026 11:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784484192; x=1785088992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qmGdjVzTGuAKBQYAYGGuA19c4Gbg1jrBCfz/iMLVnzQ=;
 b=QBU/yAEL84sroACaGqGty86djgDk27CtLU7LzQ8Ip6wClPMDVYCIGHBF5in3Dt8Ucj
 CkBUi0UdVIoSQGOusSvdV16NjDjY4BYbepfYFpeBQ2TPwtqU6K6WkinqiGzPK9J/AYyT
 q+c0yIBHQ0A0rSJE73OPIp4zW8Fx8/gPBCbXsoymdI8NQZjwvIVu25jwtj5CejTR7/Nv
 bky9xYTjq5gRb1XN+aE5MEjts9zZVenbz+3YT4QKfqBg78pjr3IIX7spJvOqVNb3BqWS
 LvUVuJBHitV1YqUlYlEWJ8Rlo4HtLt+vnzdtOGvtCBQ96/gv+3Mj0ZH2uH5hFbjKvg6R
 FZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784484192; x=1785088992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qmGdjVzTGuAKBQYAYGGuA19c4Gbg1jrBCfz/iMLVnzQ=;
 b=lfY0102vTjRXtqTIKfPNRME+GaODEyLR1JTzQNj/f6VKfCXMXKHqdn7+th3VeNNXE5
 V2Dpt84vkN/KZYESaNYAQuXpfaE0ugkqy/MeT2a0DAaDycPstph9g5lVrRPV0enj25O9
 gDajN3epPl8NAg/pEV1kN/0Ej5KwMhf9lm2mNecVcr4nZgQnpGg6uf8miLrrzFdtoLB5
 QK4n3eBH7c/aqYxRDyo5n9AWBFdTRD60Rt6W7pbYCl6V4083bWWBi7tcYNPbk/WfIodn
 zNLfKjKGXNHceyl94wrYc6KRv9R10S3E8nyxPm3FsgYsUpil2Kq21Xp47wSFqO5ZRbJf
 TgLQ==
X-Gm-Message-State: AOJu0YxT1CQwqhRD1bNfDzS4J4i3AxoAFkNoXFVIZtzocLlfZflc7UXt
 wKKJwZQDWATQqyEZcKUptVF8CQpfDUfuIYiLGVf/rYoudBZLA10sBfO/ysC3hw==
X-Gm-Gg: AfdE7cnne9L41RTatn+0feQ9fIhrjmEqM8ZD26YeV+3Iw9SWwU0xJUFOtO23V2tVBtq
 r4AXaaKgFS0EqaZjlGYPIq6ljQY/1r8aw1yfZtAbTPuszFVfagDCeCbMwnWIeiXoOTpP2E2Z5pb
 e/20hQUxj7Ruv9Ao6edUUK7r4gQqFR2PjKcxQeTu5YzZhkpU/o+5FJD779ehwdztScvHpgij3GQ
 b5+SYkaNEbGJ3/RQ4IeeIsLCaGKxf0vH90BxkuzinDssmY5NOeMEHR6askwR9VvjcisyIT89hCE
 is0rHhHMoRnG8Sm7eZe1y2z2Mo721zkOVEix+kQ6oOJb0YhvzJRKjHZRaYw/ovai7O6BJyp1Jst
 lHivxbiR69dST1Vo8cqH0TvW/7zrzvgKMlHSVweL6O533XYyvL7qjbx1bchUgouCCxoTw8P1YDY
 FsY8ozsWN1Of02Pw==
X-Received: by 2002:a05:6a21:3981:b0:3c0:adec:b3bd with SMTP id
 adf61e73a8af0-3c3ad9646afmr12160997637.49.1784484191900; 
 Sun, 19 Jul 2026 11:03:11 -0700 (PDT)
Received: from localhost.localdomain ([82.40.42.115])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cb519de3437sm3312907a12.28.2026.07.19.11.03.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 19 Jul 2026 11:03:09 -0700 (PDT)
From: Jack Wang <163wangjack@gmail.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Jack Wang <163wangjack@gmail.com>
Subject: [PATCH v2 0/2] hw/riscv/k230: add the K230 Reset Management Unit
Date: Mon, 20 Jul 2026 02:02:45 +0800
Message-ID: <20260719180247.8660-1-163wangjack@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709031237.21284-1-163wangjack@gmail.com>
 <20260717101101.1288002-1-caojunze424@gmail.com>
 <8b4f4583-63b0-4d0f-b349-a0177ff19318@oss.qualcomm.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=163wangjack@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

References: <20260709031237.21284-1-163wangjack@gmail.com>

This v2 patch reply on review of 
This series models the Kendryte K230 Reset Management Unit (RMU), a bank of
reset-control registers at 0x91101000, and wires it into the K230 SoC. It
replaces the create_unimplemented_device("rmu") stub so guest reset drivers
(drivers/reset/reset-k230.c) work against a real model.

Patch 1 adds the standalone device model; patch 2 wires it into the SoC and
adds the qtest. The qtest is deliberately placed in patch 2 accorinding to 
suggestion from Daniel: it drives "-machine k230", which only
exists once the device is wired up.

Register semantics, reset values and reserved-bit masks are taken from the
K230 TRM chapter 2.1 "Reset" (V0.3.1) and cross-checked against the mainline
Linux driver.

Changes since v1:
 - Switched to the Resettable API (phases.hold instead of the legacy
   device_class_set_legacy_reset()), per Daniel's review.
 - Model real reset propagation: the RMU now cold-resets the two linked
   watchdogs via "wdt0"/"wdt1" QOM links when their PERI0 reset bits are
   written (Cao review).
 - CPU1 reset request is now a two-step assert/deassert (not self-clearing),
   matching the hardware (Cao review ).
 - Filled in the documented per-register reset values and reserved-bit
   (writable) masks from the TRM; the *_rst_done status bits reset to 0, so
   they follow the per-bit "Reset" column rather than the summarised total.
 - Added the reset-time-control (*_RST_TIM) registers as plain storage with
   their documented reset values.
 - Fixed the storage mask so the upper half of non-write-enable registers is
   writable (surfaced by the new TIM registers).
 - New qtests: reset values, TIM storage, reserved-bit read-only, CPU1
   two-step, and real watchdog reset propagation.
 - Moved the qtest from patch 1 to patch 2 for bisectability; added the
   MAINTAINERS entries.

Jack Wang (2):
  hw/misc/k230_rmu: add Kendryte K230 Reset Management Unit model
  hw/riscv/k230: wire up the RMU device

 MAINTAINERS                 |   3 +
 docs/system/riscv/k230.rst  |   1 +
 hw/misc/Kconfig             |   3 +
 hw/misc/k230_rmu.c          | 425 ++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build         |   1 +
 hw/misc/trace-events        |   7 +
 hw/riscv/Kconfig            |   1 +
 hw/riscv/k230.c             |  15 +-
 include/hw/misc/k230_rmu.h  | 126 +++++++++++
 include/hw/riscv/k230.h     |   2 +
 tests/qtest/k230-rmu-test.c | 225 +++++++++++++++++++
 tests/qtest/meson.build     |   3 +-
 12 files changed, 808 insertions(+), 4 deletions(-)
 create mode 100644 hw/misc/k230_rmu.c
 create mode 100644 include/hw/misc/k230_rmu.h
 create mode 100644 tests/qtest/k230-rmu-test.c

-- 
2.53.0



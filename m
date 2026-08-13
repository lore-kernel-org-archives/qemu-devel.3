Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77515C5CFEB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuVwb-0002wX-Gl; Thu, 13 Aug 2026 09:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wuVwY-0002wG-En
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 09:58:02 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wuVwW-000202-Av
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 09:58:02 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2cfbbdfa60bso20766415ad.3
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 06:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786629479; x=1787234279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ortSojCF4MD4GaSWJ2LixTOkSzJRkp5zenv//2r71a0=;
 b=MqkVZNEaEHlsx1E8jWJCc7yKCjy9Ybmoha2FHrzluJsomDBzv6vf1ldQnJ+1/G/oh0
 BKFDo4J5+I85kDvtKLDm2D75/AEYfUDPsooTNpxfFxJzl+qNzF3hOKxeTyiqqtebrgWO
 1z3XOHVCl3/4jVaDq5X3kZQWH1ktLNo6R4ym72asCC+7Fvbot6L3Wx6/rPBmMiQz/y0g
 Qfr+qAsfuT2wCZPO26fFUMHqurfJ/hJeFXTXHHPo0vRhREayiFg9LJdJieUThPutI26F
 OlbFWU+jU2vVZ5TBUn9Sp+HrqcacAjCN3cNn0r8JztwUw1NdZKdlDLLbbJ50dEIVbbW2
 QW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786629479; x=1787234279;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ortSojCF4MD4GaSWJ2LixTOkSzJRkp5zenv//2r71a0=;
 b=OIM60m94HMbpFk3SjSZ0eey+XxvPSVnoVbXcV36Uhkx9A1XdM98i3+wO7EHJ46JZGy
 BYat2rdVSBjp+xHXr+y7ZqbP7SRuoSGAGgNA2p/FlD4rXr+kriE5mVOVQbPF46nrSUPy
 L54ud0HeObcisjMKvDNTrc7NRm4144vxpWphRKqZCK7zlNxYxtZDhxq9JKUkOlr6RyFn
 VWhyDmPpRovUpoBzeMVhm8YmbNO+2UTlHfwvDa6CTBLX0rrnG4h5tAWbU2hiepFXL5qj
 RwmEhgqUTF/JkLLxG+RYY39H2rRpDiPsT4nGdf5SGv3/gpZ4UStsEaeN7wwicveiAJrQ
 /7UQ==
X-Gm-Message-State: AOJu0YyEKGUIi5psuVVRZAgpqOMHEqD9r7aAEO5HwK0c05itkbgsDAnm
 4y+3r9EH+aZfW7rc4g4IqIyb6DmjcNbv9QdlLV+XDYQhS9KzMRPmCQ86GAGopoCGVQo=
X-Gm-Gg: AR+sD10t06mH+YOhn+nEKrogB9KOuck0Ibz4vP/29bC1m9w7iUeTM9uZdAjQK7oBCGk
 d8yVJEsKTuNDR0EWABPueeXfFxrs1PalltgYi2lb0unwsUcUoe2xB1hZ81QzOMvbsEj/JuetK2a
 TORuTkdATS77brlmkEkLbdWcOj9IKKdmnYS2R91iwdO7BfAE1w9VG9GlJGGEtQfw/YbTQLwsaEt
 xlJwf8342QLBSEFTNHaLWXi7UCtKFV/Cw5pCUI/zpOAKsOzKdxsls7lrt9qzWHPS0PGZ0Ra3Xsn
 0ldT+g4K8cBB33TZSWxKQnzXI7/OD6m4YaQwi3w4tRn26bbUgp3sJsD4XuJjSgJzRCnW0EeBK7l
 +1UO+TCJY4XYjhGMQCfkXg2Y2FnYrfhIdYskG754AFOGonW2Zcue+giTbyxbKAhf77MQmxRfPGq
 tW6o15bGeRd1JklIDIzJ5MUJIwbO1aUJL0hPCfZO8o0KpjN0HY1wMR1M8Hx2mqazEMyX6RF5f1h
 g3KSORrcg==
X-Received: by 2002:a17:903:2987:b0:2c9:e846:a57e with SMTP id
 d9443c01a7336-2d37d1c4a58mr73337325ad.0.1786629478749; 
 Thu, 13 Aug 2026 06:57:58 -0700 (PDT)
Received: from localhost.localdomain ([111.198.227.173])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d37c486531sm10024395ad.57.2026.08.13.06.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 06:57:58 -0700 (PDT)
From: Kangjie Huang <flamboyant.h.01@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Junze Cao <caojunze424@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Kangjie Huang <flamboyant.h.01@gmail.com>
Subject: [PATCH v3 0/3] hw/riscv/k230: add IOMUX register block model
Date: Thu, 13 Aug 2026 21:57:14 +0800
Message-ID: <20260813135717.2758-1-flamboyant.h.01@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add a SysBus model for the 64 K230 Function IO configuration registers
documented by the K230 Technical Reference Manual. The model retains the
writable configuration fields needed by the SDK U-Boot and Linux
read-modify-write paths.

The series adds the device model, wires it into the K230 SoC at
0x91105000, and adds qtest coverage.

Changes in v3:
- Migrated the model from the deprecated device_class_set_legacy_reset()
  to the Resettable interface.
- Added a comment to the model stating that bit 31 (DI) is read-only and
  reads as zero, since the model does not simulate external pin input
  (TRM V0.3.1, section 12.9.2.2).
- Added MAINTAINERS entries for the model and the qtest.
- Defined an independent K230_IOMUX_EXPECTED_WRITABLE_MASK (0x00003fff)
  in the test instead of reusing the implementation mask, with a comment
  explaining the bit layout.

Changes in v2:
- Split the device model, SoC wiring, and qtest coverage into separate
  patches.
- Removed redundant MMIO bounds, access-size, and alignment checks.
- Limited register storage to the 64 documented Function IO registers.
- Applied the documented 0x00003fff writable mask.
- Treated offsets 0x100 through 0x7ff as reserved.
- Added tests for write masking, read-modify-write accesses, IO63,
  reserved offsets, and system reset.

Tested with:
- qtest-riscv64/k230-iomux-test
- U-Boot and Linux boot tests with no unimplemented-device warnings
  for the IOMUX region

Thanks to Alistair Francis and Chao Liu for the v1 review comments that
shaped the v2 series structure and the register semantics.

Reviewed-by: Junze Cao <caojunze424@gmail.com>

v2:
https://lore.kernel.org/qemu-devel/cover.1784022244.git.flamboyant.h.01@gmail.com/

v1:
https://lore.kernel.org/qemu-devel/20260710041845.67170-1-flamboyant.h.01@gmail.com/

Kangjie Huang (3):
  hw/misc/k230_iomux: add Kendryte K230 IOMUX model
  hw/riscv/k230: wire up the IOMUX device
  tests/qtest: add test for K230 IOMUX

 MAINTAINERS                   |   3 +
 docs/system/riscv/k230.rst    |   1 +
 hw/misc/Kconfig               |   3 +
 hw/misc/k230_iomux.c          | 125 ++++++++++++++++++++++++++
 hw/misc/meson.build           |   1 +
 hw/misc/trace-events          |   4 +
 hw/riscv/Kconfig              |   1 +
 hw/riscv/k230.c               |  11 ++-
 include/hw/misc/k230_iomux.h  |  43 +++++++++
 include/hw/riscv/k230.h       |   2 +
 tests/qtest/k230-iomux-test.c | 160 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build       |   5 +-
 12 files changed, 355 insertions(+), 4 deletions(-)
 create mode 100644 hw/misc/k230_iomux.c
 create mode 100644 include/hw/misc/k230_iomux.h
 create mode 100644 tests/qtest/k230-iomux-test.c


base-commit: d49f87606ac1a6e15701b26c1b16c5d7e948ffcb
-- 
2.43.0


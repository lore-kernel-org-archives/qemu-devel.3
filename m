Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD16C636C5
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 23:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuIWf-0001Qh-T1; Sun, 22 Feb 2026 18:06:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIWe-0001Pk-1H
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:06:08 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIWc-0005v7-7u
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:06:07 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4375d4fb4d4so2336535f8f.0
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 15:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771801564; x=1772406364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=CilXNfPct5/Yscu/2lF9wsbUq8NIRMavj9fub+QMthk=;
 b=Re91SVvKpSFJWAUUr2qrfJwIbZ/UjXnDTOHFvBxuuXMGpdRDfUAcY7IboxIZfo9Mf0
 yO8rZIa4tqPvLpOe9THSYhW9B8FIF0fmsWwlsKnQbpTCz2QANccqkKdxeGLbbkcl/6UQ
 KhfQReopnSFezhrYoVPl0Osw72VbmRlXVaLwPEjbdB9lZEK4yc3MzDE4WIrPd0iwf1a3
 /NbfaHelGXFFwh3Aysilfd50g6ft/GaS4GZSzaFXnIUBx7RBdcUhvWLuLQ9/kHLvdg5a
 RwQY763QaU5SyQNqOmcIPepbZ5dLojKIqavjsw6xAhmwh4mri0+/yx2tmTQHhO/ZQHZp
 KThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771801564; x=1772406364;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CilXNfPct5/Yscu/2lF9wsbUq8NIRMavj9fub+QMthk=;
 b=ZNOdZBJ4gfT3sbN6NFe7Ol2pET6JMAxQFN3Yh/AtIhw9lC+MwoB1EqWdI/eg/jDwUs
 bHPtBNtwjCztOnuUQGGjBWGu2JWPNbOgEYG/fV4S2CjhNyogtEmbY3KiHCow+r4+QxS2
 4P+NfCpEZOKL2gxCHkb0fusnPWCS7gj/qgjSrGwX38KbbRgmi8sugyFYbAdHLANox0oH
 fn+GBoAgrtOAGfP0/5kCikxi2SGg2SwXU2JrR3Fpo3wWc2YkR0mqWoOSIhFTgy9mTCWx
 /Le6Ddo742luc+CjM/ejVq3gB6CmlQ6j1LOaVdroS8amA/ZyS6180UxQmUxOjLHgtcfR
 Dr7Q==
X-Gm-Message-State: AOJu0YwvQQw9Db2lgYd2v0MEALiu7v11FhHWvRYg64nh+vUutr+CJGZR
 E39z7rZGvc6C+6E2KrREJxM4C6VgVCBX3fSRGxSjAm/Bg9aLwwrMQQ80B10EgWG0q51sYO3rlyR
 Y5b4UT1Q=
X-Gm-Gg: AZuq6aI+5CQOw74I21aTkR/95NMw79hhJYTwe2vaOhL5VXnF71ZCJ+3FtjxqLdUKaND
 MerahN84wZ6W9ZgEcXqOLHQ/H720+OJXBb9mPFfQOUeVu+iazcXTHPpiLw4blQalXXthoSs2l3z
 NtdGs6lBWc9jRb+VSUSrapKcDsH1yfzn/4wuVC9c2Ry7n02i6y2IDsM8V4GXiqoIHYgGxs2QRIW
 LlRTH06HoHflp5YWvZdxXC92wRptY4NvQT+yk///IJJ9bB7CJBQmMQOeB60t3VVdYrVmsMIpz18
 sqjZAPtVdKB56hM7xPsQr3EsHBbF5ZcJLM2h/0EMDRfARRU/qW5iCN+Ti1Ian5wnYYPHAwN4ZsC
 cr5nmU7LpjaicTpVrLyp+HeUFYNgFGLIBPuCuThLgIMEWn3AQ8d04PU0hrUE7HGIef7bR8UnBe/
 47pPjbu3UFaOop7zAM08nH3OUI3Y1UmZFyVAXfYMbI+E9W9XGxHaLgCQmtLTo4wqWcOeBOawDh
X-Received: by 2002:adf:f3d1:0:b0:439:7e1c:87b0 with SMTP id
 ffacd0b85a97d-4397e1c8bafmr184328f8f.37.1771801563676; 
 Sun, 22 Feb 2026 15:06:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d4c626sm16426222f8f.28.2026.02.22.15.06.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Feb 2026 15:06:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/20] Misc HW patches for 2026-02-22
Date: Mon, 23 Feb 2026 00:05:41 +0100
Message-ID: <20260222230602.5756-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

The following changes since commit 07f97d5da04a9f97e273de85c76f5017d8135a6e:

  Merge tag 'pull-target-arm-20260219' of https://gitlab.com/pm215/qemu into staging (2026-02-19 10:36:06 +0000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20260222

for you to fetch changes up to ab39a5a46a411d7171192cf911d5e9465bd2e6b1:

  net: mark struct tcp_header as QEMU_PACKED (2026-02-22 23:08:19 +0100)

----------------------------------------------------------------
Misc HW & Net patches

- Fix trace event name in m68k system controller
- Constify and rename virtio_is_big_endian()
- Set graphic display dimensions generically (removing system/globals-target.c)
- Mark eth_header, udp_header, tcp_header as packed structures
- Minor doc / header cleanups
----------------------------------------------------------------

Alex Bennée (2):
  hw/alpha: remove unused includes
  hw/core/cpu: expand cpu_reset function docs

BALATON Zoltan (1):
  hw/net/rtl8139: Remove ineffective parameter

Kuan-Wei Chiu (1):
  hw/misc/virt_ctrl: Fix incorrect trace event in read operation

Peter Maydell (5):
  hw/net/rocker: Don't keep pointer to h_proto as uint16_t* in
    OfDpaFlowPktFields
  hw/net/rocker: Don't assume h_proto is aligned in eth_strip_vlan_ex()
  net: mark struct eth_header as QEMU_PACKED
  net: mark struct udp_header as QEMU_PACKED
  net: mark struct tcp_header as QEMU_PACKED

Philippe Mathieu-Daudé (9):
  hw/virtio: Constify virtio_is_big_endian() argument
  hw/display/macfb: Constify macfb_sense_table[] array
  hw/display/macfb: Constify macfb_mode_table[] array
  hw/m68k/q800: Use MacFbMode fields in q800_machine_init()
  hw/m68k/q800: Set MACFB_DISPLAY_APPLE_21_COLOR within MacFrameBuffer
  hw/m68k: Set graphic display dimensions generically
  hw/sparc: Set graphic display dimensions generically
  hw/ppc: Set graphic display dimensions generically
  system/globals: Build as common code

Pierrick Bouvier (2):
  hw/virtio: rename virtio_is_big_endian to virtio_vdev_is_big_endian
  hw/ppc/spapr: extract SPAPR_MAX_RAM_SLOTS in a new header

 include/hw/core/cpu.h             |  3 +++
 include/hw/display/macfb.h        |  2 +-
 include/hw/ppc/ppc.h              |  2 ++
 include/hw/ppc/spapr.h            |  8 +-------
 include/hw/ppc/spapr_common.h     | 17 +++++++++++++++++
 include/hw/virtio/virtio-access.h |  2 +-
 include/hw/virtio/virtio.h        |  2 +-
 include/net/eth.h                 |  6 +++---
 hw/alpha/dp264.c                  |  2 --
 hw/display/macfb.c                | 18 +++++++++++-------
 hw/m68k/q800.c                    | 17 ++++++-----------
 hw/misc/virt_ctrl.c               |  2 +-
 hw/net/rocker/rocker_of_dpa.c     | 19 ++++++++++++-------
 hw/net/rtl8139.c                  | 24 ++++++++----------------
 hw/net/virtio-net.c               |  4 ++--
 hw/ppc/mac_newworld.c             | 10 ++++++----
 hw/ppc/mac_oldworld.c             | 10 ++++++----
 hw/ppc/ppc.c                      |  8 ++++++++
 hw/ppc/prep.c                     |  4 ++++
 hw/ppc/spapr.c                    |  4 ++++
 hw/sparc/sun4m.c                  |  9 +++++++++
 hw/sparc64/sun4u.c                | 10 ++++++++++
 hw/virtio/vhost.c                 |  4 ++--
 hw/virtio/virtio-pci.c            |  8 ++++----
 net/eth.c                         |  6 +++---
 system/globals-target.c           | 24 ------------------------
 system/globals.c                  |  3 +++
 system/meson.build                |  1 -
 28 files changed, 128 insertions(+), 101 deletions(-)
 create mode 100644 include/hw/ppc/spapr_common.h
 delete mode 100644 system/globals-target.c

-- 
2.52.0



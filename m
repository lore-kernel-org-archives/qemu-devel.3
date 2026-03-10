Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E466BEB1049
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzubK-0007Ll-Sb; Tue, 10 Mar 2026 06:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1vzubJ-0007Kh-3y
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:46:09 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.wainwright@lowrisc.org>)
 id 1vzubH-0005r8-8g
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:46:08 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-439d8df7620so2776926f8f.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lowrisc.org; s=google; t=1773139565; x=1773744365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YdkZiwfVySks8Rpj4htrXSfL5hZEvQhJ0yl/SD/CGn4=;
 b=RQKxwfDyPFpwYyxtC2Xa9m0usxKkWFcNoSrLlQPUo9VBd+QcsizocLBSTh/XTd9ISR
 k3yvuWxJ/b5AmFtcw8nxW6DrW/z5VRUu22u09VKbYRXn+djfjzuvjvLYx+CiYJ2tRXDD
 Q/f2zQh/P4Ak7VEE4Uf24zRDy/HiNS8rKXp3XN8Ol6UdglftO8g6akoOpOqergRuLO8w
 t1aSsML73JPZCET1zyaoeB/ZBf5CwxuzLpowAxbTFvHJerS1EXUX+vUqO3IXFAq3bm9r
 NfzOW5+AHJovXECWEQMkgF2fOcuuG385L0yryLG1a3Q+VlBgMr29A9mrH5ptIMt5W1I7
 nolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773139565; x=1773744365;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YdkZiwfVySks8Rpj4htrXSfL5hZEvQhJ0yl/SD/CGn4=;
 b=cmBGW90XxbrF32oT54FaYbxxuFOqoITkCbyc7TCASAOx9xrV9M+yZXcXINx4ZONuVf
 hqWXB+kUNbwaeS2ZoMitPwEmx8oj32+MOTh/mI5THOaX6FcF2A5WHwd/mhxtb30UUXcq
 Ne8Cu3fYOD0vbFqeIu6jMu5KCN8LZjdc83qwpW5QT/08ZfO8ce3iiEDtrSFpMs6oQtCR
 cO1FcoVYHK1hWq1/3RxOdCYyA8GmSMqdX65TmqS8HB93XdkAOpVNi2dxxg+pEnyNmAN2
 lRjDf+rQ+BD7k6hvXH6jgQvfpxx/r9IE+y0zsKHbaqHrzbm1OgOfFSfu5HncWAkUjQkh
 omIA==
X-Gm-Message-State: AOJu0YzQ99m0VOjrYfRIZ7NbefJvMPuwBGhM+4/2pUgJh8d3zpVPPaF7
 BD8eWBs9CXfsPgn9gJtNjvMxD2ccaS9XbdKjwD5M20Qo39+a+KYBANbV30Ob5gP2WSY=
X-Gm-Gg: ATEYQzwJrJAppT6CTu1aaTfjLTGDtkugKF/lOKZo5+S/4Ci+w+sx6WYchHp+XW8cNMG
 itvBTFC9mopLxmIbTzK9yra0NhOrDXbczdwRdYpR0ihZuLbtTfIgcf+ltuogv6L98G0w8u4mlbR
 2MhHFRDFO373Am8h2bUC0A2HsTKKqpXuTubt2kY/r5inhDTdOX4WQiaPGE32nPEogOqqrbZaBV7
 xkwwRHVL4ZQSq4NPT0H9jm3Tmis4DBmF6dovZhhJkIvBSnifS7KXL7uJmpsi4Zkmjgcpdud5lw4
 3yiJomrt6izFbKClbAhWMjEuT7s7CQ2VRpk2zhX6wzWO0XEAuWTfOszXuo+oNxB7ejGum7o27Ux
 rEj2sU2PJQ8Qx9mhg8+HJYEz44JIrdc+m0sQOQNTnaXR1mJbJElRaCsldWr89B9B++Ahx19e9jI
 H9LqiwfSQGf1YZWncK/zJZe9/4QTMXdchCYS60O3Lh5MgD0YCLKnop4x+E4qLJnxfd+NAp+Vr4m
 7IIVH1eFqP9f9MQqbhP
X-Received: by 2002:a05:6000:24c6:b0:439:c6d0:b0e1 with SMTP id
 ffacd0b85a97d-439da66b5a4mr24776179f8f.26.1773139565192; 
 Tue, 10 Mar 2026 03:46:05 -0700 (PDT)
Received: from jw-ThinkPad-T14-Gen-3.home (128.70.159.143.dyn.plus.net.
 [143.159.70.128]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dadb29fdsm34838715f8f.16.2026.03.10.03.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 03:46:04 -0700 (PDT)
From: James Wainwright <james.wainwright@lowrisc.org>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com,
 James Wainwright <james.wainwright@lowrisc.org>
Subject: [PATCH v2 0/3] target/riscv: add unratified RISC-V Zbr0p93 ext
Date: Tue, 10 Mar 2026 10:45:55 +0000
Message-ID: <20260310104558.52838-1-james.wainwright@lowrisc.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=james.wainwright@lowrisc.org; helo=mail-wr1-x432.google.com
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

Reorganised as a vendor extension for Ibex and renamed to xbr0p93.

James Wainwright (3):
  util: export CRC32[C] lookup tables
  target/riscv: add draft RISC-V Zbr ext as xbr0p93
  disas: diassemble RISC-V Zbr0p93 instructions

 MAINTAINERS                                 |  2 +-
 disas/meson.build                           |  3 +-
 disas/riscv-xbr0p93.c                       | 79 +++++++++++++++++++
 disas/riscv-xbr0p93.h                       | 19 +++++
 disas/riscv.c                               |  4 +
 include/qemu/crc32.h                        | 18 +++++
 include/qemu/crc32c.h                       |  1 +
 target/riscv/bitmanip_helper.c              | 20 +++++
 target/riscv/cpu.c                          |  4 +-
 target/riscv/cpu_cfg.h                      |  1 +
 target/riscv/cpu_cfg_fields.h.inc           |  1 +
 target/riscv/helper.h                       |  2 +
 target/riscv/insn_trans/trans_xbr0p93.c.inc | 55 +++++++++++++
 target/riscv/meson.build                    |  1 +
 target/riscv/translate.c                    |  3 +
 target/riscv/xbr0p93.decode                 | 42 ++++++++++
 tests/tcg/riscv64/Makefile.softmmu-target   |  5 ++
 tests/tcg/riscv64/test-crc32.S              | 64 ++++++++++++++++
 util/crc32.c                                | 85 +++++++++++++++++++++
 util/crc32c.c                               |  4 +-
 util/meson.build                            |  1 +
 21 files changed, 409 insertions(+), 5 deletions(-)
 create mode 100644 disas/riscv-xbr0p93.c
 create mode 100644 disas/riscv-xbr0p93.h
 create mode 100644 include/qemu/crc32.h
 create mode 100644 target/riscv/insn_trans/trans_xbr0p93.c.inc
 create mode 100644 target/riscv/xbr0p93.decode
 create mode 100644 tests/tcg/riscv64/test-crc32.S
 create mode 100644 util/crc32.c

-- 
2.48.1



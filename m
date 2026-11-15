Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D81F606A32D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 00:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N8Xamdtx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSOQ6-00085u-2Z; Sat, 14 Nov 2026 19:48:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xSOQ3-00084b-7v
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 19:48:31 -0500
Received: from mail-dy1-x132e.google.com ([2607:f8b0:4864:20::132e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xSOQ1-000161-EA
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 19:48:30 -0500
Received: by mail-dy1-x132e.google.com with SMTP id
 5a478bee46e88-3791619605cso4573915eec.0
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 16:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794703707; x=1795308507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0tpo0MmoMi8opzocZq6QhnGA6dO6JJ4kylgr9lJLAFY=;
 b=N8XamdtxoueJpKq4e4f5qO0sDQJdAk4cE4mJRP94kUsf+Ug8hnQH6gi+3nZAbm6V6s
 SkCqXZe8/TpbCS4SYE0DwjteAIR+6caMgpm+aStRgz+IqLc3uDhG0+BB+N/KPhsVChCd
 4hZrJP2B3Hg0hkTjBSiB3zJ+URA5CWGEpUyulmLdULgPnR3tqi2WhMaQUBFOmPrS4F3I
 cU4n0s7c64Juxz8ONhsR0It0f71YaDI4QT9QgzxJoMDLUy1C5CGneTjQiJmnvvnK8c5f
 PkMPPeBdRDHtG6I0ZKuYKv3JoOWpveELe+FLolLKvX4LLqWv/sUr2WCrZzB3/inop4Iw
 F5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794703707; x=1795308507;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0tpo0MmoMi8opzocZq6QhnGA6dO6JJ4kylgr9lJLAFY=;
 b=HzS/KOeBV0R5wmT895RaUG7jN1Ties8E8dM4yoo7MQfw0NvNVCb9BYszl+kmZ/BH3K
 UuGb+KedBEGqTVKLH7cOTt7wosBbJsU6Hxw44PPhc+n3mnOFbzaILst3jbSTk2l5FTbE
 lmLnYbI1hESImJExuLzib+Vq6KzKlpVKEkphh7wezs5bysPr12H/p9cbBqYx5cIaX96N
 ETcv995f1ccHFtVg6poh5OHWB8GebpdXDla9d+z1X+bxeB/r6oqO3q6AqegswUFoi0Bh
 YTIs+6hLx5GABspR9MjibAXKX6iECdO4ifAXIWZigyqwKmGUsXNgsEU3MlFv1jwjJ5i4
 BJ1g==
X-Gm-Message-State: APuU4Z+0cbKFvvkDLbdY0ddWbuL9e4voEMnFzJ8uDtmftlROHWXUas55
 JvTPR3wN32BOaTTY/O+zAVUTDb68icayU/Q0CPonvllvhzetxzcNJVYEEvGVYA==
X-Gm-Gg: AYBFou2ovIHGBqeWjETR7QsPTX/1QVLETW1D6Ru1dinhH7XQQNy9wMVNpwcS+ofJA6M
 lFRPoIf/hkonj9JffImoKP9DdGAmGQrIqe9PEEilRLLxMJoJZKCTgC72RWhpjll+llglcQOy05i
 5EQytO7ypW8OTBtCVsLMJsSf2VvcHuvoozVnM7zlFghT/cMXvDW7XZNrxN1ZmINnyflU+I03pIn
 CEJyGJSdTwu50cdDaTWvHfNcqpV5gVpwcTNXVCSaBpZK5oJLl1iTLZdFhrO5NBDDuYy+HCPIVMr
 6tTOAcfqFzPliBA27qQ0EfEnjwoywAIZFZRtZ55/Kof4hU2G37JbUxj2f8/nq0ez7XFctU3p1t1
 YRKuJ0IAMCeXtlqR87bTn8or/KRwslzv/ZPeIbid9gaK0QDtB5aAyuA4K36kTtr0qy7RAKgdIWl
 gxkfydZVL1e6OAZt0r05/fs55l/YuINcN0x8HVVdpNXnk2+WYHmHMdeXLGHOaKlfBC42n6qTKCk
 OT/SuSrKkkc3qhKq2135LxNf+bHsdzpF2admhNwLTz8KcJ3AdLRdlG8hGk4sukngklH+3sQ4I/n
 WC9y5DbR5uWeWPD42BTcvwnjl/xA3c4lvNv8/8ceNpi6ugE=
X-Received: by 2002:a05:7301:fc09:b0:36e:b3e6:ebe7 with SMTP id
 5a478bee46e88-37966a58499mr6105028eec.26.1794703707320; 
 Sat, 14 Nov 2026 16:48:27 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379553316f2sm21102926eec.9.2026.11.14.16.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 16:48:26 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 0/8] riscv-to-apply queue
Date: Sun, 15 Nov 2026 10:48:11 +1000
Message-ID: <20261115004819.2586336-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132e;
 envelope-from=alistair23@gmail.com; helo=mail-dy1-x132e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alistair Francis <alistair.francis@wdc.com>

The following changes since commit e9fa1f66f0d47c74b6766e1b8b87ad7c2a9394d5:

  Merge tag 'pull-nbd-2026-11-10-v2' of https://gitlab.com/ebblake/qemu into staging (2026-11-13 08:44:16 -0700)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20261115

for you to fetch changes up to 57bae3bdbf69777c8bf32f50a85c36283bbeb673:

  target/riscv/tcg: clear itrigger_enabled during trigger_reset_hold() (2026-11-15 10:41:59 +1000)

----------------------------------------------------------------
RISC-V PR for 11.2

* Fix minimal RISC-V system builds
* Check RISC-V APLIC config value bounds in realize
* Fix Server Platform Reference mtimer frequency
* Clear itrigger_enabled during trigger_reset_hold

----------------------------------------------------------------
Daniel Henrique Barboza (1):
      target/riscv/tcg: clear itrigger_enabled during trigger_reset_hold()

Peter Maydell (1):
      hw/intc/riscv_aplic: Check config value bounds in realize

Sunil V L (1):
      hw/riscv/server_platform_ref: Fix mtimer frequency

Tan Chi (5):
      hw/riscv: Build AIA glue only with APLIC and IMSIC
      hw/riscv: Build device-common only for its users
      hw/riscv: Move platform bus FDT creation to machine code
      hw/riscv: Pass socket topology to KVM AIA
      hw/riscv: Select SSI for IBEX

 hw/riscv/aia.h                 | 17 ++++++++++++++++-
 include/hw/riscv/fdt-common.h  |  3 +--
 target/riscv/kvm/kvm_riscv.h   |  5 ++++-
 hw/intc/riscv_aplic.c          | 32 ++++++++++++++++++++++++++------
 hw/riscv/aia.c                 | 11 -----------
 hw/riscv/fdt-common.c          | 13 ++-----------
 hw/riscv/server_platform_ref.c | 11 ++++++++---
 hw/riscv/virt.c                | 21 ++++++++++++++++++---
 target/riscv/kvm/kvm-cpu.c     | 10 +++++-----
 target/riscv/kvm/kvm-stub.c    |  3 ++-
 target/riscv/tcg/debug.c       |  1 +
 hw/riscv/Kconfig               |  6 ++++++
 hw/riscv/meson.build           |  5 +++--
 13 files changed, 92 insertions(+), 46 deletions(-)


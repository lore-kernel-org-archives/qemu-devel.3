Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58434606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qn0mjt0S
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLafh-0001pT-2Y; Tue, 27 Oct 2026 02:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLaff-0001pG-Do
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:28:31 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLafd-00088E-C9
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:28:31 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-cd67cc518a6so2477567a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082507; x=1793687307; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=btPVLTYwqmiAHl7pgaKpWYzOo+CElfVrN9ywyayJ0+Q=;
 b=qn0mjt0S9nxIeLC0spVB4NPnJM5sDgtJfnKeQSiqXKm90uULVp6EsEna758aAgm/c1
 miijs/L7hPvEuilr6lT5dCFYAVCQF1yrOoabVd2DySf1l9KmXIOkUvhwFSj94KeIBWaL
 162tFPN8jN3+U/m0acqP9N2yyjy2f9Pu4BNhC8OeeyFMxUNpVzrAGFH5PMR2bhEzQ3AU
 ljkg5C33J7D5UiEjohhhYk9K9NcSuLQq0okG1HEoKH6z11lFfL5UihCHCwrsNPw5brNr
 CnLWCfcABzu6PwcESp8uO4SrpvJqzNrtqAV+/t2f56Fsr9mg4TrOkZnsVa5dfRZQnnG1
 3pCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082507; x=1793687307;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=btPVLTYwqmiAHl7pgaKpWYzOo+CElfVrN9ywyayJ0+Q=;
 b=kJODIjvib9as5BvoPfDMyERYWCMkdmkuyD7UlK8bH2Mrz1LwgwVQqND5iP3/ieXCB6
 fpmbif0BtDwOWrns5MqZKBjVWSsxWtCtCRjvy/AeyTPOTBikAXHB32YNXunt7AkL9usT
 DcQ3rzlorm4dQWuc9wT3GYi/qKlx9lwx4n4dk1/kVshXvveXRN6R0ouIWkOiWAZdl3i+
 sYVNTzkSYgTfoVBDubPy+KuD8Ts8qXS1k25cMCOivTSD+PKe8vodCNwtQT2XqXF1v+Cd
 7DUOuuLmZddveOYI1x7D7H3U+DiGzMF8fYRDIFTKy5ipJLs7lNNMzXakOBKNiGqry/6s
 gxtg==
X-Gm-Message-State: AFq9FYKA2ZH7ZUFJuMvfB6T8dpAv7nT/44FADAUBCRE4AZ7j/ib2aGOv
 hd0LVsKLa/tVCqnq+9p9v942HVBkzGHoz+APUoK69cRo44/gSkMg4FnYV2mnvg==
X-Gm-Gg: AYBFou0lT74OrVpE4yNQi8gGHvmclsHn45T4LUldb9+3cNfZkb3Oi1HfHSmQPowlVEv
 ub1TV11nh9wcR2gkIQXIBwnFQd+IEqWcMI/nDihYMib2kwwYg21y1Ev6wkle1qVWmxAlbEKKLlx
 8mMWb9aAdclF9HUNi0VU8plSUagPnSpLq8dYo5GCnB8wyDDGdLZptLm3l0PblSbv3YhmwjY/iCJ
 rOs0ePJ1Ll19jXYWVdEpgDwKYvbBdIlhWIxiCOwX0iEuBcpORWFNjJTPWM2vQ+h4iSKD2q+R9MX
 2Kg3A4HFyMMS+PgNjwcloTt7AW1R7ggkGrcLJTv4L9Hj1EAuPruWzLQlitj2Pp3Bj+W/zUtYajM
 y1MTh5ZXqdOXGq0+heQhXobh4qF5LLamE07ZK4ea59dFNtmoplkPNW+Swlx42uaRaoVxfe5IQC9
 jayxCFfOo+bDE583vqN4oQSC/APd8eUHIVyFNDaxRbxLN+QoYadh8NTkw53OwwERiyIkPtksEbe
 OIfkYFHyxfcy89Zr6rmYFScoeN5zMUMVo0auzPUxAXrjHu2LNw8GFKTDiKEpGepgQ3lDk82ytN3
 4Ar9EyOMp76/7T8A6yg=
X-Received: by 2002:a17:90a:4485:b0:3ac:97e3:7389 with SMTP id
 98e67ed59e1d1-3adeafd6493mr5628571a91.44.1793082507453; 
 Mon, 26 Oct 2026 23:28:27 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:28:26 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/29] riscv-to-apply queue
Date: Tue, 27 Oct 2026 16:27:39 +1000
Message-ID: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x536.google.com
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

The following changes since commit d73149283205645625bfa9fe029cfb68e4c4a9ae:

  Merge tag 'samuel-thibault' of https://people.debian.org/~sthibault/qemu into staging (2026-10-24 16:09:37 +0200)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20261027

for you to fetch changes up to bf67d56f282c1ee25b67dfda3f8ca54d2bd4648e:

  target/riscv: Fix CPU state access on big-endian hosts (2026-10-27 10:26:46 +1000)

----------------------------------------------------------------
RISC-V PR for 11.2

* Add experimental Zvabd extension support
* Mask vsepc according to IALIGN
* Reset vCPU on VM reset via MP_STATE_INIT_RECEIVED
* Improve modeling of the Atlantis UART
* Fix IOMMU entry leak with ioatc-limit=0
* Fix integer handling issues in k230_gsdma and k230_decomp_gzip
* Reclaim invalidated IOATC entries for IOMMU
* Duct tape fix for QMP and RV profiles introspection
* Move RISC-V 'Z' CPU properties section to removed features
* Use TSO barriers instead of full barriers for Ztso
* Make mnstatus.MNPELP writable with Zicfilp
* Gate envcfg CBO fields on extensions
* Fix stale PMP state across reset
* Use 1ULL for a value we're going to shift by 63
* Remove unused IMISC macro
* Encode debug translation ranges in IOMMU
* Allow regular mstatus MPV/GVA writes again
* Fix uninitialised upper half in pmu_timer_trigger_irq
* Fix CPU state access on big-endian hosts

----------------------------------------------------------------
Anton Johansson (1):
      target/riscv: Fix CPU state access on big-endian hosts

Daniel Henrique Barboza (3):
      target/riscv/cpu.c: duct tape fix for QMP + RV profiles introspection
      include/hw/intc/riscv_imsic.h: remove unused macro
      target/riscv/csr.c: allow regular mstatus MPV/GVA writes again

Harshit Mukhedkar (1):
      target/riscv: fix uninitialised upper half in pmu_timer_trigger_irq()

Mingliang Liu (2):
      disas/riscv: Support vabs.v pseudo-instruction
      tests/tcg/riscv64: Add Zvabd extension tests

Peter Maydell (1):
      target/riscv: Use 1ULL for a value we're going to shift by 63

Philippe Mathieu-Daudé (1):
      docs: Move RISC-V 'Z' CPU properties section to removed features

Portia Stephens (3):
      hw/riscv/atlantis: Use dw8250 UART model
      hw/riscv/atlantis: Add all UARTs for Atlantis SoC
      docs/atlantis: Update Atlantis UART documentation

Rick Richard (1):
      target/riscv: Use TSO barriers instead of full barriers for Ztso

Sebastian Alba Vives (2):
      target/riscv: pmp: clear A and L on every implemented PMP entry at reset
      target/riscv: pmp: reset the derived PMP bounds and rule count

Tan Chi (3):
      hw/riscv/riscv-iommu: fix entry leak with ioatc-limit=0
      hw/riscv/riscv-iommu: serialize IOATC accesses
      hw/riscv/riscv-iommu: reclaim invalidated IOATC entries

Tao Ding (5):
      hw/misc: fix calculating output address overflow in k230_decomp_gzip
      hw/misc: fix calculating input address overflow in k230_decomp_gzip
      hw/misc: use hwaddr for the k230_decomp_gzip input address
      qtest: fix k230_decomp_gzip test integer handling issues
      hw/dma: fix k230_gsdma integer handling issues

Wang Yechao (1):
      target/riscv/kvm: Reset vCPU on VM reset via MP_STATE_INIT_RECEIVED

Zephyr Li (2):
      target/riscv: mask vsepc according to IALIGN
      hw/riscv/riscv-iommu: encode debug translation ranges

Zhibo Hong (1):
      target/riscv: Add support for the Zvabd extension

wangyang (2):
      target/riscv: make mnstatus.MNPELP writable with Zicfilp
      target/riscv: gate envcfg CBO fields on extensions

 docs/about/deprecated.rst                   |  24 -
 docs/about/removed-features.rst             |   7 +
 docs/system/riscv/tt_atlantis.rst           |   7 +-
 hw/riscv/riscv-iommu.h                      |   1 +
 include/hw/intc/riscv_imsic.h               |   1 -
 include/hw/riscv/tt_atlantis.h              |  13 +-
 target/riscv/helper.h                       |  26 ++
 target/riscv/cpu_cfg_fields.h.inc           |   1 +
 target/riscv/insn32.decode                  |  10 +
 disas/riscv.c                               |  14 +
 hw/dma/k230_gsdma.c                         |  84 ++--
 hw/misc/k230_decomp_gzip.c                  |   6 +-
 hw/riscv/riscv-iommu.c                      | 190 ++++----
 hw/riscv/tt_atlantis.c                      |  68 +--
 target/riscv/cpu.c                          |  22 +-
 target/riscv/kvm/kvm-cpu.c                  |  27 ++
 target/riscv/tcg/csr.c                      |  50 ++-
 target/riscv/tcg/pmp.c                      |  10 +-
 target/riscv/tcg/pmu.c                      |  18 +-
 target/riscv/tcg/tcg-cpu.c                  |   6 +
 target/riscv/tcg/translate.c                |  32 +-
 target/riscv/tcg/vector_helper.c            |  56 +++
 tests/qtest/iommu-riscv-test.c              | 193 ++++++++
 tests/qtest/k230-decomp-gzip-test.c         |   2 +-
 disas/riscv-op.c.inc                        |   9 +
 target/riscv/tcg/insn_trans/trans_rvi.c.inc |   4 +-
 target/riscv/tcg/insn_trans/trans_rvv.c.inc |  49 ++-
 hw/riscv/Kconfig                            |   2 +-
 tests/tcg/riscv64/system/meson.build        |  12 +
 tests/tcg/riscv64/test-vsepc-masking.S      |  54 +++
 tests/tcg/riscv64/test-zvabd.S              | 659 ++++++++++++++++++++++++++++
 31 files changed, 1423 insertions(+), 234 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-vsepc-masking.S
 create mode 100644 tests/tcg/riscv64/test-zvabd.S


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D2BC624D5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1OMv-0000vX-BQ; Tue, 01 Sep 2026 09:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1OMs-0000vI-CN
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:38 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1OMq-00076Q-3p
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:38 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6a5f1d0af69so7570270a12.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268654; x=1788873454; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UnGEuJDhgPeksDZ1SZItlIhZ9Bqoatm2hxVSUdfEHO0=;
 b=Iis23l743zRPL2Hi9R2N5mgXc6ITthbmhtffM2dY7oPiUGQHRHuvHbARodAqHZTaoI
 jr4cCJWhOW0Imew9RIxLSHOo4E1u81pcnDfsdmMmg2BTShEPK45HFN5pGZ7FMQunm6s7
 V52mdAV/FE7lEuVgY4URkJcCHxaKIYT8h5KRPywSn1wZpjrnEVpKoD819T9Na2kvvasa
 U8siXcHvPDlqoKGqhdgSGTyR0aFuSgn6CLmWsbYVuJvwIiAxYZVtbtLo3j6PRSbPolpG
 y2nSzz52sjRwY/3jcy43TsrC0Tx+6tR2ik6YrwdmcBuJS3FHKoXdykIJ9fWegT0LA5cR
 MkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268654; x=1788873454;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UnGEuJDhgPeksDZ1SZItlIhZ9Bqoatm2hxVSUdfEHO0=;
 b=p45JX18t0fZmAlKK8ul7ag1qMglYa/RbQiOA3Ytq8pdKZ4DIn/SB/Y7OzUmXLm6qB3
 yRj+WgYDP28Fw57EOsCv8dkuQ7D2tcvlBJzQlFbYGjeKglOZ5rCR1figqay5FjykLoSf
 4YXvdOXMewxUwWxTaUwn+M485a3xFx4MpGoy894pYqyZwplPmfwxq47WhCxcdoqZnQc9
 468iUZtxBAFgHORSduM/94xevQi5hsd16cZ7IJZ3m9lB0eDt33gElRtkfzw9CzAMJip6
 hW0g/eD2kcpkWAs2wkdOrKWNgUozJ0yl3hN789w73ZVZFqWbMy2v6XZ1Z54Z+WER2CyC
 tf7Q==
X-Gm-Message-State: AFuF++n/kHntnbz3boYFGPpj5jydzo7ltVJHCGso/F/EGoQcWgGIn0XG
 65T6mWtLcvxfQpGxUFOyml8jd6dCN2H/ZPqfcV9kj4AqWm2XirX10diC5qS3T6z48GzCRQHIn4c
 rEGs4/8I=
X-Gm-Gg: AR+sD11055AVuVZbPSK0KttRIwBPmA34UjnCjcAeFShTjBpz0of9Sw2TPs2tGfzGsoP
 zmiasDYxRCNuhrEhHCXmokDiJRZvofReYWi+Cavhdzyr+SWlLzXIfKvVzGggQ6BmfDKrR44pVf8
 jvxUgKfFAhd9rJp/krv8s0dZvCbcFE1cFoo1WAAHq52a6S1APOUJC1RvQI2g1lyWDKv/UwG6gT2
 7ivMQUi1pObVJPhgTaXll7NhWUcRv9EvQ174B2Vk0KLSNLhVnEVzkt5neljdOyl3vQvpthjg3pT
 0GtL8Wt6M0NB1MY6Aza/qmtr9tq5OvLtY+cpFSDg5oykfEzmOHn9LBq+9HJdF1LhUUvm7A2x5F8
 CR7Q4kpiqvlxyf0Eh4Bewzbfxj0OWjmDR8ch+ZtiF9N9CGmej9gHPtwinxLZkwPEBf+bbevYuX5
 icI+3I7lNhYMKDLPXLGtYuUl1SIzOYlfN40mAnCqwltgPrcggagOpWhPn6WL480cAFSqlhcLCMp
 u6s2qD73J9wVu1f0ne3Ya3gZmqA6Zu1cnTVz6DyCtI43rqKo+frGbFTNBGaT5/dzwr+WQ==
X-Received: by 2002:a17:907:c11:b0:c1f:c7f0:b433 with SMTP id
 a640c23a62f3a-c2556dae689mr2327813566b.9.1788268654085; 
 Tue, 01 Sep 2026 06:17:34 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.17.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:17:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/58] target-arm queue
Date: Tue,  1 Sep 2026 14:16:34 +0100
Message-ID: <20260901131732.2263947-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

Hi; here's an arm pullreq: one new board, one removed board,
emulation of various new CPU features, some bugfixes.

-- PMM

The following changes since commit d2e570cc0f97b936902a5b1b86b73c0f5998b475:

  Merge tag 'pull-ppc-for-11.2-20260828' of https://gitlab.com/harshpb/qemu into staging (2026-08-28 15:17:04 -0700)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260901

for you to fetch changes up to 90789a83fb8b608f08a2716a3517c5ad743b3823:

  target/arm: Enable FEAT_SVE_AES2 for -cpu max (2026-09-01 13:44:13 +0100)

----------------------------------------------------------------
target-arm queue:
 * target/arm: fix TTA instruction S bit for IDAU-exempt addresses
 * target/arm: Correct reset value of SCTLR for arm926, arm1026
 * target/arm: Don't provide TLBTR for pre-v6 CPUs
 * target/arm: Don't enforce alignment faults on Device memory for SCTLR.U == 0
 * target/arm: Correctly UNDEF Thumb T1 hints, CBZ, IT on older CPUs
 * target/arm: add cortex-m85 model
 * target/arm: Separate cpu types max-v8 and max-v9
 * target/arm: Implement FEAT_FGWTE3, FEAT_SVE2p2, FEAT_SME2p2,
   FEAT_SVE_BFSCALE, FEAT_SSVE_BitPerm, FEAT_SVE_AES2
 * hw/char/pl011: support backend hotswap
 * hw/arm: Add Arm mps3-an555 board
 * hw/arm: Remove the 'musicpal' machine

----------------------------------------------------------------
Alexander Mikhalitsyn (1):
      hw/char/pl011: support backend hotswap

Alexandre Frey (1):
      target/arm: fix TTA instruction S bit for IDAU-exempt addresses

Peter Maydell (11):
      target/arm: Correct reset value of SCTLR for arm926, arm1026
      target/arm: Don't provide TLBTR for pre-v6 CPUs
      tests/qtest/pflash-cfi02-test: Don't use musicpal machine for testing
      hw/arm: Remove spurious WM8750 dependency from Realview Kconfig
      hw/arm: Remove the 'musicpal' machine
      hw: Remove Marvell 88W8618 devices
      hw/audio: Remove wm8750 I2C audio device
      target/arm: Don't enforce alignment faults on Device memory for SCTLR.U == 0
      target/arm: Make CBZ/CBNZ UNDEF before v6T2
      target/arm: Make IT insn undef when not present
      target/arm: Make Thumb T1 hint space UNDEF before v6T2

Richard Henderson (37):
      target/arm: Move -cpu max stuff out of cpu32.c
      target/arm: Build cpu32.c once in system mode
      target/arm: Rename and adjust aarch32_max_v8_tcg_initfn
      target/arm: Introduce cpu types max-v8 and max-v9
      target/arm: Use -cpu max-v8 with aarch64=off
      target/arm: Separate cpu types max-v8 and max-v9
      target/arm: Add FGWTE3_EL3
      target/arm: Add FGWTE3_EL3 bit definitions
      target/arm: Add FGWTE3 FGT bit definitions
      target/arm: Implement FGWTE3 traps
      target/arm: Set fgt in cpregs for FGWTE3
      target/arm: Enable FEAT_FGWTE3 for -cpu max
      target/arm: Split zdn in do_z2z_n1 and do_z2z_n1_fpst
      target/arm: Split zdn in do_z2z_nn and do_z2z_nn_fpst
      target/arm: Split decode of BFloat SME FMAX/FMIN
      target/arm: Implement FMUL (multiple/multiple and single vectors)
      target/arm: Enable FEAT_SVE2p2 and FEAT_SME2p2 for -cpu max
      target/arm: Remove DO_ZPZZ_FP from translate-sme.c
      target/arm: Remove DO_ZPZZ_FP_B16 from translate-sme.c
      target/arm: Remove DO_ZPZZ_AH_FP from translate-sme.c
      target/arm: Remove DO_ZPZZ_AH_FP_B16 from translate-sme.c
      target/arm: Split decode of BFloat SVE FADD, FSUB, FMUL, FMIN*, FMAX*
      target/arm: Implement SVE BFSCALE
      target/arm: Implement SME BFSCALE
      target/arm: Implement SME BFMUL
      target/arm: Enable FEAT_SVE_BFSCALE for -cpu max
      target/arm: Rename isar_feature_aa64_sve_pmull128
      target/arm: Rename isar_feature_aa64_sve_bitperm
      target/arm: Rename isar_feature_aa64_sve_sha3
      target/arm: Rename isar_feature_aa64_sve_sm4
      target/arm: Implement and enable FEAT_SSVE_BitPerm for -cpu max
      target/arm: Implement AESE (indexed)
      target/arm: Implement AESD (indexed)
      target/arm: Implement AESEMC
      target/arm: Implement AESDIMC
      target/arm: Implement PMULL, PMLAL
      target/arm: Enable FEAT_SVE_AES2 for -cpu max

Simon Xu (8):
      target/arm/tcg/cpu-v7m.c: add cortex-m85 model
      hw/arm/armsse: add Arm Corstone SSE-310
      hw/misc/iotkit-sysctl.c: add SSE-310 support
      hw/misc/iotkit-secctl.c: add SSE-310 support
      hw/misc/iotkit-secctl.c: use GNU C case ranges
      hw/misc/iotkit-sysinfo.c: add SSE-310 support
      hw/misc/mps2-fpgaio.c: add GPIOALT2 register
      hw/arm/mps2-tz.c add Arm mps3-an555 board

 MAINTAINERS                                       |   10 -
 bsd-user/aarch64/target_arch_elf.h                |    8 +-
 configs/devices/arm-softmmu/default.mak           |    1 -
 docs/about/removed-features.rst                   |   10 +
 docs/system/arm/emulation.rst                     |   19 +-
 docs/system/arm/mps2.rst                          |    7 +-
 docs/system/arm/musicpal.rst                      |   19 -
 docs/system/target-arm.rst                        |    1 -
 hw/arm/Kconfig                                    |   16 -
 hw/arm/armsse.c                                   |  208 ++-
 hw/arm/meson.build                                |    1 -
 hw/arm/mps2-tz.c                                  |  162 ++-
 hw/arm/musicpal.c                                 | 1397 ---------------------
 hw/arm/sbsa-ref.c                                 |    2 +
 hw/arm/virt.c                                     |    2 +
 hw/audio/Kconfig                                  |    4 -
 hw/audio/marvell_88w8618.c                        |  315 -----
 hw/audio/meson.build                              |    2 -
 hw/audio/wm8750.c                                 |  738 -----------
 hw/char/pl011.c                                   |   31 +-
 hw/misc/iotkit-secctl.c                           |  130 +-
 hw/misc/iotkit-sysctl.c                           |   86 +-
 hw/misc/iotkit-sysinfo.c                          |   22 +-
 hw/misc/mps2-fpgaio.c                             |   35 +
 hw/net/meson.build                                |    1 -
 hw/net/mv88w8618_eth.c                            |  403 ------
 include/hw/arm/armsse-version.h                   |    2 +
 include/hw/arm/armsse.h                           |    9 +-
 include/hw/audio/wm8750.h                         |   30 -
 include/hw/misc/mps2-fpgaio.h                     |    2 +
 include/hw/net/mv88w8618_eth.h                    |   13 -
 linux-user/aarch64/elfload.c                      |   13 +-
 target/arm/cpregs-gcs.c                           |    5 +-
 target/arm/cpregs.h                               |   56 +
 target/arm/cpu-features.h                         |   38 +-
 target/arm/cpu-max.c                              |    4 +-
 target/arm/cpu.h                                  |    2 +-
 target/arm/helper.c                               |   73 +-
 target/arm/internals.h                            |    5 +-
 target/arm/tcg/cpu-max-v8.c                       |  130 ++
 target/arm/tcg/cpu-v7m.c                          |   47 +
 target/arm/tcg/cpu32.c                            |  120 +-
 target/arm/tcg/cpu64.c                            |  164 ++-
 target/arm/tcg/crypto_helper.c                    |  164 ++-
 target/arm/tcg/helper-a64-defs.h                  |    1 +
 target/arm/tcg/helper-defs.h                      |    5 +
 target/arm/tcg/helper-sve-defs.h                  |    5 +
 target/arm/tcg/hflags.c                           |   12 +
 target/arm/tcg/m_helper.c                         |    3 +-
 target/arm/tcg/meson.build                        |   11 +-
 target/arm/tcg/op_helper.c                        |   40 +-
 target/arm/tcg/sme.decode                         |  154 ++-
 target/arm/tcg/stubs32.c                          |    7 +-
 target/arm/tcg/sve.decode                         |   70 +-
 target/arm/tcg/sve_helper.c                       |    1 +
 target/arm/tcg/t16.decode                         |    3 +
 target/arm/tcg/translate-a64.c                    |   16 +-
 target/arm/tcg/translate-sme.c                    |  190 +--
 target/arm/tcg/translate-sve.c                    |  282 +++--
 target/arm/tcg/translate.c                        |   38 +-
 target/arm/tcg/vec_helper64.c                     |   35 +
 tests/functional/aarch64/test_virt_aarch64_off.py |    4 +-
 tests/qtest/arm-cpu-features.c                    |    4 +-
 tests/qtest/meson.build                           |    6 +-
 tests/qtest/pflash-cfi02-test.c                   |   38 +-
 65 files changed, 1869 insertions(+), 3563 deletions(-)
 delete mode 100644 docs/system/arm/musicpal.rst
 delete mode 100644 hw/arm/musicpal.c
 delete mode 100644 hw/audio/marvell_88w8618.c
 delete mode 100644 hw/audio/wm8750.c
 delete mode 100644 hw/net/mv88w8618_eth.c
 delete mode 100644 include/hw/audio/wm8750.h
 delete mode 100644 include/hw/net/mv88w8618_eth.h
 create mode 100644 target/arm/tcg/cpu-max-v8.c


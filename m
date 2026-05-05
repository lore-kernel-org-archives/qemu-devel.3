Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FB8CD3430
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 09:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKC5r-0002uQ-Jn; Tue, 05 May 2026 05:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKC5p-0002tV-Mm
 for qemu-devel@nongnu.org; Tue, 05 May 2026 05:29:29 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKC5n-0001sj-QI
 for qemu-devel@nongnu.org; Tue, 05 May 2026 05:29:29 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43d75312379so3405535f8f.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 02:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777973365; x=1778578165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=WyB3SrEDPsOOhUd15ht2d3nePbZvPqOj1P39uUgVBBo=;
 b=ipYxxpJagYPE/Qleftwj0zp798uOVCz33krbZj1srFxeFa5K2lOkQ+QnHEdwQBZipi
 G9jRUjrcRvgY7MHU5fOEqhjnwXKsX91cLhoAceJc0ige83v0q3zYTkX1WfUJUPKIr7G8
 BaY8311LrxfmS0U5mV53jiFofDeniW4tDf3tHj8/ZwruBbQ9tm0qEMPVfUoUh+lXb33E
 vh+5YrcgpAPKVIHod/A9VzhTeqNKBxrJS0h412pt23arcv1bV+QDNTQhTamo9HGa2lr2
 RB9tbakkkNwLlKX9KhyMYVv3z19tUGpxPwmn7sy2+z4mAuogVdgE5QdlDKTO04Y9ZZPI
 BjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777973365; x=1778578165;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WyB3SrEDPsOOhUd15ht2d3nePbZvPqOj1P39uUgVBBo=;
 b=EZL/lCf0bks9kTnL7c9FjiuZt8hU/Z8HtDyAMP4snpXkF7vxOkyuYt4x1yZgNr+HVQ
 9bXhwzgvu6i2OS5vvSNLQuIF//DIr1nLZC8p6GUuVhrpwkYn+Luyd+s3lTG3zje+6vMi
 eDtLrwBnx7QjAVR7E6McUuPYAjwtTrA3ZgFjOLECzT+3gvUtH16OvsNcQ39o0+jsYGzS
 oU99hLVOdYM018+sgK/tEwUXnRoKqLorKzXQ/bdTMvHfmcAI0u5cWIOsoCGQT9Xhk1ms
 BZUeYMK0uHlKsYYHWxQP4f5jIEu6V6dR1rxPKP9uZm5PFFPCQzGWDxMvjfj0WFOSAkbB
 a9TQ==
X-Gm-Message-State: AOJu0Yw6PGmfW5UBYDUNLqgIsVWrLL12zM7qZmFqg85KSzuA2fDGUgws
 c7Oi7GuSotbUqWJsvX6gwuXuDfebvPnEObQUG4Pglug5p/qoSlaXlR5T0c83JDsD7fKT20TTkCe
 AVmcS
X-Gm-Gg: AeBDieuB2vUksQk3BDhxxISVwHO4OTBYcmXi1fHBcO4ZO9u7mqWI2a0Ndxsjzvj/d5x
 dP+ChX82BEyeuZ4zt583TxeEHJAb7gUmyRLSQ0MdBa2NfZO0u0jAj+LQdFy8jfh/u7shRrshNws
 /77rjV6SVAPPcUWZ4QR6GuSDQpujmuiN+ZmMcAVgbcC+9l9vBPgb336zUtYIHLi+QEcuIfxIubF
 hCiJeo4ZPBBOiQ5qO53pkLKCGbft+rxJxiUwmonNi0rMgScnDsHSRotzez0Zzh+cSLR2A4MfNUp
 L4S+NBHegoft2Z2ZbzDPy/U08fmqg3tt3moxFT0w8VFu9n6qM8mW5UAMOOnrLzFerh9FPxU1nc8
 9gMvxPb3g5WuGgHrnniDzdBYjSj0pCqxKlATh41g9UM22BzhS7wMTBdcg61HkSm6LNALy7Yv2/0
 yabyJnVybsmsXXSEO4tsnWYFhf0mbZrPdtl3C7G7ImfLbMuTG/hy+bpgr91mIPsXP7/6vABc3xf
 w95AZp0L4XxWNMZTTWCeiIGQNCiTLWzQKQpThxWqQ==
X-Received: by 2002:a05:6000:270e:b0:446:6d9c:a60 with SMTP id
 ffacd0b85a97d-44fdbf3a459mr3328466f8f.8.1777973365211; 
 Tue, 05 May 2026 02:29:25 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960022sm3181218f8f.26.2026.05.05.02.29.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 02:29:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/29] target-arm queue
Date: Tue,  5 May 2026 10:29:23 +0100
Message-ID: <20260505092923.289634-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Hi; here's an arm pullreq. There's a combination of small stuff, plus
the hvf patchset that adds vGIC and nested-virt support. 

v2 changes:
 * new patch "hvf: arm: override HV_SYS_REG_MDCR_EL2" should fix
   the CI failure from v1
 * minor wording tweak in -smb docs patch

thanks
-- PMM

The following changes since commit ac0cc20ad2fe0b8df2e5d9458e90a095ac711ab1:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-05-01 14:41:49 -0400)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260505

for you to fetch changes up to 37863fff59e0b2c71989f2de906a52935f11ce7b:

  hvf: arm: enable vGIC by default for virt-11.1 and later (2026-05-05 09:30:12 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/arm/fsl-imx8mp: Do not create redundant unimplemented devices
 * hw/arm/fsl-imx8mp: Fix parent of ocram memory region
 * sysbus: Remove unused irq routing notifier method
 * linux-user/arm: Restrict regpairs_aligned
 * qemu-options: Improve description for -smb option
 * preliminary work for FEAT_RME_GDI
 * docs/devel/decodetree: Fix formatting in "field examples" table
 * hw/net/allwinner-sun8i-emac: Flush queued packets when rx is enabled
 * hw/intc/arm_gicv3: Fix NS write to ICC_AP1Rn_EL1 when prebits < 7
 * target/arm/kvm: Cache host CPU probe failure
 * hvf: support platform vGIC
 * hvf: support nested virtualization

----------------------------------------------------------------
Akihiko Odaki (1):
      target/arm/kvm: Cache host CPU probe failure

Bernhard Beschow (3):
      hw/arm/fsl-imx8mp: Do not create redundant unimplemented devices
      hw/arm/fsl-imx8mp: Fix parent of ocram memory region
      Revert "sysbus: add irq_routing_notifier"

Jim MacArthur (4):
      target/arm/cpu-features.c: New fields in AA64MMFR4
      target/arm/cpu.h: New GPCCR fields
      target/arm/ptw.c: Add GDI spaces to the granule protection case
      tests/tcg/aarch64/system/rme_gdi.c: Very basic test of GDI

Mohamed Mediouni (16):
      hw/intc: Add hvf vGIC interrupt controller support
      hw/intc: arm_gicv3_hvf: save/restore Apple GIC state
      accel, hw/arm, include/system/hvf: infrastructure changes for HVF vGIC
      target/arm: hvf: instantiate GIC early
      hw/arm, target/arm: nested virtualisation on HVF
      hvf: only call hvf_sync_vtimer() when running without the platform vGIC
      hvf: gate ARM_FEATURE_PMU register emulation when using the Apple vGIC
      hvf: arm: allow exposing minimal PMU for kernel-irqchip=on
      target/arm: hvf: add asserts for code paths not leveraged when using the vGIC
      hvf: arm: override HV_SYS_REG_MDCR_EL2
      hvf: sync registers used at EL2
      target/arm: hvf: pass through CNTHCTL_EL2 and MDCCINT_EL1
      hvf: arm: disable SME when nested virt is active
      hvf: arm: physical timer emulation
      hvf: enable nested virtualisation support
      hvf: arm: enable vGIC by default for virt-11.1 and later

Pali Rohár (1):
      qemu-options: Improve description for -smb option

Peter Maydell (1):
      docs/devel/decodetree: Fix formatting in "field examples" table

Richard Henderson (1):
      linux-user/arm: Restrict regpairs_aligned

liugan1 (1):
      hw/intc/arm_gicv3: Fix NS write to ICC_AP1Rn_EL1 when prebits < 7

宋文武 (1):
      hw/net/allwinner-sun8i-emac: Flush queued packets when rx is enabled

 accel/hvf/hvf-all.c                |  63 +++
 accel/stubs/hvf-stub.c             |  12 +
 docs/devel/decodetree.rst          |  44 +-
 hw/arm/fsl-imx8mp.c                |   3 +-
 hw/arm/virt.c                      |  46 +-
 hw/core/sysbus.c                   |   6 -
 hw/intc/arm_gicv3_common.c         |   4 +
 hw/intc/arm_gicv3_cpuif.c          |  35 +-
 hw/intc/arm_gicv3_hvf.c            | 835 +++++++++++++++++++++++++++++++++++++
 hw/intc/arm_gicv3_hvf_stub.c       |  25 ++
 hw/intc/meson.build                |   2 +
 hw/net/allwinner-sun8i-emac.c      |   3 +
 include/hw/arm/virt.h              |   2 +
 include/hw/core/boards.h           |   1 +
 include/hw/core/sysbus.h           |   1 -
 include/hw/intc/arm_gicv3_common.h |   4 +
 include/system/hvf.h               |   8 +
 include/system/hvf_int.h           |   1 +
 linux-user/user-internals.h        |   2 +-
 qemu-options.hx                    |  19 +-
 system/vl.c                        |   2 +
 target/arm/cpu-features.h          |   8 +
 target/arm/cpu.h                   |   5 +
 target/arm/hvf/hvf.c               | 217 +++++++++-
 target/arm/hvf/sysreg.c.inc        |  44 ++
 target/arm/hvf_arm.h               |   5 +
 target/arm/kvm.c                   |  38 +-
 target/arm/ptw.c                   |  20 +
 tests/tcg/aarch64/system/rme_gdi.c |  46 ++
 29 files changed, 1427 insertions(+), 74 deletions(-)
 create mode 100644 hw/intc/arm_gicv3_hvf.c
 create mode 100644 hw/intc/arm_gicv3_hvf_stub.c
 create mode 100644 tests/tcg/aarch64/system/rme_gdi.c


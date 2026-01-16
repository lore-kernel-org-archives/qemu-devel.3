Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06FDD4899E
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 12:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgjPW-0003fi-0a; Fri, 16 Jan 2026 07:58:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgjPR-0003dz-8V
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:58:37 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgjPO-00009j-H4
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 07:58:36 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so7460605e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 04:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768568312; x=1769173112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wY5SAA5FCcDOevLMIkYsgiOyIIXdmH7VFxYgl6NNqkE=;
 b=AD4jAsiIgCui4TF4l+hs7yqVZSfL6E0tnCPFhCi/Ol2ELqpoNqTZqkzs4GWrvf2B7L
 lUImSypL20Ts88tiZrRYQ/ofH2+05bAi1SgdLaKLu6IzN8qeNqE0hjn7KdrzrAhPB7r9
 KF2rDgxRk4QErl6Wp7PfFgaZvGnnCQnh/G1daMKZccQtlm1nbdzOIU5K2RtDxMoB9XjB
 mumWCjzUEpojnF349VRvE3/OVNys4sN285/IOUVo97GvVmflFMqiar/bAraqsGWONugp
 xTerARmjr6MiHtjX6e/KlX/wETmCtP+jPUOMZb31V97DaBP6Oad+vcDRae/EM6zhVvNn
 XoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768568312; x=1769173112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wY5SAA5FCcDOevLMIkYsgiOyIIXdmH7VFxYgl6NNqkE=;
 b=ekr8QVeWFelUGjCAt2OkEvIhSO8ha6uKLk+v0/pMh7yYFFAvpf2D1iFNt979Kq+9bt
 Narb8B34Yu5USS+DZvXG3bP0WvEbd7OzOVQuoEOgLn481a+NCz3epMt6WzPKa8HslkGg
 XNWWoQq+yZ2sC0RgBEzVNwfV9CEgTZReqJfSnqm9OOpkYATDBCompuJpwfaX7XCSIxz1
 dxPpF0deiaYdmb3OISMGl8tqI+a6SPYMOP5/7KNOQSQQqOIgcfSB1uVwve+gquHm5sg3
 G9ATaJGOvMy3AT27PXfxNE+/adcOxzQzb0j5IPLl6GaY3MvqDFQEVs2aTynlnJ+fdCos
 rs6w==
X-Gm-Message-State: AOJu0YxhdynUbOhMEqpOXx/Tm/64mwi+ijyyKYsmtcrC5OK/0HpeU8/Y
 O4FtMPuoWJq9VPi+a5pgsttN0vWuucJAJ9MOMFiI4Fqm5RfUU/Q2rZ3YJ2rKKaHh+PoZs5X5R7d
 5zCoa
X-Gm-Gg: AY/fxX4Dcm1Z4ea5wWDm30rHYeKYnK9gRk88pyJzccD/aP6eD7pmAjbpLtaAdaKu5AO
 dUTFu6gLLHZatYuOqqxh7SWdDU+RrFTuJB99pVhu66lrq4ueoAf0574Zs7u+71zkDM1dJApsel3
 BvCyL7tA3GrXLOM7hbYhBbCDTAvVxVqjGwhP9Box0EZZ8rATWcEsK2K8P0ejHq/Rn1nv14tyBu8
 FLcYlyzPHxPfQDIYA0fxY/mMWMdy1Y/gmJUaQEK/V5HweilT4/yKI2hiYpw0s9dLNFpprKB+GKk
 D/N6XRu7E1fgvGfv/ys83/H4M0KTF1hr1B3Ajprc9oQYrMt4xYYoc0/hn/2qxFT7+HYAyZuiI5K
 rX3SVthoRPvbfisgvlHPA5GouETEkMd/qkDuWa721r55FBHmHYWYf4i0MFuWOHl0xFXAedGm0v9
 NpW+tJ1AVnTlPflwKrdOrhdvre/5bnxICK27UJ7vTWVfThNWyF807VKhbtMEq/fQWqgn9QPLNVp
 fTuSIvq13pkAvNJr8qdO8nycretEPQ9KDjXYLDi/qmf7A==
X-Received: by 2002:a05:600c:a009:b0:475:dd9a:f791 with SMTP id
 5b1f17b1804b1-4801eb0ef0bmr23358635e9.28.1768568311853; 
 Fri, 16 Jan 2026 04:58:31 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe67780sm15387565e9.16.2026.01.16.04.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 04:58:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 0/4] misc: clean up includes
Date: Fri, 16 Jan 2026 12:58:26 +0000
Message-ID: <20260116125830.926296-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
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

This patchset is the result of running scripts/clean-includes
as updated with my changes in the v2 patchset I just posted:
https://patchew.org/QEMU/20260116124005.925382-1-peter.maydell@linaro.org/

It makes the usual set of cleanups to #include lines:
    * Ensure .c files include qemu/osdep.h first.
    * Including it in a .h is redundant, since the .c  already includes
      it.  Drop such inclusions.
    * Likewise, including headers qemu/osdep.h includes is redundant.
      Drop these, too.

I have split the changes it proposes into five categories:
 (1) changes to mshv related files
 (2) changes to bsd-user files
 (3) changes where a .c file included a system header that
     osdep.h already provides
 (4) changes where .h files either included osdep.h or
     else some system header that osdep.h provides

The only change the updated script proposes which is not in
any patch in this series is to hw/virtio/cbor-helpers.c: I am
waiting to find out if we should put this file on the
exclude-list.

thanks
-- PMM

Peter Maydell (4):
  mshv: Clean up includes
  bsd-user: Clean up includes
  misc: Clean up includes
  all: Clean up includes

 accel/mshv/irq.c                   | 3 +--
 accel/mshv/mshv-all.c              | 1 -
 bsd-user/bsd-mem.h                 | 3 ---
 bsd-user/bsd-proc.c                | 1 -
 bsd-user/freebsd/os-proc.h         | 2 --
 bsd-user/qemu-bsd.h                | 1 -
 hw/core/machine-qmp-cmds.c         | 1 -
 hw/scsi/lasi_ncr710.h              | 1 -
 hw/scsi/ncr53c710.h                | 1 -
 include/hw/core/loader.h           | 1 -
 include/hw/i386/tdvf.h             | 1 -
 include/hw/ppc/spapr_fadump.h      | 1 -
 include/hw/riscv/iommu.h           | 1 -
 include/system/accel-irq.h         | 1 -
 include/system/mshv.h              | 1 -
 linux-user/alpha/target_proc.h     | 1 -
 qga/commands-windows-ssh.h         | 1 -
 qga/vss-win32/vss-debug.h          | 1 -
 semihosting/arm-compat-semi-stub.c | 1 -
 target/arm/cpu32-stubs.c           | 1 -
 target/i386/kvm/kvm.c              | 1 -
 target/i386/kvm/vmsr_energy.h      | 2 --
 target/i386/mshv/mshv-cpu.c        | 1 -
 target/i386/mshv/x86.c             | 1 -
 target/loongarch/csr.c             | 1 -
 target/riscv/csr.c                 | 1 -
 tools/i386/qemu-vmsr-helper.c      | 1 -
 util/cpuinfo-aarch64.c             | 1 -
 28 files changed, 1 insertion(+), 33 deletions(-)

-- 
2.47.3



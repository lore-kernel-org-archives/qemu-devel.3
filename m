Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF75CE8D4C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 04:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr94C-0007JW-HW; Thu, 19 Sep 2024 00:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sr947-0007FJ-PW
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 00:46:52 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sr945-00074Y-Pi
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 00:46:51 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-656d8b346d2so243053a12.2
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 21:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726721207; x=1727326007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=okWQnCc9i+a9qTeP/CljeFJtPOK3zSl+MYdGWF+XBiU=;
 b=VrhlSWTc9V5dHH2sQc/rklQx7Oc6XSVZfVRXWGzvVwOhL2j8EWlsjmYAJyxIo179sU
 a6rUp3xXSfus6GftUtzDYeQfTkYt/cmpmXzqnZLvM7y4cfq17IKkQm33Sx50XBvpf18d
 DYjn2luzFQ0xmIsNVFIXY1pmWnWmX8nuYqq9XotnZfApli9mImRS4PTU6tUhv+FxyQE/
 Fl1K1Y+NAffQdbqorSS0LPhbqkHgTRrljm0HGsEH7XTJ7tZ58u+XhDdJlZwrwqTbQjc4
 xoffcQ/3DSIHoN+vmqw+JK16cJ9gCwOBw1KLwZKnEKEonsuBVmZqTqpeqb1bluyYsL1y
 yhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726721207; x=1727326007;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=okWQnCc9i+a9qTeP/CljeFJtPOK3zSl+MYdGWF+XBiU=;
 b=cNVk60AJIA3zZyBNtieaQ76A5vYDT8r7LrOfZNYDrUNJRUIjraafqRwjm3zQB/a5vq
 mvSrCpscEdvtwBb6nqmBY5dPj2jZCsfL9wazu8Z2S9QFeJJ3+sGQVpPS/b7LUsWDZvta
 w33RAtEUFz6Gkfy2l3B/8zdzpOc8+Dg5p5M1F76IzZsmNRoHee8x8yuA0Js1Ag9V3VLS
 k9QeRfQeS0LpYncGky5oEiAwFMWJwysC3kxSJ2xQsk702pKnIC5E2GbOjEX7Pq5eqoWb
 PRcqTy1kYx86LKENmSveS+fSNKxMx0rHWUFvpBUgRSv2/RSu21ufpqxoJOUjmDMxj1Wk
 81vQ==
X-Gm-Message-State: AOJu0YyhQwFWwSJnc1mTX9CBbKPqTTCpavpO33Oo2jFrWc+YTS5uv4ke
 tOr8vVSnDWar/7K964fqJepAnpmvE/jvCx0fvMZhnvhrIbMNW2GFoFkR200p5lm3Q2SoIOqq09b
 mOmIwyA==
X-Google-Smtp-Source: AGHT+IFTeoz0sc18zegnRwG9uqK1i/tdvMiZIsB+jYHs0tQzrYbWKu22/eeI4GvU6Dyul2n7o0JIuw==
X-Received: by 2002:a05:6a21:1690:b0:1cf:4348:d5c8 with SMTP id
 adf61e73a8af0-1d112e8bfaemr31800828637.39.1726721206933; 
 Wed, 18 Sep 2024 21:46:46 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944bc279csm7478601b3a.188.2024.09.18.21.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 21:46:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Hyman Huang <yong.huang@smartx.com>, Halil Pasic <pasic@linux.ibm.com>,
 kvm@vger.kernel.org, Bin Meng <bmeng.cn@gmail.com>,
 Peter Xu <peterx@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Hanna Reitz <hreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Corey Minyard <minyard@acm.org>, Laurent Vivier <laurent@vivier.eu>,
 WANG Xuerui <git@xen0n.name>, Thomas Huth <thuth@redhat.com>,
 Rob Herring <robh@kernel.org>, Eduardo Habkost <eduardo@habkost.net>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Ani Sinha <anisinha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Fam Zheng <fam@euphon.net>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-riscv@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 "Richard W.M. Jones" <rjones@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Weiwei Li <liwei1518@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Helge Deller <deller@gmx.de>,
 Yanan Wang <wangyanan55@huawei.com>, Michael Rolnik <mrolnik@gmail.com>,
 Jesper Devantier <foss@defmacro.it>, Marcelo Tosatti <mtosatti@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 00/34] Use g_assert_not_reached instead of (g_)assert(0,
 false)
Date: Wed, 18 Sep 2024 21:46:07 -0700
Message-Id: <20240919044641.386068-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series cleans up all usages of assert/g_assert who are supposed to stop
execution of QEMU. We replace those by g_assert_not_reached().
It was suggested recently when cleaning codebase to build QEMU with gcc
and tsan: https://lore.kernel.org/qemu-devel/54bb02a6-1b12-460a-97f6-3f478ef766c6@linaro.org/.

In more, cleanup useless break and return after g_assert_not_reached();

And finally, ensure with scripts/checkpatch.pl that we don't reintroduce
(g_)assert(false) in the future.

New commits (removing return) need review.

Tested that it build warning free with gcc and clang.

If a maintainer could pull the whole series, this would be much more easier than
integrating various parts of it in different subsystems. Thanks!

v3
- drop changes on .promela files
- some changes were already merged

v2
- align backslashes for some changes
- add summary in all commits message
- remove redundant comment

v1
https://lore.kernel.org/qemu-devel/20240910221606.1817478-1-pierrick.bouvier@linaro.org/T/#t

Pierrick Bouvier (34):
  hw/acpi: replace assert(0) with g_assert_not_reached()
  hw/arm: replace assert(0) with g_assert_not_reached()
  hw/net: replace assert(0) with g_assert_not_reached()
  migration: replace assert(0) with g_assert_not_reached()
  qobject: replace assert(0) with g_assert_not_reached()
  target/ppc: replace assert(0) with g_assert_not_reached()
  block: replace assert(false) with g_assert_not_reached()
  hw/hyperv: replace assert(false) with g_assert_not_reached()
  hw/net: replace assert(false) with g_assert_not_reached()
  hw/nvme: replace assert(false) with g_assert_not_reached()
  hw/pci: replace assert(false) with g_assert_not_reached()
  hw/ppc: replace assert(false) with g_assert_not_reached()
  migration: replace assert(false) with g_assert_not_reached()
  target/i386/kvm: replace assert(false) with g_assert_not_reached()
  accel/tcg: remove break after g_assert_not_reached()
  block: remove break after g_assert_not_reached()
  hw/acpi: remove break after g_assert_not_reached()
  hw/net: remove break after g_assert_not_reached()
  hw/scsi: remove break after g_assert_not_reached()
  hw/tpm: remove break after g_assert_not_reached()
  target/arm: remove break after g_assert_not_reached()
  target/riscv: remove break after g_assert_not_reached()
  fpu: remove break after g_assert_not_reached()
  tcg/loongarch64: remove break after g_assert_not_reached()
  include/qemu: remove return after g_assert_not_reached()
  hw/hyperv: remove return after g_assert_not_reached()
  hw/net: remove return after g_assert_not_reached()
  hw/pci: remove return after g_assert_not_reached()
  hw/ppc: remove return after g_assert_not_reached()
  migration: remove return after g_assert_not_reached()
  qobject: remove return after g_assert_not_reached()
  qom: remove return after g_assert_not_reached()
  tests/qtest: remove return after g_assert_not_reached()
  scripts/checkpatch.pl: emit error when using assert(false)

 include/qemu/pmem.h                     |  1 -
 accel/tcg/plugin-gen.c                  |  1 -
 block/qcow2.c                           |  2 +-
 block/ssh.c                             |  1 -
 hw/acpi/aml-build.c                     |  3 +--
 hw/arm/highbank.c                       |  2 +-
 hw/hyperv/hyperv_testdev.c              |  7 +++----
 hw/hyperv/vmbus.c                       | 15 ++++++---------
 hw/net/e1000e_core.c                    |  4 +---
 hw/net/i82596.c                         |  2 +-
 hw/net/igb_core.c                       |  4 +---
 hw/net/net_rx_pkt.c                     |  3 +--
 hw/net/vmxnet3.c                        |  1 -
 hw/nvme/ctrl.c                          |  8 ++++----
 hw/pci/pci-stub.c                       |  6 ++----
 hw/ppc/ppc.c                            |  1 -
 hw/ppc/spapr_events.c                   |  3 +--
 hw/scsi/virtio-scsi.c                   |  1 -
 hw/tpm/tpm_spapr.c                      |  1 -
 migration/dirtyrate.c                   |  3 +--
 migration/migration-hmp-cmds.c          |  2 +-
 migration/postcopy-ram.c                | 21 +++++++--------------
 migration/ram.c                         |  8 +++-----
 qobject/qlit.c                          |  2 +-
 qobject/qnum.c                          | 12 ++++--------
 qom/object.c                            |  1 -
 target/arm/hyp_gdbstub.c                |  1 -
 target/i386/kvm/kvm.c                   |  4 ++--
 target/ppc/dfp_helper.c                 |  8 ++++----
 target/ppc/mmu_helper.c                 |  2 +-
 target/riscv/monitor.c                  |  1 -
 tests/qtest/acpi-utils.c                |  1 -
 fpu/softfloat-parts.c.inc               |  2 --
 target/riscv/insn_trans/trans_rvv.c.inc |  2 --
 tcg/loongarch64/tcg-target.c.inc        |  1 -
 scripts/checkpatch.pl                   |  3 +++
 36 files changed, 50 insertions(+), 90 deletions(-)

-- 
2.39.5



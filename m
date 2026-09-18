Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A573C982DD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 20:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7fDY-0001JN-2m; Fri, 18 Sep 2026 16:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1x7fDX-0001J5-8E; Fri, 18 Sep 2026 16:29:55 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1x7fDV-0003Ci-KZ; Fri, 18 Sep 2026 16:29:55 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D7AA24160C;
 Fri, 18 Sep 2026 20:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676751F000FF;
 Fri, 18 Sep 2026 20:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789763391;
 bh=d9b45h+0PbT+j+W7nwklXtvP6ReaP2gu+9ivmyVlqs0=;
 h=From:To:Cc:Subject:Date;
 b=nQ/7hA+q1OIYdUuCUbtJs/z02PH5jUkm2idRcY6OdSzeTkACTPCb6J5Qctp7OhvMT
 HH3+5xaEYkqFPn2QgkqAYhoeGArtPt2ot1cgoi4+LMtfRLUWYGwmf3OMrCuiv3x41O
 9G13yOF1uExNQizX1mNA5Uq3bRjwdz+2pKxmEIyntCG0lhelZsoHUpgEBJgdeTUclU
 mRa94WSkStPTaMcvC8iTMxdTIOm8ytPj0XUvz0Eaf58IIFV2cjypQOul5Zw3nklaH5
 MUyNIvQHmPLwY6x/q2zI/HDanj2N2D59FhhRj/YcRJrcAHKwPk3Neudv66+EOUbeQP
 HGcJAo0u8cq5A==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Helge Deller <deller@gmx.de>,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PULL 0/4] Linux user patches
Date: Fri, 18 Sep 2026 22:29:43 +0200
Message-ID: <20260918202947.5322-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

The following changes since commit e8dca265c91b45f4cde746e5094d7b763444eb6a:

  Merge tag 'pull-11.1-more-check-tcg-docker-meson-180926-1' of https://gitlab.com/stsquad/qemu into staging (2026-09-18 07:52:24 -1000)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-pull-request

for you to fetch changes up to e95f53e30be7935d98e38eb09cd6360fe2886249:

  linux-user/loongarch64: Detect vector stores in host_signal_write() (2026-09-18 22:20:21 +0200)

----------------------------------------------------------------
linux-user patches for mlock syscall and loongarch64 and riscv fixes

Add support for the mlock syscall, and some fixes for loongarch64 and riscv.

----------------------------------------------------------------

Michael Morrell (1):
  linux-user: implement mlock2(2) syscall

SignKirigami (1):
  linux-user/loongarch64: Detect vector stores in host_signal_write()

wangyang (2):
  linux-user/riscv: honor zicntr=false for base counterCSRs
  linux-user/riscv: invalidate reservations after stores

 .../include/host/loongarch64/host-signal.h    |  6 +++
 linux-user/riscv/target_cpu.h                 |  2 +
 linux-user/syscall.c                          |  9 +++++
 linux-user/syscall_defs.h                     |  4 ++
 target/riscv/cpu.c                            |  3 ++
 target/riscv/cpu.h                            |  3 ++
 target/riscv/helper.h                         |  5 +++
 target/riscv/tcg/csr.c                        | 11 ++++--
 target/riscv/tcg/insn_trans/trans_rva.c.inc   | 24 ++++++++++++
 target/riscv/tcg/insn_trans/trans_rvi.c.inc   | 11 ++++++
 .../riscv/tcg/insn_trans/trans_rvzawrs.c.inc  |  3 ++
 target/riscv/tcg/op_helper.c                  | 35 +++++++++++++++++
 target/riscv/tcg/translate.c                  | 38 +++++++++++++++++++
 13 files changed, 150 insertions(+), 4 deletions(-)

-- 
2.54.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491A2CA6009
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENEA-0004t4-AO; Wed, 07 Oct 2026 04:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xEIt2-000058-CA
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:04:28 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1xEIsy-0004cG-OA
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:04:11 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.46])
 by linux.microsoft.com (Postfix) with ESMTPSA id 8B54C20B7166;
 Tue,  6 Oct 2026 09:48:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8B54C20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1791305308;
 bh=z6UFF2yWyifVchNILESFkZYhgOjmppX2NpsLTymFLz0=;
 h=From:To:Cc:Subject:Date:From;
 b=HCJQNDIUrgmK8Pc4DixcU23sLTTuexwkEuklAUt+4lHxaJAQbV48SDaBeqpodz3Ys
 B14Dj4sapzys7yR26kpzANvdUq48KmRH+tEgw8MoV5joei7VGI2wjpdA1ItB/TCmsc
 d62imi5azlfVPYd0ErJ/cqcBS3G7UHJyxs+QCakA=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 00/11] MSHV changes for 2026-10-06
Date: Tue,  6 Oct 2026 18:48:54 +0200
Message-Id: <20261006164905.776466-1-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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

Various minor fixes and a feature (gdb debugger support) for the Microsoft
Hypervisor (mshv) accelerator. The changes have been rebased and re-tested
individually.

My public certificate is available at:
https://mkulke.github.io/magnuskulke.asc

Primary key fingerprint:
5255 B617 7982 9168 7022 31CA 68D9 BB56 DD17 8417

The following changes since commit 3377670ee96b5a68361016680a95b9013709d4b7:

  Merge tag 'linux-user-next-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-10-05 07:14:51 +0200)

are available in the Git repository at:

  https://github.com/mkulke/qemu.git tags/mkulke-pull-20261006

for you to fetch changes up to 7d42b0a4f52d57cd2d9e0a9ceb8ad5102219a801:

  target/i386/mshv: support single-stepping (2026-10-06 18:14:35 +0200)

----------------------------------------------------------------
mshv changes for 2026-10-06

----------------------------------------------------------------
Doru Blânzeanu (9):
      target/i386/mshv: fix read/write memory across the page boundary
      include/hw/hyperv: move hv_vp_register_page struct definition
      target/i386/mshv: abort when hv_vp_register_page setup fails
      target/i386/mshv: remove fallback for register page get registers
      target/i386/mshv: remove fallback for register page set registers
      target/i386/mshv: fix pio handlers clobbering device-modified registers
      include/hw/hyperv: add ABI for exception intercepts and pending events
      accel/mshv: add gdbstub software breakpoint support
      target/i386/mshv: support single-stepping

Magnus Kulke (2):
      target/i386/mshv: zero-init msr hvcall args
      target/i386/mshv: Fix cpu feature-leak from host

 accel/mshv/mshv-all.c          | 170 +++++++++++++-
 include/hw/hyperv/hvgdk.h      |   2 +
 include/hw/hyperv/hvgdk_mini.h | 159 +++++--------
 include/hw/hyperv/hvhdk.h      | 106 +++++++++
 include/system/mshv_int.h      |  14 ++
 target/i386/mshv/mshv-cpu.c    | 491 ++++++++++++++++++++++++++++-------------
 target/i386/mshv/msr.c         |   4 +-
 7 files changed, 684 insertions(+), 262 deletions(-)

-- 
2.34.1



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2569606A888
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 20:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=RpmF4vLE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRF9E-0001Nw-M8; Wed, 11 Nov 2026 15:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xRF9A-0001JP-Tq
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 15:42:21 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1xRF97-0005vw-Op
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 15:42:20 -0500
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id 7CB5E20B7166;
 Wed, 11 Nov 2026 12:42:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7CB5E20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1794429732;
 bh=+WUC/S0ewOZRCVyO43iXrz9myK8q0yh9EqQy9ChQoiU=;
 h=From:To:Cc:Subject:Date:From;
 b=RpmF4vLE8XLztXjzVZZyhr3c9yPvXMP9ENFt1D6epNDd+DNg2KFznixgzng+06AXk
 KFdbL53VwAmoKtpqru8iM5OcEhA+bdSxvbq07GQYLVQxLzRLUmvnq53a1JkLhjqU7B
 uIE24Q4ExeM0YgFK1tQN8CmaEIpQMJrW/jFN7qtw=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>,
 Doru Blanzeanu <dblanzeanu@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 0/4] MSHV fixes for 2026-11-11
Date: Wed, 11 Nov 2026 21:41:51 +0100
Message-Id: <20261111204155.36683-1-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Various bug fixes for the Microsoft Hypervisor (MSHV) accelerator.
The fixes have been rebased and re-tested individually.

My public certificate is available at:
https://mkulke.github.io/magnuskulke.asc

Primary key fingerprint:
5255 B617 7982 9168 7022 31CA 68D9 BB56 DD17 8417

The following changes since commit 29760efaf96bbe5928f8111881eddbf5ac06439e:

  Update version for v11.2.0-rc0 release (2026-11-10 14:47:54 -0800)

are available in the Git repository at:

  https://github.com/mkulke/qemu.git tags/mkulke-pull-20261111

for you to fetch changes up to fcc504b77076b936ce79e33d9be68d6b73cc5dbe:

  target/i386/mshv: add MshvPutState for vcpu writes (2026-11-11 20:51:04 +0100)

----------------------------------------------------------------
mshv fixes for 2026-11-11

----------------------------------------------------------------
Magnus Kulke (4):
      accel/mshv: skip double unmap of mem regions
      target/i386/mshv: fix vCPU run result contract
      accel/mshv: freeze time during TSC MSR write
      target/i386/mshv: add MshvPutState for vcpu writes

 accel/mshv/mem.c            |  41 ++++++++++++++--
 accel/mshv/mshv-all.c       |  44 ++++++++++++++---
 hw/i386/mshv/clock.c        | 112 +++++++++++++++++++++++++++++++-------------
 include/system/mshv.h       |   4 +-
 include/system/mshv_int.h   |  14 +++++-
 target/i386/mshv/mshv-cpu.c |  38 ++++++++++-----
 target/i386/mshv/msr.c      |  21 ++++++++-
 7 files changed, 216 insertions(+), 58 deletions(-)

-- 
2.34.1



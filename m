Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9A8CD4847
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 10:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sln2V-0004Kq-Bn; Wed, 04 Sep 2024 06:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1sln2K-0003nZ-Sz
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:14:54 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1sln2I-0002i0-Te
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:14:52 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id A333BA433EA;
 Wed,  4 Sep 2024 10:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F023C4CEC2;
 Wed,  4 Sep 2024 10:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1725444888;
 bh=UC+3IEx5gs1MfUJ8Bog5XUNNG27DXXhGPJ5UOUWDZiY=;
 h=From:To:Cc:Subject:Date:From;
 b=V0o1yAz93xI+EopXxOPex6oCBgc8DA+Nud2Exxp6m+jDm/mTtB1y8gV/9fMqRIjQv
 unn4Hh3GwdiRN2Cnr9BpqYcmJ6dCt3Y3s8Wz+fRi5UFfnZDVK9Fh2T/S3a4TcJsm5U
 xlY/H04RtstfI4CbZKx25NXpmOFW4miFQpAOysUacWREX/9mLHerx6pvYDswO9ZyvB
 G5ymVrr8TTkWIVbDURL0YHAotpLkshO+FZP0lwSaHDnFNmIslqaxFJSOslq6z+nMtb
 NOGCjhd/X+Kz9rixzIZDItXoNFgu7U0w7O50N4R48C4AzOMi1C5uHcAFKSWuXi4EM9
 fTno6Ktoc/imw==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: deller@gmx.de
Subject: [PULL 0/2] Hppa v9.1 fixes patches
Date: Wed,  4 Sep 2024 12:14:43 +0200
Message-ID: <20240904101445.4127-1-deller@kernel.org>
X-Mailer: git-send-email 2.46.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.75.193.91; envelope-from=deller@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

The following changes since commit fd1952d814da738ed107e05583b3e02ac11e88ff:

  Update version for v9.1.0 release (2024-09-03 09:18:26 -0700)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/hppa-v9.1-fixes-pull-request

for you to fetch changes up to d33d3adb573794903380e03e767e06470514cefe:

  target/hppa: Fix random 32-bit linux-user crashes (2024-09-03 22:08:22 +0200)

----------------------------------------------------------------
hppa target fixes

Two important patches for the hppa target which missed qemu-v9.1:
- One fix for random linux-user crashes
- One fix for random issues due to loosing the division V-bit
  during delivery of hardware interrupts. This triggers all sorts
  of random faults when running in system mode.

Helge

----------------------------------------------------------------

Helge Deller (2):
  target/hppa: Fix PSW V-bit packaging in cpu_hppa_get for hppa64
  target/hppa: Fix random 32-bit linux-user crashes

 target/hppa/cpu.h    | 4 ++--
 target/hppa/helper.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.46.0



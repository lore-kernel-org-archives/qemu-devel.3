Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76421C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 14:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjHlG-0008Aj-8C; Mon, 13 Jul 2026 10:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wjHl0-00085w-9j
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 10:35:46 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wjHkx-0001u1-U1
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 10:35:41 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A783360103;
 Mon, 13 Jul 2026 14:35:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334971F000E9;
 Mon, 13 Jul 2026 14:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783953336;
 bh=VQ804XAzgWJKv9vJNZaHQ/X/Kr4+XQTmRmo+VFE7TAo=;
 h=From:To:Cc:Subject:Date;
 b=oJMOQcDbnYSblYn3Fb2f/98GW4YADKX6mbQ6x7xNPEVA9gkpMiX8t0fCDPhyluycu
 cEl+FF9Wf/lvfJYFnUGOMJl1wSV4MnBf59B1TuWXn8fVb1TpsYnwwa+1jISO2HAuxS
 uy7H4GgxHuPMucQELHZx0Swjnkw9LWlole5+w3hXmx52ZS+UKHxkWEf8IXc96qBBRk
 h204ypAvEyhf6k/GMzTyQpcXBGe3LQ1dIuqEGwsrKIV5EbJbZ/UNdeGhl8fePXZrem
 zhYln0fm7+d8eGJzPK9CCdh9MQClJA/F6kvqNk+Trtadn9AhEvvQ4fhaf2Y5RI/NN/
 X4IGSRTBXjAQA==
From: Helge Deller <deller@kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>,
	qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 0/2] Linux user for v11.1 patches
Date: Mon, 13 Jul 2026 16:35:29 +0200
Message-ID: <20260713143533.4641-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
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

The following changes since commit 916ab315cc2b3a3825ebb399d83339660144d5bd:

  Merge tag 'pull-nvme-20260707' of https://gitlab.com/birkelund/qemu into staging (2026-07-07 07:09:38 +0200)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-for-v11.1-pull-request

for you to fetch changes up to 7a2e863f9dd52883d6f59bb425f30609fc14aee4:

  linux-user/alpha: populate AT_HWCAP from env->amask (2026-07-13 16:16:31 +0200)

----------------------------------------------------------------
linux-user-for-v11.1 pull request

Please pull two fixes for linux-user for v11.1:
- Validate guest-passed dm_ioctl data_size
- Alpha: Fix programs using getauxval(AT_HWCAP) to detect BWX/FIX/CIX

----------------------------------------------------------------

Matt Turner (1):
  linux-user/alpha: populate AT_HWCAP from env->amask

Peter Maydell (1):
  linux-user: Validate guest-passed dm_ioctl data_size

 linux-user/alpha/elfload.c    | 11 +++++++++++
 linux-user/alpha/target_elf.h |  1 +
 linux-user/syscall.c          | 30 ++++++++++++++++++++++++++----
 3 files changed, 38 insertions(+), 4 deletions(-)

-- 
2.54.0



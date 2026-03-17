Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21016FEDA0D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2aSQ-00046u-4q; Tue, 17 Mar 2026 15:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w2aSL-00045d-7j
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:51:57 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w2aSJ-0006Qi-P7
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:51:56 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0D3B243655;
 Tue, 17 Mar 2026 19:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1329C2BC86;
 Tue, 17 Mar 2026 19:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773777112;
 bh=lNIHE6vtAbE/Os+84Sp6cMQfzGEDP38eTaqe9+xK7B0=;
 h=From:To:Cc:Subject:Date:From;
 b=RDPtoziV7n1TZ3OiI3YlFMjVjj+rkgVktC0GmaFtqO/Cr8dqOLpc6anMJ0JaExDvW
 TQR95vftmCGoAwFa1gAqviMuqqQ9aZEm/g9X7+cNoSyA/IJfAOF8inPzcMQNAvGsF/
 HPQNYgqrAwmeFmCNsCQIPmOm8ScbTl+yRbJCCMyWP16B3WWkY4X97AC6gEyCOWChgF
 /BRDjNSpIXDyraCw+mC6o7K9593S5AA6vlEEKU7Y697w2LHyAkvXHBq/6x2+SX2lLO
 xD5sUeSjdNbt8uOEPDriOQpbxOSZEZ8XFytCVfoh+Z7FODV2b8aPcPJ+/XeWbvRu7j
 2F/NgDKis+HjQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 0/6] HPPA fixes for v11
Date: Tue, 17 Mar 2026 20:51:43 +0100
Message-ID: <20260317195149.8386-1-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Some late fixes for QEMU-v11

Various fixes in SeaBIOS-hppa and qemu code, most importantly
this fixes boot of the C3700, which broke while we added
support for CPUs with 40 and 44 bits physical address space.

Please review.

Thanks!
Helge

Helge Deller (6):
  hw/hppa: Fix description of the HP A400-44 server
  hw/hppa: Adjust physical addresses of Astro and Elroy
  target/hppa: Always map 64-bit firmware at 0xfffffff0f0000000
  hw/pci-host/astro: Use proper region names
  hw/hppa: Fix crash of 64-bit HP-UX 11 while flushing caches
  target/hppa: Update SeaBIOS-hppa to version 23

 hw/hppa/hppa_hardware.h     |   4 ++--
 hw/hppa/machine.c           |  18 +++++++++++++++++-
 hw/pci-host/astro.c         |   6 ++++--
 pc-bios/hppa-firmware.img   | Bin 632048 -> 631968 bytes
 pc-bios/hppa-firmware64.img | Bin 713608 -> 714440 bytes
 roms/seabios-hppa           |   2 +-
 target/hppa/mem_helper.c    |  10 ++++++----
 7 files changed, 30 insertions(+), 10 deletions(-)

-- 
2.53.0



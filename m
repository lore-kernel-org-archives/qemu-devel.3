Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E791061B23
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 21:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7K0s-0000nJ-Jm; Mon, 30 Mar 2026 17:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7K0p-0000lv-7n
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:19:07 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7K0n-0003hm-HF
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:19:06 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3023660132;
 Mon, 30 Mar 2026 21:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0976AC4CEF7;
 Mon, 30 Mar 2026 21:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774905541;
 bh=dOSQIdpdlFnEssku7yyJKr5yi0nxuTNtK2hItK2N2IY=;
 h=From:To:Cc:Subject:Date:From;
 b=q2oHpxxsrRRBt7S/YFZ2EPNeXe7DnKsLRVUFEThbkskRtCB+Y2i416hGQ6RseUg+q
 JKhMu11diWxcgMYNKL7wX4yZr/CelP/1PN36/4wOiUbHIARzXsxTRD/80JUA02bk12
 YAK6MY8xxOuMgUMPZ8RarVj0/IOoyt+CyLo+R7ZqWEwKjUAxGjpzwtZR9dioGH2ff/
 Pz5fMAygm12r2Jy+4DA8FlkZqgy+LfyhUMPbKBqo4WcyRryC8TVoE+y89vuDcOtOrd
 IFRUyLf8AYXxjPcyn/HqXvgIqJkGwDM5JSBtz4qcc9HSHKZg9yR6OEnozR3s3OHYF0
 vgAc7/3gdyYnA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 00/11] HPPA Patches for qemu-v11
Date: Mon, 30 Mar 2026 23:18:47 +0200
Message-ID: <20260330211859.19317-1-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

A few late fixes for the HPPA architecture:
- graphics support was broken for 64-bit machines. This series adds
  support for VGA graphics for Linux guests
- the various memory ranges were not correctly implemented
- TOC/NMI was not working on 64-bit machines
- minor 64-bit HP-UX boot fixes (but it still crashes)
- minor fixes regarding weblinks and various Astro registers

Please review and consider to pull for qemu-v11.

Thanks!
Helge

Helge Deller (11):
  hw/pci-host/astro: Update copyright and documentation link
  hw/hppa: Disable Artist graphics card on 64-bit machines
  hw/pci-host/astro: Make astro address arrays accessible for other
    users
  hw/pci-host/astro: Fix initial addresses in IOC
  hw/pci-host/astro: Implement LMMIO registers
  hw/pci-host/astro: Fix LMMIO DIRECT mappings
  hw/pci-host/astro: Add GMMIO mapping
  hw/pci-host/astro: Add comment about Astro version numbers
  target/hppa: Fix TOC handler for 64-bit CPUs
  hw/hppa: Implement memory ranges
  target/hppa: Update SeaBIOS-hppa to version 24

 hw/hppa/hppa_hardware.h     |   3 +-
 hw/hppa/machine.c           |  61 +++++++---
 hw/pci-host/astro.c         | 215 ++++++++++++++++++++++++++++++------
 include/hw/pci-host/astro.h |  12 +-
 pc-bios/hppa-firmware.img   | Bin 631968 -> 632416 bytes
 pc-bios/hppa-firmware64.img | Bin 714440 -> 664768 bytes
 roms/seabios-hppa           |   2 +-
 target/hppa/int_helper.c    |   3 +-
 8 files changed, 239 insertions(+), 57 deletions(-)

-- 
2.53.0



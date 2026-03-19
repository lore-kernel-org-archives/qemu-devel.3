Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6341091924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 21:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Kg6-0001iB-ID; Thu, 19 Mar 2026 17:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w3Kfp-0001WI-7R
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 17:12:57 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w3Kfl-0003fx-Rg
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 17:12:56 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1A75F4092C;
 Thu, 19 Mar 2026 21:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF989C19424;
 Thu, 19 Mar 2026 21:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773954763;
 bh=9kjRDaeEOJWi+t12anPHUu+cyrL5jL+OnbgxZQH0Tk8=;
 h=From:To:Cc:Subject:Date:From;
 b=Vqb0jqS4rhj5jXYtjpFb2N5XXvsAuX4lGEujsK3Xeik1E53B2Nl+vRXTPQi8IbfeQ
 KUdfCZhbFrbZG6p5ya4RjtxCA0vcj/KoR8dmjlt4emIFzOqMORkuGJUTGcQmaWf8+c
 HZ6d4iaOo2hFz9ZPfQpinRhQQyUmdFiwJ5o0uYFVstBa1XDag5AEYOLW3CO8IyFsda
 L1Edjtm1M7llBq4UH2IR/NfC4hovEx9WCBdh30Tp1+vJX/5OQyijDwchBTeSjx0zl8
 48WZAp7hFEq76w0BHrpPkh2lu56WRnUEqwkjQL5FghD9eaUmCGonnYCrOOBx4+4QgT
 3hITyNH0yiS9g==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 0/6] Hppa fixes for v11 patches
Date: Thu, 19 Mar 2026 22:12:33 +0100
Message-ID: <20260319211239.7902-1-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
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

The following changes since commit 559919ce54927d59b215a4665eda7ab6118a48aa:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2026-03-16 13:07:33 +0000)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/hppa-fixes-for-v11-pull-request

for you to fetch changes up to fa2d5d84e023d79d1ad35b952c0f9a3aa8f442e9:

  target/hppa: Update SeaBIOS-hppa to version 23 (2026-03-19 22:06:49 +0100)

----------------------------------------------------------------
HPPA fixes for v11

Some late fixes for QEMU-v11

Various fixes in SeaBIOS-hppa and qemu code, most importantly
this fixes boot of the C3700, which broke while we added
support for CPUs with 40 and 44 bits physical address space.

----------------------------------------------------------------

Helge Deller (6):
  hw/hppa: Fix description of the HP A400-44 server
  hw/hppa: Adjust physical addresses of Astro and Elroy
  target/hppa: Always map 64-bit firmware at 0xfffffff0f0000000
  hw/pci-host/astro: Use proper region names
  hw/hppa: Fix crash of 64-bit HP-UX 11 while flushing caches
  target/hppa: Update SeaBIOS-hppa to version 23

 hw/hppa/hppa_hardware.h     |   4 ++--
 hw/hppa/machine.c           |  22 +++++++++++++++++++++-
 hw/pci-host/astro.c         |   6 ++++--
 pc-bios/hppa-firmware.img   | Bin 632048 -> 631968 bytes
 pc-bios/hppa-firmware64.img | Bin 713608 -> 714440 bytes
 roms/seabios-hppa           |   2 +-
 target/hppa/mem_helper.c    |  10 ++++++----
 7 files changed, 34 insertions(+), 10 deletions(-)

-- 
2.53.0



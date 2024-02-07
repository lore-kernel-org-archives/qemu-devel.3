Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28A8C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 18:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXmXH-0004iJ-Ow; Wed, 07 Feb 2024 13:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rXmXF-0004fp-0e
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 13:20:37 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rXmXD-00084w-9i
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 13:20:36 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id EBABF61A14;
 Wed,  7 Feb 2024 18:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF80C433C7;
 Wed,  7 Feb 2024 18:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707330026;
 bh=fyx4t/wd+HoBgs+powsZLo9dv0JfIOTv2vwESQtk0ZA=;
 h=From:To:Cc:Subject:Date:From;
 b=sI6ql0aJemkxW3cnykTz/+RwZ2dQSB9pRrEc0v/AP6NeV81IlkJk5k8BiYSLsw/gG
 l3qBekj4JmFA3RxCYBRCplKSNSB8bqZHvyNGlSDch64BMAGpVgpLcViOxQUolDeVBM
 C3152jq+JD/2S9pQ+//+vLmwwGW76uyJE7o4vBPP1a4sQACYmP3eto7oaNxqNKIqJ/
 GsZs2eEZldIQnbD5gewkuwjAq08ykla2G3pKqN8f5VLiNUK8uN7BSx30OLq/oFLswx
 3GfP8NQ7OzhOsrSv36l+1emq/PtRTGya1HCJxQd3z7aPfT6A6GxZLPQwX0VpANhuH+
 kVpMA/+SyOobA==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 00/13] target/hppa: Enhancements and fixes
Date: Wed,  7 Feb 2024 19:20:10 +0100
Message-ID: <20240207182023.36316-1-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Some enhancements and fixes for the hppa target.

The major change is, that this patchset adds a new SeaBIOS-hppa firmware
which is built as 32- and 64-bit firmware.
The new 64-bit firmware is necessary to fully support 64-bit operating systems
(HP-UX, Linux, NetBSD,...).

Please review!

Helge

Helge Deller (13):
  disas/hppa: Add disassembly for qemu specific instructions
  target/hppa: Add "diag 0x101" for console output support
  target/hppa: Fix PSW_W and PSW_E bits in rsm, ssm and mtsm
  hw/pci-host/astro: Avoid aborting on access failure
  hw/pci-host/astro: Implement Hard Fail and Soft Fail mode
  lasi: allow access to LAN MAC address registers
  target/hppa: Implement do_transaction_failed handler for I/O errors
  lasi: Add reset I/O ports for LASI audio and FDC
  target/hppa: Allow read-access to PSW with rsm 0,reg instruction
  target/hppa: Check privilege only when PSW.P is set
  target/hppa: PDC_BTLB_INFO uses 32-bit ints
  target/hppa: Update SeaBIOS-hppa to version 16
  hw/hppa/machine: Load 64-bit firmware on 64-bit machines

 disas/hppa.c                |   4 +++
 hw/hppa/machine.c           |  11 ++++++--
 hw/misc/lasi.c              |  13 +++++++++
 hw/pci-host/astro.c         |  41 +++++++++++++++------------
 include/hw/misc/lasi.h      |   2 ++
 include/hw/pci-host/astro.h |   2 ++
 pc-bios/hppa-firmware.img   | Bin 163324 -> 167836 bytes
 pc-bios/hppa-firmware64.img | Bin 0 -> 205944 bytes
 roms/seabios-hppa           |   2 +-
 target/hppa/cpu.c           |   1 +
 target/hppa/cpu.h           |   7 +++++
 target/hppa/helper.h        |   5 +++-
 target/hppa/mem_helper.c    |  21 +++++++++++++-
 target/hppa/op_helper.c     |  32 +++++++++++++++++++++
 target/hppa/sys_helper.c    |  46 ++++++++++++++++++++++++++++--
 target/hppa/translate.c     |  54 ++++++++++++++++++++++++++----------
 16 files changed, 200 insertions(+), 41 deletions(-)
 mode change 100644 => 100755 pc-bios/hppa-firmware.img
 create mode 100755 pc-bios/hppa-firmware64.img

-- 
2.43.0



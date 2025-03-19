Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E448AC35FF1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 06:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tumgp-0006rA-PU; Wed, 19 Mar 2025 02:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tumgh-0006Z5-3c; Wed, 19 Mar 2025 02:13:59 -0400
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tumge-0001R5-CO; Wed, 19 Mar 2025 02:13:57 -0400
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tumgZ-000ACk-0U; Wed, 19 Mar 2025 07:13:51 +0100
Received: from [82.100.198.138] (helo=mail.embedded-brains.de)
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tumgZ-000Hof-00; Wed, 19 Mar 2025 07:13:51 +0100
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 905C5480106;
 Wed, 19 Mar 2025 07:13:50 +0100 (CET)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id nUe4hvZkMEO5; Wed, 19 Mar 2025 07:13:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 2764D4800A8;
 Wed, 19 Mar 2025 07:13:50 +0100 (CET)
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id fmC0TZUdYPyu; Wed, 19 Mar 2025 07:13:50 +0100 (CET)
Received: from zimbra.eb.localhost (unknown [10.10.171.10])
 by mail.embedded-brains.de (Postfix) with ESMTPSA id DD0DB4800A3;
 Wed, 19 Mar 2025 07:13:48 +0100 (CET)
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, "Alistair Francis" <alistair23@gmail.com>,
 "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>
Subject: [PATCH v3 0/6] Improve Microchip Polarfire SoC customization
Date: Wed, 19 Mar 2025 07:13:32 +0100
Message-ID: <20250319061342.26435-1-sebastian.huber@embedded-brains.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: smtp-embedded@poldi-networks.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27581/Tue Mar 18 14:04:32 2025)
Received-SPF: pass client-ip=85.10.215.148;
 envelope-from=sebastian.huber@embedded-brains.de; helo=dedi548.your-server.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Booting the microchip-icicle-kit machine using the latest PolarFire SoC
Hart Software Services (HSS) no longer works since Qemu lacks support
for several registers (clocks, DRAM controller). Also reading from the
SDCard does not work currently.

In order to allow tests runs for real-time kernels such as RTEMS and
Zephyr, improve the boot customization. This patch set enables a direct
run of kernel executables, for example:

qemu-system-riscv64 -no-reboot -nographic \
  -serial null -serial mon:stdio \
  -smp 2 \
  -bios none \
  -machine microchip-icicle-kit,clint-timebase-frequency=3D10000000 \
  -kernel rtos.elf

v2:

* Add documentation update.

* In patch 3, warn if no device tree is specified.

* In patch 4, use riscv_find_firmware() to locate the firmware shipped wi=
th Qemu.

v3:

* In patch 4, add support for Qemu test runs.

Sebastian Huber (6):
  hw/misc: Add MPFS system reset support
  hw/riscv: More flexible FDT placement for MPFS
  hw/riscv: Make FDT optional for MPFS
  hw/riscv: Allow direct start of kernel for MPFS
  hw/riscv: Configurable MPFS CLINT timebase freq
  hw/riscv: microchip_pfsoc: Rework documentation

 docs/system/riscv/microchip-icicle-kit.rst | 124 ++++++-----------
 hw/misc/mchp_pfsoc_sysreg.c                |   7 +
 hw/riscv/microchip_pfsoc.c                 | 153 +++++++++++++++------
 include/hw/riscv/microchip_pfsoc.h         |   1 +
 4 files changed, 164 insertions(+), 121 deletions(-)

--=20
2.43.0



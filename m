Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA55C021A4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 00:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmjEM-000379-S4; Mon, 24 Feb 2025 19:55:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tmjDz-0002ui-4T; Mon, 24 Feb 2025 19:55:03 -0500
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tmjDx-0004df-8K; Mon, 24 Feb 2025 19:55:02 -0500
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tmjDs-000HNN-29; Tue, 25 Feb 2025 01:54:56 +0100
Received: from [82.100.198.138] (helo=mail.embedded-brains.de)
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tmjDs-0008o7-2m; Tue, 25 Feb 2025 01:54:56 +0100
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id E84B148016C;
 Tue, 25 Feb 2025 01:54:55 +0100 (CET)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id aRqG5FlIDKUR; Tue, 25 Feb 2025 01:54:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 8681848005D;
 Tue, 25 Feb 2025 01:54:55 +0100 (CET)
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id XGpUwBT1ZC36; Tue, 25 Feb 2025 01:54:55 +0100 (CET)
Received: from zimbra.eb.localhost (unknown [10.10.171.10])
 by mail.embedded-brains.de (Postfix) with ESMTPSA id C418B48005B;
 Tue, 25 Feb 2025 01:54:53 +0100 (CET)
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair23@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Bin Meng <bin.meng@windriver.com>
Subject: [PATCH v2 0/6] Improve Microchip Polarfire SoC customization
Date: Tue, 25 Feb 2025 01:54:40 +0100
Message-ID: <20250225005446.13894-1-sebastian.huber@embedded-brains.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: smtp-embedded@poldi-networks.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27559/Mon Feb 24 10:44:14 2025)
Received-SPF: pass client-ip=85.10.215.148;
 envelope-from=sebastian.huber@embedded-brains.de; helo=dedi548.your-server.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Sebastian Huber (6):
  hw/misc: Add MPFS system reset support
  hw/riscv: More flexible FDT placement for MPFS
  hw/riscv: Make FDT optional for MPFS
  hw/riscv: Allow direct start of kernel for MPFS
  hw/riscv: Configurable MPFS CLINT timebase freq
  hw/riscv: microchip_pfsoc: Rework documentation

 docs/system/riscv/microchip-icicle-kit.rst | 124 ++++++-----------
 hw/misc/mchp_pfsoc_sysreg.c                |   7 +
 hw/riscv/microchip_pfsoc.c                 | 151 +++++++++++++++------
 include/hw/riscv/microchip_pfsoc.h         |   1 +
 4 files changed, 162 insertions(+), 121 deletions(-)

--=20
2.43.0



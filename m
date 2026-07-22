Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420EBC4452D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 01:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmLYo-0002PS-6O; Tue, 21 Jul 2026 21:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathan@kernel.org>) id 1wmLYm-0002O4-LE
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 21:15:44 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathan@kernel.org>) id 1wmLYk-000652-H8
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 21:15:44 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 355FE60A68;
 Wed, 22 Jul 2026 01:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391F31F00A3A;
 Wed, 22 Jul 2026 01:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784682933;
 bh=QQ4m1uZf6X98kSz9Ga4Ssl3oAe1nO+o5BsMM9lVmR40=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=P5oqx8q8ArNjy2YcjaW1KpHApkfRnTZs1lchDXtlNV4As1J5lufgZOonWjCXGXhqp
 7my/nlINndVUpVwOMcN5ONAJ1xD9kLDZiuXCBgXALql2Z+Jv7p0tv9kJYT4NweRMby
 N061Y+PDxP/G1SyM8QFNp6IQZkuGdKK/YRx5VjUT+lfsCHPG5OhtO6G9usaIYpVYlM
 eDlRJhOF5sHgA+NKRzhnfYHvD6DQ2+l7Umv8Bch0Jx/lnDuEd5EQVzwTUFaV9RwSRE
 vZbikm3iWiK3Y+I64OoH10HBJWeebUYRY+ffzxVFl+b23Vk806EEpaxf31BheiC7mh
 ynRw7BZxKSqIg==
Date: Tue, 21 Jul 2026 18:15:30 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/1] qemu-openbios queue 20260707
Message-ID: <20260722011530.GA2116566@ax162>
References: <20260707213237.494636-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707213237.494636-1-mark.cave-ayland@ilande.co.uk>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=nathan@kernel.org; helo=tor.source.kernel.org
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

Hi Mark,

On Tue, Jul 07, 2026 at 10:32:05PM +0100, Mark Cave-Ayland wrote:
> The following changes since commit 916ab315cc2b3a3825ebb399d83339660144d5bd:
> 
>   Merge tag 'pull-nvme-20260707' of https://gitlab.com/birkelund/qemu into staging (2026-07-07 07:09:38 +0200)
> 
> are available in the Git repository at:
> 
>   https://github.com/mcayland/qemu.git tags/qemu-openbios-20260707
> 
> for you to fetch changes up to 9e3508dce0045de26ec8cab064443c92fdd15288:
> 
>   Update OpenBIOS images to e5ac46dd built from submodule. (2026-07-07 22:07:16 +0100)
> 
> ----------------------------------------------------------------
> qemu-openbios queue
> 
> ----------------------------------------------------------------
> Mark Cave-Ayland (1):
>       Update OpenBIOS images to e5ac46dd built from submodule.
> 
>  pc-bios/openbios-ppc     | Bin 677200 -> 673104 bytes
>  pc-bios/openbios-sparc32 | Bin 382080 -> 382048 bytes
>  pc-bios/openbios-sparc64 | Bin 1593408 -> 1593408 bytes
>  roms/openbios            |   2 +-
>  4 files changed, 1 insertion(+), 1 deletion(-)

I bisected a hang that I see when trying to boot a Linux kernel built
from pmac32_defconfig to this change.

  $ git show 9e3508dce0045de26ec8cab064443c92fdd15288:pc-bios/openbios-ppc >openbios-ppc-bad

  $ git show 9e3508dce0045de26ec8cab064443c92fdd15288^:pc-bios/openbios-ppc >openbios-ppc-good

  $ curl -LSs https://github.com/nathanchance/bug-files/raw/main/qemu-9e3508dce0045de26ec8cab064443c92fdd15288/rootfs.cpio.zst | zstd -d >rootfs.cpio

  $ curl -LSs https://github.com/nathanchance/bug-files/raw/main/qemu-9e3508dce0045de26ec8cab064443c92fdd15288/vmlinux.zst | zstd -d >vmlinux

  $ qemu-system-ppc \
      -display none \
      -nodefaults \
      -no-reboot \
      -machine mac99 \
      -append console=ttyS0 \
      -kernel ./vmlinux \
      -initrd ./rootfs.cpio \
      -m 128m \
      -serial mon:stdio \
      -bios ./openbios-ppc-good

  >> =============================================================
  >> OpenBIOS 1.1 [Sep 24 2024 19:56]
  >> Configuration device id QEMU version 1 machine id 1
  >> CPUs: 1
  >> Memory: 128M
  >> UUID: 00000000-0000-0000-0000-000000000000
  >> CPU type PowerPC,G4
  milliseconds isn't unique.
  Output device screen not found.
  Output device screen not found.
  >> [ppc] Kernel already loaded (0x01000000 + 0x00ed2410) (initrd 0x01fd3000 + 0x004fb000)
  >> [ppc] Kernel command line: console=ttyS0
  >> switching to new context:
  NULL ihandle
  Unexpected client interface exception: -2
  printk: legacy console [ttyS0] enabled
  printk: legacy bootconsole [udbg0] disabled
  pid_max: default: 32768 minimum: 301
  Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
  Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
  VFS: Finished mounting rootfs on nullfs
  Memory: 108176K/131072K available (10508K kernel code, 1004K rwdata, 2180K rodata, 1232K init, 178K bss, 21680K reserved, 0K cma-reserved, 0K highmem)
  Found UniNorth PCI host bridge at 0x00000000f2000000. Firmware bus number: 0->0
  ...
  Starting network: OK
  Linux version 7.2.0-rc4+ (nathan@ax162) (powerpc-linux-gcc (GCC) 16.1.0, GNU ld (GNU Binutils) 2.46) #1 PREEMPT Tue Jul 21 16:59:50 MST 2026
  Stopping network:OK
  Stopping klogd: OK
  Stopping syslogd: OK
  Seeding 256 bits without crediting
  seedrng: can't open '/dev/urandom': No such file or directory
  The system is going down NOW!
  Sent SIGTERM to all processes
  Sent SIGKILL to all processes
  Requesting system reboot
  reboot: Restarting system

  $ qemu-system-ppc \
      -display none \
      -nodefaults \
      -no-reboot \
      -machine mac99 \
      -append console=ttyS0 \
      -kernel ./vmlinux \
      -initrd ./rootfs.cpio \
      -m 128m \
      -serial mon:stdio \
      -bios ./openbios-ppc-bad

  >> =============================================================
  >> OpenBIOS 1.1 [Jun 29 2026 21:11]
  >> Configuration device id QEMU version 1 machine id 1
  >> CPUs: 1
  >> Memory: 128M
  >> UUID: 00000000-0000-0000-0000-000000000000
  >> CPU type PowerPC,G4
  milliseconds isn't unique.
  Output device screen not found.
  Output device screen not found.
  >> [ppc] Kernel already loaded (0x01000000 + 0x00ed2410) (initrd 0x01fd3000 + 0x004fb000)
  >> [ppc] Kernel command line: console=ttyS0
  >> switching to new context:
  <hangs with no additional output>

Presumably this is due to OpenBIOS commit b0267d5 ("ppc: bump SAVE_SPACE
to include enough space to store all registers"), as this appears to be
the only actual source change to OpenBIOS? I have not had time to try
running under gdb to get more information about where it is hanging but
I wanted to get this report out sooner rather than later.

-- 
Cheers,
Nathan


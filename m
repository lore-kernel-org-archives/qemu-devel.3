Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8734C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 18:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP3dq-0002iM-Tz; Tue, 10 Jun 2025 14:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kevin@koconnor.net>)
 id 1uP3do-0002bO-O1
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 14:24:08 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kevin@koconnor.net>)
 id 1uP3dk-00052W-Ut
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 14:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koconnor.net;
 s=protonmail; t=1749579828; x=1749839028;
 bh=MIhDCCsGPQhHfy1H0NBZiedSXTDgON1KlRqjZXpl3KU=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=QWQ/x7cUvNbODjBvBSN5CGTDxWyf93rDf6tJ40MThwL/Agb5Rdz3dm1A+tAqDBKw8
 kXPrwN+kn346qSiz/rLlGEq2e1SmG7/Lc3CEHVycNISebvgKnN497JPuUR8GSgksoQ
 jqJpNL9jG5DgQ+cvdCyLZhvNRosMiWl11JUWyKTzFfv566WHouu3OrEYVOINw2rnjX
 MTIknYmdX+VfYnrc+Jz3BhGyGvkpJb1Xo2g8nP35FjNBPDqCzzMzxhmJ4DMQqJ5GKL
 P6kpx1vLN0xQ1xIQKoR07dUjSWepol+HqkXENhmFN5B2C2xW0uMqrFmp79u5SJt5ea
 Dh47vrqkZu8FQ==
Date: Tue, 10 Jun 2025 18:23:42 +0000
To: seabios@seabios.org, qemu-devel@nongnu.org, coreboot@coreboot.org
Subject: [ANNOUNCE] SeaBIOS 1.17.0
Message-ID: <aEh4KNk1W_ZAL_Tc@morn>
Feedback-ID: 132158305:user:proton
X-Pm-Message-ID: 3f606ade7b7f137df0242bea71c3035e54f95109
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=51.77.79.158; envelope-from=kevin@koconnor.net;
 helo=mail-0201.mail-europe.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Kevin O'Connor <kevin@koconnor.net>
From:  Kevin O'Connor via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The 1.17.0 version of SeaBIOS has now been released.  For more
information on the release, please see:

https://seabios.org/Releases


New in this release:

* Prefer PCI IO allocations above 4Gig on 64bit capable machines.
* Multiple simultaneous USB keyboard and mouse support.
* Legacy support for internally generated ACPI tables has been removed.
* SeaVGABIOS support for VBE get/set palette data.
* Several bug fixes and code cleanups.


For information on obtaining SeaBIOS, please see:

https://seabios.org/Download


=3D=3D=3D=3D=3D git shortlog -n rel-1.16.0..rel-1.17.0 =3D=3D=3D=3D=3D

Gerd Hoffmann (17):
      malloc: use variable for ZoneHigh size
      malloc: use large ZoneHigh when there is enough memory
      virtio-blk: use larger default request size
      disable array bounds warning
      better kvm detection
      detect physical address space size
      move 64bit pci window to end of address space
      be less conservative with the 64bit pci io window
      qemu: log reservations in fw_cfg e820 table
      check for e820 conflict
      limit address space used for pci devices.
      limit address space used for pci devices, part two
      drop obsolete acpi table code
      drop acpi tables and hex includes
      add romfile_loadbool()
      update pci_pad_mem64 handling
      ahci: add controller reset

Kevin O'Connor (14):
      vgasrc: Use curmode_g instead of vmode_g when mode is the current vid=
eo mode
      vgasrc: Rename vgahw_get_linesize() to vgahw_minimum_linelength()
      stdvgamodes: No need to store pelmask in vga_modes[]
      stdvgamodes: Improve naming of dac palette tables
      stdvga: Rename CGA palette functions
      stdvga: Add comments to interface functions in stdvga.c
      stdvga: Rename stdvga_toggle_intensity() to stdvga_set_palette_blinki=
ng()
      stdvga: Rework stdvga palette index paging interface functions
      stdvga: Rename stdvga_set_text_block_specifier() to stdvga_set_font_l=
ocation()
      stdvga: Rename stdvga_set_scan_lines() to stdvga_set_character_height=
()
      stdvga: Rename stdvga_get_vde() to stdvga_get_vertical_size()
      stdvga: Add stdvga_set_vertical_size() helper function
      stdvgaio: Only read/write one color palette entry at a time
      docs: Note v1.17.0 release

Mark Cave-Ayland (5):
      esp-scsi: flush FIFO before sending SCSI command
      esp-scsi: check for INTR_BS/INTR_FC instead of STAT_TC for command co=
mpletion
      esp-scsi: handle non-DMA SCSI commands with no data phase
      esp-scsi: terminate DMA transfer when ESP data transfer completes
      esp-scsi: indicate acceptance of MESSAGE IN phase data

Daniel Verkamp (3):
      vbe: Add VBE 2.0+ OemData field to struct vbe_info
      vgasrc: round up save/restore size
      vbe: implement function 09h (get/set palette data)

Daniel Khodabakhsh (2):
      boot: Force display of the boot menu when boot-menu-wait is a negativ=
e number
      usb-hid: Support multiple USB HID devices by storing them in a linked=
 list

Igor Mammedov (2):
      acpi: parse Alias object
      fix smbios blob length overflow

Volker R=C3=BCmelin (2):
      pci: refactor the pci_config_*() functions
      reset: force standard PCI configuration access

Xuan Zhuo (2):
      virtio-mmio: read/write the hi 32 features for mmio
      virtio: finalize features before using device

Andrej Krut=C3=A1k (1):
      Add AHCI Power ON + ICC_ACTIVE into port setup code

Daniil Tatianin (1):
      pciinit: don't misalign large BARs

David Woodhouse (1):
      xen: require Xen info structure at 0x1000 to detect Xen

Jiaxun Yang (1):
      ahci: Fix hangs due to controller reset

Jos=C3=A9 Mart=C3=ADnez (1):
      Fix high memory zone initialization in CSM mode

Lukas Stockner via SeaBIOS (1):
      virtio-blk: Fix integer overflow for large max IO sizes

Max Tottenham (1):
      Add LBA 64bit support for reads beyond 2TB.

Niklas Cassel via SeaBIOS (1):
      ahci: handle TFES irq correctly

Qi Zhou (1):
      usb: fix wrong init of keyboard/mouse's if first interface is not boo=
t protocol

Steven Price (1):
      vgabios: Fix generating modes list for static_functionality

Tony Titus via SeaBIOS (1):
      Increase BUILD_MAX_E820 to 128

Xiaofei Lee (1):
      virtio-blk: Fix incorrect type conversion in virtio_blk_op()

nikolar via SeaBIOS (1):
      kconfig: fix the check-lxdialog.sh to work with gcc 14+




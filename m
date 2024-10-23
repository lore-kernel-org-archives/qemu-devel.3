Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70639D2E027
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 08:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XCx-0007nQ-Qx; Wed, 23 Oct 2024 04:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XCw-0007nA-1r
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:59:10 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XCu-0000IK-FK
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=aokxL5PwRVZCJXDVYGsoz4TD8w7d929boL0XDYqevfE=; b=MBHScnP29Jn83N/J96cD0hIMhU
 jwP6RQjN9BdrvPCrHcqYDmtUU+QUcR6ChrmTx4rsUI4zAWb3Foz+qRdFEH6mtRpzizm7t+kmBuKuv
 3mnC+KZ2IYYzMPKzerdSdq8+xFo8Pdxd139c6RPQnfjTZDpWZMK0XpU482h46jGPOrsPlSkVX3W5v
 Qf8a1D2fKTGoB73PYP9thEutCU3rR/xFY+b7olqOPL+g6ZjmG9dTGxLfFM1vCUbIvjToB9RXO43mm
 Vsiy/q4YPekFuOhrlVsrCGrTpkbhJlF4nYZR9QDdOrB2dVDc6PE9RBSBywuahHU59rpHDrDn02FzU
 s2+E6XnDPTtpHAjlLrBKS7Q0ncxMobwfFtIfCA6gYLTlHGKkzHzhoRnu3FV9IGVgQj8TKOIxVZTxn
 BWy2pj/B+oaDgHos6VpmMFcfh7ejMBSKRJSwTZXPvGupBptxCeDNpQGwoczjgDIZmykKIbu1KbnTM
 YCDrjf/XWDQHy6dYU8XMQppkkIXTGPEcZVc5qKXJYSaevT8P4MBz+eURUCOINHAVh0B5b31mX2wzv
 e1EH6f4xSGNDvciFjV/dAhPYd4rbDAb7Tw/t5XNYmygENB+jUw8TtTiPvTscChew/Nne/w0me2yFI
 OHaLCpEYbxhR/oFfHDxLZP97I76JZ90sywYhiIZU4=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XCX-0008EL-FO; Wed, 23 Oct 2024 09:58:49 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 23 Oct 2024 09:58:16 +0100
Message-Id: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 00/36] next-cube: more tidy-ups and improvements
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series contains a number of tidy-ups and improvements to the NeXTCube machine
which include:

  - Bringing the code up-to-date with our latest coding standards/APIs, in particular
    related to the board configuration and IRQ wiring

  - Remove the remaining overlapping memory regions and consolidating multiple
    register implementations into a single place

  - Add a new next-scsi device containing the ESP device and its associated
    CSRs

  - Adding the empty_slot device to fill unimplemented devices and removing
    the "catch-all" next.scr memory region

  - QOMifying the next-rtc device and wiring it up with gpios as required

The next-cube machine looks in fairly good shape now, the main remaining work is to
create a separate device for the DMA controller and update the wiring of the IRQs
(including to the CPU) accordingly.

There is no change to the behaviour of the next-cube machine with this series in
that the next-cube machine with a suitable ROM image can now load the kernel from
a pre-installed NeXTStep image and start executing it.

Note that due to the device model changes this is a migration break, however since
the next-cube machine is currently unable to boot anything useful, I don't see
this as an issue.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (36):
  next-cube: fix up compilation when DEBUG_NEXT is enabled
  next-cube: remove 0x14020 dummy value from next_mmio_read()
  next-cube: remove overlap between next.dma and next.mmio memory
    regions
  next-cube: remove cpu parameter from next_scsi_init()
  next-cube: create new next.scsi container memory region
  next-cube: move next_scsi_init() to next_pc_realize()
  next-cube: introduce next_pc_init() object init function
  next-cube: introduce next-scsi device
  next-cube: move SCSI CSRs from next-pc to the next-scsi device
  next-cube: move SCSI 4020 logic from next-pc device to next-scsi
    device
  next-cube: move floppy disk MMIO to separate memory region in next-pc
  next-cube: map ESCC registers as a subregion of the next.scr memory
    region
  next-cube: move ESCC to be QOM child of next-pc device
  next-cube: move timer MMIO to separate memory region on next-pc device
  next-cube: move en ethernet MMIO to separate memory region on next-pc
    device
  next-cube: add empty slots for unknown accesses to next.scr memory
    region
  next-cube: remove unused next.scr memory region
  next-cube: rearrange NeXTState declarations to improve readability
  next-cube: convert next-pc device to use Resettable interface
  next-cube: rename typedef struct NextRtc to NeXTRTC
  next-cube: use qemu_irq to drive int_status in next_scr2_rtc_update()
  next-cube: separate rtc read and write shift logic
  next-cube: always use retval to return rtc read values
  next-cube: use named gpio to set RTC data bit in scr2
  next-cube: use named gpio to read RTC data bit in scr2
  next-cube: don't use rtc phase value of -1
  next-cube: QOMify NeXTRTC
  next-cube: move reset of next-rtc fields from next-pc to next-rtc
  next-cube: move rtc-data-in gpio from next-pc to next-rtc device
  next-cube: use named gpio output for next-rtc data
  next-cube: add rtc-cmd-reset named gpio to reset the rtc state machine
  next-cube: add rtc-power-out named gpio to reset the rtc state machine
  next-cube: move next_rtc_cmd_is_write() and next_rtc_data_in_irq()
    functions
  next-cube: rename old_scr2 and scr2_2 in next_scr2_rtc_update()
  next-cube: add my copyright to the top of the file
  next-cube: replace boiler-plate GPL 2.0 or later license text with
    SPDX identifier

 hw/m68k/Kconfig     |    1 +
 hw/m68k/next-cube.c | 1025 +++++++++++++++++++++++++++----------------
 2 files changed, 655 insertions(+), 371 deletions(-)

-- 
2.39.5


